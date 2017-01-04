--
-- Copyright (C) 2005-2017 MaNGOS <https://getmangos.eu/>
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
--

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@SESSION.TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- ----------------------------
-- Table structure for `db_version`
-- ----------------------------
DROP TABLE IF EXISTS `db_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_version` (
  `version` INT(3) NOT NULL,
  `structure` INT(3) NOT NULL,
  `content` INT(3) NOT NULL,
  `description` VARCHAR(30) NOT NULL DEFAULT '',
  `comment` VARCHAR(150) DEFAULT '',
  PRIMARY KEY (`version`,`structure`,`content`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Used DB version notes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areatrigger_tavern`
--

DROP TABLE IF EXISTS `areatrigger_tavern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_tavern` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `name` TEXT,
  PRIMARY KEY (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areatrigger_teleport`
--

DROP TABLE IF EXISTS `areatrigger_teleport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_teleport` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `name` TEXT,
  `target_map` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `target_position_x` FLOAT NOT NULL DEFAULT '0',
  `target_position_y` FLOAT NOT NULL DEFAULT '0',
  `target_position_z` FLOAT NOT NULL DEFAULT '0',
  `target_orientation` FLOAT NOT NULL DEFAULT '0',
  `condition_id` MEDIUMINT(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `battleground_events`
--

DROP TABLE IF EXISTS `battleground_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battleground_events` (
  `map` SMALLINT(5) NOT NULL,
  `event1` TINYINT(3) UNSIGNED NOT NULL,
  `event2` TINYINT(3) UNSIGNED NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`map`,`event1`,`event2`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `battleground_template`
--

DROP TABLE IF EXISTS `battleground_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battleground_template` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `MinPlayersPerTeam` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `MaxPlayersPerTeam` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `MinLvl` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `MaxLvl` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `AllianceStartLoc` MEDIUMINT(8) UNSIGNED NOT NULL,
  `AllianceStartO` FLOAT NOT NULL,
  `HordeStartLoc` MEDIUMINT(8) UNSIGNED NOT NULL,
  `HordeStartO` FLOAT NOT NULL,
  `StartMaxDist` FLOAT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `battlemaster_entry`
--

DROP TABLE IF EXISTS `battlemaster_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battlemaster_entry` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Entry of a creature',
  `bg_template` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Battleground template id',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `command`
--

DROP TABLE IF EXISTS `command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command` (
  `name` VARCHAR(50) NOT NULL DEFAULT '',
  `security` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `help` LONGTEXT,
  PRIMARY KEY (`name`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Chat System';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `condition_entry` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `type` TINYINT(3) NOT NULL DEFAULT '0' COMMENT 'Type of the condition',
  `value1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'data field one for the condition',
  `value2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'data field two for the condition',
  PRIMARY KEY (`condition_entry`),
  UNIQUE KEY `unique_conditions` (`type`,`value1`,`value2`)
) ENGINE=MYISAM AUTO_INCREMENT=1791 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Condition System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature`
--

DROP TABLE IF EXISTS `creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature` (
  `guid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier',
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `map` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `modelid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `equipment_id` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `position_x` FLOAT NOT NULL DEFAULT '0',
  `position_y` FLOAT NOT NULL DEFAULT '0',
  `position_z` FLOAT NOT NULL DEFAULT '0',
  `orientation` FLOAT NOT NULL DEFAULT '0',
  `spawntimesecs` INT(10) UNSIGNED NOT NULL DEFAULT '120',
  `spawndist` FLOAT NOT NULL DEFAULT '5',
  `currentwaypoint` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `curhealth` INT(10) UNSIGNED NOT NULL DEFAULT '1',
  `curmana` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `DeathState` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `MovementType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `idx_map` (`map`),
  KEY `index_id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=590016 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_addon`
--

DROP TABLE IF EXISTS `creature_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_addon` (
  `guid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `mount` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `bytes1` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `b2_0_sheath` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `b2_1_flags` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `emote` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `moveflags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `auras` TEXT,
  PRIMARY KEY (`guid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_ai_scripts`
--

DROP TABLE IF EXISTS `creature_ai_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_scripts` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `creature_id` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Creature Template Identifier',
  `event_type` TINYINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Event Type',
  `event_inverse_phase_mask` INT(11) NOT NULL DEFAULT '0' COMMENT 'Mask which phases this event will not trigger in',
  `event_chance` INT(3) UNSIGNED NOT NULL DEFAULT '100',
  `event_flags` INT(3) UNSIGNED NOT NULL DEFAULT '0',
  `event_param1` INT(11) NOT NULL DEFAULT '0',
  `event_param2` INT(11) NOT NULL DEFAULT '0',
  `event_param3` INT(11) NOT NULL DEFAULT '0',
  `event_param4` INT(11) NOT NULL DEFAULT '0',
  `action1_type` TINYINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Action Type',
  `action1_param1` INT(11) NOT NULL DEFAULT '0',
  `action1_param2` INT(11) NOT NULL DEFAULT '0',
  `action1_param3` INT(11) NOT NULL DEFAULT '0',
  `action2_type` TINYINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Action Type',
  `action2_param1` INT(11) NOT NULL DEFAULT '0',
  `action2_param2` INT(11) NOT NULL DEFAULT '0',
  `action2_param3` INT(11) NOT NULL DEFAULT '0',
  `action3_type` TINYINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Action Type',
  `action3_param1` INT(11) NOT NULL DEFAULT '0',
  `action3_param2` INT(11) NOT NULL DEFAULT '0',
  `action3_param3` INT(11) NOT NULL DEFAULT '0',
  `comment` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Event Comment',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM AUTO_INCREMENT=4334033 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='EventAI Scripts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_ai_summons`
--

DROP TABLE IF EXISTS `creature_ai_summons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_summons` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Location Identifier',
  `position_x` FLOAT NOT NULL DEFAULT '0',
  `position_y` FLOAT NOT NULL DEFAULT '0',
  `position_z` FLOAT NOT NULL DEFAULT '0',
  `orientation` FLOAT NOT NULL DEFAULT '0',
  `spawntimesecs` INT(11) UNSIGNED NOT NULL DEFAULT '120',
  `comment` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Summon Comment',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='EventAI Summoning Locations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_ai_texts`
--

DROP TABLE IF EXISTS `creature_ai_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_texts` (
  `entry` MEDIUMINT(8) NOT NULL,
  `content_default` TEXT NOT NULL,
  `content_loc1` TEXT,
  `content_loc2` TEXT,
  `content_loc3` TEXT,
  `content_loc4` TEXT,
  `content_loc5` TEXT,
  `content_loc6` TEXT,
  `content_loc7` TEXT,
  `content_loc8` TEXT,
  `sound` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `language` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `emote` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `comment` TEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Script Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_battleground`
--

DROP TABLE IF EXISTS `creature_battleground`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_battleground` (
  `guid` INT(10) UNSIGNED NOT NULL COMMENT 'Creature''s GUID',
  `event1` TINYINT(3) UNSIGNED NOT NULL COMMENT 'main event',
  `event2` TINYINT(3) UNSIGNED NOT NULL COMMENT 'sub event',
  PRIMARY KEY (`guid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature battleground indexing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_equip_template`
--

DROP TABLE IF EXISTS `creature_equip_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_equip_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Unique entry',
  `equipentry1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `equipentry2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `equipentry3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`),
  UNIQUE KEY `unique_template` (`equipentry1`,`equipentry2`,`equipentry3`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Equipment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_equip_template_raw`
--

DROP TABLE IF EXISTS `creature_equip_template_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_equip_template_raw` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Unique entry',
  `equipmodel1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `equipmodel2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `equipmodel3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `equipinfo1` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `equipinfo2` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `equipinfo3` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `equipslot1` INT(11) NOT NULL DEFAULT '0',
  `equipslot2` INT(11) NOT NULL DEFAULT '0',
  `equipslot3` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Equipment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_item_template`
--

DROP TABLE IF EXISTS `creature_item_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_item_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `class` TINYINT(3) UNSIGNED DEFAULT '0',
  `subclass` TINYINT(3) UNSIGNED DEFAULT '0',
  `material` MEDIUMINT(8) UNSIGNED DEFAULT '0',
  `displayid` MEDIUMINT(8) UNSIGNED DEFAULT '0',
  `inventory_type` TINYINT(3) UNSIGNED DEFAULT '0',
  `sheath_type` TINYINT(3) UNSIGNED DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Equipment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_linking`
--

DROP TABLE IF EXISTS `creature_linking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_linking` (
  `guid` INT(10) UNSIGNED NOT NULL COMMENT 'creature.guid of the slave mob that is linked',
  `master_guid` INT(10) UNSIGNED NOT NULL COMMENT 'master to trigger events',
  `flag` MEDIUMINT(8) UNSIGNED NOT NULL COMMENT 'flag - describing what should happen when',
  PRIMARY KEY (`guid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature Linking System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_linking_template`
--

DROP TABLE IF EXISTS `creature_linking_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_linking_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'creature_template.entry of the slave mob that is linked',
  `map` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Id of map of the mobs',
  `master_entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'master to trigger events',
  `flag` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'flag - describing what should happen when',
  `search_range` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'search_range - describing in which range (spawn-coords) master and slave are linked together',
  PRIMARY KEY (`entry`,`map`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature Linking System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_loot_template`
--

DROP TABLE IF EXISTS `creature_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_loot_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'entry 0 used for player insignia loot',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` FLOAT NOT NULL DEFAULT '100',
  `groupid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `mincountOrRef` MEDIUMINT(9) NOT NULL DEFAULT '1',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_model_info`
--

DROP TABLE IF EXISTS `creature_model_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_model_info` (
  `modelid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `bounding_radius` FLOAT NOT NULL DEFAULT '0',
  `combat_reach` FLOAT NOT NULL DEFAULT '0',
  `gender` TINYINT(3) UNSIGNED NOT NULL DEFAULT '2',
  `modelid_other_gender` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `modelid_other_team` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`modelid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Model related info)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_movement`
--

DROP TABLE IF EXISTS `creature_movement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_movement` (
  `id` INT(10) UNSIGNED NOT NULL COMMENT 'Creature GUID',
  `point` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `position_x` FLOAT NOT NULL DEFAULT '0',
  `position_y` FLOAT NOT NULL DEFAULT '0',
  `position_z` FLOAT NOT NULL DEFAULT '0',
  `waittime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `script_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `textid1` INT(11) NOT NULL DEFAULT '0',
  `textid2` INT(11) NOT NULL DEFAULT '0',
  `textid3` INT(11) NOT NULL DEFAULT '0',
  `textid4` INT(11) NOT NULL DEFAULT '0',
  `textid5` INT(11) NOT NULL DEFAULT '0',
  `emote` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `orientation` FLOAT NOT NULL DEFAULT '0',
  `model1` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `model2` MEDIUMINT(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`point`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_movement_template`
--

DROP TABLE IF EXISTS `creature_movement_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_movement_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL COMMENT 'Creature entry',
  `point` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `position_x` FLOAT NOT NULL DEFAULT '0',
  `position_y` FLOAT NOT NULL DEFAULT '0',
  `position_z` FLOAT NOT NULL DEFAULT '0',
  `waittime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `script_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `textid1` INT(11) NOT NULL DEFAULT '0',
  `textid2` INT(11) NOT NULL DEFAULT '0',
  `textid3` INT(11) NOT NULL DEFAULT '0',
  `textid4` INT(11) NOT NULL DEFAULT '0',
  `textid5` INT(11) NOT NULL DEFAULT '0',
  `emote` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `orientation` FLOAT NOT NULL DEFAULT '0',
  `model1` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `model2` MEDIUMINT(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`point`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature waypoint system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_onkill_reputation`
--

DROP TABLE IF EXISTS `creature_onkill_reputation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_onkill_reputation` (
  `creature_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `RewOnKillRepFaction1` SMALLINT(6) NOT NULL DEFAULT '0',
  `RewOnKillRepFaction2` SMALLINT(6) NOT NULL DEFAULT '0',
  `MaxStanding1` TINYINT(4) NOT NULL DEFAULT '0',
  `IsTeamAward1` TINYINT(4) NOT NULL DEFAULT '0',
  `RewOnKillRepValue1` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `MaxStanding2` TINYINT(4) NOT NULL DEFAULT '0',
  `IsTeamAward2` TINYINT(4) NOT NULL DEFAULT '0',
  `RewOnKillRepValue2` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `TeamDependent` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`creature_id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature OnKill Reputation gain';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_template`
--

DROP TABLE IF EXISTS `creature_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template` (
  `Entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Name` CHAR(100) NOT NULL DEFAULT '',
  `SubName` CHAR(100) DEFAULT NULL,
  `MinLevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `MaxLevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `ModelId1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ModelId2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ModelId3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ModelId4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `FactionAlliance` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `FactionHorde` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `Scale` FLOAT NOT NULL DEFAULT '1',
  `Family` TINYINT(4) NOT NULL DEFAULT '0',
  `CreatureType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `InhabitType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '3',
  `RegenerateStats` TINYINT(3) UNSIGNED DEFAULT NULL,
  `RacialLeader` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `NpcFlags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `UnitFlags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `DynamicFlags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `ExtraFlags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `CreatureTypeFlags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `SpeedWalk` FLOAT NOT NULL DEFAULT '1',
  `SpeedRun` FLOAT NOT NULL DEFAULT '1.14286',
  `UnitClass` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `Rank` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `HealthMultiplier` FLOAT NOT NULL DEFAULT '1',
  `PowerMultiplier` FLOAT NOT NULL DEFAULT '1',
  `DamageMultiplier` FLOAT NOT NULL DEFAULT '1',
  `DamageVariance` FLOAT NOT NULL DEFAULT '1',
  `ArmorMultiplier` FLOAT NOT NULL DEFAULT '1',
  `ExperienceMultiplier` FLOAT NOT NULL DEFAULT '1',
  `MinLevelHealth` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `MaxLevelHealth` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `MinLevelMana` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `MaxLevelMana` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `MinMeleeDmg` FLOAT NOT NULL DEFAULT '0',
  `MaxMeleeDmg` FLOAT NOT NULL DEFAULT '0',
  `MinRangedDmg` FLOAT NOT NULL DEFAULT '0',
  `MaxRangedDmg` FLOAT NOT NULL DEFAULT '0',
  `Armor` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `MeleeAttackPower` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `RangedAttackPower` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `MeleeBaseAttackTime` INT(10) UNSIGNED NOT NULL DEFAULT '2000',
  `RangedBaseAttackTime` INT(10) UNSIGNED NOT NULL DEFAULT '2000',
  `DamageSchool` TINYINT(4) NOT NULL DEFAULT '0',
  `MinLootGold` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `MaxLootGold` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `LootId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `PickpocketLootId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `SkinningLootId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `KillCredit1` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `KillCredit2` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `MechanicImmuneMask` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `ResistanceHoly` SMALLINT(5) NOT NULL DEFAULT '0',
  `ResistanceFire` SMALLINT(5) NOT NULL DEFAULT '0',
  `ResistanceNature` SMALLINT(5) NOT NULL DEFAULT '0',
  `ResistanceFrost` SMALLINT(5) NOT NULL DEFAULT '0',
  `ResistanceShadow` SMALLINT(5) NOT NULL DEFAULT '0',
  `ResistanceArcane` SMALLINT(5) NOT NULL DEFAULT '0',
  `PetSpellDataId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `MovementType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `TrainerType` TINYINT(4) NOT NULL DEFAULT '0',
  `TrainerSpell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `TrainerClass` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `TrainerRace` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `TrainerTemplateId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `VendorTemplateId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `GossipMenuId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `EquipmentTemplateId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Civilian` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `AIName` CHAR(64) DEFAULT '',
  PRIMARY KEY (`Entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `creature_template_addon`
--

DROP TABLE IF EXISTS `creature_template_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template_addon` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `mount` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `bytes1` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `b2_0_sheath` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `b2_1_flags` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `emote` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `moveflags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `auras` TEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_template_classlevelstats`
--

DROP TABLE IF EXISTS `creature_template_classlevelstats`;

CREATE TABLE `creature_template_classlevelstats` (
  `Level` TINYINT(4) NOT NULL,
  `Class` TINYINT(4) NOT NULL,
  `BaseHealthExp0` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '1',
  `BaseMana` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `BaseDamageExp0` FLOAT NOT NULL DEFAULT '0',
  `BaseMeleeAttackPower` FLOAT NOT NULL DEFAULT '0',
  `BaseRangedAttackPower` FLOAT NOT NULL DEFAULT '0',
  `BaseArmor` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`Level`,`Class`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `creature_template_spells`
--

DROP TABLE IF EXISTS `creature_template_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template_spells` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL,
  `spell1` MEDIUMINT(8) UNSIGNED NOT NULL,
  `spell2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spell3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spell4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System (Spells used by creature)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_texts`
--

DROP TABLE IF EXISTS `custom_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_texts` (
  `entry` MEDIUMINT(8) NOT NULL,
  `content_default` TEXT NOT NULL,
  `content_loc1` TEXT,
  `content_loc2` TEXT,
  `content_loc3` TEXT,
  `content_loc4` TEXT,
  `content_loc5` TEXT,
  `content_loc6` TEXT,
  `content_loc7` TEXT,
  `content_loc8` TEXT,
  `sound` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `language` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `emote` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `comment` TEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Custom Texts';

--
-- Table structure for table `db_script_string`
--

DROP TABLE IF EXISTS `db_script_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_script_string` (
  `entry` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `content_default` TEXT NOT NULL,
  `content_loc1` TEXT,
  `content_loc2` TEXT,
  `content_loc3` TEXT,
  `content_loc4` TEXT,
  `content_loc5` TEXT,
  `content_loc6` TEXT,
  `content_loc7` TEXT,
  `content_loc8` TEXT,
  `sound` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `language` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `emote` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `comment` TEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `db_scripts`
--

DROP TABLE IF EXISTS `db_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_scripts` (
  `script_guid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `script_type` smallint(2) unsigned NOT NULL DEFAULT '0',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_entry` int(10) unsigned NOT NULL DEFAULT '0',
  `search_radius` int(10) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL,
  PRIMARY KEY (`script_guid`)
) ENGINE=MyISAM AUTO_INCREMENT=2628 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


/*Table structure for table `dbdocsfields` */

DROP TABLE IF EXISTS `dbdocsfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbdocsfields` (
  `fieldId` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique Id for this field',
  `languageId` INT(11) NOT NULL DEFAULT '0' COMMENT 'dbdocsLanguageId to link to. (Normally 0 = English)',
  `tableName` VARCHAR(80) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the table to link to',
  `fieldName` VARCHAR(80) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the field to link the note to',
  `fieldComment` VARCHAR(80) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Main field Note',
  `fieldNotes` TEXT COLLATE utf8_unicode_ci NOT NULL COMMENT 'Additional Field Notes',
  PRIMARY KEY (`fieldId`,`languageId`),
  KEY `fieldId` (`fieldId`)
) ENGINE=INNODB AUTO_INCREMENT=1764 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbdocsfields_localised`
--
DROP TABLE IF EXISTS `dbdocsfields_localised`;

CREATE TABLE `dbdocsfields_localised` (
  `fieldId` INT(11) NOT NULL COMMENT 'dbdocsfields.fieldId to link to.',
  `languageId` INT(11) NOT NULL DEFAULT '0' COMMENT 'dbdocsLanguageId to link to. (Normally 0 = English)',
  `fieldNotes` TEXT COLLATE utf8_unicode_ci NOT NULL COMMENT 'Additional Field Notes',
  `fieldComment` VARCHAR(80) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Main field Note',
  PRIMARY KEY (`fieldId`,`languageId`),
  KEY `fieldId` (`fieldId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `dbdocslanguage`
--
DROP TABLE IF EXISTS `dbdocslanguage`;

CREATE TABLE `dbdocslanguage` (
  `LanguageId` INT(11) NOT NULL COMMENT 'LanguageId for this Language',
  `LanguageName` VARCHAR(30) NOT NULL COMMENT 'The Language Name',
  PRIMARY KEY (`LanguageId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dbdocsprogressquests`
--
DROP TABLE IF EXISTS `dbdocsprogressquests`;

CREATE TABLE `dbdocsprogressquests` (
  `QuestID` INT(11) NOT NULL COMMENT 'The Quest ID to link to',
  `Progress` INT(11) NOT NULL DEFAULT '0' COMMENT 'The percentage of how complete the quest is',
  `QuestNotes` TEXT COMMENT 'Notes about the Quest',
  PRIMARY KEY (`QuestID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


--
-- Table structure for table `dbdocssubtables`
--
DROP TABLE IF EXISTS `dbdocssubtables`;

CREATE TABLE `dbdocssubtables` (
  `subTableId` INT(11) NOT NULL COMMENT 'Unique Lookup Id',
  `languageId` INT(11) NOT NULL DEFAULT '0' COMMENT 'dbdocsLanguageId to link to. (Normally 0 = English)',
  `subTableName` VARCHAR(80) DEFAULT NULL COMMENT 'Description of Content',
  `subTableTemplate` TEXT NOT NULL COMMENT 'The Sub Table Template',
  PRIMARY KEY (`subTableId`,`languageId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dbdocssubtables_localised`
--
DROP TABLE IF EXISTS `dbdocssubtables_localised`;

CREATE TABLE `dbdocssubtables_localised` (
  `subTableId` INT(11) NOT NULL COMMENT 'dbdocsSubtableId to link to',
  `languageId` INT(11) NOT NULL DEFAULT '0' COMMENT 'dbdocsLanguageId to link to. (Normally 0 = English)',
  `subTableTemplate` TEXT NOT NULL COMMENT 'The Sub Table Template',
  PRIMARY KEY (`subTableId`,`languageId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dbdocstable`
--
DROP TABLE IF EXISTS `dbdocstable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbdocstable` (
  `tableId` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this entry',
  `languageId` INT(11) NOT NULL DEFAULT '0' COMMENT 'The Language Id for the Notes (Normally 0 for English)',
  `tableName` VARCHAR(80) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the table to add additional notes to',
  `tableNotes` TEXT COLLATE utf8_unicode_ci NOT NULL COMMENT 'The additional note to be added to the table',
  PRIMARY KEY (`tableId`,`languageId`,`tableName`),
  KEY `tableId` (`tableId`)
) ENGINE=INNODB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbdocstable_localised`
--
DROP TABLE IF EXISTS `dbdocstable_localised`;

CREATE TABLE `dbdocstable_localised` (
  `tableId` INT(11) NOT NULL COMMENT 'The dbdocsTableId to link to',
  `languageId` INT(11) NOT NULL DEFAULT '0' COMMENT 'The dbdocsLanguageId to link to. (Normally 0 for English)',
  `tableNotes` TEXT COLLATE utf8_unicode_ci NOT NULL COMMENT 'The additional note to be added to the table',
  PRIMARY KEY (`tableId`,`languageId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `disables`
--

DROP TABLE IF EXISTS `disables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disables` (
 `sourceType` INT(10) UNSIGNED NOT NULL COMMENT 'Type of disable, see enum DisableType',
 `entry` INT(10) UNSIGNED NOT NULL COMMENT 'Main entry for disable, type-specific',
 `flags` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Flag bitfield, type-specific',
 `data` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Additional data, type-specific',
 `comment` VARCHAR(255) DEFAULT NULL COMMENT 'Description of disable cause',
 PRIMARY KEY(`sourceType`,`entry`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Mangos disables system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disenchant_loot_template`
--

DROP TABLE IF EXISTS `disenchant_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disenchant_loot_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Recommended id selection: item_level*100 + item_quality',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` FLOAT NOT NULL DEFAULT '100',
  `groupid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `mincountOrRef` MEDIUMINT(9) NOT NULL DEFAULT '1',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exploration_basexp`
--

DROP TABLE IF EXISTS `exploration_basexp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exploration_basexp` (
  `level` TINYINT(4) NOT NULL DEFAULT '0',
  `basexp` MEDIUMINT(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Exploration System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fishing_loot_template`
--

DROP TABLE IF EXISTS `fishing_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_loot_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'entry 0 used for junk loot at fishing fail (if allowed by config option)',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` FLOAT NOT NULL DEFAULT '100',
  `groupid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `mincountOrRef` MEDIUMINT(9) NOT NULL DEFAULT '1',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event`
--

DROP TABLE IF EXISTS `game_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL COMMENT 'Entry of the game event',
  `start_time` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Absolute start date, the event will never start before',
  `end_time` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Absolute end date, the event will never start afler',
  `occurence` BIGINT(20) UNSIGNED NOT NULL DEFAULT '86400' COMMENT 'Delay in minutes between occurences of the event',
  `length` BIGINT(20) UNSIGNED NOT NULL DEFAULT '43200' COMMENT 'Length in minutes of the event',
  `holiday` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Client side holiday id',
  `description` VARCHAR(255) DEFAULT NULL COMMENT 'Description of the event displayed in console',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_creature`
--

DROP TABLE IF EXISTS `game_event_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_creature` (
  `guid` INT(10) UNSIGNED NOT NULL,
  `event` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Negatives value to remove during event and ignore pool grouping, positive value for spawn during event and if guid is part of pool then al pool memebers must be listed as part of event spawn.',
  PRIMARY KEY (`guid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_creature_data`
--

DROP TABLE IF EXISTS `game_event_creature_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_creature_data` (
  `guid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `entry_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `modelid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `equipment_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spell_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spell_end` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `event` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`event`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_gameobject`
--

DROP TABLE IF EXISTS `game_event_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_gameobject` (
  `guid` INT(10) UNSIGNED NOT NULL,
  `event` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Negatives value to remove during event and ignore pool grouping, positive value for spawn during event and if guid is part of pool then al pool memebers must be listed as part of event spawn.',
  PRIMARY KEY (`guid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_mail`
--

DROP TABLE IF EXISTS `game_event_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_mail` (
  `event` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Negatives value to send at event stop, positive value for send at event start.',
  `raceMask` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `quest` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `mailTemplateId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `senderEntry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`event`,`raceMask`,`quest`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Game event system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_quest`
--

DROP TABLE IF EXISTS `game_event_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_quest` (
  `quest` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'entry from quest_template',
  `event` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'entry from game_event',
  PRIMARY KEY (`quest`,`event`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COMMENT='Game event system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_graveyard_zone`
--

DROP TABLE IF EXISTS `game_graveyard_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_graveyard_zone` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ghost_zone` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `faction` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`ghost_zone`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `game_tele`
--

DROP TABLE IF EXISTS `game_tele`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_tele` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `position_x` FLOAT NOT NULL DEFAULT '0',
  `position_y` FLOAT NOT NULL DEFAULT '0',
  `position_z` FLOAT NOT NULL DEFAULT '0',
  `orientation` FLOAT NOT NULL DEFAULT '0',
  `map` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `name` VARCHAR(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=420 DEFAULT CHARSET=utf8 COMMENT='Tele Command';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_weather`
--

DROP TABLE IF EXISTS `game_weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_weather` (
  `zone` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spring_rain_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `spring_snow_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `spring_storm_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `summer_rain_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `summer_snow_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `summer_storm_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `fall_rain_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `fall_snow_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `fall_storm_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `winter_rain_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `winter_snow_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  `winter_storm_chance` TINYINT(3) UNSIGNED NOT NULL DEFAULT '25',
  PRIMARY KEY (`zone`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Weather System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject`
--

DROP TABLE IF EXISTS `gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject` (
  `guid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier',
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Gameobject Identifier',
  `map` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `position_x` FLOAT NOT NULL DEFAULT '0',
  `position_y` FLOAT NOT NULL DEFAULT '0',
  `position_z` FLOAT NOT NULL DEFAULT '0',
  `orientation` FLOAT NOT NULL DEFAULT '0',
  `rotation0` FLOAT NOT NULL DEFAULT '0',
  `rotation1` FLOAT NOT NULL DEFAULT '0',
  `rotation2` FLOAT NOT NULL DEFAULT '0',
  `rotation3` FLOAT NOT NULL DEFAULT '0',
  `spawntimesecs` INT(11) NOT NULL DEFAULT '0',
  `animprogress` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `state` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `idx_map` (`map`),
  KEY `idx_id` (`id`)
) ENGINE=MYISAM AUTO_INCREMENT=632463 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Gameobject System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_battleground`
--

DROP TABLE IF EXISTS `gameobject_battleground`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_battleground` (
  `guid` INT(10) UNSIGNED NOT NULL COMMENT 'GameObject''s GUID',
  `event1` TINYINT(3) UNSIGNED NOT NULL COMMENT 'main event',
  `event2` TINYINT(3) UNSIGNED NOT NULL COMMENT 'sub event',
  PRIMARY KEY (`guid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='GameObject battleground indexing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_loot_template`
--

DROP TABLE IF EXISTS `gameobject_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_loot_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` FLOAT NOT NULL DEFAULT '100',
  `groupid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `mincountOrRef` MEDIUMINT(9) NOT NULL DEFAULT '1',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_template`
--

DROP TABLE IF EXISTS `gameobject_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `displayId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `name` VARCHAR(100) NOT NULL DEFAULT '',
  `faction` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `flags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `size` FLOAT NOT NULL DEFAULT '1',
  `data0` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data1` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data2` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data3` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data4` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data5` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data6` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data7` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data8` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data9` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data10` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data11` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data12` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data13` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data14` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data15` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data16` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data17` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data18` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data19` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data20` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data21` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data22` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data23` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `mingold` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `maxgold` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Gameobject System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gossip_menu`
--

DROP TABLE IF EXISTS `gossip_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_menu` (
  `entry` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `text_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `script_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'script in `gossip_scripts` - will be executed on GossipHello',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`text_id`,`script_id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gossip_menu_option`
--

DROP TABLE IF EXISTS `gossip_menu_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_menu_option` (
  `menu_id` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `id` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `option_icon` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `option_text` TEXT,
  `option_id` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `npc_option_npcflag` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `action_menu_id` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `action_poi_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `action_script_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `box_coded` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `box_money` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `box_text` TEXT,
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`menu_id`,`id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gossip_texts`
--

DROP TABLE IF EXISTS `gossip_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_texts` (
  `entry` MEDIUMINT(8) NOT NULL,
  `content_default` TEXT NOT NULL,
  `content_loc1` TEXT,
  `content_loc2` TEXT,
  `content_loc3` TEXT,
  `content_loc4` TEXT,
  `content_loc5` TEXT,
  `content_loc6` TEXT,
  `content_loc7` TEXT,
  `content_loc8` TEXT,
  `comment` TEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Gossip Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instance_template`
--

DROP TABLE IF EXISTS `instance_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_template` (
  `map` SMALLINT(5) UNSIGNED NOT NULL,
  `parent` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `levelMin` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `levelMax` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `maxPlayers` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `reset_delay` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Reset time in days',
  `ghostEntranceMap` SMALLINT(5) UNSIGNED NOT NULL,
  `ghostEntranceX` FLOAT NOT NULL,
  `ghostEntranceY` FLOAT NOT NULL,
  PRIMARY KEY (`map`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_enchantment_template`
--

DROP TABLE IF EXISTS `item_enchantment_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_enchantment_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ench` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `chance` FLOAT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`ench`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item Random Enchantment System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_loot_template`
--

DROP TABLE IF EXISTS `item_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_loot_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` FLOAT NOT NULL DEFAULT '100',
  `groupid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `mincountOrRef` MEDIUMINT(9) NOT NULL DEFAULT '1',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_required_target`
--

DROP TABLE IF EXISTS `item_required_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_required_target` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL,
  `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `targetEntry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_type_target` (`entry`,`type`,`targetEntry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_template`
--

DROP TABLE IF EXISTS `item_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `class` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `subclass` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  `displayid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Quality` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `Flags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `BuyCount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `BuyPrice` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `SellPrice` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `InventoryType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `AllowableClass` MEDIUMINT(9) NOT NULL DEFAULT '-1',
  `AllowableRace` MEDIUMINT(9) NOT NULL DEFAULT '-1',
  `ItemLevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredLevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredSkill` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredSkillRank` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `requiredspell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `requiredhonorrank` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredCityRank` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredReputationFaction` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredReputationRank` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `maxcount` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `stackable` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '1',
  `ContainerSlots` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_type1` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value1` SMALLINT(6) NOT NULL DEFAULT '0',
  `stat_type2` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value2` SMALLINT(6) NOT NULL DEFAULT '0',
  `stat_type3` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value3` SMALLINT(6) NOT NULL DEFAULT '0',
  `stat_type4` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value4` SMALLINT(6) NOT NULL DEFAULT '0',
  `stat_type5` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value5` SMALLINT(6) NOT NULL DEFAULT '0',
  `stat_type6` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value6` SMALLINT(6) NOT NULL DEFAULT '0',
  `stat_type7` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value7` SMALLINT(6) NOT NULL DEFAULT '0',
  `stat_type8` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value8` SMALLINT(6) NOT NULL DEFAULT '0',
  `stat_type9` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value9` SMALLINT(6) NOT NULL DEFAULT '0',
  `stat_type10` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `stat_value10` SMALLINT(6) NOT NULL DEFAULT '0',
  `dmg_min1` FLOAT NOT NULL DEFAULT '0',
  `dmg_max1` FLOAT NOT NULL DEFAULT '0',
  `dmg_type1` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `dmg_min2` FLOAT NOT NULL DEFAULT '0',
  `dmg_max2` FLOAT NOT NULL DEFAULT '0',
  `dmg_type2` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `dmg_min3` FLOAT NOT NULL DEFAULT '0',
  `dmg_max3` FLOAT NOT NULL DEFAULT '0',
  `dmg_type3` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `dmg_min4` FLOAT NOT NULL DEFAULT '0',
  `dmg_max4` FLOAT NOT NULL DEFAULT '0',
  `dmg_type4` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `dmg_min5` FLOAT NOT NULL DEFAULT '0',
  `dmg_max5` FLOAT NOT NULL DEFAULT '0',
  `dmg_type5` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `armor` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `holy_res` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `fire_res` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `nature_res` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `frost_res` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `shadow_res` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `arcane_res` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `delay` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '1000',
  `ammo_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `RangedModRange` FLOAT NOT NULL DEFAULT '0',
  `spellid_1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spelltrigger_1` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `spellcharges_1` TINYINT(4) NOT NULL DEFAULT '0',
  `spellppmRate_1` FLOAT NOT NULL DEFAULT '0',
  `spellcooldown_1` INT(11) NOT NULL DEFAULT '-1',
  `spellcategory_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `spellcategorycooldown_1` INT(11) NOT NULL DEFAULT '-1',
  `spellid_2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spelltrigger_2` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `spellcharges_2` TINYINT(4) NOT NULL DEFAULT '0',
  `spellppmRate_2` FLOAT NOT NULL DEFAULT '0',
  `spellcooldown_2` INT(11) NOT NULL DEFAULT '-1',
  `spellcategory_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `spellcategorycooldown_2` INT(11) NOT NULL DEFAULT '-1',
  `spellid_3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spelltrigger_3` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `spellcharges_3` TINYINT(4) NOT NULL DEFAULT '0',
  `spellppmRate_3` FLOAT NOT NULL DEFAULT '0',
  `spellcooldown_3` INT(11) NOT NULL DEFAULT '-1',
  `spellcategory_3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `spellcategorycooldown_3` INT(11) NOT NULL DEFAULT '-1',
  `spellid_4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spelltrigger_4` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `spellcharges_4` TINYINT(4) NOT NULL DEFAULT '0',
  `spellppmRate_4` FLOAT NOT NULL DEFAULT '0',
  `spellcooldown_4` INT(11) NOT NULL DEFAULT '-1',
  `spellcategory_4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `spellcategorycooldown_4` INT(11) NOT NULL DEFAULT '-1',
  `spellid_5` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spelltrigger_5` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `spellcharges_5` TINYINT(4) NOT NULL DEFAULT '0',
  `spellppmRate_5` FLOAT NOT NULL DEFAULT '0',
  `spellcooldown_5` INT(11) NOT NULL DEFAULT '-1',
  `spellcategory_5` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `spellcategorycooldown_5` INT(11) NOT NULL DEFAULT '-1',
  `bonding` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `description` VARCHAR(255) NOT NULL DEFAULT '',
  `PageText` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `LanguageID` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `PageMaterial` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `startquest` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `lockid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Material` TINYINT(4) NOT NULL DEFAULT '0',
  `sheath` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `RandomProperty` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `block` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `itemset` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `MaxDurability` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `area` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Map` SMALLINT(6) NOT NULL DEFAULT '0',
  `BagFamily` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `DisenchantID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `FoodType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `minMoneyLoot` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxMoneyLoot` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `Duration` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Duration in seconds',
  `ExtraFlags` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`),
  KEY `items_index` (`class`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_creature`
--

DROP TABLE IF EXISTS `locales_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_creature` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `name_loc1` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc2` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc3` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc4` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc5` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc6` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc7` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc8` VARCHAR(100) NOT NULL DEFAULT '',
  `subname_loc1` VARCHAR(100) DEFAULT NULL,
  `subname_loc2` VARCHAR(100) DEFAULT NULL,
  `subname_loc3` VARCHAR(100) DEFAULT NULL,
  `subname_loc4` VARCHAR(100) DEFAULT NULL,
  `subname_loc5` VARCHAR(100) DEFAULT NULL,
  `subname_loc6` VARCHAR(100) DEFAULT NULL,
  `subname_loc7` VARCHAR(100) DEFAULT NULL,
  `subname_loc8` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_gameobject`
--

DROP TABLE IF EXISTS `locales_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_gameobject` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `name_loc1` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc2` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc3` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc4` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc5` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc6` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc7` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc8` VARCHAR(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_gossip_menu_option`
--

DROP TABLE IF EXISTS `locales_gossip_menu_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_gossip_menu_option` (
  `menu_id` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `id` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `option_text_loc1` TEXT,
  `option_text_loc2` TEXT,
  `option_text_loc3` TEXT,
  `option_text_loc4` TEXT,
  `option_text_loc5` TEXT,
  `option_text_loc6` TEXT,
  `option_text_loc7` TEXT,
  `option_text_loc8` TEXT,
  `box_text_loc1` TEXT,
  `box_text_loc2` TEXT,
  `box_text_loc3` TEXT,
  `box_text_loc4` TEXT,
  `box_text_loc5` TEXT,
  `box_text_loc6` TEXT,
  `box_text_loc7` TEXT,
  `box_text_loc8` TEXT,
  PRIMARY KEY (`menu_id`,`id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_item`
--

DROP TABLE IF EXISTS `locales_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_item` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `name_loc1` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc2` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc3` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc4` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc5` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc6` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc7` VARCHAR(100) NOT NULL DEFAULT '',
  `name_loc8` VARCHAR(100) NOT NULL DEFAULT '',
  `description_loc1` VARCHAR(255) DEFAULT NULL,
  `description_loc2` VARCHAR(255) DEFAULT NULL,
  `description_loc3` VARCHAR(255) DEFAULT NULL,
  `description_loc4` VARCHAR(255) DEFAULT NULL,
  `description_loc5` VARCHAR(255) DEFAULT NULL,
  `description_loc6` VARCHAR(255) DEFAULT NULL,
  `description_loc7` VARCHAR(255) DEFAULT NULL,
  `description_loc8` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_npc_text`
--

DROP TABLE IF EXISTS `locales_npc_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_npc_text` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Text0_0_loc1` LONGTEXT,
  `Text0_0_loc2` LONGTEXT,
  `Text0_0_loc3` LONGTEXT,
  `Text0_0_loc4` LONGTEXT,
  `Text0_0_loc5` LONGTEXT,
  `Text0_0_loc6` LONGTEXT,
  `Text0_0_loc7` LONGTEXT,
  `Text0_0_loc8` LONGTEXT,
  `Text0_1_loc1` LONGTEXT,
  `Text0_1_loc2` LONGTEXT,
  `Text0_1_loc3` LONGTEXT,
  `Text0_1_loc4` LONGTEXT,
  `Text0_1_loc5` LONGTEXT,
  `Text0_1_loc6` LONGTEXT,
  `Text0_1_loc7` LONGTEXT,
  `Text0_1_loc8` LONGTEXT,
  `Text1_0_loc1` LONGTEXT,
  `Text1_0_loc2` LONGTEXT,
  `Text1_0_loc3` LONGTEXT,
  `Text1_0_loc4` LONGTEXT,
  `Text1_0_loc5` LONGTEXT,
  `Text1_0_loc6` LONGTEXT,
  `Text1_0_loc7` LONGTEXT,
  `Text1_0_loc8` LONGTEXT,
  `Text1_1_loc1` LONGTEXT,
  `Text1_1_loc2` LONGTEXT,
  `Text1_1_loc3` LONGTEXT,
  `Text1_1_loc4` LONGTEXT,
  `Text1_1_loc5` LONGTEXT,
  `Text1_1_loc6` LONGTEXT,
  `Text1_1_loc7` LONGTEXT,
  `Text1_1_loc8` LONGTEXT,
  `Text2_0_loc1` LONGTEXT,
  `Text2_0_loc2` LONGTEXT,
  `Text2_0_loc3` LONGTEXT,
  `Text2_0_loc4` LONGTEXT,
  `Text2_0_loc5` LONGTEXT,
  `Text2_0_loc6` LONGTEXT,
  `Text2_0_loc7` LONGTEXT,
  `Text2_0_loc8` LONGTEXT,
  `Text2_1_loc1` LONGTEXT,
  `Text2_1_loc2` LONGTEXT,
  `Text2_1_loc3` LONGTEXT,
  `Text2_1_loc4` LONGTEXT,
  `Text2_1_loc5` LONGTEXT,
  `Text2_1_loc6` LONGTEXT,
  `Text2_1_loc7` LONGTEXT,
  `Text2_1_loc8` LONGTEXT,
  `Text3_0_loc1` LONGTEXT,
  `Text3_0_loc2` LONGTEXT,
  `Text3_0_loc3` LONGTEXT,
  `Text3_0_loc4` LONGTEXT,
  `Text3_0_loc5` LONGTEXT,
  `Text3_0_loc6` LONGTEXT,
  `Text3_0_loc7` LONGTEXT,
  `Text3_0_loc8` LONGTEXT,
  `Text3_1_loc1` LONGTEXT,
  `Text3_1_loc2` LONGTEXT,
  `Text3_1_loc3` LONGTEXT,
  `Text3_1_loc4` LONGTEXT,
  `Text3_1_loc5` LONGTEXT,
  `Text3_1_loc6` LONGTEXT,
  `Text3_1_loc7` LONGTEXT,
  `Text3_1_loc8` LONGTEXT,
  `Text4_0_loc1` LONGTEXT,
  `Text4_0_loc2` LONGTEXT,
  `Text4_0_loc3` LONGTEXT,
  `Text4_0_loc4` LONGTEXT,
  `Text4_0_loc5` LONGTEXT,
  `Text4_0_loc6` LONGTEXT,
  `Text4_0_loc7` LONGTEXT,
  `Text4_0_loc8` LONGTEXT,
  `Text4_1_loc1` LONGTEXT,
  `Text4_1_loc2` LONGTEXT,
  `Text4_1_loc3` LONGTEXT,
  `Text4_1_loc4` LONGTEXT,
  `Text4_1_loc5` LONGTEXT,
  `Text4_1_loc6` LONGTEXT,
  `Text4_1_loc7` LONGTEXT,
  `Text4_1_loc8` LONGTEXT,
  `Text5_0_loc1` LONGTEXT,
  `Text5_0_loc2` LONGTEXT,
  `Text5_0_loc3` LONGTEXT,
  `Text5_0_loc4` LONGTEXT,
  `Text5_0_loc5` LONGTEXT,
  `Text5_0_loc6` LONGTEXT,
  `Text5_0_loc7` LONGTEXT,
  `Text5_0_loc8` LONGTEXT,
  `Text5_1_loc1` LONGTEXT,
  `Text5_1_loc2` LONGTEXT,
  `Text5_1_loc3` LONGTEXT,
  `Text5_1_loc4` LONGTEXT,
  `Text5_1_loc5` LONGTEXT,
  `Text5_1_loc6` LONGTEXT,
  `Text5_1_loc7` LONGTEXT,
  `Text5_1_loc8` LONGTEXT,
  `Text6_0_loc1` LONGTEXT,
  `Text6_0_loc2` LONGTEXT,
  `Text6_0_loc3` LONGTEXT,
  `Text6_0_loc4` LONGTEXT,
  `Text6_0_loc5` LONGTEXT,
  `Text6_0_loc6` LONGTEXT,
  `Text6_0_loc7` LONGTEXT,
  `Text6_0_loc8` LONGTEXT,
  `Text6_1_loc1` LONGTEXT,
  `Text6_1_loc2` LONGTEXT,
  `Text6_1_loc3` LONGTEXT,
  `Text6_1_loc4` LONGTEXT,
  `Text6_1_loc5` LONGTEXT,
  `Text6_1_loc6` LONGTEXT,
  `Text6_1_loc7` LONGTEXT,
  `Text6_1_loc8` LONGTEXT,
  `Text7_0_loc1` LONGTEXT,
  `Text7_0_loc2` LONGTEXT,
  `Text7_0_loc3` LONGTEXT,
  `Text7_0_loc4` LONGTEXT,
  `Text7_0_loc5` LONGTEXT,
  `Text7_0_loc6` LONGTEXT,
  `Text7_0_loc7` LONGTEXT,
  `Text7_0_loc8` LONGTEXT,
  `Text7_1_loc1` LONGTEXT,
  `Text7_1_loc2` LONGTEXT,
  `Text7_1_loc3` LONGTEXT,
  `Text7_1_loc4` LONGTEXT,
  `Text7_1_loc5` LONGTEXT,
  `Text7_1_loc6` LONGTEXT,
  `Text7_1_loc7` LONGTEXT,
  `Text7_1_loc8` LONGTEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_page_text`
--

DROP TABLE IF EXISTS `locales_page_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_page_text` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Text_loc1` LONGTEXT,
  `Text_loc2` LONGTEXT,
  `Text_loc3` LONGTEXT,
  `Text_loc4` LONGTEXT,
  `Text_loc5` LONGTEXT,
  `Text_loc6` LONGTEXT,
  `Text_loc7` LONGTEXT,
  `Text_loc8` LONGTEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_points_of_interest`
--

DROP TABLE IF EXISTS `locales_points_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_points_of_interest` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `icon_name_loc1` TEXT,
  `icon_name_loc2` TEXT,
  `icon_name_loc3` TEXT,
  `icon_name_loc4` TEXT,
  `icon_name_loc5` TEXT,
  `icon_name_loc6` TEXT,
  `icon_name_loc7` TEXT,
  `icon_name_loc8` TEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_quest`
--

DROP TABLE IF EXISTS `locales_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_quest` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Title_loc1` TEXT,
  `Title_loc2` TEXT,
  `Title_loc3` TEXT,
  `Title_loc4` TEXT,
  `Title_loc5` TEXT,
  `Title_loc6` TEXT,
  `Title_loc7` TEXT,
  `Title_loc8` TEXT,
  `Details_loc1` TEXT,
  `Details_loc2` TEXT,
  `Details_loc3` TEXT,
  `Details_loc4` TEXT,
  `Details_loc5` TEXT,
  `Details_loc6` TEXT,
  `Details_loc7` TEXT,
  `Details_loc8` TEXT,
  `Objectives_loc1` TEXT,
  `Objectives_loc2` TEXT,
  `Objectives_loc3` TEXT,
  `Objectives_loc4` TEXT,
  `Objectives_loc5` TEXT,
  `Objectives_loc6` TEXT,
  `Objectives_loc7` TEXT,
  `Objectives_loc8` TEXT,
  `OfferRewardText_loc1` TEXT,
  `OfferRewardText_loc2` TEXT,
  `OfferRewardText_loc3` TEXT,
  `OfferRewardText_loc4` TEXT,
  `OfferRewardText_loc5` TEXT,
  `OfferRewardText_loc6` TEXT,
  `OfferRewardText_loc7` TEXT,
  `OfferRewardText_loc8` TEXT,
  `RequestItemsText_loc1` TEXT,
  `RequestItemsText_loc2` TEXT,
  `RequestItemsText_loc3` TEXT,
  `RequestItemsText_loc4` TEXT,
  `RequestItemsText_loc5` TEXT,
  `RequestItemsText_loc6` TEXT,
  `RequestItemsText_loc7` TEXT,
  `RequestItemsText_loc8` TEXT,
  `EndText_loc1` TEXT,
  `EndText_loc2` TEXT,
  `EndText_loc3` TEXT,
  `EndText_loc4` TEXT,
  `EndText_loc5` TEXT,
  `EndText_loc6` TEXT,
  `EndText_loc7` TEXT,
  `EndText_loc8` TEXT,
  `ObjectiveText1_loc1` TEXT,
  `ObjectiveText1_loc2` TEXT,
  `ObjectiveText1_loc3` TEXT,
  `ObjectiveText1_loc4` TEXT,
  `ObjectiveText1_loc5` TEXT,
  `ObjectiveText1_loc6` TEXT,
  `ObjectiveText1_loc7` TEXT,
  `ObjectiveText1_loc8` TEXT,
  `ObjectiveText2_loc1` TEXT,
  `ObjectiveText2_loc2` TEXT,
  `ObjectiveText2_loc3` TEXT,
  `ObjectiveText2_loc4` TEXT,
  `ObjectiveText2_loc5` TEXT,
  `ObjectiveText2_loc6` TEXT,
  `ObjectiveText2_loc7` TEXT,
  `ObjectiveText2_loc8` TEXT,
  `ObjectiveText3_loc1` TEXT,
  `ObjectiveText3_loc2` TEXT,
  `ObjectiveText3_loc3` TEXT,
  `ObjectiveText3_loc4` TEXT,
  `ObjectiveText3_loc5` TEXT,
  `ObjectiveText3_loc6` TEXT,
  `ObjectiveText3_loc7` TEXT,
  `ObjectiveText3_loc8` TEXT,
  `ObjectiveText4_loc1` TEXT,
  `ObjectiveText4_loc2` TEXT,
  `ObjectiveText4_loc3` TEXT,
  `ObjectiveText4_loc4` TEXT,
  `ObjectiveText4_loc5` TEXT,
  `ObjectiveText4_loc6` TEXT,
  `ObjectiveText4_loc7` TEXT,
  `ObjectiveText4_loc8` TEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_loot_template`
--

DROP TABLE IF EXISTS `mail_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_loot_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` FLOAT NOT NULL DEFAULT '100',
  `groupid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `mincountOrRef` MEDIUMINT(9) NOT NULL DEFAULT '1',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mangos_string`
--

DROP TABLE IF EXISTS `mangos_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mangos_string` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `content_default` TEXT NOT NULL,
  `content_loc1` TEXT,
  `content_loc2` TEXT,
  `content_loc3` TEXT,
  `content_loc4` TEXT,
  `content_loc5` TEXT,
  `content_loc6` TEXT,
  `content_loc7` TEXT,
  `content_loc8` TEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `npc_gossip`
--

DROP TABLE IF EXISTS `npc_gossip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_gossip` (
  `npc_guid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `textid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`npc_guid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_text`
--

DROP TABLE IF EXISTS `npc_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_text` (
  `ID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `text0_0` LONGTEXT,
  `text0_1` LONGTEXT,
  `lang0` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `prob0` FLOAT NOT NULL DEFAULT '0',
  `em0_0_delay` SMALLINT(5) DEFAULT NULL,
  `em0_0` SMALLINT(5) DEFAULT NULL,
  `em0_1_delay` SMALLINT(5) DEFAULT NULL,
  `em0_1` SMALLINT(5) DEFAULT NULL,
  `em0_2_delay` SMALLINT(5) DEFAULT NULL,
  `em0_2` SMALLINT(5) DEFAULT NULL,
  `text1_0` LONGTEXT,
  `text1_1` LONGTEXT,
  `lang1` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `prob1` FLOAT NOT NULL DEFAULT '0',
  `em1_0_delay` SMALLINT(5) DEFAULT NULL,
  `em1_0` SMALLINT(5) DEFAULT NULL,
  `em1_1_delay` SMALLINT(5) DEFAULT NULL,
  `em1_1` SMALLINT(5) DEFAULT NULL,
  `em1_2_delay` SMALLINT(5) DEFAULT NULL,
  `em1_2` SMALLINT(5) DEFAULT NULL,
  `text2_0` LONGTEXT,
  `text2_1` LONGTEXT,
  `lang2` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `prob2` FLOAT NOT NULL DEFAULT '0',
  `em2_0_delay` SMALLINT(5) DEFAULT NULL,
  `em2_0` SMALLINT(5) DEFAULT NULL,
  `em2_1_delay` SMALLINT(5) DEFAULT NULL,
  `em2_1` SMALLINT(5) DEFAULT NULL,
  `em2_2_delay` SMALLINT(5) DEFAULT NULL,
  `em2_2` SMALLINT(5) DEFAULT NULL,
  `text3_0` LONGTEXT,
  `text3_1` LONGTEXT,
  `lang3` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `prob3` FLOAT NOT NULL DEFAULT '0',
  `em3_0_delay` SMALLINT(5) DEFAULT NULL,
  `em3_0` SMALLINT(5) DEFAULT NULL,
  `em3_1_delay` SMALLINT(5) DEFAULT NULL,
  `em3_1` SMALLINT(5) DEFAULT NULL,
  `em3_2_delay` SMALLINT(5) DEFAULT NULL,
  `em3_2` SMALLINT(5) DEFAULT NULL,
  `text4_0` LONGTEXT,
  `text4_1` LONGTEXT,
  `lang4` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `prob4` FLOAT NOT NULL DEFAULT '0',
  `em4_0_delay` SMALLINT(5) DEFAULT NULL,
  `em4_0` SMALLINT(5) DEFAULT NULL,
  `em4_1_delay` SMALLINT(5) DEFAULT NULL,
  `em4_1` SMALLINT(5) DEFAULT NULL,
  `em4_2_delay` SMALLINT(5) DEFAULT NULL,
  `em4_2` SMALLINT(5) DEFAULT NULL,
  `text5_0` LONGTEXT,
  `text5_1` LONGTEXT,
  `lang5` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `prob5` FLOAT NOT NULL DEFAULT '0',
  `em5_0_delay` SMALLINT(5) DEFAULT NULL,
  `em5_0` SMALLINT(5) DEFAULT NULL,
  `em5_1_delay` SMALLINT(5) DEFAULT NULL,
  `em5_1` SMALLINT(5) DEFAULT NULL,
  `em5_2_delay` SMALLINT(5) DEFAULT NULL,
  `em5_2` SMALLINT(5) DEFAULT NULL,
  `text6_0` LONGTEXT,
  `text6_1` LONGTEXT,
  `lang6` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `prob6` FLOAT NOT NULL DEFAULT '0',
  `em6_0_delay` SMALLINT(5) DEFAULT NULL,
  `em6_0` SMALLINT(5) DEFAULT NULL,
  `em6_1_delay` SMALLINT(5) DEFAULT NULL,
  `em6_1` SMALLINT(5) DEFAULT NULL,
  `em6_2_delay` SMALLINT(5) DEFAULT NULL,
  `em6_2` SMALLINT(5) DEFAULT NULL,
  `text7_0` LONGTEXT,
  `text7_1` LONGTEXT,
  `lang7` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `prob7` FLOAT NOT NULL DEFAULT '0',
  `em7_0_delay` SMALLINT(5) DEFAULT NULL,
  `em7_0` SMALLINT(5) DEFAULT NULL,
  `em7_1_delay` SMALLINT(5) DEFAULT NULL,
  `em7_1` SMALLINT(5) DEFAULT NULL,
  `em7_2_delay` SMALLINT(5) DEFAULT NULL,
  `em7_2` SMALLINT(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_trainer`
--

DROP TABLE IF EXISTS `npc_trainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_trainer` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spellcost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `reqskill` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `reqskillvalue` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `reqlevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_spell` (`entry`,`spell`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_trainer_template`
--

DROP TABLE IF EXISTS `npc_trainer_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_trainer_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `spellcost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `reqskill` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `reqskillvalue` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `reqlevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_spell` (`entry`,`spell`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_vendor`
--

DROP TABLE IF EXISTS `npc_vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_vendor` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `incrtime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Npc System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_vendor_template`
--

DROP TABLE IF EXISTS `npc_vendor_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_vendor_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `incrtime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Npc System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_text`
--

DROP TABLE IF EXISTS `page_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_text` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `text` LONGTEXT NOT NULL,
  `next_page` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_levelstats`
--

DROP TABLE IF EXISTS `pet_levelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_levelstats` (
  `creature_entry` MEDIUMINT(8) UNSIGNED NOT NULL,
  `level` TINYINT(3) UNSIGNED NOT NULL,
  `hp` SMALLINT(5) UNSIGNED NOT NULL,
  `mana` SMALLINT(5) UNSIGNED NOT NULL,
  `armor` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `str` SMALLINT(5) UNSIGNED NOT NULL,
  `agi` SMALLINT(5) UNSIGNED NOT NULL,
  `sta` SMALLINT(5) UNSIGNED NOT NULL,
  `inte` SMALLINT(5) UNSIGNED NOT NULL,
  `spi` SMALLINT(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`creature_entry`,`level`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores pet levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_name_generation`
--

DROP TABLE IF EXISTS `pet_name_generation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_name_generation` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `word` TINYTEXT NOT NULL,
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `half` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM AUTO_INCREMENT=261 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `petcreateinfo_spell`
--

DROP TABLE IF EXISTS `petcreateinfo_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `petcreateinfo_spell` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Spell1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Spell2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Spell3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Spell4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Pet Create Spells';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pickpocketing_loot_template`
--

DROP TABLE IF EXISTS `pickpocketing_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pickpocketing_loot_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` FLOAT NOT NULL DEFAULT '100',
  `groupid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `mincountOrRef` MEDIUMINT(9) NOT NULL DEFAULT '1',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_classlevelstats`
--

DROP TABLE IF EXISTS `player_classlevelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_classlevelstats` (
  `class` TINYINT(3) UNSIGNED NOT NULL,
  `level` TINYINT(3) UNSIGNED NOT NULL,
  `basehp` SMALLINT(5) UNSIGNED NOT NULL,
  `basemana` SMALLINT(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`class`,`level`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_levelstats`
--

DROP TABLE IF EXISTS `player_levelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_levelstats` (
  `race` TINYINT(3) UNSIGNED NOT NULL,
  `class` TINYINT(3) UNSIGNED NOT NULL,
  `level` TINYINT(3) UNSIGNED NOT NULL,
  `str` TINYINT(3) UNSIGNED NOT NULL,
  `agi` TINYINT(3) UNSIGNED NOT NULL,
  `sta` TINYINT(3) UNSIGNED NOT NULL,
  `inte` TINYINT(3) UNSIGNED NOT NULL,
  `spi` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`race`,`class`,`level`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_xp_for_level`
--

DROP TABLE IF EXISTS `player_xp_for_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_xp_for_level` (
  `lvl` INT(3) UNSIGNED NOT NULL,
  `xp_for_next_level` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`lvl`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playercreateinfo`
--

DROP TABLE IF EXISTS `playercreateinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo` (
  `race` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `class` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `map` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `zone` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `position_x` FLOAT NOT NULL DEFAULT '0',
  `position_y` FLOAT NOT NULL DEFAULT '0',
  `position_z` FLOAT NOT NULL DEFAULT '0',
  `orientation` FLOAT NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `playercreateinfo_action`
--

DROP TABLE IF EXISTS `playercreateinfo_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_action` (
  `race` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `class` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `button` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `action` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `type` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`,`button`),
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `playercreateinfo_item`
--

DROP TABLE IF EXISTS `playercreateinfo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_item` (
  `race` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `class` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `itemid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `amount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playercreateinfo_spell`
--

DROP TABLE IF EXISTS `playercreateinfo_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_spell` (
  `race` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `class` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `Spell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Note` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`race`,`class`,`Spell`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `points_of_interest`
--

DROP TABLE IF EXISTS `points_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `points_of_interest` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `x` FLOAT NOT NULL DEFAULT '0',
  `y` FLOAT NOT NULL DEFAULT '0',
  `icon` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `flags` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `data` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `icon_name` TEXT NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_creature`
--

DROP TABLE IF EXISTS `pool_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_creature` (
  `guid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `pool_entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `chance` FLOAT UNSIGNED NOT NULL DEFAULT '0',
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_creature_template`
--

DROP TABLE IF EXISTS `pool_creature_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_creature_template` (
  `id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `pool_entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `chance` FLOAT UNSIGNED NOT NULL DEFAULT '0',
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_gameobject`
--

DROP TABLE IF EXISTS `pool_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_gameobject` (
  `guid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `pool_entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `chance` FLOAT UNSIGNED NOT NULL DEFAULT '0',
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_gameobject_template`
--

DROP TABLE IF EXISTS `pool_gameobject_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_gameobject_template` (
  `id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `pool_entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `chance` FLOAT UNSIGNED NOT NULL DEFAULT '0',
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_pool`
--

DROP TABLE IF EXISTS `pool_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_pool` (
  `pool_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `mother_pool` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `chance` FLOAT NOT NULL DEFAULT '0',
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`pool_id`),
  KEY `pool_idx` (`mother_pool`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_template`
--

DROP TABLE IF EXISTS `pool_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Pool entry',
  `max_limit` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Max number of objects (0) is no limit',
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quest_relations`
--

DROP TABLE IF EXISTS `quest_relations`;

CREATE TABLE `quest_relations` (
  `actor` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Entity involved in quest: 0 - Creature, 1 - GameObject, 2 - Area trigger',
  `entry` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Creature or GO entry from *_template, AreaTrigger ID',
  `quest` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quest ID from quest_template',
  `role` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Role of the actor: 0 - starts the quest, 1 - ends the quest (unused for actor = 2)',
  PRIMARY KEY (`entry`, `quest`, `role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `quest_template`
--

DROP TABLE IF EXISTS `quest_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Method` TINYINT(3) UNSIGNED NOT NULL DEFAULT '2',
  `ZoneOrSort` SMALLINT(6) NOT NULL DEFAULT '0',
  `MinLevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `QuestLevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `Type` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredClasses` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredRaces` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredSkill` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredSkillValue` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RepObjectiveFaction` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RepObjectiveValue` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `RequiredMinRepFaction` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredMinRepValue` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `RequiredMaxRepFaction` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RequiredMaxRepValue` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `SuggestedPlayers` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `LimitTime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `QuestFlags` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `SpecialFlags` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `PrevQuestId` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `NextQuestId` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `ExclusiveGroup` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `NextQuestInChain` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `SrcItemId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `SrcItemCount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `SrcSpell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Title` TEXT,
  `Details` TEXT,
  `Objectives` TEXT,
  `OfferRewardText` TEXT,
  `RequestItemsText` TEXT,
  `EndText` TEXT,
  `ObjectiveText1` TEXT,
  `ObjectiveText2` TEXT,
  `ObjectiveText3` TEXT,
  `ObjectiveText4` TEXT,
  `ReqItemId1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqItemId2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqItemId3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqItemId4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqItemCount1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqItemCount2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqItemCount3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqItemCount4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSourceId1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSourceId2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSourceId3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSourceId4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSourceCount1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSourceCount2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSourceCount3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSourceCount4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId1` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId2` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId3` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId4` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSpellCast1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSpellCast2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSpellCast3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ReqSpellCast4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemId1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemId2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemId3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemId4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemId5` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemId6` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemCount1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemCount2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemCount3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemCount4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemCount5` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewChoiceItemCount6` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewItemId1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewItemId2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewItemId3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewItemId4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewItemCount1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewItemCount2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewItemCount3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewItemCount4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `RewRepFaction1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction5` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepValue1` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `RewRepValue2` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `RewRepValue3` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `RewRepValue4` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `RewRepValue5` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `RewOrReqMoney` INT(11) NOT NULL DEFAULT '0',
  `RewMoneyMaxLevel` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `RewSpell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewSpellCast` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewMailTemplateId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `RewMailDelaySecs` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `PointMapId` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `PointX` FLOAT NOT NULL DEFAULT '0',
  `PointY` FLOAT NOT NULL DEFAULT '0',
  `PointOpt` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `DetailsEmote1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `DetailsEmote2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `DetailsEmote3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `DetailsEmote4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `DetailsEmoteDelay1` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `DetailsEmoteDelay2` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `DetailsEmoteDelay3` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `DetailsEmoteDelay4` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `IncompleteEmote` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `CompleteEmote` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `OfferRewardEmote1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `OfferRewardEmote2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `OfferRewardEmote3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `OfferRewardEmote4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay1` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay2` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay3` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay4` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `StartScript` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `CompleteScript` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COMMENT='Quest System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reference_loot_template`
--

DROP TABLE IF EXISTS `reference_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_loot_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` FLOAT NOT NULL DEFAULT '100',
  `groupid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `mincountOrRef` MEDIUMINT(9) NOT NULL DEFAULT '1',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reputation_reward_rate`
--

DROP TABLE IF EXISTS `reputation_reward_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reputation_reward_rate` (
  `faction` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `quest_rate` FLOAT NOT NULL DEFAULT '1',
  `creature_rate` FLOAT NOT NULL DEFAULT '1',
  `spell_rate` FLOAT NOT NULL DEFAULT '1',
  PRIMARY KEY (`faction`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reputation_spillover_template`
--

DROP TABLE IF EXISTS `reputation_spillover_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reputation_spillover_template` (
  `faction` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'faction entry',
  `faction1` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'faction to give spillover for',
  `rate_1` FLOAT NOT NULL DEFAULT '0' COMMENT 'the given rep points * rate',
  `rank_1` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'max rank, above this will not give any spillover',
  `faction2` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `rate_2` FLOAT NOT NULL DEFAULT '0',
  `rank_2` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `faction3` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `rate_3` FLOAT NOT NULL DEFAULT '0',
  `rank_3` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `faction4` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `rate_4` FLOAT NOT NULL DEFAULT '0',
  `rank_4` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`faction`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Reputation spillover reputation gain';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reserved_name`
--

DROP TABLE IF EXISTS `reserved_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserved_name` (
  `name` VARCHAR(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player Reserved Names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `script_binding`
--

DROP TABLE IF EXISTS `script_binding`;

CREATE TABLE `script_binding` (
  `type` TINYINT(2) UNSIGNED NOT NULL COMMENT 'enum ScriptedObjectType',
  `ScriptName` CHAR(64) NOT NULL COMMENT 'Script name, to be unique across all types',
  `bind` MEDIUMINT(10) NOT NULL COMMENT 'Bound to entry (>0) or GUID (<0)',
  `data` TINYINT(2) UNSIGNED DEFAULT '0' COMMENT 'Misc data; Effect number for spellscripts',
  PRIMARY KEY (`ScriptName`,`bind`),
  KEY `type` (`type`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='SD2 Script Names and Binding';

--
-- Table structure for table `script_texts`
--

DROP TABLE IF EXISTS `script_texts`;

CREATE TABLE `script_texts` (
  `entry` MEDIUMINT(8) NOT NULL,
  `content_default` TEXT NOT NULL,
  `content_loc1` TEXT,
  `content_loc2` TEXT,
  `content_loc3` TEXT,
  `content_loc4` TEXT,
  `content_loc5` TEXT,
  `content_loc6` TEXT,
  `content_loc7` TEXT,
  `content_loc8` TEXT,
  `sound` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `language` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `emote` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `comment` TEXT,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Script Texts';

--
-- Table structure for table `script_waypoint`
--

DROP TABLE IF EXISTS `script_waypoint`;

CREATE TABLE `script_waypoint` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'creature_template entry',
  `pointid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `location_x` FLOAT NOT NULL DEFAULT '0',
  `location_y` FLOAT NOT NULL DEFAULT '0',
  `location_z` FLOAT NOT NULL DEFAULT '0',
  `waittime` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'waittime in millisecs',
  `point_comment` TEXT,
  PRIMARY KEY (`entry`,`pointid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Script Creature waypoints';


--
-- Table structure for table `skill_fishing_base_level`
--

DROP TABLE IF EXISTS `skill_fishing_base_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_fishing_base_level` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Area identifier',
  `skill` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Base skill level requirement',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Fishing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skinning_loot_template`
--

DROP TABLE IF EXISTS `skinning_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skinning_loot_template` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `item` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` FLOAT NOT NULL DEFAULT '100',
  `groupid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `mincountOrRef` MEDIUMINT(9) NOT NULL DEFAULT '1',
  `maxcount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_affect`
--

DROP TABLE IF EXISTS `spell_affect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_affect` (
  `entry` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `effectId` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `SpellFamilyMask` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`effectId`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `spell_area`
--

DROP TABLE IF EXISTS `spell_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_area` (
  `spell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `area` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `quest_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `quest_start_active` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `quest_end` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `condition_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `aura_spell` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `racemask` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `gender` TINYINT(1) UNSIGNED NOT NULL DEFAULT '2',
  `autocast` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`spell`,`area`,`quest_start`,`quest_start_active`,`aura_spell`,`racemask`,`gender`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_bonus_data`
--

DROP TABLE IF EXISTS `spell_bonus_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_bonus_data` (
  `entry` SMALLINT(5) UNSIGNED NOT NULL,
  `direct_bonus` FLOAT NOT NULL DEFAULT '0',
  `one_hand_direct_bonus` FLOAT NOT NULL DEFAULT '0',
  `two_hand_direct_bonus` FLOAT NOT NULL DEFAULT '0',
  `direct_bonus_done` FLOAT NOT NULL DEFAULT '0',
  `one_hand_direct_bonus_done` FLOAT NOT NULL DEFAULT '0',
  `two_hand_direct_bonus_done` FLOAT NOT NULL DEFAULT '0',
  `direct_bonus_taken` FLOAT NOT NULL DEFAULT '0',
  `one_hand_direct_bonus_taken` FLOAT NOT NULL DEFAULT '0',
  `two_hand_direct_bonus_taken` FLOAT NOT NULL DEFAULT '0',
  `dot_bonus` FLOAT NOT NULL DEFAULT '0',
  `ap_bonus` FLOAT NOT NULL DEFAULT '0',
  `ap_dot_bonus` FLOAT NOT NULL DEFAULT '0',
  `comments` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_chain`
--

DROP TABLE IF EXISTS `spell_chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_chain` (
  `spell_id` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `prev_spell` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `first_spell` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `rank` TINYINT(4) NOT NULL DEFAULT '0',
  `req_spell` MEDIUMINT(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`spell_id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Spell Additinal Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_elixir`
--

DROP TABLE IF EXISTS `spell_elixir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_elixir` (
  `entry` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'SpellId of potion',
  `mask` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Mask 0x1 battle 0x2 guardian 0x3 flask 0x7 unstable flasks 0xB shattrath flasks',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_facing`
--

DROP TABLE IF EXISTS `spell_facing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_facing` (
  `entry` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Spell ID',
  `facingcasterflag` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'flag for facing state, usually 1',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_learn_spell`
--

DROP TABLE IF EXISTS `spell_learn_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_learn_spell` (
  `entry` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `SpellID` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `Active` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`entry`,`SpellID`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_linked`
--

DROP TABLE IF EXISTS `spell_linked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_linked` (
  `entry` INT(10) UNSIGNED NOT NULL COMMENT 'Spell entry',
  `linked_entry` INT(10) UNSIGNED NOT NULL COMMENT 'Linked spell entry',
  `type` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Type of link',
  `effect_mask` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'mask of effect (NY)',
  `comment` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`,`linked_entry`,`type`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Linked spells storage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_pet_auras`
--

DROP TABLE IF EXISTS `spell_pet_auras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_pet_auras` (
  `spell` MEDIUMINT(8) UNSIGNED NOT NULL COMMENT 'dummy spell id',
  `pet` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'pet id; 0 = all',
  `aura` MEDIUMINT(8) UNSIGNED NOT NULL COMMENT 'pet aura id',
  PRIMARY KEY (`spell`,`pet`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_proc_event`
--

DROP TABLE IF EXISTS `spell_proc_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_proc_event` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `SchoolMask` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0',
  `SpellFamilyName` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `SpellFamilyMask0` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0',
  `SpellFamilyMask1` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0',
  `SpellFamilyMask2` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0',
  `procFlags` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `procEx` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `ppmRate` FLOAT NOT NULL DEFAULT '0',
  `CustomChance` FLOAT NOT NULL DEFAULT '0',
  `Cooldown` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_proc_item_enchant`
--

DROP TABLE IF EXISTS `spell_proc_item_enchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_proc_item_enchant` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL,
  `ppmRate` FLOAT NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_script_target`
--

DROP TABLE IF EXISTS `spell_script_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_script_target` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL,
  `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `targetEntry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `inverseEffectMask` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_type_target` (`entry`,`type`,`targetEntry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_target_position`
--

DROP TABLE IF EXISTS `spell_target_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_target_position` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `target_map` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `target_position_x` FLOAT NOT NULL DEFAULT '0',
  `target_position_y` FLOAT NOT NULL DEFAULT '0',
  `target_position_z` FLOAT NOT NULL DEFAULT '0',
  `target_orientation` FLOAT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_threat`
--

DROP TABLE IF EXISTS `spell_threat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_threat` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL,
  `Threat` SMALLINT(6) NOT NULL,
  `multiplier` FLOAT NOT NULL DEFAULT '1' COMMENT 'threat multiplier for damage/healing',
  `ap_bonus` FLOAT NOT NULL DEFAULT '0' COMMENT 'additional threat bonus from attack power',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transports`
--

DROP TABLE IF EXISTS `transports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transports` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `name` TEXT,
  `period` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Transports';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warden`
--

DROP TABLE IF EXISTS `warden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warden` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Check ID from warden_checks',
  `groupid` smallint(5) unsigned NOT NULL COMMENT 'The Grouping ID of the warden_checks',
  `build` smallint(5) unsigned NOT NULL COMMENT 'Client build',
  `type` tinyint(3) unsigned DEFAULT NULL COMMENT 'Check Type',
  `data` varchar(48) NOT NULL DEFAULT '',
  `str` varchar(20) NOT NULL DEFAULT '',
  `address` int(10) unsigned NOT NULL DEFAULT '0',
  `length` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `result` varchar(24) NOT NULL DEFAULT '',
  `comment` varchar(50) DEFAULT '' COMMENT 'Description of what the check is',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1571 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
