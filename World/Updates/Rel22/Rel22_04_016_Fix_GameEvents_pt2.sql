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
    SET @cOldContent = '015';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '04';
    SET @cNewContent = '017';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Fix GameEvents pt2';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fix GameEvents pt2';

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

UPDATE `game_event` SET start_time='2022-06-20 21:00:00', end_time='2037-12-31 22:59:59' WHERE entry=1;
UPDATE `game_event` SET start_time='2022-12-14 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=2;
UPDATE `game_event` SET start_time='2022-02-08 21:00:00', end_time='2037-12-31 04:59:59' WHERE entry=3;
UPDATE `game_event` SET start_time='2022-02-08 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=4;
UPDATE `game_event` SET start_time='2022-01-07 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=5;
UPDATE `game_event` SET start_time='2022-02-27 00:00:00', end_time='2037-12-31 22:59:59' WHERE entry=6;
UPDATE `game_event` SET start_time='2022-01-21 06:00:00', end_time='2037-02-04 05:59:59' WHERE entry=7;
UPDATE `game_event` SET start_time='2022-02-10 22:00:00', end_time='2037-12-31 22:59:59' WHERE entry=8;
UPDATE `game_event` SET start_time='2022-04-16 21:00:00', end_time='2037-12-31 22:59:59' WHERE entry=9;
UPDATE `game_event` SET start_time='2023-05-01 21:00:00', end_time='2037-12-31 22:59:59' WHERE entry=10;
UPDATE `game_event` SET start_time='2022-10-18 21:00:00', end_time='2037-12-31 22:59:59' WHERE entry=12;
UPDATE `game_event` SET start_time='0000-00-00 00:00:00', end_time='2037-12-31 22:59:59' WHERE entry=13;
UPDATE `game_event` SET start_time='2022-01-02 05:00:00', end_time='2037-12-31 22:59:59' WHERE entry=14;
UPDATE `game_event` SET start_time='2022-01-01 11:00:00', end_time='2037-12-31 22:59:59' WHERE entry=15;
UPDATE `game_event` SET start_time='2022-12-31 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=16;
UPDATE `game_event` SET start_time='0000-00-00 00:00:00', end_time='0000-00-00 00:00:00' WHERE entry=17;
UPDATE `game_event` SET start_time='2022-01-19 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=18;
UPDATE `game_event` SET start_time='2022-01-26 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=19;
UPDATE `game_event` SET start_time='2022-01-05 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=20;
UPDATE `game_event` SET start_time='2022-12-25 16:00:00', end_time='2037-12-31 16:00:00' WHERE entry=21;
UPDATE `game_event` SET start_time='0000-00-00 00:00:00', end_time='0000-00-00 00:00:00' WHERE entry=22;
UPDATE `game_event` SET start_time='2022-02-05 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=23;
UPDATE `game_event` SET start_time='2022-10-18 20:01:07', end_time='2037-12-31 22:59:59', occurence=525600 WHERE entry=24;
UPDATE `game_event` SET start_time='2022-10-18 19:30:00', end_time='2037-12-31 22:59:59', occurence=525600 WHERE entry=25;
UPDATE `game_event` SET start_time='2022-01-01 19:00:00', end_time='2037-12-31 22:59:59' WHERE entry=27;
UPDATE `game_event` SET start_time='2022-01-23 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=29;
UPDATE `game_event` SET start_time='2022-01-06 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=30;
UPDATE `game_event` SET start_time='2022-01-20 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=31;
UPDATE `game_event` SET start_time='2022-01-04 23:00:00', end_time='2037-12-31 22:59:59' WHERE entry=32;
UPDATE `game_event` SET start_time='2022-10-05 23:00:00', end_time='2037-10-05 23:00:00' WHERE entry=33;
UPDATE `game_event` SET start_time='2022-01-01 06:00:00', end_time='2037-12-31 17:59:59' WHERE entry=34;
UPDATE `game_event` SET start_time='2022-09-23 02:00:00', end_time='2037-12-30 23:00:00' WHERE entry=35;
UPDATE `game_event` SET start_time='2022-03-21 01:00:00', end_time='2037-12-30 23:00:00' WHERE entry=36;
UPDATE `game_event` SET start_time='2022-12-31 23:58:00', end_time='2037-12-30 23:00:00' WHERE entry=61;

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


