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
    SET @cOldContent = '26';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '27';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'dbdocs_update_dbscripts';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'dbdocs_update_dbscripts';

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

    delete from `dbdocssubtables` where `subtableId`= 137 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (137,0,'db_script_Types','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Type</b></th>
<th align=\'left\'><b>Type Name</b></th>
<th align=\'left\'><b>Notes</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Quest Start</td><td align=\'left\' valign=\'middle\'>This type are scripts mentioned in the quest_template table. Here source = questgiver, target = Player.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Quest End</td><td align=\'left\' valign=\'middle\'>This type are scripts mentioned in the quest_template table. Here source = questrewarder, target = Player.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Gossip</td><td align=\'left\' valign=\'middle\'>This type are scripts mentioned in the gossip_menu and gossip_menu_option tables. In the latter case, the parameters depend on object type (GameObject or Unit) of the object having such gossip:<br /> for GO, source = Player and target = GameObject; <br />for Unit, source = Unit and target = Player. In the former case, source = Player and target = Unit. <br />This all is rather funny, isn\'t this?<br />The scripts &quot;on talking to gameobject&quot; are implemented instead with type 7 (Go Template Use).</td></tr>
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
|This type are scripts mentioned in the gossip_menu and gossip_menu_option tables. In the latter case, the parameters depend on object type (GameObject or Unit) of the object having such gossip:<br /> for GO, source = Player and target = GameObject; <br />for Unit, source = Unit and target = Player. In the former case, source = Player and target = Unit. <br />This all is rather funny, isn\'t this?<br />The scripts &quot;on talking to gameobject&quot; are implemented instead with type 7 (Go Template Use).
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

