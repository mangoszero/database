-- ---------------------------------------- 
-- --        CLEAR DOWN THE TABLE        -- 
-- ---------------------------------------- 
TRUNCATE TABLE `dbscripts_on_spell`; 
-- ---------------------------------------- 
-- MySQL dump 10.13  Distrib 5.5.37, for Win32 (x86)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	5.6.23-log

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
-- Dumping data for table `dbscripts_on_spell`
--

LOCK TABLES `dbscripts_on_spell` WRITE;
/*!40000 ALTER TABLE `dbscripts_on_spell` DISABLE KEYS */;
INSERT INTO `dbscripts_on_spell` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (7669,0,14,7657,1,0,0,0,0,0,0,0,0,0,0,0,'Remove Hex of Ravenclaw'),
(7669,0,14,7656,1,0,0,0,0,0,0,0,0,0,0,0,'Remove Hex of Ravenclaw'),
(11365,0,18,1000,0,0,0,0,0,0,0,0,0,0,0,0,'despawn self'),
(11885,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn treant corpse'),
(11886,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn wildkin corpse'),
(11887,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn hyppogryph corpse'),
(11888,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn faerie dragon corpse'),
(11889,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn mountain giant corpse'),
(12189,3,26,0,0,3475,50,0,0,0,0,0,0,0,0,0,'Start Attack'),
(21052,0,15,8329,0,0,0,6,0,0,0,0,0,0,0,0,'Enthralled Deeprun Rat - Cast Suicide'),
(26608,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Glob of Viscidus - Despawn'),
(19250,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,'kill credit'),
(19250,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'despawn target'),
(23359,0,26,0,0,0,0,2,0,0,0,0,0,0,0,0,'Giant/Strider attacks player on Transmogrify Spell Hit');
/*!40000 ALTER TABLE `dbscripts_on_spell` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-10 11:07:12
