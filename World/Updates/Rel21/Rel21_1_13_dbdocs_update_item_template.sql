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
    SET @cOldContent = '12'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '1';
    SET @cNewContent = '13';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'item_template_dbdocs_update';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'New subtables added, and Notes and field comments added to the item_template table';

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

DELETE FROM `dbdocssubtables` WHERE `subtableId`= 102 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (102,0,'Required Honor Rank','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Required rank</b></th>
<th><b>Horde rank</b></th>
<th><b>Officer rank</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0!Unranked</td><td align=\'center\' valign=\'middle\'>No</td></tr>
</table>
','Value||Required rank|Horde rank|Officer rank
0!Unranked| |No');
DELETE FROM `dbdocssubtables` WHERE `subtableId`= 102 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (102,0,'Required Honor Rank','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Required rank</b></th>
<th><b>Horde rank</b></th>
<th><b>Officer rank</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0!Unranked</td><td align=\'center\' valign=\'middle\'>No</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>Private</td><td align=\'center\' valign=\'middle\'>Scout</td><td align=\'center\' valign=\'middle\'>No</td></tr>
</table>
','Value||Required rank|Horde rank|Officer rank
0!Unranked| |No
5|Private|Scout|No');
DELETE FROM `dbdocssubtables` WHERE `subtableId`= 102 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (102,0,'Required Honor Rank','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Required rank</b></th>
<th><b>Horde rank</b></th>
<th><b>Officer rank</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>Unranked</td><td align=\'center\' valign=\'middle\'>&nbsp</td><td align=\'center\' valign=\'middle\'>No</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>Private</td><td align=\'center\' valign=\'middle\'>Scout</td><td align=\'center\' valign=\'middle\'>No</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'center\' valign=\'middle\'>Corporal</td><td align=\'center\' valign=\'middle\'>Grunt</td><td align=\'center\' valign=\'middle\'>No</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'center\' valign=\'middle\'>Sergeant</td><td align=\'center\' valign=\'middle\'>Sergeant</td><td align=\'center\' valign=\'middle\'>No</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>Master Sergeant</td><td align=\'center\' valign=\'middle\'>Senior Sergeant</td><td align=\'center\' valign=\'middle\'>No</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>9</td><td align=\'center\' valign=\'middle\'>Sergeant Major</td><td align=\'center\' valign=\'middle\'>First Sergeant</td><td align=\'center\' valign=\'middle\'>No</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>10</td><td align=\'center\' valign=\'middle\'>Knight</td><td align=\'center\' valign=\'middle\'>Stone Guard</td><td align=\'center\' valign=\'middle\'>Yes</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>11</td><td align=\'center\' valign=\'middle\'>Knight-Lieutenant</td><td align=\'center\' valign=\'middle\'>Blood Guard</td><td align=\'center\' valign=\'middle\'>Yes</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>12</td><td align=\'center\' valign=\'middle\'>Knight-Captain</td><td align=\'center\' valign=\'middle\'>Legionnaire</td><td align=\'center\' valign=\'middle\'>Yes</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>13</td><td align=\'center\' valign=\'middle\'>Knight-Champion</td><td align=\'center\' valign=\'middle\'>Centurion</td><td align=\'center\' valign=\'middle\'>Yes</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>14</td><td align=\'center\' valign=\'middle\'>Lieutenant-Commander</td><td align=\'center\' valign=\'middle\'>Champion</td><td align=\'center\' valign=\'middle\'>Yes</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>15</td><td align=\'center\' valign=\'middle\'>Commander</td><td align=\'center\' valign=\'middle\'>Lieutenant General</td><td align=\'center\' valign=\'middle\'>Yes</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'center\' valign=\'middle\'>Marshal</td><td align=\'center\' valign=\'middle\'>General</td><td align=\'center\' valign=\'middle\'>Yes</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>17</td><td align=\'center\' valign=\'middle\'>Field Marshal</td><td align=\'center\' valign=\'middle\'>Warlord</td><td align=\'center\' valign=\'middle\'>Yes</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>18</td><td align=\'center\' valign=\'middle\'>Grand Marshal</td><td align=\'center\' valign=\'middle\'>High Warlord</td><td align=\'center\' valign=\'middle\'>Yes</td></tr>
</table>
','Value||Required rank|Horde rank|Officer rank
0|Unranked| &nbsp|No
5|Private|Scout||No
6|Corporal|Grunt|No
7|Sergeant|Sergeant|No
8|Master Sergeant|Senior Sergeant|No
9|Sergeant Major|First Sergeant|No
10|Knight|Stone Guard|Yes
11|Knight-Lieutenant|Blood Guard|Yes
12|Knight-Captain|Legionnaire|Yes
13|Knight-Champion|Centurion|Yes
14|Lieutenant-Commander|Champion|Yes
15|Commander|Lieutenant General|Yes
16|Marshal|General|Yes
17|Field Marshal|Warlord|Yes
18|Grand Marshal|High Warlord|Yes');
DELETE FROM `dbdocssubtables` WHERE `subtableId`= 103 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (103,0,'Stat Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>No stats</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>Health</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'center\' valign=\'middle\'>Agility</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>Strength</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>Intellect</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'center\' valign=\'middle\'>Spirit</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'center\' valign=\'middle\'>Stamina</td></tr>
</table>
','Value|Description
0|No stats
1|Health
3|Agility
4|Strength
5|Intellect
6|Spirit
7|Stamina');
DELETE FROM `dbdocssubtables` WHERE `subtableId`= 105 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (105,0,'Damage Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>Physical</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>Holy</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>Fire</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'center\' valign=\'middle\'>Nature</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>Frost</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>Shadow</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'center\' valign=\'middle\'>Arcane</td></tr>
</table>
','Value|Description
0|Physical
1|Holy
2|Fire
3|Nature
4|Frost
5|Shadow
6|Arcane');
DELETE FROM `dbdocssubtables` WHERE `subtableId`= 106 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (106,0,'Spell Trigger','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>On use</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>On equip</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>Chance on hit</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>Soulstone</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>On use without delay</td></tr>
</table>
','Value|Description
0|On use
1|On equip
2|Chance on hit
4|Soulstone
5|On use without delay');
DELETE FROM `dbdocssubtables` WHERE `subtableId`= 107 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (107,0,'Bonding','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>No binding</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>Bind on pickup</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>Bind on equip</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'center\' valign=\'middle\'>Bind on use</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>Quest item</td></tr>
</table>
','Value|Description
0|No binding
1|Bind on pickup
2|Bind on equip
3|Bind on use
4|Quest item');
DELETE FROM `dbdocssubtables` WHERE `subtableId`= 108 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (108,0,'Extra Flags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>Nothing special</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>Item is not consumable</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>Item will be deleted in real time, when Duration is set</td></tr>
</table>
','Value|Description
0|Nothing special
1|Item is not consumable
2|Item will be deleted in real time, when Duration is set');
        
        
-- dbocsfields
-- -- -- -- --
UPDATE `dbdocsfields` SET `FieldComment` = 'The subclass of the item template.', `fieldNotes` = 'The subclass of the item template.' WHERE `fieldId`= '799' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The subclass of the item template.', `fieldNotes` = 'The subclass of the item template.' WHERE `fieldId`= '799' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'DEPRECATED: the city rank required. City ranks did not make it into WoW.', `fieldNotes` = 'DEPRECATED: the city rank required. City ranks did not make it into WoW.' WHERE `fieldId`= '730' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Defines the amount of slots for items of type container or ammunition container.', `fieldNotes` = 'Defines the amount of slots for items of type container or ammunition container.' WHERE `fieldId`= '684' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '779' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '781' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '782' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '783' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '784' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '785' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '786' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '787' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '788' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. ' WHERE `fieldId`= '780' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '791' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '789' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '792' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '793' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '794' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '795' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '796' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '797' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '798' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value to add for the matching modifier.', `fieldNotes` = 'The value to add for the matching modifier.' WHERE `fieldId`= '790' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The minimum damage caused by the item.', `fieldNotes` = 'The minimum damage caused by the item.' WHERE `fieldId`= '694' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The minimum damage caused by the item.', `fieldNotes` = 'The minimum damage caused by the item.' WHERE `fieldId`= '695' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The minimum damage caused by the item.', `fieldNotes` = 'The minimum damage caused by the item.' WHERE `fieldId`= '696' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The minimum damage caused by the item.', `fieldNotes` = 'The minimum damage caused by the item.' WHERE `fieldId`= '697' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The minimum damage caused by the item.', `fieldNotes` = 'The minimum damage caused by the item.' WHERE `fieldId`= '698' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The maximum damage caused by the item.', `fieldNotes` = 'The maximum damage caused by the item.' WHERE `fieldId`= '690' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The maximum damage caused by the item.', `fieldNotes` = 'The maximum damage caused by the item.' WHERE `fieldId`= '689' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The maximum damage caused by the item.', `fieldNotes` = 'The maximum damage caused by the item.' WHERE `fieldId`= '691' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The maximum damage caused by the item.', `fieldNotes` = 'The maximum damage caused by the item.' WHERE `fieldId`= '692' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The maximum damage caused by the item.', `fieldNotes` = 'The maximum damage caused by the item.' WHERE `fieldId`= '693' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of damage the matching dmg_min/dmg_max fields cause.', `fieldNotes` = 'The type of damage the matching dmg_min/dmg_max fields cause.' WHERE `fieldId`= '699' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of damage the matching dmg_min/dmg_max fields cause.', `fieldNotes` = 'The type of damage the matching dmg_min/dmg_max fields cause.' WHERE `fieldId`= '700' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of damage the matching dmg_min/dmg_max fields cause.', `fieldNotes` = 'The type of damage the matching dmg_min/dmg_max fields cause.' WHERE `fieldId`= '701' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of damage the matching dmg_min/dmg_max fields cause.', `fieldNotes` = 'The type of damage the matching dmg_min/dmg_max fields cause.' WHERE `fieldId`= '702' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of damage the matching dmg_min/dmg_max fields cause.', `fieldNotes` = 'The type of damage the matching dmg_min/dmg_max fields cause.' WHERE `fieldId`= '703' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The armor value of the item.', `fieldNotes` = 'The armor value of the item.' WHERE `fieldId`= '677' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Holy resistance.', `fieldNotes` = 'Holy resistance.' WHERE `fieldId`= '711' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Fire resistance.', `fieldNotes` = 'Fire resistance.' WHERE `fieldId`= '707' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Nature resistance.', `fieldNotes` = 'Nature resistance.' WHERE `fieldId`= '724' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Frost resistance.', `fieldNotes` = 'Frost resistance.' WHERE `fieldId`= '710' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Shadow resistance.', `fieldNotes` = 'Shadow resistance.' WHERE `fieldId`= '740' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Arcane resistance.', `fieldNotes` = 'Arcane resistance.' WHERE `fieldId`= '675' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The delay in milliseconds between successive hits for the item.', `fieldNotes` = 'The delay in milliseconds between successive hits for the item.' WHERE `fieldId`= '685' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of ammunition the item uses. Arrows = 2; Bullets = 3', `fieldNotes` = 'The type of ammunition the item uses. Arrows = 2; Bullets = 3' WHERE `fieldId`= '674' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = '', `fieldNotes` = '' WHERE `fieldId`= '729' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If the item can cast or trigger a spell, this is the reference.', `fieldNotes` = 'If the item can cast or trigger a spell, this references the spell’s entry in Spell.dbc.' WHERE `fieldId`= '762' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'd', `fieldNotes` = 'd' WHERE `fieldId`= '729' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'zzzz', `fieldNotes` = 'zzzz' WHERE `fieldId`= '729' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of trigger for the matching spellid entry.', `fieldNotes` = 'The type of trigger for the matching spellid entry.' WHERE `fieldId`= '772' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The amount of charges for the spell referenced in the matching spellid entry. ', `fieldNotes` = 'The amount of charges for the spell referenced in the matching spellid entry. ' WHERE `fieldId`= '752' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The proc per minute rate.', `fieldNotes` = 'The proc per minute rate controlling how often the spell is triggered (if #spelltrigger == 2).' WHERE `fieldId`= '767' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '757' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'This controls the proc per minute rate for a spell.', `fieldNotes` = 'If the matching spelltrigger field is of type 2, this controls the proc per minute rate for a spell.' WHERE `fieldId`= '767' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'A spell category identifier.', `fieldNotes` = 'A spell category identifier. The value has to match with a category identifier defined in SpellCategory.dbc.' WHERE `fieldId`= '742' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell category.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell category. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '747' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If the item can cast or trigger a spell, this is the references.', `fieldNotes` = 'If the item can cast or trigger a spell, this references the spell\'s entry in Spell.dbc.' WHERE `fieldId`= '763' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If the item can cast or trigger a spell, this is the references.', `fieldNotes` = 'If the item can cast or trigger a spell, this references the spell\'s entry in Spell.dbc.' WHERE `fieldId`= '764' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If the item can cast or trigger a spell, this is the references.', `fieldNotes` = 'If the item can cast or trigger a spell, this references the spell\'s entry in Spell.dbc.' WHERE `fieldId`= '765' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If the item can cast or trigger a spell, this is the references.', `fieldNotes` = 'If the item can cast or trigger a spell, this references the spell\'s entry in Spell.dbc.' WHERE `fieldId`= '766' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of trigger for the matching spellid entry.', `fieldNotes` = 'The type of trigger for the matching spellid entry.' WHERE `fieldId`= '773' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of trigger for the matching spellid entry.', `fieldNotes` = 'The type of trigger for the matching spellid entry.' WHERE `fieldId`= '774' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of trigger for the matching spellid entry.', `fieldNotes` = 'The type of trigger for the matching spellid entry.' WHERE `fieldId`= '775' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of trigger for the matching spellid entry.', `fieldNotes` = 'The type of trigger for the matching spellid entry.' WHERE `fieldId`= '776' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The amount of charges for the spell referenced in the matching spellid entry. ', `fieldNotes` = 'The amount of charges for the spell referenced in the matching spellid entry. ' WHERE `fieldId`= '754' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The amount of charges for the spell referenced in the matching spellid entry. ', `fieldNotes` = 'The amount of charges for the spell referenced in the matching spellid entry. ' WHERE `fieldId`= '755' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The amount of charges for the spell referenced in the matching spellid entry. ', `fieldNotes` = 'The amount of charges for the spell referenced in the matching spellid entry. ' WHERE `fieldId`= '756' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'This controls the proc per minute rate for a spell.', `fieldNotes` = 'If the matching spelltrigger field is of type 2, this controls the proc per minute rate for a spell.' WHERE `fieldId`= '768' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'This controls the proc per minute rate for a spell.', `fieldNotes` = 'If the matching spelltrigger field is of type 2, this controls the proc per minute rate for a spell.' WHERE `fieldId`= '769' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'This controls the proc per minute rate for a spell.', `fieldNotes` = 'If the matching spelltrigger field is of type 2, this controls the proc per minute rate for a spell.' WHERE `fieldId`= '770' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'This controls the proc per minute rate for a spell.', `fieldNotes` = 'If the matching spelltrigger field is of type 2, this controls the proc per minute rate for a spell.' WHERE `fieldId`= '771' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '760' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '759' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '758' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The amount of charges for the spell referenced in the matching spellid entry. ', `fieldNotes` = 'The amount of charges for the spell referenced in the matching spellid entry. ' WHERE `fieldId`= '753' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '761' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'A spell category identifier.', `fieldNotes` = 'A spell category identifier. The value has to match with a category identifier defined in SpellCategory.dbc.' WHERE `fieldId`= '743' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'A spell category identifier.', `fieldNotes` = 'A spell category identifier. The value has to match with a category identifier defined in SpellCategory.dbc.' WHERE `fieldId`= '744' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'A spell category identifier.', `fieldNotes` = 'A spell category identifier. The value has to match with a category identifier defined in SpellCategory.dbc.' WHERE `fieldId`= '745' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'A spell category identifier.', `fieldNotes` = 'A spell category identifier. The value has to match with a category identifier defined in SpellCategory.dbc.' WHERE `fieldId`= '746' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell category.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell category. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '748' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell category.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell category. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '749' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell category.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell category. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '750' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The cooldown in milliseconds for the matching spell category.', `fieldNotes` = 'The cooldown in milliseconds for the matching spell category. If set to -1, the default cooldown from the Spell.dbc table will be used.' WHERE `fieldId`= '751' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Defines if and how and item will be bound to a character. ', `fieldNotes` = 'Defines if and how and item will be bound to a character. ' WHERE `fieldId`= '680' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'A short - usually one sentence - description of the item. Mostly flavor texts.', `fieldNotes` = 'A short - usually one sentence - description of the item. Mostly flavor texts.' WHERE `fieldId`= '686' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If the item should be readable, e.g. for letters.', `fieldNotes` = 'If the item should be readable, e.g. for letters, this references a page text identifier in the “page_text” table table.' WHERE `fieldId`= '726' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The material to be used as background for items with page texts set.', `fieldNotes` = 'The material to be used as background for items with page texts set. This references a page text material identifier from PageTextMaterial.dbc.' WHERE `fieldId`= '715' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The material to be used as background for items with page texts set.', `fieldNotes` = 'The material to be used as background for items with page texts set. This references a page text material identifier from PageTextMaterial.dbc.' WHERE `fieldId`= '725' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value of this field controls how characters will show or hide items worn.', `fieldNotes` = 'The value of this field controls how characters will show or hide items worn, e.g. for weapons. ' WHERE `fieldId`= '741' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If an item is a shield, this field holds the block chance.', `fieldNotes` = 'If an item is a shield, this field holds the block chance.' WHERE `fieldId`= '679' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If an item is part of an item set, this references the item set’s identifier.', `fieldNotes` = 'If an item is part of an item set, this references the item set’s identifier in the ItemSet.dbc table.' WHERE `fieldId`= '714' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The maximum durability for an item.', `fieldNotes` = 'The maximum durability for an item.' WHERE `fieldId`= '720' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If an item is only usable on a specific map, this is the reference.', `fieldNotes` = 'If an item is only usable on a specific map, this reference a map identifier in the Map.dbc table.' WHERE `fieldId`= '676' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If an item is only usable on a specific map, this is the reference.', `fieldNotes` = 'If an item is only usable on a specific map, this reference a map identifier in the Map.dbc table.' WHERE `fieldId`= '717' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If an item is a bag, this holds a bit-mask corresponding to bag families.', `fieldNotes` = 'If an item is a bag, this holds a bit-mask corresponding to bag families to which the bag belongs. The value has to match with bag families defined in ItemBagFamily.dbc.' WHERE `fieldId`= '678' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'If an item is usable as pet food, this table is the reference.', `fieldNotes` = 'If an item is usable as pet food, this table references an entry in the ItemPetFood.dbc table.' WHERE `fieldId`= '709' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'This field specifies the minimum amount in a container holding money.', `fieldNotes` = 'If an item is a container holding money, this field specifies the minimum amount of money in copper possibly looted.' WHERE `fieldId`= '722' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'This field specifies the maximum amount in a container holding money.', `fieldNotes` = 'If an item is a container holding money, this field specifies the maximum amount of money in copper possibly looted.' WHERE `fieldId`= '721' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Duration before item is removed from a character’s inventory.', `fieldNotes` = 'Items may have a duration set until the get removed from a character’s inventory.' WHERE `fieldId`= '704' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'With these flags it is possible to set rare conditions on an item. ', `fieldNotes` = 'With these flags it is possible to set rare conditions on an item. ' WHERE `fieldId`= '706' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The subclass of the item template.', `fieldNotes` = 'The subclass of the item template.<br />¬subtable:17¬' WHERE `fieldId`= '799' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Required honor rank.', `fieldNotes` = 'Required honor rank.<br />¬subtable:102¬' WHERE `fieldId`= '731' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Required skill value.', `fieldNotes` = 'Value of the skill required to use the item.<br />¬subtable:102¬' WHERE `fieldId`= '736' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '779' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '782' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '781' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '783' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '784' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '785' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '786' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '787' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '788' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'An item modifier to apply for this item. ', `fieldNotes` = 'An item modifier to apply for this item. <br />¬subtable:103¬' WHERE `fieldId`= '780' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of damage the matching dmg_min/dmg_max fields cause.', `fieldNotes` = 'The type of damage the matching dmg_min/dmg_max fields cause.<br />¬subtable:105¬' WHERE `fieldId`= '699' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of damage the matching dmg_min/dmg_max fields cause.', `fieldNotes` = 'The type of damage the matching dmg_min/dmg_max fields cause.<br />¬subtable:105¬' WHERE `fieldId`= '701' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of damage the matching dmg_min/dmg_max fields cause.', `fieldNotes` = 'The type of damage the matching dmg_min/dmg_max fields cause.<br />¬subtable:105¬' WHERE `fieldId`= '702' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of damage the matching dmg_min/dmg_max fields cause.', `fieldNotes` = 'The type of damage the matching dmg_min/dmg_max fields cause.<br />¬subtable:105¬' WHERE `fieldId`= '703' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The type of trigger for the matching spellid entry.', `fieldNotes` = 'The type of trigger for the matching spellid entry.<br />¬subtable:106¬' WHERE `fieldId`= '772' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'Defines if and how and item will be bound to a character. ', `fieldNotes` = 'Defines if and how and item will be bound to a character. <br />¬subtable:107¬' WHERE `fieldId`= '680' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'The value of this field controls how characters will show or hide items worn, e.', `fieldNotes` = 'The value of this field controls how characters will show or hide items worn, e.g. for weapons. <br />¬subtable:20¬' WHERE `fieldId`= '741' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'With these flags it is possible to set rare conditions on an item. ', `fieldNotes` = 'With these flags it is possible to set rare conditions on an item. <br />¬subtable:108¬' WHERE `fieldId`= '706' AND `languageId`= 0;

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