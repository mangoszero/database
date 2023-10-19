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
    SET @cOldContent = '025';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '04';
    SET @cNewContent = '026';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'spell_script_target_Startup';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fix_spell_script_target_startup_Errors: -- GameObject 176210 ("Command Tent") is a dummy for now';

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

DELETE FROM `spell_script_target` WHERE `targetEntry`=176210 AND `type`=0 AND `entry` IN (
7082,9372,10451,16068,16069,16070,16074,16364,16365,16404,16426,16743,17272,
18971,18973,18997,19033,20001,21391,21795,21867,21934,22205,22987,23016,23031,
23845,24343,25186,25473,26075,26479,26879,27583,27894,28032,28054,28056,28078,
28083,28087,28116,28117,28138,28250,28281,28326,28353,28365,28366,28367,28992,
29280,29281,29282,29283,29285,29287,29336,29726,29727,29945,30676,32061);

-- GameObject 176210 ("Command Tent") is a dummy for now
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (7082,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (9372,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (10451,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (16068,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (16069,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (16070,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (16074,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (16364,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (16365,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (16404,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (16426,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (16743,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (17272,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (18971,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (18973,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (18997,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (19033,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (20001,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (21391,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (21795,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (21867,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (21934,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (22205,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (22987,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (23016,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (23031,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (23845,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (24343,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (25186,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (25473,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (26075,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (26479,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (26879,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (27583,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (27894,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28032,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28054,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28056,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28078,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28083,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28087,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28116,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28117,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28138,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28250,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28281,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28326,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28353,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28365,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28366,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28367,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (28992,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29280,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29281,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29282,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29283,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29285,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29287,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29336,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29726,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29727,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (29945,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (30676,0,176210,0);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES (32061,0,176210,0);


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


