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

ALTER TABLE  `db_version` CHANGE `required_r2434_01_mangos_scripted_event` `required_r2439_01_mangos_command` BIT(1) NULL DEFAULT NULL;

UPDATE `command` SET `name` = 'appear', `security` = 1, `help` = 'Syntax: .appear [$charactername]Teleport to the given character. Either specify the character name or click on the character''s portrait, e.g. when you are in a group. Character can be offline.' WHERE `name` = 'goname';
UPDATE `command` SET `name` = 'summon', `security` = 1, `help` = 'Syntax: .summon [$charactername]Teleport the given character to you. Character can be offline.' WHERE `name` = 'namego';

ALTER TABLE  `db_version` CHANGE `required_r2439_01_mangos_command` `required_r2441_01_mangos_db_version` BIT(1) NULL DEFAULT NULL;
ALTER TABLE `db_version` ADD PRIMARY KEY(`version`);
