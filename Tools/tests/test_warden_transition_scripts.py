# SPDX-License-Identifier: GPL-3.0-or-later
#
# MaNGOS is a full featured server for World of Warcraft, supporting
# the following clients: 1.12.x, 2.4.3, 3.3.5a, 4.3.4a and 5.4.8
#
# Copyright (C) 2005-2026 MaNGOS <https://www.getmangos.eu>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# World of Warcraft, and all World of Warcraft or Warcraft art, images,
# and lore are copyrighted by Blizzard Entertainment, Inc.

from pathlib import Path
import re
import shutil
import subprocess
import unittest


ROOT = Path(__file__).resolve().parents[2]
INSTALL = (ROOT / "InstallDatabases.sh").read_text(encoding="utf-8")
BACKUP = (ROOT / "Tools" / "backupDB.cmd").read_text(encoding="utf-8")
DUMP = (ROOT / "Tools" / "dump_tables.sh").read_text(encoding="utf-8")


def shell_function(name: str) -> str:
    match = re.search(
        rf"(?ms)^{re.escape(name)}\(\)\s*\{{\s*(.*?)^\}}\s*$",
        INSTALL,
    )
    if not match:
        raise AssertionError(f"missing shell function {name}")
    return match.group(1)


def batch_label(name: str, next_label: str) -> str:
    match = re.search(
        rf"(?ms)^:{re.escape(name)}\s*$\s*(.*?)^:{re.escape(next_label)}\s*$",
        BACKUP,
    )
    if not match:
        raise AssertionError(f"missing batch label {name}")
    return match.group(1)


def bash_executable() -> str:
    bash = shutil.which("bash")
    if bash:
        return bash
    git = shutil.which("git")
    if git:
        candidate = Path(git).resolve().parents[1] / "bin" / "bash.exe"
        if candidate.is_file():
            return str(candidate)
    raise AssertionError("bash is required to validate dump_tables.sh")


class CharacterUpdateRoutingTests(unittest.TestCase):
    def test_character_updates_are_dispatched_from_the_top_level(self) -> None:
        execution = INSTALL[INSTALL.index('if [ "${createcharDB}" = "YES" ]') :]
        self.assertRegex(
            execution,
            re.escape('if [ "${updatecharDB}" = "YES" ]; then')
            + r"(?s:\s*updateCharDB\s*fi)",
        )

    def test_loading_character_structure_does_not_dispatch_updates(self) -> None:
        self.assertNotIn("updateCharDB", shell_function("loadCharDB"))


class WardenBackupRoutingTests(unittest.TestCase):
    EXPECTED_OPTIONAL_TABLES = {
        ("%wdb%", "_full_worlddb", "%loadworldDB%", "warden"),
        ("%wdb%", "_full_worlddb", "%loadworldDB%", "warden_checks"),
        ("%cdb%", "_full_chardb", "%loadcharDB%", "warden_action"),
        ("%rdb%", "_full_realmdb", "%loadrealmDB%", "warden_log"),
        ("%rdb%", "_full_realmdb", "%loadrealmDB%", "warden_incident"),
        ("%rdb%", "_full_realmdb", "%loadrealmDB%", "warden_audit"),
    }

    def optional_calls(self) -> set[tuple[str, str, str, str]]:
        return set(
            re.findall(
                r'(?im)^call :DumpOptionalTable "([^"]+)" "([^"]+)" '
                r'"([^"]+)" "([^"]+)"\s*$',
                BACKUP,
            )
        )

    def test_legacy_and_replacement_tables_are_both_optional(self) -> None:
        self.assertEqual(self.optional_calls(), self.EXPECTED_OPTIONAL_TABLES)
        self.assertNotRegex(
            BACKUP,
            r"(?im)^SET TABLENAME=(warden|warden_checks|warden_action|"
            r"warden_log|warden_incident|warden_audit)\s*$",
        )

    def test_optional_table_probe_distinguishes_absence_from_failure(self) -> None:
        helper = batch_label("DumpOptionalTable", "patherror")
        self.assertIn("information_schema.tables", helper)
        self.assertIn('if not "%OPTIONALFOUND%" == "0" if not ', helper)
        self.assertIn("exit /b 1", helper)
        self.assertEqual(
            len(re.findall(r"(?im)^if errorlevel 1 goto error\s*$", BACKUP)),
            len(self.EXPECTED_OPTIONAL_TABLES),
        )

    def test_script_returns_failure_to_automation(self) -> None:
        self.assertIn('set "BACKUPRESULT=0"', BACKUP)
        self.assertEqual(BACKUP.count('set "BACKUPRESULT=1"'), 2)
        self.assertRegex(
            BACKUP,
            r"(?ms)^:finish\s*$\s*pause\s*exit /b %BACKUPRESULT%\s*$",
        )

    def test_absence_removes_only_the_exact_stale_output_after_probe(self) -> None:
        helper = batch_label("DumpOptionalTable", "patherror")
        validated = helper.index(
            'if not "%OPTIONALFOUND%" == "0" if not '
        )
        absent = helper.index('if "%OPTIONALFOUND%" == "0" (')
        deletion = helper.index(
            'if exist "%OPTIONALOUTPUT%" del /Q "%OPTIONALOUTPUT%"'
        )
        self.assertLess(validated, absent)
        self.assertLess(absent, deletion)
        self.assertEqual(
            helper.count(
                'if exist "%OPTIONALOUTPUT%" del /Q "%OPTIONALOUTPUT%"'
            ),
            1,
        )
        absent_branch = helper[absent : helper.index('set "OPTIONALPARAMS="')]
        self.assertRegex(
            absent_branch,
            r'(?s)del /Q "%OPTIONALOUTPUT%"\s*'
            r'if exist "%OPTIONALOUTPUT%" \(.*?exit /b 1',
        )
        self.assertNotRegex(helper, r'del /Q "[^"\r\n]*\*[^"\r\n]*"')

    def test_present_table_output_is_published_only_after_complete_dump(self) -> None:
        helper = batch_label("DumpOptionalTable", "patherror")
        dump = helper.index('> "%OPTIONALTEMP%"')
        ready = helper.index('move /Y "%OPTIONALTEMP%" "%OPTIONALREADY%"')
        publish = helper.index(
            'move /Y "%OPTIONALREADY%" "%OPTIONALOUTPUT%" >nul'
        )
        self.assertLess(dump, ready)
        self.assertLess(ready, publish)
        self.assertNotIn('>> "%OPTIONALOUTPUT%"', helper)

    def test_data_only_assembly_failure_preserves_previous_output(self) -> None:
        helper = batch_label("DumpOptionalTable", "patherror")
        assembly = helper[
            helper.index('if /I "%OPTIONALSTRUCTURE%" == "NO" (') :
            helper.index('move /Y "%OPTIONALREADY%" "%OPTIONALOUTPUT%"')
        ]
        writes = [
            '%ComSpec% /D /C echo -- ---------------------------------------- ^> "%OPTIONALREADY%"',
            '%ComSpec% /D /C echo -- --        CLEAR DOWN THE TABLE        -- ^>^> "%OPTIONALREADY%"',
            '%ComSpec% /D /C echo -- ---------------------------------------- ^>^> "%OPTIONALREADY%"',
            '%ComSpec% /D /C echo TRUNCATE TABLE `%OPTIONALTABLE%`; ^>^> "%OPTIONALREADY%"',
            '%ComSpec% /D /C type "%OPTIONALTEMP%" ^>^> "%OPTIONALREADY%"',
        ]
        for write in writes:
            self.assertRegex(
                assembly,
                re.escape(write)
                + r"\s*if errorlevel 1 goto DumpOptionalTableAssemblyFailed",
            )
        self.assertRegex(
            assembly,
            r'(?s)del /Q "%OPTIONALTEMP%"\s*'
            r'if exist "%OPTIONALTEMP%" goto DumpOptionalTableAssemblyFailed',
        )
        self.assertIn(":DumpOptionalTableAssemblyFailed", BACKUP)


class WardenUnixDumpRoutingTests(unittest.TestCase):
    def test_replaces_warden_dumps_only_after_successful_staging(self) -> None:
        candidates = re.search(r"for WARDEN_TABLE in ([^;\n]+); do", DUMP)
        self.assertIsNotNone(candidates, "Warden table probe loop is missing")
        self.assertEqual(candidates.group(1).split(), ["warden", "warden_checks"])
        self.assertRegex(
            DUMP,
            r"(?s)for WARDEN_TABLE in warden warden_checks; do.*?"
            r"WARDEN_FOUND=.*?mysql .*information_schema\.tables",
        )
        self.assertIn('case "${WARDEN_FOUND}" in', DUMP)

        self.assertIn('> "${WARDEN_READY}"', DUMP)
        stage = DUMP.index('> "${WARDEN_READY}"')
        publish = DUMP.index(
            'mv -f "${WARDEN_READY}" "${DUMPDIR}/${WARDEN_TABLE}.sql"'
        )
        stale_cleanup = DUMP.index(
            'rm -f "${DUMPDIR}/${WARDEN_TABLE}.sql"', publish
        )
        self.assertLess(stage, publish)
        self.assertLess(publish, stale_cleanup)
        self.assertIn('if ! mysqldump ', DUMP)
        self.assertIn('if ! mv -f "${WARDEN_READY}"', DUMP)
        self.assertIn("Neither warden nor warden_checks exists", DUMP)
        self.assertNotIn(
            'rm -f "${DUMPDIR}/warden.sql" "${DUMPDIR}/warden_checks.sql"',
            DUMP,
        )
        self.assertNotIn("${WARDEN_TABLES} \\", DUMP)
        self.assertRegex(
            DUMP,
            r"(?ms)^dump_warden_tables\(\)\s*\{.*?^\}\s*$",
        )
        self.assertNotRegex(DUMP, r"(?m)^`warden(?:_checks)?` \\$")

    def test_complete_unix_dump_script_parses_and_iterates_tables(self) -> None:
        result = subprocess.run(
            [bash_executable(), "-n", str(ROOT / "Tools" / "dump_tables.sh")],
            capture_output=True,
            check=False,
            text=True,
        )
        self.assertEqual(result.returncode, 0, result.stderr)

        loop = re.search(r"(?ms)^for TABLE in [\\]\r?\n.*?^; do\s*$", DUMP)
        self.assertIsNotNone(loop, "generic table loop is missing")
        iteration = subprocess.run(
            [bash_executable(), "-c", loop.group(0) + '\nprintf "%s\\n" "$TABLE"\ndone\n'],
            capture_output=True,
            check=False,
            text=True,
        )
        self.assertEqual(iteration.returncode, 0, iteration.stderr)
        self.assertGreater(len(iteration.stdout.splitlines()), 100)


if __name__ == "__main__":
    unittest.main()
