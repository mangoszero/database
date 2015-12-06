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
    SET @cOldContent = '23'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '1';
    SET @cNewContent = '24';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'dbdocs updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'New subtables added, Notes and field comments added, up to and including the quest_template table';

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
delete from `dbdocssubtables` where `subtableId`= 112 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (112,0,'Playercreateinfo Action button','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>button ID(s)</b></th>
<th align=\'left\'><b>Set key</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1-11</td><td align=\'left\' valign=\'middle\'>1 (SHIFT + 1)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>12-23</td><td align=\'left\' valign=\'middle\'>2 (SHIFT + 2)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>24-35</td><td align=\'left\' valign=\'middle\'>3 (SHIFT + 3) h1. Right Side Bar</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>36-47</td><td align=\'left\' valign=\'middle\'>4 (SHIFT + 4) Right Side Bar 2</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>48-59</td><td align=\'left\' valign=\'middle\'>5 (SHIFT + 5) h1. Bottom Right Bar</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>60-71</td><td align=\'left\' valign=\'middle\'>6 (SHIFT + 6) Bottom Left Bar</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>72-83</td><td align=\'left\' valign=\'middle\'>1 SpecialA</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>84-95</td><td align=\'left\' valign=\'middle\'>1 SpecialB</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>96-107</td><td align=\'left\' valign=\'middle\'>1 SpecialC</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>108-119</td><td align=\'left\' valign=\'middle\'>1 SpecialD</td></tr>
</table>
','button ID(s)|<Set key
1-11|1 (SHIFT + 1)
12-23|2 (SHIFT + 2)
24-35|3 (SHIFT + 3) h1. Right Side Bar
36-47|4 (SHIFT + 4) Right Side Bar 2
48-59|5 (SHIFT + 5) h1. Bottom Right Bar
60-71|6 (SHIFT + 6) Bottom Left Bar
72-83|1 SpecialA
84-95|1 SpecialB
96-107|1 SpecialC
108-119|1 SpecialD');
delete from `dbdocssubtables` where `subtableId`= 113 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (113,0,'Playercreateinfo Action type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>ID</b></th>
<th align=\'left\'><b>Type</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Spell</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>64</td><td align=\'left\' valign=\'middle\'>Macro</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>128</td><td align=\'left\' valign=\'middle\'>Item</td></tr>
</table>
','ID|<Type
0|Spell
64|Macro
128|Item');
delete from `dbdocssubtables` where `subtableId`= 114 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (114,0,'Quest Template QuestType','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Name</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_NONE</td><td align=\'left\' valign=\'middle\'>Nothing special going on.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_STAY_ALIVE</td><td align=\'left\' valign=\'middle\'>If the character dies, the quest will fail</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_PARTY_ACCEPT</td><td align=\'left\' valign=\'middle\'>If the character is grouped, all players that can accept this quest will receive confirmation box to accept quest</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_EXPLORATION</td><td align=\'left\' valign=\'middle\'>Quest requires the character to explore a zone</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_SHARABLE</td><td align=\'left\' valign=\'middle\'>Quest may be shared with other characters</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_UNUSED1</td><td align=\'left\' valign=\'middle\'>Not used by any quest.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>32</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_EPIC</td><td align=\'left\' valign=\'middle\'>Epic class quests?</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>64</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_RAID</td><td align=\'left\' valign=\'middle\'>Raid quests.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>128</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_UNUSED2</td><td align=\'left\' valign=\'middle\'>Not used by any quest.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>256</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_UNK2</td><td align=\'left\' valign=\'middle\'>Not used currently: DELIVERMORE Quest needs more than normal q-item drops from mobs</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>512</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_HIDDEN_REWARDS</td><td align=\'left\' valign=\'middle\'>Items and money rewarded only sent in SMSG_QUESTGIVER_OFFER_REWARD (not in SMSG_QUESTGIVER_QUEST_DETAILS or in client quest log(SMSG_QUEST_QUERY_RESPONSE))</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1024</td><td align=\'left\' valign=\'middle\'>QUEST_FLAGS_AUTO_REWARDED</td><td align=\'left\' valign=\'middle\'>These quests are automatically rewarded on quest complete and they will never appear in quest log client side.</td></tr>
</table>
','Value|<Name|<Description
0|QUEST_FLAGS_NONE|Nothing special going on.
1|QUEST_FLAGS_STAY_ALIVE|If the character dies, the quest will fail
2|QUEST_FLAGS_PARTY_ACCEPT|If the character is grouped, all players that can accept this quest will receive confirmation box to accept quest
4|QUEST_FLAGS_EXPLORATION|Quest requires the character to explore a zone
8|QUEST_FLAGS_SHARABLE|Quest may be shared with other characters
16|QUEST_FLAGS_UNUSED1|Not used by any quest.
32|QUEST_FLAGS_EPIC|Epic class quests?
64|QUEST_FLAGS_RAID|Raid quests.
128|QUEST_FLAGS_UNUSED2|Not used by any quest.
256|QUEST_FLAGS_UNK2|Not used currently: DELIVERMORE Quest needs more than normal q-item drops from mobs
512|QUEST_FLAGS_HIDDEN_REWARDS|Items and money rewarded only sent in SMSG_QUESTGIVER_OFFER_REWARD (not in SMSG_QUESTGIVER_QUEST_DETAILS or in client quest log(SMSG_QUEST_QUERY_RESPONSE))
1024|QUEST_FLAGS_AUTO_REWARDED|These quests are automatically rewarded on quest complete and they will never appear in quest log client side.');
delete from `dbdocssubtables` where `subtableId`= 115 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (115,0,'Quest Template SpecialFlags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Nothing special going on.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>The quest is repeatable.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Quest requires exploration or an event, handled by the script library.</td></tr>
</table>
','Value|<Description
0|Nothing special going on.
1|The quest is repeatable.
2|Quest requires exploration or an event, handled by the script library.');
delete from `dbdocssubtables` where `subtableId`= 116 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (116,0,'Quest Template Details','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>$B</td><td align=\'left\' valign=\'middle\'>Line break</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>$N</td><td align=\'left\' valign=\'middle\'>Character name</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>$R</td><td align=\'left\' valign=\'middle\'>Character race</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>$C</td><td align=\'left\' valign=\'middle\'>Character class</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>$G m:f</td><td align=\'left\' valign=\'middle\'>Inserts string based on character gender. Example: Such a generous $G man:woman. The order male:female needs to be kept.</td></tr>
</table>
','Value|<Description
$B|Line break
$N|Character name
$R|Character race
$C|Character class
$G m:f|Inserts string based on character gender. Example: Such a generous $G man:woman. The order male:female needs to be kept.');
delete from `dbdocssubtables` where `subtableId`= 117 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (117,0,'Quest Template OfferRewardText','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>$B</td><td align=\'left\' valign=\'middle\'>Line break</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>$N</td><td align=\'left\' valign=\'middle\'>Character name</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>$R</td><td align=\'left\' valign=\'middle\'>Character race</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>$C</td><td align=\'left\' valign=\'middle\'>Character class</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>$G m:f</td><td align=\'left\' valign=\'middle\'>Inserts string based on character gender. Example: Such a generous $G man:woman. The order male:female needs to be kept.</td></tr>
</table>
','Value|<Description
$B|Line break
$N|Character name
$R|Character race
$C|Character class
$G m:f|Inserts string based on character gender. Example: Such a generous $G man:woman. The order male:female needs to be kept.');
delete from `dbdocssubtables` where `subtableId`= 118 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (118,0,'Quest Template RequestItemsText','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>$B</td><td align=\'left\' valign=\'middle\'>Line break</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>$N</td><td align=\'left\' valign=\'middle\'>Character name</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>$R</td><td align=\'left\' valign=\'middle\'>Character race</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>$C</td><td align=\'left\' valign=\'middle\'>Character class</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>$G m:f</td><td align=\'left\' valign=\'middle\'>Inserts string based on character gender. Example: Such a generous $G man:woman. The order male:female needs to be kept.</td></tr>
</table>
','Value|<Description
$B|Line break
$N|Character name
$R|Character race
$C|Character class
$G m:f|Inserts string based on character gender. Example: Such a generous $G man:woman. The order male:female needs to be kept.');


-- dbocsfields
-- -- -- -- --
update `dbdocsfields` set `FieldComment` = 'Reference to page_text.entry.', `fieldNotes` = 'The locales_page_text table holds localized text strings for page texts.' where `fieldId`= '990' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of Text in the “page_text” table table.', `fieldNotes` = 'Korean localization of Text in the “page_text” table table.' where `fieldId`= '991' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of Text in the “page_text” table table.', `fieldNotes` = 'French localization of Text in the “page_text” table table.' where `fieldId`= '992' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of Text in the “page_text” table table.', `fieldNotes` = 'German localization of Text in the “page_text” table table.' where `fieldId`= '993' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of Text in the “page_text” table table.', `fieldNotes` = 'Chinese localization of Text in the “page_text” table table.' where `fieldId`= '994' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of Text in the “page_text” table table.', `fieldNotes` = 'Taiwanese localization of Text in the “page_text” table table.' where `fieldId`= '995' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of Text in the “page_text” table table.', `fieldNotes` = 'Spanish Spain localization of Text in the “page_text” table table.' where `fieldId`= '996' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of Text in the “page_text” table table.', `fieldNotes` = 'Spanish Latin America localization of Text in the “page_text” table table.' where `fieldId`= '997' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of Text in the “page_text” table table.', `fieldNotes` = 'Russian localization of Text in the “page_text” table table.' where `fieldId`= '998' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to points_of_interest.entry.', `fieldNotes` = 'This references the “points_of_interest” table tables unique ID for which the entry is valid.' where `fieldId`= '999' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of icon_name in the “points_of_interest” table table.', `fieldNotes` = 'Korean localization of icon_name in the “points_of_interest” table table.' where `fieldId`= '1000' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of icon_name in the “points_of_interest” table table.', `fieldNotes` = 'French localization of icon_name in the “points_of_interest” table table.' where `fieldId`= '1001' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of icon_name in the “points_of_interest” table table.', `fieldNotes` = 'German localization of icon_name in the “points_of_interest” table table.' where `fieldId`= '1002' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of icon_name in the “points_of_interest” table table.', `fieldNotes` = 'Chinese localization of icon_name in the “points_of_interest” table table.' where `fieldId`= '1003' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of icon_name in the “points_of_interest” table table.', `fieldNotes` = 'Taiwanese localization of icon_name in the “points_of_interest” table table.' where `fieldId`= '1004' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of icon_name in the “points_of_interest” table table.', `fieldNotes` = 'Spanish Spain localization of icon_name in the “points_of_interest” table table.' where `fieldId`= '1005' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of icon_name.', `fieldNotes` = 'Spanish Latin America localization of icon_name in the “points_of_interest” table table.' where `fieldId`= '1006' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of icon_name in the “points_of_interest” table table.', `fieldNotes` = 'Russian localization of icon_name in the “points_of_interest” table table.' where `fieldId`= '1007' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to quest_template.entry.', `fieldNotes` = 'This references the “quest_template” table tables unique ID for which the entry is valid.' where `fieldId`= '1024' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of Title in the “quest_template” table table.', `fieldNotes` = 'Korean localization of Title in the “quest_template” table table.' where `fieldId`= '1081' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of Title in the “quest_template” table table.', `fieldNotes` = 'French localization of Title in the “quest_template” table table.' where `fieldId`= '1082' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of Title in the “quest_template” table table.', `fieldNotes` = 'German localization of Title in the “quest_template” table table.' where `fieldId`= '1083' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of Title in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of Title in the “quest_template” table table.' where `fieldId`= '1084' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of Title in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of Title in the “quest_template” table table.' where `fieldId`= '1085' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of Title in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of Title in the “quest_template” table table.' where `fieldId`= '1086' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of Title.', `fieldNotes` = 'Spanish Latin America localization of Title in the “quest_template” table table.' where `fieldId`= '1087' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of Title in the “quest_template” table table.', `fieldNotes` = 'Russian localization of Title in the “quest_template” table table.' where `fieldId`= '1088' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of Details in the “quest_template” table table.', `fieldNotes` = 'Korean localization of Details in the “quest_template” table table.' where `fieldId`= '1008' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of Details in the “quest_template” table table.', `fieldNotes` = 'French localization of Details in the “quest_template” table table.' where `fieldId`= '1009' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of Details in the “quest_template” table table.', `fieldNotes` = 'German localization of Details in the “quest_template” table table.' where `fieldId`= '1010' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of Details in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of Details in the “quest_template” table table.' where `fieldId`= '1011' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of Details in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of Details in the “quest_template” table table.' where `fieldId`= '1012' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of Details in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of Details in the “quest_template” table table.' where `fieldId`= '1013' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of Details.', `fieldNotes` = 'Spanish Latin America localization of Details in the “quest_template” table table.' where `fieldId`= '1014' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of Details in the “quest_template” table table.', `fieldNotes` = 'Russian localization of Details in the “quest_template” table table.' where `fieldId`= '1015' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of Objectives in the “quest_template” table table.', `fieldNotes` = 'Korean localization of Objectives in the “quest_template” table table.' where `fieldId`= '1025' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of Objectives in the “quest_template” table table.', `fieldNotes` = 'French localization of Objectives in the “quest_template” table table.' where `fieldId`= '1026' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of Objectives in the “quest_template” table table.', `fieldNotes` = 'German localization of Objectives in the “quest_template” table table.' where `fieldId`= '1027' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of Objectives in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of Objectives in the “quest_template” table table.' where `fieldId`= '1028' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of Objectives in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of Objectives in the “quest_template” table table.' where `fieldId`= '1029' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of Objectives in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of Objectives in the “quest_template” table table.' where `fieldId`= '1030' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of Objectives.', `fieldNotes` = 'Spanish Latin America localization of Objectives in the “quest_template” table table.' where `fieldId`= '1031' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of Objectives in the “quest_template” table table.', `fieldNotes` = 'Russian localization of Objectives in the “quest_template” table table.' where `fieldId`= '1032' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of OfferRewardText in the “quest_template” table table.', `fieldNotes` = 'Korean localization of OfferRewardText in the “quest_template” table table.' where `fieldId`= '1065' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of OfferRewardText in the “quest_template” table table.', `fieldNotes` = 'French localization of OfferRewardText in the “quest_template” table table.' where `fieldId`= '1066' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of OfferRewardText in the “quest_template” table table.', `fieldNotes` = 'German localization of OfferRewardText in the “quest_template” table table.' where `fieldId`= '1067' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of OfferRewardText in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of OfferRewardText in the “quest_template” table table.' where `fieldId`= '1068' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of OfferRewardText in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of OfferRewardText in the “quest_template” table table.' where `fieldId`= '1069' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of OfferRewardText in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of OfferRewardText in the “quest_template” table table.' where `fieldId`= '1070' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of OfferRewardText.', `fieldNotes` = 'Spanish Latin America localization of OfferRewardText in the “quest_template” table table.' where `fieldId`= '1071' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of OfferRewardText in the “quest_template” table table.', `fieldNotes` = 'Russian localization of OfferRewardText in the “quest_template” table table.' where `fieldId`= '1072' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of RequestItemsText in the “quest_template” table table.', `fieldNotes` = 'Korean localization of RequestItemsText in the “quest_template” table table.' where `fieldId`= '1073' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of RequestItemsText in the “quest_template” table table.', `fieldNotes` = 'French localization of RequestItemsText in the “quest_template” table table.' where `fieldId`= '1074' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of RequestItemsText in the “quest_template” table table.', `fieldNotes` = 'German localization of RequestItemsText in the “quest_template” table table.' where `fieldId`= '1075' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of RequestItemsText in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of RequestItemsText in the “quest_template” table table.' where `fieldId`= '1076' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of RequestItemsText in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of RequestItemsText in the “quest_template” table table.' where `fieldId`= '1077' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of RequestItemsText in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of RequestItemsText in the “quest_template” table table.' where `fieldId`= '1078' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of RequestItemsText.', `fieldNotes` = 'Spanish Latin America localization of RequestItemsText in the “quest_template” table table.' where `fieldId`= '1079' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of RequestItemsText in the “quest_template” table table.', `fieldNotes` = 'Russian localization of RequestItemsText in the “quest_template” table table.' where `fieldId`= '1080' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of EndText in the “quest_template” table table.', `fieldNotes` = 'Korean localization of EndText in the “quest_template” table table.' where `fieldId`= '1016' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of EndText in the “quest_template” table table.', `fieldNotes` = 'French localization of EndText in the “quest_template” table table.' where `fieldId`= '1017' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of EndText in the “quest_template” table table.', `fieldNotes` = 'German localization of EndText in the “quest_template” table table.' where `fieldId`= '1018' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of EndText in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of EndText in the “quest_template” table table.' where `fieldId`= '1019' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of EndText in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of EndText in the “quest_template” table table.' where `fieldId`= '1020' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of EndText in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of EndText in the “quest_template” table table.' where `fieldId`= '1021' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of EndText.', `fieldNotes` = 'Spanish Latin America localization of EndText in the “quest_template” table table.' where `fieldId`= '1022' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of EndText in the “quest_template” table table.', `fieldNotes` = 'Russian localization of EndText in the “quest_template” table table.' where `fieldId`= '1023' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of ObjectiveText1 in the “quest_template” table table.', `fieldNotes` = 'Korean localization of ObjectiveText1 in the “quest_template” table table.' where `fieldId`= '1033' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of ObjectiveText1 in the “quest_template” table table.', `fieldNotes` = 'French localization of ObjectiveText1 in the “quest_template” table table.' where `fieldId`= '1034' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of ObjectiveText1 in the “quest_template” table table.', `fieldNotes` = 'German localization of ObjectiveText1 in the “quest_template” table table.' where `fieldId`= '1035' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of ObjectiveText1 in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of ObjectiveText1 in the “quest_template” table table.' where `fieldId`= '1036' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of ObjectiveText1 in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of ObjectiveText1 in the “quest_template” table table.' where `fieldId`= '1037' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of ObjectiveText1 in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of ObjectiveText1 in the “quest_template” table table.' where `fieldId`= '1038' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of ObjectiveText1 in the “quest_template” table table.', `fieldNotes` = 'Spanish Latin America localization of ObjectiveText1 in the “quest_template” table table.' where `fieldId`= '1039' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of ObjectiveText1 in the “quest_template” table table.', `fieldNotes` = 'Russian localization of ObjectiveText1 in the “quest_template” table table.' where `fieldId`= '1040' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of ObjectiveText2 in the “quest_template” table table.', `fieldNotes` = 'Korean localization of ObjectiveText2 in the “quest_template” table table.' where `fieldId`= '1041' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of ObjectiveText2 in the “quest_template” table table.', `fieldNotes` = 'French localization of ObjectiveText2 in the “quest_template” table table.' where `fieldId`= '1042' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of ObjectiveText2 in the “quest_template” table table.', `fieldNotes` = 'German localization of ObjectiveText2 in the “quest_template” table table.' where `fieldId`= '1043' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of ObjectiveText2 in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of ObjectiveText2 in the “quest_template” table table.' where `fieldId`= '1044' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of ObjectiveText2 in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of ObjectiveText2 in the “quest_template” table table.' where `fieldId`= '1045' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of ObjectiveText2 in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of ObjectiveText2 in the “quest_template” table table.' where `fieldId`= '1046' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of ObjectiveText2.', `fieldNotes` = 'Spanish Latin America localization of ObjectiveText2 in the “quest_template” table table.' where `fieldId`= '1047' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of ObjectiveText2 in the “quest_template” table table.', `fieldNotes` = 'Russian localization of ObjectiveText2 in the “quest_template” table table.' where `fieldId`= '1048' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of ObjectiveText3 in the “quest_template” table table.', `fieldNotes` = 'Korean localization of ObjectiveText3 in the “quest_template” table table.' where `fieldId`= '1049' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of ObjectiveText3 in the “quest_template” table table.', `fieldNotes` = 'French localization of ObjectiveText3 in the “quest_template” table table.' where `fieldId`= '1050' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of ObjectiveText3 in the “quest_template” table table.', `fieldNotes` = 'German localization of ObjectiveText3 in the “quest_template” table table.' where `fieldId`= '1051' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of ObjectiveText3 in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of ObjectiveText3 in the “quest_template” table table.' where `fieldId`= '1052' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of ObjectiveText3 in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of ObjectiveText3 in the “quest_template” table table.' where `fieldId`= '1053' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of ObjectiveText3 in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of ObjectiveText3 in the “quest_template” table table.' where `fieldId`= '1054' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of ObjectiveText3.', `fieldNotes` = 'Spanish Latin America localization of ObjectiveText3 in the “quest_template” table table.' where `fieldId`= '1055' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of ObjectiveText3 in the “quest_template” table table.', `fieldNotes` = 'Russian localization of ObjectiveText3 in the “quest_template” table table.' where `fieldId`= '1056' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of ObjectiveText4 in the “quest_template” table table.', `fieldNotes` = 'Korean localization of ObjectiveText4 in the “quest_template” table table.' where `fieldId`= '1057' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of ObjectiveText4 in the “quest_template” table table.', `fieldNotes` = 'French localization of ObjectiveText4 in the “quest_template” table table.' where `fieldId`= '1058' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of ObjectiveText4 in the “quest_template” table table.', `fieldNotes` = 'German localization of ObjectiveText4 in the “quest_template” table table.' where `fieldId`= '1059' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of ObjectiveText4 in the “quest_template” table table.', `fieldNotes` = 'Chinese localization of ObjectiveText4 in the “quest_template” table table.' where `fieldId`= '1060' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of ObjectiveText4 in the “quest_template” table table.', `fieldNotes` = 'Taiwanese localization of ObjectiveText4 in the “quest_template” table table.' where `fieldId`= '1061' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of ObjectiveText4 in the “quest_template” table table.', `fieldNotes` = 'Spanish Spain localization of ObjectiveText4 in the “quest_template” table table.' where `fieldId`= '1062' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of ObjectiveText4.', `fieldNotes` = 'Spanish Latin America localization of ObjectiveText4 in the “quest_template” table table.' where `fieldId`= '1063' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of ObjectiveText4 in the “quest_template” table table.', `fieldNotes` = 'Russian localization of ObjectiveText4 in the “quest_template” table table.' where `fieldId`= '1064' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The total number of copies of an item or may reference another loot template', `fieldNotes` = 'Depending on the value of the field it may either define the minimum number of copies for the item to be dropped, or it may reference another loot template.' where `fieldId`= '1095' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This table holds strings used internally by the server to allow translations.', `fieldNotes` = 'The mangos_string table holds strings used internally by the server to allow translations.' where `fieldId`= '1105' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references the “creature” table tables guid field for which the entry is valid.', `fieldNotes` = 'This references the “creature” table tables guid field for which the entry is valid.' where `fieldId`= '1106' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references the “npc_text” table tables unique ID.', `fieldNotes` = 'This references the “npc_text” table tables unique ID of the NPC text for which the entry is valid.' where `fieldId`= '1107' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The unique identifier for the training template.', `fieldNotes` = 'The unique identifier for the training template. A “creature_template” table references this from its trainer_id column.' where `fieldId`= '1195' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The spell identifier. . ', `fieldNotes` = 'The spell identifier. The value has to match with a spell identifier defined in Spell.dbc. This has to be a spell which teaches the actual spell.' where `fieldId`= '1199' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The cost that the player needs to pay in order to learn the spell in copper.', `fieldNotes` = 'The cost that the player needs to pay in order to learn the spell in copper.' where `fieldId`= '1200' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The required skill to be able to learn the spell.', `fieldNotes` = 'The required skill to be able to learn the spell. This references the skill’s entry in the SkillLine.dbc table.' where `fieldId`= '1197' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The minimum skill level required for the skill referenced in reqskill.', `fieldNotes` = 'The minimum skill level required for the skill referenced in reqskill.' where `fieldId`= '1198' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The character level required in order to learn the spell.', `fieldNotes` = 'The character level required in order to learn the spell.' where `fieldId`= '1196' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The unique identifier for the vending template.', `fieldNotes` = 'The unique identifier for the vending template. A “creature_template” table references this from its vendor_id column.' where `fieldId`= '1207' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Template ID of the item. ', `fieldNotes` = 'The item a vendor should sell. This references the “item_template” table tables unique ID.' where `fieldId`= '1209' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The maximum amount of the item a vendor should carry', `fieldNotes` = 'The maximum amount of the item a vendor should carry. Set to 0 to provide unlimited supplies.' where `fieldId`= '1210' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'How frequently a vendor will restock an item having a maximum count. ', `fieldNotes` = 'This field decides how frequently a vendor will restock an item having a maximum count. The value is given in seconds, and for limited items, the BuyCount column of the “item_template” table is taken into account when restocking.' where `fieldId`= '1208' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references the “conditions” table tables unique ID for which the entry is valid.', `fieldNotes` = 'This references the “conditions” table tables unique ID for which the entry is valid.' where `fieldId`= '1206' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references the “creature_template” table tables unique ID.', `fieldNotes` = 'This references the “creature_template” table tables unique ID for which the entry is valid.' where `fieldId`= '1228' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The spell identifier.', `fieldNotes` = 'The spell identifier. The value has to match with a spell identifier defined in Spell.dbc.' where `fieldId`= '1229' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The spell identifier.', `fieldNotes` = 'The spell identifier. The value has to match with a spell identifier defined in Spell.dbc.' where `fieldId`= '1230' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The spell identifier.', `fieldNotes` = 'The spell identifier. The value has to match with a spell identifier defined in Spell.dbc.' where `fieldId`= '1231' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The spell identifier.', `fieldNotes` = 'The spell identifier. The value has to match with a spell identifier defined in Spell.dbc.' where `fieldId`= '1232' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The total number of copies of an item or may reference another loot template', `fieldNotes` = 'Depending on the value of the field it may either define the minimum number of copies for the item to be dropped, or it may reference another loot template.' where `fieldId`= '1239' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to races that should get the spell. ', `fieldNotes` = 'A bit-mask corresponding to races that should get the spell. The value has to match with races defined in ChrRaces.dbc.' where `fieldId`= '1260' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to class that should get the spell.', `fieldNotes` = 'A bit-mask corresponding to class that should get the spell. The value has to match with classes defined in ChrClasses.dbc.' where `fieldId`= '1254' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The map ID (See Map.dbc)', `fieldNotes` = 'A map identifier. The value has to match with a map identifier defined in Map.dbc.' where `fieldId`= '1255' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A zone identifier.', `fieldNotes` = 'A zone identifier. The value has to match with a map identifier defined in AreaTable.dbc.' where `fieldId`= '1261' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The X position for the characters initial position.', `fieldNotes` = 'The X position for the characters initial position.' where `fieldId`= '1257' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The Y position for the characters initial position.', `fieldNotes` = 'The Y position for the characters initial position.' where `fieldId`= '1258' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The Z position for the characters initial position.', `fieldNotes` = 'The Z position for the characters initial position.' where `fieldId`= '1259' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The orientation for the characters initial position.', `fieldNotes` = 'The orientation for the characters initial position.' where `fieldId`= '1256' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to races that should get the spell.', `fieldNotes` = 'A bit-mask corresponding to races that should get the spell. The value has to match with races defined in ChrRaces.dbc.' where `fieldId`= '1265' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to class that should get the spell.', `fieldNotes` = 'A bit-mask corresponding to class that should get the spell. The value has to match with classes defined in ChrClasses.dbc.' where `fieldId`= '1264' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The ID of the button on the action ba.', `fieldNotes` = 'The ID of the button on the action bar where the action icon will be placed. Special bars are used for stances, auras, pets, stealth and other similar special modes.<br />¬subtable:112¬' where `fieldId`= '1263' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'See description in the lower half of this page..', `fieldNotes` = 'Depending on the type value, this could reference either a spell identifier as defined in Spell.dbc, a reference to the unique identifier of an “item_template” table, or the identifier for a macro.' where `fieldId`= '1262' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The following values are valid types:', `fieldNotes` = 'The following values are valid types:<br />¬subtable:113¬' where `fieldId`= '1266' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to races that should get the spell.', `fieldNotes` = 'A bit-mask corresponding to races that should get the spell. The value has to match with races defined in ChrRaces.dbc.' where `fieldId`= '1270' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to class that should get the spell.', `fieldNotes` = 'A bit-mask corresponding to class that should get the spell. The value has to match with classes defined in ChrClasses.dbc.' where `fieldId`= '1268' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The item a character should receive upon creation.', `fieldNotes` = 'The item a character should receive upon creation. This references the “item_template” table tables unique ID.' where `fieldId`= '1269' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of copies of the item to be awarded.', `fieldNotes` = 'The number of copies of the item to be awarded.' where `fieldId`= '1267' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to races that should get the spell. ', `fieldNotes` = 'A bit-mask corresponding to races that should get the spell. The value has to match with races defined in ChrRaces.dbc.' where `fieldId`= '1273' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to class that should get the spell.', `fieldNotes` = 'A bit-mask corresponding to class that should get the spell. The value has to match with classes defined in ChrClasses.dbc.' where `fieldId`= '1271' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The spell identifier.', `fieldNotes` = 'The spell identifier. The value has to match with a spell identifier defined in Spell.dbc.' where `fieldId`= '1274' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A note explaining what the spell is.', `fieldNotes` = 'A note explaining what the spell is. This is only for reference purposes.' where `fieldId`= '1272' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to races that should get the spell. ', `fieldNotes` = 'A bit-mask corresponding to races that should get the spell. The value has to match with races defined in ChrRaces.dbc.' where `fieldId`= '1248' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A bit-mask corresponding to class that should get the spell', `fieldNotes` = 'A bit-mask corresponding to class that should get the spell. The value has to match with classes defined in ChrClasses.dbc.' where `fieldId`= '1245' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The level at which the stats should be applied.', `fieldNotes` = 'The level at which the stats should be applied.' where `fieldId`= '1247' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The base strength of the character.', `fieldNotes` = 'The base strength of the character.' where `fieldId`= '1251' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The base agility of the character.', `fieldNotes` = 'The base agility of the character.' where `fieldId`= '1244' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The base stamina of the character.', `fieldNotes` = 'The base stamina of the character.' where `fieldId`= '1250' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The base intellect of the character.', `fieldNotes` = 'The base intellect of the character.' where `fieldId`= '1246' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The base spirit of the character.', `fieldNotes` = 'The base spirit of the character.' where `fieldId`= '1249' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The player’s level.', `fieldNotes` = 'The player’s level.' where `fieldId`= '1252' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The experience needed to upgrade from the value in lvl field to lvl +1.', `fieldNotes` = 'The experience needed to upgrade from the value in lvl field to lvl +1.' where `fieldId`= '1253' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Custom data to be sent for a point of interest. ', `fieldNotes` = 'Custom data to be sent for a point of interest. This currently is 0 for all points of interests in vanilla WoW.' where `fieldId`= '1275' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The text to display as tooltip for the icon on the in-game map.', `fieldNotes` = 'The text to display as tooltip for the icon on the in-game map.' where `fieldId`= '1279' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Faction ID of required faction to have max rep with.', `fieldNotes` = 'If a quest is obtainable if the character has a specific maximum reputation with a faction, this value is set to a faction identifier, referencing an entry from the Faction.dbc table.' where `fieldId`= '1378' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The highest reputation value allowed for obtaining the quest.', `fieldNotes` = 'If RequiredManRepFaction is defined, this value specifies the highest reputation value allowed for obtaining the quest.' where `fieldId`= '1379' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Recommended  number of players to complete quest. ', `fieldNotes` = 'If a quest would require more characters to cooperate for completing the quest - when the characters are in a valid level range - this value may be set to the amount of characters recommended to group up for completing the quest.' where `fieldId`= '1426' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The time limit to complete the quest.', `fieldNotes` = 'Setting this to a value in seconds will put a time limit on a quest, ticking from the moment a quest was accepted.' where `fieldId`= '1320' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The quest flags give additional details on the quest type.', `fieldNotes` = 'The quest flags give additional details on the quest type. Flags set here will determine mostly grouping behaviour. Multiple flags may be combined.<br /><br />The following table list known flags.<br />¬subtable:114¬<br />' where `fieldId`= '1344' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Flags used to define special behaviour.', `fieldNotes` = 'If quests need any special behaviour, these flags can be used to allow for it. Multiple special flags may be combined.<br /><br />Currently the following special cases are available.<br />¬subtable:115¬' where `fieldId`= '1421' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Quest ID of the preceding or an exisiting quest.', `fieldNotes` = 'This points to a "quest_template" table being a previous requirement. Depending on the signedness of the value, different requirements are set.<br /><br />If the value is > 0, the given quest needs to be completed prior to getting this quest.<br />If the value is < 0, the given quest has to be active in the quest log to get this quest.' where `fieldId`= '1343' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Quest ID of the follow-up quest (see description for more information)', `fieldNotes` = 'This points to a “quest_template” table being a follow-up. Depending on the signedness of the value, different requirements are set.<br /><br />If the value is > 0, this contains the quest identifier of the next quest, if setting the previous quest identifier on it is not sufficient.<br />If the value is < 0, this contains a quest identifier for quests where multiple follow-ups are possible. Previous quest identifier can be set to this quest identifier, too.' where `fieldId`= '1323' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This allows the grouping of multiple quests (see description).', `fieldNotes` = 'Allows to group multiple quests into a group, where only one quest can be completed from, or all quests need to be completed.<br /><br />If the value is > 0, all quests having this value set, will be put into a group of which only one quest may be completed to get this quest.<br />If the value is < 0, all quests having this value set, will be put into a group of which all quests have to be completed to get this quest.' where `fieldId`= '1318' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Quest ID of next quest in chain.', `fieldNotes` = 'If ending a quest should immediately start a new quest set this to a quest identifier referencing the “quest_template” table table.' where `fieldId`= '1324' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item ID of an item that the charcter starts the quest with.', `fieldNotes` = 'If starting a quest should give items to the character, set this field to an item identifier referencing the “item_template” table table.' where `fieldId`= '1423' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Total number of items (SrcItemId) the character starts off with', `fieldNotes` = 'If SrcItemId is set, this can be set to the amount of item copies to give to the character.' where `fieldId`= '1422' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID of the spell cast on the character on acceptance of the quest.', `fieldNotes` = 'If a spell should be casted on a character upon starting the quest, set this to a spell identifier referencing the Spell.dbc table.' where `fieldId`= '1424' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The title of the quest.', `fieldNotes` = 'The title of the quest.' where `fieldId`= '1427' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The quest text.', `fieldNotes` = 'The quest text, supporting a few variables to insert character related data into the quest’s text.<br />¬subtable:116¬' where `fieldId`= '1307' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The quest’s objective in text form. ', `fieldNotes` = 'The quest’s objective in text form. If the quest should auto-complete, leave this empty.' where `fieldId`= '1325' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The text sent to a character when talking to the quest giver.', `fieldNotes` = 'The text sent to a character when talking to the quest giver, and having completed the quest. Variables are supported.<br />¬subtable:117¬' where `fieldId`= '1338' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The text sent to a character when talking to a quest giver.', `fieldNotes` = 'The text sent to a character when talking to a quest giver, and not missing to fulfill the quest’s requirements. Variables are supported.<br />¬subtable:118¬' where `fieldId`= '1376' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'See description in the lower half of the page.', `fieldNotes` = 'If the quest’s SpecialFlag requires an action validated by the script library this text will be sent to the character.' where `fieldId`= '1316' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Set to a text string, to show up as requirement in the quest log entry.', `fieldNotes` = 'Set to a text string, to show up as requirement in the quest log entry.' where `fieldId`= '1326' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Set to a text string, to show up as requirement in the quest log entry.', `fieldNotes` = 'Set to a text string, to show up as requirement in the quest log entry.' where `fieldId`= '1327' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Set to a text string, to show up as requirement in the quest log entry.', `fieldNotes` = 'Set to a text string, to show up as requirement in the quest log entry.' where `fieldId`= '1328' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Set to a text string, to show up as requirement in the quest log entry.', `fieldNotes` = 'Set to a text string, to show up as requirement in the quest log entry.' where `fieldId`= '1329' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of an item required for quest completion.', `fieldNotes` = 'If set to an item identifier, this references an entry in the “item_template” table table which is required to complete the quest.' where `fieldId`= '1360' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of an item required for quest completion.', `fieldNotes` = 'If set to an item identifier, this references an entry in the “item_template” table table which is required to complete the quest.' where `fieldId`= '1361' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of an item required for quest completion.', `fieldNotes` = 'If set to an item identifier, this references an entry in the “item_template” table table which is required to complete the quest.' where `fieldId`= '1362' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of an item required for quest completion.', `fieldNotes` = 'If set to an item identifier, this references an entry in the “item_template” table table which is required to complete the quest.' where `fieldId`= '1363' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Amount of items (ReqItemId1)  needed to complete the quest.', `fieldNotes` = 'If ReqItemId1 is set, this defines the amount of items needed to complete the quest.' where `fieldId`= '1356' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Amount of items (ReqItemId2) needed to complete the quest.', `fieldNotes` = 'If ReqItemId2 is set, this defines the amount of items needed to complete the quest.' where `fieldId`= '1357' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Amount of items (ReqItemId3) needed to complete the quest', `fieldNotes` = 'If ReqItemId3 is set, this defines the amount of items needed to complete the quest.' where `fieldId`= '1358' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Amount of items (ReqItemId4) needed to complete the quest.', `fieldNotes` = 'If ReqItemId4 is set, this defines the amount of items needed to complete the quest.' where `fieldId`= '1359' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of the item required for making quest items', `fieldNotes` = 'If the quest requires items created by using another item, set this to an item identifier, referencing the creating items entry in the “item_template” table table.<br /><br /><b>NOTE:</b><br />This is required to decide if these items should be included in loot or not.' where `fieldId`= '1368' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of the item required for making quest items', `fieldNotes` = 'If the quest requires items created by using another item, set this to an item identifier, referencing the creating items entry in the “item_template” table table.<br /><br /><b>NOTE:</b><br />This is required to decide if these items should be included in loot or not.' where `fieldId`= '1369' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of the item required for making quest items', `fieldNotes` = 'If the quest requires items created by using another item, set this to an item identifier, referencing the creating items entry in the “item_template” table table.<br /><br /><b>NOTE:</b><br />This is required to decide if these items should be included in loot or not.' where `fieldId`= '1370' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of the item required for making quest items', `fieldNotes` = 'If the quest requires items created by using another item, set this to an item identifier, referencing the creating items entry in the “item_template” table table.<br /><br /><b>NOTE:</b><br />This is required to decide if these items should be included in loot or not.' where `fieldId`= '1371' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'If ReqSourceId1 is set, set this to the amount of required items.', `fieldNotes` = 'If ReqSourceId1 is set, set this to the amount of required items.' where `fieldId`= '1364' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'If ReqSourceId2 is set, set this to the amount of required items.', `fieldNotes` = 'If ReqSourceId2 is set, set this to the amount of required items.' where `fieldId`= '1365' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'If ReqSourceId3 is set, set this to the amount of required items.', `fieldNotes` = 'If ReqSourceId3 is set, set this to the amount of required items.' where `fieldId`= '1366' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'If ReqSourceId4 is set, set this to the amount of required items.', `fieldNotes` = 'If ReqSourceId4 is set, set this to the amount of required items.' where `fieldId`= '1367' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'ID of required creature or game object.', `fieldNotes` = 'If the quest targets creatures or game objects, this references their unique identifier.<br /><br />If the value is > 0, this references an entry in the “creature_template” table table.<br />If the value is < 0, this references an entry in the “gameobject_template” table table.' where `fieldId`= '1352' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'ID of required creature or game object.', `fieldNotes` = 'If the quest targets creatures or game objects, this references their unique identifier.<br /><br />If the value is > 0, this references an entry in the “creature_template” table table.<br />If the value is < 0, this references an entry in the “gameobject_template” table table.' where `fieldId`= '1353' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'ID of required creature or game object.', `fieldNotes` = 'If the quest targets creatures or game objects, this references their unique identifier.<br /><br />If the value is > 0, this references an entry in the “creature_template” table table.<br />If the value is < 0, this references an entry in the “gameobject_template” table table.' where `fieldId`= '1354' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'ID of required creature or game object.', `fieldNotes` = 'If the quest targets creatures or game objects, this references their unique identifier.<br /><br />If the value is > 0, this references an entry in the “creature_template” table table.<br />If the value is < 0, this references an entry in the “gameobject_template” table table.' where `fieldId`= '1355' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The amount of creatures or game objects required for the quest.', `fieldNotes` = 'The amount of creatures or game objects required for the quest.' where `fieldId`= '1348' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The amount of creatures or game objects required for the quest.', `fieldNotes` = 'The amount of creatures or game objects required for the quest.' where `fieldId`= '1349' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The amount of creatures or game objects required for the quest.', `fieldNotes` = 'The amount of creatures or game objects required for the quest.' where `fieldId`= '1350' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The amount of creatures or game objects required for the quest.', `fieldNotes` = 'The amount of creatures or game objects required for the quest.' where `fieldId`= '1351' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID of the spell that must be cast for the quest.', `fieldNotes` = 'Set to an entry referencing an entry from Spell.dbc table to require a spell to be cast. Spells usually need a target identifier set in the ReqCreatureOrGOId1.<br /><br />If a spell has an effect to send and event or signal quest completion, targets do not have to be set.' where `fieldId`= '1372' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID of the spell that must be cast for the quest.', `fieldNotes` = 'Set to an entry referencing an entry from Spell.dbc table to require a spell to be cast. Spells usually need a target identifier set in the ReqCreatureOrGOId2.<br /><br />If a spell has an effect to send and event or signal quest completion, targets do not have to be set.' where `fieldId`= '1373' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID of the spell that must be cast for the quest.', `fieldNotes` = 'Set to an entry referencing an entry from Spell.dbc table to require a spell to be cast. Spells usually need a target identifier set in the ReqCreatureOrGOId3.<br /><br />If a spell has an effect to send and event or signal quest completion, targets do not have to be set.' where `fieldId`= '1374' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID of the spell that must be cast for the quest.', `fieldNotes` = 'Set to an entry referencing an entry from Spell.dbc table to require a spell to be cast. Spells usually need a target identifier set in the ReqCreatureOrGOId4.<br /><br />If a spell has an effect to send and event or signal quest completion, targets do not have to be set.' where `fieldId`= '1375' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of one possible reward.', `fieldNotes` = 'If the quest allows to choose between multiple items as a reward, this field contains an item identifier of one of the possible rewards, referencing the item\'s entry in the “item_template” table table.' where `fieldId`= '1391' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of one possible reward.', `fieldNotes` = 'If the quest allows to choose between multiple items as a reward, this field contains an item identifier of one of the possible rewards, referencing the item\'s entry in the “item_template” table table.' where `fieldId`= '1392' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of one possible reward.', `fieldNotes` = 'If the quest allows to choose between multiple items as a reward, this field contains an item identifier of one of the possible rewards, referencing the item\'s entry in the “item_template” table table.' where `fieldId`= '1393' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of one possible reward.', `fieldNotes` = 'If the quest allows to choose between multiple items as a reward, this field contains an item identifier of one of the possible rewards, referencing the item\'s entry in the “item_template” table table.' where `fieldId`= '1394' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of one possible reward.', `fieldNotes` = 'If the quest allows to choose between multiple items as a reward, this field contains an item identifier of one of the possible rewards, referencing the item\'s entry in the “item_template” table table.' where `fieldId`= '1395' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of one possible reward.', `fieldNotes` = 'If the quest allows to choose between multiple items as a reward, this field contains an item identifier of one of the possible rewards, referencing the item\'s entry in the “item_template” table table.' where `fieldId`= '1396' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the number of charges available for the rewarded item.', `fieldNotes` = 'If RewChoiceItemId1 contains an item identifier, this defines the number of charges available for the rewarded item.' where `fieldId`= '1385' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the number of charges available for the rewarded item.', `fieldNotes` = 'If RewChoiceItemId2 contains an item identifier, this defines the number of charges available for the rewarded item.' where `fieldId`= '1386' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the number of charges available for the rewarded item.', `fieldNotes` = 'If RewChoiceItemId3 contains an item identifier, this defines the number of charges available for the rewarded item.' where `fieldId`= '1387' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the number of charges available for the rewarded item.', `fieldNotes` = 'If RewChoiceItemId4 contains an item identifier, this defines the number of charges available for the rewarded item.' where `fieldId`= '1388' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the number of charges available for the rewarded item.', `fieldNotes` = 'If RewChoiceItemId5 contains an item identifier, this defines the number of charges available for the rewarded item.' where `fieldId`= '1389' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the number of charges available for the rewarded item.', `fieldNotes` = 'If RewChoiceItemId6 contains an item identifier, this defines the number of charges available for the rewarded item.' where `fieldId`= '1390' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of the reward.', `fieldNotes` = 'If the quest rewards items without any choice, this contains an item identifier, referencing the item\'s entry in the “item_template” table.' where `fieldId`= '1401' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of the reward.', `fieldNotes` = 'If the quest rewards items without any choice, this contains an item identifier, referencing the item\'s entry in the “item_template” table.' where `fieldId`= '1402' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of the reward.', `fieldNotes` = 'If the quest rewards items without any choice, this contains an item identifier, referencing the item\'s entry in the “item_template” table.' where `fieldId`= '1403' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template Entry ID of the reward.', `fieldNotes` = 'If the quest rewards items without any choice, this contains an item identifier, referencing the item\'s entry in the “item_template” table.' where `fieldId`= '1404' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the amount if items to be rewarded.', `fieldNotes` = 'If RewItemId1 contains an item identifier, this defines the amount if items to be rewarded.' where `fieldId`= '1397' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the amount if items to be rewarded.', `fieldNotes` = 'If RewItemId2 contains an item identifier, this defines the amount if items to be rewarded.' where `fieldId`= '1398' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the amount if items to be rewarded.', `fieldNotes` = 'If RewItemId3 contains an item identifier, this defines the amount if items to be rewarded.' where `fieldId`= '1399' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the amount if items to be rewarded.', `fieldNotes` = 'If RewItemId4 contains an item identifier, this defines the amount if items to be rewarded.' where `fieldId`= '1400' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the faction ID of the faction whose rep is to be a reward.', `fieldNotes` = 'If the quest should reward reputation towards a faction, this references a faction identifier from the Faction.dbc table.<br /><br /><b>Note</b><br />This is intended to reward extra reputation. Normal reputation is awarded automatically by the server.' where `fieldId`= '1409' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the faction ID of the faction whose rep is to be a reward.', `fieldNotes` = 'If the quest should reward reputation towards a faction, this references a faction identifier from the Faction.dbc table.<br /><br /><b>Note</b><br />This is intended to reward extra reputation. Normal reputation is awarded automatically by the server.' where `fieldId`= '1410' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the faction ID of the faction whose rep is to be a reward.', `fieldNotes` = 'If the quest should reward reputation towards a faction, this references a faction identifier from the Faction.dbc table.<br /><br /><b>Note</b><br />This is intended to reward extra reputation. Normal reputation is awarded automatically by the server.' where `fieldId`= '1411' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the faction ID of the faction whose rep is to be a reward.', `fieldNotes` = 'If the quest should reward reputation towards a faction, this references a faction identifier from the Faction.dbc table.<br /><br /><b>Note</b><br />This is intended to reward extra reputation. Normal reputation is awarded automatically by the server.' where `fieldId`= '1412' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the faction ID of the faction whose rep is to be a reward.', `fieldNotes` = 'If the quest should reward reputation towards a faction, this references a faction identifier from the Faction.dbc table.<br /><br /><b>Note</b><br />This is intended to reward extra reputation. Normal reputation is awarded automatically by the server.' where `fieldId`= '1413' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the amount of reputation gain or loss for the referenced faction.', `fieldNotes` = 'If RewRepFaction1 references a faction, this defines the amount of reputation gain or loss for the referenced faction.' where `fieldId`= '1414' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the amount of reputation gain or loss for the referenced faction.', `fieldNotes` = 'If RewRepFaction2 references a faction, this defines the amount of reputation gain or loss for the referenced faction.' where `fieldId`= '1415' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the amount of reputation gain or loss for the referenced faction.', `fieldNotes` = 'If RewRepFaction3 references a faction, this defines the amount of reputation gain or loss for the referenced faction.' where `fieldId`= '1416' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the amount of reputation gain or loss for the referenced faction.', `fieldNotes` = 'If RewRepFaction4 references a faction, this defines the amount of reputation gain or loss for the referenced faction.' where `fieldId`= '1417' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the amount of reputation gain or loss for the referenced faction.', `fieldNotes` = 'If RewRepFaction5 references a faction, this defines the amount of reputation gain or loss for the referenced faction.' where `fieldId`= '1418' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required money for starting the quest, or award money for completing the quest.', `fieldNotes` = 'This field can be used to either require money for starting the quest, or award money for completing the quest.<br /><br />If set to a value > 0, the quest will reward money upon completion<br />If set to a value < 0, the quest will require money to accept it.' where `fieldId`= '1408' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The amount of experience or money to be rewarded.', `fieldNotes` = 'The value of this field decides how much experience or money (at level 60) a quest will reward.<br /><br />Experience is calculated as follows: RewMoneyMaxLevel / 0.6' where `fieldId`= '1407' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID of spell to be cast as a reward.', `fieldNotes` = 'If a spell should be shown as being casted as quest reward, set this to a spell identifier referencing the Spell.dbc table.<br /><br /><b>Note</b><br />If RewSpellCast is set, this spell will only be shown, but not cast.' where `fieldId`= '1419' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID of additional spell to be cast, different to RewSpell.', `fieldNotes` = 'If a spell should be cast as a quest reward different from the spell shown as quest reward, set this to a spell identifier referencing the Spell.dbc table.' where `fieldId`= '1420' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'mail_loot_template Entry ID of mail to be sent as a reward.', `fieldNotes` = 'If upon completion a quest should send out mail, this can be set to reference a mail template identifier in the MailTemplate.dbc table.' where `fieldId`= '1406' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of seconds to wait before sending the reward mail.', `fieldNotes` = 'The number of seconds to wait before sending the reward mail.' where `fieldId`= '1405' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A location (POI) to be highlighted on the map while the quest is active.', `fieldNotes` = 'References an entry in the points_of_interest (POI) table, if it should be shown while the quest is active.' where `fieldId`= '1339' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'X coordinate of quest POI.', `fieldNotes` = 'If a point of interest should be shown while the quest is active, this will contain the X coordinate.' where `fieldId`= '1341' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Y coordinate of quest POI.', `fieldNotes` = 'If a point of interest should be shown while the quest is active, this will contain the Y coordinate.' where `fieldId`= '1342' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references  the emote to be shown upon displaying quest details.', `fieldNotes` = 'If an emote should be shown upon displaying quest details, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1308' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references  the emote to be shown upon displaying quest details.', `fieldNotes` = 'If an emote should be shown upon displaying quest details, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1309' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references  the emote to be shown upon displaying quest details.', `fieldNotes` = 'If an emote should be shown upon displaying quest details, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1310' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references  the emote to be shown upon displaying quest details.', `fieldNotes` = 'If an emote should be shown upon displaying quest details, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1311' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of seconds to delay the emote.', `fieldNotes` = 'The number of seconds to delay the emote, if one is referenced in the DetailsEmote1 column.' where `fieldId`= '1312' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of seconds to delay the emote.', `fieldNotes` = 'The number of seconds to delay the emote, if one is referenced in the DetailsEmote2 column.' where `fieldId`= '1313' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of seconds to delay the emote.', `fieldNotes` = 'The number of seconds to delay the emote, if one is referenced in the DetailsEmote3 column.' where `fieldId`= '1314' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of seconds to delay the emote.', `fieldNotes` = 'The number of seconds to delay the emote, if one is referenced in the DetailsEmote4 column.' where `fieldId`= '1315' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references the emotes identifier in the Emotes.dbc table.', `fieldNotes` = 'If an emote should be shown upon displaying the incomplete quest text, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1319' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references the emotes identifier in the Emotes.dbc table.', `fieldNotes` = 'If an emote should be shown upon displaying the quest completion text, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1305' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Emotes.dbc ID of emote to be shown on quest completion.', `fieldNotes` = 'If an emote should be shown upon displaying rewarding the quest, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1330' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Emotes.dbc ID of emote to be shown on quest completion.', `fieldNotes` = 'If an emote should be shown upon displaying rewarding the quest, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1331' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Emotes.dbc ID of emote to be shown on quest completion.', `fieldNotes` = 'If an emote should be shown upon displaying rewarding the quest, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1332' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Emotes.dbc ID of emote to be shown on quest completion.', `fieldNotes` = 'If an emote should be shown upon displaying rewarding the quest, this references the emotes identifier in the Emotes.dbc table.' where `fieldId`= '1333' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of seconds to delay before the emote is actioned.', `fieldNotes` = 'The number of seconds to delay before the emote is actioned, if one is referenced in the OfferRewardEmote1 column.' where `fieldId`= '1334' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of seconds to delay before the emote is actioned.', `fieldNotes` = 'The number of seconds to delay before the emote is actioned, if one is referenced in the OfferRewardEmote2 column.' where `fieldId`= '1335' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of seconds to delay before the emote is actioned.', `fieldNotes` = 'The number of seconds to delay before the emote is actioned,  if one is referenced in the OfferRewardEmote3 column.' where `fieldId`= '1336' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The number of seconds to delay before the emote is actioned.', `fieldNotes` = 'The number of seconds to delay before the emote is actioned,  if one is referenced in the OfferRewardEmote4 column.' where `fieldId`= '1337' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'dbscripts_on_quest_start Entry ID of the script to be run at quest start.', `fieldNotes` = 'If a script should be executed on quest start, this references an entry in the "dbscripts_on_quest_start" table.' where `fieldId`= '1425' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'dbscripts_on_quest_start Entry ID of the script to be run at quest end.', `fieldNotes` = 'If a script should be executed on quest end, this references an entry in the “dbscripts_on_quest_end” table .' where `fieldId`= '1306' and `languageId`= 0;



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