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
  `version` int(3) NOT NULL COMMENT 'The Version of the Release',
  `structure` int(3) NOT NULL COMMENT 'The current core structure level.',
  `content` int(3) NOT NULL COMMENT 'The current core content level.',
  `description` varchar(30) NOT NULL DEFAULT '' COMMENT 'A short description of the latest database revision.',
  `comment` varchar(150) DEFAULT '' COMMENT 'A comment about the latest database revision.',
  PRIMARY KEY (`version`,`structure`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Used DB version notes';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `areatrigger_tavern`
--

DROP TABLE IF EXISTS `areatrigger_tavern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_tavern` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the trigger (See AreaTrigger.dbc).',
  `name` text DEFAULT NULL COMMENT 'Name of town or tavern.',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areatrigger_teleport`
--

DROP TABLE IF EXISTS `areatrigger_teleport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_teleport` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the trigger (See AreaTrigger.dbc).',
  `name` text DEFAULT NULL COMMENT 'The name of the teleport areatrigger.',
  `target_map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The destination map id. (See map.dbc)',
  `target_position_x` float NOT NULL DEFAULT '0' COMMENT 'The x location of the player at the destination.',
  `target_position_y` float NOT NULL DEFAULT '0' COMMENT 'The y location of the player at the destination.',
  `target_position_z` float NOT NULL DEFAULT '0' COMMENT 'The z location of the player at the destination.',
  `target_orientation` float NOT NULL DEFAULT '0' COMMENT 'The orientation of the player at the destination.',
  `status_failed_mangos_string_id` smallint(6) DEFAULT NULL,
  `condition_id` mediumint(8) NOT NULL DEFAULT '0' COMMENT 'The ID of a condition from the conditions table',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `autobroadcast`
--

DROP TABLE IF EXISTS `autobroadcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autobroadcast` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The Unique identifier of the message.',
  `content` text DEFAULT NULL COMMENT 'The message Text',
  `ratio` smallint(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `battleground_events`
--

DROP TABLE IF EXISTS `battleground_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battleground_events` (
  `map` smallint(5) NOT NULL COMMENT 'The map id of the location of the event (See map.dbc).',
  `event1` tinyint(3) unsigned NOT NULL COMMENT 'The identifier for the event node in the battleground.',
  `event2` tinyint(3) unsigned NOT NULL COMMENT 'The state of the event node.',
  `description` varchar(255) NOT NULL COMMENT 'Description of the event.',
  PRIMARY KEY (`map`,`event1`,`event2`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `battleground_template`
--

DROP TABLE IF EXISTS `battleground_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battleground_template` (
  `id` mediumint(8) unsigned NOT NULL COMMENT 'The battleground ID (See BattlemasterList.dbc).',
  `MinPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The minimum number of players that need to join the battleground.',
  `MaxPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Controls how many players from each team can join the battleground.',
  `MinLvl` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The minimum level that players need to be in order to join the battleground.',
  `MaxLvl` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The maximum level that players need to be in order to join the battleground.',
  `AllianceStartLoc` mediumint(8) unsigned NOT NULL COMMENT 'The location where the alliance players get teleported to in the battleground.',
  `AllianceStartO` float NOT NULL COMMENT 'The orientation of the alliance players upon teleport.',
  `HordeStartLoc` mediumint(8) unsigned NOT NULL COMMENT 'The location where the horde players get teleported to in the battleground.',
  `HordeStartO` float NOT NULL COMMENT 'The orientation of the horde players upon teleport into the battleground.',
  `StartMaxDist` float NOT NULL DEFAULT '0' COMMENT 'The maximium distance from the start location.',
  `Comment` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `battlemaster_entry`
--

DROP TABLE IF EXISTS `battlemaster_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battlemaster_entry` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the creature (See creature_template.entry).',
  `bg_template` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The battleground template ID (See Battleground_template).',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `command`
--

DROP TABLE IF EXISTS `command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The unique Command ID.',
  `command_text` varchar(50) NOT NULL DEFAULT '' COMMENT 'The Command Name.',
  `security` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The minimum security level to use the command (See account.gmlevel) in the realm',
  `help_text` longtext DEFAULT NULL COMMENT 'The help text for the command which explains it''s use and parameters.',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=810 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Chat System';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `condition_entry` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'Type of the condition.',
  `value1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Data field One for the condition.',
  `value2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Data field Two for the condition.',
  `comments` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`condition_entry`),
  UNIQUE KEY `unique_conditions` (`type`,`value1`,`value2`)
) ENGINE=MyISAM AUTO_INCREMENT=2045 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Condition System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature`
--

DROP TABLE IF EXISTS `creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature` (
  `guid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique identifier given to each creature to distinguish creatures.',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The id of the template that is used when instantiating this creature.',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The map id of the location of the creature (See map.dbc).',
  `modelid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The model id of the the creature. ',
  `equipment_id` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'The ID of the equipment that the creature is using.',
  `position_x` float NOT NULL DEFAULT '0' COMMENT 'The x position of the creature.',
  `position_y` float NOT NULL DEFAULT '0' COMMENT 'The y position of the creature.',
  `position_z` float NOT NULL DEFAULT '0' COMMENT 'The z position of the creature.',
  `orientation` float NOT NULL DEFAULT '0' COMMENT 'The orientation of the creature. (North = 0.0; South = pi (3.14159))',
  `spawntimesecs` int(10) unsigned NOT NULL DEFAULT '120' COMMENT 'The respawn time of the creature in seconds. ',
  `spawndist` float NOT NULL DEFAULT '5' COMMENT 'The maximum distance that the creature should spawn from its spawn point.',
  `currentwaypoint` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The current waypoint of the creature.',
  `curhealth` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The current health of the creature.',
  `curmana` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The current mana of the creature.',
  `DeathState` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The creature''s death state.',
  `MovementType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The movement type associated with this creature.',
  PRIMARY KEY (`guid`),
  KEY `idx_map` (`map`),
  KEY `index_id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=590119 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_addon`
--

DROP TABLE IF EXISTS `creature_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_addon` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Signifies a unique creature guid (See creature.guid).',
  `mount` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The model ID of the mount to be used to make the creature appear mounted.',
  `bytes1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The value here overrides the value for the creature''s unit field UNIT_FIELD_BYTE',
  `b2_0_sheath` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'SheathState.',
  `b2_1_flags` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The value here overrides the value for the creature''s unit field UNIT_FIELD_BYTE',
  `emote` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Emote ID that the creature should continually perform.',
  `moveflags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Flags controlling how the creature will behave animation-wise while moving.',
  `auras` text DEFAULT NULL COMMENT 'This field controls any auras to be applied on the creature.',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_ai_scripts`
--

DROP TABLE IF EXISTS `creature_ai_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_scripts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for the AI script entry.',
  `creature_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'This references the Unique ID in the Creature Template table.',
  `event_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type ID',
  `event_inverse_phase_mask` int(11) NOT NULL DEFAULT '0' COMMENT 'Mask for the event.',
  `event_chance` int(3) unsigned NOT NULL DEFAULT '100' COMMENT 'The percentage chance for this event to happen.',
  `event_flags` int(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Event flags allow you to modify how events are executed.',
  `event_param1` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter Value 1 for the eventtype (See creature_ai_scripts.event_type).',
  `event_param2` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter Value 2 for the eventtype (See creature_ai_scripts.event_type).',
  `event_param3` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter Value 3 for the eventtype (See creature_ai_scripts.event_type).',
  `event_param4` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter Value 4 for the eventtype (See creature_ai_scripts.event_type).',
  `action1_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The first actiontype.',
  `action1_param1` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter 1 of the action1_type (See creature_ai_scripts.action1_type)',
  `action1_param2` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter 2 of the action1_type (See creature_ai_scripts.action1_type)',
  `action1_param3` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter 3 of the action1_type (See creature_ai_scripts.action1_type)',
  `action2_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The Second actiontype (See creature_ai_scripts.action2_type)',
  `action2_param1` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter 1 of action2_type (See creature_ai_scripts.action2_type)',
  `action2_param2` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter 2 of action2_type (See creature_ai_scripts.action2_type)',
  `action2_param3` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter 3 of action2_type (See creature_ai_scripts.action2_type)',
  `action3_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The Third actiontype (See creature_ai_scripts.action3_type)',
  `action3_param1` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter 1 of action3_type (See creature_ai_scripts.action3_type)',
  `action3_param2` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter 2 of action3_type (See creature_ai_scripts.action3_type)',
  `action3_param3` int(11) NOT NULL DEFAULT '0' COMMENT 'Parameter 3 of action3_type (See creature_ai_scripts.action3_type)',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT 'Documents what an event script is supposed to do.',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1780402 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='EventAI Scripts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_ai_summons`
--

DROP TABLE IF EXISTS `creature_ai_summons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_summons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'This references the third action parameter in the Creature_ai_scripts.',
  `position_x` float NOT NULL DEFAULT '0' COMMENT 'The X position for the creature to be spawned.',
  `position_y` float NOT NULL DEFAULT '0' COMMENT 'The Y position for the creature to be spawned.',
  `position_z` float NOT NULL DEFAULT '0' COMMENT 'The Z position for the creature to be spawned.',
  `orientation` float NOT NULL DEFAULT '0' COMMENT 'The orientation for the creature to be spawned.',
  `spawntimesecs` int(11) unsigned NOT NULL DEFAULT '120' COMMENT 'The despawn timer for the summoned creature.',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT 'Documents what kind of creature will be summoned.',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='EventAI Summoning Locations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_ai_texts`
--

DROP TABLE IF EXISTS `creature_ai_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_texts` (
  `entry` mediumint(8) NOT NULL COMMENT 'This references a script using an action of the type ACTION_T_TEXT.',
  `content_default` text NOT NULL COMMENT 'Contains the text presented in the default language English.',
  `content_loc1` text DEFAULT NULL COMMENT 'Korean localization of content_default.',
  `content_loc2` text DEFAULT NULL COMMENT 'French localization of content_default.',
  `content_loc3` text DEFAULT NULL COMMENT 'German localization of content_default.',
  `content_loc4` text DEFAULT NULL COMMENT 'Chinese localization of content_default.',
  `content_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of content_default.',
  `content_loc6` text DEFAULT NULL COMMENT 'Spanish (Spain) localization of content_default',
  `content_loc7` text DEFAULT NULL COMMENT 'Spanish (Latin America) localization of content_default',
  `content_loc8` text DEFAULT NULL COMMENT 'Russian localization of content_default',
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'A sound identifier.',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of message to display.',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A language identifier.',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Emote ID that the creature should continually perform.',
  `comment` text DEFAULT NULL COMMENT 'This documents the creature text.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Script Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_battleground`
--

DROP TABLE IF EXISTS `creature_battleground`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_battleground` (
  `guid` int(10) unsigned NOT NULL COMMENT 'A unique identifier given to each creature to distinguish them from each other.',
  `event1` tinyint(3) unsigned NOT NULL COMMENT 'Main Event.',
  `event2` tinyint(3) unsigned NOT NULL COMMENT 'Sub Event.',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature battleground indexing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_equip_template`
--

DROP TABLE IF EXISTS `creature_equip_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_equip_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique Id of the equipment, no link with any official data.',
  `equipentry1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the item of the equipment used in the right hand (See Item.dbc).',
  `equipentry2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the item of the equipment used in the left hand (See Item.dbc).',
  `equipentry3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the item of the equipment used in the distance slot (See Item.dbc).',
  PRIMARY KEY (`entry`),
  UNIQUE KEY `unique_template` (`equipentry1`,`equipentry2`,`equipentry3`,`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Equipment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_equip_template_raw`
--

DROP TABLE IF EXISTS `creature_equip_template_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_equip_template_raw` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  `equipmodel1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  `equipmodel2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  `equipmodel3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  `equipinfo1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  `equipinfo2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  `equipinfo3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  `equipslot1` int(11) NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  `equipslot2` int(11) NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  `equipslot3` int(11) NOT NULL DEFAULT '0' COMMENT 'Deprecated Table',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Equipment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_item_template`
--

DROP TABLE IF EXISTS `creature_item_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_item_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier of the item template entry.',
  `class` tinyint(3) unsigned DEFAULT '0' COMMENT 'The class of the item template.',
  `subclass` tinyint(3) unsigned DEFAULT '0' COMMENT 'The subclass of the item template.',
  `material` mediumint(8) unsigned DEFAULT '0' COMMENT 'The material that the item is made of.',
  `displayid` mediumint(8) unsigned DEFAULT '0' COMMENT 'A display model identifier for the Item.',
  `inventory_type` tinyint(3) unsigned DEFAULT '0' COMMENT 'Defines if and in which slot an item can be equipped.',
  `sheath_type` tinyint(3) unsigned DEFAULT '0' COMMENT 'The value of this field controls how characters will show or hide items worn.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Equipment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_linking`
--

DROP TABLE IF EXISTS `creature_linking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_linking` (
  `guid` int(10) unsigned NOT NULL COMMENT 'This references the creature table tables unique ID.',
  `master_guid` int(10) unsigned NOT NULL COMMENT 'This references the creature table tables unique ID.',
  `flag` mediumint(8) unsigned NOT NULL COMMENT 'This flag determines how a linked creature will act.',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature Linking System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_linking_template`
--

DROP TABLE IF EXISTS `creature_linking_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_linking_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'creature_template.entry of the slave mob that is linked.',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'A map identifier',
  `master_entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'master entry to trigger events',
  `flag` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This flag determines how a linked creature will act.',
  `search_range` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'IF given != 0 only mobs with spawn-dist <= search_range around the master_entry ',
  PRIMARY KEY (`entry`,`map`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature Linking System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_loot_template`
--

DROP TABLE IF EXISTS `creature_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the loot definition (loot template).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item which can be included into the loot.',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100' COMMENT 'Meaning of that field is a bit different depending on its sign.',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A group is a set of loot definitions.',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1' COMMENT 'This field defines \nwhen positive: the minimum number of copies of the item. ',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For non-reference entries - the maximum number of copies of the item.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Value that represents a loot condition that must be filled.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_model_info`
--

DROP TABLE IF EXISTS `creature_model_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_model_info` (
  `modelid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The Display ID (See CreatureDisplayInfo.dbc).',
  `bounding_radius` float NOT NULL DEFAULT '0' COMMENT 'This is the distance the creature stands from the player to attack him.',
  `combat_reach` float NOT NULL DEFAULT '0' COMMENT 'This is the maximum distance the creature can reach the player in ranged attack.',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT 'Gender of the creature.',
  `modelid_other_gender` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'A Model information entry (See Creature_model_info.modelid).',
  `modelid_other_team` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The model information entry for the other faction.',
  PRIMARY KEY (`modelid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Model related info)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_movement`
--

DROP TABLE IF EXISTS `creature_movement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_movement` (
  `id` int(10) unsigned NOT NULL COMMENT 'Creature GUID (See creature.guid).',
  `point` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'An index count for all movement points attached to a creature spawn.',
  `position_x` float NOT NULL DEFAULT '0' COMMENT 'The X position for the creature''s movement point.',
  `position_y` float NOT NULL DEFAULT '0' COMMENT 'The Y position for the creature''s movement point.',
  `position_z` float NOT NULL DEFAULT '0' COMMENT 'The Z position for the creature''s movement point.',
  `waittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'If the creature should wait at the movement point.',
  `script_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If a script should be executed.',
  `textid1` int(11) NOT NULL DEFAULT '0' COMMENT 'If a text should be emoted, this references the db_script_string table.',
  `textid2` int(11) NOT NULL DEFAULT '0' COMMENT 'If a text should be emoted, this references the db_script_string table.',
  `textid3` int(11) NOT NULL DEFAULT '0' COMMENT 'If a text should be emoted, this references the db_script_string table.',
  `textid4` int(11) NOT NULL DEFAULT '0' COMMENT 'If a text should be emoted, this references the db_script_string table.',
  `textid5` int(11) NOT NULL DEFAULT '0' COMMENT 'If a text should be emoted, this references the db_script_string table.',
  `emote` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Emote ID that the creature should perform.',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier.',
  `orientation` float NOT NULL DEFAULT '0' COMMENT 'The orientation for the creature''s movement point.',
  `model1` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'A display model identifier activated on the waypoint.',
  `model2` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'An alternative display model identifier activated on the waypoint.',
  PRIMARY KEY (`id`,`point`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_movement_template`
--

DROP TABLE IF EXISTS `creature_movement_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_movement_template` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'Creature ID from creature_template (See creature_template.entry)',
  `point` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'An index count for all movement points attached to a creature spawn.',
  `position_x` float NOT NULL DEFAULT '0' COMMENT 'The X position for the creature''s movement point.',
  `position_y` float NOT NULL DEFAULT '0' COMMENT 'The Y position for the creature''s movement point.',
  `position_z` float NOT NULL DEFAULT '0' COMMENT 'The Z position for the creature''s movement point.',
  `waittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Delay time in milliseconds',
  `script_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If a script should be executed.',
  `textid1` int(11) NOT NULL DEFAULT '0' COMMENT 'Obsolete, Do not use this Field',
  `textid2` int(11) NOT NULL DEFAULT '0' COMMENT 'Obsolete, Do not use this Field',
  `textid3` int(11) NOT NULL DEFAULT '0' COMMENT 'Obsolete, Do not use this Field',
  `textid4` int(11) NOT NULL DEFAULT '0' COMMENT 'Obsolete, Do not use this Field',
  `textid5` int(11) NOT NULL DEFAULT '0' COMMENT 'Obsolete, Do not use this Field',
  `emote` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Emote ID that the creature should perform.',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier.',
  `orientation` float NOT NULL DEFAULT '0' COMMENT 'The orientation for the creature''s movement point.',
  `model1` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'A display model identifier activated on the waypoint.',
  `model2` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'An alternative display model identifier activated on the waypoint.',
  PRIMARY KEY (`entry`,`point`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature waypoint system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_onkill_reputation`
--

DROP TABLE IF EXISTS `creature_onkill_reputation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_onkill_reputation` (
  `creature_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The template ID of the creature (See creature_template.entry).',
  `RewOnKillRepFaction1` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The faction ID of the faction that the player will gain or lose points in.',
  `RewOnKillRepFaction2` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The faction ID of the faction that the player will gain or lose points in.',
  `MaxStanding1` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The maximum standing that the creature will award reputation until.',
  `IsTeamAward1` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'controls if the player receives the reputation ',
  `RewOnKillRepValue1` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'The reputation value that the player gains (or loses if it&amp;s negative).',
  `MaxStanding2` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The maximum standing that the creature will award reputation until.',
  `IsTeamAward2` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'controls if the player receives the reputation ',
  `RewOnKillRepValue2` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'The reputation value that the player gains (or loses if it&amp;s negative).',
  `TeamDependent` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Gender',
  PRIMARY KEY (`creature_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature OnKill Reputation gain';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_spells`
--

DROP TABLE IF EXISTS `creature_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_spells` (
  `entry` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `spellId_1` smallint(5) unsigned NOT NULL DEFAULT 0,
  `probability_1` tinyint(3) unsigned NOT NULL DEFAULT 100,
  `castTarget_1` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `targetParam1_1` smallint(5) unsigned NOT NULL DEFAULT 0,
  `targetParam2_1` smallint(5) unsigned NOT NULL DEFAULT 0,
  `castFlags_1` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `delayInitialMin_1` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayInitialMax_1` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMin_1` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMax_1` smallint(5) unsigned NOT NULL DEFAULT 0,
  `scriptId_1` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `spellId_2` smallint(5) unsigned NOT NULL DEFAULT 0,
  `probability_2` tinyint(3) unsigned NOT NULL DEFAULT 100,
  `castTarget_2` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `targetParam1_2` smallint(5) unsigned NOT NULL DEFAULT 0,
  `targetParam2_2` smallint(5) unsigned NOT NULL DEFAULT 0,
  `castFlags_2` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `delayInitialMin_2` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayInitialMax_2` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMin_2` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMax_2` smallint(5) unsigned NOT NULL DEFAULT 0,
  `scriptId_2` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `spellId_3` smallint(5) unsigned NOT NULL DEFAULT 0,
  `probability_3` tinyint(3) unsigned NOT NULL DEFAULT 100,
  `castTarget_3` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `targetParam1_3` smallint(5) unsigned NOT NULL DEFAULT 0,
  `targetParam2_3` smallint(5) unsigned NOT NULL DEFAULT 0,
  `castFlags_3` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `delayInitialMin_3` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayInitialMax_3` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMin_3` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMax_3` smallint(5) unsigned NOT NULL DEFAULT 0,
  `scriptId_3` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `spellId_4` smallint(5) unsigned NOT NULL DEFAULT 0,
  `probability_4` tinyint(3) unsigned NOT NULL DEFAULT 100,
  `castTarget_4` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `targetParam1_4` smallint(5) unsigned NOT NULL DEFAULT 0,
  `targetParam2_4` smallint(5) unsigned NOT NULL DEFAULT 0,
  `castFlags_4` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `delayInitialMin_4` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayInitialMax_4` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMin_4` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMax_4` smallint(5) unsigned NOT NULL DEFAULT 0,
  `scriptId_4` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `spellId_5` smallint(5) unsigned NOT NULL DEFAULT 0,
  `probability_5` tinyint(3) unsigned NOT NULL DEFAULT 100,
  `castTarget_5` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `targetParam1_5` smallint(5) unsigned NOT NULL DEFAULT 0,
  `targetParam2_5` smallint(5) unsigned NOT NULL DEFAULT 0,
  `castFlags_5` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `delayInitialMin_5` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayInitialMax_5` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMin_5` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMax_5` smallint(5) unsigned NOT NULL DEFAULT 0,
  `scriptId_5` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `spellId_6` smallint(5) unsigned NOT NULL DEFAULT 0,
  `probability_6` tinyint(3) unsigned NOT NULL DEFAULT 100,
  `castTarget_6` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `targetParam1_6` smallint(5) unsigned NOT NULL DEFAULT 0,
  `targetParam2_6` smallint(5) unsigned NOT NULL DEFAULT 0,
  `castFlags_6` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `delayInitialMin_6` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayInitialMax_6` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMin_6` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMax_6` smallint(5) unsigned NOT NULL DEFAULT 0,
  `scriptId_6` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `spellId_7` smallint(5) unsigned NOT NULL DEFAULT 0,
  `probability_7` tinyint(3) unsigned NOT NULL DEFAULT 100,
  `castTarget_7` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `targetParam1_7` smallint(5) unsigned NOT NULL DEFAULT 0,
  `targetParam2_7` smallint(5) unsigned NOT NULL DEFAULT 0,
  `castFlags_7` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `delayInitialMin_7` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayInitialMax_7` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMin_7` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMax_7` smallint(5) unsigned NOT NULL DEFAULT 0,
  `scriptId_7` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `spellId_8` smallint(5) unsigned NOT NULL DEFAULT 0,
  `probability_8` tinyint(3) unsigned NOT NULL DEFAULT 100,
  `castTarget_8` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `targetParam1_8` smallint(5) unsigned NOT NULL DEFAULT 0,
  `targetParam2_8` smallint(5) unsigned NOT NULL DEFAULT 0,
  `castFlags_8` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `delayInitialMin_8` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayInitialMax_8` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMin_8` smallint(5) unsigned NOT NULL DEFAULT 0,
  `delayRepeatMax_8` smallint(5) unsigned NOT NULL DEFAULT 0,
  `scriptId_8` mediumint(8) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_template`
--

DROP TABLE IF EXISTS `creature_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template` (
  `Entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the Primary NPC Entry Number and is Also the Dungeon Normal Mode / Raid ',
  `Name` char(100) NOT NULL DEFAULT '' COMMENT 'The creature''s name that will be displayed.',
  `SubName` char(100) DEFAULT NULL COMMENT 'An optional tag, which will be shown below the creature''s name.',
  `MinLevel` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The minimum level of the creature when it is spawned in-game.',
  `MaxLevel` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The maximum level of the creature when it is spawned in-game.',
  `ModelId1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'A display model identifier for the creature_template.',
  `ModelId2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'An alternative display model identifier for the creature_template.',
  `ModelId3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ModelId4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `FactionAlliance` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The Faction If The Creature Is On The Alliance Side (See FactionTemplate.dbc).',
  `FactionHorde` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The Faction If The Creature Is On The Alliance Side (See FactionTemplate.dbc).',
  `Scale` float NOT NULL DEFAULT '1' COMMENT 'The scale/size of the creature.<br />\nNormal => 1 (100%)',
  `Family` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'This Defines The Family That This Creature Belongs To.',
  `CreatureType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'This Field Defines The Type Of Creature This NPC Is.',
  `InhabitType` tinyint(3) unsigned NOT NULL DEFAULT '3' COMMENT 'This Field Controls Where The Creature Can Move Into, Chase And Attack.',
  `RegenerateStats` tinyint(3) unsigned DEFAULT NULL COMMENT 'Controls if a creature template should regenerate it''s Health/Mana.',
  `RacialLeader` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if a creature template is a racial leader.',
  `NpcFlags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The flags of the creature.\n',
  `UnitFlags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Allows the manual application of unit flags to creatures.',
  `DynamicFlags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Dynamic flags are used to control the visual appearance of a creature template.',
  `ExtraFlags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The extra flags allow to modify special behaviour for a creature_template. ',
  `CreatureTypeFlags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Type flags seem to control what actions a player can perform.',
  `SpeedWalk` float NOT NULL DEFAULT '1' COMMENT 'Controls how fast the creature can move in walking mode.',
  `SpeedRun` float NOT NULL DEFAULT '1.14286' COMMENT 'Controls how fast the creature can move in running mode.',
  `UnitClass` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A creature''s class. The following table describes the available classes.',
  `Rank` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The border of a creature portrait.',
  `HealthMultiplier` float NOT NULL DEFAULT '1' COMMENT 'Modifies the creature template''s health by this factor.',
  `PowerMultiplier` float NOT NULL DEFAULT '1' COMMENT 'The affects the creature''s power.',
  `DamageMultiplier` float NOT NULL DEFAULT '1' COMMENT 'This affects the amount of damage a creature can do.',
  `DamageVariance` float NOT NULL DEFAULT '1' COMMENT 'This is used in damage calculations.',
  `ArmorMultiplier` float NOT NULL DEFAULT '1' COMMENT 'Modify the creature template''s armor by this factor.',
  `ExperienceMultiplier` float NOT NULL DEFAULT '1' COMMENT 'This affects the amount of experience the creature will earn.',
  `MinLevelHealth` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The minimum health of the creature.',
  `MaxLevelHealth` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The maximum health of the creature.',
  `MinLevelMana` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The miminum mana of the creature if the creature has variable mana.',
  `MaxLevelMana` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The maximum mana of the creature.',
  `MinMeleeDmg` float NOT NULL DEFAULT '0' COMMENT 'Minimum damage the creature deals in melee combat.',
  `MaxMeleeDmg` float NOT NULL DEFAULT '0' COMMENT 'Maximum damage the creature deals in melee combat.',
  `MinRangedDmg` float NOT NULL DEFAULT '0' COMMENT 'Minimum damage the creature deals in ranged combat.',
  `MaxRangedDmg` float NOT NULL DEFAULT '0' COMMENT 'Maximum damage the creature deals in ranged combat.',
  `Armor` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The total armor of the creature.',
  `MeleeAttackPower` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The attack power for the creature''s melee attacks.',
  `RangedAttackPower` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The attack power for the creature''s ranged attacks.',
  `MeleeBaseAttackTime` int(10) unsigned NOT NULL DEFAULT '2000' COMMENT 'A creature''s melee attack time in milliseconds.',
  `RangedBaseAttackTime` int(10) unsigned NOT NULL DEFAULT '2000' COMMENT 'The delay between ranged attacks, in milliseconds.',
  `DamageSchool` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A damage school for melee combat.',
  `MinLootGold` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Minimum money the creature drops when killed, in copper.',
  `MaxLootGold` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The money dropped by the creature in copper.',
  `LootId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This adds loot to the creature.',
  `PickpocketLootId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This adds pickpocket loot to the creature.',
  `SkinningLootId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This adds skinning loot to the creature.',
  `KillCredit1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'If killing a creature should credit towards a different creature_template.',
  `KillCredit2` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'If killing a creature should credit towards a different creature_template.',
  `MechanicImmuneMask` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'This mask can be used to make creatures immune to spell mechanics.',
  `SchoolImmuneMask` int(10) unsigned NOT NULL DEFAULT '0',
  `ResistanceHoly` smallint(5) NOT NULL DEFAULT '0' COMMENT 'The Holy resistance of the creature.',
  `ResistanceFire` smallint(5) NOT NULL DEFAULT '0' COMMENT 'The Fire resistance of the creature.',
  `ResistanceNature` smallint(5) NOT NULL DEFAULT '0' COMMENT 'The Nature resistance of the creature.',
  `ResistanceFrost` smallint(5) NOT NULL DEFAULT '0' COMMENT 'The Frost resistance of the creature.',
  `ResistanceShadow` smallint(5) NOT NULL DEFAULT '0' COMMENT 'The Shadow resistance of the creature.',
  `ResistanceArcane` smallint(5) NOT NULL DEFAULT '0' COMMENT 'The Arcane resistance of the creature.',
  `SpellListId` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'ID of combat spells list that creature will use by default.',
  `PetSpellDataId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'ID that displays what spells the pet has in the client.',
  `MovementType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The movement type defines what a creature spawn will behave like after spawning.',
  `TrainerType` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'This details what kind of trainer the creature is.',
  `TrainerSpell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This will restrict access to a profession trainer.',
  `TrainerClass` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The value of this field will restrict access to class and/or pet trainers',
  `TrainerRace` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'This field allows to restrict a riding trainer to a specific race.',
  `TrainerTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This field adds a training spells to a creature template.',
  `VendorTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This field adds a vendor items to a creature template.',
  `GossipMenuId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This field is used for adding gossip to the creature.',
  `EquipmentTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The field adds equipment to a creature.',
  `Civilian` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Marks a creature template as a civilian.',
  `AIName` char(64) DEFAULT '' COMMENT 'This string determines which built-in AI script will be used.',
  PRIMARY KEY (`Entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `creature_template_addon`
--

DROP TABLE IF EXISTS `creature_template_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template_addon` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This references the creature_template table''s unique ID.',
  `mount` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'A display model identifier used as mount for the creature_template.',
  `bytes1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'TODO',
  `b2_0_sheath` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines the sheath state of the creature_template.',
  `b2_1_flags` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The value here overrides the value for the creature''s unit field UNIT_FIELD_BYTE',
  `emote` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Emote ID that the creature should continually perform.',
  `moveflags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '\nThe flag controls how a creature_template will be animated while moving.',
  `auras` text DEFAULT NULL COMMENT 'Allows to attach auras to a creature_template entry.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_template_classlevelstats`
--

DROP TABLE IF EXISTS `creature_template_classlevelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template_classlevelstats` (
  `Level` tinyint(4) NOT NULL COMMENT 'Creature level for the stats.',
  `Class` tinyint(4) NOT NULL COMMENT 'A creature''s class. The following table describes the available classes.',
  `BaseHealthExp0` mediumint(8) unsigned NOT NULL DEFAULT '1' COMMENT 'Base health value for expansion 0 aka. vanilla WoW.',
  `BaseMana` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Base mana value for any creature of this level and class.',
  `BaseDamageExp0` float NOT NULL DEFAULT '0' COMMENT 'Base damage value for expansion 0 aka. vanilla WoW.',
  `BaseMeleeAttackPower` float NOT NULL DEFAULT '0' COMMENT 'Base melee attack power that has been factored for low level creatures.',
  `BaseRangedAttackPower` float NOT NULL DEFAULT '0' COMMENT 'Base ranged attack power.',
  `BaseArmor` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Base armor value for any creature of this level and class.',
  PRIMARY KEY (`Level`,`Class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_template_spells`
--

DROP TABLE IF EXISTS `creature_template_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template_spells` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'This references the unique ID in table creature_template.',
  `spell1` mediumint(8) unsigned NOT NULL COMMENT 'The spell identifier. The value has to match with a defined spell identifier.',
  `spell2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier. The value has to match with a defined spell identifier.',
  `spell3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier. The value has to match with a defined spell identifier.',
  `spell4` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier. The value has to match with a defined spell identifier.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System (Spells used by creature)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_texts`
--

DROP TABLE IF EXISTS `custom_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_texts` (
  `entry` mediumint(8) NOT NULL COMMENT 'The unique identifier of the script text entry.',
  `content_default` text NOT NULL COMMENT 'Contains the text presented in the default language English.',
  `content_loc1` text DEFAULT NULL COMMENT 'Korean localization of content_default.',
  `content_loc2` text DEFAULT NULL COMMENT 'French localization of content_default.',
  `content_loc3` text DEFAULT NULL COMMENT 'German localization of content_default.',
  `content_loc4` text DEFAULT NULL COMMENT 'Chinese localization of content_default.',
  `content_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of content_default.',
  `content_loc6` text DEFAULT NULL COMMENT 'Spanish (Spain) localization of content_default',
  `content_loc7` text DEFAULT NULL COMMENT 'Spanish (Latin America) localization of content_default',
  `content_loc8` text DEFAULT NULL COMMENT 'Russian localization of content_default',
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Reference to a SoundEntries.dbc table entry.',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Selects one of various text emote types to be used for the script text.',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A language identifier.',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Emote ID that the creature should continually perform.',
  `comment` text DEFAULT NULL COMMENT 'This documents the script text.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Custom Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `db_script_string`
--

DROP TABLE IF EXISTS `db_script_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_script_string` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Text ID. See dataint parameter of the SCRIPT_COMMAND_TALK command.',
  `content_default` text NOT NULL COMMENT 'Contains the text presented in the default language English.',
  `content_loc1` text DEFAULT NULL COMMENT 'Korean localization of content_default.',
  `content_loc2` text DEFAULT NULL COMMENT 'French localization of content_default.',
  `content_loc3` text DEFAULT NULL COMMENT 'German localization of content_default.',
  `content_loc4` text DEFAULT NULL COMMENT 'Chinese localization of content_default.',
  `content_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of content_default.',
  `content_loc6` text DEFAULT NULL COMMENT 'Spanish (Spain) localization of content_default',
  `content_loc7` text DEFAULT NULL COMMENT 'Spanish (Latin America) localization of content_default',
  `content_loc8` text DEFAULT NULL COMMENT 'Russian localization of content_default',
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Sound ID. See SoundEntries.dbc.',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Sound and speech type.',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'In-game language (See Languages.dbc).',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Emote ID that the creature should continually perform.',
  `comment` text DEFAULT NULL COMMENT 'Textual comment.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `db_scripts`
--

DROP TABLE IF EXISTS `db_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_scripts` (
  `script_guid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The Unique Identifier for this script',
  `script_type` smallint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of script',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Gossip script ID.',
  `delay` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Delay (sec).',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Script command.',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Command parameter, see command description.',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Command parameter, see command description.',
  `buddy_entry` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature ID (creature_template.entry) for changing source/target.',
  `search_radius` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Radius for the buddy search.',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Command flags.',
  `dataint` int(11) NOT NULL DEFAULT '0' COMMENT 'Command parameter, see command description.',
  `dataint2` int(11) NOT NULL DEFAULT '0' COMMENT 'Command parameter, see command description.',
  `dataint3` int(11) NOT NULL DEFAULT '0' COMMENT 'Command parameter, see command description.',
  `dataint4` int(11) NOT NULL DEFAULT '0' COMMENT 'Command parameter, see command description.',
  `x` float NOT NULL DEFAULT '0' COMMENT 'Position X.',
  `y` float NOT NULL DEFAULT '0' COMMENT 'Position Y.',
  `z` float NOT NULL DEFAULT '0' COMMENT 'Position Z.',
  `o` float NOT NULL DEFAULT '0' COMMENT 'Orientation angle (0 to 2*Pi).',
  `comments` varchar(255) NOT NULL COMMENT 'Textual comment.',
  PRIMARY KEY (`script_guid`)
) ENGINE=MyISAM AUTO_INCREMENT=10629 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `disables`
--

DROP TABLE IF EXISTS `disables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disables` (
  `sourceType` int(10) unsigned NOT NULL COMMENT 'Type of disable, see enum DisableType',
  `entry` int(10) unsigned NOT NULL COMMENT 'Main entry for disable, type-specific',
  `flags` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag bitfield, type-specific',
  `data` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Additional data, type-specific',
  `comment` varchar(255) DEFAULT NULL COMMENT 'Description of disable cause',
  PRIMARY KEY (`sourceType`,`entry`,`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Mangos disables system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disenchant_loot_template`
--

DROP TABLE IF EXISTS `disenchant_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disenchant_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the loot definition (loot template).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item which can be included into the loot.',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100' COMMENT 'Command parameter, see command description.',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A group is a set of loot definitions.',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1' COMMENT 'The total number of copies of an item or may reference another loot template',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For non-reference entries - the maximum number of copies of the item.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Value that represents a loot condition that must be filled.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exploration_basexp`
--

DROP TABLE IF EXISTS `exploration_basexp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exploration_basexp` (
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Area level (See AreaTable.dbc).',
  `basexp` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Base XP reward.',
  PRIMARY KEY (`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Exploration System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fishing_loot_template`
--

DROP TABLE IF EXISTS `fishing_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the loot definition (loot template).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item which can be included into the loot.',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100' COMMENT 'Meaning of that field is a bit different depending on its sign.',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A group is a set of loot definitions.',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1' COMMENT 'The total number of copies of an item or may reference another loot template',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For non-reference entries - the maximum number of copies of the item.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Value that represents a loot condition that must be filled.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event`
--

DROP TABLE IF EXISTS `game_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'ID of the event.',
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Global starting date for the event.',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Global ending date of the event.',
  `occurence` bigint(20) unsigned NOT NULL DEFAULT '86400' COMMENT 'Event periodicity (minutes).',
  `length` bigint(20) unsigned NOT NULL DEFAULT '43200' COMMENT 'Event duration (minutes).',
  `holiday` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Holiday ID.',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of the event.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_creature`
--

DROP TABLE IF EXISTS `game_event_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_creature` (
  `guid` int(10) unsigned NOT NULL COMMENT 'Creature GUID (See creature.guid).',
  `event` smallint(6) NOT NULL DEFAULT '0' COMMENT 'ID of game event (See game_event.entry).',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_creature_data`
--

DROP TABLE IF EXISTS `game_event_creature_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_creature_data` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature GUID (See creature.guid).',
  `entry_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'New creature ID (See creature_template.entry).',
  `modelid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'New modelID (See creature_template.ModelId1,2)',
  `equipment_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'New equipment ID (See creature_equip_template.entry).',
  `spell_start` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc) to be selfcasted.',
  `spell_end` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc) to be removed.',
  `event` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event ID (See game_event.entry).',
  PRIMARY KEY (`guid`,`event`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_gameobject`
--

DROP TABLE IF EXISTS `game_event_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_gameobject` (
  `guid` int(10) unsigned NOT NULL COMMENT 'GUID of gameobject (See gameobject.guid).',
  `event` smallint(6) NOT NULL DEFAULT '0' COMMENT 'ID of the event (See game_event.entry).',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_mail`
--

DROP TABLE IF EXISTS `game_event_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_mail` (
  `event` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Event ID (See game_events.entry).',
  `raceMask` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Races of affected players.',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest (See quest_template.entry) which should be rewarded.',
  `mailTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Mail template ID (See MailTemplate.dbc).',
  `senderEntry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'NPC entry (See creature_template.entry).',
  PRIMARY KEY (`event`,`raceMask`,`quest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Game event system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_quest`
--

DROP TABLE IF EXISTS `game_event_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_quest` (
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest ID (See quest_template.entry).',
  `event` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event ID (see game_event.entry).',
  PRIMARY KEY (`quest`,`event`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Game event system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_graveyard_zone`
--

DROP TABLE IF EXISTS `game_graveyard_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_graveyard_zone` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Graveyard ID (See WorldSafeLocs.dbc).',
  `ghost_zone` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'AreaID of the zone the graveyard is tied to (See AreaTable.dbc).',
  `faction` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Player faction',
  PRIMARY KEY (`id`,`ghost_zone`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `game_tele`
--

DROP TABLE IF EXISTS `game_tele`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_tele` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The id of the teleport location.',
  `position_x` float NOT NULL DEFAULT '0' COMMENT 'The x location of the teleport location.',
  `position_y` float NOT NULL DEFAULT '0' COMMENT 'The y location of the teleport location.',
  `position_z` float NOT NULL DEFAULT '0' COMMENT 'The z location of the teleport location.',
  `orientation` float NOT NULL DEFAULT '0' COMMENT 'The orientation of the player when teleported to the teleport location.',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The map id of the teleport location (See map.dbc).',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'The name of the teleport location.',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=421 DEFAULT CHARSET=utf8 COMMENT='Tele Command';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_weather`
--

DROP TABLE IF EXISTS `game_weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_weather` (
  `zone` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'A zone identifier',
  `spring_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for rain in the Spring.',
  `spring_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for snow in the Spring.',
  `spring_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for a sand storm in the Spring.',
  `summer_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for rain in the Summer.',
  `summer_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for snow in the Summer.',
  `summer_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for a sand storm in the Summer.',
  `fall_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for rain in the Fall.',
  `fall_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for snow in the Fall.',
  `fall_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for storm in the Fall.',
  `winter_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for rain in the Winter.',
  `winter_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for snow in the Winter.',
  `winter_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25' COMMENT 'Percentage chance for storm in the Winter.',
  PRIMARY KEY (`zone`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Weather System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject`
--

DROP TABLE IF EXISTS `gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject` (
  `guid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier of the game object spawn.',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'GameObject ID (See gameobject_template.entry).',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The map id that the game object is located on (See map.dbc).',
  `position_x` float NOT NULL DEFAULT '0' COMMENT 'The x location of the game object.',
  `position_y` float NOT NULL DEFAULT '0' COMMENT 'The y location of the game object.',
  `position_z` float NOT NULL DEFAULT '0' COMMENT 'The z location of the game object.',
  `orientation` float NOT NULL DEFAULT '0' COMMENT 'The orientation of the game object.',
  `rotation0` float NOT NULL DEFAULT '0' COMMENT 'The amount of rotation of an object along one of the axis.',
  `rotation1` float NOT NULL DEFAULT '0' COMMENT 'The amount of rotation of an object along one of the axis.',
  `rotation2` float NOT NULL DEFAULT '0' COMMENT 'The amount of rotation of an object along one of the axis.',
  `rotation3` float NOT NULL DEFAULT '0' COMMENT 'The amount of rotation of an object along one of the axis.',
  `spawntimesecs` int(11) NOT NULL DEFAULT '0' COMMENT 'The respawn time for the game object, defined in seconds till respawn.',
  `animprogress` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Not really known what this is used for at this time (see description).',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `idx_map` (`map`),
  KEY `idx_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=632597 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Gameobject System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_battleground`
--

DROP TABLE IF EXISTS `gameobject_battleground`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_battleground` (
  `guid` int(10) unsigned NOT NULL COMMENT 'This references the gameobject table''s  unique ID.',
  `event1` tinyint(3) unsigned NOT NULL COMMENT 'The identifier for the event node in the battleground. ',
  `event2` tinyint(3) unsigned NOT NULL COMMENT 'The state of the event node. ',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='GameObject battleground indexing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_loot_template`
--

DROP TABLE IF EXISTS `gameobject_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the loot definition (loot template).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item which can be included into the loot.',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100' COMMENT 'Meaning of that field is a bit different depending on its sign.',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A group is a set of loot definitions.',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1' COMMENT 'The total number of copies of an item or may reference another loot template',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For non-reference entries - the maximum number of copies of the item.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Value that represents a loot condition that must be filled.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_template`
--

DROP TABLE IF EXISTS `gameobject_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Id of the gameobject template',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'GameObject Type',
  `displayId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'A display model identifier for the Item.',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Object''s Name',
  `faction` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Object''s faction, if any. (See FactionTemplate.dbc)',
  `flags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'GameObject Flag',
  `size` float NOT NULL DEFAULT '1' COMMENT 'Object''s size must be set because graphic models can be resample.',
  `data0` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data10` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data11` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data12` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data13` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data14` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data15` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data16` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data17` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data18` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data19` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data20` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data21` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data22` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `data23` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The content of the data fields depends on the gameobject type',
  `mingold` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'DEPRECATED: Defines money looted from the game object.',
  `maxgold` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'DEPRECATED: Defines money looted from the game object.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Gameobject System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gossip_menu`
--

DROP TABLE IF EXISTS `gossip_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_menu` (
  `entry` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Gossip menu ID (See creature_template.GossipMenuId).',
  `text_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Displayed text ID (See npc_text.ID).',
  `script_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'DB script ID (See dbscritps_on_gossip.id).',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Condition ID (See conditions.condition_entry).',
  PRIMARY KEY (`entry`,`text_id`,`script_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gossip_menu_option`
--

DROP TABLE IF EXISTS `gossip_menu_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_menu_option` (
  `menu_id` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Gossip menu ID (See gossip_menu.entry).',
  `id` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Menu item ID.',
  `option_icon` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Icon type for the menu item.',
  `option_text` text DEFAULT NULL COMMENT 'Menu item text displayed.',
  `option_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Gossip option ID.',
  `npc_option_npcflag` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'NPC flag required (see creature_template.NpcFlags).',
  `action_menu_id` mediumint(8) NOT NULL DEFAULT '0' COMMENT 'Gossip ID for the action (see gossip_menu.entry).',
  `action_poi_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'POI ID (See points_of_interest.entry).',
  `action_script_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'DB script ID (See dbscripts_on_gossip.id).',
  `box_coded` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag for text entering into the pop-up box.',
  `box_money` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Sum of money requested by pop-up box.',
  `box_text` text DEFAULT NULL COMMENT 'Text for the pop-up box.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Condition ID (See conditions.condition_entry).',
  PRIMARY KEY (`menu_id`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gossip_texts`
--

DROP TABLE IF EXISTS `gossip_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_texts` (
  `entry` mediumint(8) NOT NULL COMMENT 'Menu item ID text, referred by SD2 scripts.',
  `content_default` text NOT NULL COMMENT 'Contains the text presented in the default language English.',
  `content_loc1` text DEFAULT NULL COMMENT 'Korean localization of content_default.',
  `content_loc2` text DEFAULT NULL COMMENT 'French localization of content_default.',
  `content_loc3` text DEFAULT NULL COMMENT 'German localization of content_default.',
  `content_loc4` text DEFAULT NULL COMMENT 'Chinese localization of content_default.',
  `content_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of content_default.',
  `content_loc6` text DEFAULT NULL COMMENT 'Spanish (Spain) localization of content_default',
  `content_loc7` text DEFAULT NULL COMMENT 'Spanish (Latin America) localization of content_default',
  `content_loc8` text DEFAULT NULL COMMENT 'Russian localization of content_default',
  `comment` text DEFAULT NULL COMMENT 'Textual comment.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Gossip Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instance_template`
--

DROP TABLE IF EXISTS `instance_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_template` (
  `map` smallint(5) unsigned NOT NULL COMMENT 'Map ID (See Map.dbc).',
  `parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map ID of the parent instance See Map.dbc).',
  `levelMin` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Minimum allowed player level.',
  `levelMax` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Maximum allowed player level.',
  `maxPlayers` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Maximal number of players.',
  `reset_delay` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance reset delay (days).',
  `ghostEntranceMap` smallint(5) unsigned NOT NULL COMMENT 'Map ID (See Map.dbc) for ghost entrance.',
  `ghostEntranceX` float NOT NULL COMMENT 'X position of ghost entrance.',
  `ghostEntranceY` float NOT NULL COMMENT 'Y position of ghost entrance.',
  PRIMARY KEY (`map`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_enchantment_template`
--

DROP TABLE IF EXISTS `item_enchantment_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_enchantment_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Random property type (See item_template.RandomProperty).',
  `ench` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Enchantment type (See ItemRandomProperties.dbc).',
  `chance` float unsigned NOT NULL DEFAULT '0' COMMENT 'Chance to get the enchantment (%).',
  PRIMARY KEY (`entry`,`ench`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item Random Enchantment System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_loot_template`
--

DROP TABLE IF EXISTS `item_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the loot definition (loot template).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item which can be included into the loot.',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100' COMMENT 'Meaning of that field is a bit different depending on its sign.',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A group is a set of loot definitions.',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1' COMMENT 'The total number of copies of an item or may reference another loot template',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For non-reference entries - the maximum number of copies of the item.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Value that represents a loot condition that must be filled.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_required_target`
--

DROP TABLE IF EXISTS `item_required_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_required_target` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'This references the item_template table tables unique ID.',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Describes which type of target the spell requires.',
  `targetEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_type_target` (`entry`,`type`,`targetEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_template`
--

DROP TABLE IF EXISTS `item_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Item prototype ID.',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Class of the item.',
  `subclass` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The subclass of the item template.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Item name.',
  `displayid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'A display model identifier for the Item.',
  `Quality` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Quality of item.',
  `Flags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Item prototype flags.',
  `BuyCount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'Stack size by vendors.',
  `BuyPrice` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Item buying price (coppers).',
  `SellPrice` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Item selling price (coppers).',
  `InventoryType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Inventory type.',
  `AllowableClass` mediumint(9) NOT NULL DEFAULT '-1' COMMENT 'Mask of allowed classes.',
  `AllowableRace` mediumint(9) NOT NULL DEFAULT '-1' COMMENT 'Mask of allowed races.',
  `ItemLevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Level of item.',
  `RequiredLevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Required level.',
  `RequiredSkill` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required skill type.',
  `RequiredSkillRank` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required skill value.',
  `requiredspell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Required spell (See Spell.dbc).',
  `requiredhonorrank` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Required honor rank.',
  `RequiredCityRank` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'DEPRECATED: the city rank required. City ranks did not make it into WoW.',
  `RequiredReputationFaction` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required faction for reputation check (See Faction.dbc).',
  `RequiredReputationRank` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required minimal reputation rank.',
  `maxcount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The maximum amount of copies of the item that a character may have.',
  `stackable` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Maximum stack size.',
  `ContainerSlots` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines the amount of slots for items of type container or ammunition container.',
  `stat_type1` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value1` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `stat_type2` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value2` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `stat_type3` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value3` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `stat_type4` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value4` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `stat_type5` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value5` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `stat_type6` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value6` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `stat_type7` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value7` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `stat_type8` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value8` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `stat_type9` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value9` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `stat_type10` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'An item modifier to apply for this item. ',
  `stat_value10` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The value to add for the matching modifier.',
  `dmg_min1` float NOT NULL DEFAULT '0' COMMENT 'The minimum damage caused by the item.',
  `dmg_max1` float NOT NULL DEFAULT '0' COMMENT 'The maximum damage caused by the item.',
  `dmg_type1` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of damage the matching dmg_min/dmg_max fields cause.',
  `dmg_min2` float NOT NULL DEFAULT '0' COMMENT 'The minimum damage caused by the item.',
  `dmg_max2` float NOT NULL DEFAULT '0' COMMENT 'The maximum damage caused by the item.',
  `dmg_type2` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of damage the matching dmg_min/dmg_max fields cause.',
  `dmg_min3` float NOT NULL DEFAULT '0' COMMENT 'The minimum damage caused by the item.',
  `dmg_max3` float NOT NULL DEFAULT '0' COMMENT 'The maximum damage caused by the item.',
  `dmg_type3` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of damage the matching dmg_min/dmg_max fields cause.',
  `dmg_min4` float NOT NULL DEFAULT '0' COMMENT 'The minimum damage caused by the item.',
  `dmg_max4` float NOT NULL DEFAULT '0' COMMENT 'The maximum damage caused by the item.',
  `dmg_type4` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of damage the matching dmg_min/dmg_max fields cause.',
  `dmg_min5` float NOT NULL DEFAULT '0' COMMENT 'The minimum damage caused by the item.',
  `dmg_max5` float NOT NULL DEFAULT '0' COMMENT 'The maximum damage caused by the item.',
  `dmg_type5` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of damage the matching dmg_min/dmg_max fields cause.',
  `armor` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The armor value of the item.',
  `holy_res` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Holy resistance.',
  `fire_res` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Fire resistance.',
  `nature_res` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Nature resistance.',
  `frost_res` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Frost resistance.',
  `shadow_res` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Shadow resistance.',
  `arcane_res` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Arcane resistance.',
  `delay` smallint(5) unsigned NOT NULL DEFAULT '1000' COMMENT 'The delay in milliseconds between successive hits for the item.',
  `ammo_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of ammunition the item uses. Arrows = 2; Bullets = 3',
  `RangedModRange` float NOT NULL DEFAULT '0',
  `spellid_1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If the item can cast or trigger a spell, this is the reference.',
  `spelltrigger_1` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of trigger for the matching spellid entry.',
  `spellcharges_1` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The amount of charges for the spell referenced in the matching spellid entry. ',
  `spellppmRate_1` float NOT NULL DEFAULT '0' COMMENT 'This controls the proc per minute rate for a spell.',
  `spellcooldown_1` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell.',
  `spellcategory_1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'A spell category identifier.',
  `spellcategorycooldown_1` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell category.',
  `spellid_2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If the item can cast or trigger a spell, this is the references.',
  `spelltrigger_2` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of trigger for the matching spellid entry.',
  `spellcharges_2` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The amount of charges for the spell referenced in the matching spellid entry. ',
  `spellppmRate_2` float NOT NULL DEFAULT '0' COMMENT 'This controls the proc per minute rate for a spell.',
  `spellcooldown_2` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell.',
  `spellcategory_2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'A spell category identifier.',
  `spellcategorycooldown_2` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell category.',
  `spellid_3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If the item can cast or trigger a spell, this is the references.',
  `spelltrigger_3` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of trigger for the matching spellid entry.',
  `spellcharges_3` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The amount of charges for the spell referenced in the matching spellid entry. ',
  `spellppmRate_3` float NOT NULL DEFAULT '0' COMMENT 'This controls the proc per minute rate for a spell.',
  `spellcooldown_3` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell.',
  `spellcategory_3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'A spell category identifier.',
  `spellcategorycooldown_3` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell category.',
  `spellid_4` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If the item can cast or trigger a spell, this is the references.',
  `spelltrigger_4` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of trigger for the matching spellid entry.',
  `spellcharges_4` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The amount of charges for the spell referenced in the matching spellid entry. ',
  `spellppmRate_4` float NOT NULL DEFAULT '0' COMMENT 'This controls the proc per minute rate for a spell.',
  `spellcooldown_4` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell.',
  `spellcategory_4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'A spell category identifier.',
  `spellcategorycooldown_4` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell category.',
  `spellid_5` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If the item can cast or trigger a spell, this is the references.',
  `spelltrigger_5` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of trigger for the matching spellid entry.',
  `spellcharges_5` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The amount of charges for the spell referenced in the matching spellid entry. ',
  `spellppmRate_5` float NOT NULL DEFAULT '0' COMMENT 'This controls the proc per minute rate for a spell.',
  `spellcooldown_5` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell.',
  `spellcategory_5` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'A spell category identifier.',
  `spellcategorycooldown_5` int(11) NOT NULL DEFAULT '-1' COMMENT 'The cooldown in milliseconds for the matching spell category.',
  `bonding` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines if and how and item will be bound to a character. ',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'A short - usually one sentence - description of the item. Mostly flavor texts.',
  `PageText` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If the item should be readable, e.g. for letters.',
  `LanguageID` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The material to be used as background for items with page texts set.',
  `PageMaterial` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The material to be used as background for items with page texts set.',
  `startquest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest ID (See quest_template.entry).',
  `lockid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Lock ID (See Lock.dbc).',
  `Material` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Material type.',
  `sheath` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The value of this field controls how characters will show or hide items worn, e.',
  `RandomProperty` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Random property type (See item_enchantment_template.entry).',
  `block` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If an item is a shield, this field holds the block chance.',
  `itemset` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If an item is part of an item set, this references the item set''s identifier.',
  `MaxDurability` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The maximum durability for an item.',
  `area` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'If an item is only usable on a specific map, this is the reference.',
  `Map` smallint(6) NOT NULL DEFAULT '0' COMMENT 'If an item is only usable on a specific map, this is the reference.',
  `BagFamily` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'If an item is a bag, this holds a bit-mask corresponding to bag families to whic',
  `DisenchantID` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Disenchant template (See disenchant_loot_template.entry).',
  `FoodType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'If an item is usable as pet food, this table is the reference.',
  `minMoneyLoot` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'This field specifies the minimum amount in a container holding money.',
  `maxMoneyLoot` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'This field specifies the maximum amount in a container holding money.',
  `Duration` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Items may have a duration set until the get removed from a character''s inventory',
  `ExtraFlags` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'With these flags it is possible to set rare conditions on an item. ',
  PRIMARY KEY (`entry`),
  KEY `items_index` (`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_command`
--

DROP TABLE IF EXISTS `locales_command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_command` (
  `id` mediumint(8) unsigned NOT NULL COMMENT 'The unique Command ID.',
  `help_text_loc1` longtext DEFAULT NULL COMMENT 'Korean help text for the command that explian its use and parameters',
  `help_text_loc2` longtext DEFAULT NULL COMMENT 'French help text for the command that explian its use and parameters',
  `help_text_loc3` longtext DEFAULT NULL COMMENT 'German help text for the command that explian its use and parameters',
  `help_text_loc4` longtext DEFAULT NULL COMMENT 'Chinese help text for the command that explian its use and parameters',
  `help_text_loc5` longtext DEFAULT NULL COMMENT 'Taiwanese help text for the command that explian its use and parameters',
  `help_text_loc6` longtext DEFAULT NULL COMMENT 'Spanish Spain help text for the command that explian its use and parameters',
  `help_text_loc7` longtext DEFAULT NULL COMMENT 'Spanish Latin America help text for the command that explian its use and parameters',
  `help_text_loc8` longtext DEFAULT NULL COMMENT 'Russian help text for the command that explian its use and parameters',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='GM Commands localized help';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_creature`
--

DROP TABLE IF EXISTS `locales_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_creature` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature ID (See creature_template.entry).',
  `name_loc1` varchar(100) NOT NULL DEFAULT '' COMMENT 'Korean localization of name in the creature_template table table.',
  `name_loc2` varchar(100) NOT NULL DEFAULT '' COMMENT 'French localization of name in the creature_template table table.',
  `name_loc3` varchar(100) NOT NULL DEFAULT '' COMMENT 'German localization of name in the creature_template table table.',
  `name_loc4` varchar(100) NOT NULL DEFAULT '' COMMENT 'Chinese localization of name in the creature_template table table.',
  `name_loc5` varchar(100) NOT NULL DEFAULT '' COMMENT 'Taiwanese localization of name in the creature_template table table.',
  `name_loc6` varchar(100) NOT NULL DEFAULT '' COMMENT 'Spanish Spain localization of name in the creature_template table table.',
  `name_loc7` varchar(100) NOT NULL DEFAULT '' COMMENT 'Spanish Latin America localization of name.',
  `name_loc8` varchar(100) NOT NULL DEFAULT '' COMMENT 'Russian localization of name in the creature_template table table.',
  `subname_loc1` varchar(100) DEFAULT NULL COMMENT 'Korean localization of subname in the creature_template table table.',
  `subname_loc2` varchar(100) DEFAULT NULL COMMENT 'French localization of subname in the creature_template table table.',
  `subname_loc3` varchar(100) DEFAULT NULL COMMENT 'German localization of subname in the creature_template table table.',
  `subname_loc4` varchar(100) DEFAULT NULL COMMENT 'Chinese localization of subname in the creature_template table table.',
  `subname_loc5` varchar(100) DEFAULT NULL COMMENT 'Taiwanese localization of subname in the creature_template table table.',
  `subname_loc6` varchar(100) DEFAULT NULL COMMENT 'Spanish Spain localization of subname in the creature_template table table.',
  `subname_loc7` varchar(100) DEFAULT NULL COMMENT 'Spanish Latin America localization of subname.',
  `subname_loc8` varchar(100) DEFAULT NULL COMMENT 'Russian localization of subname in the creature_template table table.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_gameobject`
--

DROP TABLE IF EXISTS `locales_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_gameobject` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Gameobject ID (See gameobject_template.entry).',
  `name_loc1` varchar(100) NOT NULL DEFAULT '' COMMENT 'Korean localization of name in the gameobject_template table table.',
  `name_loc2` varchar(100) NOT NULL DEFAULT '' COMMENT 'French localization of name in the gameobject_template table table.',
  `name_loc3` varchar(100) NOT NULL DEFAULT '' COMMENT 'German localization of name in the gameobject_template table table.',
  `name_loc4` varchar(100) NOT NULL DEFAULT '' COMMENT 'Chinese localization of name in the gameobject_template table table.',
  `name_loc5` varchar(100) NOT NULL DEFAULT '' COMMENT 'Taiwanese localization of name in the gameobject_template table table.',
  `name_loc6` varchar(100) NOT NULL DEFAULT '' COMMENT 'Spanish Spain localization of name in the gameobject_template table table.',
  `name_loc7` varchar(100) NOT NULL DEFAULT '' COMMENT 'Spanish Latin America localization of name.',
  `name_loc8` varchar(100) NOT NULL DEFAULT '' COMMENT 'Russian localization of name in the gameobject_template table table.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_gossip_menu_option`
--

DROP TABLE IF EXISTS `locales_gossip_menu_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_gossip_menu_option` (
  `menu_id` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Reference to gossip_menu_option.menu_id.',
  `id` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Reference to gossip_menu_option.id.',
  `option_text_loc1` text DEFAULT NULL COMMENT 'Korean localization of option_text in the gossip_menu_option table table.',
  `option_text_loc2` text DEFAULT NULL COMMENT 'French localization of option_text in the gossip_menu_option table table.',
  `option_text_loc3` text DEFAULT NULL COMMENT 'German localization of option_text in the gossip_menu_option table table.',
  `option_text_loc4` text DEFAULT NULL COMMENT 'Chinese localization of option_text in the gossip_menu_option table table.',
  `option_text_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of option_text in the gossip_menu_option table table.',
  `option_text_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of option_text.',
  `option_text_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of option_text.',
  `option_text_loc8` text DEFAULT NULL COMMENT 'Russian localization of option_text in the gossip_menu_option table table.',
  `box_text_loc1` text DEFAULT NULL COMMENT 'Korean localization of box_text in the gossip_menu_option table table.',
  `box_text_loc2` text DEFAULT NULL COMMENT 'French localization of box_text in the gossip_menu_option table table.',
  `box_text_loc3` text DEFAULT NULL COMMENT 'German localization of box_text in the gossip_menu_option table table.',
  `box_text_loc4` text DEFAULT NULL COMMENT 'Chinese localization of box_text in the gossip_menu_option table table.',
  `box_text_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of box_text in the gossip_menu_option table table.',
  `box_text_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of box_text in the gossip_menu_option table table.',
  `box_text_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of box_text.',
  `box_text_loc8` text DEFAULT NULL COMMENT 'Russian localization of box_text in the gossip_menu_option table table.',
  PRIMARY KEY (`menu_id`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_item`
--

DROP TABLE IF EXISTS `locales_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_item` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Item ID (See item_template.entry).',
  `name_loc1` varchar(100) NOT NULL DEFAULT '' COMMENT 'Korean localization of name in the item_template table table.',
  `name_loc2` varchar(100) NOT NULL DEFAULT '' COMMENT 'French localization of name in the item_template table table.',
  `name_loc3` varchar(100) NOT NULL DEFAULT '' COMMENT 'German localization of name in the item_template table table.',
  `name_loc4` varchar(100) NOT NULL DEFAULT '' COMMENT 'Chinese localization of name in the item_template table table.',
  `name_loc5` varchar(100) NOT NULL DEFAULT '' COMMENT 'Taiwanese localization of name in the item_template table table.',
  `name_loc6` varchar(100) NOT NULL DEFAULT '' COMMENT 'Spanish Spain localization of name in the item_template table table.',
  `name_loc7` varchar(100) NOT NULL DEFAULT '' COMMENT 'Spanish Latin America localization of name in the item_template table table.',
  `name_loc8` varchar(100) NOT NULL DEFAULT '' COMMENT 'Russian localization of name in the item_template table table.',
  `description_loc1` varchar(255) DEFAULT NULL COMMENT 'Korean localization of description in the item_template table table.',
  `description_loc2` varchar(255) DEFAULT NULL COMMENT 'French localization of description in the item_template table table.',
  `description_loc3` varchar(255) DEFAULT NULL COMMENT 'German localization of description in the item_template table table.',
  `description_loc4` varchar(255) DEFAULT NULL COMMENT 'Chinese localization of description in the item_template table table.',
  `description_loc5` varchar(255) DEFAULT NULL COMMENT 'Taiwanese localization of description in the item_template table table.',
  `description_loc6` varchar(255) DEFAULT NULL COMMENT 'Spanish Spain localization of description in the item_template table table.',
  `description_loc7` varchar(255) DEFAULT NULL COMMENT 'Spanish Latin America localization of description.',
  `description_loc8` varchar(255) DEFAULT NULL COMMENT 'Russian localization of description in the item_template table table.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_npc_text`
--

DROP TABLE IF EXISTS `locales_npc_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_npc_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Reference to npc_text.ID.',
  `Text0_0_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text0_0_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text0_0_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text0_0_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text0_0_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text0_0_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text0_0_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text0_0_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text0_1_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text0_1_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text0_1_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text0_1_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text0_1_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text0_1_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text0_1_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text0_1_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text1_0_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text1_0_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text1_0_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text1_0_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text1_0_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text1_0_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text1_0_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text1_0_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text1_1_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text1_1_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text1_1_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text1_1_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text1_1_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text1_1_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text1_1_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text1_1_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text2_0_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text2_0_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text2_0_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text2_0_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text2_0_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text2_0_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text2_0_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text2_0_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text2_1_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text2_1_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text2_1_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text2_1_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text2_1_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text2_1_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text2_1_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text2_1_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text3_0_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text3_0_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text3_0_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text3_0_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text3_0_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text3_0_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text3_0_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text3_0_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text3_1_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text3_1_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text3_1_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text3_1_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text3_1_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text3_1_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text3_1_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text3_1_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text4_0_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text4_0_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text4_0_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text4_0_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text4_0_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text4_0_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text4_0_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text4_0_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text4_1_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text4_1_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text4_1_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text4_1_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text4_1_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text4_1_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text4_1_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text4_1_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text5_0_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text5_0_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text5_0_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text5_0_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text5_0_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text5_0_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text5_0_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text5_0_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text5_1_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text5_1_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text5_1_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text5_1_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text5_1_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text5_1_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text5_1_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text5_1_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text6_0_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text6_0_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text6_0_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text6_0_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text6_0_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text6_0_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text6_0_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text6_0_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text6_1_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text6_1_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text6_1_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text6_1_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text6_1_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text6_1_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text6_1_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text6_1_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text7_0_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text7_0_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text7_0_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text7_0_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text7_0_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text7_0_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text7_0_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text7_0_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `Text7_1_loc1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text7_1_loc2` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text7_1_loc3` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text7_1_loc4` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text7_1_loc5` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text7_1_loc6` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text7_1_loc7` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `Text7_1_loc8` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_page_text`
--

DROP TABLE IF EXISTS `locales_page_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_page_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Reference to page_text.entry.',
  `Text_loc1` longtext DEFAULT NULL COMMENT 'Korean localization of Text in the page_text table.',
  `Text_loc2` longtext DEFAULT NULL COMMENT 'French localization of Text in the page_text table.',
  `Text_loc3` longtext DEFAULT NULL COMMENT 'German localization of Text in the page_text table.',
  `Text_loc4` longtext DEFAULT NULL COMMENT 'Chinese localization of Text in the page_text table.',
  `Text_loc5` longtext DEFAULT NULL COMMENT 'Taiwanese localization of Text in the page_text table.',
  `Text_loc6` longtext DEFAULT NULL COMMENT 'Spanish Spain localization of Text in the page_text table.',
  `Text_loc7` longtext DEFAULT NULL COMMENT 'Spanish Latin America localization of Text.',
  `Text_loc8` longtext DEFAULT NULL COMMENT 'Russian localization of Text in the page_text table.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_points_of_interest`
--

DROP TABLE IF EXISTS `locales_points_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_points_of_interest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Reference to points_of_interest.entry.',
  `icon_name_loc1` text DEFAULT NULL COMMENT 'Korean localization of icon_name in the points_of_interest table.',
  `icon_name_loc2` text DEFAULT NULL COMMENT 'French localization of icon_name in the points_of_interest table.',
  `icon_name_loc3` text DEFAULT NULL COMMENT 'German localization of icon_name in the points_of_interest table.',
  `icon_name_loc4` text DEFAULT NULL COMMENT 'Chinese localization of icon_name in the points_of_interest table.',
  `icon_name_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of icon_name in the points_of_interest table.',
  `icon_name_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of icon_name in the points_of_interest table.',
  `icon_name_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of icon_name.',
  `icon_name_loc8` text DEFAULT NULL COMMENT 'Russian localization of icon_name in the points_of_interest table.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_quest`
--

DROP TABLE IF EXISTS `locales_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_quest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Reference to quest_template.entry.',
  `Title_loc1` text DEFAULT NULL COMMENT 'Korean localization of Title in the quest_template table.',
  `Title_loc2` text DEFAULT NULL COMMENT 'French localization of Title in the quest_template table.',
  `Title_loc3` text DEFAULT NULL COMMENT 'German localization of Title in the quest_template table.',
  `Title_loc4` text DEFAULT NULL COMMENT 'Chinese localization of Title in the quest_template table.',
  `Title_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of Title in the quest_template table.',
  `Title_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of Title in the quest_template table.',
  `Title_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of Title.',
  `Title_loc8` text DEFAULT NULL COMMENT 'Russian localization of Title in the quest_template table.',
  `Details_loc1` text DEFAULT NULL COMMENT 'Korean localization of Details in the quest_template table.',
  `Details_loc2` text DEFAULT NULL COMMENT 'French localization of Details in the quest_template table.',
  `Details_loc3` text DEFAULT NULL COMMENT 'German localization of Details in the quest_template table.',
  `Details_loc4` text DEFAULT NULL COMMENT 'Chinese localization of Details in the quest_template table.',
  `Details_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of Details in the quest_template table.',
  `Details_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of Details in the quest_template table.',
  `Details_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of Details.',
  `Details_loc8` text DEFAULT NULL COMMENT 'Russian localization of Details in the quest_template table.',
  `Objectives_loc1` text DEFAULT NULL COMMENT 'Korean localization of Objectives in the quest_template table.',
  `Objectives_loc2` text DEFAULT NULL COMMENT 'French localization of Objectives in the quest_template table.',
  `Objectives_loc3` text DEFAULT NULL COMMENT 'German localization of Objectives in the quest_template table.',
  `Objectives_loc4` text DEFAULT NULL COMMENT 'Chinese localization of Objectives in the quest_template table.',
  `Objectives_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of Objectives in the quest_template table.',
  `Objectives_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of Objectives in the quest_template table.',
  `Objectives_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of Objectives.',
  `Objectives_loc8` text DEFAULT NULL COMMENT 'Russian localization of Objectives in the quest_template table.',
  `OfferRewardText_loc1` text DEFAULT NULL COMMENT 'Korean localization of OfferRewardText in the quest_template table.',
  `OfferRewardText_loc2` text DEFAULT NULL COMMENT 'French localization of OfferRewardText in the quest_template table.',
  `OfferRewardText_loc3` text DEFAULT NULL COMMENT 'German localization of OfferRewardText in the quest_template table.',
  `OfferRewardText_loc4` text DEFAULT NULL COMMENT 'Chinese localization of OfferRewardText in the quest_template table.',
  `OfferRewardText_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of OfferRewardText in the quest_template table.',
  `OfferRewardText_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of OfferRewardText.',
  `OfferRewardText_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of OfferRewardText.',
  `OfferRewardText_loc8` text DEFAULT NULL COMMENT 'Russian localization of OfferRewardText in the quest_template table.',
  `RequestItemsText_loc1` text DEFAULT NULL COMMENT 'Korean localization of RequestItemsText in the quest_template table.',
  `RequestItemsText_loc2` text DEFAULT NULL COMMENT 'French localization of RequestItemsText in the quest_template table.',
  `RequestItemsText_loc3` text DEFAULT NULL COMMENT 'German localization of RequestItemsText in the quest_template table.',
  `RequestItemsText_loc4` text DEFAULT NULL COMMENT 'Chinese localization of RequestItemsText in the quest_template table.',
  `RequestItemsText_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of RequestItemsText in the quest_template table.',
  `RequestItemsText_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of RequestItemsText in the quest_template table.',
  `RequestItemsText_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of RequestItemsText.',
  `RequestItemsText_loc8` text DEFAULT NULL COMMENT 'Russian localization of RequestItemsText in the quest_template table.',
  `EndText_loc1` text DEFAULT NULL COMMENT 'Korean localization of EndText in the quest_template table.',
  `EndText_loc2` text DEFAULT NULL COMMENT 'French localization of EndText in the quest_template table.',
  `EndText_loc3` text DEFAULT NULL COMMENT 'German localization of EndText in the quest_template table.',
  `EndText_loc4` text DEFAULT NULL COMMENT 'Chinese localization of EndText in the quest_template table.',
  `EndText_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of EndText in the quest_template table.',
  `EndText_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of EndText in the quest_template table.',
  `EndText_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of EndText.',
  `EndText_loc8` text DEFAULT NULL COMMENT 'Russian localization of EndText in the quest_template table.',
  `ObjectiveText1_loc1` text DEFAULT NULL COMMENT 'Korean localization of ObjectiveText1 in the quest_template table.',
  `ObjectiveText1_loc2` text DEFAULT NULL COMMENT 'French localization of ObjectiveText1 in the quest_template table.',
  `ObjectiveText1_loc3` text DEFAULT NULL COMMENT 'German localization of ObjectiveText1 in the quest_template table.',
  `ObjectiveText1_loc4` text DEFAULT NULL COMMENT 'Chinese localization of ObjectiveText1 in the quest_template table.',
  `ObjectiveText1_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of ObjectiveText1 in the quest_template table.',
  `ObjectiveText1_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of ObjectiveText1 in the quest_template table.',
  `ObjectiveText1_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of ObjectiveText1.',
  `ObjectiveText1_loc8` text DEFAULT NULL COMMENT 'Russian localization of ObjectiveText1 in the quest_template table.',
  `ObjectiveText2_loc1` text DEFAULT NULL COMMENT 'Korean localization of ObjectiveText2 in the quest_template table.',
  `ObjectiveText2_loc2` text DEFAULT NULL COMMENT 'French localization of ObjectiveText2 in the quest_template table.',
  `ObjectiveText2_loc3` text DEFAULT NULL COMMENT 'German localization of ObjectiveText2 in the quest_template table.',
  `ObjectiveText2_loc4` text DEFAULT NULL COMMENT 'Chinese localization of ObjectiveText2 in the quest_template table.',
  `ObjectiveText2_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of ObjectiveText2 in the quest_template table.',
  `ObjectiveText2_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of ObjectiveText2 in the quest_template table.',
  `ObjectiveText2_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of ObjectiveText2.',
  `ObjectiveText2_loc8` text DEFAULT NULL COMMENT 'Russian localization of ObjectiveText2 in the quest_template table.',
  `ObjectiveText3_loc1` text DEFAULT NULL COMMENT 'Korean localization of ObjectiveText3 in the quest_template table.',
  `ObjectiveText3_loc2` text DEFAULT NULL COMMENT 'French localization of ObjectiveText3 in the quest_template table.',
  `ObjectiveText3_loc3` text DEFAULT NULL COMMENT 'German localization of ObjectiveText3 in the quest_template table.',
  `ObjectiveText3_loc4` text DEFAULT NULL COMMENT 'Chinese localization of ObjectiveText3 in the quest_template table.',
  `ObjectiveText3_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of ObjectiveText3 in the quest_template table.',
  `ObjectiveText3_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of ObjectiveText3 in the quest_template table.',
  `ObjectiveText3_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of ObjectiveText3.',
  `ObjectiveText3_loc8` text DEFAULT NULL COMMENT 'Russian localization of ObjectiveText3 in the quest_template table.',
  `ObjectiveText4_loc1` text DEFAULT NULL COMMENT 'Korean localization of ObjectiveText4 in the quest_template table.',
  `ObjectiveText4_loc2` text DEFAULT NULL COMMENT 'French localization of ObjectiveText4 in the quest_template table.',
  `ObjectiveText4_loc3` text DEFAULT NULL COMMENT 'German localization of ObjectiveText4 in the quest_template table.',
  `ObjectiveText4_loc4` text DEFAULT NULL COMMENT 'Chinese localization of ObjectiveText4 in the quest_template table.',
  `ObjectiveText4_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of ObjectiveText4 in the quest_template table.',
  `ObjectiveText4_loc6` text DEFAULT NULL COMMENT 'Spanish Spain localization of ObjectiveText4 in the quest_template table.',
  `ObjectiveText4_loc7` text DEFAULT NULL COMMENT 'Spanish Latin America localization of ObjectiveText4.',
  `ObjectiveText4_loc8` text DEFAULT NULL COMMENT 'Russian localization of ObjectiveText4 in the quest_template table.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_loot_template`
--

DROP TABLE IF EXISTS `mail_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the loot definition (loot template).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item which can be included into the loot.',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100' COMMENT 'Meaning of that field is a bit different depending on its sign.',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A group is a set of loot definitions.',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1' COMMENT 'The total number of copies of an item or may reference another loot template',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For non-reference entries - the maximum number of copies of the item.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Value that represents a loot condition that must be filled.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mangos_string`
--

DROP TABLE IF EXISTS `mangos_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mangos_string` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This table holds strings used internally by the server to allow translations.',
  `content_default` text NOT NULL COMMENT 'Contains the text presented in the default language English.',
  `content_loc1` text DEFAULT NULL COMMENT 'Korean localization of content_default.',
  `content_loc2` text DEFAULT NULL COMMENT 'French localization of content_default.',
  `content_loc3` text DEFAULT NULL COMMENT 'German localization of content_default.',
  `content_loc4` text DEFAULT NULL COMMENT 'Chinese localization of content_default.',
  `content_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of content_default.',
  `content_loc6` text DEFAULT NULL COMMENT 'Spanish (Spain) localization of content_default',
  `content_loc7` text DEFAULT NULL COMMENT 'Spanish (Latin America) localization of content_default',
  `content_loc8` text DEFAULT NULL COMMENT 'Russian localization of content_default',
  `source_file` varchar(100) DEFAULT NULL,
  `source_enum_wrapper` varchar(100) DEFAULT NULL,
  `source_enum_tag` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `npc_text`
--

DROP TABLE IF EXISTS `npc_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_text` (
  `ID` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier of the text entry.',
  `text0_0` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `text0_1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `lang0` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The language of the text ingame.',
  `prob0` float NOT NULL DEFAULT '0' COMMENT 'This is the probability that the creature will say this text.',
  `em0_0_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait before the first emote is played.',
  `em0_0` smallint(5) DEFAULT NULL COMMENT 'Emote to play when text is displayed.',
  `em0_1_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the first emote are played, before the second emote.',
  `em0_1` smallint(5) DEFAULT NULL COMMENT 'Second emote to play when text is displayed.',
  `em0_2_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the second emote are played, before the third emote.',
  `em0_2` smallint(5) DEFAULT NULL COMMENT 'Third emote to play when text is displayed',
  `text1_0` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `text1_1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `lang1` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The language of the text in game.',
  `prob1` float NOT NULL DEFAULT '0' COMMENT 'This is the probability that the creature will say this text.',
  `em1_0_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait before the first emote is played.',
  `em1_0` smallint(5) DEFAULT NULL COMMENT 'emote to play when text is displayed.',
  `em1_1_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the first emote are played, before the second emote.',
  `em1_1` smallint(5) DEFAULT NULL COMMENT 'Second emote to play when text is displayed.',
  `em1_2_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the second emote are played, before the third emote.',
  `em1_2` smallint(5) DEFAULT NULL COMMENT 'Third emote to play when text is displayed.',
  `text2_0` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `text2_1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `lang2` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The language of the text in game.',
  `prob2` float NOT NULL DEFAULT '0' COMMENT 'This is the probability that the creature will say this text.',
  `em2_0_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait before the first emote is played.',
  `em2_0` smallint(5) DEFAULT NULL COMMENT 'emote to play when text is displayed.',
  `em2_1_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the first emote are played, before the second emote.',
  `em2_1` smallint(5) DEFAULT NULL COMMENT 'Second emote to play when text is displayed.',
  `em2_2_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the second emote are played, before the third emote.',
  `em2_2` smallint(5) DEFAULT NULL COMMENT 'Third emote to play when text is displayed.',
  `text3_0` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `text3_1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `lang3` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The language of the text in game.',
  `prob3` float NOT NULL DEFAULT '0' COMMENT 'This is the probability that the creature will say this text.',
  `em3_0_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait before the first emote is played.',
  `em3_0` smallint(5) DEFAULT NULL COMMENT 'emote to play when text is displayed.',
  `em3_1_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the first emote are played, before the second emote.',
  `em3_1` smallint(5) DEFAULT NULL COMMENT 'Second emote to play when text is displayed.',
  `em3_2_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the second emote are played, before the third emote.',
  `em3_2` smallint(5) DEFAULT NULL COMMENT 'Third emote to play when text is displayed.',
  `text4_0` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `text4_1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `lang4` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The language of the text in game.',
  `prob4` float NOT NULL DEFAULT '0' COMMENT 'This is the probability that the creature will say this text.',
  `em4_0_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait before the first emote is played.',
  `em4_0` smallint(5) DEFAULT NULL COMMENT 'emote to play when text is displayed.',
  `em4_1_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the first emote are played, before the second emote.',
  `em4_1` smallint(5) DEFAULT NULL COMMENT 'Second emote to play when text is displayed.',
  `em4_2_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the second emote are played, before the third emote.',
  `em4_2` smallint(5) DEFAULT NULL COMMENT 'Third emote to play when text is displayed.',
  `text5_0` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `text5_1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `lang5` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The language of the text in game.',
  `prob5` float NOT NULL DEFAULT '0' COMMENT 'This is the probability that the creature will say this text.',
  `em5_0_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait before the first emote is played.',
  `em5_0` smallint(5) DEFAULT NULL COMMENT 'emote to play when text is displayed.',
  `em5_1_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the first emote are played, before the second emote.',
  `em5_1` smallint(5) DEFAULT NULL COMMENT 'Second emote to play when text is displayed.',
  `em5_2_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the second emote are played, before the third emote.',
  `em5_2` smallint(5) DEFAULT NULL COMMENT 'Third emote to play when text is displayed.',
  `text6_0` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `text6_1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `lang6` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The language of the text in game.',
  `prob6` float NOT NULL DEFAULT '0' COMMENT 'This is the probability that the creature will say this text.',
  `em6_0_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait before the first emote is played.',
  `em6_0` smallint(5) DEFAULT NULL COMMENT 'emote to play when text is displayed.',
  `em6_1_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the first emote are played, before the second emote.',
  `em6_1` smallint(5) DEFAULT NULL COMMENT 'Second emote to play when text is displayed.',
  `em6_2_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the second emote are played, before the third emote.',
  `em6_2` smallint(5) DEFAULT NULL COMMENT 'Third emote to play when text is displayed.',
  `text7_0` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is male.',
  `text7_1` longtext DEFAULT NULL COMMENT 'This is the locale text that is displayed if the creature is female.',
  `lang7` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The language of the text in game.',
  `prob7` float NOT NULL DEFAULT '0' COMMENT 'This is the probability that the creature will say this text.',
  `em7_0_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait before the first emote is played.',
  `em7_0` smallint(5) DEFAULT NULL COMMENT 'emote to play when text is displayed.',
  `em7_1_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the first emote are played, before the second emote.',
  `em7_1` smallint(5) DEFAULT NULL COMMENT 'Second emote to play when text is displayed.',
  `em7_2_delay` smallint(5) DEFAULT NULL COMMENT 'Time to wait after the second emote are played, before the third emote.',
  `em7_2` smallint(5) DEFAULT NULL COMMENT 'Third emote to play when text is displayed.',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_trainer`
--

DROP TABLE IF EXISTS `npc_trainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_trainer` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature ID (See creature_template.entry).',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Learning spell ID (See Spell.dbc).',
  `spellcost` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Learning cost (coppers).',
  `reqskill` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required skill type.',
  `reqskillvalue` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required skill value.',
  `reqlevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Required level.',
  UNIQUE KEY `entry_spell` (`entry`,`spell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_trainer_template`
--

DROP TABLE IF EXISTS `npc_trainer_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_trainer_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier for the training template.',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier. . ',
  `spellcost` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The cost that the player needs to pay in order to learn the spell in copper.',
  `reqskill` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The required skill to be able to learn the spell.',
  `reqskillvalue` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The minimum skill level required for the skill referenced in reqskill.',
  `reqlevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The character level required in order to learn the spell.',
  UNIQUE KEY `entry_spell` (`entry`,`spell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_vendor`
--

DROP TABLE IF EXISTS `npc_vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_vendor` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature ID (See creature_template.entry).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Item ID (See item_template.entry).',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Items available.',
  `incrtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Restoration time, sec.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Condition ID (See conditions.condition_entry).',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Npc System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_vendor_template`
--

DROP TABLE IF EXISTS `npc_vendor_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_vendor_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier for the vending template.',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item. ',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The maximum amount of the item a vendor should carry',
  `incrtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'How frequently a vendor will restock an item having a maximum count. ',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This references the conditions tables unique ID for which the entry is valid.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Npc System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_text`
--

DROP TABLE IF EXISTS `page_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Reference to item_template.PageText.',
  `text` longtext NOT NULL COMMENT 'Text of single page.',
  `next_page` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Reference to page_text.entry.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_levelstats`
--

DROP TABLE IF EXISTS `pet_levelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_levelstats` (
  `creature_entry` mediumint(8) unsigned NOT NULL COMMENT 'Creature ID (See creature_template.entry).',
  `level` tinyint(3) unsigned NOT NULL COMMENT 'Pet level.',
  `hp` smallint(5) unsigned NOT NULL COMMENT 'Pet HP at the level.',
  `mana` smallint(5) unsigned NOT NULL COMMENT 'Pet MP at the level.',
  `armor` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Pet armor at the level.',
  `str` smallint(5) unsigned NOT NULL COMMENT 'Pet strength at the level.',
  `agi` smallint(5) unsigned NOT NULL COMMENT 'Pet agility at the level.',
  `sta` smallint(5) unsigned NOT NULL COMMENT 'Pet stamina at the level.',
  `inte` smallint(5) unsigned NOT NULL COMMENT 'Pet intellect at the level.',
  `spi` smallint(5) unsigned NOT NULL COMMENT 'Pet spirit at the level.',
  PRIMARY KEY (`creature_entry`,`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores pet levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_name_generation`
--

DROP TABLE IF EXISTS `pet_name_generation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_name_generation` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Table index.',
  `word` tinytext NOT NULL COMMENT 'Part of the name.',
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature ID (See creature_template.entry).',
  `half` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Type of the word.',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=261 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `petcreateinfo_spell`
--

DROP TABLE IF EXISTS `petcreateinfo_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `petcreateinfo_spell` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This references the creature_template tables unique ID.',
  `Spell1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier.',
  `Spell2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier.',
  `Spell3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier.',
  `Spell4` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Pet Create Spells';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pickpocketing_loot_template`
--

DROP TABLE IF EXISTS `pickpocketing_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pickpocketing_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the loot definition (loot template).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item which can be included into the loot.',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100' COMMENT 'Meaning of that field is a bit different depending on its sign.',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A group is a set of loot definitions.',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1' COMMENT 'The total number of copies of an item or may reference another loot template',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For non-reference entries - the maximum number of copies of the item.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Value that represents a loot condition that must be filled.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_classlevelstats`
--

DROP TABLE IF EXISTS `player_classlevelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_classlevelstats` (
  `class` tinyint(3) unsigned NOT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  `basehp` smallint(5) unsigned NOT NULL,
  `basemana` smallint(5) unsigned NOT NULL COMMENT 'Base mana value for any creature of this level and class.',
  PRIMARY KEY (`class`,`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_levelstats`
--

DROP TABLE IF EXISTS `player_levelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_levelstats` (
  `race` tinyint(3) unsigned NOT NULL COMMENT 'A bit-mask corresponding to races that should get the spell. ',
  `class` tinyint(3) unsigned NOT NULL COMMENT 'A bit-mask corresponding to class that should get the spell',
  `level` tinyint(3) unsigned NOT NULL COMMENT 'The level at which the stats should be applied.',
  `str` tinyint(3) unsigned NOT NULL COMMENT 'The base strength of the character.',
  `agi` tinyint(3) unsigned NOT NULL COMMENT 'The base agility of the character.',
  `sta` tinyint(3) unsigned NOT NULL COMMENT 'The base stamina of the character.',
  `inte` tinyint(3) unsigned NOT NULL COMMENT 'The base intellect of the character.',
  `spi` tinyint(3) unsigned NOT NULL COMMENT 'The base spirit of the character.',
  PRIMARY KEY (`race`,`class`,`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_xp_for_level`
--

DROP TABLE IF EXISTS `player_xp_for_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_xp_for_level` (
  `lvl` int(3) unsigned NOT NULL COMMENT 'The player''s level.',
  `xp_for_next_level` int(10) unsigned NOT NULL COMMENT 'The experience needed to upgrade from the value in lvl field to lvl +1.',
  PRIMARY KEY (`lvl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playercreateinfo`
--

DROP TABLE IF EXISTS `playercreateinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A bit-mask corresponding to races that should get the spell. ',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A bit-mask corresponding to class that should get the spell.',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The map ID (See Map.dbc)',
  `zone` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'A zone identifier.',
  `position_x` float NOT NULL DEFAULT '0' COMMENT 'The X position for the characters initial position.',
  `position_y` float NOT NULL DEFAULT '0' COMMENT 'The Y position for the characters initial position.',
  `position_z` float NOT NULL DEFAULT '0' COMMENT 'The Z position for the characters initial position.',
  `orientation` float NOT NULL DEFAULT '0' COMMENT 'The orientation for the characters initial position.',
  PRIMARY KEY (`race`,`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `playercreateinfo_action`
--

DROP TABLE IF EXISTS `playercreateinfo_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_action` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A bit-mask corresponding to races that should get the spell.',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A bit-mask corresponding to class that should get the spell.',
  `button` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the button on the action ba.',
  `action` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'See description in the lower half of this page..',
  `type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The following values are valid types:',
  PRIMARY KEY (`race`,`class`,`button`),
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `playercreateinfo_item`
--

DROP TABLE IF EXISTS `playercreateinfo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_item` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A bit-mask corresponding to races that should get the spell.',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A bit-mask corresponding to class that should get the spell.',
  `itemid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The item a character should receive upon creation.',
  `amount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The number of copies of the item to be awarded.',
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playercreateinfo_spell`
--

DROP TABLE IF EXISTS `playercreateinfo_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_spell` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A bit-mask corresponding to races that should get the spell. ',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A bit-mask corresponding to class that should get the spell.',
  `Spell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier.',
  `Note` varchar(255) DEFAULT NULL COMMENT 'A note explaining what the spell is.',
  PRIMARY KEY (`race`,`class`,`Spell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `points_of_interest`
--

DROP TABLE IF EXISTS `points_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `points_of_interest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'POI ID.',
  `x` float NOT NULL DEFAULT '0' COMMENT 'X coordinate.',
  `y` float NOT NULL DEFAULT '0' COMMENT 'Y coordinate.',
  `icon` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'POI icon.',
  `flags` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Custom data to be sent for a point of interest. ',
  `icon_name` text NOT NULL COMMENT 'The text to display as tooltip for the icon on the in-game map.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_creature`
--

DROP TABLE IF EXISTS `pool_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_creature` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature GUID (See creature.guid).',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Pool ID (See pool_template.entry).',
  `chance` float unsigned NOT NULL DEFAULT '0' COMMENT 'Chance in %.',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'Description.',
  PRIMARY KEY (`guid`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_creature_template`
--

DROP TABLE IF EXISTS `pool_creature_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_creature_template` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature ID (See creature_template.entry).',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Pool ID (See pool_template.entry).',
  `chance` float unsigned NOT NULL DEFAULT '0' COMMENT 'Chance, %.',
  `description` varchar(255) NOT NULL COMMENT 'Description.',
  PRIMARY KEY (`id`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_gameobject`
--

DROP TABLE IF EXISTS `pool_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_gameobject` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Gameobject GUID (See gameobject.guid).',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Pool ID (See pool_template.entry).',
  `chance` float unsigned NOT NULL DEFAULT '0' COMMENT 'Chance, %.',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'Description.',
  PRIMARY KEY (`guid`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_gameobject_template`
--

DROP TABLE IF EXISTS `pool_gameobject_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_gameobject_template` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Gameobject ID (See gameobject_template.entry).',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Pool ID (See pool_template.entry).',
  `chance` float unsigned NOT NULL DEFAULT '0' COMMENT 'Chance, %.',
  `description` varchar(255) NOT NULL COMMENT 'Description.',
  PRIMARY KEY (`id`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_pool`
--

DROP TABLE IF EXISTS `pool_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_pool` (
  `pool_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Pool ID (See pool_template.entry).',
  `mother_pool` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Mother pool ID.',
  `chance` float NOT NULL DEFAULT '0' COMMENT 'Chance, %.',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'Description.',
  PRIMARY KEY (`pool_id`),
  KEY `pool_idx` (`mother_pool`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_template`
--

DROP TABLE IF EXISTS `pool_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Pool ID.',
  `max_limit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Maximum number of entities.',
  `description` varchar(255) NOT NULL COMMENT 'Description.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quest_relations`
--

DROP TABLE IF EXISTS `quest_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_relations` (
  `actor` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The Entity involved in the quest',
  `entry` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature or GO entr',
  `quest` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest ID',
  `role` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Role of the actor',
  PRIMARY KEY (`entry`,`quest`,`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quest_template`
--

DROP TABLE IF EXISTS `quest_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier of the quest template entry.',
  `Method` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT 'This flag decides how a quest will be handled.',
  `ZoneOrSort` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Defines the category under which a quest will be listed.',
  `MinLevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The lowest level allowed to accept the quest.',
  `QuestLevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The quest''s level.',
  `Type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest''s difficulty.',
  `RequiredClasses` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required classes mask.',
  `RequiredRaces` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required races mask.',
  `RequiredSkill` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required skill type.',
  `RequiredSkillValue` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required skill value.',
  `RepObjectiveFaction` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Faction (See Faction.dbc).',
  `RepObjectiveValue` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Reputation value.',
  `RequiredMinRepFaction` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Faction (See Faction.dbc).',
  `RequiredMinRepValue` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Reputation value.',
  `RequiredMaxRepFaction` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Faction ID of required faction to have max rep with.',
  `RequiredMaxRepValue` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'The highest reputation value allowed for obtaining the quest.',
  `SuggestedPlayers` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Recommended  number of players to complete quest. ',
  `LimitTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The time limit to complete the quest.',
  `QuestFlags` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The quest flags give additional details on the quest type.',
  `SpecialFlags` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Flags used to define special behaviour.',
  `PrevQuestId` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Quest ID of the preceding or an exisiting quest.',
  `NextQuestId` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Quest ID of the follow-up quest (see description for more information)',
  `ExclusiveGroup` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'This allows the grouping of multiple quests (see description).',
  `NextQuestInChain` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest ID of next quest in chain.',
  `SrcItemId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Item ID of an item that the charcter starts the quest with.',
  `SrcItemCount` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Total number of items (SrcItemId) the character starts off with',
  `SrcSpell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID of the spell cast on the character on acceptance of the quest.',
  `Title` text DEFAULT NULL COMMENT 'The title of the quest.',
  `Details` text DEFAULT NULL COMMENT 'The quest text.',
  `Objectives` text DEFAULT NULL COMMENT 'The quest''s objective in text form. ',
  `OfferRewardText` text DEFAULT NULL COMMENT 'The text sent to a character when talking to the quest giver.',
  `RequestItemsText` text DEFAULT NULL COMMENT 'The text sent to a character when talking to a quest giver.',
  `EndText` text DEFAULT NULL COMMENT 'See description in the lower half of the page.',
  `ObjectiveText1` text DEFAULT NULL COMMENT 'Set to a text string, to show up as requirement in the quest log entry.',
  `ObjectiveText2` text DEFAULT NULL COMMENT 'Set to a text string, to show up as requirement in the quest log entry.',
  `ObjectiveText3` text DEFAULT NULL COMMENT 'Set to a text string, to show up as requirement in the quest log entry.',
  `ObjectiveText4` text DEFAULT NULL COMMENT 'Set to a text string, to show up as requirement in the quest log entry.',
  `ReqItemId1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template ID of an item required for quest completion.',
  `ReqItemId2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template ID of an item required for quest completion.',
  `ReqItemId3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template ID of an item required for quest completion.',
  `ReqItemId4` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template ID of an item required for quest completion.',
  `ReqItemCount1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Amount of items (ReqItemId1)  needed to complete the quest.',
  `ReqItemCount2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Amount of items (ReqItemId2) needed to complete the quest.',
  `ReqItemCount3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Amount of items (ReqItemId3) needed to complete the quest',
  `ReqItemCount4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Amount of items (ReqItemId4) needed to complete the quest.',
  `ReqSourceId1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template ID of the item required for making quest items',
  `ReqSourceId2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template ID of the item required for making quest items',
  `ReqSourceId3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template ID of the item required for making quest items',
  `ReqSourceId4` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template ID of the item required for making quest items',
  `ReqSourceCount1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'If ReqSourceId1 is set, set this to the amount of required items.',
  `ReqSourceCount2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'If ReqSourceId2 is set, set this to the amount of required items.',
  `ReqSourceCount3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'If ReqSourceId3 is set, set this to the amount of required items.',
  `ReqSourceCount4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'If ReqSourceId4 is set, set this to the amount of required items.',
  `ReqCreatureOrGOId1` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'ID of required creature or game object.',
  `ReqCreatureOrGOId2` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'ID of required creature or game object.',
  `ReqCreatureOrGOId3` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'ID of required creature or game object.',
  `ReqCreatureOrGOId4` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'ID of required creature or game object.',
  `ReqCreatureOrGOCount1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The amount of creatures or game objects required for the quest.',
  `ReqCreatureOrGOCount2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The amount of creatures or game objects required for the quest.',
  `ReqCreatureOrGOCount3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The amount of creatures or game objects required for the quest.',
  `ReqCreatureOrGOCount4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The amount of creatures or game objects required for the quest.',
  `ReqSpellCast1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID of the spell that must be cast for the quest.',
  `ReqSpellCast2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID of the spell that must be cast for the quest.',
  `ReqSpellCast3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID of the spell that must be cast for the quest.',
  `ReqSpellCast4` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID of the spell that must be cast for the quest.',
  `RewChoiceItemId1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of one possible reward.',
  `RewChoiceItemId2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of one possible reward.',
  `RewChoiceItemId3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of one possible reward.',
  `RewChoiceItemId4` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of one possible reward.',
  `RewChoiceItemId5` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of one possible reward.',
  `RewChoiceItemId6` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of one possible reward.',
  `RewChoiceItemCount1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the number of charges available for the rewarded item.',
  `RewChoiceItemCount2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the number of charges available for the rewarded item.',
  `RewChoiceItemCount3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the number of charges available for the rewarded item.',
  `RewChoiceItemCount4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the number of charges available for the rewarded item.',
  `RewChoiceItemCount5` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the number of charges available for the rewarded item.',
  `RewChoiceItemCount6` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the number of charges available for the rewarded item.',
  `RewItemId1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of the reward.',
  `RewItemId2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of the reward.',
  `RewItemId3` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of the reward.',
  `RewItemId4` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'item_template Entry ID of the reward.',
  `RewItemCount1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the amount if items to be rewarded.',
  `RewItemCount2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the amount if items to be rewarded.',
  `RewItemCount3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the amount if items to be rewarded.',
  `RewItemCount4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This defines the amount if items to be rewarded.',
  `RewRepFaction1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the faction ID of the faction whose rep is to be a reward.',
  `RewRepFaction2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the faction ID of the faction whose rep is to be a reward.',
  `RewRepFaction3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the faction ID of the faction whose rep is to be a reward.',
  `RewRepFaction4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the faction ID of the faction whose rep is to be a reward.',
  `RewRepFaction5` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the faction ID of the faction whose rep is to be a reward.',
  `RewRepValue1` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'This defines the amount of reputation gain or loss for the referenced faction.',
  `RewRepValue2` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'This defines the amount of reputation gain or loss for the referenced faction.',
  `RewRepValue3` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'This defines the amount of reputation gain or loss for the referenced faction.',
  `RewRepValue4` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'This defines the amount of reputation gain or loss for the referenced faction.',
  `RewRepValue5` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'This defines the amount of reputation gain or loss for the referenced faction.',
  `RewOrReqMoney` int(11) NOT NULL DEFAULT '0' COMMENT 'Required money for starting the quest, or award money for completing the quest.',
  `RewMoneyMaxLevel` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The amount of experience or money to be rewarded.',
  `RewSpell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID of spell to be cast as a reward.',
  `RewSpellCast` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID of additional spell to be cast, different to RewSpell.',
  `RewMailTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'mail_loot_template Entry ID of mail to be sent as a reward.',
  `RewMailDelaySecs` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of seconds to wait before sending the reward mail.',
  `PointMapId` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'A location (POI) to be highlighted on the map while the quest is active.',
  `PointX` float NOT NULL DEFAULT '0' COMMENT 'X coordinate of quest POI.',
  `PointY` float NOT NULL DEFAULT '0' COMMENT 'Y coordinate of quest POI.',
  `PointOpt` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `DetailsEmote1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This references  the emote to be shown upon displaying quest details.',
  `DetailsEmote2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This references  the emote to be shown upon displaying quest details.',
  `DetailsEmote3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This references  the emote to be shown upon displaying quest details.',
  `DetailsEmote4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This references  the emote to be shown upon displaying quest details.',
  `DetailsEmoteDelay1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of seconds to delay the emote.',
  `DetailsEmoteDelay2` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of seconds to delay the emote.',
  `DetailsEmoteDelay3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of seconds to delay the emote.',
  `DetailsEmoteDelay4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of seconds to delay the emote.',
  `IncompleteEmote` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This references the emotes identifier in the Emotes.dbc table.',
  `CompleteEmote` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'This references the emotes identifier in the Emotes.dbc table.',
  `OfferRewardEmote1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Emotes.dbc ID of emote to be shown on quest completion.',
  `OfferRewardEmote2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Emotes.dbc ID of emote to be shown on quest completion.',
  `OfferRewardEmote3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Emotes.dbc ID of emote to be shown on quest completion.',
  `OfferRewardEmote4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Emotes.dbc ID of emote to be shown on quest completion.',
  `OfferRewardEmoteDelay1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of seconds to delay before the emote is actioned.',
  `OfferRewardEmoteDelay2` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of seconds to delay before the emote is actioned.',
  `OfferRewardEmoteDelay3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of seconds to delay before the emote is actioned.',
  `OfferRewardEmoteDelay4` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of seconds to delay before the emote is actioned.',
  `StartScript` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'dbscripts_on_quest_start Entry ID of the script to be run at quest start.',
  `CompleteScript` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'dbscripts_on_quest_start Entry ID of the script to be run at quest end.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Quest System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reference_loot_template`
--

DROP TABLE IF EXISTS `reference_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the loot definition (loot template).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item which can be included into the loot.',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100' COMMENT 'Meaning of that field is a bit different depending on its sign.',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A group is a set of loot definitions.',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1' COMMENT 'The total number of copies of an item or may reference another loot template',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For non-reference entries - the maximum number of copies of the item.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Value that represents a loot condition that must be filled.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reputation_reward_rate`
--

DROP TABLE IF EXISTS `reputation_reward_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reputation_reward_rate` (
  `faction` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Faction (See Faction.dbc).',
  `quest_rate` float NOT NULL DEFAULT '1' COMMENT 'Rate for quest reputation.',
  `creature_rate` float NOT NULL DEFAULT '1' COMMENT 'Rate for creature kill reputation.',
  `spell_rate` float NOT NULL DEFAULT '1' COMMENT 'Rate for reputation spells.',
  PRIMARY KEY (`faction`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reputation_spillover_template`
--

DROP TABLE IF EXISTS `reputation_spillover_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reputation_spillover_template` (
  `faction` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Base faction (See Faction.dbc).',
  `faction1` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Dependent faction (See Faction.dbc).',
  `rate_1` float NOT NULL DEFAULT '0' COMMENT 'Rate for faction one.',
  `rank_1` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The topmost rank allowed.',
  `faction2` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Dependent faction (See Faction.dbc).',
  `rate_2` float NOT NULL DEFAULT '0' COMMENT 'Rate for faction two.',
  `rank_2` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The topmost rank allowed.',
  `faction3` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Dependent faction (See Faction.dbc).',
  `rate_3` float NOT NULL DEFAULT '0' COMMENT 'Rate for faction three.',
  `rank_3` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The topmost rank allowed.',
  `faction4` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Dependent faction (See Faction.dbc).',
  `rate_4` float NOT NULL DEFAULT '0' COMMENT 'Rate for faction four.',
  `rank_4` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The topmost rank allowed.',
  PRIMARY KEY (`faction`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Reputation spillover reputation gain';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reserved_name`
--

DROP TABLE IF EXISTS `reserved_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserved_name` (
  `name` varchar(12) NOT NULL DEFAULT '' COMMENT 'The name to disallow for characters created on normal player accounts.',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player Reserved Names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `script_binding`
--

DROP TABLE IF EXISTS `script_binding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_binding` (
  `type` tinyint(2) unsigned NOT NULL COMMENT 'enum ScriptedObjectType in ScriptMgr.h',
  `ScriptName` char(64) NOT NULL COMMENT 'Script name, to be unique across all types',
  `bind` mediumint(10) NOT NULL COMMENT 'Bound to entry (>0) or GUID (<0)',
  `data` tinyint(2) unsigned DEFAULT '0' COMMENT 'Misc data; Effect number for spellscripts',
  PRIMARY KEY (`ScriptName`,`bind`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='SD2 Script Names and Binding';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `script_texts`
--

DROP TABLE IF EXISTS `script_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_texts` (
  `entry` mediumint(8) NOT NULL COMMENT 'Script text ID.',
  `content_default` text NOT NULL COMMENT 'Contains the text presented in the default language English.',
  `content_loc1` text DEFAULT NULL COMMENT 'Korean localization of content_default.',
  `content_loc2` text DEFAULT NULL COMMENT 'French localization of content_default.',
  `content_loc3` text DEFAULT NULL COMMENT 'German localization of content_default.',
  `content_loc4` text DEFAULT NULL COMMENT 'Chinese localization of content_default.',
  `content_loc5` text DEFAULT NULL COMMENT 'Taiwanese localization of content_default.',
  `content_loc6` text DEFAULT NULL COMMENT 'Spanish (Spain) localization of content_default',
  `content_loc7` text DEFAULT NULL COMMENT 'Spanish (Latin America) localization of content_default',
  `content_loc8` text DEFAULT NULL COMMENT 'Russian localization of content_default',
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Sound ID (See SoundEntries.dbc).',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Chat type (see enum ChatType in Creature.h).',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'In-game language.',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Emote ID that the creature should continually perform.',
  `comment` text DEFAULT NULL COMMENT 'Textual comment.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Script Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `script_waypoint`
--

DROP TABLE IF EXISTS `script_waypoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_waypoint` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature ID (See creature_template.entry).',
  `pointid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Point ID.',
  `location_x` float NOT NULL DEFAULT '0' COMMENT 'X position of WP.',
  `location_y` float NOT NULL DEFAULT '0' COMMENT 'Y position of WP.',
  `location_z` float NOT NULL DEFAULT '0' COMMENT 'Z position of WP.',
  `waittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Wait time (msec).',
  `point_comment` text DEFAULT NULL COMMENT 'Textual comment.',
  PRIMARY KEY (`entry`,`pointid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Script Creature waypoints';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `skill_fishing_base_level`
--

DROP TABLE IF EXISTS `skill_fishing_base_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_fishing_base_level` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Area ID (See AreaTable.dbc).',
  `skill` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Fishing skill value.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Fishing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skinning_loot_template`
--

DROP TABLE IF EXISTS `skinning_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skinning_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the loot definition (loot template).',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Template ID of the item which can be included into the loot.',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100' COMMENT 'Meaning of that field is a bit different depending on its sign.',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'A group is a set of loot definitions.',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1' COMMENT 'The total number of copies of an item or may reference another loot template',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'For non-reference entries - the maximum number of copies of the item.',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Value that represents a loot condition that must be filled.',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_affect`
--

DROP TABLE IF EXISTS `spell_affect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_affect` (
  `entry` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc#Id).',
  `effectId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Effect ID (See Spell.dbc).',
  `SpellFamilyMask` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'SpellFamilyFlags (See Spell.dbc).',
  PRIMARY KEY (`entry`,`effectId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `spell_area`
--

DROP TABLE IF EXISTS `spell_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_area` (
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc).',
  `area` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Area ID (See AreaTable.dbc).',
  `quest_start` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest ID (See quest_template.entry).',
  `quest_start_active` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag for quest_start.',
  `quest_end` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest ID (See quest_template.entry).',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Condition ID (See conditions.condition_entry).',
  `aura_spell` mediumint(8) NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc).',
  `racemask` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Race mask value.',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT 'The gender of characters to which the spell is applied.',
  `autocast` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Autocast flag.',
  PRIMARY KEY (`spell`,`area`,`quest_start`,`quest_start_active`,`aura_spell`,`racemask`,`gender`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_bonus_data`
--

DROP TABLE IF EXISTS `spell_bonus_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_bonus_data` (
  `entry` smallint(5) unsigned NOT NULL COMMENT 'Spell ID (See Spell.dbc).',
  `direct_bonus` float NOT NULL DEFAULT '0' COMMENT 'Direct damage bonus.',
  `one_hand_direct_bonus` float NOT NULL DEFAULT '0' COMMENT 'Direct bonus for one-handed weapon.',
  `two_hand_direct_bonus` float NOT NULL DEFAULT '0' COMMENT 'Direct damage bonus for two-handed weapon.',
  `direct_bonus_done` float NOT NULL DEFAULT '0' COMMENT 'Direct bonus for done part.',
  `one_hand_direct_bonus_done` float NOT NULL DEFAULT '0' COMMENT 'Direct damage done bonus with one-handed weapon.',
  `two_hand_direct_bonus_done` float NOT NULL DEFAULT '0' COMMENT 'Direct damage done bonus with two-handed weapon.',
  `direct_bonus_taken` float NOT NULL DEFAULT '0' COMMENT 'Direct damage taken bonus.',
  `one_hand_direct_bonus_taken` float NOT NULL DEFAULT '0' COMMENT 'Direct damage taken bonus with one-handed weapon.',
  `two_hand_direct_bonus_taken` float NOT NULL DEFAULT '0' COMMENT 'Direct damage taken bonus with two-handed weapon.',
  `dot_bonus` float NOT NULL DEFAULT '0' COMMENT 'DoT tick bonus coefficient.',
  `ap_bonus` float NOT NULL DEFAULT '0' COMMENT 'Any value here will modify the spells attack power with the factor given here.',
  `ap_dot_bonus` float NOT NULL DEFAULT '0' COMMENT 'DoT bonus for physical damage.',
  `comments` varchar(255) DEFAULT NULL COMMENT 'Textual comment.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_chain`
--

DROP TABLE IF EXISTS `spell_chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_chain` (
  `spell_id` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Spell ID.',
  `prev_spell` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Previous rank of the spell.',
  `first_spell` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Lowest rank spell.',
  `rank` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Rank.',
  `req_spell` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Required spell ID.',
  PRIMARY KEY (`spell_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Spell Additinal Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_elixir`
--

DROP TABLE IF EXISTS `spell_elixir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_elixir` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc).',
  `mask` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines what type of potion/food spell this is.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_facing`
--

DROP TABLE IF EXISTS `spell_facing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_facing` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc).',
  `facingcasterflag` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Facing caster flags.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_learn_spell`
--

DROP TABLE IF EXISTS `spell_learn_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_learn_spell` (
  `entry` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc).',
  `SpellID` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc).',
  `Active` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'Active flag.',
  PRIMARY KEY (`entry`,`SpellID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_linked`
--

DROP TABLE IF EXISTS `spell_linked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_linked` (
  `entry` int(10) unsigned NOT NULL COMMENT 'Spell ID (See Spell.dbc).',
  `linked_entry` int(10) unsigned NOT NULL COMMENT 'Spell ID (See Spell.dbc).',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link type.',
  `effect_mask` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Effect mask.',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT 'Textual comment.',
  PRIMARY KEY (`entry`,`linked_entry`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Linked spells storage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_pet_auras`
--

DROP TABLE IF EXISTS `spell_pet_auras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_pet_auras` (
  `spell` mediumint(8) unsigned NOT NULL COMMENT 'Spell ID (See Spell.dbc).',
  `pet` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature ID (See creature_template.entry).',
  `aura` mediumint(8) unsigned NOT NULL COMMENT 'Spell ID (See Spell.dbc).',
  PRIMARY KEY (`spell`,`pet`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_proc_event`
--

DROP TABLE IF EXISTS `spell_proc_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_proc_event` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID (See Spell.dbc).',
  `SchoolMask` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell school mask.',
  `SpellFamilyName` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell family name.',
  `SpellFamilyMask0` bigint(40) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell family mask for effect 0.',
  `SpellFamilyMask1` bigint(40) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell family mask for effect 1.',
  `SpellFamilyMask2` bigint(40) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell family mask for effect 2.',
  `procFlags` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Flags defining conditions for aura to proc.',
  `procEx` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Flags refining proc condition.',
  `ppmRate` float NOT NULL DEFAULT '0' COMMENT 'Proc frequency limit.',
  `CustomChance` float NOT NULL DEFAULT '0' COMMENT 'Chance of proc.',
  `Cooldown` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Cooldown (in msec).',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_proc_item_enchant`
--

DROP TABLE IF EXISTS `spell_proc_item_enchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_proc_item_enchant` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'Spell ID (See Spell.dbc).',
  `ppmRate` float NOT NULL DEFAULT '0' COMMENT 'Proc frequency limit, per minute.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_script_target`
--

DROP TABLE IF EXISTS `spell_script_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_script_target` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'Spell ID (See Spell.dbc).',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Type of the target entry.',
  `targetEntry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature ID or Gameobject ID.',
  `inverseEffectMask` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Inverse effect mask.',
  UNIQUE KEY `entry_type_target` (`entry`,`type`,`targetEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_target_position`
--

DROP TABLE IF EXISTS `spell_target_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_target_position` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The spell identifier. The value has to match with a defined spell identifier.',
  `target_map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The target map''s identifier.',
  `target_position_x` float NOT NULL DEFAULT '0' COMMENT 'The X position on the target map.',
  `target_position_y` float NOT NULL DEFAULT '0' COMMENT 'The Y position on the target map.',
  `target_position_z` float NOT NULL DEFAULT '0' COMMENT 'The Z position on the target map.',
  `target_orientation` float NOT NULL DEFAULT '0' COMMENT 'The orientation for the character on the target map.',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_threat`
--

DROP TABLE IF EXISTS `spell_threat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_threat` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'The spell identifier.',
  `Threat` smallint(6) NOT NULL COMMENT 'The value of threat to add or remove from the characters threat.',
  `multiplier` float NOT NULL DEFAULT '1' COMMENT 'Any value here will modify the spells threat with the factor given here.',
  `ap_bonus` float NOT NULL DEFAULT '0' COMMENT 'Any value here will modify the spells attack power with the factor given here.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transports`
--

DROP TABLE IF EXISTS `transports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transports` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This references the Gameobject Template table''s unique ID.',
  `name` text DEFAULT NULL COMMENT 'A name describing the transport.',
  `period` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'This is the amount of time that it take for the transport to make one full pass.',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Transports';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warden`
--

DROP TABLE IF EXISTS `warden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warden` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Identifier',
  `groupid` smallint(5) unsigned NOT NULL COMMENT 'Grouped Check ID',
  `build` smallint(5) unsigned NOT NULL COMMENT 'Build Number',
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
