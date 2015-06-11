-- ---------------------------------------- 
-- --        CLEAR DOWN THE TABLE        -- 
-- ---------------------------------------- 
TRUNCATE TABLE `db_version`; 
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
-- Dumping data for table `db_version`
--

LOCK TABLES `db_version` WRITE;
/*!40000 ALTER TABLE `db_version` DISABLE KEYS */;
INSERT INTO `db_version` (`version`, `creature_ai_version`, `required_21000_17_dbdocslanguage`) VALUES ('ZeroDatabase 2.0.18 for MaNGOSZero / ScriptDev 20004+','MaNGOSZero Artificial Creature Intelligence Database',NULL),('MaNGOSZero Database 2.0.11 Rev 20007_18','EventAI and Scripts available',NULL),('MaNGOSZero Database 2.0.11 Rev 20007_19',NULL,NULL),('MaNGOSZero Database 2.0.11 Rev 20007_20',NULL,NULL),('MaNGOSZero Database Rev 21000_02',NULL,NULL),('MaNGOSZero Database Rev 21000_03',NULL,NULL),('MaNGOSZero Database Rev 21000_04',NULL,NULL),('MaNGOSZero Database Rev 21000_05',NULL,NULL),('MaNGOSZero Database Rev 21000_06',NULL,NULL),('MaNGOSZero Database Rev 21000_07',NULL,NULL),('MaNGOSZero Database Rev 21000_08',NULL,NULL),('MaNGOSZero Database 2.0.09 Rev 21000_09',NULL,NULL),('MaNGOSZero Database Rev 21000_10',NULL,NULL),('MaNGOSZero Database Rev 21000_11',NULL,NULL),('MaNGOSZero Database Rev 21000_12',NULL,NULL),('MaNGOSZero Database Rev 21000_13',NULL,NULL),('MaNGOSZero Database Rev 21000_14',NULL,NULL),('MaNGOSZero Database Rev 21000_17',NULL,NULL),('MaNGOSZero Database Rev 21000_17',NULL,NULL),('MaNGOSZero Database Rev 21000_17',NULL,NULL);
/*!40000 ALTER TABLE `db_version` ENABLE KEYS */;
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
