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
    SET @cOldStructure = '22'; 
    SET @cOldContent = '007';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '22';
    SET @cNewContent = '008';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Laris Geardawdle';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Laris Geardawdle';

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

    
SET @db_string := (SELECT MAX(`entry`) FROM `db_script_string`);
SET @condition := (SELECT MAX(`condition_entry`) FROM `conditions`);

-- Set Laris Geardawdle movement.
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 9616;

-- Text for movement script.
INSERT INTO `db_script_string` (`entry`, `content_default`, `comment`) VALUES 
(@db_string+1,'Incredible! Amazing! I don\'t even know what this means!','Laris Say.');

-- Laris Geardawdle scripts.
DELETE FROM `db_scripts` WHERE `id` IN (9615,9616);
DELETE FROM `db_scripts` WHERE `script_type` = 1 AND `id` IN (4512);
INSERT INTO `db_scripts` (`script_type`,`id`,`delay`,`command`,`datalong`,`comments`) VALUES
(3,9615,0,32,1,'Laris Pause WP1'),
(1,4512,0,32,0,'Laris Unpause WP');
INSERT INTO `db_scripts` (`script_type`,`id`,`delay`,`command`,`dataint`,`comments`) VALUES
(3,9616,0,0,@db_string+1,'Laris Say on WP');

-- Laris Geardawdle Waypoints.
DELETE FROM `creature_movement_template` WHERE `entry` = 9616;
INSERT INTO `creature_movement_template` VALUES
(9616,1,-4692.6,-1312.64,503.382,0,9615,0,0,0,0,0,0,0,2.93215,0,0), -- Hold Position.
(9616,2,-4692.6,-1312.64,503.382,0,0,0,0,0,0,0,0,0,2.93215,0,0), -- Needed for some strange reason.
(9616,3,-4691.117,-1316.719,503.382,0,9616,0,0,0,0,0,0,0,2.93215,0,0), -- Say at position.
(9616,4,-4693.545,-1311.002,503.382,0,0,0,0,0,0,0,0,0,2.93215,0,0),
(9616,5,-4692.032,-1315.076,503.382,0,0,0,0,0,0,0,0,0,2.93215,0,0);

-- Update Quest 4512 with Complete Script.
UPDATE `quest_template` SET `CompleteScript` = 4512 WHERE `entry` = 4512;

-- Gossip and npc page text conditions.
INSERT INTO `conditions` (`condition_entry`,`type`,`value1`,`value2`,`comments`) VALUES
(@condition+1,8,4512,0,'Show gossip text 3099 if quest, A Little Slime Goes a Long Way (Part 1), is rewarded'),
(@condition+2,8,4513,0,'Show gossip text 3098 if quest, A Little Slime Goes a Long Way (Part 2), is rewarded'),
(@condition+3,-3,@condition+2,0,'Only show if quest, A Little Slime Goes a Long Way (Part 2), is NOT rewarded'),
(@condition+4,-1,@condition+1,@condition+3,'Condition Check for A Little Slime Goes a Long Way gossip');

-- Laris Geardawdle - fix Gossip Texts
DELETE FROM `gossip_menu` WHERE `entry`= 2405 AND `text_id` IN (3077,3098,3097);
DELETE FROM `gossip_menu` WHERE `entry` IN (2406,2407,2408);
INSERT INTO `gossip_menu` (`entry`,`text_id`,`script_id`,`condition_id`) VALUES
(2405,3077,0,0),
(2405,3099,0,@condition+1),
(2405,3098,0,@condition+2),
(2406,3100,0,0),
(2407,3101,0,0),
(2408,3102,0,0);

-- Fixed Laris Geardawdle's gossip option and added conditions for them.
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (2406,2407,2405);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`,`condition_id`) VALUES
(2405,0,0,'Is there a difference between ooze and slime?',1,1,2406,0,0,0,0,'',@condition+4),
(2406,0,0,'What do you mean by \"pure?\"',1,1,2407,0,0,0,0,'',@condition+4),
(2407,0,0,'Are there any areas you can think of that would be so untouched?',1,1,2408,0,0,0,0,'',@condition+4);

-- Add missing npc text for Laris Geardawdle.
DELETE FROM `npc_text` WHERE `ID` IN (3099);
INSERT INTO `npc_text` (`ID`,`text0_0`) VALUES
(3099,'There must be someplace on Azeroth that we can find oozes uncorrupted by the Scourge or anything else. But where?!');

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


