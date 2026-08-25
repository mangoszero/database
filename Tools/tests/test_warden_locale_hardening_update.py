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
import unittest


ROOT = Path(__file__).resolve().parents[2]
UPDATE_PATH = (
    ROOT / "World" / "Updates" / "Rel22"
    / "Rel22_06_004_Warden_Locale_Hardening.sql"
)


class WardenLocaleHardeningUpdateTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        if not UPDATE_PATH.is_file():
            raise AssertionError(f"missing {UPDATE_PATH.name}")
        cls.sql = UPDATE_PATH.read_text(encoding="utf-8")

    def row(self, build: int, locale_hex: str, check_id: int) -> str:
        match = re.search(
            rf"(?ms)^\s*\({build},0x57696E,0x{locale_hex},{check_id},.*?"
            r"\)(?:,|;)$",
            self.sql,
        )
        self.assertIsNotNone(
            match, f"missing {build}/Win/{locale_hex} check {check_id}"
        )
        return match.group(0)

    def test_advances_only_the_expected_world_database_revision(self) -> None:
        self.assertIn("SET @cOldVersion = '22';", self.sql)
        self.assertIn("SET @cOldStructure = '06';", self.sql)
        self.assertIn("SET @cOldContent = '003';", self.sql)
        self.assertIn("SET @cNewVersion = '22';", self.sql)
        self.assertIn("SET @cNewStructure = '06';", self.sql)
        self.assertIn("SET @cNewContent = '004';", self.sql)
        self.assertIn("SET @cNewDescription = 'Warden_Locale_Hardening';", self.sql)
        self.assertNotRegex(self.sql, r"(?i)INSERT\s+(?:IGNORE\s+)?INTO\s+`?db_version`?.*003")

    def test_adds_five_complete_profiles_and_hardens_three_existing_ones(self) -> None:
        expected_ids = {65536, 1, 2, 1107, 827, 1566, 1135, 65537, 65538}
        new_profiles = {
            (5875, "6B6F4B52"),
            (5875, "7A685457"),
            (5875, "66724652"),
            (5875, "65734553"),
            (6005, "64654445"),
        }
        existing_profiles = {
            (5875, "656E5553"),
            (6005, "656E4742"),
            (6141, "7A68434E"),
        }

        rows = re.findall(
            r"(?m)^\s*\((\d+),0x57696E,0x([0-9A-F]{8}),(\d+),",
            self.sql,
        )
        self.assertEqual(len(rows), 51)
        actual: dict[tuple[int, str], set[int]] = {}
        for build, locale, check_id in rows:
            actual.setdefault((int(build), locale), set()).add(int(check_id))
        for profile in new_profiles:
            self.assertEqual(actual.get(profile), expected_ids)
        for profile in existing_profiles:
            self.assertEqual(actual.get(profile), {65537, 65538})
        self.assertEqual(set(actual), new_profiles | existing_profiles)

    def test_pins_each_new_localized_archive_and_lua_expectation(self) -> None:
        expectations = {
            (5875, "6B6F4B52"): (
                "755D6D7F49BB34114433386D559261ED3AA23F00", "ED9995EC9DB8"
            ),
            (5875, "7A685457"): (
                "2A70E6402A40A4F9E9960CED419DBA5E6DEB8536", "E7A2BAE5AE9A"
            ),
            (5875, "66724652"): (
                "AF2D81AF013A9BA6BB92CE171E43FA903C9E8C09", "4F4B"
            ),
            (5875, "65734553"): (
                "1ECEC2C6596B8411FA5FE153EDFB9A6EE43360E9", "41636570746172"
            ),
            (6005, "64654445"): (
                "A0B3DC2D78AD892F2436BCD937BE51B4989D64C1", "4F4B"
            ),
        }
        for (build, locale), (mpq_sha1, lua_text) in expectations.items():
            self.assertIn(f"0x{mpq_sha1}", self.row(build, locale, 1))
            self.assertIn(f"0x{lua_text}", self.row(build, locale, 2))

    def test_pins_signature_dispatch_tables_for_every_profile(self) -> None:
        profiles = {
            (5875, "656E5553"), (5875, "6B6F4B52"),
            (5875, "7A685457"), (5875, "66724652"),
            (5875, "65734553"), (6005, "656E4742"),
            (6005, "64654445"), (6141, "7A68434E"),
        }
        for build, locale in profiles:
            glue = self.row(build, locale, 65537)
            self.assertRegex(
                glue,
                r",243,1,80,1,X'',4631212,16,X'',"
                r"\s*0x1CA9460029A9460036A946009EA94600,",
            )
            frame = self.row(build, locale, 65538)
            if build == 6141:
                address = 4788152
                expected = "4E0D49005B0D4900680D4900850D4900"
            else:
                address = 4784584
                expected = "5EFF48006BFF480078FF480095FF4800"
            self.assertRegex(
                frame,
                rf",243,1,90,1,X'',{address},16,X'',\s*0x{expected},",
            )

    def test_validates_required_rows_without_rejecting_operator_tuning(self) -> None:
        self.assertRegex(
            self.sql,
            r"(?s)SET @cRequiredSeedRows :=\s*\(.*?"
            r"\(`build`,`platform`,`locale`\) IN\s*\(\s*"
            r"\(5875,0x57696E,0x656E5553\),\s*"
            r"\(6005,0x57696E,0x656E4742\),\s*"
            r"\(6141,0x57696E,0x7A68434E\)\s*\).*?"
            r"`check_id` IN\s*\(1,2,827,1107,1135,1566,65536\).*?"
            r"IF @cRequiredSeedRows <> 21",
        )
        self.assertRegex(
            self.sql,
            r"(?s)SET @cRequiredExpandedRows :=\s*\(.*?"
            r"\(5875,0x57696E,0x656E5553\),\s*"
            r"\(5875,0x57696E,0x6B6F4B52\),\s*"
            r"\(5875,0x57696E,0x7A685457\),\s*"
            r"\(5875,0x57696E,0x66724652\),\s*"
            r"\(5875,0x57696E,0x65734553\),\s*"
            r"\(6005,0x57696E,0x656E4742\),\s*"
            r"\(6005,0x57696E,0x64654445\),\s*"
            r"\(6141,0x57696E,0x7A68434E\)\s*\).*?"
            r"`check_id` IN\s*\(1,2,827,1107,1135,1566,65536,65537,65538\).*?"
            r"IF @cRequiredExpandedRows <> 72",
        )
        self.assertNotRegex(
            self.sql,
            r"COUNT\(\*\) FROM `warden_checks` WHERE `enabled` = 1",
        )
        self.assertIn("restore the canonical 22/06/003 seed", self.sql)
        self.assertIn("START TRANSACTION;", self.sql)
        self.assertIn("ROLLBACK;", self.sql)
        self.assertIn("COMMIT;", self.sql)
        self.assertNotRegex(self.sql, r"(?i)INSERT\s+IGNORE|REPLACE\s+INTO")

    def test_preserves_operator_rows_while_reserving_new_id_and_order_slots(self) -> None:
        self.assertIn(
            "Custom Warden check IDs 65537/65538 conflict", self.sql
        )
        self.assertIn(
            "Custom rows already use a new Warden locale profile", self.sql
        )
        self.assertIn(
            "Warden sort_order relocation would overflow", self.sql
        )
        self.assertRegex(
            self.sql,
            r"(?s)UPDATE `warden_checks`\s+"
            r"SET `sort_order` = `sort_order` \+ 20\s+"
            r"WHERE \(`build`,`platform`,`locale`\) IN\s*\(\s*"
            r"\(5875,0x57696E,0x656E5553\),\s*"
            r"\(6005,0x57696E,0x656E4742\),\s*"
            r"\(6141,0x57696E,0x7A68434E\)\s*\)\s+"
            r"AND `sort_order` >= 80\s+"
            r"ORDER BY `sort_order` DESC;",
        )
        self.assertLess(
            self.sql.index("SET `sort_order` = `sort_order` + 20"),
            self.sql.index("INSERT INTO `warden_checks`"),
        )


if __name__ == "__main__":
    unittest.main()
