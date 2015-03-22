--
-- Copyright (C) 2005-2013 MaNGOS <http://getmangos.com/>
-- Copyright (C) 2009-2013 MaNGOSZero <https://github.com/mangoszero>
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--

-- Fixed quest 1846: item 7131 now is a 100% drop for characters on the quest.
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 7131;

-- Fixed creature 299: Young Wolf will ignore aggro now.
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 299;

-- Fixed quest 111: removed RequestItemsText.
UPDATE `quest_template` SET `RequestItemsText` = '' WHERE `entry` = 111;

-- Fixed quest 3065: restricted quest faction to Troll.
UPDATE `quest_template` SET `RequiredRaces` = 128 WHERE `entry` = 3065;

-- Fixed quest 5624: added punctuation to quest texts.
UPDATE `quest_template` SET `OfferRewardText` = 'Excellent, $N. With one more healthy guard out there to help the town, we\'ll be that much safer. I\'m glad to see you\'re already learning to use your abilities wisely. If you feel you are ready for more training at any time, please come back to me. But for now, take this robe. It will let others know that you are one of our order. If you don\'t want to wear it, that\'s fine. Later there will be more tests and this robe isn\'t necessary for those.' WHERE `entry` = 5624;

-- Fixed quest 5625: added punctuation to quest texts.
UPDATE `quest_template` SET `OfferRewardText` = 'Excellent, $N. With one more healthy guard out there to help the town, we\'ll be that much safer. I\'m glad to see you\'re already learning to use your abilities wisely. If you feel you are ready for more training at any time, please come back to me. But for now, take this robe. It will let others know that you are one of our order. If you don\'t want to wear it, that\'s fine. Later there will be more tests and this robe isn\'t necessary for those.' WHERE `entry` = 5625;

-- Fixed quest 6072: added OfferRewardText.
UPDATE `quest_template` SET `OfferRewardText` = 'Yes, it is time, $c.' WHERE `entry` = 6072;

-- Fixed quest 6126: removed PrevQuestId, thus the quest is now attainable.
UPDATE `quest_template` SET `PrevQuestId` = 0 WHERE `entry` = 6126;

-- Added on kill reputation for a few Ahn'Qiraj creatures. 
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15318;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15319;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15325;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15327;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15335;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15336;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15355;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15505;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15514;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15538;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15555;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15934;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 15741;
INSERT INTO `creature_onkill_reputation` VALUES
(15318,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15319,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15325,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15327,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15335,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15336,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15355,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15505,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15514,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15538,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15555,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15934,609,0,7,0,5,0,0,0,0);
INSERT INTO `creature_onkill_reputation` VALUES
(15741,910,609,3,0,2000,7,0,25,0);

-- Fixed Required Races for quest 6283 Bloodfury Bloodline
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 6283;

-- Fixed Required Races for quest 2936 The Spider God
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 2936;

-- Fixed Required Races for quest 8913 An earnest proposition
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 8913;

-- Fixed Required Races for quest 8927 Just Compensation
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 8927;

-- Quest event script for Quest 75 The Legend Of Stalvan
DELETE FROM `dbscripts_on_event` WHERE `id` = 264;
INSERT INTO `dbscripts_on_event` VALUES
(264,3,10,2044,300000,0,0,0,0,0,0,0,-9548.42,-1440.2,62.29,2.19,'Summon Forlorn Spirit');
INSERT INTO `dbscripts_on_event` VALUES
(264,6,26,0,0,2044,10,3,0,0,0,0,0,0,0,0,'Start Attack');

-- Quest start script for Quest 74 The Legend Of Stalvan
UPDATE `quest_template` SET `StartScript` = 74 WHERE `entry` = 74;
DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 74;
INSERT INTO `dbscripts_on_quest_start` VALUES
(74,3,10,2044,300000,0,0,0,0,0,0,0,-8831.1,988.50,98.984,5.349,'Summon Forlorn Spirit');
INSERT INTO `dbscripts_on_quest_start` VALUES
(74,6,26,0,0,2044,10,0,0,0,0,0,0,0,0,0,'Start Attack');

-- Quest start script for Quest 68 The Legend Of Stalvan
UPDATE `quest_template` SET `CompleteScript` = 0 WHERE `entry` = 67;
UPDATE `quest_template` SET `StartScript` = 68 WHERE `entry` = 68;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 67;
DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 68;
INSERT INTO `dbscripts_on_quest_start` VALUES
(68,0,10,2044,300000,0,0,0,0,0,0,0,-10953.3,1568.47,46.978,3.392,'Summon Forlorn Spirit');
INSERT INTO `dbscripts_on_quest_start` VALUES
(68,3,26,0,0,2044,30,0,0,0,0,0,0,0,0,0,'Start Attack');

-- fixing Questtext for Quest 1004, 1018, 1019, 1047 A New Frontier
UPDATE `quest_template` SET `OfferRewardText` = 'Greetings, $C.$B$BI am pleased to see the likes of you taking an interest in the well being of nature; tales of your mighty deeds precede you, and you are welcomed here. Seeing you before me instills the feeling of confidence that the Cenarion Circle will get the proper aid it needs.$B$BOur connection with the Cenarion Circle in Moonglade transcends racial and political divides. Remember this as you work on behalf of the Circle, and you will do well.' WHERE `entry` = 1004;
UPDATE `quest_template` SET `OfferRewardText` = 'Greetings, $C.$B$BI am pleased to see the likes of you taking an interest in the well being of nature; tales of your mighty deeds precede you, and you are welcomed here. Seeing you before me instills the feeling of confidence that the Cenarion Circle will get the proper aid it needs.$B$BOur connection with the Cenarion Circle in Moonglade transcends racial and political divides. Remember this as you work on behalf of the Circle, and you will do well.' WHERE `entry` = 1018;
UPDATE `quest_template` SET `OfferRewardText` = 'What makes you think I wish to be pestered by the likes of you, $C? Wait - let me stop the important duties I attend to on a daily basis so I can help you locate a doodad somewhere. By all means, the welfare of Darnassus - nay, all of Teldrassil - should come second to the acquisition of a bauble for your collection.$B$BThe fools in Moonglade waste my time with their call for assistance, and now I must endure this?' WHERE `entry` = 1019;
UPDATE `quest_template` SET `OfferRewardText` = 'What makes you think I wish to be pestered by the likes of you, $C? Wait - let me stop the important duties I attend to on a daily basis so I can help you locate a doodad somewhere. By all means, the welfare of Darnassus - nay, all of Teldrassil - should come second to the acquisition of a bauble for your collection.$B$BThe fools in Moonglade waste my time with their call for assistance, and now I must endure this?' WHERE `entry` = 1047;

-- Made Quest startobject unavailable for alliance players Quest 6284 Arachnophobia
UPDATE `gameobject_template` SET `faction` = 83 WHERE `entry` = 177904;

-- Fix Questitem dropchance for quest 1093 Super reaper  6000
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -31 WHERE `item` = 5734;

-- fixed error from earlier commit
DELETE FROM `creature_loot_template` WHERE `entry` = 3283;
DELETE FROM `creature_loot_template` WHERE `entry` = 3286;
INSERT INTO `creature_loot_template` VALUES
(3283,414,0.02,0,1,1,0),
(3283,765,0.02,0,1,1,0),
(3283,774,0.02,0,1,1,0),
(3283,785,0.02,0,1,1,0),
(3283,818,0.08,0,1,1,0),
(3283,856,0.0049,0,1,1,0),
(3283,858,1.594,0,1,1,0),
(3283,954,0.36,0,1,1,0),
(3283,955,0.54,0,1,1,0),
(3283,1179,2.2549,0,1,1,0),
(3283,1180,0.5,0,1,1,0),
(3283,1206,0.12,0,1,1,0),
(3283,1210,0.36,0,1,1,0),
(3283,2287,4.6557,0,1,1,0),
(3283,2406,0.02,0,1,1,0),
(3283,2407,0.02,0,1,1,0),
(3283,2408,0.02,0,1,1,0),
(3283,2409,0.02,0,1,1,0),
(3283,2450,0.02,0,1,1,0),
(3283,2453,0.02,0,1,1,0),
(3283,2455,0.7533,0,1,1,0),
(3283,2553,0.02,0,1,1,0),
(3283,2555,0.02,0,1,1,0),
(3283,2589,17.782,0,1,3,0),
(3283,2592,19.8668,0,1,2,0),
(3283,2601,0.02,0,1,1,0),
(3283,2657,0.0049,0,1,1,0),
(3283,2770,0.08,0,1,1,0),
(3283,2771,0.02,0,1,1,0),
(3283,2835,0.04,0,1,1,0),
(3283,2836,0.02,0,1,1,0),
(3283,2881,0.02,0,1,1,0),
(3283,2882,0.02,0,1,1,0),
(3283,2996,0.02,0,1,1,0),
(3283,3012,0.34,0,1,1,0),
(3283,3311,0.0243,0,1,1,0),
(3283,3393,0.02,0,1,1,0),
(3283,3394,0.02,0,1,1,0),
(3283,3610,0.02,0,1,1,0),
(3283,4292,0.02,0,1,1,0),
(3283,4293,0.02,0,1,1,0),
(3283,4294,0.02,0,1,1,0),
(3283,4345,0.02,0,1,1,0),
(3283,4346,0.04,0,1,1,0),
(3283,4348,0.02,0,1,1,0),
(3283,4349,0.02,0,1,1,0),
(3283,4359,0.02,0,1,1,0),
(3283,4361,0.02,0,1,1,0),
(3283,4363,0.02,0,1,1,0),
(3283,4364,0.02,0,1,1,0),
(3283,4408,0.02,0,1,1,0),
(3283,4409,0.02,0,1,1,0),
(3283,4410,0.02,0,1,1,0),
(3283,4537,0.02,0,1,1,0),
(3283,4541,0.02,0,1,1,0),
(3283,4605,0.02,0,1,1,0),
(3283,5097,-100,0,1,1,0),
(3283,5500,0.02,0,1,1,0),
(3283,5573,0.0146,0,1,1,0),
(3283,5574,0.0194,0,1,1,0),
(3283,5578,0.02,0,1,1,0),
(3283,5972,0.02,0,1,1,0),
(3283,6271,0.02,0,1,1,0),
(3283,6342,0.02,0,1,1,0),
(3283,6344,0.02,0,1,1,0),
(3283,6347,0.02,0,1,1,0),
(3283,6348,0.04,0,1,1,0),
(3283,6375,0.02,0,1,1,0),
(3283,6390,0.02,0,1,1,0),
(3283,6391,0.02,0,1,1,0),
(3283,6661,0.04,0,1,1,0),
(3283,6663,0.06,0,1,1,0),
(3283,6716,0.02,0,1,1,0),
(3283,7288,0.02,0,1,1,0),
(3283,10316,0.02,0,1,1,0),
(3283,11038,0.02,0,1,1,0),
(3283,11039,0.02,0,1,1,0),
(3283,11081,0.02,0,1,1,0),
(3283,11148,-29,0,1,1,0),
(3283,24062,1,1,-24062,1,0),
(3283,24060,1,1,-24060,1,0),
(3283,24075,1,1,-24075,1,0),
(3283,24076,1,1,-24076,1,0),
(3283,24078,1,1,-24078,1,0),
(3283,24077,1,1,-24077,1,0),
(3283,24070,5,1,-24070,1,0),
(3286,414,0.02,0,1,1,0),
(3286,785,0.02,0,1,1,0),
(3286,814,25.3942,0,1,1,0),
(3286,818,0.14,0,1,1,0),
(3286,856,0.02,0,1,1,0),
(3286,858,1.3534,0,1,1,0),
(3286,954,0.36,0,1,1,0),
(3286,955,0.56,0,1,1,0),
(3286,1179,2.651,0,1,1,0),
(3286,1180,0.56,0,1,1,0),
(3286,1206,0.12,0,1,1,0),
(3286,1210,0.34,0,1,1,0),
(3286,2287,4.6533,0,1,1,0),
(3286,2406,0.02,0,1,1,0),
(3286,2407,0.02,0,1,1,0),
(3286,2408,0.02,0,1,1,0),
(3286,2409,0.02,0,1,1,0),
(3286,2449,0.02,0,1,1,0),
(3286,2452,0.02,0,1,1,0),
(3286,2453,0.02,0,1,1,0),
(3286,2455,0.7186,0,1,1,0),
(3286,2553,0.02,0,1,1,0),
(3286,2555,0.02,0,1,1,0),
(3286,2589,18.5084,0,1,3,0),
(3286,2592,19.513,0,1,2,0),
(3286,2601,0.02,0,1,1,0),
(3286,2657,0.014,0,1,1,0),
(3286,2770,0.04,0,1,1,0),
(3286,2771,0.04,0,1,1,0),
(3286,2775,0.02,0,1,1,0),
(3286,2835,0.02,0,1,1,0),
(3286,2836,0.02,0,1,1,0),
(3286,2881,0.02,0,1,1,0),
(3286,2882,0.02,0,1,1,0),
(3286,2996,0.02,0,1,1,0),
(3286,3012,0.36,0,1,1,0),
(3286,3393,0.02,0,1,1,0),
(3286,3394,0.02,0,1,1,0),
(3286,3610,0.02,0,1,1,0),
(3286,4292,0.04,0,1,1,0),
(3286,4293,0.02,0,1,1,0),
(3286,4294,0.02,0,1,1,0),
(3286,4345,0.02,0,1,1,0),
(3286,4346,0.02,0,1,1,0),
(3286,4347,0.02,0,1,1,0),
(3286,4348,0.02,0,1,1,0),
(3286,4349,0.02,0,1,1,0),
(3286,4359,0.02,0,1,1,0),
(3286,4361,0.02,0,1,1,0),
(3286,4363,0.02,0,1,1,0),
(3286,4364,0.04,0,1,1,0),
(3286,4408,0.02,0,1,1,0),
(3286,4409,0.02,0,1,1,0),
(3286,4410,0.02,0,1,1,0),
(3286,4537,0.02,0,1,1,0),
(3286,4541,0.02,0,1,1,0),
(3286,4605,0.02,0,1,1,0),
(3286,4957,0.02,0,1,1,0),
(3286,5075,0.0349,0,1,2,0),
(3286,5097,-100,0,1,1,0),
(3286,5573,0.0279,0,1,1,0),
(3286,5574,0.014,0,1,1,0),
(3286,5972,0.02,0,1,1,0),
(3286,6271,0.02,0,1,1,0),
(3286,6342,0.02,0,1,1,0),
(3286,6344,0.02,0,1,1,0),
(3286,6347,0.02,0,1,1,0),
(3286,6348,0.04,0,1,1,0),
(3286,6375,0.02,0,1,1,0),
(3286,6390,0.02,0,1,1,0),
(3286,6391,0.02,0,1,1,0),
(3286,6661,0.1,0,1,1,0),
(3286,6663,0.02,0,1,1,0),
(3286,6716,0.02,0,1,1,0),
(3286,7288,0.02,0,1,1,0),
(3286,10316,0.02,0,1,1,0),
(3286,11038,0.02,0,1,1,0),
(3286,11039,0.02,0,1,1,0),
(3286,11081,0.02,0,1,1,0),
(3286,11148,-27,0,1,1,0),
(3286,14169,0.014,0,1,1,0),
(3286,15019,0.02,0,1,1,0),
(3286,15496,0.02,0,1,1,0),
(3286,24060,1,1,-24060,1,0),
(3286,24078,1,1,-24078,1,0),
(3286,24077,1,1,-24077,1,0),
(3286,24070,5,1,-24070,1,0);

-- correct all reputation values for Stonetalon Mountains
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1057;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1058;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1059;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1062;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1068;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1071;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 1072;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1073;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 1074;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 1075;
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 1075;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1076;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 1076;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 1077;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1078;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 1078;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 1079;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 1080;
UPDATE `quest_template` SET `RewRepValue1` = 200 WHERE `entry` = 1081;
UPDATE `quest_template` SET `RewRepValue3` = 200 WHERE `entry` = 1081;
UPDATE `quest_template` SET `RewRepValue4` = 200 WHERE `entry` = 1081;
UPDATE `quest_template` SET `RewRepValue5` = 200 WHERE `entry` = 1081;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 1082;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1083;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1084;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 1089;
UPDATE `quest_template` SET `RewRepFaction1` = 76 WHERE `entry` = 1089;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 1090;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 1092;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1093;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 1094;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 1095;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1096;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 5881;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 6282;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 6283;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 6284;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 6301;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 6381;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 6401;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 6421;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 6461;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 6481;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 6548;

-- correct MinLevel and Level for Stonetalon Mountains
UPDATE `quest_template` SET `QuestLevel` = 22 WHERE `entry` = 1082;
UPDATE `quest_template` SET `MinLevel` = 21 WHERE `entry` = 1059;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 1068;
UPDATE `quest_template` SET `MinLevel` = 18 WHERE `entry` = 1072;
UPDATE `quest_template` SET `MinLevel` = 18 WHERE `entry` = 1073;
UPDATE `quest_template` SET `MinLevel` = 18 WHERE `entry` = 1074;
UPDATE `quest_template` SET `MinLevel` = 18 WHERE `entry` = 1075;
UPDATE `quest_template` SET `MinLevel` = 17 WHERE `entry` = 1078;
UPDATE `quest_template` SET `MinLevel` = 22 WHERE `entry` = 1081;
UPDATE `quest_template` SET `MinLevel` = 22 WHERE `entry` = 1082;
UPDATE `quest_template` SET `MinLevel` = 20 WHERE `entry` = 1083;
UPDATE `quest_template` SET `MinLevel` = 20 WHERE `entry` = 1088;
UPDATE `quest_template` SET `MinLevel` = 17 WHERE `entry` = 1090;
UPDATE `quest_template` SET `MinLevel` = 17 WHERE `entry` = 1092;
UPDATE `quest_template` SET `MinLevel` = 16 WHERE `entry` = 1093;
UPDATE `quest_template` SET `MinLevel` = 23 WHERE `entry` = 5881;
UPDATE `quest_template` SET `MinLevel` = 18 WHERE `entry` = 6283;
UPDATE `quest_template` SET `MinLevel` = 14 WHERE `entry` = 6284;
UPDATE `quest_template` SET `MinLevel` = 17 WHERE `entry` = 6381;
UPDATE `quest_template` SET `MinLevel` = 14 WHERE `entry` = 6401;
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 6461;
UPDATE `quest_template` SET `MinLevel` = 17 WHERE `entry` = 6481;
UPDATE `quest_template` SET `MinLevel` = 14 WHERE `entry` = 6523;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 6629;

-- correct faction for Quest 6421 Boulderslide Ravine
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 6421;

-- correct XP for Quest 1089 The Den
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 1800 WHERE `entry` = 1089;

-- Adding the missing Blueleaf Tubers and Spellfocus. Credits for Tubers to classicdb and Cala
DELETE FROM `gameobject` WHERE `id` = 20920;
INSERT INTO `gameobject` VALUES
(632448,20920,47,2082.74,1671.82,61.2396,3.66079,0,0,0.966493,-0.256693,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632449,20920,47,2159.43,1687.49,57.5433,3.66079,0,0,0.966493,-0.256693,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632450,20920,47,2080.89,1703.36,56.6447,0.553757,0,0,0.273354,0.961913,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632451,20920,47,2055.28,1767.7,58.4559,2.98378,0,0,0.996889,0.0788245,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632452,20920,47,2196.64,1827.96,61.4706,2.11277,0,0,0.870583,0.492022,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632453,20920,47,2030.32,1867.61,56.2866,5.6777,0,0,0.298139,-0.954522,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632454,20920,47,2091.33,1861.73,51.0341,1.25355,0,0,0.586536,0.809923,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632455,20920,47,2200.15,1897.64,71.3191,2.6492,0,0,0.969846,0.243717,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632456,20920,47,2075.75,1742.04,76.7184,1.33994,0,0,0.620962,0.78384,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632457,20920,47,2126,1661.15,82.4824,0.0220437,0,0,0.0110216,0.999939,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632458,20920,47,2207.92,1596.91,80.7375,3.60582,0,0,0.973182,-0.230035,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632459,20920,47,2156.98,1542.26,72.849,2.43086,0,0,0.937519,0.347934,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632460,20920,47,2179.95,1514.06,69.0709,0.778385,0,0,0.379441,0.925216,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632461,20920,47,2000.85,1533.93,80.3971,4.919,0,0,0.630419,-0.776255,-43200,100,1);
INSERT INTO `gameobject` VALUES
(632462,20920,47,1991.49,1608.53,81.1601,1.1004,0,0,0.522858,0.85242,-43200,100,1);
DELETE FROM `gameobject` WHERE `id` = 300011;
INSERT INTO `gameobject` VALUES
(99868,300011,47,2072.84,1582.57,82.14,0,0,0,0,0,180,0,1);
INSERT INTO `gameobject` VALUES
(55538,300011,47,2064.12,1648.8,61.2081,1.30774,0,0,0.608264,0.793735,25,100,1);
INSERT INTO `gameobject` VALUES
(55539,300011,47,2105.7,1672.02,59.0945,6.13716,0,0,0.0729491,-0.997336,25,100,1);
INSERT INTO `gameobject` VALUES
(55540,300011,47,2146.11,1679.81,58.0822,0.403748,0,0,0.200506,0.979693,25,100,1);
INSERT INTO `gameobject` VALUES
(55541,300011,47,2137.09,1736.08,51.8058,2.91153,0,0,0.993391,0.114779,25,100,1);
INSERT INTO `gameobject` VALUES
(55542,300011,47,2082.86,1704.65,56.2846,3.38983,0,0,0.992307,-0.123803,25,100,1);
INSERT INTO `gameobject` VALUES
(55543,300011,47,2034.71,1730.53,60.9074,1.50488,0,0,0.683421,0.730024,25,100,1);
INSERT INTO `gameobject` VALUES
(55544,300011,47,2062.74,1773.09,57.918,0.548263,0,0,0.270711,0.962661,25,100,1);
INSERT INTO `gameobject` VALUES
(55545,300011,47,2133.34,1809.76,46.8661,1.08512,0,0,0.516328,0.856391,25,100,1);
INSERT INTO `gameobject` VALUES
(55546,300011,47,2125.36,1851.84,50.2691,3.16642,0,0,0.999923,-0.0124143,25,100,1);
INSERT INTO `gameobject` VALUES
(55547,300011,47,2067.48,1848.23,55.2606,3.16642,0,0,0.999923,-0.0124143,25,100,1);
INSERT INTO `gameobject` VALUES
(55548,300011,47,2038.78,1860.75,55.8016,2.18624,0,0,0.888067,0.459715,25,100,1);
INSERT INTO `gameobject` VALUES
(55549,300011,47,2165.94,1854.16,57.4779,5.94516,0,0,0.168208,-0.985752,25,100,1);
INSERT INTO `gameobject` VALUES
(55550,300011,47,2188.1,1819.3,62.0598,5.15976,0,0,0.532635,-0.846345,25,100,1);
INSERT INTO `gameobject` VALUES
(55551,300011,47,2014.35,1546.19,80.7209,5.08123,0,0,0.565448,-0.824784,25,100,1);
INSERT INTO `gameobject` VALUES
(55552,300011,47,2176.8,1526.98,71.5483,3.38084,0,0,0.992854,-0.119339,25,100,1);
INSERT INTO `gameobject` VALUES
(55553,300011,47,2197.64,1611.29,81.0498,0.404178,0,0,0.200716,0.979649,25,100,1);
INSERT INTO `gameobject` VALUES
(55554,300011,47,2141.6,1634.92,81.8847,5.69305,0,0,0.290805,-0.956782,25,100,1);
INSERT INTO `gameobject` VALUES
(55555,300011,47,2077.92,1740.42,77.0148,3.9102,0,0,0.92706,-0.374912,25,100,1);
DELETE FROM `creature_loot_template` WHERE `item` = 5876;
UPDATE `item_template` SET `spellcharges_1` = -5 WHERE `entry` = 5880;
UPDATE `gameobject_template` SET `data1` = 30 WHERE `entry` = 300011;
UPDATE `gameobject_template` SET `name` = 'Nearby Tubers' WHERE `entry` = 300011;

-- Added spawn and attack script for Echeyakee
DELETE FROM `dbscripts_on_event` WHERE `id` = 2980;
DELETE FROM `dbscripts_on_spell` WHERE `id` = 12189;
INSERT INTO `dbscripts_on_event` VALUES
(2980,0,10,3475,180000,0,0,0,0,0,0,0,436.258,-3058,92.434,0.68,'Summon Echeyakee');
INSERT INTO `dbscripts_on_spell` VALUES
(12189,3,26,0,0,3475,50,0,0,0,0,0,0,0,0,0,'Start Attack');

-- Fixes https://github.com/mangoszero/database/issues/102
-- http://www.wowwiki.com/Quest:A_Warning

UPDATE `creature_template` SET `gossip_menu_id`=14000, `npcflag`=3 WHERE `entry`=14494;
UPDATE `quest_template` SET `PrevQuestId`=7621 WHERE `entry`=7622;

DELETE FROM `npc_text` WHERE `id` IN (17200,17201,17202,17203,17204,17205);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `lang0`, `prob0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `lang1`, `prob1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `lang2`, `prob2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `lang3`, `prob3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `lang4`, `prob4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `lang5`, `prob5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `lang6`, `prob6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `lang7`, `prob7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`) VALUES
(17200, 'Praise the Light, one has finally answered the calling.', NULL, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0),
(17201, '<Eris nods>$BThe Eye has seen so many horrors and wonders.$BIt displays what it feels the one looking into it is most suited to see.', NULL, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0),
(17202, 'You were. The Eye is never wrong.$BYou are a $G priest:priestess; after all. A powerful $G priest:priestess;, if the Eye showed you this horrible memory.$BYou have come for redemption, yet you yourself do not realize this... Do you?', NULL, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0),
(17203, 'I know you will, $N.$BI myself am a priestess, though, unlike you I am long since gone from this world. My spirit, however, remains here, as do the spirits of the thousands who were brutally slain by the mad Prince, Arthas Menethil and his legion of undeath.', NULL, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0),
(17204, 'I never stated that you were here to redeem yourself, $G priest:priestess;. You are here to redeem me and the innocents murdered while trying to escape Stratholme.$BMy spirit and the spirit of those lost are bound here, cursed to endlessly relive our own tragic deaths.', NULL, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0),
(17205, 'You must do what I could not: Save the peasants that were cut down while fleeing from Stratholme.$BThey will walk towards the light, you must ensure their survival. Should too many fall, our cursed existence shall continue - you will have failed.$BEvery ability, prayer and spell that you have learned will be tested. May the Light protect you, $N.', NULL, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `gossip_menu` WHERE `entry` IN (14000,14001,14002,14003,14004,14005);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(14000, 17200, 0, 0),
(14001, 17201, 0, 0),
(14002, 17202, 0, 0),
(14003, 17203, 0, 0),
(14004, 17204, 0, 0),
(14005, 17205, 0, 0);

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (14000,14001,14002,14003,14004);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
(14000, 1, 0, 'The Eye led me here, Eris.', 1, 1, 14001, 0, 0, 0, 0, ' ', 0),
(14001, 1, 0, 'And I was suited to see this?', 1, 1, 14002, 0, 0, 0, 0, ' ', 0),
(14002, 1, 0, 'I really did not know what to expect, Eris. I will use my powers to assist you if that is what is asked of me.', 1, 1, 14003, 0, 0, 0, 0, ' ', 0),
(14003, 1, 0, 'Those days are over, Eris.', 1, 1, 14004, 0, 0, 0, 0, ' ', 0),
(14004, 1, 0, 'So what can I do to help?', 1, 1, 14005, 0, 0, 0, 0, ' ', 0);

-- Update doors to close in 5 seconds and torch return state 5 seconds
-- GAMEOBJECT_TYPE_DOOR = 0
-- data0: startOpen (Boolean flag)
-- data1: open (LockId from Lock.dbc)
-- data2: autoClose (65536 * seconds) (e.g. open after 5min = 19660800)
UPDATE `gameobject_template` SET `data2` = 327680 WHERE `entry` IN (177188,177189,177192,177198,179507,179508,179510,179513);

-- Update faction leaders and provide sane health values.
--
-- Description: The faction leaders currently have health points being too low.
-- Creatures:
--              - Highlord Bolvar Fordragon                     http://www.wowhead.com/npc=1748
--              - King Magni Bronzebeard <Lord of Ironforge>    http://www.wowhead.com/npc=2784
--              - Cairne Bloodhoof <High Chieftain>             http://www.wowhead.com/npc=3057
--              - Thrall <Warchief>                             http://www.wowhead.com/npc=4949
UPDATE `creature_template` SET `minhealth` = 633420, `maxhealth` = 633420 WHERE `entry` = 4949;
--              - High Tinker Mekkatorque <King of Gnomes>      http://www.wowhead.com/npc=7937
--              - Tyrand Whisperwind <High Priestess of Elune>  http://www.wowhead.com/npc=7999
--              - Lady Sylvanas Windrunner <Banshee Queen>      http://www.wowhead.com/npc=10181
--              - Vol'jin                                       http://www.wowhead.com/npc=10540

DELETE FROM `creature_template` WHERE `entry` = 15118;
INSERT INTO `creature_template` (`entry`,`modelid_1`, `name`) VALUES
(15118, 15234, 'Master Angler Form');
--              - Hook of the Master Angler    http://www.wowhead.com/item=19979

-- Remove TBC script for Lady Sylvanas Windrunner for the Lament of the Highborne
-- Creature template #10181
UPDATE `creature_template` SET `ScriptName` = NULL WHERE `entry` = 10181;

-- UPDATE Database Version
UPDATE `db_version` SET `version` = 'ZeroDatabase 2.0.9 for MaNGOSZero z2462+ and ScriptDevZero z2686+';
