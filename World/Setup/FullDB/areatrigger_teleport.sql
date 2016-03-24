-- ---------------------------------------- 
-- --        CLEAR DOWN THE TABLE        -- 
-- ---------------------------------------- 
TRUNCATE TABLE `areatrigger_teleport`; 
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
-- Dumping data for table `areatrigger_teleport`
--

LOCK TABLES `areatrigger_teleport` WRITE;
/*!40000 ALTER TABLE `areatrigger_teleport` DISABLE KEYS */;
INSERT INTO `areatrigger_teleport` (`id`, `name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`, `condition_id`) VALUES 
(45,'Scarlet Monastery - Graveyard (Entrance)',189,1687,1050,18.6775,1.57,2004),
(78,'DeadMines Entrance',36,-16.4,-383.07,61.78,1.86,107),
(101,'Stormwind Stockades Entrance',34,54.23,0.28,-18.34,6.26,2003),
(107,'Stormwind Vault Entrance',35,-0.91,40.57,-24.23,0,0),
(109,'Stormwind Vault Instance',0,-8653.45,606.19,91.16,0,0),
(119,'DeadMines Instance Start',0,-11208.3,1672.52,24.66,4.55217,0),
(121,'Deadmines Instance End',0,-11339.4,1571.16,100.56,0,0),
(145,'Shadowfang Keep Entrance',33,-229.135,2109.18,76.8898,1.267,2002),
(194,'Shadowfang keep - Entrance',0,-232.796,1568.28,76.8909,4.398,0),
(226,'The Barrens - Wailing Caverns',1,-740.059,-2214.23,16.1374,5.68,0),
(228,'The Barrens - Wailing Caverns',43,-163.49,132.9,-73.66,5.83,2001),
(242,'Razorfen Kraul Instance Start',1,-4464.92,-1666.24,90,0,0),
(244,'Razorfen Kraul Entrance',47,1943,1544.63,82,1.38,168),
(257,'Blackfathom Deeps Entrance',48,-151.89,106.96,-39.87,4.53,1011),
(259,'Blackfathom Deeps Instance Start',1,4247.74,745.879,-24.5299,4.5828,0),
(286,'Uldaman Entrance',70,-226.8,49.09,-46.03,1.39,2008),
(288,'Uldaman Instance Start',0,-6066.73,-2955.63,209.776,3.20443,0),
(322,'Gnomeregan Instance Start',0,-5163.33,927.623,257.188,0,0),
(324,'Gnomeregan Entrance',90,-332.22,-2.28,-150.86,2.77,168),
(442,'Razorfen Downs Entrance',129,2592.55,1107.5,51.29,4.74,2006),
(444,'Razorfen Downs Instance Start',1,-4658.12,-2526.35,81.492,1.25978,0),
(446,'Altar of Atal\'Hakkar Entrance',109,-319.24,99.9,-131.85,3.19,2010),
(448,'Altar Of Atal\'Hakkar Instance Start',0,-10175.1,-3995.15,-112.9,2.95938,0),
(503,'Stockades Instance',0,-8764.83,846.075,87.4842,3.77934,0),
(523,'Gnomeregan Train Depot Entrance',90,-736.51,2.71,-249.99,3.14,1011),
(525,'Gnomeregan Train Depot Instance',0,-4858.27,756.435,244.923,0,0),
(527,'Teddrassil - Ruth Theran',1,8786.36,967.445,30.197,3.39632,0),
(542,'Teddrassil - Darnassus',1,9945.13,2616.89,1316.46,4.61446,0),
(602,'Scarlet Monastery - Graveyard (Exit)',0,2913.92,-802.404,160.333,3.50405,0),
(604,'Scarlet Monastery - Cathedral (Exit)',0,2906.14,-813.772,160.333,1.95739,0),
(606,'Scarlet Monastery - Armory (Exit)',0,2884.45,-822.01,160.333,1.95268,0),
(608,'Scarlet Monastery - Library (Exit)',0,2870.9,-820.164,160.333,0.387856,0),
(610,'Scarlet Monastery - Cathedral (Entrance)',189,855.683,1321.5,18.6709,0.001747,2007),
(612,'Scarlet Monastery - Armory (Entrance)',189,1610.83,-323.433,18.6738,6.28022,2006),
(614,'Scarlet Monastery - Library (Entrance)',189,255.346,-209.09,18.6773,6.26656,2005),
(702,'Stormwind - Wizard Sanctum Room',0,-9015.97,875.318,148.617,0,0),
(704,'Stormwind - Wizard Sanctum Tower Portal',0,-9019.16,887.596,29.6206,0,0),
(882,'Uldaman Instance End',0,-6620.48,-3765.19,266.226,3.13531,0),
(902,'Uldaman Exit',70,-214.02,383.607,-38.7687,0.5,2008),
(922,'Zul\'Farrak Instance Start',1,-6796.49,-2890.77,8.88063,3.30496,0),
(924,'Zul\'Farrak Entrance',209,1213.52,841.59,8.93,6.09,2009),
(943,'Leap of Faith - End of fall',1,-5187.47,-2804.32,-8.375,5.76,0),
(1064,'Onyxia\'s Lair - Dustwallow Instance',1,-4747.17,-3753.27,49.8122,0.713271,0),
(1466,'Blackrock Mountain - Searing Gorge Instance?',230,458.32,26.52,-70.67,4.95,2011),
(1468,'Blackrock Spire - Searing Gorge Instance (Inside)',229,78.5083,-225.044,49.839,5.1,2012),
(1470,'Blackrock Spire - Searing Gorge Instance',0,-7524.19,-1230.13,285.743,2.09544,0),
(1472,'Blackrock Dephts - Searing Gorge Instance',0,-7179.63,-923.667,166.416,1.84097,0),
(2068,'Blackrock Spire - Fall out',0,-7524.19,-1230.13,285.743,2.09544,0),
(2166,'Deeprun Tram - Ironforge Instance (Inside)',0,-4838.95,-1318.46,501.868,1.42372,0),
(2171,'Deeprun Tram - Stormwind Instance (Inside)',0,-8364.57,535.981,91.7969,2.24619,0),
(2173,'Deeprun Tram - Stormwind Instance',369,68.3006,2490.91,-4.29647,3.12192,0),
(2175,'Deeprun Tram - Ironforge Instance',369,69.2542,10.257,-4.29664,3.09832,0),
(2214,'Stratholme - Eastern Plaguelands Instance',329,3593.15,-3646.56,138.5,5.33,2013),
(2216,'Stratholme - Eastern Plaguelands Instance',329,3395.09,-3380.25,142.702,0.1,2013),
(2217,'Stratholme - Eastern Plaguelands Instance',329,3395.09,-3380.25,142.702,0.1,2013),
(2221,'Stratholme - Eastern Plaguelands Instance (Inside)',0,3235.46,-4050.6,108.45,1.93522,0),
(2226,'Ragefire Chasm - Ogrimmar Instance (Inside)',1,1813.49,-4418.58,-18.57,1.78,0),
(2230,'Ragefire Chasm - Ogrimmar Instance',389,3.81,-14.82,-17.84,4.39,2000),
(2527,'Hall of Legends - Ogrimmar',450,221.322,74.4933,25.7195,0.484836,2031),
(2530,'Hall of Legends - Ogrimmar (Inside)',1,1637.32,-4242.7,56.1827,4.1927,0),
(2532,'Stormwind - Champions Hall',449,-0.299116,4.39156,-0.255884,1.54805,2032),
(2534,'Stormwind (Inside) - Champions Hall',0,-8762.45,403.062,103.902,5.34463,0),
(2567,'Scholomance Entrance',289,196.37,127.05,134.91,6.09,2013),
(2568,'Scholomance Instance',0,1275.05,-2552.03,90.3994,3.6631,0),
(2606,'Alterac Valley - Horde Exit',0,534.868,-1087.68,106.119,3.35758,0),
(2608,'Alterac Valley - Alliance Exit',0,98.432,-182.274,127.52,5.02654,0),
(2848,'Onyxia\'s Lair Entrance',249,29.1607,-71.3372,-8.18032,4.58,2016),
(2886,'The Molten Bridge',409,1096,-467,-104.6,3.64,2014),
(2890,'Molten Core Entrance, Inside',0,-7506.95,-1040.91,180.91,3.35,2011),
(3126,'Maraudon',1,-1186.98,2875.95,85.7258,1.78443,0),
(3131,'Maraudon',1,-1471.07,2618.57,76.1944,0,0),
(3133,'Maraudon',349,1019.69,-458.31,-43.43,0.31,179),
(3134,'Maraudon',349,752.91,-616.53,-33.11,1.37,179),
(3183,'Dire Maul',429,44.4499,-154.822,-2.71201,0,2013),
(3184,'Dire Maul',429,-201.11,-328.66,-2.72,5.22,2013),
(3185,'Dire Maul',429,9.31119,-837.085,-32.5305,0,2013),
(3186,'Dire Maul',429,-62.9658,159.867,-3.46206,3.14788,2013),
(3187,'Dire Maul',429,31.5609,159.45,-3.4777,0.01,2013),
(3189,'Dire Maul',429,255.249,-16.0561,-2.58737,4.7,2013),
(3190,'Dire Maul',1,-3831.79,1250.23,160.223,0,0),
(3191,'Dire Maul',1,-3747.96,1249.18,160.217,3.15827,0),
(3193,'Dire Maul',1,-3520.65,1077.72,161.138,1.5009,0),
(3194,'Dire Maul',1,-3737.48,934.975,160.973,3.13864,0),
(3195,'Dire Maul',1,-3980.58,776.193,161.006,0,0),
(3196,'Dire Maul',1,-4030.21,127.966,26.8109,0,0),
(3197,'Dire Maul',1,-3577.67,841.859,134.594,0,0),
(3528,'The Molten Core Window Entrance',409,1096,-467,-104.6,3.64,2017),
(3529,'The Molten Core Window(Lava) Entrance',409,1096,-467,-104.6,3.64,2017),
(3726,'Blackwing Lair - Blackrock Mountain - Eastern Kingdoms',469,-7666.23,-1102.79,399.68,0.601256,2018),
(3728,'Blackrock Spire, Unknown',0,-7524.19,-1230.13,285.743,2.09544,1125),
(3928,'Zul\'Gurub Entrance',309,-11916.1,-1230.53,92.5334,4.71867,2014),
(3930,'Zul\'Gurub Exit',0,-11916.3,-1208.37,92.2868,1.61792,0),
(3948,'Arathi Basin Alliance Out',0,-1198,-2533,22,0,0),
(3949,'Arathi Basin Horde Out',0,-817,-3509,73,0,0),
(4006,'Ruins Of Ahn\'Qiraj (Inside)',1,-8418.5,1505.94,31.8232,0,0),
(4008,'Ruins Of Ahn\'Qiraj (Outside)',509,-8429.74,1512.14,31.9074,2.58,2014),
(4010,'Ahn\'Qiraj Temple (Outside)',531,-8231.33,2010.6,129.861,0,2014),
(4012,'Ahn\'Qiraj Temple (Inside)',1,-8242.67,1992.06,129.072,0,0),
(4055,'Naxxramas (Exit)',533,3005.87,-3435.01,293.882,0,0),
(4156,'Naxxramas (Entrance)',533,3498.28,-5349.9,144.968,1.31324,0);
/*!40000 ALTER TABLE `areatrigger_teleport` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-24 22:25:05
