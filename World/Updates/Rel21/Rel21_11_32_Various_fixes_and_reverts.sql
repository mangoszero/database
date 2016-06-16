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
    SET @cOldContent = '31';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '32';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Various_fixes_and_reverts';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Various_fixes_and_reverts';

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

    -- Tided and error fixed Rel21_11_18_loot_table_fixes 
-- Gemstones weren't a quest item they always dropped and weren't 100% until patch 2.2 tbc
-- Proof: Proof: http://wowwiki.wikia.com/wiki/Patch_2.2.0
-- Relevant section: The gems for the Seal of Ascension are now a 100%

-- Overlord Wyrmthalak, War Master Voone and Highlord Omokk.
-- Overlord Wyrmthalak loot fix
UPDATE `creature_loot_template` SET ChanceOrQuestChance = 100 WHERE `entry` = 9568 AND `item` = 12780; 
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 20 WHERE `entry` = 9568 AND `item` IN 
(13163,22321 ,13161,13162 ,16679);
UPDATE `creature_loot_template` SET ChanceOrQuestChance = 26 WHERE `entry` = 9568 AND `item` = 12337;

-- Highlord Omokk loot fixed
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `entry` = 9196 AND `item` = 12534; 
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 16.67 WHERE `entry` = 9196 AND `item` IN 
(13166, 13167,13168,13169, 13170,16670);
-- War Master Voone loot fixed
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 20 WHERE `entry` = 9237 AND `item` IN (12582,13177,13179,16676,22231);

-- Tidied up: Fixed Rel21_11_19_respawn_time_fixes additional work needed here
UPDATE `gameobject` SET spawntimesecs = 3600 WHERE `guid` IN 
(45745,45746,45747,45748,45749,45740,45741,45742,45743,45744,48265,48266,48267, 
48268,48269,48270,48271,48272,48273,48274,48276,48275,48277,48278,48279,48280,
48281,48282);

-- Reverts rookery egg faction to 0
-- Revert: Rel21_11_20_dragonkin_eggs_fix.sql
-- rookery egg
UPDATE `gameobject_template` SET `faction`=0 WHERE `entry` = 175124;

-- Revert Rel21_11_25_quest_item_drop_fixes as they are later wow values
-- http://www.wowhead.com/item=3919/mistvale-giblets
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -30  WHERE `item`= 3919;
-- http://www.wowhead.com/item=3411/strigid-owl-feather
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -35  WHERE `item`= 3411;
-- http://www.wowhead.com/item=3412/webwood-spider-silk
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -27  WHERE `item`= 3412;
-- http://www.wowhead.com/item=5170/mossy-tumor
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -35  WHERE `item`= 5170 AND `entry` = 2027;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -42  WHERE `item`= 5170 AND `entry` IN (2029,2030);
-- http://www.wowhead.com/item=3409/nightsaber-fang
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -21  WHERE `item`= 3409;
-- http://www.wowhead.com/quest=500/deprecated-crushridge-bounty
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -50  WHERE `item`= 2843;
-- http://www.wowhead.com/item=3658/recovered-tome
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -15  WHERE `item`= 3658;
-- http://www.wowhead.com/item=5064/witchwing-talon
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -39  WHERE `item`= 5064;
-- http://www.wowhead.com/item=5097/cats-eye-emerald#comments
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -2  WHERE `entry`= 9336  AND `item`= 5097;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -6  WHERE `entry`= 3283  AND `item`= 5097;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -5 WHERE `entry`= 3286  AND `item`= 5097;
-- http://www.wowhead.com/item=5794/salty-scorpid-venom
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -10  WHERE `item`= 5794;
-- http://www.wowhead.com/item=5795/hardened-tortoise-shell
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -30  WHERE `item`= 5795;

-- Lowers the money far to low. Source?
-- Revert Partial Rel21_11_22_Update_additional_quest_rewards /21
-- Felwood repeatable quests 
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 3660 WHERE `entry` IN (5882,5883,5884,5885,5886);

-- Fixed Rel21_11_26_various_quest_fixes.sql
-- http://wowwiki.wikia.com/wiki/Patch_1.12.0
-- Changed these weapons to have spells like 'Hurricane' as per patch 1.12.0.

-- fixed Weapon Damage
UPDATE `item_template` SET `dmg_min2` = 0 , `dmg_max2` = 0, `dmg_type2` = 0 WHERE `entry` IN 
(10567,17753,2825,13040 ,6469,2099 ,13146 ,9412,16004);

-- Quillshooter
UPDATE `item_template` SET `spellid_1`=29634, `spelltrigger_1`=1 WHERE  `entry`=10567;
-- Dark Iron Rifle
UPDATE `item_template` SET `spellid_1`=29632, `spelltrigger_1`=1 WHERE  `entry`=16004;
-- Verdant keeper's Aim
UPDATE `item_template` SET `spellid_1`=29637, `spelltrigger_1`=1 WHERE  `entry`=17753;
-- Shell Launcher Shotgun
UPDATE `item_template` SET `spellid_1`=29635, `spelltrigger_1`=1 WHERE  `entry`=13146;
-- Heartseeking Crossbow
UPDATE `item_template` SET `spellid_1`=29640, `spelltrigger_1`=1 WHERE  `entry`=13040;
-- Galgann's Blaster
UPDATE `item_template` SET `spellid_1`=29633, `spelltrigger_1`=1 WHERE  `entry`=9412;
-- VenomStrike
UPDATE `item_template` SET `spellid_1`=29636, `spelltrigger_1`=1 WHERE  `entry`=6469;
-- Bow of Searing Arrows
UPDATE `item_template` SET `spellid_1`=29638, `spelltrigger_1`=1 WHERE  `entry`=2825;
-- Dwarven handcannon
UPDATE `item_template` SET `spellid_1`=29639, `spelltrigger_1`=1 WHERE  `entry`=2099;

-- Addtional Fixes
-- Change certain 'Says' to Emotes in Quest: How Big a Threat? 
-- https://www.getmangos.eu/issue.php?issueid=1169
-- Thankyou: Gabrielsan for pointing this out!

UPDATE `db_script_string` SET `type`=2 WHERE  `entry` IN ('2000005393', '2000005391', '2000005389', '2000005387', '2000005385');

-- Remove Kharanos mailbox from Hallows End event. 
-- Fixes Issue: https://www.getmangos.eu/issue.php?issueid=1143
-- Thankyou to: Gabrielsani for pointing this issue out!

DELETE FROM `game_event_gameobject` WHERE  `guid`= 38755;

-- Item: 10552 for Quest: 3452 droprate lowered to %10. 
-- Proof: http://www.wowhead.com/item=10552/symbol-of-ragnaros
-- Proof: https://vanilla-twinhead.twinstar.cz/?item=10552
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-10 WHERE  `entry` IN (5860,5861,5862,8419) AND `item`=10552;

-- Added 2 scourge data to ziggarauts
-- Proof: http://www.wowhead.com/object=176249/scourge-data#comments
-- Proof: http://wowwiki.wikia.com/wiki/Scourge_Data
DELETE FROM `gameobject` WHERE `guid` IN (632464,632463);
INSERT INTO `gameobject` VALUES 
(632464, 176249, 329, 4070.86, -3665.03, 132.656, 4.78743, 0, 0, 0.680085, -0.733134, 25, 100, 1),
(632463, 176249, 329, 3827.66, -3505.07, 141.21, 2.02674, 0, 0, 0.848619, 0.529004, 25, 100, 1);

-- Pool Templates
DELETE FROM `pool_template` WHERE `entry` = 25505;
INSERT INTO `pool_template` VALUES (25505, 1, 'Scourge Data');

-- Pool Gameobject 
DELETE FROM `pool_gameobject` WHERE `guid` IN (632464,632463,27880);
INSERT INTO `pool_gameobject` VALUES 
(632464, 25505, 0, 'Scourge Data'),
(632463, 25505, 0, 'Scourge Data'),
(27880, 25505, 0, 'Scourge Data');

--  Path Lazzarik and Jorb
-- Proof: http://wowwiki.wikia.com/wiki/Jorb
-- Proof: http://wowwiki.wikia.com/wiki/Lizzarik
-- Fixes: https://www.getmangos.eu/issue.php?issueid=101
-- Set Larrik to waypoint movement
UPDATE `creature` SET `MovementType`=2 WHERE  `guid`=14056;
UPDATE `creature_template_addon` SET `moveflags`=2 WHERE  `entry`=3658;
-- Link Jorb to lizzarik
DELETE FROM `creature_linking` WHERE `guid` = 14057;
INSERT INTO `creature_linking` VALUES (14057, 14056, 643);
-- Give Lizzarik waypoints
DELETE FROM `creature_movement_template` WHERE `entry` =  3658;
INSERT INTO `creature_movement_template` VALUES 
(3658, 20, -1013.48, -3411.28, 76.7449, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 19, -1012.58, -3434.42, 71.6242, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 18, -1009.65, -3456.4, 66.7277, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 17, -1007.61, -3472.89, 61.9067, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 16, -996.188, -3485.45, 57.5409, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 15, -982.939, -3501.15, 52.99, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 14, -978.18, -3522.96, 46.1286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 13, -974.482, -3542.2, 39.9397, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 12, -961.164, -3555.35, 34.7074, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 11, -950.664, -3571.4, 29.6878, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 10, -946.587, -3588.83, 24.9134, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 9, -944.078, -3614.4, 18.4669, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 8, -942.68, -3634.02, 14.696, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 7, -942.253, -3643.68, 12.9161, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 6, -945.92, -3652.5, 11.1915, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 5, -953.702, -3656.07, 10.7072, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 4, -960.407, -3651.54, 12.2445, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 3, -966.136, -3643.84, 15.9002, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 2, -970.831, -3639.29, 18.0752, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 1, -973.714, -3635.71, 18.9430, 180000, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 21, -1011.04, -3385.82, 83.0191, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 22, -1005.43, -3361.67, 88.3728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 23, -997.351, -3348.44, 91.5736, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 24, -985.274, -3328.6, 94.5442, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 25, -979.424, -3306.67, 95.2504, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 26, -970.135, -3286.31, 95.7862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 27, -956.495, -3265.02, 95.7862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 28, -949.008, -3247.36, 94.9369, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 29, -940.436, -3233.85, 92.7622, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 30, -931.281, -3226.08, 91.7106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 31, -913.331, -3211.54, 91.668, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 32, -894.802, -3185.14, 91.668, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 33, -884.48, -3161.18, 92.7747, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 34, -879.461, -3125.11, 94.0409, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 35, -876.84, -3106.71, 95.1118, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 36, -868.681, -3092.01, 95.1256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 37, -846.549, -3083.52, 96.2828, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 38, -820.901, -3073.88, 96.7255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 39, -794.073, -3053.32, 95.785, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 40, -768.567, -3020.82, 93.2511, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 41, -740.784, -2995.39, 92.8363, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 42, -711.561, -2976.18, 94.399, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 43, -699.905, -2957.64, 95.3581, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 44, -673.319, -2949.59, 95.7864, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 45, -643.523, -2930.65, 95.7884, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 46, -621.737, -2907.9, 95.7852, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 47, -608.069, -2886.81, 94.1918, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 48, -591.722, -2873.45, 92.1117, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 49, -567.04, -2853.62, 91.6669, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 50, -540.023, -2830.48, 91.6669, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 51, -511.05, -2801.82, 91.6669, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 52, -488.72, -2777.63, 91.6669, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 53, -483.307, -2756.6, 91.694, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 54, -480.568, -2721.99, 93.373, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 55, -478.15, -2702.9, 94.8884, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 56, -471.006, -2691.1, 95.5833, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 57, -470.684, -2681.27, 95.6921, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 58, -481.235, -2680.01, 96.9561, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 59, -484.901, -2681.5, 97.0094, 180000, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 60, -483.707, -2681.266, 96.978, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 61, -472.043, -2681.34, 95.8392, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 62, -471.873, -2690.83, 95.5787, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 63, -478.175, -2701.76, 94.9648, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 64, -480.086, -2719.54, 93.5952, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 65, -481.303, -2740.82, 92.4681, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 66, -483.009, -2755.46, 91.709, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 67, -488.161, -2776.31, 91.6677, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 68, -508.322, -2798.51, 91.6677, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 69, -535.945, -2818, 91.6677, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 70, -555.524, -2834.52, 91.6677, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 71, -571.633, -2847.6, 91.687, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 72, -593.913, -2866.19, 91.6963, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 73, -613.266, -2881.91, 94.0434, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 74, -624.144, -2896.79, 95.5848, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 75, -641.76, -2914.75, 95.7858, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 76, -659.625, -2933.93, 95.7873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 77, -676.874, -2942.66, 95.7876, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 78, -702.819, -2948.81, 95.8929, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 79, -715.012, -2967.85, 94.5936, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 80, -740.016, -2983.05, 92.3598, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 81, -760.976, -3001.41, 92.2708, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 82, -782.168, -3026.59, 94.101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 83, -797.828, -3046.92, 96.0543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 84, -814.626, -3060.99, 96.7209, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 85, -832.638, -3071.55, 96.8766, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 86, -854.951, -3076.84, 96.3577, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 87, -876.139, -3087.39, 95.0842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 88, -883.838, -3101.15, 95.0266, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 89, -885.04, -3122.12, 94.3326, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 90, -887.875, -3148.55, 93.0788, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 91, -916.252, -3205.13, 91.6667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 92, -933.595, -3219.78, 91.6667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 93, -943.411, -3229.84, 92.2266, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 94, -951.631, -3246.37, 94.8433, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 95, -960.281, -3263.95, 95.7859, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 96, -973.529, -3284.55, 95.7888, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 97, -982.17, -3304, 95.3839, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 98, -988.843, -3323.85, 94.7288, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 99, -1000.79, -3344.85, 91.6158, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 100, -1009.45, -3358.52, 88.7479, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 101, -1015.22, -3383.57, 83.1857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 102, -1018.72, -3409.7, 77.1243, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 103, -1018.41, -3433.29, 72.0238, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 104, -1014.82, -3460.53, 65.8871, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 105, -1013.02, -3473.91, 62.1409, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 106, -1002.82, -3484.8, 58.1286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 107, -987.011, -3498.94, 53.9634, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 108, -981.342, -3519.52, 47.2472, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 109, -978.241, -3539.3, 41.1956, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 110, -967.509, -3554.65, 35.6399, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 111, -956.37, -3570.33, 30.43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 112, -951.962, -3589.35, 25.1491, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 113, -950.533, -3611.54, 19.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 114, -953.15, -3619.33, 18.014, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 115, -960.739, -3626.75, 18.4132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(3658, 116, -971.593, -3631.02, 19.0482, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);

-- Remove unobtainable tbc loot gossip from code vendor
DELETE FROM `gossip_menu_option` WHERE `menu_id`= 6565 and`id` IN (1,2);

-- remove guard and pvp status for se'jib
UPDATE `creature_template` SET `UnitFlags`=512, `ExtraFlags`=2  WHERE  `Entry`=7871;

    

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

