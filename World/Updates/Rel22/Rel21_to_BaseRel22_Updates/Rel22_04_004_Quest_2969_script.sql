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
    SET @cOldContent = '003';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '04';
    SET @cNewContent = '004';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Quest 2969 script';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Quest 2969 script';

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

	-- Update Captured Sprite Darter stats.
	UPDATE `creature` SET `spawntimesecs` = 30 WHERE id = 7997;
	UPDATE `creature_template` SET `SpeedWalk` = 1.6534, `SpeedRun` = 1.84286 WHERE `Entry` = 7997;

	-- Start GO script on use.
	DELETE FROM `db_scripts` WHERE `id` = 50029;
	INSERT INTO `db_scripts` (`script_type`,`id`,`delay`,`command`,`datalong`,`datalong2`,`buddy_entry`,`search_radius`,`data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`,`x`,`y`,`z`,`o`,`comments`) VALUES
	(6,50029,23,7,2969,0,0,0,0,0,0,0,0,0,0,0,0,'Quest 2969 Complete'),
	(6,50029,0,3,0,0,7997,50062,16,0,0,0,0,-4514.793,753.3322,60.4589,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50063,16,0,0,0,0,-4516.7895,756.357,60.3792,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50064,16,0,0,0,0,-4515.7895,754.357,60.3792,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50065,16,0,0,0,0,-4515.6352,756.6066,60.3453,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50066,16,0,0,0,0,-4517.2333,755.2796,60.39724,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50067,16,0,0,0,0,-4517.081,750.508,60.4589,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50068,16,0,0,0,0,-4556.0273,786.2335,48.379509,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50069,16,0,0,0,0,-4554.9843,784.9313,48.302906,0,'Move - Captured Sprite Darter'), 
	(6,50029,0,3,0,0,7997,50070,16,0,0,0,0,-4626.6254,831.622,57.140984,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50071,16,0,0,0,0,-4523.5468,831.250061,57.499138,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50072,16,0,0,0,0,-4521.779,829.74,57.519093,0,'Move - Captured Sprite Darter'),
	(6,50029,0,3,0,0,7997,50073,16,0,0,0,0,-4523.5468,832.250061,57.499138,0,'Move - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50062,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50063,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50064,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50065,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50066,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50067,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50068,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50069,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50070,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50071,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50072,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter'),
	(6,50029,23,18,5,0,7997,50073,16,0,0,0,0,0,0,0,0,'Despawn - Captured Sprite Darter');

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


