-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update (v1.4)
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT structure FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurContent := (SELECT content FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '22'; 
    SET @cOldStructure = '01'; 
    SET @cOldContent = '002';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '01'; -- If The Update contains any 'ALTER DATABASE' statements, increment this and set cNewContent to 001
    SET @cNewContent = '003';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'CopperOre TirisfalGlades Fix';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Adding a lot of missing Copper Ore nodes (116)';

    -- Evaluate all settings
    SET @cCurResult := (SELECT description FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cOldResult := (SELECT description FROM db_version WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;

        -- UPDATE THE DB VERSION
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
        SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

		SET @go_guid:= (SELECT MAX(guid) FROM gameobject);
		SET @pt_guid:= (SELECT MAX(entry) FROM pool_template);
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+1,3,'Tirisfal Glades - Copper Ore - Pool 1');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+2,4,'Tirisfal Glades - Copper Ore - Pool 2');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+3,9,'Tirisfal Glades - Copper Ore - Pool 3');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+4,5,'Tirisfal Glades - Copper Ore - Pool 4');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+5,14,'Tirisfal Glades - Copper Ore - Pool 5');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+6,10,'Tirisfal Glades - Copper Ore - Pool 6');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+7,4,'Tirisfal Glades - Copper Ore - Pool 7');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+8,10,'Tirisfal Glades - Copper Ore - Pool 8');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+9,4,'Tirisfal Glades - Copper Ore - Pool 9');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+10,20,'Tirisfal Glades - Copper Ore - Pool 10');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+11,6,'Tirisfal Glades - Copper Ore - Pool 11');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+12,11,'Tirisfal Glades - Copper Ore - Pool 12');
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@pt_guid+13,6,'Tirisfal Glades - Copper Ore - Pool 13');

		-- Pool 1 (4 pool entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
		(@go_guid+1,1731,0,2117.61,1212.14,47.1468,0,0,0,0.65176,-0.758425,1800,100,1),
		(@go_guid+2,1731,0,2228.93,1285.16,48.6022,0,0,0,0.198076,-0.980187,1800,100,1),
		(@go_guid+3,1731,0,2246.21,1330.14,36.7445,0,0,0,0.0658231,-0.997831,1800,100,1),
		(@go_guid+4,1731,0,2248.99,1520.44,50.8533,0,0,0,0.98858,-0.150697,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+1,@pt_guid+1,0,'Tirisfal Glades - Copper Ore - Pool 1 - Entry #1'),
		(@go_guid+2,@pt_guid+1,0,'Tirisfal Glades - Copper Ore - Pool 1 - Entry #2'),
		(@go_guid+3,@pt_guid+1,0,'Tirisfal Glades - Copper Ore - Pool 1 - Entry #2'),
		(@go_guid+4,@pt_guid+1,0,'Tirisfal Glades - Copper Ore - Pool 1 - Entry #4');

		-- Pool 2 (5 pool entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+5,1731,0,2413.7,1470.21,39.4824,0,0,0,0.0959738,-0.995384,1800,100,1),
		(@go_guid+6,1731,0,2491.23,1485.2,7.18662,0,0,0,0.997106,0.0760228,1800,100,1),
		(@go_guid+7,1731,0,2464.13,1645.12,20.3032,0,0,0,0.914732,-0.404061,1800,100,1),
		(@go_guid+8,1731,0,2555.33,1687.74,6.99163,0,0,0,0.738364,0.674402,1800,100,1),
		(@go_guid+9,1731,0,2424.67,1754.3,34.5784,0,0,0,0.995967,0.0897217,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+5,@pt_guid+2,0,'Tirisfal Glades - Copper Ore - Pool 2 - Entry #1'),
		(@go_guid+6,@pt_guid+2,0,'Tirisfal Glades - Copper Ore - Pool 2 - Entry #2'),
		(@go_guid+7,@pt_guid+2,0,'Tirisfal Glades - Copper Ore - Pool 2 - Entry #3'),
		(@go_guid+8,@pt_guid+2,0,'Tirisfal Glades - Copper Ore - Pool 2 - Entry #4'),
		(@go_guid+9,@pt_guid+2,0,'Tirisfal Glades - Copper Ore - Pool 2 - Entry #5');

		-- Pool 3 (11 pool entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+10,1731,0,2623.07,1451.19,5.36734,0,0,0,0.868583,-0.495544,1800,100,1),
		(@go_guid+11,1731,0,2644.7,1352.96,6.36807,0,0,0,0.214213,-0.976787,1800,100,1),
		(@go_guid+12,1731,0,2708.58,1338.33,39.7302,0,0,0,0.996753,-0.0805239,1800,100,1),
		(@go_guid+13,1731,0,2734.97,1410.58,4.61187,0,0,0,0.23717,-0.971468,1800,100,1),
		(@go_guid+14,1731,0,2716.07,1261.77,44.7325,0,0,0,0.99638,0.0850149,1800,100,1),
		(@go_guid+15,1731,0,2656.53,1194.28,74.8843,0,0,0,0.716551,0.697534,1800,100,1),
		(@go_guid+16,1731,0,2672.34,1072.18,116.119,0,0,0,0.999985,-0.00557198,1800,100,1),
		(@go_guid+17,1731,0,2674.31,1064.91,118.488,0,0,0,0.99808,0.0619309,1800,100,1),
		(@go_guid+18,1731,0,2758.26,1076.28,110.109,0,0,0,0.853418,-0.521227,1800,100,1),
		(@go_guid+19,1731,0,2888.72,1104.63,115.012,0,0,0,0.860502,-0.509447,1800,100,1),
		(@go_guid+20,1731,0,2966.74,1131.14,83.4966,0,0,0,0.97335,-0.229326,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+10,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #1'),
		(@go_guid+11,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #2'),
		(@go_guid+12,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #3'),
		(@go_guid+13,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #4'),
		(@go_guid+14,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #5'),
		(@go_guid+15,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #6'),
		(@go_guid+16,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #7'),
		(@go_guid+17,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #8'),
		(@go_guid+18,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #9'),
		(@go_guid+19,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #10'),
		(@go_guid+20,@pt_guid+3,0,'Tirisfal Glades - Copper Ore - Pool 3 - Emtry #11');

		-- Pool 4 (6 pool entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+21,1731,0,3002.69,896.044,103.064,0,0,0,0.651296,0.758824,1800,100,1),
		(@go_guid+22,1731,0,3020.34,792.264,86.1429,0,0,0,0.868472,0.495738,1800,100,1),
		(@go_guid+23,1731,0,3019.29,704.501,99.6637,0,0,0,0.995478,-0.0949886,1800,100,1),
		(@go_guid+24,1731,0,3038.99,619.462,97.8708,0,0,0,0.801864,0.597506,1800,100,1),
		(@go_guid+25,1731,0,3062.28,463.578,8.42335,0,0,0,0.573309,-0.819339,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+21,@pt_guid+4,0,'Tirisfal Glades - Copper Ore - Pool 4 - Entry #1'),
		(@go_guid+22,@pt_guid+4,0,'Tirisfal Glades - Copper Ore - Pool 4 - Entry #2'),
		(@go_guid+23,@pt_guid+4,0,'Tirisfal Glades - Copper Ore - Pool 4 - Entry #3'),
		(@go_guid+24,@pt_guid+4,0,'Tirisfal Glades - Copper Ore - Pool 4 - Entry #4'),
		(@go_guid+25,@pt_guid+4,0,'Tirisfal Glades - Copper Ore - Pool 4 - Entry #5');
		-- 55019 previous existing node --
		DELETE FROM `pool_gameobject` WHERE `guid` = 55019;
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES (55019,@pt_guid+4,0,'Copper Ore - Pool 4 - Entry #6');

		-- Pool 5 (17 pool entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+26,1731,0,3025.26,155.146,10.6816,0,0,0,0.310232,0.950661,1800,100,1),
		(@go_guid+27,1731,0,2915.37,319.127,24.7399,0,0,0,0.577165,-0.816627,1800,100,1),
		(@go_guid+28,1731,0,2956.35,411.315,38.4654,0,0,0,0.784764,-0.619794,1800,100,1),
		(@go_guid+29,1731,0,2926.62,448.328,38.0339,0,0,0,0.902597,-0.430487,1800,100,1),
		(@go_guid+30,1731,0,2615.07,567.123,20.9818,0,0,0,0.981673,-0.190574,1800,100,1),
		(@go_guid+31,1731,0,2575.88,638.221,31.6361,0,0,0,0.983282,-0.182089,1800,100,1),
		(@go_guid+32,1731,0,2483.95,584.074,32.7491,0,0,0,0.521584,0.8532,1800,100,1),
		(@go_guid+33,1731,0,2471.25,471.3,43.3989,0,0,0,0.950902,-0.309492,1800,100,1),
		(@go_guid+34,1731,0,2516.68,431.999,28.2431,0,0,0,0.646077,-0.763272,1800,100,1),
		(@go_guid+35,1731,0,2442.78,270.068,29.0606,0,0,0,0.927779,0.37313,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+26,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #1'),
		(@go_guid+27,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #2'),
		(@go_guid+28,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #3'),
		(@go_guid+29,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #4'),
		(@go_guid+30,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #5'),
		(@go_guid+31,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #6'),
		(@go_guid+32,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #7'),
		(@go_guid+33,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #8'),
		(@go_guid+34,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #9'),
		(@go_guid+35,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #10');

		-- 55008 previous existing node --
		-- 55010 previous existing node --
		-- 55011 previous existing node --
		-- 55014 previous existing node --
		-- 55017 previous existing node --
		-- 55013 previous existing node --
		-- 55009 previous existing node --
		DELETE FROM `pool_gameobject` WHERE `guid` IN (55008,55010,55011,55014,55017,55013,55009);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(55008,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #11'),
		(55010,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #12'),
		(55011,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #13'),
		(55014,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #14'),
		(55017,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #15'),
		(55013,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #16'),
		(55009,@pt_guid+5,0,'Tirisfal Glades - Copper Ore - Pool 5 - Entry #17');

		-- Pool 6 (12 pool entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+36,1731,0,2203.25,545.166,38.5178,0,0,0,0.453573,-0.891219,25,100,1),
		(@go_guid+37,1731,0,2219.26,615.911,26.5034,0,0,0,0.981789,0.189976,1800,100,1),
		(@go_guid+38,1731,0,2402.76,575.06,39.3755,0,0,0,0.934926,0.354843,1800,100,1),
		(@go_guid+39,1731,0,2473.01,754.915,55.5685,0,0,0,0.999292,0.0376171,1800,100,1),
		(@go_guid+40,1731,0,2475.24,748.608,59.5999,0,0,0,0.992398,-0.12307,1800,100,1),
		(@go_guid+41,1731,0,2505.33,742.876,120.394,0,0,0,0.993353,0.115106,1800,100,1),
		(@go_guid+42,1731,0,2372.72,805.544,47.5157,0,0,0,0.887563,-0.460686,1800,100,1),
		(@go_guid+43,1731,0,2408.75,846.221,61.1394,0,0,0,0.97819,0.207711,1800,100,1),
		(@go_guid+44,1731,0,2451.71,837.415,84.9076,0,0,0,0.985723,0.168375,1800,100,1),
		(@go_guid+45,1731,0,2520.89,832.503,102.855,0,0,0,0.0658526,-0.997829,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+36,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #1'),
		(@go_guid+37,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #2'),
		(@go_guid+38,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #3'),
		(@go_guid+39,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #4'),
		(@go_guid+40,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #5'),
		(@go_guid+41,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #6'),
		(@go_guid+42,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #7'),
		(@go_guid+43,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #8'),
		(@go_guid+44,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #9'),
		(@go_guid+45,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #10');

		-- 55016 previous existing node --
		-- 55018 previous existing node --
		DELETE FROM `pool_gameobject` WHERE `guid` IN (55016,55018);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(55016,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #11'),
		(55018,@pt_guid+6,0,'Tirisfal Glades - Copper Ore - Pool 6 - Entry #12');

		-- Pool 7 (5 pool entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+46,1731,0,2656.1,805.766,112.806,0,0,0,0.355374,0.934724,1800,100,1),
		(@go_guid+47,1731,0,2782.69,759.721,123.837,0,0,0,0.803019,0.595954,1800,100,1),
		(@go_guid+48,1731,0,2806.41,742.378,138.8,0,0,0,0.497091,-0.867698,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+46,@pt_guid+7,0,'Tirisfal Glades - Copper Ore - Pool 7 - Entry #1'),
		(@go_guid+47,@pt_guid+7,0,'Tirisfal Glades - Copper Ore - Pool 7 - Entry #2'),
		(@go_guid+48,@pt_guid+7,0,'Tirisfal Glades - Copper Ore - Pool 7 - Entry #3');

		-- 55015 previous existing node --
		-- 55012 previous existing node --
		DELETE FROM `pool_gameobject` WHERE `guid` IN (55015,55012);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(55015,@pt_guid+7,0,'Tirisfal Glades - Copper Ore - Pool 7 - Entry #4'),
		(55012,@pt_guid+7,0,'Tirisfal Glades - Copper Ore - Pool 7 - Entry #5');

		-- Pool 8 (13 pool entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+49,1731,0,1846.05,773.903,32.1986,0,0,0,0.156891,0.987616,1800,100,1),
		(@go_guid+50,1731,0,1704.15,769.587,69.2222,0,0,0,0.125654,-0.992074,1800,100,1),
		(@go_guid+51,1731,0,1724.92,809.83,70.5267,0,0,0,0.327191,-0.944958,1800,100,1),
		(@go_guid+52,1731,0,1732.64,895.906,61.3271,0,0,0,0.813881,0.581032,1800,100,1),
		(@go_guid+53,1731,0,1792.18,882.436,32.9864,0,0,0,0.109809,0.993953,1800,100,1),
		(@go_guid+54,1731,0,1731.85,991.255,56.9477,0,0,0,0.353403,-0.935471,1800,100,1),
		(@go_guid+55,1731,0,1887.99,982.354,29.5875,0,0,0,0.995443,-0.0953573,1800,100,1),
		(@go_guid+56,1731,0,1886.93,975.042,27.6812,0,0,0,0.984205,-0.177031,1800,100,1),
		(@go_guid+57,1731,0,1906.11,1077.33,28.9321,0,0,0,0.799872,-0.600171,1800,100,1),
		(@go_guid+58,1731,0,1843.64,1131.52,32.0953,0,0,0,0.2261,-0.974104,1800,100,1),
		(@go_guid+59,1731,0,1746.81,1162.9,74.0332,0,0,0,0.424982,-0.905202,1800,100,1),
		(@go_guid+60,1731,0,1731.15,1117.68,82.1689,0,0,0,0.0326671,0.999466,1800,100,1),
		(@go_guid+61,1731,0,1732.26,1112.21,80.8562,0,0,0,0.162947,-0.986635,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+49,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #1'),
		(@go_guid+50,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #2'),
		(@go_guid+51,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #3'),
		(@go_guid+52,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #4'),
		(@go_guid+53,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #5'),
		(@go_guid+54,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #6'),
		(@go_guid+55,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #7'),
		(@go_guid+56,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #8'),
		(@go_guid+57,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #9'),
		(@go_guid+58,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #10'),
		(@go_guid+59,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #11'),
		(@go_guid+60,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #12'),
		(@go_guid+61,@pt_guid+8,0,'Tirisfal Glades - Copper Ore - Pool 8 - Entry #13');

		-- Pool 9 (5 entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+62,1731,0,2190.43,-63.2282,35.9805,0,0,0,0.829003,-0.559245,1800,100,1),
		(@go_guid+63,1731,0,2474.5,54.7162,14.0829,0,0,0,0.794769,0.606913,1800,100,1),
		(@go_guid+64,1731,0,2509.1,-68.4834,30.5456,0,0,0,0.961949,0.273229,1800,100,1),
		(@go_guid+65,1731,0,2596.79,-95.367,26.5279,0,0,0,0.873317,0.487153,1800,100,1),
		(@go_guid+66,1731,0,2555.83,-116.956,30.381,0,0,0,0.44321,0.896418,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+62,@pt_guid+9,0,'Tirisfal Glades - Copper Ore - Pool 9 - Entry #1'),
		(@go_guid+63,@pt_guid+9,0,'Tirisfal Glades - Copper Ore - Pool 9 - Entry #2'),
		(@go_guid+64,@pt_guid+9,0,'Tirisfal Glades - Copper Ore - Pool 9 - Entry #3'),
		(@go_guid+65,@pt_guid+9,0,'Tirisfal Glades - Copper Ore - Pool 9 - Entry #4'),
		(@go_guid+66,@pt_guid+9,0,'Tirisfal Glades - Copper Ore - Pool 9 - Entry #5');

		-- Pool 10 (24 entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+67,1731,0,2586.27,-305.702,69.8045,0,0,0,0.76631,0.642472,1800,100,1),
		(@go_guid+68,1731,0,2508.06,-373.549,83.5047,0,0,0,0.996531,0.0832247,1800,100,1),
		(@go_guid+69,1731,0,2471.14,-473.14,78.6911,0,0,0,0.816635,0.577155,1800,100,1),
		(@go_guid+70,1731,0,2523.15,-584.422,83.9081,0,0,0,0.320094,-0.947386,1800,100,1),
		(@go_guid+71,1731,0,2607.96,-499.559,96.2493,0,0,0,0.672928,-0.739708,1800,100,1),
		(@go_guid+72,1731,0,2746.64,-381.677,84.6157,0,0,0,0.0772257,0.997014,1800,100,1),
		(@go_guid+73,1731,0,2715.85,-541.814,106.345,0,0,0,0.982015,0.188806,1800,100,1),
		(@go_guid+74,1731,0,2636.24,-656.939,109.704,0,0,0,0.345275,-0.938501,1800,100,1),
		(@go_guid+75,1731,0,2592.27,-671.541,82.3038,0,0,0,0.999558,0.0297245,1800,100,1),
		(@go_guid+76,1731,0,2583.06,-671.094,80.9095,0,0,0,0.481999,-0.876172,1800,100,1),
		(@go_guid+77,1731,0,2674.48,-771.65,86.5594,0,0,0,0.962318,-0.271928,1800,100,1),
		(@go_guid+78,1731,0,2699.09,-848.409,84.1667,0,0,0,0.969333,-0.245752,1800,100,1),
		(@go_guid+79,1731,0,2782.72,-829.569,155.911,0,0,0,0.976233,-0.216721,1800,100,1),
		(@go_guid+80,1731,0,2892.07,-713.135,144.329,0,0,0,0.651023,0.759058,1800,100,1),
		(@go_guid+81,1731,0,2861.49,-494.596,100.32,0,0,0,0.555667,0.831405,1800,100,1),
		(@go_guid+82,1731,0,2857.7,-499.864,105.175,0,0,0,0.617334,0.786701,1800,100,1),
		(@go_guid+83,1731,0,2848.75,-460.001,80.5454,0,0,0,0.531612,0.846988,1800,100,1),
		(@go_guid+84,1731,0,2898.83,-399.681,85.1083,0,0,0,0.495847,-0.86841,1800,100,1),
		(@go_guid+85,1731,0,2884.98,-323.556,60.3524,0,0,0,0.896613,0.442815,1800,100,1),
		(@go_guid+86,1731,0,2970.41,-346.714,24.301,0,0,0,0.482035,0.876152,1800,100,1),
		(@go_guid+87,1731,0,3044.7,-437.222,5.14143,0,0,0,0.294361,0.955694,1800,100,1),
		(@go_guid+88,1731,0,2982.19,-473.49,84.8282,0,0,0,0.387507,0.921867,1800,100,1),
		(@go_guid+89,1731,0,2967.17,-519.511,112.573,0,0,0,0.366775,0.93031,1800,100,1),
		(@go_guid+90,1731,0,2979.09,-568.756,120.815,0,0,0,0.597998,0.801498,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+67,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #1'),
		(@go_guid+68,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #2'),
		(@go_guid+69,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #3'),
		(@go_guid+70,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #4'),
		(@go_guid+71,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #5'),
		(@go_guid+72,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #6'),
		(@go_guid+73,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #7'),
		(@go_guid+74,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #8'),
		(@go_guid+75,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #9'),
		(@go_guid+76,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #10'),
		(@go_guid+77,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #11'),
		(@go_guid+78,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #12'),
		(@go_guid+79,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #13'),
		(@go_guid+80,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #14'),
		(@go_guid+81,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #15'),
		(@go_guid+82,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #16'),
		(@go_guid+83,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #17'),
		(@go_guid+84,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #18'),
		(@go_guid+85,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #19'),
		(@go_guid+86,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #20'),
		(@go_guid+87,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #21'),
		(@go_guid+88,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #22'),
		(@go_guid+89,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #23'),
		(@go_guid+90,@pt_guid+10,0,'Tirisfal Glades - Copper Ore - Pool 10 - Entry #24');

		-- Pool 11 (7 entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+91,1731,0,2377.47,-423.692,72.7209,0,0,0,0.584238,0.811582,1800,100,1),
		(@go_guid+92,1731,0,2375.59,-631.358,68.0833,0,0,0,0.759712,0.65026,1800,100,1),
		(@go_guid+93,1731,0,2249.64,-634.664,83.8773,0,0,0,0.447935,-0.894066,1800,100,1),
		(@go_guid+94,1731,0,2156.68,-812.348,86.9953,0,0,0,0.0503571,0.998731,1800,100,1),
		(@go_guid+95,1731,0,2105.27,-830.041,112.035,0,0,0,0.965454,-0.260573,1800,100,1),
		(@go_guid+96,1731,0,2162.83,-888.33,88.7472,0,0,0,0.139236,-0.990259,1800,100,1),
		(@go_guid+97,1731,0,2285.54,-1083.24,82.7087,0,0,0,0.038588,0.999255,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+91,@pt_guid+11,0,'Tirisfal Glades - Copper Ore - Pool 11 - Entry #1'),
		(@go_guid+92,@pt_guid+11,0,'Tirisfal Glades - Copper Ore - Pool 11 - Entry #2'),
		(@go_guid+93,@pt_guid+11,0,'Tirisfal Glades - Copper Ore - Pool 11 - Entry #3'),
		(@go_guid+94,@pt_guid+11,0,'Tirisfal Glades - Copper Ore - Pool 11 - Entry #4'),
		(@go_guid+95,@pt_guid+11,0,'Tirisfal Glades - Copper Ore - Pool 11 - Entry #5'),
		(@go_guid+96,@pt_guid+11,0,'Tirisfal Glades - Copper Ore - Pool 11 - Entry #6'),
		(@go_guid+97,@pt_guid+11,0,'Tirisfal Glades - Copper Ore - Pool 11 - Entry #7');

		-- Pool 12 (13 entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+98,1731,0,2225.54,-328.573,69.0414,0,0,0,0.755755,0.654855,1800,100,1),
		(@go_guid+99,1731,0,2230.49,-333.667,77.1404,0,0,0,0.906797,0.421568,1800,100,1),
		(@go_guid+100,1731,0,2139.22,-318.787,61.3864,0,0,0,0.771582,0.63613,1800,100,1),
		(@go_guid+101,1731,0,2130.22,-321.49,76.5074,0,0,0,0.631002,0.775781,1800,100,1),
		(@go_guid+102,1731,0,2099.22,-319.025,50.7188,0,0,0,0.958505,0.285076,1800,100,1),
		(@go_guid+103,1731,0,2087.06,-422.231,45.3643,0,0,0,0.975733,0.218965,1800,100,1),
		(@go_guid+104,1731,0,2137.26,-458.404,77.8811,0,0,0,0.49813,0.867103,1800,100,1),
		(@go_guid+105,1731,0,2195.75,-500.518,85.4636,0,0,0,0.984926,0.172974,1800,100,1),
		(@go_guid+106,1731,0,2104.15,-587.399,64.8141,0,0,0,0.992297,-0.123884,1800,100,1),
		(@go_guid+107,1731,0,2117.3,-662.068,79.4757,0,0,0,0.515354,-0.856977,1800,100,1),
		(@go_guid+108,1731,0,2018.63,-626.719,65.9468,0,0,0,0.71244,0.701733,1800,100,1),
		(@go_guid+109,1731,0,1891.28,-681.61,50.6175,0,0,0,0.75792,0.652347,1800,100,1),
		(@go_guid+110,1731,0,1779.82,-747.61,65.0404,0,0,0,0.670766,0.741669,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+98,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #1'),
		(@go_guid+99,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #2'),
		(@go_guid+100,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #3'),
		(@go_guid+101,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #4'),
		(@go_guid+102,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #5'),
		(@go_guid+103,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #6'),
		(@go_guid+104,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #7'),
		(@go_guid+105,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #8'),
		(@go_guid+106,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #9'),
		(@go_guid+107,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #10'),
		(@go_guid+108,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #11'),
		(@go_guid+109,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #12'),
		(@go_guid+110,@pt_guid+12,0,'Tirisfal Glades - Copper Ore - Pool 12 - Entry #13');

		-- Pool 13 (7 entries) --
		INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
		(@go_guid+111,1731,0,1634.66,-685.405,47.0466,0,0,0,0.0360153,-0.999351,1800,100,1),
		(@go_guid+112,1731,0,1572.56,-687.115,56.8445,0,0,0,0.623178,0.78208,1800,100,1),
		(@go_guid+113,1731,0,1617.98,-557.151,58.0527,0,0,0,0.217111,0.976147,1800,100,1),
		(@go_guid+114,1731,0,1588.48,-373.687,62.8941,0,0,0,0.0250589,0.999686,1800,100,1),
		(@go_guid+115,1731,0,1660.36,-279.92,54.2251,0,0,0,0.333085,-0.942897,1800,100,1),
		(@go_guid+116,1731,0,1779.22,-283.885,43.7887,0,0,0,0.333086,-0.942896,1800,100,1),
		(@go_guid+117,1731,0,1816.97,-141.627,50.4391,0,0,0,0.49911,-0.866539,1800,100,1);
		INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES 
		(@go_guid+111,@pt_guid+13,0,'Tirisfal Glades - Copper Ore - Pool 13 - Entry #1'),
		(@go_guid+112,@pt_guid+13,0,'Tirisfal Glades - Copper Ore - Pool 13 - Entry #2'),
		(@go_guid+113,@pt_guid+13,0,'Tirisfal Glades - Copper Ore - Pool 13 - Entry #3'),
		(@go_guid+114,@pt_guid+13,0,'Tirisfal Glades - Copper Ore - Pool 13 - Entry #4'),
		(@go_guid+115,@pt_guid+13,0,'Tirisfal Glades - Copper Ore - Pool 13 - Entry #5'),
		(@go_guid+116,@pt_guid+13,0,'Tirisfal Glades - Copper Ore - Pool 13 - Entry #6'),
		(@go_guid+117,@pt_guid+13,0,'Tirisfal Glades - Copper Ore - Pool 13 - Entry #7');


        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL ABOVE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

        -- If we get here ok, commit the changes
        IF bRollback = TRUE THEN
            ROLLBACK;
            SHOW ERRORS;
            SELECT '* UPDATE FAILED *' AS `===== Status =====`,@cCurResult AS `===== DB is on Version: =====`;
        ELSE
            COMMIT;
            SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,@cNewResult AS `===== DB is now on Version =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cCurResult AS `===== DB is already on Version =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
		IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
		ELSE
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                END IF;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;

