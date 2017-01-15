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
    SET @cOldContent = '18'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '19';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'respawn_time_fixes';

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

-- Repair some box refresh time is too short
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45745'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45746'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45747'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45748'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45749'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45740'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45741'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45742'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45743'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '45744'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48265'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48266'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48267'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48268'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48269'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48270'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48271'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48272'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48273'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48274'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48276'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48275'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48277'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48278'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48279'; 
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48280';
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48281';
UPDATE `gameobject` SET spawntimesecs = '7200' WHERE 'guid' = '48282';

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
