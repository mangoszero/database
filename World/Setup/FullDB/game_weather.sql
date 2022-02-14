-- ---------------------------------------- 
-- --        CLEAR DOWN THE TABLE        -- 
-- ---------------------------------------- 
TRUNCATE TABLE `game_weather`; 
-- ---------------------------------------- 
-- MySQL dump 10.13  Distrib 5.5.37, for Win32 (x86)
--
-- Host: localhost    Database: mangos0
-- ------------------------------------------------------
-- Server version	5.5.5-10.5.8-MariaDB

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
-- Dumping data for table `game_weather`
--

LOCK TABLES `game_weather` WRITE;
/*!40000 ALTER TABLE `game_weather` DISABLE KEYS */;
INSERT INTO `game_weather` (`zone`, `spring_rain_chance`, `spring_snow_chance`, `spring_storm_chance`, `summer_rain_chance`, `summer_snow_chance`, `summer_storm_chance`, `fall_rain_chance`, `fall_snow_chance`, `fall_storm_chance`, `winter_rain_chance`, `winter_snow_chance`, `winter_storm_chance`) VALUES 
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-14 21:26:18
