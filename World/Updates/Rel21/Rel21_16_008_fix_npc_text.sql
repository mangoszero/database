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
    SET @cOldStructure = '16'; 
    SET @cOldContent = '007';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '16';
    SET @cNewContent = '008';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'fix_npc_text_definition_update';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'fix_npc_text_definition_update';

    -- Evaluate all settings
    SET @cCurResult := (SELECT description FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cOldResult := (SELECT description FROM db_version WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

UPDATE npc_text SET em0_0_delay = 0 WHERE em0_0_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em0_0_delay em0_0_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em0_0 = 0 WHERE em0_0 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em0_0 em0_0 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em0_1_delay = 0 WHERE em0_1_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em0_1_delay em0_1_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em0_1 = 0 WHERE em0_1 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em0_1 em0_1 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em0_2_delay = 0 WHERE em0_2_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em0_2_delay em0_2_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em0_2 = 0 WHERE em0_2 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em0_2 em0_2 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';


UPDATE npc_text SET em1_0_delay = 0 WHERE em1_0_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em1_0_delay em1_0_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em1_0 = 0 WHERE em1_0 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em1_0 em1_0 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em1_1_delay = 0 WHERE em1_1_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em1_1_delay em1_1_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em1_1 = 0 WHERE em1_1 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em1_1 em1_1 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em1_2_delay = 0 WHERE em1_2_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em1_2_delay em1_2_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em1_2 = 0 WHERE em1_2 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em1_2 em1_2 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';


UPDATE npc_text SET em2_0_delay = 0 WHERE em2_0_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em2_0_delay em2_0_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em2_0 = 0 WHERE em2_0 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em2_0 em2_0 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em2_1_delay = 0 WHERE em2_1_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em2_1_delay em2_1_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em2_1 = 0 WHERE em2_1 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em2_1 em2_1 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em2_2_delay = 0 WHERE em2_2_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em2_2_delay em2_2_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em2_2 = 0 WHERE em2_2 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em2_2 em2_2 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';


UPDATE npc_text SET em3_0_delay = 0 WHERE em3_0_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em3_0_delay em3_0_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em3_0 = 0 WHERE em3_0 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em3_0 em3_0 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em3_1_delay = 0 WHERE em3_1_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em3_1_delay em3_1_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em3_1 = 0 WHERE em3_1 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em3_1 em3_1 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em3_2_delay = 0 WHERE em3_2_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em3_2_delay em3_2_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em3_2 = 0 WHERE em3_2 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em3_2 em3_2 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';


UPDATE npc_text SET em4_0_delay = 0 WHERE em4_0_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em4_0_delay em4_0_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em4_0 = 0 WHERE em4_0 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em4_0 em4_0 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em4_1_delay = 0 WHERE em4_1_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em4_1_delay em4_1_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em4_1 = 0 WHERE em4_1 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em4_1 em4_1 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em4_2_delay = 0 WHERE em4_2_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em4_2_delay em4_2_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em4_2 = 0 WHERE em4_2 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em4_2 em4_2 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';


UPDATE npc_text SET em5_0_delay = 0 WHERE em5_0_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em5_0_delay em5_0_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em5_0 = 0 WHERE em5_0 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em5_0 em5_0 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em5_1_delay = 0 WHERE em5_1_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em5_1_delay em5_1_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em5_1 = 0 WHERE em5_1 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em5_1 em5_1 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em5_2_delay = 0 WHERE em5_2_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em5_2_delay em5_2_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em5_2 = 0 WHERE em5_2 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em5_2 em5_2 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';


UPDATE npc_text SET em6_0_delay = 0 WHERE em6_0_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em6_0_delay em6_0_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em6_0 = 0 WHERE em6_0 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em6_0 em6_0 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em6_1_delay = 0 WHERE em6_1_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em6_1_delay em6_1_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em6_1 = 0 WHERE em6_1 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em6_1 em6_1 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em6_2_delay = 0 WHERE em6_2_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em6_2_delay em6_2_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em6_2 = 0 WHERE em6_2 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em6_2 em6_2 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';


UPDATE npc_text SET em7_0_delay = 0 WHERE em7_0_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em7_0_delay em7_0_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em7_0 = 0 WHERE em7_0 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em7_0 em7_0 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em7_1_delay = 0 WHERE em7_1_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em7_1_delay em7_1_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em7_1 = 0 WHERE em7_1 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em7_1 em7_1 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em7_2_delay = 0 WHERE em7_2_delay IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em7_2_delay em7_2_delay SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

UPDATE npc_text SET em7_2 = 0 WHERE em7_2 IS NULL;
ALTER TABLE npc_text CHANGE COLUMN em7_2 em7_2 SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0';

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
            SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

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

