-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
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
    SET @cOldStructure = '5'; 
    SET @cOldContent = '7'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '6';
    SET @cNewContent = '1';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'ticket_commands_update';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'GM_ticket_commands_update';

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

-- add output formats for GM ticket commands
DELETE FROM `mangos_string` WHERE `entry` IN (290,373,1514,1515,1516,1517,1518);
INSERT INTO `mangos_string` (`entry`,`content_default`) VALUES
 (290,'Ticket of %s (Last updated: %s): %s'),
 (373,'Response: %s'),
 (1514,'ID %u from %s (%s), changed %s'),
 (1515,'= Shown %u tickets out of total %u from online players.'),
 (1516,'ID %u from GUID %u (%s), changed %s'),
 (1517,'= Shown %u tickets of total %u.'),
 (1518,'Informing you about arriving tickets is %s.');

-- Change `command` to reflect .ticket current status

DELETE FROM `command` WHERE `name` IN ('ticket','delticket');
DELETE FROM `command` WHERE `name` LIKE 'ticket %';

INSERT INTO `command` (`name`,`security`,`help`) VALUES
 ('ticket accept', 3, 'Syntax: .ticket accept (on|off)\nTurning on/off the whole ticket accepting system.' ),
 ('ticket close', 2, 'Syntax: .ticket close (#ID|$name)\nClosing the ticket.'),
 ('ticket delete', 3, 'Syntax: .ticket delete (#ID|$name)\nDelete ticket from the list. It will reappear after server restart.'),
 ('ticket info', 1, 'Syntax: .ticket info\nInformation on the tickets and your relation to them.'),
 ('ticket list', 2, 'Syntax: .ticket list\nGet list of ticket IDs with player GUIDs and last change date.'),
 ('ticket meaccept', 2, 'Syntax: .ticket meaccept [(on|off)]\nSet you informing about incoming tickets, or show its status.'),
 ('ticket onlinelist', 2, 'Syntax: .ticket onlinelist\nGet list of the tickets for online players only.'),
 ('ticket respond', 2, 'Syntax: .ticket respond (#ID|$name) $responce_text\nSend your responce to the ticket as whisper chat.'),
 ('ticket show', 2, 'Syntax: .ticket show (#ID|$name)\nShow details about the ticket.'),
 ('ticket surveyclose', 2, 'Syntax: .ticket surveyclose (#ID|$name)\nClosing the ticket with the user survey.');


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
                SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurResult AS `===== Found Version =====`;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;