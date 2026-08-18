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
import os
import re
import shutil
import subprocess
import tempfile
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


def batch_helper_region(script: str) -> str:
    label = re.search(r"(?m)^:DumpOptionalGroup\s*$", script)
    if not label:
        raise AssertionError("missing batch label DumpOptionalGroup")
    start = label.start()
    end = script.find("\n:patherror", start)
    if end < 0:
        raise AssertionError("DumpOptionalGroup helper region is unterminated")
    return script[start:end].rstrip()


def batch_for_blocks(body: str) -> list[str]:
    lines = body.splitlines()
    blocks = []
    for index, line in enumerate(lines):
        if not re.match(r"(?i)^\s*for\b.*\(\s*$", line):
            continue
        depth = 0
        block = []
        for nested in lines[index:]:
            block.append(nested)
            depth += nested.count("(") - nested.count(")")
            if depth == 0:
                break
        blocks.append("\n".join(block))
    return blocks


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
    def test_optional_groups_are_called_in_exact_order(self) -> None:
        expected_groups = [
            ('"%wdb%"', '"_full_worlddb"', '"%loadworldDB%"', '"YES"',
             '"warden"', '"warden_checks"'),
            ('"%cdb%"', '"_full_chardb"', '"%loadcharDB%"', '"NO"',
             '"warden_action"'),
            ('"%rdb%"', '"_full_realmdb"', '"%loadrealmDB%"', '"YES"',
             '"warden_log"', '"warden_incident"', '"warden_audit"'),
        ]

        calls = [
            tuple(re.findall(r'"[^"]+"', line))
            for line in BACKUP.splitlines()
            if line.startswith("call :DumpOptionalGroup ")
        ]
        self.assertEqual(calls, expected_groups)
        self.assertNotIn("call :DumpOptionalTable ", BACKUP)
        self.assertEqual(
            len(re.findall(r"(?im)^if errorlevel 1 goto error\s*$", BACKUP)), 3
        )

    def test_optional_group_phases_publish_before_absent_cleanup(self) -> None:
        labels = [
            "DumpOptionalGroup",
            "ProbeOptionalTable",
            "StageOptionalTable",
            "CleanupOptionalGroupArtifacts",
            "DumpOptionalGroupRetainEmpty",
            "DumpOptionalGroupFailed",
        ]
        actual = re.findall(
            r"(?m)^:(DumpOptionalGroup|ProbeOptionalTable|StageOptionalTable|"
            r"CleanupOptionalGroupArtifacts|DumpOptionalGroupRetainEmpty|"
            r"DumpOptionalGroupFailed)\s*$",
            BACKUP,
        )
        self.assertEqual(actual, labels)

        group = batch_label("DumpOptionalGroup", "ProbeOptionalTable")
        preflight = group[: group.index("call :ProbeOptionalTable")]
        self.assertIn(
            "for %%S in (exists.tmp dump.tmp sql.new present.tmp absent.tmp) do (",
            preflight,
        )
        probe = group.index("call :ProbeOptionalTable")
        stage = group.index("call :StageOptionalTable")
        publish = group.index('move /Y "!OPTIONALREADY!" "!OPTIONALOUTPUT!"')
        cleanup = group.index('del /Q "!OPTIONALOUTPUT!"', publish)
        self.assertLess(probe, stage)
        self.assertLess(stage, publish)
        self.assertLess(publish, cleanup)
        self.assertNotIn('del /Q "!OPTIONALOUTPUT!"', group[:publish])
        self.assertIn(
            'if "!OPTIONALPRESENT!" == "0" if /I "!OPTIONALRETAINEMPTY!" == "YES"',
            group,
        )
        self.assertRegex(
            group,
            r"(?s)call :CleanupOptionalGroupArtifacts.*?endlocal\s+exit /b 0\s*$",
        )

    def test_probe_and_cleanup_reject_unsafe_artifacts_and_results(self) -> None:
        probe = batch_label("ProbeOptionalTable", "StageOptionalTable")
        query = probe.index("information_schema.tables")
        before_query = probe[:query]
        for suffix in (".exists.tmp", ".present.tmp", ".absent.tmp"):
            assignment = re.search(
                rf'(?m)^set "([A-Z]+)=[^"\r\n]*{re.escape(suffix)}"\s*$',
                before_query,
            )
            self.assertIsNotNone(assignment, f"missing {suffix} marker")
            marker = f"%{assignment.group(1)}%"
            marker_lines = before_query.splitlines()
            deletion_line = f'if exist "{marker}" del /Q "{marker}"'
            self.assertIn(deletion_line, marker_lines, f"{suffix} is not cleared")
            deletion = marker_lines.index(deletion_line)
            verification = next(
                (
                    index
                    for index, line in enumerate(marker_lines[deletion + 1 :], deletion + 1)
                    if line.startswith(f'if exist "{marker}"')
                ),
                -1,
            )
            self.assertGreater(
                verification, deletion, f"{suffix} removal is not verified"
            )
            verification_line = marker_lines[verification]
            if verification_line == f'if exist "{marker}" exit /b 1':
                continue
            self.assertEqual(
                verification_line,
                f'if exist "{marker}" (',
                f"{suffix} verification does not propagate failure",
            )
            verification_end = next(
                (
                    index
                    for index, line in enumerate(
                        marker_lines[verification + 1 :], verification + 1
                    )
                    if line == ")"
                ),
                -1,
            )
            self.assertGreater(verification_end, verification)
            self.assertIn(
                "exit /b 1",
                (line.strip() for line in marker_lines[verification:verification_end]),
                f"{suffix} verification does not return failure",
            )

        probe_lines = probe.splitlines()
        query_line = next(
            index
            for index, line in enumerate(probe_lines)
            if line.startswith('"%mysql%mysql.exe"')
        )
        self.assertEqual(probe_lines[query_line + 1], "if errorlevel 1 (")
        query_guard_end = next(
            index
            for index, line in enumerate(probe_lines[query_line + 2 :], query_line + 2)
            if line == ")"
        )
        self.assertIn(
            "exit /b 1",
            (line.strip() for line in probe_lines[query_line + 1 : query_guard_end]),
        )

        accepted = re.findall(
            r'(?m)^if "%OPTIONALFOUND%" == "([^"]+)" \($', probe
        )
        self.assertEqual(accepted, ["0", "1"])
        self.assertIn("exit /b 1", probe)

        cleanup = batch_label(
            "CleanupOptionalGroupArtifacts", "DumpOptionalGroupRetainEmpty"
        )
        self.assertIn(
            "for %%S in (exists.tmp dump.tmp sql.new present.tmp absent.tmp) do (",
            cleanup,
        )
        self.assertNotRegex(cleanup, r"(?i)\.sql(?!\.new)")
        self.assertEqual(cleanup.count("setlocal"), 1)
        self.assertEqual(cleanup.count("endlocal"), 2)
        self.assertRegex(
            cleanup,
            r'(?s)if "!OPTIONALFAILED!" == "1" \(\s*'
            r'endlocal\s+exit /b 1\s*\)\s*endlocal\s+exit /b 0\s*$',
        )

    def test_group_loops_record_failure_and_helper_region_is_crlf(self) -> None:
        helper = batch_helper_region(BACKUP)
        self.assertNotRegex(
            helper, r'(?i)del /Q "[^"\r\n]*\*[^"\r\n]*"'
        )
        group = batch_label("DumpOptionalGroup", "ProbeOptionalTable")
        cleanup = batch_label(
            "CleanupOptionalGroupArtifacts", "DumpOptionalGroupRetainEmpty"
        )
        blocks = batch_for_blocks(group) + batch_for_blocks(cleanup)
        self.assertTrue(blocks, "optional-group loops are missing")
        for block in blocks:
            self.assertNotRegex(block, r"(?i)\bgoto\b")

        def assert_guarded(
            body: str, operation: str, failure_guard: str
        ) -> None:
            self.assertEqual(body.count(operation), 1)
            self.assertRegex(
                body,
                re.escape(operation) + r"\s*" + re.escape(failure_guard),
            )

        group_artifact = r'"!OPTIONALDIR!\%%~T.%%S"'
        assert_guarded(
            group,
            f"if exist {group_artifact} del /Q {group_artifact}",
            f'if exist {group_artifact} set "OPTIONALFAILED=1"',
        )
        assert_guarded(
            group,
            'call :ProbeOptionalTable "!OPTIONALDB!" "!OPTIONALDIR!" "%%~T"',
            'if errorlevel 1 set "OPTIONALFAILED=1"',
        )
        assert_guarded(
            group,
            'call :StageOptionalTable "!OPTIONALDB!" "!OPTIONALDIR!" '
            '"!OPTIONALSTRUCTURE!" "%%~T"',
            'if errorlevel 1 set "OPTIONALFAILED=1"',
        )
        assert_guarded(
            group,
            'move /Y "!OPTIONALREADY!" "!OPTIONALOUTPUT!" >nul',
            'if errorlevel 1 set "OPTIONALFAILED=1"',
        )
        assert_guarded(
            group,
            'if exist "!OPTIONALOUTPUT!" del /Q "!OPTIONALOUTPUT!"',
            'if exist "!OPTIONALOUTPUT!" set "OPTIONALFAILED=1"',
        )
        assert_guarded(
            group,
            'call :CleanupOptionalGroupArtifacts "!OPTIONALDIR!" "%~5" "%~6" "%~7"',
            "if errorlevel 1 goto DumpOptionalGroupFailed",
        )
        cleanup_artifact = r'"!OPTIONALDIR!\%%~T.%%S"'
        assert_guarded(
            cleanup,
            f"if exist {cleanup_artifact} del /Q {cleanup_artifact}",
            f'if exist {cleanup_artifact} set "OPTIONALFAILED=1"',
        )

        probe = batch_label("ProbeOptionalTable", "StageOptionalTable")
        self.assertEqual(
            probe.splitlines()[0],
            "setlocal EnableExtensions DisableDelayedExpansion",
        )
        self.assertNotRegex(probe, r"(?i)\bgoto\b")
        stage = batch_label("StageOptionalTable", "CleanupOptionalGroupArtifacts")
        self.assertEqual(
            stage.splitlines()[0],
            "setlocal EnableExtensions DisableDelayedExpansion",
        )
        stage_lines = stage.splitlines()
        dump_line = next(
            index
            for index, line in enumerate(stage_lines)
            if line.startswith('"%mysql%mysqldump.exe"')
        )
        self.assertEqual(stage_lines[dump_line + 1], "if errorlevel 1 (")
        dump_guard_end = next(
            index
            for index, line in enumerate(stage_lines[dump_line + 2 :], dump_line + 2)
            if line == ")"
        )
        self.assertIn(
            "exit /b 1",
            (line.strip() for line in stage_lines[dump_line + 1 : dump_guard_end]),
        )
        stage_preflight = "\n".join(stage_lines[:dump_line])
        for artifact in ("%OPTIONALTEMP%", "%OPTIONALREADY%"):
            assert_guarded(
                stage_preflight,
                f'if exist "{artifact}" del /Q "{artifact}"',
                f'if exist "{artifact}" (',
            )
            verification = stage_preflight.index(f'if exist "{artifact}" (')
            verification_end = stage_preflight.index("\n)", verification)
            self.assertIn(
                "exit /b 1", stage_preflight[verification:verification_end]
            )

        child_commands = [
            index
            for index, line in enumerate(stage_lines)
            if line.lstrip().startswith("%ComSpec% /D /C ")
        ]
        self.assertEqual(len(child_commands), 6)
        assembly_failures = []
        for index in child_commands:
            guard = stage_lines[index + 1].strip()
            match = re.fullmatch(
                r"if errorlevel 1 goto ([A-Za-z0-9_]+)", guard
            )
            self.assertIsNotNone(match, f"unguarded child command: {stage_lines[index]}")
            assembly_failures.append(match.group(1))
        self.assertEqual(len(set(assembly_failures)), 1)
        assembly_target = assembly_failures[0]
        delete_guard = re.search(
            r'(?s)del /Q "%OPTIONALTEMP%"\s*'
            r'if exist "%OPTIONALTEMP%" goto ([A-Za-z0-9_]+)',
            stage,
        )
        self.assertIsNotNone(delete_guard)
        self.assertEqual(delete_guard.group(1), assembly_target)
        move_guard = re.search(
            r'(?s)move /Y "%OPTIONALTEMP%" "%OPTIONALREADY%" >nul\s*'
            r'if errorlevel 1 goto ([A-Za-z0-9_]+)',
            stage,
        )
        self.assertIsNotNone(move_guard)
        self.assertEqual(move_guard.group(1), assembly_target)
        self.assertRegex(
            stage, rf"(?m)^:{re.escape(assembly_target)}\s*$"
        )

        raw = (ROOT / "Tools" / "backupDB.cmd").read_bytes()
        raw.decode("utf-8")
        normalized = raw.replace(b"\r\n", b"\n")
        start = normalized.find(b":DumpOptionalGroup\n")
        self.assertGreaterEqual(start, 0, "DumpOptionalGroup label is missing")
        end = normalized.find(b"\n:patherror", start)
        self.assertGreater(end, start, "optional-group helper region is unterminated")
        self.assertTrue(normalized[start:end].startswith(b":DumpOptionalGroup\n"))
        if os.name == "nt":
            windows_start = raw.find(b":DumpOptionalGroup\r\n")
            self.assertGreaterEqual(
                windows_start, 0, "DumpOptionalGroup CRLF label is missing"
            )
            windows_end = raw.find(b"\r\n:patherror", windows_start)
            self.assertGreater(
                windows_end,
                windows_start,
                "optional-group CRLF helper region is unterminated",
            )
            windows_region = raw[windows_start:windows_end]
            self.assertNotIn(b"\n", windows_region.replace(b"\r\n", b""))

    def test_script_returns_failure_to_automation(self) -> None:
        self.assertIn('set "BACKUPRESULT=0"', BACKUP)
        self.assertEqual(BACKUP.count('set "BACKUPRESULT=1"'), 2)
        self.assertRegex(
            BACKUP,
            r"(?ms)^:finish\s*$\s*pause\s*exit /b %BACKUPRESULT%\s*$",
        )

    @unittest.skipUnless(os.name == "nt", "cmd.exe behavior requires Windows")
    def test_optional_group_runtime_safety(self) -> None:
        region = batch_helper_region(BACKUP)
        region, probe_replacements = re.subn(
            r'(?m)^"%mysql%mysql\.exe".* > "%OPTIONALPROBE%" 2>nul[ \t]*$',
            'call :FakeMysql "%OPTIONALTABLE%" "%OPTIONALPROBE%"',
            region,
        )
        region, dump_replacements = re.subn(
            r'(?m)^"%mysql%mysqldump\.exe".* > "%OPTIONALTEMP%"[ \t]*$',
            'call :FakeDump "%OPTIONALTABLE%" "%OPTIONALTEMP%"',
            region,
        )
        self.assertEqual(probe_replacements, 1)
        self.assertEqual(dump_replacements, 1)

        def run_case(
            directory: Path,
            retain_empty: str,
            tables: tuple[str, ...],
            present: dict[str, str],
            fail_stage_table: str = "",
        ) -> subprocess.CompletedProcess[str]:
            assignments = [
                f'set "PRESENT_{table}={value}"'
                for table, value in present.items()
            ]
            table_args = " ".join(f'"{table}"' for table in tables)
            harness = "\n".join(
                [
                    "@echo off",
                    "setlocal EnableExtensions EnableDelayedExpansion",
                    'set "mysql="',
                    'set "user=test"',
                    'set "pass=test"',
                    'set "port=3306"',
                    'set "svr=localhost"',
                    f'set "FAIL_STAGE_TABLE={fail_stage_table}"',
                    *assignments,
                    f'call :DumpOptionalGroup "test" "{directory}" "YES" '
                    f'"{retain_empty}" {table_args}',
                    "exit /b %errorlevel%",
                    region,
                    ":FakeMysql",
                    "setlocal EnableDelayedExpansion",
                    '> "%~2" echo(!PRESENT_%~1!',
                    "endlocal",
                    "exit /b 0",
                    ":FakeDump",
                    "setlocal EnableDelayedExpansion",
                    'if /I "!FAIL_STAGE_TABLE!" == "%~1" exit /b 1',
                    '> "%~2" echo(-- deterministic dump for %~1',
                    "endlocal",
                    "exit /b 0",
                    "",
                ]
            )
            batch = directory / "run-group.cmd"
            batch.write_bytes(harness.replace("\n", "\r\n").encode("utf-8"))
            return subprocess.run(
                ["cmd.exe", "/d", "/c", str(batch)],
                cwd=directory,
                capture_output=True,
                check=False,
                text=True,
            )

        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)

            stage_failure = root / "stage-failure"
            stage_failure.mkdir()
            stage_failure_prior = b"prior world warden backup\r\n"
            (stage_failure / "warden.sql").write_bytes(stage_failure_prior)
            result = run_case(
                stage_failure,
                "YES",
                ("warden", "warden_checks"),
                {"warden": "0", "warden_checks": "1"},
                "warden_checks",
            )
            self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
            self.assertEqual(
                (stage_failure / "warden.sql").read_bytes(), stage_failure_prior
            )

            stale_marker = root / "stale-marker"
            stale_marker.mkdir()
            (stale_marker / "warden.absent.tmp").write_text(
                "stale", encoding="utf-8"
            )
            result = run_case(
                stale_marker,
                "YES",
                ("warden", "warden_checks"),
                {"warden": "1", "warden_checks": "0"},
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((stale_marker / "warden.absent.tmp").exists())
            self.assertIn(
                "deterministic dump for warden",
                (stale_marker / "warden.sql").read_text(encoding="utf-8"),
            )

            character_absent = root / "character-absent"
            character_absent.mkdir()
            (character_absent / "warden_action.sql").write_text(
                "prior", encoding="utf-8"
            )
            result = run_case(
                character_absent,
                "NO",
                ("warden_action",),
                {"warden_action": "0"},
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((character_absent / "warden_action.sql").exists())

            world_empty = root / "world-empty"
            world_empty.mkdir()
            world_empty_prior = {
                "warden": b"prior world warden backup\r\n",
                "warden_checks": b"prior world warden-checks backup\r\n",
            }
            for table, prior in world_empty_prior.items():
                (world_empty / f"{table}.sql").write_bytes(prior)
            result = run_case(
                world_empty,
                "YES",
                ("warden", "warden_checks"),
                {"warden": "0", "warden_checks": "0"},
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            for table, prior in world_empty_prior.items():
                self.assertEqual((world_empty / f"{table}.sql").read_bytes(), prior)

            invalid_probe = root / "invalid-probe"
            invalid_probe.mkdir()
            invalid_probe_prior = {
                "warden": b"prior invalid-probe warden backup\r\n",
                "warden_checks": b"prior invalid-probe warden-checks backup\r\n",
            }
            for table, prior in invalid_probe_prior.items():
                (invalid_probe / f"{table}.sql").write_bytes(prior)
            result = run_case(
                invalid_probe,
                "YES",
                ("warden", "warden_checks"),
                {"warden": "2", "warden_checks": "1"},
            )
            self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
            for table, prior in invalid_probe_prior.items():
                self.assertEqual((invalid_probe / f"{table}.sql").read_bytes(), prior)


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

    def test_unix_dump_retains_prior_warden_files_when_no_tables_exist(self) -> None:
        function = re.search(
            r"(?ms)^dump_warden_tables\(\)\s*\{.*?^\}\s*$", DUMP
        )
        self.assertIsNotNone(function, "dump_warden_tables is missing")
        harness = "\n".join(
            (
                function.group(0),
                "mysql() { printf '0\\n'; }",
                "mysqldump() { return 99; }",
                "USERNAME=test",
                "PASSWORD=test",
                "DB=test_world",
                'DUMPDIR="$1"',
                'touch "${DUMPDIR}/warden.sql" "${DUMPDIR}/warden_checks.sql"',
                "set -e",
                "dump_warden_tables",
                "status=$?",
                "test ${status} -eq 0",
                'test -f "${DUMPDIR}/warden.sql"',
                'test -f "${DUMPDIR}/warden_checks.sql"',
            )
        )
        with tempfile.TemporaryDirectory() as temporary:
            result = subprocess.run(
                [bash_executable(), "-c", harness, "dump-warden-harness", temporary],
                capture_output=True,
                check=False,
                text=True,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("Neither warden nor warden_checks exists", result.stderr)
            self.assertTrue((Path(temporary) / "warden.sql").is_file())
            self.assertTrue((Path(temporary) / "warden_checks.sql").is_file())

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
