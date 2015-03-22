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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Weather System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_weather`
--

LOCK TABLES `game_weather` WRITE;
/*!40000 ALTER TABLE `game_weather` DISABLE KEYS */;
INSERT INTO `game_weather` (`zone`, `spring_rain_chance`, `spring_snow_chance`, `spring_storm_chance`, `summer_rain_chance`, `summer_snow_chance`, `summer_storm_chance`, `fall_rain_chance`, `fall_snow_chance`, `fall_storm_chance`, `winter_rain_chance`, `winter_snow_chance`, `winter_storm_chance`) VALUES (1,0,25,0,0,15,0,0,25,0,0,25,0),
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
