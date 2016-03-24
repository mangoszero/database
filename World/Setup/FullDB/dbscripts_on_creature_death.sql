-- ---------------------------------------- 
-- --        CLEAR DOWN THE TABLE        -- 
-- ---------------------------------------- 
TRUNCATE TABLE `dbscripts_on_creature_death`; 
-- ---------------------------------------- 
-- MySQL dump 10.13  Distrib 5.5.37, for Win32 (x86)
--
-- Host: localhost    Database: mangos0
-- ------------------------------------------------------
-- Server version	5.5.34

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
-- Dumping data for table `dbscripts_on_creature_death`
--

LOCK TABLES `dbscripts_on_creature_death` WRITE;
/*!40000 ALTER TABLE `dbscripts_on_creature_death` DISABLE KEYS */;
INSERT INTO `dbscripts_on_creature_death` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES 
(15355,1,15,27627,0,0,0,8,0,0,0,0,0,0,0,0,'drops small obsidian chunk'),
(15338,1,15,27627,0,0,0,8,0,0,0,0,0,0,0,0,'drops small obsidian chunk'),
(15264,1,15,27627,0,0,0,8,0,0,0,0,0,0,0,0,'drops small obsidian chunk'),
(15340,1,15,27630,0,0,0,8,0,0,0,0,0,0,0,0,'drops large obsidian chunk'),
(15277,1,15,27630,0,0,0,8,0,0,0,0,0,0,0,0,'drops large obsidian chunk'),
(412,5,0,6,0,468,4185,16,2000000188,0,0,0,0,0,0,0,'stitches - town crier 3rd yell'),
(4971,1,0,0,0,0,0,0,2000000602,0,0,0,0,0,0,0,''),
(10503,1,0,0,0,0,0,0,2000000612,0,0,0,0,0,0,0,''),
(10503,1,15,26096,0,0,0,0,0,0,0,0,0,0,0,0,'Jandice Barov - Summon Journal of Jandice Barov on Death'),
(4829,2,31,6729,50,0,0,8,0,0,0,0,0,0,0,0,'search for 6729'),
(4829,3,10,6729,300000,0,0,0,0,0,0,0,-857.158,-467.636,-33.9256,5.90677,'');
/*!40000 ALTER TABLE `dbscripts_on_creature_death` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-24 22:25:10
