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
    SET @cOldContent = '17'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '18';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'loot_table_fixes';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fixed Loot Table for several bosses';

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

-- Overlord Wyrmthalak loot fix
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '100' WHERE 'entry' = '9568' AND 'item' = '12780'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9568' AND 'item' = '13163'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9568' AND 'item' = '22321'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9568' AND 'item' = '13161'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9568' AND 'item' = '13162'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9568' AND 'item' = '16679';
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '-100' WHERE 'entry' = '9568' AND 'item' = '12337';

-- Highlord Omokk loot fixed
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '100' WHERE 'entry' = '9196' AND 'item' = '12534'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '16.67' WHERE 'entry' = '9196' AND 'item' = '13166'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '16.67' WHERE 'entry' = '9196' AND 'item' = '13167'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '16.67' WHERE 'entry' = '9196' AND 'item' = '13168'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '16.67' WHERE 'entry' = '9196' AND 'item' = '13169'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '16.67' WHERE 'entry' = '9196' AND 'item' = '13170';
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '16.67' WHERE 'entry' = '9196' AND 'item' = '16670';

-- War Master Voone loot fixed
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9237' AND 'item' = '12582'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9237' AND 'item' = '13177'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9237' AND 'item' = '13179'; 
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9237' AND 'item' = '16676';
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '20' WHERE 'entry' = '9237' AND 'item' = '22231';

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
