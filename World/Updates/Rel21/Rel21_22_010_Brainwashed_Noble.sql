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
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '22'; 
    SET @cOldContent = '009';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '22';
    SET @cNewContent = '010';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Brainwashed Noble';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Brainwashed Noble';

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

    
-- Brainwashed Noble
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `Entry` = 596;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 596;
INSERT INTO `creature_ai_scripts` VALUES
(59601,596,27,0,100,1,12544,1,15000,30000,11,12544,0,33,0,0,0,0,0,0,0,0,'Brainwashed Noble - Cast Frost Armor on Missing Buff'),
(59602,596,4,0,100,0,0,0,0,0,21,1,0,0,22,1,0,0,0,0,0,0,'Brainwashed Noble - Enable Dynamic Movement and Set Phase 1 on Aggro'),
(59603,596,9,13,100,1,0,40,2100,3400,11,9053,1,0,0,0,0,0,0,0,0,0,'Brainwashed Noble - Cast Fireball (Phase 1)'),
(59604,596,9,13,100,1,9,80,1000,1000,21,1,0,0,0,0,0,0,0,0,0,0,'Brainwashed Noble - Enable Dynamic Movement at 9-80 Yards (Phase 1)'),
(59605,596,9,0,100,1,0,8,1000,1000,21,0,0,0,0,0,0,0,0,0,0,0,'Brainwashed Noble - Disable Dynamic Movement at 0-8 Yards'),
(59606,596,3,13,100,0,7,0,0,0,21,0,0,0,22,2,0,0,0,0,0,0,'Brainwashed Noble - Disable Dynamic Movement and Set Phase 2 at 7% MP (Phase 1)'),
(59607,596,3,11,100,1,100,15,1000,1000,22,1,0,0,0,0,0,0,0,0,0,0,'Brainwashed Noble - Set Phase 1 at 15% MP (Phase 2)'),
(59608,596,0,0,80,1,18000,25000,25000,35000,11,228,1,0,0,0,0,0,0,0,0,0,'Brainwashed Noble - Cast Polymorph: Chicken'),
(59609,596,2,0,100,1,50,0,35000,35000,11,512,1,0,0,0,0,0,0,0,0,0,'Brainwashed Noble - Cast Chains of Ice at 50% HP'),
(59610,596,2,0,100,0,15,0,0,0,21,0,0,0,22,3,0,0,0,0,0,0,'Brainwashed Noble - Disable Dynamic Movement and Set Phase 3 at 15% HP'),
(59611,596,2,7,100,0,15,0,0,0,25,0,0,0,1,-47,0,0,0,0,0,0,'Brainwashed Noble - Flee at 15% HP (Phase 3)'),
(59612,596,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Brainwashed Noble - Set Phase to 0 on Evade');

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


