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
    SET @cOldContent = '028';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '14';
    SET @cNewContent = '029';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'DeadCreaturesStandStateOnAggro';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'DeadCreaturesStandStateOnAggro';

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

-- Update AI of creatures that have bytes1 animation as dead so that they have standing animation in combat
-- Set AI to EventAI
UPDATE
	`creature_template`
SET
	`AIName` = 'EventAI'
WHERE
	`Entry` IN (2097, 3920, 4510, 5908, 6391, 6516, 7643, 12418, 14757);
DELETE
FROM
	`creature_ai_scripts`
WHERE
	`creature_id` IN (2097, 3920, 4510, 5908, 6391, 6516, 7643, 12418, 14757);
-- Add on aggro event
INSERT INTO
	`creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_chance`, `action1_type`, `comment`)
VALUES
	(209701, 2097, 4, 100, 47, 'Harlo Barnaby: set UnitStandStateType to UNIT_STAND_STATE_STAND'),
	(392001, 3920, 4, 100, 47, 'Anilia: set UnitStandStateType to UNIT_STAND_STATE_STAND'),
	(451001, 4510, 4, 100, 47, 'Heralath Fallowbrook: set UnitStandStateType to UNIT_STAND_STATE_STAND'),
	(590801, 5908, 4, 100, 47, 'Grunt Dogran: set UnitStandStateType to UNIT_STAND_STATE_STAND'),
	(639101, 6391, 4, 100, 47, 'Holdout Warrior: set UnitStandStateType to UNIT_STAND_STATE_STAND'),
	(651601, 6516, 4, 100, 47, 'Un''Goro Thunderer: set UnitStandStateType to UNIT_STAND_STATE_STAND'),
	(764301, 7643, 4, 100, 47, 'Bengor: set UnitStandStateType to UNIT_STAND_STATE_STAND'),
	(1241801, 12418, 4, 100, 47, 'Gordok Hyena: set UnitStandStateType to UNIT_STAND_STATE_STAND'),
	(1475701, 14757, 4, 100, 47, 'Elder Torntusk: set UnitStandStateType to UNIT_STAND_STATE_STAND');
-- Add previous scripts
INSERT INTO
	`creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `comment`)
VALUES
	(392002, 3920, 2, 100, 0, 15, 0, 0, 0, 25, 0, 0, 0, 1, -47, 'Anilia: flee at 15% HP'),
	(639102, 6391, 9, 100, 1, 0, 5, 7000, 10000, 11, 11976, 1, 0, 0, 0, 'Holdout Warrior: cast Strike'),
	(639103, 6391, 13, 100, 1, 11000, 15000, 0, 0, 11, 12555, 1, 1, 0, 0, 'Holdout Warrior: cast Pummel on Target Spell Casting'),
	(639104, 6391, 8, 100, 0, 9798, -1, 0, 0, 1, -31, 0, 0, 0, 0, 'Holdout Warrior: emote on Radiation Spellhit'),
	(639105, 6391, 2, 100, 0, 15, 0, 0, 0, 25, 0, 0, 0, 1, -47, 'Holdout Warrior: flee at 15% HP'),
	(651602, 6516, 0, 100, 1, 5000, 5000, 9000, 15000, 11, 12553, 1, 0, 0, 0, 'Un''Goro Thunderer: cast Shock'),
	(1241802, 12418, 9, 100, 1, 0, 5, 17000, 21000, 11, 13445, 1, 0, 0, 0, 'Gordok Hyena: cast Rend');
	

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
