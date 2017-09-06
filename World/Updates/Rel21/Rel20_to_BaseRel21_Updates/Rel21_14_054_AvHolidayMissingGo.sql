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
    SET @cOldStructure = '14'; 
    SET @cOldContent = '053';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '14';
    SET @cNewContent = '054';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'AvHolidayMissingGo';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'AvHolidayMissingGo';

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


-- Fix gameobjects for event 18 Call to Arms: Alterac Valley!
-- Move existing gameobjects for event 18 Call to Arms: Alterac Valley!
DELETE
FROM
	`gameobject`
WHERE
	`guid` IN (
		250022, 190001,
		250024, 190007,
		250021, 190013,
		250045, 190019,
		250046, 190025,
		250036, 190037,
		250035, 190043,
		250039, 190049,
		250051, 190055,
		250054, 190061,
		250023, 190067,
		250047, 190073,
		250055, 190079,
		250020, 190085,
		250048, 190151,
		250030, 190270,
		250031, 190274,
		250029, 190278,
		250028, 190282,
		250059, 190286,
		250062, 190290,
		250063, 190294,
		250061, 190298,
		250032, 190302,
		250027, 190306,
		250025, 190310,
		250026, 190314
	);
INSERT INTO
	`gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `animprogress`, `state`)
VALUES
	(190001, 180399, 0, -8843.1, 654.157, 97.9823, -2.53073, 180, 255, 1),
	(190007, 180399, 0, -8870.25, 544.276, 107.011, 5.0603, 180, 255, 1),
	(190013, 180399, 0, -8847.29, 594.026, 94.1301, -0.698132, 180, 255, 1),
	(190019, 180399, 0, -4919.66, -844.965, 502.275, -2.40855, 180, 255, 1),
	(190025, 180399, 0, -5034.97, -921.89, 502.476, 6.14817, 180, 255, 1),
	(190037, 180399, 1, 9964.87, 2179.44, 1328.61, 3.7134, 180, 255, 1),
	(190043, 180399, 1, 9984.68, 2348.01, 1331.29, 3.136, 180, 255, 1),
	(190049, 180399, 1, 9720.44, 2545.07, 1336.21, 2.14675, 180, 255, 1),
	(190055, 180399, 0, -4832.84, -1171.19, 502.723, 1.509, 180, 255, 1),
	(190061, 180399, 0, -4675.23, -985.175, 502.526, 1.16136, 180, 255, 1),
	(190067, 180399, 0, -8387.16, 288.082, 121.513, 3.80376, 180, 255, 1),
	(190073, 180399, 1, 9963.4, 2490.17, 1316.5, 3.1401, 180, 255, 1),
	(190079, 180399, 0, -5034.64, -1263.19, 506.017, -2.426, 180, 255, 1),
	(190085, 180399, 0, -8411.21, 577.031, 92.4777, -0.9599, 180, 255, 1),
	(190151, 180399, 1, 9920.2, 2349.05, 1331.37, -1.55334, 180, 255, 1),
	(190270, 180395, 1, -1379.01, -58.6698, 158.927, 3.71842, 180, 255, 1),
	(190274, 180395, 1, -1273.51, 134.157, 132.078, -2.35619, 180, 255, 1),
	(190278, 180395, 1, -1249.68, 52.4457, 127.18, 1.90241, 180, 255, 1),
	(190282, 180395, 1, -1091.78, -20.9857, 140.129, 0.241459, 180, 255, 1),
	(190286, 180395, 0, 1262.51, 353.944, -63.7039, 5.5162, 180, 255, 1),
	(190290, 180395, 0, 1524.65, 242.972, -41.3899, -1.55334, 180, 255, 1),
	(190294, 180395, 0, 1592.72, 168.947, -41.4244, 0, 180, 255, 1),
	(190298, 180395, 0, 1598.8, 311.823, -41.4244, 3.17493, 180, 255, 1),
	(190302, 180395, 1, 1657.46, -4385.4, 23.5797, -1.01229, 180, 255, 1),
	(190306, 180395, 1, 1663.59, -4343.19, 61.2462, 0.750492, 180, 255, 1),
	(190310, 180395, 1, 1934.82, -4711.71, 37.4563, 0.517133, 180, 255, 1),
	(190314, 180395, 1, 1746.33, -3967.47, 49.2634, 2.0013, 180, 255, 1);
-- Delete game_event_gameobject records pointing to nothing because of guid changes
DELETE
FROM
	`game_event_gameobject`
WHERE
	`guid` IN (
		250022,
		250024,
		250021,
		250045,
		250046,
		250036,
		250035,
		250039,
		250051,
		250054,
		250023,
		250047,
		250055,
		250020,
		250048,
		250030,
		250031,
		250029,
		250028,
		250059,
		250062,
		250063,
		250061,
		250032,
		250027,
		250025,
		250026
	);

-- Add missing gameobjects for event 18 Call to Arms: Alterac Valley!
DELETE
FROM
	`gameobject`
WHERE
	`guid` IN (
		190002,
		190008,
		190014,
		190020,
		190026,
		190038,
		190044,
		190050,
		190056,
		190062,
		190068,
		190074,
		190080,
		190086,
		190152,
		190266,
		190318
	);
INSERT INTO
	`gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `animprogress`, `state`)
VALUES
	(190002, 180397, 0, -8842.76, 654.543, 97.2775, -2.47837, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190008, 180397, 0, -8870.4, 544.658, 106.284, -1.22173, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190014, 180397, 0, -8846.94, 593.738, 93.4625, 2.42601, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190020, 180397, 0, -4919.31, -844.615, 501.661, -0.855212, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190026, 180397, 0, -5035.49, -921.804, 501.659, -0.122173, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190038, 180397, 1, 9965.32, 2179.72, 1328.07, -2.54818, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190044, 180397, 1, 9985.22, 2348.01, 1330.79, 0, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190050, 180397, 1, 9720.18, 2545.46, 1335.68, -0.977383, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190056, 180397, 0, -4832.88, -1171.66, 502.195, 1.509, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190062, 180397, 0, -4675.27, -985.681, 501.859, 1.16136, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190068, 180397, 0, -8386.73, 288.405, 120.886, -2.47837, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190074, 180397, 1, 9963.93, 2490.04, 1316.05, 0, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190080, 180397, 0, -5035.03, -1263.47, 505.4, 0.698132, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190086, 180397, 0, -8411.49, 577.444, 91.9777, -0.9599, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	(190152, 180397, 1, 9920.16, 2349.58, 1330.78, 4.7303, 180, 255, 1), -- add PVP HOLIDAY GENERIC SIGNPOST
	
	(190266, 180395, 1, -1383.59, -85.434, 159.566, 3.17021, 180, 255, 1), -- add PVP HOLIDATE HORDE AV
	(190318, 180395, 1, -1051.74, 234.324, 134.494, 0.7054, 180, 255, 1); -- add PVP HOLIDATE HORDE AV

-- Link gameobjects to event
DELETE
FROM
	`game_event_gameobject`
WHERE
	`guid` IN (
		190001,
		190002,
		190007,
		190008,
		190013,
		190014,
		190019,
		190020,
		190025,
		190026,
		190037,
		190038,
		190043,
		190044,
		190049,
		190050,
		190055,
		190056,
		190061,
		190062,
		190067,
		190068,
		190073,
		190074,
		190079,
		190080,
		190085,
		190086,
		190151,
		190152,
		190266,
		190270,
		190274,
		190278,
		190282,
		190286,
		190290,
		190294,
		190298,
		190302,
		190306,
		190310,
		190314,
		190318
	);
INSERT INTO
	`game_event_gameobject` (`guid`, `event`)
VALUES
	(190001, 18),
	(190002, 18),
	(190007, 18),
	(190008, 18),
	(190013, 18),
	(190014, 18),
	(190019, 18),
	(190020, 18),
	(190025, 18),
	(190026, 18),
	(190037, 18),
	(190038, 18),
	(190043, 18),
	(190044, 18),
	(190049, 18),
	(190050, 18),
	(190055, 18),
	(190056, 18),
	(190061, 18),
	(190062, 18),
	(190067, 18),
	(190068, 18),
	(190073, 18),
	(190074, 18),
	(190079, 18),
	(190080, 18),
	(190085, 18),
	(190086, 18),
	(190151, 18),
	(190152, 18),
	(190266, 18),
	(190270, 18),
	(190274, 18),
	(190278, 18),
	(190282, 18),
	(190286, 18),
	(190290, 18),
	(190294, 18),
	(190298, 18),
	(190302, 18),
	(190306, 18),
	(190310, 18),
	(190314, 18),
	(190318, 18);

-- Corrections to z-axis
UPDATE
	`gameobject`
SET
	`position_z` = 501.65
WHERE
	`guid` = 190062;
UPDATE
	`gameobject`
SET
	`position_z` = 505.3
WHERE
	`guid` = 190080;
UPDATE
	`gameobject`
SET
	`position_z` = 37.21
WHERE
	`guid` = 190310;



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
