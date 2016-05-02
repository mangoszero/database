-- -----------------------------------
-- Added to prevent timeout's while loading
-- -----------------------------------
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
    SET @cOldContent = '1'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '2';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'dbdocs_cleanup_pt1';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'dbdocs_cleanup_pt1_db_scripts';

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

DELETE FROM dbdocsfields WHERE tablename IN
(
'db_scripts',
'dbscripts_on_creature_death',
'dbscripts_on_creature_movement',
'dbscripts_on_event',
'dbscripts_on_go_template_use',
'dbscripts_on_go_use',
'dbscripts_on_gossip',
'dbscripts_on_quest_end',
'dbscripts_on_quest_start',
'dbscripts_on_spell',
'scripted_areatrigger,'
'scripted_event',
'sd2_db_version',
'world_template'
);

DELETE FROM dbdocstable WHERE tablename IN
(
'db_scripts',
'dbscripts_on_creature_death',
'dbscripts_on_creature_movement',
'dbscripts_on_event',
'dbscripts_on_go_template_use',
'dbscripts_on_go_use',
'dbscripts_on_gossip',
'dbscripts_on_quest_end',
'dbscripts_on_quest_start',
'dbscripts_on_spell',
'scripted_areatrigger',
'scripted_event',
'sd2_db_version',
'world_template'
);

-- Add new db_scripts entries
DELETE FROM `dbdocstable` WHERE `languageId`=0 AND `tableName`='db_scripts';
INSERT  INTO `dbdocstable`(`languageId`,`tableName`,`tableNotes`) VALUES (0, 'db_scripts','This table holds scripts activated under certain criteria.<br /><br />The type controls what criteria are in effect');

DELETE FROM `dbdocsfields` WHERE `tableName`='db_scripts';
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'buddy_entry', 'Creature ID (creature_template.entry) for changing source/target.', 'Creature ID (creature_template.entry) for changing source/target.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'command', 'Script command.', 'Script command. Note for this script type, several commands have no sense. These are animation command (will be overridden by death animation), movement, mount, despawn.<br />¬subtable:36¬');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'comments', 'Textual comment.', 'Textual comment, ignored by the core.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'data_flags', 'Command flags.', 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'dataint', 'Command parameter, see command description.', 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'dataint2', 'Command parameter, see command description.', 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'dataint3', 'Command parameter, see command description.', 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'dataint4', 'Command parameter, see command description.', 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'datalong', 'Command parameter, see command description.', 'Command parameter, see command description.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'datalong2', 'Command parameter, see command description.', 'Command parameter, see command description.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'delay', 'Delay (sec).', 'Delay in seconds. Note that for any delay>0, the creature is dead and cannot perform any action by itself (including cast).<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'id', 'Creature ID (See creature_template.entry).', 'ID of the creature (creature_template.entry), at which death will run this script.<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by ''delay'' parameter.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'o', 'Orientation angle (0 to 2*Pi).', 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'search_radius', 'Radius for the buddy search.', 'Radius, in which the buddy will be searched. For changing source/target mechanic.<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the ''gameobject'' table or ''creature'' table table.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'x', 'Position X.', 'X of position - for commands requiring position.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'y', 'Position Y.', 'Y of position - for commands requiring position.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'z', 'Position Z.', 'Z of position - for commands requiring position.');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'script_guid', 'The Unique Identifier for this script','The Unique Identifier for this script');
INSERT INTO `dbdocsfields` (`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) VALUES ('0', 'db_scripts', 'script_type', 'The type of script','The type of script:<br /><br />¬subtable:137¬<br /><br />');

DELETE FROM `dbdocssubtables` WHERE `subtableId`= 137 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (137,0,'db_script_Types','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Type</b></th>
<th align=\'left\'><b>Type Name</b></th>
<th align=\'left\'><b>Notes</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Quest Start</td><td align=\'left\' valign=\'middle\'>This type are scripts mentioned in the quest_template table. Here source = questgiver, target = Player.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Quest End</td><td align=\'left\' valign=\'middle\'>This type are scripts mentioned in the quest_template table. Here source = questrewarder, target = Player.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Gossip</td><td align=\'left\' valign=\'middle\'>This type are scripts mentioned in the gossip_menu and gossip_menu_item tables. In the latter case, the parameters depend on object type (GameObject or Unit) of the object having such gossip:<br /> for GO, source = Player and target = GameObject; <br />for Unit, source = Unit and target = Player. In the former case, source = Player and target = Unit. <br />This all is rather funny, isn\'t this?<br />The scripts &quot;on talking to gameobject&quot; are implemented instead with type 7 (Go Template Use).</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Creature Movement</td><td align=\'left\' valign=\'middle\'>This type are  scripts activated when a creature moving by waypoints reaches a WP. (Source: creature)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Creature Death</td><td align=\'left\' valign=\'middle\'>This type are scripts activated when a creature dies. (Source: creature; at the script execution time, it is considered alive, so can cast instant spells.)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Spell</td><td align=\'left\' valign=\'middle\'>This type are scripts triggered by spells with EFFECT_DUMMY (3) or EFFECT_SCRIPT_EFFECT (77). Here source = caster, target = unitTarget.<br />Note that if the spell contains more than 1 effect of such type, this script will be set up for the single effect only, namely for one with the least effect number.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Go Use</td><td align=\'left\' valign=\'middle\'>This type are scripts activated when a character uses either door or button. <br />This script, bound to the GameObject GUID, does not override the script bound to the GameObject entry, if any. If both scripts are defined, they are executed sequentially, the script of this type activates after type 7 (Go Template Use).</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>Go Template Use</td><td align=\'left\' valign=\'middle\'>This type are scripts activated when a character uses a gameobject (like door, chest, button so on).</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>Event</td><td align=\'left\' valign=\'middle\'>This type are scripts activated when an event is sent either via spell (SPELL_EFFECT_SEND_EVENT=61) or by a gameobject.</td></tr>
</table>
','Type|<Type Name|<Notes
0|Quest Start
|This type are scripts mentioned in the quest_template table. Here source = questgiver, target = Player.
1|Quest End|This type are scripts mentioned in the quest_template table. Here source = questrewarder, target = Player.
2|Gossip
|This type are scripts mentioned in the gossip_menu and gossip_menu_item tables. In the latter case, the parameters depend on object type (GameObject or Unit) of the object having such gossip:<br /> for GO, source = Player and target = GameObject; <br />for Unit, source = Unit and target = Player. In the former case, source = Player and target = Unit. <br />This all is rather funny, isn\'t this?<br />The scripts &quot;on talking to gameobject&quot; are implemented instead with type 7 (Go Template Use).
3|Creature Movement
|This type are  scripts activated when a creature moving by waypoints reaches a WP. (Source: creature)
4|Creature Death
|This type are scripts activated when a creature dies. (Source: creature; at the script execution time, it is considered alive, so can cast instant spells.)
5|Spell
|This type are scripts triggered by spells with EFFECT_DUMMY (3) or EFFECT_SCRIPT_EFFECT (77). Here source = caster, target = unitTarget.<br />Note that if the spell contains more than 1 effect of such type, this script will be set up for the single effect only, namely for one with the least effect number.
6|Go Use
|This type are scripts activated when a character uses either door or button. <br />This script, bound to the GameObject GUID, does not override the script bound to the GameObject entry, if any. If both scripts are defined, they are executed sequentially, the script of this type activates after type 7 (Go Template Use).
7|Go Template Use
|This type are scripts activated when a character uses a gameobject (like door, chest, button so on).
8|Event
|This type are scripts activated when an event is sent either via spell (SPELL_EFFECT_SEND_EVENT=61) or by a gameobject.');

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
