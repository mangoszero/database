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

-- Fix npc gossip (15609) this fix quest 8738 close #36
UPDATE `creature_template` SET `gossip_menu_id` = 6692 WHERE `entry`= 15609;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 6692;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('6692','0','0','May I have your report?','1','1','-1','0','6692','0','0',NULL,'1777');

DELETE FROM `gossip_menu` WHERE `entry` = 6692;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('6692','8065','0','0');

DELETE FROM `conditions` WHERE `condition_entry` IN (1771, 1774, 1777);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('1771','9','8738','0'),
('1774','24','21160','1'),
('1777','-1','1771','1774');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 6692;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('6692','0','15','25847','0','0','0','0','0','0','0','0','0','0','0','0','Create Hive\'Regal Scout Report');

-- Small Update for Quest 5561 Thanks Ghurok
UPDATE `quest_template` SET `ReqSpellCast1` = 0 WHERE `entry` = 5561;

-- Fix Gossip of NPC (11800) and (11798) close #38
UPDATE `creature_template` SET `gossip_menu_id` = 4041 WHERE `entry` = 11800;
UPDATE `creature_template` SET `gossip_menu_id` = 4042 WHERE `entry` = 11798;

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (4041, 4042);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('4041','0','0','I\'d like to fly to Rut\'theran Village.','1','1','-1','0','4041','0','0',NULL,'520'),
('4041','1','0','Do you know where I can find Half Pendant of Aquatic Agility?','1','1','20009','0','0','0','0',NULL,'677'),
('4042','0','0','I\'d like to fly to Thunder Bluff.','1','1','-1','0','4042','0','0',NULL,'519'),
('4042','1','0','Do you know where I can find Half Pendant of Aquatic Endurance?','1','1','20010','0','0','0','0',NULL,'677');

DELETE FROM `gossip_menu` WHERE `entry` IN (4041 ,4042, 20009, 20010);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('4041','4913','0','75'),
('4041','4914','0','520'),
('4041','4915','0','519'),
('4042','4916','0','75'),
('4042','4917','0','520'),
('4042','4918','0','519'),
('20009','5375','0','159'),
('20009','5376','0','158'),
('20010','5373','0','159'),
('20010','5374','0','158');

DELETE FROM `dbscripts_on_gossip` WHERE `id` IN (4041, 4042);
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('4041','0','30','315','0','0','0','0','0','0','0','0','0','0','0','0','fly to Rut\'theran Village'),
('4042','0','30','316','0','0','0','0','0','0','0','0','0','0','0','0','fly to Thunder Bluff');

DELETE FROM `conditions` WHERE `condition_entry` IN (75, 102, 158, 159, 519, 520, 677);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('75','14','0','511'),
('102','14','0','1024'),
('158','9','30','0'),
('159','9','272','0'),
('519','-1','4','102'),
('520','-1','5','102'),
('677','-2','158','159');

-- Fix NPC Gossip (15171,15170) This fix Quest 8304 close #41
UPDATE `creature_template` SET `gossip_menu_id` = 6533 WHERE `entry` = 15171;
UPDATE `creature_template` SET `gossip_menu_id` = 6534 WHERE `entry` = 15170;

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (6533, 6552, 6553, 6554, 6555, 6556, 6557, 6558);
INSERT `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('6533','0','0','Hello, Frankal. I\'ve heard that you might have some information as to the whereabouts of Mistress Natalia Mar\'alith.','1','1','6558','0','0','0','0',NULL,'512'),
('6552','0','0','Thanks for the information, Frankal.','1','1','-1','0','6552','0','0',NULL,'0'),
('6553','0','0','What a story! So she went into Hive\'Regal and that was the last you saw of her?','1','1','6552','0','0','0','0',NULL,'0'),
('6554','0','0','Then what?','1','1','6553','0','0','0','0',NULL,'0'),
('6555','0','0','I\'ve been meaning to ask out about that monkey.','1','1','6554','0','0','0','0',NULL,'0'),
('6556','0','0','You couldn\'t handle a lone night elf priestess?','1','1','6555','0','0','0','0',NULL,'0'),
('6557','0','0','That\'s odd.','1','1','6556','0','0','0','0',NULL,'0'),
('6558','0','0','That\'s what I like to hear.','1','1','6557','0','0','0','0',NULL,'0');

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (6534, 6545, 6546, 6547, 6548, 6549, 6550, 6551);
INSERT `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('6534','0','0','Hello, Rutgar. The Commander has sent me here to gather some information about his missing wife.','1','1','6551','0','0','0','0',NULL,'512'),
('6545','0','0','I\'ll be back once I straighten this mess out.','1','1','-1','0','6545','0','0',NULL,'0'),
('6546','0','0','Possessed by what?','1','1','6545','0','0','0','0',NULL,'0'),
('6547','0','0','Lost it? What do you mean?','1','1','6546','0','0','0','0',NULL,'0'),
('6548','0','0','What demands?','1','1','6547','0','0','0','0',NULL,'0'),
('6549','0','0','Natalia?','1','1','6548','0','0','0','0',NULL,'0'),
('6550','0','0','What happened to her after that?','1','1','6549','0','0','0','0',NULL,'0'),
('6551','0','0','That sounds dangerous.','1','1','6550','0','0','0','0',NULL,'0');

DELETE FROM `gossip_menu` WHERE `entry` IN (6533, 6552, 6553, 6554, 6555 ,6556, 6557, 6558);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('6533','7735','0','0'),
('6552','7768','0','0'),
('6553','7767','0','0'),
('6554','7766','0','0'),
('6555','7765','0','0'),
('6556','7764','0','0'),
('6557','7763','0','0'),
('6558','7762','0','0');

DELETE FROM `gossip_menu` WHERE `entry` IN (6534, 6545, 6546, 6547, 6548, 6549, 6550, 6551);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('6534','7736','0','0'),
('6545','7761','0','0'),
('6546','7760','0','0'),
('6547','7759','0','0'),
('6548','7758','0','0'),
('6549','7757','0','0'),
('6550','7756','0','0'),
('6551','7755','0','0');

DELETE FROM `conditions` WHERE `condition_entry` = 512;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('512','9','8304','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 6552;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('6552','0','8','15221','0','0','0','0','0','0','0','0','0','0','0','0','cast killcredit 15221');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 6545;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('6545','0','8','15222','0','0','0','0','0','0','0','0','0','0','0','0','cast killcredit 15222');

-- Fix MinLevel of Quest (8725)
UPDATE `quest_template` SET `MinLevel` = 1 WHERE `entry` = 8725;

-- Delete duplicate mailbox in Ironforge - Military Ward
DELETE FROM `gameobject` WHERE `guid` = 7875 AND `id` = 171556;

-- Remove TBC and WotLK game objects
DELETE FROM `gameobject_template` WHERE `entry` IN(181626, 183342, 183343, 185317, 185318, 185319, 186622, 186623, 187080, 210068, 300029);
DELETE FROM `gameobject` WHERE `id` IN(181626, 183342, 183343, 185317, 185318, 185319, 186622, 186623, 187080, 210068, 300029);

-- Set Spawners/Triggers to use the infamous infernal model, and make them invisible
UPDATE `creature_template` SET `modelid_1` = 1126, `modelid_2` = 0, `type` = 10,`flags_extra` = `flags_extra` | 128 WHERE `entry` IN (7898,8611,11179,11494,12758,12999,13477,13876,14026,14027,14028,14029,14030,14031,14307,14309,14310,14311,14312,14422,14443,14449,14495,14606,14646,14758,15091,15164,15218,15221,15222,15384,15426,15454,15590,15695,15717,15800,15922,15957,15964,16006,16044,16045,16046,16047,16048,16079,16082,16100,16137,16306,16336,16338,16430,16606);

-- Insert missing creature templates
DELETE FROM `creature_template` WHERE `entry` IN (17719, 17720);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `modelid_1`, `modelid_2`, `name`, `subname`, `gossip_menu_id`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Civilian`, `RacialLeader`, `RegenHealth`, `equipment_id`, `trainer_id`, `vendor_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
('17719', '0', '0', '17202', '0', 'Ironforge Gryphon Rider', NULL, '0', '1', '1', '300', '300', '0', '0', '20', '35', '35', '0', '1', '1.14286', '1', '0', '1', '1.29', '0', '100', '1', '1400', '1900', '0', '0', '0', '0', '0', '0', '0', '0', '0.344828', '0.444828', '100', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', NULL, '1', '3', '0', '0', '1', '0', '0', '0', '0', '0', NULL), ('17720', '0', '0', '17203', '0', 'Orgrimmar Wyvern Rider', NULL, '0', '1', '1', '300', '300', '0', '0', '20', '35', '35', '0', '1', '1.14286', '1', '0', '1', '1.29', '0', '100', '1', '1400', '1900', '0', '0', '0', '0', '0', '0', '0', '0', '0.344828', '0.444828', '100', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', NULL, '1', '3', '0', '0', '1', '0', '0', '0', '0', '0', NULL);

-- Fix Quest (3520)
UPDATE `creature_template` SET `gossip_menu_id` = 1405, `flags_extra` = `flags_extra` | 2050 WHERE `entry` = 8612;
DELETE FROM `gossip_menu` WHERE `entry` = 1405;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('1405','2039','1405','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 1405;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1405','0','8','8612','0','0','0','0','0','0','0','0','0','0','0','0','give killcredit - Screecher Spirit'),
('1405','2','29','1','2','8612','5','0','0','0','0','0','0','0','0','0','');

-- Fix Quest (5742)
UPDATE `creature_template` SET `gossip_menu_id` = 3502  WHERE `entry` = 1855;

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (3502, 3681, 3682, 3683);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('3502','0','0','I am ready to hear your tale, Tirion.','1','1','3683','0','0','0','0',NULL,'139'),
('3681','0','0','I will, Tirion.','1','1','-1','0','3681','0','0',NULL,'0'),
('3682','0','0','That is terrible.','1','1','3681','0','0','0','0',NULL,'0'),
('3683','0','0','Thank you, Tirion. What of your identity?','1','1','3682','0','0','0','0',NULL,'0');

DELETE FROM `conditions` WHERE `condition_entry` = 139;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('139','9','5742','0');

DELETE FROM `gossip_menu` WHERE `entry` IN (3502, 3681, 3682, 3683);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('3502','4254','0','0'),
('3502','4673','0','139'),
('3681','4495','0','0'),
('3682','4494','0','0'),
('3683','4493','0','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 3681;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('3681','0','7','5742','0','0','0','0','0','0','0','0','0','0','0','0','complete quest');

-- Fix Quests (4285), (4287), (4288)
-- Quest (4285)
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 2177;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('2177','0','0','I want to examine this pylon.','1','1','2181','0','2177','0','0','','316');

DELETE FROM `gossip_menu` WHERE `entry` IN (2177, 2181);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('2177','2810','0','123'),
('2177','2933','0','124'),
('2181','2812','0','0');

DELETE FROM `conditions` WHERE `condition_entry` IN (123, 124, 316);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('123','22','4321','0'),
('124','8','4321','0'),
('316','9','4285','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 2177;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('2177','0','7','4285','0','0','0','0','0','0','0','0','0','0','0','0','explore northern pylon');

-- Quest (4287)
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 2178;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('2178','0','0','I want to examine this pylon.','1','1','2180','0','2178','0','0','','317');

DELETE FROM `gossip_menu` WHERE `entry` IN (2178, 2180);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('2178','2810','0','123'),
('2178','2933','0','124'),
('2180','2811','0','0');

DELETE FROM `conditions` WHERE `condition_entry` = 317;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('317','9','4287','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 2178;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('2178','0','7','4287','0','0','0','0','0','0','0','0','0','0','0','0','explore eastern pylon');

-- Quest (4288)
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 2179;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('2179','0','0','I want to examine this pylon.','1','1','2182','0','2179','0','0','','318');

DELETE FROM `gossip_menu` WHERE `entry` IN (2179, 2182);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('2179','2810','0','123'),
('2179','2933','0','124'),
('2182','2813','0','0');

DELETE FROM `conditions` WHERE `condition_entry` = 318;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('318','9','4288','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 2179;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('2179','0','7','4288','0','0','0','0','0','0','0','0','0','0','0','0','explore western pylon');

-- Make Gameobject (176361) Untargetable
UPDATE `gameobject_template` SET `flags` = 4 WHERE `entry` = 176361;

-- Fix a lot of creature_template.scale
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 69;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 299;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 374;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 417;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 460;
UPDATE `creature_template` SET `scale` = 1.62 WHERE `entry` = 646;
UPDATE `creature_template` SET `scale` = 10 WHERE `entry` = 659;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 704;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 705;
UPDATE `creature_template` SET `scale` = 1.3 WHERE `entry` = 889;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 944;
UPDATE `creature_template` SET `scale` = 0.61 WHERE `entry` = 1015;
UPDATE `creature_template` SET `scale` = 0.61 WHERE `entry` = 1020;
UPDATE `creature_template` SET `scale` = 0.86 WHERE `entry` = 1108;
UPDATE `creature_template` SET `scale` = 0.88 WHERE `entry` = 1114;
UPDATE `creature_template` SET `scale` = 0.74 WHERE `entry` = 1133;
UPDATE `creature_template` SET `scale` = 0.72 WHERE `entry` = 1138;
UPDATE `creature_template` SET `scale` = 1.4 WHERE `entry` = 1200;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1211;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1228;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1268;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1269;
UPDATE `creature_template` SET `scale` = 0.47 WHERE `entry` = 1417;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1454;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1466;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 1508;
UPDATE `creature_template` SET `scale` = 0.71 WHERE `entry` = 1509;
UPDATE `creature_template` SET `scale` = 0.4 WHERE `entry` = 1512;
UPDATE `creature_template` SET `scale` = 0.41 WHERE `entry` = 1513;
UPDATE `creature_template` SET `scale` = 0.42 WHERE `entry` = 1553;
UPDATE `creature_template` SET `scale` = 0.44 WHERE `entry` = 1554;
UPDATE `creature_template` SET `scale` = 1.33 WHERE `entry` = 1557;
UPDATE `creature_template` SET `scale` = 1.33 WHERE `entry` = 1653;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1676;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 1693;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 1842;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1889;
UPDATE `creature_template` SET `scale` = 1.33 WHERE `entry` = 1895;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1914;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1915;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 1949;
UPDATE `creature_template` SET `scale` = 1.33 WHERE `entry` = 2033;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 2339;
UPDATE `creature_template` SET `scale` = 1.33 WHERE `entry` = 2348;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 2476;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2478;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2487;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 2489;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 2491;
UPDATE `creature_template` SET `scale` = 0.66 WHERE `entry` = 2560;
UPDATE `creature_template` SET `scale` = 1.33 WHERE `entry` = 2635;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 2682;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 2683;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 2687;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 2688;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2798;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 2806;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 2920;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 2921;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2947;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2948;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2980;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2981;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2982;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2984;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2985;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2986;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 2987;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2988;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 2991;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2993;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2994;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2995;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2996;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 2997;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2998;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 2999;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3001;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3002;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3003;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3004;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3005;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3007;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3008;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3009;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3010;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3011;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3012;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3013;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3014;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3015;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3016;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3017;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3018;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3019;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3020;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3021;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3022;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3023;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3024;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3025;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3026;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3027;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3028;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3029;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3030;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3031;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3032;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3033;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3034;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3036;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3037;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3038;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3039;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3040;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3041;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3042;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3043;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3050;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3052;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3054;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3055;
UPDATE `creature_template` SET `scale` = 1.62 WHERE `entry` = 3057;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3059;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3060;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3061;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3062;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3063;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3064;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3065;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3066;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3067;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3069;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3072;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3073;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3074;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3075;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3076;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3077;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3078;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3079;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3080;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3081;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3083;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3084;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3092;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3093;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3095;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 3096;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 3102;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 3133;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 3181;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3209;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3210;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3211;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3212;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3213;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3214;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3215;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3217;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3218;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3219;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3220;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3221;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3222;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3223;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3224;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3233;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 3290;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 3322;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3341;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3387;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3388;
UPDATE `creature_template` SET `scale` = 1.4 WHERE `entry` = 3398;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3418;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3441;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3447;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3448;
UPDATE `creature_template` SET `scale` = 0.57 WHERE `entry` = 3461;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3480;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3483;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3486;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3500;
UPDATE `creature_template` SET `scale` = 0.9 WHERE `entry` = 3503;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 3524;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 3653;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 3666;
UPDATE `creature_template` SET `scale` = 1.62 WHERE `entry` = 3678;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3685;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3688;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3689;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3690;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 3692;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3703;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3704;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3705;
UPDATE `creature_template` SET `scale` = 1.4 WHERE `entry` = 3754;
UPDATE `creature_template` SET `scale` = 1.4 WHERE `entry` = 3755;
UPDATE `creature_template` SET `scale` = 1.3 WHERE `entry` = 3765;
UPDATE `creature_template` SET `scale` = 1.4 WHERE `entry` = 3770;
UPDATE `creature_template` SET `scale` = 1.3 WHERE `entry` = 3771;
UPDATE `creature_template` SET `scale` = 0.51 WHERE `entry` = 3866;
UPDATE `creature_template` SET `scale` = 0.51 WHERE `entry` = 3868;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3883;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3884;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3934;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3978;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 4040;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 4077;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 4081;
UPDATE `creature_template` SET `scale` = 1.33 WHERE `entry` = 4119;
UPDATE `creature_template` SET `scale` = 0.5 WHERE `entry` = 4196;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 4202;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 4253;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 4261;
UPDATE `creature_template` SET `scale` = 0.44 WHERE `entry` = 4263;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4309;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4310;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4312;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 4317;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 4356;
UPDATE `creature_template` SET `scale` = 1.75 WHERE `entry` = 4357;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 4388;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 4408;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 4410;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 4425;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 4430;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4451;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 4453;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 4454;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 4495;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 4619;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4629;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 4720;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4721;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4722;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 4810;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 4812;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4814;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4876;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 4877;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4878;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 4941;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 4943;
UPDATE `creature_template` SET `scale` = 0.87 WHERE `entry` = 4950;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5054;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5100;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5114;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5127;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5128;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5129;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5132;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5144;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5145;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5146;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5151;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5152;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5157;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5158;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5162;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5163;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5167;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5169;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5171;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5172;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5174;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5175;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5177;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5178;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5189;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 5226;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 5314;
UPDATE `creature_template` SET `scale` = 1.8 WHERE `entry` = 5345;
UPDATE `creature_template` SET `scale` = 1.45 WHERE `entry` = 5352;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5390;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 5407;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 5412;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5518;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5519;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5520;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5568;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5569;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5599;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5612;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 5726;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 5730;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 5760;
UPDATE `creature_template` SET `scale` = 0.75 WHERE `entry` = 5766;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5767;
UPDATE `creature_template` SET `scale` = 1.62 WHERE `entry` = 5769;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 5770;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5784;
UPDATE `creature_template` SET `scale` = 1.03 WHERE `entry` = 5792;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5860;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5862;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 5888;
UPDATE `creature_template` SET `scale` = 0.5 WHERE `entry` = 5890;
UPDATE `creature_template` SET `scale` = 0.85 WHERE `entry` = 5897;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 5901;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 5905;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5906;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5938;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 5939;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 5940;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 5944;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 5982;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 5997;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6001;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 6028;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6119;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6120;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6169;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6221;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6222;
UPDATE `creature_template` SET `scale` = 1.26 WHERE `entry` = 6223;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6224;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 6290;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6328;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6376;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 6387;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6391;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6392;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 6393;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 6394;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6407;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 6410;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 6466;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6496;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6569;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 6571;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 6572;
UPDATE `creature_template` SET `scale` = 0.75 WHERE `entry` = 6573;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6577;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6579;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 6666;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6667;
UPDATE `creature_template` SET `scale` = 1.3 WHERE `entry` = 6726;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6730;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 6746;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 6747;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 6775;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 6776;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 6782;
UPDATE `creature_template` SET `scale` = 1.09 WHERE `entry` = 6826;
UPDATE `creature_template` SET `scale` = 0.87 WHERE `entry` = 7078;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 7089;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7207;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7312;
UPDATE `creature_template` SET `scale` = 0.9 WHERE `entry` = 7405;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7406;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7427;
UPDATE `creature_template` SET `scale` = 1.07 WHERE `entry` = 7430;
UPDATE `creature_template` SET `scale` = 1.75 WHERE `entry` = 7440;
UPDATE `creature_template` SET `scale` = 1.62 WHERE `entry` = 7441;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7546;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7547;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7548;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7551;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7554;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7556;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7558;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7559;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7561;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7570;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7603;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7668;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7670;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7671;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7714;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 7725;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 7726;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 7727;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 7737;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7763;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7766;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 7767;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7776;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7791;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7793;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7843;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 7847;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7854;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7869;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 7874;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 7875;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 7898;
UPDATE `creature_template` SET `scale` = 1.38 WHERE `entry` = 7937;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7944;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7950;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7954;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7955;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 7975;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 7978;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8016;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8020;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8142;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8143;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8144;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8145;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8146;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8147;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8152;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8153;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8154;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8158;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8159;
UPDATE `creature_template` SET `scale` = 1.8 WHERE `entry` = 8204;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8208;
UPDATE `creature_template` SET `scale` = 1.6 WHERE `entry` = 8299;
UPDATE `creature_template` SET `scale` = 1.45 WHERE `entry` = 8300;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8307;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8356;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8357;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8358;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8359;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8360;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8361;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8362;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8363;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8364;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8385;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8393;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8398;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8401;
UPDATE `creature_template` SET `scale` = 1.09 WHERE `entry` = 8416;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 8444;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 8503;
UPDATE `creature_template` SET `scale` = 0.66 WHERE `entry` = 8600;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 8662;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8664;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8674;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 8679;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 8681;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8722;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 8737;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 8878;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 8912;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9076;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9081;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9084;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 9087;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 9099;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 9117;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 9166;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 9256;
UPDATE `creature_template` SET `scale` = 2.5 WHERE `entry` = 9376;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9501;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9525;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 9529;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 9542;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9548;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9550;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9551;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 9561;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 9599;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 9616;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9619;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 9636;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 9676;
UPDATE `creature_template` SET `scale` = 0.3 WHERE `entry` = 9700;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 9705;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 9859;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 9936;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 9981;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 9983;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 10050;
UPDATE `creature_template` SET `scale` = 1.48 WHERE `entry` = 10054;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10079;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10086;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 10184;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10278;
UPDATE `creature_template` SET `scale` = 0.45 WHERE `entry` = 10357;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10377;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10378;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 10379;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10380;
UPDATE `creature_template` SET `scale` = 1.21 WHERE `entry` = 10427;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10428;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 10455;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 10456;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10459;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10537;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10539;
UPDATE `creature_template` SET `scale` = 0.75 WHERE `entry` = 10581;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10599;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10600;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10612;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10638;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 10645;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 10646;
UPDATE `creature_template` SET `scale` = 0.7 WHERE `entry` = 10656;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 10667;
UPDATE `creature_template` SET `scale` = 0.4 WHERE `entry` = 10716;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 10721;
UPDATE `creature_template` SET `scale` = 1.62 WHERE `entry` = 10739;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 10758;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 10759;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10760;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10761;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10783;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10784;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10785;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10786;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10787;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10788;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10789;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10790;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10791;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10792;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10793;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10794;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10795;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10796;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10797;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 10798;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 10857;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10881;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10896;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 10902;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 10903;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 10904;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 10905;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 10921;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 10922;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 11026;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 11028;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 11029;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 11035;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 11037;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11047;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11051;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11071;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11084;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11098;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11116;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 11151;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 11152;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 11179;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11180;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11259;
UPDATE `creature_template` SET `scale` = 0.2 WHERE `entry` = 11325;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 11437;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 11494;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 11547;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11548;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11608;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 11628;
UPDATE `creature_template` SET `scale` = 2.5 WHERE `entry` = 11661;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11718;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11720;
UPDATE `creature_template` SET `scale` = 2.3 WHERE `entry` = 11734;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11748;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11749;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 11750;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 11758;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11795;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11796;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11797;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11798;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11805;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 11811;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11822;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11833;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11834;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11856;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11857;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11858;
UPDATE `creature_template` SET `scale` = 1.62 WHERE `entry` = 11860;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11861;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11864;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11869;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 11872;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 11877;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11910;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11911;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11912;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 11913;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11914;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 11944;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 12043;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 12047;
UPDATE `creature_template` SET `scale` = 2.5 WHERE `entry` = 12119;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12145;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12146;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12147;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 12247;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 12251;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 12252;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 12254;
UPDATE `creature_template` SET `scale` = 0.1 WHERE `entry` = 12255;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12260;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12345;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12356;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12357;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12362;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12368;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12370;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12371;
UPDATE `creature_template` SET `scale` = 2.2 WHERE `entry` = 12397;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12434;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 12475;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 12476;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 12576;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 12596;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 12696;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 12723;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12756;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12758;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12777;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 12792;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 12837;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 12958;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 12997;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 13000;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 13018;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 13084;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 13096;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 13143;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13145;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 13146;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13148;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 13153;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 13236;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 13417;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13477;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13516;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13517;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13518;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13519;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13520;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13521;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13522;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13523;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 13546;
UPDATE `creature_template` SET `scale` = 0.72 WHERE `entry` = 13599;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13619;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 13620;
UPDATE `creature_template` SET `scale` = 1.8 WHERE `entry` = 13636;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 14041;
UPDATE `creature_template` SET `scale` = 1.72 WHERE `entry` = 14121;
UPDATE `creature_template` SET `scale` = 0.85 WHERE `entry` = 14122;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14182;
UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 14186;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14228;
UPDATE `creature_template` SET `scale` = 1.4 WHERE `entry` = 14234;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 14268;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14274;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14306;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14307;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14309;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14310;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14311;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14312;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14373;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14422;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14426;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14440;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14441;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14442;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14443;
UPDATE `creature_template` SET `scale` = 1.4 WHERE `entry` = 14454;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 14469;
UPDATE `creature_template` SET `scale` = 1.8 WHERE `entry` = 14472;
UPDATE `creature_template` SET `scale` = 2.85 WHERE `entry` = 14476;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 14477;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 14478;
UPDATE `creature_template` SET `scale` = 1.15 WHERE `entry` = 14481;
UPDATE `creature_template` SET `scale` = 1.4 WHERE `entry` = 14491;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14493;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14501;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14531;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14554;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14562;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14563;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14606;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14623;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14629;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14630;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14631;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14632;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14633;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14635;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14636;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14681;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14682;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14686;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14690;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14693;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14738;
UPDATE `creature_template` SET `scale` = 1.33 WHERE `entry` = 14757;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 14845;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14877;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14879;
UPDATE `creature_template` SET `scale` = 0.2 WHERE `entry` = 14881;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 14887;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 14888;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 14889;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 14890;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 14902;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14941;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14966;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14967;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 14968;
UPDATE `creature_template` SET `scale` = 2.4 WHERE `entry` = 15082;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15109;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15110;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15139;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 15168;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 15175;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 15176;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 15178;
UPDATE `creature_template` SET `scale` = 0.8 WHERE `entry` = 15186;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 15188;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 15191;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 15192;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15216;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15217;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 15246;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 15270;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 15306;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15313;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15314;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15328;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 15334;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15348;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15364;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15370;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15373;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15374;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15375;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15376;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15377;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15387;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15394;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15410;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15411;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15412;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15413;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15425;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15426;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15427;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15436;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15461;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15462;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15471;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 15499;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15507;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15521;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15543;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 15589;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15590;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 15613;
UPDATE `creature_template` SET `scale` = 2.5 WHERE `entry` = 15630;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15660;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15695;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 15702;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15705;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15710;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15711;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 15713;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 15714;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 15715;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 15716;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15717;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15721;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 15726;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15745;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15746;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15769;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15772;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15773;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15774;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15775;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15776;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15777;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15778;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15780;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15781;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15782;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15783;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15784;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15785;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15786;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15787;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15788;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15789;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15790;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15791;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15792;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15793;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15794;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15795;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15796;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15800;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15805;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15809;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15815;
UPDATE `creature_template` SET `scale` = 2.5 WHERE `entry` = 15818;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15832;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15838;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15863;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 15869;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15878;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15893;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15894;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15901;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15902;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15904;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15917;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15922;
UPDATE `creature_template` SET `scale` = 2.3 WHERE `entry` = 15931;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15933;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15957;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15972;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 15973;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 15974;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 15975;
UPDATE `creature_template` SET `scale` = 2.5 WHERE `entry` = 15976;
UPDATE `creature_template` SET `scale` = 2.5 WHERE `entry` = 15989;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16006;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16017;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 16024;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16027;
UPDATE `creature_template` SET `scale` = 2.5 WHERE `entry` = 16029;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16030;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 16036;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 16037;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16064;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16068;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16082;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16086;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16092;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16110;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16123;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16127;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16129;
UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 16134;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16137;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16145;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16146;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16157;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16163;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16164;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 16165;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16166;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16211;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16218;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16281;
UPDATE `creature_template` SET `scale` = 1.5 WHERE `entry` = 16290;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16306;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16336;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16338;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16356;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16368;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16369;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16373;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16374;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 16375;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 16381;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16382;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16386;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 16390;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16398;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16400;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16401;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16419;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16420;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16421;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16422;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16423;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16430;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16437;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16438;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16439;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16440;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 16441;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 16446;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16449;
UPDATE `creature_template` SET `scale` = 2.2 WHERE `entry` = 16451;
UPDATE `creature_template` SET `scale` = 2 WHERE `entry` = 16452;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16508;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16509;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16510;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16512;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16513;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16604;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16606;
UPDATE `creature_template` SET `scale` = 1.2 WHERE `entry` = 16698;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16701;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16775;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16776;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16777;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16778;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16788;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16979;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16980;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16985;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16986;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16987;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16988;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16989;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16990;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 16995;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 17003;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 17038;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 17688;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 17691;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 17697;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 17699;

-- Cleanup
UPDATE `gameobject` SET `state` = 0 WHERE `id` IN (SELECT `entry` FROM `gameobject_template` WHERE `type` = 0 AND `data0` = 1);
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 2048 WHERE `unit_flags` & 2048 = 2048;
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 524288 WHERE `unit_flags` & 524288 = 524288;
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 67108864 WHERE `unit_flags` & 67108864 = 67108864;
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 8388608 WHERE `unit_flags` & 8388608 = 8388608;
UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`minhealth`, `creature`.`curmana` = `creature_template`.`minmana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` = '1';
UPDATE `creature_template` SET `dynamicflags` = `dynamicflags` &~ 223;
UPDATE `creature_template` SET `npcflag` = `npcflag` &~ 16777216; -- UNIT_NPC_FLAG_SPELLCLICK
UPDATE `creature_template` SET `modelid_2` = 0 WHERE `modelid_1` = `modelid_2`;
-- UPDATE `creature_template` `c1`, `creature_template` `c2` SET `c2`.`unit_class` = `c1`.`unit_class`, `c2`.`npcflag` = `c1`.`npcflag`, `c2`.`faction_A` = `c1`.`faction_A`, `c2`.`faction_H` = `c1`.`faction_H`, `c2`.`speed_walk` = `c1`.`speed_walk`, `c2`.`speed_run` = `c1`.`speed_run`, `c2`.`scale` = `c1`.`scale`, `c2`.`InhabitType` = `c1`.`InhabitType`, `c2`.`MovementType` = `c1`.`MovementType`, `c2`.`unit_flags` = `c1`.`unit_flags` WHERE `c2`.`entry` = `c1`.`difficulty_entry_1`;
-- UPDATE `creature_template` `c1`, `creature_template` `c2` SET `c2`.`unit_class` = `c1`.`unit_class`, `c2`.`npcflag` = `c1`.`npcflag`, `c2`.`faction_A` = `c1`.`faction_A`, `c2`.`faction_H` = `c1`.`faction_H`, `c2`.`speed_walk` = `c1`.`speed_walk`, `c2`.`speed_run` = `c1`.`speed_run`, `c2`.`scale` = `c1`.`scale`, `c2`.`InhabitType` = `c1`.`InhabitType`, `c2`.`MovementType` = `c1`.`MovementType`, `c2`.`unit_flags` = `c1`.`unit_flags` WHERE `c2`.`entry` = `c1`.`difficulty_entry_2`;
-- UPDATE `creature_template` `c1`, `creature_template` `c2` SET `c2`.`unit_class` = `c1`.`unit_class`, `c2`.`npcflag` = `c1`.`npcflag`, `c2`.`faction_A` = `c1`.`faction_A`, `c2`.`faction_H` = `c1`.`faction_H`, `c2`.`speed_walk` = `c1`.`speed_walk`, `c2`.`speed_run` = `c1`.`speed_run`, `c2`.`scale` = `c1`.`scale`, `c2`.`InhabitType` = `c1`.`InhabitType`, `c2`.`MovementType` = `c1`.`MovementType`, `c2`.`unit_flags` = `c1`.`unit_flags` WHERE `c2`.`entry` = `c1`.`difficulty_entry_3`;
-- UPDATE `gameobject_template` SET `flags` = `flags` &~ 4 WHERE `type` IN (2, 19, 17);
UPDATE `creature` SET `MovementType` = 0 WHERE `spawndist` = 0 AND `MovementType` = 1;
UPDATE `creature` SET `spawndist` = 0 WHERE `MovementType` = 0;
UPDATE `quest_template` SET `SpecialFlags` = `SpecialFlags` | 1 WHERE `QuestFlags` = `QuestFlags` | 4096;
UPDATE `quest_template` SET `SpecialFlags` = `SpecialFlags` | 1 WHERE `QuestFlags` = `QuestFlags` | 32768;
DELETE FROM `go`,`gt` USING `gameobject` `go` LEFT JOIN `gameobject_template` `gt` ON `go`.`id` = `gt`.`entry` WHERE `gt`.`entry` IS NULL;
DELETE FROM `gi`,`gt` USING `gameobject_involvedrelation` `gi` LEFT JOIN `gameobject_template` `gt` ON `gi`.`id` = `gt`.`entry` WHERE `gt`.`entry` IS NULL;
DELETE FROM `gqr`,`gt` USING `gameobject_questrelation` `gqr` LEFT JOIN `gameobject_template` `gt` ON `gqr`.`id` = `gt`.`entry` WHERE `gt`.`entry` IS NULL;
DELETE FROM `ge`,`go` USING `game_event_gameobject` `ge` LEFT JOIN `gameobject` `go` ON `ge`.`guid` = `go`.`guid` WHERE `go`.`guid` IS NULL;
DELETE FROM `dbscripts_on_go_use` WHERE `id` NOT IN (SELECT `guid` FROM `gameobject`);
DELETE FROM `dbscripts_on_go_use` WHERE `command` IN (11, 12) AND `datalong` != 0 AND `datalong` NOT IN (SELECT `guid` FROM `gameobject`);
DELETE FROM `gameobject_battleground` WHERE `guid` NOT IN (SELECT `guid` FROM `gameobject`);
DELETE FROM `creature_battleground` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x00000100; -- SPLINEFLAG_DONE
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x00000200; -- SPLINEFLAG_FALLING
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x00000800; -- SPLINEFLAG_TRAJECTORY (can crash client)
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x00200000; -- SPLINEFLAG_UNKNOWN3 (can crash client)
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x08000000;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x00000100;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x00000200;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x00000800;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x00200000;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x08000000;
DELETE FROM `npc_gossip` WHERE `npc_guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_movement` WHERE `id` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `game_event_creature` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_questrelation` WHERE `id` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` NOT IN (SELECT `entry` FROM `creature_template`);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 2 WHERE `entry` IN (SELECT `id` FROM `creature_questrelation` UNION SELECT `id` FROM `creature_involvedrelation`);

-- UPDATE Database Version
UPDATE `db_version` SET `version` = 'ZeroDatabase 2.0.4 for MaNGOSZero z2293+ and ScriptDevZero z2639+';
