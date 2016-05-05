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
    SET @cOldContent = '11'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '12';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'fix quest 1222';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fix quest 1222 - stinkys escape';

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

/* quest 1222 - Stinky's Escape */

DELETE FROM script_waypoint WHERE entry=4880;
INSERT INTO script_waypoint VALUES
(4880, 0, -2670.221, -3446.189, 34.085, 0, ''),
(4880, 1, -2683.958, -3451.094, 34.707, 0, ''),
(4880, 2, -2703.241, -3454.822, 33.395, 0, ''),
(4880, 3, -2721.615, -3457.408, 33.626, 0, ''),
(4880, 4, -2739.977, -3459.843, 33.329, 0, ''),
(4880, 5, -2756.240, -3460.516, 32.037, 5000, 'SAY_STINKY_FIRST_STOP'),
(4880, 6, -2764.517, -3472.714, 33.750, 0, ''),
(4880, 7, -2773.679, -3482.913, 32.840, 0, ''),
(4880, 8, -2781.394, -3490.613, 32.598, 0, ''),
(4880, 9, -2788.308, -3492.904, 30.761, 0, ''),
(4880, 10, -2794.578, -3489.185, 31.119, 5000, 'SAY_SECOND_STOP'),
(4880, 11, -2789.427, -3498.043, 31.050, 0, ''),
(4880, 12, -2786.968, -3508.168, 31.983, 0, ''),
(4880, 13, -2786.770, -3519.953, 31.079, 0, ''),
(4880, 14, -2789.359, -3525.025, 31.831, 0, ''),
(4880, 15, -2797.950, -3523.693, 31.697, 0, ''),
(4880, 16, -2812.971, -3519.838, 29.864, 0, ''),
(4880, 17, -2818.331, -3521.396, 30.563, 0, ''),
(4880, 18, -2824.771, -3528.728, 32.399, 0, ''),
(4880, 19, -2830.697, -3539.875, 32.505, 0, ''),
(4880, 20, -2836.235, -3549.962, 31.180, 0, ''),
(4880, 21, -2837.576, -3561.052, 30.740, 0, ''),
(4880, 22, -2834.445, -3568.264, 30.751, 0, ''),
(4880, 23, -2827.351, -3569.807, 31.316, 0, ''),
(4880, 24, -2817.380, -3566.961, 30.947, 5000, 'SAY_THIRD_STOP_1'),
(4880, 25, -2817.380, -3566.961, 30.947, 2000, 'SAY_THIRD_STOP_2'),
(4880, 26, -2817.380, -3566.961, 30.947, 0, 'SAY_THIRD_STOP_3'),
(4880, 27, -2818.815, -3579.415, 28.525, 0, ''),
(4880, 28, -2820.205, -3590.640, 30.269, 0, ''),
(4880, 29, -2820.849, -3593.938, 31.150, 3000, ''),
(4880, 30, -2820.849, -3593.938, 31.150, 3000, 'SAY_PLANT_GATHERED'),
(4880, 31, -2834.209, -3592.041, 33.790, 0, ''),
(4880, 32, -2840.306, -3586.207, 36.288, 0, ''),
(4880, 33, -2847.491, -3576.416, 37.660, 0, ''),
(4880, 34, -2855.718, -3565.184, 39.390, 0, ''),
(4880, 35, -2861.785, -3552.902, 41.243, 0, ''),
(4880, 36, -2869.542, -3545.579, 40.701, 0, ''),
(4880, 37, -2877.784, -3538.372, 37.274, 0, ''),
(4880, 38, -2882.677, -3534.165, 34.844, 0, ''),
(4880, 39, -2888.567, -3534.117, 34.298, 4000, 'SAY_STINKY_END'),
(4880, 40, -2888.567, -3534.117, 34.298, 0, '');

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

DROP PROCEDURE IF EXISTS `update_mangos`;
