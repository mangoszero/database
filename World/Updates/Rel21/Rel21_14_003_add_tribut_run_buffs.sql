
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
    SET @cOldContent = '002';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '14';
    SET @cNewContent = '003';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Add Tribut-Run-Buffs';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Add Tribut-Run-Buffs';

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

-- Tribut Run Gossip->Buffs

INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`, `condition_id`)
	VALUES 
		(51002, 0, 0, 'Yeah, you''re a real brainiac. Just how smart do you think you are, Slip''kik?', 1, 1, 14323, 0, 0, 0, '', 0),
		(51003, 0, 0, 'So, now that I''m the king... what have you got for me?!', 1, 1, 14321, 0, 0, 0, '', 0),
		(51004, 0, 0, 'Call me "Boss".  What have you got for me!', 1, 1, 14326, 0, 0, 0, '', 0);

INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `lang0`, `prob0`, `em0_0_delay`, `em0_0`, `em0_1_delay`, `em0_1`, `em0_2_delay`, `em0_2`, `text1_0`, `text1_1`, `lang1`, `prob1`, `em1_0_delay`, `em1_0`, `em1_1_delay`, `em1_1`, `em1_2_delay`, `em1_2`, `text2_0`, `text2_1`, `lang2`, `prob2`, `em2_0_delay`, `em2_0`, `em2_1_delay`, `em2_1`, `em2_2_delay`, `em2_2`, `text3_0`, `text3_1`, `lang3`, `prob3`, `em3_0_delay`, `em3_0`, `em3_1_delay`, `em3_1`, `em3_2_delay`, `em3_2`, `text4_0`, `text4_1`, `lang4`, `prob4`, `em4_0_delay`, `em4_0`, `em4_1_delay`, `em4_1`, `em4_2_delay`, `em4_2`, `text5_0`, `text5_1`, `lang5`, `prob5`, `em5_0_delay`, `em5_0`, `em5_1_delay`, `em5_1`, `em5_2_delay`, `em5_2`, `text6_0`, `text6_1`, `lang6`, `prob6`, `em6_0_delay`, `em6_0`, `em6_1_delay`, `em6_1`, `em6_2_delay`, `em6_2`, `text7_0`, `text7_1`, `lang7`, `prob7`, `em7_0_delay`, `em7_0`, `em7_1_delay`, `em7_1`, `em7_2_delay`, `em7_2`)
	VALUES
		('60000', 'You are da King of the Gordok! You''re A-number-one!', NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL),
		('60001', 'You da man now, dog!', NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL),
		('60002', 'You got me good boss! How you get by Slip''kik?? I smart though. I watch next time! Har har!$B$B Nobody get by Slip''kik no more. Slip''kik promise!', NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`)
	VALUES
		('51004', '60000', '0', '0'),
		('51003', '60001', '0', '0'),
		('51002', '60002', '0', '0');

INSERT INTO `db_scripts` (`script_guid`, `script_type`, `id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`)
	VALUES
		('2668', '2', '510021', '0', '15', '22818', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'cast mol''dar''s moxie'),
		('2669', '2', '510031', '0', '15', '22817', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'cast fengus'' ferocity'),
		('2670', '2', '510041', '0', '15', '22820', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'cast slip''kik''s savvy');

UPDATE `creature_template` SET `GossipMenuId` = '51003' WHERE `creature_template`.`Entry` = 14321;
UPDATE `creature_template` SET `GossipMenuId` = '51004' WHERE `creature_template`.`Entry` = 14326;
UPDATE `creature_template` SET `GossipMenuId` = '51002' WHERE `creature_template`.`Entry` = 14323;

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL ABOVE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

        -- If we get here ok, commit the changes
        IF bRollback = TRUE THEN
            ROLLBACK;
            SHOW ERRORS;
            SELECT '* UPDATE FAILED *' AS `===== STATUS =====`,@cCurResult AS `===== DB IS ON VERSION: =====`;



        ELSE
            COMMIT;
            SELECT '* UPDATE COMPLETE *' AS `===== STATUS =====`,@cNewResult AS `===== DB IS NOW ON VERSION =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== STATUS =====`,@cCurResult AS `===== DB IS already ON VERSION =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== STATUS =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
		IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
		    SET @cCurVersion := (SELECT `VERSION` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== STATUS =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== FOUND VERSION =====`;
		ELSE
		    SET @cCurVersion := (SELECT `VERSION` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SELECT '* UPDATE SKIPPED *' AS `===== STATUS =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== FOUND VERSION =====`;
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
