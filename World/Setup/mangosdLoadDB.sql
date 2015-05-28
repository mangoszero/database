-- MySQL dump 10.13  Distrib 5.5.34, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mangos
-- ------------------------------------------------------
-- Server version	5.5.34-0ubuntu0.13.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `db_version`
--

DROP TABLE IF EXISTS `db_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_version` (
  `version` varchar(120) NOT NULL DEFAULT '',
  `creature_ai_version` varchar(120) DEFAULT NULL,
  `required_20007_18_Deadmines_Mr_Smite_Corrections` bit(1) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Used DB version notes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_version`
--

LOCK TABLES `db_version` WRITE;
/*!40000 ALTER TABLE `db_version` DISABLE KEYS */;
INSERT INTO `db_version` VALUES
('MaNGOSZero Database 2.0.11 Rev 20007_18','No EventAI or Scripts available',NULL);
/*!40000 ALTER TABLE `db_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areatrigger_involvedrelation`
--

DROP TABLE IF EXISTS `areatrigger_involvedrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_involvedrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areatrigger_tavern`
--

DROP TABLE IF EXISTS `areatrigger_tavern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_tavern` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areatrigger_teleport`
--

DROP TABLE IF EXISTS `areatrigger_teleport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_teleport` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `name` text,
  `required_level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `required_item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `required_item2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `required_quest_done` int(11) unsigned NOT NULL DEFAULT '0',
  `target_map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `target_position_x` float NOT NULL DEFAULT '0',
  `target_position_y` float NOT NULL DEFAULT '0',
  `target_position_z` float NOT NULL DEFAULT '0',
  `target_orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areatrigger_teleport`
--

LOCK TABLES `areatrigger_teleport` WRITE;
/*!40000 ALTER TABLE `areatrigger_teleport` DISABLE KEYS */;
INSERT INTO `areatrigger_teleport` VALUES
(45,'Scarlet Monastery - Graveyard - Entrance - Inside',0,0,0,0,189,1688.99,1053.48,18.6775,0.00117),
(78,'The Deadmines - Entrance - Inside',0,0,0,0,36,-16.4,-383.07,61.78,1.86),
(101,'Stormwind Stockades - Entrance - Inside',0,0,0,0,34,54.23,0.28,-18.34,6.26),
(119,'The Deadmines - Entrance - Outside',0,0,0,0,0,-11208.3,1672.52,24.66,4.55217),
(121,'The Deadmines - Exit - Soutside',0,0,0,0,0,-11339.4,1571.16,100.56,0),
(145,'Shadowfang Keep - Entrance - Inside',0,0,0,0,33,-229.135,2109.18,76.8898,1.267),
(194,'Shadowfang keep - Entrance - Outside',0,0,0,0,0,-232.796,1568.28,76.8909,4.398),
(226,'The Wailing Caverns - Caverns of Mist - Entrance - Outside',0,0,0,0,1,-740.059,-2214.23,16.1374,5.68),
(228,'The Wailing Caverns - Entrance - Inside',0,0,0,0,43,-163.49,132.9,-73.66,5.83),
(242,'Razorfen Kraul - Entrance - Outside',0,0,0,0,1,-4464.92,-1666.24,90,0),
(244,'Razorfen Kraul - Entrance - Inside',0,0,0,0,47,1943,1544.63,82,1.38),
(257,'Blackfathom Deeps - Entrance - Inside',0,0,0,0,48,-151.89,106.96,-39.87,4.53),
(259,'Blackfathom Deeps - Entrance - Outside',0,0,0,0,1,4247.74,745.879,-24.5299,4.5828),
(286,'Uldaman - Hall of the Keepers - Entrance - Entrance - Inside',0,0,0,0,70,-226.8,49.09,-46.03,1.39),
(288,'Uldaman - Dig One - Entrance - Outside',0,0,0,0,0,-6066.73,-2955.63,209.776,3.20443),
(322,'Gnomeregan - Entrance - Outside',0,0,0,0,0,-5163.33,927.623,257.188,0),
(324,'Gnomeregan - The Clockwerk Run - Entrance - Inside',0,0,0,0,90,-332.22,-2.28,-150.86,2.77),
(442,'Razorfen Downs - Entrance - Inside',0,0,0,0,129,2592.55,1107.5,51.29,4.74),
(444,'Razorfen Downs - Entrance - Outside',0,0,0,0,1,-4658.12,-2526.35,81.492,1.25978),
(446,'The Temple of Atal\'Hakkar - Entrance - Inside',0,0,0,0,109,-319.24,99.9,-131.85,3.19),
(448,'The Temple of Atal\'Hakkar - Entrance - Outside',0,0,0,0,0,-10175.1,-3995.15,-112.9,2.95938),
(503,'Stormwind Stockades - Entrance - Outside',0,0,0,0,0,-8764.83,846.075,87.4842,3.77934),
(523,'Gnomeregan - Train Depot - Entrance - Inside',0,0,0,0,90,-736.51,2.71,-249.99,3.14),
(525,'Gnomeregan - Train Depot - Entrance - Outside',0,0,0,0,0,-4858.27,756.435,244.923,0),
(527,'Teldrassil - Rut\'theran Village',0,0,0,0,1,8786.36,967.445,30.197,3.39632),
(542,'Teldrassil - Darnassus',0,0,0,0,1,9945.13,2616.89,1316.46,4.61446),
(602,'Scarlet Monastery - Graveyard - Entrance - Outside',0,0,0,0,0,2913.92,-802.404,160.333,3.50405),
(604,'Scarlet Monastery - Cathedral - Entrance - Outside',0,0,0,0,0,2906.14,-813.772,160.333,1.95739),
(606,'Scarlet Monastery - Armory - Entrance - Outside',0,0,0,0,0,2884.45,-822.01,160.333,1.95268),
(608,'Scarlet Monastery - Library - Entrance - Outside',0,0,0,0,0,2870.9,-820.164,160.333,0.387856),
(610,'Scarlet Monastery - Cathedral - Entrance - Inside',0,0,0,0,189,855.683,1321.5,18.6709,0.001747),
(612,'Scarlet Monastery - Armory - Entrance - Inside',0,0,0,0,189,1610.83,-323.433,18.6738,6.28022),
(614,'Scarlet Monastery - Library - Entrance - Inside',0,0,0,0,189,255.346,-209.09,18.6773,6.26656),
(702,'Stormwind - Wizard Sanctum - Entrance - Outside',0,0,0,0,0,-9015.97,875.318,148.617,0),
(704,'Stormwind - Wizard Sanctum - Exit - Inside',0,0,0,0,0,-9019.16,887.596,29.6206,0),
(882,'Dustwind Gulch - Uldaman - Entrance - Outside',0,0,0,0,0,-6620.48,-3765.19,266.226,3.13531),
(902,'Uldaman - Echomok Caverns - Side Entrance - Inside',0,0,0,0,70,-214.02,383.607,-38.7687,0.5),
(922,'Zul\'Farrak - Entrance - Outside',0,0,0,0,1,-6796.49,-2890.77,8.88063,3.30496),
(924,'Zul\'Farrak - Entrance - ',0,0,0,0,209,1213.52,841.59,8.93,6.09),
(943,'Leap of Faith - End of fall',0,0,0,0,1,-5187.47,-2804.32,-8.375,5.76),
(1064,'Onyxia\'s Lair - Entrance - Outside',0,0,0,0,1,-4747.17,-3753.27,49.8122,0.713271),
(1466,'Blackrock Depths - Entrance - Inside',0,0,0,0,230,458.32,26.52,-70.67,4.95),
(1468,'Blackrock Spire - Entrance - Inside',0,0,0,0,229,78.5083,-225.044,49.839,5.1),
(1470,'Blackrock Spire - Entrance - Outside',0,0,0,0,0,-7524.19,-1230.13,285.743,2.09544),
(1472,'Blackrock Depths - Entrance - Outside',0,0,0,0,0,-7179.63,-923.667,166.416,1.84097),
(2068,'Blackrock Spire - Fall out',0,0,0,0,0,-7524.19,-1230.13,285.743,2.09544),
(2166,'Deeprun Tram - Ironforge Instance (Inside)',0,0,0,0,0,-4838.95,-1318.46,501.868,1.42372),
(2171,'Deeprun Tram - Stormwind Instance (Inside)',0,0,0,0,0,-8364.57,535.981,91.7969,2.24619),
(2173,'Deeprun Tram - Stormwind Instance',0,0,0,0,369,68.3006,2490.91,-4.29647,3.12192),
(2175,'Deeprun Tram - Ironforge Instance',0,0,0,0,369,69.2542,10.257,-4.29664,3.09832),
(2214,'Stratholme - Eastwall Gate - Entrance - Inside',0,0,0,0,329,3593.15,-3646.56,138.5,5.33),
(2216,'Stratholme - Main Entrance - Right - Entrance - Inside',0,0,0,0,329,3395.09,-3380.25,142.702,0.1),
(2217,'Stratholme - Main Entrance - Left - Entrance - Inside',0,0,0,0,329,3395.09,-3380.25,142.702,0.1),
(2221,'Stratholme - Eastwall Gate - Entrance - Outside',0,0,0,0,0,3235.46,-4050.6,108.45,1.93522),
(2226,'Ragefire Chasm - Entrance - Outside',0,0,0,0,1,1813.49,-4418.58,-18.57,1.78),
(2230,'Ragefire Chasm - Entrance - Inside',0,0,0,0,389,3.81,-14.82,-17.84,4.39),
(2527,'Orgrimmar - Hall of Legends - Entrance - Inside',0,0,0,0,450,221.322,74.4933,25.7195,0.484836),
(2530,'Orgrimmar - Hall of Legends - Entrance - Outside',0,0,0,0,1,1637.32,-4242.7,56.1827,4.1927),
(2532,'Stormwind City - Champions Hall - Entrance - Inside',0,0,0,0,449,-0.299116,4.39156,-0.255884,1.54805),
(2534,'Stormwind City - Champions Hall - Entrance - Outside',0,0,0,0,0,-8762.45,403.062,103.902,5.34463),
(2567,'Scholomance - Entrance - Inside',0,0,0,0,289,196.37,127.05,134.91,6.09),
(2568,'Scholomance - Entrance - Outside',0,0,0,0,0,1275.05,-2552.03,90.3994,3.6631),
(2606,'Alterac Valley - Horde - Entrance - Outside',0,0,0,0,0,534.868,-1087.68,106.119,3.35758),
(2608,'Alterac Valley - Alliance - Entrance - Outside',0,0,0,0,0,98.432,-182.274,127.52,5.02654),
(2848,'Onyxias Lair - Entrance - Inside',0,0,0,0,249,29.1607,-71.3372,-8.18032,4.58),
(2886,'The Molten Core - The Molten Bridge - Entrance - Inside',0,0,0,0,409,1096,-467,-104.6,3.64),
(2890,'Blackrock Depths - Molten Core - Entrance - Outside',0,0,0,0,230,1115.35,-457.35,-102.7,0.5),
(3126,'Maraudon - Purple - Entrance - Outside',0,0,0,0,1,-1186.98,2875.95,85.7258,1.78443),
(3131,'Maraudon - Orange - Entrance - Outside',0,0,0,0,1,-1471.07,2618.57,76.1944,0),
(3133,'Maraudon - Entrance - Orange',0,0,0,0,349,1019.69,-458.31,-43.43,0.31),
(3134,'Maraudon - Entrance - Purple',0,0,0,0,349,752.91,-616.53,-33.11,1.37),
(3183,'Dire Maul - East - Entrance - Inside',0,0,0,0,429,44.4499,-154.822,-2.71201,0),
(3184,'Dire Maul - East - Side Entrance - Entrance - Inside',0,0,0,0,429,-201.11,-328.66,-2.72,5.22),
(3185,'Dire Maul - East - Lariss Pavilion - Entrance - Inside',0,0,0,0,429,9.31119,-837.085,-32.5305,0),
(3186,'Dire Maul - West - Right - Entrance - Inside',0,0,0,0,429,-62.9658,159.867,-3.46206,3.14788),
(3187,'Dire Maul - West - Left - Entrance - Inside',0,0,0,0,429,31.5609,159.45,-3.4777,0.01),
(3189,'Dire Maul - North - Entrance - Inside',0,0,0,0,429,255.249,-16.0561,-2.58737,4.7),
(3190,'Dire Maul - West - Left - Entrance - Outside',0,0,0,0,1,-3831.79,1250.23,160.223,0),
(3191,'Dire Maul - West - Right - Entrance - Outside',0,0,0,0,1,-3747.96,1249.18,160.217,3.15827),
(3193,'Dire Maul - North - Entrance - Outside',0,0,0,0,1,-3520.65,1077.72,161.138,1.5009),
(3194,'Dire Maul - East - Entrance - Outside',0,0,0,0,1,-3737.48,934.975,160.973,3.13864),
(3195,'Dire Maul - East - Side Entrance - Outside',0,0,0,0,1,-3980.58,776.193,161.006,0),
(3196,'Dire Maul - East - Lariss Pavilion - Entrance - Outside',0,0,0,0,1,-4030.21,127.966,26.8109,0),
(3197,'Dire Maul - East - Alzzin - Exit - Outside',0,0,0,0,1,-3577.67,841.859,134.594,0),
(3528,'The Molten Core - Window - Entrance - Inside',0,0,0,0,409,1096,-467,-104.6,3.64),
(3529,'The Molten Core - Window(Lava) - Entrance - Inside',0,0,0,0,409,1096,-467,-104.6,3.64),
(3726,'Blackwing Lair - Entrance - Inside',0,0,0,0,469,-7666.23,-1102.79,399.68,0.601256),
(3728,'Blackrock Spire - Entrance - Outside',0,0,0,0,0,-7524.19,-1230.13,285.743,2.09544),
(3928,'Zul\'Gurub - Entrance - Inside',0,0,0,0,309,-11916.1,-1230.53,92.5334,4.71867),
(3930,'Zul\'Gurub - Entrance - Outside',0,0,0,0,0,-11916.3,-1208.37,92.2868,1.61792),
(3948,'Arathi Basin - Refuge Point - Entrance - Outside',0,0,0,0,0,-1198,-2533,22,0),
(3949,'Arathi Basin - Hammerfall - Entrance - Outside',0,0,0,0,0,-817,-3509,73,0),
(4006,'Ruins Of Ahn\'Qiraj - Entrance - Outside',0,0,0,0,1,-8418.5,1505.94,31.8232,0),
(4008,'Ruins Of Ahn\'Qiraj - Entrance - Inside',0,0,0,0,509,-8429.74,1512.14,31.9074,2.58),
(4010,'Ahn\'Qiraj Temple - Entrance - Inside',0,0,0,0,531,-8231.33,2010.6,129.861,0),
(4012,'Ahn\'Qiraj Temple - Entrance - Outside',0,0,0,0,1,-8242.67,1992.06,129.072,0),
(4055,'Naxxramas - Entrance - Inside',0,0,0,0,533,3005.87,-3435.01,293.882,0),
(4156,'Naxxramas - Sapphiron\'s Lair - Entrance - Inside',0,0,0,0,533,3498.28,-5349.9,144.968,1.31324);
/*!40000 ALTER TABLE `areatrigger_teleport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `battleground_events`
--

DROP TABLE IF EXISTS `battleground_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battleground_events` (
  `map` smallint(5) NOT NULL,
  `event1` tinyint(3) unsigned NOT NULL,
  `event2` tinyint(3) unsigned NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`map`,`event1`,`event2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `battleground_template`
--

DROP TABLE IF EXISTS `battleground_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battleground_template` (
  `id` mediumint(8) unsigned NOT NULL,
  `MinPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MaxPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MinLvl` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MaxLvl` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllianceStartLoc` mediumint(8) unsigned NOT NULL,
  `AllianceStartO` float NOT NULL,
  `HordeStartLoc` mediumint(8) unsigned NOT NULL,
  `HordeStartO` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `battlemaster_entry`
--

DROP TABLE IF EXISTS `battlemaster_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battlemaster_entry` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Entry of a creature',
  `bg_template` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Battleground template id',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `command`
--

DROP TABLE IF EXISTS `command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `security` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `help` longtext,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Chat System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command`
--

LOCK TABLES `command` WRITE;
/*!40000 ALTER TABLE `command` DISABLE KEYS */;
INSERT INTO `command` VALUES
('account',0,'Syntax: .account\r\nDisplay the access level of your account.'),
('account characters',3,'Syntax: .account characters [#accountId|$accountName]\r\n\r\nShow list all characters for account selected by provided #accountId or $accountName, or for selected player in game.'),
('account create',4,'Syntax: .account create $account $password\r\n\r\nCreate account and set password to it.'),
('account delete',4,'Syntax: .account delete $account\r\n\r\nDelete account with all characters.'),
('account lock',0,'Syntax: .account lock [on|off]\r\n\r\nAllow login from account only from current used IP or remove this requirement.'),
('account onlinelist',4,'Syntax: .account onlinelist\r\n\r\nShow list of online accounts.'),
('account password',0,'Syntax: .account password $old_password $new_password $new_password\r\n\r\nChange your account password.'),
('account set addon',3,'Syntax: .account set addon [#accountId|$accountName] #addon\r\n\r\nSet user (possible targeted) expansion addon level allowed. Addon values: 0 - normal, 1 - tbc, 2 - wotlk.'),
('account set gmlevel',4,'Syntax: .account set gmlevel [#accountId|$accountName] #level\r\n\r\nSet the security level for targeted player (can\'t be used at self) or for #accountId or $accountName to a level of #level.\r\n\r\n#level may range from 0 to 3.'),
('account set password',4,'Syntax: .account set password (#accountId|$accountName) $password $password\r\n\r\nSet password for account.'),
('additem',3,'Syntax: .additem #itemid/[#itemname]/#shift-click-item-link #itemcount\r\n\r\nAdds the specified number of items of id #itemid (or exact (!) name $itemname in brackets, or link created by shift-click at item in inventory or recipe) to your or selected character inventory. If #itemcount is omitted, only one item will be added.'),
('additemset',3,'Syntax: .additemset #itemsetid\r\n\r\nAdd items from itemset of id #itemsetid to your or selected character inventory. Will add by one example each item from itemset.'),
('ahbot items amount',3,'Syntax: .ahbot items amount $GreyItems $WhiteItems $GreenItems $BlueItems $PurpleItems $OrangeItems $YellowItems\r\n\r\nSet amount of each items color be selled on auction.'),
('ahbot items amount blue',3,'Syntax: .ahbot items amount blue $BlueItems\r\n\r\nSet amount of Blue color items be selled on auction.'),
('ahbot items amount green',3,'Syntax: .ahbot items amount green $GreenItems\r\n\r\nSet amount of Green color items be selled on auction.'),
('ahbot items amount grey',3,'Syntax: .ahbot items amount grey $GreyItems\r\n\r\nSet amount of Grey color items be selled on auction.'),
('ahbot items amount orange',3,'Syntax: .ahbot items amount orange $OrangeItems\r\n\r\nSet amount of Orange color items be selled on auction.'),
('ahbot items amount purple',3,'Syntax: .ahbot items amount purple $PurpleItems\r\n\r\nSet amount of Purple color items be selled on auction.'),
('ahbot items amount white',3,'Syntax: .ahbot items amount white $WhiteItems\r\n\r\nSet amount of White color items be selled on auction.'),
('ahbot items amount yellow',3,'Syntax: .ahbot items amount yellow $YellowItems\r\n\r\nSet amount of Yellow color items be selled on auction.'),
('ahbot items ratio',3,'Syntax: .ahbot items ratio $allianceratio $horderatio $neutralratio\r\n\r\nSet ratio of items in 3 auctions house.'),
('ahbot items ratio alliance',3,'Syntax: .ahbot items ratio alliance $allianceratio\r\n\r\nSet ratio of items in alliance auction house.'),
('ahbot items ratio horde',3,'Syntax: .ahbot items ratio horde $horderatio\r\n\r\nSet ratio of items in horde auction house.'),
('ahbot items ratio neutral',3,'Syntax: .ahbot items ratio neutral $neutralratio\r\n\r\nSet ratio of items in $neutral auction house.'),
('ahbot rebuild',3,'Syntax: .ahbot rebuild [all]\r\n\r\nExpire all actual auction of ahbot except bided by player. Bided auctions could be forced to expire by using \"all\" option. AHBot will re-fill auctions using current settings.'),
('ahbot reload',3,'Syntax: .ahbot reload\r\n\r\nReload AHBot settings from configuration file.'),
('ahbot status',3,'Syntax: .ahbot status [all]\r\n\r\nShow current ahbot state data in short form, and with \"all\" with details.'),
('announce',1,'Syntax: .announce $MessageToBroadcast\r\n\r\nSend a global message to all players online in chat log.'),
('appear',1,'Syntax: .appear [$charactername]\r\n\r\nTeleport to the given character. Either specify the character name or click on the character\'s portrait, e.g. when you are in a group. Character can be offline.'),
('auction',3,'Syntax: .auction\r\n\r\nShow your team auction store.'),
('auction alliance',3,'Syntax: .auction alliance\r\n\r\nShow alliance auction store independent from your team.'),
('auction goblin',3,'Syntax: .auction goblin\r\n\r\nShow goblin auction store common for all teams.'),
('auction horde',3,'Syntax: .auction horde\r\n\r\nShow horde auction store independent from your team.'),
('auction item',3,'Syntax: .auction item (alliance|horde|goblin) #itemid[:#itemcount] [[[#minbid] #buyout] [short|long|verylong]\r\n\r\nAdd new item to an specific auction house at short|long|verylong periods. Periods are the same as the ones in the in-game dialog. Created auction does not have an owner.'),
('aura',3,'Syntax: .aura #spellid\r\n\r\nAdd the aura from spell #spellid to the selected Unit.'),
('ban account',3,'Syntax: .ban account $Name $bantime $reason\r\n\r\nBan account and kick player.\r\n\r\n$bantime: negative value leads to permban, otherwise use a timestring like \"4d20h3s\"'),
('ban character',3,'Syntax: .ban character $Name $bantime $reason\r\n\r\nBan account and kick player.\r\n$bantime: negative value leads to permban, otherwise use a timestring like \"4d20h3s\"'),
('ban ip',3,'Syntax: .ban ip $Ip $bantime $reason\r\n\r\nBan IP.\r\n$bantime: negative value leads to permban, otherwise use a timestring like \"4d20h3s\"'),
('baninfo account',3,'Syntax: .baninfo account $accountid\r\n\r\nWatch full information about a specific ban.'),
('baninfo character',3,'Syntax: .baninfo character $charactername\r\n\r\nWatch full information about a specific ban.'),
('baninfo ip',3,'Syntax: .baninfo ip $ip\r\n\r\nWatch full information about a specific ban.'),
('bank',3,'Syntax: .bank\r\n\r\nShow your bank inventory.'),
('banlist account',3,'Syntax: .banlist account [$Name]\r\n\r\nSearches the banlist for a account name pattern or show full list account bans.'),
('banlist character',3,'Syntax: .banlist character $Name\r\n\r\nSearches the banlist for a character name pattern. Pattern required.'),
('banlist ip',3,'Syntax: .banlist ip [$Ip]\r\n\r\nSearches the banlist for a IP pattern or show full list of IP bans.'),
('cast',3,'Syntax: .cast #spellid [triggered]\r\n\r\nCast #spellid to selected target. If no target selected cast to self. If \'trigered\' or part provided then spell casted with triggered flag.'),
('cast back',3,'Syntax: .cast back #spellid [triggered]\r\n\r\nSelected target will cast #spellid to your character. If \'trigered\' or part provided then spell casted with triggered flag.'),
('cast dist',3,'Syntax: .cast dist #spellid [#dist [triggered]]\r\n\r\nYou will cast spell to point at distance #dist. If \'trigered\' or part provided then spell casted with triggered flag. Not all spells can be casted as area spells.'),
('cast self',3,'Syntax: .cast self #spellid [triggered]\r\n\r\nCast #spellid by target at target itself. If \'trigered\' or part provided then spell casted with triggered flag.'),
('cast target',3,'Syntax: .cast target #spellid [triggered]\r\n\r\nSelected target will cast #spellid to his victim. If \'trigered\' or part provided then spell casted with triggered flag.'),
('character deleted delete',4,'Syntax: .character deleted delete #guid|$name\r\n\r\nCompletely deletes the selected characters.\r\nIf $name is supplied, only characters with that string in their name will be deleted, if #guid is supplied, only the character with that GUID will be deleted.'),
('character deleted list',3,'Syntax: .character deleted list [#guid|$name]\r\n\r\nShows a list with all deleted characters.\r\nIf $name is supplied, only characters with that string in their name will be selected, if #guid is supplied, only the character with that GUID will be selected.'),
('character deleted old',4,'Syntax: .character deleted old [#keepDays]\r\n\r\nCompletely deletes all characters with deleted time longer #keepDays. If #keepDays not provided the  used value from mangosd.conf option \'CharDelete.KeepDays\'. If referenced config option disabled (use 0 value) then command can\'t be used without #keepDays.'),
('character deleted restore',3,'Syntax: .character deleted restore #guid|$name [$newname] [#new account]\r\n\r\nRestores deleted characters.\r\nIf $name is supplied, only characters with that string in their name will be restored, if $guid is supplied, only the character with that GUID will be restored.\r\nIf $newname is set, the character will be restored with that name instead of the original one. If #newaccount is set, the character will be restored to specific account character list. This works only with one character!'),
('character erase',4,'Syntax: .character erase $name\r\n\r\nDelete character $name. Character finally deleted in case any deleting options.'),
('character level',3,'Syntax: .character level [$playername] [#level]\r\n\r\nSet the level of character with $playername (or the selected if not name provided) by #numberoflevels Or +1 if no #numberoflevels provided). If #numberoflevels is omitted, the level will be increase by 1. If #numberoflevels is 0, the same level will be restarted. If no character is selected and name not provided, increase your level. Command can be used for offline character. All stats and dependent values recalculated. At level decrease talents can be reset if need. Also at level decrease equipped items with greater level requirement can be lost.'),
('character rename',2,'Syntax: .character rename [$name]\r\n\r\nMark selected in game or by $name in command character for rename at next login.'),
('character reputation',2,'Syntax: .character reputation [$player_name]\r\n\r\nShow reputation information for selected player or player find by $player_name.'),
('combatstop',2,'Syntax: .combatstop [$playername]\r\n\r\nStop combat for selected character. If selected non-player then command applied to self. If $playername provided then attempt applied to online player $playername.'),
('commands',0,'Syntax: .commands\r\n\r\nDisplay a list of available commands for your account level.'),
('cooldown',3,'Syntax: .cooldown [#spell_id]\r\n\r\nRemove all (if spell_id not provided) or #spel_id spell cooldown from selected character or you (if no selection).'),
('damage',3,'Syntax: .damage $damage_amount [$school [$spellid]]\r\n\r\nApply $damage to target. If not $school and $spellid provided then this flat clean melee damage without any modifiers. If $school provided then damage modified by armor reduction (if school physical), and target absorbing modifiers and result applied as melee damage to target. If spell provided then damage modified and applied as spell damage. $spellid can be shift-link.'),
('debug anim',2,'Syntax: .debug anim #emoteid\r\n\r\nPlay emote #emoteid for your character.'),
('debug bg',3,'Syntax: .debug bg\r\n\r\nToggle debug mode for battlegrounds. In debug mode GM can start battleground with single player.'),
('debug getitemvalue',3,'Syntax: .debug getitemvalue #itemguid #field [int|hex|bit|float]\r\n\r\nGet the field #field of the item #itemguid in your inventroy.\r\n\r\nUse type arg for set output format: int (decimal number), hex (hex value), bit (bitstring), float. By default use integer output.'),
('debug getvalue',3,'Syntax: .debug getvalue #field [int|hex|bit|float]\r\n\r\nGet the field #field of the selected target. If no target is selected, get the content of your field.\r\n\r\nUse type arg for set output format: int (decimal number), hex (hex value), bit (bitstring), float. By default use integer output.'),
('debug moditemvalue',3,'Syntax: .debug moditemvalue #guid #field [int|float| &= | |= | &=~ ] #value\r\n\r\nModify the field #field of the item #itemguid in your inventroy by value #value. \r\n\r\nUse type arg for set mode of modification: int (normal add/subtract #value as decimal number), float (add/subtract #value as float number), &= (bit and, set to 0 all bits in value if it not set to 1 in #value as hex number), |= (bit or, set to 1 all bits in value if it set to 1 in #value as hex number), &=~ (bit and not, set to 0 all bits in value if it set to 1 in #value as hex number). By default expect integer add/subtract.'),
('debug modvalue',3,'Syntax: .debug modvalue #field [int|float| &= | |= | &=~ ] #value\r\n\r\nModify the field #field of the selected target by value #value. If no target is selected, set the content of your field.\r\n\r\nUse type arg for set mode of modification: int (normal add/subtract #value as decimal number), float (add/subtract #value as float number), &= (bit and, set to 0 all bits in value if it not set to 1 in #value as hex number), |= (bit or, set to 1 all bits in value if it set to 1 in #value as hex number), &=~ (bit and not, set to 0 all bits in value if it set to 1 in #value as hex number). By default expect integer add/subtract.'),
('debug play cinematic',1,'Syntax: .debug play cinematic #cinematicid\r\n\r\nPlay cinematic #cinematicid for you. You stay at place while your mind fly.'),
('debug play sound',1,'Syntax: .debug play sound #soundid\r\n\r\nPlay sound with #soundid.\r\nSound will be play only for you. Other players do not hear this.'),
('debug setitemvalue',3,'Syntax: .debug setitemvalue #guid #field [int|hex|bit|float] #value\r\n\r\nSet the field #field of the item #itemguid in your inventroy to value #value.\r\n\r\nUse type arg for set input format: int (decimal number), hex (hex value), bit (bitstring), float. By default expect integer input format.'),
('debug setvalue',3,'Syntax: .debug setvalue #field [int|hex|bit|float] #value\r\n\r\nSet the field #field of the selected target to value #value. If no target is selected, set the content of your field.\r\n\r\nUse type arg for set input format: int (decimal number), hex (hex value), bit (bitstring), float. By default expect integer input format.'),
('debug spellcoefs',3,'Syntax: .debug spellcoefs #spellid\r\n\r\nShow default calculated and DB stored coefficients for direct/dot heal/damage.'),
('debug spellmods',3,'Syntax: .debug spellmods (flat|pct) #spellMaskBitIndex #spellModOp #value\r\n\r\nSet at client side spellmod affect for spell that have bit set with index #spellMaskBitIndex in spell family mask for values dependent from spellmod #spellModOp to #value.'),
('delticket',2,'Syntax: .delticket all, .delticket #num, .delticket $character_name\r\n\r\nTo delete all tickets at server, $character_name to delete ticket of this character, #num to delete ticket #num.'),
('demorph',2,'Syntax: .demorph\r\n\r\nDemorph the selected player.'),
('die',3,'Syntax: .die\r\n\r\nKill the selected player. If no player is selected, it will kill you.'),
('dismount',0,'Syntax: .dismount\r\n\r\nDismount you, if you are mounted.'),
('distance',3,'Syntax: .distance [$name/$link]\r\n\r\nDisplay the distance from your character to the selected creature/player, or player with name $name, or player/creature/gameobject pointed to shift-link with guid.'),
('event',2,'Syntax: .event #event_id\r\n\r\nShow details about event with #event_id.'),
('event list',2,'Syntax: .event list\r\n\r\nShow list of currently active events.Show list of all events'),
('event start',2,'Syntax: .event start #event_id\r\n\r\nStart event #event_id. Set start time for event to current moment (change not saved in DB).'),
('event stop',2,'Syntax: .event stop #event_id\r\n\r\nStop event #event_id. Set start time for event to time in past that make current moment is event stop time (change not saved in DB).'),
('explorecheat',3,'Syntax: .explorecheat #flag\r\n\r\nReveal  or hide all maps for the selected player. If no player is selected, hide or reveal maps to you.Use a #flag of value 1 to reveal, use a #flag value of 0 to hide all maps.'),
('gm',1,'Syntax: .gm [on/off]\r\n\r\nEnable or Disable in game GM MODE or show current state of on/off not provided.'),
('gm chat',1,'Syntax: .gm chat [on/off]\r\n\r\nEnable or disable chat GM MODE (show gm badge in messages) or show current state of on/off not provided.'),
('gm ingame',0,'Syntax: .gm ingame\r\n\r\nDisplay a list of available in game Game Masters.'),
('gm list',3,'Syntax: .gm list\r\n\r\nDisplay a list of all Game Masters accounts and security levels.'),
('gm setview',1,'Syntax: .gm setview\r\n\r\nSet farsight view on selected unit. Select yourself to set view back.'),
('gm visible',1,'Syntax: .gm visible on/off\r\n\r\nOutput current visibility state or make GM visible(on) and invisible(off) for other players.'),
('go',1,'Syntax: .go  [$playername|pointlink|#x #y #z [#mapid]]\r\n\r\nTeleport your character to point with coordinates of player $playername, or coordinates of one from shift-link types: player, tele, taxinode, creature/creature_entry, gameobject/gameobject_entry, or explicit #x #y #z #mapid coordinates.'),
('go creature',1,'Syntax: .go creature (#creature_guid|$creature_name|id #creature_id)\r\n\r\nTeleport your character to creature with guid #creature_guid, or teleport your character to creature with name including as part $creature_name substring, or teleport your character to a creature that was spawned from the template with this entry #creature_id.'),
('go graveyard',1,'Syntax: .go graveyard #graveyardId\r\n\r\nTeleport to graveyard with the graveyardId specified.'),
('go grid',1,'Syntax: .go grid #gridX #gridY [#mapId]\r\n\r\nTeleport the gm to center of grid with provided indexes at map #mapId (or current map if it not provided).'),
('go object',1,'Syntax: .go object (#gameobject_guid|$gameobject_name|id #gameobject_id)\r\n\r\nTeleport your character to gameobject with guid #gameobject_guid, or teleport your character to gameobject with name including as part $gameobject_name substring, or teleport your character to a gameobject that was spawned from the template with this entry #gameobject_id.'),
('go taxinode',1,'Syntax: .go taxinode #taxinode\r\n\r\nTeleport player to taxinode coordinates. You can look up zone using .lookup taxinode $namepart'),
('go trigger',1,'Syntax: .go trigger (#trigger_id|$trigger_shift-link|$trigger_target_shift-link) [target]\r\n\r\nTeleport your character to areatrigger with id #trigger_id or trigger id associated with shift-link. If additional arg \"target\" provided then character will telported to areatrigger target point.'),
('go xy',1,'Syntax: .go xy #x #y [#mapid]\r\n\r\nTeleport player to point with (#x,#y) coordinates at ground(water) level at map #mapid or same map if #mapid not provided.'),
('go xyz',1,'Syntax: .go xyz #x #y #z [#mapid]\r\n\r\nTeleport player to point with (#x,#y,#z) coordinates at ground(water) level at map #mapid or same map if #mapid not provided.'),
('go zonexy',1,'Syntax: .go zonexy #x #y [#zone]\r\n\r\nTeleport player to point with (#x,#y) client coordinates at ground(water) level in zone #zoneid or current zone if #zoneid not provided. You can look up zone using .lookup area $namepart'),
('gobject add',2,'Syntax: .gobject add #id <spawntimeSecs>\r\n\r\nAdd a game object from game object templates to the world at your current location using the #id.spawntimesecs sets the spawntime, it is optional.Note: this is a copy of .gameobject.'),
('gobject delete',2,'Syntax: .gobject delete #go_guid\r\n\r\nDelete gameobject with guid #go_guid.'),
('gobject move',2,'Syntax: .gobject move #goguid [#x #y #z]\r\n\r\nMove gameobject #goguid to character coordinates (or to (#x,#y,#z) coordinates if its provide).'),
('gobject near',2,'Syntax: .gobject near  [#distance]\r\n\r\nOutput gameobjects at distance #distance from player. Output gameobject guids and coordinates sorted by distance from character. If #distance not provided use 10 as default value.'),
('gobject target',2,'Syntax: .gobject target [#go_id|#go_name_part]\r\n\r\nLocate and show position nearest gameobject. If #go_id or #go_name_part provide then locate and show position of nearest gameobject with gameobject template id #go_id or name included #go_name_part as part.'),
('gobject turn',2,'Syntax: .gobject turn #goguid\r\n\r\nSet for gameobject #goguid orientation same as current character orientation.'),
('gps',1,'Syntax: .gps [$name|$shift-link]\r\n\r\nDisplay the position information for a selected character or creature (also if player name $name provided then for named player, or if creature/gameobject shift-link provided then pointed creature/gameobject if it loaded). Position information includes X, Y, Z, and orientation, map Id and zone Id'),
('groupgo',1,'Syntax: .groupgo [$charactername]\r\n\r\nTeleport the given character and his group to you. Teleported only online characters but original selected group member can be offline.'),
('guid',2,'Syntax: .guid\r\n\r\nDisplay the GUID for the selected character.'),
('guild create',2,'Syntax: .guild create [$GuildLeaderName] \"$GuildName\"\r\n\r\nCreate a guild named $GuildName with the player $GuildLeaderName (or selected) as leader.  Guild name must in quotes.'),
('guild delete',2,'Syntax: .guild delete \"$GuildName\"\r\n\r\nDelete guild $GuildName. Guild name must in quotes.'),
('guild invite',2,'Syntax: .guild invite [$CharacterName] \"$GuildName\"\r\n\r\nAdd player $CharacterName (or selected) into a guild $GuildName. Guild name must in quotes.'),
('guild rank',2,'Syntax: .guild rank $CharacterName #Rank\r\n\r\nSet for $CharacterName rank #Rank in a guild.'),
('guild uninvite',2,'Syntax: .guild uninvite [$CharacterName]\r\n\r\nRemove player $CharacterName (or selected) from a guild.'),
('help',0,'Syntax: .help [$command]\r\n\r\nDisplay usage instructions for the given $command. If no $command provided show list available commands.'),
('hidearea',3,'Syntax: .hidearea #areaid\r\n\r\nHide the area of #areaid to the selected character. If no character is selected, hide this area to you.'),
('honor add',2,'Syntax: .honor add $amount\r\n\r\nAdd a certain amount of honor (gained in lifetime) to the selected player.'),
('honor addkill',2,'Syntax: .honor addkill\r\n\r\nAdd the targeted unit as one of your pvp kills today (you only get honor if it\'s a racial leader or a player)'),
('honor show',1,'Syntax: .honor show\r\n\r\nDisplay the honor stats of the selected player'),
('honor update',2,'Syntax: .honor update\r\n\r\nForce honor to be update'),
('instance listbinds',3,'Syntax: .instance listbinds\r\n\r\nLists the binds of the selected player.'),
('instance savedata',3,'Syntax: .instance savedata\r\n\r\nSave the InstanceData for the current player\'s map to the DB.'),
('instance stats',3,'Syntax: .instance stats\r\n\r\nShows statistics about instances.'),
('instance unbind',3,'Syntax: .instance unbind all\r\n\r\nAll of the selected player\'s binds will be cleared..instance unbind #mapid Only the specified #mapid instance will be cleared.'),
('itemmove',2,'Syntax: .itemmove #sourceslotid #destinationslotid\r\n\r\nMove an item from slots #sourceslotid to #destinationslotid in your inventoryNot yet implemented'),
('kick',2,'Syntax: .kick [$charactername]\r\n\r\nKick the given character name from the world. If no character name is provided then the selected player (except for yourself) will be kicked.'),
('learn',3,'Syntax: .learn #spell [all]\r\n\r\nSelected character learn a spell of id #spell. If \'all\' provided then all ranks learned.'),
('learn all',3,'Syntax: .learn all\r\n\r\nLearn all big set different spell maybe useful for Administrator.'),
('learn all_crafts',2,'Syntax: .learn crafts\r\n\r\nLearn all professions and recipes.'),
('learn all_default',1,'Syntax: .learn all_default [$playername]\r\n\r\nLearn for selected/$playername player all default spells for his race/class and spells rewarded by completed quests.'),
('learn all_gm',2,'Syntax: .learn all_gm\r\n\r\nLearn all default spells for Game Masters.'),
('learn all_lang',1,'Syntax: .learn all_lang\r\n\r\nLearn all languages'),
('learn all_myclass',3,'Syntax: .learn all_myclass\r\n\r\nLearn all spells and talents available for his class.'),
('learn all_myspells',3,'Syntax: .learn all_myspells\r\n\r\nLearn all spells (except talents and spells with first rank learned as talent) available for his class.'),
('learn all_mytalents',3,'Syntax: .learn all_mytalents\r\n\r\nLearn all talents (and spells with first rank learned as talent) available for his class.'),
('learn all_recipes',2,'Syntax: .learn all_recipes [$profession]\r\n\r\nLearns all recipes of specified profession and sets skill level to max.\r\nExample: .learn all_recipes enchanting'),
('levelup',3,'Syntax: .levelup [$playername] [#numberoflevels]\r\n\r\nIncrease/decrease the level of character with $playername (or the selected if not name provided) by #numberoflevels Or +1 if no #numberoflevels provided). If #numberoflevels is omitted, the level will be increase by 1. If #numberoflevels is 0, the same level will be restarted. If no character is selected and name not provided, increase your level. Command can be used for offline character. All stats and dependent values recalculated. At level decrease talents can be reset if need. Also at level decrease equipped items with greater level requirement can be lost.'),
('linkgrave',3,'Syntax: .linkgrave #graveyard_id [alliance|horde]\r\n\r\nLink current zone to graveyard for any (or alliance/horde faction ghosts). This let character ghost from zone teleport to graveyard after die if graveyard is nearest from linked to zone and accept ghost of this faction. Add only single graveyard at another map and only if no graveyards linked (or planned linked at same map).'),
('list creature',3,'Syntax: .list creature #creature_id [#max_count]\r\n\r\nOutput creatures with creature id #creature_id found in world. Output creature guids and coordinates sorted by distance from character. Will be output maximum #max_count creatures. If #max_count not provided use 10 as default value.'),
('list item',3,'Syntax: .list item #item_id [#max_count]\r\n\r\nOutput items with item id #item_id found in all character inventories, mails, auctions, and guild banks. Output item guids, item owner guid, owner account and owner name (guild name and guid in case guild bank). Will be output maximum #max_count items. If #max_count not provided use 10 as default value.'),
('list object',3,'Syntax: .list object #gameobject_id [#max_count]\r\n\r\nOutput gameobjects with gameobject id #gameobject_id found in world. Output gameobject guids and coordinates sorted by distance from character. Will be output maximum #max_count gameobject. If #max_count not provided use 10 as default value.'),
('list talents',3,'Syntax: .list talents\r\n\r\nShow list all really known (as learned spells) talent rank spells for selected player or self.'),
('loadscripts',3,'Syntax: .loadscripts $scriptlibraryname\r\n\r\nUnload current and load the script library $scriptlibraryname or reload current if $scriptlibraryname omitted, in case you changed it while the server was running.'),
('lookup account email',2,'Syntax: .lookup account email $emailpart [#limit] \r\n\r\nSearches accounts, which email including $emailpart with optional parameter #limit of results. If #limit not provided expected 100.'),
('lookup account ip',2,'Syntax: lookup account ip $ippart [#limit] \r\n\r\nSearches accounts, which last used ip including $ippart (textual) with optional parameter #$limit of results. If #limit not provided expected 100.'),
('lookup account name',2,'Syntax: .lookup account name $accountpart [#limit] \r\n\r\nSearches accounts, which username including $accountpart with optional parameter #limit of results. If #limit not provided expected 100.'),
('lookup area',1,'Syntax: .lookup area $namepart\r\n\r\nLooks up an area by $namepart, and returns all matches with their area ID\'s.'),
('lookup creature',3,'Syntax: .lookup creature $namepart\r\n\r\nLooks up a creature by $namepart, and returns all matches with their creature ID\'s.'),
('lookup event',2,'Syntax: .lookup event $name\r\n\r\nAttempts to find the ID of the event with the provided $name.'),
('lookup faction',3,'Syntax: .lookup faction $name\r\n\r\nAttempts to find the ID of the faction with the provided $name.'),
('lookup item',3,'Syntax: .lookup item $itemname\r\n\r\nLooks up an item by $itemname, and returns all matches with their Item ID\'s.'),
('lookup itemset',3,'Syntax: .lookup itemset $itemname\r\n\r\nLooks up an item set by $itemname, and returns all matches with their Item set ID\'s.'),
('lookup object',3,'Syntax: .lookup object $objname\r\n\r\nLooks up an gameobject by $objname, and returns all matches with their Gameobject ID\'s.'),
('lookup player account',2,'Syntax: .lookup player account $accountpart [#limit] \r\n\r\nSearches players, which account username including $accountpart with optional parameter #limit of results. If #limit not provided expected 100.'),
('lookup player email',2,'Syntax: .lookup player email $emailpart [#limit] \r\n\r\nSearches players, which account email including $emailpart with optional parameter #limit of results. If #limit not provided expected 100.'),
('lookup player ip',2,'Syntax: .lookup player ip $ippart [#limit] \r\n\r\nSearches players, which account last used ip inluding $ippart (textual) with optional parameter #limit of results. If #limit not provided expected 100.'),
('lookup pool',2,'Syntax: .lookup pool $pooldescpart\r\n\r\nList of pools (anywhere) with substring in description.'),
('lookup quest',3,'Syntax: .lookup quest $namepart\r\n\r\nLooks up a quest by $namepart, and returns all matches with their quest ID\'s.'),
('lookup skill',3,'Syntax: .lookup skill $$namepart\r\n\r\nLooks up a skill by $namepart, and returns all matches with their skill ID\'s.'),
('lookup spell',3,'Syntax: .lookup spell $namepart\r\n\r\nLooks up a spell by $namepart, and returns all matches with their spell ID\'s.'),
('lookup taxinode',3,'Syntax: .lookup taxinode $substring\r\n\r\nSearch and output all taxinodes with provide $substring in name.'),
('lookup tele',1,'Syntax: .lookup tele $substring\r\n\r\nSearch and output all .tele command locations with provide $substring in name.'),
('maxskill',3,'Syntax: .maxskill\r\n\r\nSets all skills of the targeted player to their maximum VALUESfor its current level.'),
('modify aspeed',1,'Syntax: .modify aspeed #rate\r\n\r\nModify all speeds -run,swim,run back,swim back- of the selected player to normal base speed for this move type*rate. If no player is selected, modify your speed. #rate may range from 0.1 to 10.'),
('modify bwalk',1,'Syntax: .modify bwalk #rate\r\n\r\nModify the speed of the selected player while running backwards to normal walk back speed*rate. If no player is selected, modify your speed. #rate may range from 0.1 to 10.'),
('modify drunk',1,'Syntax: .modify drunk #value\r\n\r\nSet drunk level to #value (0..100). Value 0 remove drunk state, 100 is max drunked state.'),
('modify energy',1,'Syntax: .modify energy #energy\r\n\r\nModify the energy of the selected player. If no player is selected, modify your energy.'),
('modify faction',1,'Syntax: .modify faction #factionid #flagid #npcflagid #dynamicflagid\r\n\r\nModify the faction and flags of the selected creature. Without arguments, display the faction and flags of the selected creature.'),
('modify gender',2,'Syntax: .modify gender male/female\r\n\r\nChange gender of selected player.'),
('modify honor',2,'Syntax: .modify honor $field $value\r\n\r\nAdd $value to an honor $field (it\'s just for debug , values won\'t be saved at player logout)\r\nField list: points / rank / todaykills / yesterdaykills / yesterdayhonor /thisweekkills / thisweekhonor / lastweekkills / lastweekhonor /lastweekstanding / lifetimedishonorablekills / lifetimehonorablekills '),
('modify hp',1,'Syntax: .modify hp #newhp\r\n\r\nModify the hp of the selected player. If no player is selected, modify your hp.'),
('modify mana',1,'Syntax: .modify mana #newmana\r\n\r\nModify the mana of the selected player. If no player is selected, modify your mana.'),
('modify money',1,'Syntax: .modify money #money\r\n\r\nAdd or remove money to the selected player. If no player is selected, modify your money. #gold can be negative to remove money.'),
('modify morph',2,'Syntax: .modify morph #displayid\r\n\r\nChange your current model id to #displayid.'),
('modify mount',1,'Syntax: .modify mount #id #speed\r\n\r\nDisplay selected player as mounted at #id creature and set speed to #speed value.'),
('modify rage',1,'Syntax: .modify rage #newrage\r\n\r\nModify the rage of the selected player. If no player is selected, modify your rage.'),
('modify rep',2,'Syntax: .modify rep #repId (#repvalue | $rankname [#delta])\r\n\r\nSets the selected players reputation with faction #repId to #repvalue or to $reprank.\r\nIf the reputation rank name is provided, the resulting reputation will be the lowest reputation for that rank plus the delta amount, if specified.You can use \'.pinfo rep\' to list all known reputation ids, or use \'.lookup faction $name\' to locate a specific faction id.'),
('modify scale',1,'Syntax: .modify scale #scale\r\n\r\nChange model scale for targeted player (util relogin) or creature (until respawn).'),
('modify speed',1,'Syntax: .modify speed #rate\r\n\r\nModify the running speed of the selected player to normal base run speed*rate. If no player is selected, modify your speed. #rate may range from 0.1 to 10.'),
('modify standstate',2,'Syntax: .modify standstate #emoteid\r\n\r\nChange the emote of your character while standing to #emoteid.'),
('modify swim',1,'Syntax: .modify swim #rate\r\n\r\nModify the swim speed of the selected player to normal swim speed*rate. If no player is selected, modify your speed. #rate may range from 0.1 to 10.'),
('movegens',3,'Syntax: .movegens\r\n\r\nShow movement generators stack for selected creature or player.'),
('mute',1,'Syntax: .mute [$playerName] $timeInMinutes\r\n\r\nDisable chat messaging for any character from account of character $playerName (or currently selected) at $timeInMinutes minutes. Player can be offline.'),
('neargrave',3,'Syntax: .neargrave [alliance|horde]\r\n\r\nFind nearest graveyard linked to zone (or only nearest from accepts alliance or horde faction ghosts).'),
('notify',1,'Syntax: .notify $MessageToBroadcast\r\n\r\nSend a global message to all players online in screen.'),
('npc add',2,'Syntax: .npc add #creatureid\r\n\r\nSpawn a creature by the given template id of #creatureid.'),
('npc additem',2,'Syntax: .npc additem #itemId <#maxcount><#incrtime>r\r\n\r\nAdd item #itemid to item list of selected vendor. Also optionally set max count item in vendor item list and time to item count restoring.'),
('npc addmove',2,'Syntax: .npc addmove #creature_guid [#waittime]\r\n\r\nAdd your current location as a waypoint for creature with guid #creature_guid. And optional add wait time.'),
('npc addweapon',3,'Not yet implemented.'),
('npc aiinfo',2,'Syntax: .npc npc aiinfo\r\n\r\nShow npc AI and script information.'),
('npc allowmove',3,'Syntax: .npc allowmove\r\n\r\nEnable or disable movement creatures in world. Not implemented.'),
('npc changelevel',2,'Syntax: .npc changelevel #level\r\n\r\nChange the level of the selected creature to #level.#level may range from 1 to 63.'),
('npc delete',2,'Syntax: .npc delete [#guid]\r\n\r\nDelete creature with guid #guid (or the selected if no guid is provided)'),
('npc delitem',2,'Syntax: .npc delitem #itemId\r\n\r\nRemove item #itemid from item list of selected vendor.'),
('npc factionid',2,'Syntax: .npc factionid #factionid\r\n\r\nSet the faction of the selected creature to #factionid.'),
('npc flag',2,'Syntax: .npc flag #npcflag\r\n\r\nSet the NPC flags of creature template of the selected creature and selected creature to #npcflag. NPC flags will applied to all creatures of selected creature template after server restart or grid unload/load.'),
('npc follow',2,'Syntax: .npc follow\r\n\r\nSelected creature start follow you until death/fight/etc.'),
('npc info',3,'Syntax: .npc info\r\n\r\nDisplay a list of details for the selected creature.\r\nThe list includes:\r\n- GUID, Faction, NPC flags, Entry ID, Model ID,\r\n- Level,\r\n- Health (current/maximum),\r\n- Field flags, dynamic flags, faction template,\r\n- Position information,\r\n- and the creature type, e.g. if the creature is a vendor.'),
('npc move',2,'Syntax: .npc move [#creature_guid]\r\n\r\nMove the targeted creature spawn point to your coordinates.'),
('npc name',2,'Syntax: .npc name $name\r\n\r\nChange the name of the selected creature or character to $name.Command disabled.'),
('npc playemote',3,'Syntax: .npc playemote #emoteid\r\n\r\nMake the selected creature emote with an emote of id #emoteid.'),
('npc say',1,'Syntax: .npc say #text\r\n\r\nMake the selected npc says #text.'),
('npc setdeathstate',2,'Syntax: .npc setdeathstate on/off\r\n\r\nSet default death state (dead/alive) for npc at spawn.'),
('npc setmodel',2,'Syntax: .npc setmodel #displayid\r\n\r\nChange the model id of the selected creature to #displayid.'),
('npc setmovetype',2,'Syntax: .npc setmovetype [#creature_guid] stay/random/way [NODEL]\r\n\r\nSet for creature pointed by #creature_guid (or selected if #creature_guid not provided) movement type and move it to respawn position (if creature alive). Any existing waypoints for creature will be removed from the database if you do not use NODEL. If the creature is dead then movement type will applied at creature respawn.\r\n\r\nMake sure you use NODEL, if you want to keep the waypoints.'),
('npc spawndist',2,'Syntax: .npc spawndist #dist\r\n\r\nAdjust spawndistance of selected creature to dist.'),
('npc spawntime',2,'Syntax: .npc spawntime #time\r\n\r\nAdjust spawntime of selected creature to time.'),
('npc subname',2,'Syntax: .npc subname $Name\r\n\r\nChange the subname of the selected creature or player to $Name.\r\nCommand disabled.'),
('npc tame',2,'Syntax: .npc tame\r\n\r\nTame selected creature (tameable non pet creature). You must not have pet.'),
('npc textemote',1,'Syntax: .npc textemote #emoteid\r\n\r\nMake the selected creature to do textemote with an emote of id #emoteid.'),
('npc unfollow',2,'Syntax: .npc unfollow\r\n\r\nSelected creature (non pet) stop follow you.'),
('npc whisper',1,'Syntax: .npc whisper #playerguid #text\r\n\r\nMake the selected npc whisper #text to  #playerguid.'),
('npc yell',1,'Syntax: .npc yell #text\r\n\r\nMake the selected npc yells #text.'),
('pdump load',3,'Syntax: .pdump load $filename $account [$newname] [$newguid]\r\n\r\nLoad character dump from dump file into character list of $account with saved or $newname, with saved (or first free) or $newguid guid.'),
('pdump write',3,'Syntax: .pdump write $filename $playerNameOrGUID\r\n\r\nWrite character dump with name/guid $playerNameOrGUID to file $filename.'),
('pinfo',2,'Syntax: .pinfo [$player_name]\r\n\r\nOutput account information for selected player or player find by $player_name.'),
('pool',2,'Syntax: .pool #pool_id\r\n\r\nPool information and full list creatures/gameobjects included in pool.'),
('pool list',2,'Syntax: .pool list\r\n\r\nList of pools with spawn in current map (only work in instances. Non-instanceable maps share pool system state os useless attempt get all pols at all continents.'),
('pool spawns',2,'Syntax: .pool spawns #pool_id\r\n\r\nList current creatures/objects listed in pools (or in specific #pool_id) and spawned (added to grid data, not meaning show in world.'),
('quest add',3,'Syntax: .quest add #quest_id\r\n\r\nAdd to character quest log quest #quest_id. Quest started from item can\'t be added by this command but correct .additem call provided in command output.'),
('quest complete',3,'Syntax: .quest complete #questid\r\n\r\nMark all quest objectives as completed for target character active quest. After this target character can go and get quest reward.'),
('quest remove',3,'Syntax: .quest remove #quest_id\r\n\r\nSet quest #quest_id state to not completed and not active (and remove from active quest list) for selected player.'),
('quit',4,'Syntax: quit\r\n\r\nClose RA connection. Command must be typed fully (quit).'),
('recall',1,'Syntax: .recall [$playername]\r\n\r\nTeleport $playername or selected player to the place where he has been before last use of a teleportation command. If no $playername is entered and no player is selected, it will teleport you.'),
('reload all',3,'Syntax: .reload all\r\n\r\nReload all tables with reload support added and that can be _safe_ reloaded.'),
('reload all_area',3,'Syntax: .reload all_area\r\n\r\nReload all `areatrigger_*` tables if reload support added for this table and this table can be _safe_ reloaded.'),
('reload all_eventai',3,'Syntax: .reload all_eventai\r\n\r\nReload `creature_ai_*` tables if reload support added for these tables and these tables can be _safe_ reloaded.'),
('reload all_item',3,'Syntax: .reload all_item\r\n\r\nReload `item_required_target`, `page_texts` and `item_enchantment_template` tables.'),
('reload all_locales',3,'Syntax: .reload all_locales\r\n\r\nReload all `locales_*` tables with reload support added and that can be _safe_ reloaded.'),
('reload all_loot',3,'Syntax: .reload all_loot\r\n\r\nReload all `*_loot_template` tables. This can be slow operation with lags for server run.'),
('reload all_npc',3,'Syntax: .reload all_npc\r\n\r\nReload `points_of_interest` and `npc_*` tables if reload support added for these tables and these tables can be _safe_ reloaded.'),
('reload all_quest',3,'Syntax: .reload all_quest\r\n\r\nReload all quest related tables if reload support added for this table and this table can be _safe_ reloaded.'),
('reload all_scripts',3,'Syntax: .reload all_scripts\r\n\r\nReload `dbscripts_on_*` tables.'),
('reload all_spell',3,'Syntax: .reload all_spell\r\n\r\nReload all `spell_*` tables with reload support added and that can be _safe_ reloaded.'),
('reload config',3,'Syntax: .reload config\r\n\r\nReload config settings (by default stored in mangosd.conf). Not all settings can be change at reload: some new setting values will be ignored until restart, some values will applied with delay or only to new objects/maps, some values will explicitly rejected to change at reload.'),
('repairitems',2,'Syntax: .repairitems\r\n\r\nRepair all selected player\'s items.'),
('reset all',3,'Syntax: .reset all spells\r\nSyntax: .reset all talents\r\n\r\nRequest reset spells or talents at next login each existed character.'),
('reset honor',3,'Syntax: .reset honor [Playername]\r\n\r\nReset all honor data for targeted character.'),
('reset level',3,'Syntax: .reset level [Playername]\r\n\r\nReset level to 1 including reset stats and talents.  Equipped items with greater level requirement can be lost.'),
('reset spells',3,'Syntax: .reset spells [Playername]\r\n\r\nRemoves all non-original spells from spellbook.. Playername can be name of offline character.'),
('reset stats',3,'Syntax: .reset stats [Playername]\r\n\r\nResets(recalculate) all stats of the targeted player to their original VALUESat current level.'),
('reset talents',3,'Syntax: .reset talents [Playername]\r\n\r\nRemoves all talents of the targeted player. Playername can be name of offline character.'),
('respawn',3,'Syntax: .respawn\r\n\r\nRespawn selected creature or respawn all nearest creatures (if none selected) and GO without waiting respawn time expiration.'),
('revive',3,'Syntax: .revive\r\n\r\nRevive the selected player. If no player is selected, it will revive you.'),
('save',0,'Syntax: .save\r\n\r\nSaves your character.'),
('saveall',1,'Syntax: .saveall\r\n\r\nSave all characters in game.'),
('send items',3,'Syntax: .send items #playername \"#subject\" \"#text\" itemid1[:count1] itemid2[:count2] ... itemidN[:countN]\r\n\r\nSend a mail to a player. Subject and mail text must be in quotes. If for itemid not provided related count values then expected 1, if count > max items in stack then items will be send in required amount stacks. All stacks amount in mail limited to 12.'),
('send mail',1,'Syntax: .send mail #playername \"#subject\" \"#text\"\r\n\r\nSend a mail to a player. Subject and mail text must be in quotes.'),
('send mass items',3,'Syntax: .send mass items #racemask|$racename|alliance|horde|all \"#subject\" \"#text\" itemid1[:count1] itemid2[:count2] ... itemidN[:countN]\r\n\r\nSend a mail to players. Subject and mail text must be in quotes. If for itemid not provided related count values then expected 1, if count > max items in stack then items will be send in required amount stacks. All stacks amount in mail limited to 12.'),
('send mass mail',3,'Syntax: .send mass mail #racemask|$racename|alliance|horde|all \"#subject\" \"#text\"\r\n\r\nSend a mail to players. Subject and mail text must be in quotes.'),
('send mass money',3,'Syntax: .send mass money #racemask|$racename|alliance|horde|all \"#subject\" \"#text\" #money\r\n\r\nSend mail with money to players. Subject and mail text must be in quotes.'),
('send message',3,'Syntax: .send message $playername $message\r\n\r\nSend screen message to player from ADMINISTRATOR.'),
('send money',3,'Syntax: .send money #playername \"#subject\" \"#text\" #money\r\n\r\nSend mail with money to a player. Subject and mail text must be in quotes.'),
('server corpses',2,'Syntax: .server corpses\r\n\r\nTriggering corpses expire check in world.'),
('server exit',4,'Syntax: .server exit\r\n\r\nTerminate mangosd NOW. Exit code 0.'),
('server idlerestart',3,'Syntax: .server idlerestart #delay\r\n\r\nRestart the server after #delay seconds if no active connections are present (no players). Use #exist_code or 2 as program exist code.'),
('server idlerestart cancel',3,'Syntax: .server idlerestart cancel\r\n\r\nCancel the restart/shutdown timer if any.'),
('server idleshutdown',3,'Syntax: .server idleshutdown #delay [#exist_code]\r\n\r\nShut the server down after #delay seconds if no active connections are present (no players). Use #exist_code or 0 as program exist code.'),
('server idleshutdown cancel',3,'Syntax: .server idleshutdown cancel\r\n\r\nCancel the restart/shutdown timer if any.'),
('server info',0,'Syntax: .server info\r\n\r\nDisplay server version and the number of connected players.'),
('server log filter',4,'Syntax: .server log filter [($filtername|all) (on|off)]\r\n\r\nShow or set server log filters. If used \"all\" then all filters will be set to on/off state.'),
('server log level',4,'Syntax: .server log level [#level]\r\n\r\nShow or set server log level (0 - errors only, 1 - basic, 2 - detail, 3 - debug).'),
('server motd',0,'Syntax: .server motd\r\n\r\nShow server Message of the day.'),
('server plimit',3,'Syntax: .server plimit [#num|-1|-2|-3|reset|player|moderator|gamemaster|administrator]\r\n\r\nWithout arg show current player amount and security level limitations for login to server, with arg set player linit ($num > 0) or securiti limitation ($num < 0 or security leme name. With `reset` sets player limit to the one in the config file'),
('server restart',3,'Syntax: .server restart #delay\r\n\r\nRestart the server after #delay seconds. Use #exist_code or 2 as program exist code.'),
('server restart cancel',3,'Syntax: .server restart cancel\r\n\r\nCancel the restart/shutdown timer if any.'),
('server set motd',3,'Syntax: .server set motd $MOTD\r\n\r\nSet server Message of the day.'),
('server shutdown',3,'Syntax: .server shutdown #delay [#exit_code]\r\n\r\nShut the server down after #delay seconds. Use #exit_code or 0 as program exit code.'),
('server shutdown cancel',3,'Syntax: .server shutdown cancel\r\n\r\nCancel the restart/shutdown timer if any.'),
('setskill',3,'Syntax: .setskill #skill #level [#max]\r\n\r\nSet a skill of id #skill with a current skill value of #level and a maximum value of #max (or equal current maximum if not provide) for the selected character. If no character is selected, you learn the skill.'),
('showarea',3,'Syntax: .showarea #areaid\r\n\r\nReveal the area of #areaid to the selected character. If no character is selected, reveal this area to you.'),
('stable',3,'Syntax: .stable\r\n\r\nShow your pet stable.'),
('start',0,'Syntax: .start\r\n\r\nTeleport you to the starting area of your character.'),
('summon',1,'Syntax: .summon [$charactername]\r\n\r\nTeleport the given character to you. Character can be offline.'),
('taxicheat',1,'Syntax: .taxicheat on/off\r\n\r\nTemporary grant access or remove to all taxi routes for the selected character. If no character is selected, hide or reveal all routes to you.Visited taxi nodes sill accessible after removing access.'),
('tele',1,'Syntax: .tele #location\r\n\r\nTeleport player to a given location.'),
('tele add',3,'Syntax: .tele add $name\r\n\r\nAdd current your position to .tele command target locations list with name $name.'),
('tele del',3,'Syntax: .tele del $name\r\n\r\nRemove location with name $name for .tele command locations list.'),
('tele group',1,'Syntax: .tele group #location\r\n\r\nTeleport a selected player and his group members to a given location.'),
('tele name',1,'Syntax: .tele name [#playername] #location\r\n\r\nTeleport the given character to a given location. Character can be offline.'),
('ticket',2,'Syntax: .ticket on\r\n        .ticket off\r\n        .ticket system_on\r\n        .ticket system_off\r\n        .ticket #num\r\n        .ticket $character_name\r\n        .ticket respond/response/whisper #num $response\r\n        .ticket respond/response/whisper $character_name $response\r\n        .ticket close $character_name\r\n        .ticket close #num\r\n        .ticket close_survey #num\r\n        .ticket close_survey $character_name\r\n\r\non/off for GMs to show or not a new ticket directly, $character_name to show ticket of this character, #num to show ticket #num, close to close the given ticket, close_survey to close the given ticket and have the player answer a survey about the gm, system_on/off to globally turn off accepting tickets, will show a message to the client if off that you cant file a ticket if off'),
('trigger',2,'Syntax: .trigger [#trigger_id|$trigger_shift-link|$trigger_target_shift-link]\r\n\r\nShow detail infor about areatrigger with id #trigger_id or trigger id associated with shift-link. If areatrigger id or shift-link not provided then selected nearest areatrigger at current map.'),
('trigger active',2,'Syntax: .trigger active\r\n\r\nShow list of areatriggers with activation zone including current character position.'),
('trigger near',2,'Syntax: .trigger near [#distance]\r\n\r\nOutput areatriggers at distance #distance from player. If #distance not provided use 10 as default value.'),
('unaura',3,'Syntax: .unaura #spellid\r\n\r\nRemove aura due to spell #spellid from the selected Unit.'),
('unban account',3,'Syntax: .unban account $Name\r\n\r\nUnban accounts for account name pattern.'),
('unban character',3,'Syntax: .unban character $Name\r\n\r\nUnban accounts for character name pattern.'),
('unban ip',3,'Syntax : .unban ip $Ip\r\n\r\nUnban accounts for IP pattern.'),
('unlearn',3,'Syntax: .unlearn #spell [all]\r\n\r\nUnlearn for selected player a spell #spell.  If \'all\' provided then all ranks unlearned.'),
('unmute',1,'Syntax: .unmute $playerName\r\n\r\nRestore chat messaging for any character from account of character $playerName.'),
('waterwalk',2,'Syntax: .waterwalk on/off\r\n\r\nSet on/off waterwalk state for selected player.'),
('wchange',3,'Syntax: .wchange #weathertype #status\r\n\r\nSet current weather to #weathertype with an intensity of #status.\r\n#weathertype can be 1 for rain, 2 for snow, and 3 for sand. #status can be 0 for disabled, and 1 for enabled.'),
('whispers',1,'Syntax: .whispers on|off\r\n\r\nEnable/disable accepting whispers by GM from players. By default use mangosd.conf setting.'),
('wp add',2,'Syntax: .wp add [#creature_guid or Select a Creature]'),
('wp export',3,'Syntax: .wp export [#creature_guid or Select a Creature] $filename'),
('wp import',3,'Syntax: .wp import $filename'),
('wp modify',2,'Syntax: .wp modify [#creature_guid or Select a Creature]\r\nadd - Add a waypoint after the selected visualwaittime $timeemote IDspell IDtext1| text2| text3| text4| text5 <text>model1 IDmodel2 IDmove(moves wp to player pos)del (deletes the wp)\r\nOnly one parameter per time!'),
('wp show',2,'Syntax: .wp show [#creature_guid or Select a Creature]\r\nwhere command can have one of the following values\r\non (to show all related wp)\r\nfirst (to see only first one)\r\nlast (to see only last one)\r\noff (to hide all related wp)\r\ninfo (to get more info about theses wp)\r\n\r\nFor using info you have to do first show on and than select a Visual-Waypoint and do the show info!');
/*!40000 ALTER TABLE `command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `condition_entry` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'Type of the condition',
  `value1` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'data field one for the condition',
  `value2` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'data field two for the condition',
  PRIMARY KEY (`condition_entry`),
  UNIQUE KEY `unique_conditions` (`type`,`value1`,`value2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Condition System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature`
--

DROP TABLE IF EXISTS `creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature` (
  `guid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `modelid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipment_id` mediumint(9) NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `spawntimesecs` int(10) unsigned NOT NULL DEFAULT '120',
  `spawndist` float NOT NULL DEFAULT '5',
  `currentwaypoint` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `curhealth` int(10) unsigned NOT NULL DEFAULT '1',
  `curmana` int(10) unsigned NOT NULL DEFAULT '0',
  `DeathState` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MovementType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `idx_map` (`map`),
  KEY `index_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6491096 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_addon`
--

DROP TABLE IF EXISTS `creature_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_addon` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `mount` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `bytes1` int(10) unsigned NOT NULL DEFAULT '0',
  `b2_0_sheath` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b2_1_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` int(10) unsigned NOT NULL DEFAULT '0',
  `moveflags` int(10) unsigned NOT NULL DEFAULT '0',
  `auras` text,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_ai_scripts`
--

DROP TABLE IF EXISTS `creature_ai_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_scripts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `creature_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Template Identifier',
  `event_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type',
  `event_inverse_phase_mask` int(11) NOT NULL DEFAULT '0' COMMENT 'Mask which phases this event will not trigger in',
  `event_chance` int(3) unsigned NOT NULL DEFAULT '100',
  `event_flags` int(3) unsigned NOT NULL DEFAULT '0',
  `event_param1` int(11) NOT NULL DEFAULT '0',
  `event_param2` int(11) NOT NULL DEFAULT '0',
  `event_param3` int(11) NOT NULL DEFAULT '0',
  `event_param4` int(11) NOT NULL DEFAULT '0',
  `action1_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type',
  `action1_param1` int(11) NOT NULL DEFAULT '0',
  `action1_param2` int(11) NOT NULL DEFAULT '0',
  `action1_param3` int(11) NOT NULL DEFAULT '0',
  `action2_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type',
  `action2_param1` int(11) NOT NULL DEFAULT '0',
  `action2_param2` int(11) NOT NULL DEFAULT '0',
  `action2_param3` int(11) NOT NULL DEFAULT '0',
  `action3_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type',
  `action3_param1` int(11) NOT NULL DEFAULT '0',
  `action3_param2` int(11) NOT NULL DEFAULT '0',
  `action3_param3` int(11) NOT NULL DEFAULT '0',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT 'Event Comment',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=576403 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='EventAI Scripts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_ai_summons`
--

DROP TABLE IF EXISTS `creature_ai_summons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_summons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Location Identifier',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `spawntimesecs` int(11) unsigned NOT NULL DEFAULT '120',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT 'Summon Comment',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='EventAI Summoning Locations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_ai_texts`
--

DROP TABLE IF EXISTS `creature_ai_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_texts` (
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Script Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_battleground`
--

DROP TABLE IF EXISTS `creature_battleground`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_battleground` (
  `guid` int(10) unsigned NOT NULL COMMENT 'Creature''s GUID',
  `event1` tinyint(3) unsigned NOT NULL COMMENT 'main event',
  `event2` tinyint(3) unsigned NOT NULL COMMENT 'sub event',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature battleground indexing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_equip_template`
--

DROP TABLE IF EXISTS `creature_equip_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_equip_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique entry',
  `equipentry1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipentry2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipentry3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`),
  UNIQUE KEY `unique_template` (`equipentry1`,`equipentry2`,`equipentry3`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Equipment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_equip_template_raw`
--

DROP TABLE IF EXISTS `creature_equip_template_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_equip_template_raw` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique entry',
  `equipmodel1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipmodel2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipmodel3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipinfo1` int(10) unsigned NOT NULL DEFAULT '0',
  `equipinfo2` int(10) unsigned NOT NULL DEFAULT '0',
  `equipinfo3` int(10) unsigned NOT NULL DEFAULT '0',
  `equipslot1` int(11) NOT NULL DEFAULT '0',
  `equipslot2` int(11) NOT NULL DEFAULT '0',
  `equipslot3` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Creature System (Equipment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_involvedrelation`
--

DROP TABLE IF EXISTS `creature_involvedrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_involvedrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_item_template`
--

DROP TABLE IF EXISTS `creature_item_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_item_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned DEFAULT '0',
  `subclass` tinyint(3) unsigned DEFAULT '0',
  `material` mediumint(8) unsigned DEFAULT '0',
  `displayid` mediumint(8) unsigned DEFAULT '0',
  `inventory_type` tinyint(3) unsigned DEFAULT '0',
  `sheath_type` tinyint(3) unsigned DEFAULT '0',
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
  `guid` int(10) unsigned NOT NULL COMMENT 'creature.guid of the slave mob that is linked',
  `master_guid` int(10) unsigned NOT NULL COMMENT 'master to trigger events',
  `flag` mediumint(8) unsigned NOT NULL COMMENT 'flag - describing what should happen when',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature Linking System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_linking_template`
--

DROP TABLE IF EXISTS `creature_linking_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_linking_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'creature_template.entry of the slave mob that is linked',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Id of map of the mobs',
  `master_entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'master to trigger events',
  `flag` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'flag - describing what should happen when',
  `search_range` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'search_range - describing in which range (spawn-coords) master and slave are linked together',
  PRIMARY KEY (`entry`,`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature Linking System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_loot_template`
--

DROP TABLE IF EXISTS `creature_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'entry 0 used for player insignia loot',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_model_info`
--

DROP TABLE IF EXISTS `creature_model_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_model_info` (
  `modelid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `bounding_radius` float NOT NULL DEFAULT '0',
  `combat_reach` float NOT NULL DEFAULT '0',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `modelid_other_gender` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `modelid_other_team` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`modelid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Creature System (Model related info)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_movement`
--

DROP TABLE IF EXISTS `creature_movement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_movement` (
  `id` int(10) unsigned NOT NULL COMMENT 'Creature GUID',
  `point` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `waittime` int(10) unsigned NOT NULL DEFAULT '0',
  `script_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `textid1` int(11) NOT NULL DEFAULT '0',
  `textid2` int(11) NOT NULL DEFAULT '0',
  `textid3` int(11) NOT NULL DEFAULT '0',
  `textid4` int(11) NOT NULL DEFAULT '0',
  `textid5` int(11) NOT NULL DEFAULT '0',
  `emote` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `wpguid` int(11) NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `model1` mediumint(9) NOT NULL DEFAULT '0',
  `model2` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_movement_template`
--

DROP TABLE IF EXISTS `creature_movement_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_movement_template` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'Creature entry',
  `point` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `waittime` int(10) unsigned NOT NULL DEFAULT '0',
  `script_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `textid1` int(11) NOT NULL DEFAULT '0',
  `textid2` int(11) NOT NULL DEFAULT '0',
  `textid3` int(11) NOT NULL DEFAULT '0',
  `textid4` int(11) NOT NULL DEFAULT '0',
  `textid5` int(11) NOT NULL DEFAULT '0',
  `emote` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `wpguid` int(11) NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `model1` mediumint(9) NOT NULL DEFAULT '0',
  `model2` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature waypoint system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_onkill_reputation`
--

DROP TABLE IF EXISTS `creature_onkill_reputation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_onkill_reputation` (
  `creature_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `RewOnKillRepFaction1` smallint(6) NOT NULL DEFAULT '0',
  `RewOnKillRepFaction2` smallint(6) NOT NULL DEFAULT '0',
  `MaxStanding1` tinyint(4) NOT NULL DEFAULT '0',
  `IsTeamAward1` tinyint(4) NOT NULL DEFAULT '0',
  `RewOnKillRepValue1` mediumint(9) NOT NULL DEFAULT '0',
  `MaxStanding2` tinyint(4) NOT NULL DEFAULT '0',
  `IsTeamAward2` tinyint(4) NOT NULL DEFAULT '0',
  `RewOnKillRepValue2` mediumint(9) NOT NULL DEFAULT '0',
  `TeamDependent` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`creature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature OnKill Reputation gain';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_questrelation`
--

DROP TABLE IF EXISTS `creature_questrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_questrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_template`
--

DROP TABLE IF EXISTS `creature_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template` (
  `Entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Name` char(100) NOT NULL DEFAULT '',
  `SubName` char(100) DEFAULT NULL,
  `MinLevel` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `MaxLevel` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `ModelId1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ModelId2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `FactionAlliance` smallint(5) unsigned NOT NULL DEFAULT '0',
  `FactionHorde` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Scale` float NOT NULL DEFAULT '1',
  `Family` tinyint(4) NOT NULL DEFAULT '0',
  `CreatureType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `InhabitType` tinyint(3) unsigned NOT NULL DEFAULT '3',
  `RegenerateStats` tinyint(3) unsigned DEFAULT NULL,
  `RacialLeader` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `NpcFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `UnitFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `DynamicFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `ExtraFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `CreatureTypeFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `SpeedWalk` float NOT NULL DEFAULT '1',
  `SpeedRun` float NOT NULL DEFAULT '1.14286',
  `UnitClass` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Rank` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `HealthMultiplier` float NOT NULL DEFAULT '1',
  `ManaMultiplier` float NOT NULL DEFAULT '1',
  `DamageMultiplier` float NOT NULL DEFAULT '1',
  `DamageVariance` float NOT NULL DEFAULT '1',
  `ArmorMultiplier` float NOT NULL DEFAULT '1',
  `ExperienceMultiplier` float NOT NULL DEFAULT '1',
  `MinLevelHealth` int(10) unsigned NOT NULL DEFAULT '0',
  `MaxLevelHealth` int(10) unsigned NOT NULL DEFAULT '0',
  `MinLevelMana` int(10) unsigned NOT NULL DEFAULT '0',
  `MaxLevelMana` int(10) unsigned NOT NULL DEFAULT '0',
  `MinMeleeDmg` float NOT NULL DEFAULT '0',
  `MaxMeleeDmg` float NOT NULL DEFAULT '0',
  `MinRangedDmg` float NOT NULL DEFAULT '0',
  `MaxRangedDmg` float NOT NULL DEFAULT '0',
  `Armor` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `MeleeAttackPower` int(10) unsigned NOT NULL DEFAULT '0',
  `RangedAttackPower` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MeleeBaseAttackTime` int(10) unsigned NOT NULL DEFAULT '2000',
  `RangedBaseAttackTime` int(10) unsigned NOT NULL DEFAULT '2000',
  `DamageSchool` tinyint(4) NOT NULL DEFAULT '0',
  `MinLootGold` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `MaxLootGold` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `LootId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `PickpocketLootId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `SkinningLootId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `KillCredit1` int(11) unsigned NOT NULL DEFAULT '0',
  `KillCredit2` int(11) unsigned NOT NULL DEFAULT '0',
  `MechanicImmuneMask` int(10) unsigned NOT NULL DEFAULT '0',
  `ResistanceHoly` smallint(5) NOT NULL DEFAULT '0',
  `ResistanceFire` smallint(5) NOT NULL DEFAULT '0',
  `ResistanceNature` smallint(5) NOT NULL DEFAULT '0',
  `ResistanceFrost` smallint(5) NOT NULL DEFAULT '0',
  `ResistanceShadow` smallint(5) NOT NULL DEFAULT '0',
  `ResistanceArcane` smallint(5) NOT NULL DEFAULT '0',
  `PetSpellDataId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `MovementType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TrainerType` tinyint(4) NOT NULL DEFAULT '0',
  `TrainerSpell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `TrainerClass` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TrainerRace` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TrainerTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `VendorTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `GossipMenuId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `EquipmentTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Civilian` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AIName` char(64) DEFAULT '',
  `ScriptName` char(64) DEFAULT '',
  PRIMARY KEY (`Entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_template`
--

LOCK TABLES `creature_template` WRITE;
/*!40000 ALTER TABLE `creature_template` DISABLE KEYS */;
INSERT INTO `creature_template` VALUES
(1,'Waypoint (Only GM can see it)','Visual',63,63,10045,0,35,35,0,8,8,7,1,0,0,4096,0,130,5242886,0.91,1.14286,0,3,1,1,1,1,1,1,9999,9999,0,0,7,7,1.76,2.42,0,3,100,2000,2200,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','');
/*!40000 ALTER TABLE `creature_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_template_addon`
--

DROP TABLE IF EXISTS `creature_template_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template_addon` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `mount` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `bytes1` int(10) unsigned NOT NULL DEFAULT '0',
  `b2_0_sheath` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `b2_1_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `moveflags` int(10) unsigned NOT NULL DEFAULT '0',
  `auras` text,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creature_template_classlevelstats`
--

DROP TABLE IF EXISTS `creature_template_classlevelstats`;

CREATE TABLE `creature_template_classlevelstats` (
  `Level` tinyint(4) NOT NULL,
  `Class` tinyint(4) NOT NULL,
  `BaseHealthExp0` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `BaseMana` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `BaseDamageExp0` float NOT NULL DEFAULT '0',
  `BaseMeleeAttackPower` float NOT NULL DEFAULT '0',
  `BaseRangedAttackPower` float NOT NULL DEFAULT '0',
  `BaseArmor` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Level`,`Class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `creature_template_spells`
--

DROP TABLE IF EXISTS `creature_template_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template_spells` (
  `entry` mediumint(8) unsigned NOT NULL,
  `spell1` mediumint(8) unsigned NOT NULL,
  `spell2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature System (Spells used by creature)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_texts`
--

DROP TABLE IF EXISTS `custom_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_texts` (
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Custom Texts';

--
-- Table structure for table `db_script_string`
--

DROP TABLE IF EXISTS `db_script_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_script_string` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0',
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*Table structure for table `dbdocsfields` */

DROP TABLE IF EXISTS `dbdocsfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbdocsfields` (
  `fieldId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique Id for this field',
  `languageId` int(11) NOT NULL DEFAULT '0' COMMENT 'dbdocsLanguageId to link to. (Normallu 0 = English)',
  `tableName` varchar(80) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the table to link to',
  `fieldName` varchar(80) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the field to link the note to',
  `fieldComment` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Main field Note',
  `fieldNotes` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Additional Field Notes',
  PRIMARY KEY (`fieldId`,`languageId`),
  KEY `fieldId` (`fieldId`)
) ENGINE=InnoDB AUTO_INCREMENT=1764 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `dbdocsfields_localised`
--
DROP TABLE IF EXISTS `dbdocsfields_localised`;

CREATE TABLE `dbdocsfields_localised` (
  `fieldId` int(11) NOT NULL COMMENT 'dbdocsfields.fieldId to link to.',
  `languageId` int(11) NOT NULL COMMENT 'dbdocsLanguageId to link to. (Normallu 0 = English)',
  `fieldNotes` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Additional Field Notes',
  `fieldComment` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Main field Note',
  PRIMARY KEY (`fieldId`,`languageId`),
  KEY `fieldId` (`fieldId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `dbdocsfields_localised` */
LOCK TABLES `dbdocsfields_localised` WRITE;
/*!40000 ALTER TABLE `dbdocsfields_localised` DISABLE KEYS */;

/*!40000 ALTER TABLE `dbdocsfields_localised` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbdocslanguage`
--
DROP TABLE IF EXISTS `dbdocslanguage`;

CREATE TABLE `dbdocslanguage` (
  `LanguageId` int(11) NOT NULL COMMENT 'LanguageId for this Language',
  `LanguageName` varchar(30) NOT NULL COMMENT 'The Language Name',
  PRIMARY KEY (`LanguageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dbdocslanguage` */
LOCK TABLES `dbdocslanguage` WRITE;
/*!40000 ALTER TABLE `dbdocslanguage` DISABLE KEYS */;
insert  into `dbdocslanguage`(`LanguageId`,`LanguageName`) values (0,'English');
insert  into `dbdocslanguage`(`LanguageId`,`LanguageName`) values (1,'Korean');
insert  into `dbdocslanguage`(`LanguageId`,`LanguageName`) values (2,'French');
insert  into `dbdocslanguage`(`LanguageId`,`LanguageName`) values (3,'German');
insert  into `dbdocslanguage`(`LanguageId`,`LanguageName`) values (4,'Chinese');
insert  into `dbdocslanguage`(`LanguageId`,`LanguageName`) values (5,'Taiwanese');
insert  into `dbdocslanguage`(`LanguageId`,`LanguageName`) values (6,'Spanish (Spain)');
insert  into `dbdocslanguage`(`LanguageId`,`LanguageName`) values (7,'Spanish (Latin America)');
insert  into `dbdocslanguage`(`LanguageId`,`LanguageName`) values (8,'Russian');
/*!40000 ALTER TABLE `dbdocslanguage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbdocsprogressquests`
--
DROP TABLE IF EXISTS `dbdocsprogressquests`;

CREATE TABLE `dbdocsprogressquests` (
  `QuestID` int(11) NOT NULL COMMENT 'The Quest ID to link to',
  `Progress` int(11) NOT NULL DEFAULT '0' COMMENT 'The percentage of how complete the quest is',
  `QuestNotes` text COMMENT 'Notes about the Quest',
  PRIMARY KEY (`QuestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `dbdocssubtables`
--
DROP TABLE IF EXISTS `dbdocssubtables`;

CREATE TABLE `dbdocssubtables` (
  `subTableId` int(11) NOT NULL COMMENT 'Unique Lookup Id',
  `languageId` int(11) NOT NULL DEFAULT '0' COMMENT 'dbdocsLanguageId to link to. (Normally 0 = English)',
  `subTableName` varchar(80) DEFAULT NULL COMMENT 'Description of Content',
  `subTableContent` text NOT NULL COMMENT 'The Sub Table Content',
  `subTableTemplate` text NOT NULL COMMENT 'The Sub Table Template',
  PRIMARY KEY (`subTableId`,`languageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `dbdocssubtables_localised`
--
DROP TABLE IF EXISTS `dbdocssubtables_localised`;

CREATE TABLE `dbdocssubtables_localised` (
  `subTableId` int(11) NOT NULL COMMENT 'dbdocsSubtableId to link to',
  `languageId` int(11) NOT NULL DEFAULT '2' COMMENT 'dbdocsLanguageId to link to.',
  `subTableContent` text NOT NULL COMMENT 'The Sub Table Content',
  `subTableTemplate` text NOT NULL COMMENT 'The Sub Table Template',
  PRIMARY KEY (`subTableId`,`languageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dbdocssubtables_localised` */
LOCK TABLES `dbdocssubtables_localised` WRITE;
/*!40000 ALTER TABLE `dbdocssubtables_localised` DISABLE KEYS */;
/*!40000 ALTER TABLE `dbdocssubtables_localised` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbdocstable`
--
DROP TABLE IF EXISTS `dbdocstable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbdocstable` (
  `tableId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this entry',
  `languageId` int(11) NOT NULL DEFAULT '0' COMMENT 'The Language Id for the Notes (Normally 0 for English)',
  `tableName` varchar(80) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the table to add additional notes to',
  `tableNotes` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'The additional note to be added to the table',
  PRIMARY KEY (`tableId`,`languageId`,`tableName`),
  KEY `tableId` (`tableId`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `dbdocstable_localised`
--
DROP TABLE IF EXISTS `dbdocstable_localised`;

CREATE TABLE `dbdocstable_localised` (
  `tableId` int(11) NOT NULL COMMENT 'The dbdocsTableId to link to',
  `languageId` int(11) NOT NULL DEFAULT '2' COMMENT 'The dbdocsLanguageId to link to',
  `tableNotes` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'The additional note to be added to the table',
  PRIMARY KEY (`tableId`,`languageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `dbdocstable_localised` */
LOCK TABLES `dbdocstable_localised` WRITE;
/*!40000 ALTER TABLE `dbdocstable_localised` DISABLE KEYS */;
/*!40000 ALTER TABLE `dbdocstable_localised` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `dbscripts_on_creature_death`
--

DROP TABLE IF EXISTS `dbscripts_on_creature_death`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbscripts_on_creature_death` (
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
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbscripts_on_creature_movement`
--

DROP TABLE IF EXISTS `dbscripts_on_creature_movement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbscripts_on_creature_movement` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `search_radius` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbscripts_on_event`
--

DROP TABLE IF EXISTS `dbscripts_on_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbscripts_on_event` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `search_radius` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbscripts_on_go_template_use`
--

DROP TABLE IF EXISTS `dbscripts_on_go_template_use`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbscripts_on_go_template_use` (
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
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbscripts_on_go_use`
--

DROP TABLE IF EXISTS `dbscripts_on_go_use`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbscripts_on_go_use` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `search_radius` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbscripts_on_gossip`
--

DROP TABLE IF EXISTS `dbscripts_on_gossip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbscripts_on_gossip` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `search_radius` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbscripts_on_quest_end`
--

DROP TABLE IF EXISTS `dbscripts_on_quest_end`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbscripts_on_quest_end` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `search_radius` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbscripts_on_quest_start`
--

DROP TABLE IF EXISTS `dbscripts_on_quest_start`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbscripts_on_quest_start` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `search_radius` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbscripts_on_spell`
--

DROP TABLE IF EXISTS `dbscripts_on_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbscripts_on_spell` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `search_radius` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disenchant_loot_template`
--

DROP TABLE IF EXISTS `disenchant_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disenchant_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Recommended id selection: item_level*100 + item_quality',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exploration_basexp`
--

DROP TABLE IF EXISTS `exploration_basexp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exploration_basexp` (
  `level` tinyint(4) NOT NULL DEFAULT '0',
  `basexp` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Exploration System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fishing_loot_template`
--

DROP TABLE IF EXISTS `fishing_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'entry 0 used for junk loot at fishing fail (if allowed by config option)',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event`
--

DROP TABLE IF EXISTS `game_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'Entry of the game event',
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Absolute start date, the event will never start before',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Absolute end date, the event will never start afler',
  `occurence` bigint(20) unsigned NOT NULL DEFAULT '86400' COMMENT 'Delay in minutes between occurences of the event',
  `length` bigint(20) unsigned NOT NULL DEFAULT '43200' COMMENT 'Length in minutes of the event',
  `holiday` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Client side holiday id',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of the event displayed in console',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_creature`
--

DROP TABLE IF EXISTS `game_event_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_creature` (
  `guid` int(10) unsigned NOT NULL,
  `event` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Negatives value to remove during event and ignore pool grouping, positive value for spawn during event and if guid is part of pool then al pool memebers must be listed as part of event spawn.',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_creature_data`
--

DROP TABLE IF EXISTS `game_event_creature_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_creature_data` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `entry_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `modelid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipment_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell_start` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell_end` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `event` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_gameobject`
--

DROP TABLE IF EXISTS `game_event_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_gameobject` (
  `guid` int(10) unsigned NOT NULL,
  `event` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Negatives value to remove during event and ignore pool grouping, positive value for spawn during event and if guid is part of pool then al pool memebers must be listed as part of event spawn.',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_mail`
--

DROP TABLE IF EXISTS `game_event_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_mail` (
  `event` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Negatives value to send at event stop, positive value for send at event start.',
  `raceMask` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `mailTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `senderEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`event`,`raceMask`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Game event system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_event_quest`
--

DROP TABLE IF EXISTS `game_event_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_quest` (
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'entry from quest_template',
  `event` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'entry from game_event',
  PRIMARY KEY (`quest`,`event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Game event system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_graveyard_zone`
--

DROP TABLE IF EXISTS `game_graveyard_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_graveyard_zone` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ghost_zone` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `faction` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`ghost_zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_graveyard_zone`
--

LOCK TABLES `game_graveyard_zone` WRITE;
/*!40000 ALTER TABLE `game_graveyard_zone` DISABLE KEYS */;
INSERT INTO `game_graveyard_zone` VALUES
(3,10,469),
(4,40,0),
(4,1581,0),
(6,38,469),
(7,1,67),
(7,11,0),
(7,38,67),
(8,3,0),
(8,38,67),
(8,1337,0),
(10,17,67),
(10,718,0),
(31,405,0),
(31,2100,0),
(32,14,0),
(34,215,67),
(35,148,469),
(36,41,0),
(39,400,0),
(39,491,0),
(39,722,0),
(70,1377,0),
(89,215,67),
(90,141,469),
(90,1657,469),
(91,141,469),
(92,331,0),
(92,719,0),
(93,141,469),
(94,85,67),
(96,85,67),
(97,130,67),
(97,209,0),
(98,36,67),
(98,267,67),
(99,45,0),
(100,1,469),
(101,1,469),
(101,721,0),
(103,3,67),
(104,10,67),
(104,44,0),
(105,12,469),
(106,12,469),
(106,717,0),
(107,1519,469),
(107,2257,0),
(107,2918,0),
(108,8,67),
(108,1417,0),
(108,1477,0),
(109,33,0),
(149,36,469),
(149,130,469),
(149,209,0),
(149,267,469),
(169,2597,0),
(189,15,469),
(189,2159,469),
(209,440,0),
(209,1176,0),
(209,1941,0),
(229,17,0),
(249,17,67),
(249,215,469),
(249,1638,469),
(289,85,67),
(309,357,469),
(309,1477,0),
(310,357,67),
(329,400,0),
(349,47,469),
(369,16,0),
(370,4,0),
(370,8,469),
(389,33,0),
(389,1581,0),
(389,1977,0),
(409,406,0),
(429,796,0),
(429,2057,0),
(449,361,0),
(450,490,0),
(469,141,67),
(469,148,469),
(469,1657,67),
(489,11,0),
(509,28,469),
(510,139,0),
(511,618,0),
(512,17,469),
(512,148,67),
(512,331,0),
(512,719,0),
(512,1637,469),
(529,22,0),
(569,28,67),
(569,85,67),
(609,16,0),
(610,2597,67),
(611,2597,469),
(629,85,469),
(629,2057,0),
(630,16,0),
(631,15,67),
(631,2159,67),
(632,46,0),
(633,493,0),
(634,139,0),
(635,361,0),
(636,25,0),
(636,51,0),
(636,1583,0),
(636,1584,0),
(636,2677,0),
(636,2717,0),
(649,14,67),
(669,22,0),
(670,22,0),
(671,22,0),
(689,2597,0),
(709,14,67),
(729,2597,469),
(749,2597,67),
(750,2597,67),
(751,2597,469),
(769,3277,469),
(770,3277,67),
(771,3277,469),
(772,3277,67),
(789,47,67),
(809,3277,0),
(810,3277,0),
(829,28,0),
(829,2597,0),
(830,2597,0),
(849,357,0),
(849,2557,0),
(850,14,67),
(850,1637,67),
(850,2437,0),
(850,2917,67),
(851,215,67),
(851,1638,67),
(852,1,469),
(854,12,0),
(854,1519,67),
(869,2057,0),
(889,3358,67),
(890,3358,469),
(891,3358,0),
(892,3358,0),
(893,3358,67),
(894,3358,0),
(895,3358,469),
(896,3358,0),
(897,3358,0),
(898,3358,469),
(899,3358,67),
(909,139,0),
(909,2017,0),
(909,3456,0),
(910,1377,0),
(911,10,0),
(913,1377,0),
(913,3428,0),
(913,3478,0),
(927,139,0);
/*!40000 ALTER TABLE `game_graveyard_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_tele`
--

DROP TABLE IF EXISTS `game_tele`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_tele` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tele Command';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_weather`
--

DROP TABLE IF EXISTS `game_weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_weather` (
  `zone` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spring_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `spring_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `spring_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `summer_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `summer_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `summer_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `fall_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `fall_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `fall_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `winter_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `winter_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `winter_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  PRIMARY KEY (`zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Weather System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_weather`
--

LOCK TABLES `game_weather` WRITE;
/*!40000 ALTER TABLE `game_weather` DISABLE KEYS */;
INSERT INTO `game_weather` VALUES
(1,0,25,0,0,15,0,0,25,0,0,25,0),
(3,0,0,20,0,0,20,0,0,20,0,0,15),
(10,15,0,0,15,0,0,20,0,0,15,0,0),
(11,25,0,0,15,0,0,25,0,0,25,0,0),
(12,20,0,0,15,0,0,20,0,0,20,0,0),
(15,25,0,0,20,0,0,25,0,0,25,0,0),
(28,10,0,0,15,0,0,15,0,0,10,0,0),
(33,20,0,0,25,0,0,25,0,0,20,0,0),
(36,0,20,0,0,20,0,0,25,0,0,30,0),
(38,15,0,0,15,0,0,15,0,0,15,0,0),
(41,15,0,0,5,0,0,15,0,0,15,0,0),
(44,15,0,0,15,0,0,15,0,0,15,0,0),
(45,23,0,0,15,0,0,23,0,0,23,0,0),
(47,10,0,0,10,0,0,15,0,0,10,0,0),
(85,20,0,0,15,0,0,20,0,0,20,0,0),
(139,10,0,0,15,0,0,15,0,0,10,0,0),
(141,15,0,0,5,0,0,15,0,0,15,0,0),
(148,15,0,0,10,0,0,20,0,0,15,0,0),
(215,15,0,0,10,0,0,20,0,0,15,0,0),
(267,15,0,0,10,0,0,15,0,0,15,0,0),
(357,15,0,0,15,0,0,15,0,0,15,0,0),
(405,10,0,0,5,0,0,5,0,0,5,0,0),
(440,0,0,15,0,0,15,0,0,15,0,0,15),
(490,15,0,0,10,0,0,20,0,0,15,0,0),
(618,0,25,0,0,20,0,0,20,0,0,25,0),
(796,5,0,0,10,0,0,25,0,0,5,0,0),
(1377,0,0,20,0,0,25,0,0,20,0,0,15),
(1977,15,0,0,5,0,0,15,0,0,15,0,0),
(2017,5,0,0,5,0,0,5,0,0,5,0,0),
(2597,0,15,0,0,15,0,0,20,0,0,25,0),
(3358,10,0,0,10,0,0,10,0,0,10,0,0),
(3428,0,0,20,0,0,20,0,0,20,0,0,20),
(3429,0,0,20,0,0,20,0,0,20,0,0,20);
/*!40000 ALTER TABLE `game_weather` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameobject`
--

DROP TABLE IF EXISTS `gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject` (
  `guid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Gameobject Identifier',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `rotation0` float NOT NULL DEFAULT '0',
  `rotation1` float NOT NULL DEFAULT '0',
  `rotation2` float NOT NULL DEFAULT '0',
  `rotation3` float NOT NULL DEFAULT '0',
  `spawntimesecs` int(11) NOT NULL DEFAULT '0',
  `animprogress` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `idx_map` (`map`),
  KEY `idx_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Gameobject System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_battleground`
--

DROP TABLE IF EXISTS `gameobject_battleground`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_battleground` (
  `guid` int(10) unsigned NOT NULL COMMENT 'GameObject''s GUID',
  `event1` tinyint(3) unsigned NOT NULL COMMENT 'main event',
  `event2` tinyint(3) unsigned NOT NULL COMMENT 'sub event',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='GameObject battleground indexing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_involvedrelation`
--

DROP TABLE IF EXISTS `gameobject_involvedrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_involvedrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_loot_template`
--

DROP TABLE IF EXISTS `gameobject_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_questrelation`
--

DROP TABLE IF EXISTS `gameobject_questrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_questrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameobject_template`
--

DROP TABLE IF EXISTS `gameobject_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `displayId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  `faction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `size` float NOT NULL DEFAULT '1',
  `data0` int(10) unsigned NOT NULL DEFAULT '0',
  `data1` int(10) unsigned NOT NULL DEFAULT '0',
  `data2` int(10) unsigned NOT NULL DEFAULT '0',
  `data3` int(10) unsigned NOT NULL DEFAULT '0',
  `data4` int(10) unsigned NOT NULL DEFAULT '0',
  `data5` int(10) unsigned NOT NULL DEFAULT '0',
  `data6` int(10) unsigned NOT NULL DEFAULT '0',
  `data7` int(10) unsigned NOT NULL DEFAULT '0',
  `data8` int(10) unsigned NOT NULL DEFAULT '0',
  `data9` int(10) unsigned NOT NULL DEFAULT '0',
  `data10` int(10) unsigned NOT NULL DEFAULT '0',
  `data11` int(10) unsigned NOT NULL DEFAULT '0',
  `data12` int(10) unsigned NOT NULL DEFAULT '0',
  `data13` int(10) unsigned NOT NULL DEFAULT '0',
  `data14` int(10) unsigned NOT NULL DEFAULT '0',
  `data15` int(10) unsigned NOT NULL DEFAULT '0',
  `data16` int(10) unsigned NOT NULL DEFAULT '0',
  `data17` int(10) unsigned NOT NULL DEFAULT '0',
  `data18` int(10) unsigned NOT NULL DEFAULT '0',
  `data19` int(10) unsigned NOT NULL DEFAULT '0',
  `data20` int(10) unsigned NOT NULL DEFAULT '0',
  `data21` int(10) unsigned NOT NULL DEFAULT '0',
  `data22` int(10) unsigned NOT NULL DEFAULT '0',
  `data23` int(10) unsigned NOT NULL DEFAULT '0',
  `mingold` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `maxgold` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ScriptName` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Gameobject System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gossip_menu`
--

DROP TABLE IF EXISTS `gossip_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_menu` (
  `entry` smallint(6) unsigned NOT NULL DEFAULT '0',
  `text_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `script_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'script in `gossip_scripts` - will be executed on GossipHello',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`text_id`,`script_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gossip_menu`
--

LOCK TABLES `gossip_menu` WRITE;
/*!40000 ALTER TABLE `gossip_menu` DISABLE KEYS */;
INSERT INTO `gossip_menu` VALUES
(83,580,0,0);
/*!40000 ALTER TABLE `gossip_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gossip_menu_option`
--

DROP TABLE IF EXISTS `gossip_menu_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_menu_option` (
  `menu_id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `option_icon` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `option_text` text,
  `option_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `npc_option_npcflag` int(10) unsigned NOT NULL DEFAULT '0',
  `action_menu_id` mediumint(8) NOT NULL DEFAULT '0',
  `action_poi_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `action_script_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `box_coded` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `box_money` int(11) unsigned NOT NULL DEFAULT '0',
  `box_text` text,
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`menu_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gossip_menu_option`
--

LOCK TABLES `gossip_menu_option` WRITE;
/*!40000 ALTER TABLE `gossip_menu_option` DISABLE KEYS */;
INSERT INTO `gossip_menu_option` VALUES
(83,0,4,'Return me to life.',6,32,0,0,0,0,0,NULL,0);
/*!40000 ALTER TABLE `gossip_menu_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gossip_texts`
--

DROP TABLE IF EXISTS `gossip_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_texts` (
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `comment` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Gossip Texts';

--
-- Table structure for table `instance_template`
--

DROP TABLE IF EXISTS `instance_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_template` (
  `map` smallint(5) unsigned NOT NULL,
  `parent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `levelMin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `levelMax` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `maxPlayers` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reset_delay` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Reset time in days',
  `ghostEntranceMap` smallint(5) unsigned NOT NULL,
  `ghostEntranceX` float NOT NULL,
  `ghostEntranceY` float NOT NULL,
  `ScriptName` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_enchantment_template`
--

DROP TABLE IF EXISTS `item_enchantment_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_enchantment_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ench` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`ench`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Item Random Enchantment System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_loot_template`
--

DROP TABLE IF EXISTS `item_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_required_target`
--

DROP TABLE IF EXISTS `item_required_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_required_target` (
  `entry` mediumint(8) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `targetEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_type_target` (`entry`,`type`,`targetEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item_template`
--

DROP TABLE IF EXISTS `item_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `subclass` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `displayid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Quality` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Flags` int(10) unsigned NOT NULL DEFAULT '0',
  `BuyCount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `BuyPrice` int(10) unsigned NOT NULL DEFAULT '0',
  `SellPrice` int(10) unsigned NOT NULL DEFAULT '0',
  `InventoryType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllowableClass` mediumint(9) NOT NULL DEFAULT '-1',
  `AllowableRace` mediumint(9) NOT NULL DEFAULT '-1',
  `ItemLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RequiredLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RequiredSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredSkillRank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `requiredspell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `requiredhonorrank` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RequiredCityRank` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RequiredReputationFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredReputationRank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `maxcount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `stackable` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ContainerSlots` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_type1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value1` smallint(6) NOT NULL DEFAULT '0',
  `stat_type2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value2` smallint(6) NOT NULL DEFAULT '0',
  `stat_type3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value3` smallint(6) NOT NULL DEFAULT '0',
  `stat_type4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value4` smallint(6) NOT NULL DEFAULT '0',
  `stat_type5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value5` smallint(6) NOT NULL DEFAULT '0',
  `stat_type6` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value6` smallint(6) NOT NULL DEFAULT '0',
  `stat_type7` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value7` smallint(6) NOT NULL DEFAULT '0',
  `stat_type8` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value8` smallint(6) NOT NULL DEFAULT '0',
  `stat_type9` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value9` smallint(6) NOT NULL DEFAULT '0',
  `stat_type10` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value10` smallint(6) NOT NULL DEFAULT '0',
  `dmg_min1` float NOT NULL DEFAULT '0',
  `dmg_max1` float NOT NULL DEFAULT '0',
  `dmg_type1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dmg_min2` float NOT NULL DEFAULT '0',
  `dmg_max2` float NOT NULL DEFAULT '0',
  `dmg_type2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dmg_min3` float NOT NULL DEFAULT '0',
  `dmg_max3` float NOT NULL DEFAULT '0',
  `dmg_type3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dmg_min4` float NOT NULL DEFAULT '0',
  `dmg_max4` float NOT NULL DEFAULT '0',
  `dmg_type4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dmg_min5` float NOT NULL DEFAULT '0',
  `dmg_max5` float NOT NULL DEFAULT '0',
  `dmg_type5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `armor` smallint(5) unsigned NOT NULL DEFAULT '0',
  `holy_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `fire_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `nature_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `frost_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `shadow_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `arcane_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `delay` smallint(5) unsigned NOT NULL DEFAULT '1000',
  `ammo_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RangedModRange` float NOT NULL DEFAULT '0',
  `spellid_1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_1` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_1` float NOT NULL DEFAULT '0',
  `spellcooldown_1` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_1` int(11) NOT NULL DEFAULT '-1',
  `spellid_2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_2` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_2` float NOT NULL DEFAULT '0',
  `spellcooldown_2` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_2` int(11) NOT NULL DEFAULT '-1',
  `spellid_3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_3` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_3` float NOT NULL DEFAULT '0',
  `spellcooldown_3` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_3` int(11) NOT NULL DEFAULT '-1',
  `spellid_4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_4` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_4` float NOT NULL DEFAULT '0',
  `spellcooldown_4` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_4` int(11) NOT NULL DEFAULT '-1',
  `spellid_5` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_5` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_5` float NOT NULL DEFAULT '0',
  `spellcooldown_5` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_5` int(11) NOT NULL DEFAULT '-1',
  `bonding` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `PageText` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `LanguageID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PageMaterial` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `startquest` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `lockid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Material` tinyint(4) NOT NULL DEFAULT '0',
  `sheath` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RandomProperty` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `block` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `itemset` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `MaxDurability` smallint(5) unsigned NOT NULL DEFAULT '0',
  `area` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Map` smallint(6) NOT NULL DEFAULT '0',
  `BagFamily` mediumint(9) NOT NULL DEFAULT '0',
  `ScriptName` varchar(64) NOT NULL DEFAULT '',
  `DisenchantID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `FoodType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `minMoneyLoot` int(10) unsigned NOT NULL DEFAULT '0',
  `maxMoneyLoot` int(10) unsigned NOT NULL DEFAULT '0',
  `Duration` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Duration in seconds',
  `ExtraFlags` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`),
  KEY `items_index` (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_creature`
--

DROP TABLE IF EXISTS `locales_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_creature` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name_loc1` varchar(100) NOT NULL DEFAULT '',
  `name_loc2` varchar(100) NOT NULL DEFAULT '',
  `name_loc3` varchar(100) NOT NULL DEFAULT '',
  `name_loc4` varchar(100) NOT NULL DEFAULT '',
  `name_loc5` varchar(100) NOT NULL DEFAULT '',
  `name_loc6` varchar(100) NOT NULL DEFAULT '',
  `name_loc7` varchar(100) NOT NULL DEFAULT '',
  `name_loc8` varchar(100) NOT NULL DEFAULT '',
  `subname_loc1` varchar(100) DEFAULT NULL,
  `subname_loc2` varchar(100) DEFAULT NULL,
  `subname_loc3` varchar(100) DEFAULT NULL,
  `subname_loc4` varchar(100) DEFAULT NULL,
  `subname_loc5` varchar(100) DEFAULT NULL,
  `subname_loc6` varchar(100) DEFAULT NULL,
  `subname_loc7` varchar(100) DEFAULT NULL,
  `subname_loc8` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_gameobject`
--

DROP TABLE IF EXISTS `locales_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_gameobject` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name_loc1` varchar(100) NOT NULL DEFAULT '',
  `name_loc2` varchar(100) NOT NULL DEFAULT '',
  `name_loc3` varchar(100) NOT NULL DEFAULT '',
  `name_loc4` varchar(100) NOT NULL DEFAULT '',
  `name_loc5` varchar(100) NOT NULL DEFAULT '',
  `name_loc6` varchar(100) NOT NULL DEFAULT '',
  `name_loc7` varchar(100) NOT NULL DEFAULT '',
  `name_loc8` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_gossip_menu_option`
--

DROP TABLE IF EXISTS `locales_gossip_menu_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_gossip_menu_option` (
  `menu_id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `option_text_loc1` text,
  `option_text_loc2` text,
  `option_text_loc3` text,
  `option_text_loc4` text,
  `option_text_loc5` text,
  `option_text_loc6` text,
  `option_text_loc7` text,
  `option_text_loc8` text,
  `box_text_loc1` text,
  `box_text_loc2` text,
  `box_text_loc3` text,
  `box_text_loc4` text,
  `box_text_loc5` text,
  `box_text_loc6` text,
  `box_text_loc7` text,
  `box_text_loc8` text,
  PRIMARY KEY (`menu_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_item`
--

DROP TABLE IF EXISTS `locales_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_item` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name_loc1` varchar(100) NOT NULL DEFAULT '',
  `name_loc2` varchar(100) NOT NULL DEFAULT '',
  `name_loc3` varchar(100) NOT NULL DEFAULT '',
  `name_loc4` varchar(100) NOT NULL DEFAULT '',
  `name_loc5` varchar(100) NOT NULL DEFAULT '',
  `name_loc6` varchar(100) NOT NULL DEFAULT '',
  `name_loc7` varchar(100) NOT NULL DEFAULT '',
  `name_loc8` varchar(100) NOT NULL DEFAULT '',
  `description_loc1` varchar(255) DEFAULT NULL,
  `description_loc2` varchar(255) DEFAULT NULL,
  `description_loc3` varchar(255) DEFAULT NULL,
  `description_loc4` varchar(255) DEFAULT NULL,
  `description_loc5` varchar(255) DEFAULT NULL,
  `description_loc6` varchar(255) DEFAULT NULL,
  `description_loc7` varchar(255) DEFAULT NULL,
  `description_loc8` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_npc_text`
--

DROP TABLE IF EXISTS `locales_npc_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_npc_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Text0_0_loc1` longtext,
  `Text0_0_loc2` longtext,
  `Text0_0_loc3` longtext,
  `Text0_0_loc4` longtext,
  `Text0_0_loc5` longtext,
  `Text0_0_loc6` longtext,
  `Text0_0_loc7` longtext,
  `Text0_0_loc8` longtext,
  `Text0_1_loc1` longtext,
  `Text0_1_loc2` longtext,
  `Text0_1_loc3` longtext,
  `Text0_1_loc4` longtext,
  `Text0_1_loc5` longtext,
  `Text0_1_loc6` longtext,
  `Text0_1_loc7` longtext,
  `Text0_1_loc8` longtext,
  `Text1_0_loc1` longtext,
  `Text1_0_loc2` longtext,
  `Text1_0_loc3` longtext,
  `Text1_0_loc4` longtext,
  `Text1_0_loc5` longtext,
  `Text1_0_loc6` longtext,
  `Text1_0_loc7` longtext,
  `Text1_0_loc8` longtext,
  `Text1_1_loc1` longtext,
  `Text1_1_loc2` longtext,
  `Text1_1_loc3` longtext,
  `Text1_1_loc4` longtext,
  `Text1_1_loc5` longtext,
  `Text1_1_loc6` longtext,
  `Text1_1_loc7` longtext,
  `Text1_1_loc8` longtext,
  `Text2_0_loc1` longtext,
  `Text2_0_loc2` longtext,
  `Text2_0_loc3` longtext,
  `Text2_0_loc4` longtext,
  `Text2_0_loc5` longtext,
  `Text2_0_loc6` longtext,
  `Text2_0_loc7` longtext,
  `Text2_0_loc8` longtext,
  `Text2_1_loc1` longtext,
  `Text2_1_loc2` longtext,
  `Text2_1_loc3` longtext,
  `Text2_1_loc4` longtext,
  `Text2_1_loc5` longtext,
  `Text2_1_loc6` longtext,
  `Text2_1_loc7` longtext,
  `Text2_1_loc8` longtext,
  `Text3_0_loc1` longtext,
  `Text3_0_loc2` longtext,
  `Text3_0_loc3` longtext,
  `Text3_0_loc4` longtext,
  `Text3_0_loc5` longtext,
  `Text3_0_loc6` longtext,
  `Text3_0_loc7` longtext,
  `Text3_0_loc8` longtext,
  `Text3_1_loc1` longtext,
  `Text3_1_loc2` longtext,
  `Text3_1_loc3` longtext,
  `Text3_1_loc4` longtext,
  `Text3_1_loc5` longtext,
  `Text3_1_loc6` longtext,
  `Text3_1_loc7` longtext,
  `Text3_1_loc8` longtext,
  `Text4_0_loc1` longtext,
  `Text4_0_loc2` longtext,
  `Text4_0_loc3` longtext,
  `Text4_0_loc4` longtext,
  `Text4_0_loc5` longtext,
  `Text4_0_loc6` longtext,
  `Text4_0_loc7` longtext,
  `Text4_0_loc8` longtext,
  `Text4_1_loc1` longtext,
  `Text4_1_loc2` longtext,
  `Text4_1_loc3` longtext,
  `Text4_1_loc4` longtext,
  `Text4_1_loc5` longtext,
  `Text4_1_loc6` longtext,
  `Text4_1_loc7` longtext,
  `Text4_1_loc8` longtext,
  `Text5_0_loc1` longtext,
  `Text5_0_loc2` longtext,
  `Text5_0_loc3` longtext,
  `Text5_0_loc4` longtext,
  `Text5_0_loc5` longtext,
  `Text5_0_loc6` longtext,
  `Text5_0_loc7` longtext,
  `Text5_0_loc8` longtext,
  `Text5_1_loc1` longtext,
  `Text5_1_loc2` longtext,
  `Text5_1_loc3` longtext,
  `Text5_1_loc4` longtext,
  `Text5_1_loc5` longtext,
  `Text5_1_loc6` longtext,
  `Text5_1_loc7` longtext,
  `Text5_1_loc8` longtext,
  `Text6_0_loc1` longtext,
  `Text6_0_loc2` longtext,
  `Text6_0_loc3` longtext,
  `Text6_0_loc4` longtext,
  `Text6_0_loc5` longtext,
  `Text6_0_loc6` longtext,
  `Text6_0_loc7` longtext,
  `Text6_0_loc8` longtext,
  `Text6_1_loc1` longtext,
  `Text6_1_loc2` longtext,
  `Text6_1_loc3` longtext,
  `Text6_1_loc4` longtext,
  `Text6_1_loc5` longtext,
  `Text6_1_loc6` longtext,
  `Text6_1_loc7` longtext,
  `Text6_1_loc8` longtext,
  `Text7_0_loc1` longtext,
  `Text7_0_loc2` longtext,
  `Text7_0_loc3` longtext,
  `Text7_0_loc4` longtext,
  `Text7_0_loc5` longtext,
  `Text7_0_loc6` longtext,
  `Text7_0_loc7` longtext,
  `Text7_0_loc8` longtext,
  `Text7_1_loc1` longtext,
  `Text7_1_loc2` longtext,
  `Text7_1_loc3` longtext,
  `Text7_1_loc4` longtext,
  `Text7_1_loc5` longtext,
  `Text7_1_loc6` longtext,
  `Text7_1_loc7` longtext,
  `Text7_1_loc8` longtext,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_page_text`
--

DROP TABLE IF EXISTS `locales_page_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_page_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Text_loc1` longtext,
  `Text_loc2` longtext,
  `Text_loc3` longtext,
  `Text_loc4` longtext,
  `Text_loc5` longtext,
  `Text_loc6` longtext,
  `Text_loc7` longtext,
  `Text_loc8` longtext,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_points_of_interest`
--

DROP TABLE IF EXISTS `locales_points_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_points_of_interest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `icon_name_loc1` text,
  `icon_name_loc2` text,
  `icon_name_loc3` text,
  `icon_name_loc4` text,
  `icon_name_loc5` text,
  `icon_name_loc6` text,
  `icon_name_loc7` text,
  `icon_name_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locales_quest`
--

DROP TABLE IF EXISTS `locales_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_quest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title_loc1` text,
  `Title_loc2` text,
  `Title_loc3` text,
  `Title_loc4` text,
  `Title_loc5` text,
  `Title_loc6` text,
  `Title_loc7` text,
  `Title_loc8` text,
  `Details_loc1` text,
  `Details_loc2` text,
  `Details_loc3` text,
  `Details_loc4` text,
  `Details_loc5` text,
  `Details_loc6` text,
  `Details_loc7` text,
  `Details_loc8` text,
  `Objectives_loc1` text,
  `Objectives_loc2` text,
  `Objectives_loc3` text,
  `Objectives_loc4` text,
  `Objectives_loc5` text,
  `Objectives_loc6` text,
  `Objectives_loc7` text,
  `Objectives_loc8` text,
  `OfferRewardText_loc1` text,
  `OfferRewardText_loc2` text,
  `OfferRewardText_loc3` text,
  `OfferRewardText_loc4` text,
  `OfferRewardText_loc5` text,
  `OfferRewardText_loc6` text,
  `OfferRewardText_loc7` text,
  `OfferRewardText_loc8` text,
  `RequestItemsText_loc1` text,
  `RequestItemsText_loc2` text,
  `RequestItemsText_loc3` text,
  `RequestItemsText_loc4` text,
  `RequestItemsText_loc5` text,
  `RequestItemsText_loc6` text,
  `RequestItemsText_loc7` text,
  `RequestItemsText_loc8` text,
  `EndText_loc1` text,
  `EndText_loc2` text,
  `EndText_loc3` text,
  `EndText_loc4` text,
  `EndText_loc5` text,
  `EndText_loc6` text,
  `EndText_loc7` text,
  `EndText_loc8` text,
  `ObjectiveText1_loc1` text,
  `ObjectiveText1_loc2` text,
  `ObjectiveText1_loc3` text,
  `ObjectiveText1_loc4` text,
  `ObjectiveText1_loc5` text,
  `ObjectiveText1_loc6` text,
  `ObjectiveText1_loc7` text,
  `ObjectiveText1_loc8` text,
  `ObjectiveText2_loc1` text,
  `ObjectiveText2_loc2` text,
  `ObjectiveText2_loc3` text,
  `ObjectiveText2_loc4` text,
  `ObjectiveText2_loc5` text,
  `ObjectiveText2_loc6` text,
  `ObjectiveText2_loc7` text,
  `ObjectiveText2_loc8` text,
  `ObjectiveText3_loc1` text,
  `ObjectiveText3_loc2` text,
  `ObjectiveText3_loc3` text,
  `ObjectiveText3_loc4` text,
  `ObjectiveText3_loc5` text,
  `ObjectiveText3_loc6` text,
  `ObjectiveText3_loc7` text,
  `ObjectiveText3_loc8` text,
  `ObjectiveText4_loc1` text,
  `ObjectiveText4_loc2` text,
  `ObjectiveText4_loc3` text,
  `ObjectiveText4_loc4` text,
  `ObjectiveText4_loc5` text,
  `ObjectiveText4_loc6` text,
  `ObjectiveText4_loc7` text,
  `ObjectiveText4_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_loot_template`
--

DROP TABLE IF EXISTS `mail_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mangos_string`
--

DROP TABLE IF EXISTS `mangos_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mangos_string` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mangos_string`
--

LOCK TABLES `mangos_string` WRITE;
/*!40000 ALTER TABLE `mangos_string` DISABLE KEYS */;
INSERT INTO `mangos_string` VALUES
(1,'You should select a character or a creature.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(2,'You should select a creature.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(3,'|cffff0000[System Message]: %s|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(4,'|cffff0000[Event Message]: %s|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(5,'There is no help for that command',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(6,'There is no such command',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(7,'There is no such subcommand',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(8,'Command %s have subcommands:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(9,'Commands available to you:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10,'Incorrect syntax.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(11,'Your account level is: %i',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(12,'Online players: %u (max: %u) Queued players: %u (max: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(13,'Server uptime: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(14,'Player saved.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(15,'All players saved.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(16,'There are the following active GMs on this server:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(17,'There are no GMs currently logged in on this server.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(18,'Cannot do that while flying.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(19,'Cannot do that in Battlegrounds.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20,'Target is flying you can\'t do that.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(21,'%s is flying command failed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(22,'You are not mounted so you can\'t dismount.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(23,'Cannot do that while fighting.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(24,'You used it recently.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(25,'Password not changed (unknown error)!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(26,'The password was changed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(27,'The old password is wrong',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(28,'Your account is now locked.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(29,'Your account is now unlocked.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30,', rank ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(31,' [known]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(32,' [learn]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(33,' [passive]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(34,' [talent]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(35,' [active]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(36,' [complete]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(37,' (offline)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(38,'on',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(39,'off',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(40,'You are: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(41,'visible',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(42,'invisible',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(43,'done',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(44,'You',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(45,' <unknown> ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(46,'<error>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(47,'<non-existing character>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(48,'UNKNOWN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(49,'You must be at least level %u to enter.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(50,'You must be at least level %u and have item %s to enter.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(51,'Hello! Ready for some training?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(52,'Invaid item count (%u) for item %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(53,'Mail can\'t have more %u item stacks',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(54,'The new passwords do not match',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(55,'Your password can\'t be longer than 16 characters (client limit), password not changed!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(56,'Current Message of the day: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(57,'Using World DB: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(58,'Using script library: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(59,'Using creature EventAI: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(61,'Username: ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(62,'Password: ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(63,'Accepts whispers',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(64,'Doesn\'t accept whispers',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(65,'Using script library: <Unknown Script Library>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(66,'Using script library: <No Script Library Loaded>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(100,'Global notify: ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(101,'Map: %u (%s) Zone: %u (%s) Area: %u (%s)X: %f Y: %f Z: %f Orientation: %fgrid[%u,%u]cell[%u,%u] InstanceID: %u ZoneX: %f ZoneY: %fGroundZ: %f FloorZ: %f Have height data (Map: %u VMap: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(102,'%s is already being teleported.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(103,'You can summon a player to your instance only if he is in your party with you as leader.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(104,'You cannot go to the player\'s instance because you are in a party now.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(105,'You can go to the player\'s instance while not being in his party only if your GM mode is on.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(106,'You can not go to player %s from instance to instance.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(107,'You can not summon player %s from instance to instance.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(108,'You are summoning %s%s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(109,'You are being summoned by %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(110,'You are teleporting %s%s to %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(111,'You are being teleported by %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(112,'Player (%s) does not exist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(113,'Appearing at %s\'s location.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(114,'%s is appearing to your location.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(115,'Incorrect values.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(116,'No character selected.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(117,'%s is not in a group.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(118,'You changed HP of %s to %i/%i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(119,'%s changed your HP to %i/%i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(120,'You changed MANA of %s to %i/%i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(121,'%s changed your MANA to %i/%i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(122,'You changed ENERGY of %s to %i/%i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(123,'%s changed your ENERGY to %i/%i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(124,'Current energy: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(125,'You changed rage of %s to %i/%i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(126,'%s changed your rage to %i/%i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(127,'You changed level of %s to %i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(128,'GUID %i, faction is %i, flags is %i, npcflag is %i, DY flag is %i',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(129,'Wrong faction: %u (not found in factiontemplate.dbc).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(130,'You changed GUID=%i \'s Faction to %i, flags to %i, npcflag to %i, dyflag to %i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(131,'You changed the %s spellmod %u to value %i for spell with family bit %u for %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(132,'%s changed your spellmod %u to value %i for spell with family bit %u.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(133,'%s has access to all taxi nodes now (until logout).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(134,'%s has no more access to all taxi nodes now (only visited accessible).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(135,'%s has given you access to all taxi nodes (until logout).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(136,'%s has removed access to all taxi nodes (only visited still accessible).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(137,'You set all speeds to %2.2f from normal of %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(138,'%s set all your speeds to %2.2f from normal.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(139,'You set the speed to %2.2f from normal of %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(140,'%s set your speed to %2.2f from normal.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(141,'You set the swim speed to %2.2f from normal of %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(142,'%s set your swim speed to %2.2f from normal.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(143,'You set the backwards run speed to %2.2f from normal of %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(144,'%s set your backwards run speed to %2.2f from normal.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(147,'You set the size %2.2f of %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(148,'%s set your size to %2.2f.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(149,'There is no such mount.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(150,'You give a mount to %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(151,'%s gave you a mount.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(152,'USER1: %i, ADD: %i, DIF: %i',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(153,'You take all copper of %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(154,'%s took you all of your copper.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(155,'You take %i copper from %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(156,'%s took %i copper from you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(157,'You give %i copper to %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(158,'%s gave you %i copper.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(159,'You hear sound %u.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(160,'USER2: %i, ADD: %i, RESULT: %i',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(161,'Removed bit %i in field %i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(162,'Set bit %i in field %i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(163,'Teleport location table is empty!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(164,'Teleport location not found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(165,'Requires search parameter.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(166,'There are no teleport locations matching your request.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(168,'Locations found are: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(169,'Mail sent to %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(170,'You try to hear sound %u but it doesn\'t exist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(171,'You can\'t teleport self to self!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(172,'server console command',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(175,'Liquid level: %f, ground: %f, type flags %u, status: %d.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(200,'No selection.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(201,'Object GUID is: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(202,'The name was too long by %i characters.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(203,'Error, name can only contain characters A-Z and a-z.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(204,'The subname was too long by %i characters.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(205,'Not yet implemented',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(206,'Item \'%i\' \'%s\' added to list with maxcount \'%i\' and incrtime \'%i\'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(207,'Item \'%i\' not found in database.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(208,'Item \'%i\' \'%s\' deleted from vendor list',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(209,'Item \'%i\' not found in vendor list.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(210,'Item \'%i\' already in vendor list.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(211,'Spells of %s reset.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(212,'Spells of %s will reset at next login.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(213,'Talents of %s reset.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(214,'Talents of %s will reset at next login.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(215,'Your spells have been reset.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(216,'Your talents have been reset.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(217,'Unknown case \'%s\' for .resetall command. Type full correct case name.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(218,'Spells will reset for all players at login. Strongly recommend re-login!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(219,'Talents will reset for all players at login. Strongly recommend re-login!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(220,'Creature (GUID: %u) No waypoint found.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(221,'Creature (GUID: %u) Last waypoint not found.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(222,'Creature (GUID: %u) No waypoint found - used \'wpguid\'. Now trying to find it by its position...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(223,'Creature (GUID: %u) No waypoints found - This is a MaNGOS db problem (single float).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(224,'Selected creature is ignored - provided GUID is used',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(225,'Creature (GUID: %u) not found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(226,'You must select a visual waypoint.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(227,'No visual waypoints found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(228,'Could not create visual waypoint with creatureID: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(229,'All visual waypoints removed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(230,'Could not create waypoint-creature with ID: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(231,'No GUID provided.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(232,'No waypoint number provided.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(233,'Argument required for \'%s\'.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(234,'Waypoint %i added to GUID: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(235,'Waypoint %d added.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(236,'Waypoint changed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(237,'Waypoint %s modified.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(238,'WP export successfull.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(239,'No waypoints found inside the database.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(240,'File imported.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(241,'Waypoint removed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(242,'Warning: Could not delete WP from the world with ID: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(243,'This happens if the waypoint is too far away from your char.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(244,'The WP is deleted from the database, but not from the world here.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(245,'They will disappear after a server restart.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(246,'Waypoint %d: Info for creature: %s, GUID: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(247,'Waittime: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(248,'Model %d: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(249,'Emote: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(250,'Spell: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(251,'Text%d (ID: %i): %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(252,'AIScript: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(253,'Forced rename for player %s will be requested at next login.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(254,'Forced rename for player %s (GUID #%u) will be requested at next login.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(255,'Waypoint-Creature (GUID: %u) Not found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(256,'Could not find NPC...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(257,'Creature movement type set to \'%s\', waypoints removed (if any).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(258,'Creature movement type set to \'%s\', waypoints were not removed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(259,'Incorrect value, use on or off',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(260,'Value saved.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(261,'Value saved, you may need to rejoin or clean your client cache.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(262,'Areatrigger ID %u not found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(263,'Target map or coordinates is invalid (X: %f Y: %f MapId: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(264,'Zone coordinates is invalid (X: %f Y: %f AreaId: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(265,'Zone %u (%s) is part of instanceable map %u (%s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(266,'Nothing found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(267,'Object not found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(268,'Creature not found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(270,'Creature removed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(271,'Creature moved.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(272,'Creature (GUID:%u) must be on the same map as player!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(273,'Game Object (GUID: %u) not found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(274,'Game Object (GUID: %u) has references in not found owner %s GO list, can\'t be deleted.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(275,'Game Object (GUID: %u) removed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(276,'Game Object |cffffffff|Hgameobject:%d|h[%s]|h|r (GUID: %u) turned',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(277,'Game Object |cffffffff|Hgameobject:%d|h[%s]|h|r (GUID: %u) moved',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(278,'You must select a vendor',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(279,'You must send id for item',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(280,'Vendor has too many items (max 128)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(281,'You can\'t kick self, logout instead',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(282,'Player %s kicked.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(284,'Accepting Whisper: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(285,'Accepting Whisper: ON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(286,'Accepting Whisper: OFF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(287,'Creature (GUID: %u) not found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(288,'Tickets count: %i show new tickets: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(289,'New ticket from %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(290,'Ticket of %s (Last updated: %s):%s ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(291,'New ticket show: ON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(292,'New ticket show: OFF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(293,'Ticket %i doesn\'t exist',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(294,'All tickets deleted.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(295,'Character %s ticket deleted.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(296,'Ticket deleted.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(297,'Spawn distance changed to: %f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(298,'Spawn time changed to: %i',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(299,'The %s field of %s was set to %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(300,'Your chat has been disabled for %u minutes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(301,'You have disabled %s\'s chat for %u minutes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(302,'Player\'s chat is already enabled.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(303,'Your chat has been enabled.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(304,'You have enabled %s\'s chat.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(305,'Faction %s (%u) reputation of %s was set to %5d!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(307,'No faction found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(308,'Faction %i unknown!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(309,'Invalid parameter %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(310,'delta must be between 0 and %d (inclusive)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(311,'%d - |cffffffff|Hfaction:%d|h[%s]|h|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(312,' [visible]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(313,' [at war]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(314,' [peace forced]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(315,' [hidden]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(316,' [invisible forced]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(317,' [inactive]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(318,'Hated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(319,'Hostile',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(320,'Unfriendly',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(321,'Neutral',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(322,'Friendly',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(323,'Honored',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(324,'Revered',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(325,'Exalted',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(326,'Faction %s (%u) can\'not have reputation.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(327,' [no reputation]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(328,'Characters at account %s (Id: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(329,'  %s (GUID %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(330,'No players found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(331,'Extended item cost %u not exist',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(332,'GM mode is ON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(333,'GM mode is OFF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(334,'GM Chat Badge is ON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(335,'GM Chat Badge is OFF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(336,'You repair all %s\'s items.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(337,'All your items repaired by %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(338,'You set waterwalk mode %s for %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(339,'Your waterwalk mode %s by %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(340,'%s is now following you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(341,'%s is not following you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(342,'%s is now not following you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(343,'Creature (Entry: %u) cannot be tamed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(344,'You already have pet.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(347,'TaxiNode ID %u not found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(348,'Game Object (Entry: %u) have invalid data and can\'t be spawned',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(357,'Areatrigger %u not has target coordinates',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(358,'No areatriggers found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(359,'%s|cffffffff|Hareatrigger_target:%u|h[Trigger target %u]|h|r Map %u X:%f Y:%f Z:%f%s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(360,'%s[Trigger target %u] Map %u X:%f Y:%f Z:%f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(361,'|cffffffff|Hareatrigger:%u|h[Trigger %u]|h|r Map %u X:%f Y:%f Z:%f%s%s%s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(362,'[Trigger %u] Map %u X:%f Y:%f Z:%f%s%s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(363,' (Dist %f)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(364,' [Tavern]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(365,' [Quest]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(366,'Explore quest:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(367,'Required level %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(368,'Required Items:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(369,'Required quest:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(373,'Response:\n%s ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(374,'Tickets count: %i\n',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(375,'Player %s not have tickets.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(376,'%u - |cffffffff|Hpool:%u|h[%s]|h|r AutoSpawn: %u MaxLimit: %u Creatures: %u GameObjecs: %u Pools %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(377,'No pools found for map \'%s\' (Id:%u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(378,'You can\'t use this command at non-instanceable map \'%s\' (Id:%u). Use .lookup pool command instead.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(379,'You can\'t use this command without args at non-instanceable map \'%s\' (Id:%u).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(380,'%d%s - |cffffffff|Hcreature:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r Chance:%f %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(381,'%d%s - [%s] X:%f Y:%f Z:%f MapId:%d Chance:%f %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(382,'%d%s - |cffffffff|Hcreature:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(383,'%d%s - [%s] X:%f Y:%f Z:%f MapId:%d %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(384,'%d%s - |cffffffff|Hgameobject:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r Chance:%f %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(385,'%d%s - [%s] X:%f Y:%f Z:%f MapId:%d Chance:%f %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(386,'%d%s - |cffffffff|Hgameobject:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(387,'%d%s - [%s] X:%f Y:%f Z:%f MapId:%d %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(388,'Creatures with explicitly chance:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(389,'Creatures with equal chance:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(390,'Gameobjects with explicitly chance:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(391,'Gameobjects with equal chance:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(392,'Pool %u - Mother pool: %u |cffffffff|Hpool:%u|h[%s]|h|r AutoSpawn: %u MaxLimit: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(393,'Pool %u - Mother pool: %u [%s] AutoSpawn: %u MaxLimit: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(394,'Pool %u - Mother pool: none AutoSpawn: %u MaxLimit: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(395,'No pools found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(396,'%u - [%s] AutoSpawn: %u MaxLimit: %u Creatures: %u GameObjecs: %u Pools %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(397,'Pools with explicitly chance:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(398,'Pools with equal chance:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(399,'%u - |cffffffff|Hpool:%u|h[%s]|h|r AutoSpawn: %u MaxLimit: %u Creatures: %u GameObjecs: %u Pools %u Chance: %f %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(400,'|cffff0000[System Message]:|rScripts reloaded',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(401,'You change security level of account %s to %i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(402,'%s changed your security level to %i.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(403,'You have low security level for this.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(404,'Creature movement disabled.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(405,'Creature movement enabled.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(406,'Weather can\'t be changed for this zone.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(407,'Weather system disabled at server.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(408,'%s is banned for %s. Reason: %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(409,'%s is banned permanently for %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(410,'%s %s not found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(411,'%s unbanned.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(412,'There was an error removing the ban on %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(413,'Account not exist: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(414,'There is no such character.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(415,'There is no such IP in banlist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(416,'Account %s has never been banned',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(417,'Ban history for account %s:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(418,'Ban Date: %s Bantime: %s Still active: %s  Reason: %s Set by: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(419,'Inf.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(420,'Never',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(421,'Yes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(422,'No',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(423,'IP: %sBan Date: %sUnban Date: %sRemaining: %sReason: %sSet by: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(424,'There is no matching IPban.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(425,'There is no matching account.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(426,'There is no banned account owning a character matching this part.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(427,'The following IPs match your pattern:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(428,'The following accounts match your query:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(429,'You learned many spells/skills.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(430,'You learned all spells for class.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(431,'You learned all talents for class.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(432,'You learned all languages.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(433,'You learned all craft skills and recipes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(434,'Could not find \'%s\'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(435,'Invalid item id: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(436,'No items found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(437,'Invalid gameobject id: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(438,'Found items %u: %u ( inventory %u mail %u auction %u guild %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(439,'Found gameobjects %u: %u ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(440,'Invalid creature id: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(441,'Found creatures %u: %u ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(442,'No area found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(443,'No item sets found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(444,'No skills found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(445,'No spells found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(446,'No quests found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(447,'No creatures found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(448,'No gameobjects found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(449,'Graveyard #%u doesn\'t exist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(450,'Graveyard #%u already linked to zone #%u (current).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(451,'Graveyard #%u linked to zone #%u (current).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(452,'Graveyard #%u can\'t be linked to subzone or not existed zone #%u (internal error).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(454,'No faction in Graveyard with id= #%u , fix your DB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(455,'invalid team, please fix database',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(456,'any',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(457,'alliance',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(458,'horde',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(459,'Graveyard #%u (faction: %s) is nearest from linked to zone #%u.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(460,'Zone #%u doesn\'t have linked graveyards.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(461,'Zone #%u doesn\'t have linked graveyards for faction: %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(462,'Teleport location already exists!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(463,'Teleport location added.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(464,'Teleport location NOT added: database error.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(465,'Teleport location deleted.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(466,'No taxinodes found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(467,'Target unit has %d auras:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(468,'id: %d eff: %d type: %d duration: %d maxduration: %d name: %s%s%s caster: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(469,'Target unit has %d auras of type %d:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(470,'id: %d eff: %d name: %s%s%s caster: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(471,'Quest %u not found.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(472,'Quest %u started from item. For correct work, please, add item to inventory and start quest in normal way: .additem %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(473,'Quest removed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(474,' [rewarded]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(475,' [complete]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(476,' [active]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(477,'%s\'s Fly Mode %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(478,'Opcode %u sent to %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(479,'Character loaded successfully!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(480,'Failed to load the character!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(481,'Character dumped successfully!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(482,'Character dump failed!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(483,'Spell %u broken and not allowed to cast or learn!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(484,'Skill %u (%s) for player %s set to %u and current maximum set to %u (without permanent (talent) bonuses).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(485,'Player %s must have skill %u (%s) before using this command.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(486,'Invalid skill id (%u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(487,'You learned default GM spells/skills.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(488,'You already know that spell.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(489,'Target(%s) already know that spell.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(490,'%s doesn\'t know that spell.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(491,'You already forgot that spell.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(492,'All spell cooldowns removed for %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(493,'Spell %u cooldown removed for %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(494,'Command : Additem, itemId = %i, amount = %i',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(495,'Command : Additemset, itemsetId = %i',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(496,'Removed itemID = %i, amount = %i from %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(497,'Cannot create item \'%i\' (amount: %i)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(498,'You need to provide a guild name!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(499,'Player not found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(500,'Player already has a guild!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(501,'Guild not created! (already exists?)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(502,'No items from itemset \'%u\' found.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(503,'The distance is: (3D) %f (2D) %f - (3D, point-to-point) %f yards.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(504,'Item \'%i\' \'%s\' Item Slot %i',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(505,'Item \'%i\' doesn\'t exist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(506,'Item \'%i\' \'%s\' Added to Slot %i',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(507,'Item save failed!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(508,'%d - owner: %s (guid: %u account: %u ) %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(509,'%d - sender: %s (guid: %u account: %u ) receiver: %s (guid: %u account: %u ) %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(510,'%d - owner: %s (guid: %u account: %u ) %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(511,'Wrong link type!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(512,'%d - |cffffffff|Hitem:%d:0:0:0:0:0:0:0|h[%s]|h|r %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(513,'%d - |cffffffff|Hquest:%d:%d|h[%s]|h|r %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(514,'%d - |cffffffff|Hcreature_entry:%d|h[%s]|h|r ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(515,'%d%s - |cffffffff|Hcreature:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(516,'%d - |cffffffff|Hgameobject_entry:%d|h[%s]|h|r ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(517,'%d%s, Entry %d - |cffffffff|Hgameobject:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(518,'%d - |cffffffff|Hitemset:%d|h[%s %s]|h|r ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(519,'|cffffffff|Htele:%s|h[%s]|h|r ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(520,'%d - |cffffffff|Hspell:%d|h[%s]|h|r ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(521,'%d - |cffffffff|Hskill:%d|h[%s %s]|h|r %s %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(522,'Game Object (Entry: %u) not found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(523,'>> Game Object %s (GUID: %u) at %f %f %f. Orientation %f.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(524,'Selected object:|cffffffff|Hgameobject:%d|h[%s]|h|r GUID: %u ID: %uX: %f Y: %f Z: %f MapId: %uOrientation: %f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(525,'>> Add Game Object \'%i\' (%s) (GUID: %i) added at \'%f %f %f\'.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(526,'%s (lowguid: %u) movement generators stack:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(527,'   Idle',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(528,'   Random',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(529,'   Waypoint',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(530,'   Animal random',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(531,'   Confused',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(532,'   Targeted to player %s (lowguid %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(533,'   Targeted to creature %s (lowguid %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(534,'   Targeted to <NULL>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(535,'   Home movement to (X:%f Y:%f Z:%f)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(536,'   Home movement used for player?!?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(537,'   Taxi flight',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(538,'   Unknown movement generator (%u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(539,'Player selected: %s.\nFaction: %u.\nnpcFlags: %u.\nEntry: %u.\nDisplayID: %u (Native: %u).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(540,'Level: %u.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(541,'Health (base): %u. (max): %u. (current): %u.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(542,'Unit Flags: %u.\nDynamic Flags: %u.\nFaction Template: %u.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(543,'Loot: %u Pickpocket: %u Skinning: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(544,'Position: %f %f %f.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(545,'*** Is a vendor!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(546,'*** Is a trainer!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(547,'InstanceID: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(548,'Player%s %s (guid: %u) Account: %s (id: %u) GMLevel: %u E-mail: %s Last IP: %s Last login: %s Latency: %ums',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(549,'Played time: %s Level: %u Money: %ug%us%uc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(550,'Command .pinfo doesn\'t support \'rep\' option for offline players.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(551,'%s has explored all zones now.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(552,'%s has no more explored zones.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(553,'%s has explored all zones for you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(554,'%s has hidden all zones from you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(557,'%s level up you to (%i)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(558,'%s level down you to (%i)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(559,'%s reset your level progress.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(560,'The area has been set as explored.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(561,'The area has been set as not explored.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(564,'The value index %u is too big to %s (count: %u).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(565,'Set for %s field:%u to uint32 value:%u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(566,'You set for %s field:%u to uint32 value: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(567,'Set for %s field:%u to to float value:%f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(568,'You set for %s field:%u to float value: %f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(569,'Get %s uint32 value:[FIELD]:%u [VALUE]:%u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(570,'%s has uint32 value:[FIELD]:%u [VALUE]:%u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(571,'Get %s float value:[FIELD]:%u [VALUE]:%f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(572,'%s has float value:[FIELD]:%u [VALUE]:%f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(575,'Modify %s uint32 field:%u to sum with:%i = %u (%i)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(576,'You modify for %s uint32 field:%u to sum with:%i = %u (%i)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(577,'You are now invisible.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(578,'You are now visible.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(579,'Selected player or creature not have victim.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(580,'You learned all default spells for race/class and completed quests rewarded spells.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(581,'Found near gameobjects (distance %f): %u ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(582,'SpawnTime: Full:%s Remain:%s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(583,'%d - |cffffffff|Hgameevent:%d|h[%s]|h|r%s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(584,'No event found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(585,'Event not exist!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(586,'Event %u: %s%sStart: %s End: %s Occurence: %s Length: %sNext state change: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(587,'Event %u already active!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(588,'Event %u not active!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(589,'   Point movement to (X:%f Y:%f Z:%f)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(590,'   Fear movement',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(591,'   Distract movement',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(592,'You have learned all spells in craft: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(593,'Currently Banned Accounts:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(594,'|    Account    |   BanDate    |   UnbanDate  |  Banned By    |   Ban Reason  |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(595,'Currently Banned IPs:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(596,'|      IP       |   BanDate    |   UnbanDate  |  Banned By    |   Ban Reason  |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(597,'Current gamemasters:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(598,'|    Account    |  GM  |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(599,'No gamemasters.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(600,'The Alliance wins!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(601,'The Horde wins!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(602,'The battle for Warsong Gulch begins in 1 minute.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(603,'The battle for Warsong Gulch begins in 30 seconds. Prepare yourselves!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(604,'Let the battle for Warsong Gulch begin!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(605,'$n captured the Horde flag!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(606,'$n captured the Alliance flag!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(607,'The Horde flag was dropped by $n!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(608,'The Alliance Flag was dropped by $n!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(609,'The Alliance Flag was returned to its base by $n!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(610,'The Horde flag was returned to its base by $n!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(611,'The Horde flag was picked up by $n!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(612,'The Alliance Flag was picked up by $n!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(613,'The flags are now placed at their bases.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(614,'The Alliance flag is now placed at its base.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(615,'The Horde flag is now placed at its base.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(650,'Alliance',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(651,'Horde',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(652,'stables',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(653,'blacksmith',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(654,'farm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(655,'lumber mill',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(656,'mine',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(657,'The %s has taken the %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(658,'$n has defended the %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(659,'$n has assaulted the %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(660,'$n claims the %s! If left unchallenged, the %s will control it in 1 minute!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(661,'The Battle for Arathi Basin begins in 1 minute.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(662,'The Battle for Arathi Basin begins in 30 seconds. Prepare yourselves!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(663,'The Battle for Arathi Basin has begun!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(664,'The Alliance has gathered $1776W resources, and is near victory!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(665,'The Horde has gathered $1777W resources, and is near victory!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(666,'After your recent battle in %s our best attempts to award you a Mark of Honor failed. Enclosed you will find the Mark of Honor we were not able to deliver to you at the time. Thanks for fighting in %s!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(705,'You must wait %s before speaking again.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(706,'This item(s) has problems with equipping/storing to inventory.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(707,'%s does not wish to be disturbed: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(708,'%s is Away from Keyboard: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(709,'Do not Disturb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(710,'Away from Keyboard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(711,'Queue status for %s (Lvl: %u to %u)Queued alliances: %u (Need at least %u more)Queued hordes: %u (Need at least %u more)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(712,'|cffff0000[BG Queue Announcer]:|r %s -- [%u-%u] A: %u/%u, H: %u/%u|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(715,'You don\'t meet Battleground level requirements',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(717,'|cffff0000[BG Queue Announcer]:|r %s -- [%u-%u] Started!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(720,'Your group is too large for this battleground. Please regroup to join.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(727,'Your group has an offline member. Please remove him before joining.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(728,'Your group has players from the opposing faction. You can\'t join the battleground as a group.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(729,'Your group has players from different battleground brakets. You can\'t join as group.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(730,'Someone in your party is already in this battleground queue. (S)he must leave it before joining as group.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(731,'Someone in your party is Deserter. You can\'t join as group.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(732,'Someone in your party is already in three battleground queues. You cannot join as group.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(733,'You cannot teleport to a battleground map.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(734,'You cannot summon players to a battleground or arena map.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(735,'You must be in GM mode to teleport to a player in a battleground.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(736,'You cannot teleport to a battleground from another battleground. Please leave the current battleground first.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(739,'Battlegrounds are set to 1v0 for debugging.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(740,'Battlegrounds are set to normal playercount.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(750,'Not enough players. This game will close in %u mins.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(751,'Not enough players. This game will close in %u seconds.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(752,'Only the Alliance can use that portal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(753,'Only the Horde can use that portal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(759,'%s was destroyed by the %s!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(760,'The %s is under attack! If left unchecked, the %s will destroy it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(761,'The %s was taken by the %s!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(762,'The %s was taken by the %s!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(763,'The %s was taken by the %s!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(764,'The %s is under attack! If left unchecked, the %s will capture it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(765,'The %s has taken the %s! Its supplies will now be used for reinforcements!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(766,'Irondeep Mine',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(767,'Coldtooth Mine',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(768,'Stormpike Aid Station',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(769,'Dun Baldar South Bunker',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(770,'Dun Baldar North Bunker',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(771,'Stormpike Graveyard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(772,'Icewing Bunker',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(773,'Stonehearth Graveyard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(774,'Stonehearth Bunker',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(775,'Snowfall Graveyard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(776,'Iceblood Tower',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(777,'Iceblood Graveyard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(778,'Tower Point',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(779,'Frostwolf Graveyard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(780,'East Frostwolf Tower',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(781,'West Frostwolf Tower',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(782,'Frostwolf Relief Hut',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(784,'1 minute until the battle for Alterac Valley begins.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(785,'30 seconds until the battle for Alterac Valley begins. Prepare yourselves!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(786,'The battle for Alterac Valley has begun!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(787,'The Alliance Team is running out of reinforcements!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(788,'The Horde Team is running out of reinforcements!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(789,'The Frostwolf General is Dead!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(790,'The Stormpike General is Dead!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(801,'You do not have enough gold',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(802,'You do not have enough free slots',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(803,'Your partner does not have enough free bag slots',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(804,'You do not have permission to perform that function',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(805,'Unknown language',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(806,'You don\'t know that language',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(807,'Please provide character name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(808,'Player %s not found or offline',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(809,'Account for character %s not found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(811,'Guild Master',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(812,'Officer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(813,'Veteran',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(814,'Member',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(815,'Initiate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1000,'Exiting daemon...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1001,'Account deleted: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1002,'Account %s NOT deleted (probably sql file format was updated)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1003,'Account %s NOT deleted (unknown error)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1004,'Account created: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1005,'Account name cannot be longer than 16 characters (client limit), account not created!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1006,'Account with this name already exist!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1007,'Account %s NOT created (probably sql file format was updated)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1008,'Account %s NOT created (unknown error)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1009,'Player %s (Guid: %u) Account %s (Id: %u) deleted.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1010,'| ID         |    Account    |       Character      |       IP        | GM | Expansion |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1012,'========================================================================================',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1013,'| %10u |%15s| %20s | %15s |%4d| %9d |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1014,'No online players.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1015,'Can only quit from a Remote Admin console or the quit command was not entered in full (quit).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1016,'| GUID       | Name                 | Account                      | Delete Date         |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1017,'| %10u | %20s | %15s (%10u) | %19s |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1018,'==========================================================================================',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1019,'No characters found.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1020,'Restoring the following characters:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1021,'Deleting the following characters:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1022,'ERROR: You can only assign a new name for a single selected character!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1023,'Character \'%s\' (GUID: %u Account %u) can\'t be restored: account doesn\'t exist!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1024,'Character \'%s\' (GUID: %u Account %u) can\'t be restored: account character list full!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1025,'Character \'%s\' (GUID: %u Account %u) can\'t be restored: name already in use!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1026,'GUID: %u Name: %s Account: %s (%u) Date: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1027,'Log filters state:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1028,'All log filters set to: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1029,'Command can only be called from a Remote Admin console.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1100,'Account %s (Id: %u) has been granted %u expansion rights.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1101,'Message of the day changed to:%s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1102,'Message sent to %s: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1103,'%d - %s %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1104,'%d - %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1105,'%d - %s %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1106,'%d - %s %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1107,'%d - %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1108,'%d - %s %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1109,'%d - %s %s %s %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1110,'%d%s - %s X:%f Y:%f Z:%f MapId:%d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1111,'%d%s - %s X:%f Y:%f Z:%f MapId:%d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1112,'Failed to open file: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1113,'Account %s (%u) have max amount allowed characters (client limit)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1114,'Dump file have broken data!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1115,'Invalid character name!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1116,'Invalid character guid!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1117,'Character guid %u in use!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1118,'%d - guild: %s (guid: %u) %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1119,'You must use male or female as gender.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1120,'You change gender of %s to %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1121,'Your gender changed to %s by %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1122,'(%u/%u +perm %u +temp %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1128,'%d - |cffffffff|Htaxinode:%u|h[%s %s]|h|r (Map:%u X:%f Y:%f Z:%f)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1129,'%d - %s %s (Map:%u X:%f Y:%f Z:%f)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1130,'event started %u \"%s\"',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1131,'event stopped %u \"%s\"',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1132,'   Follow player %s (lowguid %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1133,'   Follow creature %s (lowguid %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1134,'   Follow <NULL>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1135,'List known talents:',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1136,'   (Found talents: %u used talent points: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1137,'%d%s - |cffffffff|Hgameobject:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1138,'=================================================================================',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1139,'| GUID       | Name                 | Race            | Class           | Level |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1140,'| %10u | %20s | %15s | %15s | %5u |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1141,'%u - |cffffffff|Hplayer:%s|h[%s]|h|r %s %s %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1142,'%u - %s (Online:%s IP:%s GM:%u Expansion:%u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1143,'Spawned by event %u (%s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1144,'Despawned by event %u (%s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1145,'Part of pool %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1146,'Part of pool %u, top pool %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1147,'The (top)pool %u is spawned by event %u (%s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1148,'The (top)pool %u is despawned by event %u (%s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1149,' (Pool %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1150,' (Event %i)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1151,' (Pool %u Event %i)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1152,'[usable]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1153,'Get %s bitstr value:[FIELD]:%u [VALUE]:%s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1154,'%s has bitstr value:[FIELD]:%u [VALUE]:%s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1155,'Get %s hex value:[FIELD]:%u [VALUE]:%x',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1156,'%s has hex value:[FIELD]:%u [VALUE]:%x',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1157,'Modify %s hex field:%u %s %x = %x (hex)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1158,'You modify for %s hex field:%u %s %x = %x (hex)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1159,'Modify %s float field:%u to sum with:%f = %f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1160,'You modify for %s float field:%u to sum with:%f = %f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1165,'Spell %u not have auras.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1166,'Scripting library not found or not accessible.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1167,'Scripting library has wrong list functions (outdated?).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1168,'Scripting library reloaded.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1169,'Scripting library build for different mangosd revision.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1171,'All config are reloaded from ahbot configuration file.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1172,'Error while trying to reload ahbot config.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1173,'==========================================================',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1174,'|--------------------------------------------------------|',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1175,'|            | Alliance |  Horde   | Neutral  |  Total   |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1176,'          Alliance/Horde/Neutral/Total',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1177,'| %-10s | %8u | %8u | %8u | %8u |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1178,'%-10s = %6u / %6u / %6u / %6u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1179,'Count',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1180,'Item Ratio',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1181,'|            | Alliance |   Horde  | Neutral  |  Amount  |',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1182,'          Alliance/Horde/Neutral/Amount',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1183,'Grey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1184,'White',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1185,'Green',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1186,'Blue',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1187,'Purple',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1188,'Orange',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1189,'Yellow',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1190,'Amount of %s items is set to %u.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1191,'Items ratio for %s is set to %u.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1192,'Effect movement',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1194,'Current State Information: GOState %u, LootState %u. Collision %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1195,'Current State Information: GOState %u, LootState %u. Collision %s, (door %s by default)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1200,'You tried to view cinematic %u but it doesn\'t exist.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1202,'Spell %u %s = %f (*1.88 = %f) DB = %f AP = %f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1203,'direct heal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1204,'direct damage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1205,'dot heal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1206,'dot damage',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1400,'Private ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1401,'Corporal ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1402,'Sergeant ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1403,'Master Sergeant ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1404,'Sergeant Major ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1405,'Knight ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1406,'Knight-Lieutenant ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1407,'Knight-Captain ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1408,'Knight-Champion ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1409,'Lieutenant Commander ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1410,'Commander ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1411,'Marshal ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1412,'Field Marshal ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1413,'Grand Marshal ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1414,'Scout ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1415,'Grunt ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1416,'Sergeant ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1417,'Senior Sergeant ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1418,'First Sergeant ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1419,'Stone Guard ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1420,'Blood Guard ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1421,'Legionnare ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1422,'Centurion ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1423,'Champion ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1424,'Lieutenant General ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1425,'General ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1426,'Warlord ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1427,'High Warlord ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1428,'Game Master ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1429,'No Rank ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1430,'Dishonored ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1431,'Exiled ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1432,'Outlaw ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1433,'Pariah ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1434,'Player: %s - %s (Rank %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1435,'Today: [Honorable Kills: |c0000ff00%u|r] [Dishonorable Kills: |c00ff0000%u|r]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1436,'Yesterday: [Kills: |c0000ff00%u|r] [Honor: %u]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1437,'This Week: [Kills: |c0000ff00%u|r] [Honor: %u]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1438,'Last Week: [Kills: |c0000ff00%u|r] [Honor: %u] [Standing: %u]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1439,'Life Time: [Rank Points: |c0000ff00%f|r] [Honorable Kills: |c0000ff00%u|r] [Dishonorable Kills: |c00ff0000%u|r] [Highest Rank %u: %s]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1500,'%u - [%s] AutoSpawn: %u MaxLimit: %u Creatures: %u GameObjecs: %u Pools %u Chance: %f %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1501,'%u - |cffffffff|Hpool:%u|h[%s]|h|r AutoSpawn: %u MaxLimit: %u Creatures: %u GameObjecs: %u Pools %u %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1502,'%u - [%s] AutoSpawn: %u MaxLimit: %u Creatures: %u GameObjecs: %u Pools %u %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1503,'Cannot add spawn because no free guids for static spawn in reserved guids range. Server restart is required before command can be used. Also look GuidReserveSize.* config options.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1504,'AI-Information for Npc Entry %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1505,'AIName: %s (%s) ScriptName: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1506,'Current phase = %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1507,'Combat-Movement is %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1508,'Melee attacking is %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1509,'Pool %u not found (Maximal pool entry is %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1510,'Closed ticket for player %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1511,'Ticket system is globally on, accepting all tickets',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1512,'Ticket system is globally off, not accepting tickets at all',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1513,'You cant close a ticket for offline players',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1600,'|cffffff00Northpass Tower has been taken by the Horde!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1601,'|cffffff00Northpass Tower has been taken by the Alliance!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1602,'|cffffff00Crown Guard Tower has been taken by the Horde!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1603,'|cffffff00Crown Guard Tower has been taken by the Alliance!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1604,'|cffffff00Eastwall Tower has been taken by the Horde!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1605,'|cffffff00Eastwall Tower has been taken by the Alliance!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1606,'|cffffff00The Plaguewood Tower has been taken by the Horde!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1607,'|cffffff00The Plaguewood Tower has been taken by the Alliance!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1635,'|cffffff00The Horde has collected 200 silithyst!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1636,'|cffffff00The Alliance has collected 200 silithyst!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `mangos_string` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_gossip`
--

DROP TABLE IF EXISTS `npc_gossip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_gossip` (
  `npc_guid` int(10) unsigned NOT NULL DEFAULT '0',
  `textid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`npc_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_text`
--

DROP TABLE IF EXISTS `npc_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_text` (
  `ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `text0_0` longtext,
  `text0_1` longtext,
  `lang0` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob0` float NOT NULL DEFAULT '0',
  `em0_0_delay` smallint(5) DEFAULT NULL,
  `em0_0` smallint(5) DEFAULT NULL,
  `em0_1_delay` smallint(5) DEFAULT NULL,
  `em0_1` smallint(5) DEFAULT NULL,
  `em0_2_delay` smallint(5) DEFAULT NULL,
  `em0_2` smallint(5) DEFAULT NULL,
  `text1_0` longtext,
  `text1_1` longtext,
  `lang1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob1` float NOT NULL DEFAULT '0',
  `em1_0_delay` smallint(5) DEFAULT NULL,
  `em1_0` smallint(5) DEFAULT NULL,
  `em1_1_delay` smallint(5) DEFAULT NULL,
  `em1_1` smallint(5) DEFAULT NULL,
  `em1_2_delay` smallint(5) DEFAULT NULL,
  `em1_2` smallint(5) DEFAULT NULL,
  `text2_0` longtext,
  `text2_1` longtext,
  `lang2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob2` float NOT NULL DEFAULT '0',
  `em2_0_delay` smallint(5) DEFAULT NULL,
  `em2_0` smallint(5) DEFAULT NULL,
  `em2_1_delay` smallint(5) DEFAULT NULL,
  `em2_1` smallint(5) DEFAULT NULL,
  `em2_2_delay` smallint(5) DEFAULT NULL,
  `em2_2` smallint(5) DEFAULT NULL,
  `text3_0` longtext,
  `text3_1` longtext,
  `lang3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob3` float NOT NULL DEFAULT '0',
  `em3_0_delay` smallint(5) DEFAULT NULL,
  `em3_0` smallint(5) DEFAULT NULL,
  `em3_1_delay` smallint(5) DEFAULT NULL,
  `em3_1` smallint(5) DEFAULT NULL,
  `em3_2_delay` smallint(5) DEFAULT NULL,
  `em3_2` smallint(5) DEFAULT NULL,
  `text4_0` longtext,
  `text4_1` longtext,
  `lang4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob4` float NOT NULL DEFAULT '0',
  `em4_0_delay` smallint(5) DEFAULT NULL,
  `em4_0` smallint(5) DEFAULT NULL,
  `em4_1_delay` smallint(5) DEFAULT NULL,
  `em4_1` smallint(5) DEFAULT NULL,
  `em4_2_delay` smallint(5) DEFAULT NULL,
  `em4_2` smallint(5) DEFAULT NULL,
  `text5_0` longtext,
  `text5_1` longtext,
  `lang5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob5` float NOT NULL DEFAULT '0',
  `em5_0_delay` smallint(5) DEFAULT NULL,
  `em5_0` smallint(5) DEFAULT NULL,
  `em5_1_delay` smallint(5) DEFAULT NULL,
  `em5_1` smallint(5) DEFAULT NULL,
  `em5_2_delay` smallint(5) DEFAULT NULL,
  `em5_2` smallint(5) DEFAULT NULL,
  `text6_0` longtext,
  `text6_1` longtext,
  `lang6` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob6` float NOT NULL DEFAULT '0',
  `em6_0_delay` smallint(5) DEFAULT NULL,
  `em6_0` smallint(5) DEFAULT NULL,
  `em6_1_delay` smallint(5) DEFAULT NULL,
  `em6_1` smallint(5) DEFAULT NULL,
  `em6_2_delay` smallint(5) DEFAULT NULL,
  `em6_2` smallint(5) DEFAULT NULL,
  `text7_0` longtext,
  `text7_1` longtext,
  `lang7` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob7` float NOT NULL DEFAULT '0',
  `em7_0_delay` smallint(5) DEFAULT NULL,
  `em7_0` smallint(5) DEFAULT NULL,
  `em7_1_delay` smallint(5) DEFAULT NULL,
  `em7_1` smallint(5) DEFAULT NULL,
  `em7_2_delay` smallint(5) DEFAULT NULL,
  `em7_2` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_text`
--

LOCK TABLES `npc_text` WRITE;
/*!40000 ALTER TABLE `npc_text` DISABLE KEYS */;
INSERT INTO `npc_text` VALUES
(580,'It is not yet your time. I shall aid your journey back to the realm of the living... for a price.',NULL,0,100,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `npc_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_trainer`
--

DROP TABLE IF EXISTS `npc_trainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_trainer` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spellcost` int(10) unsigned NOT NULL DEFAULT '0',
  `reqskill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `reqskillvalue` smallint(5) unsigned NOT NULL DEFAULT '0',
  `reqlevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_spell` (`entry`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_trainer_template`
--

DROP TABLE IF EXISTS `npc_trainer_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_trainer_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spellcost` int(10) unsigned NOT NULL DEFAULT '0',
  `reqskill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `reqskillvalue` smallint(5) unsigned NOT NULL DEFAULT '0',
  `reqlevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_spell` (`entry`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_vendor`
--

DROP TABLE IF EXISTS `npc_vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_vendor` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `incrtime` int(10) unsigned NOT NULL DEFAULT '0',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Npc System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `npc_vendor_template`
--

DROP TABLE IF EXISTS `npc_vendor_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_vendor_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `incrtime` int(10) unsigned NOT NULL DEFAULT '0',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Npc System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_text`
--

DROP TABLE IF EXISTS `page_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `text` longtext NOT NULL,
  `next_page` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_levelstats`
--

DROP TABLE IF EXISTS `pet_levelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_levelstats` (
  `creature_entry` mediumint(8) unsigned NOT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  `hp` smallint(5) unsigned NOT NULL,
  `mana` smallint(5) unsigned NOT NULL,
  `armor` int(10) unsigned NOT NULL DEFAULT '0',
  `str` smallint(5) unsigned NOT NULL,
  `agi` smallint(5) unsigned NOT NULL,
  `sta` smallint(5) unsigned NOT NULL,
  `inte` smallint(5) unsigned NOT NULL,
  `spi` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`creature_entry`,`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores pet levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_name_generation`
--

DROP TABLE IF EXISTS `pet_name_generation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_name_generation` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `word` tinytext NOT NULL,
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `half` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `petcreateinfo_spell`
--

DROP TABLE IF EXISTS `petcreateinfo_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `petcreateinfo_spell` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Spell1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Spell2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Spell3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Spell4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Pet Create Spells';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pickpocketing_loot_template`
--

DROP TABLE IF EXISTS `pickpocketing_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pickpocketing_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
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
  `basemana` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`class`,`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_levelstats`
--

DROP TABLE IF EXISTS `player_levelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_levelstats` (
  `race` tinyint(3) unsigned NOT NULL,
  `class` tinyint(3) unsigned NOT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  `str` tinyint(3) unsigned NOT NULL,
  `agi` tinyint(3) unsigned NOT NULL,
  `sta` tinyint(3) unsigned NOT NULL,
  `inte` tinyint(3) unsigned NOT NULL,
  `spi` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`race`,`class`,`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_xp_for_level`
--

DROP TABLE IF EXISTS `player_xp_for_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_xp_for_level` (
  `lvl` int(3) unsigned NOT NULL,
  `xp_for_next_level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`lvl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playercreateinfo`
--

DROP TABLE IF EXISTS `playercreateinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `zone` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo`
--

LOCK TABLES `playercreateinfo` WRITE;
/*!40000 ALTER TABLE `playercreateinfo` DISABLE KEYS */;
INSERT INTO `playercreateinfo` VALUES
(1,1,0,12,-8949.95,-132.493,83.5312,0),
(1,2,0,12,-8949.95,-132.493,83.5312,0),
(1,4,0,12,-8949.95,-132.493,83.5312,0),
(1,5,0,12,-8949.95,-132.493,83.5312,0),
(1,8,0,12,-8949.95,-132.493,83.5312,0),
(1,9,0,12,-8949.95,-132.493,83.5312,0),
(2,1,1,14,-618.518,-4251.67,38.718,0),
(2,3,1,14,-618.518,-4251.67,38.718,0),
(2,4,1,14,-618.518,-4251.67,38.718,0),
(2,7,1,14,-618.518,-4251.67,38.718,0),
(2,9,1,14,-618.518,-4251.67,38.718,0),
(3,1,0,1,-6240.32,331.033,382.758,6.17716),
(3,2,0,1,-6240.32,331.033,382.758,6.17716),
(3,3,0,1,-6240.32,331.033,382.758,6.17716),
(3,4,0,1,-6240.32,331.033,382.758,6.17716),
(3,5,0,1,-6240.32,331.033,382.758,6.17716),
(4,1,1,141,10311.3,832.463,1326.41,5.69632),
(4,3,1,141,10311.3,832.463,1326.41,5.69632),
(4,4,1,141,10311.3,832.463,1326.41,5.69632),
(4,5,1,141,10311.3,832.463,1326.41,5.69632),
(4,11,1,141,10311.3,832.463,1326.41,5.69632),
(5,1,0,85,1676.71,1678.31,121.67,2.70526),
(5,4,0,85,1676.71,1678.31,121.67,2.70526),
(5,5,0,85,1676.71,1678.31,121.67,2.70526),
(5,8,0,85,1676.71,1678.31,121.67,2.70526),
(5,9,0,85,1676.71,1678.31,121.67,2.70526),
(6,1,1,215,-2917.58,-257.98,52.9968,0),
(6,3,1,215,-2917.58,-257.98,52.9968,0),
(6,7,1,215,-2917.58,-257.98,52.9968,0),
(6,11,1,215,-2917.58,-257.98,52.9968,0),
(7,1,0,1,-6240.32,331.033,382.758,0),
(7,4,0,1,-6240.32,331.033,382.758,0),
(7,8,0,1,-6240.32,331.033,382.758,0),
(7,9,0,1,-6240.32,331.033,382.758,0),
(8,1,1,14,-618.518,-4251.67,38.718,0),
(8,3,1,14,-618.518,-4251.67,38.718,0),
(8,4,1,14,-618.518,-4251.67,38.718,0),
(8,5,1,14,-618.518,-4251.67,38.718,0),
(8,7,1,14,-618.518,-4251.67,38.718,0),
(8,8,1,14,-618.518,-4251.67,38.718,0);
/*!40000 ALTER TABLE `playercreateinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo_action`
--

DROP TABLE IF EXISTS `playercreateinfo_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_action` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `button` smallint(5) unsigned NOT NULL DEFAULT '0',
  `action` int(11) unsigned NOT NULL DEFAULT '0',
  `type` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`,`button`),
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo_action`
--

LOCK TABLES `playercreateinfo_action` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_action` DISABLE KEYS */;
INSERT INTO `playercreateinfo_action` VALUES
(1,1,72,6603,0),
(1,1,73,78,0),
(1,1,83,117,128),
(1,2,0,6603,0),
(1,2,1,21084,0),
(1,2,2,635,0),
(1,2,10,159,128),
(1,2,11,2070,128),
(1,4,0,6603,0),
(1,4,1,1752,0),
(1,4,2,2098,0),
(1,4,3,2764,0),
(1,4,11,2070,128),
(1,5,0,6603,0),
(1,5,1,585,0),
(1,5,2,2050,0),
(1,5,10,159,128),
(1,5,11,2070,128),
(1,8,0,6603,0),
(1,8,1,133,0),
(1,8,2,168,0),
(1,8,10,159,128),
(1,8,11,2070,128),
(1,9,0,6603,0),
(1,9,1,686,0),
(1,9,2,687,0),
(1,9,10,159,128),
(1,9,11,4604,128),
(2,1,72,6603,0),
(2,1,73,78,0),
(2,1,74,20572,0),
(2,1,83,117,128),
(2,3,0,6603,0),
(2,3,1,2973,0),
(2,3,2,75,0),
(2,3,3,20572,0),
(2,3,10,159,128),
(2,3,11,117,128),
(2,4,0,6603,0),
(2,4,1,1752,0),
(2,4,2,2098,0),
(2,4,3,2764,0),
(2,4,4,20572,0),
(2,4,11,117,128),
(2,7,0,6603,0),
(2,7,1,403,0),
(2,7,2,331,0),
(2,7,3,20572,0),
(2,7,10,159,128),
(2,7,11,117,128),
(2,9,0,6603,0),
(2,9,1,686,0),
(2,9,2,687,0),
(2,9,3,20572,0),
(2,9,10,159,128),
(2,9,11,117,128),
(3,1,72,6603,0),
(3,1,73,78,0),
(3,1,74,20594,0),
(3,1,75,2481,0),
(3,1,83,117,128),
(3,2,0,6603,0),
(3,2,1,21084,0),
(3,2,2,635,0),
(3,2,3,20594,0),
(3,2,4,2481,0),
(3,2,10,159,128),
(3,2,11,4540,128),
(3,3,0,6603,0),
(3,3,1,2973,0),
(3,3,2,75,0),
(3,3,3,20594,0),
(3,3,4,2481,0),
(3,3,10,159,128),
(3,3,11,117,128),
(3,4,0,6603,0),
(3,4,1,1752,0),
(3,4,2,2098,0),
(3,4,3,2764,0),
(3,4,4,20594,0),
(3,4,5,2481,0),
(3,4,11,4540,128),
(3,5,0,6603,0),
(3,5,1,585,0),
(3,5,2,2050,0),
(3,5,3,20594,0),
(3,5,4,2481,0),
(3,5,10,159,128),
(3,5,11,4540,128),
(4,1,72,6603,0),
(4,1,73,78,0),
(4,1,74,20580,0),
(4,1,83,117,128),
(4,3,0,6603,0),
(4,3,1,2973,0),
(4,3,2,75,0),
(4,3,3,20580,0),
(4,3,10,159,128),
(4,3,11,117,128),
(4,4,0,6603,0),
(4,4,1,1752,0),
(4,4,2,2098,0),
(4,4,3,2764,0),
(4,4,4,20580,0),
(4,4,11,4540,128),
(4,5,0,6603,0),
(4,5,1,585,0),
(4,5,2,2050,0),
(4,5,3,20580,0),
(4,5,10,159,128),
(4,5,11,2070,128),
(4,11,0,6603,0),
(4,11,1,5176,0),
(4,11,2,5185,0),
(4,11,3,20580,0),
(4,11,10,159,128),
(4,11,11,4536,128),
(5,1,72,6603,0),
(5,1,73,78,0),
(5,1,74,20577,0),
(5,1,83,4604,128),
(5,4,0,6603,0),
(5,4,1,1752,0),
(5,4,2,2098,0),
(5,4,3,2764,0),
(5,4,4,20577,0),
(5,4,11,4604,128),
(5,5,0,6603,0),
(5,5,1,585,0),
(5,5,2,2050,0),
(5,5,3,20577,0),
(5,5,10,159,128),
(5,5,11,4604,128),
(5,8,0,6603,0),
(5,8,1,133,0),
(5,8,2,168,0),
(5,8,3,20577,0),
(5,8,10,159,128),
(5,8,11,4604,128),
(5,9,0,6603,0),
(5,9,1,686,0),
(5,9,2,687,0),
(5,9,3,20577,0),
(5,9,10,159,128),
(5,9,11,4604,128),
(6,1,72,6603,0),
(6,1,73,78,0),
(6,1,74,20549,0),
(6,1,83,4540,128),
(6,3,0,6603,0),
(6,3,1,2973,0),
(6,3,2,75,0),
(6,3,3,20549,0),
(6,3,10,159,128),
(6,3,11,117,128),
(6,7,0,6603,0),
(6,7,1,403,0),
(6,7,2,331,0),
(6,7,3,20549,0),
(6,7,10,159,128),
(6,7,11,4604,128),
(6,11,0,6603,0),
(6,11,1,5176,0),
(6,11,2,5185,0),
(6,11,3,20549,0),
(6,11,10,159,128),
(6,11,11,4536,128),
(7,1,72,6603,0),
(7,1,73,78,0),
(7,1,83,117,128),
(7,4,0,6603,0),
(7,4,1,1752,0),
(7,4,2,2098,0),
(7,4,3,2764,0),
(7,4,11,117,128),
(7,8,0,6603,0),
(7,8,1,133,0),
(7,8,2,168,0),
(7,8,10,159,128),
(7,8,11,4536,128),
(7,9,0,6603,0),
(7,9,1,686,0),
(7,9,2,687,0),
(7,9,10,159,128),
(7,9,11,4604,128),
(8,1,72,6603,0),
(8,1,73,78,0),
(8,1,74,2764,0),
(8,1,75,26296,0),
(8,1,83,117,128),
(8,3,0,6603,0),
(8,3,1,2973,0),
(8,3,2,75,0),
(8,3,3,20554,0),
(8,3,10,159,128),
(8,3,11,4604,128),
(8,4,0,6603,0),
(8,4,1,1752,0),
(8,4,2,2098,0),
(8,4,3,2764,0),
(8,4,4,26297,0),
(8,4,11,117,128),
(8,5,0,6603,0),
(8,5,1,585,0),
(8,5,2,2050,0),
(8,5,3,20554,0),
(8,5,10,159,128),
(8,5,11,4540,128),
(8,7,0,6603,0),
(8,7,1,403,0),
(8,7,2,331,0),
(8,7,3,20554,0),
(8,7,10,159,128),
(8,7,11,117,128),
(8,8,0,6603,0),
(8,8,1,133,0),
(8,8,2,168,0),
(8,8,3,20554,0),
(8,8,10,159,128),
(8,8,11,117,128);
/*!40000 ALTER TABLE `playercreateinfo_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo_item`
--

DROP TABLE IF EXISTS `playercreateinfo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_item` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `itemid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `amount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playercreateinfo_spell`
--

DROP TABLE IF EXISTS `playercreateinfo_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_spell` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`race`,`class`,`Spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo_spell`
--

LOCK TABLES `playercreateinfo_spell` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_spell` DISABLE KEYS */;
INSERT INTO `playercreateinfo_spell` VALUES
(1,1,78,'Heroic Strike'),
(1,1,81,'Dodge'),
(1,1,107,'Block'),
(1,1,196,'One-Handed Axes'),
(1,1,198,'One-Handed Maces'),
(1,1,201,'One-Handed Swords'),
(1,1,203,'Unarmed'),
(1,1,204,'Defense'),
(1,1,522,'SPELLDEFENSE (DND)'),
(1,1,668,'Language Common'),
(1,1,2382,'Generic'),
(1,1,2457,'Battle Stance'),
(1,1,2479,'Honorless Target'),
(1,1,3050,'Detect'),
(1,1,3365,'Opening'),
(1,1,5301,'Defensive State (DND)'),
(1,1,6233,'Closing'),
(1,1,6246,'Closing'),
(1,1,6247,'Opening'),
(1,1,6477,'Opening'),
(1,1,6478,'Opening'),
(1,1,6603,'Attack'),
(1,1,7266,'Duel'),
(1,1,7267,'Grovel'),
(1,1,7355,'Stuck'),
(1,1,8386,'Attacking'),
(1,1,8737,'Mail'),
(1,1,9077,'Leather'),
(1,1,9078,'Cloth'),
(1,1,9116,'Shield'),
(1,1,9125,'Generic'),
(1,1,20597,'Sword Specialization'),
(1,1,20598,'The Human Spirit'),
(1,1,20599,'Diplomacy'),
(1,1,20600,'Perception'),
(1,1,20864,'Mace Specialization'),
(1,1,21651,'Opening'),
(1,1,21652,'Closing'),
(1,1,22027,'Remove Insignia'),
(1,1,22810,'Opening - No Text'),
(1,2,81,'Dodge'),
(1,2,107,'Block'),
(1,2,198,'One-Handed Maces'),
(1,2,199,'Two-Handed Maces'),
(1,2,203,'Unarmed'),
(1,2,204,'Defense'),
(1,2,522,'SPELLDEFENSE (DND)'),
(1,2,635,'Holy Light'),
(1,2,668,'Language Common'),
(1,2,2382,'Generic'),
(1,2,2479,'Honorless Target'),
(1,2,3050,'Detect'),
(1,2,3365,'Opening'),
(1,2,6233,'Closing'),
(1,2,6246,'Closing'),
(1,2,6247,'Opening'),
(1,2,6477,'Opening'),
(1,2,6478,'Opening'),
(1,2,6603,'Attack'),
(1,2,7266,'Duel'),
(1,2,7267,'Grovel'),
(1,2,7355,'Stuck'),
(1,2,8386,'Attacking'),
(1,2,8737,'Mail'),
(1,2,9077,'Leather'),
(1,2,9078,'Cloth'),
(1,2,9116,'Shield'),
(1,2,9125,'Generic'),
(1,2,20597,'Sword Specialization'),
(1,2,20598,'The Human Spirit'),
(1,2,20599,'Diplomacy'),
(1,2,20600,'Perception'),
(1,2,20864,'Mace Specialization'),
(1,2,21084,'Seal of Righteousness'),
(1,2,21651,'Opening'),
(1,2,21652,'Closing'),
(1,2,22027,'Remove Insignia'),
(1,2,22810,'Opening - No Text'),
(1,2,27762,'Libram'),
(1,4,81,'Dodge'),
(1,4,203,'Unarmed'),
(1,4,204,'Defense'),
(1,4,522,'SPELLDEFENSE (DND)'),
(1,4,668,'Language Common'),
(1,4,1180,'Daggers'),
(1,4,1752,'Sinister Strike'),
(1,4,2098,'Eviscerate'),
(1,4,2382,'Generic'),
(1,4,2479,'Honorless Target'),
(1,4,2567,'Thrown'),
(1,4,2764,'Throw'),
(1,4,3050,'Detect'),
(1,4,3365,'Opening'),
(1,4,6233,'Closing'),
(1,4,6246,'Closing'),
(1,4,6247,'Opening'),
(1,4,6477,'Opening'),
(1,4,6478,'Opening'),
(1,4,6603,'Attack'),
(1,4,7266,'Duel'),
(1,4,7267,'Grovel'),
(1,4,7355,'Stuck'),
(1,4,8386,'Attacking'),
(1,4,9077,'Leather'),
(1,4,9078,'Cloth'),
(1,4,9125,'Generic'),
(1,4,16092,'Defensive State (DND)'),
(1,4,20597,'Sword Specialization'),
(1,4,20598,'The Human Spirit'),
(1,4,20599,'Diplomacy'),
(1,4,20600,'Perception'),
(1,4,20864,'Mace Specialization'),
(1,4,21184,'Rogue Passive (DND)'),
(1,4,21651,'Opening'),
(1,4,21652,'Closing'),
(1,4,22027,'Remove Insignia'),
(1,4,22810,'Opening - No Text'),
(1,5,81,'Dodge'),
(1,5,198,'One-Handed Maces'),
(1,5,203,'Unarmed'),
(1,5,204,'Defense'),
(1,5,522,'SPELLDEFENSE (DND)'),
(1,5,585,'Smite'),
(1,5,668,'Language Common'),
(1,5,2050,'Lesser Heal'),
(1,5,2382,'Generic'),
(1,5,2479,'Honorless Target'),
(1,5,3050,'Detect'),
(1,5,3365,'Opening'),
(1,5,5009,'Wands'),
(1,5,5019,'Shoot'),
(1,5,6233,'Closing'),
(1,5,6246,'Closing'),
(1,5,6247,'Opening'),
(1,5,6477,'Opening'),
(1,5,6478,'Opening'),
(1,5,6603,'Attack'),
(1,5,7266,'Duel'),
(1,5,7267,'Grovel'),
(1,5,7355,'Stuck'),
(1,5,8386,'Attacking'),
(1,5,9078,'Cloth'),
(1,5,9125,'Generic'),
(1,5,20597,'Sword Specialization'),
(1,5,20598,'The Human Spirit'),
(1,5,20599,'Diplomacy'),
(1,5,20600,'Perception'),
(1,5,20864,'Mace Specialization'),
(1,5,21651,'Opening'),
(1,5,21652,'Closing'),
(1,5,22027,'Remove Insignia'),
(1,5,22810,'Opening - No Text'),
(1,8,81,'Dodge'),
(1,8,133,'Fireball'),
(1,8,168,'Frost Armor'),
(1,8,203,'Unarmed'),
(1,8,204,'Defense'),
(1,8,227,'Staves'),
(1,8,522,'SPELLDEFENSE (DND)'),
(1,8,668,'Language Common'),
(1,8,2382,'Generic'),
(1,8,2479,'Honorless Target'),
(1,8,3050,'Detect'),
(1,8,3365,'Opening'),
(1,8,5009,'Wands'),
(1,8,5019,'Shoot'),
(1,8,6233,'Closing'),
(1,8,6246,'Closing'),
(1,8,6247,'Opening'),
(1,8,6477,'Opening'),
(1,8,6478,'Opening'),
(1,8,6603,'Attack'),
(1,8,7266,'Duel'),
(1,8,7267,'Grovel'),
(1,8,7355,'Stuck'),
(1,8,8386,'Attacking'),
(1,8,9078,'Cloth'),
(1,8,9125,'Generic'),
(1,8,20597,'Sword Specialization'),
(1,8,20598,'The Human Spirit'),
(1,8,20599,'Diplomacy'),
(1,8,20600,'Perception'),
(1,8,20864,'Mace Specialization'),
(1,8,21651,'Opening'),
(1,8,21652,'Closing'),
(1,8,22027,'Remove Insignia'),
(1,8,22810,'Opening - No Text'),
(1,9,81,'Dodge'),
(1,9,203,'Unarmed'),
(1,9,204,'Defense'),
(1,9,522,'SPELLDEFENSE (DND)'),
(1,9,668,'Language Common'),
(1,9,686,'Shadow Bolt'),
(1,9,687,'Demon Skin'),
(1,9,1180,'Daggers'),
(1,9,2382,'Generic'),
(1,9,2479,'Honorless Target'),
(1,9,3050,'Detect'),
(1,9,3365,'Opening'),
(1,9,5009,'Wands'),
(1,9,5019,'Shoot'),
(1,9,6233,'Closing'),
(1,9,6246,'Closing'),
(1,9,6247,'Opening'),
(1,9,6477,'Opening'),
(1,9,6478,'Opening'),
(1,9,6603,'Attack'),
(1,9,7266,'Duel'),
(1,9,7267,'Grovel'),
(1,9,7355,'Stuck'),
(1,9,8386,'Attacking'),
(1,9,9078,'Cloth'),
(1,9,9125,'Generic'),
(1,9,20597,'Sword Specialization'),
(1,9,20598,'The Human Spirit'),
(1,9,20599,'Diplomacy'),
(1,9,20600,'Perception'),
(1,9,20864,'Mace Specialization'),
(1,9,21651,'Opening'),
(1,9,21652,'Closing'),
(1,9,22027,'Remove Insignia'),
(1,9,22810,'Opening - No Text'),
(2,1,78,'Heroic Strike'),
(2,1,81,'Dodge'),
(2,1,107,'Block'),
(2,1,196,'One-Handed Axes'),
(2,1,197,'Two-Handed Axes'),
(2,1,201,'One-Handed Swords'),
(2,1,203,'Unarmed'),
(2,1,204,'Defense'),
(2,1,522,'SPELLDEFENSE (DND)'),
(2,1,669,'Language Orcish'),
(2,1,2382,'Generic'),
(2,1,2457,'Battle Stance'),
(2,1,2479,'Honorless Target'),
(2,1,3050,'Detect'),
(2,1,3365,'Opening'),
(2,1,5301,'Defensive State (DND)'),
(2,1,6233,'Closing'),
(2,1,6246,'Closing'),
(2,1,6247,'Opening'),
(2,1,6477,'Opening'),
(2,1,6478,'Opening'),
(2,1,6603,'Attack'),
(2,1,7266,'Duel'),
(2,1,7267,'Grovel'),
(2,1,7355,'Stuck'),
(2,1,8386,'Attacking'),
(2,1,8737,'Mail'),
(2,1,9077,'Leather'),
(2,1,9078,'Cloth'),
(2,1,9116,'Shield'),
(2,1,9125,'Generic'),
(2,1,20572,'Blood Fury'),
(2,1,20573,'Hardiness'),
(2,1,20574,'Axe Specialization'),
(2,1,21563,'Command'),
(2,1,21651,'Opening'),
(2,1,21652,'Closing'),
(2,1,22027,'Remove Insignia'),
(2,1,22810,'Opening - No Text'),
(2,3,75,'Auto Shot'),
(2,3,81,'Dodge'),
(2,3,196,'One-Handed Axes'),
(2,3,203,'Unarmed'),
(2,3,204,'Defense'),
(2,3,264,'Bows'),
(2,3,522,'SPELLDEFENSE (DND)'),
(2,3,669,'Language Orcish'),
(2,3,2382,'Generic'),
(2,3,2479,'Honorless Target'),
(2,3,2973,'Raptor Strike'),
(2,3,3050,'Detect'),
(2,3,3365,'Opening'),
(2,3,6233,'Closing'),
(2,3,6246,'Closing'),
(2,3,6247,'Opening'),
(2,3,6477,'Opening'),
(2,3,6478,'Opening'),
(2,3,6603,'Attack'),
(2,3,7266,'Duel'),
(2,3,7267,'Grovel'),
(2,3,7355,'Stuck'),
(2,3,8386,'Attacking'),
(2,3,9077,'Leather'),
(2,3,9078,'Cloth'),
(2,3,9125,'Generic'),
(2,3,13358,'Defensive State (DND)'),
(2,3,20572,'Blood Fury'),
(2,3,20573,'Hardiness'),
(2,3,20574,'Axe Specialization'),
(2,3,20576,'Command'),
(2,3,21651,'Opening'),
(2,3,21652,'Closing'),
(2,3,22027,'Remove Insignia'),
(2,3,22810,'Opening - No Text'),
(2,3,24949,'Defensive State 2 (DND)'),
(2,4,81,'Dodge'),
(2,4,203,'Unarmed'),
(2,4,204,'Defense'),
(2,4,522,'SPELLDEFENSE (DND)'),
(2,4,669,'Language Orcish'),
(2,4,1180,'Daggers'),
(2,4,1752,'Sinister Strike'),
(2,4,2098,'Eviscerate'),
(2,4,2382,'Generic'),
(2,4,2479,'Honorless Target'),
(2,4,2567,'Thrown'),
(2,4,2764,'Throw'),
(2,4,3050,'Detect'),
(2,4,3365,'Opening'),
(2,4,6233,'Closing'),
(2,4,6246,'Closing'),
(2,4,6247,'Opening'),
(2,4,6477,'Opening'),
(2,4,6478,'Opening'),
(2,4,6603,'Attack'),
(2,4,7266,'Duel'),
(2,4,7267,'Grovel'),
(2,4,7355,'Stuck'),
(2,4,8386,'Attacking'),
(2,4,9077,'Leather'),
(2,4,9078,'Cloth'),
(2,4,9125,'Generic'),
(2,4,16092,'Defensive State (DND)'),
(2,4,20572,'Blood Fury'),
(2,4,20573,'Hardiness'),
(2,4,20574,'Axe Specialization'),
(2,4,21184,'Rogue Passive (DND)'),
(2,4,21563,'Command'),
(2,4,21651,'Opening'),
(2,4,21652,'Closing'),
(2,4,22027,'Remove Insignia'),
(2,4,22810,'Opening - No Text'),
(2,7,81,'Dodge'),
(2,7,107,'Block'),
(2,7,198,'One-Handed Maces'),
(2,7,203,'Unarmed'),
(2,7,204,'Defense'),
(2,7,227,'Staves'),
(2,7,331,'Healing Wave'),
(2,7,403,'Lightning Bolt'),
(2,7,522,'SPELLDEFENSE (DND)'),
(2,7,669,'Language Orcish'),
(2,7,2382,'Generic'),
(2,7,2479,'Honorless Target'),
(2,7,3050,'Detect'),
(2,7,3365,'Opening'),
(2,7,6233,'Closing'),
(2,7,6246,'Closing'),
(2,7,6247,'Opening'),
(2,7,6477,'Opening'),
(2,7,6478,'Opening'),
(2,7,6603,'Attack'),
(2,7,7266,'Duel'),
(2,7,7267,'Grovel'),
(2,7,7355,'Stuck'),
(2,7,8386,'Attacking'),
(2,7,9077,'Leather'),
(2,7,9078,'Cloth'),
(2,7,9116,'Shield'),
(2,7,9125,'Generic'),
(2,7,20572,'Blood Fury'),
(2,7,20573,'Hardiness'),
(2,7,20574,'Axe Specialization'),
(2,7,21563,'Command'),
(2,7,21651,'Opening'),
(2,7,21652,'Closing'),
(2,7,22027,'Remove Insignia'),
(2,7,22810,'Opening - No Text'),
(2,7,27763,'Totem'),
(2,9,81,'Dodge'),
(2,9,203,'Unarmed'),
(2,9,204,'Defense'),
(2,9,522,'SPELLDEFENSE (DND)'),
(2,9,669,'Language Orcish'),
(2,9,686,'Shadow Bolt'),
(2,9,687,'Demon Skin'),
(2,9,1180,'Daggers'),
(2,9,2382,'Generic'),
(2,9,2479,'Honorless Target'),
(2,9,3050,'Detect'),
(2,9,3365,'Opening'),
(2,9,5009,'Wands'),
(2,9,5019,'Shoot'),
(2,9,6233,'Closing'),
(2,9,6246,'Closing'),
(2,9,6247,'Opening'),
(2,9,6477,'Opening'),
(2,9,6478,'Opening'),
(2,9,6603,'Attack'),
(2,9,7266,'Duel'),
(2,9,7267,'Grovel'),
(2,9,7355,'Stuck'),
(2,9,8386,'Attacking'),
(2,9,9078,'Cloth'),
(2,9,9125,'Generic'),
(2,9,20572,'Blood Fury'),
(2,9,20573,'Hardiness'),
(2,9,20574,'Axe Specialization'),
(2,9,20575,'Command'),
(2,9,21651,'Opening'),
(2,9,21652,'Closing'),
(2,9,22027,'Remove Insignia'),
(2,9,22810,'Opening - No Text'),
(3,1,78,'Heroic Strike'),
(3,1,81,'Dodge'),
(3,1,107,'Block'),
(3,1,196,'One-Handed Axes'),
(3,1,197,'Two-Handed Axes'),
(3,1,198,'One-Handed Maces'),
(3,1,203,'Unarmed'),
(3,1,204,'Defense'),
(3,1,522,'SPELLDEFENSE (DND)'),
(3,1,668,'Language Common'),
(3,1,672,'Language Dwarven'),
(3,1,2382,'Generic'),
(3,1,2457,'Battle Stance'),
(3,1,2479,'Honorless Target'),
(3,1,2481,'Find Treasure'),
(3,1,3050,'Detect'),
(3,1,3365,'Opening'),
(3,1,5301,'Defensive State (DND)'),
(3,1,6233,'Closing'),
(3,1,6246,'Closing'),
(3,1,6247,'Opening'),
(3,1,6477,'Opening'),
(3,1,6478,'Opening'),
(3,1,6603,'Attack'),
(3,1,7266,'Duel'),
(3,1,7267,'Grovel'),
(3,1,7355,'Stuck'),
(3,1,8386,'Attacking'),
(3,1,8737,'Mail'),
(3,1,9077,'Leather'),
(3,1,9078,'Cloth'),
(3,1,9116,'Shield'),
(3,1,9125,'Generic'),
(3,1,20594,'Stoneform'),
(3,1,20595,'Gun Specialization'),
(3,1,20596,'Frost Resistance'),
(3,1,21651,'Opening'),
(3,1,21652,'Closing'),
(3,1,22027,'Remove Insignia'),
(3,1,22810,'Opening - No Text'),
(3,2,81,'Dodge'),
(3,2,107,'Block'),
(3,2,198,'One-Handed Maces'),
(3,2,199,'Two-Handed Maces'),
(3,2,203,'Unarmed'),
(3,2,204,'Defense'),
(3,2,522,'SPELLDEFENSE (DND)'),
(3,2,635,'Holy Light'),
(3,2,668,'Language Common'),
(3,2,672,'Language Dwarven'),
(3,2,2382,'Generic'),
(3,2,2479,'Honorless Target'),
(3,2,2481,'Find Treasure'),
(3,2,3050,'Detect'),
(3,2,3365,'Opening'),
(3,2,6233,'Closing'),
(3,2,6246,'Closing'),
(3,2,6247,'Opening'),
(3,2,6477,'Opening'),
(3,2,6478,'Opening'),
(3,2,6603,'Attack'),
(3,2,7266,'Duel'),
(3,2,7267,'Grovel'),
(3,2,7355,'Stuck'),
(3,2,8386,'Attacking'),
(3,2,8737,'Mail'),
(3,2,9077,'Leather'),
(3,2,9078,'Cloth'),
(3,2,9116,'Shield'),
(3,2,9125,'Generic'),
(3,2,20594,'Stoneform'),
(3,2,20595,'Gun Specialization'),
(3,2,20596,'Frost Resistance'),
(3,2,21084,'Seal of Righteousness'),
(3,2,21651,'Opening'),
(3,2,21652,'Closing'),
(3,2,22027,'Remove Insignia'),
(3,2,22810,'Opening - No Text'),
(3,2,27762,'Libram'),
(3,3,75,'Auto Shot'),
(3,3,81,'Dodge'),
(3,3,196,'One-Handed Axes'),
(3,3,203,'Unarmed'),
(3,3,204,'Defense'),
(3,3,266,'Guns'),
(3,3,522,'SPELLDEFENSE (DND)'),
(3,3,668,'Language Common'),
(3,3,672,'Language Dwarven'),
(3,3,2382,'Generic'),
(3,3,2479,'Honorless Target'),
(3,3,2481,'Find Treasure'),
(3,3,2973,'Raptor Strike'),
(3,3,3050,'Detect'),
(3,3,3365,'Opening'),
(3,3,6233,'Closing'),
(3,3,6246,'Closing'),
(3,3,6247,'Opening'),
(3,3,6477,'Opening'),
(3,3,6478,'Opening'),
(3,3,6603,'Attack'),
(3,3,7266,'Duel'),
(3,3,7267,'Grovel'),
(3,3,7355,'Stuck'),
(3,3,8386,'Attacking'),
(3,3,9077,'Leather'),
(3,3,9078,'Cloth'),
(3,3,9125,'Generic'),
(3,3,13358,'Defensive State (DND)'),
(3,3,20594,'Stoneform'),
(3,3,20595,'Gun Specialization'),
(3,3,20596,'Frost Resistance'),
(3,3,21651,'Opening'),
(3,3,21652,'Closing'),
(3,3,22027,'Remove Insignia'),
(3,3,22810,'Opening - No Text'),
(3,3,24949,'Defensive State 2 (DND)'),
(3,4,81,'Dodge'),
(3,4,203,'Unarmed'),
(3,4,204,'Defense'),
(3,4,522,'SPELLDEFENSE (DND)'),
(3,4,668,'Language Common'),
(3,4,672,'Language Dwarven'),
(3,4,1180,'Daggers'),
(3,4,1752,'Sinister Strike'),
(3,4,2098,'Eviscerate'),
(3,4,2382,'Generic'),
(3,4,2479,'Honorless Target'),
(3,4,2481,'Find Treasure'),
(3,4,2567,'Thrown'),
(3,4,2764,'Throw'),
(3,4,3050,'Detect'),
(3,4,3365,'Opening'),
(3,4,6233,'Closing'),
(3,4,6246,'Closing'),
(3,4,6247,'Opening'),
(3,4,6477,'Opening'),
(3,4,6478,'Opening'),
(3,4,6603,'Attack'),
(3,4,7266,'Duel'),
(3,4,7267,'Grovel'),
(3,4,7355,'Stuck'),
(3,4,8386,'Attacking'),
(3,4,9077,'Leather'),
(3,4,9078,'Cloth'),
(3,4,9125,'Generic'),
(3,4,16092,'Defensive State (DND)'),
(3,4,20594,'Stoneform'),
(3,4,20595,'Gun Specialization'),
(3,4,20596,'Frost Resistance'),
(3,4,21184,'Rogue Passive (DND)'),
(3,4,21651,'Opening'),
(3,4,21652,'Closing'),
(3,4,22027,'Remove Insignia'),
(3,4,22810,'Opening - No Text'),
(3,5,81,'Dodge'),
(3,5,198,'One-Handed Maces'),
(3,5,203,'Unarmed'),
(3,5,204,'Defense'),
(3,5,522,'SPELLDEFENSE (DND)'),
(3,5,585,'Smite'),
(3,5,668,'Language Common'),
(3,5,672,'Language Dwarven'),
(3,5,2050,'Lesser Heal'),
(3,5,2382,'Generic'),
(3,5,2479,'Honorless Target'),
(3,5,2481,'Find Treasure'),
(3,5,3050,'Detect'),
(3,5,3365,'Opening'),
(3,5,5009,'Wands'),
(3,5,5019,'Shoot'),
(3,5,6233,'Closing'),
(3,5,6246,'Closing'),
(3,5,6247,'Opening'),
(3,5,6477,'Opening'),
(3,5,6478,'Opening'),
(3,5,6603,'Attack'),
(3,5,7266,'Duel'),
(3,5,7267,'Grovel'),
(3,5,7355,'Stuck'),
(3,5,8386,'Attacking'),
(3,5,9078,'Cloth'),
(3,5,9125,'Generic'),
(3,5,20594,'Stoneform'),
(3,5,20595,'Gun Specialization'),
(3,5,20596,'Frost Resistance'),
(3,5,21651,'Opening'),
(3,5,21652,'Closing'),
(3,5,22027,'Remove Insignia'),
(3,5,22810,'Opening - No Text'),
(4,1,78,'Heroic Strike'),
(4,1,81,'Dodge'),
(4,1,107,'Block'),
(4,1,198,'One-Handed Maces'),
(4,1,201,'One-Handed Swords'),
(4,1,203,'Unarmed'),
(4,1,204,'Defense'),
(4,1,522,'SPELLDEFENSE (DND)'),
(4,1,668,'Language Common'),
(4,1,671,'Language Darnassian'),
(4,1,1180,'Daggers'),
(4,1,2382,'Generic'),
(4,1,2457,'Battle Stance'),
(4,1,2479,'Honorless Target'),
(4,1,3050,'Detect'),
(4,1,3365,'Opening'),
(4,1,5301,'Defensive State (DND)'),
(4,1,6233,'Closing'),
(4,1,6246,'Closing'),
(4,1,6247,'Opening'),
(4,1,6477,'Opening'),
(4,1,6478,'Opening'),
(4,1,6603,'Attack'),
(4,1,7266,'Duel'),
(4,1,7267,'Grovel'),
(4,1,7355,'Stuck'),
(4,1,8386,'Attacking'),
(4,1,8737,'Mail'),
(4,1,9077,'Leather'),
(4,1,9078,'Cloth'),
(4,1,9116,'Shield'),
(4,1,9125,'Generic'),
(4,1,20580,'Shadowmeld'),
(4,1,20582,'Quickness'),
(4,1,20583,'Nature Resistance'),
(4,1,20585,'Wisp Spirit'),
(4,1,21009,'Shadowmeld Passive'),
(4,1,21651,'Opening'),
(4,1,21652,'Closing'),
(4,1,22027,'Remove Insignia'),
(4,1,22810,'Opening - No Text'),
(4,3,75,'Auto Shot'),
(4,3,81,'Dodge'),
(4,3,203,'Unarmed'),
(4,3,204,'Defense'),
(4,3,264,'Bows'),
(4,3,522,'SPELLDEFENSE (DND)'),
(4,3,668,'Language Common'),
(4,3,671,'Language Darnassian'),
(4,3,1180,'Daggers'),
(4,3,2382,'Generic'),
(4,3,2479,'Honorless Target'),
(4,3,2973,'Raptor Strike'),
(4,3,3050,'Detect'),
(4,3,3365,'Opening'),
(4,3,6233,'Closing'),
(4,3,6246,'Closing'),
(4,3,6247,'Opening'),
(4,3,6477,'Opening'),
(4,3,6478,'Opening'),
(4,3,6603,'Attack'),
(4,3,7266,'Duel'),
(4,3,7267,'Grovel'),
(4,3,7355,'Stuck'),
(4,3,8386,'Attacking'),
(4,3,9077,'Leather'),
(4,3,9078,'Cloth'),
(4,3,9125,'Generic'),
(4,3,13358,'Defensive State (DND)'),
(4,3,20580,'Shadowmeld'),
(4,3,20582,'Quickness'),
(4,3,20583,'Nature Resistance'),
(4,3,20585,'Wisp Spirit'),
(4,3,21009,'Shadowmeld Passive'),
(4,3,21651,'Opening'),
(4,3,21652,'Closing'),
(4,3,22027,'Remove Insignia'),
(4,3,22810,'Opening - No Text'),
(4,3,24949,'Defensive State 2 (DND)'),
(4,4,81,'Dodge'),
(4,4,203,'Unarmed'),
(4,4,204,'Defense'),
(4,4,522,'SPELLDEFENSE (DND)'),
(4,4,668,'Language Common'),
(4,4,671,'Language Darnassian'),
(4,4,1180,'Daggers'),
(4,4,1752,'Sinister Strike'),
(4,4,2098,'Eviscerate'),
(4,4,2382,'Generic'),
(4,4,2479,'Honorless Target'),
(4,4,2567,'Thrown'),
(4,4,2764,'Throw'),
(4,4,3050,'Detect'),
(4,4,3365,'Opening'),
(4,4,6233,'Closing'),
(4,4,6246,'Closing'),
(4,4,6247,'Opening'),
(4,4,6477,'Opening'),
(4,4,6478,'Opening'),
(4,4,6603,'Attack'),
(4,4,7266,'Duel'),
(4,4,7267,'Grovel'),
(4,4,7355,'Stuck'),
(4,4,8386,'Attacking'),
(4,4,9077,'Leather'),
(4,4,9078,'Cloth'),
(4,4,9125,'Generic'),
(4,4,16092,'Defensive State (DND)'),
(4,4,20580,'Shadowmeld'),
(4,4,20582,'Quickness'),
(4,4,20583,'Nature Resistance'),
(4,4,20585,'Wisp Spirit'),
(4,4,21009,'Shadowmeld Passive'),
(4,4,21184,'Rogue Passive (DND)'),
(4,4,21651,'Opening'),
(4,4,21652,'Closing'),
(4,4,22027,'Remove Insignia'),
(4,4,22810,'Opening - No Text'),
(4,5,81,'Dodge'),
(4,5,198,'One-Handed Maces'),
(4,5,203,'Unarmed'),
(4,5,204,'Defense'),
(4,5,522,'SPELLDEFENSE (DND)'),
(4,5,585,'Smite'),
(4,5,668,'Language Common'),
(4,5,671,'Language Darnassian'),
(4,5,2050,'Lesser Heal'),
(4,5,2382,'Generic'),
(4,5,2479,'Honorless Target'),
(4,5,3050,'Detect'),
(4,5,3365,'Opening'),
(4,5,5009,'Wands'),
(4,5,5019,'Shoot'),
(4,5,6233,'Closing'),
(4,5,6246,'Closing'),
(4,5,6247,'Opening'),
(4,5,6477,'Opening'),
(4,5,6478,'Opening'),
(4,5,6603,'Attack'),
(4,5,7266,'Duel'),
(4,5,7267,'Grovel'),
(4,5,7355,'Stuck'),
(4,5,8386,'Attacking'),
(4,5,9078,'Cloth'),
(4,5,9125,'Generic'),
(4,5,20580,'Shadowmeld'),
(4,5,20582,'Quickness'),
(4,5,20583,'Nature Resistance'),
(4,5,20585,'Wisp Spirit'),
(4,5,21009,'Shadowmeld Passive'),
(4,5,21651,'Opening'),
(4,5,21652,'Closing'),
(4,5,22027,'Remove Insignia'),
(4,5,22810,'Opening - No Text'),
(4,11,81,'Dodge'),
(4,11,203,'Unarmed'),
(4,11,204,'Defense'),
(4,11,227,'Staves'),
(4,11,522,'SPELLDEFENSE (DND)'),
(4,11,668,'Language Common'),
(4,11,671,'Language Darnassian'),
(4,11,1180,'Daggers'),
(4,11,2382,'Generic'),
(4,11,2479,'Honorless Target'),
(4,11,3050,'Detect'),
(4,11,3365,'Opening'),
(4,11,5176,'Wrath'),
(4,11,5185,'Healing Touch'),
(4,11,6233,'Closing'),
(4,11,6246,'Closing'),
(4,11,6247,'Opening'),
(4,11,6477,'Opening'),
(4,11,6478,'Opening'),
(4,11,6603,'Attack'),
(4,11,7266,'Duel'),
(4,11,7267,'Grovel'),
(4,11,7355,'Stuck'),
(4,11,8386,'Attacking'),
(4,11,9077,'Leather'),
(4,11,9078,'Cloth'),
(4,11,9125,'Generic'),
(4,11,20580,'Shadowmeld'),
(4,11,20582,'Quickness'),
(4,11,20583,'Nature Resistance'),
(4,11,20585,'Wisp Spirit'),
(4,11,21009,'Shadowmeld Passive'),
(4,11,21651,'Opening'),
(4,11,21652,'Closing'),
(4,11,22027,'Remove Insignia'),
(4,11,22810,'Opening - No Text'),
(4,11,27764,'Fetish'),
(5,1,78,'Heroic Strike'),
(5,1,81,'Dodge'),
(5,1,107,'Block'),
(5,1,201,'One-Handed Swords'),
(5,1,202,'Two-Handed Swords'),
(5,1,203,'Unarmed'),
(5,1,204,'Defense'),
(5,1,522,'SPELLDEFENSE (DND)'),
(5,1,669,'Language Orcish'),
(5,1,1180,'Daggers'),
(5,1,2382,'Generic'),
(5,1,2457,'Battle Stance'),
(5,1,2479,'Honorless Target'),
(5,1,3050,'Detect'),
(5,1,3365,'Opening'),
(5,1,5227,'Underwater Breathing'),
(5,1,5301,'Defensive State (DND)'),
(5,1,6233,'Closing'),
(5,1,6246,'Closing'),
(5,1,6247,'Opening'),
(5,1,6477,'Opening'),
(5,1,6478,'Opening'),
(5,1,6603,'Attack'),
(5,1,7266,'Duel'),
(5,1,7267,'Grovel'),
(5,1,7355,'Stuck'),
(5,1,7744,'Will of the Forsaken'),
(5,1,8386,'Attacking'),
(5,1,8737,'Mail'),
(5,1,9077,'Leather'),
(5,1,9078,'Cloth'),
(5,1,9116,'Shield'),
(5,1,9125,'Generic'),
(5,1,17737,'Language Gutterspeak'),
(5,1,20577,'Cannibalize'),
(5,1,20579,'Shadow Resistance'),
(5,1,21651,'Opening'),
(5,1,21652,'Closing'),
(5,1,22027,'Remove Insignia'),
(5,1,22810,'Opening - No Text'),
(5,4,81,'Dodge'),
(5,4,203,'Unarmed'),
(5,4,204,'Defense'),
(5,4,522,'SPELLDEFENSE (DND)'),
(5,4,669,'Language Orcish'),
(5,4,1180,'Daggers'),
(5,4,1752,'Sinister Strike'),
(5,4,2098,'Eviscerate'),
(5,4,2382,'Generic'),
(5,4,2479,'Honorless Target'),
(5,4,2567,'Thrown'),
(5,4,2764,'Throw'),
(5,4,3050,'Detect'),
(5,4,3365,'Opening'),
(5,4,5227,'Underwater Breathing'),
(5,4,6233,'Closing'),
(5,4,6246,'Closing'),
(5,4,6247,'Opening'),
(5,4,6477,'Opening'),
(5,4,6478,'Opening'),
(5,4,6603,'Attack'),
(5,4,7266,'Duel'),
(5,4,7267,'Grovel'),
(5,4,7355,'Stuck'),
(5,4,7744,'Will of the Forsaken'),
(5,4,8386,'Attacking'),
(5,4,9077,'Leather'),
(5,4,9078,'Cloth'),
(5,4,9125,'Generic'),
(5,4,16092,'Defensive State (DND)'),
(5,4,17737,'Language Gutterspeak'),
(5,4,20577,'Cannibalize'),
(5,4,20579,'Shadow Resistance'),
(5,4,21184,'Rogue Passive (DND)'),
(5,4,21651,'Opening'),
(5,4,21652,'Closing'),
(5,4,22027,'Remove Insignia'),
(5,4,22810,'Opening - No Text'),
(5,5,81,'Dodge'),
(5,5,198,'One-Handed Maces'),
(5,5,203,'Unarmed'),
(5,5,204,'Defense'),
(5,5,522,'SPELLDEFENSE (DND)'),
(5,5,585,'Smite'),
(5,5,669,'Language Orcish'),
(5,5,2050,'Lesser Heal'),
(5,5,2382,'Generic'),
(5,5,2479,'Honorless Target'),
(5,5,3050,'Detect'),
(5,5,3365,'Opening'),
(5,5,5009,'Wands'),
(5,5,5019,'Shoot'),
(5,5,5227,'Underwater Breathing'),
(5,5,6233,'Closing'),
(5,5,6246,'Closing'),
(5,5,6247,'Opening'),
(5,5,6477,'Opening'),
(5,5,6478,'Opening'),
(5,5,6603,'Attack'),
(5,5,7266,'Duel'),
(5,5,7267,'Grovel'),
(5,5,7355,'Stuck'),
(5,5,7744,'Will of the Forsaken'),
(5,5,8386,'Attacking'),
(5,5,9078,'Cloth'),
(5,5,9125,'Generic'),
(5,5,17737,'Language Gutterspeak'),
(5,5,20577,'Cannibalize'),
(5,5,20579,'Shadow Resistance'),
(5,5,21651,'Opening'),
(5,5,21652,'Closing'),
(5,5,22027,'Remove Insignia'),
(5,5,22810,'Opening - No Text'),
(5,8,81,'Dodge'),
(5,8,133,'Fireball'),
(5,8,168,'Frost Armor'),
(5,8,203,'Unarmed'),
(5,8,204,'Defense'),
(5,8,227,'Staves'),
(5,8,522,'SPELLDEFENSE (DND)'),
(5,8,669,'Language Orcish'),
(5,8,2382,'Generic'),
(5,8,2479,'Honorless Target'),
(5,8,3050,'Detect'),
(5,8,3365,'Opening'),
(5,8,5009,'Wands'),
(5,8,5019,'Shoot'),
(5,8,5227,'Underwater Breathing'),
(5,8,6233,'Closing'),
(5,8,6246,'Closing'),
(5,8,6247,'Opening'),
(5,8,6477,'Opening'),
(5,8,6478,'Opening'),
(5,8,6603,'Attack'),
(5,8,7266,'Duel'),
(5,8,7267,'Grovel'),
(5,8,7355,'Stuck'),
(5,8,7744,'Will of the Forsaken'),
(5,8,8386,'Attacking'),
(5,8,9078,'Cloth'),
(5,8,9125,'Generic'),
(5,8,17737,'Language Gutterspeak'),
(5,8,20577,'Cannibalize'),
(5,8,20579,'Shadow Resistance'),
(5,8,21651,'Opening'),
(5,8,21652,'Closing'),
(5,8,22027,'Remove Insignia'),
(5,8,22810,'Opening - No Text'),
(5,9,81,'Dodge'),
(5,9,203,'Unarmed'),
(5,9,204,'Defense'),
(5,9,522,'SPELLDEFENSE (DND)'),
(5,9,669,'Language Orcish'),
(5,9,686,'Shadow Bolt'),
(5,9,687,'Demon Skin'),
(5,9,1180,'Daggers'),
(5,9,2382,'Generic'),
(5,9,2479,'Honorless Target'),
(5,9,3050,'Detect'),
(5,9,3365,'Opening'),
(5,9,5009,'Wands'),
(5,9,5019,'Shoot'),
(5,9,5227,'Underwater Breathing'),
(5,9,6233,'Closing'),
(5,9,6246,'Closing'),
(5,9,6247,'Opening'),
(5,9,6477,'Opening'),
(5,9,6478,'Opening'),
(5,9,6603,'Attack'),
(5,9,7266,'Duel'),
(5,9,7267,'Grovel'),
(5,9,7355,'Stuck'),
(5,9,7744,'Will of the Forsaken'),
(5,9,8386,'Attacking'),
(5,9,9078,'Cloth'),
(5,9,9125,'Generic'),
(5,9,17737,'Language Gutterspeak'),
(5,9,20577,'Cannibalize'),
(5,9,20579,'Shadow Resistance'),
(5,9,21651,'Opening'),
(5,9,21652,'Closing'),
(5,9,22027,'Remove Insignia'),
(5,9,22810,'Opening - No Text'),
(6,1,78,'Heroic Strike'),
(6,1,81,'Dodge'),
(6,1,107,'Block'),
(6,1,196,'One-Handed Axes'),
(6,1,198,'One-Handed Maces'),
(6,1,199,'Two-Handed Maces'),
(6,1,203,'Unarmed'),
(6,1,204,'Defense'),
(6,1,522,'SPELLDEFENSE (DND)'),
(6,1,669,'Language Orcish'),
(6,1,670,'Language Taurahe'),
(6,1,2382,'Generic'),
(6,1,2457,'Battle Stance'),
(6,1,2479,'Honorless Target'),
(6,1,3050,'Detect'),
(6,1,3365,'Opening'),
(6,1,5301,'Defensive State (DND)'),
(6,1,6233,'Closing'),
(6,1,6246,'Closing'),
(6,1,6247,'Opening'),
(6,1,6477,'Opening'),
(6,1,6478,'Opening'),
(6,1,6603,'Attack'),
(6,1,7266,'Duel'),
(6,1,7267,'Grovel'),
(6,1,7355,'Stuck'),
(6,1,8386,'Attacking'),
(6,1,8737,'Mail'),
(6,1,9077,'Leather'),
(6,1,9078,'Cloth'),
(6,1,9116,'Shield'),
(6,1,9125,'Generic'),
(6,1,20549,'War Stomp'),
(6,1,20550,'Endurance'),
(6,1,20551,'Nature Resistance'),
(6,1,20552,'Cultivation'),
(6,1,21651,'Opening'),
(6,1,21652,'Closing'),
(6,1,22027,'Remove Insignia'),
(6,1,22810,'Opening - No Text'),
(6,3,75,'Auto Shot'),
(6,3,81,'Dodge'),
(6,3,196,'One-Handed Axes'),
(6,3,203,'Unarmed'),
(6,3,204,'Defense'),
(6,3,266,'Guns'),
(6,3,522,'SPELLDEFENSE (DND)'),
(6,3,669,'Language Orcish'),
(6,3,670,'Language Taurahe'),
(6,3,2382,'Generic'),
(6,3,2479,'Honorless Target'),
(6,3,2973,'Raptor Strike'),
(6,3,3050,'Detect'),
(6,3,3365,'Opening'),
(6,3,6233,'Closing'),
(6,3,6246,'Closing'),
(6,3,6247,'Opening'),
(6,3,6477,'Opening'),
(6,3,6478,'Opening'),
(6,3,6603,'Attack'),
(6,3,7266,'Duel'),
(6,3,7267,'Grovel'),
(6,3,7355,'Stuck'),
(6,3,8386,'Attacking'),
(6,3,9077,'Leather'),
(6,3,9078,'Cloth'),
(6,3,9125,'Generic'),
(6,3,13358,'Defensive State (DND)'),
(6,3,20549,'War Stomp'),
(6,3,20550,'Endurance'),
(6,3,20551,'Nature Resistance'),
(6,3,20552,'Cultivation'),
(6,3,21651,'Opening'),
(6,3,21652,'Closing'),
(6,3,22027,'Remove Insignia'),
(6,3,22810,'Opening - No Text'),
(6,3,24949,'Defensive State 2 (DND)'),
(6,7,81,'Dodge'),
(6,7,107,'Block'),
(6,7,198,'One-Handed Maces'),
(6,7,203,'Unarmed'),
(6,7,204,'Defense'),
(6,7,227,'Staves'),
(6,7,331,'Healing Wave'),
(6,7,403,'Lightning Bolt'),
(6,7,522,'SPELLDEFENSE (DND)'),
(6,7,669,'Language Orcish'),
(6,7,670,'Language Taurahe'),
(6,7,2382,'Generic'),
(6,7,2479,'Honorless Target'),
(6,7,3050,'Detect'),
(6,7,3365,'Opening'),
(6,7,6233,'Closing'),
(6,7,6246,'Closing'),
(6,7,6247,'Opening'),
(6,7,6477,'Opening'),
(6,7,6478,'Opening'),
(6,7,6603,'Attack'),
(6,7,7266,'Duel'),
(6,7,7267,'Grovel'),
(6,7,7355,'Stuck'),
(6,7,8386,'Attacking'),
(6,7,9077,'Leather'),
(6,7,9078,'Cloth'),
(6,7,9116,'Shield'),
(6,7,9125,'Generic'),
(6,7,20549,'War Stomp'),
(6,7,20550,'Endurance'),
(6,7,20551,'Nature Resistance'),
(6,7,20552,'Cultivation'),
(6,7,21651,'Opening'),
(6,7,21652,'Closing'),
(6,7,22027,'Remove Insignia'),
(6,7,22810,'Opening - No Text'),
(6,7,27763,'Totem'),
(6,11,81,'Dodge'),
(6,11,198,'One-Handed Maces'),
(6,11,203,'Unarmed'),
(6,11,204,'Defense'),
(6,11,227,'Staves'),
(6,11,522,'SPELLDEFENSE (DND)'),
(6,11,669,'Language Orcish'),
(6,11,670,'Language Taurahe'),
(6,11,2382,'Generic'),
(6,11,2479,'Honorless Target'),
(6,11,3050,'Detect'),
(6,11,3365,'Opening'),
(6,11,5176,'Wrath'),
(6,11,5185,'Healing Touch'),
(6,11,6233,'Closing'),
(6,11,6246,'Closing'),
(6,11,6247,'Opening'),
(6,11,6477,'Opening'),
(6,11,6478,'Opening'),
(6,11,6603,'Attack'),
(6,11,7266,'Duel'),
(6,11,7267,'Grovel'),
(6,11,7355,'Stuck'),
(6,11,8386,'Attacking'),
(6,11,9077,'Leather'),
(6,11,9078,'Cloth'),
(6,11,9125,'Generic'),
(6,11,20549,'War Stomp'),
(6,11,20550,'Endurance'),
(6,11,20551,'Nature Resistance'),
(6,11,20552,'Cultivation'),
(6,11,21651,'Opening'),
(6,11,21652,'Closing'),
(6,11,22027,'Remove Insignia'),
(6,11,22810,'Opening - No Text'),
(6,11,27764,'Fetish'),
(7,1,78,'Heroic Strike'),
(7,1,81,'Dodge'),
(7,1,107,'Block'),
(7,1,198,'One-Handed Maces'),
(7,1,201,'One-Handed Swords'),
(7,1,203,'Unarmed'),
(7,1,204,'Defense'),
(7,1,522,'SPELLDEFENSE (DND)'),
(7,1,668,'Language Common'),
(7,1,1180,'Daggers'),
(7,1,2382,'Generic'),
(7,1,2457,'Battle Stance'),
(7,1,2479,'Honorless Target'),
(7,1,3050,'Detect'),
(7,1,3365,'Opening'),
(7,1,5301,'Defensive State (DND)'),
(7,1,6233,'Closing'),
(7,1,6246,'Closing'),
(7,1,6247,'Opening'),
(7,1,6477,'Opening'),
(7,1,6478,'Opening'),
(7,1,6603,'Attack'),
(7,1,7266,'Duel'),
(7,1,7267,'Grovel'),
(7,1,7340,'Language Gnomish'),
(7,1,7355,'Stuck'),
(7,1,8386,'Attacking'),
(7,1,8737,'Mail'),
(7,1,9077,'Leather'),
(7,1,9078,'Cloth'),
(7,1,9116,'Shield'),
(7,1,9125,'Generic'),
(7,1,20589,'Escape Artist'),
(7,1,20591,'Expansive Mind'),
(7,1,20592,'Arcane Resistance'),
(7,1,20593,'Engineering Specialization'),
(7,1,21651,'Opening'),
(7,1,21652,'Closing'),
(7,1,22027,'Remove Insignia'),
(7,1,22810,'Opening - No Text'),
(7,4,81,'Dodge'),
(7,4,203,'Unarmed'),
(7,4,204,'Defense'),
(7,4,522,'SPELLDEFENSE (DND)'),
(7,4,668,'Language Common'),
(7,4,1180,'Daggers'),
(7,4,1752,'Sinister Strike'),
(7,4,2098,'Eviscerate'),
(7,4,2382,'Generic'),
(7,4,2479,'Honorless Target'),
(7,4,2567,'Thrown'),
(7,4,2764,'Throw'),
(7,4,3050,'Detect'),
(7,4,3365,'Opening'),
(7,4,6233,'Closing'),
(7,4,6246,'Closing'),
(7,4,6247,'Opening'),
(7,4,6477,'Opening'),
(7,4,6478,'Opening'),
(7,4,6603,'Attack'),
(7,4,7266,'Duel'),
(7,4,7267,'Grovel'),
(7,4,7340,'Language Gnomish'),
(7,4,7355,'Stuck'),
(7,4,8386,'Attacking'),
(7,4,9077,'Leather'),
(7,4,9078,'Cloth'),
(7,4,9125,'Generic'),
(7,4,16092,'Defensive State (DND)'),
(7,4,20589,'Escape Artist'),
(7,4,20591,'Expansive Mind'),
(7,4,20592,'Arcane Resistance'),
(7,4,20593,'Engineering Specialization'),
(7,4,21184,'Rogue Passive (DND)'),
(7,4,21651,'Opening'),
(7,4,21652,'Closing'),
(7,4,22027,'Remove Insignia'),
(7,4,22810,'Opening - No Text'),
(7,8,81,'Dodge'),
(7,8,133,'Fireball'),
(7,8,168,'Frost Armor'),
(7,8,203,'Unarmed'),
(7,8,204,'Defense'),
(7,8,227,'Staves'),
(7,8,522,'SPELLDEFENSE (DND)'),
(7,8,668,'Language Common'),
(7,8,2382,'Generic'),
(7,8,2479,'Honorless Target'),
(7,8,3050,'Detect'),
(7,8,3365,'Opening'),
(7,8,5009,'Wands'),
(7,8,5019,'Shoot'),
(7,8,6233,'Closing'),
(7,8,6246,'Closing'),
(7,8,6247,'Opening'),
(7,8,6477,'Opening'),
(7,8,6478,'Opening'),
(7,8,6603,'Attack'),
(7,8,7266,'Duel'),
(7,8,7267,'Grovel'),
(7,8,7340,'Language Gnomish'),
(7,8,7355,'Stuck'),
(7,8,8386,'Attacking'),
(7,8,9078,'Cloth'),
(7,8,9125,'Generic'),
(7,8,20589,'Escape Artist'),
(7,8,20591,'Expansive Mind'),
(7,8,20592,'Arcane Resistance'),
(7,8,20593,'Engineering Specialization'),
(7,8,21651,'Opening'),
(7,8,21652,'Closing'),
(7,8,22027,'Remove Insignia'),
(7,8,22810,'Opening - No Text'),
(7,9,81,'Dodge'),
(7,9,203,'Unarmed'),
(7,9,204,'Defense'),
(7,9,522,'SPELLDEFENSE (DND)'),
(7,9,668,'Language Common'),
(7,9,686,'Shadow Bolt'),
(7,9,687,'Demon Skin'),
(7,9,1180,'Daggers'),
(7,9,2382,'Generic'),
(7,9,2479,'Honorless Target'),
(7,9,3050,'Detect'),
(7,9,3365,'Opening'),
(7,9,5009,'Wands'),
(7,9,5019,'Shoot'),
(7,9,6233,'Closing'),
(7,9,6246,'Closing'),
(7,9,6247,'Opening'),
(7,9,6477,'Opening'),
(7,9,6478,'Opening'),
(7,9,6603,'Attack'),
(7,9,7266,'Duel'),
(7,9,7267,'Grovel'),
(7,9,7340,'Language Gnomish'),
(7,9,7355,'Stuck'),
(7,9,8386,'Attacking'),
(7,9,9078,'Cloth'),
(7,9,9125,'Generic'),
(7,9,20589,'Escape Artist'),
(7,9,20591,'Expansive Mind'),
(7,9,20592,'Arcane Resistance'),
(7,9,20593,'Engineering Specialization'),
(7,9,21651,'Opening'),
(7,9,21652,'Closing'),
(7,9,22027,'Remove Insignia'),
(7,9,22810,'Opening - No Text'),
(8,1,78,'Heroic Strike'),
(8,1,81,'Dodge'),
(8,1,107,'Block'),
(8,1,196,'One-Handed Axes'),
(8,1,203,'Unarmed'),
(8,1,204,'Defense'),
(8,1,522,'SPELLDEFENSE (DND)'),
(8,1,669,'Language Orcish'),
(8,1,1180,'Daggers'),
(8,1,2382,'Generic'),
(8,1,2457,'Battle Stance'),
(8,1,2479,'Honorless Target'),
(8,1,2567,'Thrown'),
(8,1,2764,'Throw'),
(8,1,3050,'Detect'),
(8,1,3365,'Opening'),
(8,1,5301,'Defensive State (DND)'),
(8,1,6233,'Closing'),
(8,1,6246,'Closing'),
(8,1,6247,'Opening'),
(8,1,6477,'Opening'),
(8,1,6478,'Opening'),
(8,1,6603,'Attack'),
(8,1,7266,'Duel'),
(8,1,7267,'Grovel'),
(8,1,7341,'Language Troll'),
(8,1,7355,'Stuck'),
(8,1,8386,'Attacking'),
(8,1,8737,'Mail'),
(8,1,9077,'Leather'),
(8,1,9078,'Cloth'),
(8,1,9116,'Shield'),
(8,1,9125,'Generic'),
(8,1,20555,'Regeneration'),
(8,1,20557,'Beast Slaying'),
(8,1,20558,'Throwing Specialization'),
(8,1,21651,'Opening'),
(8,1,21652,'Closing'),
(8,1,22027,'Remove Insignia'),
(8,1,22810,'Opening - No Text'),
(8,1,26290,'Bow Specialization'),
(8,1,26296,'Berserking'),
(8,3,75,'Auto Shot'),
(8,3,81,'Dodge'),
(8,3,196,'One-Handed Axes'),
(8,3,203,'Unarmed'),
(8,3,204,'Defense'),
(8,3,264,'Bows'),
(8,3,522,'SPELLDEFENSE (DND)'),
(8,3,669,'Language Orcish'),
(8,3,2382,'Generic'),
(8,3,2479,'Honorless Target'),
(8,3,2973,'Raptor Strike'),
(8,3,3050,'Detect'),
(8,3,3365,'Opening'),
(8,3,6233,'Closing'),
(8,3,6246,'Closing'),
(8,3,6247,'Opening'),
(8,3,6477,'Opening'),
(8,3,6478,'Opening'),
(8,3,6603,'Attack'),
(8,3,7266,'Duel'),
(8,3,7267,'Grovel'),
(8,3,7341,'Language Troll'),
(8,3,7355,'Stuck'),
(8,3,8386,'Attacking'),
(8,3,9077,'Leather'),
(8,3,9078,'Cloth'),
(8,3,9125,'Generic'),
(8,3,13358,'Defensive State (DND)'),
(8,3,20554,'Berserking'),
(8,3,20555,'Regeneration'),
(8,3,20557,'Beast Slaying'),
(8,3,20558,'Throwing Specialization'),
(8,3,21651,'Opening'),
(8,3,21652,'Closing'),
(8,3,22027,'Remove Insignia'),
(8,3,22810,'Opening - No Text'),
(8,3,24949,'Defensive State 2 (DND)'),
(8,3,26290,'Bow Specialization'),
(8,4,81,'Dodge'),
(8,4,203,'Unarmed'),
(8,4,204,'Defense'),
(8,4,522,'SPELLDEFENSE (DND)'),
(8,4,669,'Language Orcish'),
(8,4,1180,'Daggers'),
(8,4,1752,'Sinister Strike'),
(8,4,2098,'Eviscerate'),
(8,4,2382,'Generic'),
(8,4,2479,'Honorless Target'),
(8,4,2567,'Thrown'),
(8,4,2764,'Throw'),
(8,4,3050,'Detect'),
(8,4,3365,'Opening'),
(8,4,6233,'Closing'),
(8,4,6246,'Closing'),
(8,4,6247,'Opening'),
(8,4,6477,'Opening'),
(8,4,6478,'Opening'),
(8,4,6603,'Attack'),
(8,4,7266,'Duel'),
(8,4,7267,'Grovel'),
(8,4,7341,'Language Troll'),
(8,4,7355,'Stuck'),
(8,4,8386,'Attacking'),
(8,4,9077,'Leather'),
(8,4,9078,'Cloth'),
(8,4,9125,'Generic'),
(8,4,16092,'Defensive State (DND)'),
(8,4,20555,'Regeneration'),
(8,4,20557,'Beast Slaying'),
(8,4,20558,'Throwing Specialization'),
(8,4,21184,'Rogue Passive (DND)'),
(8,4,21651,'Opening'),
(8,4,21652,'Closing'),
(8,4,22027,'Remove Insignia'),
(8,4,22810,'Opening - No Text'),
(8,4,26290,'Bow Specialization'),
(8,4,26297,'Berserking'),
(8,5,81,'Dodge'),
(8,5,198,'One-Handed Maces'),
(8,5,203,'Unarmed'),
(8,5,204,'Defense'),
(8,5,522,'SPELLDEFENSE (DND)'),
(8,5,585,'Smite'),
(8,5,669,'Language Orcish'),
(8,5,2050,'Lesser Heal'),
(8,5,2382,'Generic'),
(8,5,2479,'Honorless Target'),
(8,5,3050,'Detect'),
(8,5,3365,'Opening'),
(8,5,5009,'Wands'),
(8,5,5019,'Shoot'),
(8,5,6233,'Closing'),
(8,5,6246,'Closing'),
(8,5,6247,'Opening'),
(8,5,6477,'Opening'),
(8,5,6478,'Opening'),
(8,5,6603,'Attack'),
(8,5,7266,'Duel'),
(8,5,7267,'Grovel'),
(8,5,7341,'Language Troll'),
(8,5,7355,'Stuck'),
(8,5,8386,'Attacking'),
(8,5,9078,'Cloth'),
(8,5,9125,'Generic'),
(8,5,20554,'Berserking'),
(8,5,20555,'Regeneration'),
(8,5,20557,'Beast Slaying'),
(8,5,20558,'Throwing Specialization'),
(8,5,21651,'Opening'),
(8,5,21652,'Closing'),
(8,5,22027,'Remove Insignia'),
(8,5,22810,'Opening - No Text'),
(8,5,26290,'Bow Specialization'),
(8,7,81,'Dodge'),
(8,7,107,'Block'),
(8,7,198,'One-Handed Maces'),
(8,7,203,'Unarmed'),
(8,7,204,'Defense'),
(8,7,227,'Staves'),
(8,7,331,'Healing Wave'),
(8,7,403,'Lightning Bolt'),
(8,7,522,'SPELLDEFENSE (DND)'),
(8,7,669,'Language Orcish'),
(8,7,2382,'Generic'),
(8,7,2479,'Honorless Target'),
(8,7,3050,'Detect'),
(8,7,3365,'Opening'),
(8,7,6233,'Closing'),
(8,7,6246,'Closing'),
(8,7,6247,'Opening'),
(8,7,6477,'Opening'),
(8,7,6478,'Opening'),
(8,7,6603,'Attack'),
(8,7,7266,'Duel'),
(8,7,7267,'Grovel'),
(8,7,7341,'Language Troll'),
(8,7,7355,'Stuck'),
(8,7,8386,'Attacking'),
(8,7,9077,'Leather'),
(8,7,9078,'Cloth'),
(8,7,9116,'Shield'),
(8,7,9125,'Generic'),
(8,7,20554,'Berserking'),
(8,7,20555,'Regeneration'),
(8,7,20557,'Beast Slaying'),
(8,7,20558,'Throwing Specialization'),
(8,7,21651,'Opening'),
(8,7,21652,'Closing'),
(8,7,22027,'Remove Insignia'),
(8,7,22810,'Opening - No Text'),
(8,7,26290,'Bow Specialization'),
(8,7,27763,'Totem'),
(8,8,81,'Dodge'),
(8,8,133,'Fireball'),
(8,8,168,'Frost Armor'),
(8,8,203,'Unarmed'),
(8,8,204,'Defense'),
(8,8,227,'Staves'),
(8,8,522,'SPELLDEFENSE (DND)'),
(8,8,669,'Language Orcish'),
(8,8,2382,'Generic'),
(8,8,2479,'Honorless Target'),
(8,8,3050,'Detect'),
(8,8,3365,'Opening'),
(8,8,5009,'Wands'),
(8,8,5019,'Shoot'),
(8,8,6233,'Closing'),
(8,8,6246,'Closing'),
(8,8,6247,'Opening'),
(8,8,6477,'Opening'),
(8,8,6478,'Opening'),
(8,8,6603,'Attack'),
(8,8,7266,'Duel'),
(8,8,7267,'Grovel'),
(8,8,7341,'Language Troll'),
(8,8,7355,'Stuck'),
(8,8,8386,'Attacking'),
(8,8,9078,'Cloth'),
(8,8,9125,'Generic'),
(8,8,20554,'Berserking'),
(8,8,20555,'Regeneration'),
(8,8,20557,'Beast Slaying'),
(8,8,20558,'Throwing Specialization'),
(8,8,21651,'Opening'),
(8,8,21652,'Closing'),
(8,8,22027,'Remove Insignia'),
(8,8,22810,'Opening - No Text'),
(8,8,26290,'Bow Specialization');
/*!40000 ALTER TABLE `playercreateinfo_spell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `points_of_interest`
--

DROP TABLE IF EXISTS `points_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `points_of_interest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `icon` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `flags` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `icon_name` text NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_creature`
--

DROP TABLE IF EXISTS `pool_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_creature` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_creature_template`
--

DROP TABLE IF EXISTS `pool_creature_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_creature_template` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_gameobject`
--

DROP TABLE IF EXISTS `pool_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_gameobject` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_gameobject_template`
--

DROP TABLE IF EXISTS `pool_gameobject_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_gameobject_template` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pool_idx` (`pool_entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_pool`
--

DROP TABLE IF EXISTS `pool_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_pool` (
  `pool_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `mother_pool` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`pool_id`),
  KEY `pool_idx` (`mother_pool`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pool_template`
--

DROP TABLE IF EXISTS `pool_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Pool entry',
  `max_limit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Max number of objects (0) is no limit',
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quest_template`
--

DROP TABLE IF EXISTS `quest_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Method` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `ZoneOrSort` smallint(6) NOT NULL DEFAULT '0',
  `MinLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `QuestLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Type` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredClasses` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredRaces` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredSkillValue` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RepObjectiveFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RepObjectiveValue` mediumint(9) NOT NULL DEFAULT '0',
  `RequiredMinRepFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredMinRepValue` mediumint(9) NOT NULL DEFAULT '0',
  `RequiredMaxRepFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredMaxRepValue` mediumint(9) NOT NULL DEFAULT '0',
  `SuggestedPlayers` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LimitTime` int(10) unsigned NOT NULL DEFAULT '0',
  `QuestFlags` smallint(5) unsigned NOT NULL DEFAULT '0',
  `SpecialFlags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PrevQuestId` mediumint(9) NOT NULL DEFAULT '0',
  `NextQuestId` mediumint(9) NOT NULL DEFAULT '0',
  `ExclusiveGroup` mediumint(9) NOT NULL DEFAULT '0',
  `NextQuestInChain` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `SrcItemId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `SrcItemCount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SrcSpell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` text,
  `Details` text,
  `Objectives` text,
  `OfferRewardText` text,
  `RequestItemsText` text,
  `EndText` text,
  `ObjectiveText1` text,
  `ObjectiveText2` text,
  `ObjectiveText3` text,
  `ObjectiveText4` text,
  `ReqItemId1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemId2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemId3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemId4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSourceId1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSourceId2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSourceId3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSourceId4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSourceCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSourceCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSourceCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSourceCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId1` mediumint(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId2` mediumint(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId3` mediumint(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId4` mediumint(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSpellCast1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSpellCast2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSpellCast3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSpellCast4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId5` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId6` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount6` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewItemId1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewItemId2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewItemId3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewItemId4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewItemCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewItemCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewItemCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewItemCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewRepFaction1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction5` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepValue1` mediumint(9) NOT NULL DEFAULT '0',
  `RewRepValue2` mediumint(9) NOT NULL DEFAULT '0',
  `RewRepValue3` mediumint(9) NOT NULL DEFAULT '0',
  `RewRepValue4` mediumint(9) NOT NULL DEFAULT '0',
  `RewRepValue5` mediumint(9) NOT NULL DEFAULT '0',
  `RewOrReqMoney` int(11) NOT NULL DEFAULT '0',
  `RewMoneyMaxLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `RewSpell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewSpellCast` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewMailTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewMailDelaySecs` int(11) unsigned NOT NULL DEFAULT '0',
  `PointMapId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PointX` float NOT NULL DEFAULT '0',
  `PointY` float NOT NULL DEFAULT '0',
  `PointOpt` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `DetailsEmote1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DetailsEmote2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DetailsEmote3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DetailsEmote4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DetailsEmoteDelay1` int(11) unsigned NOT NULL DEFAULT '0',
  `DetailsEmoteDelay2` int(11) unsigned NOT NULL DEFAULT '0',
  `DetailsEmoteDelay3` int(11) unsigned NOT NULL DEFAULT '0',
  `DetailsEmoteDelay4` int(11) unsigned NOT NULL DEFAULT '0',
  `IncompleteEmote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CompleteEmote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmote1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmote2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmote3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmote4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay1` int(11) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay2` int(11) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay3` int(11) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay4` int(11) unsigned NOT NULL DEFAULT '0',
  `StartScript` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `CompleteScript` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quest System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reference_loot_template`
--

DROP TABLE IF EXISTS `reference_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reputation_reward_rate`
--

DROP TABLE IF EXISTS `reputation_reward_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reputation_reward_rate` (
  `faction` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest_rate` float NOT NULL DEFAULT '1',
  `creature_rate` float NOT NULL DEFAULT '1',
  `spell_rate` float NOT NULL DEFAULT '1',
  PRIMARY KEY (`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reputation_spillover_template`
--

DROP TABLE IF EXISTS `reputation_spillover_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reputation_spillover_template` (
  `faction` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'faction entry',
  `faction1` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'faction to give spillover for',
  `rate_1` float NOT NULL DEFAULT '0' COMMENT 'the given rep points * rate',
  `rank_1` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'max rank, above this will not give any spillover',
  `faction2` smallint(6) unsigned NOT NULL DEFAULT '0',
  `rate_2` float NOT NULL DEFAULT '0',
  `rank_2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `faction3` smallint(6) unsigned NOT NULL DEFAULT '0',
  `rate_3` float NOT NULL DEFAULT '0',
  `rank_3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `faction4` smallint(6) unsigned NOT NULL DEFAULT '0',
  `rate_4` float NOT NULL DEFAULT '0',
  `rank_4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Reputation spillover reputation gain';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reserved_name`
--

DROP TABLE IF EXISTS `reserved_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserved_name` (
  `name` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player Reserved Names';
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Table structure for table `script_texts`
--

DROP TABLE IF EXISTS `script_texts`;
CREATE TABLE `script_texts` (
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Script Texts';

--
-- Table structure for table `script_waypoint`
--

DROP TABLE IF EXISTS `script_waypoint`;
CREATE TABLE `script_waypoint` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'creature_template entry',
  `pointid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `location_x` float NOT NULL DEFAULT '0',
  `location_y` float NOT NULL DEFAULT '0',
  `location_z` float NOT NULL DEFAULT '0',
  `waittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'waittime in millisecs',
  `point_comment` text,
  PRIMARY KEY (`entry`,`pointid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Script Creature waypoints';

--
-- Table structure for table `scripted_areatrigger`
--

DROP TABLE IF EXISTS `scripted_areatrigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripted_areatrigger` (
  `entry` mediumint(8) NOT NULL,
  `ScriptName` char(64) NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scripted_event`
--

DROP TABLE IF EXISTS `scripted_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripted_event` (
  `id` mediumint(8) NOT NULL,
  `ScriptName` char(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Script library scripted events';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sd2_db_version`
--

DROP TABLE IF EXISTS `sd2_db_version`;

CREATE TABLE `sd2_db_version` (
  `version` varchar(255) NOT NULL DEFAULT '' COMMENT 'Database version string'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `skill_fishing_base_level`
--

DROP TABLE IF EXISTS `skill_fishing_base_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_fishing_base_level` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Area identifier',
  `skill` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Base skill level requirement',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Fishing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skinning_loot_template`
--

DROP TABLE IF EXISTS `skinning_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skinning_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_affect`
--

DROP TABLE IF EXISTS `spell_affect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_affect` (
  `entry` smallint(5) unsigned NOT NULL DEFAULT '0',
  `effectId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`effectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_affect`
--

LOCK TABLES `spell_affect` WRITE;
/*!40000 ALTER TABLE `spell_affect` DISABLE KEYS */;
INSERT INTO `spell_affect` VALUES
(11083,0,0x0000000000C20017),
(11115,0,0x0000000008C20017),
(11124,0,0x0000000008C20017),
(11170,0,0x0000000040FE1AF7),
(11242,0,0x0000000000001000),
(11247,0,0x0000000000002000),
(11367,0,0x0000000008C20017),
(11368,0,0x0000000008C20017),
(11369,0,0x0000000008C20017),
(11370,0,0x0000000008C20017),
(12042,0,0x0000000020E01AF7),
(12042,1,0x0000000020E01AF7),
(12042,2,0x0000000020E01AF7),
(12285,0,0x0000000000000001),
(12288,0,0x0000000000000008),
(12288,1,0x0000000000000008),
(12301,0,0x0000000000000100),
(12351,0,0x0000000000C20017),
(12378,0,0x0000000008C20017),
(12398,0,0x0000000008C20017),
(12399,0,0x0000000008C20017),
(12400,0,0x0000000008C20017),
(12467,0,0x0000000000001000),
(12469,0,0x0000000000001000),
(12536,0,0x0000000020C01AF7),
(12593,1,0x0000000020E01AF7),
(12697,0,0x0000000000000001),
(12707,0,0x0000000000000008),
(12707,1,0x0000000000000008),
(12818,0,0x0000000000000100),
(12842,0,0x0000000000240000),
(12982,0,0x0000000040FE1AF7),
(12983,0,0x0000000040FE1AF7),
(12984,0,0x0000000040FE1AF7),
(12985,0,0x0000000040FE1AF7),
(13742,0,0x0000000000000060),
(13743,0,0x0000000000000040),
(13872,0,0x0000000000000060),
(13875,0,0x0000000000000040),
(13975,1,0x0000000000400000),
(13976,0,0x0000000000000700),
(13979,0,0x0000000000000700),
(13980,0,0x0000000000000700),
(13981,0,0x0000000001000800),
(14062,1,0x0000000000400000),
(14063,1,0x0000000000400000),
(14064,1,0x0000000000400000),
(14065,1,0x0000000000400000),
(14066,0,0x0000000001000800),
(14067,0,0x0000000001000800),
(14082,0,0x0000000000000500),
(14083,0,0x0000000000000500),
(14113,0,0x000000001001E000),
(14114,0,0x000000001001E000),
(14115,0,0x000000001001E000),
(14116,0,0x000000001001E000),
(14117,0,0x000000001001E000),
(14143,0,0x0000000004000206),
(14149,0,0x0000000004000206),
(14168,0,0x0000000000080000),
(14169,0,0x0000000000080000),
(14174,0,0x0000000000200000),
(14175,0,0x0000000000200000),
(14176,0,0x0000000000200000),
(14909,1,0x0000000000100080),
(15017,1,0x0000000000100080),
(15058,0,0x00000000002212E0),
(15059,0,0x00000000002212E0),
(15060,0,0x00000000002212E0),
(16035,0,0x0000000090100003),
(16038,0,0x0000000040000000),
(16039,0,0x0000000090100003),
(16041,0,0x0000000000000003),
(16043,0,0x0000000000000008),
(16043,1,0x0000000020000000),
(16086,0,0x0000000000000020),
(16086,1,0x0000000008000000),
(16086,2,0x0000000000000004),
(16089,0,0x00000004D3300407),
(16105,0,0x0000000090100003),
(16106,0,0x0000000090100003),
(16106,1,0x0000000010000000),
(16107,0,0x0000000090100003),
(16108,0,0x0000000090100003),
(16109,0,0x0000000090100003),
(16110,0,0x0000000090100003),
(16111,0,0x0000000090100003),
(16112,0,0x0000000090100003),
(16117,0,0x0000000000000003),
(16118,0,0x0000000000000003),
(16119,0,0x0000000000000003),
(16120,0,0x0000000000000003),
(16130,0,0x0000000000000008),
(16130,1,0x0000000020000000),
(16160,0,0x0000000040000000),
(16161,0,0x0000000040000000),
(16166,0,0x0000000090100003),
(16166,1,0x0000000090100003),
(16173,0,0x0000000020080000),
(16181,0,0x00000000000001C0),
(16183,0,0x0000000000000100),
(16184,0,0x0000000000000200),
(16184,1,0x0000000000000200),
(16187,0,0x0000000000006000),
(16189,0,0x000000000403E000),
(16205,0,0x0000000000006000),
(16206,0,0x0000000000006000),
(16207,0,0x0000000000006000),
(16208,0,0x0000000000006000),
(16209,1,0x0000000000000200),
(16222,0,0x0000000020080000),
(16223,0,0x0000000020080000),
(16224,0,0x0000000020080000),
(16225,0,0x0000000020080000),
(16230,0,0x00000000000001C0),
(16232,0,0x00000000000001C0),
(16233,0,0x00000000000001C0),
(16234,0,0x00000000000001C0),
(16258,0,0x0000000000008000),
(16258,1,0x0000000000040000),
(16259,0,0x0000000000010000),
(16259,1,0x0000000000020000),
(16266,0,0x0000000000400000),
(16266,1,0x0000000001000000),
(16266,2,0x0000000000800000),
(16293,0,0x0000000000008000),
(16293,1,0x0000000000040000),
(16295,0,0x0000000000010000),
(16295,1,0x0000000000020000),
(16513,0,0x000000080001E000),
(16513,1,0x000000000001E000),
(16513,2,0x000000000001E000),
(16514,0,0x000000080001E000),
(16514,1,0x000000000001E000),
(16514,2,0x000000000001E000),
(16515,0,0x000000080001E000),
(16515,1,0x000000000001E000),
(16515,2,0x000000000001E000),
(16544,2,0x0000000000000004),
(16719,0,0x000000080001E000),
(16719,1,0x000000000001E000),
(16719,2,0x000000000001E000),
(16720,0,0x000000080001E000),
(16720,1,0x000000000001E000),
(16720,2,0x000000000001E000),
(16870,0,0x001007F100E3FEFF),
(17123,0,0x0000000000000080),
(17124,0,0x0000000000000080),
(17904,0,0x0000000000000000),
(17912,0,0x0000000000000000),
(17913,0,0x0000000000000000),
(17914,0,0x0000000000000000),
(17915,0,0x0000000000000000),
(17916,0,0x0000000000000000),
(17954,1,0x000000C000001364),
(17955,1,0x000000C000001364),
(17956,1,0x000000C000001364),
(17957,1,0x000000C000001364),
(17958,1,0x000000C000001364),
(18174,0,0x00000001804D841A),
(18175,0,0x00000001804D841A),
(18176,0,0x00000001804D841A),
(18177,0,0x00000001804D841A),
(18178,0,0x00000001804D841A),
(18218,0,0x00000001804D841A),
(18219,0,0x00000001804D841A),
(18271,0,0x0000000300016489),
(18271,1,0x000000010008040A),
(18271,2,0x0000000000000000),
(18272,0,0x0000000300016489),
(18272,1,0x000000010008040A),
(18272,2,0x0000000000000000),
(18273,0,0x0000000300016489),
(18273,1,0x000000010008040A),
(18273,2,0x0000000000000000),
(18274,0,0x0000000300016489),
(18274,1,0x000000010008040A),
(18274,2,0x0000000000000000),
(18275,0,0x0000000300016489),
(18275,1,0x000000010008040A),
(18275,2,0x0000000000000000),
(20101,0,0x000000000A800200),
(20102,0,0x000000000A800200),
(20103,0,0x000000000A800200),
(20104,0,0x000000000A800200),
(20105,0,0x000000000A800200),
(20575,1,0x0000000004000000),
(21942,1,0x0000000008000000),
(23300,0,0x0000000020000000),
(26118,0,0x0000000004000000),
(26118,1,0x0000000004000000),
(28539,0,0x0000000000001000),
(28682,0,0x0000000000400017),
(28743,0,0x00000000000000F0),
(28746,1,0x0000000000010406),
(28751,0,0x0000000000021000),
(28755,0,0x0000000000000020),
(28763,0,0x0000000004000000),
(28774,0,0x0000000000008000),
(28787,0,0x0000000200000000),
(28807,0,0x0000000000000040),
(28808,0,0x0000000411041E40),
(28811,0,0x0000000000800000),
(28814,0,0x0000000000020000),
(28815,0,0x0000000002000006),
(28818,0,0x0000000020080000),
(28821,0,0x0000000000000400),
(28829,0,0x0000000000000002),
(28830,0,0x0000000000040000),
(28831,0,0x0000000000000001),
(28842,0,0x0000000100004440),
(28843,0,0x0000000000088000),
(28844,0,0x0000000000000400),
(28852,0,0x0000000000000200),
(28852,1,0x0000000020000000),
(28855,0,0x0000000000000800),
(28999,0,0x0000000000000003),
(29000,0,0x0000000000000003),
(29005,0,0x0000000090100003),
(29063,0,0x00000000000009C3),
(29079,0,0x0000000000400000),
(29079,1,0x0000000001000000),
(29079,2,0x0000000000800000),
(29080,0,0x0000000000400000),
(29080,1,0x0000000001000000),
(29080,2,0x0000000000800000),
(29171,0,0x0000000000004000),
(29187,0,0x00000000000001C0),
(29189,0,0x00000000000001C0),
(29191,0,0x00000000000001C0),
(29192,0,0x0000000000800000),
(29192,1,0x0000000000200000),
(29193,0,0x0000000000800000),
(29193,1,0x0000000000200000),
(29202,0,0x0000000000000040),
(29205,0,0x0000000000000040),
(29206,0,0x0000000000000040),
(29438,0,0x00000000004002F7),
(29439,0,0x00000000004002F7),
(29440,0,0x00000000004002F7),
(30440,0,0x0000000000088000),
(30441,0,0x0000000800000000),
(30640,0,0x0000000000000100),
(30812,0,0x00000000B0181418),
(30813,0,0x00000000B0181418),
(30814,0,0x00000000B0181418),
(30872,0,0x0000000000000100),
(30892,0,0x0000000008000000),
(30893,0,0x0000000008000000);
/*!40000 ALTER TABLE `spell_affect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_area`
--

DROP TABLE IF EXISTS `spell_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_area` (
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `area` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest_start` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest_start_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `quest_end` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `aura_spell` mediumint(8) NOT NULL DEFAULT '0',
  `racemask` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `autocast` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`spell`,`area`,`quest_start`,`quest_start_active`,`aura_spell`,`racemask`,`gender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_bonus_data`
--

DROP TABLE IF EXISTS `spell_bonus_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_bonus_data` (
  `entry` smallint(5) unsigned NOT NULL,
  `direct_bonus` float NOT NULL DEFAULT '0',
  `one_hand_direct_bonus` float NOT NULL DEFAULT '0',
  `two_hand_direct_bonus` float NOT NULL DEFAULT '0',
  `direct_bonus_done` float NOT NULL DEFAULT '0',
  `one_hand_direct_bonus_done` float NOT NULL DEFAULT '0',
  `two_hand_direct_bonus_done` float NOT NULL DEFAULT '0',
  `direct_bonus_taken` float NOT NULL DEFAULT '0',
  `one_hand_direct_bonus_taken` float NOT NULL DEFAULT '0',
  `two_hand_direct_bonus_taken` float NOT NULL DEFAULT '0',
  `dot_bonus` float NOT NULL DEFAULT '0',
  `ap_bonus` float NOT NULL DEFAULT '0',
  `ap_dot_bonus` float NOT NULL DEFAULT '0',
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_bonus_data`
--

LOCK TABLES `spell_bonus_data` WRITE;
/*!40000 ALTER TABLE `spell_bonus_data` DISABLE KEYS */;
INSERT INTO `spell_bonus_data` VALUES
/* Druid */
(339, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 'Druid - Entangling Roots'),
(5185, 1.6104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Druid - Healing Touch'),
(5570, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.127, 0, 0, 'Druid - Insect Swarm'),
(8921, 0.1515, 0, 0, 0, 0, 0, 0, 0, 0, 0.13, 0, 0, 'Druid - Moonfire'),
(8936, 0.3, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 'Druid - Regrowth'),
(18562, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Druid - Swiftmend'),
(5176, 0.5714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Druid - Wrath'),
/* Item */
(18764, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item - Fungal Regrowth'),
(17712, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item - Lifestone Healing'),
(5707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item - Lifestone Regeneration'),
(21179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item - Six Demon Bag - Chain Lightning'),
(15662, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item - Six Demon Bag - Fireball'),
(11538, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item - Six Demon Bag - Frostbolt'),
/* Mage */
(7268, 0.2857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Arcane Missiles Triggered Spell Rank 1'),
(7269, 0.2857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Arcane Missiles Triggered Spell Rank 2'),
(7270, 0.2857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Arcane Missiles Triggered Spell Rank 3'),
(8419, 0.2857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Arcane Missiles Triggered Spell Rank 4'),
(8418, 0.2857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Arcane Missiles Triggered Spell Rank 5'),
(10273, 0.2857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Arcane Missiles Triggered Spell Rank 6'),
(10274, 0.2857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Arcane Missiles Triggered Spell Rank 7'),
(25346, 0.2857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Arcane Missiles Triggered Spell Rank 8'),
(11113, 0.1357, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Blast Wave Rank'),
(120, 0.1357, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Cone of Cold'),
(133, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Fire Ball'),
(2120, 0.2357, 0, 0, 0, 0, 0, 0, 0, 0, 0.122, 0, 0, 'Mage - Flamestrike'),
(116, 0.8143, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Frost Bolt'),
(1463, 0.8053, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mage - Mana Shield'),
/* Paladin */
(26573, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.04, 0, 0.04, 'Paladin - Consecration'),
(879, 0.15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.15, 0, 'Paladin - Exorcism'),
(24275, 0.15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.15, 0, 'Paladin - Hammer of Wrath'),
(20925, 0.09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.056, 0, 'Paladin - Holy Shield'),
(2812, 0.07, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.07, 0, 'Paladin - Holy Wrath'),
(20424, 0, 0, 0, 0.2, 0, 0, 0.29, 0, 0, 0, 0.16, 0, 'Paladin - Seal of Command Proc'),
(20167, 0.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.16, 0, 'Paladin - Seal of Light Proc'),
(20154, 0, 0.125, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Paladin - Seal of Righteousness Dummy Proc'),
/* Priest */
(2061, 0.6177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Flash Heal'),
(2060, 1.2353, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Greater Heal'),
(14914, 0.5711, 0, 0, 0, 0, 0, 0, 0, 0, 0.024, 0, 0, 'Priest - Holy Fire'),
(15237, 0.1606, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Holy Nova Damage'),
(23455, 0.3035, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Holy Nova Heal Rank 1'),
(23458, 0.3035, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Holy Nova Heal Rank 2'),
(23459, 0.3035, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Holy Nova Heal Rank 3'),
(27803, 0.3035, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Holy Nova Heal Rank 4'),
(27804, 0.3035, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Holy Nova Heal Rank 5'),
(27805, 0.3035, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Holy Nova Heal Rank 6'),
(8129, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Mana Burn'),
(15407, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.19, 0, 0, 'Priest - Mind Flay'),
(585, 0.714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Priest - Smite'),
/* Rogue */
(703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.03, 'Rogue - Garrote'),
/* Shaman */
(421, 0.57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Chain Lightning'),
(974, 0.2857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Earth Shield'),
(379, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Earth Shield Triggered'),
(8042, 0.3858, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Earth Shock'),
(8443, 0.2142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Fire Nova Totem Casted by Totem Rank 1'),
(8504, 0.2142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Fire Nova Totem Casted by Totem Rank 2'),
(8505, 0.2142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Fire Nova Totem Casted by Totem Rank 3'),
(11310, 0.2142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Fire Nova Totem Casted by Totem Rank 4'),
(11311, 0.2142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Fire Nova Totem Casted by Totem Rank 5'),
(8050, 0.2142, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 'Shaman - Flame Shock'),
(10444, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Flametongue Attack'),
(8026, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Flametongue Weapon Proc Rank 1'),
(8028, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Flametongue Weapon Proc Rank 2'),
(8029, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Flametongue Weapon Proc Rank 3'),
(10445, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Flametongue Weapon Proc Rank 4'),
(16343, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Flametongue Weapon Proc Rank 5'),
(16344, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Flametongue Weapon Proc Rank 6'),
(8056, 0.3858, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Frost Shock'),
(8034, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Frostbrand Attack Rank 1'),
(5672, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.045, 0, 0, 'Shaman - Healing Stream Totem'),
(331, 0.8571, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Healing Wave'),
(403, 0.7143, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Lightning Bolt'),
(26364, 0.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Lightning Shield Proc Rank 1'),
(26365, 0.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Lightning Shield Proc Rank 2'),
(26366, 0.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Lightning Shield Proc Rank 3'),
(26367, 0.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Lightning Shield Proc Rank 4'),
(26369, 0.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Lightning Shield Proc Rank 5'),
(26370, 0.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Lightning Shield Proc Rank 6'),
(26363, 0.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Lightning Shield Proc Rank 7'),
(8188, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Magma Totam Passive Rank 1'),
(10582, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Magma Totam Passive Rank 2'),
(10583, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Magma Totam Passive Rank 3'),
(10584, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Magma Totam Passive Rank 4'),
(3606, 0.1667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Searing Totem Attack Rank 1'),
(6350, 0.1667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Searing Totem Attack Rank 2'),
(6351, 0.1667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Searing Totem Attack Rank 3'),
(6352, 0.1667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Searing Totem Attack Rank 4'),
(10435, 0.1667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Searing Totem Attack Rank 5'),
(10436, 0.1667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shaman - Searing Totem Attack Rank 6'),
/* Warlock */
(172, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.156, 0, 0, 'Warlock - Corruption'),
(980, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 'Warlock - Curse of Agony'),
(603, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 'Warlock - Curse of Doom'),
(18220, 0.96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Dark Pact'),
(5138, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Drain Mana'),
(1120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.4286, 0, 0, 'Warlock - Drain Soul'),
(18790, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Fel Stamina'),
(755, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.4485, 0, 0, 'Warlock - Health Funnel'),
(1949, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0946, 0, 0, 'Warlock - Hellfire'),
(5857, 0.1428, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Hellfire Effect on Enemy Rank 1'),
(11681, 0.1428, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Hellfire Effect on Enemy Rank 2'),
(11682, 0.1428, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Hellfire Effect on Enemy Rank 3'),
(348, 0.2, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, 0, 0, 'Warlock - Immolate'),
(1454, 0.8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Life Tap'),
(686, 0.8571, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Shadow Bolt'),
(6229, 0.3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Shadow Ward'),
(6353, 1.15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlock - Soul Fire');
/*!40000 ALTER TABLE `spell_bonus_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_chain`
--

DROP TABLE IF EXISTS `spell_chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_chain` (
  `spell_id` mediumint(9) NOT NULL DEFAULT '0',
  `prev_spell` mediumint(9) NOT NULL DEFAULT '0',
  `first_spell` mediumint(9) NOT NULL DEFAULT '0',
  `rank` tinyint(4) NOT NULL DEFAULT '0',
  `req_spell` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Spell Additinal Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_chain`
--

LOCK TABLES `spell_chain` WRITE;
/*!40000 ALTER TABLE `spell_chain` DISABLE KEYS */;
INSERT INTO `spell_chain` VALUES
-- ------------------
-- (0) Not associated with skills
-- ------------------
/* Deadly Poison Triggered */
(2818,0,2818,1,0),
(2819,2818,2818,2,0),
(11353,2819,2818,3,0),
(11354,11353,2818,4,0),
(25349,11354,2818,5,0),
/* Enrage Triggered, Warrior */
(12880,0,12880,1,0),
(14201,12880,12880,2,0),
(14202,14201,12880,3,0),
(14203,14202,12880,4,0),
(14204,14203,12880,5,0),
/* Frostbrand Attack */
(8034,0,8034,1,0),
(8037,8034,8034,2,0),
(10458,8037,8034,3,0),
(16352,10458,8034,4,0),
(16353,16352,8034,5,0),
/* Healing Stream Totem Spell */
(5672,0,5672, 1,0),
(6371,5672,5672,2,0),
(6372,6371,5672,3,0),
(10460,6372,5672,4,0),
(10461,10460,5672,5,0),
/* Instant Poison */
(8680,0,8680,1,0),
(8685,8680,8680,2,0),
(8689,8685,8680,3,0),
(11335,8689,8680,4,0),
(11336,11335,8680,5,0),
(11337,11336,8680,6,0),
/* Wound Poison */
(13218,0,13218,1,0),
(13222,13218,13218,2,0),
(13223,13222,13218,3,0),
(13224,13223,13218,4,0),
-- ------------------
-- (6) Frost
-- ------------------
/* Cone of Cold */
(120,0,120,1,0),
(8492,120,120,2,0),
(10159,8492,120,3,0),
(10160,10159,120,4,0),
(10161,10160,120,5,0),
/* Blizzard */
(10,0,10,1,0),
(6141,10,10,2,0),
(8427,6141,10,3,0),
(10185,8427,10,4,0),
(10186,10185,10,5,0),
(10187,10186,10,6,0),
/* Frost Armor */
(168,0,168,1,0),
(7300,168,168,2,0),
(7301,7300,168,3,0),
/* Frostbolt */
(116,0,116,1,0),
(205,116,116,2,0),
(837,205,116,3,0),
(7322,837,116,4,0),
(8406,7322,116,5,0),
(8407,8406,116,6,0),
(8408,8407,116,7,0),
(10179,8408,116,8,0),
(10180,10179,116,9,0),
(10181,10180,116,10,0),
(25304,10181,116,11,0),
/* Frost Nova */
(122,0,122,1,0),
(865,122,122,2,0),
(6131,865,122,3,0),
(10230,6131,122,4,0),
/* Frost Ward */
(6143,0,6143,1,0),
(8461,6143,6143,2,0),
(8462,8461,6143,3,0),
(10177,8462,6143,4,0),
(28609,10177,6143,5,0),
/* Ice Armor */
(7302,0,7302,1,0),
(7320,7302,7302,2,0),
(10219,7320,7302,3,0),
(10220,10219,7302,4,0),
/* Ice Barrier */
(11426,0,11426,1,0),
(13031,11426,11426,2,0),
(13032,13031,11426,3,0),
(13033,13032,11426,4,0),
-- ------------------
-- (8)Fire
-- ------------------
/* Blast Wave */
(11113,0,11113,1,0),
(13018,11113,11113,2,0),
(13019,13018,11113,3,0),
(13020,13019,11113,4,0),
(13021,13020,11113,5,0),
/* Fire Blast */
(2136,0,2136,1,0),
(2137,2136,2136,2,0),
(2138,2137,2136,3,0),
(8412,2138,2136,4,0),
(8413,8412,2136,5,0),
(10197,8413,2136,6,0),
(10199,10197,2136,7,0),
/* Fireball */
(133,0,133,1,0),
(143,133,133,2,0),
(145,143,133,3,0),
(3140,145,133,4,0),
(8400,3140,133,5,0),
(8401,8400,133,6,0),
(8402,8401,133,7,0),
(10148,8402,133,8,0),
(10149,10148,133,9,0),
(10150,10149,133,10,0),
(10151,10150,133,11,0),
(25306,10151,133,12,0),
/* Fire Ward */
(543,0,543,1,0),
(8457,543,543,2,0),
(8458,8457,543,3,0),
(10223,8458,543,4,0),
(10225,10223,543,5,0),
/* Flamestrike */
(2120,0,2120,1,0),
(2121,2120,2120,2,0),
(8422,2121,2120,3,0),
(8423,8422,2120,4,0),
(10215,8423,2120,5,0),
(10216,10215,2120,6,0),
/* Pyroblast */
(11366,0,11366,1,0),
(12505,11366,11366,2,0),
(12522,12505,11366,3,0),
(12523,12522,11366,4,0),
(12524,12523,11366,5,0),
(12525,12524,11366,6,0),
(12526,12525,11366,7,0),
(18809,12526,11366,8,0),
/* Scorch */
(2948,0,2948,1,0),
(8444,2948,2948,2,0),
(8445,8444,2948,3,0),
(8446,8445,2948,4,0),
(10205,8446,2948,5,0),
(10206,10205,2948,6,0),
(10207,10206,2948,7,0),
-- ------------------
-- (40) Poisons
-- ------------------
/* Crippling Poison */
(3420,0,3420,1,0),
(3421,3420,3420,2,0),
/* Deadly Poison */
(2835,0,2835,1,0),
(2837,2835,2835,2,0),
(11357,2837,2835,3,0),
(11358,11357,2835,4,0),
(25347,11358,2835,5,0),
/* Instant Poison */
(8681,0,8681,1,0),
(8687,8681,8681,2,0),
(8691,8687,8681,3,0),
(11341,8691,8681,4,0),
(11342,11341,8681,5,0),
(11343,11342,8681,6,0),
/* Mind-numbing Poison */
(5763,0,5763,1,0),
(8694,5763,5763,2,0),
(11400,8694,5763,3,0),
/* Wound Poison */
(13220,0,13220,1,0),
(13228,13220,13220,2,0),
(13229,13228,13220,3,0),
(13230,13229,13220,4,0),
-- ------------------
-- (50) Beast Mastery
-- ------------------
/* Aspect of the Hawk */
(13165,0,13165,1,0),
(14318,13165,13165,2,0),
(14319,14318,13165,3,0),
(14320,14319,13165,4,0),
(14321,14320,13165,5,0),
(14322,14321,13165,6,0),
(25296,14322,13165,7,0),
/* Aspect of the Wild */
(20043,0,20043,1,0),
(20190,20043,20043,2,0),
/* Mend Pet */
(136,0,136,1,0),
(3111,136,136,2,0),
(3661,3111,136,3,0),
(3662,3661,136,4,0),
(13542,3662,136,5,0),
(13543,13542,136,6,0),
(13544,13543,136,7,0),
/* Scare Beast */
(1513,0,1513,1,0),
(14326,1513,1513,2,0),
(14327,14326,1513,3,0),
-- ------------------
-- (51)Survival
-- ------------------
/* Counterattack */
(19306,0,19306,1,0),
(20909,19306,19306,2,0),
(20910,20909,19306,3,0),
/* Disengage */
(781,0,781,1,0),
(14272,781,781,2,0),
(14273,14272,781,3,0),
/* Explosive Trap */
(13813,0,13813,1,0),
(14316,13813,13813,2,0),
(14317,14316,13813,3,0),
/* Explosive Trap Effect */
(13812,0,13812,1,0),
(14314,13812,13812,2,0),
(14315,14314,13812,3,0),
/* Freezing Trap */
(1499,0,1499,1,0),
(14310,1499,1499,2,0),
(14311,14310,1499,3,0),
/* Immolation Trap */
(13795,0,13795,1,0),
(14302,13795,13795,2,0),
(14303,14302,13795,3,0),
(14304,14303,13795,4,0),
(14305,14304,13795,5,0),
/* Immolation Trap Triggered */
(13797,0,13797,1,0),
(14298,13797,13797,2,0),
(14299,14298,13797,3,0),
(14300,14299,13797,4,0),
(14301,14300,13797,5,0),
/* Mongoose Bite */
(1495,0,1495,1,0),
(14269,1495,1495,2,0),
(14270,14269,1495,3,0),
(14271,14270,1495,4,0),
/* Raptor Strike */
(2973,0,2973,1,0),
(14260,2973,2973,2,0),
(14261,14260,2973,3,0),
(14262,14261,2973,4,0),
(14263,14262,2973,5,0),
(14264,14263,2973,6,0),
(14265,14264,2973,7,0),
(14266,14265,2973,8,0),
/* Wing Clip */
(2974,0,2974,1,0),
(14267,2974,2974,2,0),
(14268,14267,2974,3,0),
/* Wyvern Sting */
(19386,0,19386,1,0),
(24132,19386,19386,2,0),
(24133,24132,19386,3,0),
-- ------------------
-- (56) Holy (Priest)
-- ------------------
/* Desperate Prayer */
(13908,0,13908,1,0),
(19236,13908,13908,2,0),
(19238,19236,13908,3,0),
(19240,19238,13908,4,0),
(19241,19240,13908,5,0),
(19242,19241,13908,6,0),
(19243,19242,13908,7,0),
/* Flash Heal */
(2061,0,2061,1,0),
(9472,2061,2061,2,0),
(9473,9472,2061,3,0),
(9474,9473,2061,4,0),
(10915,9474,2061,5,0),
(10916,10915,2061,6,0),
(10917,10916,2061,7,0),
/* Greater Heal */
(2060,0,2060,1,0),
(10963,2060,2060,2,0),
(10964,10963,2060,3,0),
(10965,10964,2060,4,0),
(25314,10965,2060,5,0),
/* Heal */
(2054,0,2054,1,0),
(2055,2054,2054,2,0),
(6063,2055,2054,3,0),
(6064,6063,2054,4,0),
/* Holy Fire */
(14914,0,14914,1,0),
(15262,14914,14914,2,0),
(15263,15262,14914,3,0),
(15264,15263,14914,4,0),
(15265,15264,14914,5,0),
(15266,15265,14914,6,0),
(15267,15266,14914,7,0),
(15261,15267,14914,8,0),
/* Holy Nova */
(15237,0,15237,1,0),
(15430,15237,15237,2,0),
(15431,15430,15237,3,0),
(27799,15431,15237,4,0),
(27800,27799,15237,5,0),
(27801,27800,15237,6,0),
/* Lesser Heal */
(2050,0,2050,1,0),
(2052,2050,2050,2,0),
(2053,2052,2050,3,0),
/* Lightwell */
(724,0,724,1,0),
(27870,724,724,2,0),
(27871,27870,724,3,0),
/* Prayer of Healing */
(596,0,596,1,0),
(996,596,596,2,0),
(10960,996,596,3,0),
(10961,10960,596,4,0),
(25316,10961,596,5,0),
/* Renew */
(139,0,139,1,0),
(6074,139,139,2,0),
(6075,6074,139,3,0),
(6076,6075,139,4,0),
(6077,6076,139,5,0),
(6078,6077,139,6,0),
(10927,6078,139,7,0),
(10928,10927,139,8,0),
(10929,10928,139,9,0),
(25315,10929,139,10,0),
/* Resurrection */
(2006,0,2006,1,0),
(2010,2006,2006,2,0),
(10880,2010,2006,3,0),
(10881,10880,2006,4,0),
(20770,10881,2006,5,0),
/* Smite */
(585,0,585,1,0),
(591,585,585,2,0),
(598,591,585,3,0),
(984,598,585,4,0),
(1004,984,585,5,0),
(6060,1004,585,6,0),
(10933,6060,585,7,0),
(10934,10933,585,8,0),
-- ------------------
-- (78) Shadow Magic
-- ------------------
/* Devouring Plague */
(2944,0,2944,1,0),
(19276,2944,2944,2,0),
(19277,19276,2944,3,0),
(19278,19277,2944,4,0),
(19279,19278,2944,5,0),
(19280,19279,2944,6,0),
/* Fade */
(586,0,586,1,0),
(9578,586,586,2,0),
(9579,9578,586,3,0),
(9592,9579,586,4,0),
(10941,9592,586,5,0),
(10942,10941,586,6,0),
/* Mind Control */
(605,0,605,1,0),
(10911,605,605,2,0),
(10912,10911,605,3,0),
/* Hex of Weakness */
(9035,0,9035,1,0),
(19281,9035,9035,2,0),
(19282,19281,9035,3,0),
(19283,19282,9035,4,0),
(19284,19283,9035,5,0),
(19285,19284,9035,6,0),
/* Mind Blast */
(8092,0,8092,1,0),
(8102,8092,8092,2,0),
(8103,8102,8092,3,0),
(8104,8103,8092,4,0),
(8105,8104,8092,5,0),
(8106,8105,8092,6,0),
(10945,8106,8092,7,0),
(10946,10945,8092,8,0),
(10947,10946,8092,9,0),
/* Mind Flay */
(15407,0,15407,1,0),
(17311,15407,15407,2,0),
(17312,17311,15407,3,0),
(17313,17312,15407,4,0),
(17314,17313,15407,5,0),
(18807,17314,15407,6,0),
/* Mind Soothe */
(453,0,453,1,0),
(8192,453,453,2,0),
(10953,8192,453,3,0),
/* Mind Vision */
(2096,0,2096,1,0),
(10909,2096,2096,2,0),
/* Psychic Scream */
(8122,0,8122,1,0),
(8124,8122,8122,2,0),
(10888,8124,8122,3,0),
(10890,10888,8122,4,0),
/* Shadowguard */
(18137,0,18137,1,0),
(19308,18137,18137,2,0),
(19309,19308,18137,3,0),
(19310,19309,18137,4,0),
(19311,19310,18137,5,0),
(19312,19311,18137,6,0),
/* Shadow Protection */
(976,0,976,1,0),
(10957,976,976,2,0),
(10958,10957,976,3,0),
/* Shadow Word: Pain */
(589,0,589,1,0),
(594,589,589,2,0),
(970,594,589,3,0),
(992,970,589,4,0),
(2767,992,589,5,0),
(10892,2767,589,6,0),
(10893,10892,589,7,0),
(10894,10893,589,8,0),
/* Touch of Weakness */
(2652,0,2652,1,0),
(19261,2652,2652,2,0),
(19262,19261,2652,3,0),
(19264,19262,2652,4,0),
(19265,19264,2652,5,0),
(19266,19265,2652,6,0),
-- ------------------
-- (134) Feral Combat (Druid)
-- ------------------
/* Faerie Fire (Feral) */
(16857,0,16857,1,0),
(17390,16857,16857,2,0),
(17391,17390,16857,3,0),
(17392,17391,16857,4,0),
-- ------------------
-- (163)Marksmanship
-- ------------------
/* Aimed Shot */
(19434,0,19434,1,0),
(20900,19434,19434,2,0),
(20901,20900,19434,3,0),
(20902,20901,19434,4,0),
(20903,20902,19434,5,0),
(20904,20903,19434,6,0),
/* Arcane Shot */
(3044,0,3044,1,0),
(14281,3044,3044,2,0),
(14282,14281,3044,3,0),
(14283,14282,3044,4,0),
(14284,14283,3044,5,0),
(14285,14284,3044,6,0),
(14286,14285,3044,7,0),
(14287,14286,3044,8,0),
/* Distracting Shot */
(20736,0,20736,1,0),
(14274,20736,20736,2,0),
(15629,14274,20736,3,0),
(15630,15629,20736,4,0),
(15631,15630,20736,5,0),
(15632,15631,20736,6,0),
/* Hunter's Mark */
(1130,0,1130,1,0),
(14323,1130,1130,2,0),
(14324,14323,1130,3,0),
(14325,14324,1130,4,0),
/* Multi-Shot */
(2643,0,2643,1,0),
(14288,2643,2643,2,0),
(14289,14288,2643,3,0),
(14290,14289,2643,4,0),
(25294,14290,2643,5,0),
/* Serpent Sting */
(1978,0,1978,1,0),
(13549,1978,1978,2,0),
(13550,13549,1978,3,0),
(13551,13550,1978,4,0),
(13552,13551,1978,5,0),
(13553,13552,1978,6,0),
(13554,13553,1978,7,0),
(13555,13554,1978,8,0),
(25295,13555,1978,9,0),
/* Trueshot Aura */
(19506,0,19506,1,0),
(20905,19506,19506,2,0),
(20906,20905,19506,3,0),
/* Viper Sting */
(3034,0,3034,1,0),
(14279,3034,3034,2,0),
(14280,14279,3034,3,0),
/* Volley */
(1510,0,1510,1,0),
(14294,1510,1510,2,0),
(14295,14294,1510,3,0),
-- ------------------
-- (164) Blacksmithing
-- ------------------
/* Blacksmithing */
(9787,9785,2018,5,0),
(9788,9785,2018,5,0),
(17039,9787,2018,6,0),
(17040,9787,2018,6,0),
(17041,9787,2018,6,0),
-- ------------------
-- (165) Leatherworking
-- ------------------
/* Leatherworking */
(10656,10662,2108,5,0),
(10658,10662,2108,5,0),
(10660,10662,2108,5,0),
-- ------------------
-- (184) Retribution (Paladin)
-- ------------------
/* Blessing of Might */
(19740,0,19740,1,0),
(19834,19740,19740,2,0),
(19835,19834,19740,3,0),
(19836,19835,19740,4,0),
(19837,19836,19740,5,0),
(19838,19837,19740,6,0),
(25291,19838,19740,7,0),
/* Greater Blessing of Might */
(25782,0,25782,1,19838),
(25916,25782,25782,2,25291),
/* Hammer of Wrath */
(24275,0,24275,1,0),
(24274,24275,24275,2,0),
(24239,24274,24275,3,0),
/* Seal of Command */
(20375,0,20375,1,0),
(20915,20375,20375,2,0),
(20918,20915,20375,3,0),
(20919,20918,20375,4,0),
(20920,20919,20375,5,0),
/* Seal of the Crusader */
(21082,0,21082,1,0),
(20162,21082,21082,2,0),
(20305,20162,21082,3,0),
(20306,20305,21082,4,0),
(20307,20306,21082,5,0),
(20308,20307,21082,6,0),
-- ------------------
-- (237)Arcane
-- ------------------
/* Amplify Magic */
(1008,0,1008,1,0),
(8455,1008,1008,2,0),
(10169,8455,1008,3,0),
(10170,10169,1008,4,0),
/* Arcane Explosion */
(1449,0,1449,1,0),
(8437,1449,1449,2,0),
(8438,8437,1449,3,0),
(8439,8438,1449,4,0),
(10201,8439,1449,5,0),
(10202,10201,1449,6,0),
/* Arcane Intellect */
(1459,0,1459,1,0),
(1460,1459,1459,2,0),
(1461,1460,1459,3,0),
(10156,1461,1459,4,0),
(10157,10156,1459,5,0),
/* Arcane Missiles */
(5143,0,5143,1,0),
(5144,5143,5143,2,0),
(5145,5144,5143,3,0),
(8416,5145,5143,4,0),
(8417,8416,5143,5,0),
(10211,8417,5143,6,0),
(10212,10211,5143,7,0),
(25345,10212,5143,8,0),
/* Conjure Food */
(587,0,587,1,0),
(597,587,587,2,0),
(990,597,587,3,0),
(6129,990,587,4,0),
(10144,6129,587,5,0),
(10145,10144,587,6,0),
(28612,10145,587,7,0),
/* Conjure Water */
(5504,0,5504,1,0),
(5505,5504,5504,2,0),
(5506,5505,5504,3,0),
(6127,5506,5504,4,0),
(10138,6127,5504,5,0),
(10139,10138,5504,6,0),
(10140,10139,5504,7,0),
/* Dampen Magic */
(604,0,604,1,0),
(8450,604,604,2,0),
(8451,8450,604,3,0),
(10173,8451,604,4,0),
(10174,10173,604,5,0),
/* Mage Armor */
(6117,0,6117,1,0),
(22782,6117,6117,2,0),
(22783,22782,6117,3,0),
/* Mana Shield */
(1463,0,1463,1,0),
(8494,1463,1463,2,0),
(8495,8494,1463,3,0),
(10191,8495,1463,4,0),
(10192,10191,1463,5,0),
(10193,10192,1463,6,0),
/* Polymorph */
(118,0,118,1,0),
(12824,118,118,2,0),
(12825,12824,118,3,0),
(12826,12825,118,4,0),
-- ------------------
-- (267) Protection (Paladin)
-- ------------------
/* Blessing of Kings */
(20217,0,20217,1,0),
/* Blessing of Protection */
(1022,0,1022,1,0),
(5599,1022,1022,2,0),
(10278,5599,1022,3,0),
/* Blessing of Sacrifice */
(6940,0,6940,1,0),
(20729,6940,6940,2,0),
/* Blessing of Salvation */
(1038,0,1038,1,0),
/* Blessing of Sanctuary */
(20911,0,20911,1,0),
(20912,20911,20911,2,0),
(20913,20912,20911,3,0),
(20914,20913,20911,4,0),
/* Divine Protection */
(498,0,498,1,0),
(5573,498,498,2,0),
/* Divine Shield */
(642,0,642,1,0),
(1020,642,642,2,0),
/* Greater Blessing of Kings */
(25898,0,25898,1,20217),
/* Greater Blessing of Salvation */
(25895,0,25895,1,1038),
/* Greater Blessing of Sanctuary */
(25899,0,25899,1,20914),
/* Hammer of Justice */
(853,0,853,1,0),
(5588,853,853,2,0),
(5589,5588,853,3,0),
(10308,5589,853,4,0),
/* Holy Shield */
(20925,0,20925,1,0),
(20927,20925,20925,2,0),
(20928,20927,20925,3,0),
-- ------------------
-- (354)Demonology
-- ------------------
/* Banish */
(710,0,710,1,0),
(18647,710,710,2,0),
/* Create Firestone */
(6366,0,6366,1,0),
(17951,6366,6366,2,0),
(17952,17951,6366,3,0),
(17953,17952,6366,4,0),
/* Create Healthstone */
(6201,0,6201,1,0),
(6202,6201,6201,2,0),
(5699,6202,6201,3,0),
(11729,5699,6201,4,0),
(11730,11729,6201,5,0),
/* Create Soulstone */
(693,0,693,1,0),
(20752,693,693,2,0),
(20755,20752,693,3,0),
(20756,20755,693,4,0),
(20757,20756,693,5,0),
/* Create Spellstone */
(2362,0,2362,1,0),
(17727,2362,2362,2,0),
(17728,17727,2362,3,0),
/* Demon Armor */
(706,0,706,1,0),
(1086,706,706,2,0),
(11733,1086,706,3,0),
(11734,11733,706,4,0),
(11735,11734,706,5,0),
/* Demon Skin */
(687,0,687,1,0),
(696,687,687,2,0),
/* Enslave Demon */
(1098,0,1098,1,0),
(11725,1098,1098,2,0),
(11726,11725,1098,3,0),
/* Health Funnel */
(755,0,755,1,0),
(3698,755,755,2,0),
(3699,3698,755,3,0),
(3700,3699,755,4,0),
(11693,3700,755,5,0),
(11694,11693,755,6,0),
(11695,11694,755,7,0),
/* Shadow Ward */
(6229,0,6229,1,0),
(11739,6229,6229,2,0),
(11740,11739,6229,3,0),
(28610,11740,6229,4,0),
-- ------------------
-- (355)Affliction
-- ------------------
/* Corruption */
(172,0,172,1,0),
(6222,172,172,2,0),
(6223,6222,172,3,0),
(7648,6223,172,4,0),
(11671,7648,172,5,0),
(11672,11671,172,6,0),
(25311,11672,172,7,0),
/* Curse of Agony */
(980,0,980,1,0),
(1014,980,980,2,0),
(6217,1014,980,3,0),
(11711,6217,980,4,0),
(11712,11711,980,5,0),
(11713,11712,980,6,0),
/* Curse of the Elements */
(1490,0,1490,1,0),
(11721,1490,1490,2,0),
(11722,11721,1490,3,0),
/* Curse of Recklessness */
(704,0,704,1,0),
(7658,704,704,2,0),
(7659,7658,704,3,0),
(11717,7659,704,4,0),
/* Curse of Shadow */
(17862,0,17862,1,0),
(17937,17862,17862,2,0),
/* Curse of Tongues */
(1714,0,1714,1,0),
(11719,1714,1714,2,0),
/* Curse of Weakness */
(702,0,702,1,0),
(1108,702,702,2,0),
(6205,1108,702,3,0),
(7646,6205,702,4,0),
(11707,7646,702,5,0),
(11708,11707,702,6,0),
/* Dark Pact */
(18220,0,18220,1,0),
(18937,18220,18220,2,0),
(18938,18937,18220,3,0),
/* Death Coil */
(6789,0,6789,1,0),
(17925,6789,6789,2,0),
(17926,17925,6789,3,0),
/* Drain Life */
(689,0,689,1,0),
(699,689,689,2,0),
(709,699,689,3,0),
(7651,709,689,4,0),
(11699,7651,689,5,0),
(11700,11699,689,6,0),
/* Drain Mana */
(5138,0,5138,1,0),
(6226,5138,5138,2,0),
(11703,6226,5138,3,0),
(11704,11703,5138,4,0),
/* Drain Soul */
(1120,0,1120,1,0),
(8288,1120,1120,2,0),
(8289,8288,1120,3,0),
(11675,8289,1120,4,0),
/* Fear */
(5782,0,5782,1,0),
(6213,5782,5782,2,0),
(6215,6213,5782,3,0),
/* Howl of Terror */
(5484,0,5484,1,0),
(17928,5484,5484,2,0),
/* Life Tap */
(1454,0,1454,1,0),
(1455,1454,1454,2,0),
(1456,1455,1454,3,0),
(11687,1456,1454,4,0),
(11688,11687,1454,5,0),
(11689,11688,1454,6,0),
/* Siphon Life */
(18265,0,18265,1,0),
(18879,18265,18265,2,0),
(18880,18879,18265,3,0),
(18881,18880,18265,4,0),
-- ------------------
-- (373) Enhancement
-- ------------------
/* Fire Resistance Totem */
(8184,0,8184,1,0),
(10537,8184,8184,2,0),
(10538,10537,8184,3,0),
/* Flametongue Totem */
(8227,0,8227,1,0),
(8249,8227,8227,2,0),
(10526,8249,8227,3,0),
(16387,10526,8227,4,0),
/* Flametongue Weapon */
(8024,0,8024,1,0),
(8027,8024,8024,2,0),
(8030,8027,8024,3,0),
(16339,8030,8024,4,0),
(16341,16339,8024,5,0),
(16342,16341,8024,6,0),
/* Frost Resistance Totem */
(8181,0,8181,1,0),
(10478,8181,8181,2,0),
(10479,10478,8181,3,0),
/* Frostbrand Weapon */
(8033,0,8033,1,0),
(8038,8033,8033,2,0),
(10456,8038,8033,3,0),
(16355,10456,8033,4,0),
(16356,16355,8033,5,0),
/* Grace of Air Totem */
(8835,0,8835,1,0),
(10627,8835,8835,2,0),
(25359,10627,8835,3,0),
/* Lightning Shield */
(324,0,324,1,0),
(325,324,324,2,0),
(905,325,324,3,0),
(945,905,324,4,0),
(8134,945,324,5,0),
(10431,8134,324,6,0),
(10432,10431,324,7,0),
/* Nature Resistance Totem */
(10595,0,10595,1,0),
(10600,10595,10595,2,0),
(10601,10600,10595,3,0),
/* Rockbiter Weapon */
(8017,0,8017,1,0),
(8018,8017,8017,2,0),
(8019,8018,8017,3,0),
(10399,8019,8017,4,0),
(16314,10399,8017,5,0),
(16315,16314,8017,6,0),
(16316,16315,8017,7,0),
/* Stoneskin Totem */
(8071,0,8071,1,0),
(8154,8071,8071,2,0),
(8155,8154,8071,3,0),
(10406,8155,8071,4,0),
(10407,10406,8071,5,0),
(10408,10407,8071,6,0),
/* Strength of Earth Totem */
(8075,0,8075,1,0),
(8160,8075,8075,2,0),
(8161,8160,8075,3,0),
(10442,8161,8075,4,0),
(25361,10442,8075,5,0),
/* Windfury Totem */
(8512,0,8512,1,0),
(10613,8512,8512,2,0),
(10614,10613,8512,3,0),
/* Windfury Weapon */
(8232,0,8232,1,0),
(8235,8232,8232,2,0),
(10486,8235,8232,3,0),
(16362,10486,8232,4,0),
/* Windwall Totem */
(15107,0,15107,1,0),
(15111,15107,15107,2,0),
(15112,15111,15107,3,0),
-- ------------------
-- (374) Restoration (Shaman)
-- ------------------
/* Ancestral Spirit */
(2008,0,2008,1,0),
(20609,2008,2008,2,0),
(20610,20609,2008,3,0),
(20776,20610,2008,4,0),
(20777,20776,2008,5,0),
/* Chain Heal */
(1064,0,1064,1,0),
(10622,1064,1064,2,0),
(10623,10622,1064,3,0),
/* Entangling Roots */
(339,0,339,1,0),
(1062,339,339,2,0),
(5195,1062,339,3,0),
(5196,5195,339,4,0),
(9852,5196,339,5,0),
(9853,9852,339,6,0),
/* Healing Stream Totem */
(5394,0,5394,1,0),
(6375,5394,5394,2,0),
(6377,6375,5394,3,0),
(10462,6377,5394,4,0),
(10463,10462,5394,5,0),
/* Healing Wave */
(331,0,331,1,0),
(332,331,331,2,0),
(547,332,331,3,0),
(913,547,331,4,0),
(939,913,331,5,0),
(959,939,331,6,0),
(8005,959,331,7,0),
(10395,8005,331,8,0),
(10396,10395,331,9,0),
(25357,10396,331,10,0),
/* Lesser Healing Wave */
(8004,0,8004,1,0),
(8008,8004,8004,2,0),
(8010,8008,8004,3,0),
(10466,8010,8004,4,0),
(10467,10466,8004,5,0),
(10468,10467,8004,6,0),
/* Mana Spring Totem */
(5675,0,5675,1,0),
(10495,5675,5675,2,0),
(10496,10495,5675,3,0),
(10497,10496,5675,4,0),
-- ------------------
-- (375) Elemental Combat
-- ------------------
/* Chain Lightning */
(421,0,421,1,0),
(930,421,421,2,0),
(2860,930,421,3,0),
(10605,2860,421,4,0),
/* Earth Shock */
(8042,0,8042,1,0),
(8044,8042,8042,2,0),
(8045,8044,8042,3,0),
(8046,8045,8042,4,0),
(10412,8046,8042,5,0),
(10413,10412,8042,6,0),
(10414,10413,8042,7,0),
/* Fire Nova */
(1535,0,1535,1,0),
(8498,1535,1535,2,0),
(8499,8498,1535,3,0),
(11314,8499,1535,4,0),
(11315,11314,1535,5,0),
/* Flame Shock */
(8050,0,8050,1,0),
(8052,8050,8050,2,0),
(8053,8052,8050,3,0),
(10447,8053,8050,4,0),
(10448,10447,8050,5,0),
(29228,10448,8050,6,0),
/* Frost Shock */
(8056,0,8056,1,0),
(8058,8056,8056,2,0),
(10472,8058,8056,3,0),
(10473,10472,8056,4,0),
/* Lightning Bolt */
(403,0,403,1,0),
(529,403,403,2,0),
(548,529,403,3,0),
(915,548,403,4,0),
(943,915,403,5,0),
(6041,943,403,6,0),
(10391,6041,403,7,0),
(10392,10391,403,8,0),
(15207,10392,403,9,0),
(15208,15207,403,10,0),
/* Magma Totem */
(8190,0,8190,1,0),
(10585,8190,8190,2,0),
(10586,10585,8190,3,0),
(10587,10586,8190,4,0),
/* Purge */
(370,0,370,1,0),
(8012,370,370,2,0),
/* Searing Totem */
(3599,0,3599,1,0),
(6363,3599,3599,2,0),
(6364,6363,3599,3,0),
(6365,6364,3599,4,0),
(10437,6365,3599,5,0),
(10438,10437,3599,6,0),
/* Stoneclaw Totem */
(5730,0,5730,1,0),
(6390,5730,5730,2,0),
(6391,6390,5730,3,0),
(6392,6391,5730,4,0),
(10427,6392,5730,5,0),
(10428,10427,5730,6,0),
-- ------------------
-- (573)Restoration
-- ------------------
/* Gift of the Wild */
(21849,0,21849,1,0),
(21850,21849,21849,2,0),
/* Healing Touch */
(5185,0,5185,1,0),
(5186,5185,5185,2,0),
(5187,5186,5185,3,0),
(5188,5187,5185,4,0),
(5189,5188,5185,5,0),
(6778,5189,5185,6,0),
(8903,6778,5185,7,0),
(9758,8903,5185,8,0),
(9888,9758,5185,9,0),
(9889,9888,5185,10,0),
(25297,9889,5185,11,0),
/* Mark of the Wild */
(1126,0,1126,1,0),
(5232,1126,1126,2,0),
(6756,5232,1126,3,0),
(5234,6756,1126,4,0),
(8907,5234,1126,5,0),
(9884,8907,1126,6,0),
(9885,9884,1126,7,0),
/* Rebirth */
(20484,0,20484,1,0),
(20739,20484,20484,2,0),
(20742,20739,20484,3,0),
(20747,20742,20484,4,0),
(20748,20747,20484,5,0),
/* Regrowth */
(8936,0,8936,1,0),
(8938,8936,8936,2,0),
(8939,8938,8936,3,0),
(8940,8939,8936,4,0),
(8941,8940,8936,5,0),
(9750,8941,8936,6,0),
(9856,9750,8936,7,0),
(9857,9856,8936,8,0),
(9858,9857,8936,9,0),
/* Rejuvenation */
(774,0,774,1,0),
(1058,774,774,2,0),
(1430,1058,774,3,0),
(2090,1430,774,4,0),
(2091,2090,774,5,0),
(3627,2091,774,6,0),
(8910,3627,774,7,0),
(9839,8910,774,8,0),
(9840,9839,774,9,0),
(9841,9840,774,10,0),
(25299,9841,774,11,0),
/* Tranquility */
(740,0,740,1,0),
(8918,740,740,2,0),
(9862,8918,740,3,0),
(9863,9862,740,4,0),
-- ------------------
-- (574)Balance
-- ------------------
/* Faerie Fire */
(770,0,770,1,0),
(778,770,770,2,0),
(9749,778,770,3,0),
(9907,9749,770,4,0),
/* Hibernate */
(2637,0,2637,1,0),
(18657,2637,2637,2,0),
(18658,18657,2637,3,0),
/* Hurricane */
(16914,0,16914,1,0),
(17401,16914,16914,2,0),
(17402,17401,16914,3,0),
/* Insect Swarm */
(5570,0,5570,1,0),
(24974,5570,5570,2,0),
(24975,24974,5570,3,0),
(24976,24975,5570,4,0),
(24977,24976,5570,5,0),
/* Moonfire */
(8921,0,8921,1,0),
(8924,8921,8921,2,0),
(8925,8924,8921,3,0),
(8926,8925,8921,4,0),
(8927,8926,8921,5,0),
(8928,8927,8921,6,0),
(8929,8928,8921,7,0),
(9833,8929,8921,8,0),
(9834,9833,8921,9,0),
(9835,9834,8921,10,0),
/* Nature'sGrasp */
(16689,0,16689,1,339),
(16810,16689,16689,2,1062),
(16811,16810,16689,3,5195),
(16812,16811,16689,4,5196),
(16813,16812,16689,5,9852),
(17329,16813,16689,6,9853),
/* Soothe Animal */
(2908,0,2908,1,0),
(8955,2908,2908,2,0),
(9901,8955,2908,3,0),
/* Starfire */
(2912,0,2912,1,0),
(8949,2912,2912,2,0),
(8950,8949,2912,3,0),
(8951,8950,2912,4,0),
(9875,8951,2912,5,0),
(9876,9875,2912,6,0),
(25298,9876,2912,7,0),
/* Thorns */
(467,0,467,1,0),
(782,467,467,2,0),
(1075,782,467,3,0),
(8914,1075,467,4,0),
(9756,8914,467,5,0),
(9910,9756,467,6,0),
/* Wrath */
(5176,0,5176,1,0),
(5177,5176,5176,2,0),
(5178,5177,5176,3,0),
(5179,5178,5176,4,0),
(5180,5179,5176,5,0),
(6780,5180,5176,6,0),
(8905,6780,5176,7,0),
(9912,8905,5176,8,0),
-- ------------------
-- (593)Destruction
-- ------------------
/* Conflagrate */
(17962,0,17962,1,0),
(18930,17962,17962,2,0),
(18931,18930,17962,3,0),
(18932,18931,17962,4,0),
/* Hellfire */
(1949,0,1949,1,0),
(11683,1949,1949,2,0),
(11684,11683,1949,3,0),
/* Immolate */
(348,0,348,1,0),
(707,348,348,2,0),
(1094,707,348,3,0),
(2941,1094,348,4,0),
(11665,2941,348,5,0),
(11667,11665,348,6,0),
(11668,11667,348,7,0),
(25309,11668,348,8,0),
/* Rain of Fire */
(5740,0,5740,1,0),
(6219,5740,5740,2,0),
(11677,6219,5740,3,0),
(11678,11677,5740,4,0),
/* Searing Pain */
(5676,0,5676,1,0),
(17919,5676,5676,2,0),
(17920,17919,5676,3,0),
(17921,17920,5676,4,0),
(17922,17921,5676,5,0),
(17923,17922,5676,6,0),
/* Shadow Bolt */
(686,0,686,1,0),
(695,686,686,2,0),
(705,695,686,3,0),
(1088,705,686,4,0),
(1106,1088,686,5,0),
(7641,1106,686,6,0),
(11659,7641,686,7,0),
(11660,11659,686,8,0),
(11661,11660,686,9,0),
(25307,11661,686,10,0),
/* Shadowburn */
(17877,0,17877,1,0),
(18867,17877,17877,2,0),
(18868,18867,17877,3,0),
(18869,18868,17877,4,0),
(18870,18869,17877,5,0),
(18871,18870,17877,6,0),
/* Soul Fire */
(6353,0,6353,1,0),
(17924,6353,6353,2,0),
-- ------------------
-- (594) Holy (Paladin)
-- ------------------
/* Blessing of Light */
(19977,0,19977,1,0),
(19978,19977,19977,2,0),
(19979,19978,19977,3,0),
/* Blessing of Wisdom */
(19742,0,19742,1,0),
(19850,19742,19742,2,0),
(19852,19850,19742,3,0),
(19853,19852,19742,4,0),
(19854,19853,19742,5,0),
(25290,19854,19742,6,0),
/* Consecration */
(26573,0,26573,1,0),
(20116,26573,26573,2,0),
(20922,20116,26573,3,0),
(20923,20922,26573,4,0),
(20924,20923,26573,5,0),
/* Exorcism */
(879,0,879,1,0),
(5614,879,879,2,0),
(5615,5614,879,3,0),
(10312,5615,879,4,0),
(10313,10312,879,5,0),
(10314,10313,879,6,0),
/* Flash of Light */
(19750,0,19750,1,0),
(19939,19750,19750,2,0),
(19940,19939,19750,3,0),
(19941,19940,19750,4,0),
(19942,19941,19750,5,0),
(19943,19942,19750,6,0),
/* Greater Blessing of Light */
(25890,0,25890,1,19979),
/* Greater Blessing of Wisdom */
(25894,0,25894,1,19854),
(25918,25894,25894,2,25290),
/* Holy Light */
(635,0,635,1,0),
(639,635,635,2,0),
(647,639,635,3,0),
(1026,647,635,4,0),
(1042,1026,635,5,0),
(3472,1042,635,6,0),
(10328,3472,635,7,0),
(10329,10328,635,8,0),
(25292,10329,635,9,0),
/* Holy Shock */
(20473,0,20473,1,0),
(20929,20473,20473,2,0),
(20930,20929,20473,3,0),
/* Holy Wrath */
(2812,0,2812,1,0),
(10318,2812,2812,2,0),
/* Redemption */
(7328,0,7328,1,0),
(10322,7328,7328,2,0),
(10324,10322,7328,3,0),
(20772,10324,7328,4,0),
(20773,20772,7328,5,0),
/* Seal of Light */
(20165,0,20165,1,0),
(20347,20165,20165,2,0),
(20348,20347,20165,3,0),
(20349,20348,20165,4,0),
/* Seal of Righteousness */
(20287,21084,20154,3,0),
(20288,20287,20154,4,0),
(20289,20288,20154,5,0),
(20290,20289,20154,6,0),
(20291,20290,20154,7,0),
(20292,20291,20154,8,0),
(20293,20292,20154,9,0),
/* Seal of Wisdom */
(20166,0,20166,1,0),
(20356,20166,20166,2,0),
(20357,20356,20166,3,0),
/* Turn Undead */
(2878,0,2878,1,0),
(5627,2878,2878,2,0),
(10326,5627,2878,3,0),
-- ------------------
-- (613)Discipline
-- ------------------
/* Dispel Magic*/
(527,0,527,1,0),
(988,527,527,2,0),
/* Divine Spirit */
(14752,0,14752,1,0),
(14818,14752,14752,2,0),
(14819,14818,14752,3,0),
(27841,14819,14752,4,0),
/* Elune's Grace */
(2651,0,2651,1,0),
(19289,2651,2651,2,0),
(19291,19289,2651,3,0),
(19292,19291,2651,4,0),
(19293,19292,2651,5,0),
/* Feedback */
(13896,0,13896,1,0),
(19271,13896,13896,2,0),
(19273,19271,13896,3,0),
(19274,19273,13896,4,0),
(19275,19274,13896,5,0),
/* InnerFire */
(588,0,588,1,0),
(7128,588,588,2,0),
(602,7128,588,3,0),
(1006,602,588,4,0),
(10951,1006,588,5,0),
(10952,10951,588,6,0),
/* Mana Burn */
(8129,0,8129,1,0),
(8131,8129,8129,2,0),
(10874,8131,8129,3,0),
(10875,10874,8129,4,0),
(10876,10875,8129,5,0),
/* Power Word: Fortitude */
(1243,0,1243,1,0),
(1244,1243,1243,2,0),
(1245,1244,1243,3,0),
(2791,1245,1243,4,0),
(10937,2791,1243,5,0),
(10938,10937,1243,6,0),
/* PowerWord:Shield */
(17,0,17,1,0),
(592,17,17,2,0),
(600,592,17,3,0),
(3747,600,17,4,0),
(6065,3747,17,5,0),
(6066,6065,17,6,0),
(10898,6066,17,7,0),
(10899,10898,17,8,0),
(10900,10899,17,9,0),
(10901,10900,17,10,0),
/* Prayer of Fortitude */
(21562,0,21562,1,0),
(21564,21562,21562,2,0),
/* Prayer of Spirit */
(27681,14752,14752,2,0),
/* Shackle Undead */
(9484,0,9484,1,0),
(9485,9484,9484,2,0),
(10955,9485,9484,3,0),
/* Starshards */
(10797,0,10797,1,0),
(19296,10797,10797,2,0),
(19299,19296,10797,3,0),
(19302,19299,10797,4,0),
(19303,19302,10797,5,0),
(19304,19303,10797,6,0),
(19305,19304,10797,7,0),
-- ------------------
-- (762)Riding
-- ------------------
/*Riding*/
(33388,0,33388,1,0),
(33391,33388,33388,2,0);
/*!40000 ALTER TABLE `spell_chain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_elixir`
--

DROP TABLE IF EXISTS `spell_elixir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_elixir` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'SpellId of potion',
  `mask` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Mask 0x1 battle 0x2 guardian 0x3 flask 0x7 unstable flasks 0xB shattrath flasks',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_facing`
--

DROP TABLE IF EXISTS `spell_facing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_facing` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell ID',
  `facingcasterflag` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'flag for facing state, usually 1',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Table structure for table `spell_learn_spell`
--

DROP TABLE IF EXISTS `spell_learn_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_learn_spell` (
  `entry` smallint(5) unsigned NOT NULL DEFAULT '0',
  `SpellID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`entry`,`SpellID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_linked`
--

DROP TABLE IF EXISTS `spell_linked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_linked` (
  `entry` int(10) unsigned NOT NULL COMMENT 'Spell entry',
  `linked_entry` int(10) unsigned NOT NULL COMMENT 'Linked spell entry',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Type of link',
  `effect_mask` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'mask of effect (NY)',
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`,`linked_entry`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Linked spells storage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_pet_auras`
--

DROP TABLE IF EXISTS `spell_pet_auras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_pet_auras` (
  `spell` mediumint(8) unsigned NOT NULL COMMENT 'dummy spell id',
  `pet` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'pet id; 0 = all',
  `aura` mediumint(8) unsigned NOT NULL COMMENT 'pet aura id',
  PRIMARY KEY (`spell`,`pet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_proc_event`
--

DROP TABLE IF EXISTS `spell_proc_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_proc_event` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `SchoolMask` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyName` smallint(5) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask0` bigint(40) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask1` bigint(40) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask2` bigint(40) unsigned NOT NULL DEFAULT '0',
  `procFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `procEx` int(10) unsigned NOT NULL DEFAULT '0',
  `ppmRate` float NOT NULL DEFAULT '0',
  `CustomChance` float NOT NULL DEFAULT '0',
  `Cooldown` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_proc_item_enchant`
--

DROP TABLE IF EXISTS `spell_proc_item_enchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_proc_item_enchant` (
  `entry` mediumint(8) unsigned NOT NULL,
  `ppmRate` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_script_target`
--

DROP TABLE IF EXISTS `spell_script_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_script_target` (
  `entry` mediumint(8) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `targetEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `inverseEffectMask` mediumint(8) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_type_target` (`entry`,`type`,`targetEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_target_position`
--

DROP TABLE IF EXISTS `spell_target_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_target_position` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `target_map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `target_position_x` float NOT NULL DEFAULT '0',
  `target_position_y` float NOT NULL DEFAULT '0',
  `target_position_z` float NOT NULL DEFAULT '0',
  `target_orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spell_threat`
--

DROP TABLE IF EXISTS `spell_threat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_threat` (
  `entry` mediumint(8) unsigned NOT NULL,
  `Threat` smallint(6) NOT NULL,
  `multiplier` float NOT NULL DEFAULT '1' COMMENT 'threat multiplier for damage/healing',
  `ap_bonus` float NOT NULL DEFAULT '0' COMMENT 'additional threat bonus from attack power',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transports`
--

DROP TABLE IF EXISTS `transports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transports` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name` text,
  `period` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Transports';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transports`
--

LOCK TABLES `transports` WRITE;
/*!40000 ALTER TABLE `transports` DISABLE KEYS */;
INSERT INTO `transports` VALUES
(20808,'Ratchet and Booty Bay',350818),
(164871,'Orgrimmar and Undercity',356284),
(175080,'Grom\'Gol Base Camp and Orgrimmar',303463),
(176231,'Menethil Harbor and Theramore Isle',329313),
(176244,'Teldrassil and Auberdine',316251),
(176310,'Menethil Harbor and Auberdine',295579),
(176495,'Grom\'Gol Base Camp and Undercity',333044),
(177233,'Forgotton Coast and Feathermoon Stronghold',317038);
/*!40000 ALTER TABLE `transports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `world_template`
--

DROP TABLE IF EXISTS `world_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `world_template` (
  `map` smallint(5) unsigned NOT NULL,
  `ScriptName` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
