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

-- fixed dropchance of item 11148 Manual Page and made them questdrop. Needed for quest 3924 Samophlange Manual
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -29 WHERE `entry` = 3283;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -27 WHERE `entry` = 3286;

-- Quest end script for quest 857 The Tear of the Moons and movement for feegly
UPDATE `creature_template` SET `MovementType` = 2 WHERE `entry` = 3421;
DELETE FROM `creature` WHERE `guid` = 14138;
INSERT INTO `creature` VALUES
(14138,3421,1,1406,0,-4217.42,-2342.11,91.73,2.13,275,0,0,860,0,0,2);
DELETE FROM `creature_movement` WHERE `id` = 14138;
INSERT INTO `creature_movement` VALUES
(14138,1,-4217.83,-2341.47,91.7458,10000,0,0,0,0,0,0,0,0,0,2.13698,0,0);
INSERT INTO `creature_movement` VALUES
(14138,2,-4219.46,-2336.15,91.8028,10000,0,0,0,0,0,0,0,0,0,2.13698,0,0);
UPDATE `quest_template` SET `CompleteScript` = 857 WHERE `entry` = 857;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 857;
INSERT INTO `dbscripts_on_quest_end` VALUES
(857,0,20,0,0,0,0,0,0,0,0,0,0,0,0,0,'Stop movement');
INSERT INTO `dbscripts_on_quest_end` VALUES
(857,1,0,0,0,0,0,0,2000000240,0,0,0,0,0,0,0,'Say 1');
INSERT INTO `dbscripts_on_quest_end` VALUES
(857,3,0,0,0,0,0,0,2000000241,0,0,0,0,0,0,0,'Text emote 1');
INSERT INTO `dbscripts_on_quest_end` VALUES
(857,6,0,0,0,0,0,0,2000000242,0,0,0,0,0,0,0,'Say 2');
INSERT INTO `dbscripts_on_quest_end` VALUES
(857,9,0,0,0,0,0,0,2000000243,0,0,0,0,0,0,0,'Text emote 2');
INSERT INTO `dbscripts_on_quest_end` VALUES
(857,10,15,5142,0,0,0,0,0,0,0,0,0,0,0,0,'cast Troggform');
INSERT INTO `dbscripts_on_quest_end` VALUES
(857,16,15,5,0,0,0,4,0,0,0,0,0,0,0,0,'Kill feegly');
DELETE FROM `db_script_string` WHERE `entry` = 2000000240;
DELETE FROM `db_script_string` WHERE `entry` = 2000000241;
DELETE FROM `db_script_string` WHERE `entry` = 2000000242;
DELETE FROM `db_script_string` WHERE `entry` = 2000000243;
INSERT INTO `db_script_string` VALUES
(2000000240,'The power of the Tear of the Moons is mine! Mine I say!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL);
INSERT INTO `db_script_string` VALUES
(2000000241,'Feegly the Exiled begins to rub the Tear of the Moons.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,NULL);
INSERT INTO `db_script_string` VALUES
(2000000242,'Power! Glorious power!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL);
INSERT INTO `db_script_string` VALUES
(2000000243,'Feegly the Exiled begins to make strange grunting noises. The Tear of the Moons drops to the ground and shatters.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,NULL);

-- Verog the dervish gets now spawned with command 47 to prevent double spawns
UPDATE `creature_ai_scripts` SET `action2_type` = 47 WHERE `action2_param1` = 3395;

-- Fixed all Bubbly fissures
DELETE FROM `gameobject_template` WHERE `entry` = 177524;
INSERT INTO `gameobject_template` VALUES
(177524,6,344,'Bubbly Fissure',0,0,0.1,0,0,8,17775,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
UPDATE `gameobject` SET `id` = 177524 WHERE `guid` = 13380;
DELETE FROM `gameobject_template` WHERE `entry` = 180057;
INSERT INTO `gameobject_template` VALUES
(180057,6,0,'Bubbly Fissure',0,0,0.1,0,0,8,17775,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');

-- Fixed several problems with quest 877 The Stagnant Oasis
UPDATE `gameobject_template` SET `flags` = 0 WHERE `entry` = 3743;
UPDATE `quest_template` SET `ReqItemId2` = 5068 WHERE `entry` = 877;
UPDATE `quest_template` SET `ReqItemCount2` = 1 WHERE `entry` = 877;
DELETE FROM `gameobject` WHERE `id` = 3743;
INSERT INTO `gameobject` VALUES
(55531,3743,1,-1280.23,-3015.37,72.0094,0.630807,0,0,0.3102,0.950671,-60,100,1);
INSERT INTO `gameobject` VALUES
(55532,3743,1,-1276.09,-3017.25,72.9672,5.71077,0,0,0.282316,-0.959321,-60,100,1);
INSERT INTO `gameobject` VALUES
(55533,3743,1,-1271.2,-3012.87,71.8351,4.22637,0,0,0.856478,-0.516183,-60,100,1);
INSERT INTO `gameobject` VALUES
(55534,3743,1,-1273.34,-3007.69,71.6012,2.15527,0,0,0.880841,0.473411,-60,100,1);
INSERT INTO `gameobject` VALUES
(55535,3743,1,-1281.12,-3010.96,71.4162,4.1227,0,0,0.882072,-0.471114,-60,100,1);
DELETE FROM `dbscripts_on_event` WHERE `id` = 525;
INSERT INTO `dbscripts_on_event` VALUES
(525,2,9,55531,60,0,0,0,0,0,0,0,0,0,0,0,'Spawn Fissure Plant');
INSERT INTO `dbscripts_on_event` VALUES
(525,2,9,55532,60,0,0,0,0,0,0,0,0,0,0,0,'Spawn Fissure Plant');
INSERT INTO `dbscripts_on_event` VALUES
(525,2,9,55533,60,0,0,0,0,0,0,0,0,0,0,0,'Spawn Fissure Plant');
INSERT INTO `dbscripts_on_event` VALUES
(525,2,9,55534,60,0,0,0,0,0,0,0,0,0,0,0,'Spawn Fissure Plant');
INSERT INTO `dbscripts_on_event` VALUES
(525,2,9,55535,60,0,0,0,0,0,0,0,0,0,0,0,'Spawn Fissure Plant');
DELETE FROM `gameobject_loot_template` WHERE `entry` = 2603;
INSERT INTO `gameobject_loot_template` VALUES
(2603,5066,100,0,1,1,0);
DELETE FROM `gameobject` WHERE `guid` = 55536;
DELETE FROM `gameobject` WHERE `guid` = 55537;
INSERT INTO `gameobject` VALUES
(55536,180057,1,-1274.37,-3012.04,72.67,0,0,0,0,0,2,100,1);
INSERT INTO `gameobject` VALUES
(55537,180057,1,89.75,-1943.77,80.02,0,0,0,0,0,2,100,1);
DELETE FROM `gameobject_template` WHERE `entry` = 211085;
DELETE FROM `gameobject_template` WHERE `entry` = 211086;

-- correct max Reputation value for quest 9267 Mending old wounds
UPDATE `quest_template` SET `RequiredMaxRepValue` = 42000 WHERE `entry` = 9267;

-- correct all reputation values Darkspear Trolls for The Barrens
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 6384;
UPDATE `quest_template` SET `RewRepValue2` = 150 WHERE `entry` = 6386;

-- correct Experience for The Barrens
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 600 WHERE `entry` = 822;
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 1980 WHERE `entry` = 1101;
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 1980 WHERE `entry` = 1109;
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 1800 WHERE `entry` = 1142;
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 1800 WHERE `entry` = 1144;
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 780 WHERE `entry` = 1145;
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 1260 WHERE `entry` = 1221;

-- correct all reputation values for The Barrens
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 819;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 821;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 822;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 843;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 844;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 845;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 846;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 848;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 849;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 850;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 851;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 852;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 853;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 855;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 858;
UPDATE `quest_template` SET `RewRepValue1` = 140 WHERE `entry` = 863;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 865;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 867;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 868;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 869;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 870;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 871;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 872;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 873;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 875;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 876;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 877;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 878;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 879;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 880;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 881;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 882;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 883;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 884;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 885;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 887;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 888;
UPDATE `quest_template` SET `RewRepFaction1` = 470 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepFaction2` = 68 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepFaction3` = 76 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepFaction4` = 81 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepFaction5` = 530 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepValue3` = 50 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepValue4` = 50 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepValue5` = 50 WHERE `entry` = 891;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 893;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 894;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 895;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 896;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 897;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 898;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 899;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 900;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 901;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 902;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 903;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 905;
UPDATE `quest_template` SET `RewRepValue1` = 200 WHERE `entry` = 906;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 907;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 913;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1060;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 1069;
UPDATE `quest_template` SET `RewRepValue1` = 200 WHERE `entry` = 1102;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 1109;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 1142;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 1144;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 1145;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1153;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1221;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 1492;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 3281;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 3301;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 3369;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 3370;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 3513;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 3514;
UPDATE `quest_template` SET `RewRepFaction1` = 470 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepFaction2` = 68 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepFaction3` = 76 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepFaction4` = 81 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepFaction5` = 530 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepValue2` = 25 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepValue3` = 25 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepValue4` = 25 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepValue5` = 25 WHERE `entry` = 3921;
UPDATE `quest_template` SET `RewRepFaction1` = 470 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepFaction2` = 68 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepFaction3` = 76 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepFaction4` = 81 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepFaction5` = 530 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepValue3` = 50 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepValue4` = 50 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepValue5` = 50 WHERE `entry` = 3922;
UPDATE `quest_template` SET `RewRepFaction1` = 470 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepFaction2` = 68 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepFaction3` = 76 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepFaction4` = 81 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepFaction5` = 530 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepValue1` = 25 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepValue2` = 10 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepValue3` = 10 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepValue4` = 10 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepValue5` = 10 WHERE `entry` = 3923;
UPDATE `quest_template` SET `RewRepFaction1` = 470 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepFaction2` = 68 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepFaction3` = 76 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepFaction4` = 81 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepFaction5` = 530 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepValue2` = 75 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepValue3` = 75 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepValue4` = 75 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepValue5` = 75 WHERE `entry` = 3924;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 4021;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 4921;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 5041;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 5052;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 6362;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 6364;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 6384;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 6386;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 6543;

-- correct minLevel and Questlevel for The Barrens
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 822;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 844;
UPDATE `quest_template` SET `MinLevel` = 17 WHERE `entry` = 846;
UPDATE `quest_template` SET `MinLevel` = 17 WHERE `entry` = 849;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 852;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 853;
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 858;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 863;
UPDATE `quest_template` SET `MinLevel` = 16 WHERE `entry` = 873;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 874;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 875;
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 876;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 880;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 881;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 883;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 884;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 885;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 888;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 889;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 890;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 892;
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 898;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 900;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 901;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 902;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 903;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 905;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 913;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 1060;
UPDATE `quest_template` SET `MinLevel` = 29 WHERE `entry` = 1102;
UPDATE `quest_template` SET `MinLevel` = 25 WHERE `entry` = 1142;
UPDATE `quest_template` SET `MinLevel` = 22 WHERE `entry` = 1144;
UPDATE `quest_template` SET `MinLevel` = 9 WHERE `entry` = 1492;
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 3261;
UPDATE `quest_template` SET `MinLevel` = 9 WHERE `entry` = 3281;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 3301;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 3369;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 3370;
UPDATE `quest_template` SET `MinLevel` = 18 WHERE `entry` = 3514;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 3921;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 3922;
UPDATE `quest_template` SET `MinLevel` = 14 WHERE `entry` = 4021;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 5042;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 5043;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 5044;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 5045;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 5046;
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 5052;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 6361;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 6385;
UPDATE `quest_template` SET `MinLevel` = 60 WHERE `entry` = 9267;
UPDATE `quest_template` SET `QuestLevel` = 60 WHERE `entry` = 9267;

-- correct Required Races for Quests in the Barrens
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` IN (860,1102);
UPDATE `quest_template` SET `RequiredRaces` = 77 WHERE `entry` = 1142;

-- fixing Quest 437 The Death Fields spawnscripts by ghurok
DELETE FROM `areatrigger_involvedrelation` WHERE `id` = 173;
INSERT INTO `areatrigger_involvedrelation` VALUES
(173, 437);
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `entry` = 437;
DELETE FROM `creature_ai_scripts` WHERE `id` = 177203;
DELETE FROM `creature_ai_scripts` WHERE `id` = 177303;
INSERT INTO `creature_ai_scripts` VALUES
(177203, 1772, 6, 0, 10, 0, 0, 0, 0, 0, 47, 1983, 1, 17, 1, 0, 0, 0, 0, 0, 0, 0, 'Rot Hide Gladerunner - On Death Spawn Nightlash');
INSERT INTO `creature_ai_scripts` VALUES
(177303, 1773, 6, 0, 10, 0, 0, 0, 0, 0, 47, 1983, 1, 17, 1, 0, 0, 0, 0, 0, 0, 0, 'Rot Hide Mystic - On Death Spawn Nightlash');
DELETE FROM `creature_ai_summons` WHERE `id` = 17;
INSERT INTO `creature_ai_summons` VALUES
(17, 1073.84, 1543.37, 28.6752, 0.174533, 300000, '1983');
DELETE FROM `creature` WHERE `guid` = 28379;

-- Spell script for spell 7669 Bethors potion
DELETE FROM `dbscripts_on_spell` WHERE `id` = 7669;
INSERT INTO `dbscripts_on_spell` VALUES
(7669,0,14,7656,1,0,0,0,0,0,0,0,0,0,0,0,'Remove Hex of Ravenclaw');
INSERT INTO `dbscripts_on_spell` VALUES
(7669,0,14,7657,1,0,0,0,0,0,0,0,0,0,0,0,'Remove Hex of Ravenclaw');

-- fixing Quest 99, 421, 422, 423, 424, 1014 Dalar Dawnweaver now using correct spell
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 99;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 421;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 422;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 423;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 424;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1014;
INSERT INTO `dbscripts_on_quest_end` VALUES
(99,0,15,1460,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(421,0,15,1460,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(422,0,15,1460,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(423,0,15,1460,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(424,0,15,1460,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(1014,0,15,1460,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');

-- fixing Quest 452 Pyrewood Ambush , Rewarded Money pre TBC and Rewarded XP pre TBC
UPDATE `quest_template` SET `RewOrReqMoney` = 1400 WHERE `entry` = 452;
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 780 WHERE `entry` = 452;

-- fixing Quest 450 A Recipe for Death, Rewarded Money pre tbc
UPDATE `quest_template` SET `RewOrReqMoney` = 1400 WHERE `entry` = 450;

-- correct all reputation values for Silverpine Forest to pre TBC
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 99;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 421;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 422;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 423;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 424;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 425;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 429;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 430;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 435;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 437;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 438;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 440;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 441;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 442;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 443;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 447;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 448;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 449;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 450;
UPDATE `quest_template` SET `RewRepValue1` = 200 WHERE `entry` = 451;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 452;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 460;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 461;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 477;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 478;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 479;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 480;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 491;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 493;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 516;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 530;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 6323;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 6324;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 1358;

-- correct minLevel for Silverpine Forest
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 99;
UPDATE `quest_template` SET `MinLevel` = 9 WHERE `entry` = 421;
UPDATE `quest_template` SET `MinLevel` = 9 WHERE `entry` = 422;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 423;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 424;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 429;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 435;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 437;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 438;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 440;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 441;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 443;
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 444;
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 446;
UPDATE `quest_template` SET `MinLevel` = 9 WHERE `entry` = 447;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 448;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 449;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 450;
UPDATE `quest_template` SET `MinLevel` = 14 WHERE `entry` = 451;
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 452;
UPDATE `quest_template` SET `MinLevel` = 13 WHERE `entry` = 461;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 479;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 480;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 481;
UPDATE `quest_template` SET `MinLevel` = 11 WHERE `entry` = 482;
UPDATE `quest_template` SET `MinLevel` = 12 WHERE `entry` = 530;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 3221;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 1358;
UPDATE `quest_template` SET `MinLevel` = 10 WHERE `entry` = 1359;

-- correct Required Races for all Quests in Silverpine Forest and two in UC which are horde only. Quest 99, 421, 422, 423, 424, 425, 428, 429, 430, 435, 437, 438, 440,
-- 441, 442, 443, 444, 446, 447, 448, 449, 450, 451, 452, 460, 461, 477, 478, 479, 480, 481, 482, 491, 493, 516, 530, 3221, 1358, 1359
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` IN (99,421,422,423,424,425,428,429,430,435,437,438,440,441,442,443,444,446,447);
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` IN (448,449,450,451,452,460,461,477,478,479,480,481,482,491,493,516,530,3221,1358,1359);

-- scripted the quest end script for quest 771 Rite of vision
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 771;
INSERT INTO `dbscripts_on_quest_end` VALUES
(771,0,15,5026,0,0,0,0,0,0,0,0,0,0,0,0,'Cast Water of seers');
INSERT INTO `dbscripts_on_quest_end` VALUES
(771,0,0,2,0,0,0,0,2000000179,0,0,0,0,0,0,0,'Text emote');
INSERT INTO `dbscripts_on_quest_end` VALUES
(771,8,0,0,3,0,0,0,2000000180,0,0,0,0,0,0,0,'Zarlman Say');
DELETE FROM `db_script_string` WHERE `entry` = 2000000179;
DELETE FROM `db_script_string` WHERE `entry` = 2000000180;
INSERT INTO `db_script_string` VALUES
(2000000179,"Zarlman Two-Moons begins chanting as he mixes the well stones and ambercom before the Tribal Fire.",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,NULL);
INSERT INTO `db_script_string` VALUES
(2000000180,"The Water of the Seers is ready for your consumption, $N.",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,3,0,NULL);

-- Fixing Quest 772 Rite of vision
UPDATE `quest_template` SET `RewSpellCast` = 0 WHERE `entry` = 772;
UPDATE `quest_template` SET `CompleteScript` = 772 WHERE `entry` = 772;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 772;
INSERT INTO `dbscripts_on_quest_end` VALUES
(772,0,15,1126,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Motw on Player');
UPDATE `creature_template` SET `MovementType` = 2 WHERE `entry` = 2983;
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 298301;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(298301,4,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'despawn self, with delay');
DELETE FROM `creature_movement_template` WHERE `entry` = 2983;
INSERT INTO `creature_movement_template` VALUES
(2983,1,-2226.32,-408.095,-9.36235,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,2,-2203.04,-437.212,-5.72498,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,3,-2163.91,-457.851,-7.09049,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,4,-2123.87,-448.137,-9.29591,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,5,-2104.66,-427.166,-6.49513,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,6,-2101.48,-422.826,-5.3567,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,7,-2097.56,-417.083,-7.16716,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,8,-2084.87,-398.626,-9.88973,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,9,-2072.71,-382.324,-10.2488,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,10,-2054.05,-356.728,-6.22468,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,11,-2051.8,-353.645,-5.35791,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,12,-2049.08,-349.912,-6.15723,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,13,-2030.6,-310.724,-9.59302,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,14,-2002.15,-249.308,-10.8124,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,15,-1972.85,-195.811,-10.6316,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,16,-1940.93,-147.652,-11.7055,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,17,-1888.06,-81.943,-11.4404,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,18,-1837.05,-34.0109,-12.258,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,19,-1796.12,-14.6462,-10.3581,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,20,-1732.61,-4.27746,-10.0213,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,21,-1688.94,-0.829945,-11.7103,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,22,-1681.32,13.0313,-9.48056,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,23,-1677.04,36.8349,-7.10318,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,24,-1675.2,68.559,-8.95384,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,25,-1676.57,89.023,-9.65104,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,26,-1678.16,110.939,-10.1782,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,27,-1677.86,128.681,-5.73869,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,28,-1675.27,144.324,-3.47916,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,29,-1671.7,163.169,-1.23098,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,30,-1666.61,181.584,5.26145,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,31,-1661.51,196.154,8.95252,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,32,-1655.47,210.811,8.38727,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,33,-1647.07,226.947,5.27755,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,34,-1621.65,232.91,2.69579,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,35,-1600.23,237.641,2.98539,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,36,-1576.07,242.546,4.66541,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,37,-1554.57,248.494,6.60377,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,38,-1547.53,259.302,10.6741,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,39,-1541.7,269.847,16.4418,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,40,-1539.83,278.989,21.0597,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,41,-1540.16,290.219,27.8247,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,42,-1538.99,298.983,34.0032,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,43,-1540.38,307.337,41.3557,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,44,-1536.61,314.884,48.0179,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,45,-1532.42,323.277,55.6667,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,46,-1528.77,329.774,61.1525,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,47,-1525.65,333.18,63.2161,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,48,-1517.01,350.713,62.4286,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,49,-1511.39,362.537,62.4539,0,0,0,0,0,0,0,0,0,0,0,0,0),
(2983,50,-1511.23,362.934,62.452,5000,298301,0,0,0,0,0,0,0,0,1.058,0,0);

-- fixing the "you learn spell" from quest window, fixing the not enough mana bug, for quest 755 Rites of the Earthmother
UPDATE `quest_template` SET `RewSpellCast` = 0 WHERE `entry` = 755;
UPDATE `quest_template` SET `CompleteScript` = 755 WHERE `entry` = 755;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 755;
INSERT INTO `dbscripts_on_quest_end` VALUES
(755,0,15,1126,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Motw on Player');

-- Fixing Quest 750 The Hunt continues Questtext
UPDATE `quest_template` SET `OfferRewardText` = "The tauren of Narache thank you for these provisions, $N. With your skill in the ways of the hunt you will surely be revered in Thunder Bluff someday." WHERE `entry` = 750;

-- Fixing Quest 747 The Hunt begins Questtext
UPDATE `quest_template` SET `OfferRewardText` = "The tauren of Narache thank you, $N. You show much promise." WHERE `entry` = 747;

-- correct all reputation values for Mulgore
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 743;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 745;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 746;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 747;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 748;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 749;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 750;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 751;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 752;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 753;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 754;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 755;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 756;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 757;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 758;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 759;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 760;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 761;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 763;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 764;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 765;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 766;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 770;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 771;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 772;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 773;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 775;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 776;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 780;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 781;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 833;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 861;
UPDATE `quest_template` SET `RewRepValue1` = 200 WHERE `entry` = 3376;

-- correct minLevel for Mulgore
UPDATE `quest_template` SET `MinLevel` = 1 WHERE `entry` = 750;
UPDATE `quest_template` SET `MinLevel` = 5 WHERE `entry` = 751;
UPDATE `quest_template` SET `MinLevel` = 4 WHERE `entry` = 754;
UPDATE `quest_template` SET `MinLevel` = 1 WHERE `entry` = 755;
UPDATE `quest_template` SET `MinLevel` = 5 WHERE `entry` = 756;
UPDATE `quest_template` SET `MinLevel` = 5 WHERE `entry` = 758;
UPDATE `quest_template` SET `MinLevel` = 7 WHERE `entry` = 759;
UPDATE `quest_template` SET `MinLevel` = 7 WHERE `entry` = 760;
UPDATE `quest_template` SET `MinLevel` = 3 WHERE `entry` = 763;
UPDATE `quest_template` SET `MinLevel` = 5 WHERE `entry` = 765;
UPDATE `quest_template` SET `MinLevel` = 5 WHERE `entry` = 766;
UPDATE `quest_template` SET `MinLevel` = 4 WHERE `entry` = 772;
UPDATE `quest_template` SET `MinLevel` = 4 WHERE `entry` = 773;
UPDATE `quest_template` SET `MinLevel` = 6 WHERE `entry` = 775;
UPDATE `quest_template` SET `MinLevel` = 7 WHERE `entry` = 776;
UPDATE `quest_template` SET `MinLevel` = 3 WHERE `entry` = 781;

-- correct Required Races for Quests in Mulgore which are horde only. Quest 743, 745, 746, 749, 750, 751,
-- 752, 753, 755, 757, 761, 763, 764, 765, 766, 767, 770, 771, 772, 773, 775, 776, 780, 781, 833, 861, 1656, 3376
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` IN (743,745,746,749,750,751,752,753,755,757,761,763,764,765,766,767,770,771,772,773,775,776,780,781,833,861,1656,3376);

-- Added Quest start script for quest 804 Sarkoth and removed wrong start script from quest 790 sarkoth part 1
UPDATE `quest_template` SET `CompleteEmote` = 0 WHERE `entry` = 790;
UPDATE `quest_template` SET `StartScript` = 0 WHERE `entry` = 790;
UPDATE `quest_template` SET `StartScript` = 804 WHERE `entry` = 804;
DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 790;
DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 804;
INSERT INTO `dbscripts_on_quest_start` VALUES
(804,2,28,8,0,0,0,0,0,0,0,0,0,0,0,0,'Hana zua Kneel');
INSERT INTO `dbscripts_on_quest_start` VALUES
(804,3,0,0,0,0,0,0,2000005017,0,0,0,0,0,0,0,'Hana zua say');
INSERT INTO `dbscripts_on_quest_start` VALUES
(804,7,28,7,0,0,0,0,0,0,0,0,0,0,0,0,'Hana zua death state');

-- scripted the quest end script for quest 808 Minshinas Skull
UPDATE `creature_template` SET `MovementType` = 0 WHERE `entry` = 3289;
UPDATE `quest_template` SET `CompleteScript` = 808 WHERE `entry` = 808;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 808;
INSERT INTO `dbscripts_on_quest_end` VALUES
(808,0,10,3289,20000,0,0,0,0,0,0,0,-823.88,-4924.51,19.71,1.89,'Summon Minshinas Ghost');
INSERT INTO `dbscripts_on_quest_end` VALUES
(808,1,0,0,0,0,0,0,2000000808,0,0,0,0,0,0,0,'Gadrin Say');
INSERT INTO `dbscripts_on_quest_end` VALUES
(808,3,1,2,0,3289,20,0,0,0,0,0,0,0,0,0,'Minshina Bow');
DELETE FROM `db_script_string` WHERE `entry` = 2000000808;
INSERT INTO `db_script_string` VALUES
(2000000808,"I thank you. $n. And my brother thanks you.",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,NULL);

-- Quest 842 Crossroads Conscription Offer Reward text fixed. removing $ sign
UPDATE `quest_template` SET `OfferRewardText` = "Alright, $n. You want to earn your keep with the Horde? Well there's plenty to do here, so listen close and do what you're told.$B$B$GI see that look in your eyes, do not think I will tolerate any insolence. Thrall himself has declared the Hordes females to be on equal footing with you men. Disrespect me in the slightest, and you will know true pain.:I'm happy to have met you. Thrall will be glad to know that more females like you and I are taking the initiative to push forward in the Barrens.;" WHERE `entry` = 842;

-- Quest 809 Ak Zeloth removing wrong objective text
UPDATE `quest_template` SET `EndText` = "" WHERE `entry` = 809;
UPDATE `quest_template` SET `ObjectiveText1` = "" WHERE `entry` = 809;

-- SILVERPINE FIXES START HERE

-- The Hunt Begins (747) correct OfferRewardText. Thanks Ghurok.
UPDATE `quest_template` SET `OfferRewardText`='The Tauren of Narache thank you, $N. You show much promise.' WHERE `entry`=747;

-- The Hunt Continues (750) correct OfferRewardText. Thanks Ghurok.
UPDATE `quest_template` SET `OfferRewardText`='The Tauren of Narache thank you for these provisions, $N. With your skill in the ways of the hunt you will surely be revered in Thunder Bluff someday.' WHERE `entry`=750;

-- Change npcflag for Ayanna Everstride (3596). Thanks Ghurok.
UPDATE `creature_template` SET `npcflag`=19 WHERE `entry`=3596;

-- Item Westfall Stew Recipe (2832) correct page_text. Thanks Ghurok.
UPDATE `page_text` SET `text`='Westfall Stew$B$B3 parts Stringy Vulture Meat$B3 Goretusk Snouts$B3 Murloc Eyes$B3 Okra$B$BMix together and bring to a boil.  Let simmer for at least two hours before serving.' WHERE `entry`=213;

-- Add gossip flag to Zargh (3489). Thanks Ghurok.
UPDATE `creature_template` SET `npcflag`=7 WHERE `entry`=3489;

-- Despawn object Blood Filled Orb from Ragefire Chasm. Didn't exist in 1.12.1. Thanks Therilith.
DELETE FROM `gameobject` WHERE `id`=182024;

-- Despawn object Mudsprocket (sign). Didn't exist in 1.12.1. Thanks Therilith.
DELETE FROM `gameobject` WHERE `id`=186241;

-- Despawn object Brackenwall Village (sign). Didn't exist in 1.12.1. Thanks Therilith.
DELETE FROM `gameobject` WHERE `id`=186241;

-- Add mount to a specific Warsong Outrider (12864). Thanks Ghurok.
UPDATE `creature_addon` SET `mount`=2326 WHERE `guid`=52348;

-- Remove RequestItemsText from quest Speak with Gramma (111). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`="" WHERE `entry`=111;

-- Tinkmaster Overspark (2923) correct OfferRewardText. Thanks Ghurok.
UPDATE `quest_template` SET `OfferRewardText`="Yes it's true. Techbot has gone rogue! Please, can you help me?" WHERE `entry`=2923;

-- Set RequiredRaces to Troll only for quest Simple Table (3065). Thanks Ghurok.
UPDATE `quest_template` SET `RequiredRaces`=128 WHERE `entry`=3065;

-- Remove quest Touch of Weakness (5659) from being available in-game. Thanks Ghurok.
DELETE FROM `creature_questrelation` WHERE `id`=2129 AND `quest`=5659;

-- Remove Urok Doomhowl from always being spawned in LBRS. Thanks Ghurok.
DELETE FROM `creature` WHERE `guid`=44457;

-- Rot Hide Mongrel (1675) and Maggot Eye (1753) will no longer cast Curse of Thule (3237) on themselves. Thanks Ghurok.
UPDATE `creature_ai_scripts` SET `action1_param2`=1 WHERE `id`=167502;
UPDATE `creature_ai_scripts` SET `action1_param2`=1 WHERE `id`=175302;

-- Add gossip to npc Itharius (5353) for quest chain. Thanks Ghurok.
SET @CONDITION_ENTRY                   = 719;

UPDATE `creature_template` SET `gossip_menu_id`=1341 WHERE `entry`=5353;

DELETE FROM `conditions` WHERE `condition_entry`=@CONDITION_ENTRY;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
(@CONDITION_ENTRY, 2, 10455, 1);

DELETE FROM `gossip_menu` WHERE `entry` IN (1366, 1365, 1364, 1363, 1341);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(1366, 1997),
(1365, 1998),
(1364, 1999),
(1363, 1996),
(1341, 1995);

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (1366, 1365, 1364, 1341);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_script_id`, `condition_id`) VALUES
(1366, 0, 'What happened to him in the first place?  When I... encountered him, he was rather malicious.', 1, 1, 1365, 0, 0),
(1365, 0, 'I possess part of Eranikus\' essence.  What do you want with it... or with me?', 1, 1, 1364, 0, 0),
(1364, 0, 'I will consider what you have told me.', 1, 1, -1, 1364, 0),
(1341, 1, 'Do you know someone... or something, rather, by the name of Eranikus?', 1, 1, 1366, 0, @CONDITION_ENTRY),
(1341, 0, 'What\'s an elf like you doing inside a cave like this?', 1, 1, 1363, 0, 0);

DELETE FROM `dbscripts_on_gossip` WHERE `id`=1364;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `comments`) VALUES
(1364, 0, 15, 12578, 'cast Create Oathstone of Ysera\'s Dragonflight');

-- Add gossip to object Altar of Suntara (148498). Script still missing however. Thanks Ghurok.
SET @CONDITION_ENTRY                   = 720;
SET @CONDITION_QUESTTAKEN              = 9;
SET @QUEST_RISE_OBSIDION               = 3566;

DELETE FROM `conditions` WHERE `condition_entry`=@CONDITION_ENTRY;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`) VALUES
(@CONDITION_ENTRY, @CONDITION_QUESTTAKEN, @QUEST_RISE_OBSIDION);

DELETE FROM `gossip_menu` WHERE `entry`=1282;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(1282, 1918);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=1282;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `condition_id`) VALUES
(1282, 0, 0, 'Touch the Suntara stone and call forth Lathoric the Black and his guardian, Obsidion.', 1, 1, @CONDITION_ENTRY);

-- Set RequiredRaces to Horde for quest The Lost Report (1238). Thanks Ghurok.
UPDATE `quest_template` SET `RequiredRaces`=178 WHERE `entry`=1238;

-- Set RequiredRaces to 0 for quest In Eranikus' Own Words (3512). Thanks Ghurok.
UPDATE `quest_template` SET `RequiredRaces`=0 WHERE `entry`=3512;

-- Add gossip to npc Roberto Pupellyverbos (277). Thanks Ghurok.
UPDATE `creature_template` SET `gossip_menu_id`=685, `npcflag`=5 WHERE `entry`=277;

-- Add gossip to npc Elaine Trias (483). Thanks Ghurok.
UPDATE `creature_template` SET `gossip_menu_id`=685, `npcflag`=5 WHERE `entry`=483;

-- Add script to quest Freed from the Hive (4265). Thanks Ghurok.
SET @DB_SCRIPT_STRING1=2000005395;
SET @DB_SCRIPT_STRING2=2000005396;

DELETE FROM `dbscripts_on_quest_start` WHERE `id`=4265;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(4265, 1, 10, 9546, 12000, 0, 0, 0, 0, 0, 0, 0, -5323.11, 431.63, 12.11, 3.6, 'Spawn/despawn Raschal the Courier'),
(4265, 2, 0, 0, 0, 9546, 30, 0, @DB_SCRIPT_STRING1, 0, 0, 0, 0, 0, 0, 0, 'Raschal the Courier Gossip 1'),
(4265, 2, 1, 64, 0, 9546, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Emote Stun - Raschal the Courier'),
(4265, 6, 1, 0, 0, 9546, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Emote None - Raschal the Courier'),
(4265, 7, 0, 0, 0, 9546, 30, 0, @DB_SCRIPT_STRING2, 0, 0, 0, 0, 0, 0, 0, 'Raschal the Courier Gossip 2'),
(4265, 7, 1, 1, 0, 9546, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Emote Talk - Raschal the Courier'),
(4265, 12, 1, 2, 0, 9546, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Emote Bow - Raschal the Courier'),
(4265, 14, 7, 4265, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Complete quest objective');

DELETE FROM `db_script_string` WHERE `entry` IN (@DB_SCRIPT_STRING1, @DB_SCRIPT_STRING2);
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES
(@DB_SCRIPT_STRING1, 'Oh man, I thought I was dead for sure. Ugh... still dizzy...'),
(@DB_SCRIPT_STRING2, 'I can get back to the Stronghold on my own, I think. Now that you bought me some time, I should be able to stealth out of here. Who ever you are... thank you. May Elune bless you always!');

-- Improve the position of Andruin Wrynn, Highlord Bolvar Fordragon and Lady Katrana Prestor. Thanks Ghurok.
UPDATE `creature` SET `position_x`='-8439.71', `position_y`='331.023', `position_z`='122.579',`orientation`='2.34047' WHERE `id`=1747;
UPDATE `creature` SET `position_x`='-8439.98', `position_y`='329.392', `position_z`='122.579',`orientation`='2.293' WHERE `id`=1748;
UPDATE `creature` SET `position_x`='-8437.94', `position_y`='331.014', `position_z`='122.579',`orientation`='2.34047' WHERE `id`=1749;

-- Add gossip to npc Koma (3318). Thanks Ghurok.
UPDATE `creature_template` SET `gossip_menu_id`=1623, `npcflag`=257 WHERE `entry`=3318;

-- Despawn the Burning Felhound (10261) in Blackrock Spire. Should only be spawned when summoned. Thanks Ghurok.
DELETE FROM `creature` WHERE `id`=10261;

-- Add gossip to npc Salfa (11556). Thanks Ghurok.
UPDATE `creature_template` SET `gossip_menu_id`=3624 WHERE `entry`=11556;

-- Make npc Precious (14528) not fall through the ground. Temporary fix, should patrol instead. Thanks Ghurok.
UPDATE `creature` SET `position_z`='-265.614' WHERE `id`=14528;

-- Spawn two missing npc Horde Warbringer (15350). Thanks Ghurok.
SET @GUID1 = 151178;
SET @GUID2 = 151179;

DELETE FROM `creature` WHERE `guid` IN (@GUID1, @GUID2);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID1, 15350, 0, 15387, 0, 382.39, -983.139, 109.899, 2.7861, 300, 0, 0, 2148, 0, 0, 0),
(@GUID2, 15350, 1, 15387, 0, 1026.63, -2110.69, 123.007, 5.84961, 300, 0, 0, 2148, 0, 0, 0);

-- Spawn one missing npc Alliance Brigadier General (15351). Thanks Ghurok.
SET @GUID = 151180;

DELETE FROM `creature` WHERE `guid` IN (@GUID);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID, 15351, 0, 15389, 0, -1231.51, -2510.64, 23.053, 4.4196, 300, 0, 0, 3857, 0, 0, 0);

-- Add gossip_menu for object Tablet of Theka (142715). Thanks Ghurok.
DELETE FROM `gossip_menu` WHERE `entry`=1053;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(1053, 1653);

-- Add gossip_menu for object Catalogue of the Wayward (176192). Thanks Ghurok.
DELETE FROM `gossip_menu` WHERE `entry`=3083;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(3083, 3815);

-- Correct page_text for item The Collector's Schedule (2223). Thanks Ghurok.
UPDATE `page_text` SET `text`='Below is the process and schedule of Defias gold collection from the mines of Elwynn to our headquarters in Westfall.$B$BCollection Schedule:$B$BSunday: 12:30pm$BWednesday: 12:30pm$B$BBy each specified day, gold gained from the Elwynn mines will be gathered at the Brackwell pumpkin patch.  The agent in charge of these gatherings, \"The Collector,\" will be known by the engraved ring he possesses.  A ring I gave him. ' WHERE `entry`=79;
UPDATE `page_text` SET `text`='A party from Defias headquarters will contact the Collector, after which he will transfer the gathered gold.$B$BBe sure this process is performed without fail and with utmost discretion.  The Collector is responsible for the transfer of gold, but ultimately it is the responsibility of each member of the Defias Brotherhood to ensure that his role is acted out with attention and discipline. ' WHERE `entry`=250;
UPDATE `page_text` SET `text`='Remember, my brothers, we were once proud craftsmen.  We\'ll perform our current duties with the same precision we used in our past trade.$B$B-EVC ' WHERE `entry`=251;

-- Correct page_text for item Deathstalker Report (3252). Thanks Ghurok.
UPDATE `page_text` SET `text`='Deathstalker Mission Report$B$BAgents: Rane Yorick, Quinn Yorick, Erland McKree$B$BPrimary mission: perform reconnaissance through northern silverpine, and determine threat levels of wildlife and Scourge. ' WHERE `entry`=380;
UPDATE `page_text` SET `text`='Agents commenced sweep, finding significant worg presence.  Recommend hunting squads dispatched to reduce this threat.$B$BUndead gnolls were found at the farm steading dubbed The Dead Field.  Their purpose at the farm is not known, though their movements and level of readiness suggest imminent military action.  In the time they were observed, no notable leaders were found among the gnolls.  It is assumed they await the arrival of leadership or reinforcements. ' WHERE `entry`=381;
UPDATE `page_text` SET `text`='Continuing the sweep, our agents were detained at Ivar\'s farm.  Ivar, most of his family and his workers had succumbed to the Scourge and become its minions.$B$BOur agents were attacked and although successful in defeating their ambushers, they sustained serious injuries, particularly agent Quinn. ' WHERE `entry`=382;
UPDATE `page_text` SET `next_page`=386, `text`='A defensive position was taken in Ivar\'s old house, and while Rane kept watch for future attacks, Erland continued the reconnaissance mission.$B$BErland was then pinned by Worgs in a northern orchard, only escaping with the aid of another Forsaken agent.  That agent is the bearer of this report. ' WHERE `entry`=383;
UPDATE `page_text` SET `text`='It should be noted here that this report bearer was instrumental in not only the success of our mission, but also in the defeat of Ivar the Foul, the rescue of Erland, and the deliverance of this report.$B$BWe extend our gratitude, and recommend that command acknowledges this individual with awards befitting such meritorious conduct as was displayed in the field.$B$B-Deathstalker Rane Yorick,$BMission Leader ' WHERE `entry`=386;

-- Correct page_text for item Covert Ops Plans Alpha & Beta (5737). Thanks Ghurok.
UPDATE `page_text` SET `text`='Okay, you should have your NG-5 charges and detonators ready. I\'ve labeled them for you... Blue is for the lumber mill. Red is for Windshear Mine.$B$BI did some scouting, and there are enough explosives throughout Windshear Crag that it shouldn\'t be a problem at all for you to get in, plant the explosives, and then get out before detonating them.$B$BRemember, this is a distraction. Get far from the wagons before the goblins get there to check out what happened, then sneak in behind them. ' WHERE `entry`=417;
UPDATE `page_text` SET `text`='Be careful with them by the way. The Nitromirglyceronium alone could reduce you to dust. I\'ve encased some of the liquid in copper tubes which should keep it stable and safe.$B$BThe scroll you got from Collin I used on the detonator boxes. They will now send a silent message to the NG-5 charges after you\'ve set them. I used a simple Stalthwargon mechanism to make sure the wire conductivity is optimal and the flow of the Nitroglyceronium between the differential fluid is better than average. ' WHERE `entry`=418;
UPDATE `page_text` SET `text`='Before I get back into the details about my design, let me explain where you should place the explosives.$B$BPlan Alpha- the lumber mill:$BThere\'s a wagon out in front of the lumber mill (this is northeast of their deforestation and lumber collection construct). I suspect the engineering plans are inside of the lumber mill.$B$BTo plant the charge, head to the back of the wagon. Once it\'s set, make haste and get some distance. ' WHERE `entry`=419;
UPDATE `page_text` SET `text`='When you\'re ready, hit the detonator.$B$BI\'ve ensured a strong signal by routing copper and silver wires with a Melthusian antenae array within the casing of the box. That should give you good range. Just be careful of the goblins nearby. They won\'t appreciate my creation if they catch you in their site.$B$BOh, just in case it wasn\'t obvious, don\'t be near the wagon when it blows... it\'ll hurt. ' WHERE `entry`=420;
UPDATE `page_text` SET `text`='Plan Beta- Windshear Mine:$B$BI saw the goblins using another wagon of explosives north of the mine\'s entrance. I think that should be a good enough place to plant NG-5 Charge (Red). After you set the charge in the back of the wagon, get some distance and hit the button.$B$BIf the goblins don\'t come running to check out the commotion, it\'s probably because the mountain came down on top of their heads. ' WHERE `entry`=421;
UPDATE `page_text` SET `text`='The Venture Co. Letters are outside the mine... I think on some crates on the bottom level.$B$BGood luck, and remember...$B$BBlue Charge: lumber mill$BRed Charge: mine$B$BOh, and destroy this letter after you\'ve accomplished your mission. Hmm, maybe I should look into a way to make these things destroy themselves after they\'re read. That\'s not a bad idea...' WHERE `entry`=422;

-- Correct page_text for item Quel'Thalas Registry (15847). Thanks Ghurok.
UPDATE `page_text` SET `text`='Entry Date: Unknown$B$BName: Nathanos Marris, Human Ranger Lord of Lordaeron.$B$BEntry:$B$BKael\'thas Sunstrider\'s dissention in regards to my decision to allow Nathanos Marris into the order is noted. It should also be noted that Nathanos - although a human - is one of the most gifted rangers I have ever had the pleasure of training.$B$B(continued)' WHERE `entry`=2431;
UPDATE `page_text` SET `text`='For millennia we have isolated ourselves from outsiders. I will be the first among us to admit that mistakes were made in the past. Humans should have never been exposed to magic. I will not deny this but I will not condemn us to this guarded existance for the blunders of our predecessors. There is much that a coexistance between the Quel\'dorei and other races of this world can bring. We must practice tolerance.$B$B(continued)' WHERE `entry`=2471;
UPDATE `page_text` SET `text`='It is with these words, then, that I deny Kael\'s request in regards to Nathanos Marris. He will prove to be an invaluable ally. Mark my words.$B$BSigned,$B$BSylvanas Windrunner$BRanger General of Silvermoon' WHERE `entry`=2472;

-- Item Iron Pommel (5519) remove drop from creature, add drop to object. Thanks Ghurok.
DELETE FROM `creature_loot_template` WHERE `entry`=3928 AND `item`=5519;
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry`=2971 AND `item`=5519;

-- Remove RequestItemsText from quest Hamuul Runetotem (1489). Thanks Ghurok.
UPDATE `quest_template` SET `RequestItemsText`='' WHERE `entry`=1489;

-- Correct OfferRewardText for quest The Tome of Valor (1649). Thanks Ghurok.
UPDATE `quest_template` SET `OfferRewardText`='Ah, you wish to petition me for a test of valor. Splendid.$B$BThere are many tasks throughout the city and surrounding lands that hold much challenge, and they could use a $G man:woman; with your skills.$B$BThis test should not be taken lightly, $N. This, like many things along our path, could take our lives. The Church always wishes to bolster its ranks, but it understands the sacrifices needed to ensure the paladins serving it are worthy.$B$BAre you prepared?' WHERE `entry`=1649;

-- Correct RequestItemsText for quest Agamand Heirlooms (1821). Thanks Ghurok.
UPDATE `quest_template` SET `RequestItemsText`='Do you have the heirlooms, $N?' WHERE `entry`=1821;

-- Correct OfferRewardText for quest Nether-lace Garment (1946). Thanks Ghurok.
UPDATE `quest_template` SET `OfferRewardText`='Here is your nether-lace, $N.  It is both comfortable and durable, and holds the magic of the laughing sisters\' hair.$B$BEnjoy, and if you find it amenable, please mention so to Deino.  She is a mage on whose good side I wish to stay...' WHERE `entry`=1946;

-- Add gossip to npc Herbalist Pomeroy (1218). Thanks Ghurok.
UPDATE `creature_template` SET `gossip_menu_id`=7691 WHERE `entry`=1218;

-- Add gossip to npc Lisbeth Schneider (1299). Thanks Ghurok.
UPDATE `creature_template` SET `gossip_menu_id`=685, `npcflag`=16389 WHERE `entry`=1299;

-- Correct OfferRewardText for quest The Woodland Protector (458). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='I see you found me, young $R. Melithar is a wise druid to have sent you.' WHERE `entry`=458;

-- Correct OfferRewardText for quest The Woodland Protector (459). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='Your service to the creatures of Shadowglen is worthy of reward, $N.$B$BYou confirmed my fears, however. If the grells have become tainted by the Fel Moss, one can only imagine what has become of the Gnarlpine tribe of furbolgs who once lived here.$B$BShould you find yourself in Dolanaar, able $C, seek out the knowledgeable druid, Athridas Bearmantle. He shares our concern for the well being of the forest.' WHERE `entry`=459;

-- Correct OfferRewardText for quest Bartolo's Yeti Fur Cloak (565). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='Now it is time for the great Bartolo to work his magic! I require no wizard\'s staff, no mage\'s rod. For I, the great Bartolo, work magic with a mere needle and thread!' WHERE `entry`=565;

-- Correct RequestItemsText for quest Foul Magics (673). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='The burning in my blood... it grows by the day. The warlock must be stopped.' WHERE `entry`=673;

-- Correct RequestItemsText for quest Blood of Innocents (1066). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='Did you find the Syndicate Shadow Mages, and collect from them the blood?' WHERE `entry`=1066;

-- Correct OfferRewardText for quest Alliance Relations (1431). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='$N, noble $C. I am Keldran, student of magic... and other mystical arts.$B$BThe business Craven sent you here to speak to me about requires a touch more subtlety than you\'ve previously needed, but that does not mean you can not still aid our cause.$B$BPlease, make yourself comfortable, and I shall tell you why the Warchief has need of my aid... and yours.$B$BIt starts with appearances, $N. How the Horde sees itself. How our allies see us. And most importantly, how our enemies see us.' WHERE `entry`=1431;

-- Correct OfferRewardText for quest Beginnings (1599). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='Very good, very good! You\'ve done well, $N. Perhaps the interest that is being shown in you is deserved, after all.$B$BThat\'ll be for the others to decide--assuming your imp doesn\'t overpower you and nip your career in the bud. For now, I\'m satisfied that you\'ll probably survive your first few months as a $C.$B$BA word about the imp, $N. As a $R knows, don\'t let its size fool you, its magic can be very dangerous.' WHERE `entry`=1599;

-- Correct RequestItemsText for quest Vejrek (1678). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='Have you been to Vejrek\'s hut, $N? Is that troll stink I smell on you?' WHERE `entry`=1678;

-- Correct OfferRewardText for quest Elanaria (1684). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='I bid you greetings, $N. Your name rings loudly in Darnassus, for you show promise. But we shall soon see if you possess the strength of will to follow the path of the warrior.' WHERE `entry`=1684;

-- Correct required objectives (and text) for quest Job Opening: Guard Captain of Revantusk Village (7862). Thanks Therilith.
UPDATE `quest_template` SET `ReqCreatureOrGOCount1`=20, `ReqCreatureOrGOCount2`=20, `ReqCreatureOrGOCount3`=20, `ReqCreatureOrGOCount4`=20, `Objectives`='You have been tasked with the decimation of 20 Vilebranch Berserkers, 20 Vilebranch Shadow Hunters, 20 Vilebranch Blood Drinkers, and 20 Vilebranch Soul Eaters.$B$BShould you complete this task, return to Primal Torntusk at Revantusk Village in the Hinterlands.' WHERE `entry`=7862;

-- Correct OfferRewardText for quest Da Voodoo (8413). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='It\'s about time this troll got a full night\'s rest! The spirit totem will watch over me.$B$BI been a long time collectin\' things, maybe you want somethin\' for all your trouble?' WHERE `entry`=8413;

-- Correct RequestItemsText for quest The Alliance Needs More Rainbow Fin Albacore! (8525). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='What! You again? Well I\'ll be a monkey\'s uncle... except that I\'m a gnome. Slicky Gastronome to be precise! So you\'re back to help out again, eh? Well, I can\'t say as I blame you. Don\'t you just love the smell of all of that food? <drool>$B$BEnough loitering! Get out there and bring me back more rainbow fin albacore!' WHERE `entry`=8525;

-- Horde will now spawn at Kharanos instead of Wetlands when dying in Dun Morogh or Ironforge
UPDATE `game_graveyard_zone` SET `faction`=0 WHERE `id`=101 AND `ghost_zone`=1;

-- Correct OfferRewardText for quest Thwarting Kolkar Aggression (786). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='The Horde would surely prevail if the Kolkar centaurs were to attack. But by preventing such an attack. we have spared our mighty warriors unnecessary bloodshed.$B$BAnd as sure as there is sand in the Tanaris desert, we know that there will be blood spilled before these trying times are through.$B$BYou have served your people well, $C.' WHERE `entry`=786;

-- Correct OfferRewardText for quest The Hunter's Way (861). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='Skorn Whitecloud is a wise tauren. He has hunted for years and years, and although his body is old, his spirit burns fiercely. We are honored to have him with us.$B$BIf Skorn sent you to me, then you too must have the hunter\'s spirit. And to have gathered these claws shows your burgeoning skills.$B$BPerhaps you are ready to walk the path.' WHERE `entry`=861;

-- Correct OfferRewardText for quest Crown of the Earth (933). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='Shan\'do Stormrage never returned, and the druids were in disarray, and to this day we still do not know what became of him. With Malfurion missing, Arch Druid Fandral Staghelm took over the leadership of the druids, convincing the Circle of Ancients in Darkshore that it was time for our people to rebuild, and that it was time for our people to regain their immortality.$B$BWith the approval of the Circle, Staghelm and the most powerful druids grew Teldrassil, the new World Tree.' WHERE `entry`=933;

-- Correct RequestItemsText for quest Crown of the Earth (934). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='Along with the druids, the Oracle Tree and the Arch Druid have been carefully monitoring the growth of Teldrassil. But though we have a new home, our immortal lives have not been restored.', `OfferRewardText`='To be in the presence of the Oracle Tree... it is almost to feel wisdom take form. Let me continue the telling...$B$BWith Teldrassil grown, the Arch Druid approached the dragons for their blessings, as the dragons had placed upon Nordrassil in ancient times. But Nozdormu, Lord of Time, refused to give his blessing, chiding the druid for his arrogance. In agreement with Nozdormu, Alexstrasza also refused Staghelm, and without her blessing, Teldrassil\'s growth has been flawed and unpredictable...' WHERE `entry`=934;

-- Correct RequestItemsText for quest Teldrassil (940). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='Hmm... You come with the spirit of the forest strongly within you, $C. What business do you have with the Arch Druid of the Kaldorei?' WHERE `entry`=940;

-- Correct OfferRewardText for quest Grove of the Ancients (952). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='Ah. Thank you, $N. It is strange, though. The Arch Druid always seems in such a hurry. The forest knows that all shall come to pass in the appointed time. Shan\'do Stormrage understood that.' WHERE `entry`=952;

-- Correct OfferRewardText for quest Frostmaw (1136). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='Both strength and cunning were needed to find and defeat Frostmaw, $N. You have both.$B$BYour path has taken you to the valleys of Thousand Needles and to the high mountains of Alterac. It will one day lead you through all the Earthmother\'s lands, for such is the way of the hunter.' WHERE `entry`=1136;

-- Correct OfferRewardText for quest Report to Jennea (1919). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='$N, I have a mission for you, here in the Mage district. Listen closely, for there is no time to waste.' WHERE `entry`=1919;

-- Correct OfferRewardText for quest Necklace Recovery (2284). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='You seem to have found the remains of the paladin that Dran had mentioned from before. Searching the remains uncovers what would appear to be his journal. The book is in poor condition, as dried blood has stained most of the text in the book. What you can read, however, is gibberish; it is written in the native tongue of the humans, to the best of your knowledge.$B$BYou will need the book translated if you are to glean any knowledge from it.' WHERE `entry`=2284;

-- Correct OfferRewardText for quest Simple Parchment (2383). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='Ah, that\'s my parchment. I heard you\'d be coming to the Valley, $N. I\'m glad to see you made it--let\'s hope you survive the trials ahead. Like I said, as you gain in power, come to me--I will do what I can to train you in the ways of the warrior.$B$BGood luck, $N, and return to me whenever you feel ready.' WHERE `entry`=2383;

-- Correct OfferRewardText for quest Simple Tablet (3065). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='You\'ll find this place fitting as you continue to train in the warrior ways. If you have any questions, feel free to ask anyone around, and when you feel you\'re ready, come back to me for training. I\'ve mastered as much as any warrior here in the Valley and can pass that knowledge on to you... for a price.' WHERE `entry`=3065;

-- Correct RequestItemsText for quest Etched Tablet (3082). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='Jen\'shan see a mighty $C before her and da spirits approve.$B$BDa path of da $C is one of our oldest walks of life. Da Horde turned to us when they be just strugglin\' to survive on Azeroth, and they ask us to teach them, to show them the secrets of many tings. They were strong already: strong in shaman ways; strong in warrior ways. But the hunter path not be their path... then.', `OfferRewardText`='Now we teach them those things, and they teach us others. We become one race... almost. We be allies for long time now. So you remember to help them. And Jen\'shan remember to help you.$B$BJen\'shan teach you da ways of the hunter--teach you good. You never forget, $C\'s be respected greatly by da tribe. You be havin\' a large role to play in da future... you never forget that.$B$BWhen you feel da need, come to Jen\'shan. She teach you as much as she can when she feel you ready.' WHERE `entry`=3082;

-- Correct RequestItemsText for quest Betrayed (3504). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='Ah, Belgrom wizened up and finally sent someone not in his ranks to aid us, did he?$B$BThis camp used to be a dozen warriors strong, $N, but now they\'re all dead. That mage, Rimtori, has slain them all. She played Belgrom like a lute... seduced him even. It\'s none of my business, but between you and I, she is quite the temptress. That\'s probably why I\'m still out here helping Belgrom--I probably would have done the same thing.' WHERE `entry`=3504;

-- Correct OfferRewardText for quest Betrayed (3507). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='HAHA! Look at you now, pathetic woman! I spit on your remains!$B$BThank you, $N. Thank you from the bottom of my heart! This is indeed a great day!$B$BI would give you a kingdom if it were in my power! But perhaps you will settle for this.$B$B<Belgrom looks down at the head of the mage who had betrayed him.>$B$BHaha! Stupid blood elf, look at you now... in a burlap sack and missing your body! You should never have betrayed Belgrom!' WHERE `entry`=3507;

-- Correct RequestItemsText for quest Morrowgrain Research (3785). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='Yes $N, have you grown some morrowgrain for the Arch Druid\'s important research? The mysterious properties of Un\'Goro Crater become clearer with each passing day, thanks to the help you are giving us.', `OfferRewardText`='Well done $N, I will be sure to give these to the Arch Druid himself when he has need of them. Meanwhile, please accept this as a token of the Cenarion Circle\'s appreciation.$B$BOur need for morrowgrain, for now, is constant; if you wish to continue aiding us, then please return when you have cultivated more of it.' WHERE `entry`=3785;

-- Correct OfferRewardText for quest Arikara (5088). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='This does not make sense. Why would Arikara be after Cairne Bloodhoof? Magatha could not be wrong, she is our most powerful shaman.$B$B<Motega shakes his head.>$B$BRegardless, your great deed to the Horde shall not go unnoticed - please, choose one of these as a reward for your aid.' WHERE `entry`=5088;

-- Correct OfferRewardText for quest Retribution of the Light (5204). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='You gather the paladin\'s remains as carefully as you can, recalling that at least his spirit has been released from any pain or suffering that might have been forced upon him.' WHERE `entry`=5204;

-- Correct OfferRewardText for quest Body and Heart (6001). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='You have finally taken your large step into a much larger world, $N. I sense the teaching of the Great Bear Spirit within you, and I sense that you have received the strength that Lunaclaw possessed.$B$BThere are no further obstacles in your way... let me now teach you what it means to be a Druid of the Claw!' WHERE `entry`=6001;

-- Correct OfferRewardText for quest Body and Heart (6002). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='You have finally taken your large step into a much larger world, $N. I sense the teaching of the Great Bear Spirit within you, and I sense that you have received the strength that Lunaclaw possessed.$B$BThere are no further obstacles in your way... let me now teach you what it means to be a Druid of the Claw!' WHERE `entry`=6002;

-- Correct OfferRewardText for quest The Green Drake (8232). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='You have learned the old ways, $N, and for that I offer you a gift from my days as a hunter.' WHERE `entry`=8232;

-- Correct OfferRewardText for quest Magecraft (8250). Thanks Therilith.
UPDATE `quest_template` SET `OfferRewardText`='<Sanath sneers at you.>$B$BArchmage Xylem awaits your arrival.' WHERE `entry`=8250;

-- Correct RequestItemsText for quest Winterfall Ritual Totem (8471). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='$C - you approach us in a peaceful manner, but I sense that you are here on matters that are grave and severe... for both furbolg and $R alike. What have you come to tell us?' WHERE `entry`=8471;

-- Correct Objectives text for quest The Alliance Needs More Arthas' Tears! (8510). Thanks Therilith.
UPDATE `quest_template` SET `Objectives`='Bring 20 Arthas\' Tears to Sergeant Major Germaine at the airfield in Dun Morogh.' WHERE `entry`=8510;

-- Correct RequestItemsText for quest The Horde Needs Spotted Yellowtail! (8613). Thanks Therilith.
UPDATE `quest_template` SET `RequestItemsText`='Back so soon with the spotted yellowtail, $C? You rememba\' to cook it up nice? We not servin\' raw fish to the soldiers out in the hot desert sun, to be sure.', `OfferRewardText`='Oh ya, this be the good stuff. I pack it up real nice so it not go to waste. Thanks be to you for helpin\' me out like this. I\'m thinkin\' you an A-number-one fisherman for all this spotted yellowtail. An if you happen to fish up and cook even more, you bring it to me here; I make sure everyone know you did!' WHERE `entry`=8613;

-- Correct the equipment (remove incorrect weapons) of npc Thuros Lightfingers (61). Thanks Ghurok.
UPDATE `creature` SET `equipment_id`=0 WHERE `id`=61;

-- Add quest start script to Wrath of the Blue Flight (5162). Thanks Ghurok.
UPDATE `quest_template` SET `StartScript`=5162 WHERE `entry`=5162;

DELETE FROM `dbscripts_on_quest_start` WHERE `id`=5162;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`, `comments`) VALUES
(5162, 0, 15, 17168, 2, 0, 0, 0, 0, 'Cast Haleh\'s Will on Player'),
(5162, 11, 6, 0, 0, 1535, -2629, 380, 0, 'Teleport Player to Western Plaguelands');

-- Correct the model for npc Captain Fairmount (3393). Thanks Ghurok.
UPDATE `creature_model_info` SET `modelid_other_gender`=0 WHERE `modelid`=1855;

-- Remove ReqSpellCast1 from quest Kodo Roundup. Should be handled in a script. Thanks Ghurok.
UPDATE `quest_template` SET `ReqSpellCast1`=0 WHERE `entry`=5561;

-- Spawn Sergeant Ba'sha (12799) and add vendor items
SET @GUID                      = 160017;

DELETE FROM `creature` WHERE `guid`=@GUID;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID, 12799, 1, 12681, 1632.38, -4262.25, 48.978973, 3.991370, 430, 0, 4108, 0, 0, 0);

DELETE FROM `npc_vendor` WHERE `entry`=12799;
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`) VALUES
(12799, 18675, 0, 0),
(12799, 16497, 0, 0),
(12799, 18435, 0, 0),
(12799, 16486, 0, 0),
(12799, 18437, 0, 0),
(12799, 16532, 0, 0),
(12799, 18432, 0, 0),
(12799, 18434, 0, 0),
(12799, 18436, 0, 0),
(12799, 18429, 0, 0),
(12799, 18430, 0, 0),
(12799, 16335, 0, 0),
(12799, 18428, 0, 0),
(12799, 15200, 0, 0),
(12799, 18461, 0, 0),
(12799, 16341, 0, 0),
(12799, 18427, 0, 0),
(12799, 29592, 0, 0),
(12799, 18853, 0, 0),
(12799, 18852, 0, 0),
(12799, 18851, 0, 0),
(12799, 18850, 0, 0),
(12799, 18849, 0, 0),
(12799, 18846, 0, 0),
(12799, 18845, 0, 0),
(12799, 18834, 0, 0),
(12799, 15197, 0, 0);

-- Spawn Officer Areyn (12805) and add vendor items
SET @GUID                      = 160018;

DELETE FROM `creature` WHERE `guid`=@GUID;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID, 12805, 0, 12923, -8759.208008, 389.119598, 101.056503, 0.645159, 430, 0, 4108, 0, 0, 0);

DELETE FROM `npc_vendor` WHERE `entry`=12805;
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`) VALUES
(12805, 18664, 0, 0),
(12805, 18448, 0, 0),
(12805, 18449, 0, 0),
(12805, 18454, 0, 0),
(12805, 18455, 0, 0),
(12805, 18452, 0, 0),
(12805, 18453, 0, 0),
(12805, 18445, 0, 0),
(12805, 18447, 0, 0),
(12805, 18456, 0, 0),
(12805, 18457, 0, 0),
(12805, 18443, 0, 0),
(12805, 18444, 0, 0),
(12805, 18442, 0, 0),
(12805, 16342, 0, 0),
(12805, 18441, 0, 0),
(12805, 18440, 0, 0),
(12805, 18858, 0, 0),
(12805, 18857, 0, 0),
(12805, 18856, 0, 0),
(12805, 18859, 0, 0),
(12805, 18862, 0, 0),
(12805, 29593, 0, 0),
(12805, 18864, 0, 0),
(12805, 18863, 0, 0),
(12805, 18854, 0, 0),
(12805, 15196, 0, 0);

-- Add script for the warlock summoning event in the Magic Quarter, Undercity
SET @AI_SCRIPT_ID                   = 570202;
SET @AI_SUMMONS_ID                  = 22;
SET @ACTION_T_SUMMON_ID             = 32;

DELETE FROM `creature` WHERE `id` IN (5726, 5729, 5730);

DELETE FROM `creature_ai_texts` WHERE `entry` IN (-1311, -1312, -1313, -1314, -1315, -1316, -1317, -1318, -1319, -1320, -1321, -1322);
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(-1322, 'There you have it. Our lesson on summoning has come to an end. A new class will begin shortly, so if you wish to brush up, feel free to stay around.', 0, 0, 33, 0, '5702'),
(-1321, 'I doubt you have had much occasion to see such a creature. These demonic equines will make your travels much faster by acting as your mount as long as you control them. However, they are difficult to control, so be sure you are ready before attempting it.', 0, 0, 33, 0, '5702'),
(-1320, 'When facing a spellcaster of any kind, this feral beast will be your best friend. Now, let us take a look at something a bit different. This next creature will aid your travels and make your future journeys much easier. Let\'s take a look at a felsteed.', 0, 0, 33, 0, '5702'),
(-1319, 'What you see before you is a felhunter. This creature\'s natural talents include spell lock and other abilities which make it unequalled when facing a magically attuned opponent.', 0, 0, 33, 0, '5702'),
(-1318, 'Study hard and you might one day be able to summon one on your own, but for now it\'s time to move on to the felhunter.', 0, 0, 33, 0, '5702'),
(-1317, 'All right now. Aside from the obvious distractions a minion like this will provide against your more masculine foes, she is also capable of dealing out impressive amounts of damage. However, her fragile endurance makes her almost useless as a shield.', 0, 0, 33, 0, '5702'),
(-1316, 'If you\'ve never seen one, it is a sight to behold. A very impressive creature both on and off the field of battle. Next, let us take a look at what I am sure all you male students have been waiting for. The succubus.', 0, 0, 33, 0, '5702'),
(-1315, 'This demonic entity is known as the Voidwalker. Its strength and endurance are significant, making it ideal for defense. Send it to attack your enemy, then use it as a shield while you use your spells and abilities to drain away your opponent\'s life.', 0, 0, 33, 0, '5702'),
(-1314, 'Now that you have had a chance to study imp, let us move on the next minion you will be able to summon, the voidwalker.', 0, 0, 33, 0, '5702'),
(-1313, 'This foul little beast is the imp. It is small and weak, making it almost useless as a meatshield, and its damage output is mediocre at best. This creature is best used for support of a larger group.', 0, 0, 33, 0, '5702'),
(-1312, 'The easiest creature for you to summon is the imp. You should already be able to bring forth this minion but for completeness\' sake I will start with him.', 0, 0, 33, 0, '5702'),
(-1311, 'If you\'re here, then it means you are prepared to begin the study of summoning demonic cohorts to do your bidding. We will start with the lowliest creatures you will be able to call and continue from there. Let us begin.', 0, 0, 33, 0, '5702');

DELETE FROM `creature_ai_summons` WHERE `id`=@AI_SUMMONS_ID;
INSERT INTO `creature_ai_summons` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `comment`) VALUES
(@AI_SUMMONS_ID, 1793.96, 128.84, -63.8432, 2.0714, 30000, '5702');

DELETE FROM `creature_ai_scripts` WHERE `id` IN (@AI_SCRIPT_ID, @AI_SCRIPT_ID+1, @AI_SCRIPT_ID+2, @AI_SCRIPT_ID+3, @AI_SCRIPT_ID+4, @AI_SCRIPT_ID+5, @AI_SCRIPT_ID+6, @AI_SCRIPT_ID+7, @AI_SCRIPT_ID+8, @AI_SCRIPT_ID+9, @AI_SCRIPT_ID+10, @AI_SCRIPT_ID+11, @AI_SCRIPT_ID+12, @AI_SCRIPT_ID+13, @AI_SCRIPT_ID+14, @AI_SCRIPT_ID+15, @AI_SCRIPT_ID+16);
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
(@AI_SCRIPT_ID, 5702, 1, 0, 100, 1, 0, 0, 300000, 300000, 1, -1311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Event start Say Line'),
(@AI_SCRIPT_ID+1, 5702, 1, 0, 100, 1, 10000, 10000, 300000, 300000, 1, -1312, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Imp Say Line 1'),
(@AI_SCRIPT_ID+2, 5702, 1, 0, 100, 1, 18000, 18000, 300000, 300000, @ACTION_T_SUMMON_ID, 5730, 0, @AI_SUMMONS_ID, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Summon Jezelle\'s Imp'),
(@AI_SCRIPT_ID+3, 5702, 1, 0, 100, 1, 20000, 20000, 300000, 300000, 1, -1313, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Imp Say Line 2'),
(@AI_SCRIPT_ID+4, 5702, 1, 0, 100, 1, 50000, 50000, 300000, 300000, 1, -1314, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Voidwalker Say Line 1'),
(@AI_SCRIPT_ID+5, 5702, 1, 0, 100, 1, 58000, 58000, 300000, 300000, @ACTION_T_SUMMON_ID, 5729, 0, @AI_SUMMONS_ID, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Summon Jezelle\'s Voidwalker'),
(@AI_SCRIPT_ID+6, 5702, 1, 0, 100, 1, 60000, 60000, 300000, 300000, 1, -1315, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Voidwalker Say Line 2'),
(@AI_SCRIPT_ID+7, 5702, 1, 0, 100, 1, 90000, 90000, 300000, 300000, 1, -1316, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Succubus Say Line 1'),
(@AI_SCRIPT_ID+8, 5702, 1, 0, 100, 1, 98000, 98000, 300000, 300000, @ACTION_T_SUMMON_ID, 5728, 0, @AI_SUMMONS_ID, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Summon Jezelle\'s Succubus'),
(@AI_SCRIPT_ID+9, 5702, 1, 0, 100, 1, 100000, 100000, 300000, 300000, 1, -1317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Succubus Say Line 2'),
(@AI_SCRIPT_ID+10, 5702, 1, 0, 100, 1, 130000, 130000, 300000, 300000, 1, -1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Felhunter Say Line 1'),
(@AI_SCRIPT_ID+11, 5702, 1, 0, 100, 1, 138000, 138000, 300000, 300000, @ACTION_T_SUMMON_ID, 5726, 0, @AI_SUMMONS_ID, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Summon Jezelle\'s Felhunter'),
(@AI_SCRIPT_ID+12, 5702, 1, 0, 100, 1, 140000, 140000, 300000, 300000, 1, -1319, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Felhunter Say Line 2'),
(@AI_SCRIPT_ID+13, 5702, 1, 0, 100, 1, 170000, 170000, 300000, 300000, 1, -1320, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Felsteed Say Line 1'),
(@AI_SCRIPT_ID+14, 5702, 1, 0, 100, 1, 178000, 178000, 300000, 300000, @ACTION_T_SUMMON_ID, 5727, 0, @AI_SUMMONS_ID, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Summon Jezelle\'s Felsteed'),
(@AI_SCRIPT_ID+15, 5702, 1, 0, 100, 1, 180000, 180000, 300000, 300000, 1, -1321, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Felsteed Say Line 2'),
(@AI_SCRIPT_ID+16, 5702, 1, 0, 100, 1, 210000, 210000, 300000, 300000, 1, -1322, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jezelle Pruitt - OOC - Event end Say Line');

-- Add script for quest Fields of Grief (407)
SET @DB_SCRIPT_STRING1                     = 2000000082;
SET @DB_SCRIPT_STRING2                     = 2000000083;

DELETE FROM `db_script_string` WHERE `entry` IN (@DB_SCRIPT_STRING1, @DB_SCRIPT_STRING2);
INSERT INTO `db_script_string` (`entry`, `content_default`) VALUES
(@DB_SCRIPT_STRING1, 'I. . .I. . .don\'t. . .feel. . .right. . .'),
(@DB_SCRIPT_STRING2, 'My mind. . .my flesh. . .I\'m. . .rotting. . . .!');

DELETE FROM `dbscripts_on_quest_end` WHERE `id`=407;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `data_flags`, `x`, `y`, `z`, `o`, `comments`) VALUES
(407, 0, 0, 0, 0, @DB_SCRIPT_STRING1, 0, 0, 0, 0, 0, 'Captured Scarlet Zealot - Gossip 1'),
(407, 4, 15, 3287, 0, 0, 4, 0, 0, 0, 0, 'Captured Scarlet Zealot - Cast Ghoul Form'),
(407, 4, 3, 0, 0, 0, 0, 2290.15, 234.361, 27.0888, 2.56956, 'Captured Scarlet Zealot - Move 1'),
(407, 5, 3, 0, 0, 0, 0, 2288.9, 236.615, 27.0888, 1.83911, 'Captured Scarlet Zealot - Move 2'),
(407, 6, 0, 0, 0, @DB_SCRIPT_STRING2, 0, 0, 0, 0, 0, 'Captured Scarlet Zealot - Gossip 2'),
(407, 7, 3, 0, 0, 0, 0, 2289.83, 238.224, 27.0888, 0.862072, 'Captured Scarlet Zealot - Move 3'),
(407, 8, 3, 0, 0, 0, 0, 2291.01, 235.69, 27.0888, 2.16605, 'Captured Scarlet Zealot - Move 4'),
(407, 9, 3, 0, 0, 0, 0, 2293.6, 238.072, 27.0894, 0.949244, 'Captured Scarlet Zealot - Move 5'),
(407, 11, 3, 0, 0, 0, 0, 2289.32, 242.205, 27.0881, 2.45802, 'Captured Scarlet Zealot - Move 6'),
(407, 13, 3, 0, 0, 0, 0, 2287.07, 237.225, 27.0881, 4.12621, 'Captured Scarlet Zealot - Move 7'),
(407, 15, 3, 0, 0, 0, 0, 2289.47, 238.213, 27.0881, 0.485854, 'Captured Scarlet Zealot - Move 8'),
(407, 18, 15, 5, 0, 0, 4, 0, 0, 0, 0, 'Captured Scarlet Zealot - Cast Death Touch');

-- END OF SILVERPINE FIXES

-- Add gossip option for creature Caretaker Alen (11038)
SET @NPC_CARETAKER_ALEN_ENTRY                   = 11038;
SET @NPC_CARETAKER_ALEN_GUID                    = 54749;

SET @GOSSIP_MENU_ID                             = 3181;

UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP_MENU_ID, `npcflag`=7 WHERE `entry`=@NPC_CARETAKER_ALEN_ENTRY;

DELETE FROM `npc_gossip` WHERE `npc_guid`=@NPC_CARETAKER_ALEN_GUID;

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP_MENU_ID;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`) VALUES
(@GOSSIP_MENU_ID, 0, 1, 'I wish to make a purchase.', 3, 1);

-- Add gossip to Miranda Breechlock (11536) and Hasana (10856)
SET @GOSSIP_MENU_ID                                 = 3461;
SET @SCRIPT_COMMAND_CREATE_ITEM                     = 17;

SET @ITEM_ARGENT_DAWN_COMMISSION                    = 12846;

SET @NPC_MIRANDA_BREECHLOCK_ENTRY                   = 11536;
SET @NPC_MIRANDA_BREECHLOCK_GUID                    = 68499;

SET @CONDITION_ENTRY                                = 724;
SET @CONDITION_NOITEM_WITH_BANK                     = 24;

UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP_MENU_ID WHERE `entry`=@NPC_MIRANDA_BREECHLOCK_ENTRY;

DELETE FROM `npc_gossip` WHERE `npc_guid`=@NPC_MIRANDA_BREECHLOCK_GUID;

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP_MENU_ID;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
(@GOSSIP_MENU_ID, 0, 0, 'I need another Argent Dawn Commission.', 1, 1, -1, 0, 3421, 0, 0, NULL, @CONDITION_ENTRY),
(@GOSSIP_MENU_ID, 1, 1, 'I would like to buy from you.', 3, 1, 0, 0, 0, 0, 0, NULL, 0),
(@GOSSIP_MENU_ID, 2, 0, 'Miranda, could you please tell me the insignia cost of items that you are offering for adventurers with other reputations?', 1, 1, 0, 0, 0, 0, 0, NULL, 0);

DELETE FROM `dbscripts_on_gossip` WHERE `id`=3421;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `comments`) VALUES
(3421, 0, 17, 12846, 1, 'Give item Argent Dawn Commission (12846)');

DELETE FROM `conditions` WHERE `condition_entry`=@CONDITION_ENTRY;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
(@CONDITION_ENTRY, @CONDITION_NOITEM_WITH_BANK, @ITEM_ARGENT_DAWN_COMMISSION, 1);

SET @GOSSIP_MENU_ID_HASANA              = 3421;

SET @NPC_HASANA_ENTRY                   = 10856;
SET @NPC_HASANA_GUID                    = 28419;

DELETE FROM `npc_gossip` WHERE `npc_guid`=@NPC_HASANA_GUID;
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP_MENU_ID_HASANA WHERE `entry`=@NPC_HASANA_ENTRY;
UPDATE `gossip_menu_option` SET `action_menu_id`=-1, `action_script_id`=@GOSSIP_MENU_ID_HASANA, `condition_id`=@CONDITION_ENTRY WHERE `menu_id`=@GOSSIP_MENU_ID_HASANA AND `id`=0;

-- Add Points of Interest to Undercity Guardian (5624) gossip options. Fixes #86.
UPDATE `gossip_menu_option` SET `action_poi_id`=283 WHERE `menu_id`=2849 AND `id`=0;
UPDATE `gossip_menu_option` SET `action_poi_id`=281 WHERE `menu_id`=2849 AND `id`=1;
UPDATE `gossip_menu_option` SET `action_poi_id`=279 WHERE `menu_id`=2849 AND `id`=2;
UPDATE `gossip_menu_option` SET `action_poi_id`=278 WHERE `menu_id`=2849 AND `id`=3;
UPDATE `gossip_menu_option` SET `action_poi_id`=276 WHERE `menu_id`=2849 AND `id`=4;
UPDATE `gossip_menu_option` SET `action_poi_id`=284 WHERE `menu_id`=2849 AND `id`=5;
UPDATE `gossip_menu_option` SET `action_poi_id`=273 WHERE `menu_id`=2849 AND `id`=6;
UPDATE `gossip_menu_option` SET `action_poi_id`=274 WHERE `menu_id`=2849 AND `id`=7;
UPDATE `gossip_menu_option` SET `action_poi_id`=275 WHERE `menu_id`=2849 AND `id`=8;
UPDATE `gossip_menu_option` SET `action_poi_id`=280 WHERE `menu_id`=2849 AND `id`=9;

UPDATE `gossip_menu_option` SET `action_poi_id`=272 WHERE `menu_id`=2848 AND `id`=0;
UPDATE `gossip_menu_option` SET `action_poi_id`=270 WHERE `menu_id`=2848 AND `id`=2;
UPDATE `gossip_menu_option` SET `action_poi_id`=269 WHERE `menu_id`=2848 AND `id`=3;
UPDATE `gossip_menu_option` SET `action_poi_id`=268 WHERE `menu_id`=2848 AND `id`=4;
UPDATE `gossip_menu_option` SET `action_poi_id`=267 WHERE `menu_id`=2848 AND `id`=5;

UPDATE `gossip_menu_option` SET `action_poi_id`=266 WHERE `menu_id`=2847 AND `id`=0;
UPDATE `gossip_menu_option` SET `action_poi_id`=265 WHERE `menu_id`=2847 AND `id`=1;
UPDATE `gossip_menu_option` SET `action_poi_id`=264 WHERE `menu_id`=2847 AND `id`=2;
UPDATE `gossip_menu_option` SET `action_poi_id`=263 WHERE `menu_id`=2847 AND `id`=3;
UPDATE `gossip_menu_option` SET `action_poi_id`=262 WHERE `menu_id`=2847 AND `id`=4;
UPDATE `gossip_menu_option` SET `action_poi_id`=261 WHERE `menu_id`=2847 AND `id`=5;
UPDATE `gossip_menu_option` SET `action_poi_id`=260 WHERE `menu_id`=2847 AND `id`=6;
UPDATE `gossip_menu_option` SET `action_poi_id`=259 WHERE `menu_id`=2847 AND `id`=7;
UPDATE `gossip_menu_option` SET `action_poi_id`=257 WHERE `menu_id`=2847 AND `id`=8;
UPDATE `gossip_menu_option` SET `action_poi_id`=256 WHERE `menu_id`=2847 AND `id`=9;
UPDATE `gossip_menu_option` SET `action_poi_id`=255 WHERE `menu_id`=2847 AND `id`=10;
UPDATE `gossip_menu_option` SET `action_poi_id`=254 WHERE `menu_id`=2847 AND `id`=11;

-- Add pathing to creature Seeker Thompson (14404) in Undercity. Fixes #94.
UPDATE `creature` SET `position_x`=1727, `position_y`=203.614, `position_z`=-61.62, `orientation`=1.30443, `MovementType`=2 WHERE `id`=14404;

DELETE FROM `creature_movement` WHERE `id`=32072;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(32072, 1, 1732.3, 222.523, -62.1776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.3006, 0, 0),
(32072, 2, 1731.57, 233.338, -62.1776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.63832, 0, 0),
(32072, 3, 1723.39, 239.127, -62.1776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.52582, 0, 0),
(32072, 4, 1677.05, 240.163, -62.1776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.1188, 0, 0),
(32072, 5, 1665.3, 249.331, -62.1776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.4787, 0, 0),
(32072, 6, 1663.02, 266.851, -62.1776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.68937, 0, 0),
(32072, 7, 1657.06, 279.867, -62.1776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.99961, 0, 0),
(32072, 8, 1651.19, 287.107, -62.1805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.26271, 0, 0),
(32072, 9, 1643.75, 287.384, -62.1834, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.19341, 0, 0),
(32072, 10, 1625.17, 269.373, -60.6917, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.92383, 0, 0),
(32072, 11, 1619.45, 263.685, -58.8606, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.92383, 0, 0),
(32072, 12, 1612.25, 256.534, -61.9081, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.92383, 0, 0),
(32072, 13, 1610.43, 254.719, -62.0773, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.92383, 0, 0),
(32072, 14, 1605.25, 252.56, -62.0936, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.5272, 0, 0),
(32072, 15, 1586.61, 252.471, -62.0946, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.14629, 0, 0),
(32072, 16, 1582.39, 248.038, -62.079, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.95132, 0, 0),
(32072, 17, 1582.81, 227.101, -62.079, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.73671, 0, 0),
(32072, 18, 1584.94, 223.331, -62.1522, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.23544, 0, 0),
(32072, 19, 1591.79, 220.867, -57.1859, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.96193, 0, 0),
(32072, 20, 1599.01, 220.875, -57.1616, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.000752, 0, 0),
(32072, 21, 1607.25, 223.58, -62.1374, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.346328, 0, 0),
(32072, 22, 1611.69, 223.622, -61.9065, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.004679, 0, 0),
(32072, 23, 1617.71, 217.89, -59.0818, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.49069, 0, 0),
(32072, 24, 1624.78, 210.724, -60.6919, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.49069, 0, 0),
(32072, 25, 1642.25, 193.005, -62.1838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.49069, 0, 0),
(32072, 26, 1650.23, 193.472, -62.1814, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.059658, 0, 0),
(32072, 27, 1662.77, 214.051, -62.1787, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.0257, 0, 0),
(32072, 28, 1663.87, 229.842, -62.1787, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.52443, 0, 0),
(32072, 29, 1671.56, 235.312, -62.1787, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.61729, 0, 0),
(32072, 30, 1681.28, 239.637, -62.1787, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.405233, 0, 0),
(32072, 31, 1723.1, 238.522, -62.1787, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.25645, 0, 0),
(32072, 32, 1729.79, 228.355, -62.1787, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.29434, 0, 0),
(32072, 33, 1731.34, 217.821, -62.1787, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.85845, 0, 0),
(32072, 34, 1724.98, 195.701, -62.1671, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.43041, 0, 0),
(32072, 35, 1713.35, 179.375, -60.7483, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.09269, 0, 0),
(32072, 36, 1698.91, 182.183, -62.1728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.94208, 0, 0),
(32072, 37, 1692.82, 179.199, -62.1728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.59789, 0, 0),
(32072, 38, 1677.57, 161.509, -62.1572, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.01022, 0, 0),
(32072, 39, 1654.14, 142.97, -62.1517, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.80995, 0, 0),
(32072, 40, 1652.96, 135.5, -62.165, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.56, 0, 0),
(32072, 41, 1659.56, 124.273, -61.4918, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.25507, 0, 0),
(32072, 42, 1668.15, 122.337, -61.4785, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.07581, 0, 0),
(32072, 43, 1679.69, 127.941, -60.399, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.452356, 0, 0),
(32072, 44, 1690.99, 138.584, -55.2144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.758661, 0, 0),
(32072, 45, 1694.65, 138.741, -55.1205, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.036095, 0, 0),
(32072, 46, 1700.56, 132.965, -51.1889, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.51032, 0, 0),
(32072, 47, 1706.48, 127.192, -48.9843, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.51032, 0, 0),
(32072, 48, 1710.44, 123.259, -50.5277, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.48676, 0, 0),
(32072, 49, 1715.23, 118.353, -54.0606, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.48676, 0, 0),
(32072, 50, 1717.61, 115.928, -55.2149, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.48676, 0, 0),
(32072, 51, 1716.88, 112.975, -55.2149, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.46968, 0, 0),
(32072, 52, 1695.71, 91.8981, -62.2246, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.92776, 0, 0),
(32072, 53, 1693.73, 79.1823, -62.2891, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.56393, 0, 0),
(32072, 54, 1702.2, 70.9584, -62.2891, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.48284, 0, 0),
(32072, 55, 1738.34, 59.7895, -59.7713, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.25645, 0, 0),
(32072, 56, 1750.16, 47.7324, -52.817, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.49069, 0, 0),
(32072, 57, 1754.99, 47.2671, -52.817, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.19754, 0, 0),
(32072, 58, 1759.38, 51.5006, -50.2111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.790076, 0, 0),
(32072, 59, 1763.55, 55.7116, -46.3169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.790076, 0, 0),
(32072, 60, 1778.34, 70.5382, -46.3188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.778295, 0, 0),
(32072, 61, 1781.78, 73.9327, -49.3515, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.778295, 0, 0),
(32072, 62, 1787.11, 79.1894, -52.8169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.778295, 0, 0),
(32072, 63, 1786.87, 83.4353, -52.8169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.62653, 0, 0),
(32072, 64, 1779.14, 91.4176, -56.1755, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.34124, 0, 0),
(32072, 65, 1775.15, 95.5312, -59.6657, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.34124, 0, 0),
(32072, 66, 1760.93, 133.892, -62.2949, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.94068, 0, 0),
(32072, 67, 1748.07, 140.085, -62.2585, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.70252, 0, 0),
(32072, 68, 1737.57, 133.233, -62.1182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.72747, 0, 0),
(32072, 69, 1727.58, 123.542, -60.1819, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.89633, 0, 0),
(32072, 70, 1720.53, 116.855, -55.2148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.90419, 0, 0),
(32072, 71, 1717.04, 116.903, -55.0754, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.06774, 0, 0),
(32072, 72, 1712.63, 121.317, -52.3247, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.35302, 0, 0),
(32072, 73, 1707.51, 126.463, -49.0926, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.35302, 0, 0),
(32072, 74, 1701.38, 132.564, -50.6214, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.35302, 0, 0),
(32072, 75, 1695.16, 138.816, -54.9837, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.35302, 0, 0),
(32072, 76, 1695.02, 142.361, -55.2144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.61082, 0, 0),
(32072, 77, 1702.29, 149.973, -60.4682, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.805789, 0, 0),
(32072, 78, 1701.05, 158.937, -60.5802, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.71685, 0, 0),
(32072, 79, 1718.89, 186.261, -60.7598, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.04141, 0, 0),
(32072, 80, 1724.63, 195.081, -62.1654, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.982504, 0, 0);

-- Add class trainer Points of Interest to Bluffwatcher (3084) gossip options. Fixes #98.
UPDATE `gossip_menu_option` SET `action_poi_id`=316 WHERE `menu_id`=740 AND `id`=0;
UPDATE `gossip_menu_option` SET `action_poi_id`=313 WHERE `menu_id`=740 AND `id`=1;
UPDATE `gossip_menu_option` SET `action_poi_id`=315 WHERE `menu_id`=740 AND `id`=2;
UPDATE `gossip_menu_option` SET `action_poi_id`=315 WHERE `menu_id`=740 AND `id`=3;
UPDATE `gossip_menu_option` SET `action_poi_id`=314 WHERE `menu_id`=740 AND `id`=4;
UPDATE `gossip_menu_option` SET `action_poi_id`=313 WHERE `menu_id`=740 AND `id`=5;

-- Spawn all, except patrolling, Emissary NPCs and banners in Orgrimmar.
SET @GUID1_OBJ = 100000;
SET @GUID2_OBJ = 100001;
SET @GUID3_OBJ = 100002;
SET @GUID4_OBJ = 100003;
SET @GUID5_OBJ = 31675;
SET @GUID6_OBJ = 100004;
SET @GUID7_OBJ = 100005;
SET @GUID8_OBJ = 31676;
SET @GUID9_OBJ = 100006;
SET @GUID10_OBJ = 100007;
SET @GUID11_OBJ = 100008;
SET @GUID12_OBJ = 100009;

SET @GUID1_NPC = 100000;
SET @GUID2_NPC = 100001;
SET @GUID3_NPC = 100002;
SET @GUID4_NPC = 100003;
SET @GUID5_NPC = 100004;
SET @GUID6_NPC = 100005;
SET @GUID7_NPC = 100006;
SET @GUID8_NPC = 100007;
SET @GUID9_NPC = 100008;
SET @GUID10_NPC = 100009;
SET @GUID11_NPC = 100010;
SET @GUID12_NPC = 100011;
SET @GUID13_NPC = 100012;
SET @GUID14_NPC = 100013;
SET @GUID15_NPC = 100014;
SET @GUID16_NPC = 100015;
SET @GUID17_NPC = 100016;
SET @GUID18_NPC = 100017;
SET @GUID19_NPC = 100018;
SET @GUID20_NPC = 100019;
SET @GUID21_NPC = 100020;
SET @GUID22_NPC = 100021;
SET @GUID23_NPC = 100022;
SET @GUID24_NPC = 100023;

DELETE FROM `game_event_gameobject` WHERE `guid` IN (@GUID1_OBJ, @GUID2_OBJ, @GUID3_OBJ, @GUID4_OBJ, @GUID5_OBJ, @GUID6_OBJ, @GUID7_OBJ, @GUID8_OBJ, @GUID9_OBJ, @GUID10_OBJ, @GUID11_OBJ, @GUID12_OBJ);
DELETE FROM `gameobject` WHERE `guid` IN (@GUID1_OBJ, @GUID2_OBJ, @GUID3_OBJ, @GUID4_OBJ, @GUID5_OBJ, @GUID6_OBJ, @GUID7_OBJ, @GUID8_OBJ, @GUID9_OBJ, @GUID10_OBJ, @GUID11_OBJ, @GUID12_OBJ);
DELETE FROM `game_event_creature` WHERE `guid` IN (@GUID1_NPC, @GUID2_NPC, @GUID3_NPC, @GUID4_NPC, @GUID5_NPC, @GUID6_NPC, @GUID7_NPC, @GUID8_NPC, @GUID9_NPC, @GUID10_NPC, @GUID11_NPC, @GUID12_NPC, @GUID13_NPC, @GUID14_NPC, @GUID15_NPC, @GUID16_NPC, @GUID17_NPC, @GUID18_NPC, @GUID19_NPC, @GUID20_NPC, @GUID21_NPC, @GUID22_NPC, @GUID23_NPC, @GUID24_NPC);
DELETE FROM `creature` WHERE `guid` IN (@GUID1_NPC, @GUID2_NPC, @GUID3_NPC, @GUID4_NPC, @GUID5_NPC, @GUID6_NPC, @GUID7_NPC, @GUID8_NPC, @GUID9_NPC, @GUID10_NPC, @GUID11_NPC, @GUID12_NPC, @GUID13_NPC, @GUID14_NPC, @GUID15_NPC, @GUID16_NPC, @GUID17_NPC, @GUID18_NPC, @GUID19_NPC, @GUID20_NPC, @GUID21_NPC, @GUID22_NPC, @GUID23_NPC, @GUID24_NPC);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID1_OBJ, 20);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID1_OBJ, 180396, 1, 1933.43, -4708.58, 36.4638, 1.3304, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID1_NPC, 20),
(@GUID2_NPC, 20);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID1_NPC, 14990, 1, 0, 0, 1936.4, -4710.2, 36.4882, 1.29584, 370, 0, 0, 2471, 0, 0, 0),
(@GUID2_NPC, 14990, 1, 0, 0, 1937.07, -4707.49, 35.4933, 4.4123, 370, 0, 0, 2471, 0, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID2_OBJ, 19);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID2_OBJ, 180394, 1, 1933.43, -4708.58, 36.4638, 1.3304, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID3_NPC, 19),
(@GUID4_NPC, 19);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID3_NPC, 15105, 1, 0, 0, 1937.07, -4707.49, 35.4933, 4.4123, 370, 0, 0, 1605, 852, 0, 0),
(@GUID4_NPC, 15105, 1, 0, 0, 1936.4, -4710.2, 36.4882, 1.29584, 370, 0, 0, 1605, 852, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID3_OBJ, 18);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID3_OBJ, 180395, 1, 1933.43, -4708.58, 36.4638, 1.3304, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID5_NPC, 18),
(@GUID6_NPC, 18);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID5_NPC, 15106, 1, 0, 0, 1937.07, -4707.49, 35.4933, 4.4123, 370, 0, 0, 4108, 0, 0, 0),
(@GUID6_NPC, 15106, 1, 0, 0, 1936.4, -4710.2, 36.4882, 1.29584, 370, 0, 0, 4108, 0, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID4_OBJ, 20);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID4_OBJ, 180396, 1, 1657.46, -4385.4, 23.5797, 5.41287, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID7_NPC, 20),
(@GUID8_NPC, 20);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID7_NPC, 14990, 1, 0, 0, 1660.82, -4385.81, 23.9178, 4.17041, 370, 0, 0, 2471, 0, 0, 0),
(@GUID8_NPC, 14990, 1, 0, 0, 1658.83, -4388.91, 23.681, 1.01544, 370, 0, 0, 2471, 0, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID5_OBJ, 19);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID5_OBJ, 180394, 1, 1657.46, -4385.4, 23.5797, 5.41287, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID9_NPC, 19),
(@GUID10_NPC, 19);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID9_NPC, 15105, 1, 0, 0, 1660.82, -4385.81, 23.9178, 4.17041, 370, 0, 0, 1605, 852, 0, 0),
(@GUID10_NPC, 15105, 1, 0, 0, 1658.83, -4388.91, 23.681, 1.01544, 370, 0, 0, 1605, 852, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID6_OBJ, 18);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID6_OBJ, 180395, 1, 1657.46, -4385.4, 23.5797, 5.41287, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID11_NPC, 18),
(@GUID12_NPC, 18);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID11_NPC, 15106, 1, 0, 0, 1660.82, -4385.81, 23.9178, 4.17041, 370, 0, 0, 4108, 0, 0, 0),
(@GUID12_NPC, 15106, 1, 0, 0, 1658.83, -4388.91, 23.681, 1.01544, 370, 0, 0, 4108, 0, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID7_OBJ, 20);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID7_OBJ, 180396, 1, 1663.59, -4343.19, 61.2462, 0.750492, 0, 0, 0.366501, 0.930418, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID13_NPC, 20),
(@GUID14_NPC, 20);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID13_NPC, 14990, 1, 0, 0, 1665.79, -4344.94, 61.2469, 5.42626, 370, 0, 0, 2471, 0, 0, 0),
(@GUID14_NPC, 14990, 1, 0, 0, 1667.51, -4347, 61.2465, 2.33336, 370, 0, 0, 2471, 0, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID8_OBJ, 19);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID8_OBJ, 180394, 1, 1663.59, -4343.19, 61.2462, 0.750492, 0, 0, 0.366501, 0.930418, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID15_NPC, 19),
(@GUID16_NPC, 19);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID15_NPC, 15105, 1, 0, 0, 1665.79, -4344.94, 61.2469, 5.42626, 370, 0, 0, 1605, 852, 0, 0),
(@GUID16_NPC, 15105, 1, 0, 0, 1667.51, -4347, 61.2465, 2.33336, 370, 0, 0, 1605, 852, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID9_OBJ, 18);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID9_OBJ, 180395, 1, 1663.59, -4343.19, 61.2462, 0.750492, 0, 0, 0.366501, 0.930418, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID17_NPC, 18),
(@GUID18_NPC, 18);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID17_NPC, 15106, 1, 0, 0, 1665.79, -4344.94, 61.2469, 5.42626, 370, 0, 0, 4108, 0, 0, 0),
(@GUID18_NPC, 15106, 1, 0, 0, 1667.51, -4347, 61.2465, 2.33336, 370, 0, 0, 4108, 0, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID10_OBJ, 20);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID10_OBJ, 180396, 1, 1749.75, -3963.67, 50.4844, 3.50363, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID19_NPC, 20),
(@GUID20_NPC, 20);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID19_NPC, 14990, 1, 0, 0, 1743.72, -3967.15, 49.1537, 0.42906, 370, 0, 0, 2471, 0, 0, 0),
(@GUID20_NPC, 14990, 1, 0, 0, 1747.21, -3965.75, 49.6639, 3.57536, 370, 0, 0, 2471, 0, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID11_OBJ, 19);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`)
VALUES
(@GUID11_OBJ, 180394, 1, 1749.75, -3963.67, 50.4844, 3.50363, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID21_NPC, 19),
(@GUID22_NPC, 19);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID21_NPC, 15105, 1, 0, 0, 1743.72, -3967.15, 49.1537, 0.42906, 370, 0, 0, 1605, 852, 0, 0),
(@GUID22_NPC, 15105, 1, 0, 0, 1747.21, -3965.75, 49.6639, 3.57536, 370, 0, 0, 1605, 852, 0, 0);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES
(@GUID12_OBJ, 18);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID12_OBJ, 180395, 1, 1749.75, -3963.67, 50.4844, 3.50363, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES
(@GUID23_NPC, 18),
(@GUID24_NPC, 18);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID23_NPC, 15106, 1, 0, 0, 1743.72, -3967.15, 49.1537, 0.42906, 370, 0, 0, 4108, 0, 0, 0),
(@GUID24_NPC, 15106, 1, 0, 0, 1747.21, -3965.75, 49.6639, 3.57536, 370, 0, 0, 4108, 0, 0, 0);

-- Remove two non-classic items from the npc_vendor table
DELETE FROM `npc_vendor` WHERE `item` IN (29592, 29593);

-- Fixed warlock quest 1716 (Devourer of Souls)
-- The quest was only available to gnomes (64) and humans (1) back in
-- Classic
-- Quest 1717 (Gakin's Summons) is not a prerequisite of quest 1716
-- it is only an alternate startup quest for warlocks in Ironforge (mainly
-- gnomes warlocks)
UPDATE `quest_template` SET `RequiredRaces` = 65, `PrevQuestId` = 0 WHERE `entry` = 1716;

-- Switch quest givers for NE racial priest quests 5673 and 5675 (Elune's Grace)
-- As the dwarf version was wrongly given by human priest (376) and human version by dwarf priest (11406)
UPDATE `creature_questrelation` SET `id` = 376 WHERE `quest` = 5673;
UPDATE `creature_questrelation` SET `id` = 11406 WHERE `quest` = 5675;

-- Removes wrong loot chance for item 16746 (Warsong Report)
-- Wrongly looted from item 16882 (Battered Junkbox)
DELETE FROM `item_loot_template` WHERE `entry` = 16882 AND `item` = 16746;

-- Wrongly dropped by a lot of creatures as it is a quest item, found when opening another quest item
-- source: http://www.wowhead.com/item=16746
DELETE FROM `creature_loot_template` WHERE `item` = 16746;

-- Reverted faction for creatures 2578 (Young Mesa Buzzard), 2579 (Mesa Buzzard), 2580 (Elder Mesa Buzzard)
-- as they were hostile to players prio to patch 2.3.2. Correct faction value is taken from other buzzard creatures
-- Source: http://http://www.wowwiki.com/Mesa_Buzzard
-- http://www.wowwiki.com/Elder_Mesa_Buzzard
-- http://www.wowwiki.com/Young_Mesa_Buzzard
UPDATE `creature_template` SET `Faction_A` = 73, `Faction_H` = 73 WHERE `entry` IN (2578, 2579, 2580);

-- Adds equipement to creature 1853 (Darkmaster Gandling)
-- He now wields his infamous skull staff
-- (equipement was already in DB but not linked to NPC)
UPDATE `creature_template` SET `equipment_id` = 1205 WHERE `entry` = 1853;

-- Adds waypoint movement for creature 522 (Mor'Ladim)
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 522;
DELETE FROM `creature_movement_template` WHERE `entry` = 522;
INSERT INTO `creature_movement_template` VALUES
(522, 1, -10381.8, 385.819, 47.4858, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.18829, 0, 0),
(522, 2, -10378.4, 396.698, 48.6662, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.76791, 0, 0),
(522, 3, -10383.9, 406.43, 48.2008, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.21245, 0, 0),
(522, 4, -10392.8, 415.511, 48.5681, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.69861, 0, 0),
(522, 5, -10402.7, 424.936, 48.5981, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.59494, 0, 0),
(522, 6, -10422.1, 430.723, 47.0119, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.95858, 0, 0),
(522, 7, -10436.6, 429.382, 45.2662, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.12351, 0, 0),
(522, 8, -10453.3, 433.284, 40.6231, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.79364, 0, 0),
(522, 9, -10470.3, 439.704, 37.3075, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.97428, 0, 0),
(522, 10, -10475.1, 439.484, 36.9664, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.58297, 0, 0),
(522, 11, -10483.4, 433.097, 37.9773, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.10997, 0, 0),
(522, 12, -10487.7, 425.658, 37.6992, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.26234, 0, 0),
(522, 13, -10491.3, 416.08, 35.8946, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.4312, 0, 0),
(522, 14, -10497.2, 393.399, 36.0944, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.55684, 0, 0),
(522, 15, -10496.4, 366.334, 34.3317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.82387, 0, 0),
(522, 16, -10488.2, 347.825, 34.1085, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.18909, 0, 0),
(522, 17, -10474.2, 327.59, 35.0722, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.31868, 0, 0),
(522, 18, -10466.7, 311.631, 36.7639, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.46397, 0, 0),
(522, 19, -10449.7, 301.976, 37.3267, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.83311, 0, 0),
(522, 20, -10436, 298.191, 37.4351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.158601, 0, 0),
(522, 21, -10416.6, 304.413, 38.8815, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.563077, 0, 0),
(522, 22, -10408.8, 312.268, 39.3245, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.16626, 0, 0),
(522, 23, -10405.8, 321.295, 40.5022, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.46943, 0, 0),
(522, 24, -10405.1, 334.65, 42.6046, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.54404, 0, 0),
(522, 25, -10405, 345.921, 43.8031, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.35162, 0, 0),
(522, 26, -10399.3, 360.188, 45.1209, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.37125, 0, 0),
(522, 27, -10400, 366.515, 45.581, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.18257, 0, 0),
(522, 28, -10405.3, 372.353, 45.7753, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.43075, 0, 0),
(522, 29, -10410.4, 375.665, 45.6153, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.35614, 0, 0),
(522, 30, -10412.4, 379.826, 45.7007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.23852, 0, 0),
(522, 31, -10411.1, 383.231, 46.2108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.66675, 0, 0),
(522, 32, -10408.7, 384.592, 46.6007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.97264, 0, 0),
(522, 33, -10399.6, 381.67, 46.8407, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.21768, 0, 0),
(522, 34, -10391.9, 382.664, 46.8753, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.623291, 0, 0);

-- Adds completion text for quest 1653 (The Test of Righteousness)
-- source: http://www.wowwiki.com/Quest:The_Test_of_Righteousness_(1)
UPDATE `quest_template` SET `OfferRewardText` = 'Good day, $N. The Light is with you, I trust?$B$BWhat\'s that? You were sent by Duthorian!? My wife, how is she? I knew there was going to be trouble if I left.$B$BPlease tell me she\'s... oh, thank goodness. I\'m so glad that she\'s safe. The Defias were a threat long before these attacks, but now the King\'s advisors cannot deny it.$B$BWhat else did Duthorian have to say? You\'re the one that was sent to protect my wife? Then I thank you again, $N. I couldn\'t think of a better test of valor than that.' WHERE `entry` = 1653;

-- Fiora Longears (4456) moved back to Theramore from Auberdine. Moved in 2.3.0 --
UPDATE `creature` SET `position_x` = '-3613.427734', `position_y` = '-4463.895020', `position_z` = '13.622666', `orientation` = '2.975219' WHERE `guid` = '37087';

-- Adds teleport location for The Stockades ".tele TheStockades"
DELETE FROM `game_tele` WHERE `id`=418;
INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES
(418,-8787.390625,828.377075,97.648933,0.626312,0,'TheStockades');

-- Updates the position of Barkeep Hann because his title was flickering in the wall
UPDATE `creature` SET `position_x` = '-10509.634766', `position_y` = '-1155.536011', `position_z` = '28.099501', `orientation` = '3.218907' WHERE `guid` = '4191';

-- This fixes the text for quest 388 - QG refers to you incorrectly in completion text instead of "Mac" --
UPDATE `quest_template` SET `OfferRewardText`='So these bandanas -- filthy tokens of corruption -- are what my Mac had to die for? Such a waste. Such a tragic sacrifice. $b$bBut alas, I cannot return to the past. Just know, $N, that you have brought my family justice through your deeds.' WHERE `entry`='388';

-- Removed item 2203 (Brashclaw's Chopper) and item 2204 (Brashclaw's Skewer) from reference_loot_template
-- because they can only drop from creature 506 (Sergeant Brashclaw)
-- Thanks to Neotmiren for pointing
-- Source: http://www.wowhead.com/item=2203
-- Source: http://www.wowhead.com/item=2204
DELETE FROM `reference_loot_template` WHERE `item` IN (2203, 2204);

-- Added drop chance for item 2203 (Brashclaw's Chopper) and item 2204 (Brashclaw's Skewer) from creature 506 (Sergeant Brashclaw)
-- Thanks to Neotmiren for pointing
-- Source: http://www.wowhead.com/npc=506
DELETE FROM `creature_loot_template` WHERE `entry` = 506 AND `item` IN (2203, 2204);
INSERT INTO `creature_loot_template` VALUES
(506, 2203, 0.03, 0, 1, 1, 0),
(506, 2204, 0.9, 0, 1, 1, 0);

-- Prevent creature 647 (Captain Greenskin) from using wrong undead model instead of its goblin model
-- Thanks Neotmiren for pointing and fixing
-- Source: http://www.wowhead.com/npc=647
UPDATE `creature_model_info` SET `modelid_other_gender` = 0 WHERE `modelid` = 7113 AND `modelid_other_gender` = 3494;

-- Remove Random Obsidian Chunks --
DELETE FROM `gameobject` WHERE `guid` = '9306';
DELETE FROM `game_event_gameobject` WHERE `guid` = '9306';
DELETE FROM `gameobject_battleground` WHERE `guid` = '9306';
DELETE FROM `gameobject` WHERE `guid` = '11495';
DELETE FROM `game_event_gameobject` WHERE `guid` = '11495';
DELETE FROM `gameobject_battleground` WHERE `guid` = '11495';
DELETE FROM `gameobject` WHERE `guid` = '12443';
DELETE FROM `game_event_gameobject` WHERE `guid` = '12443';
DELETE FROM `gameobject_battleground` WHERE `guid` = '12443';
DELETE FROM `gameobject` WHERE `guid` = '9301';
DELETE FROM `game_event_gameobject` WHERE `guid` = '9301';
DELETE FROM `gameobject_battleground` WHERE `guid` = '9301';
DELETE FROM `gameobject` WHERE `guid` = '14106';
DELETE FROM `game_event_gameobject` WHERE `guid` = '14106';
DELETE FROM `gameobject_battleground` WHERE `guid` = '14106';
DELETE FROM `gameobject` WHERE `guid` = '14124';
DELETE FROM `game_event_gameobject` WHERE `guid` = '14124';
DELETE FROM `gameobject_battleground` WHERE `guid` = '14124';
DELETE FROM `gameobject` WHERE `guid` = '14127';
DELETE FROM `game_event_gameobject` WHERE `guid` = '14127';
DELETE FROM `gameobject_battleground` WHERE `guid` = '14127';
DELETE FROM `gameobject` WHERE `guid` = '14142';
DELETE FROM `game_event_gameobject` WHERE `guid` = '14142';
DELETE FROM `gameobject_battleground` WHERE `guid` = '14142';

-- Anubisath Sentinel Position Adjustment --
UPDATE `creature` SET `position_x` = '-8159.728027', `position_y` = '2145.341309', `position_z` = '129.582779', `orientation` = '3.473037' WHERE `guid` = '87570';
UPDATE `creature` SET `position_x` = '-8156.620605', `position_y` = '2119.613770', `position_z` = '129.114990', `orientation` = '3.174591' WHERE `guid` = '87571';

-- Adds missing Obsidian Eradicator --
DELETE FROM `creature` WHERE `guid`=590011;
INSERT INTO `creature` VALUES
(590011, 15262, 531, 0, 0, -8277.51, 2117.84, 118.176, 0.261538, 25, 0, 0, 170805, 24340, 0, 0);
UPDATE `creature` SET `spawntimesecs`=3600 WHERE `guid`=590011;

-- Corrects 2 slanted Sentinels next to Skeram --
UPDATE `creature` SET `position_x` = '-8317.698242', `position_y` = '2134.262451', `position_z` = '118.550896', `orientation` = '0.410774' WHERE `guid` = '87564';
UPDATE `creature` SET `position_x` = '-8314.269531', `position_y` = '2114.679932', `position_z` = '118.272003', `orientation` = '0.204999' WHERE `guid` = '87565';

-- Removes drop chance for quest item 1309 (Oslow Toolbox) from item "Small Barned Clam" (5523)
-- as it should only be dropped by quest object Sunken Chest (GO 32)
-- Source: http://www.wowhead.com/item=1309#contained-in-object
DELETE FROM `item_loot_template` WHERE `item` = 1309;

-- Changed drop chance of item 12884 (Arnak's Hoof) to make it drop only when player
-- have related quest
-- Thanks to The_Great_Sephiroth for pointing
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 12884 AND `entry` = 10896;

-- Replaces two mithril ore's found in Durotar with Copper Nodes
-- Fixes one of the Copper Ore nodes that's half way in the world
UPDATE `gameobject` SET `id` = 1731 WHERE `guid` = 7321;
UPDATE `gameobject` SET `id` = 1731 WHERE `guid` = 7304;
UPDATE `gameobject` SET `position_z` = -8.4 WHERE `guid` = 5455;

-- Fixes quest 2701 that is missing its completion text and is rewarded by quest giver
-- instead of specific gameobject which shows wrong gameobject behavior
-- Source: http://www.wowhead.com/quest=2701#comments
-- Adds the gameobject 141980 (Spectral Lockbox) as the quest completion GO
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 2701;
INSERT INTO `gameobject_involvedrelation` VALUES
(141980, 2701);
-- Updates gameobject 141980 which had the wrong quest number reference
UPDATE `gameobject_template` SET `data1` = 2701 WHERE `entry` = 141980;
-- Updates quest to remove completion emote as gameobject does not do emote
UPDATE `quest_template` SET `CompleteEmote` = 0 WHERE `entry` = 2701;
-- Removes quest completion from creature 7750 (Corporal Thund Splithoof)
DELETE FROM `creature_involvedrelation` WHERE `quest` = 2701;

-- Remove the "mail" subclass from engineering trinkets which prevented cloth and leather class to use them
-- Thanks to Neotmiren for pointing and fixing
UPDATE `item_template` SET `subclass` = 0 WHERE `class` = 4 AND `subclass` = 3 AND `InventoryType` = 12;

-- Update InhabitType of creature 7046 (Searscale Drake): let it hover!
UPDATE `creature_template` SET `InhabitType` = 3 WHERE `entry` = 7046;

-- Adds condition for loot template of items "Shredder operating manual pages" (entries 16645 to 16656)
-- as these should only drop for Horde players
-- Source: http://www.wowwiki.com/Patch_1.8.0#Items
-- For items looted from creatures
UPDATE `creature_loot_template` SET `condition_id` = 4 WHERE `item` BETWEEN 16645 AND 16656;
-- For items looted from gameobjects
UPDATE `gameobject_loot_template` SET `condition_id` = 4 WHERE `item` BETWEEN 16645 AND 16656;

-- Change Weapon on Dark Touched Warrior from axe to bucket.
-- Source:http://www.wowhead.com/npc=16156#screenshots:id=46064
UPDATE `creature_template` SET `equipment_id` = 1139 WHERE `entry` = 16156;

-- Sewage slime placeholders near patchwerk are actually npc living poison. Level Updated.
-- http://www.wowhead.com/npc=16027#comments
-- http://www.wowwiki.com/Living_Poison
-- http://www.wowhead.com/spell=28433 - spell they use
UPDATE  `creature`  SET `id` = 16027 WHERE `guid` IN (88697, 88696, 88695, 88694, 88693, 88692, 88691, 88690, 88689, 88688, 88687, 88686, 88685, 88684, 88683, 88682);
Update `creature_template` SET `minlevel` = 61, `maxlevel` = 61 WHERE `entry` = 16027;

-- Minor change death touched warrior to doom touched warrior
-- http://www.youtube.com/watch?v=agWfYn0piY8&feature=related
-- http://www.youtube.com/watch?v=7VcozSUZc9Y
DELETE FROM `creature` WHERE `guid` = 88428;
DELETE FROM `creature` WHERE `guid` = 88443;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(88428, 16157, 533, 16528, 0, 2879.88, -3198.33, 298.33, 4.04, 3520, 0, 0, 95847, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(88443, 16156, 533, 16534, 0, 2799.42, -3159.93, 298.33, 3.85, 3520, 0, 0, 24372, 12000, 0, 0);

-- Embalming slime random movement add and decrease npc scale
UPDATE `creature` SET `spawndist` = 8, `movementtype` = 1 WHERE `id` = 16024;
UPDATE `creature_template` SET `scale` = 1.0 WHERE `entry` = 16024;

-- Remove faerlinas surgical assistants and trash began again
-- Used some anub placeholders to fill in the extra missing npcs of faerlinas trash
-- Source http://imageshack.us/a/img10/126/u2zr.jpg
-- http://imageshack.us/a/img822/7834/qjbl.jpg
-- http://imageshack.us/a/img203/350/u1tu.jpg
-- http://imageshack.us/a/img802/5744/q6o7.jpg
-- http://imageshack.us/a/img153/3964/n2sw.jpg
-- http://imageshack.us/a/img834/5807/yr87.jpg
-- http://imageshack.us/a/img703/4140/q3t4.jpg
-- http://imageshack.us/a/img18/3176/c0t1.jpg
-- http://imageshack.us/a/img843/4158/vf0g.jpg
-- http://imageshack.us/a/img818/7010/iyeq.jpg
-- http://imageshack.us/a/img850/781/ve7x.jpg
-- http://imageshack.us/a/img844/2372/91fi.jpg
-- http://imageshack.us/a/img27/2779/ngzw.jpg
-- http://imageshack.us/a/img607/3883/z21x.jpg
-- http://imageshack.us/a/img41/459/o5w9.jpg

DELETE FROM `creature` WHERE `guid` IN (88515,88511,88514,88512,88513,88516,88540,88521,88539,88519,88520,88518,
88349,88350,88351,88352,88353,88354,88355,88356,88357,88358,88517,88530,88529,88528,88527,88526,88525,88524,88523,
 88522,88508,88507,88506,88505,88538,88537,88536,88535,88534,88533,88532,88531,88510,88509,88504,88503);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(88540, 15980, 533, 16594, 0, 3383.74, -3696.1, 259.079, 2.18733, 3520, 0, 0, 25824, 58750, 0, 0),
(88539, 15980, 533, 16594, 0, 3381.75, -3692.54, 259.081, 2.18888, 3520, 0, 0, 25824, 58750, 0, 0),
(88530, 15980, 533, 16594, 0, 3369.99, -3648.58, 259.083, 2.25985, 3520, 0, 0, 25824, 58750, 0, 0),
(88529, 15980, 533, 16594, 0, 3369.86, -3645.99, 259.084, 2.34441, 3520, 0, 0, 25824, 58750, 0, 0),
(88528, 15980, 533, 16594, 0, 3328.08, -3667.47, 259.083, 1.14667, 3520, 0, 0, 25824, 58750, 0, 0),
(88527, 15980, 533, 16594, 0, 3330.6, -3668.71, 259.083, 1.05558, 3520, 0, 0, 25824, 58750, 0, 0),
(88526, 15980, 533, 16594, 0, 3386.68, -3693.53, 259.078, 1.99099, 3520, 0, 0, 25824, 58750, 0, 0),
(88525, 15980, 533, 16594, 0, 3364.66, -3652.31, 259.083, 2.20226, 3520, 0, 0, 25824, 58750, 0, 0),
(88524, 15980, 533, 16594, 0, 3377.78, -3667.32, 259.082, 2.02632, 3520, 0, 0, 25824, 58750, 0, 0),
(88523, 15980, 533, 16594, 0, 3380.65, -3668.88, 259.082, 1.83783, 3520, 0, 0, 25824, 58750, 0, 0),
(88522, 15980, 533, 16594, 0, 3371.37, -3674.5, 259.081, 2.04125, 3520, 0, 0, 25824, 58750, 0, 0),
(88521, 15980, 533, 16594, 0, 3378.09, -3694.5, 259.081, 2.21561, 3520, 0, 0, 25824, 58750, 0, 0),
(88520, 15980, 533, 16594, 0, 3359.55, -3691.23, 259.079, 1.67604, 3520, 0, 0, 25824, 58750, 0, 0),
(88519, 15980, 533, 16594, 0, 3351.66, -3686.87, 259.077, 1.48675, 3520, 0, 0, 25824, 58750, 0, 0),
(88518, 15980, 533, 16594, 0, 3343.45, -3690.63, 259.081, 1.38309, 3520, 0, 0, 25824, 58750, 0, 0),
(88516, 15980, 533, 16594, 0, 3387.27, -3686.28, 259.078, 1.99491, 3520, 0, 0, 25824, 58750, 0, 0),
(88515, 15980, 533, 16594, 0, 3328.66, -3645.67, 259.083, 0.806731, 3520, 0, 0, 25824, 58750, 0, 0),
(88514, 15980, 533, 16594, 0, 3339.58, -3648.76, 259.084, 1.09422, 3520, 0, 0, 25824, 58750, 0, 0),
(88513, 15980, 533, 16594, 0, 3335.5, -3646.6, 259.083, 0.870372, 3520, 0, 0, 25824, 58750, 0, 0),
(88512, 15980, 533, 16594, 0, 3336.3, -3651.87, 259.083, 1.07928, 3520, 0, 0, 25824, 58750, 0, 0),
(88511, 15980, 533, 16594, 0, 3330.74, -3642.45, 259.083, 0.574275, 3520, 0, 0, 25824, 58750, 0, 0),
(88508, 15980, 533, 16594, 0, 3372.95, -3647.09, 259.084, 2.33053, 3520, 0, 0, 25824, 58750, 0, 0),
(88507, 15980, 533, 16594, 0, 3331.81, -3673.99, 259.083, 1.04451, 3520, 0, 0, 25824, 58750, 0, 0),
(88506, 15980, 533, 16594, 0, 3321.17, -3668, 259.083, 1.02287, 3520, 0, 0, 25824, 58750, 0, 0),
(88505, 15980, 533, 16594, 0, 3328.58, -3671.77, 259.082, 1.19209, 3520, 0, 0, 25824, 58750, 0, 0),
(88538, 15981, 533, 16598, 0, 3325.36, -3669.93, 259.083, 0.86144, 3520, 0, 0, 26274, 58750, 0, 0),
(88537, 15981, 533, 16598, 0, 3333.9, -3670.34, 259.083, 1.06684, 3520, 0, 0, 26274, 58750, 0, 0),
(88536, 15981, 533, 16598, 0, 3325.01, -3665.89, 259.083, 1.08134, 3520, 0, 0, 26274, 58750, 0, 0),
(88535, 15981, 533, 16598, 0, 3381.35, -3665.38, 259.082, 2.10801, 3520, 0, 0, 26274, 58750, 0, 0),
(88534, 15981, 533, 16598, 0, 3371.72, -3670.42, 259.082, 1.85668, 3520, 0, 0, 26274, 58750, 0, 0),
(88533, 15981, 533, 16598, 0, 3363.15, -3648.38, 259.084, 2.10817, 3520, 0, 0, 26274, 58750, 0, 0),
(88532, 15981, 533, 16598, 0, 3376.57, -3645.85, 259.083, 2.31337, 3520, 0, 0, 26274, 58750, 0, 0),
(88531, 15981, 533, 16598, 0, 3376.47, -3642.95, 259.084, 2.62281, 3520, 0, 0, 26274, 58750, 0, 0),
(88517, 15981, 533, 16598, 0, 3354.76, -3691.24, 259.075, 1.5166, 3520, 0, 0, 26274, 58750, 0, 0),
(88510, 15981, 533, 16598, 0, 3367.35, -3651.84, 259.084, 2.20932, 3520, 0, 0, 26274, 58750, 0, 0),
(88509, 15981, 533, 16598, 0, 3332.52, -3645.51, 259.083, 0.874526, 3520, 0, 0, 26274, 58750, 0, 0),
(88504, 15981, 533, 16598, 0, 3339.67, -3653.26, 259.083, 1.34752, 3520, 0, 0, 26274, 58750, 0, 0),
(88503, 15981, 533, 16598, 0, 3332.51, -3650.26, 259.083, 1.00466, 3520, 0, 0, 26274, 58750, 0, 0),
(88358, 15981, 533, 16598, 0, 3341.08, -3686.59, 259.087, 1.48889, 3520, 0, 0, 26274, 58750, 0, 0),
(88357, 15981, 533, 16598, 0, 3349.37, -3690.77, 259.078, 1.50796, 3520, 0, 0, 26274, 58750, 0, 0),
(88356, 15981, 533, 16598, 0, 3385.21, -3689.97, 259.08, 2.23446, 3520, 0, 0, 26274, 58750, 0, 0),
(88355, 15981, 533, 16598, 0, 3380.14, -3698.34, 259.082, 2.13314, 3520, 0, 0, 26274, 58750, 0, 0),
(88354, 15981, 533, 16598, 0, 3374.55, -3669.16, 259.083, 1.9792, 3520, 0, 0, 26274, 58750, 0, 0),
(88353, 15981, 533, 16598, 0, 3372.73, -3696.97, 259.082, 2.02146, 3520, 0, 0, 26274, 58750, 0, 0),
(88352, 15981, 533, 16598, 0, 3345.89, -3686.31, 259.082, 1.51205, 3520, 0, 0, 26274, 58750, 0, 0),
(88351, 15981, 533, 16598, 0, 3357.25, -3686.85, 259.079, 1.57865, 3520, 0, 0, 26274, 58750, 0, 0),
(88350, 15981, 533, 16598, 0, 3377.55, -3670.89, 259.082, 2.07345, 3520, 0, 0, 26274, 58750, 0, 0),
(88349, 15981, 533, 16598, 0, 3374.54, -3672.9, 259.082, 1.75929, 3520, 0, 0, 26274, 58750, 0, 0);

-- correcting game objects in ubrs
DELETE FROM `gameobject` WHERE `guid` IN (87895,87896,87897,87863,87898,87864,87899,87865,87900,87901,87902,87903,87904,87905,87951,87952,87953,87954,87955,87956,87957
,87958,87959,87960,87961,87962,87963,87964,87965,87966,87967,87968,87969,87970,87971,87972,87857,87858,87859,87860,87861,87862,87976,87867,87871,87872,87873,87874,87875,87876,
87906,87907,87908,87909,87855,87911,87977,87978,87914,87915,87921,87920,87923,87916,87917,87918,87919,87925,87924,87936,87934,87933,87932,87931,87930,87922,87935,87929,87928,87927,87926,87913);

-- missing most fire and bonfires Ie entry to beasts room
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(87871, 136922, 229, 88.2152, -415.1, 110.957, 2.72271, 0, 0, 0, 0, 120, 0, 1),
(87872, 136923, 229, 87.4498, -468.454, 116.887, 2.72271, 0, 0, 0, 0, 120, 0, 1),
(87873, 136925, 229, 40.7229, -586.71, 30.6817, 1.74533, 0, 0, 0, 0, 120, 0, 1),
(87874, 136926, 229, 43.3149, -572.476, 30.6817, 1.74533, 0, 0, 0, 0, 120, 0, 1),
(87875, 136927, 229, 4.75705, -567.073, 29.2222, 1.74533, 0, 0, 0, 0, 120, 0, 1),
(87876, 136928, 229, 8.39204, -583.677, 29.2222, 1.74533, 0, 0, 0, 0, 120, 0, 1),
(87895, 136947, 229, 16.9937, -253.821, 65.4498, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87896, 136948, 229, 8.17041, -268.98, 65.4498, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87897, 136949, 229, 51.2451, -274.133, 65.4498, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87863, 136950, 229, 72.8373, -265.63, 60.7365, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87898, 136951, 229, 68.8802, -283.794, 60.7365, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87864, 136952, 229, 69.9731, -329.868, 55.8721, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87899, 136954, 229, 16.1674, -280.865, 9.61726, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87865, 136955, 229, 56.3641, -306.158, 54.0157, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87900, 136957, 229, 117.454, -254.291, 91.5711, 2.72271, 0, 0, 0, 0, 120, 0, 1),
(87901, 136959, 229, 125.656, -280.808, 91.5711, 2.72271, 0, 0, 0, 0, 120, 0, 1),
(87902, 136961, 229, 46.4689, -309.649, 91.5711, 2.72271, 0, 0, 0, 0, 120, 0, 1),
(87903, 136962, 229, 106.177, -265.953, 91.5711, -1.46608, 0, 0, 0, 0, 120, 0, 1),
(87904, 136963, 229, 107.69, -253.095, 91.5711, 2.72271, 0, 0, 0, 0, 120, 0, 1),
(87905, 136964, 229, 82.5879, -364.586, 116.859, 2.72271, 0, 0, 0, 0, 120, 0, 1),
(87951, 176425, 229, 60.0724, -511.967, 29.2143, -3.13874, 0, 0, 0, 0, 120, 0, 1),
(87952, 176426, 229, 56.9335, -556.048, 30.6604, -3.13874, 0, 0, 0, 0, 120, 0, 1),
(87953, 176427, 229, 53.1921, -461.07, 24.3897, -3.1415, 0, 0, 0, 0, 120, 0, 1),
(87954, 176428, 229, -63.2568, -581.483, 29.2934, -3.1415, 0, 0, 0, 0, 120, 0, 1),
(87955, 176429, 229, -37.6863, -551.822, 16.2163, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87956, 176430, 229, -25.3349, -478.438, 17.2504, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87957, 176431, 229, -46.3865, -448.61, -18.5644, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87958, 176432, 229, -2.64242, -579.144, -18.7609, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87959, 176433, 229, 26.982, -583.365, -18.5153, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87960, 176434, 229, 35.6424, -550.73, -18.411, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87961, 176435, 229, 33.1643, -471.047, -18.5059, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87962, 176436, 229, 31.9839, -495.349, -18.8984, -3.13874, 0, 0, 0, 0, 120, 0, 1),
(87963, 176437, 229, -39.3852, -424.878, -18.8471, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87964, 176438, 229, -23.2051, -410.609, -18.8984, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87965, 176439, 229, -76.0975, -418.801, -18.9234, -1.83259, 0, 0, 0, 0, 120, 0, 1),
(87966, 176440, 229, -59.9712, -409.641, -18.8443, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87967, 176441, 229, -79.5309, -453.927, -18.8332, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87968, 176442, 229, -15.4378, -368.781, 49.4936, 3.14085, 0, 0, 0, 0, 120, 0, 1),
(87969, 176443, 229, -121.137, -296.445, 71.0397, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87970, 176444, 229, -137.264, -305.605, 70.9606, -1.83259, 0, 0, 0, 0, 120, 0, 1),
(87971, 176445, 229, -59.1198, -339.829, 70.9606, -1.83259, 0, 0, 0, 0, 120, 0, 1),
(87972, 176446, 229, -87.3357, -348.37, 71.0397, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87857, 176447, 229, 35.2499, -505.634, 110.914, -3.13874, 0, 0, 0, 0, 120, 0, 1),
(87858, 176448, 229, 31.283, -505.634, 110.914, 1.57142, 0, 0, 0, 0, 120, 0, 1),
(87859, 176449, 229, 27.4453, -505.634, 110.914, -0.261172, 0, 0, 0, 0, 120, 0, 1),
(87860, 176450, 229, 21.5668, -506.581, 110.914, -1.57017, 0, 0, 0, 0, 120, 0, 1),
(87861, 176451, 229, 18.0824, -505.634, 110.914, -3.13874, 0, 0, 0, 0, 120, 0, 1),
(87862, 176452, 229, 24.542, -504.736, 110.914, -2.35556, 0, 0, 0, 0, 120, 0, 1),
(87976, 176457, 229, -115.273, -428.518, -18.701, 3.14159, 0, 0, 0, 0, 120, 0, 1),
(87867, 176460, 229, 70.5435, -257.169, 60.7401, 3.12412, 0, 0, 0, 0, 120, 0, 1),

-- spider eggs
(87914, 175606, 229, -100.23, -529.537, -5.77381, -0.436332, 0, 0, 0, 0, 120, 0, 1),
(87915, 175606, 229, -100.325, -523.847, 10.7029, 2.11185, 0, 0, 0, 0, 120, 0, 1),
(87921, 175606, 229, -129.514, -441.7, 24.4328, 0.977383, 0, 0, 0, 0, 120, 0, 1),
(87920, 175606, 229, -126.746, -514.164, -12.147, 3.10665, 0, 0, 0, 0, 120, 0, 1),
(87923, 175606, 229, -131.805, -526.784, 6.55651, -2.28638, 0, 0, 0, 0, 120, 0, 1),
(87916, 175606, 229, -101.886, -521.985, -7.84199, -0.0349063, 0, 0, 0, 0, 120, 0, 1),
(87917, 175606, 229, -102.465, -575.651, 9.90089, 2.47837, 0, 0, 0, 0, 120, 0, 1),
(87918, 175606, 229, -112.21, -569.506, 10.1992, 2.18166, 0, 0, 0, 0, 120, 0, 1),
(87919, 175606, 229, -125.229, -576.664, 13.7726, -0.296705, 0, 0, 0, 0, 120, 0, 1),
(87925, 175606, 229, -132.404, -514.961, -15.9374, -1.79769, 0, 0, 0, 0, 120, 0, 1),
(87924, 175606, 229, -132.261, -474.848, 9.82244, -2.82743, 0, 0, 0, 0, 120, 0, 1),
(87936, 175606, 229, -154.889, -570.339, 10.0172, 2.47837, 0, 0, 0, 0, 120, 0, 1),
(87934, 175606, 229, -154.592, -525.219, 8.16182, 2.04204, 0, 0, 0, 0, 120, 0, 1),
(87933, 175606, 229, -154.378, -552.234, 9.91885, -2.05949, 0, 0, 0, 0, 120, 0, 1),
(87932, 175606, 229, -153.788, -515.227, -15.9504, -0.95993, 0, 0, 0, 0, 120, 0, 1),
(87931, 175606, 229, -150.104, -470.008, 16.2278, 1.76278, 0, 0, 0, 0, 120, 0, 1),
(87930, 175606, 229, -147.881, -448.549, 20.0911, 1.32645, 0, 0, 0, 0, 120, 0, 1),
(87922, 175606, 229, -131.57, -439.602, 22.8934, -1.13446, 0, 0, 0, 0, 120, 0, 1),
(87935, 175606, 229, -154.77, -541.317, 9.02217, -0.104719, 0, 0, 0, 0, 120, 0, 1),
(87929, 175606, 229, -146.907, -441.463, 22.4744, -0.802851, 0, 0, 0, 0, 120, 0, 1),
(87928, 175606, 229, -144.505, -441.603, 23.1016, 0.331611, 0, 0, 0, 0, 120, 0, 1),
(87927, 175606, 229, -139.153, -434.738, 23.1123, -2.74016, 0, 0, 0, 0, 120, 0, 1),
(87926, 175606, 229, -138.894, -439.497, 24.8088, 1.76278, 0, 0, 0, 0, 120, 0, 1),
(87913, 175588, 229, -139.523, -525.879, 6.36398, -2.426, 0, 0, 0, 0, 120, 0, 1),

-- chests
(87906, 153464, 229, -36.1176, -583.828, -18.8201, 1.97222, 0, 0, 0, 0, 120, 0, 1),
(87909, 153469, 229, 86.8551, -587.501, 30.6085, 2.63544, 0, 0, 0, 0, 120, 0, 1),
(87908, 153469, 229, -84.2677, -350.104, 70.9524, 1.91986, 0, 0, 0, 0, 120, 0, 1),
(87907, 153469, 229, -73.9985, -453.335, -18.935, -3.08918, 0, 0, 0, 0, 120, 0, 1),

-- Doodad_BOSSGATE02 draks second gate ubrs uses sd2 id
(87855, 175947, 229, 45.1933, -312.52, 106.533, 3.14159, 0, 0, 0, 0, 180, 100, 1),

-- bijous belongings
-- Source 1xtdb 2x http://www.wowdb.net/quest-4982.html
(87911, 175334, 229, 33.7166, -466.067, -18.4651, -1.53589, 0, 0, 0, 0, 120, 0, 1),
(87977, 175334, 229, -78.5492, -402.515, -18.935, 5.53805, 0, 0, 0.36401, -0.931395, 25, 100, 1),
(87978, 175334, 229, -9.06949, -462.313, -18.6442, 3.13474, 0, 0, 0.999994, 0.00342519, 25, 100, 1);

-- Pooling of bijous belongings
DELETE FROM `pool_template` WHERE `entry` = 1073;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(1073, 1, 'QUEST OBJECT - Bijous Belongings - 175334');
DELETE FROM `pool_gameobject_template` WHERE `id` = 175334;
INSERT INTO `pool_gameobject_template` (`id`, `pool_entry`, `chance`, `description`) VALUES
(175334, 1073, 0, 'Bijous Belongings');

-- Adjust runes in ubrs pyroguard emberseer room and delete extra rune (theres a duplicate)
Update `gameobject` set `position_x` = 126.4257, `position_y` = -240.77, `position_z` = 91.4701 where `guid` = 82601;
Update `gameobject` set `position_x` = 162.310, `position_y` = -240.765, `position_z` = 91.4688 where `guid` = 82602;
Update `gameobject` set `position_x` = 162.395, `position_y` = -258.904, `position_z` = 91.4701 where `guid` = 82604;
Update `gameobject` set `position_x` = 126.337, `position_y` = -258.731, `position_z` = 91.4701 where `guid` = 82603;
Update `gameobject` set `position_x` = 126.314, `position_y` = -276.79, `position_z` = 91.4701 where `guid` = 82605;
delete from `gameobject` where `guid` = 232791;

-- fifth  mosharu tablet place correctly (move to wall at the moment just tossed strangely in room)
-- http://www.lurkerlounge.com/forums/thread-6826.html
update `gameobject` set `position_x` = -128.234, `position_y` = -482.381, `position_z` = 25.7435, `orientation` = 6.27245, `rotation2` = 0.00536574, `rotation3` = -0.999986 where `guid` = 30277;

-- sixth mosharu tablet place correctly (move to wall at the moment just tossed strangely in room)
-- http://www.lurkerlounge.com/forums/thread-6826.html
update `gameobject` set `position_x` = -11.1345, `position_y` = -465.705, `position_z` = -16.8553, `orientation` = 1.5577, `rotation2` = 0.69938, `rotation3` = 0.71475  where `guid` = 30278;

-- Lower blackrock spire fall out teleport. currently if you fall out of lbrs you do not get teleported, therefore you can fall through the world
DELETE FROM `areatrigger_teleport` where `id` = 2068;
INSERT INTO `areatrigger_teleport` (`id`, `name`, `required_level`, `required_item`, `required_item2`, `required_quest_done`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(2068, 'Blackrock Spire - Fall out', 0, 0, 0, 0, 0, -7524.19, -1230.13, 285.743, 2.09544);

-- Add Bijou source http://www.lurkerlounge.com/forums/thread-6826.html
DELETE FROM `creature` WHERE `guid` = 83030;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(83030, 10257, 229, 9553, 0, -5.93244, -553.565, 16.1868, 2.87606, 3520, 0, 0, 8774, 0, 0, 0);

-- Added npc Naxxramas Military Sub-Boss Trigger For gothic fight
-- Updated Naxxramas Military Sub-Boss Trigger level. 80 to 60, and unit flag from 130 to 2
-- 130 = 128 CREATURE_FLAG_EXTRA_INVISIBLE + 2 CREATURE_FLAG_EXTRA_CIVILIAN  otherwise spell visuals are also invisible upon spellhit (can see only with gm on
-- Source tdb
UPDATE `creature_template` SET `minlevel` = 60, `maxlevel` = 60, `flags_extra` = 2 WHERE `entry` = 16137;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2714.03, `position_y` = -3430.7,  `position_z` = 268.563, `orientation` = 4.01511, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88359;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2669.94, `position_y` = -3429.76, `position_z` = 268.563, `orientation` = 5.74927, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88360;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2643.73, `position_y` = -3321.73, `position_z` = 284.233, `orientation` = 6.19592, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88361;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2725.82, `position_y` = -3309.57, `position_z` = 267.769, `orientation` = 2.82743, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88362;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2664.87, `position_y` = -3340.75, `position_z` = 267.767, `orientation` = 5.93412, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88363;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2643.73, `position_y` = -3399.68, `position_z` = 284.183, `orientation` = 6.0912,  `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88364;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2700.27, `position_y` = -3322.35, `position_z` = 267.768, `orientation` = 3.52556, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88365;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2683.89, `position_y` = -3304.21, `position_z` = 267.768, `orientation` = 2.49582, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88366;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2739.99, `position_y` = -3399.78, `position_z` = 284.295, `orientation` = 6.10865, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88367;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2692.21, `position_y` = -3428.78, `position_z` = 268.646, `orientation` = 1.48353, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88368;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2739.99, `position_y` = -3321.73, `position_z` = 284.232, `orientation` = 2.82743, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88369;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2733.46, `position_y` = -3349.39, `position_z` = 267.768, `orientation` = 1.78024, `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88370;
UPDATE `creature` set `id` = 16137, `modelid` = 11686, `position_x` = 2692.16, `position_y` = -3430.75, `position_z` = 268.646, `orientation` = 1.6057,  `spawntimesecs` =  3600, `curhealth` = 17010 where `guid` = 88371;

-- Change Spectral death knight/Unrelenting Death Knight name also Unrelenting rider/unrelenting trainee/Spectral rider faction rank
UPDATE `creature_template` SET `faction_A` = 21, `faction_H` = 21, `rank` = 1 WHERE `entry` = 16126;
UPDATE `creature_template` SET `faction_A` = 21, `faction_H` = 21, `rank` = 1 WHERE `entry` = 16124;
UPDATE `creature_template` SET `name` = 'Unrelenting Deathknight', `faction_A` = 21, `faction_H` = 21, `rank` = 1 WHERE `entry` = 16125;
UPDATE `creature_template` SET `name` = 'Spectral Deathknight', `faction_A` = 21, `faction_H` = 21, `rank` = 1 WHERE `entry` = 16148;
UPDATE `creature_template` SET `faction_A` = 21, `faction_H` = 21, `rank` = 1 WHERE `entry` = 16150;

-- Add quest start script to Vyletongue Corruption (7029 & 7041)
UPDATE `quest_template` SET `StartScript`=7029 WHERE `StartScript`=7029;
UPDATE `quest_template` SET `StartScript`=7041 WHERE `StartScript`=7041;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` IN (7029, 7041);
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(7029, 0, 0, 0, 0, 0, 0, 0, 2000005465, 0, 0, 0, 0, 0, 0, 0, 'Vark Battlescar - Talk'),
(7041, 0, 0, 0, 0, 0, 0, 0, 2000005465, 0, 0, 0, 0, 0, 0, 0, 'Talendria - Talk');

DELETE FROM `db_script_string` WHERE `entry`=2000005465;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(2000005465, '$N, please take a look at the sample of the Vylestem vine that I took from the caverns, so that you know what to look for...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL);

-- Various fixes attibuted to Ela/cala/swatter/neotrim/tdb thanks

-- Fixes size for creature 1895 (Pyrewood Elder) which was way too big compared to other inhabitants of Pyrewood village
-- Source (hes huge set model to 0 normal size)
UPDATE `creature_template` SET `scale` = 0 WHERE `entry` = 1895;

-- Removed item 5422 (Brambleweed Leggings) from reference_loot_table
-- to creature_loot_table of NPC 3672 (Boahn) with a 51% drop chance
-- Thanks to Neotmiren for pointing
-- Source: http://www.wowhead.com/item=5422
-- http://www.wowwiki.com/Brambleweed_Leggings?oldid=691064
-- http://www.wowdb.com/items/5422-brambleweed-leggings#dropped-by-npc
-- http://wowd.org/items/5422.html
DELETE FROM `creature_loot_template` WHERE `entry` = 3672 AND `item` = 5422;
INSERT INTO `creature_loot_template` VALUES
(3672, 5422, 51, 0, 1, 1, 0);
DELETE FROM `reference_loot_template` WHERE `item` = 5422;

-- War Effort Commanders Now Have Their Correct Mounts
-- http://www.wowwiki.com/Warlord_Gorchuk   http://www.wowwiki.com/Field_Marshal_Snowfall
-- http://www.wowwiki.com/Commander_Stronghammer http://www.wowwiki.com/General_Zog
DELETE FROM `creature_template_addon` where`entry` IN (15701,15700,15458,15539);
INSERT INTO `creature_template_addon` (`entry`,`mount`) VALUES
(15701,14347),
(15700,14573),
(15458,14346),
(15539,14575);

-- Storm Shadowhoof in Winterspring set to aggresive when hit for alliance (quest is flagged for horde only)
-- Faction thunderbluff.
-- change faction and scale http://www.wowhead.com/npc=10303 sdb src
UPDATE `creature_template` SET `faction_a` = 104, `faction_h` = 104, `scale`='1.38'  WHERE (`entry`='10303');
-- remove remote controlled golem from deadmines and burning imp from lbrs (both summoned)
DELETE FROM `creature` WHERE `id` IN (9708,2520);

-- Updated size of gameobjects 1610, 1667 (Incendicite Mineral Vein) to make it match other veins size
-- http://wowbane.com/Wetlands-Incendicite-Ore.html
-- http://www.wowdb.net/object-1610.html
UPDATE `gameobject_template` SET `size` = 0.7 WHERE `entry` IN (1610, 1667);

-- Adds missing equipment for NPC 9237 (War Master Voone)
-- Thanks Stan84 for pointing and fixing
-- Source: http://www.wowhead.com/npc=9237#screenshots
DELETE FROM `creature_equip_template_raw` WHERE `entry` = 967;
INSERT INTO `creature_equip_template_raw` VALUES
(967, 22319, 22319, 0, 33488898, 33488898, 0, 781, 781, 0);
-- Link equipment to NPC 9237
UPDATE `creature_template` SET `equipment_id` = 967 WHERE `entry` = 9237;

-- Fixed equipment for creature 14423 (Officer Jaxon), 14438 (Officer Pomeroy) and 14439 (Officer Brady) who should have their weapon unsheathed while patrolling
-- Thanks stan84 for pointing
-- Source: http://www.wowhead.com/npc=14423#screenshots
-- Source: http://www.wowhead.com/npc=14438#screenshots
-- Source: http://www.wowhead.com/npc=14439#screenshots
UPDATE `creature_addon` SET `b2_0_sheath` = 1 WHERE `guid` IN (79818, 90484, 79768);

-- Fixed equipment for creature 10429 (Rend Blackhand) who should wear a polearm
-- Thanks stan84 for pointing
-- Source: http://www.wowhead.com/npc=10429#screenshots
UPDATE `creature_template` SET `equipment_id` = 1082  WHERE `entry` = 10429;

-- Fixed equipment for creature 11486 (Prince Tortheldrin) who should wear two swords
-- Thanks stan84 for pointing
-- Source: http://www.wowhead.com/npc=11486#screenshots
UPDATE `creature_template` SET `equipment_id` =  1203  WHERE `entry` = 11486;
DELETE FROM `creature_equip_template_raw` WHERE `entry` = 1203;
INSERT INTO `creature_equip_template_raw` VALUES
(1203, 30638, 30638, 0, 33490690, 33490690, 0, 781, 781, 0);

-- Adds conditions to t1 and t2 shaman/paladin
-- http://wow.joystiq.com/2006/12/07/judgement-dropping-for-horde-working-as-intended/
-- https://github.com/FeenixServerProject/Phoenix_1.12.1_Issue_tracker/issues/2617
-- https://github.com/FeenixServerProject/Phoenix_1.12.1_Issue_tracker/issues/1826
-- Added condition to paladin and shaman items of tier 1 and 2 to prevent them from dropping for opposite faction

-- Shaman
-- Earthfury Tier 1 (items from 16837 to 16844)
UPDATE `reference_loot_template` SET `condition_id` = 4 WHERE `item` BETWEEN 16837 AND 16844;
UPDATE `creature_loot_template` SET `condition_id` = 4 WHERE `item` BETWEEN 16837 AND 16844;
UPDATE `reference_loot_template` SET `condition_id` = 4 WHERE `item` BETWEEN 16943 AND 16950;
-- Paladin
-- Lawbringer Tier 1 (items from 16853 to 16860)
UPDATE `reference_loot_template` SET `condition_id` = 5 WHERE `item` BETWEEN 16853 AND 16860;
UPDATE `creature_loot_template` SET `condition_id` = 5 WHERE `item` BETWEEN 16853 AND 16860;
-- Judgement Tier 2 (items from 16951 to 16958)
UPDATE `reference_loot_template` SET `condition_id` = 5 WHERE `item` BETWEEN 16951 AND 16958;
UPDATE `reference_loot_template` SET `condition_id` = 4 where `item` = 16946;
UPDATE `reference_loot_template` SET `condition_id` = 5 where `item` = 16954;
-- draconic for dummys quest item 100%
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `entry` = 11502 AND `item` = 21110;
-- setting required source so it only drops for those with quest
UPDATE `quest_template` SET `ReqSourceId1`=21110, `ReqSourceCount1` = 1 WHERE `entry`= 8620;

-- Fixed stealth aura missing for creatures 947 (Rohh the Silent), 3457 (Razormane Stalker), 684 (Shadowmaw Panther)
-- Thanks scotty0100 for pointing
-- Rohh the Silent
-- Source: http://www.wowhead.com/npc=947/rohh-the-silent#comments:id=117974
UPDATE `creature_template_addon` SET `b2_0_sheath` = 1, `auras` = 6408 WHERE `entry` = 947;
DELETE FROM `creature_addon` WHERE `guid` IN (28480, 134148, 134149, 134150, 134151, 134152, 134153, 134154, 134155, 134156, 134157, 134158, 134159);
INSERT INTO `creature_addon` VALUES
(28480, 0, 33554432, 1, 16, 0, 0, '6408'),
(134148, 0, 33554432, 1, 16, 0, 0, '6408'),
(134149, 0, 33554432, 1, 16, 0, 0, '6408'),
(134150, 0, 33554432, 1, 16, 0, 0, '6408'),
(134151, 0, 33554432, 1, 16, 0, 0, '6408'),
(134152, 0, 33554432, 1, 16, 0, 0, '6408'),
(134153, 0, 33554432, 1, 16, 0, 0, '6408'),
(134154, 0, 33554432, 1, 16, 0, 0, '6408'),
(134155, 0, 33554432, 1, 16, 0, 0, '6408'),
(134156, 0, 33554432, 1, 16, 0, 0, '6408'),
(134157, 0, 33554432, 1, 16, 0, 0, '6408'),
(134158, 0, 33554432, 1, 16, 0, 0, '6408'),
(134159, 0, 33554432, 1, 16, 0, 0, '6408');

-- Shadowmaw Panthers
-- Source: http://www.wowhead.com/npc=684/shadowmaw-panther#comments:id=71387
UPDATE `creature_addon` SET `bytes1` = 33554432, `auras` = '6408' WHERE `guid` IN (1109, 1224, 1231, 1260, 1297, 1328, 1343, 1347, 1350, 1352, 1354, 1424, 1666, 1864, 1865, 1866, 1899, 1900, 1930, 2058, 2062, 2558, 2578, 2583, 2585);

-- Razormane Stalkers
-- Source: http://www.wowhead.com/npc=3457#comments:id=328513
UPDATE `creature_addon` SET `auras` = '6408' WHERE `guid` IN (14447, 14448, 14449, 14450, 14451, 14452, 14453, 14454, 14455, 14456, 14457, 14458, 14459, 14460, 14461, 14462, 14463);

-- Quest Harlan Needs a Resupply (forum - thx Axel, that he found this bug)
-- turns him to face harlan bagley during his rounds
UPDATE `creature_movement_template` SET `orientation` = 2.66 WHERE `entry` = 1433 AND point = 15;

-- Fixes type and faction for creature 14305 (Human Orphan) as it was
UPDATE `creature_template` SET `type` = 7, `faction_A` =12, `faction_H` =12 WHERE `entry` =14305; -- Human Orphan

-- Min lvl quest 256 choksul min level to 15
-- http://wowd.org/quests/256.html
UPDATE `quest_template` SET `MinLevel` = 15 WHERE `entry` = 256;

-- lvl change quest 181 look to the stars
-- http://wowd.org/quests/181.html
UPDATE `quest_template` SET `MinLevel` = 20, `QuestLevel` = 30 WHERE `entry` = 181;

-- (Half-buried Bottle)
-- http://www.wowwiki.com/Half-Buried_Bottle
-- http://wow.magelo.com/en/object/2560#_tab_1-- http://www.wowhead.com/object=2560#contains and comments

DELETE FROM `gameobject_loot_template` WHERE `entry` = 2032;
INSERT INTO `gameobject_loot_template` VALUES
(2032, 1477, 2.5, 0, 1, 1, 0),
(2032, 1711, 4.2, 0, 1, 1, 0),
(2032, 2289, 2.7, 0, 1, 1, 0),
(2032, 2290, 4.4, 0, 1, 1, 0),
(2032, 3608, 0.02, 0, 1, 1, 0),
(2032, 3830, 0.02, 0, 1, 1, 0),
(2032, 3866, 0.02, 0, 1, 1, 0),
(2032, 3867, 0.02, 0, 1, 1, 0),
(2032, 3868, 0.02, 0, 1, 1, 0),
(2032, 3869, 0.02, 0, 1, 1, 0),
(2032, 3870, 0.02, 0, 1, 1, 0),
(2032, 3872, 0.02, 0, 1, 1, 0),
(2032, 3874, 0.02, 0, 1, 1, 0),
(2032, 4098, 25, 0, 1, 1, 0),
(2032, 4100, 15.5, 0, 1, 1, 0),
(2032, 4101, 16.3, 0, 1, 1, 0),
(2032, 4102, 17.2, 0, 1, 1, 0),
(2032, 4298, 0.02, 0, 1, 1, 0),
(2032, 4299, 0.02, 0, 1, 1, 0),
(2032, 4350, 0.02, 0, 1, 1, 0),
(2032, 4351, 0.02, 0, 1, 1, 0),
(2032, 4352, 0.02, 0, 1, 1, 0),
(2032, 4412, 0.02, 0, 1, 1, 0),
(2032, 4414, 0.02, 0, 1, 1, 0),
(2032, 4416, 0.02, 0, 1, 1, 0),
(2032, 4417, 0.02, 0, 1, 1, 0),
(2032, 5543, 0.02, 0, 1, 1, 0),
(2032, 5774, 0.02, 0, 1, 1, 0),
(2032, 6045, 0.02, 0, 1, 1, 0),
(2032, 6454, 0.02, 0, 1, 1, 0),
(2032, 7085, 0.02, 0, 1, 1, 0),
(2032, 7090, 0.02, 0, 1, 1, 0),
(2032, 7360, 0.02, 0, 1, 1, 0),
(2032, 7363, 0.02, 0, 1, 1, 0),
(2032, 7364, 0.02, 0, 1, 1, 0),
(2032, 7449, 0.02, 0, 1, 1, 0),
(2032, 7450, 0.02, 0, 1, 1, 0),
(2032, 7975, 0.1, 0, 1, 1, 0),
(2032, 7992, 0.0508056, 0, 1, 1, 0),
(2032, 8029, 0.0508056, 0, 1, 1, 0),
(2032, 8385, 0.0508056, 0, 1, 1, 0),
(2032, 8386, 0.0580636, 0, 1, 1, 0),
(2032, 8387, 0.0725795, 0, 1, 1, 0),
(2032, 9293, 0.0435477, 0, 1, 1, 0),
(2032, 10300, 0.1, 0, 1, 1, 0),
(2032, 10301, 0.1, 0, 1, 1, 0),
(2032, 10302, 0.0653215, 0, 1, 1, 0),
(2032, 10312, 0.0290318, 0, 1, 1, 0),
(2032, 10424, 0.02, 0, 1, 1, 0),
(2032, 10601, 0.02, 0, 1, 1, 0),
(2032, 10603, 0.0362897, 0, 1, 1, 0),
(2032, 10604, 0.0653215, 0, 1, 1, 0),
(2032, 10606, 0.1, 0, 1, 1, 0),
(2032, 11098, 0.02, 0, 1, 1, 0),
(2032, 11164, 0.02, 0, 1, 1, 0),
(2032, 11165, 0.02, 0, 1, 1, 0),
(2032, 11167, 0.02, 0, 1, 1, 0),
(2032, 11202, 0.0290318, 0, 1, 1, 0),
(2032, 11204, 0.1, 0, 1, 1, 0);

-- Added gossip menu to creature 3216 (Neeru Fireblade (Hidden Enemies) 5727
UPDATE `creature_template` SET `gossip_menu_id` = 3701 WHERE `entry` = 3216;

DELETE FROM `gossip_menu` WHERE `entry` IN (3701,3702,3703,3704,3705);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(3701,4513,0,0), -- 1st
(3702,4533,0,0), -- 2nd
(3703,4534,0,0), -- 3rd
(3704,4535,0,0), -- 4th
(3705,4536,0,0); -- last
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (3701,3702,3703,3704);
INSERT INTO `gossip_menu_option`
(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`,`condition_id`) VALUES
(3701,0,0, 'You may speak frankly, Neeru...' ,1,1,3702,0,0,0,0,NULL,107),
(3702,0,0, 'It is good to see the Burning Blade is taking over where the Shadow Council once failed.' ,1,1,3703,0,0,0,0,NULL,0),
(3703,0,0, 'So the Searing Blade is expendable?' ,1,1,3704,0,0,0,0,NULL,0),
(3704,0,0, 'If there is anything you would have of me...' ,1,1,3705,0,370500,0,0,NULL,0); -- Must Link to Final Action Menu as well
DELETE FROM `dbscripts_on_gossip` WHERE `id`=370500;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(370500,1,7,5727,5,0,0,0,0,0,0,0,0,0,0,0,0); -- Complete external event
UPDATE `quest_template` SET `SpecialFlags`= 2 WHERE `entry`=5727;
-- Condition so gossips don't show up if the player doesn't have the item 9 = (on quest active in log)
DELETE FROM `conditions` where `condition_entry` = 107;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
(107, 9, 5727, 0);

-- Adds dwarf priest quest 5647 (A Lack of Fear) from Night Elf priest trainers
-- It is currently only existing in DB for Human and Dwarf priest trainers
-- source: http://www.wowhead.com/quest=5647
DELETE FROM `quest_template` WHERE `entry` = 5647;
INSERT INTO `quest_template` VALUES
(5647, 2, -262, 20, 20, 0, 16, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5641, 0, 0, 0, 0, 'A Lack of Fear', 'Your race is so very strong, $N. We are proud to call you allies. And as each day\'s sun sets, you and your kin grow closer to not only finding your true origins, but find great confidence that you are on the right path in so many things. That feeling must make you feel so triumphant.$B$BWord came from Ironforge just recently. It asked that you return there and speak to High Priest Rohan in the Mystic Ward. I would not keep him waiting. May Elune guide your travels.', 'Speak to High Priest Rohan in Ironforge.', 'You\'ve got the makings of a great $C, $N. Keep up the good work!$B$BYou\'ve already shown you\'re ready for battle. Perhaps it\'s time we taught ya a little somethin\' more.', '', '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19337, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
-- Link quest to creature 4092 (Lariia <Priest Trainer>) as she is the Night Elf priest trainer
-- redirecting other races to their respective trainers for racial quests (like Desperate Prayer)
DELETE FROM `creature_questrelation` WHERE `id` = 4092 AND `quest` = 5647;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES
(4092, 5647);
-- Updates target creature 11406 (High Priest Rohan) to complete the quest
DELETE FROM `creature_involvedrelation` WHERE `id` = 11406 AND `quest` = 5647;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES
(11406, 5647);

-- Fixes required race for paladin quests 1641 (Tome of Divinity - Human) and 1645 (Tome of Divinity - Dwarf)
-- as they were previously available for both races while next quests were not.
-- Set race to human only for human quest line
UPDATE `quest_template` SET `RequiredRaces` = 1 WHERE `entry` = 1641;
-- Set race to dwarf only for dwarf quest line
UPDATE `quest_template` SET `RequiredRaces` = 4 WHERE `entry` = 1645;

-- Source Direct from Tdb
-- Pathing for 10
-- Positions for 25
-- http://wowpedia.org/Searing_Infernal
-- http://wowpedia.org/Roaming_Felguard
-- http://wowpedia.org/Mannoroc_Lasher
-- http://wowpedia.org/Maggot

-- Searing infernal roams to far and goes out of model
UPDATE `creature` SET `spawndist`=1 WHERE `guid`=20082;
-- Maggots to large
UPDATE `creature_template` SET `scale`=0 WHERE `entry`=16030;
-- Set Existing Felguards to path
UPDATE `creature` set `MovementType` = 2 where `guid` IN (20872,20874,20876);
-- Add missing npcs
DELETE FROM `creature` where `guid` BETWEEN 58200 AND 58224;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `deathstate`, `MovementType`) VALUES
(58200, 11697, 1,  0, 0, 1377.44, -2831.15, 108.027, 5.77812, 300, 0, 0, 952, 811, 0,  2),
(58201, 11697, 1,  0, 0, 1442.84, -2781.55, 143.33, 3.40741, 300, 2, 0, 952, 811, 0,  1),
(58202, 11697, 1,  0, 0, 1520.55, -2910.79, 128.79, 0.370891, 300, 1, 0, 952, 811, 0,  1),
(58203, 11697, 1,  0, 0, 1525.12, -2850.32, 182.265, 5.1565, 300, 0, 0, 952, 811, 0,  2),
(58204, 11697, 1,  0, 0, 1538.94, -2878.93, 183.464, 1.23918, 300, 0, 0, 952, 811, 0,  0),
(58205, 11697, 1,  0, 0, 1544.03, -2848.75, 182.515, 5.044, 300, 0, 0, 952, 811, 0,  0),
(58206, 11697, 1,  0, 0, 1544.42, -2863, 112.056, 2.70184, 300, 2, 0, 952, 811, 0,  1),
(58207, 11697, 1,  0, 0, 1563.02, -2859.16, 182.293, 4.06662, 300, 0, 0, 952, 811, 0,  0),
(58208, 11697, 1,  0, 0, 1581.57, -2897.42, 182.329, 1.43117, 300, 0, 0, 952, 811, 0,  0),
(58209, 16030, 1,  0, 0, 1625.75, -3095.01, 89.1229, 2.2015, 300, 10, 0, 8, 0, 0,  1),
(58210, 16030, 1,  0, 0, 1636.01, -3052.93, 90.0757, 4.71536, 300, 10, 0, 8, 0, 0,  1),
(58211, 16030, 1,  0, 0, 1647.72, -3076.71, 88.3328, 1.01697, 300, 10, 0, 8, 0, 0,  1),
(58212, 6073, 1, 0, 0, 1420.36, -2797, 153.297, 4.15846, 300, 0, 0, 986, 0, 0,  0),
(58213, 6073, 1, 0, 0, 1451.37, -2815.77, 154.216, 4.38523, 300, 0, 0, 986, 0, 0,  0),
(58214, 6073, 1, 0, 0, 1500.76, -2835.74, 111.587, 5.95405, 300, 0, 0, 986, 0, 0,  0),
(58215, 6115, 1, 0, 0, 1606.02, -2979.19, 182.067, 2.85391, 300, 0, 0, 1089, 0, 0,  2),
(58216, 6073, 1, 0, 0, 1550.41, -2885.67, 132.955, 4.35423, 300, 0, 0, 986, 0, 0,  0),
(58217, 6073, 1, 0, 0, 1555.71, -2901.45, 182.44, 3.85718, 300, 3, 0, 986, 0, 0,  1),
(58218, 6073, 1, 0, 0, 1566.78, -2894.13, 132.596, 0.195648, 300, 0, 0, 986, 0, 0,  0),
(58219, 6073, 1, 0, 0, 1537.93, -2823.11, 181.607, 5.28222, 300, 0, 0, 986, 0, 0,  0),
(58220, 6073, 1, 0, 0, 1583.34, -2959.56, 182.253, 5.41046, 300, 0, 0, 986, 0, 0,  0),
(58221, 6115, 1, 0, 0, 1418.67, -2849.54, 133.129, 0.943858, 300, 0, 0, 1089, 0, 0,  2),
(58222, 6115, 1, 0, 0, 1461.95, -2777.58, 154.924, 4.63733, 300, 0, 0, 1089, 0, 0,  2),
(58223, 6115, 1, 0, 0, 1529.59, -2869.34, 124.593, 4.90235, 300, 0, 0, 1089, 0, 0,  2),
(58224, 6115, 1, 0, 0, 1682.38, -3116.47, 89.555, 1.34784, 300, 0, 0, 1089, 0, 0,  2);

-- Pathing
DELETE FROM `creature_movement` WHERE `id` IN (58200,58203,58215,58221,58222,58223,58224,20872,20874,20876);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(58200, 0, 1377.44, -2831.15, 108.027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 1, 1382.23, -2827.56, 108.826, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 2, 1391.73, -2823.1, 109.964, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 3, 1403.63, -2820.42, 113.993, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 4, 1414.02, -2821.88, 116.553, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 5, 1425.68, -2823.23, 118.282, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 6, 1437.26, -2822.14, 120.388, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 7, 1444.38, -2817.18, 120.541, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 8, 1439.56, -2812.11, 120.443, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 9, 1429.91, -2806.32, 121.627, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 10, 1420.17, -2802.42, 122.529, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 11, 1406.44, -2799.52, 123.336, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 12, 1408.15, -2806.98, 124.64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 13, 1411.56, -2817.52, 130.557, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 14, 1414.25, -2826.45, 134.03, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 15, 1416.99, -2833.9, 134.159, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 16, 1418.68, -2841.62, 134.089, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 17, 1417.68, -2851.52, 133.206, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 18, 1419.57, -2843.88, 134.064, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 19, 1418.28, -2835.08, 133.903, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 20, 1413.76, -2826.06, 133.872, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 21, 1410.71, -2816.01, 129.678, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 22, 1407.74, -2804.35, 123.423, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 23, 1411.13, -2800.36, 123.362, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 24, 1423.22, -2802.81, 122.215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 25, 1432.72, -2807.23, 121.249, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 26, 1442.87, -2811.43, 120.475, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 27, 1442.99, -2817.75, 120.496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 28, 1432.81, -2820.32, 120.215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 29, 1422.91, -2822.05, 118.091, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 30, 1411.09, -2819.57, 115.682, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 31, 1400.67, -2819.33, 113.069, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 32, 1392.44, -2822.63, 110.105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58200, 33, 1381.68, -2827.95, 108.544, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 0, 1525.12, -2850.32, 182.265, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 1, 1531.2, -2840.05, 182.316, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 2, 1540.61, -2830.15, 182.036, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 3, 1550.37, -2824.62, 181.914, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 4, 1560.61, -2825.6, 181.714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 5, 1573.44, -2834.2, 181.62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 6, 1573.68, -2843.12, 182.237, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 7, 1575.5, -2852.66, 183.287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 8, 1573.92, -2863.64, 182.804, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 9, 1568.23, -2881.09, 183.118, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 10, 1558.65, -2884.78, 183.471, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 11, 1549.38, -2877.01, 182.97, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58203, 12, 1541.13, -2864.69, 182.265, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 0, 1606.02, -2979.19, 182.067, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 1, 1592.61, -2967.98, 181.735, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 2, 1584.64, -2961.7, 182.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 3, 1576.77, -2950.72, 182.331, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 4, 1570.19, -2937.65, 181.648, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 5, 1569.35, -2915.37, 181.607, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 6, 1567.29, -2897.67, 181.974, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 7, 1561.56, -2883.12, 183.536, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 8, 1554.51, -2870.6, 182.784, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 9, 1559.56, -2883.65, 183.535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 10, 1565.66, -2900.05, 181.914, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 11, 1570.2, -2913.28, 181.572, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 12, 1573.81, -2932.62, 181.726, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 13, 1579.7, -2949.06, 182.504, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 14, 1586.54, -2960.6, 182.165, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58215, 15, 1596, -2972.9, 181.873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 0, 1418.67, -2849.54, 133.129, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 1, 1419.05, -2840.87, 133.873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 2, 1416.69, -2834.15, 134.138, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 3, 1414.61, -2827.47, 134.225, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 4, 1412.58, -2820.77, 132.077, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 5, 1409.09, -2810.66, 126.843, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 6, 1411.3, -2817.29, 130.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 7, 1413.9, -2826.61, 134.035, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 8, 1416.53, -2833.09, 134.308, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58221, 9, 1418.74, -2841.77, 134.127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 0, 1461.95, -2777.58, 154.924, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 1, 1465.13, -2767.57, 154.857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 2, 1472.37, -2758.64, 156.073, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 3, 1482.15, -2754.23, 156.293, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 4, 1494, -2752.11, 158.143, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 5, 1497.64, -2753.63, 159.106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 6, 1500.6, -2760.66, 160.423, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 7, 1501.83, -2768.01, 160.797, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 8, 1503.9, -2771.08, 161.295, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 9, 1509.37, -2777.2, 163.673, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 10, 1512.18, -2785.97, 165.084, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 11, 1513.8, -2792.1, 165.634, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 12, 1518.17, -2796.06, 165.139, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 13, 1524.35, -2800.77, 167.72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 14, 1525.07, -2806.12, 169.22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 15, 1522.83, -2812.21, 170.962, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 16, 1511.61, -2814.37, 174.127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 17, 1510.14, -2812.83, 174.583, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 18, 1507.54, -2804.13, 177.22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 19, 1510.85, -2799.4, 178.859, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 20, 1516.89, -2797.35, 180.676, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 21, 1522.65, -2800.57, 182.536, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 22, 1524.14, -2803.74, 183.546, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 23, 1525.99, -2809.31, 183.374, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 24, 1531.26, -2816.57, 183.529, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 25, 1525.76, -2811.33, 183.374, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 26, 1524.78, -2808.99, 183.374, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 27, 1523.44, -2802.63, 183.127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 28, 1517.13, -2796.26, 180.712, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 29, 1513.05, -2798, 179.479, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 30, 1507.43, -2804.46, 177.127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 31, 1508.34, -2810.7, 175.403, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 32, 1511.2, -2812.71, 174.372, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 33, 1517.65, -2814.7, 172.516, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 34, 1522.48, -2811.2, 170.816, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 35, 1524.92, -2804.58, 168.84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 36, 1522.21, -2800.14, 167.21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 37, 1515.74, -2793.85, 165.49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 38, 1513.62, -2789.28, 165.761, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 39, 1511.7, -2782.55, 165.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 40, 1509.51, -2776.44, 163.673, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 41, 1504.34, -2768.24, 160.875, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 42, 1499.62, -2758.87, 160.066, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 43, 1492.98, -2750.64, 158.08, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 44, 1487.86, -2750.59, 157.577, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 45, 1478.63, -2755.59, 155.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 46, 1469.61, -2761.45, 155.948, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 47, 1465.01, -2767.51, 154.873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58222, 48, 1462.42, -2775.39, 155.379, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 0, 1529.59, -2869.34, 124.593, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 1, 1521.65, -2867.31, 125.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 2, 1513.95, -2865.16, 121.647, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 3, 1505.4, -2862.67, 118.802, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 4, 1503.57, -2868.24, 116.714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 5, 1502.71, -2874.97, 113.316, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 6, 1512.91, -2877.69, 111.03, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 7, 1521.64, -2882.19, 111.867, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 8, 1529.31, -2885.16, 111.464, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 9, 1539.29, -2881.08, 112.202, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 10, 1543.73, -2870.51, 112.592, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 11, 1538.33, -2855.84, 111.516, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 12, 1527.17, -2852.84, 111.963, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 13, 1519.44, -2860.6, 111.479, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 14, 1511.97, -2870.45, 111.601, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 15, 1507.42, -2876.43, 112.033, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 16, 1504.04, -2877.9, 112.834, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 17, 1502.58, -2873.35, 113.795, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 18, 1505, -2866.78, 117.746, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 19, 1506.12, -2863.15, 118.807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 20, 1513.88, -2865.62, 121.674, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58223, 21, 1527.2, -2868.42, 124.731, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 0, 1682.38, -3116.47, 89.555, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 1, 1674.62, -3109.4, 88.9762, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 2, 1658.96, -3095.42, 89.2658, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 3, 1653.57, -3084.08, 88.6866, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 4, 1646.3, -3068.17, 88.8051, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 5, 1636.78, -3059.66, 88.9738, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 6, 1624.32, -3060.5, 89.1423, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 7, 1617.47, -3070.3, 89.1846, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 8, 1617.1, -3082.55, 89.3179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 9, 1627.49, -3091.39, 88.6581, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 10, 1637.34, -3094.99, 88.3819, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 11, 1650.98, -3098.08, 88.3894, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58224, 12, 1665.72, -3104.71, 88.8148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 0, 1445.67, -2785.96, 144.079, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 1, 1450.66, -2799.6, 144.582, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 2, 1457.76, -2801.68, 145.51, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 3, 1467.13, -2804.87, 147.88, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 4, 1476.77, -2806.02, 149.54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 5, 1478.05, -2798.39, 149.963, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 6, 1473.79, -2787.38, 152.504, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 7, 1468.06, -2783.52, 154.801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 8, 1460.11, -2782.34, 154.57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 9, 1466.06, -2783.57, 155.144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 10, 1473.38, -2788.68, 152.408, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 11, 1477.98, -2797.37, 150.017, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 12, 1473.04, -2804.99, 149.483, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 13, 1465.72, -2806.2, 147.414, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 14, 1457.34, -2802.4, 145.514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20872, 15, 1450.98, -2794.12, 144.332, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 0, 1427.13, -2794.93, 153.368, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 1, 1434.87, -2792.61, 153.984, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 2, 1439.88, -2789.65, 156.962, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 3, 1446.39, -2787.08, 158.248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 4, 1452.75, -2784.16, 156.517, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 5, 1461.06, -2782.99, 154.608, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 6, 1459.08, -2790.69, 157.111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 7, 1457.62, -2795.23, 158.473, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 8, 1455.8, -2801.99, 158.056, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 9, 1453.83, -2808.71, 155.066, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 10, 1451.86, -2814.85, 153.94, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 11, 1453.88, -2807.04, 155.887, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 12, 1457.24, -2798.09, 158.691, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 13, 1459.89, -2791.61, 157.409, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 14, 1461.22, -2782.31, 154.564, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 15, 1450.71, -2784.91, 157.357, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 16, 1444.17, -2787.41, 158.144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20874, 17, 1434.53, -2791.57, 154.062, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 0, 1519.06, -2911.23, 128.725, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 1, 1520.78, -2904.44, 130.02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 2, 1523.58, -2894.32, 129.76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 3, 1525.4, -2887.57, 129.65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 4, 1527.51, -2880.89, 127.859, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 5, 1530.47, -2871.78, 124.707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 6, 1534.4, -2865.13, 124.945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 7, 1541.49, -2857.39, 129.325, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 8, 1546.34, -2852.34, 129.805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 9, 1551.96, -2845.88, 129.61, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 10, 1547.11, -2851.71, 129.801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 11, 1542.21, -2856.7, 129.542, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 12, 1534.89, -2864.23, 125.346, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 13, 1530.25, -2871.38, 124.679, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 14, 1528.43, -2877.17, 126.128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 15, 1525.86, -2887.35, 129.626, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 16, 1523.78, -2894.03, 129.771, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20876, 17, 1521.69, -2900.71, 129.564, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Tdb and comparion
-- http://www.youtube.com/watch?v=asKYQoMPbks

-- Spire Spiderling -  Die on Evade'' removed as there are -static- spawns it kills that should stay alive on evade
-- http://www.playthingofthegods.net/LBRSWorgPupGuide/LBRSWorgPupGuide.htm http://wowpedia.org/Spire_Spiderling
-- http://www.lurkerlounge.com/forums/thread-6826.html
-- Quote:More bad news: The spiders that hatch from the eggs stay up, so you have to avoid them next time through.
DELETE FROM `creature_ai_scripts` where `id` = 1037501;
UPDATE `creature_template` set `AIName` = '' where `entry` = 10375;

-- Bloodaxe worg pup increase size (atm tiny )
-- Source (not far up from bottom) http://www.playthingofthegods.net/LBRSWorgPupGuide/LBRSWorgPupGuide.htm
UPDATE `creature_template` SET `scale`=1 WHERE `entry`=10221;

-- Awbee gossip http://wowpedia.org/Awbee
-- Source udb 402 http://www.wowhead.com/npc=10740/awbee
UPDATE `creature_template` SET `gossip_menu_id` =3063, `npcflag` = 3 WHERE `entry`=10740;
DELETE FROM `gossip_menu` where `entry` IN (3063,3064,3065,3066);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(3063, 3797, 0, 0),
(3064, 3798, 0, 0),
(3065, 3799, 0, 0),
(3066, 3800, 0, 0);
DELETE FROM `gossip_menu_option` where `menu_id` IN (3063,3064,3065,3066);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
(3063, 0, 0, 'You will be ok, Awbee. Your assailants have been terminated.', 1, 1, 3064, 0, 0, 0, 0, '', 0),
(3064, 0, 0, 'Continue please...', 1, 1, 3065, 0, 0, 0, 0, '', 0),
(3065, 0, 0, 'Horrifying.', 1, 1, 3066, 0, 0, 0, 0, '', 0),
(3066, 0, 0, 'Absolutely.', 1, 1, -1, 0, 0, 0, 0, '', 0);

-- Blackhand Veteran and Blackhand Dreadweaver Emote talk Tdb
DELETE FROM `creature_ai_scripts` where `id` IN (981906,981713);
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
(981906, 9819, 1, 0, 100, 1, 0, 8000, 12000, 14000, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 'Blackhand Veteran - OOC - emote'),
(981713, 9817, 1, 0, 100, 1, 0, 8000, 12000, 14000, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 'Blackhand Dreadweaver - OOC - emote');

-- 1st room last rune set so its alight like the other 6
UPDATE `gameobject` SET `spawntimesecs`=180, `animprogress`=255, `state`=0 WHERE `guid`=35790;
-- Ubrs Unforged Runic Breastplate align to stand (was lying on floor)
UPDATE `gameobject` set `position_x` = 147.228, `position_y` = -240.436, `position_z` = 112.205, `orientation` = 4.66492, `rotation2` = 0.72369, `rotation3` = -0.690125 where `guid` = 35792;

-- Link patrols
DELETE FROM `creature_linking` WHERE `guid` IN (58029,58083,58084,58082,58081,58043);
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES
-- Lbrs entry pats link
(58029, 58030, 515),
-- Ubrs draks room guard link
(58083, 58067, 515),
(58084, 58067, 515),
(58082, 58067, 515),
(58081, 58067, 515),
-- 2nd lbrs pat link
(58043, 58018, 515);

-- Remove Gyth and Lord Victor Nefarius and set trash to non move
DELETE FROM `creature` where `guid` IN (41877,41812);
UPDATE `creature_template` SET `MovementType` = 0 WHERE `entry` IN (10429,10442,10447,10742,10339);

-- add more npcs Source Tdb
-- Lbrs Mobs
DELETE FROM `creature` where `guid` BETWEEN 58000 AND 58087;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `deathstate`, `MovementType`) VALUES
(58000, 9045, 229, 0, 0, 107.024, -306.314, 54.0037, 4.2237, 10800, 0, 0, 5890, 2041, 0, 0),
(58001, 9045, 229, 0, 0, 107.412, -329.583, 54.0033, 5.20108, 10800, 0, 0, 5890, 2041, 0, 0),
(58002, 9045, 229, 0, 0, 14.1216, -259.228, 65.4331, 2.35619, 10800, 0, 0, 5890, 2041, 0, 0),
(58003, 9045, 229, 0, 0, 48.0625, -257.407, 65.4592, 0.418879, 10800, 0, 0, 5890, 2041, 0, 0),
(58004, 9045, 229, 0, 0, 18.0154, -276.734, 65.3758, 1.03067, 10800, 4, 0, 5890, 2041, 0, 1),
(58005, 9045, 229, 0, 0, 52.8444, -312.811, 54.0037, 0.575959, 10800, 0, 0, 5890, 2041, 0, 0),
(58006, 9045, 229, 0, 0, 80.2288, -313.64, 55.7827, 4.93724, 10800, 5, 0, 5890, 2041, 0, 1),
(58007, 9045, 229, 0, 0, 79.8655, -353.92, 60.7854, 0.872665, 10800, 4, 0, 5890, 2041, 0, 1),
(58008, 9097, 229, 0, 0, 102.43, -314.698, 54.0012, 1.06465, 10800, 0, 0, 7557, 0, 0, 0),
(58009, 9097, 229, 0, 0, 107.279, -324.247, 54.0037, 3.50811, 10800, 0, 0, 7557, 0, 0, 0),
(58010, 9097, 229, 0, 0, 107.633, -311.387, 54.0037, 2.67035, 10800, 0, 0, 7557, 0, 0, 0),
(58011, 9097, 229, 0, 0, 12.893, -329.743, 48.8472, 3.15905, 10800, 0, 0, 7557, 0, 0, 0),
(58012, 9097, 229, 0, 0, 12.9406, -279.608, 65.452, 5.96903, 10800, 5, 0, 7557, 0, 0, 1),
(58013, 9097, 229, 0, 0, 18.7628, -284.284, 65.4592, 2.1293, 10800, 5, 0, 7557, 0, 0, 1),
(58014, 9097, 229, 0, 0, 30.9196, -399.683, 48.7868, 3.00197, 10800, 0, 0, 7557, 0, 0, 0),
(58015, 9097, 229, 0, 0, 43.5522, -274.522, 65.4592, 6.10865, 10800, 4, 0, 7557, 0, 0, 1),
(58016, 9097, 229, 0, 0, 45.8465, -279.354, 65.3547, 1.03703, 10800, 4, 0, 7557, 0, 0, 1),
(58017, 9097, 229, 0, 0, 51.8909, -287.351, 65.4592, 3.03687, 10800, 0, 0, 7557, 0, 0, 0),
(58018, 9097, 229, 0, 0, 53.4595, -325.36, 53.916, 1.39626, 10800, 0, 0, 7557, 0, 0, 2),
(58019, 9097, 229, 0, 0, 57.5052, -314.922, 54.0019, 2.26893, 10800, 0, 0, 7557, 0, 0, 0),
(58020, 9097, 229, 0, 0, 57.8383, -310.132, 54.0015, 3.57792, 10800, 0, 0, 7557, 0, 0, 0),
(58021, 9097, 229, 0, 0, 6.909, -271.978, 65.4107, 0.20944, 10800, 0, 0, 7557, 0, 0, 0),
(58022, 9097, 229, 0, 0, 66.2384, -274.532, 60.7346, 6.23083, 10800, 0, 0, 7557, 0, 0, 0),
(58023, 9097, 229, 0, 0, 69.6397, -278.318, 60.6777, 0.296706, 10800, 0, 0, 7557, 0, 0, 0),
(58024, 10318, 229, 0, 0, 117.291, -562.613, 107.403, 5.98648, 10800, 0, 0, 15700, 0, 0, 2),
(58025, 9097, 229, 0, 0, 8.43384, -253.377, 65.4404, 5.46288, 10800, 0, 0, 7557, 0, 0, 0),
(58026, 9097, 229, 0, 0, 71.4322, -317.43, 55.7848, 5.90014, 10800, 5, 0, 7557, 0, 0, 1),
(58027, 9097, 229, 0, 0, 85.2124, -357.967, 60.7854, 6.05629, 10800, 4, 0, 7557, 0, 0, 1),
(58028, 9097, 229, 0, 0, 70.9496, -282.071, 60.6077, 2.49933, 10800, 0, 0, 7557, 0, 0, 2),
(58029, 9097, 229, 0, 0, 81.974, -288.075, 60.6613, 3.38828, 10800, 0, 0, 7557, 0, 0, 2),
(58030, 9097, 229, 0, 0, 83.9848, -287.04, 60.643, 3.38829, 10800, 0, 0, 7557, 0, 0, 2),
(58031, 9097, 229, 0, 0, 9.05815, -257.731, 65.4136, 0.698132, 10800, 0, 0, 7557, 0, 0, 0),
(58032, 9097, 229, 0, 0, 9.25125, -332.557, 48.795, 1.23918, 10800, 0, 0, 7557, 0, 0, 0),
(58033, 9097, 229, 0, 0, 90.2249, -280.722, 60.6818, 4.83456, 10800, 0, 0, 7557, 0, 0, 0),
(58034, 9097, 229, 0, 0, 91.5369, -361.906, 60.702, 1.54309, 10800, 4, 0, 7557, 0, 0, 1),
(58035, 9097, 229, 0, 0, 94.6544, -275.047, 60.7526, 3.14159, 10800, 0, 0, 7557, 0, 0, 0),
(58036, 9098, 229, 0, 0, 102.172, -308.932, 54.0021, 5.91667, 10800, 0, 0, 5961, 4082, 0, 0),
(58037, 9098, 229, 0, 0, 105.506, -332.577, 54.0027, 6.23083, 10800, 0, 0, 5961, 4082, 0, 0),
(58038, 9098, 229, 0, 0, 14.2494, -254.14, 65.4355, 3.68264, 10800, 0, 0, 5961, 4082, 0, 0),
(58039, 9098, 229, 0, 0, 29.0992, -396.495, 48.8011, 4.53786, 10800, 0, 0, 5961, 4082, 0, 0),
(58040, 9098, 229, 0, 0, 47.6855, -270.914, 65.3638, 6.24155, 10800, 4, 0, 5961, 4082, 0, 1),
(58041, 9098, 229, 0, 0, 52.1843, -307.34, 54.0019, 5.25344, 10800, 0, 0, 5961, 4082, 0, 0),
(58042, 9098, 229, 0, 0, 52.4136, -255.367, 65.4592, 3.63028, 10800, 0, 0, 5961, 4082, 0, 0),
(58043, 9098, 229, 0, 0, 53.4595, -325.36, 53.916, 1.39626, 10800, 0, 0, 5961, 4082, 0, 0),
(58044, 9098, 229, 0, 0, 8.8431, -326.523, 48.8573, 5.11381, 10800, 0, 0, 5961, 4082, 0, 0),
(58045, 9098, 229, 0, 0, 81.9816, -321.303, 55.7799, 4.93724, 10800, 6, 0, 5961, 4082, 0, 1),
(58046, 9098, 229, 0, 0, 90.1113, -354.348, 60.7854, 4.4855, 10800, 4, 0, 5961, 4082, 0, 1),
(58047, 9416, 229, 0, 0, 15.7057, -319.695, 48.9296, 4.81711, 10800, 0, 0, 3049, 0, 0, 0),
(58048, 9416, 229, 0, 0, 21.6264, -319.308, 48.9218, 4.59022, 10800, 0, 0, 3049, 0, 0, 0),
(58049, 9416, 229, 0, 0, 39.9758, -401.308, 48.734, 1.37881, 10800, 0, 0, 3049, 0, 0, 0),
(58050, 9416, 229, 0, 0, 44.2465, -401.75, 48.8482, 1.41372, 10800, 0, 0, 3049, 0, 0, 0),
(58051, 9258, 229, 0, 0, 18.6335, -319.564, 48.9254, 4.69494, 10800, 0, 0, 7527., 0, 0, 0),
(58052, 9258, 229, 0, 0, 42.2404, -400.9, 48.789, 1.39626, 10800, 0, 0, 7527., 0, 0, 0),
(58053, 9257, 229, 0, 0, 26.0838, -398.582, 48.8248, 6.07375, 10800, 0, 0, 5898, 2041, 0, 0),
-- Ubrs Mobs
(58054, 9818, 229, 0, 0, 130.432, -340.068, 71.0431, 3.1765, 10800, 0, 0, 7009, 2369, 0, 0),
(58055, 9818, 229, 0, 0, 224.405, -307.493, 77.0506, 0.785398, 10800, 0, 0, 7009, 2369, 0, 0),
(58056, 9818, 229, 0, 0, 223.704, -297.484, 77.0515, 5.46288, 10800, 0, 0, 7009, 2369, 0, 0),
(58057, 9818, 229, 0, 0, 188.856, -258.877, 77.0358, 6.07375, 10800, 0, 0, 7009, 2369, 0, 0),
(58058, 9817, 229, 0, 0, 159.043, -288.596, 71.0319, 3.64774, 10800, 0, 0, 7212, 2434 , 0, 0),
(58059, 9817, 229, 0, 0, 190.633, -263.959, 77.0332, 0.959931, 10800, 0, 0, 7212, 2434 , 0, 0),
(58060, 9817, 229, 0, 0, 128.321, -295.045, 71.0612, 3.87463, 10800, 0, 0, 7212, 2434 , 0, 0),
(58061, 9817, 229, 0, 0, 120.969, -296.045, 70.944, 5.552, 10800, 0, 0, 7212, 2434 , 0, 0),
(58062, 10319, 229, 0, 0, 42.5142, -431.719, 111.029, 5.93412, 10800, 0, 0, 12205 , 0, 0, 0),
(58063, 10319, 229, 0, 0, 25.9504, -431.148, 111.036, 3.45575, 10800, 0, 0, 12205 , 0, 0, 0),
(58064, 10371, 229, 0, 0, 33.9682, -327.537, 111.027, 4.72984, 10800, 0, 0, 19323, 0, 0, 0),
(58065, 10371, 229, 0, 0, -10.6943, -350.008, 111.029, 0.855211, 10800, 0, 0, 19323, 0, 0, 0),
(58066, 10371, 229, 0, 0, -16.0222, -263.335, 111.036, 5.70723, 10800, 0, 0, 19323, 0, 0, 0),
(58067, 10371, 229, 0, 0, 17.7263, -263.467, 110.943, 3.65105, 10800, 0, 0, 19323, 0, 0, 2),
(58068, 10372, 229, 0, 0, 26.4126, -327.414, 111.027, 4.79966, 10800, 0, 0, 18800, 0, 0, 0),
(58069, 10372, 229, 0, 0, -15.5815, -344.315, 111.027, 0.715585, 10800, 0, 0, 18800, 0, 0, 0),
(58070, 10372, 229, 0, 0, -10.344, -259.275, 111.027, 5.157, 10800, 0, 0, 18800, 0, 0, 0),
(58071, 10317, 229, 0, 0, -18.4047, -338.186, 111.027, 0.593412, 10800, 0, 0, 15217, 0, 0, 0),
(58072, 10317, 229, 0, 0, -5.02656, -352.543, 111.027, 0.959931, 10800, 0, 0, 15217, 0, 0, 0),
(58073, 10318, 229, 0, 0, 37.3332, -333.779, 111.027, 4.66003, 10800, 0, 0, 15700, 0, 0, 0),
(58074, 10317, 229, 0, 0, 30.4171, -332.907, 111.027, 4.76475, 10800, 0, 0, 15217, 0, 0, 0),
(58075, 10318, 229, 0, 0, -9.047, -266.921, 111.027, 5.718, 10800, 0, 0, 15700, 0, 0, 0),
(58076, 10317, 229, 0, 0, -13.7762, -274.926, 111.027, 5.89921, 10800, 0, 0, 15217, 0, 0, 0),
(58077, 10083, 229, 0, 0, 136.424, -316.189, 111.064, 0.0174533, 10800, 0, 0, 6737, 7860, 0, 0),
(58078, 10083, 229, 0, 0, 136.282, -308.682, 111.073, 0.279253, 10800, 0, 0, 6737, 7860, 0, 0),
(58079, 10318, 229, 0, 0, 27.209, -487.106, 110.949, 2.40855, 10800, 0, 0, 15700, 0, 0, 2),
(58080, 10319, 229, 0, 0, 32.9856, -441.198, 110.948, 3.4383, 10800, 0, 0, 12535, 0, 0, 2),
(58081, 10319, 229, 0, 0, 17.7263, -263.467, 110.943, 3.65105, 10800, 0, 0, 12535, 0, 0, 0),
(58082, 10319, 229, 0, 0, 17.7263, -263.467, 110.943, 3.65105, 10800, 0, 0, 12535, 0, 0, 0),
(58083, 10366, 229, 0, 0, 17.7263, -263.467, 110.943, 3.65105, 10800, 0, 0, 18116, 0, 0, 0),
(58084, 10317, 229, 0, 0, 17.7263, -263.467, 110.943, 3.65105, 10800, 0, 0, 15217, 0, 0, 0),
-- 3 spirestone battlemage add
(58085, 9197, 229, 0, 0, -18.244, -392.326, 48.550, 4.7580, 10800, 0, 0, 11435, 11445, 0, 0),
(58086, 9197, 229, 0, 0, -42.433, -364.162, 51.933, 4.603, 10800, 0, 0, 11435, 11445, 0, 0),
(58087, 9197, 229, 0, 0, -18.428, -376.728, 49.142, 2.1715, 10800, 0, 0, 11435, 11445, 0, 0);

-- Begin pathing
-- Source: Tdb
DELETE FROM `creature_movement` WHERE `id` IN (58018,58028,58029,58030,40275,40500,40501,40515,45826,41823,45825,40497,45829,45828,45831,58067,58079,58080,40458,58024);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
-- Scarshield Legionnaire Lbrs
(58018, 1, 41.5168, -327.276, 53.7463, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 17, 41.5168, -327.276, 53.7463, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 16, 34.5769, -329.267, 53.6296, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 15, 22.0622, -329.214, 48.7563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 14, 18.7198, -332.48, 48.7262, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 13, 18.6102, -346.358, 48.6756, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 12, 20.2517, -349.204, 48.6731, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 11, 35.1303, -349.151, 48.6754, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 10, 37.1637, -352.389, 48.6782, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 9, 37.2667, -364.091, 48.6567, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 8, 37.1637, -352.389, 48.6782, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 7, 35.1303, -349.151, 48.6754, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 6, 20.2517, -349.204, 48.6731, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 5, 18.6102, -346.358, 48.6756, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 4, 18.7198, -332.48, 48.7262, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 3, 22.0622, -329.214, 48.7563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 2, 34.5769, -329.267, 53.6296, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58018, 18, 53.4595, -325.36, 53.916, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Scarshield Legionnaire Lbrs (entry)
(58028, 1, 72.5072, -281.783, 60.6237, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58028, 2, 87.1247, -283.336, 60.6086, 29000, 0, 0, 0, 0, 0, 0, 7, 0, 0, 6.097, 0, 0),
(58028, 3, 86.7408, -283.049, 60.6107, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58028, 4, 70.9496, -282.071, 60.6077, 24000, 0, 0, 0, 0, 0, 0, 69, 0, 0, 3.777, 0, 0),
-- Scarshield Legionnaire Lbrs
(58029, 1, 89.9381, -286.135, 60.5951, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 19, 93.2917, -324.569, 65.4635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 20, 92.3302, -319.026, 65.4952, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 21, 88.1107, -320.541, 65.4697, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 22, 77.1285, -321.647, 65.4606, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 23, 73.9044, -321.041, 65.4619, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 24, 70.8984, -320.856, 65.4615, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 25, 67.8924, -320.671, 65.4611, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 26, 62.8699, -314.552, 65.4635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 27, 62.3815, -310.165, 65.4635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 28, 62.1636, -298.094, 60.9048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 29, 62.0786, -295.281, 60.7565, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 30, 66.5189, -289.695, 60.6581, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 31, 71.1994, -288.528, 60.6103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 32, 76.7199, -286.148, 60.667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 18, 95.2904, -329.295, 65.0196, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 17, 94.9044, -337.612, 61.8113, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 16, 95.9481, -341.314, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 2, 93.2999, -289.36, 60.5976, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 3, 96.0648, -291.15, 60.6264, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 4, 97.3805, -295.306, 60.6733, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 5, 97.9475, -302.046, 62.4287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 6, 97.9478, -313.342, 65.4635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 7, 96.7286, -316.577, 65.4871, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 8, 91.3134, -317.938, 65.4901, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 9, 68.4867, -322.16, 65.4549, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 10, 65.659, -322.929, 65.4505, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 11, 66.5869, -327.411, 65.4635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 12, 66.2184, -330.474, 64.5625, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 13, 66.7119, -333.154, 63.5297, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 14, 66.7489, -344.389, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 15, 94.7288, -344.11, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58029, 33, 83.9848, -287.04, 60.643, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Scarshield Legionnaire Lbrs
(58030, 1, 88.1308, -288.433, 60.6153, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 16, 94.4877, -344.458, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 17, 95.4922, -340.782, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 18, 95.3281, -327.504, 65.4635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 19, 94.6866, -322.019, 65.4659, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 20, 89.4879, -319.026, 65.4938, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 21, 80.7852, -319.461, 65.4714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 22, 70.6172, -318.835, 65.4835, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 23, 65.9269, -314.613, 65.4635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 24, 64.534, -310.319, 65.4635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 25, 64.1376, -297.204, 60.7421, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 26, 67.1428, -292.455, 60.64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 27, 74.2058, -289.41, 60.6412, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 15, 91.5057, -346.17, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 14, 83.8056, -346.314, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 2, 93.4819, -291.869, 60.6323, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 3, 95.9473, -296.932, 60.6652, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 4, 95.9477, -309.726, 65.3904, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 5, 94.9931, -314.949, 65.4793, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 6, 87.0009, -316.962, 65.4838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 7, 71.7164, -319.578, 65.4673, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 8, 65.5863, -320.898, 65.4592, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 9, 64.6919, -327.065, 65.4635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 10, 64.736, -340.491, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 11, 66.1642, -345.61, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 12, 71.373, -346.424, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 13, 75.1596, -346.238, 60.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58030, 28, 81.974, -288.075, 60.6613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Ubrs pathing Tdb
-- Dragon just in ubrs door path
(40275, 1, 137.036, -318.309, 70.9563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 13, 206.769, -288.047, 76.9327, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 14, 206.049, -300.881, 76.9044, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 15, 203.805, -308.685, 76.8987, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 16, 200.091, -314.903, 76.892, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 17, 196.037, -321.532, 76.8849, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 18, 187.264, -325.25, 76.8738, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 19, 172.508, -330.708, 71.6636, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 20, 157.819, -330.472, 70.9563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 21, 151.347, -332.406, 70.9563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 12, 205.403, -280.035, 76.9363, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 11, 197.221, -281.635, 76.9372, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 2, 139.625, -311.595, 70.9563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 3, 145.022, -306.612, 70.9563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 4, 155.634, -307.226, 70.9563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 5, 165.665, -309.29, 70.9563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 6, 179.918, -308.349, 75.0044, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 7, 186.484, -307.375, 76.8804, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 8, 190.417, -303.615, 76.8863, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 9, 190, -295.833, 76.9324, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 10, 192.748, -284.944, 76.9366, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40275, 22, 141.415, -328.32, 70.9563, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Dragon in rookery at top
(40500, 1, 102.492, -284.08, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40500, 2, 103.388, -312.501, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40500, 3, 102.492, -284.08, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40500, 4, 102.111, -255.036, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Orc near dragon path
(40501, 1, 156.655, -261.057, 110.911, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 2, 156.697, -270.709, 110.945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 3, 157.437, -283.381, 110.653, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 4, 156.721, -302.091, 110.655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 5, 155.393, -316.954, 110.658, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 6, 145.795, -316.889, 110.658, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 7, 138.546, -312.556, 110.971, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 8, 128.11, -312.561, 110.948, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 9, 113.444, -312.323, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 10, 107.291, -311.159, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 11, 107.143, -305.034, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 12, 107.968, -294.352, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 13, 108.13, -273.961, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 14, 108.325, -262.696, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 15, 113.576, -260.461, 106.436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 16, 119.512, -259.629, 108.912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 17, 126.887, -258.807, 110.95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 18, 134.264, -256.577, 110.872, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 19, 142.107, -253.858, 110.808, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 20, 149.232, -254.785, 110.835, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40501, 21, 156.027, -256.98, 110.873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Upper dragon near stadium fall in
(40515, 1, 164.673, -366.137, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40515, 2, 159.69, -366.065, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40515, 3, 134.314, -365.853, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40515, 4, 113.681, -366.227, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40515, 5, 134.314, -365.853, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40515, 6, 159.69, -366.065, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Blackhand Iron Guard patrol (before beasts trash)
(45826, 1, 137.876, -449.432, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 2, 142.882, -447.466, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 3, 150.106, -447.552, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 4, 158.939, -447.841, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 5, 162.936, -450.315, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 6, 164.986, -455.795, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 7, 165.879, -465.25, 116.954, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 8, 165.223, -470.568, 116.829, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 9, 158.806, -470.375, 116.826, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 10, 148.989, -470.486, 116.816, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 11, 142.296, -471.539, 116.839, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 12, 127.625, -473.384, 116.845, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 13, 118.149, -473.105, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 14, 109.252, -473.191, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 15, 101.37, -473.117, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 16, 97.2847, -470.1, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 17, 93.7787, -464.77, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 18, 93.1996, -456.881, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 19, 93.0105, -447.581, 113.951, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 20, 92.7964, -437.883, 110.923, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 21, 92.9087, -447.432, 113.951, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 22, 93.261, -456.932, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 23, 94.0509, -465.158, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 24, 97.3934, -470.372, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 25, 101.615, -473.2, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 26, 109.96, -473.221, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 27, 119.431, -472.966, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 28, 129.714, -473.405, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 29, 137.726, -471.057, 116.836, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 30, 137.759, -466.307, 116.807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45826, 31, 137.438, -458.164, 121.874, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Rage Talon Dragon Guard into beasts trash
(41823, 1, 150.917, -475.661, 116.826, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 2, 165.273, -475.48, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 3, 150.917, -475.661, 116.826, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 4, 137.109, -474.652, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 5, 120.161, -474.673, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 6, 106.258, -474.643, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 7, 94.7496, -473.079, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 8, 83.6851, -474.242, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 9, 77.1173, -474.496, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 10, 65.0976, -474.578, 113.951, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 11, 51.9036, -474.688, 110.923, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 12, 64.8587, -474.58, 113.951, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 13, 77.1173, -474.496, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 14, 83.4094, -474.271, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 15, 94.7496, -473.079, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 16, 106.258, -474.643, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 17, 120.161, -474.673, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41823, 18, 137.109, -474.652, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Blackhand Iron Guard patrol into beasts trash
(45825, 1, 83.5422, -474.662, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 2, 93.117, -476.806, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 3, 93.1617, -484.36, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 4, 93.117, -476.806, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 5, 83.6851, -474.694, 116.842, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 6, 70.9019, -474.603, 115.496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 7, 60.6071, -474.358, 112.139, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 8, 45.0526, -476.175, 110.926, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 9, 36.505, -483.864, 110.939, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 10, 24.5104, -485.579, 110.947, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 11, 12.3218, -481.582, 110.936, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 12, 10.0676, -472.998, 110.935, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 13, 17.3661, -456.806, 110.947, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 14, 29.5697, -454.026, 110.96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 15, 35.4522, -454.598, 110.943, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 16, 34.7464, -442.818, 110.945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 17, 33.5042, -417.918, 110.712, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 18, 34.7464, -442.818, 110.945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 19, 35.4522, -454.598, 110.943, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 20, 29.5697, -454.026, 110.96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 21, 17.3661, -456.806, 110.947, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 22, 10.0676, -472.998, 110.935, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 23, 12.3218, -481.582, 110.936, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 24, 24.5104, -485.579, 110.947, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 25, 36.505, -483.864, 110.939, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 26, 45.0526, -476.175, 110.926, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 27, 60.6071, -474.358, 112.139, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45825, 28, 70.9019, -474.603, 115.496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Rage talon flamescale path along Anvilcracks room
(40497, 1, 151.483, -266.668, 110.941, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40497, 2, 151.43, -299.848, 110.655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40497, 3, 151.826, -337.478, 110.948, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40497, 4, 151.43, -299.848, 110.655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Veteran path into Anvilcracks room
(45829, 1, 156.734, -340.574, 110.949, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 2, 161.285, -330.085, 110.941, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 3, 164.349, -321.437, 110.935, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 4, 164.066, -307.895, 110.926, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 5, 161.931, -295.254, 110.937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 6, 161.54, -286.843, 110.94, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 7, 161.626, -276.16, 110.942, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 8, 162.619, -260.48, 110.922, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 9, 160.883, -251.074, 110.911, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 10, 153.333, -254.239, 110.841, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 11, 147.933, -256.874, 110.85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 12, 144.41, -258.089, 110.852, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 13, 142.226, -262.721, 110.888, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 14, 139.325, -272.981, 110.928, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 15, 139.064, -292.411, 110.964, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 16, 138.366, -304.562, 110.976, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 17, 140.202, -318.19, 110.956, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 18, 141.56, -328.348, 110.948, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 19, 145.867, -339.175, 110.95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45829, 20, 151.986, -343.381, 110.952, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Veteran path into arena right trash room
(45828, 1, 137.932, -365.946, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 2, 119.13, -366.058, 116.848, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 3, 137.932, -365.946, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 4, 137.681, -374.135, 116.807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 5, 138.003, -383.829, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 6, 137.621, -374.032, 116.807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 7, 137.28, -358.897, 116.838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 8, 138.01, -349.646, 111.285, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 9, 138.504, -339.926, 110.965, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 10, 138.055, -349.128, 110.97, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 11, 137.272, -358.828, 116.838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 12, 137.975, -366.027, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 13, 151.988, -365.319, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 14, 168.97, -365.253, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 15, 151.988, -365.319, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 16, 137.975, -366.027, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 17, 137.263, -358.934, 116.838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 18, 138.048, -349.209, 110.971, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 19, 138.504, -339.926, 110.965, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 20, 138.01, -349.646, 111.285, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 21, 137.286, -358.828, 116.838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 22, 137.621, -374.032, 116.807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 23, 138.003, -383.829, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45828, 24, 137.681, -374.135, 116.807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Jed runewatcher pathing
(45831, 1, 143.081, -332.039, 110.946, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 2, 137.568, -346.437, 110.972, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 3, 137.582, -349.249, 110.999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 4, 137.404, -357.64, 116.838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 5, 137.005, -366.262, 116.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 6, 137.173, -374.983, 116.807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 7, 137.252, -383.108, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 8, 137.299, -392.334, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 9, 151.393, -392.988, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 10, 165.537, -392.823, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 11, 165.44, -383.058, 121.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 12, 165.651, -374.907, 116.807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 13, 165.556, -367.59, 116.845, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 14, 165.415, -357.528, 116.837, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 15, 165.545, -348.847, 110.969, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 16, 165.094, -341.963, 110.951, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 17, 160.784, -330.969, 110.941, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 18, 160.191, -309.153, 110.656, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 19, 160.079, -280.562, 110.652, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 20, 144.032, -280.615, 110.653, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45831, 21, 142.987, -312.006, 110.658, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Rage Talon Captain Draks room
(58067, 1, 0.073367, -274.516, 110.929, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 2, -0.197867, -320.715, 110.939, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 3, 32.9907, -344.613, 110.943, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 4, 2.70391, -335.468, 110.942, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 5, 21.5374, -315.253, 110.945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 6, 21.8535, -266.793, 110.943, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 7, 21.5374, -315.253, 110.945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 8, 2.70391, -335.468, 110.942, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 9, 32.9907, -344.613, 110.943, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 10, -0.199047, -320.916, 110.942, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 11, 0.073367, -274.516, 110.929, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58067, 12, 17.7263, -263.467, 110.943, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- assasin beast trash path
(58079, 1, 41.0048, -479.188, 110.932, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58079, 2, 40.6946, -470.055, 110.934, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58079, 3, 28.987, -457.701, 110.958, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58079, 4, 19.4282, -458.143, 110.948, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58079, 5, 10.9487, -465.839, 110.938, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58079, 6, 12.0295, -481.36, 110.935, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58079, 7, 27.209, -487.106, 110.949, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Blackhand Iron Guard Patrol beast trash
(58080, 1, 33.2388, -451.331, 110.947, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58080, 2, 27.8349, -467.173, 110.954, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58080, 3, 22.5882, -486.309, 110.945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58080, 4, 21.3946, -495.946, 110.941, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58080, 5, 22.5882, -486.309, 110.945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58080, 6, 27.8349, -467.173, 110.954, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58080, 7, 33.2388, -451.331, 110.947, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58080, 8, 32.9856, -441.198, 110.948, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58080, 9, 33.2187, -432.523, 110.949, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58080, 10, 32.9856, -441.198, 110.948, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Anvilcrack path
(40458, 1, 140.872, -243.59, 110.826, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 2, 140.034, -244.993, 110.804, 7000, 0, 0, 0, 0, 0, 0, 69, 0, 0, 5.714, 0, 0),
(40458, 3, 140.031, -247.348, 110.773, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 4, 142.018, -248.934, 110.779, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 5, 144.882, -250.299, 110.788, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 6, 148.933, -246.427, 110.862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 7, 152.118, -245.322, 110.9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 8, 159.539, -248.629, 110.923, 48000, 0, 0, 0, 0, 0, 0, 133, 0, 0, 0.648, 0, 0),
(40458, 9, 155.153, -243.632, 110.926, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 10, 148.945, -243.166, 110.897, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 11, 147.221, -242.018, 110.895, 70000, 0, 0, 0, 0, 0, 0, 28, 0, 0, 1.539, 0, 0),
(40458, 12, 144.955, -246.962, 110.824, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 13, 147.965, -244.265, 110.877, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 14, 149.641, -243.561, 110.899, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 15, 147.806, -248.505, 110.831, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 16, 148.333, -245.98, 110.862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 17, 152.27, -246.428, 110.89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 18, 147.781, -243.522, 110.884, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 19, 148.172, -245.329, 110.868, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 20, 149.042, -247.2, 110.855, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 21, 150.123, -244.737, 110.89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40458, 22, 145.179, -242.707, 110.871, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- blackhand assasin by beast path
(58024, 1, 117.515, -567.955, 107.125, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 2, 117.291, -562.613, 107.403, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 3, 112.967, -557.621, 107.663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 4, 105.091, -557.245, 107.682, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 5, 96.0483, -553.948, 110.578, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 6, 87.704, -550.909, 110.923, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 7, 79.952, -545.042, 110.939, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 8, 71.7458, -539.995, 110.94, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 9, 63.5328, -534.943, 110.942, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 10, 71.6881, -539.98, 110.94, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 11, 79.952, -545.042, 110.939, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 12, 87.704, -550.909, 110.923, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 13, 96.0483, -553.948, 110.578, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 14, 105.091, -557.245, 107.682, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 15, 112.967, -557.621, 107.663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58024, 16, 117.291, -562.613, 107.403, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Time to position and correct ubrs Tdb
-- Blackhand Dreadweaver path along solakar balcony
UPDATE `creature` set `id` = 9817, `modelid` = 9671, `position_x` = 156.027, `position_y` = -256.98, `position_z` = 110.873, `orientation` = 0.802851, `curhealth` = 7018, `curmana` = 2369, `MovementType` = 2 where `guid` = 40501;
-- Rage talon dragonspawn path along solakar balcony
UPDATE `creature` set `position_x` = 102.111, `position_y` = -255.036, `position_z` = 106.436, `orientation` = 4.7232, `MovementType` = 2 where `guid` = 40500;
-- Rage talon flamescale path along pre arena balcony
UPDATE `creature` set `id` = 10083, `modelid` = 8249, `position_x` = 159.69, `position_y` = -366.065, `position_z` = 116.844, `orientation` = 6.27482, `curhealth` = 6737, `curmana` = 7860, `MovementType` = 2 where `guid` = 40515;
-- Rage talon flamescale path along Anvilcracks room
UPDATE `creature` set `id` = 10083, `modelid` = 8249, `position_x` = 151.43, `position_y` = -299.848, `position_z` = 110.655, `orientation` = 1.58379, `curhealth` = 6737, `curmana` = 7860, `MovementType` = 2 where `guid` = 40497;
-- Five dragons at start are rage talon dragonspawn one path 4 random
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 147.042, `position_y` = -317.722, `position_z` = 70.9564, `orientation` = 3.23265, `spawndist` = 8, `curhealth` = 14250, `MovementType` = 1 where `guid` = 40273;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 161.09, `position_y` = -316.202, `position_z` = 70.9563, `orientation` = 1.91313, `spawndist` = 8, `curhealth` = 14250, `MovementType` = 1 where `guid` = 40274;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 141.415, `position_y` = -328.32, `position_z` = 70.9563, `orientation` = 3.14905, `curhealth` = 14250, `MovementType` = 2 where `guid` = 40275;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `spawndist` = 8, `curhealth` = 14250, `MovementType` = 1 where `guid` = 40276;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `spawndist` = 8, `curhealth` = 14250, `MovementType` = 1 where `guid` = 40277;
-- adjust 4 mobs between emberseer and previous door
UPDATE `creature` set `position_x` = 217.2, `position_y` = -259.564, `position_z` = 82.1871, `orientation` = 6.26573 where `guid` = 40272;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 221.518, `position_y` = -258.424, `position_z` = 82.1293, `orientation` = 3.04174, `curhealth` = 7018, `curmana` = 2369 where `guid` = 45832;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 225.861, `position_y` = -266.147, `position_z` = 82.0873, `orientation` = 3.30034, `curhealth` = 7018, `curmana` = 2369 where `guid` = 40270;
UPDATE `creature` set `position_x` = 225.916, `position_y` = -261.532, `position_z` = 82.1132, `orientation` = 4.10386 where `guid` = 40271;
-- 2 dragons up ramp from solakar are rage talon dragonspawn
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 100.743, `position_y` = -246.005, `position_z` = 106.519, `orientation` = 2.6529, `curhealth` = 18116 where `guid` = 40499;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 101.678, `position_y` = -237.667, `position_z` = 106.519, `orientation` = 3.54302, `curhealth` = 18116 where `guid` = 40498;
-- 2 dragons just after emberseer are rage talon dragonspawn
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 94.5187, `position_y` = -256.703, `position_z` = 91.5369, `orientation` = 6.26573, `curhealth` = 18116 where `guid` = 40457;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 96.1789, `position_y` = -268.54, `position_z` = 91.5311, `orientation` = 1.37881, `curhealth` = 18116 where `guid` = 40456;
-- 2 drakes near solakar are rage talon flamescale
UPDATE `creature` set `id` = 10083, `modelid` = 8249, `position_x` = 81.0064, `position_y` = -284.353, `position_z` = 91.5332, `orientation` = 5.95157, `spawndist` = 7, `curhealth` = 6737, `curmana` = 7860, `MovementType` = 1 where `guid` = 40455;
UPDATE `creature` set `id` = 10083, `modelid` = 8249, `position_x` = 74.9968, `position_y` = -316.266, `position_z` = 91.5203, `orientation` = 5.8618, `spawndist` = 7, `curhealth` = 6737, `curmana` = 7860, `MovementType` = 1 where `guid` = 40454;
-- 3 drakes near solakar move and one is rage talon flamescale
UPDATE `creature` set `id` = 10083, `modelid` = 8249, `position_x` = 102.802, `position_y` = -332.121, `position_z` = 106.519, `orientation` = 2.21657, `curhealth` = 6737, `curmana` = 7860 where `guid` = 40504;
UPDATE `creature` set `position_x` = 105.175, `position_y` = -327.111, `position_z` = 106.519, `orientation` = 2.53073 where `guid` = 40502;
UPDATE `creature` set `position_x` = 97.9175, `position_y` = -333.681, `position_z` = 106.519, `orientation` = 1.93732 where `guid` = 40503;
-- 2 drakes on bridge to drak adjust
UPDATE `creature` set `position_x` = 27.6827, `position_y` = -426.067, `position_z` = 111.009, `orientation` = 5.48033 where `guid` = 42158;
UPDATE `creature` set `position_x` = 39.7524, `position_y` = -426.769, `position_z` = 111.011, `orientation` = 3.9619 where `guid` = 42159;
-- 4 orcs on bridge to drak adjust
UPDATE `creature` set `modelid` = 9890, `position_x` = 29.507, `position_y` = -385.555, `position_z` = 110.748, `orientation` = 5.42797 where `guid` = 42639;
UPDATE `creature` set `position_x` = 30.4782, `position_y` = -381.184, `position_z` = 110.766, `orientation` = 4.97419 where `guid` = 42651;
UPDATE `creature` set `id` = 10318, `modelid` = 9887, `position_x` = 38.164, `position_y` = -385.48, `position_z` = 110.798, `orientation` = 4.18879, `curhealth` = 15700 where `guid` = 42638;
UPDATE `creature` set `position_x` = 37.201, `position_y` = -381.272, `position_z` = 110.683, `orientation` = 4.461 where `guid` = 42652;
-- Hallway to bwl change Blackhand Dragon Handler x2 to Blackhand Iron Guard
UPDATE `creature` set `id` = 10319, `modelid` = 9895, `position_x` = 124.058, `position_y` = -470.959, `position_z` = 116.926, `orientation` = 3.85718, `curhealth` = 12205 where `guid` = 45824;
UPDATE `creature` set `id` = 10319, `modelid` = 9696, `position_x` = 124.094, `position_y` = -478.258, `position_z` = 116.926, `orientation` = 2.37365, `curhealth` = 12205 where `guid` = 45823;
-- 2x dragons overlooking arena correct type and position
UPDATE `creature` set `id` = 10083, `modelid` = 8249, `position_x` = 141.698, `position_y` = -394.829, `position_z` = 122.059, `orientation` = 4.86947, `curhealth` = 6737, `curmana` = 7860 where `guid` = 40516;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 138.316, `position_y` = -395.086, `position_z` = 122.059, `orientation` = 4.76475, `curhealth` = 14250 where `guid` = 40517;
-- 3 mobs in pre beast room adjust
UPDATE `creature` set `position_x` = 43.2278, `position_y` = -449.183, `position_z` = 111.027, `orientation` = 3.85718 where `guid` = 42157;
UPDATE `creature` set `position_x` = 37.9199, `position_y` = -451.057, `position_z` = 111.029, `orientation` = 0.08726 where `guid` = 42187;
UPDATE `creature` set `position_x` = 40.4204, `position_y` = -453.613, `position_z` = 111.024, `orientation` = 1.3439 where `guid` = 42161;
-- 5 mobs in pre beast room adjust
UPDATE `creature` set `id` = 10319, `modelid` = 9895, `position_x` = 11.7395, `position_y` = -460.466, `position_z` = 111.022, `orientation` = 2.80998, `curhealth` = 12205 where `guid` = 42155;
UPDATE `creature` set `id` = 10319, `modelid` = 9696, `position_x` = 10.1527, `position_y` = -457.007, `position_z` = 111.021, `orientation` = 4.50295, `curhealth` = 12205 where `guid` = 42156;
UPDATE `creature` set `position_x` = 6.64531, `position_y` = -460.465, `position_z` = 111.016, `orientation` = 0.418879 where `guid` = 42570;
UPDATE `creature` set `position_x` = 16.306, `position_y` = -449.323, `position_z` = 111.029, `orientation` = 4.46804 where `guid` = 42571;
UPDATE `creature` set `position_x` = 8.80271, `position_y` = -450.548, `position_z` = 111.02, `orientation` = 5.68977 where `guid` = 42572;
-- 7 dragons and orcs before beasts trash fix
UPDATE `creature` set `position_x` = 92.8477, `position_y` = -489.693, `position_z` = 116.926, `orientation` = 1.58825 where `guid` = 41821;
UPDATE `creature` set `position_x` = 86.684, `position_y` = -480.174, `position_z` = 116.926, `orientation` = 0.855211 where `guid` = 41822;
UPDATE `creature` set `position_x` = 99.7287, `position_y` = -479.423, `position_z` = 116.926, `orientation` = 2.75762 where `guid` = 41819;
UPDATE `creature` set `position_x` = 71.4935, `position_y` = -474.606, `position_z` = 115.779, `orientation` = 6.27849 where `guid` = 41820;
UPDATE `creature` set `id` = 10317, `modelid` = 9891, `position_x` = 97.2168, `position_y` = -476.818, `position_z` = 116.926, `orientation` = 5.23599, `curhealth` = 15217 where `guid` = 41814;
UPDATE `creature` set `id` = 10319, `modelid` = 9894, `position_x` = 137.438, `position_y` = -458.164, `position_z` = 121.874, `orientation` = 5.67232, `curhealth` = 12205, `MovementType` = 2 where `guid` = 45826;
UPDATE `creature` set `id` = 10366, `modelid` = 9753, `position_x` = 137.109, `position_y` = -474.652, `position_z` = 116.842, `orientation` = 0.01255, `curhealth` = 18811, `MovementType` = 2 where `guid` = 41823;
UPDATE `creature` set `id` = 10319, `modelid` = 9697, `position_x` = 70.9019, `position_y` = -474.603, `position_z` = 115.496, `orientation` = 5.92132, `curhealth` = 12205, `MovementType` = 2 where `guid` = 45825;
-- Veteran path into Anvilcracks room
UPDATE `creature` set `id` = 9819, `modelid` = 9897, `position_x` = 151.986, `position_y` = -343.381, `position_z` = 110.952, `orientation` = 1.20428, `curhealth` = 8807, `MovementType` = 2 where `guid` = 45829;
-- 6 trash before arena on left
UPDATE `creature` set `position_x` = 172.879, `position_y` = -365.446, `position_z` = 116.926, `orientation` = 2.84489 where `guid` = 40509;
UPDATE `creature` set `position_x` = 178.113, `position_y` = -364.09, `position_z` = 116.926, `orientation` = 4.95674 where `guid` = 40506;
UPDATE `creature` set `id` = 9818, `modelid` = 9849, `position_x` = 179.995, `position_y` = -365.894, `position_z` = 116.926, `orientation` = 3.19395, `curhealth` = 7009, `curmana` = 2369 where `guid` = 40505;
UPDATE `creature` set `id` = 9818, `modelid` = 9849, `position_x` = 170.606, `position_y` = -362.353, `position_z` = 116.924, `orientation` = 4.86947, `curhealth` = 7009, `curmana` = 2369 where `guid` = 40508;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 169.916, `position_y` = -367.141, `position_z` = 116.926, `orientation` = 1.13446, `curhealth` = 7212, `curmana` = 2434 where `guid` = 40510;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 177.831, `position_y` = -367.561, `position_z` = 116.926, `orientation` = 1.15192, `curhealth` = 7212, `curmana` = 2434 where `guid` = 40507;
-- 6 trash before arena on right
UPDATE `creature` set `position_x` = 85.7341, `position_y` = -373.624, `position_z` = 116.926, `orientation` = 0.680678 where `guid` = 40602;
UPDATE `creature` set `position_x` = 90.0266, `position_y` = -367.406, `position_z` = 117.518, `orientation` = 2.51327 where `guid` = 40603;
UPDATE `creature` set `id` = 9818, `modelid` = 9849, `position_x` = 87.1749, `position_y` = -363.085, `position_z` = 117.796, `orientation` = 4.72984, `curhealth` = 7009, `curmana` = 2369 where `guid` = 41320;
UPDATE `creature` set `position_x` = 106.929, `position_y` = -367.276, `position_z` = 116.926, `orientation` = 2.30383 where `guid` = 40601;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 103.098, `position_y` = -364.339, `position_z` = 116.926, `orientation` = 5.86431, `curhealth` = 14250 where `guid` = 40518;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 85.6391, `position_y` = -366.95, `position_z` = 116.926, `orientation` = 0.802851, `curhealth` = 7212, `curmana` = 2434 where `guid` = 40514;
-- Veteran path into arena right trash room
UPDATE `creature` set `id` = 9819, `modelid` = 9897, `position_x` = 137.681, `position_y` = -374.135, `position_z` = 116.807, `orientation` = 5.49779, `curhealth` = 8807, `MovementType` = 2 where `guid` = 45828;
-- 4 dragons end of anvilcracks room adjust
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 136.037, `position_y` = -338.207, `position_z` = 111.044, `orientation` = 0.645772, `curhealth` = 14689  where `guid` = 40491;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 142.593, `position_y` = -342.274, `position_z` = 111.041, `orientation` = 1.39626, `curhealth` = 14689  where `guid` = 40492;
UPDATE `creature` set `id` = 10083, `modelid` = 8249, `position_x` = 161.34, `position_y` = -343.435, `position_z` = 111.039, `orientation` = 1.85005, `curhealth` = 6737, `curmana` = 7860  where `guid` = 40494;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 167.774, `position_y` = -338.655, `position_z` = 111.034, `orientation` = 2.79253, `curhealth` = 14689  where `guid` = 40493;
-- arena outer trash
UPDATE `creature` set `id` = 9818, `modelid` = 9849, `position_x` = 90.1016, `position_y` = -419.204, `position_z` = 111.006, `orientation` = 0.994838, `curhealth` = 7009, `curmana` = 2369 where `guid` = 45827;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 93.9204, `position_y` = -417.965, `position_z` = 111.006, `orientation` = 2.79253, `curhealth` = 7212, `curmana` = 2434 where `guid` = 41780;
UPDATE `creature` set `modelid` = 9897, `position_x` = 87.5, `position_y` = -426.621, `position_z` = 111.006, `orientation` = 5.91667 where `guid` = 41779;
UPDATE `creature` set `position_x` = 92.1094, `position_y` = -415.175, `position_z` = 111.006, `orientation` = 4.59022 where `guid` = 41775;
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 92.245, `position_y` = -427.635, `position_z` = 111.006, `orientation` = 3.15905, `curhealth` = 14250 where `guid` = 41811;
-- two dragons left side of arena balcony change move
UPDATE `creature` set `id` = 9096, `modelid` = 2554, `position_x` = 165.521, `position_y` = -394.921, `position_z` = 122.059, `orientation` = 4.67748, `curhealth` = 18116 where `guid` = 41674;
UPDATE `creature` set `id` = 10083, `modelid` = 8249, `position_x` = 161.314, `position_y` = -393.649, `position_z` = 122.059, `orientation` = 4.86947, `curhealth` = 6737, `curmana` = 7860 where `guid` = 41723;
-- 1st room right dreadweavers and summoner adjust
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 119.028, `position_y` = -340.441, `position_z` = 71.046, `orientation` = 0.0349066, `curhealth` = 7212, `curmana` = 2434 where `guid` = 40259;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 125.033, `position_y` = -346.358, `position_z` = 71.0462, `orientation` = 1.6057, `curhealth` = 7212, `curmana` = 2434 where `guid` = 40258;
UPDATE `creature` set `position_x` = 124.872, `position_y` = -334.523, `position_z` = 71.0431, `orientation` = 4.69494 where `guid` = 40260;
-- 2nd room right summoner and veteran adjust
UPDATE `creature` set `position_x` = 151.103, `position_y` = -358.37, `position_z` = 71.0217, `orientation` = 1.20428 where `guid` = 40261;
UPDATE `creature` set `position_x` = 150.514, `position_y` = -354.058, `position_z` = 71.0197, `orientation` = 5.21853 where `guid` = 40257;
UPDATE `creature` set `position_x` = 157.88, `position_y` = -359.291, `position_z` = 71.0256, `orientation` = 1.53589 where `guid` = 40256;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 159.470, `position_y` = -350.015, `position_z` = 71.0256, `orientation` = 3.133, `curhealth` = 7212, `curmana` = 2434 where `guid` = 45834;
-- 3rd room right summoner and veteran adjust
UPDATE `creature` set `position_x` = 212.137, `position_y` = -339.792, `position_z` = 76.9863, `orientation` = 1.15192 where `guid` = 40263;
UPDATE `creature` set `position_x` = 212.101, `position_y` = -336.132, `position_z` = 76.9559, `orientation` = 5.09636 where `guid` = 40265;
UPDATE `creature` set `position_x` = 222.666, `position_y` = -334.586, `position_z` = 77.013, `orientation` = 3.07178 where `guid` = 40264;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 215.519, `position_y` = -337.733, `position_z` = 76.9524, `orientation` = 3.10669, `curhealth` = 7212, `curmana` = 2434 where `guid` = 45833;
-- 4th room right summoner and dreadweaver adjust
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 234.324, `position_y` = -306.764, `position_z` = 77.0605, `orientation` = 2.44346, `curhealth` = 7212, `curmana` = 2434 where `guid` = 40267;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 232.84, `position_y` = -297.491, `position_z` = 77.0546, `orientation` = 4.08407, `curhealth` = 7212, `curmana` = 2434 where `guid` = 40266;
-- 2nd room left adjust 3
UPDATE `creature` set `position_x` = 156.815, `position_y` = -283.34, `position_z` = 71.0354, `orientation` = 1.98968 where `guid` = 40262;
UPDATE `creature` set `position_x` = 157.249, `position_y` = -291.752, `position_z` = 71.0334, `orientation` = 1.69297 where `guid` = 40255;
UPDATE `creature` set `id` = 9817, `modelid` = 9673, `position_x` = 154.429, `position_y` = -289.456, `position_z` = 71.0298, `orientation` = 6.17847, `curhealth` = 7212, `curmana` = 2434 where `guid` = 40254;
-- 3rd room left adjust 3
UPDATE `creature` set `modelid` = 9897, `position_x` = 191.329, `position_y` = -272.01, `position_z` = 77.0306, `orientation` = 5.61996 where `guid` = 40268;
UPDATE `creature` set `position_x` = 195.222, `position_y` = -271.913, `position_z` = 77.0306, `orientation` = 3.78736 where `guid` = 40269;
UPDATE `creature` set `position_x` = 194.615, `position_y` = -255.948, `position_z` = 77.0195, `orientation` = 4.31096 where `guid` = 40252;
-- anvilcrack trash adjust 3 adds
UPDATE `creature` set `position_x` = 162.63, `position_y` = -243.073, `position_z` = 111.034, `orientation` = 4.32842 where `guid` = 40462;
UPDATE `creature` set `position_x` = 163.503, `position_y` = -247.514, `position_z` = 111.026, `orientation` = 2.0944 where `guid` = 40461;
UPDATE `creature` set `position_x` = 159.269, `position_y` = -245.613, `position_z` = 111.026, `orientation` = 6.23083 where `guid` = 40460;
-- enter jed and pathing
UPDATE `creature` set `id` = 10509, `modelid` = 9686, `position_x` = 165.094, `position_y` = -341.963, `position_z` = 110.951, `orientation` = 1.58882, `curhealth` = 8885, `MovementType` = 2 where `guid` = 45831;
-- 1st room left adjust
UPDATE `creature` set `position_x` = 121.719, `position_y` = -301.577, `position_z` = 71.056, `orientation` = 0.750492 where `guid` = 40253;
UPDATE `creature` set `position_x` = 122.200, `position_y` = -293.707, `position_z` = 71.056, `orientation` = 5.537991 where `guid` = 40251;
-- Draks room adjust Blackhand Iron Guard
UPDATE `creature` set `position_x` = 40.669, `position_y` = -330.527, `position_z` = 111.027, `orientation` = 4.62512 where `guid` = 42662;
UPDATE `creature` set `position_x` = -8.14168, `position_y` = -341.893, `position_z` = 111.027, `orientation` = 0.767945 where `guid` = 42663;
UPDATE `creature` set `position_x` = -3.29208, `position_y` = -259.911, `position_z` = 111.027, `orientation` = 5.48033 where `guid` = 42664;
-- 4 Mob Beasts trash (centre of room)
UPDATE `creature` set `position_x` = 21.4283, `position_y` = -475.195, `position_z` = 111.038, `orientation` = 1.76278 where `guid` = 42569;
UPDATE `creature` set `position_x` = 20.7244, `position_y` = -468.802, `position_z` = 111.035, `orientation` = 4.83456 where `guid` = 42162;
UPDATE `creature` set `position_x` = 18.2124, `position_y` = -471.4, `position_z` = 111.031, `orientation` = 6.17847 where `guid` = 42567;
UPDATE `creature` set `id` = 10318, `modelid` = 9887, `position_x` = 23.5067, `position_y` = -470.538, `position_z` = 111.039, `orientation` = 3.56047, `curhealth` = 15700 where `guid` = 42568;
-- 2 Mob Blackhand Iron Guard (outside bwl portal) adjust
UPDATE `creature` set `position_x` = 172.06, `position_y` = -470.118, `position_z` = 116.908, `orientation` = 3.38594 where `guid` = 41876;
UPDATE `creature` set `position_x` = 172.338, `position_y` = -478.921, `position_z` = 116.908, `orientation` = 3.009 where `guid` = 41875;
-- 2 Mob Blackhand Thug (near awbee)adjust
UPDATE `creature` set `position_x` = 71.7459, `position_y` = -419.106, `position_z` = 111.144, `orientation` = 4.69494 where `guid` = 41783;
UPDATE `creature` set `position_x` = 71.6325, `position_y` = -421.346, `position_z` = 110.795, `orientation` = 1.74533 where `guid` = 41781;
-- 2 dragons anvilcrack room adjust
UPDATE `creature` set `position_x` = 128.02, `position_y` = -315.29, `position_z` = 111.029, `orientation` = 2.98451 where `guid` = 40496;
UPDATE `creature` set `position_x` = 128.02, `position_y` = -310.533, `position_z` = 111.029, `orientation` = 3.27923 where `guid` = 40495;
-- 3 mob near beast room adjust
UPDATE `creature` set `position_x` = 31.2498, `position_y` = -497.101, `position_z` = 111.035, `orientation` = 1.27409 where `guid` = 42153;
UPDATE `creature` set `position_x` = 31.8535, `position_y` = -490.663, `position_z` = 111.036, `orientation` = 4.32842 where `guid` = 42160;
UPDATE `creature` set `id` = 10317, `modelid` = 9890, `position_x` = 35.4868, `position_y` = -492.95, `position_z` = 111.036, `orientation` = 3.05433, `curhealth` = 15217 where `guid` = 42154;
-- Anvilcrack move and path
UPDATE `creature` set `position_x` = 145.179, `position_y` = -242.707, `position_z` = 110.871, `orientation` = 1.7653, `MovementType` = 2 where `guid` = 40458;
-- 2 mob near anvilcrack adjust
UPDATE `creature` set `position_x` = 144.939, `position_y` = -257.132, `position_z` = 110.92, `orientation` = 5.8294 where `guid` = 40459;
UPDATE `creature` set `id` = 9819, `modelid` = 9686, `position_x` = 149.248, `position_y` = -249.037, `position_z` = 110.908, `orientation` = 4.86947, `curhealth` = 9017 where `guid` = 45830;
-- 1 - 4 anvil trash
UPDATE `creature` set `position_x` = 146.275, `position_y` = -275.064, `position_z` = 111.027, `orientation` = 3.10669 where `guid` = 40466;
UPDATE `creature` set `position_x` = 142.973, `position_y` = -277.891, `position_z` = 111.027, `orientation` = 0.139626 where `guid` = 40470;
UPDATE `creature` set `position_x` = 142.902, `position_y` = -275.03, `position_z` = 111.027, `orientation` = 0.0349066 where `guid` = 40469;
UPDATE `creature` set `position_x` = 142.862, `position_y` = -272.084, `position_z` = 111.027, `orientation` = 6.21337 where `guid` = 40468;
-- 2 - 4 anvil trash
UPDATE `creature` set `position_x` = 164.434, `position_y` = -285.266, `position_z` = 111.026, `orientation` = 0 where `guid` = 40467;
UPDATE `creature` set `position_x` = 168.53, `position_y` = -282.207, `position_z` = 111.026, `orientation` = 3.38594 where `guid` = 40481;
UPDATE `creature` set `position_x` = 168.467, `position_y` = -285.357, `position_z` = 111.026, `orientation` = 3.15905 where `guid` = 40471;
UPDATE `creature` set `position_x` = 168.431, `position_y` = -288.574, `position_z` = 111.026, `orientation` = 2.9147 where `guid` = 40482;
-- 3 - 4 anvil trash
UPDATE `creature` set `position_x` = 141.763, `position_y` = -302.243, `position_z` = 111.032, `orientation` = 0.122173 where `guid` = 40486;
UPDATE `creature` set `position_x` = 141.709, `position_y` = -299.483, `position_z` = 111.032, `orientation` = 0.0349066 where `guid` = 40483;
UPDATE `creature` set `position_x` = 141.792, `position_y` = -296.81, `position_z` = 111.032, `orientation` = 6.23083 where `guid` = 40484;
UPDATE `creature` set `id` = 10317, `modelid` = 9890, `position_x` = 144.601, `position_y` = -299.439, `position_z` = 110.735, `orientation` = 3.08923, `curhealth` = 15217  where `guid` = 40485;
-- 4 - 4 anvil trash
UPDATE `creature` set `position_x` = 161.471, `position_y` = -314.998, `position_z` = 111.022, `orientation` = 3.19395 where `guid` = 40490;
UPDATE `creature` set `position_x` = 161.448, `position_y` = -317.886, `position_z` = 111.022, `orientation` = 3.1765 where `guid` = 40487;
UPDATE `creature` set `position_x` = 161.538, `position_y` = -320.877, `position_z` = 111.022, `orientation` = 3.12414 where `guid` = 40488;
UPDATE `creature` set `id` = 10317, `modelid` = 9890, `position_x` = 158.335, `position_y` = -317.906, `position_z` = 110.735, `orientation` = 0.0349066, `curhealth` = 15217  where `guid` = 40489;

-- lbrs ogre urok trash mob remove and reuse placeholder for spirestone warlord
UPDATE `creature` set `id` = 9216, `modelid` = 11582, `position_x` = -10.853, `position_y` = -381.579, `position_z` = 49.1851, `orientation` = 3.1533, `curhealth` = 13936, `curmana` = 0  where `guid` = 45095;

-- Enter Npc Warosh http://www.wowwiki.com/Warosh
UPDATE `creature` set `id` = 10799, `modelid` = 763, `position_x` = 45.7163, `position_y` = -576.1502, `position_z` = 30.7533, `orientation` = 0.841, `curhealth` = 3857, `curmana` = 0  where `guid` = 45838;

-- https://github.com/scriptdev2/scriptdev2/commit/bb69b8038b1e6f1219cb903a0c6a508953bd1c31
--  Quest 995 remove db script
DELETE FROM `dbscripts_on_quest_start` where `id` = 995;
DELETE FROM `db_script_string` WHERE `entry` = 2000000016;

-- https://github.com/scriptdev2/scriptdev2/commit/a743ba78f9f568f6cc739a0afef673be8e3ae1d8
-- Removes required spell cast from quests 6124/6129
UPDATE `quest_template` SET `ReqSpellCast1` = 0 WHERE `entry` IN (6129,6124);

-- https://github.com/scriptdev2/scriptdev2/commit/9d3df48298ba026065206282291748ac8bdfbb7e
-- Quest 4322 Jail break

SET @STRING_START := 2000000067;
delete from `creature_movement_template` where `entry`=9679;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `script_id`) values
(9679,1,549.21,-281.07,-75.27,0),
(9679,2,554.39,-267.39,-73.68,0),
(9679,3,533.59,-249.38,-67.04,0),
(9679,4,519.44,-217.02,-59.34,0),
(9679,5,506.55,-153.49,-62.34,967901);
delete from `creature_movement_template` where `entry`=9022;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `script_id`) values
(9022,1,280.42,-82.86,-77.12,0),
(9022,2,287.64,-87.01,-76.79,0),
(9022,3,354.63,-64.95,-67.53,902201);
delete from `dbscripts_on_creature_movement` where `id` in (902201,967901);
insert into `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `comments`) values
(902201,0,18,0,'Despawn Dughal on last waypoint'),
(967901,0,18,0,'Despawn Tobias on last waypoint');
DELETE FROM `db_script_string` WHERE `entry` in (@STRING_START,@STRING_START+1,@STRING_START+2,@STRING_START+3);
insert into `db_script_string` (`entry`, `content_default`) values
(@STRING_START,'Get him out of there!'),
(@STRING_START+1,'Perhaps Ograbisi will use your head as a tiny little hat when I\'m through with you.'),
(@STRING_START+2,'Where I come from, you get shanked for opening another inmate\'s cell door!'),
(@STRING_START+3,'Ograbisi needs new hat.');
delete from `dbscripts_on_go_template_use` where `id` in (170562,170567,170568,170569);
insert into `dbscripts_on_go_template_use` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `comments`) values
-- dughal
(170562, 1, 0, 0, 0, 9023, 20, 3, @STRING_START, 'Windsor - say on Dughal door open'),
-- jaz
(170568, 1, 0, 0, 0, 9677, 20, 3, @STRING_START+3 ,'Ograbisi - say on Jaz door open'),
(170568, 2, 22, 54, 5, 9681, 20, 3, 0, 'Jaz - change faction to hostile'),
(170568, 2, 22, 54, 5, 9677, 20, 3, 0, 'Ograbisi - change faction to hostile'),
-- shill
(170569, 1, 0, 0, 0, 9678, 20, 3, @STRING_START+1, 'Shill - say on Shill door open'),
(170569, 1, 22, 54, 5, 9678, 20, 3, 0, 'Shill - change faction to hostile'),
-- crest
(170567, 1, 0, 0, 0, 9680, 20, 3, @STRING_START+2, 'Crest - say on Crest door open'),
(170567, 1, 22, 54, 5, 9680, 20, 3, 0, 'Crest - change faction to hostile');

-- https://github.com/scriptdev2/scriptdev2/commit/0d23d645c634403a4e177b16ba5cc01c1a80903f
-- Emberseer update (from sniff)
UPDATE `creature_template` SET `speed_run` = 1.42857146263123, `Unit_Flags` = 33554752, `faction_A` = 40, `faction_H` = 40, `MovementType` = 0 WHERE `entry` = 9816;

-- https://github.com/scriptdev2/scriptdev2/commit/c39fb0c55b9f563a6fbf971bc84132efbf77e6d6
-- Chromaggus door lever and chromaggus enter room
delete from `dbscripts_on_go_use` where `id` = 66908; -- guid for 179148;
insert into `dbscripts_on_go_use` values
(66908,1,11,66900,0,0,0,0,0,0,0,0,0,0,0,0,'Open Chromaggus side door'), -- 66900 = guid of entry 179116
(66908,2,25,1,0,14020,70,0,0,0,0,0,0,0,0,0,'Set Chromaggus run = true'),
(66908,3,3,0,0,14020,70,0,0,0,0,0,-7484.91,-1072.98,476.55,2.18,'Move Chromaggus in the center of the room');

-- https://github.com/scriptdev2/scriptdev2/commit/0c57d7d061fa73e47bb269cd0476bd58b815e6e6
-- spell targets related to AQ20 Ossirian Weakness spells
DELETE FROM `spell_script_target` WHERE `entry` IN (25183, 25177, 25178, 25180, 25181, 25183);
INSERT INTO `spell_script_target` VALUES
(25183, 1, 15339,0),
(25177, 1, 15339,0),
(25178, 1, 15339,0),
(25180, 1, 15339,0),
(25181, 1, 15339,0);
-- A trigger npc (entry 15590) and go (entry 180619) must be spawned
DELETE FROM `creature` WHERE `guid` = 95457;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(95457, 15590, 509, 0, 0, -9407.718, 1960.211, 85.63906, 1.117011, 3520, 0, 0, 9062, 0, 0, 0);

DELETE FROM `gameobject` WHERE `guid` = 40200;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(40200, 180619, 509, -9407.718, 1960.211, 85.63906, 1.117011, 0, 0, 0.134851, 0.990866, 5400, 100, 1);

-- https://github.com/scriptdev2/scriptdev2/commit/ce98ad5a138ee697cd8577108bc09a848f17c0c8
-- Improvement for quest 9364 (set sheep to wander (polymorph clone)
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` = 16479;

-- https://github.com/scriptdev2/scriptdev2/commit/d0030bb6426f9f551f89d73ae9a732b16d23ee31
-- Additional improvements to Uldaman
DELETE FROM `creature_linking_template` WHERE `entry` IN (7309,10120,7076,7077);
INSERT INTO `creature_linking_template` (`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES
(7309, 70, 2748, 20, 0),
(10120, 70, 2748, 20, 0),
(7076, 70, 2748, 20, 0),
(7077, 70, 2748, 20, 0);
DELETE FROM `spell_script_target` WHERE `entry` IN (10258,10252);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) VALUES
(10258, 1, 10120),
(10252, 1, 7076);

-- https://github.com/scriptdev2/scriptdev2/commit/cedc2f582ea8320f86b61119889cd729745548da
-- Ouro
-- update creature id to the spawner - boss is summoned by script
update `creature` set `id` = 15957 where `id` = 15517;
-- delete the bugs from the map - they are summoned
delete from `creature` where `id` = 15718;
-- Fix some flags and factions
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` in (15957,15712,15717);
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 15712;

-- https://github.com/scriptdev2/scriptdev2/commit/c85fe6696968a2df36f77821c45520e614cb6e89
-- Ouro sandworm base script target
delete from `spell_script_target` where `entry` = 26063;
insert into `spell_script_target` values
(26063,0,180795,0);


-- https://github.com/scriptdev2/scriptdev2/commit/3503313f36e745182e0ff72cb7a55a2025f107f3
-- Allow Sapphiron to be spawned using GO 181356
UPDATE `gameobject_template` SET `ScriptName`='go_sapphiron_birth' WHERE `entry`=181356;

-- Pyramid event for Zul'Farrak - SD2 update z2673
-- https://github.com/scriptdev2/scriptdev2/commit/797d2126992288afa13e9a1b0c392d0ad714ae44

-- ZF pyramid
UPDATE `creature` SET `MovementType` = 2 WHERE `id` IN (7607, 7604, 7605, 7606, 7608);
UPDATE `creature_template` SET `MovementType` = 0 WHERE `entry` IN (8877,8876,7275,7796);

DELETE FROM `creature_movement_template` WHERE `entry` IN (7607, 7604, 7605, 7606, 7608);
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `orientation`) VALUES
-- Weegli Blastfuse
(7607,1,1881.05, 1297.36, 48.419, 1000, 760701, 5.41),          -- workaround in order to pause the default wp movement. This is needed to avoid evade complications
(7607,2,1881.741, 1295.994, 48.323, 1000, 760702, 5.41),
(7607,3,1881.001, 1293.345, 47.627, 0, 0, 0),
(7607,4,1880.210, 1290.434, 45.970, 0, 0, 0),                   -- workaround in order to force move maps to do the right move path
(7607,5,1880.210, 1290.434, 45.970, 0, 0, 0),
(7607,6,1891.080, 1284.610, 43.580, 1000, 760706, 4.71),
(7607,7,1883.285, 1263.755, 41.576, 2000, 760707, 4.71),
(7607,8,1889.486, 1271.971, 41.626, 1000, 760701, 4.71),
(7607,9,1895.356, 1227.598, 9.521, 0, 0, 0),
(7607,10,1893.277, 1206.289, 8.877, 1000, 760701, 4.61),
-- blowing the door
(7607,11,1891.670, 1181.687, 8.877, 0, 0, 0),
(7607,12,1876.005, 1161.771, 9.653, 0, 0, 0),
(7607,13,1857.490, 1145.531, 15.119, 1000, 760713, 3.86),
-- run away
(7607,14,1877.107, 1148.825, 10.316, 0, 0, 0),
(7607,15,1886.306, 1137.952, 9.352, 0, 0, 0),
(7607,16,1869.976, 1092.893, 8.876, 0, 1, 0),
-- Sergeant Bly
(7604,1,1882.89, 1299.27, 48.3843, 1000, 760401, 4.83),
(7604,2,1883.395, 1297.178, 48.293, 1000, 760402, 4.83),
(7604,3,1881.001, 1293.345, 47.627, 0, 0, 0),
(7604,4,1880.210, 1290.434, 45.970, 0, 0, 0),
(7604,5,1880.210, 1290.434, 45.970, 0, 0, 0),
(7604,6,1886.896, 1264.077, 41.494, 1000, 760401, 4.71),
(7604,7,1886.703, 1227.956, 9.9242, 0, 0, 0),
(7604,8,1884.289, 1202.936, 8.8781, 60000, 0, 4.61),
(7604,9,1884.289, 1202.936, 8.8781, 15000, 760409, 4.61),
-- Raven
(7605,1,1886.64, 1299.11, 48.3146, 1000, 760501, 4.36),
(7605,2,1886.123, 1297.247, 48.241, 1000, 760502, 4.36),
(7605,3,1881.001, 1293.345, 47.627, 0, 0, 0),
(7605,4,1880.210, 1290.434, 45.970, 0, 0, 0),
(7605,5,1880.210, 1290.434, 45.970, 0, 0, 0),
(7605,6,1890.223, 1264.296, 41.420, 1000, 760501, 4.71),
(7605,7,1895.356, 1227.598, 9.521, 0, 0, 0),
(7605,8,1889.008, 1201.978, 8.878, 60000, 0, 4.54),
(7605,9,1889.008, 1201.978, 8.878, 15000, 760509, 4.54),
-- Oro Eyegouge
(7606,1,1889.62, 1298.01, 48.2581, 1000, 760601, 3.94),
(7606,2,1888.196, 1296.756, 48.203, 1000, 760602, 3.94),
(7606,3,1881.001, 1293.345, 47.627, 0, 0, 0),
(7606,4,1880.210, 1290.434, 45.970, 0, 0, 0),
(7606,5,1880.210, 1290.434, 45.970, 0, 0, 0),
(7606,6,1883.209, 1271.997, 41.850, 1000, 760601, 4.71),
(7606,7,1879.247, 1227.145, 9.276, 0, 0, 0),
(7606,8,1876.139, 1207.258, 8.877, 60000, 0, 4.64),
(7606,9,1876.139, 1207.258, 8.877, 15000, 760609, 4.64),
-- Murta Grimgut
(7608,1,1891.07, 1294.78, 48.2347, 1000, 760801, 3.31),
(7608,2,1889.018, 1294.428, 48.189, 1000, 760802, 3.31),
(7608,3,1881.001, 1293.345, 47.627, 0, 0, 0),
(7608,4,1880.210, 1290.434, 45.970, 0, 0, 0),
(7608,5,1880.210, 1290.434, 45.970, 0, 0, 0),
(7608,6,1886.345, 1271.890, 41.735, 1000, 760801, 4.71),
(7608,7,1886.703, 1227.956, 9.924, 0, 0, 0),
(7608,8,1884.856, 1208.976, 8.878, 60000, 0, 4.61),
(7608,9,1884.856, 1208.976, 8.878, 15000, 760809, 4.61);

-- texts
DELETE FROM `db_script_string` WHERE `entry` IN (2000005547,2000005548,2000005549,2000005550,2000005551,2000005552,2000005553);
INSERT INTO `db_script_string` (`entry`, `content_default` , `sound`, `type`, `language`, `emote`, `comment`) VALUES
(2000005547,'Oh no! Here they come!',0,0,0,0,'Weegli Blastfuse - say event start'),
(2000005548,'Ok, here I go!',0,0,0,0,'Weegli Blastfuse - say blow door normal'),
(2000005549,'What? How dare you say that to me?!?',0,0,0,6,'Sergeant Bly - say faction change 1'),
(2000005550,'After all we\'ve been through? Well, I didn\'t like you anyway!!',0,0,0,5,'Sergeant Bly - say faction change 2'),
(2000005551,'I\'m out of here!',0,0,0,0,'Weegli Blastfuse - say blow door forced'),
(2000005552,'Who dares step into my domain! Come! Come, and be consumed!',0,6,0,0,'Ukorz Sandscalp - say after door blown'),
(2000005553,'Let\'s move forward!',0,0,0,0,'Sergeant Bly - move downstairs');

-- creature move scripts
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` IN (760702,760402,760502,760602,760802,760706,760707,760701,760401,760501,760601,760801);
INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `dataint`, `comments`) VALUES
(760701, 0, 32, 1, 0, 'Weegli Blastfuse - stop movement'),
(760401, 0, 32, 1, 0, 'Sergeant Bly - stop movement'),
(760501, 0, 32, 1, 0, 'Raven - stop movement'),
(760601, 0, 32, 1, 0, 'Oro Eyegouge - stop movement'),
(760801, 0, 32, 1, 0, 'Murta Grimgut - stop movement'),
(760702, 0, 1, 71, 0, 'Sergeant Bly - emote cheer'),
(760402, 0, 1, 71, 0, 'Raven - emote cheer'),
(760502, 0, 1, 71, 0, 'Oro Eyegouge - emote cheer'),
(760602, 0, 1, 71, 0, 'Weegli Blastfuse - emote cheer'),
(760802, 0, 1, 71, 0, 'Murta Grimgut - emote cheer'),
(760702, 0, 22, 495, 0, 'Weegli Blastfuse - update faction'),
(760402, 0, 22, 495, 0, 'Sergeant Bly - update faction'),
(760502, 0, 22, 495, 0, 'Raven - update faction'),
(760602, 0, 22, 495, 0, 'Oro Eyegouge - update faction'),
(760802, 0, 22, 495, 0, 'Murta Grimgut - update faction'),
(760706, 0, 25, 1, 0, 'Weegli Blastfuse - set run on'),
(760707, 0, 0, 0, 2000005547, 'Weegli Blastfuse - say event begin');

-- despawn self
DELETE FROM `dbscripts_on_spell` WHERE `id` = 11365;
INSERT INTO `dbscripts_on_spell` (`id`, `command`, `datalong`, `comments`) VALUES
(11365, 18, 1000, 'despawn self');
-- party escape and door is blown
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` IN (760713,760409,760809,760609,760509);
INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, command, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `comments`) VALUES
(760713, 0, 15, 10772, 0, 0, 0, 0, 0, 'Weegli Blastfuse - cast Create Weegli\'s Barrel'),
(760713, 2, 13, 0, 0, 141612, 20, 1, 0, 'Weegli Blastfuse - use Weegli\'s Barrel'),
(760713, 5, 0, 6, 0, 7267, 200, 0, 2000005552, 'Ukorz Sandscalp - yell intro'),
(760409, 0, 15, 11365, 0, 0, 0, 0, 0, 'Sergeant Bly - cast Bly\'s Band\'s Escape'),
(760409, 0, 29, 1, 2, 0, 0, 0, 0, 'Sergeant Bly - remove gossip flag'),
(760809, 0, 15, 11365, 0, 0, 0, 0, 0, 'Raven - cast Bly\'s Band\'s Escape'),
(760609, 0, 15, 11365, 0, 0, 0, 0, 0, 'Oro Eyegouge - cast Bly\'s Band\'s Escape'),
(760509, 0, 15, 11365, 0, 0, 0, 0, 0, 'Murta Grimgut - cast Bly\'s Band\'s Escape');

-- gossip conditions
DELETE FROM `conditions` WHERE `condition_entry` IN (383, 384, 385, 386, 387, 388, 389);
INSERT INTO `conditions` VALUES
(383, 33, 2, 1), -- wp >= 2
(384, 33, 8, 0), -- wp == 8
(385, 33, 8, 2), -- wp < 8
(386, 33, 10, 2), -- wp < 10
(387, -1, 383, 386), -- wp between 1 and 9
(388, -1, 383, 385), -- wp between 1 and 7
(389, 33, 1, 0); -- wp == 1

UPDATE `creature_template` SET `gossip_menu_id`=941 WHERE `entry`=7604;
UPDATE `creature_template` SET `gossip_menu_id`=940 WHERE `entry`=7607;

DELETE FROM `gossip_menu` WHERE `entry` IN (940,941);
INSERT INTO `gossip_menu` VALUES
(940, 1511, 0, 389),
(940, 1513, 0, 387),
(940, 1514, 0, 721),
(941, 1515, 0, 389),
(941, 1516, 0, 388),
(941, 1517, 0, 384);

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (940, 941);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_script_id`, `condition_id`) VALUES
(940, 0, 0, 'Will you blow up that door now?', 1, 1, 94001, 721),
(941, 0, 0, 'Hey Bly!  Bilgewizzle wants his divino-matic rod back!', 1, 1, 0, 384),  -- Note: we are not sure what should be the action of this one - maybe similar to the one below
(941, 1, 0, 'That\'s it!  I\'m tired of helping you out.  It\'s time we settled things on the battlefield!', 1, 1, 94101, 384);


DELETE FROM `dbscripts_on_gossip` WHERE `id` IN (94001,94101);
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `comments`) VALUES
(94001, 0, 0, 0, 0, 0, 0, 0, 2000005548,'Weegli Blastfuse - say start door bombing'),
(94001, 0, 29, 1, 2, 0, 0, 0, 0, 'Weegli Blastfuse - remove gossip flag'),
(94001, 0, 22, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - update faction to default'),
(94001, 0, 25, 1, 0, 0, 0, 0, 0, 'Weegli Blastfuse - set run on'),
(94001, 0, 32, 0, 0, 0, 0, 0, 0,'Weegli Blastfuse - start WP movement'),
(94101, 0, 29, 1, 2, 0, 0, 0, 0, 'Sergeant Bly - remove gossip flag'),
(94101, 0, 0, 0, 0, 0, 0, 0, 2000005549, 'Sergeant Bly - say start combat 1'),
(94101, 3, 0, 0, 0, 0, 0, 0, 2000005550, 'Sergeant Bly - say start combat 2'),
(94101, 6, 22, 14, 0, 0, 0, 0, 0, 'Sergeant Bly - update faction to hostile'),
(94101, 6, 22, 14, 0, 7608, 30, 4, 0, 'Murta Grimgut - update faction'),
(94101, 6, 22, 14, 0, 7606, 30, 4, 0, 'Oro Eyegouge - update faction'),
(94101, 6, 22, 14, 0, 7605, 30, 4, 0, 'Raven - update faction'),
(94101, 6, 0, 0, 0, 7607, 30, 4, 2000005551,'Weegli Blastfuse - say start door bombing'),
(94101, 6, 29, 1, 2, 7607, 30, 4, 0, 'Weegli Blastfuse - remove gossip flag'),
(94101, 6, 22, 0, 0, 7607, 30, 4, 0, 'Weegli Blastfuse - update faction to default'),
(94101, 0, 25, 1, 0, 7607, 30, 4, 0, 'Weegli Blastfuse - set run on'),
(94101, 6, 32, 0, 0, 7607, 30, 4, 0,'Weegli Blastfuse - start WP movement');

-- Summon event
DELETE FROM `dbscripts_on_event` WHERE `id` = 2609;
INSERT INTO `dbscripts_on_event` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
-- Open cages
(2609, 0, 11, 27089, 9000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Open Troll Cage'),
(2609, 0, 11, 27090, 9000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Open Troll Cage'),
(2609, 0, 11, 27091, 9000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Open Troll Cage'),
(2609, 0, 11, 27092, 9000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Open Troll Cage'),
(2609, 0, 11, 27093, 9000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Open Troll Cage'),
-- Start movement
(2609, 2, 32, 0, 0, 7604, 30, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Start WP movement'),
(2609, 2, 32, 0, 0, 7605, 30, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Raven - Start WP movement'),
(2609, 2, 32, 0, 0, 7606, 30, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Oro Eyegouge - Start WP movement'),
(2609, 2, 32, 0, 0, 7607, 30, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - Start WP movement'),
(2609, 2, 32, 0, 0, 7608, 30, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Murta Grimgut - Start WP movement'),
-- Spawn first troll wave; there are around 38 - 40 trolls per wave. (slave and drudge). Note: some coords are guessword
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1902.83, 1223.41, 8.96, 3.95, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1894.64, 1206.29, 8.87, 2.22, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1873.45, 1204.44, 8.87, 0.88, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1875.18, 1221.24, 9.21, 0.84, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1879.02, 1223.06, 9.12, 5.91, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1882.07, 1225.7, 9.32, 5.69, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1886.97, 1225.86, 9.85, 5.79, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1892.28, 1225.49, 9.57, 5.63, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1894.72, 1221.91, 8.87, 2.34, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1890.08, 1218.68, 8.87, 1.59, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1883.5, 1218.25, 8.9, 0.67, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1886.93, 1221.4, 8.94, 1.6, 'spawn Sandfury Slave'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1883.76, 1222.3, 9.11, 6.26, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1889.82, 1222.51, 9.03, 0.97, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1898.23, 1217.97, 8.87, 3.42, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1877.4, 1216.41, 8.97, 0.37, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1893.07, 1215.26, 8.87, 3.08, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1874.57, 1214.16, 8.87, 3.12, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1889.94, 1212.21, 8.87, 1.59, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1883.74, 1212.35, 8.87, 1.59, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1877, 1207.27, 8.87, 3.8, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1873.63, 1204.65, 8.87, 0.61, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1896.46, 1205.62, 8.87, 5.72, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1899.63, 1202.52, 8.87, 2.46, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1903.49, 1211.52, 8.88, 0.61, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1901.34, 1206.06, 8.87, 5.72, 'spawn Sandfury Slave'),
(2609, 10, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1869.46, 1210.38, 9.15, 2.46, 'spawn Sandfury Slave'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1872.73, 1203.04, 8.87, 6.26, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1881.32, 1205.39, 8.87, 0.97, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1887.19, 1205.09, 8.87, 3.42, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1882.50, 1203.33, 8.87, 0.37, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1868.75, 1213.85, 9.47, 3.08, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1886.06, 1213.20, 8.87, 3.12, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1906.30, 1220.33, 9.03, 1.59, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1878.61, 1202.73, 8.87, 1.59, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1897.06, 1216.08, 8.87, 3.12, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1878.07, 1216.37, 8.93, 1.59, 'spawn Sandfury Drudge'),
(2609, 10, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1891.60, 1209.43, 8.87, 1.59, 'spawn Sandfury Drudge'),
-- Spawn second troll wave after 100 sec (slave, drudge and about 8 cretins)
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1902.83, 1223.41, 8.96, 3.95, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1894.64, 1206.29, 8.87, 2.22, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1873.45, 1204.44, 8.87, 0.88, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1875.18, 1221.24, 9.21, 0.84, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1879.02, 1223.06, 9.12, 5.91, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1882.07, 1225.7, 9.32, 5.69, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1886.97, 1225.86, 9.85, 5.79, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1892.28, 1225.49, 9.57, 5.63, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1894.72, 1221.91, 8.87, 2.34, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1890.08, 1218.68, 8.87, 1.59, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1883.5, 1218.25, 8.9, 0.67, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1886.93, 1221.4, 8.94, 1.6, 'spawn Sandfury Slave'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1883.76, 1222.3, 9.11, 6.26, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1889.82, 1222.51, 9.03, 0.97, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1898.23, 1217.97, 8.87, 3.42, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1877.4, 1216.41, 8.97, 0.37, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1893.07, 1215.26, 8.87, 3.08, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1874.57, 1214.16, 8.87, 3.12, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1889.94, 1212.21, 8.87, 1.59, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1883.74, 1212.35, 8.87, 1.59, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7789, 9000000, 0, 0, 0, 0, 0, 0, 0, 1877, 1207.27, 8.87, 3.8, 'spawn Sandfury Cretin'),
(2609, 100, 10, 7789, 9000000, 0, 0, 0, 0, 0, 0, 0, 1873.63, 1204.65, 8.87, 0.61, 'spawn Sandfury Cretin'),
(2609, 100, 10, 7789, 9000000, 0, 0, 0, 0, 0, 0, 0, 1896.46, 1205.62, 8.87, 5.72, 'spawn Sandfury Cretin'),
(2609, 100, 10, 7789, 9000000, 0, 0, 0, 0, 0, 0, 0, 1899.63, 1202.52, 8.87, 2.46, 'spawn Sandfury Cretin'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1903.49, 1211.52, 8.88, 0.61, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1901.34, 1206.06, 8.87, 5.72, 'spawn Sandfury Slave'),
(2609, 100, 10, 7787, 9000000, 0, 0, 0, 0, 0, 0, 0, 1869.46, 1210.38, 9.15, 2.46, 'spawn Sandfury Slave'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1872.73, 1203.04, 8.87, 6.26, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1881.32, 1205.39, 8.87, 0.97, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1887.19, 1205.09, 8.87, 3.42, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1882.50, 1203.33, 8.87, 0.37, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1868.75, 1213.85, 9.47, 3.08, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1886.06, 1213.20, 8.87, 3.12, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7788, 9000000, 0, 0, 0, 0, 0, 0, 0, 1906.30, 1220.33, 9.03, 1.59, 'spawn Sandfury Drudge'),
(2609, 100, 10, 7789, 9000000, 0, 0, 0, 0, 0, 0, 0, 1878.61, 1202.73, 8.87, 1.59, 'spawn Sandfury Cretin'),
(2609, 100, 10, 7789, 9000000, 0, 0, 0, 0, 0, 0, 0, 1897.06, 1216.08, 8.87, 3.12, 'spawn Sandfury Cretin'),
(2609, 100, 10, 7789, 9000000, 0, 0, 0, 0, 0, 0, 0, 1878.07, 1216.37, 8.93, 1.59, 'spawn Sandfury Cretin'),
(2609, 100, 10, 7789, 9000000, 0, 0, 0, 0, 0, 0, 0, 1891.60, 1209.43, 8.87, 1.59, 'spawn Sandfury Cretin'),
-- npcs start to move downstairs when boss spawn
(2609, 250, 25, 0, 0, 7607, 150, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - set run off'),
(2609, 250, 32, 0, 0, 7604, 150, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Start WP movement'),
(2609, 250, 0, 0, 0, 7604, 150, 4, 2000005553, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - yell at movement start'),
(2609, 250, 32, 0, 0, 7605, 150, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Raven - Start WP movement'),
(2609, 250, 32, 0, 0, 7606, 150, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Oro Eyegouge - Start WP movement'),
(2609, 250, 32, 0, 0, 7607, 150, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - Start WP movement'),
(2609, 250, 32, 0, 0, 7608, 150, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Murta Grimgut - Start WP movement'),
-- boss spawns after 4 min and 10 sec after the first wave (250 sec) (acolytes and zealots + 2 bosses)
(2609, 250, 10, 8876, 9000000, 0, 0, 0, 0, 0, 0, 0, 1890.552, 1199.941, 8.96, 4.46, 'spawn Sandfury Acolyte'),
(2609, 250, 10, 8876, 9000000, 0, 0, 0, 0, 0, 0, 0, 1888.446, 1200.169, 8.96, 1.11, 'spawn Sandfury Acolyte'),
(2609, 250, 10, 8876, 9000000, 0, 0, 0, 0, 0, 0, 0, 1876.983, 1199.938, 8.96, 2.19, 'spawn Sandfury Acolyte'),
(2609, 250, 10, 8876, 9000000, 0, 0, 0, 0, 0, 0, 0, 1873.311, 1197.546, 8.96, 4.60, 'spawn Sandfury Acolyte'),
(2609, 250, 10, 8877, 9000000, 0, 0, 0, 0, 0, 0, 0, 1895.159, 1198.047, 8.96, 1.51, 'spawn Sandfury Zealot'),
(2609, 250, 10, 8877, 9000000, 0, 0, 0, 0, 0, 0, 0, 1878.941, 1200.573, 8.96, 2.60, 'spawn Sandfury Zealot'),
(2609, 250, 10, 8877, 9000000, 0, 0, 0, 0, 0, 0, 0, 1874.741, 1199.029, 8.96, 2.53, 'spawn Sandfury Zealot'),
(2609, 250, 10, 7275, 9000000, 0, 0, 0, 0, 0, 0, 0, 1883.983, 1201.655, 8.96, 1.71, 'spawn Shadowpriest Sezz\'ziz'),
(2609, 250, 10, 7796, 9000000, 0, 0, 0, 0, 0, 0, 0, 1882.324, 1201.454, 8.96, 6.05, 'spawn Nekrum Gutchewer');

-- https://github.com/scriptdev2/scriptdev2/commit/031473d2bce3bd7a8e841ccc6ef849b8393bad56
-- Cleanup and improve script for the Bug Trio
delete from `spell_script_target` where `targetentry` IN (15543,15511);
insert into `spell_script_target` values
(25790, 1, 15543, 0),
(25790, 1, 15511, 0);

-- https://github.com/scriptdev2/scriptdev2/commit/8dd714a8fa649a3ec3acced439479541d33fa055
-- zg bats from cave behind high priestess jeklik
delete from `spell_script_target` where `entry` = 23974;
insert into `spell_script_target` values
(23974, 1, 14758, 0);

-- https://github.com/scriptdev2/scriptdev2/commit/1348124ea6b3f3e633cde82716568ed72630819e
-- Implement support for Nefarian - combat phase 3
DELETE FROM `dbscripts_on_go_template_use` WHERE `id` = 179804;
INSERT INTO `dbscripts_on_go_template_use` VALUES
(179804,1,10,14605,60000,0,0,2,0,0,0,0,0,0,0,0,'Drakonid Bones - Summon Bone Construct');

-- https://github.com/scriptdev2/scriptdev2/commit/de021dca0caeaef8ccb5ab22d2fd602c4d9e40d0
-- postbox parcels stratholme
DELETE FROM `gameobject` WHERE `id` IN(176346,176349,176350,176351,176352,176353);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,
`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(23607, 176346, 329, 3682.24, -3401.63, 132.84, 3.87243, 0, 0, 0.933973, -0.357343, 600, 255, 1),
(23609, 176349, 329, 3651.64, -3165.24, 128.157, 2.17619, 0, 0, 0.885745, 0.464173, 600, 255, 1),
(23610, 176350, 329, 3660.31, -3476.31, 138.379, 1.49442, 0, 0, 0.679596, 0.733586, 600, 255, 1),
(23611, 176351, 329, 3662.84, -3629.71, 138.513, 5.47596, 0, 0, 0.392744, -0.919648, 600, 255, 1),
(23612, 176352, 329, 3567.3, -3351.87, 130.696, 5.47596, 0, 0, 0.392744, -0.919648, 600, 255, 1),
(23613, 176353, 329, 3500.43, -3295.64, 131.034, 1.57623, 0, 0, 0.709027, 0.705182, 600, 255, 1);

-- postboxes
DELETE FROM `gameobject` WHERE `id` = 176360;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`,
 `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(23620, 176360, 329, 3500.44, -3296.51, 132.178, 4.55695, 0, 0, -0.711057, -0.703135, -180, 255, 1),
(23619, 176360, 329, 3566.72, -3351.26, 131.838, 2.31857, 0, 0, 0.916517, 0.399995, -180, 255, 1),
(23618, 176360, 329, 3662.24, -3629.09, 139.66, 2.20469, 0, 0, -0.382585, 0.92392, -180, 255, 1),
(23617, 176360, 329, 3660.25, -3477.18, 139.511, 4.82007, 0, 0, -0.685653, -0.727929, -180, 255, 1),
(23616, 176360, 329, 3652.15, -3165.96, 129.285, 5.34443, 0, 0, 0.452331, -0.89185, -180, 255, 1),
(23615, 176360, 329, 3682.91, -3401.05, 133.941, 0.670026, 0, 0, -0.929145, 0.369716, -180, 255, 1);

-- parcels appear when box open
DELETE FROM `dbscripts_on_go_use` WHERE `id` IN (23613,23607,23612,23609,23610,23611);
INSERT INTO `dbscripts_on_go_use` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(23613, 0, 9, 23620, 600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fras Slabi Parcel'),
(23607, 0, 9, 23615, 600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Market Row Parcel'),
(23612, 0, 9, 23619, 600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kings Square Parcel'),
(23609, 0, 9, 23616, 600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusaders Square Parcel'),
(23610, 0, 9, 23617, 600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Festival Lane Parcel'),
(23611, 0, 9, 23618, 600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Elders Square Parcel');

-- Fixing creatures rank (Rare)
-- source: old.wowhead.com, www.wowhead.com (mostly from comments), www.wowwiki.com, wowpedia.org

UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 6648; -- Antilos, found in: AZSHARA
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5347; -- Antilus the Soarer, found in: FERALAS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14222; -- Araga, found in: ALTERAC MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5349; -- Arash-ethis, found in: FERALAS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5834; -- Azzere the Skyblade, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1130; -- Bjarn, found in: DUN MOROGH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 616; -- Chatter, found in: REDRIDGE MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8301; -- Clack the Reaver, found in: BLASTED LANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 6582; -- Clutchmother Zavas, found in: UN'GORO CRATER
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14223; -- Cranky Benj, found in: ALTERAC MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14279; -- Creepthess, found in: HILLSBRAD FOOTHILLS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 4380; -- Darkmist Widow, found in: DUSTWALLOW MARSH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14232; -- Dart, found in: DUSTWALLOW MARSH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5823; -- Death Flayer, found in: DUROTAR
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14339; -- Death Howl, found in: FELWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8302; -- Deatheye, found in: BLASTED LANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5865; -- Dishu, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14228; -- Giggler, found in: DESOLACE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 12431; -- Gorefang, found in: SILVERPINE FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8207; -- Greater Firebird, found in: TANARIS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14472; -- Gretheer, found in: SILITHUS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8303; -- Grunter, found in: BLASTED LANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8205; -- Haarka the Ravenous, found in: TANARIS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14234; -- Hayoc, found in: DUSTWALLOW MARSH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14227; -- Hissperak, found in: DESOLACE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8213; -- Ironback, found in: THE HINTERLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14476; -- Krellack, found in: SILITHUS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 12433; -- Krethis Shadowspinner, found in: SILVERPINE FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14491; -- Kurmokk, found in: STRANGLETHORN VALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2476; -- Large Loch Crocolisk, found in: LOCH MODAN
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1112; -- Leech Widow, found in: WETLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14268; -- Lord Condar, found in: LOCH MODAN
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 521; -- Lupos, found in: DUSKWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3068; -- Mazzranache, found in: MULGORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10644; -- Mist Howler, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14344; -- Mongress, found in: FELWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 471; -- Mother Fang, found in: ELWYNN FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8208; -- Murderous Blisterpaw, found in: TANARIS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 574; -- Naraxis, found in: DUSKWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8211; -- Old Cliff Jumper, found in: THE HINTERLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5352; -- Old Grizzlegut, found in: FERALAS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 12432; -- Old Vicejaw, found in: SILVERPINE FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14343; -- Olm the Wise, found in: FELWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14237; -- Oozeworm, found in: DUSTWALLOW MARSH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 4015; -- Pridewing Patriarch, found in: STONETALON MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10200; -- Rak'shiri, found in: WINTERSPRING
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8300; -- Ravage, found in: BLASTED LANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 6581; -- Ravasaur Matriarch, found in: UN'GORO CRATER
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1140; -- Razormaw Matriarch, found in: WETLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8277; -- Rekk'tilac, found in: SEARING GORGE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10357; -- Ressan the Needler, found in: TIRISFAL GLADES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14490; -- Rippa, found in: STRANGLETHORN VALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14233; -- Ripscale, found in: DUSTWALLOW MARSH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1552; -- Scale Belly, found in: STRANGLETHORN VALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3581; -- Sewer Beast, found in: STORMWIND CITY
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2175; -- Shadowclaw, found in: DARKSHORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14266; -- Shanda the Spinner, found in: LOCH MODAN
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 4132; -- Silithid Ravager, found in: THOUSAND NEEDLES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5356; -- Snarler, found in: FERALAS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5829; -- Snort the Heckler, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8204; -- Soriid the Devourer, found in: TANARIS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8299; -- Spiteflayer, found in: BLASTED LANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10359; -- Sri'skulk, found in: TIRISFAL GLADES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2172; -- Strider Clutchmother, found in: DARKSHORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8660; -- The Evalcharr, found in: AZSHARA
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5807; -- The Rake, found in: MULGORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5832; -- Thunderstomp, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1132; -- Timber, found in: DUN MOROGH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 6585; -- Uhk'loc, found in: UN'GORO CRATER
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 12037; -- Ursol'lok, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3773; -- Akkrilus, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14340; -- Alshirr Banebreath, found in: FELWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10356; -- Bayne, found in: TIRISFAL GLADES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14226; -- Kaskk, found in: DESOLACE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2191; -- Licillin, found in: DARKSHORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14225; -- Prince Kellen, found in: DESOLACE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10647; -- Prince Raze, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3470; -- Rathorian, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8280; -- Shleipnarr, found in: SEARING GORGE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10078; -- Terrorspark, found in: BURNING STEPPES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1063; -- Jade, found in: TEMPLE OF ATAL'HAKKAR
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14272; -- Snarlflare, found in: REDRIDGE MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3535; -- Blackmoss the Fetid, found in: TELDRASSIL
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10641; -- Branch Snapper, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14231; -- Drogoth the Roamer, found in: DUSTWALLOW MARSH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10642; -- Eck'alom, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5354; -- Gnarl Leafbrother, found in: FERALAS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14478; -- Huricanian, found in: SILITHUS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8981; -- Malfunctioning Reaver, found in: BURNING STEPPES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14448; -- Molt Thorn, found in: SWAMP OF SORROWS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2752; -- Rumbler, found in: BADLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8281; -- Scald, found in: SEARING GORGE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14269; -- Seeker Aqualon, found in: REDRIDGE MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8278; -- Smoldar, found in: SEARING GORGE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2258; -- Stone Fury, found in: ALTERAC MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1851; -- The Husk, found in: WESTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 4030; -- Vengeful Ancient, found in: STONETALON MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2751; -- War Golem, found in: BADLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14273; -- Boulderheart, found in: REDRIDGE MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 596; -- Brainwashed Noble, found in: THE DEADMINES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 599; -- Marisa du'Paige, found in: THE DEADMINES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5399; -- Veyzhak the Cannibal, found in: TEMPLE OF ATAL'HAKKAR
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8298; -- Akubar the Seer, found in: BLASTED LANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3735; -- Apothecary Falthis, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5346; -- Bloodroar the Stalker, found in: FERALAS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3672; -- Boahn, found in: WAILING CAVERNS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1398; -- Boss Galgosh, found in: LOCH MODAN
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5838; -- Brokespear, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14230; -- Burgle Eye, found in: DUSTWALLOW MARSH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2186; -- Carnivous the Breaker, found in: DARKSHORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 11688; -- Cursed Centaur, found in: MARAUDON
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8202; -- Cyclok the Mad, found in: TANARIS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1920; -- Dalaran Spellscribe, found in: SILVERPINE FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10827; -- Deathspeaker Selendre, found in: EASTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1911; -- Deeb, found in: TIRISFAL GLADES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5345; -- Diamond Head, found in: FERALAS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5849; -- Digger Flameforge, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1037; -- Dragonmaw Battlemaster, found in: WETLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8304; -- Dreadscorn, found in: BLASTED LANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10817; -- Duggan Wildhammer, found in: EASTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1137; -- Edan the Howler, found in: DUN MOROGH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5787; -- Enforcer Emilgund, found in: MULGORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5836; -- Engineer Whirleygig, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1936; -- Farmer Solliden, found in: TIRISFAL GLADES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 472; -- Fedfennel, found in: ELWYNN FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 507; -- Fenros, found in: DUSKWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14446; -- Fingat, found in: SWAMP OF SORROWS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2192; -- Firecaller Radison, found in: DARKSHORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 7015; -- Flagglemurk the Cruel, found in: DARKSHORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5835; -- Foreman Grills, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1844; -- Foreman Marcrid, found in: WESTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2108; -- Garneg Charskull, found in: WETLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 6651; -- Gatekeeper Rageroar, found in: AZSHARA
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 6650; -- General Fangferror, found in: AZSHARA
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5826; -- Geolord Mottle, found in: DUROTAR
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5863; -- Geopriest Gukk'rok, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8503; -- Gibblewilt, found in: DUN MOROGH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14447; -- Gilmorian, found in: SWAMP OF SORROWS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14487; -- Gluggle, found in: STRANGLETHORN VALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 9604; -- Gorgon'och, found in: BURNING STEPPES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14221; -- Gravis Slipknot, found in: ALTERAC MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1260; -- Great Father Arctikus, found in: DUN MOROGH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1425; -- Grizlak, found in: LOCH MODAN
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10199; -- Grizzle Snowpaw, found in: WINTERSPRING
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8979; -- Gruklash, found in: BURNING STEPPES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 9602; -- Hahk'Zor, found in: BURNING STEPPES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1119; -- Hammerspine, found in: DUN MOROGH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5847; -- Heggin Stonewhisker, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8214; -- Jalinde Summerdrake, found in: THE HINTERLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14281; -- Jimmy the Bleeder, found in: ALTERAC MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 584; -- Kazon, found in: REDRIDGE MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2603; -- Kovork, found in: ARATHI HIGHLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8203; -- Kregg Keelhaul, found in: TANARIS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 6649; -- Lady Sesspira, found in: AZSHARA
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5343; -- Lady Szallah, found in: FERALAS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10559; -- Lady Vespia, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 7016; -- Lady Vespira, found in: DARKSHORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14277; -- Lady Zephris, found in: HILLSBRAD FOOTHILLS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2453; -- Lo'Grosh, found in: ALTERAC MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14236; -- Lord Angler, found in: DUSTWALLOW MARSH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1848; -- Lord Maldazzar, found in: WESTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2541; -- Lord Sakrasis, found in: STRANGLETHORN VALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 7017; -- Lord Sinslayer, found in: DARKSHORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 763; -- Lost One Chieftain, found in: SWAMP OF SORROWS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1106; -- Lost One Cook, found in: SWAMP OF SORROWS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 6647; -- Magister Hawkhelm, found in: AZSHARA
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1399; -- Magosh, found in: LOCH MODAN
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8297; -- Magronos the Unyielding, found in: BLASTED LANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5848; -- Malgin Barleybrew, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2090; -- Ma'ruk Wyrmscale, found in: WETLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10197; -- Mezzir the Howler, found in: WINTERSPRING
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8296; -- Mojo the Twisted, found in: BLASTED LANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2604; -- Molok the Crusher, found in: ARATHI HIGHLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 99; -- Morgaine the Sly, found in: ELWYNN FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1910; -- Muad, found in: TIRISFAL GLADES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10643; -- Mugglefin, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 79; -- Narg the Taskmaster, found in: ELWYNN FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 534; -- Nefaru, found in: DUSKWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2606; -- Nimar the Slayer, found in: ARATHI HIGHLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10640; -- Oakpaw, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8201; -- Omgorn the Lost, found in: TANARIS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2779; -- Prince Nazjak, found in: ARATHI HIGHLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14342; -- Ragepaw, found in: FELWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10824; -- Ranger Lord Hawkspear, found in: EASTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8216; -- Retherokk the Berserker, found in: THE HINTERLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14271; -- Ribchaser, found in: REDRIDGE MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14278; -- Ro'Bark, found in: HILLSBRAD FOOTHILLS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14488; -- Roloch, found in: STRANGLETHORN VALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10639; -- Rorgish Jowl, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14276; -- Scargil, found in: HILLSBRAD FOOTHILLS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2744; -- Shadowforge Commander, found in: BADLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2600; -- Singer, found in: ARATHI HIGHLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2452; -- Skhowl, found in: ALTERAC MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8283; -- Slave Master Blackheart, found in: SEARING GORGE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5786; -- Snagglespear, found in: MULGORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14270; -- Squiddic, found in: REDRIDGE MOUNTAINS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5837; -- Stonearm, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3792; -- Terrowulf Packlord, found in: ASHENVALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8978; -- Thauris Balgarr, found in: BURNING STEPPES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 61; -- Thuros Lightfingers, found in: ELWYNN FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14479; -- Twilight Lord Everun, found in: SILITHUS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14492; -- Verifonix, found in: STRANGLETHORN VALE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5808; -- Warlord Kolkanis, found in: DUROTAR
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10822; -- Warlord Thresh'jin, found in: EASTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5809; -- Watch Commander Zalaphil, found in: DUROTAR
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8218; -- Witherheart the Stalker, found in: THE HINTERLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2605; -- Zalas Witherbark, found in: ARATHI HIGHLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8219; -- Zul'arek Hatefowler, found in: THE HINTERLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10823; -- Zul'Brin Warpbranch, found in: EASTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14224; -- 7:XT, found in: BADLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 573; -- Foe Reaper 4000, found in: WESTFALL
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3652; -- Trigore the Lasher, found in: WAILING CAVERNS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5350; -- Qirot, found in: FERALAS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3253; -- Silithid Harvester, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 3295; -- Sludge Beast, found in: THE BARRENS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14345; -- The Ongar, found in: FELWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8212; -- The Reak, found in: THE HINTERLANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 14235; -- The Rot, found in: DUSTWALLOW MARSH
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5400; -- Zekkis, found in: TEMPLE OF ATAL'HAKKAR
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 771; -- Commander Felstrom, found in: DUSKWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10358; -- Fellicent's Shade, found in: TIRISFAL GLADES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1847; -- Foulmane, found in: WESTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10825; -- Gish the Unmoving, found in: EASTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10821; -- Hed'mush the Rotting, found in: EASTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2184; -- Lady Moongazer, found in: DARKSHORE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 10826; -- Lord Darkscythe, found in: EASTERN PLAGUELANDS
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 503; -- Lord Malathrom, found in: DUSKWOOD
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1531; -- Lost Soul, found in: TIRISFAL GLADES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 2283; -- Ravenclaw Regent, found in: SILVERPINE FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1944; -- Rot Hide Bruiser, found in: SILVERPINE FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1948; -- Snarlmane, found in: SILVERPINE FOREST
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 1533; -- Tormented Spirit, found in: TIRISFAL GLADES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 6118; -- Varo'then's Ghost, found in: AZSHARA
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 9046; -- Scarshield Quartermaster, found in: BLACKROCK MOUNTAIN
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 8279; -- Faulty War Golem, found in: BADLANDS/SEARING GORGE
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 5933; -- Achellios the Banished, found in: THOUSAND NEEDLES
UPDATE `creature_template` SET `rank` = 4 WHERE `entry` = 7895; -- Ambassador Bloodrage, found in: THE BARRENS

-- Fixes issue #3: correct experience rewarded for quest
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 240 WHERE `entry` = 4402;

-- Fixes issue #14: correct experience rewarded for quest
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 3720 WHERE `entry` = 8464;

-- Fixes issue #22: correct experience rewarded for quest.
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 2640 WHERE `entry` = 8460;

-- Fixes issue #9: added missing loot condition for quest item loot.
DELETE FROM `conditions` WHERE `condition_entry` = '725' AND `type` = '9' AND `value1` = '5147' AND `value2` = '0';
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`)
VALUES
(725, 9, 5147, 0);
UPDATE `creature_loot_template` SET `condition_id` = 725 WHERE `entry` = 10896 AND `item` = 12884;

-- Fixes issue #117: Midsummer creatures should only be visible during the event
INSERT IGNORE INTO `game_event_creature` (`guid`, `event`)
VALUES
    (1882, 1),
    (47575, 1),
    (47614, 1),
    (94864, 1),
    (94865, 1),
    (94866, 1),
    (94867, 1),
    (94868, 1),
    (94869, 1),
    (94870, 1),
    (94871, 1),
    (94872, 1),
    (94873, 1),
    (94875, 1),
    (94876, 1),
    (94877, 1),
    (94878, 1),
    (94879, 1),
    (94880, 1),
    (94881, 1),
    (94882, 1),
    (94883, 1),
    (94884, 1),
    (94886, 1),
    (94887, 1),
    (94888, 1),
    (94889, 1),
    (94890, 1),
    (94891, 1),
    (94892, 1),
    (94893, 1),
    (94894, 1),
    (94895, 1),
    (94896, 1),
    (94897, 1),
    (94898, 1),
    (94899, 1),
    (94900, 1),
    (94901, 1),
    (94902, 1),
    (94903, 1),
    (94904, 1),
    (94905, 1),
    (94906, 1),
    (94907, 1),
    (94908, 1),
    (94909, 1),
    (94910, 1),
    (94911, 1),
    (94912, 1),
    (94913, 1),
    (94914, 1),
    (94918, 1),
    (94529, 1),
    (94530, 1),
    (94531, 1),
    (94532, 1),
    (94533, 1),
    (94534, 1),
    (94535, 1),
    (94536, 1),
    (94537, 1),
    (94538, 1),
    (94539, 1),
    (94540, 1),
    (94541, 1),
    (94542, 1),
    (94543, 1),
    (94544, 1),
    (94545, 1),
    (94546, 1),
    (94547, 1),
    (94548, 1),
    (94549, 1),
    (94550, 1),
    (94551, 1),
    (94552, 1),
    (94553, 1),
    (94554, 1),
    (94555, 1),
    (94556, 1),
    (94557, 1),
    (94558, 1),
    (94559, 1),
    (94560, 1),
    (94561, 1),
    (94562, 1),
    (94563, 1),
    (94564, 1),
    (94565, 1),
    (94566, 1),
    (94567, 1),
    (94568, 1),
    (94569, 1),
    (94570, 1),
    (94571, 1),
    (94574, 1),
    (94575, 1),
    (94576, 1),
    (94577, 1),
    (94578, 1),
    (94579, 1),
    (94580, 1),
    (94581, 1),
    (94582, 1),
    (94583, 1),
    (94584, 1),
    (94585, 1),
    (94586, 1),
    (94587, 1),
    (94588, 1),
    (94589, 1),
    (94590, 1),
    (94591, 1),
    (94592, 1),
    (94593, 1),
    (94594, 1),
    (94595, 1),
    (94596, 1),
    (94597, 1),
    (94598, 1),
    (94599, 1),
    (94600, 1),
    (94601, 1),
    (94602, 1),
    (94603, 1),
    (94604, 1),
    (94605, 1),
    (94606, 1),
    (94607, 1),
    (94608, 1),
    (94609, 1),
    (94610, 1),
    (94611, 1),
    (94612, 1),
    (94615, 1),
    (94616, 1),
    (94617, 1),
    (94618, 1),
    (94619, 1),
    (94620, 1),
    (94621, 1),
    (94622, 1),
    (94623, 1),
    (94627, 1),
    (94628, 1),
    (94629, 1),
    (94630, 1),
    (94634, 1),
    (94635, 1),
    (94636, 1),
    (94637, 1),
    (94638, 1),
    (94639, 1),
    (94640, 1),
    (94641, 1),
    (94642, 1),
    (94643, 1),
    (94644, 1),
    (94645, 1),
    (94646, 1),
    (94647, 1),
    (94648, 1),
    (94649, 1),
    (94650, 1),
    (94651, 1),
    (94652, 1),
    (94653, 1),
    (94654, 1),
    (94655, 1),
    (94656, 1),
    (94657, 1),
    (94658, 1),
    (94659, 1),
    (94660, 1),
    (94661, 1),
    (94662, 1),
    (94663, 1),
    (94664, 1),
    (94669, 1),
    (94670, 1),
    (94671, 1),
    (94672, 1),
    (94673, 1),
    (94674, 1),
    (94675, 1),
    (94676, 1),
    (94677, 1),
    (94678, 1),
    (94679, 1),
    (94680, 1),
    (94681, 1),
    (94682, 1),
    (94683, 1),
    (94684, 1),
    (94685, 1),
    (94686, 1),
    (94687, 1),
    (94688, 1),
    (94689, 1),
    (94690, 1),
    (94691, 1),
    (94692, 1),
    (94693, 1),
    (94694, 1),
    (94695, 1),
    (94696, 1),
    (94697, 1),
    (94698, 1),
    (94699, 1),
    (94700, 1),
    (94701, 1),
    (94702, 1),
    (94703, 1),
    (94704, 1),
    (94705, 1),
    (94706, 1),
    (94707, 1),
    (94708, 1),
    (94709, 1),
    (94710, 1),
    (94711, 1),
    (94715, 1),
    (94716, 1),
    (94717, 1),
    (94723, 1),
    (94724, 1),
    (94725, 1),
    (94726, 1),
    (94727, 1),
    (94728, 1),
    (94729, 1),
    (94730, 1),
    (94731, 1),
    (94732, 1),
    (94733, 1),
    (94734, 1),
    (94735, 1),
    (94738, 1),
    (94739, 1),
    (94740, 1),
    (94741, 1),
    (94742, 1),
    (94743, 1),
    (94744, 1),
    (94745, 1),
    (94746, 1),
    (94747, 1);

-- Fixes issue #116: set correct faction for Enraged Hippogryph
UPDATE `creature_template`
SET
    `faction_A` = 80, `faction_H` = 80
WHERE
    `entry` = 9527;

-- Fixes issue #113: assign proper gossip to Orb of Command
DELETE FROM `conditions` WHERE `condition_entry` = '726' AND `type` = '8' AND `value1` = '7761' AND `value2` = '0';
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`)
VALUES
(726, 8, 7761, 0);

INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`)
VALUES
    (6001, 0, 15, 23460, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Teleport player to Blackwing Lair.');

DELETE FROM `gossip_menu` WHERE `entry` = '6001' AND `text_id` = '7154' AND `script_id` = '0' AND `condition_id` = '0';
DELETE FROM `gossip_menu` WHERE `entry` = '6001' AND `text_id` = '7155' AND `script_id` = '0' AND `condition_id` = '726';
INSERT INTO `gossip_menu` (`entry`,`text_id`,`script_id`,`condition_id`)
VALUES
    (6001, 7154, 0, 0), -- displayed if player completed quest
    (6001, 7155, 0, 726); -- displayed if player is not yet attuned

DELETE FROM `gossip_menu_option` WHERE `menu_id` = '6001' AND `id` = '0';
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`)
VALUES
    (6001, 0, 0, '<Place my hand on the orb.>', 1, 1, -1, 0, 6001, 0, 0, NULL, 726);

-- Fixes #112: assign proper gossio and conditions to Lothos Riftwaker
UPDATE `creature_template` SET `gossip_menu_id` = 5750 WHERE `entry` = 14387;

DELETE FROM `conditions` WHERE `condition_entry` = '727' AND `type` = '8';
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`)
VALUES
(727, 8, 7848, 0);

UPDATE `gossip_menu_option` SET `option_text` = 'Transport me to the Molten Core, Lothos.', `condition_id` = 727 WHERE `menu_id` = 5750 AND `id` = 1;

-- Fixes #114: removed duplicate spawn of Cenarion Hold Infantry
DELETE FROM `creature` WHERE `guid` = 42896;
DELETE FROM `creature_addon` WHERE `guid` = 42896;
DELETE FROM `creature_movement` WHERE `id` = 42896;

-- Missing ScriptDev script assignments
UPDATE `gameobject_template` SET `ScriptName` = 'go_fathom_stone' WHERE entry = 177964;

DELETE FROM scripted_event WHERE `id` = '2609';
INSERT INTO scripted_event VALUES
(2609,'event_spell_unlocking');
UPDATE creature_template SET ScriptName='boss_zumrah' WHERE entry=7271;
UPDATE creature_template SET ScriptName='npc_piznik' WHERE entry=4276;

-- Database error fixes
DELETE FROM `creature_addon` WHERE `guid` IN (28379, 45146, 45214, 45215);
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 1623 AND `id` = 1;

-- Fix quest text for 1132
-- Source http://www.wowpeek.com/quest.php?questid=1132
UPDATE `quest_template` SET `Details` = 'Oh, to be at sea once again!  To feel the kiss of the wind, and to have the waves rock me like my blessed mother, long ago!$B$BOh, I wish I had your fortune, good $c, for I see the sea in your future!$B$BIt\'s my job to tell eager souls of the land of Kalimdor, the land of opportunity!  If you\'re willing to try your luck across the sea, then take a ship from here to the lovely port of Theramore.  Speak there with my partner, the elf, Fiora Longears.$B$BShe\'ll start you on your Kalimdor adventure!', `Objectives` = 'Speak with Fiora Longears in Theramore.' WHERE `entry` = 1132;

-- Blackwing lair exit to blackrock spire
UPDATE `areatrigger_teleport` SET `target_map` = 0, `target_position_x` = -7524.19, `target_position_y` = -1230.13, `target_position_z` = 285.743, `target_orientation` = 2.09544 WHERE `id` = 3728;

-- Typos
UPDATE `areatrigger_teleport` SET `name`='Blackfathom Deeps Entrance' WHERE `id`=257;
UPDATE `areatrigger_teleport` SET `name`='Blackfathom Deeps Instance Start' WHERE `id`=259;

-- Quests available only after 9233 Omarions Handbook
-- Source: http://www.wowwiki.com/Omarion%27s_Handbook
UPDATE `quest_template` SET `prevquestid` = 9233 WHERE `entry` IN (9234,9235,9236,9237,9238,9239,9240,9241,9242,9243,9244,9245,9246);

-- Spirit of Azuregos gossip aq chain
-- http://www.wowwiki.com/Quest:Azuregos%27s_Magical_Ledger
UPDATE `creature_template` SET `gossip_menu_id`=27052 WHERE `entry`=15481;

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (27052,27053,27054,27055,27056,27057,27058,27059,27060,27061,27062,27063,27064);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
(27064, 1, 0, 'But...', 1, 1, 27065, 0, 0, 0, 0, ' ', 0),
(27063, 1, 0, 'FINE! And how, dare I ask, am I supposed to acquire an arcanite buoy?', 1, 1, 27064, 0, 0, 0, 0, ' ', 0),
(27062, 1, 0, 'Ok, let me get this straight. You put the scepter entrusted to your Flight by Anachronos on a minnow of your own making and now you expect me to build an... an arcanite buoy or something... to force your minnow out of hiding? AND potentially incur the wrath of an Elemental Lord? Did I miss anything? Perhaps I am to do this without any clothes on, during a solar eclipse, on a leap year?', 1, 1, 27063, 0, 0, 0, 0, ' ', 0),
(27061, 1, 0, 'Come again.', 1, 1, 27062, 0, 0, 0, 0, ' ', 0),
(27060, 1, 0, ' I\'m all ears.', 1, 1, 27061, 0, 0, 0, 0, ' ', 0),
(27059, 1, 0, 'You\'re insane.', 1, 1, 27060, 0, 0, 0, 0, ' ', 0),
(27058, 1, 0, 'You put the piece on a minnow and placed the minnow somewhere in the waters of the sea between here and the Eastern Kingdoms? And this minnow has special powers?', 1, 1, 27059, 0, 0, 0, 0, ' ', 0),
(27057, 1, 0, '...', 1, 1, 27058, 0, 0, 0, 0, ' ', 0),
(27056, 1, 0, 'A minnow? The oceans are filled with minnows! There could be a hundred million million minnows out there!', 1, 1, 27057, 0, 0, 0, 0, ' ', 0),
(27055, 1, 0, 'Fish? You gave a piece of what could be the key to saving all life on Kalimdor to a fish?', 1, 1, 27056, 0, 0, 0, 0, ' ', 0),
(27054, 1, 0, 'By Bronzebeard\'s... um, beard! What are you talking about?', 1, 1, 27055, 0, 0, 0, 0, ' ', 0),
(27053, 1, 0, 'Alright. Where?', 1, 1, 27054, 0, 0, 0, 0, ' ', 0),
(27052, 1, 0, 'How did you know? I mean, yes... Yes I am looking for that shard. Do you have it?', 1, 1, 27053, 0, 0, 0, 0, ' ', 1790);

DELETE FROM `gossip_menu` WHERE `entry` IN (27052,27053,27054,27055,27056,27057,27058,27059,27060,27061,27062,27063,27064,27065);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(27065, 25017, 27066, 0),
(27064, 25016, 0, 0),
(27063, 25015, 0, 0),
(27062, 25014, 0, 0),
(27061, 25013, 0, 0),
(27060, 25012, 0, 0),
(27059, 25011, 0, 0),
(27058, 25010, 0, 0),
(27057, 25009, 0, 0),
(27056, 25008, 0, 0),
(27055, 25007, 0, 0),
(27054, 25006, 0, 0),
(27053, 25005, 0, 0),
(27052, 7881, 0, 0),
(27052, 25004, 0, 1790);

DELETE FROM `conditions` WHERE `condition_entry` = 1790;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
(1790, 8, 8555, 0);

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 27066;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(27066, 0, 17, 20949, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magical ledger add');

-- Omarion gossip npc text
DELETE FROM `npc_text` WHERE `ID` IN (24400, 24401, 24402, 24403, 24404);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `lang0`, `prob0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `lang1`, `prob1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `lang2`, `prob2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `lang3`, `prob3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `lang4`, `prob4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `lang5`, `prob5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `lang6`, `prob6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `lang7`, `prob7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`) VALUES
(24400, '<Omarion grumbles something under his breath.>$B$BBut of course I can help you, dear $S. It is my dying wish... my final desire. Please, take this handbook. The information on its pages are a compilation of all that I know and have learned in the past 30 some-odd years of my miserable life. Give the handbook to that good for nothing apprentice of mine that\'s probably sitting on his fat duff at Light\'s Hope Chapel.', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0),
(24401, 'A tailor, eh? Very well. What would you like to learn about, tailor?$B$B', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0),
(24402, 'A blacksmith, eh? Very well. What would you like to learn about, blacksmith?$B$B', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0),
(24403, 'A leatherworker, eh? Very well. What would you like to learn about, leatherworker?$B$B', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0),
(24404, 'Is this the best they could do?$B$B<Omarion musters the strength to laugh.>$B$BYou do not possess the resolve to face a monster like Kel\'Thuzad. You will crumble before his minions - just like those that have come before you...$B$BLeave me here to die. I refuse to return to a world that champions the likes of you.', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (24400, 24401, 24402, 24403, 24404);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
(24400, 1, 0, 'Thank you, Omarion. You have taken a fatal blow for the team on this day.', 1, 1, 24404, 0, 2901, 0, 0, NULL, 0),
(24401, 1, 0, 'Glacial Cloak.', 1, 1, 24401, 0, 2902, 0, 0, NULL, 5),
(24401, 2, 0, 'Glacial Gloves.', 1, 1, 24401, 0, 2903, 0, 0, NULL, 5),
(24401, 3, 0, 'Glacial Wrists.', 1, 1, 24401, 0, 2904, 0, 0, NULL, 5),
(24401, 4, 0, 'Glacial Vest.', 1, 1, 24401, 0, 2900, 0, 0, NULL, 5),
(24401, 5, 0, 'I need to go. Evil stirs. Die well, Omarion.', 1, 1, 24404, 0, 0, 0, 0, NULL, 0),
(24402, 1, 0, 'Icebane Bracers.', 1, 1, 24402, 0, 2905, 0, 0, NULL, 5),
(24402, 2, 0, 'Icebane Gauntlets.', 1, 1, 24402, 0, 2906, 0, 0, NULL, 5),
(24402, 3, 0, 'Icebane Breastplate.', 1, 1, 24402, 0, 2907, 0, 0, NULL, 5),
(24402, 4, 0, 'I need to go. Evil stirs. Die well, Omarion.', 1, 1, 24404, 0, 0, 0, 0, NULL, 0),
(24403, 1, 0, 'Polar Bracers.', 1, 1, 24403, 0, 2908, 0, 0, NULL, 5),
(24403, 2, 0, 'Polar Gloves.', 1, 1, 24403, 0, 2909, 0, 0, NULL, 5),
(24403, 3, 0, 'Polar Tunic.', 1, 1, 24403, 0, 2910, 0, 0, NULL, 5),
(24403, 4, 0, 'Icy Scale Bracers.', 1, 1, 24403, 0, 2911, 0, 0, NULL, 5),
(24403, 5, 0, 'Icy Scale Gauntlets.', 1, 1, 24403, 0, 2912, 0, 0, NULL, 5),
(24403, 6, 0, 'Icy Scale Breastplate.', 1, 1, 24403, 0, 2913, 0, 0, NULL, 5),
(24403, 7, 0, 'I need to go. Evil stirs. Die well, Omarion.', 1, 1, 24404, 0, 0, 0, 0, NULL, 0),
(24404, 1, 0, 'I am a master leatherworker, Omarion.', 1, 1, 24403, 0, 0, 0, 0, NULL, 1353),
(24404, 2, 0, 'I am a master blacksmith, Omarion.', 1, 1, 24402, 0, 0, 0, 0, NULL, 1355),
(24404, 3, 0, 'I am a master tailor, Omarion.', 1, 1, 24401, 0, 0, 0, 0, NULL, 1357),
(24404, 4, 0, 'Omarion, I am not a craftsman. Can you still help me?', 1, 1, 24400, 0, 0, 0, 0, NULL, 1349);

DELETE FROM `gossip_menu` WHERE `entry` IN (24400, 24401, 24402, 24403, 24404);

INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(24404, 24404, 0, 0),
(24403, 24403, 0, 0),
(24402, 24402, 0, 0),
(24401, 24401, 0, 0),
(24400, 24400, 0, 0);

DELETE FROM `dbscripts_on_gossip` WHERE `id` IN (2900, 2901, 2902, 2903, 2904, 2905, 2906, 2907, 2908, 2909, 2910, 2911, 2912, 2913);
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(2913, 0, 15, 28257, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'icy scale tunic'),
(2912, 0, 15, 28258, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'icy scale gloves'),
(2911, 0, 15, 28259, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ice scale bracers'),
(2910, 0, 15, 28254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'polar tunic'),
(2909, 0, 15, 28255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'polar gloves'),
(2908, 0, 15, 28256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'polar bracers'),
(2907, 0, 15, 28251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast icebane breastplate'),
(2906, 0, 15, 28253, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast icebane gauntlets'),
(2905, 0, 15, 28252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast icebane bracers'),
(2904, 0, 15, 28262, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast glacial wrists'),
(2903, 0, 15, 28261, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast glacial gloves'),
(2902, 0, 15, 28263, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast glacial cloak'),
(2901, 0, 15, 28287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast Conjure E.C.A.C'),
(2900, 0, 15, 28260, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast glacial vest');

DELETE FROM `conditions` WHERE `condition_entry` IN (1349, 1352, 1353, 1354, 1355, 1356, 1357);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
(1357, -1, 1349, 1356),
(1356, 7, 197, 300),
(1355, -1, 1349, 1354),
(1354, 7, 164, 300),
(1353, -1, 1349, 1352),
(1352, 7, 165, 300),
(1349, 5, 529, 6);

UPDATE `creature_template` SET `npcflag` = 1, `gossip_menu_id` = 24404 WHERE `entry` = 16365;

DELETE FROM `creature` where `guid`IN (88372,88373,88374,88375,88376,88377,88378,88379,88380,88381,88382,88383,88384,88385,88386,88387,88388,88389,88390,88391,88392,88101,88102,88103,88104,88105,88106,88107,88108,88109,88110,88111,88112,88113,88114,88115,88116,88662,88663,88664,88665,88666,88667,88668,88669,88670,88671,88672,88673,
88661,88660,88659,88658,88657,88656,88655,88654,88653,88758,88757,88759,88761,88760,88762,88681,88680,88679,88678,154199,154198,154197,
154196,154195,154194,154193,154192,154191,154190,154189,154188,154187,154186,154185,154184,154183);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(88372, 16448, 533, 0, 0, 2658.3, -3027.3, 240.526, 0.768528, 25, 0, 0, 19500, 12000, 0, 0),
(88373, 16448, 533, 0, 0, 2661.77, -3030.89, 240.526, 0.768528, 25, 0, 0, 19500, 12000, 0, 0),
(88374, 16448, 533, 0, 0, 2665.16, -3034.39, 240.526, 0.768528, 25, 0, 0, 19500, 12000, 0, 0),
(88375, 16447, 533, 0, 0, 2714.12, -2978.91, 240.526, 1.99375, 25, 0, 0, 93736, 0, 0, 0),
(88376, 16447, 533, 0, 0, 2717.78, -2978.17, 240.526, 1.99375, 25, 0, 0, 93736, 0, 0, 0),
(88377, 16447, 533, 0, 0, 2716.18, -2979.42, 240.526, 1.99375, 25, 0, 0, 93736, 0, 0, 0),
(88378, 16447, 533, 0, 0, 2714.82, -2976.4, 240.526, 1.99375, 25, 0, 0, 93736, 0, 0, 0),
(88379, 16449, 533, 0, 0, 2697.38, -2986.79, 240.526, 0.446517, 25, 5, 0, 65845, 0, 0, 1),
(88380, 16449, 533, 0, 0, 2555.72, -3127.08, 240.526, 4.63109, 25, 5, 0, 65845, 0, 0, 1),
(88381, 16447, 533, 0, 0, 2556.08, -3107.57, 240.526, 3.89439, 25, 0, 0, 93736, 0, 0, 0),
(88382, 16447, 533, 0, 0, 2554.5, -3103.96, 240.526, 3.89439, 25, 0, 0, 93736, 0, 0, 0),
(88383, 16447, 533, 0, 0, 2556.17, -3104.94, 240.526, 3.89439, 25, 0, 0, 93736, 0, 0, 0),
(88384, 16447, 533, 0, 0, 2553.45, -3107.49, 240.526, 3.89832, 25, 0, 0, 93736, 0, 0, 0),
(88385, 16447, 533, 0, 0, 2559.82, -3151.46, 240.526, 0.87532, 25, 0, 0, 93736, 0, 0, 0),
(88386, 16447, 533, 0, 0, 2562.36, -3154.57, 240.526, 0.87532, 25, 0, 0, 93736, 0, 0, 0),
(88387, 16447, 533, 0, 0, 2560.26, -3153.44, 240.526, 0.87532, 25, 0, 0, 93736, 0, 0, 0),
(88388, 16447, 533, 0, 0, 2562.91, -3150.26, 240.526, 0.87532, 25, 0, 0, 93736, 0, 0, 0),
(88389, 16446, 533, 0, 0, 2553.29, -3298.49, 267.594, 4.90991, 25, 0, 0, 252533, 12000, 0, 0),
(88390, 16446, 533, 0, 0, 2555.65, -3298.02, 267.594, 4.90991, 25, 0, 0, 252533, 12000, 0, 0),
(88391, 16447, 533, 0, 0, 2564.04, -3356.27, 267.594, 0.537598, 25, 0, 0, 93736, 0, 0, 0),
(88392, 16447, 533, 0, 0, 2565.91, -3359.42, 267.594, 0.537598, 25, 0, 0, 93736, 0, 0, 0),

(88116, 16447, 533, 0, 0, 2564.29, -3358.21, 267.594, 0.537598, 25, 0, 0, 93736, 0, 0, 0),
(88115, 16447, 533, 0, 0, 2566.71, -3356.78, 267.594, 0.537598, 25, 0, 0, 93736, 0, 0, 0),
(88114, 16447, 533, 0, 0, 2537.69, -3328.78, 267.594, 5.44123, 25, 0, 0, 93736, 0, 0, 0),
(88113, 16447, 533, 0, 0, 2534.89, -3331.28, 267.594, 5.44123, 25, 0, 0, 93736, 0, 0, 0),
(88112, 16447, 533, 0, 0, 2535.34, -3329.24, 267.594, 5.44123, 25, 0, 0, 93736, 0, 0, 0),
(88111, 16447, 533, 0, 0, 2537.73, -3331.91, 267.594, 5.44123, 25, 0, 0, 93736, 0, 0, 0),
(88110, 16449, 533, 0, 0, 2555.8, -3340.88, 267.594, 1.53387, 25, 5, 0, 65845, 0, 0, 1),
(88109, 16452, 533, 0, 1451, 2558.5, -3502.25, 267.594, 4.83097, 25, 5, 0, 105632, 108270, 0, 1),
(88108, 16452, 533, 0, 1451, 2551.45, -3503.8, 267.594, 4.92836, 25, 5, 0, 105632, 108270, 0, 1),
(88107, 16451, 533, 0, 1232, 2554.83, -3504.11, 267.594, 4.62913, 25, 5, 0, 154800, 25680, 0, 1),
(88106, 16447, 533, 0, 0, 2539.05, -3541.54, 267.594, 5.1632, 25, 0, 0, 93736, 0, 0, 0),
(88105, 16447, 533, 0, 0, 2535.33, -3542.86, 267.594, 5.1632, 25, 0, 0, 93736, 0, 0, 0),
(88104, 16447, 533, 0, 0, 2536.89, -3541.23, 267.594, 5.1632, 25, 0, 0, 93736, 0, 0, 0),
(88103, 16447, 533, 0, 0, 2538.82, -3545.21, 267.594, 5.1632, 25, 0, 0, 93736, 0, 0, 0),
(88102, 16449, 533, 0, 0, 2555.73, -3528.12, 267.594, 4.97392, 25, 5, 0, 65845, 0, 0, 1),
(88101, 16447, 533, 0, 0, 3104.35, -3904.99, 267.593, 0.230284, 25, 0, 0, 93736, 0, 0, 0),

(88673, 16447, 533, 0, 0, 3105.79, -3902.55, 267.593, 0.230284, 25, 0, 0, 93736, 0, 0, 0),
(88672, 16447, 533, 0, 0, 3106.59, -3905.95, 267.593, 0.230284, 25, 0, 0, 93736, 0, 0, 0),
(88671, 16447, 533, 0, 0, 3109.15, -3903.28, 267.593, 0.230284, 25, 0, 0, 93736, 0, 0, 0),
(88670, 16449, 533, 0, 0, 3099.32, -3883.2, 267.593, 6.17182, 25, 5, 0, 65845, 0, 0, 1),
(88669, 16446, 533, 0, 0, 3223.91, -3904.63, 284.276, 3.02866, 25, 0, 0, 252533, 12000, 0, 0),
(88668, 16446, 533, 0, 0, 3223.59, -3907.46, 284.108, 3.02866, 25, 0, 0, 252533, 12000, 0, 0),
(88667, 16446, 533, 0, 0, 3227.23, -3860.86, 286.028, 3.40172, 25, 0, 0, 252533, 12000, 0, 0),
(88666, 16446, 533, 0, 0, 3226.59, -3858.43, 285.691, 3.40172, 25, 0, 0, 252533, 12000, 0, 0),
(88665, 16453, 533, 0, 0, 3200.34, -3884.8, 271.91, 3.22893, 25, 0, 0, 81178, 0, 0, 0),
(88664, 16453, 533, 0, 0, 3199.81, -3878.81, 271.636, 3.22893, 25, 0, 0, 81178, 0, 0, 0),
(88663, 16453, 533, 0, 0, 3180.56, -3880.48, 267.596, 3.09934, 25, 0, 0, 81178, 0, 0, 0),
(88662, 16453, 533, 0, 0, 3180.29, -3886.92, 267.594, 3.09934, 25, 0, 0, 81178, 0, 0, 0),

(88661, 16447, 533, 0, 0, 2698.33, -3905.87, 294.661, 6.15751, 25, 0, 0, 93736, 0, 0, 0),
(88660, 16447, 533, 0, 0, 2691.71, -3903.51, 294.661, 5.72712, 25, 0, 0, 93736, 0, 0, 0),
(88659, 16447, 533, 0, 0, 2694.34, -3906.1, 294.661, 6.14574, 25, 0, 0, 93736, 0, 0, 0),
(88658, 16447, 533, 0, 0, 2695.23, -3903.61, 294.661, 6.17323, 25, 0, 0, 93736, 0, 0, 0),
(88657, 16447, 533, 0, 0, 2534.39, -3745.11, 294.66, 5.16792, 25, 0, 0, 93736, 0, 0, 0),
(88656, 16447, 533, 0, 0, 2537.05, -3751.42, 294.66, 5.20326, 25, 0, 0, 93736, 0, 0, 0),
(88655, 16447, 533, 0, 0, 2534.48, -3749.12, 294.66, 5.22525, 25, 0, 0, 93736, 0, 0, 0),
(88654, 16447, 533, 0, 0, 2537.26, -3748.3, 294.66, 5.18912, 25, 0, 0, 93736, 0, 0, 0),
(88653, 16449, 533, 0, 0, 2698.88, -3883.78, 294.661, 1.14591, 25, 5, 0, 65845, 0, 0, 1),
(88758, 16449, 533, 0, 0, 2556.73, -3740.18, 294.661, 0.699024, 25, 5, 0, 65845, 0, 0, 1),
(88757, 16453, 533, 0, 0, 3451.22, -3622.6, 268.174, 1.47906, 25, 0, 0, 81178, 0, 0, 0),
(88759, 16453, 533, 0, 0, 3458.51, -3621.24, 267.597, 1.51755, 25, 0, 0, 81178, 0, 0, 0),
(88761, 16453, 533, 0, 0, 3450.34, -3607.45, 267.595, 1.5686, 25, 0, 0, 81178, 0, 0, 0),
(88760, 16453, 533, 0, 0, 3457.94, -3608.86, 267.596, 1.55682, 25, 0, 0, 81178, 0, 0, 0),
(88762, 16446, 533, 0, 0, 3435.87, -3657.61, 286.549, 1.6118, 25, 0, 0, 252533, 12000, 0, 0),
(88681, 16446, 533, 0, 0, 3430.02, -3657.79, 286.637, 1.45865, 25, 0, 0, 252533, 12000, 0, 0),
(88680, 16446, 533, 0, 0, 3474.6, -3657.63, 286.561, 1.6275, 25, 0, 0, 252533, 12000, 0, 0),
(88679, 16446, 533, 0, 0, 3480.53, -3657.47, 286.48, 1.61965, 25, 0, 0, 252533, 12000, 0, 0),
(88678, 16447, 533, 0, 0, 3436.56, -3515.73, 267.593, 0.551487, 25, 0, 0, 93736, 0, 0, 0),
(154199, 16447, 533, 0, 0, 3431.03, -3521.39, 267.593, 0.748622, 25, 0, 0, 93736, 0, 0, 0),
(154198, 16447, 533, 0, 0, 3432.97, -3516.82, 267.593, 0.783965, 25, 0, 0, 93736, 0, 0, 0),
(154197, 16447, 533, 0, 0, 3435.5, -3518.7, 267.593, 0.669297, 25, 0, 0, 93736, 0, 0, 0),
(154196, 16447, 533, 0, 0, 3431.17, -3738.49, 294.661, 1.49005, 25, 0, 0, 93736, 0, 0, 0),
(154195, 16447, 533, 0, 0, 3431, -3746.12, 294.661, 1.50183, 25, 0, 0, 93736, 0, 0, 0),
(154194, 16447, 533, 0, 0, 3428.93, -3742.09, 294.661, 1.35496, 25, 0, 0, 93736, 0, 0, 0),
(154193, 16447, 533, 0, 0, 3432.54, -3741.98, 294.661, 1.53874, 25, 0, 0, 93736, 0, 0, 0),
(154192, 16447, 533, 0, 0, 3321.89, -3903.37, 294.661, 3.22342, 25, 0, 0, 93736, 0, 0, 0),
(154191, 16447, 533, 0, 0, 3314.86, -3903.95, 294.661, 3.22342, 25, 0, 0, 93736, 0, 0, 0),
(154190, 16447, 533, 0, 0, 3318.49, -3905.5, 294.661, 3.34516, 25, 0, 0, 93736, 0, 0, 0),
(154189, 16447, 533, 0, 0, 3318.43, -3902.14, 294.661, 3.49517, 25, 0, 0, 93736, 0, 0, 0),
(154188, 16449, 533, 0, 0, 3454.04, -3527.75, 267.594, 4.44629, 25, 5, 0, 65845, 0, 0, 1),
(154187, 16449, 533, 0, 0, 3453.65, -3740.35, 294.661, 2.71056, 25, 5, 0, 65845, 0, 0, 1),
(154186, 16449, 533, 0, 0, 3309.65, -3883.5, 294.661, 2.22362, 25, 5, 0, 65845, 0, 0, 1),
(154185, 16448, 533, 0, 0, 3405.67, -3780.59, 294.662, 4.07009, 25, 0, 0, 19500, 12000, 0, 0),
(154184, 16448, 533, 0, 0, 3409.66, -3783.58, 294.662, 4.07009, 25, 0, 0, 19500, 12000, 0, 0),
(154183, 16448, 533, 0, 0, 3413.66, -3786.57, 294.662, 4.07009, 25, 0, 0, 19500, 12000, 0, 0);

UPDATE `creature_template` SET `scale` = 2, `Faction_A`= 21, `Faction_H` = 21 WHERE `entry`= 16861;
UPDATE `gameobject_template` SET `type` = 10, `data0` = 0, `data10` = 28444, `data11` = 1, `data12` = 129 WHERE `entry` = 181575;
UPDATE `creature_template` SET `scale` = 0 WHERE `entry` = 16064;
UPDATE `creature_template` SET `scale` = 0 WHERE `entry` IN (16775, 16776, 16777, 16778);
UPDATE `creature_template` SET `scale` = 0 WHERE `entry` = 15931;
UPDATE `creature_template` SET `minmana` = 0, `maxmana` = 0 WHERE `entry` IN (16194, 16215, 16216);
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 16028;

DELETE FROM `creature_movement` WHERE `id` = 88298;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88298, 1, 3305.03, -3231.81, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.14091, 0, 0),
(88298, 2, 3257.44, -3230.36, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.78355, 0, 0),
(88298, 3, 3232.6, -3210.97, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.35551, 0, 0),
(88298, 4, 3208.7, -3188.16, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.37515, 0, 0),
(88298, 5, 3182.32, -3163.56, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.37908, 0, 0),
(88298, 6, 3161.25, -3145.45, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.64612, 0, 0),
(88298, 7, 3134.11, -3140.88, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.12128, 0, 0),
(88298, 8, 3107.4, -3145.3, 294.063, 60000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.41188, 0, 0),
(88298, 9, 3134.25, -3140.29, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.17256, 0, 0),
(88298, 10, 3160.95, -3145.5, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.68954, 0, 0),
(88298, 11, 3182.92, -3162.53, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.50497, 0, 0),
(88298, 12, 3209.04, -3188.25, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.49712, 0, 0),
(88298, 13, 3233.26, -3210.67, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.53246, 0, 0),
(88298, 14, 3257.23, -3230.15, 294.063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.17648, 0, 0);

UPDATE `creature_template` SET `gossip_menu_id`=8400, `npcflag`=1 WHERE `entry`=16381;

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (8408,8407,8406,8405,8404,8403,8402,8401,8400);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
(8408, 0, 0, 'So Kel\'Thuzad holds all of the pieces?', 1, 1, 8409, 0, 0, 0, NULL, 0),
(8407, 0, 0, 'So what has led you to Naxxramas?', 1, 1, 8408, 0, 0, 0, NULL, 0),
(8406, 0, 0, 'What happened to the staff?', 1, 1, 8407, 0, 0, 0, NULL, 0),
(8405, 0, 0, 'You said you would have it back. What does that mean?', 1, 1, 8406, 0, 0, 0, NULL, 0),
(8404, 0, 0, 'What staff?', 1, 1, 8405, 0, 0, 0, NULL, 0),
(8403, 0, 0, 'You are talking nonsense, mage.', 1, 1, 8404, 0, 0, 0, NULL, 0),
(8402, 0, 0, 'I still do not understand.', 1, 1, 8403, 0, 0, 0, NULL, 0),
(8401, 0, 0, 'Why have you done such horrible things?', 1, 1, 8402, 0, 0, 0, NULL, 0),
(8400, 0, 0, 'What are you talking about, mage?', 1, 1, 8401, 0, 0, 0, NULL, 0);

DELETE FROM `gossip_menu` WHERE `entry` IN (8409,8408,8407,8406,8405,8404,8403,8402,8401,8400);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(8400, 8517, 0, 0),
(8401, 8518, 0, 0),
(8402, 8519, 0, 0),
(8403, 8520, 0, 0),
(8404, 8521, 0, 0),
(8405, 8522, 0, 0),
(8406, 8523, 0, 0),
(8407, 8529, 0, 0),
(8408, 8530, 0, 0),
(8409, 8531, 0, 0);

-- Correct script and AI names
UPDATE `creature_template` SET `AIName` = NULL, `ScriptName` = NULL WHERE `entry` IN (1, 2, 6491);
UPDATE `creature_template` SET `ScriptName` = 'npc_guardian' WHERE `entry` IN (5764);
UPDATE `creature_template` SET `subname` = NULL WHERE `subname` = '';
UPDATE `creature_template` SET `AIName` = NULL WHERE `AIName` = '';
UPDATE `creature_template` SET `ScriptName` = NULL WHERE `ScriptName` = '';

-- Remove loot from waypoints, spawnpoints
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` IN (1,2);
-- Set proper gossip_menu_id for spirit healer
UPDATE `creature_template` SET `gossip_menu_id` = 83 WHERE `entry` IN (6491);

-- Fix a few template names
UPDATE `creature_template` SET `name` = 'Waypoint' WHERE `entry` IN (1);
UPDATE `creature_template` SET `name` = 'Spawnpoint' WHERE `entry` IN (2);
UPDATE `creature_template` SET `subname` = 'GM Visual' WHERE `entry` IN (1,2);
UPDATE `creature_template` SET `name` = 'Rend on Drake', `subname` = 'Transformation Visual' WHERE `entry` = 10459;
UPDATE `creature_template` SET `name` = 'Kirtonos the Herald', `subname` = 'Spell Visual' WHERE `entry` = 10579;
UPDATE `creature_template` SET `name` = 'Wisp', `subname` = 'Ghost Visual' WHERE `entry` = 12861;
UPDATE `creature_template` SET `name` = 'High Priest Venoxis', `subname` = 'Transformation Visual' WHERE `entry` = 14877;
UPDATE `creature_template` SET `name` = 'High Priestess Jeklik', `subname` = 'Transformation Visual' WHERE `entry` = 14941;
UPDATE `creature_template` SET `name` = 'High Priest Thekal', `subname` = 'Transformation Visual' WHERE `entry` = 14966;
UPDATE `creature_template` SET `name` = 'High Priestess Mar''li', `subname` = 'Transformation Visual' WHERE `entry` = 14967;
UPDATE `creature_template` SET `name` = 'High Priestess Arlokk', `subname` = 'Transformation Visual' WHERE `entry` = 14968;
UPDATE `creature_template` SET `name` = 'Primal Blessing', `subname` = 'Transformation Visual' WHERE `entry` = 15109;
UPDATE `creature_template` SET `name` = 'Buru the Gorger', `subname` = 'Transformation Visual' WHERE `entry` = 15507;
UPDATE `creature_template` SET `name` = 'Mouth Tentacle', `subname` = 'Mount Visual' WHERE `entry` = 15778;
UPDATE `creature_template` SET `name` = "C'Thun", `subname` = 'Transformation Visual' WHERE `entry` = 15809;
UPDATE `creature_template` SET `name` = 'Mor Grayhoof', `subname` = 'Transformation Visual' WHERE `entry` = 16083;
UPDATE `creature_template` SET `name` = 'Arei', `subname` = 'Transformation Visual' WHERE `entry` = 9599;
UPDATE `creature_template` SET `name` = 'Eranikus', `subname` = 'Transformation Visual' WHERE `entry` = 15660;
UPDATE `creature_template` SET `name` = 'High Inquisitor Fairbanks', `subname` = 'Transformation Visual' WHERE `entry` = 16439;
UPDATE `creature_template` SET `name` = 'Highlord Mograine', `subname` = 'Transformation Visual' WHERE `entry` = 16440;
UPDATE `creature_template` SET `name` = 'Scourge Invasion Minion', `subname` = 'Ghost/Ghoul spawner' WHERE `entry` = 16306;
UPDATE `creature_template` SET `name` = 'Scourge Invasion Minion', `subname` = 'Ghost/Skeleton spawner' WHERE `entry` = 16336;
UPDATE `creature_template` SET `name` = 'Scourge Invasion Minion', `subname` = 'Ghoul/Skeleton spawner' WHERE `entry` = 16338;
UPDATE `creature_template` SET `name` = 'Scourge Invasion Minion', `subname` = 'finder' WHERE `entry` = 16356;
UPDATE `creature_template` SET `name` = 'Skeletal Fiend', `subname` = 'Enraged Form' WHERE `entry` = 2454;
UPDATE `creature_template` SET `name` = 'Bear Form', `subname` = 'Night Elf Druid' WHERE `entry` = 4253;
UPDATE `creature_template` SET `name` = 'Bear Form', `subname` = 'Tauren Druid' WHERE `entry` = 4261;
UPDATE `creature_template` SET `name` = 'Aquatic Form', `subname` = 'Night Elf Druid' WHERE `entry` = 4408;
UPDATE `creature_template` SET `name` = 'Aquatic Form', `subname` = 'Tauren Druid' WHERE `entry` = 4410;
UPDATE `creature_template` SET `name` = 'Cat Form', `subname` = 'Night Elf Druid' WHERE `entry` = 6571;
UPDATE `creature_template` SET `name` = 'Cat Form', `subname` = 'Tauren Druid' WHERE `entry` = 6572;
UPDATE `creature_template` SET `name` = 'Travel Form', `subname` = 'Druid' WHERE `entry` = 6573;
UPDATE `creature_template` SET `name` = 'Curse of the Eye', `subname` = 'Male' WHERE `entry` = 7503;
UPDATE `creature_template` SET `name` = 'Curse of the Eye', `subname` = 'Female' WHERE `entry` = 7504;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Orc Male' WHERE `entry` = 10783;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Orc Female' WHERE `entry` = 10784;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Tauren Male' WHERE `entry` = 10785;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Tauren Female' WHERE `entry` = 10786;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Troll Male' WHERE `entry` = 10787;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Troll Female' WHERE `entry` = 10788;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Undead Male' WHERE `entry` = 10789;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Undead Female' WHERE `entry` = 10790;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Dwarf Male' WHERE `entry` = 10791;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Dwarf Female' WHERE `entry` = 10792;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Gnome Male' WHERE `entry` = 10793;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Gnome Female' WHERE `entry` = 10794;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Human Male' WHERE `entry` = 10795;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Human Female' WHERE `entry` = 10796;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = 'Night Elf Male' WHERE `entry` = 10797;
UPDATE `creature_template` SET `name` = 'Orb of Deception', `subname` = '(Night Elf Female)' WHERE `entry` = 10798;
UPDATE `creature_template` SET `name` = 'Monster Generator (Blackwing)', `subname` = NULL WHERE `entry` = 12434;
UPDATE `creature_template` SET `name` = 'World Invisible Trigger', `subname` = 'DO NOT DELETE' WHERE `entry` = 12999;
UPDATE `creature_template` SET `name` = 'Warlock Mount Ritual Mob Type 3 (Infernal)', `subname` = 'DO NOT DELETE' WHERE `entry` = 14501;
UPDATE `creature_template` SET `name` = 'Moonkin', `subname` = 'Night Elf Druid' WHERE `entry` = 15313;
UPDATE `creature_template` SET `name` = 'Moonkin', `subname` = 'Tauren Druid' WHERE `entry` = 15314;
UPDATE `creature_template` SET `name` = 'OLDWorld Trigger', `subname` = 'DO NOT DELETE' WHERE `entry` = 15384;

-- Remove wrong model IDs
UPDATE `creature_template` SET `modelid_2` = 0 WHERE `entry` = 17794;
UPDATE `creature_template` SET `modelid_2` = 0 WHERE `entry` = 16995;
UPDATE `creature_template` SET `modelid_2` = 0 WHERE `entry` = 17795;

-- UPDATE Database Version
UPDATE `db_version` SET `version` = 'ZeroDatabase 2.0.8 for MaNGOSZero z2436+ and ScriptDevZero z2676+';
