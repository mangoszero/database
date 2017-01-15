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
    SET @cOldStructure = '1'; 
    SET @cOldContent = '20'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '1';
    SET @cNewContent = '21';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'dbdocs update for custom_texts';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'New subtables added, and Notes and field comments added to the custom_texts table, plus corrections made to 2 item_template submodule tables';

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

-- dbocssubtables
-- -- -- -- -- --
DELETE FROM `dbdocssubtables` WHERE `subtableId`= 110 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (110,0,'Custom Texts type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Say</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Yell</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Text emote</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Boss emote</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Whisper</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Boss whisper</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Zone-wide yell</td></tr>
</table>
','Value|<Description
0|Say
1|Yell
2|Text emote
3|Boss emote
4|Whisper
5|Boss whisper
6|Zone-wide yell');
DELETE FROM dbdocssubtables WHERE subTableId=13;DELETE FROM `dbdocssubtables` WHERE `subtableId`= 106 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (106,0,'Spell Trigger','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>On use</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>On equip</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Chance on hit</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Soulstone</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>On use without delay</td></tr>
</table>
','Value|<Description
0|On use
1|On equip
2|Chance on hit
4|Soulstone
5|On use without delay');
DELETE FROM `dbdocssubtables` WHERE `subtableId`= 103 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (103,0,'Stat Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>No stats</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Health</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Agility</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Strength</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Intellect</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Spirit</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>Stamina</td></tr>
</table>
','Value|<Description
0|No stats
1|Health
3|Agility
4|Strength
5|Intellect
6|Spirit
7|Stamina');

        
-- dbocsfields
-- -- -- -- --
update `dbdocstable` set `languageId`=0, `tableName`='custom_texts', `tableNotes`='The custom_texts table holds custom text strings, sounds, and emotes used in scripted events.' where tableId=31;
update `dbdocsfields` set `FieldComment` = 'The unique identifier of the script text entry.', `fieldNotes` = 'The unique identifier of the script text entry. Identifiers here have to match with the identifier set in the string using the text.' where `fieldId`= '307' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to a SoundEntries.dbc table entry.', `fieldNotes` = 'If a sound file should be played, this references an entry in the SoundEntries.dbc table.' where `fieldId`= '309' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Selects one of various text emote types to be used for the script text.', `fieldNotes` = 'Selects one of various text emote types to be used for the script text. The following tables shows available text emote types.<br />¬subtable:109¬' where `fieldId`= '310' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Selects one of various text emote types to be used for the script text.', `fieldNotes` = 'Selects one of various text emote types to be used for the script text. The following tables shows available text emote types.<br />¬subtable:110¬' where `fieldId`= '310' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Selects one of various text emote types to be used for the script text.', `fieldNotes` = 'Selects one of various text emote types to be used for the script text. The following tables shows available text emote types.<br />¬subtable:110¬' where `fieldId`= '310' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A language identifier.', `fieldNotes` = 'A language identifier. The value has to match with a language identifier defined in Languages.dbc.' where `fieldId`= '308' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This documents the script text.', `fieldNotes` = 'This documents the script text. Currently no rules have been defined for the format of the comment. It should help identifying who and why does perform the emote.' where `fieldId`= '296' and `languageId`= 0;





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