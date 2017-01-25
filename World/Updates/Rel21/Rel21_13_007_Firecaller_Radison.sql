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
    SET @cOldStructure = '13'; 
    SET @cOldContent = '006';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '13';
    SET @cNewContent = '007';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Firecaller_Radison ';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Firecaller_Radison ';

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

    -- Firecaller Radison
-- drop
DELETE FROM creature_loot_template WHERE entry = 2192;
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id) VALUES
(2192,414,5,0,1,1,0),
(2192,785,0.3,0,1,1,0),
(2192,818,0.19,0,1,1,0),
(2192,858,2.8169,0,1,1,0),
(2192,954,0.3,0,1,1,0),
(2192,955,0.29,0,1,1,0),
(2192,1179,2.8169,0,1,1,0),
(2192,1206,0.3,0,1,1,0),
(2192,1210,0.3,0,1,1,0),
(2192,1738,0.2,0,1,1,0),
(2192,1743,0.03,0,1,1,0),
(2192,1766,0.03,0,1,1,0),
(2192,1768,0.16,0,1,1,0),
(2192,1769,0.19,0,1,1,0),
(2192,1770,0.19,0,1,1,0),
(2192,1787,0.3,0,1,1,0),
(2192,1794,0.16,0,1,1,0),
(2192,1812,0.16,0,1,1,0),
(2192,1813,0.4,0,1,1,0),
(2192,1814,0.19,0,1,1,0),
(2192,1816,0.3,0,1,1,0),
(2192,2287,6.338,0,1,1,0),
(2192,2447,0.3,0,1,1,0),
(2192,2453,0.3,0,1,1,0),
(2192,2455,0.7042,0,1,1,0),
(2192,2589,20,0,1,3,0),
(2192,2592,19,0,1,2,0),
(2192,2698,0.1,0,1,1,0),
(2192,2781,0.16,0,1,1,0),
(2192,3012,0.3,0,1,1,0),
(2192,3193,0.3,0,1,1,0),
(2192,3376,0.19,0,1,1,0),
(2192,4575,0.03,0,1,1,0),
(2192,5503,0.1,0,1,1,0),
(2192,6348,0.3,0,1,1,0),
(2192,6536,4,0,1,1,0),
(2192,6538,3,0,1,1,0),
(2192,6540,4,0,1,1,0),
(2192,6545,4,0,1,1,0),
(2192,6552,5,0,1,1,0),
(2192,6553,5,0,1,1,0),
(2192,6562,1.7,0,1,1,0),
(2192,6563,2,0,1,1,0),
(2192,6564,3,0,1,1,0),
(2192,6565,0.8,0,1,1,0),
(2192,6570,0.6,0,1,1,0),
(2192,6574,0.5,0,1,1,0),
(2192,6575,1.9,0,1,1,0),
(2192,6576,0.5,0,1,1,0),
(2192,6581,3,0,1,1,0),
(2192,6582,0.5,0,1,1,0),
(2192,6583,1.9,0,1,1,0),
(2192,6585,2,0,1,1,0),
(2192,9766,1.8,0,1,1,0),
(2192,9767,3,0,1,1,0),
(2192,9768,4,0,1,1,0),
(2192,9770,4,0,1,1,0),
(2192,9771,2,0,1,1,0),
(2192,9772,0.3,0,1,1,0),
(2192,9775,4,0,1,1,0),
(2192,9776,3,0,1,1,0),
(2192,9777,4,0,1,1,0),
(2192,9779,5,0,1,1,0),
(2192,9780,2,0,1,1,0),
(2192,9781,0.5,0,1,1,0),
(2192,9783,2,0,1,1,0),
(2192,9784,4,0,1,1,0),
(2192,9787,4,0,1,1,0),
(2192,9788,4,0,1,1,0),
(2192,9789,4,0,1,1,0),
(2192,9812,1.3,0,1,1,0),
(2192,10287,0.9,0,1,1,0),
(2192,10405,0.7042,0,1,1,0),
(2192,10407,3.9,0,1,1,0),
(2192,14367,0.19,0,1,1,0),
(2192,15498,0.03,0,1,1,0),
(2192,24060,1,1,-24060,1,0),
(2192,24062,1,1,-24062,1,0),
(2192,24064,1,1,-24064,1,0),
(2192,24066,0.5,1,-24066,1,0),
(2192,24070,5,1,-24070,1,0),
(2192,24078,1,1,-24078,1,0);

    

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

