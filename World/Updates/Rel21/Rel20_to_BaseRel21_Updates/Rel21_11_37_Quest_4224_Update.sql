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
    SET @cOldContent = '36';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '37';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Quest_4224_Update';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Quest_4224_Update';

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

    -- Moved to DB gossip menu/gossip menus options used in quest 4224 (The True Masters) by NPC 9563 (Ragged John)

SET @CONDITION := 871;

DELETE FROM conditions WHERE condition_entry=@CONDITION;
INSERT INTO conditions VALUES
(@CONDITION, 9, 4224, 0);

DELETE FROM gossip_menu WHERE entry BETWEEN 2050 AND 2060;
INSERT INTO gossip_menu VALUES
(2050, 2725, 205001, 0),
(2051, 2723, 0, 0),
(2052, 2722, 0, 0),
(2053, 2721, 0, 0),
(2054, 2720, 0, 0),
(2055, 2719, 0, 0),
(2056, 2718, 0, 0),
(2057, 2717, 0, 0),
(2058, 2716, 0, 0),
(2059, 2715, 0, 0),
(2060, 2714, 0, 0);

DELETE FROM gossip_menu_option WHERE menu_id BETWEEN 2050 AND 2061;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(2061, 0, 0, 'Official business, John. I need some information about Marshal Windsor. Tell me about the last time you saw him', 1, 1, 2060, 0, 0, 0, 0, '', @CONDITION),
(2060, 0, 0, 'So what did you do?', 1, 1, 2059, 0, 0, 0, 0, '', 0),
(2059, 0, 0, 'Start making sense, dwarf. I don\'t want to have anything to do with your cracker, your pappy, or any sort of \'discreditin\'.', 1, 1, 2058, 0, 0, 0, 0, '', 0),
(2058, 0, 0, 'Ironfoe?', 1, 1, 2057, 0, 0, 0, 0, '', 0),
(2057, 0, 0, 'Interesting... continue, John.', 1, 1, 2056, 0, 0, 0, 0, '', 0),
(2056, 0, 0, 'So that\'s how Windsor died...', 1, 1, 2055, 0, 0, 0, 0, '', 0),
(2055, 0, 0, 'So how did he die?', 1, 1, 2054, 0, 0, 0, 0, '', 0),
(2054, 0, 0, 'Ok, so where the hell is he? Wait a minute! Are you drunk?', 1, 1, 2053, 0, 0, 0, 0, '', 0),
(2053, 0, 0, 'WHY is he in Blackrock Depths?', 1, 1, 2052, 0, 0, 0, 0, '', 0),
(2052, 0, 0, '300? So the Dark Irons killed him and dragged him into the Depths?', 1, 1, 2051, 0, 0, 0, 0, '', 0),
(2051, 0, 0, 'Ahh... Ironfoe.', 1, 1, 2050, 0, 0, 0, 0, '', 0),
(2050, 0, 0, 'Thanks, Ragged John. Your story was very uplifting and informative.', 1, 1, -1, 0, 0, 0, 0, '', 0);

DELETE FROM db_scripts WHERE id=205001 AND script_type=2;
INSERT INTO `db_scripts` (script_type,id,delay,command,datalong,datalong2,buddy_entry,search_radius,data_flags,dataint,dataint2,dataint3,dataint4,X,Y,z,o,comments) VALUES
(2, 205001, 0, 7, 4224, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

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

