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
    SET @cOldContent = '3'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '4';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'warden_dbdocs';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'warden_dbdocs_updates';

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

DELETE FROM `dbdocssubtables` WHERE `subtableId`= 138 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (138,0,'Warden_Types','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Check Type</b></th>
<th><b>Type (Hex)</b></th>
<th><b>Type (Dec)</b></th>
<th align=\'left\'><b>Notes</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>MEM_CHECK</td><td align=\'center\' valign=\'middle\'>0xF3</td><td align=\'center\' valign=\'middle\'>243</td><td align=\'left\' valign=\'middle\'>byte moduleNameIndex + uint Offset + byte Len (check to ensure memory isn\'t modified)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PAGE_CHECK_A</td><td align=\'center\' valign=\'middle\'>0xB2</td><td align=\'center\' valign=\'middle\'>178</td><td align=\'left\' valign=\'middle\'>uint Seed + byte[20] SHA1 + uint Addr + byte Len (scans all pages for specified hash)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PAGE_CHECK_B</td><td align=\'center\' valign=\'middle\'>0xBF</td><td align=\'center\' valign=\'middle\'>191</td><td align=\'left\' valign=\'middle\'>uint Seed + byte[20] SHA1 + uint Addr + byte Len (scans only pages starts with MZ+PE headers for specified hash)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>MPQ_CHECK</td><td align=\'center\' valign=\'middle\'>0x98</td><td align=\'center\' valign=\'middle\'>152</td><td align=\'left\' valign=\'middle\'>byte fileNameIndex (check to ensure MPQ file isn\'t modified)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>LUA_STR_CHECK</td><td align=\'center\' valign=\'middle\'>0x8B</td><td align=\'center\' valign=\'middle\'>139</td><td align=\'left\' valign=\'middle\'>byte luaNameIndex (check to ensure LUA string isn\'t used)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>DRIVER_CHECK</td><td align=\'center\' valign=\'middle\'>0x71</td><td align=\'center\' valign=\'middle\'>113</td><td align=\'left\' valign=\'middle\'>uint Seed + byte[20] SHA1 + byte driverNameIndex (check to ensure driver isn\'t loaded)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>TIMING_CHECK</td><td align=\'center\' valign=\'middle\'>0x57</td><td align=\'center\' valign=\'middle\'>87</td><td align=\'left\' valign=\'middle\'>empty (check to ensure GetTickCount() isn\'t detoured)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PROC_CHECK</td><td align=\'center\' valign=\'middle\'>0x7E</td><td align=\'center\' valign=\'middle\'>126</td><td align=\'left\' valign=\'middle\'>uint Seed + byte[20] SHA1 + byte moluleNameIndex + byte procNameIndex + uint Offset + byte Len (check to ensure proc isn\'t detoured)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>MODULE_CHECK</td><td align=\'center\' valign=\'middle\'>0xD9</td><td align=\'center\' valign=\'middle\'>217</td><td align=\'left\' valign=\'middle\'>uint Seed + byte[20] SHA1 (check to ensure module isn\'t injected)</td></tr>
</table>
','Check Type|Type (Hex)|Type (Dec)|<Notes
MEM_CHECK|0xF3|243|byte moduleNameIndex + uint Offset + byte Len (check to ensure memory isn\'t modified)
PAGE_CHECK_A|0xB2|178|uint Seed + byte[20] SHA1 + uint Addr + byte Len (scans all pages for specified hash)
PAGE_CHECK_B|0xBF|191|uint Seed + byte[20] SHA1 + uint Addr + byte Len (scans only pages starts with MZ+PE headers for specified hash)
MPQ_CHECK|0x98|152|byte fileNameIndex (check to ensure MPQ file isn\'t modified)
LUA_STR_CHECK|0x8B|139|byte luaNameIndex (check to ensure LUA string isn\'t used)
DRIVER_CHECK|0x71|113|uint Seed + byte[20] SHA1 + byte driverNameIndex (check to ensure driver isn\'t loaded)
TIMING_CHECK|0x57|87|empty (check to ensure GetTickCount() isn\'t detoured)
PROC_CHECK|0x7E|126|uint Seed + byte[20] SHA1 + byte moluleNameIndex + byte procNameIndex + uint Offset + byte Len (check to ensure proc isn\'t detoured)
MODULE_CHECK|0xD9|217|uint Seed + byte[20] SHA1 (check to ensure module isn\'t injected)
');

DELETE FROM `dbdocstable` WHERE `languageId`=0 AND `tableName`='warden';
INSERT  INTO `dbdocstable`(`languageId`,`tableName`,`tableNotes`) VALUES (0, 'warden','This table contains the Warden Anti-cheat system checks.<br />');
INSERT  INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES (0,'warden','type','Check Type','The type of check performed:<br /><br />¬subtable:138¬');
INSERT  INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES (0,'warden','id','Unique Identifier','Unique Identifier');
INSERT  INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES (0,'warden','groupid','Grouped Check ID','The Grouped Check ID, this should be unique per check and build');
INSERT  INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES (0,'warden','build','Build Number','This is the build number that warden should check against.');
INSERT  INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES (0,'warden','comment','Decription','A description of what the check does');

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
