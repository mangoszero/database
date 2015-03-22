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

-- Startup Error Fixes
UPDATE `creature_template` SET minlevel=18, maxlevel=19 WHERE entry=3989;
UPDATE `creature_template` SET minlevel=60, maxlevel=60 WHERE entry=14302;

-- drop conditions for recipes. each player can get any recipe (without a proper profession) Thanks kokeszko
DELETE FROM `conditions` WHERE condition_entry IN (6,10,13,16);
UPDATE creature_loot_template SET condition_id=0 WHERE condition_id IN (6,10,13,16);

-- Fix Gossip for npc 8479 and Quest 3441
UPDATE `creature_template` SET gossip_menu_id=1323 WHERE entry=8479;

DELETE FROM `gossip_menu_option` WHERE menu_id IN (1321,1322,1323);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('1321','0','0','Let me confer with my colleagues.','1','1','1323','0','1321','0','0','','0'),
('1322','0','0','Continue please.','1','1','1321','0','0','0','0','','0'),
('1323','0','0','Tell me what drives this vengeance?','1','1','1322','0','0','0','0','','223'),
('1323','2','0','Kalaran, I have misplaced my torch. I require another.','1','1','-1','0','132302','0','0','','538'),
('1323','3','0','Kalaran, please enchant the torch.','1','1','0','0','0','0','0','','0');

DELETE FROM `dbscripts_on_gossip` WHERE id IN (1321,132302);
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1321','0','7','3441','0','0','0','0','0','0','0','0','0','0','0','0','quest 3441 complete of npc 8479'),
('132302','0','15','19797','0','0','0','0','0','0','0','0','0','0','0','0','cast Conjure Torch of Retribution');

DELETE FROM `conditions` WHERE condition_entry IN (223,224,225,538);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('223','9','3441','1'),
('224','24','10515','1'),
('225','8','3454','0'),
('538','-1','225','224');

DELETE FROM `gossip_menu` WHERE entry IN (1321,1322,1323);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('1321','1955','0','0'),
('1322','1954','0','0'),
('1323','1953','0','0');

DELETE FROM `npc_text` WHERE id IN (1953,1954,1955);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `lang0`, `prob0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `lang1`, `prob1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `lang2`, `prob2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `lang3`, `prob3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `lang4`, `prob4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `lang5`, `prob5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `lang6`, `prob6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `lang7`, `prob7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`) VALUES
('1953','Vengeance shall be mine.','','0','1','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0'),
('1954','My father was slain by the filth that inhabits the cauldron. My pleas for assistance to the Stormwind magistrate fell on deaf ears. Nay, they want not to admit that this part of the world even exists, let alone send their precious military in to administer justice.$B$BI seek vengeance, $r, plain and simple. Is there a more passionate cause in this world?','','0','1','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0'),
('1955','As you can see, I am but one man with a lumbering oaf of a squire. The might of the Dark Iron dwarves and the beasts held in the grip of Ragnaros would surely overwhelm me alone, but I have the utmost confidence that such a brave and ambitious adventurer such as you would have no problem handling the denizens of the cauldron. Should you choose to assist me, I shall reward you with riches and wealth beyond your wildest dreams.','','0','1','0','1','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0');

-- Fix Gossip for npc 11956
UPDATE creature_template set gossip_menu_id=3882 WHERE entry=11956;

DELETE FROM `gossip_menu` WHERE entry IN (3881,3882,3883,3884,3885);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('3881','4721','0','0'),
('3882','4718','0','0'),
('3882','4719','0','676'),
('3883','4733','0','0'),
('3884','4734','0','0'),
('3885','4735','0','0');

DELETE FROM `conditions` WHERE condition_entry IN (231,507,676);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('231','9','5930','0'),
('507','9','5929','0'),
('676','-2','507','231');

DELETE FROM `gossip_menu_option` WHERE menu_id IN (3881,3882,3883,3884);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('3881','0','0','I seek to understand the importance of strength of the body.','1','1','3883','0','0','0','0','','0'),
('3882','0','0','What do you represent, spirit?','1','1','3881','0','0','0','0','','676'),
('3883','0','0','I seek to understand the importance of strength of the heart.','1','1','3884','0','0','0','0','','0'),
('3884','0','0','I have heard your words, Great Bear Spirit, and I understand.  I now seek your blessings to fully learn the way of the Claw.','1','1','3885','0','3884','0','0','','507'),
('3884','1','0','I have heard your words, Great Bear Spirit, and I understand.  I now seek your blessings to fully learn the way of the Claw.','1','1','3885','0','3885','0','0','','231');

DELETE FROM `dbscripts_on_gossip` WHERE id IN (3884,3885);
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('3884','1','7','5929','5','0','0','0','0','0','0','0','0','0','0','0','Quest complete 5929'),
('3885','1','7','5930','5','0','0','0','0','0','0','0','0','0','0','0','Quest complete 5930');

DELETE FROM `npc_text` WHERE id IN (4718,4719,4721,4733,4734,4735);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `lang0`, `prob0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `lang1`, `prob1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `lang2`, `prob2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `lang3`, `prob3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `lang4`, `prob4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `lang5`, `prob5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `lang6`, `prob6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `lang7`, `prob7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`) VALUES
('4718','The bear looks at you calmy and patiently, but says nothing.','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0'),
('4719','The bear spirit looks upon you with a calm and peaceful gaze.  You hear a voice speak to you as though it was coming from the bear, but the creature makes no indication that it is speaking.$B$B\"Greetings, my young friend.  If you have come to me seeking guidance, then perhaps I can help you find what you seek.\"','','0','1','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0'),
('4721','I represent the strength which bolsters you as a young druid.  You have come to me to learn this strength, young one, and I will teach this to you.  I will teach you all that is the spirit bear, provided you will listen and understand.$B$BIn order to know what it means to draw upon my spirit, you need to understand the importance of the strength of the body, as well as the strength of the heart.','','0','1','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0'),
('4734','Strength of the heart is what gives you the resolve to take action... action that is rooted in intents that are pure and forthright.  To keep the balance is not to be complacent or banal.$B$BYou must show resolve for that which you believe in, and you must be willing to fight for it.  The mother bear shows endless conviction in protecting her young, as does an elder bear protecting his den.  It is this resolve, this strength of heart, which you must come to know if you are to master the way of the Claw.','','0','1','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0'),
('4733','Strength of the body is the power and swiftness of action.  You must keep yourself fit at all times, both physically and mentally.  The bear\'s girth highlights its strength, as it is a ferocious foe in combat.  The bear\'s girth, however, belies its lithe agility and sharp mind.  These are surprises you will use to your advantage.$B$BYou must rely on the strength of the bear\'s body in order to master the way of the Claw.','','0','1','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0'),
('4735','It remains to be seen if you are ready, young one.  Even the wisest and oldest of druids are never truly ready when their ultimate time of testing comes.$B$BYou have heard my words, and now you must move on.  Heed what I have taught you.  There will be a time when you will have your strength tested.  You must face your foe as the bear would - with strength of body and with strength of heart.  Learn from the fight, young one.  Go... with my blessings.','','0','1','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0','','','0','0','0','0','0','0','0','0');

-- Gossip for npc 12144 fix Quest 6001 and 6002
UPDATE `creature_template` SET gossip_menu_id=3862 WHERE entry=12144;

DELETE FROM `gossip_menu_option` WHERE menu_id=3862;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('3862','0','0','You have fought well, spirit.  I ask you to grant me the strength of your body and the strength of your heart.','1','1','3863','0','386201','0','0','','230'),
('3862','1','0','You have fought well, spirit.  I ask you to grant me the strength of your body and the strength of your heart.','1','1','3863','0','386202','0','0','','455');

DELETE FROM `gossip_menu` WHERE entry IN (3862,3863);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('3862','4714','0','0'),
('3863','4715','0','0');

DELETE FROM `conditions` WHERE condition_entry IN (230,455);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('230','9','6001','1'),
('455','9','6002','1');

DELETE FROM `dbscripts_on_gossip` WHERE id IN (386201,386202);
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('386201','0','7','6001','6','0','0','0','0','0','0','0','0','0','0','0','Spirit of Lunaclaw - Questcredit (Alliance)'),
('386202','0','7','6002','6','0','0','0','0','0','0','0','0','0','0','0','Spirit of Lunaclaw - Questcredit (Horde)');

-- Added text to creature 5494 Thanks Ghurok (add right gossip_menu_id)
UPDATE `creature_template` SET gossip_menu_id=685 WHERE entry=5494;

-- Set resistances of multiple Kolkar mobs to 0
UPDATE `creature_template` SET resistance2=0, resistance5=0 WHERE entry IN (3119,3120,3272,3273,3274,3275,3397,4632,4633,4634,4635,4636,4637,9523,9524,12976,12977);

-- Set resistances of multiple Kobold mobs to 0
UPDATE `creature_template` SET resistance2=0 WHERE entry IN (40,475,476,1236,4111);

-- Remove loot (3939), skinning loots (3939,5766,14865), and make mob non tameable (3939)
DELETE FROM `creature_loot_template` WHERE entry=3939;
DELETE FROM `skinning_loot_template` WHERE entry=10105;
UPDATE `creature_template` SET lootid=0, skinloot=0, type_flags=0 WHERE entry IN (3939,5766,14865);

-- Typo in creature (15842) name thanks danielsreichenbach
UPDATE `creature_template` SET name='Might of Kalimdor Mage' WHERE entry=15842;

-- Fix Sapphiron Blizzlike Spawn Event
DELETE FROM `dbscripts_on_event` WHERE id=10211;
INSERT INTO `dbscripts_on_event` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('10211','0','10','15989','0','0','0','0','0','0','0','0','3521.3','-5237.56','137.72','4.51','Sapphiron Spawn Event');

DELETE FROM `gameobject` WHERE guid=960;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
('960','181356','533','3522.57','-5236.76','137.63','-1.8','0','0','-0.783327','0.62161','604800','100','1');

UPDATE `gameobject_template` SET `data3`=29250, `data10`=1 WHERE `entry`=181356;

DELETE FROM `creature` WHERE guid=88756;

-- Fix Typo in Quest End Script for Quest 963
UPDATE `creature_template` SET MovementType=0 WHERE entry=3843;

-- Creature Type ModelID Fixes Thanks danielsreichenbach
-- Creature fix for 'Dalaran Serpent': correct type
UPDATE `creature_template` SET `type` =  1 WHERE `entry` = 2540;
-- Creature fix for 'Ward of Laze': correct type
UPDATE `creature_template` SET `type` =  11 WHERE `entry` = 2667;
-- Creature fix for 'Trigore the Lasher': correct type
UPDATE `creature_template` SET `type` =  1 WHERE `entry` = 3652;
-- Creature fix for 'Mystlash Flayer': correct type
UPDATE `creature_template` SET `type` =  1 WHERE `entry` = 3772;
-- Creature fix for 'Swamp Ooze': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 4391;
-- Creature fix for 'Corrosive Swamp Ooze': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 4392;
-- Creature fix for 'Illusionary Nightmare': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 4785;
-- Creature fix for 'Force of Nature': correct type
UPDATE `creature_template` SET `type` =  4 WHERE `entry` = 4795;
-- Creature fix for 'Nightmare Ectoplasm': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 5763;
-- Creature fix for 'Cloned Ectoplasm': correct type
UPDATE `creature_template` SET `type` =  4 WHERE `entry` = 5780;
-- Creature fix for 'Deviate Nightmare': correct type
UPDATE `creature_template` SET `type` =  1 WHERE `entry` = 5914;
-- Creature fix for 'Ward of Zanzil': correct type
UPDATE `creature_template` SET `type` =  11 WHERE `entry` = 6386;
-- Creature fix for 'Zul'Farrak Dead Hero': correct type
UPDATE `creature_template` SET `type` =  6 WHERE `entry` = 7276;
-- Creature fix for 'Elven Wisp': correct type
UPDATE `creature_template` SET `type` =  8 WHERE `entry` = 7570;
-- Creature fix for 'Witherbark Bloodling': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 7768;
-- Creature fix for 'Hazzali Parasite': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 7769;
-- Creature fix for 'Sul'lithuz Broodling': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 8138;
-- Creature fix for 'Sul'lithuz Warder': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 8149;
-- Creature fix for 'Servant of Antu'sul': correct type
UPDATE `creature_template` SET `type` =  1 WHERE `entry` = 8156;
-- Creature fix for 'Hakkari Minion': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 8437;
-- Creature fix for 'Hakkari Bloodkeeper': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 8438;
-- Creature fix for 'Shade of Hakkar': correct type
UPDATE `creature_template` SET `type` =  6 WHERE `entry` = 8440;
-- Creature fix for 'Avatar of Hakkar': correct type
UPDATE `creature_template` SET `type` =  6 WHERE `entry` = 8443;
-- Creature fix for 'Idol Oven Fire Target': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 8662;
-- Creature fix for 'Deathly Usher': correct type
UPDATE `creature_template` SET `type` =  6 WHERE `entry` = 8816;
-- Creature fix for 'Pet Bomb': correct type
UPDATE `creature_template` SET `type` =  9 WHERE `entry` = 8937;
-- Creature fix for 'Spawn of Bael'Gar': correct type
UPDATE `creature_template` SET `type` =  4 WHERE `entry` = 9436;
-- Creature fix for 'Cloned Ooze': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 9477;
-- Creature fix for 'Gorishi Grub': correct type
UPDATE `creature_template` SET `type` =  1 WHERE `entry` = 9498;
-- Creature fix for 'Gargantuan Ooze': correct type
UPDATE `creature_template` SET `type` =  10 WHERE `entry` = 9621;
-- Creature fix for 'Gorishi Hive Guard': correct type
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 10040;
-- Creature fix for 'Gorishi Hive Queen': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 10041;
-- Creature fix for 'Captured Felwood Ooze': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 10290;
-- Creature fix for 'Bile Slime': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 10697;
-- Creature fix for 'Rotting Worm': correct type
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 10925;
-- Creature fix for 'Skeletal Black Warhorse': correct type
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 11195;
-- Creature fix for 'Bazzalan': correct type
UPDATE `creature_template` SET `type` = 3 WHERE `entry` = 11519;
-- Creature fix for 'Ley Sprite': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 12381;
-- Creature fix for 'Vorsha the Lasher': correct type
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 12940;
-- Creature fix for 'Hive'Ashi Ambusher': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 13301;
-- Creature fix for 'PvP Graveyard Credit Marker': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 13756;
-- Creature fix for 'PvP Tower Credit Marker': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 13778;
-- Creature fix for 'PvP Mine Credit Marker': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 13796;
-- Creature fix for 'Demon Portal': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 14081;
-- Creature fix for 'Blue Drakonid': correct type
UPDATE `creature_template` SET `type` = 2 WHERE `entry` = 14261;
-- Creature fix for 'Green Drakonid': correct type
UPDATE `creature_template` SET `type` = 2 WHERE `entry` = 14262;
-- Creature fix for 'Bronze Drakonid': correct type
UPDATE `creature_template` SET `type` = 2 WHERE `entry` = 14263;
-- Creature fix for 'Red Drakonid': correct type
UPDATE `creature_template` SET `type` = 2 WHERE `entry` = 14264;
-- Creature fix for 'Black Drakonid': correct type
UPDATE `creature_template` SET `type` = 2 WHERE `entry` = 14265;
-- Creature fix for 'Chromatic Drakonid': correct type
UPDATE `creature_template` SET `type` = 2 WHERE `entry` = 14302;
-- Creature fix for 'Human Orphan': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 14306;
-- Creature fix for 'Warpwood Spores': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 14366;
-- Creature fix for 'Alarm-o-Bot': correct type
UPDATE `creature_template` SET `type` = 9 WHERE `entry` = 14434;
-- Creature fix for 'Orcish Orphan': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 14444;
-- Creature fix for 'Alliance Battle Standard': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 14465;
-- Creature fix for 'Horde Battle Standard': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 14466;
-- Creature fix for 'High Priestess Arlokk': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 14515;
-- Creature fix for 'Vartrus the Ancient': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 14524;
-- Creature fix for 'Stoma the Ancient': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 14525;
-- Creature fix for 'Hastat the Ancient': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 14526;
-- Creature fix for 'Emissary Roman'khan': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 14862;
-- Creature fix for 'PvP A-Mid Credit Marker': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 15001;
-- Creature fix for 'PvP Mid Credit Marker': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 15002;
-- Creature fix for 'PvP ALT-S Credit Marker': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 15004;
-- Creature fix for 'PvP ALT-N Credit Marker': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 15005;
-- Creature fix for 'Arathi Farmer': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15045;
-- Creature fix for 'Forsaken Farmer': correct type
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 15046;
-- Creature fix for 'Arathi Lumberjack': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15062;
-- Creature fix for 'Arathi Blacksmith': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15063;
-- Creature fix for 'Forsaken Blacksmith': correct type
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 15064;
-- Creature fix for 'Arathi Miner': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15074;
-- Creature fix for 'Forsaken Miner': correct type
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 15075;
-- Creature fix for 'Arathi Stablehand': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15086;
-- Creature fix for 'Forsaken Stablehand': correct type
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 15087;
-- Creature fix for 'Forsaken Lumberjack': correct type
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 15089;
-- Creature fix for 'Swift Zulian Tiger': correct type
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 15104;
-- Creature fix for 'Arathi Horse': correct type and modelid
UPDATE `creature_template` SET `type` = 1, `modelid_1` = 229 WHERE `entry` = 15107;
-- Creature fix for 'Forsaken Horse': correct type
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 15108;
-- Creature fix for 'Pat's Splash Guy': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15140;
-- Creature fix for 'The Banshee Queen': correct type and modelid
UPDATE `creature_template` SET `type` = 7, `modelid_1` = 11657 WHERE `entry` = 15193;
-- Creature fix for 'Hoary Templar': correct type
UPDATE `creature_template` SET `type` = 4 WHERE `entry` = 15212;
-- Creature fix for 'Xil'xix': correct type
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 15286;
-- Creature fix for 'Aluntir': correct type
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 15288;
-- Creature fix for 'Arakis': correct type
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 15290;
-- Creature fix for 'Qiraji Swarmguard': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15343;
-- Creature fix for 'Swarmguard Needler': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15344;
-- Creature fix for 'Colonel Zerran': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15385;
-- Creature fix for 'Major Yeggeth': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15386;
-- Creature fix for 'Qiraji Warrior': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15387;
-- Creature fix for 'Major Pakkon': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15388;
-- Creature fix for 'Captain Drenn': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15389;
-- Creature fix for 'Captain Xurrem': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15390;
-- Creature fix for 'Captain Qeez': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15391;
-- Creature fix for 'Captain Tuubid': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15392;
-- Creature fix for 'Disgusting Oozeling': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 15429;
-- Creature fix for 'Lieutnant General Andorov': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15471;
-- Creature fix for 'Kaldorei Elite': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15473;
-- Creature fix for 'Glob of Viscidus': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 15667;
-- Creature fix for 'Father Winter's Helper': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15698;
-- Creature fix for 'Winter's Little Helper': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15705;
-- Creature fix for 'Winter Reindeer': correct type
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 15706;
-- Creature fix for 'Eye Tentacle': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 15726;
-- Creature fix for 'Colossal Anubisath Warbringer': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 15743;
-- Creature fix for 'Imperial Qiraji Destroyer': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 15744;
-- Creature fix for 'Flesh Tentacle': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 15802;
-- Creature fix for 'Lieutenant General Nokhor': correct type, and modelid
UPDATE `creature_template` SET `type` = 7, `modelid_1` = 15738 WHERE `entry` = 15818;
-- Creature fix for 'Lord Valthalak': correct type
UPDATE `creature_template` SET `type` = 2 WHERE `entry` = 16042;
-- Creature fix for 'Peddlefeet': correct type
UPDATE `creature_template` SET `type` = 7 WHERE `entry` = 16085;
-- Creature fix for 'Shadow of Doom': correct type
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 16143;
-- Creature fix for 'Plagued Gargoyle': correct type
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 16446;
-- Creature fix for 'Stormpike Battle Standard': correct type
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 19045;

-- Cleanup
UPDATE gameobject SET state = 0 WHERE id IN (SELECT entry FROM gameobject_template WHERE type = 0 AND data0 = 1);
UPDATE creature_template SET unit_flags=unit_flags&~2048 WHERE unit_flags&2048=2048;
UPDATE creature_template SET unit_flags=unit_flags&~524288 WHERE unit_flags&524288=524288;
UPDATE creature_template SET unit_flags=unit_flags&~67108864 WHERE unit_flags&67108864=67108864;
UPDATE creature_template SET unit_flags=unit_flags&~8388608 WHERE unit_flags&8388608=8388608;
UPDATE creature, creature_template SET creature.curhealth=creature_template.minhealth,creature.curmana=creature_template.minmana WHERE creature.id=creature_template.entry and creature_template.RegenHealth = '1';
UPDATE creature_template SET dynamicflags = dynamicflags &~ 223;
UPDATE creature_template SET npcflag = npcflag&~16777216; -- UNIT_NPC_FLAG_SPELLCLICK
-- UPDATE creature_template c1, creature_template c2 SET c2.unit_class=c1.unit_class, c2.npcflag=c1.npcflag, c2.faction_A=c1.faction_A, c2.faction_H=c1.faction_H, c2.speed_walk=c1.speed_walk, c2.speed_run=c1.speed_run, c2.scale=c1.scale, c2.InhabitType=c1.InhabitType, c2.MovementType=c1.MovementType, c2.unit_flags=c1.unit_flags WHERE c2.entry=c1.difficulty_entry_1;
-- UPDATE creature_template c1, creature_template c2 SET c2.unit_class=c1.unit_class, c2.npcflag=c1.npcflag, c2.faction_A=c1.faction_A, c2.faction_H=c1.faction_H, c2.speed_walk=c1.speed_walk, c2.speed_run=c1.speed_run, c2.scale=c1.scale, c2.InhabitType=c1.InhabitType, c2.MovementType=c1.MovementType, c2.unit_flags=c1.unit_flags WHERE c2.entry=c1.difficulty_entry_2;
-- UPDATE creature_template c1, creature_template c2 SET c2.unit_class=c1.unit_class, c2.npcflag=c1.npcflag, c2.faction_A=c1.faction_A, c2.faction_H=c1.faction_H, c2.speed_walk=c1.speed_walk, c2.speed_run=c1.speed_run, c2.scale=c1.scale, c2.InhabitType=c1.InhabitType, c2.MovementType=c1.MovementType, c2.unit_flags=c1.unit_flags WHERE c2.entry=c1.difficulty_entry_3;
-- UPDATE gameobject_template SET flags=flags&~4 WHERE type IN (2,19,17);
UPDATE creature SET MovementType = 0 WHERE spawndist = 0 AND MovementType=1;
UPDATE creature SET spawndist=0 WHERE MovementType=0;
UPDATE quest_template SET SpecialFlags=SpecialFlags|1 WHERE QuestFlags=QuestFlags|4096;
UPDATE quest_template SET SpecialFlags=SpecialFlags|1 WHERE QuestFlags=QuestFlags|32768;
DELETE FROM go,gt USING gameobject go LEFT JOIN gameobject_template gt ON go.id=gt.entry WHERE gt.entry IS NULL;
DELETE FROM gi,gt USING gameobject_involvedrelation gi LEFT JOIN gameobject_template gt ON gi.id=gt.entry WHERE gt.entry IS NULL;
DELETE FROM gqr,gt USING gameobject_questrelation gqr LEFT JOIN gameobject_template gt ON gqr.id=gt.entry WHERE gt.entry IS NULL;
DELETE FROM ge,go USING game_event_gameobject ge LEFT JOIN gameobject go ON ge.guid=go.guid WHERE go.guid IS NULL;
DELETE FROM dbscripts_on_go_use WHERE id NOT IN (SELECT guid FROM gameobject);
DELETE FROM dbscripts_on_go_use WHERE command IN (11, 12) AND datalong!=0 AND datalong NOT IN (SELECT guid FROM gameobject);
DELETE FROM gameobject_battleground WHERE guid NOT IN (SELECT guid FROM gameobject);
DELETE FROM creature_battleground WHERE guid NOT IN (SELECT guid FROM creature);
DELETE FROM creature_addon WHERE guid NOT IN (SELECT guid FROM creature);
UPDATE creature_addon SET moveflags=moveflags &~ 0x00000100; -- SPLINEFLAG_DONE
UPDATE creature_addon SET moveflags=moveflags &~ 0x00000200; -- SPLINEFLAG_FALLING
UPDATE creature_addon SET moveflags=moveflags &~ 0x00000800; -- SPLINEFLAG_TRAJECTORY (can crash client)
UPDATE creature_addon SET moveflags=moveflags &~ 0x00200000; -- SPLINEFLAG_UNKNOWN3 (can crash client)
UPDATE creature_addon SET moveflags=moveflags &~ 0x08000000;
UPDATE creature_template_addon SET moveflags=moveflags &~ 0x00000100;
UPDATE creature_template_addon SET moveflags=moveflags &~ 0x00000200;
UPDATE creature_template_addon SET moveflags=moveflags &~ 0x00000800;
UPDATE creature_template_addon SET moveflags=moveflags &~ 0x00200000;
UPDATE creature_template_addon SET moveflags=moveflags &~ 0x08000000;
DELETE FROM npc_gossip WHERE npc_guid NOT IN (SELECT guid FROM creature);
DELETE FROM creature_movement WHERE id NOT IN (SELECT guid FROM creature);
DELETE FROM game_event_creature WHERE guid NOT IN (SELECT guid FROM creature);
DELETE FROM creature_questrelation WHERE id NOT IN (SELECT entry FROM creature_template);
DELETE FROM creature_onkill_reputation WHERE creature_id NOT IN (SELECT entry FROM creature_template);
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry IN (SELECT id FROM creature_questrelation UNION SELECT id FROM creature_involvedrelation);

-- UPDATE Database Version
UPDATE db_version set version = 'ZeroDatabase 2.0.3 for MaNGOSZero z2269+ and ScriptDevZero z2634+';
