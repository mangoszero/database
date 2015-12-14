-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos` ()

BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT structure FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurContent := (SELECT content FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '2'; 
    SET @cOldContent = '0'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '2';
    SET @cNewContent = '1';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Characters dbdocs update'; 

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Characters database dbdocs update to the fields and new tables added';

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

-- dbdocssubtables
-- -- -- -- -- --
delete from `dbdocssubtables` where `subtableId`= 28 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (28,0,'characters playerBytes','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Attribute</b></th>
<th><b>Offset</b></th>
<th><b>Bits</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>skin</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>0 - 7</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>face</td><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>8 - 15</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>hairStyle</td><td align=\'center\' valign=\'middle\'>16</td><td align=\'center\' valign=\'middle\'>16 - 23</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>hairColor</td><td align=\'center\' valign=\'middle\'>24</td><td align=\'center\' valign=\'middle\'>24 - 31</td></tr>
</table>
','Attribute|Offset|Bits
skin|0|0 - 7
face|8|8 - 15
hairStyle|16|16 - 23
hairColor|24|24 - 31');
delete from `dbdocssubtables` where `subtableId`= 29 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (29,0,'characters actionBars','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Action bar</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>bottom left</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>bottom right</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>right action bar</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>12</td><td align=\'left\' valign=\'middle\'>right action bar and action bar2</td></tr>
</table>
','Value|<Action bar
1|bottom left
2|bottom right
4|right action bar
12|right action bar and action bar2');
delete from `dbdocssubtables` where `subtableId`= 30 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (30,0,'characters playerFlags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Flag</b></th>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_NONE</td><td align=\'center\' valign=\'middle\'>0x00000000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_GROUP_LEADER</td><td align=\'center\' valign=\'middle\'>0x00000001</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_AFK</td><td align=\'center\' valign=\'middle\'>0x00000002</td><td align=\'left\' valign=\'middle\'>Player is away from keyboard</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_DND</td><td align=\'center\' valign=\'middle\'>0x00000004</td><td align=\'left\' valign=\'middle\'>Player has do not disturb set</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_GM</td><td align=\'center\' valign=\'middle\'>0x00000008</td><td align=\'left\' valign=\'middle\'>GM mode is on</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_GHOST</td><td align=\'center\' valign=\'middle\'>0x00000010</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_RESTING</td><td align=\'center\' valign=\'middle\'>0x00000020</td><td align=\'left\' valign=\'middle\'>Player is in a rest area, such as a town</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_UNK7</td><td align=\'center\' valign=\'middle\'>0x00000040</td><td align=\'left\' valign=\'middle\'>admin?</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_FFA_PVP</td><td align=\'center\' valign=\'middle\'>0x00000080</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_CONTESTED_PVP</td><td align=\'center\' valign=\'middle\'>0x00000100</td><td align=\'left\' valign=\'middle\'>Player has been involved in a PvP combat and will be attacked by contested guards</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_IN_PVP</td><td align=\'center\' valign=\'middle\'>0x00000200</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_HIDE_HELM</td><td align=\'center\' valign=\'middle\'>0x00000400</td><td align=\'left\' valign=\'middle\'>Player has hide helm set</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_HIDE_CLOAK</td><td align=\'center\' valign=\'middle\'>0x00000800</td><td align=\'left\' valign=\'middle\'>Player has hide cloak set</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_PARTIAL_PLAY_TIME</td><td align=\'center\' valign=\'middle\'>0x00001000</td><td align=\'left\' valign=\'middle\'>played long time</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_NO_PLAY_TIME</td><td align=\'center\' valign=\'middle\'>0x00002000</td><td align=\'left\' valign=\'middle\'>played too long time</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_UNK15</td><td align=\'center\' valign=\'middle\'>0x00004000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_UNK16</td><td align=\'center\' valign=\'middle\'>0x00008000</td><td align=\'left\' valign=\'middle\'>strange visual effect (2.0.1), looks like PLAYER_FLAGS_GHOST flag</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_SANCTUARY</td><td align=\'center\' valign=\'middle\'>0x00010000</td><td align=\'left\' valign=\'middle\'>player entered sanctuary</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_TAXI_BENCHMARK</td><td align=\'center\' valign=\'middle\'>0x00020000</td><td align=\'left\' valign=\'middle\'>taxi benchmark mode (on/off) (2.0.1)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>PLAYER_FLAGS_PVP_TIMER</td><td align=\'center\' valign=\'middle\'>0x00040000</td><td align=\'left\' valign=\'middle\'>&nbsp;</td></tr>
</table>
','Flag|Value|<Description
PLAYER_FLAGS_NONE|0x00000000|&nbsp;
PLAYER_FLAGS_GROUP_LEADER|0x00000001|&nbsp;
PLAYER_FLAGS_AFK|0x00000002|Player is away from keyboard
PLAYER_FLAGS_DND|0x00000004|Player has do not disturb set
PLAYER_FLAGS_GM |0x00000008|GM mode is on
PLAYER_FLAGS_GHOST|0x00000010|&nbsp;
PLAYER_FLAGS_RESTING|0x00000020|Player is in a rest area, such as a town
PLAYER_FLAGS_UNK7|0x00000040|admin?
PLAYER_FLAGS_FFA_PVP|0x00000080|&nbsp;
PLAYER_FLAGS_CONTESTED_PVP|0x00000100|Player has been involved in a PvP combat and will be attacked by contested guards
PLAYER_FLAGS_IN_PVP|0x00000200|&nbsp;
PLAYER_FLAGS_HIDE_HELM|0x00000400|Player has hide helm set
PLAYER_FLAGS_HIDE_CLOAK|0x00000800|Player has hide cloak set
PLAYER_FLAGS_PARTIAL_PLAY_TIME|0x00001000|played long time
PLAYER_FLAGS_NO_PLAY_TIME|0x00002000|played too long time
PLAYER_FLAGS_UNK15|0x00004000|&nbsp;
PLAYER_FLAGS_UNK16|0x00008000|strange visual effect (2.0.1), looks like PLAYER_FLAGS_GHOST flag
PLAYER_FLAGS_SANCTUARY|0x00010000|player entered sanctuary
PLAYER_FLAGS_TAXI_BENCHMARK |0x00020000|taxi benchmark mode (on/off) (2.0.1)
PLAYER_FLAGS_PVP_TIMER|0x00040000|&nbsp;');
delete from `dbdocssubtables` where `subtableId`= 31 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (31,0,'characters PvP Ranks Enlisted ','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Rank</b></th>
<th><b>Rating Points</b></th>
<th><b>Alliance Title</b></th>
<th><b>Horde Title</b></th>
<th align=\'left\'><b>Reward</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>15 HK (see note)</td><td align=\'center\' valign=\'middle\'>Private</td><td align=\'center\' valign=\'middle\'>Scout</td><td align=\'left\' valign=\'middle\'>Tabard</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>2000</td><td align=\'center\' valign=\'middle\'>Corporal</td><td align=\'center\' valign=\'middle\'>Grunt</td><td align=\'left\' valign=\'middle\'>Team insignia trinket</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'center\' valign=\'middle\'>5000</td><td align=\'center\' valign=\'middle\'>Sergeant</td><td align=\'center\' valign=\'middle\'>Sergeant</td><td align=\'left\' valign=\'middle\'><li>Superior-quality cloak<li>10% discount on all goods and repairs from your faction\'s NPCs</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>10000</td><td align=\'center\' valign=\'middle\'>Master Sergeant</td><td align=\'center\' valign=\'middle\'>Senior Sergeant</td><td align=\'left\' valign=\'middle\'>Superior-quality necklace</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>15000</td><td align=\'center\' valign=\'middle\'>Sergeant Major</td><td align=\'center\' valign=\'middle\'>First Sergeant</td><td align=\'left\' valign=\'middle\'>Superior-quality bracers</td></tr>
</table>
','Rank|Rating Points|Alliance Title|Horde Title|<Reward
1|15 HK (see note)|Private|Scout|Tabard
2|2000|Corporal|Grunt|Team insignia trinket
3|5000|Sergeant|Sergeant|<li>Superior-quality cloak<li>10% discount on all goods and repairs from your faction\'s NPCs
4|10000|Master Sergeant|Senior Sergeant|Superior-quality necklace
5|15000|Sergeant Major|First Sergeant|Superior-quality bracers');
delete from `dbdocssubtables` where `subtableId`= 32 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (32,0,'characters PvP Ranks Officer','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Rank</b></th>
<th><b>Rating Points</b></th>
<th><b>Alliance Title</b></th>
<th><b>Horde Title</b></th>
<th align=\'left\'><b>Reward</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'center\' valign=\'middle\'>20000</td><td align=\'center\' valign=\'middle\'>Knight</td><td align=\'center\' valign=\'middle\'>Stone Guard</td><td align=\'left\' valign=\'middle\'><li>Access to officer\'s barracks<li>Officer\'s tabard<li>Officer\'s potions (Combat Healing Potion and Combat Mana Potion)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'center\' valign=\'middle\'>25000</td><td align=\'center\' valign=\'middle\'>Knight-Lieutenant</td><td align=\'center\' valign=\'middle\'>Blood Guard</td><td align=\'left\' valign=\'middle\'><li>Superior-quality boots<li>Superior-quality gloves</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>30000</td><td align=\'center\' valign=\'middle\'>Knight-Captain</td><td align=\'center\' valign=\'middle\'>Legionnaire</td><td align=\'left\' valign=\'middle\'><li>Superior-quality chest armor<li>Superior-quality leggings</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>9</td><td align=\'center\' valign=\'middle\'>35000</td><td align=\'center\' valign=\'middle\'>Knight-Champion</td><td align=\'center\' valign=\'middle\'>Centurion</td><td align=\'left\' valign=\'middle\'>Battle standard</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>10</td><td align=\'center\' valign=\'middle\'>40000</td><td align=\'center\' valign=\'middle\'>Lieutenant Commander</td><td align=\'center\' valign=\'middle\'>Champion</td><td align=\'left\' valign=\'middle\'><li>Superior-quality helm<li>Superior-quality shoulder armor</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>11</td><td align=\'center\' valign=\'middle\'>45000 (1.4%)</td><td align=\'center\' valign=\'middle\'>Commander</td><td align=\'center\' valign=\'middle\'>Lieutenant General</td><td align=\'left\' valign=\'middle\'><li>Epic mount<li>Ability to talk in World Defense</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>12</td><td align=\'center\' valign=\'middle\'>50000</td><td align=\'center\' valign=\'middle\'>Marshal</td><td align=\'center\' valign=\'middle\'>General</td><td align=\'left\' valign=\'middle\'><li>Epic-quality gloves<li>Epic-quality leggings<li>Epic-quality boots</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>13</td><td align=\'center\' valign=\'middle\'>55000</td><td align=\'center\' valign=\'middle\'>Field Marshal</td><td align=\'center\' valign=\'middle\'>Warlord</td><td align=\'left\' valign=\'middle\'><li>Epic-quality helm<li>Epic-quality shoulder armor<li>Epic-quality chest</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>14</td><td align=\'center\' valign=\'middle\'>60000 (0.1%)</td><td align=\'center\' valign=\'middle\'>Grand Marshal</td><td align=\'center\' valign=\'middle\'>High Warlord</td><td align=\'left\' valign=\'middle\'><li>Epic-quality weapon<li>Epic-quality shield<li>Only top .1% of players can have this rank</td></tr>
</table>
','Rank|Rating Points|Alliance Title|Horde Title|<Reward
6|20000|Knight|Stone Guard|<li>Access to officer\'s barracks<li>Officer\'s tabard<li>Officer\'s potions (Combat Healing Potion and Combat Mana Potion)
7|25000|Knight-Lieutenant|Blood Guard|<li>Superior-quality boots<li>Superior-quality gloves
8|30000|Knight-Captain|Legionnaire|<li>Superior-quality chest armor<li>Superior-quality leggings
9|35000|Knight-Champion|Centurion|Battle standard
10|40000|Lieutenant Commander|Champion|<li>Superior-quality helm<li>Superior-quality shoulder armor
11|45000 (1.4%)|Commander|Lieutenant General|<li>Epic mount<li>Ability to talk in World Defense
12|50000|Marshal|General|<li>Epic-quality gloves<li>Epic-quality leggings<li>Epic-quality boots
13|55000|Field Marshal|Warlord|<li>Epic-quality helm<li>Epic-quality shoulder armor<li>Epic-quality chest
14|60000 (0.1%)|Grand Marshal|High Warlord|<li>Epic-quality weapon<li>Epic-quality shield<li>Only top .1% of players can have this rank');
delete from `dbdocssubtables` where `subtableId`= 33 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (33,0,'Character Pet loyalty','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Loyalty</b></th>
<th><b>Value</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>REBELLIOUS</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>UNRULY</td><td align=\'center\' valign=\'middle\'>2</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>SUBMISSIVE</td><td align=\'center\' valign=\'middle\'>3</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>DEPENDABLE</td><td align=\'center\' valign=\'middle\'>4</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>FAITHFUL</td><td align=\'center\' valign=\'middle\'>5</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>BEST_FRIEND</td><td align=\'center\' valign=\'middle\'>6</td></tr>
</table>
','Loyalty|Value
REBELLIOUS|1
UNRULY|2
SUBMISSIVE|3
DEPENDABLE|4
FAITHFUL|5
BEST_FRIEND|6');
delete from `dbdocssubtables` where `subtableId`= 34 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (34,0,'Groups lootMethod','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Method</b></th>
<th><b>Value</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>FREE_FOR_ALL</td><td align=\'center\' valign=\'middle\'>0</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>ROUND_ROBIN</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>MASTER_LOOT</td><td align=\'center\' valign=\'middle\'>2</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>GROUP_LOOT</td><td align=\'center\' valign=\'middle\'>3</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>NEED_BEFORE_GREED</td><td align=\'center\' valign=\'middle\'>4</td></tr>
</table>
','Method|Value
FREE_FOR_ALL|0
ROUND_ROBIN|1
MASTER_LOOT|2
GROUP_LOOT|3
NEED_BEFORE_GREED|4');
delete from `dbdocssubtables` where `subtableId`= 35 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (35,0,'groups lootThreshold','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Quality</b></th>
<th><b>Value</b></th>
<th><b>Colour</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>ITEM_QUALITY_POOR</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>GREY</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>ITEM_QUALITY_NORMAL</td><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>WHITE</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>ITEM_QUALITY_UNCOMMON</td><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>GREEN</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>ITEM_QUALITY_RARE</td><td align=\'center\' valign=\'middle\'>3</td><td align=\'center\' valign=\'middle\'>BLUE</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>ITEM_QUALITY_EPIC</td><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>PURPLE</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>ITEM_QUALITY_LEGENDAR</td><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>ORANGE</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>ITEM_QUALITY_ARTIFACT</td><td align=\'center\' valign=\'middle\'>6</td><td align=\'center\' valign=\'middle\'>LIGHT YELLOW</td></tr>
</table>
','Quality|Value|Colour
ITEM_QUALITY_POOR|0|GREY
ITEM_QUALITY_NORMAL|1|WHITE
ITEM_QUALITY_UNCOMMON|2|GREEN
ITEM_QUALITY_RARE|3|BLUE
ITEM_QUALITY_EPIC|4|PURPLE
ITEM_QUALITY_LEGENDAR|5|ORANGE
ITEM_QUALITY_ARTIFACT|6|LIGHT YELLOW');
delete from `dbdocssubtables` where `subtableId`= 36 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (36,0,'Extra Flags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Bit</b></th>
<th><b>Name</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>PLAYER_EXTRA_GM_ON</td><td align=\'left\' valign=\'middle\'>Defines GM state</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>PLAYER_EXTRA_GM_ACCEPT_TICKETS</td><td align=\'left\' valign=\'middle\'>Defines if tickets are accepted</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>PLAYER_EXTRA_ACCEPT_WHISPERS</td><td align=\'left\' valign=\'middle\'>Defines if whispers are accepted</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>PLAYER_EXTRA_TAXICHEAT</td><td align=\'left\' valign=\'middle\'>Sets taxicheat></td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'center\' valign=\'middle\'>PLAYER_EXTRA_GM_INVISIBLE</td><td align=\'left\' valign=\'middle\'>Control\'s GM\'s invisibly</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>32</td><td align=\'center\' valign=\'middle\'>PLAYER_EXTRA_GM_CHAT</td><td align=\'left\' valign=\'middle\'>Show GM badge in chat messages</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>64</td><td align=\'center\' valign=\'middle\'>PLAYER_EXTRA_PVP_DEATH</td><td align=\'left\' valign=\'middle\'>Store PvP death status until corpse creating</td></tr>
</table>
','Bit|Name|<Description
1|PLAYER_EXTRA_GM_ON|Defines GM state
2|PLAYER_EXTRA_GM_ACCEPT_TICKETS|Defines if tickets are accepted
4|PLAYER_EXTRA_ACCEPT_WHISPERS|Defines if whispers are accepted
8|PLAYER_EXTRA_TAXICHEAT|Sets taxicheat>
16|PLAYER_EXTRA_GM_INVISIBLE|Control\'s GM\'s invisibly
32|PLAYER_EXTRA_GM_CHAT|Show GM badge in chat messages
64|PLAYER_EXTRA_PVP_DEATH|Store PvP death status until corpse creating');

-- dbocsfields
-- -- -- -- --
update `dbdocsfields` set `FieldComment` = 'This defines the physical attributes of the character.', `fieldNotes` = 'This defines the following physical attributes of the character: <br />skin, face, hairstyle, hair colour<br />¬subtable:28¬<br /><br />TODO (an example of setting an attribute)' where `fieldId`= '205' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This defines the facial hair physical attribute of the character.', `fieldNotes` = 'This defines the facial hair physical attribute of the character.<br /><br />As with playerBytes, playerBytes2\'s bits (0 to 7) are used to change the character\'s facial hair <br /><br />TODO (an example of setting this attribute)' where `fieldId`= '206' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the rest bonus for the character.', `fieldNotes` = 'This is part of the rest system, and is used to calculate how much rest bonus to give the player when they have been offline. Rest bonus affects the amount of experience the character can earn,' where `fieldId`= '219' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The character\'s health when logging out.', `fieldNotes` = 'The character\'s health when logging out.' where `fieldId`= '193' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'If a mana user, then this is a character\'s mana level when logging out.', `fieldNotes` = 'The character\'s mana level when logging out.' where `fieldId`= '211' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'If a warrior, then this is a character\'s rage level when logging out.', `fieldNotes` = 'If a warrior, then this is character\'s rage level when logging out.' where `fieldId`= '212' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'If a rogue, then this is a character\'s energy level when logging out.', `fieldNotes` = 'If a rogue, then this is character\'s energy level when logging out.' where `fieldId`= '214' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is a record of all areas discovered by the character.', `fieldNotes` = 'This is a record of all areas discovered by the character.' where `fieldId`= '189' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is a record of all items that are currently equipped.', `fieldNotes` = 'This is a record of all items that are currently equipped.<br /><br />Changing this information does not affect what is equipped. It will just revert back to what was originally equipped.' where `fieldId`= '188' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the item_template Entry ID of the ammo currently equipped.', `fieldNotes` = 'This is the item_template Entry ID of the ammo currently equipped.<br /><br />e.g. 2516 light shot' where `fieldId`= '179' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This represents which action bars are currently active.', `fieldNotes` = 'This represents which action bars are currently active.<br />¬subtable:29¬<br /><br />A combination of the above gives you which action bars are currently active, e.g. 3 will be bottom left and bottom right, 7 will be bottom left and right bars and the right action bar, and 19 will be all action bars active.' where `fieldId`= '178' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The is the name of the character being deleted.', `fieldNotes` = 'The is the name of the character being deleted.' where `fieldId`= '186' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the date the character was deleted,', `fieldNotes` = 'This is the date the character was deleted,' where `fieldId`= '184' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the account number from the characters table.', `fieldNotes` = 'This is the account number from the characters table, that the deleted character is on.' where `fieldId`= '185' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This represents the alcoholic strength of the drink.', `fieldNotes` = 'This represents the alcoholic strength of the drink. The stronger the drinker, the longer your character is drunk for <hic>' where `fieldId`= '187' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the transprt the character is currently travelling on.', `fieldNotes` = 'This is the transprt the character is currently travelling on.<br /><br />It\'s the entry ID from the transports table.' where `fieldId`= '231' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The X coordinate of the character on the transport it is travelling on.', `fieldNotes` = 'The X coordinate of the character on the transport it is travelling on at the point of logging off.' where `fieldId`= '228' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The Y coordinate of the character on the transport it is travelling on.', `fieldNotes` = 'The Y coordinate of the character on the transport it is travelling on at the point of logging off.' where `fieldId`= '229' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The Z coordinate of the character on the transport it is travelling on.', `fieldNotes` = 'The Z coordinate of the character on the transport it is travelling on at the point of logging off.' where `fieldId`= '230' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The orientation of the character on the transport it is travelling on.', `fieldNotes` = 'The orientation of the character on the transport it is travelling on at the point of logging off.' where `fieldId`= '227' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the current active pet\'s happiness level.', `fieldNotes` = 'This is the current active pet\'s happiness level at the point of logging off.' where `fieldId`= '215' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is a hunter pet\'s focus level.', `fieldNotes` = 'This is a hunter pet\'s focus level at point of logging off.' where `fieldId`= '213' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'These are the player flags, such as GM mode on or off.', `fieldNotes` = 'These are the player flags. They are represented as decimal values in the database table, and hexidecimal values in the table below.<br />¬subtable:30¬<br />' where `fieldId`= '207' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The is the total dishonorable kills made by the character.', `fieldNotes` = 'The is the total dishonorable kills made by the character.' where `fieldId`= '221' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The is the total honorable kills made by the character.', `fieldNotes` = 'The is the total honorable kills made by the character.' where `fieldId`= '223' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The faction whose rep is being followed on the experience bar.', `fieldNotes` = 'The faction whose rep is being followed on the experience bar.<br /><br />Only one faction at a time can be followed.<br /><br />The ID of the faction being followed will appear in this field, e.g.<br />18 for Gnomeragan Exiles<br />20 for Ironforge<br />21 for Darnassus<br /><br />These are not the same as the Faction IDs from the DBC file.' where `fieldId`= '232' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This shows the highest honor rank ever earned.', `fieldNotes` = 'This shows the highest rank honor ever earned, niot necessarily the current rank.<br /><br /><h2>Enlisted ranks</h2><br />¬subtable:31¬<br /><br /><h2>Officer ranks</h2><br />¬subtable:32¬' where `fieldId`= '194' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the current amount of honor points.', `fieldNotes` = 'This is the current amount of honor points, and relates to the character\'s current honor rank. See the tables under honor_highest_rank.' where `fieldId`= '222' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Primary effect.', `fieldNotes` = 'Primary effect, such as Priest\'s heal, Warloack Demon skin, or Paladin\'s Seal of Righteousness.<br /><br />The effect can be positive or negative.' where `fieldId`= '23' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Secondary effect (healing)', `fieldNotes` = 'This is a secondary effect and appears to be healing related, such as the Warlock Demon skin heal over time.' where `fieldId`= '24' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Secondary effect (damage)', `fieldNotes` = 'This is a secondary effect, and appears to be damage related, such unleasing the Paladin\'s Seal of Righteousness.' where `fieldId`= '25' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Primary effect over time counter.', `fieldNotes` = 'Primary effect over time counter, such as the Priest\'s heal.' where `fieldId`= '31' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Primary effect (healing) over time counter.', `fieldNotes` = 'Primary effect (healing) over time counter.' where `fieldId`= '32' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Primary effect (damage) over time counter.', `fieldNotes` = 'Primary effect (damage) over time counter.' where `fieldId`= '33' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The character battleground datar global unique identifier.', `fieldNotes` = 'The character battleground datar global unique identifier.' where `fieldId`= '39' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The unique ID of the battleground instance the character has entered.', `fieldNotes` = 'The unique ID of the battleground instance the character has entered.' where `fieldId`= '40' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The character\'s X coordinate in the battleground.', `fieldNotes` = 'The character\'s X coordinate in the battleground.' where `fieldId`= '43' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The character\'s Y coordinate in the battleground.', `fieldNotes` = 'The character\'s Y coordinate in the battleground.' where `fieldId`= '44' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The character\'s Z coordinate in the battleground.', `fieldNotes` = 'The character\'s Z coordinate in the battleground.' where `fieldId`= '45' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The character\'s orientation in the battleground.', `fieldNotes` = 'The character\'s orientation in the battleground.' where `fieldId`= '42' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Neutral, Horde, or Alliance', `fieldNotes` = 'Neutral, Horde, or Alliance' where `fieldId`= '46' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Battleground map ID where the character will spawn.', `fieldNotes` = 'Battleground map ID where the character will spawn.' where `fieldId`= '41' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='character_battleground_data', `tableNotes`='This table holds information about the character when it joins a battleground.' where tableId=5;
update `dbdocsfields` set `FieldComment` = 'zzzz', `fieldNotes` = 'TODO - find out what this field is used for!<br /><br />What has been attempted so far in the search  to identify this field\'s purpose: <br />1) moved gift between bags and bank<br />2) gave gift to another character via trade<br />3) sent gift by mail to another character<br /><br />After the above, the value in the field did not change, it was always 0.' where `fieldId`= '49' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='character_honor_cp', `tableNotes`='This table holds information on the honor kills made by the character.' where tableId=9;
update `dbdocsfields` set `FieldComment` = 'The global unique identifier player character (victor)', `fieldNotes` = 'The global unique identifier player character (victor)' where `fieldId`= '59' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The global unique identifier player character (victim)', `fieldNotes` = 'The global unique identifier player character (victim)' where `fieldId`= '62' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Amount of honor earned for the honor kill.', `fieldNotes` = 'Amount of honor earned for the honor kill.' where `fieldId`= '60' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The date the honor kill occured.', `fieldNotes` = 'The date the honor kill occured.' where `fieldId`= '58' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The is appears to be 1 for player and 2 for NPC.', `fieldNotes` = 'The is appears to be 1 for player and 2 for NPC.' where `fieldId`= '61' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This appears to be 4 for a player and 3 for an NPC.', `fieldNotes` = 'This appears to be 4 for a player and 3 for an NPC.' where `fieldId`= '63' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The current amount of loyalty points the pet has.', `fieldNotes` = 'The current amount of loyalty points the pet has.' where `fieldId`= '82' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The pet\'s loyalty level.', `fieldNotes` = 'The pet\'s loyalty level.<br />¬subtable:33¬' where `fieldId`= '81' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Total training points available to spend.', `fieldNotes` = 'Total training points available to spend.' where `fieldId`= '94' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Time of death.', `fieldNotes` = 'Time of death.' where `fieldId`= '244' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Time till the creature should respawn.', `fieldNotes` = 'Time till the creature should respawn.' where `fieldId`= '247' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Instance ID of the instance the creature is respawning into.', `fieldNotes` = 'Instance ID of the instance the creature is respawning into.' where `fieldId`= '246' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Short sentence describing the field\'s purpose.', `fieldNotes` = 'Short sentence describing the field\'s purpose.' where `fieldId`= '248' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Global unique ID of the game object.', `fieldNotes` = 'Global unique ID of the game object.' where `fieldId`= '259' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Time till the game object should respawn.', `fieldNotes` = 'Time till the game object should respawn, as in 60000 for 1 minute after server start..' where `fieldId`= '261' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Instance ID that the game object will spawn in.', `fieldNotes` = 'Instance ID that the game object will spawn in.' where `fieldId`= '260' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Uniquie ID for the group.', `fieldNotes` = 'Uniquie ID for the group.' where `fieldId`= '269' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the group\'s leader', `fieldNotes` = 'Guid of the group\'s leader, from the characters table.' where `fieldId`= '279' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the character who retrieves the loot.', `fieldNotes` = 'Guid of the character who retrieves the loot.' where `fieldId`= '280' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Flag set for if group is part of a raid or not.', `fieldNotes` = 'Flag set for if group is part of a raid or not (1 = raid, 0 = not raid).' where `fieldId`= '278' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the character who is that main tank.', `fieldNotes` = 'Guid of the character who is that main tank.' where `fieldId`= '284' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the character who is that main assist.', `fieldNotes` = 'Guid of the character who is that main assit.<br /><br />This group member calls the shots as to the order in which mobs are taken on.' where `fieldId`= '283' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the loot method used by the group.', `fieldNotes` = 'This is the loot method used by the group.<br />¬subtable:34¬' where `fieldId`= '281' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The quality of the items in the loot to be rolled for.', `fieldNotes` = 'The quality of theitems in the loot to be rolled for. This will be the minimum quality level to throw for, any loot below that will not be thrown for.<br />¬subtable:35¬<br />' where `fieldId`= '282' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of target that has the dimond raid target on it.', `fieldNotes` = 'Guid of target that has the dimond raid target on it.<br /><br />These are placed on playesr and mobs, and can be used for controlling kill orders, crowd control, and assigning players to mobs.' where `fieldId`= '272' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the target that has the circle raid target on it.', `fieldNotes` = 'Guid of the target that has the circle raid target on it.<br /><br />These are placed on playesr and mobs, and can be used for controlling kill orders, crowd control, and assigning players to mobs.' where `fieldId`= '271' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the target that has the star raid target on it.', `fieldNotes` = 'Guid of the target that has the star raid target on it.<br /><br />These are placed on playesr and mobs, and can be used for controlling kill orders, crowd control, and assigning players to mobs.' where `fieldId`= '270' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the target that has the triangler raid target on it.', `fieldNotes` = 'Guid of the target that has the triangler raid target on it.<br /><br />These are placed on playesr and mobs, and can be used for controlling kill orders, crowd control, and assigning players to mobs.' where `fieldId`= '273' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the target that has the moon raid target on it.', `fieldNotes` = 'Guid of the target that has the moon raid target on it.<br /><br />These are placed on playesr and mobs, and can be used for controlling kill orders, crowd control, and assigning players to mobs.' where `fieldId`= '274' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the target that has the square raid target on it.', `fieldNotes` = 'Guid of the target that has the square raid target on it.<br /><br />These are placed on playesr and mobs, and can be used for controlling kill orders, crowd control, and assigning players to mobs.' where `fieldId`= '275' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the target that has the cross raid target on it.', `fieldNotes` = 'Guid of the target that has the cross raid target on it.<br /><br />These are placed on playesr and mobs, and can be used for controlling kill orders, crowd control, and assigning players to mobs.' where `fieldId`= '276' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the target that has the skull raid target on it.', `fieldNotes` = 'Guid of the target that has the skull raid target on it.<br /><br />These are placed on playesr and mobs, and can be used for controlling kill orders, crowd control, and assigning players to mobs.' where `fieldId`= '277' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The group ID from the groups table.', `fieldNotes` = 'The group ID from the groups table.' where `fieldId`= '266' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The GUID of the character in the group.', `fieldNotes` = 'The GUID of the character in the group.' where `fieldId`= '267' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Flag stating whether or not the character is the assist.', `fieldNotes` = 'Flag stating whether or not the character is the assist.<br /><br />The assits controls which mobs to attack and in what order.' where `fieldId`= '265' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the group number within a raid (8 groups max)', `fieldNotes` = 'This is the group number within a raid (8 groups max).<br /><br />Group numbering starts at 0 and end at 7.' where `fieldId`= '268' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Global unique ID of the item loot entry.', `fieldNotes` = 'Global unique ID of the item loot entry.' where `fieldId`= '322' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item template entry ID of the item.', `fieldNotes` = 'Item template entry ID of the item.' where `fieldId`= '323' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Total number of the item.', `fieldNotes` = 'Total number of the item.' where `fieldId`= '321' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item random property.', `fieldNotes` = 'Item random property.' where `fieldId`= '325' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The item_text ID of the massage within the mail.', `fieldNotes` = 'The item_text ID of the massage within the mail.' where `fieldId`= '334' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Boolean value showing whether or not atems have been sent.', `fieldNotes` = 'Boolean value showing whether or not atems have been sent.<br /><br />0 = no item included in the mail.<br />1 = items included in the mail.' where `fieldId`= '332' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The GUID of the item.', `fieldNotes` = 'The GUID of the item.' where `fieldId`= '342' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The entry ID of the item in the item_template table.', `fieldNotes` = 'The entry ID of the item in the item_template table.' where `fieldId`= '343' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the total number of times the aura can be stacked on the pet.', `fieldNotes` = 'This is the total number of times the aura can be stacked on the pet.' where `fieldId`= '360' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Guid of the item that is casting the aura on the pet.', `fieldNotes` = 'Guid of the item that is casting the aura on the pet.' where `fieldId`= '352' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Primary effect.', `fieldNotes` = 'Primary effect, such as healing.' where `fieldId`= '346' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Secondary effect (appears to be only healing related)', `fieldNotes` = 'Secondary effect (appears to be only healing related)' where `fieldId`= '347' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Secondary effect (appears to be only damage related)', `fieldNotes` = 'Secondary effect (appears to be only damage related)' where `fieldId`= '348' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Primary effect over time.', `fieldNotes` = 'Primary effect over time.' where `fieldId`= '354' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Secondary effect (healing) over time', `fieldNotes` = 'Secondary effect (healing) over time' where `fieldId`= '355' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Secondary effect (damage) over time.', `fieldNotes` = 'Secondary effect (damage) over time.' where `fieldId`= '356' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The type of action.', `fieldNotes` = 'The type of action:<br />¬subtable:14¬<br />' where `fieldId`= '22' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The slot is the slot in the bag where the item is.', `fieldNotes` = 'If the bag field is non-zero, then the slot is the slot in the bag where the item is kept. The range can differ depending on the number of slots the bag has.<br /><br />If the bag field is zero, then the slot has a range of 0 to 84 and the value stands for the following:<br />¬subtable:15¬<br /><br />' where `fieldId`= '71' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The current quest status.', `fieldNotes` = 'The current quest status.<br />¬subtable:16¬<br /><br /><br />' where `fieldId`= '107' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This field is a bitmask containing flags that apply to the faction.', `fieldNotes` = 'This field is a bitmask containing flags that apply to the faction and how it\'s displayed to the character. Just like any flag field, you can combine flags by adding them together. <br />If this field is 0, then it is not shown in the reputation list in-game.<br />¬subtable:17¬<br /><br />' where `fieldId`= '110' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Whether the character is a friend or ignored.', `fieldNotes` = 'The flag indicating whether the entry is either a friend or ignored.<br />¬subtable:18¬<br /><br />' where `fieldId`= '117' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The race of the character.', `fieldNotes` = 'The race of the character.<br />¬subtable:12¬<br /><br />' where `fieldId`= '216' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The Sex/Gender of the character.', `fieldNotes` = 'The Sex/Gender of the character.<br />¬subtable:10¬<br /><br />' where `fieldId`= '191' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'These flags control certain player specific attributes, mostly GM features.', `fieldNotes` = 'These flags control certain player specific attributes, mostly GM features<br />¬subtable:36¬' where `fieldId`= '190' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The status of the character.', `fieldNotes` = 'The status of the character.<br />¬subtable:11¬<br /><br />' where `fieldId`= '180' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The Display Type of the corpse.', `fieldNotes` = 'The Display Type of the corpse:<br />¬subtable:19¬<br /><br /><br />' where `fieldId`= '235' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The Guild Event Type.', `fieldNotes` = 'The Guild Event Type:<br />¬subtable:20¬<br /><br />' where `fieldId`= '296' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The rights a player with this rank has in the guild.', `fieldNotes` = 'The rights a player with this rank has in the guild. <br />The calculation of multiple rights is a bit different in this case as the rights do not all have 2^n values. <br />To combine ranks, you must do the OR operation (&#124;) on the two flags.<br />¬subtable:21¬<br /><br /><br />' where `fieldId`= '310' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Much like the playerbytes fields in the characters table.', `fieldNotes` = 'Much like the playerbytes fields in the characters table, this field has many number fields all separated by a space which contain specific individual item information like any enchantments applied to the item, etc.<br />¬subtable:22¬<br />' where `fieldId`= '318' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The StationeryID (See Stationery.dbc).', `fieldNotes` = 'The StationeryID (See Stationery.dbc).<br />¬subtable:24¬' where `fieldId`= '340' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'message_type.', `fieldNotes` = 'The type of the Message:<br />¬subtable:23¬' where `fieldId`= '336' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'checked_flag.', `fieldNotes` = 'checked_flag<br />¬subtable:25¬<br />Flag Mask:<br />¬subtable:26¬<br /><br />' where `fieldId`= '328' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The flags controlling character cleanup.', `fieldNotes` = 'The flags controlling character cleanup:<br />¬subtable:27¬<br /><br />' where `fieldId`= '374' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The ID of the button on the action bar where the action icon will be placed.', `fieldNotes` = 'The ID of the button on the action bar where the action icon will be placed.<br /><br />Special bars are used for stances, auras, pets, stealth, and other similar special modes.<br />¬subtable:13¬<br /><br />' where `fieldId`= '20' and `languageId`= 0;

        
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