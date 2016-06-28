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
    SET @cOldContent = '37';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '38';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Update_Quests_4001_and_4342';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Update_Quests_4001_and_4342';

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

    -- Moved to DB gossip menu/gossip menus options used in quests 4001 (What Is Going On) and 4342 (Kharan's Tale) by NPC 9021 (Kharan Mighthammer)

SET @CONDITION := 1098;
SET @CONDITION_HORDE := 3;
SET @CONDITION_ALLIANCE := 4;

DELETE FROM conditions WHERE condition_entry IN (@CONDITION, @CONDITION + 1);
INSERT INTO conditions VALUES
(@CONDITION, 9, 4001, 0),   -- Horde quest
(@CONDITION + 1, 9, 4342, 0);   -- Alliance quest

DELETE FROM gossip_menu WHERE entry BETWEEN 1823 AND 1830;
INSERT INTO gossip_menu VALUES
(1823, 2482, 182301, @CONDITION_HORDE),
(1823, 2482, 182302, @CONDITION_ALLIANCE),
(1824, 2481, 0, 0),
(1825, 2480, 0, 0),
(1826, 2479, 0, 0),
(1827, 2478, 0, 0),
(1828, 2477, 0, 0),
(1829, 2476, 0, 0),
(1830, 2475, 0, 0);

DELETE FROM gossip_menu_option WHERE menu_id BETWEEN 1822 AND 1830;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(1822, 0, 0, 'I need to know where the princess are, Kharan!', 1, 1, 1830, 0, 0, 0, 0, '', @CONDITION),
(1822, 1, 0, 'All is not lost, Kharan!', 1, 1, 1828, 0, 0, 0, 0, '', @CONDITION + 1),
(1830, 0, 0, 'Gor\'shak is my friend, you can trust me.', 1, 1, 1829, 0, 0, 0, 0, '', 0),
(1829, 0, 0, 'Not enough, you need to tell me more.', 1, 1, 1828, 0, 0, 0, 0, '', 0),
(1828, 0, 0, 'So what happened?', 1, 1, 1827, 0, 0, 0, 0, '', 0),
(1827, 0, 0, 'Continue...', 1, 1, 1826, 0, 0, 0, 0, '', 0),
(1826, 0, 0, 'So you suspect that someone on the inside was involved? That they were tipped off?', 1, 1, 1825, 0, 0, 0, 0, '', 0),
(1825, 0, 0, 'Continue with your story please.', 1, 1, 1824, 0, 0, 0, 0, '', 0),
(1824, 0, 0, 'Indeed.', 1, 1, 1823, 0, 0, 0, 0, '', 0),
(1823, 0, 0, 'The door is open, Kharan. You are a free man.', 1, 1, -1, 0, 0, 0, 0, '', 0);

DELETE FROM dbscripts_on_gossip WHERE id IN (182301, 182302);
INSERT INTO dbscripts_on_gossip VALUES
(182301, 0, 7, 4001, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(182302, 0, 7, 4342, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM script_binding WHERE scriptname = 'npc_kharan_mighthammer';
    

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

