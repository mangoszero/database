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
    SET @cOldContent = '21'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '1';
    SET @cNewContent = '22';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'dbdocs updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Added New subtables and replace missing subtable';

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
delete from `dbdocssubtables` where `subtableId`= 13 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (13,0,'Sheath State','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>State</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>All weapons sheathed</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Melee weapon unsheathed</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Ranged weapon unsheathed</td></tr>
</table>
','Value|<State
0|All weapons sheathed 
1|Melee weapon unsheathed 
2|Ranged weapon unsheathed 
');
delete from `dbdocssubtables` where `subtableId`= 109 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (109,0,'Dummy2','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>ID</b></th>
<th align=\'left\'><b>Type</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Idle; stay in one place</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Random movement inside the spawndist radius</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Waypoint movement</td></tr>
</table>
','ID|<Type
0|Idle; stay in one place
1|Random movement inside the spawndist radius
2|Waypoint movement');
delete from `dbdocssubtables` where `subtableId`= 9 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (9,0,'Civilian Flag','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>No civilian</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Civilian</td></tr>
</table>
','Value|<Description
0|No civilian 
1|Civilian 
');
delete from `dbdocssubtables` where `subtableId`= 8 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (8,0,'Inhabit Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>ID</b></th>
<th align=\'left\'><b>Family</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Ground Movement Only</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Water Movement Only</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Both Ground and Water Movement</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Always Flying</td></tr>
</table>
','ID|<Family
1|Ground Movement Only
2|Water Movement Only
3|Both Ground and Water Movement
4|Always Flying');
delete from `dbdocssubtables` where `subtableId`= 7 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (7,0,'Racial Leader Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Normal creature</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Racial leader</td></tr>
</table>
','Value|<Description
0|Normal creature 
1|Racial leader 
');
delete from `dbdocssubtables` where `subtableId`= 25 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (25,0,'Creature Family','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>ID</b></th>
<th align=\'left\'><b>Family</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Wolf</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Cat</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Spider</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Bear</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Boar</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Crocolisk</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>Carrion Bird</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>Crab</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>9</td><td align=\'left\' valign=\'middle\'>Gorilla</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>11</td><td align=\'left\' valign=\'middle\'>Raptor</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>12</td><td align=\'left\' valign=\'middle\'>Tallstrider</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>15</td><td align=\'left\' valign=\'middle\'>Felhunter</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>Voidwalker</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>17</td><td align=\'left\' valign=\'middle\'>Succubus</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>19</td><td align=\'left\' valign=\'middle\'>Doomguard</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>20</td><td align=\'left\' valign=\'middle\'>Scorpid</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>21</td><td align=\'left\' valign=\'middle\'>Turtle</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>23</td><td align=\'left\' valign=\'middle\'>Imp</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>24</td><td align=\'left\' valign=\'middle\'>Bat</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>25</td><td align=\'left\' valign=\'middle\'>Hyena</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>26</td><td align=\'left\' valign=\'middle\'>Owl</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>27</td><td align=\'left\' valign=\'middle\'>Wind Serpent</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>28</td><td align=\'left\' valign=\'middle\'>Remote Control</td></tr>
</table>
','ID|<Family
1|Wolf
2|Cat
3|Spider
4|Bear
5|Boar
6|Crocolisk
7|Carrion Bird
8|Crab
9|Gorilla
11|Raptor
12|Tallstrider
15|Felhunter
16|Voidwalker
17|Succubus
19|Doomguard
20|Scorpid
21|Turtle
23|Imp
24|Bat
25|Hyena
26|Owl
27|Wind Serpent
28|Remote Control');
delete from `dbdocssubtables` where `subtableId`= 26 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (26,0,'Creature Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>ID</b></th>
<th align=\'left\'><b>Family</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>None</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Beast</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Dragonkin</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Demon</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Elemental</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Giant</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Undead</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>Humanoid</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>Critter</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>9</td><td align=\'left\' valign=\'middle\'>Mechanical</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>10</td><td align=\'left\' valign=\'middle\'>Not Specified</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>11</td><td align=\'left\' valign=\'middle\'>Totem</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>12</td><td align=\'left\' valign=\'middle\'>Non-combat pet</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>13</td><td align=\'left\' valign=\'middle\'>Gas Cloud</td></tr>
</table>
','ID|<Family
0|None
1|Beast
2|Dragonkin
3|Demon
4|Elemental
5|Giant
6|Undead
7|Humanoid
8|Critter
9|Mechanical
10|Not Specified
11|Totem
12|Non-combat pet
13|Gas Cloud');
delete from `dbdocssubtables` where `subtableId`= 108 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (108,0,'Extra Flags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Nothing special</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Item is not consumable</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Item will be deleted in real time, when Duration is set</td></tr>
</table>
','Value|<Description

0|Nothing special

1|Item is not consumable

2|Item will be deleted in real time, when Duration is set');
delete from `dbdocssubtables` where `subtableId`= 45 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (45,0,'Spell Linked Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Type name</b></th>
<th><b>Value</b></th>
<th align=\'left\'><b>Meaning</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_NONE</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Ignored</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_BOOST</td><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_PRECAST</td><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Triggered before spellcast</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_TRIGGERED</td><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Cast on cast, i.e. triggering</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_PROC</td><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Cast on aura proc</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_REMOVEONCAST</td><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Remove aura on cast</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_REMOVEONREMOVE</td><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Remove aura on remove another aura</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_CASTONREMOVE</td><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>Cast on remove another aura</td></tr>
</table>
','<Type name|Value|<Meaning
SPELL_LINKED_TYPE_NONE|0|Ignored
SPELL_LINKED_TYPE_BOOST|1|&nbsp;|
SPELL_LINKED_TYPE_PRECAST|2|Triggered before spellcast
SPELL_LINKED_TYPE_TRIGGERED|3|Cast on cast, i.e. triggering
SPELL_LINKED_TYPE_PROC|4|Cast on aura proc
SPELL_LINKED_TYPE_REMOVEONCAST|5|Remove aura on cast
SPELL_LINKED_TYPE_REMOVEONREMOVE|6|Remove aura on remove another aura
SPELL_LINKED_TYPE_CASTONREMOVE|7|Cast on remove another aura');
delete from `dbdocssubtables` where `subtableId`= 6 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (6,0,'Creature Template NPCFlags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'right\'><b>Pure Flags</b></th>
<th><b>Decimal</b></th>
<th><b>Binary (32 Bit)</b></th>
<th align=\'left\'><b>Remarks</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_NONE</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_GOSSIP</td><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 0000 0001</td><td align=\'left\' valign=\'middle\'>(If NPC has more gossip options, add this flag to bring up a menu.)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_QUESTGIVER</td><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 0000 0010</td><td align=\'left\' valign=\'middle\'>(Any NPC giving or taking quests needs to have this flag.)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_UNKNOWN1</td><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 0000 0100</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_UNKOWN2</td><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 0000 1000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_TRAINER</td><td align=\'center\' valign=\'middle\'>16</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 0001 0000</td><td align=\'left\' valign=\'middle\'>(Allows the NPC to have a trainer list to teach spells, all trainers must have this flag)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_TRAINER_CLASS</td><td align=\'center\' valign=\'middle\'>32</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 0010 0000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_TRAINER_PROF</td><td align=\'center\' valign=\'middle\'>64</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 0100 0000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_VENDOR</td><td align=\'center\' valign=\'middle\'>128</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 1000 0000</td><td align=\'left\' valign=\'middle\'>(Any NPC selling items needs to have this flag)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_VENDOR_AMMO</td><td align=\'center\' valign=\'middle\'>256</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0001 0000 0000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_VENDOR_FOOD</td><td align=\'center\' valign=\'middle\'>512</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0010 0000 0000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_VENDOR_POISON</td><td align=\'center\' valign=\'middle\'>1024</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0100 0000 0000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_VENDOR_REAGENT</td><td align=\'center\' valign=\'middle\'>2048</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 1000 0000 0000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_ARMORER</td><td align=\'center\' valign=\'middle\'>4096</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0001 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(NPC with this flag can repair items.)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_TAXIVENDOR</td><td align=\'center\' valign=\'middle\'>8192</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0010 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(Any NPC serving as fly master has this.)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_SPIRITHEALER</td><td align=\'center\' valign=\'middle\'>16384</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0100 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(Makes the NPC invisible to alive characters and has the resurrect function.)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_SPIRITGUIDE</td><td align=\'center\' valign=\'middle\'>32768</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 1000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_INNKEEPER</td><td align=\'center\' valign=\'middle\'>65536</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0001 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(NPC with this flag can set hearthstone locations.)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_BANKER</td><td align=\'center\' valign=\'middle\'>131072</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0010 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(NPC with this flag can show the bank)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_ARENACHARTER</td><td align=\'center\' valign=\'middle\'>262144</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0100 0000 0000 0000 0000</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_TABARDVENDOR</td><td align=\'center\' valign=\'middle\'>524288</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 1000 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(Allows the designing of guild tabards.)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_BATTLEFIELDPERSON</td><td align=\'center\' valign=\'middle\'>1048576</td><td align=\'center\' valign=\'middle\'>0000 0000 0001 0000 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(NPC with this flag port players to battlegrounds. Like battlemasters, arena organzier etc.)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_AUCTIONEER</td><td align=\'center\' valign=\'middle\'>2097152</td><td align=\'center\' valign=\'middle\'>0000 0000 0010 0000 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(Allows NPC to display auction list.)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_STABLE</td><td align=\'center\' valign=\'middle\'>4194304</td><td align=\'center\' valign=\'middle\'>0000 0000 0100 0000 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(Has the option to stable pets for hunters.)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_GUILD_BANK</td><td align=\'center\' valign=\'middle\'>8388608</td><td align=\'center\' valign=\'middle\'>0000 0000 1000 0000 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>UNIT_NPC_FLAG_SPELLCLICK</td><td align=\'center\' valign=\'middle\'>16777216</td><td align=\'center\' valign=\'middle\'>0000 0001 0000 0000 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(Needs data on npc_spellclick_spells table)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>Mailbox</td><td align=\'center\' valign=\'middle\'>67108864</td><td align=\'center\' valign=\'middle\'>0000 0100 0000 0000 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(NPC will act like a mailbox, opens mailbox with right-click)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>Guard</td><td align=\'center\' valign=\'middle\'>268435456</td><td align=\'center\' valign=\'middle\'>0001 0000 0000 0000 0000 0000 0000 0000</td><td align=\'left\' valign=\'middle\'>(Cityguards, must be scripted)</td></tr>
</table>
','>Pure Flags|Decimal|Binary (32 Bit)|<Remarks
UNIT_NPC_FLAG_NONE|0|0000 0000 0000 0000 0000 0000 0000 0000|&nbsp;
UNIT_NPC_FLAG_GOSSIP|1|0000 0000 0000 0000 0000 0000 0000 0001|(If NPC has more gossip options, add this flag to bring up a menu.)
UNIT_NPC_FLAG_QUESTGIVER|2|0000 0000 0000 0000 0000 0000 0000 0010|(Any NPC giving or taking quests needs to have this flag.)
UNIT_NPC_FLAG_UNKNOWN1|4|0000 0000 0000 0000 0000 0000 0000 0100|&nbsp;
UNIT_NPC_FLAG_UNKOWN2|8|0000 0000 0000 0000 0000 0000 0000 1000|&nbsp;
UNIT_NPC_FLAG_TRAINER|16|0000 0000 0000 0000 0000 0000 0001 0000|(Allows the NPC to have a trainer list to teach spells, all trainers must have this flag)
UNIT_NPC_FLAG_TRAINER_CLASS|32|0000 0000 0000 0000 0000 0000 0010 0000|&nbsp;
UNIT_NPC_FLAG_TRAINER_PROF|64|0000 0000 0000 0000 0000 0000 0100 0000|&nbsp;
UNIT_NPC_FLAG_VENDOR|128|0000 0000 0000 0000 0000 0000 1000 0000|(Any NPC selling items needs to have this flag)
UNIT_NPC_FLAG_VENDOR_AMMO|256|0000 0000 0000 0000 0000 0001 0000 0000|&nbsp;
UNIT_NPC_FLAG_VENDOR_FOOD|512|0000 0000 0000 0000 0000 0010 0000 0000|&nbsp;
UNIT_NPC_FLAG_VENDOR_POISON|1024|0000 0000 0000 0000 0000 0100 0000 0000|&nbsp;
UNIT_NPC_FLAG_VENDOR_REAGENT|2048|0000 0000 0000 0000 0000 1000 0000 0000|&nbsp;
UNIT_NPC_FLAG_ARMORER|4096|0000 0000 0000 0000 0001 0000 0000 0000|(NPC with this flag can repair items.)
UNIT_NPC_FLAG_TAXIVENDOR|8192|0000 0000 0000 0000 0010 0000 0000 0000|(Any NPC serving as fly master has this.)
UNIT_NPC_FLAG_SPIRITHEALER|16384|0000 0000 0000 0000 0100 0000 0000 0000|(Makes the NPC invisible to alive characters and has the resurrect function.)
UNIT_NPC_FLAG_SPIRITGUIDE|32768|0000 0000 0000 0000 1000 0000 0000 0000|&nbsp;
UNIT_NPC_FLAG_INNKEEPER|65536|0000 0000 0000 0001 0000 0000 0000 0000|(NPC with this flag can set hearthstone locations.)
UNIT_NPC_FLAG_BANKER|131072|0000 0000 0000 0010 0000 0000 0000 0000|(NPC with this flag can show the bank)
UNIT_NPC_FLAG_ARENACHARTER|262144|0000 0000 0000 0100 0000 0000 0000 0000|
UNIT_NPC_FLAG_TABARDVENDOR|524288|0000 0000 0000 1000 0000 0000 0000 0000|(Allows the designing of guild tabards.)
UNIT_NPC_FLAG_BATTLEFIELDPERSON|1048576|0000 0000 0001 0000 0000 0000 0000 0000|(NPC with this flag port players to battlegrounds. Like battlemasters, arena organzier etc.)
UNIT_NPC_FLAG_AUCTIONEER|2097152|0000 0000 0010 0000 0000 0000 0000 0000|(Allows NPC to display auction list.)
UNIT_NPC_FLAG_STABLE|4194304|0000 0000 0100 0000 0000 0000 0000 0000|(Has the option to stable pets for hunters.)
UNIT_NPC_FLAG_GUILD_BANK|8388608|0000 0000 1000 0000 0000 0000 0000 0000|&nbsp;
UNIT_NPC_FLAG_SPELLCLICK|16777216|0000 0001 0000 0000 0000 0000 0000 0000|(Needs data on npc_spellclick_spells table)
Mailbox|67108864|0000 0100 0000 0000 0000 0000 0000 0000|(NPC will act like a mailbox, opens mailbox with right-click)
Guard|268435456|0001 0000 0000 0000 0000 0000 0000 0000|(Cityguards, must be scripted)');
delete from `dbdocssubtables` where `subtableId`= 5 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (5,0,'Creature Flag Combinations','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'right\'><b>Flag Combinations</b></th>
<th><b>Decimal</b></th>
<th><b>Binary (32 Bit)</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>TRAINER_CLASS + TRAINER + GOSSIP</td><td align=\'center\' valign=\'middle\'>49</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 0011 0001</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>VENDOR + QUESTGIVER + GOSSIP</td><td align=\'center\' valign=\'middle\'>131</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 1000 0011</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'right\' valign=\'middle\'>VENDOR + TRAINER_CLASS + TRAINER + GOSSIP</td><td align=\'center\' valign=\'middle\'>177</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 0000 0000 0000 1011 0001</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'right\' valign=\'middle\'>TABARDVENDOR + ARENACHARTER (GUILDMASTER)</td><td align=\'center\' valign=\'middle\'>786433</td><td align=\'center\' valign=\'middle\'>0000 0000 0000 1100 0000 0000 0000 0000</td></tr>
</table>
','>Flag Combinations|Decimal|Binary (32 Bit)
TRAINER_CLASS + TRAINER + GOSSIP|49|0000 0000 0000 0000 0000 0000 0011 0001
VENDOR + QUESTGIVER + GOSSIP|131|0000 0000 0000 0000 0000 0000 1000 0011
VENDOR + TRAINER_CLASS + TRAINER + GOSSIP|177|0000 0000 0000 0000 0000 0000 1011 0001
TABARDVENDOR + ARENACHARTER (GUILDMASTER)|786433|0000 0000 0000 1100 0000 0000 0000 0000');
delete from `dbdocssubtables` where `subtableId`= 4 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (4,0,'Cresture Template Unitflags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Flag</b></th>
<th align=\'left\'><b>Name</b></th>
<th align=\'left\'><b>Comments</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_UNK_0</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_NON_ATTACKABLE</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_DISABLE_MOVE</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_PVP_ATTACKABLE</td><td align=\'left\' valign=\'middle\'>(allow apply pvp rules to attackable state in addition to faction dependent state)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_RENAME</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>32</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_RESTING</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>64</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_UNK_6</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>128</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_NOT_ATTACKABLE_1</td><td align=\'left\' valign=\'middle\'>(??) ((UNIT_FLAG_PVP_ATTACKABLE + UNIT_FLAG_NOT_ATTACKABLE_1) is NON_PVP_ATTACKABLE)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>256</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_OOC_NOT_ATTACKABLE</td><td align=\'left\' valign=\'middle\'>(2.0.8 – Can not be attacked when not in combat. Removed if unit for some reason enter combat.) (2.4.3, Seems to make the unit unattackable)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>512</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_PASSIVE</td><td align=\'left\' valign=\'middle\'>(makes unable to attack everything. Almost identical to "civilian". Will not engage in combat unless "called upon" or engaged by another unit.)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1024</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_LOOTING</td><td align=\'left\' valign=\'middle\'>(loot animation)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2048</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_PET_IN_COMBAT</td><td align=\'left\' valign=\'middle\'>(in combat?, 2.0.8)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4096</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_PVP</td><td align=\'left\' valign=\'middle\'>Allows item spells to be casted upon (?)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>8192</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_SILENCED</td><td align=\'left\' valign=\'middle\'>Can’t cast spells</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16384</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_UNK_14</td><td align=\'left\' valign=\'middle\'>(2.0.8)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>32768</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_UNK_15</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>65536</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_UNK_16</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>131072</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_PACIFIED</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>262144</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_DISABLE_ROTATE</td><td align=\'left\' valign=\'middle\'>(stunned, 2.1.1)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>524288</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_IN_COMBAT</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1048576</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_TAXI_FLIGHT</td><td align=\'left\' valign=\'middle\'>(disable casting at client side spell not allowed by taxi flight (mounted?), probably used with 0×4 flag)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2097152</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_DISARMED</td><td align=\'left\' valign=\'middle\'>(disable melee spells casting…, "Required melee weapon" added to melee spells tooltip.)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4194304</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_CONFUSED</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>8388608</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_FLEEING</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16777216</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_PLAYER_CONTROLLED</td><td align=\'left\' valign=\'middle\'>(used in spell Eyes of the Beast for pet…)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>33554432</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_NOT_SELECTABLE</td><td align=\'left\' valign=\'middle\'>Can’t be selected by mouse</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>67108864</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_SKINNABLE</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>134217728</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_MOUNT</td><td align=\'left\' valign=\'middle\'>(the client seems to handle it perfectly)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>268435456</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_UNK_28</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>536870912</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_UNK_29</td><td align=\'left\' valign=\'middle\'>(used in Feign Death spell)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1073741824</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_SHEATHE</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2147483648</td><td align=\'left\' valign=\'middle\'>UNIT_FLAG_UNK_31</td><td align=\'left\' valign=\'middle\'>(set skinnable icon and also changes color of portrait)</td></tr>
</table>
','Flag|<Name|<Comments
1|UNIT_FLAG_UNK_0|&nbsp;
2|UNIT_FLAG_NON_ATTACKABLE|&nbsp;
4|UNIT_FLAG_DISABLE_MOVE|&nbsp;
8|UNIT_FLAG_PVP_ATTACKABLE|(allow apply pvp rules to attackable state in addition to faction dependent state)
16|UNIT_FLAG_RENAME|&nbsp;
32|UNIT_FLAG_RESTING|&nbsp;
64|UNIT_FLAG_UNK_6|&nbsp;
128|UNIT_FLAG_NOT_ATTACKABLE_1|(??) ((UNIT_FLAG_PVP_ATTACKABLE + UNIT_FLAG_NOT_ATTACKABLE_1) is NON_PVP_ATTACKABLE)
256|UNIT_FLAG_OOC_NOT_ATTACKABLE|(2.0.8 – Can not be attacked when not in combat. Removed if unit for some reason enter combat.) (2.4.3, Seems to make the unit unattackable)
512|UNIT_FLAG_PASSIVE|(makes unable to attack everything. Almost identical to "civilian". Will not engage in combat unless "called upon" or engaged by another unit.)
1024|UNIT_FLAG_LOOTING|(loot animation)
2048|UNIT_FLAG_PET_IN_COMBAT|(in combat?, 2.0.8)
4096|UNIT_FLAG_PVP|Allows item spells to be casted upon (?)
8192|UNIT_FLAG_SILENCED|Can’t cast spells
16384|UNIT_FLAG_UNK_14|(2.0.8)
32768|UNIT_FLAG_UNK_15|&nbsp;
65536|UNIT_FLAG_UNK_16|&nbsp;
131072|UNIT_FLAG_PACIFIED|&nbsp;
262144|UNIT_FLAG_DISABLE_ROTATE|(stunned, 2.1.1)
524288|UNIT_FLAG_IN_COMBAT|&nbsp;
1048576|UNIT_FLAG_TAXI_FLIGHT|(disable casting at client side spell not allowed by taxi flight (mounted?), probably used with 0×4 flag)
2097152|UNIT_FLAG_DISARMED|(disable melee spells casting…, "Required melee weapon" added to melee spells tooltip.)
4194304|UNIT_FLAG_CONFUSED|&nbsp;
8388608|UNIT_FLAG_FLEEING|&nbsp;
16777216|UNIT_FLAG_PLAYER_CONTROLLED|(used in spell Eyes of the Beast for pet…)
33554432|UNIT_FLAG_NOT_SELECTABLE|Can’t be selected by mouse
67108864|UNIT_FLAG_SKINNABLE|&nbsp;
134217728|UNIT_FLAG_MOUNT|(the client seems to handle it perfectly)
268435456|UNIT_FLAG_UNK_28|&nbsp;
536870912|UNIT_FLAG_UNK_29|(used in Feign Death spell)
1073741824|UNIT_FLAG_SHEATHE|&nbsp;
2147483648|UNIT_FLAG_UNK_31|(set skinnable icon and also changes color of portrait)');
delete from `dbdocssubtables` where `subtableId`= 3 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (3,0,'Creature Template Dynamic Flags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<th align=\'left\'><b>Comments</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>None</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Lootable</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Track unit</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Other tagger</td><td align=\'left\' valign=\'middle\'>Makes creature name tag appear grey</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>Rooted</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>Specialinfo</td><td align=\'left\' valign=\'middle\'>Show basic creature stats in tooltip</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>32</td><td align=\'left\' valign=\'middle\'>Dead</td><td align=\'left\' valign=\'middle\'>Make creature appear dead without tag</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>64</td><td align=\'left\' valign=\'middle\'>Tapped by all threat list</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
</table>
','Value|<Description|<Comments
0|None|&nbsp;
1|Lootable|&nbsp;
2|Track unit|&nbsp;
4|Other tagger|Makes creature name tag appear grey
8|Rooted|&nbsp;
16|Specialinfo|Show basic creature stats in tooltip
32|Dead|Make creature appear dead without tag
64|Tapped by all threat list|&nbsp;');

update `dbdocstable` set `languageId`=0, `tableName`='areatrigger_involvedrelation', `tableNotes`='The areatrigger_involvedrelation table holds connections between triggers and quests.<br /><br />If there is a record in the table for a quest, the quest will not be completed until the player activates the areatriger. The quest is not necessarily finished after that, but that one condition of the quest is satisfied. If the only condition of the quest is to explore an area, then the quest will be complete.' where tableId=1;
update `dbdocsfields` set `FieldComment` = 'The destination map id. (See map.dbc)', `fieldNotes` = 'The destination map id. The value has to match with a map identifier defined (see Map.dbc).' where `fieldId`= '11' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The movement type associated with this creature.', `fieldNotes` = 'The movement type associated with this creature. Usually the same as creature_template.MovementType but can be different (See creature_template.MovementType) for possible values.<br /><br />¬subtable:109¬ <br />' where `fieldId`= '47' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Value that represents a loot condition that must be filled.', `fieldNotes` = 'Value that represents a loot condition that must be filled in order for the item to drop. This field combined with condition_value1-2 fields can provide conditions on when an item can be dropped. <br /><br />¬subtable:12¬<br /><br />NOTE: For reference entries this field has no meaning, not used by the core in any way and should have the default value of 0. <br /><br />' where `fieldId`= '142' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'ID that displays what spells the pet has in the client.', `fieldNotes` = 'ID that displays what spells the pet has in the client.' where `fieldId`= '246' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Marks a creature template as a civilian.', `fieldNotes` = 'Marking a creature template as civilian will prevent it from aggroing and may influence the honor points gained negatively.<br /><br />¬subtable:9¬<br /><br /><br />' where `fieldId`= '205' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This Field Controls Where The Creature Can Move Into, Chase And Attack.', `fieldNotes` = 'This Field Controls Where The Creature Can Move Into, Chase And Attack. The NPC Is Limited To ONLY This:<br /><br />¬subtable:8¬' where `fieldId`= '221' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Determines if a creature template is a racial leader.', `fieldNotes` = 'Determines if a creature template is a racial leader. Racial leaders will grant increased honor points upon death.<br /><br />¬subtable:7¬' where `fieldId`= '249' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The flags of the creature.
', `fieldNotes` = 'The flags of the creature.<br />Note that most of these also require the "Gossip" [1] flag to work.<br />So if you want a NPC that is a quest giver, a vendor and can repair you just add the specific flags together: 1 + 2 + 128 + 4096 = 4227. <br /><br />¬subtable:6¬<br /><br />¬subtable:5¬' where `fieldId`= '245' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Allows the manual application of unit flags to creatures.', `fieldNotes` = 'Allows the manual application of unit flags to creatures. Again this is a bitmask field and to apply more than one flag, just add the different numbers. Some possible flags are:<br /><br />¬subtable:4¬' where `fieldId`= '273' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Dynamic flags are used to control the visual appearance of a creature template.', `fieldNotes` = 'Dynamic flags are used to control the visual appearance of a creature template. The following table provides a list of valid values. Multiple flags may be combined.<br /><br />¬subtable:3¬' where `fieldId`= '211' and `languageId`= 0;


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