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
    SET @cOldStructure = '17'; 
    SET @cOldContent = '001';

    -- New Values
    SET @cNewVersion = '00';
    SET @cNewStructure = '17';
    SET @cNewContent = '002';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'UBRS_models_add';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'UBRS_models_add';

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

    --Blackhand Thug--
UPDATE `creature_template` SET `ModelId2`='10173', `ModelId3`='10174', `ModelId4`='10175' WHERE `Entry`='10762';

--Blackhand Thug models gender fix according to dbc--
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='10174' WHERE `modelid`='10172';
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='10175' WHERE `modelid`='10173';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='10172' WHERE `modelid`='10174';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='10173' WHERE `modelid`='10175';

--Blackhand Dragon Handler--
UPDATE `creature_template` SET `ModelId2`='10177', `ModelId3`='10178', `ModelId4`='10179' WHERE `Entry`='10742';

--Blackhand Dragon Handler models gender fix according to dbc--
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='10178' WHERE `modelid`='10176';
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='10179' WHERE `modelid`='10177';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='10176' WHERE `modelid`='10178';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='10177' WHERE `modelid`='10179';

--Summoned Blackhand Veteran--
UPDATE `creature_template` SET `ModelId2`='9687', `ModelId3`='9896', `ModelId4`='9897' WHERE `Entry`='10681';

--Summoned Blackhand Veteran models gender fix according to dbc--
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='9896' WHERE `modelid`='9686';
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='9897' WHERE `modelid`='9687';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='9686' WHERE `modelid`='9896';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='9687' WHERE `modelid`='9897';

--Summoned Blackhand Dreadweaver--
UPDATE `creature_template` SET `ModelId2`='9671', `ModelId3`='9672', `ModelId4`='9673' WHERE `Entry`='10680';

--Summoned Blackhand Dreadweaver models gender fix according to dbc--
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='0' WHERE `modelid`='9670';
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='0' WHERE `modelid`='9671';
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='0' WHERE `modelid`='9872';
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='0' WHERE `modelid`='9873';

--Blackhand Iron Guard--
UPDATE `creature_template` SET `ModelId2`='9697', `ModelId3`='9894', `ModelId4`='9895' WHERE `Entry`='10319';

--Blackhand Iron Guard models gender fix according to dbc--
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='9894' WHERE `modelid`='9696';
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='9895' WHERE `modelid`='9697';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='9696' WHERE `modelid`='9894';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='9697' WHERE `modelid`='9895';

--Blackhand Assassin--
UPDATE `creature_template` SET `ModelId2`='9887' WHERE `Entry`='10318';

--Blackhand Assassin models gender fix according to dbc--
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='9887' WHERE `modelid`='9691';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='9691' WHERE `modelid`='9887';

--Blackhand Elite--
UPDATE `creature_template` SET `ModelId2`='9735', `ModelId3`='9890', `ModelId4`='9891' WHERE `Entry`='10317';

--Blackhand Elite models gender fix according to dbc--
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='9890' WHERE `modelid`='9734';
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='9891' WHERE `modelid`='9735';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='9734' WHERE `modelid`='9890';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='9735' WHERE `modelid`='9891';

--Blackhand Incarcerator--
UPDATE `creature_template` SET `ModelId2`='9692', `ModelId3`='9892', `ModelId4`='9893' WHERE `Entry`='10316';

--Blackhand Incarcerator models gender fix according to dbc--
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='9892' WHERE `modelid`='9690';
UPDATE `creature_model_info` SET `gender`='0', `modelid_other_gender`='9893' WHERE `modelid`='9692';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='9690' WHERE `modelid`='9892';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='9692' WHERE `modelid`='9893';

--Blackhand Veteran--
UPDATE `creature_template` SET `ModelId2`='9687', `ModelId3`='9896', `ModelId4`='9897' WHERE `Entry`='9819';

--models were changed already--

--Blackhand Summoner--
UPDATE `creature_template` SET `ModelId2`='9850', `ModelId3`='9851', `ModelId4`='9852' WHERE `Entry`='9818';

--Blackhand Summoner models gender fix according to dbc--
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='0' WHERE `modelid`='9849';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='0' WHERE `modelid`='9850';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='0' WHERE `modelid`='9851';
UPDATE `creature_model_info` SET `gender`='1', `modelid_other_gender`='0' WHERE `modelid`='9852';

--Blackhand Dreadweaver--
UPDATE `creature_template` SET `ModelId2`='9671', `ModelId3`='9672', `ModelId4`='9673' WHERE `Entry`='9817';

--models were changed already--


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


