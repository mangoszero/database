-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update (v1.4)
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
    SET @cOldStructure = '06'; 
    SET @cOldContent = '001';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '07'; -- If The Update contains any 'ALTER DATABASE' statements, increment this and set cNewContent to 001
    SET @cNewContent = '001';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Update deprecated ROW_FORMAT';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Update deprecated ROW_FORMAT field';

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

-- Character 0
ALTER TABLE ai_playerbot_names ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE bugreport ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE characters ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_action ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_aura ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_battleground_data ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_homebind ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_honor_cp ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_inventory ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_pet ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_queststatus ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_reputation ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_skills ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_social ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_spell ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_ticket ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE character_tutorial ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE corpse ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_respawn ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE gameobject_respawn ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_event_status ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE groups ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE group_member ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE guild ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE guild_member ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE guild_rank ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE item_instance ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE item_loot ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE item_text ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE mail ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE mail_items ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE petition ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE petition_sign ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pet_aura ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pet_spell ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE saved_variables ROW_FORMAT=DYNAMIC ENGINE=INNODB;

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

