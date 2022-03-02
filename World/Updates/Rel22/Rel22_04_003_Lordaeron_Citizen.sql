-- ----------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update
-- Now compatible with newer MySql Databases (v1.5)
-- ----------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT `structure` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cCurContent := (SELECT `content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '22'; 
    SET @cOldStructure = '04'; 
    SET @cOldContent = '002';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '04';
    SET @cNewContent = '003';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Lordaeron Citizen';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Add missing Lordaeron Citizen';

    -- Evaluate all settings
    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

	UPDATE `creature_template` SET `MinLevelHealth` = 328, `MaxLevelHealth` = 328 WHERE `Entry` = 3617;
	DELETE FROM `creature_template_addon` WHERE `entry` = 3617;
	INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`b2_0_sheath`,`b2_1_flags`,`emote`,`auras`) VALUES
	(3617,0,0,0,0,0,16380);
	DELETE FROM `creature` WHERE `id` = 3617;
	INSERT INTO `creature` (`id`,`map`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
	(3617,0,0,0,1837.95,238.254,60.5144,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1821.23,239.487,60.6478,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1784.68,238.47,60.4086,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1774.19,238.088,60.6982,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1779.74,208.601,60.3128,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1797.38,321.783,70.8146,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1846.19,271.665,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1805.22,291.655,70.3996,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1820.13,250.549,60.0474,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1817.45,225.251,59.528,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1830.29,213.645,60.389,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1836.37,229.404,60.2315,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1768.28,193.266,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1788.09,193.416,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1841.26,196.939,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1819.39,193.334,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1803.13,192.819,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1805.75,210.858,65.3998,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1785.05,210.563,59.7069,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1782.66,226.65,59.3659,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1783.95,251.046,59.5074,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1782.72,267.958,59.6138,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1806.01,254.011,60.6559,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1769.92,285.161,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1794.1,284.269,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1843.58,278.447,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1831.26,282.122,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1816.99,281.063,70.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1806.35,265.815,65.3997,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1819.52,264.184,59.8956,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1829.43,259.207,59.5834,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1823.91,252.862,60.025,0,300,5,0,328,0,0,1),
	(3617,0,0,0,1834.21,249.057,59.8226,0,300,5,0,328,0,0,1);

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
            -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
            -- UPDATE THE DB VERSION
            -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
            INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
            SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

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
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                ELSE
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
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


