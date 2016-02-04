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
    SET @cOldContent = '24'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '1';
    SET @cNewContent = '25';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'dbdocs updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'New subtables added, Notes and field comments added. Updates and fixes completed at this point for the World database.';

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
delete from `dbdocssubtables` where `subtableId`= 119 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (119,0,'Creature DeathState','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>State</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Alive</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Dead</td></tr>
</table>
','Value|<State
0|Alive
1|Dead');
delete from `dbdocssubtables` where `subtableId`= 120 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (120,0,'','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Name</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Warrior</td><td align=\'left\' valign=\'middle\'>Has increased health and no mana</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Paladin</td><td align=\'left\' valign=\'middle\'>Has increased health and low mana</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Rogue</td><td align=\'left\' valign=\'middle\'>Has increased damage, but lower armor</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>Mage</td><td align=\'left\' valign=\'middle\'>Has low health, but increased mana</td></tr>
</table>
','Value|<Name|<Description
1|Warrior|Has increased health and no mana
2|Paladin|Has increased health and low mana
4|Rogue|Has increased damage, but lower armor
8|Mage|Has low health, but increased mana');
delete from `dbdocssubtables` where `subtableId`= 121 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (121,0,'Creature Template UnitClass','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Name</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Warrior</td><td align=\'left\' valign=\'middle\'>Has increased health and no mana</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Paladin</td><td align=\'left\' valign=\'middle\'>Has increased health and low mana</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Rogue</td><td align=\'left\' valign=\'middle\'>Has increased damage, but lower armor</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>Mage</td><td align=\'left\' valign=\'middle\'>Has low health, but increased mana</td></tr>
</table>
','Value|<Name|<Description
1|Warrior|Has increased health and no mana
2|Paladin|Has increased health and low mana
4|Rogue|Has increased damage, but lower armor
8|Mage|Has low health, but increased mana');
delete from `dbdocssubtables` where `subtableId`= 122 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (122,0,'Creature Template DamageSchool','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Normal damage</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Holy damage</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Fire damage</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Nature damage</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Frost damage</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Shadow damage</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Arcane damage</td></tr>
</table>
','Value|<Description
0|Normal damage
1|Holy damage
2|Fire damage
3|Nature damage
4|Frost damage
5|Shadow damage
6|Arcane damage');
delete from `dbdocssubtables` where `subtableId`= 123 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (123,0,'Creature Template MechanicaIImmuneMask','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Type</b></th>
<th align=\'left\'><b>Value</b></th>
<th align=\'left\'><b>Type</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>NONE</td><td align=\'left\' valign=\'middle\'>32768</td><td align=\'left\' valign=\'middle\'>BANDAGE</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>CHARM</td><td align=\'left\' valign=\'middle\'>65536</td><td align=\'left\' valign=\'middle\'>POLYMORPH</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>CONFUSED</td><td align=\'left\' valign=\'middle\'>131072</td><td align=\'left\' valign=\'middle\'>BANISH</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>DISARM</td><td align=\'left\' valign=\'middle\'>262144</td><td align=\'left\' valign=\'middle\'>SHIELD</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>DISTRACT</td><td align=\'left\' valign=\'middle\'>524288</td><td align=\'left\' valign=\'middle\'>SHACKLE</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>FEAR</td><td align=\'left\' valign=\'middle\'>1048576</td><td align=\'left\' valign=\'middle\'>MOUNT</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>32</td><td align=\'left\' valign=\'middle\'>FUMBLE</td><td align=\'left\' valign=\'middle\'>2097152</td><td align=\'left\' valign=\'middle\'>PERSUADE</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>64</td><td align=\'left\' valign=\'middle\'>ROOT</td><td align=\'left\' valign=\'middle\'>4194304</td><td align=\'left\' valign=\'middle\'>TURN</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>128</td><td align=\'left\' valign=\'middle\'>PACIFY</td><td align=\'left\' valign=\'middle\'>8388608</td><td align=\'left\' valign=\'middle\'>HORROR</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>256</td><td align=\'left\' valign=\'middle\'>SILENCE</td><td align=\'left\' valign=\'middle\'>16777216</td><td align=\'left\' valign=\'middle\'>INVULNERABILITY</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>512</td><td align=\'left\' valign=\'middle\'>SLEEP</td><td align=\'left\' valign=\'middle\'>33554432</td><td align=\'left\' valign=\'middle\'>INTERRUPT</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1024</td><td align=\'left\' valign=\'middle\'>SNARE</td><td align=\'left\' valign=\'middle\'>67108864</td><td align=\'left\' valign=\'middle\'>DAZE</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2048</td><td align=\'left\' valign=\'middle\'>STUN</td><td align=\'left\' valign=\'middle\'>134217728</td><td align=\'left\' valign=\'middle\'>DISCOVERY</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4096</td><td align=\'left\' valign=\'middle\'>FREEZE</td><td align=\'left\' valign=\'middle\'>268435456</td><td align=\'left\' valign=\'middle\'>IMMUNE_SHIELD</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8192</td><td align=\'left\' valign=\'middle\'>KNOCKOUT</td><td align=\'left\' valign=\'middle\'>536870912</td><td align=\'left\' valign=\'middle\'>SAPPED</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>16384</td><td align=\'left\' valign=\'middle\'>BLEED</td><td align=\'left\' valign=\'middle\'>&nbsp;</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
</table>
','Value|<Type|<Value|<Type
0|NONE|32768|BANDAGE
1|CHARM|65536|POLYMORPH
2|CONFUSED|131072|BANISH
4|DISARM|262144|SHIELD
8|DISTRACT|524288|SHACKLE
16|FEAR|1048576|MOUNT
32|FUMBLE|2097152|PERSUADE
64|ROOT|4194304|TURN
128|PACIFY|8388608|HORROR
256|SILENCE|16777216|INVULNERABILITY
512|SLEEP|33554432|INTERRUPT
1024|SNARE|67108864|DAZE
2048|STUN|134217728|DISCOVERY
4096|FREEZE|268435456|IMMUNE_SHIELD
8192|KNOCKOUT|536870912|SAPPED
16384|BLEED| &nbsp;|&nbsp; |');
delete from `dbdocssubtables` where `subtableId`= 124 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (124,0,'Creature Template TrainerClass','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Warrior</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Paladin</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Hunter</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Rogue</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Priest</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>Shaman</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>Mage</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>9</td><td align=\'left\' valign=\'middle\'>Warlock</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>11</td><td align=\'left\' valign=\'middle\'>Druid</td></tr>
</table>
','Value|<Description
1|Warrior
2|Paladin
3|Hunter
4|Rogue
5|Priest
7|Shaman
8|Mage
9|Warlock
11|Druid');
delete from `dbdocssubtables` where `subtableId`= 125 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (125,0,'Creature Template ExtraFlags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Type</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>NONE</td><td align=\'left\' valign=\'middle\'>Default: do nothing.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>INSTANCE_BIND</td><td align=\'left\' valign=\'middle\'>Bounds killer’s party to the instance</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>CIVILIAN</td><td align=\'left\' valign=\'middle\'>Makes creature ignore aggro</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>NO_PARRY</td><td align=\'left\' valign=\'middle\'>Prohibits from parrying</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>NO_PARRY_HASTEN</td><td align=\'left\' valign=\'middle\'>Parries do not speed up its next attack</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>NO_BLOCK</td><td align=\'left\' valign=\'middle\'>Prohibits from blocking</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>32</td><td align=\'left\' valign=\'middle\'>NO_CRUSH</td><td align=\'left\' valign=\'middle\'>Prohibits from dealing crushing blows</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>64</td><td align=\'left\' valign=\'middle\'>NO_XP_AT_KILL</td><td align=\'left\' valign=\'middle\'>Creature rewards no XP at kill</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>128</td><td align=\'left\' valign=\'middle\'>INVISIBLE</td><td align=\'left\' valign=\'middle\'>Creature invisible for player, e.g triggers</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>256</td><td align=\'left\' valign=\'middle\'>NOT_TAUNTABLE</td><td align=\'left\' valign=\'middle\'>Creature is immune to taunts</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>512</td><td align=\'left\' valign=\'middle\'>AGGRO_ZONE</td><td align=\'left\' valign=\'middle\'>Sets itself in combat with zone on aggro</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1024</td><td align=\'left\' valign=\'middle\'>GUARD</td><td align=\'left\' valign=\'middle\'>Is zone guard and death will be announced</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2048</td><td align=\'left\' valign=\'middle\'>NO_TALKTO_CREDIT</td><td align=\'left\' valign=\'middle\'>Does not give quest credit (temporary)</td></tr>
</table>
','Value|<Type|<Description
0|NONE|Default: do nothing.
1|INSTANCE_BIND|Bounds killer’s party to the instance
2|CIVILIAN|Makes creature ignore aggro
4|NO_PARRY|Prohibits from parrying
8|NO_PARRY_HASTEN|Parries do not speed up its next attack
16|NO_BLOCK|Prohibits from blocking
32|NO_CRUSH|Prohibits from dealing crushing blows
64|NO_XP_AT_KILL|Creature rewards no XP at kill
128|INVISIBLE|Creature invisible for player, e.g triggers
256|NOT_TAUNTABLE|Creature is immune to taunts
512|AGGRO_ZONE|Sets itself in combat with zone on aggro
1024|GUARD|Is zone guard and death will be announced
2048|NO_TALKTO_CREDIT|Does not give quest credit (temporary)');
delete from `dbdocssubtables` where `subtableId`= 126 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (126,0,'Creature Template MovementType','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Behaviour</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Idle on spawn point</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Random movement within spawndist radius</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Waypoint movement</td></tr>
</table>
','Value|<Behaviour
0|Idle on spawn point
1|Random movement within spawndist radius
2|Waypoint movement');
delete from `dbdocssubtables` where `subtableId`= 127 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (127,0,'Creature Template TrainerType','To be populated','To be populated');
delete from `dbdocssubtables` where `subtableId`= 128 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (128,0,'Db Script String sound','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
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
delete from `dbdocssubtables` where `subtableId`= 129 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (129,0,'Disenchant Loot Template ChanceOrQuestChance','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>ChanceOrQuestChance</b></th>
<th align=\'left\'><b>mincountOrRef</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>> 0</td><td align=\'left\' valign=\'middle\'>> 0</td><td align=\'left\' valign=\'middle\'>A simple percentage based drop chance.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>< 0</td><td align=\'left\' valign=\'middle\'>> 0</td><td align=\'left\' valign=\'middle\'>A quest based drop chance.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>> 0</td><td align=\'left\' valign=\'middle\'>< 0</td><td align=\'left\' valign=\'middle\'>A drop chance which has a chance to be used.</td></tr>
</table>
','<ChanceOrQuestChance|<mincountOrRef|<Description
> 0|> 0|A simple percentage based drop chance.
< 0|> 0|A quest based drop chance.
> 0|< 0|A drop chance which has a chance to be used.');
delete from `dbdocssubtables` where `subtableId`= 130 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (130,0,'Game Graveyard Zone faction','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Value</b></th>
<th align=\'left\'><b>Faction</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Any faction</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>67</td><td align=\'left\' valign=\'middle\'>Horde only</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>469</td><td align=\'left\' valign=\'middle\'>Alliance only</td></tr>
</table>
','<Value|<Faction
0|Any faction
67|Horde only
469|Alliance only');
delete from `dbdocssubtables` where `subtableId`= 131 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (131,0,'Pet Name Generation half','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>First half</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Last half</td></tr>
</table>
','<Value|<Description
0|First half
1|Last half');
delete from `dbdocssubtables` where `subtableId`= 132 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (132,0,'Spell Area gender','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Value</b></th>
<th align=\'left\'><b>Gender</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Male</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Female</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Both</td></tr>
</table>
','<Value|<Gender
0|Male
1|Female
2|Both');
delete from `dbdocssubtables` where `subtableId`= 133 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (133,0,'Spell Elixir mask','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Value</b></th>
<th align=\'left\'><b>Type</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>None</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Flask</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>Food granting well fed buffs</td></tr>
</table>
','<Value|<Type
0|None
3|Flask
16|Food granting well fed buffs');
delete from `dbdocssubtables` where `subtableId`= 134 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (134,0,'Spell Learn Spell Active','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Will not appear in the spell book.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Will appear in the spell book.</td></tr>
</table>
','<Value|<Description
0|Will not appear in the spell book.
1|Will appear in the spell book.');
delete from `dbdocssubtables` where `subtableId`= 135 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (135,0,'Creature AI Scripts event_type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Type</b></th>
<th><b>Parameters</b></th>
<th><b>Description</b></th>
<th align=\'left\'><b>Notes</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>EVENT_T_TIMER_IN_COMBAT</td><td align=\'center\' valign=\'middle\'>InitialMin, InitialMax, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4)</td><td align=\'left\' valign=\'middle\'>EXPIRES ONLY IN COMBAT.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>EVENT_T_TIMER_OOC</td><td align=\'center\' valign=\'middle\'>InitialMin, InitialMax, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4)</td><td align=\'left\' valign=\'middle\'>EXPIRES ONLY OUT OF COMBAT BUT NOT DURING EVADE.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>EVENT_T_HP</td><td align=\'center\' valign=\'middle\'>HPMax%, HPMin%, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when the NPC’s HP% is between (Param1) and (Param2). Will repeat between every (Param3) and (Param4)</td><td align=\'left\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'center\' valign=\'middle\'>EVENT_T_MANA</td><td align=\'center\' valign=\'middle\'>ManaMax%,ManaMin% RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when the NPC’s Mana% is between (Param1) and (Param2). Will repeat between every (Param3) and (Param4)</td><td align=\'left\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>EVENT_T_AGGRO NONE</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>Expires ONLY upon the NPC’s INITIAL Aggro at the Start of Combat (Does NOT Repeat) and Only Resets on Spawn or Evade.</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>EVENT_T_KILL</td><td align=\'center\' valign=\'middle\'>RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires upon Killing a Player. Will Repeat Check between (Param1) and (Param2).</td><td align=\'left\' valign=\'middle\'>This Event Will Not Trigger Again Until Repeat Timer Expires</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'center\' valign=\'middle\'>EVENT_T_DEATH NONE</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>Expires on the NPC’s Death. (This Triggers At The Moment The NPC Dies)</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'center\' valign=\'middle\'>EVENT_T_EVADE NONE</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>Expires at the moment the Creature EnterEvadeMode() and Exits Combat.</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>EVENT_T_SPELLHIT</td><td align=\'center\' valign=\'middle\'>SpellID, School, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires upon Spell Hit of the NPC. When (param1) is set, it is the specific Spell ID used as the trigger. With (param2) specified, the expiration is limited to specific spell schools (-1 for all) and Spell ID value is ignored.</td><td align=\'left\' valign=\'middle\'>Will repeat Event Conditions Check between every (Param3) and (Param4). Only A Spell ID or Spell School may be Specified but NOT both.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>9</td><td align=\'center\' valign=\'middle\'>EVENT_T_RANGE</td><td align=\'center\' valign=\'middle\'>MinDist, MaxDist, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when the Highest Threat Target Distance is Greater than (Param1) and Less than (Param2).</td><td align=\'left\' valign=\'middle\'>Will repeat between every (Param3) and (Param4) if Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>10</td><td align=\'center\' valign=\'middle\'>EVENT_T_OOC_LOS</td><td align=\'center\' valign=\'middle\'>NoHostile, MaxRange, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when a unit moves within distance (MaxAllowedRange) of the NPC. If (Param1) is 0 it will expire only when unit is hostile, If (Param1) is 1 it will expire only when unit is friendly.</td><td align=\'left\' valign=\'middle\'>This depends generally on faction relations. Will repeat every (Param3) and (Param4). Does NOT expire when the NPC is in combat.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>11</td><td align=\'center\' valign=\'middle\'>EVENT_T_SPAWNED</td><td align=\'center\' valign=\'middle\'>Condition, CondValue1</td><td align=\'center\' valign=\'middle\'>Expires on initial spawn and respawn of the NPC (Useful for setting Ranged Movement/Summoning Pets/Applying Buffs).</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>12</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_HP</td><td align=\'center\' valign=\'middle\'>HPMax%, HPMin%, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when current target’s HP% is between (Param1) and (Param2). Will repeat every (Param3) and (Param4)</td><td align=\'left\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>13</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_CASTING</td><td align=\'center\' valign=\'middle\'>RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when the current target is casting a spell. Will repeat every (Param1) and (Param2)</td><td align=\'left\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>14</td><td align=\'center\' valign=\'middle\'>EVENT_T_FRIENDLY_HP</td><td align=\'center\' valign=\'middle\'>HPDeficit, Radius, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when a friendly unit in (Radius) has at least (Param1) HP points missing. Will repeat every (Param3) and (Param4)</td><td align=\'left\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>15</td><td align=\'center\' valign=\'middle\'>EVENT_T_FRIENDLY_IS_CC</td><td align=\'center\' valign=\'middle\'>DispelType, Radius, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when a friendly unit is crowd controlled within the given Radius (Param2). Will repeat every (Param3) and (Param4).</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'center\' valign=\'middle\'>EVENT_T_FRIENDLY_MISSING_BUFF</td><td align=\'center\' valign=\'middle\'>SpellId, Radius, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when a friendly unit is missing aura(s) given by a spell (Param1) within Radius (Param2). Will repeat every (Param3) and (Param4) If Event Conditions Are Still Met.</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>17</td><td align=\'center\' valign=\'middle\'>EVENT_T_SUMMONED_UNIT</td><td align=\'center\' valign=\'middle\'>CreatureId, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires after creature with entry = (Param1) is spawned (Param1 = 0 means all spawns).</td><td align=\'left\' valign=\'middle\'>Will repeat every (Param2) and (Param3).</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>18</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_MANA</td><td align=\'center\' valign=\'middle\'>ManaMax%, ManaMin%, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when current target’s Mana% is between (Param1) and (Param2). Will repeat every (Param3) and (Param4)</td><td align=\'left\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>19</td><td align=\'center\' valign=\'middle\'>EVENT_T_QUEST_ACCEPT QuestID</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>20</td><td align=\'center\' valign=\'middle\'>EVENT_T_QUEST_COMPLETE</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>21</td><td align=\'center\' valign=\'middle\'>EVENT_T_REACHED_HOME</td><td align=\'center\' valign=\'middle\'>NONE</td><td align=\'center\' valign=\'middle\'>Expires when a creature reaches it’s home (spawn) location after evade.</td><td align=\'left\' valign=\'middle\'>This is commonly used for NPC’s who Stealth once reaching their Spawn Location</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>22</td><td align=\'center\' valign=\'middle\'>EVENT_T_RECEIVE_EMOTE</td><td align=\'center\' valign=\'middle\'>EmoteId, Condition, CondValue1, CondValue2</td><td align=\'center\' valign=\'middle\'>Expires when a creature receives an emote with emote text id (“enum TextEmotes” from SharedDefines.h in Mangos Source) in (Param1).</td><td align=\'left\' valign=\'middle\'>Conditions can be defined (Param2) with optional values (Param3,Param4), see (enum ConditionType) in ObjectMgr.h (Mangos Source).</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>23</td><td align=\'center\' valign=\'middle\'>EVENT_T_AURA</td><td align=\'center\' valign=\'middle\'>Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max Expires when a creature has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).</td><td align=\'center\' valign=\'middle\'>Will repeat every (Param3) and (Param4)</td><td align=\'left\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>24</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_AURA</td><td align=\'center\' valign=\'middle\'>Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max Expires when a target unit has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).</td><td align=\'center\' valign=\'middle\'>Will repeat every (Param3) and (Param4)</td><td align=\'left\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>25</td><td align=\'center\' valign=\'middle\'>EVENT_T_SUMMONED_JUST_DIED</td><td align=\'center\' valign=\'middle\'>CreatureId, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires after creature with entry = (Param1) is die (Param1 = 0 means all spawns).</td><td align=\'left\' valign=\'middle\'>Will repeat every (Param2) and (Param3).</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>26</td><td align=\'center\' valign=\'middle\'>EVENT_T_SUMMONED_JUST_DESPAWN</td><td align=\'center\' valign=\'middle\'>CreatureId, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires before creature with entry = (Param1) is despawn (Param1 = 0 means all spawns).</td><td align=\'left\' valign=\'middle\'>Will repeat every (Param2) and (Param3).</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>27</td><td align=\'center\' valign=\'middle\'>EVENT_T_MISSING_AURA</td><td align=\'center\' valign=\'middle\'>Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max</td><td align=\'center\' valign=\'middle\'>Expires when a creature not has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).</td><td align=\'left\' valign=\'middle\'>Will repeat every (Param3) and (Param4).</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>28</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_MISSING_AURA</td><td align=\'center\' valign=\'middle\'>Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max</td><td align=\'center\' valign=\'middle\'>Expires when a target unit not has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).</td><td align=\'left\' valign=\'middle\'>Will repeat every (Param3) and (Param4).</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>29</td><td align=\'center\' valign=\'middle\'>EVENT_T_TIMER_GENERIC</td><td align=\'center\' valign=\'middle\'>InitialMin, InitialMax, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4).</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>30</td><td align=\'center\' valign=\'middle\'>EVENT_T_RECEIVE_AI_EVENT</td><td align=\'center\' valign=\'middle\'>AIEventType, Sender-Entry, unused, unused</td><td align=\'center\' valign=\'middle\'>Expires when the creature receives an AIEvent of type (Param1), sent by creature (Param2 != 0). If (Param2 = 0) then sent by any</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
</table>
','Value|Type|Parameters|Description|<Notes
0|EVENT_T_TIMER_IN_COMBAT|InitialMin, InitialMax, RepeatMin, RepeatMax|Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4)|EXPIRES ONLY IN COMBAT.
1|EVENT_T_TIMER_OOC|InitialMin, InitialMax, RepeatMin, RepeatMax|Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4)|EXPIRES ONLY OUT OF COMBAT BUT NOT DURING EVADE.
2|EVENT_T_HP|HPMax%, HPMin%, RepeatMin, RepeatMax|Expires when the NPC’s HP% is between (Param1) and (Param2). Will repeat between every (Param3) and (Param4)|If Event Conditions Are Still Met.
3|EVENT_T_MANA|ManaMax%,ManaMin% RepeatMin, RepeatMax|Expires when the NPC’s Mana% is between (Param1) and (Param2). Will repeat between every (Param3) and (Param4)|If Event Conditions Are Still Met.
4|EVENT_T_AGGRO NONE|&nbsp; |Expires ONLY upon the NPC’s INITIAL Aggro at the Start of Combat (Does NOT Repeat) and Only Resets on Spawn or Evade.| &nbsp;|
5|EVENT_T_KILL|RepeatMin, RepeatMax|Expires upon Killing a Player. Will Repeat Check between (Param1) and (Param2).|This Event Will Not Trigger Again Until Repeat Timer Expires
6|EVENT_T_DEATH NONE|&nbsp; |Expires on the NPC’s Death. (This Triggers At The Moment The NPC Dies)| &nbsp;|
7|EVENT_T_EVADE NONE|&nbsp; |Expires at the moment the Creature EnterEvadeMode() and Exits Combat.| &nbsp;|
8|EVENT_T_SPELLHIT|SpellID, School, RepeatMin, RepeatMax|Expires upon Spell Hit of the NPC. When (param1) is set, it is the specific Spell ID used as the trigger. With (param2) specified, the expiration is limited to specific spell schools (-1 for all) and Spell ID value is ignored.|Will repeat Event Conditions Check between every (Param3) and (Param4). Only A Spell ID or Spell School may be Specified but NOT both.
9|EVENT_T_RANGE|MinDist, MaxDist, RepeatMin, RepeatMax|Expires when the Highest Threat Target Distance is Greater than (Param1) and Less than (Param2).|Will repeat between every (Param3) and (Param4) if Event Conditions Are Still Met.
10|EVENT_T_OOC_LOS|NoHostile, MaxRange, RepeatMin, RepeatMax|Expires when a unit moves within distance (MaxAllowedRange) of the NPC. If (Param1) is 0 it will expire only when unit is hostile, If (Param1) is 1 it will expire only when unit is friendly.|This depends generally on faction relations. Will repeat every (Param3) and (Param4). Does NOT expire when the NPC is in combat.
11|EVENT_T_SPAWNED|Condition, CondValue1|Expires on initial spawn and respawn of the NPC (Useful for setting Ranged Movement/Summoning Pets/Applying Buffs).| &nbsp;|
12|EVENT_T_TARGET_HP|HPMax%, HPMin%, RepeatMin, RepeatMax|Expires when current target’s HP% is between (Param1) and (Param2). Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met.
13|EVENT_T_TARGET_CASTING|RepeatMin, RepeatMax|Expires when the current target is casting a spell. Will repeat every (Param1) and (Param2)|If Event Conditions Are Still Met.
14|EVENT_T_FRIENDLY_HP|HPDeficit, Radius, RepeatMin, RepeatMax|Expires when a friendly unit in (Radius) has at least (Param1) HP points missing. Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met.
15|EVENT_T_FRIENDLY_IS_CC|DispelType, Radius, RepeatMin, RepeatMax|Expires when a friendly unit is crowd controlled within the given Radius (Param2). Will repeat every (Param3) and (Param4).| &nbsp;|
16|EVENT_T_FRIENDLY_MISSING_BUFF|SpellId, Radius, RepeatMin, RepeatMax|Expires when a friendly unit is missing aura(s) given by a spell (Param1) within Radius (Param2). Will repeat every (Param3) and (Param4) If Event Conditions Are Still Met.|&nbsp;| 
17|EVENT_T_SUMMONED_UNIT|CreatureId, RepeatMin, RepeatMax|Expires after creature with entry = (Param1) is spawned (Param1 = 0 means all spawns).|Will repeat every (Param2) and (Param3).
18|EVENT_T_TARGET_MANA|ManaMax%, ManaMin%, RepeatMin, RepeatMax|Expires when current target’s Mana% is between (Param1) and (Param2). Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met.
19|EVENT_T_QUEST_ACCEPT QuestID| &nbsp;| &nbsp;| &nbsp;|
20|EVENT_T_QUEST_COMPLETE|&nbsp; | &nbsp;| &nbsp;|
21|EVENT_T_REACHED_HOME|NONE|Expires when a creature reaches it’s home (spawn) location after evade.|This is commonly used for NPC’s who Stealth once reaching their Spawn Location
22|EVENT_T_RECEIVE_EMOTE|EmoteId, Condition, CondValue1, CondValue2|Expires when a creature receives an emote with emote text id (“enum TextEmotes” from SharedDefines.h in Mangos Source) in (Param1).|Conditions can be defined (Param2) with optional values (Param3,Param4), see (enum ConditionType) in ObjectMgr.h (Mangos Source).
23|EVENT_T_AURA|Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max Expires when a creature has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).|Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met.
24|EVENT_T_TARGET_AURA|Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max Expires when a target unit has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).|Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met.
25|EVENT_T_SUMMONED_JUST_DIED|CreatureId, RepeatMin, RepeatMax|Expires after creature with entry = (Param1) is die (Param1 = 0 means all spawns).|Will repeat every (Param2) and (Param3).
26|EVENT_T_SUMMONED_JUST_DESPAWN|CreatureId, RepeatMin, RepeatMax|Expires before creature with entry = (Param1) is despawn (Param1 = 0 means all spawns).|Will repeat every (Param2) and (Param3).
27|EVENT_T_MISSING_AURA|Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max|Expires when a creature not has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).|Will repeat every (Param3) and (Param4).
28|EVENT_T_TARGET_MISSING_AURA|Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max|Expires when a target unit not has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).|Will repeat every (Param3) and (Param4).
29|EVENT_T_TIMER_GENERIC|InitialMin, InitialMax, RepeatMin, RepeatMax|Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4).| &nbsp;|
30|EVENT_T_RECEIVE_AI_EVENT|AIEventType, Sender-Entry, unused, unused|Expires when the creature receives an AIEvent of type (Param1), sent by creature (Param2 != 0). If (Param2 = 0) then sent by any |&nbsp;|');
delete from `dbdocssubtables` where `subtableId`= 136 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (136,0,'Creature AI Scripts possible target types','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Type</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>TARGET_T_SELF</td><td align=\'left\' valign=\'middle\'>self cast</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>TARGET_T_HOSTILE</td><td align=\'left\' valign=\'middle\'>Our current target (ie: top aggro)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>TARGET_T_HOSTILE_SECOND_AGGRO</td><td align=\'left\' valign=\'middle\'>Second highest aggro, usually offtank (generaly used for cleaves and some special attacks)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'center\' valign=\'middle\'>TARGET_T_HOSTILE_LAST_AGGRO</td><td align=\'left\' valign=\'middle\'>Bottom aggro target (these are healers usually)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>TARGET_T_HOSTILE_RANDOM</td><td align=\'left\' valign=\'middle\'>Just any random target on our threat list</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>TARGET_T_HOSTILE_RANDOM_NOT_TOP</td><td align=\'left\' valign=\'middle\'>Any random target except top aggro</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'center\' valign=\'middle\'>TARGET_T_ACTION_INVOKER</td><td align=\'left\' valign=\'middle\'>Unit who caused this Event to occur (only works for EVENT_T_AGGRO, EVENT_T_KILL, EVENT_T_DEATH, EVENT_T_SPELLHIT, EVENT_T_OOC_LOS, EVENT_T_FRIENDLY_HP, EVENT_T_FRIENDLY_IS_CC, EVENT_T_FRIENDLY_MISSING_BUFF, EVENT_T_RECEIVE_EMOTE, EVENT_T_RECEIVE_AI_EVENT)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'center\' valign=\'middle\'>TARGET_T_ACTION_INVOKER_OWNER</td><td align=\'left\' valign=\'middle\'>Unit owning the one responsible for Event to occur, for example, the hunter which pet triggered the event (only works for EVENT_T_AGGRO, EVENT_T_KILL, EVENT_T_DEATH, EVENT_T_SPELLHIT, EVENT_T_OOC_LOS, EVENT_T_FRIENDLY_HP, EVENT_T_FRIENDLY_IS_CC, EVENT_T_FRIENDLY_MISSING_BUFF, EVENT_T_RECEIVE_EMOTE, EVENT_T_RECEIVE_AI_EVENT)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>TARGET_T_HOSTILE_RANDOM_PLAYER</td><td align=\'left\' valign=\'middle\'>Just any random player on our threat list</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>9</td><td align=\'center\' valign=\'middle\'>TARGET_T_HOSTILE_RANDOM_NOT_TOP_PLAYER</td><td align=\'left\' valign=\'middle\'>Any random player from threat list except top aggro (ie except main tank)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>10</td><td align=\'center\' valign=\'middle\'>TARGET_T_EVENT_SENDER</td><td align=\'left\' valign=\'middle\'>Unit who sent an AIEvent that was received with EVENT_T_RECEIVE_AI_EVENT</td></tr>
</table>
','Value|Type|<Description
0|TARGET_T_SELF|self cast
1|TARGET_T_HOSTILE|Our current target (ie: top aggro)
2|TARGET_T_HOSTILE_SECOND_AGGRO|Second highest aggro, usually offtank (generaly used for cleaves and some special attacks)
3|TARGET_T_HOSTILE_LAST_AGGRO|Bottom aggro target (these are healers usually)
4|TARGET_T_HOSTILE_RANDOM|Just any random target on our threat list
5|TARGET_T_HOSTILE_RANDOM_NOT_TOP|Any random target except top aggro
6|TARGET_T_ACTION_INVOKER|Unit who caused this Event to occur (only works for EVENT_T_AGGRO, EVENT_T_KILL, EVENT_T_DEATH, EVENT_T_SPELLHIT, EVENT_T_OOC_LOS, EVENT_T_FRIENDLY_HP, EVENT_T_FRIENDLY_IS_CC, EVENT_T_FRIENDLY_MISSING_BUFF, EVENT_T_RECEIVE_EMOTE, EVENT_T_RECEIVE_AI_EVENT)
7|TARGET_T_ACTION_INVOKER_OWNER|Unit owning the one responsible for Event to occur, for example, the hunter which pet triggered the event (only works for EVENT_T_AGGRO, EVENT_T_KILL, EVENT_T_DEATH, EVENT_T_SPELLHIT, EVENT_T_OOC_LOS, EVENT_T_FRIENDLY_HP, EVENT_T_FRIENDLY_IS_CC, EVENT_T_FRIENDLY_MISSING_BUFF, EVENT_T_RECEIVE_EMOTE, EVENT_T_RECEIVE_AI_EVENT)
8|TARGET_T_HOSTILE_RANDOM_PLAYER|Just any random player on our threat list
9|TARGET_T_HOSTILE_RANDOM_NOT_TOP_PLAYER|Any random player from threat list except top aggro (ie except main tank)
10|TARGET_T_EVENT_SENDER|Unit who sent an AIEvent that was received with EVENT_T_RECEIVE_AI_EVENT');


-- dbocsfields
-- -- -- -- --
update `dbdocsfields` set `FieldComment` = 'The total number of copies of an item or may reference another loot template', `fieldNotes` = 'Depending on the value of the field it may either define the minimum number of copies for the item to be dropped, or it may reference another loot template.' where `fieldId`= '1436' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Dependent faction (See Faction.dbc).', `fieldNotes` = 'A faction for which reputation is awarded. The value has to match with a faction identifier defined in Faction.dbc. This is an alternative to the faction defined.' where `fieldId`= '1442' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Dependent faction (See Faction.dbc).', `fieldNotes` = 'A faction for which reputation is awarded. The value has to match with a faction identifier defined in Faction.dbc. This is an alternative to the faction defined.' where `fieldId`= '1443' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Rate for faction two.', `fieldNotes` = 'The rate applied to the base reputation change, then the result is added to the faction one reputation.' where `fieldId`= '1451' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The topmost rank allowed.', `fieldNotes` = 'The topmost reputation rank allowed. Since reaching it, the faction one reputation is not influenced by this table and should be gained directly.<br />¬subtable:42¬' where `fieldId`= '1447' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Dependent faction (See Faction.dbc).', `fieldNotes` = 'A faction for which reputation is awarded. The value has to match with a faction identifier defined in Faction.dbc. This is an alternative to the faction defined.' where `fieldId`= '1444' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Rate for faction three.', `fieldNotes` = 'The rate applied to the base reputation change, then the result is added to the faction one reputation.' where `fieldId`= '1452' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The topmost rank allowed.', `fieldNotes` = 'The topmost reputation rank allowed. Since reaching it, the faction one reputation is not influenced by this table and should be gained directly.<br />¬subtable:42¬' where `fieldId`= '1448' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Dependent faction (See Faction.dbc).', `fieldNotes` = 'A faction for which reputation is awarded. The value has to match with a faction identifier defined in Faction.dbc. This is an alternative to the faction defined.' where `fieldId`= '1445' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Rate for faction four.', `fieldNotes` = 'The rate applied to the base reputation change, then the result is added to the faction one reputation.' where `fieldId`= '1453' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The topmost rank allowed.', `fieldNotes` = 'The topmost reputation rank allowed. Since reaching it, the faction one reputation is not influenced by this table and should be gained directly.<br />¬subtable:42¬' where `fieldId`= '1449' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The name to disallow for characters created on normal player accounts.', `fieldNotes` = 'The name to disallow for characters created on normal player accounts.' where `fieldId`= '1454' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The total number of copies of an item or may reference another loot template', `fieldNotes` = 'Depending on the value of the field it may either define the minimum number of copies for the item to be dropped, or it may reference another loot template.' where `fieldId`= '1490' and `languageId`= 0;
-- Corrections, missing content, and Note(s) added to the fields
update `dbdocsfields` set `FieldComment` = 'The state of the event node.', `fieldNotes` = 'The state of the event node. Node status is defined differently in every battleground script.<br /><br /><b>Note:</b><br />If you update battleground scripts and make changes to node status values ensure that you provide database update scripts which update the battleground events accordingly.<br />' where `fieldId`= '18' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references a script using an action of the type ACTION_T_TEXT.', `fieldNotes` = 'This references a script using an action of the type ACTION_T_TEXT in the Creature AI Scripts tables entry (See creature_ai_scripts).<br /><br /><b>Note:</b><br />IDs use the negative versions of the referenced action’s ID.' where `fieldId`= '103' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The creature\'s death state.', `fieldNotes` = 'The creature\'s death state. A boolean, 0 = Alive, 1 = Corpse lying dead around (no gossip possible when dead, if you need corpse-gossip use dynamicflags|32) <br />¬subtable:119¬<br /><br /><b>Note:</b><br />Dead creatures can not have gossip dialogues, unless you explicitly set the dynamic flag for corpses on the “creature_template” table.<br /><br />' where `fieldId`= '41' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Base melee attack power that has been factored for low level creatures.', `fieldNotes` = 'Base melee attack power that has been factored for low level creatures.<br /><br /><b>Note:</b><br />This is raw base value to be used for all melee damage calculations.' where `fieldId`= '287' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Base ranged attack power.', `fieldNotes` = 'Base ranged attack power.<br /><br /><b>Note:</b><br />This is raw base value to be used for all ranged damage calculations.' where `fieldId`= '288' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The Faction If The Creature Is On The Alliance Side (See FactionTemplate.dbc).', `fieldNotes` = 'The Faction If The Creature Is On The Alliance Side (See FactionTemplate.dbc).. Just Because More Than One Faction Has The Same Name, The Inter-Faction Relationships Can Be Different.<br /><br /><b>Note:</b><br />This Field Also Controls The Creature Family Assistance Mechanic. Only Creatures With The Same Faction Will Assist Each Other.' where `fieldId`= '216' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The Faction If The Creature Is On The Alliance Side (See FactionTemplate.dbc).', `fieldNotes` = 'The Faction If The Creature Is On The Alliance Side (See FactionTemplate.dbc).. Just Because More Than One Faction Has The Same Name, The Inter-Faction Relationships Can Be Different.<br /><br /><b>Note:</b><br />This Field Also Controls The Creature Family Assistance Mechanic. Only Creatures With The Same Faction Will Assist Each Other.' where `fieldId`= '217' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This Defines The Family That This Creature Belongs To.', `fieldNotes` = 'This Defines The Family That This Creature Belongs To. This Is Only Used If CreatureType Is 1 (Beast).<br />¬subtable:25¬<br /><br /><b>Note:</b><br />It has to be evaluated if creatures of type 3 (Demons) should have their family set, as there are creature families defined for these. Also, remote control family would probably be having a type of 9 since these are mechanical.' where `fieldId`= '218' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A creature’s class. The following table describes the available classes.', `fieldNotes` = 'A creature’s class. The following table describes the available classes.<br />¬subtable:121¬<br /><br /><b>Note:</b><br />Depending on the creature’s class, you have to make sure that the mana values are set properly. E.g. a Warrior or Rogue will not have mana set.' where `fieldId`= '272' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A damage school for melee combat.', `fieldNotes` = 'A damage school for melee combat. The following table provides a list of valid values.<br />¬subtable:122¬' where `fieldId`= '209' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This mask can be used to make creatures immune to spell mechanics.', `fieldNotes` = 'This mask can be used to make creatures immune to spell mechanics. Multiple immunities can be combined.<br />¬subtable:123¬<br /><br /><b>Note:</b><br />In theory this should somehow relates to SpellMechanic.dbc and the immunities list there, but it does not match.' where `fieldId`= '232' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The value of this field will restrict access to class and/or pet trainers', `fieldNotes` = 'The value of this field will restrict access to class and/or pet trainers, if set to a value corresponding with the class identifiers from ChrClasses.dbc.<br />¬subtable:124¬<br /><br /><b>Note:</b><br />Pet trainers should always use the Hunter class identifier 3.' where `fieldId`= '267' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The extra flags allow to modify special behaviour for a creature_template. ', `fieldNotes` = 'The extra flags allow to modify special behaviour for a creature_template. The following table contains a list of combinable flags.<br />¬subtable:125¬' where `fieldId`= '215' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The affects the creature\'s power.', `fieldNotes` = 'Setting this value to a value smaller or larger than 1 will modify the creature template’s power by this factor.' where `fieldId`= '248' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This affects the amount of damage a creature can do.', `fieldNotes` = 'Setting this value to a value smaller or larger than 1 will modify the creature template’s damage by this factor.' where `fieldId`= '208' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is used in damage calculations.', `fieldNotes` = 'Damage Variance is a Co-Efficient used in Damage Calculations To Limit the Min/Max Damage Range.<br /><br />Default Value is 1 (Normal) ===> See DamageMultiplier for More Information' where `fieldId`= '210' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This affects the amount of experience the creature will earn.', `fieldNotes` = 'Setting this value to a value smaller or larger than 1 will modify experience gained from the creature template by this factor.' where `fieldId`= '214' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The minimum health of the creature.', `fieldNotes` = 'The minimum health of the creature if the creature has variable health.' where `fieldId`= '236' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The maximum health of the creature.', `fieldNotes` = 'The maximum health of the creature if the creature has a variable health. When added to world, the health value is chosen in proportion to the level chosen.' where `fieldId`= '227' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The miminum mana of the creature if the creature has variable mana.', `fieldNotes` = 'The miminum mana of the creature if the creature has variable mana.' where `fieldId`= '237' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The maximum mana of the creature.', `fieldNotes` = 'The maximum mana of the creature if the creature has variable mana. When added to world, the mana value is chosen in proportion to the level chosen.' where `fieldId`= '228' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Minimum damage the creature deals in melee combat.', `fieldNotes` = 'Minimum damage the creature deals in melee combat. This field is combined with the attackpower field to calculate the damage.' where `fieldId`= '239' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Maximum damage the creature deals in melee combat.', `fieldNotes` = 'Maximum damage the creature deals in melee combat. This field is combined with the attackpower field to calculate the damage.' where `fieldId`= '230' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Minimum damage the creature deals in ranged combat.', `fieldNotes` = 'Minimum damage the creature deals in ranged combat. This field is combined with the ranged attackpower field to calculate the damage.' where `fieldId`= '240' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This adds loot to the creature.', `fieldNotes` = 'The field adds loot to a creature template and references the “creature_loot_template” table unique ID for which the entry is valid.' where `fieldId`= '224' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This adds pickpocket loot to the creature.', `fieldNotes` = 'The field adds pickpocketing loot to a creature template and references the “pickpocketing_loot_template” tables unique ID for which the entry is valid.' where `fieldId`= '247' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This adds skinning loot to the creature.', `fieldNotes` = 'The field adds skinning loot to a creature template and references the “skinning_loot_template” tables unique ID for which the entry is valid.' where `fieldId`= '263' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The movement type defines what a creature spawn will behave like after spawning.', `fieldNotes` = 'The movement type defines what a creature spawn will behave like after spawning.<br />¬subtable:126¬<br />' where `fieldId`= '243' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This details what kind of trainer the creature is.', `fieldNotes` = 'For creature templates set to be trainers, this details what kind of trainer the creature is. The following table provides a list of valid trainer types.<br />¬subtable:127¬' where `fieldId`= '271' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This field adds a training spells to a creature template.', `fieldNotes` = 'This field adds a training spells to a creature template and references the “npc_trainer_template” tables unique ID for which the entry is valid.' where `fieldId`= '270' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This field adds a vendor items to a creature template.', `fieldNotes` = 'This field adds a vendor items to a creature template and references the “npc_vendor_template” tables unique ID for which the entry is valid.' where `fieldId`= '274' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This field is used for adding gossip to the creature.', `fieldNotes` = 'This references the “gossip_menu” tables unique ID for which the entry is valid, if the creature_template should have a gossip dialogue.' where `fieldId`= '219' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The field adds equipment to a creature.', `fieldNotes` = 'The field adds equipment to a creature template and references the “creature_equip_template” tables unique ID for which the entry is valid.' where `fieldId`= '213' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds. Note that for any delay>0, the creature is dead and cannot perform any action by itself (including cast).<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.' where `fieldId`= '352' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the “gameobject” table or “creature” table table.' where `fieldId`= '355' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '346' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '347' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '348' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '349' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The delay in seconds to apply before starting the script command. ', `fieldNotes` = 'The delay in seconds to apply before starting the script command. Setting the value to 0 will instantly execute the command.<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.' where `fieldId`= '369' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the “gameobject” table or “creature” table table.' where `fieldId`= '372' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '363' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '364' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '365' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '366' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The delay in seconds to apply before starting the script command.', `fieldNotes` = 'The delay in seconds to apply before starting the script command. Setting the value to 0 will instantly execute the command.<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.' where `fieldId`= '386' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the “gameobject” table or “creature” table table.' where `fieldId`= '389' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '380' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '381' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands..' where `fieldId`= '382' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values.<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '383' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The delay in seconds to apply before starting the script command.', `fieldNotes` = 'Delay in seconds.The delay in seconds to apply before starting the script command. Setting the value to 0 will instantly execute the command<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.' where `fieldId`= '437' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the “gameobject” table or “creature” table table.' where `fieldId`= '440' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.<br />' where `fieldId`= '431' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '432' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '433' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '434' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The delay in seconds to apply before starting the script command.', `fieldNotes` = 'The delay in seconds to apply before starting the script command. Setting the value to 0 will instantly execute the command<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.' where `fieldId`= '403' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the “gameobject” table or “creature” table table.<br />' where `fieldId`= '406' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '397' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '398' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '399' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands..' where `fieldId`= '400' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The delay in seconds to apply before starting the script command.', `fieldNotes` = 'The delay in seconds to apply before starting the script command. Setting the value to 0 will instantly execute the command<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.' where `fieldId`= '420' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the “gameobject” table or “creature” table table.' where `fieldId`= '423' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '414' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '415' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '416' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '417' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The delay in seconds to apply before starting the script command.', `fieldNotes` = 'The delay in seconds to apply before starting the script command. Setting the value to 0 will instantly execute the command<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.' where `fieldId`= '454' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the “gameobject” table or “creature” table table.' where `fieldId`= '457' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.<br />' where `fieldId`= '448' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.<br />' where `fieldId`= '449' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.<br />' where `fieldId`= '450' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.<br />' where `fieldId`= '451' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The delay in seconds to apply before starting the script command.', `fieldNotes` = 'The delay in seconds to apply before starting the script command. Setting the value to 0 will instantly execute the command<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.' where `fieldId`= '471' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the “gameobject” table or “creature” table table.' where `fieldId`= '474' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '465' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '466' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '467' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '468' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The delay in seconds to apply before starting the script command', `fieldNotes` = 'The delay in seconds to apply before starting the script command. Setting the value to 0 will instantly execute the command<br /><br /><b>Note:</b><br />Delay is accumulated over all events with identical id values.' where `fieldId`= '488' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic<br /><br /><b>Note:</b><br />If data_flags has SCRIPT_FLAG_BUDDY_BY_GUID set, this references an entry in the “gameobject” table or “creature” table table.' where `fieldId`= '491' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '482' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '483' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '484' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'A multi-purpose data field storing signed integer values<br /><br /><b>Note:</b><br />Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '485' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Sound ID. See SoundEntries.dbc.', `fieldNotes` = 'ID of the sound which will accompany the text appearance.<br />These IDs are tied to filenames in SoundEntries.dbc. The corresponding sound files are stored in the client MPQ archives.<br />Example: sound 8580 is tied to the file CThunDeathIsClose.wav, which is found under SoundCreatureCThun section of an MPQ archive, this time it is patch.MPQ.<br />¬subtable:128¬<br />' where `fieldId`= '324' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'This field determines if an item should drop by chance, or by the character looting having a quest. The meaning is determined by the fields signedness and the value of the mincountOrRef field’s value.<br /><br />The following table shows possible combinations and their meanings.<br />¬subtable:129¬<br /><br><br /><br /><b>Note:</b><br />Setting ChanceOrQuestChance to 0 is only allowed for entries which are part of a loot group (aka. have a groupid set). Also note that non-zero values are subject to multiplication based on the drop rate configured in the world server configuration if they are not part of a loot group.<br /><br />' where `fieldId`= '495' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'New modelID (See creature_template.ModelId1,2)', `fieldNotes` = 'New modelID of the creature (creature_template.ModelId1 or ModelId2) applied during the event<br /><br /><b>Note:</b><br />Set to 0 if only the equipment should be changed.' where `fieldId`= '524' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'New equipment ID (See creature_equip_template.entry).', `fieldNotes` = 'New equipment ID (See creature_equip_template.entry) applied during the event.<br /><br /><b>Note:</b><br />Set to 0 if only the model should be changed.' where `fieldId`= '521' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Event duration (minutes).', `fieldNotes` = 'The interval (in minutes) between start and end of single event occurence<br /><br /><b>Note:</b><br />If length is > occurence, an event would never stop.' where `fieldId`= '515' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Player faction', `fieldNotes` = 'Faction: ALLIANCE = 469, HORDE = 67, both = 0.<br />Some graveyards accept ghosts of players only from one faction.<br />¬subtable:130¬<br />' where `fieldId`= '536' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'GameObject ID (See gameobject_template.entry).', `fieldNotes` = 'ID of the GameObject (See gameobject_template.entry) which takes the quest<br /><br /><b>Note:</b><br />Game object templates need to be of type quest giver.' where `fieldId`= '576' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The state of the event node. ', `fieldNotes` = 'The state of the event node. Node status is defined differently in every battleground script.<br /><br />Node events can occur for every node and usually describe changes due to character interaction. E.g. if stables in Arathi Basin are taken over by Alliance, the stables note state would become Alliance controlled. Similar node states exist for every battleground note<br /><br /><b>Note:</b><br />If you update battleground scripts and make changes to node status values ensure that you provide database update scripts which update the battleground events accordingly.<br />' where `fieldId`= '574' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'GameObject ID (See gameobject_template.entry).', `fieldNotes` = 'ID of the GameObject (See gameobject_template_entry) that starts the quest<br /><br /><b>Note:</b><br />Game object templates need to be of type quest giver.<br />' where `fieldId`= '585' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The respawn time for the game object, defined in seconds till respawn.', `fieldNotes` = 'The respawn time for the game object, defined in seconds till respawn<br /><br /><b>Note:</b><br />Using a negative spawn time will lead to the object being despawned until spawned by a script. It will then despawn after the time specified here.' where `fieldId`= '571' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Not really known what this is used for at this time (see description).', `fieldNotes` = 'Not really known what this is used for at this time<br /><br /><b>Note:</b><br />Set to 100 for game objects of type chest.' where `fieldId`= '559' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The name of the teleport location.', `fieldNotes` = 'The name of the teleport location<br /><br /><b>Note:</b><br />Using spaces and special characters for locations is prohibited.' where `fieldId`= '541' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Gossip option ID.', `fieldNotes` = 'ID of the option of the gossip menu item, see enum Gossip_Option in GossipDef.h.<br />¬subtable:34¬<br /><br><br /><br /><b>Note:</b><br />In order for gossip_menu_option entries to work, the npcflag of the “creature_template” table table entry needs to be set appropriately.' where `fieldId`= '636' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Gossip ID for the action (see gossip_menu.entry).', `fieldNotes` = 'Gossip ID for the action (see gossip_menu.entry).<br />The scheme allows to create chains of gossips. Typical situation is a long story NPC tells to the player, requesting menu item as a confirmation after each brief part<br /><br /><b>Note:</b><br />If you want the gossip_menu_option to close the gossip window, set this field to -1.' where `fieldId`= '625' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Class of the item.', `fieldNotes` = 'Class of the item is it very general description.<br />¬subtable:16¬<br /><br><br /><br /><b>Note:</b><br />The table only contains active classes, obsolete classes have been stripped.' where `fieldId`= '683' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The subclass of the item template.', `fieldNotes` = 'The subclass of the item template.<br />¬subtable:17¬<br /><br><br /><br /><b>Note:</b><br />The table only contains active subclasses, obsolete classes have been stripped.' where `fieldId`= '799' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Stack size by vendors.', `fieldNotes` = 'If an item is sold in stacks, the holds the number of items in a stack<br /><br /><b>Note:</b><br />If an item has limited supplies, the item is refresh to this count.' where `fieldId`= '681' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Mask of allowed classes.', `fieldNotes` = 'A bit-mask corresponding to class that should be able to use the item. The value has to match with classes defined in ChrClasses.dbc.<br />¬subtable:40¬<br /><br /><b>Note:</b><br />Set to -1 to allow usage by all classes.' where `fieldId`= '672' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Mask of allowed races.', `fieldNotes` = 'A bit-mask corresponding to races that should be able to use the item. The value has to match with races defined in ChrRaces.dbc.<br />¬subtable:30¬<br /><br><br /><br /><b>Note:</b><br />Set to -1 to allow usage by all races.' where `fieldId`= '673' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'If an item is a bag, this holds a bit-mask corresponding to bag families to whic', `fieldNotes` = 'If an item is a bag, this holds a bit-mask corresponding to bag families to which the bag belongs. The value has to match with bag families defined in ItemBagFamily.dbc<br /><br /><b>Note:</b><br />Multiple bag families may be combined.' where `fieldId`= '678' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Items may have a duration set until the get removed from a character’s inventory', `fieldNotes` = 'Items may have a duration set until the get removed from a character’s inventory<br /><br /><b>Note:</b><br />Items set to be deleted in real time, require ExtraFlags set accordingly.' where `fieldId`= '704' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This table holds strings used internally by the server to allow translations.', `fieldNotes` = 'The ID that the core uses to identify a string. These IDs are contained and used internally and need to correspond to what the core expects<br /><br /><b>Note:</b><br />The core will not operate if strings are missing from this table.<br />' where `fieldId`= '1105' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Type of the word.', `fieldNotes` = 'Type of the word. If equal to 0, the word is first namepart, otherwise is the second one.<br />¬subtable:131¬' where `fieldId`= '1225' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The quest flags give additional details on the quest type.', `fieldNotes` = 'The quest flags give additional details on the quest type. Flags set here will determine mostly grouping behaviour. Multiple flags may be combined.<br /><br />The following table list known flags.<br />¬subtable:114¬<br /><br><br /><br /><b>Note:</b><br />Not all quest flags are currently supported by the core.<br />' where `fieldId`= '1344' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of the item required for making quest items', `fieldNotes` = 'If the quest requires items created by using another item, set this to an item identifier, referencing the creating items entry in the “item_template” table.<br /><br /><b>Note:</b><br />This is required to decide if these items should be included in loot or not.' where `fieldId`= '1368' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of the item required for making quest items', `fieldNotes` = 'If the quest requires items created by using another item, set this to an item identifier, referencing the creating items entry in the “item_template” table.<br /><br /><b>Note:</b><br />This is required to decide if these items should be included in loot or not.' where `fieldId`= '1369' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of the item required for making quest items', `fieldNotes` = 'If the quest requires items created by using another item, set this to an item identifier, referencing the creating items entry in the “item_template” table.<br /><br /><b>Note:</b><br />This is required to decide if these items should be included in loot or not.' where `fieldId`= '1370' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'item_template ID of the item required for making quest items', `fieldNotes` = 'If the quest requires items created by using another item, set this to an item identifier, referencing the creating items entry in the “item_template” table.<br /><br /><b>Note:</b><br />This is required to decide if these items should be included in loot or not.' where `fieldId`= '1371' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The gender of characters to which the spell is applied.', `fieldNotes` = 'The gender of characters to which the spell is applied. The following table list available values.<br /><br />Gender of the creature<br />¬subtable:132¬<br />' where `fieldId`= '1498' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Defines what type of potion/food spell this is.', `fieldNotes` = 'Defines what type of potion/food spell this is. The following table lists the available values.<br />¬subtable:133¬<br />' where `fieldId`= '1524' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Facing caster flags.', `fieldNotes` = 'Facing caster flags, see enum SpellFacingFlags in Unit.h.<br />Currenlty (0.20), in the core is defined the only flag SPELL_FACING_FLAG_INFRONT=1<br /><br /><b>Note:</b><br />Setting this to zero would disable the need to face the target.' where `fieldId`= '1526' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Active flag.', `fieldNotes` = 'The active flag. If set, the spell is enabled as active, i.e. allowed to be casted.<br />¬subtable:134¬' where `fieldId`= '1527' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell school mask.', `fieldNotes` = 'Spell school mask. Spell School is defined in in the second field of Spell.dbc entry. This value is the bitmask (see enum SpellSchoolMask in SharedDefines.h), where different schools may be combined.<br />¬subtable:46¬<br /><br><br /><br /><b>Note:</b><br />Multiple school masks can be combined to have spell trigger on more than one spell school.' where `fieldId`= '1544' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The spell identifier.', `fieldNotes` = 'The spell identifier. The value has to match with a spell identifier defined (See Spell.dbc)<br /><br /><b>Note:</b><br />Any spell referenced is required to be rank 1 in the spell chain, and has to have threat values set in the original spell definition.</h4>' where `fieldId`= '1562' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The first actiontype.', `fieldNotes` = 'The first actiontype<br /><br /><br />Before we start to list and explain the different actions that can be taken, we must first look at how the eventAI targeting system works. Due to technical reasons in how targetting is handled, the eventAI script cannot target anything or anyone that is not in its threat list or is not the scripted creature itself. It also can\'t currently target anyone specific in its threat list except by their position in the threat list. However, even then it can only target specifically the current victim, the second unit in its threat list, and the last unit in its threat list. It can also target units in its threat list at random and has two options for that: anyone in its threat list at random, or anyone in its threat list excluding the unit with the most threat. Aside from all of those external targets, the script can always target itself. More information on the target types can be found in the reference tables at the end of this guide.<br /><br />One last note before we start looking at individual actions is about the texts. The eventAI script has support for localized text entries. Therefore, you can define what the mob will say in more than one language all in another table and the script will show the corresponding localized text to the corresponding client (english text to enUS/enGB clients, german text to deDE clients, etc). All of the localized text entries will have a unique text ID assigned to them and it is that text ID that will be used by any actions that require textual input.<br /><br />¬subtable:2¬<br /><br />Possible target types<br />¬subtable:136¬' where `fieldId`= '65' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Parameter 2 of action2_type (See creature_ai_scripts.action2_type)', `fieldNotes` = 'Parameter 2 of action2_type (See creature_ai_scripts.action2_type)' where `fieldId`= '67' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The attack power for the creature\'s melee attacks.', `fieldNotes` = 'The attack power for the creature\'s melee attacks. This field along with MinMeleeDmg and MaxMeleeDmg dictate how much the creature will hit for. The formula for applying correct damages is as follows:<br /><pre>UPDATE `creature_template` SET<br />    `MinMeleeDmg` = <#1>,<br />    `MaxMeleeDmg` = <#2>,<br />    `MeleeAttackPower` = ROUND((`MinMeleeDmg` + `MaxMeleeDmg`) / 4 * 7),<br />    `MinMeleeDmg` = ROUND(`MinMeleeDmg` - `MeleeAttackPower` / 7),<br />    `MaxMeleeDmg` = ROUND(`MaxMeleeDmg` - `MeleeAttackPower` / 7)<br />WHERE `Entry` = ...<br /></pre>In the query above, substitute <#1> with the minimum damage you want the creature to deal and <#2> with the maximum damage you want the creature to deal.<br /><br /><b>Note:</b><br />You might want to double check the calculated values after the query has run because a large difference between MinMeleeDmg and MaxMeleeDmg can cause MinMeleeDmg to become a negative value.' where `fieldId`= '233' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references the “npc_text” tables unique ID.', `fieldNotes` = 'This references the “npc_text” tables unique ID of the NPC text for which the entry is valid.<br /><br /><b>Note:</b><br />To actually make a creature display a gossip dialogue with the linked text, you will have to update the “creature_template” table as follows:<br /><pre>SET @CREATURE_FLAG_NPC_GOSSIP                   = 1;<br /><br />UPDATE `creature_template`<br />SET<br />    `NpcFlags`              = `NpcFlags` | @CREATURE_FLAG_NPC_GOSSIP,<br />WHERE<br />    `entry`                 = YOUR-CREATURE;<br /></pre>This will add the gossip flag to any existing flags and thus enable the link text to be displayed.' where `fieldId`= '1107' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Marks a creature template as a civilian.', `fieldNotes` = 'Marking a creature template as civilian will prevent it from aggroing and may influence the honor points gained negatively.<br />¬subtable:9¬' where `fieldId`= '205' and `languageId`= 0;

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