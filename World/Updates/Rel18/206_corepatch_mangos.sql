--
-- Copyright (C) 2005-2013 MaNGOS <http://getmangos.com/>
-- Copyright (C) 2009-2013 MaNGOSZero <https://github.com/mangoszero>
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--

-- z2302
ALTER TABLE db_version CHANGE COLUMN required_z2268_s1900_12370_02_mangos_npc_vendor_template required_z2302_sxxxx_xxxxx_01_mangos_string bit;

DELETE FROM mangos_string WHERE entry =548;

INSERT INTO mangos_string VALUES
(548,'Player%s %s (guid: %u) Account: %s (id: %u) GMLevel: %u E-mail: %s Last IP: %s Last login: %s Latency: %ums',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- z2330
ALTER TABLE db_version CHANGE COLUMN required_z2302_sxxxx_xxxxx_01_mangos_string required_z2330_sxxxx_xxxxx_01_mangos_spell_proc_event bit;

DELETE FROM `spell_proc_event` WHERE `entry` = 23401;
INSERT INTO spell_proc_event VALUES
(23401, 0x00,  6, 0x0000000000041e00, 0x0000000000000000, 0x0000000000000000, 0x00004000, 0x00000000, 0.000000, 0.000000,  0);

-- z2363
ALTER TABLE db_version CHANGE COLUMN required_z2330_sxxxx_xxxxx_01_mangos_spell_proc_event required_z2363_s1957_12440_01_mangos_spell_area bit;

ALTER TABLE spell_area ADD COLUMN `condition_id` mediumint(8) unsigned NOT NULL default '0' AFTER quest_end;
