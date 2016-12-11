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
    SET @cOldContent = '62';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '63';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'CMangos_updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'CMangos_updates';

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


/* Sources: 
	https://github.com/cmangos/classic-db/blob/master/Updates/1451_fire_effiy.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1452_rumsey_rum.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1453_katrina_shimmerstar.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1455_legionnaire_mangos_string.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1460_lolly_quests.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1462_defias_highwayman.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1470_z2687_01_mangos_spell_chain.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1471_tbc_objects.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1481_gameobject_respawntimer.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1486_skhowl.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1489_creature_template_armor.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1491_stones_of_binding.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1494_areatrigger_position.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1495_winterspring_frostsaber.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1496_greishan_ironstove.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1497_mechanical_bleed_immunity.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1498_xt9_movement.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1499_undermarket.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1500_parchment_text.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1501_boss_immunities.sql
	https://github.com/cmangos/classic-db/blob/master/Updates/1512_kirith.sql
*/

-- Missing spell bonus data (found in cmangos database)
DELETE FROM
	spell_bonus_data
WHERE
	entry IN (133, 879, 24275, 26573);
INSERT INTO
	spell_bonus_data(entry, direct_bonus, dot_bonus, ap_bonus, ap_dot_bonus, comments)
VALUES
	(133, 1, 0, 0, 0, 'Mage - Fire Ball'),
	(879, 0.15, 0, 0.15, 0, 'Paladin - Exorcism'),
	(24275, 0.15, 0, 0.15, 0, 'Paladin - Hammer of Wrath'),
	(26573, 0, 0.04, 0, 0.04, 'Paladin - Consecration');

-- https://github.com/cmangos/classic-db/blob/master/Updates/1451_fire_effiy.sql
-- Removed Fire Effigy (186720) from gameobject tables
-- This object was not used in Classic version of the Hallow's End event
DELETE FROM `gameobject` WHERE `id`= 186720;
DELETE FROM `game_event_gameobject` WHERE `guid` IN (43049, 43056, 43057, 43061, 43062, 43073, 43080, 43081);

-- https://github.com/cmangos/classic-db/blob/master/Updates/1452_rumsey_rum.sql
-- https://vanilla-twinhead.twinstar.cz/?issue=9487
DELETE FROM `npc_vendor` WHERE `entry`='2366' AND`item`='21151';

-- https://github.com/cmangos/classic-db/blob/master/Updates/1453_katrina_shimmerstar.sql
-- Hallow's End Vendor Corrections
-- As per Dagochen's report, Katrina Shimmerstar was not present in this event.  This NPC has been added and in addition the Pumpkin treat has been added to her vendor list. 
-- This item is only available when the Jesper(Alliance)/Spoops(Horde) quests have been completed at the respective vendors (source: wowwiki page for each npc).
-- Conditions for these casess have been added.  Thanks to @Dagochen for spotting.

/* Adding Katrina to the Hallow's End Event */
DELETE FROM `creature` WHERE `guid` = 86235;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(86235, 15353, 0, 0, 0, -4918.637, -983.1412, 501.5376, 2.43867, 120, 0, 0, 1605, 0, 0, 0);
DELETE FROM `game_event_creature` WHERE `guid` = 86235;
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(86235, 12);

SET @CONDITION := 1368;

/* Adding conditions for Hallow's End Vendors */
DELETE FROM `conditions` WHERE `condition_entry` IN (@CONDITION, @CONDITION + 1);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
(@CONDITION, 8, 8311, 0),
(@CONDITION + 1, 8, 8312, 0);

/* Adding Treat to Katrina vendor table and adding quest completion conditions for both vendors */
DELETE FROM `npc_vendor` WHERE `entry` = 15353 AND `item` = 20557;
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `condition_id`) VALUES
(15353, 20557, 0, 0, @CONDITION);
UPDATE `npc_vendor` SET `condition_id`= @CONDITION + 1 WHERE `entry`= 15354 AND `item`= 20557;

-- https://github.com/cmangos/classic-db/blob/master/Updates/1455_legionnaire_mangos_string.sql
-- Fixed string for horde honor rank
UPDATE mangos_string SET content_default = 'Legionnaire ' WHERE entry = 1421;

-- https://github.com/cmangos/classic-db/blob/master/Updates/1460_lolly_quests.sql
/* Fixed Lolly Quests
These quests involve Jesper and Spoops. They require the player to visit innkeepers in each capital, perform an emote and receive their lollies. Currently the initial quest from Jesper(8311) is unavailable as are the quests from the alliance capital innkeepers. The innkeepers also do not respond to the correct emote to complete the quest. All of these issues have been corrected.

Spoops has the quest(8312) available but is incorrectly designated an innkeeper with gossip. These have been corrected. Npcs involved in these quests have available their respective quests once quest 8312 is accepted but are unable to complete these quests upon receiving the correct emote. These issues have been corrected.
*/

-- Spoops and Quest 8312

-- Adding Spoops (guid 99966) to Hallow's End npcs
DELETE FROM `game_event_creature` WHERE guid = 99966;
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES (99966, 12);

-- Removing Gossip and Innkeeper functionality from Spoops (Should only be a questgiver)
UPDATE `creature_template` SET `NpcFlags`= 2 WHERE `Entry`= 15309;

-- Removing repeatability from Quest 8312
UPDATE `quest_template` SET `SpecialFlags`= 0 WHERE `entry`= 8312;

-- Horde
-- Quest 8359
-- Adding support for Alliance/Horde lolly collecting quests
UPDATE `quest_template` SET `QuestFlags`= 2, `SpecialFlags`= 2 WHERE `entry` IN (8353, 8354, 8355, 8356, 8357, 8358, 8359, 8360);

-- Removing casting creature requirement from quest 8359 and adding talk emote on quest details plus cheer emote on reaching reward page
UPDATE `quest_template` SET `ReqCreatureOrGOId1`= 0, `DetailsEmote1`= 1, `OfferRewardEmote1`= 4 WHERE `entry`= 8359;

-- Moving ObjectText1 to EndText due to SpecialFlags being changed to 2
UPDATE `quest_template` SET `ObjectiveText1`= '', `EndText`= 'Flex for Innkeeper Gryshka' WHERE `entry`= 8359;

-- Quest 8358
-- Removing casting creature requirement from quest 8358 and adding talk emote on quest details plus cheer emote on reaching reward page
UPDATE `quest_template` SET `ReqCreatureOrGOId1`= 0, `DetailsEmote1`= 1, `OfferRewardEmote1`= 4 WHERE `entry`= 8358;

-- Moving ObjectText1 to EndText due to SpecialFlags being changed to 2
UPDATE `quest_template` SET `ObjectiveText1`= '', `EndText`= 'Do the "train" for Kali Remik' WHERE `entry`= 8358;

-- Quest 8360
-- Removing casting creature requirement from quest 8360 and adding talk emote on quest details plus cheer emote on reaching reward page
UPDATE `quest_template` SET `ReqCreatureOrGOId1`= 0, `DetailsEmote1`= 1, `OfferRewardEmote1`= 4 WHERE `entry`= 8360;

-- Moving ObjectText1 to EndText due to SpecialFlags being changed to 2
UPDATE `quest_template` SET `ObjectiveText1`= '', `EndText`= 'Dance for Innkeeper Pala' WHERE `entry`= 8360;

-- Quest 8354
-- Removing casting creature requirement from quest 8360 and adding talk emote on quest details plus cheer emote on reaching reward page
UPDATE `quest_template` SET `ReqCreatureOrGOId1`= 0, `DetailsEmote1`= 1, `OfferRewardEmote1`= 4 WHERE `entry`= 8354;

-- Moving ObjectText1 to EndText due to SpecialFlags being changed to 2
UPDATE `quest_template` SET `ObjectiveText1`= '', `EndText`= 'Cluck like a chicken for Innkeeper Norman' WHERE `entry`= 8354;


-- Alliance
-- Quest 8356

-- Removing casting creature requirement from quest 8355 and adding talk emote on quest details plus cheer emote on reaching reward page
UPDATE `quest_template` SET `ReqCreatureOrGOId1`= 0, `DetailsEmote1`= 1, `OfferRewardEmote1`= 4 WHERE `entry`= 8356;

-- Moving ObjectText1 to EndText due to SpecialFlags being changed to 2
UPDATE `quest_template` SET `ObjectiveText1`= '', `EndText`= 'Flex for Innkeeper Allison' WHERE `entry`= 8356;

-- Quest 8355

-- Removing casting creature requirement from quest 8355 and adding talk emote on quest details plus cheer emote on reaching reward page
UPDATE `quest_template` SET `ReqCreatureOrGOId1`= 0, `DetailsEmote1`= 1, `OfferRewardEmote1`= 4 WHERE `entry`= 8355;

-- Moving ObjectText1 to EndText due to SpecialFlags being changed to 2
UPDATE `quest_template` SET `ObjectiveText1`= '', `EndText`= 'Do the "train" for Talvash' WHERE `entry`= 8355;

-- Quest 8353

-- Removing casting creature requirement from quest 8353 and adding talk emote on quest details plus cheer emote on reaching reward page
UPDATE `quest_template` SET `ReqCreatureOrGOId1`= 0, `DetailsEmote1`=1, `OfferRewardEmote1`= 4 WHERE `entry`= 8353;

-- Moving ObjectText1 to EndText due to SpecialFlags being changed to 2
UPDATE `quest_template` SET `ObjectiveText1`= '', `EndText`= 'Cluck like a chicken for Innkeeper Firebrew' WHERE `entry`= 8353;

-- Quest 8357

-- Removing casting creature requirement from quest 8357 and adding talk emote on quest details plus cheer emote on reaching reward page
UPDATE `quest_template` SET `ReqCreatureOrGOId1`= 0, `ReqCreatureOrGOCount1` = 0, `DetailsEmote1`= 1, `OfferRewardEmote1`= 4 WHERE `entry`= 8357;

-- Moving ObjectText1 to EndText due to SpecialFlags being changed to 2
UPDATE `quest_template` SET `ObjectiveText1`= '', `EndText`= 'Dance for Innkeeper Saelienne' WHERE `entry`= 8357;

-- https://github.com/cmangos/classic-db/blob/master/Updates/1462_defias_highwayman.sql
UPDATE `creature_template` SET `MinLevel`='17' WHERE `Entry`='122';

-- https://github.com/cmangos/classic-db/blob/master/Updates/1470_z2687_01_mangos_spell_chain.sql
-- Links Mage gem conjure spells together
DELETE FROM `spell_chain` WHERE `spell_id` IN (759,3552,10053,10054);
INSERT INTO `spell_chain` VALUES
(759,0,759,1,0),
(3552,759,759,2,0),
(10053,3552,759,3,0),
(10054,10053,759,4,0);

-- https://github.com/cmangos/classic-db/blob/master/Updates/1471_tbc_objects.sql
-- Removed a few gameobject spawns that were added in patch 2.0.1 or later
DELETE FROM gameobject WHERE id IN (182068, 182071, 182072, 181629);

-- https://github.com/cmangos/classic-db/blob/master/Updates/1481_gameobject_respawntimer.sql
-- Respawntimer fix for some Quest GO
-- Ammo Crate
UPDATE gameobject SET spawntimesecs = 10 WHERE guid = 10663;
-- The Holy Spring
UPDATE gameobject SET spawntimesecs = 10 WHERE guid = 10121;

-- https://github.com/cmangos/classic-db/blob/master/Updates/1486_skhowl.sql
-- Skhowl (Rare)

-- Corrected loot drop
DELETE FROM creature_loot_template WHERE entry = 2452;
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id) VALUES
(2452,1477,0.14,0,1,1,0),
(2452,1708,3,0,1,1,0),
(2452,1710,1.4,0,1,1,0),
(2452,1725,0.42,0,1,1,0),
(2452,1783,0.7,0,1,1,0),
(2452,1809,0.4,0,1,1,0),
(2452,1829,0.3,0,1,1,0),
(2452,1830,0.2,0,1,1,0),
(2452,2289,0.42,0,1,1,0),
(2452,2772,0.84,0,1,1,0),
(2452,2786,0.05,0,1,1,0),
(2452,2838,0.42,0,1,1,0),
(2452,3011,75,0,1,1,0),
(2452,3385,0.7937,0,1,1,0),
(2452,3720,-80,0,1,1,0),
(2452,3771,4,0,1,1,0),
(2452,4304,1.5873,0,1,1,0),
(2452,4636,1.28,0,1,1,0),
(2452,5637,3,0,1,1,0),
(2452,6331,25,0,1,1,0),
(2452,8146,3.1746,0,1,1,0),
(2452,24047,5,1,-24047,1,0),
(2452,24052,1,1,-24052,1,0),
(2452,24053,0.5,1,-24053,1,0),
(2452,24054,1,1,-24054,1,0),
(2452,24056,1,1,-24056,1,0),
(2452,24058,5,1,-24058,1,0);

-- https://github.com/cmangos/classic-db/blob/master/Updates/1489_creature_template_armor.sql
-- Fixed armor for many NPCs whose stats were previously fixed but were using wrong armor values
-- due to the base stats table being wrong itself
-- Fixed armor for many NPCs stats are still pending to be fixed
-- Used base armor for NPCs having no armor set and for remaining unfixed NPCs

-- Miscelleanous and specific fixes
UPDATE creature_template SET ArmorMultiplier=1 WHERE Entry=5237; -- Gordunni Ogre Mage
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=92; -- Rock Elemental
UPDATE creature_template SET ArmorMultiplier=1.3 WHERE Entry=121; -- Defias Pathstalker
UPDATE creature_template SET ArmorMultiplier=0.37 WHERE Entry=124; -- Riverpaw Brute
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=334; -- Gath'Ilzogg
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=474; -- Defias Rogue Wizard
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=476; -- Kobold Geomancer
UPDATE creature_template SET ArmorMultiplier=0.37 WHERE Entry=502; -- Benny Blaanco
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=507; -- Fenros
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=589; -- Defias Pillager
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=688; -- Stone Maw Basilisk
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=689; -- Crystal Spine Basilisk
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=690; -- Cold Eye Basilisk
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=744; -- Green Scalebane
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=745; -- Scalebane Captain
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=746; -- Elder Dragonkin
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=783; -- Skullsplitter Berserker
UPDATE creature_template SET ArmorMultiplier=0.38 WHERE Entry=822; -- Young Forest Bear
UPDATE creature_template SET ArmorMultiplier=1.3 WHERE Entry=830; -- Sand Crawler
UPDATE creature_template SET ArmorMultiplier=1.3 WHERE Entry=831; -- Sea Crawler
UPDATE creature_template SET ArmorMultiplier=1.3 WHERE Entry=875; -- Saltscale Tide Lord
UPDATE creature_template SET ArmorMultiplier=1.54 WHERE Entry=910; -- Defias Enchanter
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=922; -- Silt Crawler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1009; -- Mosshide Mistweaver
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1030; -- Black Slime
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1031; -- Crimson Ooze
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1032; -- Black Ooze
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1033; -- Monstrous Ooze
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1047; -- Red Scalebane
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1049; -- Scalebane Royal Guard
UPDATE creature_template SET ArmorMultiplier=0.22 WHERE Entry=1114; -- Jungle Thunderer
UPDATE creature_template SET ArmorMultiplier=0.24 WHERE Entry=1128; -- Young Black Bear
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1140; -- Razormaw Matriarch
UPDATE creature_template SET ArmorMultiplier=1.3 WHERE Entry=1216; -- Shore Crawler
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=1502; -- Wretched Zombie
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=1504; -- Young Night Web Spider
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=1505; -- Night Web Spider
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=1507; -- Scarlet Initiate
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=1509; -- Ragged Scavenger
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1552; -- Scale Belly
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=1718; -- Rockjaw Raider
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1729; -- Defias Evoker
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1732; -- Defias Squallshaper
UPDATE creature_template SET ArmorMultiplier=1.3 WHERE Entry=1769; -- Moonrage Whitescalp
UPDATE creature_template SET ArmorMultiplier=0.52 WHERE Entry=1797; -- Giant Grizzled Bear
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=1815; -- Diseased Black Bear
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=1816; -- Diseased Grizzly
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1885; -- Scarlet Smith
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=1890; -- Rattlecage Skeleton
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=1916; -- Stephen Bhartec
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=1947; -- Thule Ravenclaw
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2010; -- Gnarlpine Defender
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2018; -- Bloodfeather Sorceress
UPDATE creature_template SET ArmorMultiplier=0.42 WHERE Entry=2163; -- Thistle Bear
UPDATE creature_template SET ArmorMultiplier=0.42 WHERE Entry=2164; -- Rabid Thistle Bear
UPDATE creature_template SET ArmorMultiplier=0.47 WHERE Entry=2165; -- Grizzled Thistle Bear
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2231; -- Pygmy Tide Crawler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2233; -- Encrusted Tide Crawler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2234; -- Young Reef Crawler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2235; -- Reef Crawler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2236; -- Raging Reef Crawler
UPDATE creature_template SET ArmorMultiplier=0.6 WHERE Entry=2253; -- Crushridge Brute
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2258; -- Stone Fury
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2359; -- Syndicate Wizard
UPDATE creature_template SET ArmorMultiplier=0.37 WHERE Entry=2351; -- Gray Bear
UPDATE creature_template SET ArmorMultiplier=0.37 WHERE Entry=2354; -- Vicious Gray Bear
UPDATE creature_template SET ArmorMultiplier=0.37 WHERE Entry=2356; -- Elder Gray Bear
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2387; -- Hillsbrad Councilman
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2408; -- Snapjaw
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2505; -- Saltwater Snapjaw
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2544; -- Southern Sand Crawler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2592; -- Rumbling Exile
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=2611; -- Fozruk
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=2592; -- Green Sludge
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2723; -- Stone Golem
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=2735; -- Lesser Rock Elemental
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=2736; -- Greater Rock Elemental
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2744; -- Shadowforge Commander
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2751; -- War Golem
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2752; -- Rumbler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2763; -- Thenan
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=2791; -- Enraged Rock Elemental
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=2967; -- Galak Centaur
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3103; -- Makrura Clacker
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3104; -- Makrura Shellhide
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3126; -- Armored Scorpid
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3251; -- Silithid Grub
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3528; -- Pyrewood Armorer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3529; -- Moonrage Armorer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3532; -- Pyrewood Leatherworker
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3533; -- Moonrage Leatherworker
UPDATE creature_template SET ArmorMultiplier=5.0 WHERE Entry=3653; -- Kresh
UPDATE creature_template SET ArmorMultiplier=0.47 WHERE Entry=3809; -- Ashenvale Bear
UPDATE creature_template SET ArmorMultiplier=0.47 WHERE Entry=3810; -- Elder Ashenvale Bear
UPDATE creature_template SET ArmorMultiplier=0.47 WHERE Entry=3811; -- Giant Ashenvale Bear
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3812; -- Clattering Crawler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3814; -- Spined Crawler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=3850; -- Sorcerer Ashcrombe
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=4035; -- Furious Stone Spirit
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=4139; -- Scorpid Terror
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=4110; -- Scorpid Reaver
UPDATE creature_template SET ArmorMultiplier=2.5 WHERE Entry=4143; -- Sparkleshell Snapper
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=4286; -- Scarlet Soldier
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=4292; -- Scarlet Protector
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=4298; -- Scarlet Defender
UPDATE creature_template SET ArmorMultiplier=0.3 WHERE Entry=4306; -- Scarlet Torturer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=4392; -- Corrosive Swamp Ooze
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=4393; -- Acidic Swamp Ooze
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=4396; -- Mudrock Tortoise
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=4398; -- Mudrock Burrower
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=4399; -- Mudrock Borer
UPDATE creature_template SET ArmorMultiplier=1.2 WHERE Entry=4402; -- Muckshell Snapclaw
UPDATE creature_template SET ArmorMultiplier=1.2 WHERE Entry=4405; -- Muckshell Razorclaw
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=4468; -- Jade Sludge
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=4528; -- Stone Rumbler
UPDATE creature_template SET ArmorMultiplier=0.25 WHERE Entry=4540; -- Scarlet Monk
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=4661; -- Gelkis Rumbler
UPDATE creature_template SET ArmorMultiplier=0.5 WHERE Entry=4666; -- Burning Blade Felsworn
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5185; -- Hammerhead Shark
UPDATE creature_template SET ArmorMultiplier=0.7 WHERE Entry=5253; -- Woodpaw Brute
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5268; -- Ironfur Bear
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5272; -- Grizzled Ironfur Bear
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5274; -- Ironfur Patriarch
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5277; -- Nightmare Scalebane
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5327; -- Coast Crawl Snapclaw
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5328; -- Coast Crawl Deepseer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5331; -- Hatecrest Warrior
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5400; -- Zekkis
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5431; -- Surf Glider
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5432; -- Giant Surf Glider
UPDATE creature_template SET ArmorMultiplier=1.75 WHERE Entry=5465; -- Land Rager
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5490; -- Gnarled Thistleshrub
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=5823; -- Death Flayer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=5854; -- Heavy War Golem
UPDATE creature_template SET ArmorMultiplier=1.2 WHERE Entry=5855; -- Magma Elemental
UPDATE creature_template SET ArmorMultiplier=2.5 WHERE Entry=5935; -- Ironeye the Invincible
UPDATE creature_template SET ArmorMultiplier=0.8 WHERE Entry=5976; -- Dreadmaul Brute
UPDATE creature_template SET ArmorMultiplier=0.8 WHERE Entry=6011; -- Felguard Sentry
UPDATE creature_template SET ArmorMultiplier=1.7 WHERE Entry=6130; -- Blue Scalebane
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=6135; -- Arkkoran Clacker
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=6137; -- Arkkoran Pincer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=6146; -- Cliff Breaker
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=6147; -- Cliff Thunderer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=6148; -- Cliff Walker
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=6194; -- Spitelash Serpent Guard
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=6350; -- Makrinni Razorclaw
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=6370; -- Makrinni Scrabbler
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=6499; -- Ironhide Devilsaur
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=6502; -- Plated Stegodon
UPDATE creature_template SET ArmorMultiplier=0.5 WHERE Entry=6788; -- Den Mother
UPDATE creature_template SET ArmorMultiplier=1.3 WHERE Entry=6906; -- Baelog
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=7027; -- Blackrock Slayer
UPDATE creature_template SET ArmorMultiplier=0.5 WHERE Entry=7029; -- Blackrock Battlemaster
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=7031; -- Obsidian Elemental
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=7033; -- Firegut Ogre
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=7034; -- Firegut Ogre Mage
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=7035; -- Firegut Brute
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=7039; -- War Reaver
UPDATE creature_template SET ArmorMultiplier=1.3 WHERE Entry=7076; -- Earthen Guardian
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=7138; -- Irontree Wanderer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=7139; -- Irontree Stomper
UPDATE creature_template SET ArmorMultiplier=0.7 WHERE Entry=7149; -- Withered Protector
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=7206; -- Ancient Stone Keeper
UPDATE creature_template SET ArmorMultiplier=0.3 WHERE Entry=7320; -- Stonevault Mauler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=7344; -- Splinterbone Warrior
UPDATE creature_template SET ArmorMultiplier=0.5 WHERE Entry=7371; -- Deadwind Mauler
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=7446; -- Rabid Shardtooth
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=7687; -- Spotted Frostsaber
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=7690; -- Striped Nightsaber
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=7707; -- Turquoise Raptor
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=7708; -- Violet Raptor
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=7739; -- Red Mechanostrider
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=7749; -- Blue Mechanostrider
UPDATE creature_template SET ArmorMultiplier=1.35 WHERE Entry=7789; -- Sandfury Cretin
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=7800; -- Mekgineer Thermaplugg
UPDATE creature_template SET ArmorMultiplier=0.8 WHERE Entry=7846; -- Teremus the Devourer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=7873; -- Razorfen Battleguard
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=7915; -- Walking Bomb
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=8149; -- Sul'lithuz Warder
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=8376; -- Mechanical Chicken
UPDATE creature_template SET ArmorMultiplier=0.8 WHERE Entry=8504; -- Dark Iron Sentry
UPDATE creature_template SET ArmorMultiplier=0.7 WHERE Entry=8585; -- Frost Spectre
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=8611; -- Idol Room Spawner
UPDATE creature_template SET ArmorMultiplier=1.39 WHERE Entry=8656; -- Hukku's Voidwalker
UPDATE creature_template SET ArmorMultiplier=0.66 WHERE Entry=8657; -- Hukku's Succubus
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=8776; -- Emerald Dragon Whelp
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=8836; -- Battle Chicken
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=8926; -- Deep Stinger
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=8937; -- Pet Bomb
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=8982; -- Ironhand Guardian
UPDATE creature_template SET ArmorMultiplier=0.8 WHERE Entry=9028; -- Grizzle
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=9038; -- Seeth'rel
UPDATE creature_template SET ArmorMultiplier=1.20 WHERE Entry=9039; -- Doom'rel
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=9043; -- Scarshield Grunt
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=9158; -- Warhorse
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=9256; -- Farm Chicken
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=9260; -- Firebrand Legionnaire
UPDATE creature_template SET ArmorMultiplier=1.85 WHERE Entry=9396; -- Ground Pounder
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=9601; -- Treant Spirit
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=9707; -- Scarshield Portal
UPDATE creature_template SET ArmorMultiplier=0.6 WHERE Entry=10043; -- Ribbly's Crony
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=10180; -- Unpainted Mechanostrider
UPDATE creature_template SET ArmorMultiplier=1.4 WHERE Entry=10393; -- Skul
UPDATE creature_template SET ArmorMultiplier=1.4 WHERE Entry=10422; -- Crimson Sorcerer
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=10487; -- Risen Protector
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=10489; -- Risen Guard
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=10577; -- Crypt Scarab
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=10598; -- Smolderweb Hatchling
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=10603; -- Hallucination
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=10656; -- Guardian Felhunter
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=10657; -- Corrupted Cat
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=10716; -- Belfry Bat
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=10980; -- Umi's Mechanical Yeti
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11021; -- Winterspring Frostsaber
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11122; -- Restless Soul
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11136; -- Freed Soul
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11147; -- Green Mechanostrider
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11153; -- Red Skeletal Horse
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11154; -- Blue Skeletal Horse
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11155; -- Brown Skeletal Horse
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11236; -- Blood Parrot
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11282; -- Melia
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11283; -- Sammy
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=11321; -- Molten Elemental
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11325; -- Panda Cub
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11326; -- Mini Diablo
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11327; -- Zergling
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=11562; -- Drysnap Crawler
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=11563; -- Drysnap Pincer
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11689; -- Brown Kodo
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=11722; -- Hive'Ashi Defender
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=11723; -- Hive'Ashi Sandstalker
UPDATE creature_template SET ArmorMultiplier=0.75 WHERE Entry=11730; -- Hive'Regal Ambusher
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=11746; -- Desert Rumbler
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=11747; -- Desert Rager
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=11777; -- Shadowshard Rumbler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=11778; -- Shadowshard Smasher
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=11781; -- Ambershard Crusher
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=11782; -- Ambershard Destroyer
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=11884; -- Obi
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=11920; -- Goggeroc
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12120; -- Plagueland Termite
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=12123; -- Reef Shark
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12149; -- Gray Kodo
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12152; -- Voice of Elune
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=12204; -- Spitelash Raider
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12297; -- Cured Gazelle
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12299; -- Cured Deer
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12344; -- Swift Green Skeletal Horse
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12345; -- Mottled Crimson Raptor
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=12347; -- Enraged Reef Crawler
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12348; -- Ivory Raptor
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12361; -- Riding Nightsaber
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12362; -- Riding Frostsaber
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12368; -- White Mechanostrider Mod A
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12370; -- Black Ram
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12371; -- Frost Ram
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=12377; -- Wailing Spectre
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12419; -- Lifelike Toad
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=12426; -- Masterwork Target Dummy
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=12581; -- Mercutio
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=13338; -- Core Rat
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=13599; -- Stolid Snapjaw
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=13756; -- PvP Graveyard Credit Marker
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=13778; -- PvP Tower Credit Marker
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=13796; -- PvP Mine Credit Marker
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=13876; -- Mekgineer Trigger
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=13976; -- Tortured Drake
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14021; -- Winterax Sentry
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=14123; -- Steeljaw Snapper
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=14235; -- The Rot
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=14236; -- Lord Angler
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=14237; -- Oozeworm
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=14266; -- Shanda the Spinner
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14329; -- Black War Wolf
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14330; -- Black War Raptor
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14331; -- Red Skeletal Warhorse
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14332; -- Black War Steed
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14333; -- Black War Kodo
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14334; -- Black Battlestrider
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14335; -- Black War Ram
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14336; -- Black War Tiger
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14361; -- Shen'dralar Wisp
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14366; -- Warpwood Spores
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14449; -- Blackwing Orb Trigger
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14453; -- Orb of Domination
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14459; -- Nefarian's Troops
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14465; -- Alliance Battle Standard
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14466; -- Horde Battle Standard
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14495; -- Invisible Trigger One
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE Entry=14505; -- Dreadsteed
UPDATE creature_template SET ArmorMultiplier=2.0 WHERE Entry=14530; -- Solenor the Slayer
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=14690; -- Revanchion
UPDATE creature_template SET ArmorMultiplier=1.02 WHERE Entry=14862; -- Emissary Roman'khan
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=15205; -- Baron Kazum
UPDATE creature_template SET ArmorMultiplier=1.25 WHERE Entry=15208; -- The Duke of Shards
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=16102; -- Sothos
UPDATE creature_template SET ArmorMultiplier=1.5 WHERE Entry=16104; -- Spirit of Sothos
UPDATE creature_template SET ArmorMultiplier=1.0 WHERE Entry=16438; -- Skeletal Trooper
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE CreatureType=8; -- All critters
UPDATE creature_template SET ArmorMultiplier=1.33 WHERE NAME LIKE "Riding%)"; -- Faction mounts models

-- Global fixes
-- Fix armor of NPCs whose stats were previously fixed but were using wrong armor values
UPDATE creature_template,creature_template_classlevelstats SET Armor=BaseArmor*ArmorMultiplier WHERE ArmorMultiplier>0 AND UnitClass=Class AND MaxLevel=LEVEL;
-- Pre-fix armor for NPCs not already fixed but armor set to 0 (usually, multiplier is 1, so reduces amount of manual work)
UPDATE creature_template,creature_template_classlevelstats SET Armor=BaseArmor WHERE Armor=0 AND ArmorMultiplier=-1 AND UnitClass=Class AND MaxLevel=LEVEL;

-- https://github.com/cmangos/classic-db/blob/master/Updates/1491_stones_of_binding.sql
-- Stones of Binding: aligned spawntime with Servants and set default flags to 4 to make it usable by players
UPDATE gameobject SET spawntimesecs = 450 WHERE id IN (141812,141857,141858,141859);
UPDATE gameobject_template SET flags = 4 WHERE entry IN (141812,141857,141858,141859);

-- https://github.com/cmangos/classic-db/blob/master/Updates/1494_areatrigger_position.sql
-- AREATRIGGER

-- Ragefire Chasm
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Ragefire Chasm - Entering', `target_position_x`=0.797643, `target_position_y`=-8.23429, `target_position_z`=-15.5288, `target_orientation`=4.71239 WHERE `id`=2230;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Ragefire Chasm - Exiting', `target_position_x`=1814.99, `target_position_y`=-4419.23, `target_position_z`=-18.8151, `target_orientation`=1.91986 WHERE `id`=2226;

-- Deadmines
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Deadmines - Entering', `target_position_x`=-14.5732, `target_position_y`=-385.475, `target_position_z`=62.4561, `target_orientation`=1.5708 WHERE `id`=78;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Deadmines - Exiting', `target_position_x`=-11208.7, `target_position_y`=1675.9, `target_position_z`=24.5733, `target_orientation`=4.71239 WHERE `id`=119;
-- Exiting after ship
UPDATE `areatrigger_teleport` SET `name`='Deadmines - Exiting after ship', `target_position_x`=-11339.9, `target_position_y`=1572.45, `target_position_z`=94.3916, `target_orientation`=1.5708 WHERE `id`=121;

-- Shadowfang Keep
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Shadowfang Keep - Entering', `target_position_x`=-228.191, `target_position_y`=2111.41, `target_position_z`=76.8904, `target_orientation`=1.22173 WHERE `id`=145;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Shadowfang Keep - Exiting', `target_position_x`=-233.011, `target_position_y`=1567.5, `target_position_z`=76.8921, `target_orientation`=4.27606 WHERE `id`=194;

-- BlackFATHOM Deeps (wrongfully named Blackphantom in our table names)
-- Entering 	
UPDATE `areatrigger_teleport` SET `name`='Blackfathom Deeps - Entering', `target_position_x`=-150.234, `target_position_y`=106.594, `target_position_z`=-39.779, `target_orientation`=4.45059 WHERE `id`=257;

-- Stormwind Stockades
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Stormwind Stockades - Entering', `target_position_x`=48.9849, `target_position_y`=0.483882, `target_position_z`=-16.3942, `target_orientation`=0 WHERE `id`=101;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Stormwind stockades - Exiting', `target_position_x`=-8766.11, `target_position_y`=845.499, `target_position_z`=87.9952, `target_orientation`=3.83972 WHERE `id`=503;

-- Gnomeregan
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Gnomeregan - Entering', `target_position_x`=-329.098, `target_position_y`=-3.20722, `target_position_z`=-152.851, `target_orientation`=2.96706 WHERE `id`=324;

-- Razorfen Kraul
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Razorfen Kraul - Entering', `target_position_x`=1942.27, `target_position_y`=1544.23, `target_position_z`=81.805061, `target_orientation`=1.309 WHERE `id`=244;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Razorfen Kraul - Exiting', `target_position_x`=-4463.32, `target_position_y`=-1664.29, `target_position_z`=82.243629, `target_orientation`=3.92699 WHERE `id`=242;

-- Scarlet Monestary - Graveyard
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Scarlet Monestary Graveyard - Entering', `target_position_x`=1687.27, `target_position_y`=1050.09, `target_position_z`=18.6773, `target_orientation`=1.5708 WHERE `id`=45;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Scarlet Monestary Graveyard - Exiting', `target_position_x`=2915.34, `target_position_y`=-801.58, `target_position_z`=160.333, `target_orientation`=3.49066 WHERE `id`=602;

-- Scarlet Monestary - Library
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Scarlet Monestary Library - Entering', `target_position_x`=253.672, `target_position_y`=-206.624, `target_position_z`=18.6773, `target_orientation`=4.71239 WHERE `id`=614;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Scarlet Monestary Library - Exiting', `target_position_x`=2869.32, `target_position_y`=-820.818, `target_position_z`=160.333, `target_orientation`=0.349066 WHERE `id`=608;

-- Scarlet Monestary - Armory
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Scarlet Monestary Armory - Entering', `target_position_x`=1608.1, `target_position_y`=-318.919, `target_position_z`=18.6714, `target_orientation`=4.71239 WHERE `id`=612;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Scarlet Monestary Armory - Exiting', `target_position_x`=2885.96, `target_position_y`=-835.802, `target_position_z`=160.327, `target_orientation`=0.349066 WHERE `id`=606;

-- Scarlet Monestary - Cathedral
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Scarlet Monestary Cathedral - Entering', `target_position_x`=853.179, `target_position_y`=1319.18, `target_position_z`=18.6714, `target_orientation`=1.5708 WHERE `id`=610;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Scarlet Monestary Cathedral - Exiting', `target_position_x`=2915.13, `target_position_y`=-823.637, `target_position_z`=160.327, `target_orientation`=3.49066 WHERE `id`=604;

-- Uldaman
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Uldaman - Entering', `target_position_x`=-228.859, `target_position_y`=46.1018, `target_position_z`=-46.0186, `target_orientation`=1.5708 WHERE `id`=286;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Uldaman - Exiting', `target_position_x`=-6066.25, `target_position_y`=-2954.56, `target_position_z`=209.772, `target_orientation`=3.14159 WHERE `id`=288;

-- Zul'Farrak
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Zul\'Farrak - Entering', `target_position_x`=1212.67, `target_position_y`=842.04, `target_position_z`=8.93346, `target_orientation`=0 WHERE `id`=924;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Zul\'Farrak - Exiting', `target_position_x`=-6795.56, `target_position_y`=-2890.72, `target_position_z`=8.88742, `target_orientation`=3.14159 WHERE `id`=922;

-- Maraudon - Orange
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Maraudon Orange - Entering', `target_position_x`=1016.83, `target_position_y`=-458.52, `target_position_z`=-43.4737, `target_orientation`=0 WHERE `id`=3133;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Maraudon Orange - Exiting', `target_position_x`=-1468.2, `target_position_y`=2614.21, `target_position_z`=76.3804, `target_orientation`=0 WHERE `id`=3131;

-- Maraudon - Purple
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Maraudon Purple - Entering', `target_position_x`=755.078, `target_position_y`=-617.696, `target_position_z`=-32.9222, `target_orientation`=1.5708 WHERE `id`=3134;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Maraudon Purple - Exiting', `target_position_x`=-1182.8, `target_position_y`=2877.43, `target_position_z`=85.908, `target_orientation`=1.65806 WHERE `id`=3126;

-- Sunken Temple
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Altar of Atal\'Hakkar (Sunken Temple) - Entering', `target_position_x`=-315.903, `target_position_y`=100.197, `target_position_z`=-131.849, `target_orientation`=3.14159 WHERE `id`=446;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Altar of Atal\'Hakkar (Sunken Temple) - Exiting', `target_position_x`=-10176.6, `target_position_y`=-3995.35, `target_position_z`=-112.185, `target_orientation`=3.00197 WHERE `id`=448;

-- Blackrock Depths
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Blackrock Depths - Entering', `target_position_x`=456.929, `target_position_y`=34.0923, `target_position_z`=-69.561729, `target_orientation`=4.71239 WHERE `id`=1466;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Blackrock Depths - Exiting', `target_position_x`=-7178.41, `target_position_y`=-922.152, `target_position_z`=166.092, `target_orientation`=2.00713 WHERE `id`=1472;

-- Blackrock Spire
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Blackrock Spire - Entering', `target_position_x`=78.3534, `target_position_y`=-226.841, `target_position_z`=49.7662, `target_orientation`=4.71239 WHERE `id`=1468;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Blackrock Spire - Exiting', `target_position_x`=-7524.7, `target_position_y`=-1228.41, `target_position_z`=285.733185, `target_orientation`=1.74533 WHERE `id`=1470;

-- Dire Maul - East
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Dire Maul East - Entering', `target_position_x`=47.4501, `target_position_y`=-153.665, `target_position_z`=-2.71439, `target_orientation`=5.49779 WHERE `id`=3183;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Dire Maul East - Exiting', `target_position_x`=-3738.62, `target_position_y`=934.522, `target_position_z`=160.975, `target_orientation`=3.14159 WHERE `id`=3194;
-- Exiting after Alzzin
UPDATE `areatrigger_teleport` SET `name`='Dire Maul East - Exiting after Alzzin', `target_position_x`=-3585.84, `target_position_y`=847.367, `target_position_z`=138.641, `target_orientation`=2.35619 WHERE `id`=3197;

-- Dire Maul - East (Back Door)
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Dire Maul East - Entering Back Door', `target_position_x`=10.5786, `target_position_y`=-836.991, `target_position_z`=-32.3988, `target_orientation`=0 WHERE `id`=3185;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Dire Maul East - Exiting Back Door', `target_position_x`=-4031.25, `target_position_y`=129.345, `target_position_z`=26.4744, `target_orientation`=1.570797 WHERE `id`=3196;

-- Dire Maul - West
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Dire Maul West - Entering', `target_position_x`=-65.6559, `target_position_y`=159.561, `target_position_z`=-3.4647, `target_orientation`=2.35619 WHERE `id`=3186;

-- Dire Maul - West (Side Door)
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Dire Maul West - Entering Side Door', `target_position_x`=33.1083, `target_position_y`=158.977, `target_position_z`=-3.47126, `target_orientation`=0.785398 WHERE `id`=3187;

-- Dire Maul - North
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Dire Maul North - Entering', `target_position_x`=254.92, `target_position_y`=-19.463, `target_position_z`=-2.5596, `target_orientation`=5.49779 WHERE `id`=3189;

-- Stratholme - Front
-- Entering (Left)
UPDATE `areatrigger_teleport` SET `name`='Stratholme - Entering Left Front', `target_position_x`=3392.92, `target_position_y`=-3395.03, `target_position_z`=143.135, `target_orientation`=1.5708 WHERE `id`=2216;
-- Entering (Right)
UPDATE `areatrigger_teleport` SET `name`='Stratholme - Entering Right Front', `target_position_x`=3392.84, `target_position_y`=-3364.44, `target_position_z`=142.965, `target_orientation`=4.71239 WHERE `id`=2217;

-- Stratholme - UD
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Stratholme - Entering Back Door', `target_position_x`=3590.87, `target_position_y`=-3643.22, `target_position_z`=138.491, `target_orientation`=5.49779 WHERE `id`=2214;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Stratholme - Exiting Back Door', `target_position_x`=3233.06, `target_position_y`=-4048.3, `target_position_z`=108.442, `target_orientation`=2.00713 WHERE `id`=2221;

-- Scholomance
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Scholomance - Entering', `target_position_x`=190.819, `target_position_y`=126.329, `target_position_z`=137.227, `target_orientation`=0 WHERE `id`=2567;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Scholomance - Exiting', `target_position_x`=1273.91, `target_position_y`=-2553.09, `target_position_z`=90.632217, `target_orientation`=3.57793 WHERE `id`=2568;

-- Onyxia's Lair
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Onyxia\'s Lair - Entering', `target_position_x`=30.8916, `target_position_y`=-54.079, `target_position_z`=-5.02784, `target_orientation`=4.71239 WHERE `id`=2848;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Onyxia\'s Lair - Exiting', `target_position_x`=-4750.38, `target_position_y`=-3754.44, `target_position_z`=49.0485, `target_orientation`=0.785398 WHERE `id`=1064;

-- Zul'Gurub
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Zul\'Gurub - Entering', `target_position_x`=-11916.6, `target_position_y`=-1243.52, `target_position_z`=92.5338, `target_orientation`=4.71239 WHERE `id`=3928;

-- Blackwing Lair
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Blackwing Lair - Entering', `target_position_x`=-7672.32, `target_position_y`=-1107.05, `target_position_z`=396.651, `target_orientation`=0.785398 WHERE `id`=3726;

-- Ruins of Ahn'Qiraj
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Ruins of Ahn\'Qiraj - Entering', `target_position_x`=-8436.53, `target_position_y`=1519.17, `target_position_z`=31.907, `target_orientation`=2.61799 WHERE `id`=4008;

-- Ahn'Qiraj Temple
-- Entering
UPDATE `areatrigger_teleport` SET `name`='Ahn\'Qiraj Temple - Entering', `target_position_x`=-8221.35, `target_position_y`=2014.34, `target_position_z`=129.071, `target_orientation`=0.872665 WHERE `id`=4010;
-- Exiting
UPDATE `areatrigger_teleport` SET `name`='Ahn\'Qiraj Temple - Exiting', `target_position_x`=-8239.01, `target_position_y`=1993.25, `target_position_z`=129.071, `target_orientation`=4.01426 WHERE `id`=4012;


-- TARGET POSITION

-- Blackfathom Deeps
-- Exiting using Darnassus Portal
UPDATE `spell_target_position` SET `target_position_x`=9664.14, `target_position_y`=2526.36, `target_position_z`=1334.27, `target_orientation`=1.84454 WHERE `id`=3565;

-- Maraudon
-- Portal to Earth Song Falls (Princess run)
UPDATE `spell_target_position` SET `target_position_x`=386.27, `target_position_y`=33.4144, `target_position_z`=-130.934, `target_orientation`=0 WHERE `id`=21128;

-- Molten Core
-- Entering using High Elf (Attunement)
UPDATE `spell_target_position` SET `target_position_x`=1080, `target_position_y`=-483, `target_position_z`=-108, `target_orientation`=1 WHERE `id`=20534;
UPDATE `spell_target_position` SET `target_position_x`=1080, `target_position_y`=-483, `target_position_z`=-108, `target_orientation`=1 WHERE `id`=20618;

-- https://github.com/cmangos/classic-db/blob/master/Updates/1495_winterspring_frostsaber.sql
UPDATE item_template SET RequiredSkillRank = 75 WHERE entry = 13086;

-- https://github.com/cmangos/classic-db/blob/master/Updates/1496_greishan_ironstove.sql
-- ===========================================================
-- Greishan Ironstove <Traveling Merchant> - Waypoint Movement
-- ===========================================================
UPDATE creature SET position_x = '-4705.119141', position_y = '-2698.643555', position_z = '318.819061', orientation = '6.277992', SpawnDist='0', MovementType=2 WHERE guid = '8837';

DELETE FROM creature_movement_template WHERE entry=3291;
INSERT INTO creature_movement_template (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('3291','1','-4680.42','-2698.77','319.517','0','0','0','0','0','0','0','0','0','6.27799','0','0'),
('3291','2','-4721.25','-2699.82','321.085','0','0','0','0','0','0','0','0','0','3.23615','0','0'),
('3291','3','-4740.11','-2702.29','323.793','0','0','0','0','0','0','0','0','0','3.42307','0','0'),
('3291','4','-4758.03','-2707.47','325.954','0','0','0','0','0','0','0','0','0','3.42307','0','0'),
('3291','5','-4769.43','-2708.21','326.446','0','0','0','0','0','0','0','0','0','3.2063','0','0'),
('3291','6','-4782.5','-2710.1','326.239','0','0','0','0','0','0','0','0','0','3.28484','0','0'),
('3291','7','-4831.48','-2710.55','329.007','0','0','0','0','0','0','0','0','0','3.26206','0','0'),
('3291','8','-4865.17','-2714.63','329.387','0','0','0','0','0','0','0','0','0','3.26206','0','0'),
('3291','9','-4909.79','-2729.57','328.91','0','0','0','0','0','0','0','0','0','3.59664','0','0'),
('3291','10','-4923.08','-2737.38','328.223','0','0','0','0','0','0','0','0','0','3.93437','0','0'),
('3291','11','-4959.79','-2767.4','325.68','0','0','0','0','0','0','0','0','0','3.79849','0','0'),
('3291','12','-4987.17','-2778.25','325.62','0','0','0','0','0','0','0','0','0','3.51889','0','0'),
('3291','13','-5018.18','-2792.34','326.408','0','0','0','0','0','0','0','0','0','3.8519','0','0'),
('3291','14','-5048','-2811.41','327.366','0','0','0','0','0','0','0','0','0','3.71053','0','0'),
('3291','15','-5089.59','-2827.29','327.24','0','0','0','0','0','0','0','0','0','3.50632','0','0'),
('3291','16','-5110.5','-2832.04','328.256','0','0','0','0','0','0','0','0','0','3.36495','0','0'),
('3291','17','-5124.4','-2833.18','329.882','0','0','0','0','0','0','0','0','0','3.22358','0','0'),
('3291','18','-5171.46','-2844.02','334.823','0','0','0','0','0','0','0','0','0','3.36809','0','0'),
('3291','19','-5200.48','-2850.71','336.135','0','0','0','0','0','0','0','0','0','3.36809','0','0'),
('3291','20','-5210.11','-2855.97','336.675','0','0','0','0','0','0','0','0','0','3.64141','0','0'),
('3291','21','-5229.24','-2872.21','338.195','0','0','0','0','0','0','0','0','0','3.84562','0','0'),
('3291','22','-5242.24','-2880.93','338.925','0','0','0','0','0','0','0','0','0','3.69246','0','0'),
('3291','23','-5248.25','-2882.28','339.107','0','0','0','0','0','0','0','0','0','3.3626','0','0'),
('3291','24','-5271.35','-2881.15','338.801','0','0','0','0','0','0','0','0','0','3.09242','0','0'),
('3291','25','-5284.27','-2876.7','338.717','0','0','0','0','0','0','0','0','0','2.80967','0','0'),
('3291','26','-5297.93','-2867.31','339.035','0','0','0','0','0','0','0','0','0','2.80653','0','0'),
('3291','27','-5320.77','-2859.35','339.353','0','0','0','0','0','0','0','0','0','2.80653','0','0'),
('3291','28','-5347.96','-2856.93','340.131','0','0','0','0','0','0','0','0','0','3.28091','0','0'),
('3291','29','-5366.32','-2859.51','340.621','0','0','0','0','0','0','0','0','0','3.28091','0','0'),
('3291','30','-5376.33','-2866.84','340.616','0','0','0','0','0','0','0','0','0','3.81813','0','0'),
('3291','31','-5388.38','-2876.52','341.284','0','0','0','0','0','0','0','0','0','3.81813','0','0'),
('3291','32','-5401.77','-2881.79','342.363','0','0','0','0','0','0','0','0','0','3.51653','0','0'),
('3291','33','-5404.59','-2886.82','342.694','0','0','0','0','0','0','0','0','0','4.2014','0','0'),
('3291','34','-5403.44','-2893.16','341.937','0','0','0','0','0','0','0','0','0','4.89255','0','0'),
('3291','35','-5394.98','-2907.22','338.543','0','0','0','0','0','0','0','0','0','5.25384','0','0'),
('3291','36','-5372.85','-2930.37','330.083','0','0','0','0','0','0','0','0','0','5.34494','0','0'),
('3291','37','-5353.62','-2954.16','323.949','0','0','0','0','0','0','0','0','0','5.48474','0','0'),
('3291','38','-5347.86','-2973.72','324.281','0','0','0','0','0','0','0','0','0','4.84071','0','0'),
('3291','39','-5341.48','-2986.86','323.796','0','0','0','0','0','0','0','0','0','5.1643','0','0'),
('3291','40','-5339.28','-2994.1','323.666','0','0','0','0','0','0','0','0','0','4.84386','0','0'),
('3291','41','-5336.93','-3011.92','324.204','0','0','0','0','0','0','0','0','0','4.84386','0','0'),
('3291','42','-5327.9','-3023.13','323.927','0','0','0','0','0','0','0','0','0','5.39049','0','0'),
('3291','43','-5307.19','-3025.36','323.987','0','0','0','0','0','0','0','0','0','6.17589','0','0'),
('3291','44','-5277.25','-3020.54','324.528','0','0','0','0','0','0','0','0','0','0.128326','0','0'),
('3291','45','-5259.13','-3007.79','327.425','0','0','0','0','0','0','0','0','0','0.681246','0','0'),
('3291','46','-5277.49','-3018.52','324.255','0','0','0','0','0','0','0','0','0','3.61157','0','0'),
('3291','47','-5306.74','-3023.87','323.995','0','0','0','0','0','0','0','0','0','3.32254','0','0'),
('3291','48','-5326.26','-3021.57','324.09','0','0','0','0','0','0','0','0','0','3.02409','0','0'),
('3291','49','-5335.82','-3011.17','324.245','0','0','0','0','0','0','0','0','0','2.31409','0','0'),
('3291','50','-5339.37','-2990.65','323.728','0','0','0','0','0','0','0','0','0','1.74232','0','0'),
('3291','51','-5346.71','-2971.87','324.224','0','0','0','0','0','0','0','0','0','1.94338','0','0'),
('3291','52','-5349.32','-2959.58','323.622','0','0','0','0','0','0','0','0','0','1.68577','0','0'),
('3291','53','-5357.6','-2945.74','324.196','0','0','0','0','0','0','0','0','0','2.10989','0','0'),
('3291','54','-5392.87','-2908.93','338.031','0','0','0','0','0','0','0','0','0','2.24183','0','0'),
('3291','55','-5411.23','-2885.81','343.241','0','0','0','0','0','0','0','0','0','2.24183','0','0'),
('3291','56','-5433.09','-2883.85','345.324','0','0','0','0','0','0','0','0','0','3.05236','0','0'),
('3291','57','-5472.83','-2872.93','351.192','0','0','0','0','0','0','0','0','0','2.87329','0','0'),
('3291','58','-5520.14','-2862.64','358.587','0','0','0','0','0','0','0','0','0','2.82774','0','0'),
('3291','59','-5536.49','-2857.33','360.9','0','0','0','0','0','0','0','0','0','2.82774','0','0'),
('3291','60','-5554.88','-2837.76','363.595','0','0','0','0','0','0','0','0','0','2.22691','0','0'),
('3291','61','-5572.69','-2818.53','365.922','0','0','0','0','0','0','0','0','0','2.36828','0','0'),
('3291','62','-5596.97','-2804.36','366.727','0','0','0','0','0','0','0','0','0','2.61333','0','0'),
('3291','63','-5606.84','-2798.6','366.133','0','0','0','0','0','0','0','0','0','2.61333','0','0'),
('3291','64','-5634.87','-2786.19','365.073','0','0','0','0','0','0','0','0','0','2.83638','0','0'),
('3291','65','-5678.13','-2770.23','362.982','0','0','0','0','0','0','0','0','0','2.99582','0','0'),
('3291','66','-5690.66','-2766.1','362.397','0','0','0','0','0','0','0','0','0','2.82303','0','0'),
('3291','67','-5698.76','-2756.49','361.138','0','0','0','0','0','0','0','0','0','2.08475','0','0'),
('3291','68','-5704.36','-2737.12','357.373','0','0','0','0','0','0','0','0','0','1.85228','0','0'),
('3291','69','-5727.72','-2700.13','346.873','0','0','0','0','0','0','0','0','0','1.83971','0','0'),
('3291','70','-5732.92','-2685.87','342.616','0','0','0','0','0','0','0','0','0','2.22691','0','0'),
('3291','71','-5740.88','-2675.53','339.458','0','0','0','0','0','0','0','0','0','2.22691','0','0'),
('3291','72','-5769.3','-2646.41','328.436','0','0','0','0','0','0','0','0','0','2.16958','0','0'),
('3291','73','-5789.12','-2625.26','320.88','0','0','0','0','0','0','0','0','0','2.29917','0','0'),
('3291','74','-5819.53','-2595.51','313.505','0','0','0','0','0','0','0','0','0','2.22377','0','0'),
('3291','75','-5829.42','-2584.07','311.853','0','0','0','0','0','0','0','0','0','2.55678','0','0'),
('3291','76','-5862.57','-2562.12','308.096','0','0','0','0','0','0','0','0','0','2.55678','0','0'),
('3291','77','-5867.84','-2558.63','307.436','0','0','0','0','0','0','0','0','0','2.55678','0','0'),
('3291','78','-5882.61','-2573.11','304.617','0','0','0','0','0','0','0','0','0','3.85426','0','0'),
('3291','79','-5899.8','-2594.09','310.551','0','0','0','0','0','0','0','0','0','4.18726','0','0'),
('3291','80','-5908.81','-2609.64','312.219','0','0','0','0','0','0','0','0','0','4.18726','0','0'),
('3291','81','-5906.14','-2622.35','311.742','0','0','0','0','0','0','0','0','0','4.91926','0','0'),
('3291','82','-5898.01','-2632.78','311.436','0','0','0','0','0','0','0','0','0','5.37479','0','0'),
('3291','83','-5890.23','-2639.18','310.56','0','0','0','0','0','0','0','0','0','5.5947','0','0'),
('3291','84','-5902.75','-2627.92','311.851','0','0','0','0','0','0','0','0','0','2.40913','0','0'),
('3291','85','-5909.63','-2610.52','312.202','0','0','0','0','0','0','0','0','0','1.94731','0','0'),
('3291','86','-5906.77','-2602.09','312.394','0','0','0','0','0','0','0','0','0','1.24359','0','0'),
('3291','87','-5889.35','-2582.36','306.596','0','0','0','0','0','0','0','0','0','0.847753','0','0'),
('3291','88','-5871.75','-2562.41','307.249','0','0','0','0','0','0','0','0','0','0.847753','0','0'),
('3291','89','-5860.95','-2564.09','308.236','0','0','0','0','0','0','0','0','0','6.12877','0','0'),
('3291','90','-5832.95','-2584.17','311.647','0','0','0','0','0','0','0','0','0','5.62062','0','0'),
('3291','91','-5813.9','-2604.7','314.778','0','0','0','0','0','0','0','0','0','5.52009','0','0'),
('3291','92','-5791.18','-2628.3','321.143','0','0','0','0','0','0','0','0','0','5.40699','0','0'),
('3291','93','-5764.56','-2656.04','331.466','0','0','0','0','0','0','0','0','0','5.64339','0','0'),
('3291','94','-5740.97','-2679.22','340.073','0','0','0','0','0','0','0','0','0','5.46197','0','0'),
('3291','95','-5730.23','-2695.35','345.314','0','0','0','0','0','0','0','0','0','5.19258','0','0'),
('3291','96','-5726.44','-2706.78','348.473','0','0','0','0','0','0','0','0','0','5.52873','0','0'),
('3291','97','-5710','-2730.68','355.388','0','0','0','0','0','0','0','0','0','5.3151','0','0'),
('3291','98','-5701.37','-2751.53','360.474','0','0','0','0','0','0','0','0','0','5.10461','0','0'),
('3291','99','-5696.75','-2762.71','361.656','0','0','0','0','0','0','0','0','0','5.47846','0','0'),
('3291','100','-5689.72','-2770.02','362.277','0','0','0','0','0','0','0','0','0','5.47846','0','0'),
('3291','101','-5660.88','-2779.39','363.599','0','0','0','0','0','0','0','0','0','5.8476','0','0'),
('3291','102','-5636.26','-2788.88','364.866','0','0','0','0','0','0','0','0','0','5.84289','0','0'),
('3291','103','-5605.18','-2803.53','366.493','0','0','0','0','0','0','0','0','0','5.84289','0','0'),
('3291','104','-5573.36','-2818.52','365.96','0','0','0','0','0','0','0','0','0','5.84289','0','0'),
('3291','105','-5550.69','-2846.35','362.608','0','0','0','0','0','0','0','0','0','5.5193','0','0'),
('3291','106','-5537.64','-2859.53','360.821','0','0','0','0','0','0','0','0','0','5.65046','0','0'),
('3291','107','-5531.32','-2864.17','359.991','0','0','0','0','0','0','0','0','0','6.16569','0','0'),
('3291','108','-5488.37','-2873.25','353.666','0','0','0','0','0','0','0','0','0','6.04709','0','0'),
('3291','109','-5456.38','-2880.48','348.614','0','0','0','0','0','0','0','0','0','6.16019','0','0'),
('3291','110','-5423.53','-2884.54','344.053','0','0','0','0','0','0','0','0','0','6.16019','0','0'),
('3291','111','-5401.69','-2884.27','342.503','0','0','0','0','0','0','0','0','0','0.206868','0','0'),
('3291','112','-5392.35','-2880.58','341.778','0','0','0','0','0','0','0','0','0','0.514744','0','0'),
('3291','113','-5380.66','-2872.7','340.858','0','0','0','0','0','0','0','0','0','0.537521','0','0'),
('3291','114','-5365.29','-2862.53','340.165','0','0','0','0','0','0','0','0','0','0.267344','0','0'),
('3291','115','-5347.07','-2858.9','340.08','0','0','0','0','0','0','0','0','0','0.010519','0','0'),
('3291','116','-5324.24','-2861.33','339.594','0','0','0','0','0','0','0','0','0','6.17589','0','0'),
('3291','117','-5309.2','-2866.12','339.309','0','0','0','0','0','0','0','0','0','5.97483','0','0'),
('3291','118','-5292.78','-2873.85','338.848','0','0','0','0','0','0','0','0','0','5.84289','0','0'),
('3291','119','-5281.6','-2881.01','338.697','0','0','0','0','0','0','0','0','0','5.71408','0','0'),
('3291','120','-5264.57','-2885.16','339.156','0','0','0','0','0','0','0','0','0','6.04395','0','0'),
('3291','121','-5242.85','-2885.72','339.023','0','0','0','0','0','0','0','0','0','6.25758','0','0'),
('3291','122','-5229.56','-2874.37','338.371','0','0','0','0','0','0','0','0','0','0.706381','0','0'),
('3291','123','-5214','-2862.08','336.731','0','0','0','0','0','0','0','0','0','0.499036','0','0'),
('3291','124','-5197.48','-2853.08','335.844','0','0','0','0','0','0','0','0','0','0.499036','0','0'),
('3291','125','-5178.22','-2848.09','335.132','0','0','0','0','0','0','0','0','0','0.146392','0','0'),
('3291','126','-5146.21','-2841.59','332.234','0','0','0','0','0','0','0','0','0','0.186448','0','0'),
('3291','127','-5106.87','-2833.91','327.933','0','0','0','0','0','0','0','0','0','0.29012','0','0'),
('3291','128','-5066.16','-2823.28','327.375','0','0','0','0','0','0','0','0','0','0.24064','0','0'),
('3291','129','-5032.91','-2804.65','326.915','0','0','0','0','0','0','0','0','0','0.510817','0','0'),
('3291','130','-5010','-2791.81','326.304','0','0','0','0','0','0','0','0','0','0.510817','0','0'),
('3291','131','-4968.57','-2773.72','325.646','0','0','0','0','0','0','0','0','0','0.439346','0','0'),
('3291','132','-4954.18','-2766.95','325.752','0','0','0','0','0','0','0','0','0','0.439346','0','0'),
('3291','133','-4927.36','-2744.64','327.572','0','0','0','0','0','0','0','0','0','0.693815','0','0'),
('3291','134','-4916.59','-2735.69','328.483','0','0','0','0','0','0','0','0','0','0.693815','0','0'),
('3291','135','-4884.93','-2722.71','329.08','0','0','0','0','0','0','0','0','0','0.38908','0','0'),
('3291','136','-4851.32','-2715.76','329.103','0','0','0','0','0','0','0','0','0','0.203726','0','0'),
('3291','137','-4819.79','-2715.28','327.945','0','0','0','0','0','0','0','0','0','0.015231','0','0'),
('3291','138','-4778.75','-2714.66','326.079','0','0','0','0','0','0','0','0','0','0.015231','0','0'),
('3291','139','-4763.65','-2712.3','326.411','0','0','0','0','0','0','0','0','0','0.161315','0','0'),
('3291','140','-4739.89','-2704.22','323.584','0','0','0','0','0','0','0','0','0','0.327819','0','0'),
('3291','141','-4702.18','-2700.57','318.752','0','0','0','0','0','0','0','0','0','0.085131','0','0');

-- https://github.com/cmangos/classic-db/blob/master/Updates/1497_mechanical_bleed_immunity.sql
-- All Mechanical NPC Are Immune To Bleed Effects
UPDATE creature_template SET MechanicImmuneMask=MechanicImmuneMask|16384 WHERE CreatureType=9;

-- https://github.com/cmangos/classic-db/blob/master/Updates/1498_xt9_movement.sql
-- ========================================
-- XT:9 NPC Pathing in Stonetalon Mountians
-- ========================================
UPDATE creature SET SpawnDist=0, MovementType=2 WHERE id IN (4074);
DELETE FROM creature_movement_template WHERE entry=4074;
INSERT INTO creature_movement_template (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('4074','1','1075.73','109.549','5.60816','0','0','0','0','0','0','0','0','0','5.0834','0','0'),
('4074','2','1079.73','99.268','3.41564','0','0','0','0','0','0','0','0','0','5.0834','0','0'),
('4074','3','1090.37','94.7499','1.38691','0','0','0','0','0','0','0','0','0','5.90493','0','0'),
('4074','4','1098.28','86.305','-0.519949','0','0','0','0','0','0','0','0','0','5.46511','0','0'),
('4074','5','1100.67','71.9778','-2.34006','0','0','0','0','0','0','0','0','0','4.87763','0','0'),
('4074','6','1091.75','52.2905','-0.612526','0','0','0','0','0','0','0','0','0','4.28701','0','0'),
('4074','7','1091.41','41.9269','2.40356','0','0','0','0','0','0','0','0','0','4.67971','0','0'),
('4074','8','1084.62','28.2413','3.83921','0','0','0','0','0','0','0','0','0','4.25166','0','0'),
('4074','9','1083.64','13.9664','4.41043','0','0','0','0','0','0','0','0','0','4.64436','0','0'),
('4074','10','1086.07','5.34832','4.50555','0','0','0','0','0','0','0','0','0','4.9868','0','0'),
('4074','11','1081.28','-10.0805','5.44058','0','0','0','0','0','0','0','0','0','4.4111','0','0'),
('4074','12','1088.65','-24.2962','2.91566','0','0','0','0','0','0','0','0','0','5.24519','0','0'),
('4074','13','1087.07','-39.721','4.07423','0','0','0','0','0','0','0','0','0','4.61059','0','0'),
('4074','14','1088.96','-49.3655','4.30293','0','0','0','0','0','0','0','0','0','4.9059','0','0'),
('4074','15','1092.73','-62.5249','3.37376','0','0','0','0','0','0','0','0','0','5.05434','0','0'),
('4074','16','1095.35','-75.815','2.76013','0','0','0','0','0','0','0','0','0','4.90669','0','0'),
('4074','17','1088.35','-90.7219','4.77906','0','0','0','0','0','0','0','0','0','4.23517','0','0'),
('4074','18','1086.6','-111.394','4.95865','0','0','0','0','0','0','0','0','0','4.62787','0','0'),
('4074','19','1075.78','-135.984','6.67439','0','0','0','0','0','0','0','0','0','4.298','0','0'),
('4074','20','1075.67','-159.762','6.27177','0','0','0','0','0','0','0','0','0','4.67735','0','0'),
('4074','21','1071.92','-176.93','6.73229','0','0','0','0','0','0','0','0','0','4.49357','0','0'),
('4074','22','1073.79','-201.316','5.99961','0','0','0','0','0','0','0','0','0','4.78888','0','0'),
('4074','23','1071.11','-211.791','5.2782','0','0','0','0','0','0','0','0','0','4.45744','0','0'),
('4074','24','1076.08','-230.956','4.15773','0','0','0','0','0','0','0','0','0','4.87527','0','0'),
('4074','25','1099.89','-244.16','-1.29967','0','0','0','0','0','0','0','0','0','5.79576','0','0'),
('4074','26','1121.68','-242.158','-0.718831','0','0','0','0','0','0','0','0','0','0.126754','0','0'),
('4074','27','1134.62','-236.012','-2.50224','0','0','0','0','0','0','0','0','0','0.517883','0','0'),
('4074','28','1142.64','-216.147','-3.15201','0','0','0','0','0','0','0','0','0','1.15798','0','0'),
('4074','29','1140.35','-201.093','0.440253','0','0','0','0','0','0','0','0','0','1.78159','0','0'),
('4074','30','1133.45','-183.984','2.20237','0','0','0','0','0','0','0','0','0','1.94103','0','0'),
('4074','31','1145.68','-170.846','1.77109','0','0','0','0','0','0','0','0','0','0.741722','0','0'),
('4074','32','1153.89','-157.054','-2.33697','0','0','0','0','0','0','0','0','0','1.03389','0','0'),
('4074','33','1144.74','-142.506','-1.19541','0','0','0','0','0','0','0','0','0','2.06198','0','0'),
('4074','34','1122.65','-133.265','1.03252','0','0','0','0','0','0','0','0','0','2.72485','0','0'),
('4074','35','1125.36','-110.493','2.11991','0','0','0','0','0','0','0','0','0','1.45251','0','0'),
('4074','36','1122.38','-93.8318','2.5116','0','0','0','0','0','0','0','0','0','1.74782','0','0'),
('4074','37','1129.87','-74.1374','-2.2857','0','0','0','0','0','0','0','0','0','1.20746','0','0'),
('4074','38','1134.64','-61.5813','-5.31756','0','0','0','0','0','0','0','0','0','1.20746','0','0'),
('4074','39','1137.59','-48.6249','-7.44319','0','0','0','0','0','0','0','0','0','1.39125','0','0'),
('4074','40','1128.82','-38.9268','-2.43575','0','0','0','0','0','0','0','0','0','2.30231','0','0'),
('4074','41','1122.16','-27.6501','0.344378','0','0','0','0','0','0','0','0','0','2.10439','0','0'),
('4074','42','1120.96','-16.3595','-1.48752','0','0','0','0','0','0','0','0','0','1.67635','0','0'),
('4074','43','1126.61','-1.9186','-3.63006','0','0','0','0','0','0','0','0','0','1.19804','0','0'),
('4074','44','1116.24','10.5576','0.557486','0','0','0','0','0','0','0','0','0','2.31173','0','0'),
('4074','45','1104.32','16.4108','4.14081','0','0','0','0','0','0','0','0','0','2.61804','0','0'),
('4074','46','1101.3','33.6785','4.8855','0','0','0','0','0','0','0','0','0','1.69912','0','0'),
('4074','47','1120.13','44.4575','2.74572','0','0','0','0','0','0','0','0','0','0.535947','0','0'),
('4074','48','1132.62','61.1624','0.727029','0','0','0','0','0','0','0','0','0','0.928646','0','0'),
('4074','49','1134.27','76.7979','-1.64004','0','0','0','0','0','0','0','0','0','1.3182','0','0'),
('4074','50','1139.01','90.8736','-6.655','0','0','0','0','0','0','0','0','0','1.24516','0','0'),
('4074','51','1134.5','111.563','-1.48075','0','0','0','0','0','0','0','0','0','1.78552','0','0'),
('4074','52','1125.54','132.373','0.369555','0','0','0','0','0','0','0','0','0','2.00464','0','0'),
('4074','53','1128.01','157.092','0.350579','0','0','0','0','0','0','0','0','0','1.44073','0','0'),
('4074','54','1121.17','175.285','0.835962','0','0','0','0','0','0','0','0','0','1.93081','0','0'),
('4074','55','1123.89','192.99','1.13405','0','0','0','0','0','0','0','0','0','1.41795','0','0'),
('4074','56','1141.96','219.473','2.28035','0','0','0','0','0','0','0','0','0','0.991478','0','0'),
('4074','57','1152.68','240.982','6.25921','0','0','0','0','0','0','0','0','0','1.17526','0','0'),
('4074','58','1156.9','260.554','11.7266','0','0','0','0','0','0','0','0','0','1.39674','0','0'),
('4074','59','1155.6','275.102','14.4837','0','0','0','0','0','0','0','0','0','1.55382','0','0'),
('4074','60','1155.85','289.52','15.4549','0','0','0','0','0','0','0','0','0','1.55382','0','0'),
('4074','61','1146.88','297.346','16.5141','0','0','0','0','0','0','0','0','0','2.42405','0','0'),
('4074','62','1132.46','291.095','17.5076','0','0','0','0','0','0','0','0','0','3.55266','0','0'),
('4074','63','1127.93','271.738','15.7887','0','0','0','0','0','0','0','0','0','4.48257','0','0'),
('4074','64','1122.46','248.346','10.638','0','0','0','0','0','0','0','0','0','4.48257','0','0'),
('4074','65','1110.74','232.731','10.2723','0','0','0','0','0','0','0','0','0','4.0883','0','0'),
('4074','66','1090.53','227.583','11.042','0','0','0','0','0','0','0','0','0','3.39008','0','0'),
('4074','67','1078.98','217.067','10.5359','0','0','0','0','0','0','0','0','0','3.91552','0','0'),
('4074','68','1080.79','196.068','9.36658','0','0','0','0','0','0','0','0','0','4.79831','0','0'),
('4074','69','1081.94','182.796','9.09012','0','0','0','0','0','0','0','0','0','4.79831','0','0'),
('4074','70','1078.11','165.016','8.87527','0','0','0','0','0','0','0','0','0','4.5297','0','0'),
('4074','71','1074.72','146.657','5.22298','0','0','0','0','0','0','0','0','0','4.5297','0','0'),
('4074','72','1068.86','128.503','5.98122','0','0','0','0','0','0','0','0','0','4.42131','0','0'),
('4074','73','1070.86','117.81','7.22734','0','0','0','0','0','0','0','0','0','4.93732','0','0');

-- https://github.com/cmangos/classic-db/blob/master/Updates/1499_undermarket.sql
UPDATE quest_template SET RequiredSkillValue=1 WHERE entry IN (3385);

-- https://github.com/cmangos/classic-db/blob/master/Updates/1500_parchment_text.sql
DELETE FROM page_text WHERE entry=2461;
INSERT INTO `page_text` (`entry`, `text`, `next_page`) VALUES('2461','Lok-tar, $gbrother:sister. The elements beckon you closer and bid me to show you the path of the shaman. The spirits of our ancestors watch from beyond and swell with pride knowing you have joined our ranks.
When you are ready, seek me out near the entrance to the Den. It is there that I will be training others of our kind. Until then, may the wind be at your back.
-Shikrik, Shaman Trainer','0');

-- https://github.com/cmangos/classic-db/blob/master/Updates/1501_boss_immunities.sql
-- ======================================
-- All Bosses Are Immune To Crowd Control -- Daze, Horror, Shackle, Banish, Polymorph, Knockout, Freeze, Stun, Snare, Sleep, Silence, Pacify, Root, Fear, Distract, Disarm, Confused, Charm
-- ======================================

-- SHADOWFANG KEEP
UPDATE creature_template SET MechanicImmuneMask=MechanicImmuneMask|76234719 WHERE entry IN (4275,3887,4278,4274,4279,3886,3914,14682,3927);

-- RAGEFIRE CHASM
UPDATE creature_template SET MechanicImmuneMask=MechanicImmuneMask|76234719 WHERE entry IN (11517,11518,11519,11520);

-- https://github.com/cmangos/classic-db/blob/master/Updates/1512_kirith.sql
-- Kirith the Damned
UPDATE creature_template SET MinLevelHealth=10456,MaxLevelHealth=10456,MinLevelMana=0,MaxLevelMana=0, HealthMultiplier=4.0, ArmorMultiplier=1.0, DamageMultiplier=3.5, MinMeleeDmg=94, MaxMeleeDmg=125, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=228, RangedAttackPower=23, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000 WHERE entry=7728;
-- Spirit of Kirith
UPDATE creature_template SET MinLevelHealth=10456,MaxLevelHealth=10456,MinLevelMana=0,MaxLevelMana=0, HealthMultiplier=4.0, ArmorMultiplier=1.0, DamageMultiplier=3.5, MinMeleeDmg=94, MaxMeleeDmg=125, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=228, RangedAttackPower=23, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000 WHERE entry=7729;

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

SELECT * FROM db_version
