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
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbscripts_on_go_template_use`
--

LOCK TABLES `dbscripts_on_go_template_use` WRITE;
/*!40000 ALTER TABLE `dbscripts_on_go_template_use` DISABLE KEYS */;
INSERT INTO `dbscripts_on_go_template_use` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (170569,1,22,54,5,9678,20,3,0,0,0,0,0,0,0,0,'Shill - change faction to hostile'),
(170569,1,0,0,0,9678,20,3,2000000068,0,0,0,0,0,0,0,'Shill - say on Shill door open'),
(170568,2,22,54,5,9677,20,3,0,0,0,0,0,0,0,0,'Ograbisi - change faction to hostile'),
(170568,2,22,54,5,9681,20,3,0,0,0,0,0,0,0,0,'Jaz - change faction to hostile'),
(170568,1,0,0,0,9677,20,3,2000000070,0,0,0,0,0,0,0,'Ograbisi - say on Jaz door open'),
(170562,1,0,0,0,9023,20,3,2000000067,0,0,0,0,0,0,0,'Windsor - say on Dughal door open'),
(179804,1,10,14605,60000,0,0,2,0,0,0,0,0,0,0,0,'Drakonid Bones - Summon Bone Construct'),
(170567,1,0,0,0,9680,20,3,2000000069,0,0,0,0,0,0,0,'Crest - say on Crest door open'),
(170567,1,22,54,5,9680,20,3,0,0,0,0,0,0,0,0,'Crest - change faction to hostile'),
(178145,0,10,11920,30000,0,0,0,0,0,0,0,0,0,0,0,''),
(176581,0,10,11876,30000,0,0,0,0,0,0,0,0,0,0,0,''),
(175944,0,10,10882,30000,0,0,0,0,0,0,0,-5008.34,-2118.89,83.657,0.874,''),
(179985,1,10,15041,60000,0,0,2,0,0,0,0,0,0,0,0,'Spider Egg - Summon Spawn of Mar\'li'),
(177398,1,10,11937,60000,0,0,0,0,0,0,0,0,0,0,0,'Demon Portal - Summon Demon Portal Guardian'),
(128403,2,15,10247,0,0,0,2,0,0,0,0,0,0,0,0,'cast Summon Zul\'Farrak Zombies'),
(124371,1,10,7228,9000000,0,0,0,0,0,0,0,-235.673,309.639,-47.5976,4.74317,'Summon Ironaya'),
(124371,27,11,14394,9000000,0,0,0,0,0,0,0,0,0,0,0,'Open the Seal of Khaz\'Mul'),
(124371,28,0,1,0,7228,100,0,2000005555,0,0,0,0,0,0,0,'Ironaya yell'),
(124371,28,20,2,0,7228,100,0,0,0,0,0,0,0,0,0,'Ironaya starts moving'),
(300058,0,15,26448,0,15892,7,3,0,0,0,0,0,0,0,0,'Lunar Festival - Teleports Moonglade - Alliance'),
(300058,0,15,26448,0,15891,7,3,0,0,0,0,0,0,0,0,'Lunar Festival - Teleports Moonglade - Horde'),
(300058,0,15,26454,0,15694,7,5,0,0,0,0,0,0,0,0,'Lunar Festival - Teleports Storwimnd'),
(300058,0,15,26452,0,15906,7,5,0,0,0,0,0,0,0,0,'Lunar Festival - Teleports Ironforge'),
(300058,0,15,26450,0,15905,7,5,0,0,0,0,0,0,0,0,'Lunar Festival - Teleports Darnassus'),
(300058,0,15,26453,0,15908,7,5,0,0,0,0,0,0,0,0,'Lunar Festival - Teleports Orgrimmar'),
(300058,0,15,26456,0,15907,7,5,0,0,0,0,0,0,0,0,'Lunar Festival - Teleports Undercity'),
(300058,0,15,26455,0,15719,7,5,0,0,0,0,0,0,0,0,'Lunar Festival - Teleports Thunderbluff'),
(17156,0,11,0,15,150138,10,0,0,0,0,0,0,0,0,0,'Stonewrought Pass - Northern Door Lever'),
(17157,0,11,0,15,150137,10,0,0,0,0,0,0,0,0,0,'Stonewrought Pass - Southern Door Lever'),
(178905,0,10,13696,60000,0,0,0,0,0,0,0,0,0,0,0,'summon Noxxious Scion'),
(178905,0,10,13696,60000,0,0,0,0,0,0,0,0,0,0,0,'summon Noxxious Scion'),
(178905,0,10,13696,60000,0,0,0,0,0,0,0,0,0,0,0,'summon Noxxious Scion');
/*!40000 ALTER TABLE `dbscripts_on_go_template_use` ENABLE KEYS */;
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
