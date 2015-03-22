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
ALTER TABLE db_version CHANGE COLUMN required_z2363_s1957_12440_01_mangos_spell_area required_z2408_s2034_12522_01_mangos_db_script_string bit;


ALTER TABLE db_script_string ADD COLUMN sound mediumint(8) unsigned NOT NULL DEFAULT '0' AFTER content_loc8;
ALTER TABLE db_script_string ADD COLUMN type tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER sound;
ALTER TABLE db_script_string ADD COLUMN language tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER type;
ALTER TABLE db_script_string ADD COLUMN emote smallint(5) unsigned NOT NULL DEFAULT '0' AFTER language;
ALTER TABLE db_script_string ADD COLUMN comment text AFTER emote;

-- Update Dbscript_string with the type and language from Dbscripts_on_*
CREATE TEMPORARY TABLE IF NOT EXISTS db_script_temp AS
-- dbscripts_on_creature_death
SELECT A.entry
    ,A.content_default
    ,A.content_loc1
    ,A.content_loc2
    ,A.content_loc3
    ,A.content_loc4
    ,A.content_loc5
    ,A.content_loc6
    ,A.content_loc7
    ,A.content_loc8
    ,0 AS sound
    ,B.datalong AS type
    ,B.datalong2 AS language
    ,0 AS emote
    ,NULL AS comment
FROM db_script_string A
INNER JOIN dbscripts_on_creature_death B ON (A.entry = B.dataint OR A.entry = B.dataint2 OR A.entry = B.dataint3 OR A.entry = B.dataint4)
-- dbscripts_on_creature_movement
UNION ALL
SELECT A.entry
    ,A.content_default
    ,A.content_loc1
    ,A.content_loc2
    ,A.content_loc3
    ,A.content_loc4
    ,A.content_loc5
    ,A.content_loc6
    ,A.content_loc7
    ,A.content_loc8
    ,0 AS sound
    ,B.datalong AS type
    ,B.datalong2 AS language
    ,0 AS emote
    ,NULL AS comment
FROM db_script_string A
INNER JOIN dbscripts_on_creature_movement B ON (A.entry = B.dataint OR A.entry = B.dataint2 OR A.entry = B.dataint3 OR A.entry = B.dataint4)
-- dbscripts_on_event
UNION ALL
SELECT A.entry
    ,A.content_default
    ,A.content_loc1
    ,A.content_loc2
    ,A.content_loc3
    ,A.content_loc4
    ,A.content_loc5
    ,A.content_loc6
    ,A.content_loc7
    ,A.content_loc8
    ,0 AS sound
    ,B.datalong AS type
    ,B.datalong2 AS language
    ,0 AS emote
    ,NULL AS comment
FROM db_script_string A
INNER JOIN dbscripts_on_event B ON (A.entry = B.dataint OR A.entry = B.dataint2 OR A.entry = B.dataint3 OR A.entry = B.dataint4)
-- dbscripts_on_gossip
UNION ALL
SELECT A.entry
    ,A.content_default
    ,A.content_loc1
    ,A.content_loc2
    ,A.content_loc3
    ,A.content_loc4
    ,A.content_loc5
    ,A.content_loc6
    ,A.content_loc7
    ,A.content_loc8
    ,0 AS sound
    ,B.datalong AS type
    ,B.datalong2 AS language
    ,0 AS emote
    ,NULL AS comment
FROM db_script_string A
INNER JOIN dbscripts_on_gossip B ON (A.entry = B.dataint OR A.entry = B.dataint2 OR A.entry = B.dataint3 OR A.entry = B.dataint4)
-- dbscripts_on_go_template_use
UNION ALL
SELECT A.entry
    ,A.content_default
    ,A.content_loc1
    ,A.content_loc2
    ,A.content_loc3
    ,A.content_loc4
    ,A.content_loc5
    ,A.content_loc6
    ,A.content_loc7
    ,A.content_loc8
    ,0 AS sound
    ,B.datalong AS type
    ,B.datalong2 AS language
    ,0 AS emote
    ,NULL AS comment
FROM db_script_string A
INNER JOIN dbscripts_on_go_template_use B ON (A.entry = B.dataint OR A.entry = B.dataint2 OR A.entry = B.dataint3 OR A.entry = B.dataint4)
-- dbscripts_on_go_use
UNION ALL
SELECT A.entry
    ,A.content_default
    ,A.content_loc1
    ,A.content_loc2
    ,A.content_loc3
    ,A.content_loc4
    ,A.content_loc5
    ,A.content_loc6
    ,A.content_loc7
    ,A.content_loc8
    ,0 AS sound
    ,B.datalong AS type
    ,B.datalong2 AS language
    ,0 AS emote
    ,NULL AS comment
FROM db_script_string A
INNER JOIN dbscripts_on_go_use B ON (A.entry = B.dataint OR A.entry = B.dataint2 OR A.entry = B.dataint3 OR A.entry = B.dataint4)
-- dbscripts_on_quest_end
UNION ALL
SELECT A.entry
    ,A.content_default
    ,A.content_loc1
    ,A.content_loc2
    ,A.content_loc3
    ,A.content_loc4
    ,A.content_loc5
    ,A.content_loc6
    ,A.content_loc7
    ,A.content_loc8
    ,0 AS sound
    ,B.datalong AS type
    ,B.datalong2 AS language
    ,0 AS emote
    ,NULL AS comment
FROM db_script_string A
INNER JOIN dbscripts_on_quest_end B ON (A.entry = B.dataint OR A.entry = B.dataint2 OR A.entry = B.dataint3 OR A.entry = B.dataint4)
-- dbscripts_on_quest_start
UNION ALL
SELECT A.entry
    ,A.content_default
    ,A.content_loc1
    ,A.content_loc2
    ,A.content_loc3
    ,A.content_loc4
    ,A.content_loc5
    ,A.content_loc6
    ,A.content_loc7
    ,A.content_loc8
    ,0 AS sound
    ,B.datalong AS type
    ,B.datalong2 AS language
    ,0 AS emote
    ,NULL AS comment
FROM db_script_string A
INNER JOIN dbscripts_on_quest_start B ON (A.entry = B.dataint OR A.entry = B.dataint2 OR A.entry = B.dataint3 OR A.entry = B.dataint4)
-- dbscripts_on_spell
UNION ALL
SELECT A.entry
    ,A.content_default
    ,A.content_loc1
    ,A.content_loc2
    ,A.content_loc3
    ,A.content_loc4
    ,A.content_loc5
    ,A.content_loc6
    ,A.content_loc7
    ,A.content_loc8
    ,0 AS sound
    ,B.datalong AS type
    ,B.datalong2 AS language
    ,0 AS emote
    ,NULL AS comment
FROM db_script_string A
INNER JOIN dbscripts_on_spell B ON (A.entry = B.dataint OR A.entry = B.dataint2 OR A.entry = B.dataint3 OR A.entry = B.dataint4);

-- Clean dbscript_string and insert the new updated values
DELETE FROM db_script_string WHERE entry IN (SELECT DISTINCT entry FROM db_script_temp);
INSERT INTO db_script_string SELECT DISTINCT * FROM db_script_temp;
DROP TABLE IF EXISTS db_script_temp;

ALTER TABLE db_version CHANGE COLUMN required_z2408_s2034_12522_01_mangos_db_script_string required_r2420_01_mangos_spell_linked bit;

DROP TABLE IF EXISTS `spell_linked`;
CREATE TABLE IF NOT EXISTS `spell_linked` (
  `entry` int(10) unsigned NOT NULL COMMENT 'Spell entry',
  `linked_entry` int(10) unsigned NOT NULL COMMENT 'Linked spell entry',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Type of link',
  `effect_mask`int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'mask of effect (NY)',
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`,`linked_entry`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Linked spells storage';
