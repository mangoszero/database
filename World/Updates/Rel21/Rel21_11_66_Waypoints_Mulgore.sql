-- ----------------------------------------
-- Added to prevent timeout's while loading
-- ----------------------------------------
SET GLOBAL net_read_timeout=30;
SET GLOBAL net_write_timeout=60;
SET GLOBAL net_buffer_length=1000000; 
SET GLOBAL max_allowed_packet=1000000000;
SET GLOBAL connect_timeout=10000000;

-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update (v1.3)
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
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '11'; 
    SET @cOldContent = '65';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '66';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Waypoints_Mulgore';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Adds missing waypoints for certain creatures in Mulgore';

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





-- todo: Mazzranache
-- todo: Thunderhorn Water Well kodos

-- Ghost Howl
UPDATE
	creature
SET
	position_x = -758.331,
	position_y = 132.167,
	position_z = 2.77833
WHERE
	guid = 51845;
DELETE
FROM
	creature_movement_template
WHERE
	entry = 3056;
INSERT INTO
	creature_movement_template(`entry`, `point`, `position_x`, `position_y`, `position_z`)
VALUES
	(3056, 1, -758.331, 132.167, 2.77833),
	(3056, 2, -779.039, 138.003, -3.39281),
	(3056, 3, -801.73, 140.724, -8.18451),
	(3056, 4, -817.906, 137.464, -10.6107),
	(3056, 5, -830.672, 150.509, -10.049),
	(3056, 6, -824.121, 172.511, -10.2011),
	(3056, 7, -824.765, 186.873, -9.98871),
	(3056, 8, -831.983, 206.749, -9.48999),
	(3056, 9, -844.891, 227.419, -3.09247),
	(3056, 10, -857.643, 244.088, 8.02225),
	(3056, 11, -872.992, 266.185, 19.1681),
	(3056, 12, -882.134, 276.547, 22.0825),
	(3056, 13, -889.801, 296.096, 23.3952),
	(3056, 14, -902.935, 328.538, 23.2227),
	(3056, 15, -911.667, 347.622, 22.7623),
	(3056, 16, -920.617, 366.61, 17.7281),
	(3056, 17, -929.676, 385.545, 15.6721),
	(3056, 18, -939.391, 404.154, 17.81),
	(3056, 19, -952.278, 430.415, 22.445),
	(3056, 20, -962.798, 448.574, 27.8895),
	(3056, 21, -974.157, 466.224, 33.3872),
	(3056, 22, -986.256, 481.866, 36.9113),
	(3056, 23, -1009.33, 498.011, 39.3174),
	(3056, 24, -1028.78, 505.895, 38.9738),
	(3056, 25, -1050.18, 512.74, 37.6667),
	(3056, 26, -1067.73, 514.1, 36.464),
	(3056, 27, -1088.43, 510.596, 33.6737),
	(3056, 28, -1109.12, 506.993, 31.1725),
	(3056, 29, -1136.63, 501.823, 24.1533),
	(3056, 30, -1156.81, 493.641, 17.2383),
	(3056, 31, -1171.16, 480.67, 11.4534),
	(3056, 32, -1185.96, 465.781, 6.86526),
	(3056, 33, -1207.32, 447.693, 5.38923),
	(3056, 34, -1218, 433.971, 4.80097),
	(3056, 35, -1233.59, 412.767, 3.49479),
	(3056, 36, -1231.27, 384.682, -1.09937),
	(3056, 37, -1215.84, 369.726, -1.82196),
	(3056, 38, -1195.58, 360.879, 4.17312),
	(3056, 39, -1176.72, 351.738, 10.6938),
	(3056, 40, -1156.65, 345.599, 15.7258),
	(3056, 41, -1130.64, 342.17, 22.5894),
	(3056, 42, -1102.56, 342.3, 31.5151),
	(3056, 43, -1080.75, 344.271, 37.1855),
	(3056, 44, -1064.6, 353.161, 35.4317),
	(3056, 45, -1040.97, 368.182, 32.0226),
	(3056, 46, -1023.56, 379.915, 27.8226),
	(3056, 47, -1006.35, 391.956, 24.1773),
	(3056, 48, -988.706, 402.576, 20.7179),
	(3056, 49, -969.884, 398.737, 17.4093),
	(3056, 50, -954.82, 383.869, 18.1765),
	(3056, 51, -940.533, 364.391, 19.0925),
	(3056, 52, -930.116, 346.158, 23.0264),
	(3056, 53, -914.62, 322.843, 27.8011),
	(3056, 54, -907.517, 307.24, 28.4644),
	(3056, 55, -899.405, 286.196, 28.6649),
	(3056, 56, -883.98, 262.895, 23.5318),
	(3056, 57, -875.789, 248.851, 16.681),
	(3056, 58, -872.647, 221.03, 3.03563),
	(3056, 59, -869.937, 200.206, -4.58467),
	(3056, 60, -865.188, 175.769, -11.7553),
	(3056, 61, -856.971, 158.444, -10.8236),
	(3056, 62, -840.617, 142.701, -10.2134),
	(3056, 63, -819.318, 131.755, -10.5982),
	(3056, 64, -794.494, 124.538, -8.37794),
	(3056, 65, -769.619, 126.573, -4.2534),
	(3056, 66, -751.691, 122.151, 0.485237),
	(3056, 67, -727.577, 116.422, 5.93297),
	(3056, 68, -701.034, 114.986, 7.78627);
UPDATE
	creature_template
SET
	MovementType = 2
WHERE
	entry = 3056;
UPDATE
	creature
SET
	MovementType = 2
WHERE
	guid = 51845;

-- Palemane Rock Kodo Matriarch
DELETE
FROM
	creature_movement
WHERE
	id = 26213;
INSERT INTO
	creature_movement(`id`, `point`, `position_x`, `position_y`, `position_z`)
VALUES
	(26213, 1, -2545.07, 21.1902, 11.8055),
	(26213, 2, -2487.88, 100.192, 33.7867),
	(26213, 3, -2420.56, 88.3994, 38.0405),
	(26213, 4, -2319, 115.247, 50.7186),
	(26213, 5, -2284.75, 27.0455, 22.493),
	(26213, 6, -2349.13, -61.5067, -8.76367);
UPDATE
	creature
SET
	MovementType = 2
WHERE
	guid = 26213;
DELETE
FROM
	creature_linking
WHERE
	guid IN
	(
		26185,
		26186,
		26187,
		26207
	);
INSERT INTO
	creature_linking(`guid`, `master_guid`, `flag`)
VALUES
	(26185, 26213, 515),
	(26186, 26213, 515),
	(26187, 26213, 515),
	(26207, 26213, 515);

-- Golden Plains Kodo Matriarch
DELETE
FROM
	creature_movement
WHERE
	id = 26233;
INSERT INTO
	creature_movement(`id`, `point`, `position_x`, `position_y`, `position_z`)
VALUES
	(26233, 1, -1317.95, -926.415, 1.9346),
	(26233, 2, -1244.69, -980.33, -4.92039),
	(26233, 3, -1193.67, -948.34, -3.64333),
	(26233, 4, -1182.62, -859.417, -11.059),
	(26233, 5, -1183.54, -796.476, -36.5517),
	(26233, 6, -1182.81, -740.117, -52.755),
	(26233, 7, -1200.2, -605.367, -57.7549),
	(26233, 8, -1242.38, -494.067, -57.6106),
	(26233, 9, -1468.88, -522.602, -55.4965),
	(26233, 10, -1551.13, -656.098, -50.8176),
	(26233, 11, -1394.68, -802.561, -21.88),
	(26233, 12, -1317.95, -926.415, 1.9346);
UPDATE
	creature
SET
	MovementType = 2
WHERE
	guid = 26233;
DELETE
FROM
	creature_linking
WHERE
	guid IN
	(
		26192,
		26193,
		26194,
		26195
	);
INSERT INTO
	creature_linking(`guid`, `master_guid`, `flag`)
VALUES
	(26192, 26233, 515),
	(26193, 26233, 515),
	(26194, 26233, 515),
	(26195, 26233, 515);
  
  
  
  
 
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

SELECT * FROM db_version
