--
-- Copyright (C) 2005-2015 MaNGOS <http://getmangos.eu/>
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature Linking System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_linking_template`
--

LOCK TABLES `creature_linking_template` WRITE;
/*!40000 ALTER TABLE `creature_linking_template` DISABLE KEYS */;
INSERT INTO `creature_linking_template` (`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES (1725,36,644,1,0),
(2532,0,2533,656,0),
(2946,1,2433,3,0),
(5277,109,5709,1,0),
(5280,109,5709,1,0),
(5283,109,5709,1,0),
(5719,109,5709,1,0),
(5722,109,5709,1,0),
(7077,70,2748,20,0),
(7076,70,2748,20,0),
(7268,209,7267,1,0),
(10120,70,2748,20,0),
(8120,209,7267,1,0),
(8319,109,5709,1,0),
(7309,70,2748,20,0),
(10316,229,10316,3,0),
(10814,229,10363,7,0),
(11373,309,14507,7,0),
(11661,409,12259,7,0),
(11662,409,12098,7,0),
(11663,409,12018,7,0),
(11664,409,12018,7,0),
(11672,409,11988,39,0),
(11673,409,11982,1024,0),
(12099,409,12057,7,0),
(12119,409,12118,519,0),
(12557,469,12435,135,0),
(14456,469,12557,143,0),
(14892,1,14857,512,0),
(14988,309,11382,4096,0),
(15117,309,11382,4096,0),
(15276,531,15275,143,0),
(15316,531,15276,132,0),
(15317,531,15276,132,0),
(15334,531,15727,4128,0),
(15428,509,15339,4112,0),
(15514,509,15370,1030,0),
(15544,531,15511,1167,0),
(15543,531,15511,1167,0),
(15546,509,15369,4112,0),
(15589,531,15727,4,0),
(15725,531,15589,4096,0),
(15726,531,15727,4128,0),
(15728,531,15727,4128,0),
(15802,531,15727,4128,0),
(15904,531,15727,4128,0),
(15910,531,15727,4128,0),
(15934,509,15369,4096,0),
(15984,531,15516,519,0),
(16063,533,16062,143,0),
(16064,533,16062,143,0),
(16065,533,16062,143,0),
(16360,533,15932,4112,0),
(16505,533,15953,7,0),
(16506,533,15953,7,0),
(16573,533,15956,1034,0),
(16803,533,16061,7,0),
(17647,0,17635,515,10),
(17996,0,17995,515,10),
(5668,0,5670,518,20),
(5707,0,5706,518,20),
(5701,0,5706,518,20),
(14349,429,14327,515,0),
(2738,0,2612,515,0),
(2721,0,2714,515,0),
(390,0,330,515,0),
(15262,531,15263,1024,0),
(15264,531,15263,1024,0),
(11459,429,11489,1,0),
(10475,289,10433,1,0),
(10433,289,10432,1,0),
(15277,531,15276,1025,0),
(15250,531,15252,1679,7),
(15246,531,15252,1679,7),
(15229,531,15510,1024,0),
(15343,509,15348,1024,0),
(15338,509,15340,1024,0),
(15355,509,15339,1024,0),
(1755,0,1754,3,100),
(15235,531,15509,1024,0),
(15236,531,15235,1667,8),
(15249,531,15235,1667,8),
(15461,509,15340,1024,0),
(15462,509,15340,1024,0),
(15318,509,15369,1024,0),
(15319,509,15369,1024,0),
(15336,509,15369,1024,0),
(4063,0,2611,515,0),
(2764,0,2611,515,0),
(2765,0,2611,515,0),
(12101,409,12057,1024,0),
(7386,0,8666,8832,0),
(15922,531,15299,4112,0),
(8421,0,8400,3,50),
(8391,0,8400,3,50),
(2331,0,2330,656,20),
(3504,0,2330,656,20),
(1414,0,1413,656,30),
(1415,0,1413,656,30);
/*!40000 ALTER TABLE `creature_linking_template` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
