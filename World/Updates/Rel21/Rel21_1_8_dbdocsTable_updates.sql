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
    SET @cOldContent = '7'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '1';
    SET @cNewContent = '8';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'update_dbdocs_entries';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'update_dbdocs_entries - for recently changed tables';

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

insert  into `dbdocstable`(`languageId`,`tableName`,`tableNotes`) values (0, 'dbdocsfields_localised','This table is part of the implementation of the 'Mangos Database Documentation' (MDD) Project.<br /><br />An entry in this table provides a link to the table and field to allow additional notes to describe the field in the Wiki for languages other than English.');
insert  into `dbdocstable`(`languageId`,`tableName`,`tableNotes`) values (0, 'dbdocssubtables_localised','This table is part of the implementation of the 'Mangos Database Documentation' (MDD) Project.<br /><br />An entry in this table provides a table which dirctly replaces the link in the fieldnotes for languages other than English.');
insert  into `dbdocstable`(`languageId`,`tableName`,`tableNotes`) values (0, 'dbdocstable_localised','This table is part of the implementation of the 'Mangos Database Documentation' (MDD) Project.<br /><br />An entry in this table provides a additional notes field to describe the database in the Wiki for languages other than English.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'db_version','description','','The Description of the latest database revision.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'db_version','comment','','A comment about the latest database revision.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'db_version','structure','','The current core structure level.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'db_version','content','','The current core content level, The server will start if there is a mismatch, but will issue a warning message');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocsfields','languageId','','The ID of the language of the localised entry.<br /><br /><br />¬subtable:101¬<br />');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocsfields','fieldId','','The unique Id for this field.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocsfields_localised','fieldId','','The unique Id for this field.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocsfields_localised','languageId','','The ID of the language of the localised entry.<br /><br /><br />¬subtable:101¬');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocsfields_localised','fieldNotes','','The localised Field Note text');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocsfields_localised','fieldComment','','A short localised Description of the Field.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocslanguage','LanguageId','','The ID of the language of the localised entry.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocslanguage','LanguageName','','The Name of the language of the localised entry.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocssubtables','languageId','','The ID of the language of the localised entry.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocssubtables_localised','subTableId','','This is the Lookup Id of the subTable');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocssubtables_localised','languageId','','The ID of the language of the localised entry.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocssubtables_localised','subTableContent','','The Content of the subTable.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocssubtables_localised','subTableTemplate','','The SubTable Template, Used to create the SubTableContent field content');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocstable','languageId','','The ID of the language of the localised entry.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocstable','tableId','','The unique Id of the table.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocstable_localised','tableId','','The unique Id of the table.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocstable_localised','languageId','','The ID of the language of the localised entry.');
insert  into `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`tableComments`,`tableNotes`) values (0,'dbdocstable_localised','tableNotes','','The table note text.');

delete from `dbdocssubtables` where `subtableId`= 101 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (101,0,'DbDocsLangs','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>LanguageId</b></th>
<th align=\'left\'><b>LanguageName</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>English</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Korean</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>French</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>German</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Chinese</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Taiwanese</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Spanish (Spain)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>Spanish (Latin America)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>Russian</td></tr>
</table>
','LanguageId|<LanguageName
0|English
1|Korean
2|French
3|German
4|Chinese
5|Taiwanese
6|Spanish (Spain)
7|Spanish (Latin America)
8|Russian');


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