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
-- Table structure for table `scripted_areatrigger`
--

DROP TABLE IF EXISTS `scripted_areatrigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripted_areatrigger` (
  `entry` mediumint(8) NOT NULL,
  `ScriptName` char(64) NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripted_areatrigger`
--

LOCK TABLES `scripted_areatrigger` WRITE;
/*!40000 ALTER TABLE `scripted_areatrigger` DISABLE KEYS */;
INSERT INTO `scripted_areatrigger` (`entry`, `ScriptName`) VALUES (522,'at_twiggy_flathead'),
(1447,'at_zulfarrak'),
(1526,'at_ring_of_law'),
(1740,'at_scent_larkorwi'),
(1739,'at_scent_larkorwi'),
(1738,'at_scent_larkorwi'),
(1737,'at_scent_larkorwi'),
(1736,'at_scent_larkorwi'),
(1735,'at_scent_larkorwi'),
(1734,'at_scent_larkorwi'),
(1733,'at_scent_larkorwi'),
(1732,'at_scent_larkorwi'),
(1731,'at_scent_larkorwi'),
(1730,'at_scent_larkorwi'),
(1729,'at_scent_larkorwi'),
(1728,'at_scent_larkorwi'),
(1727,'at_scent_larkorwi'),
(1726,'at_scent_larkorwi'),
(1966,'at_murkdeep'),
(2046,'at_blackrock_spire'),
(2026,'at_blackrock_spire'),
(3066,'at_ravenholdt'),
(3552,'at_childrens_week_spot'),
(3550,'at_childrens_week_spot'),
(3549,'at_childrens_week_spot'),
(3548,'at_childrens_week_spot'),
(3547,'at_childrens_week_spot'),
(3546,'at_childrens_week_spot'),
(3626,'at_vaelastrasz'),
(3960,'at_zulgurub'),
(3958,'at_zulgurub'),
(4016,'at_shade_of_eranikus'),
(4034,'at_stomach_cthun'),
(4033,'at_stomach_cthun'),
(4047,'at_temple_ahnqiraj'),
(4156,'at_naxxramas'),
(4113,'at_naxxramas'),
(4112,'at_naxxramas');
/*!40000 ALTER TABLE `scripted_areatrigger` ENABLE KEYS */;
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
