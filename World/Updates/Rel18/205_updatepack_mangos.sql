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

-- Remove the mana from Orgrimmar Grunts. Thanks Ghurok
UPDATE `creature` SET `curmana` = 0 WHERE `id` = 3296;
UPDATE `creature_template` SET `minmana` = 0, `maxmana` = 0 WHERE `entry` = 3296;

-- Fix header info from quest (236) this quest is delete in tbc close #43
UPDATE `quest_template` SET `ZoneOrSort` = 10 WHERE `entry` = 236;

-- Add gossip_menu for npc (197)
UPDATE `creature_template` SET `gossip_menu_id` = 4048 WHERE `entry` = 197;

-- Add gossip_menu for npc (17804)
UPDATE `creature_template` SET `gossip_menu_id` = 7480 WHERE `entry` = 17804;

-- Add gossip_menu for npc (17249)
UPDATE `creature_template` SET `gossip_menu_id` = 7394 WHERE `entry` = 17249;

-- Add gossip_menu for npc (10307)
UPDATE `creature_template` SET `gossip_menu_id` = 2703 WHERE `entry` = 10307;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 2703;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('2703','0','0','How do I use the Cache of Mau\'ari?','1','1','-1','0','2703','0','0','','229'),
('2703','1','0','What is E\'ko?','1','1','0','0','0','0','0','','0');

DELETE FROM `gossip_menu` WHERE `entry` = 2703;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('2703','3375','0','0'),
('2703','3377','0','114');

DELETE FROM `conditions` WHERE `condition_entry` IN (114, 229);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('114','8','975','0'),
('229','24','12384','1');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 2703;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('2703','0','15','16351','0','0','0','0','0','0','0','0','0','0','0','0','Create Cache of Mau\'ari');

-- Add gossip_menu for npc (8436)
UPDATE `creature_template` SET `gossip_menu_id` = 1285 WHERE `entry` = 8436;

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (1285, 1287, 1286);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('1285','0','0','I wish to hear your tale.','1','1','1287','0','0','0','0','','222'),
('1286','0','0','Let me think about it, Zamael.','1','1','-1','0','1286','0','0','','0'),
('1287','0','0','Please continue, Zamael.','1','1','1286','0','0','0','0','','0');

DELETE FROM `gossip_menu` WHERE `entry` IN (1285, 1287, 1286);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('1285','1920','0','0'),
('1286','1922','0','0'),
('1287','1921','0','0');

DELETE FROM `conditions` WHERE `condition_entry` = 222;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('222','9','3377','1');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 1286;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1286','0','7','3377','5','0','0','0','0','0','0','0','0','0','0','0','Zamael Lunthistle - Questcredit (3377)');

-- Add gossip_menu for npc (12384)
UPDATE `creature_template` SET `gossip_menu_id` = 4085, `npcflag` = `npcflag` | 131 WHERE `entry` = 12384;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 4085;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('4085','0','1','Yes, Augustus.  I would like to do business.','3','128','0','0','0','0','0','','141');

DELETE FROM `gossip_menu` WHERE `entry` = 4085;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('4085','4979','0','0'),
('4085','4980','0','141');

DELETE FROM `conditions` WHERE `condition_entry` = 141;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('141','8','6164','0');

-- Add gossip_menu for npc (8696)
UPDATE `creature_template` SET `gossip_menu_id` = 1443 WHERE `entry` = 8696;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 1443;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('1443','0','0','You can cook?  So can I!  Is there a recipe you can teach me?','1','1','1501','0','144300','0','0','','539'),
('1443','1','0','You\'re an alchemist?  So am I.  Perhaps you can teach me what you know...','1','1','1442','0','144301','0','0','','597');

DELETE FROM `gossip_menu` WHERE `entry` IN (1443, 1501, 1442);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('1442','2115','0','0'),
('1443','2113','0','0'),
('1501','2173','0','0');

DELETE FROM `conditions` WHERE `condition_entry` IN (539, 597, 227, 226, 419, 418);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('226','17','13028','1'),
('227','7','185','175'),
('418','17','3451','1'),
('419','7','171','180'),
('539','-1','227','226'),
('597','-1','419','418');

DELETE FROM `dbscripts_on_gossip` WHERE `id` IN (144300, 144301);
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('144301','1','15','13030','0','0','0','0','0','0','0','0','0','0','0','0','learn Major Troll\'s Blood Elixir'),
('144301','0','0','0','0','0','0','0','2000000237','0','0','0','0','0','0','0','say 2'),
('144300','1','15','13029','0','0','0','0','0','0','0','0','0','0','0','0','learn Goldthorn Tea'),
('144300','0','0','0','0','0','0','0','2000000237','0','0','0','0','0','0','0','say 1');

DELETE FROM `db_script_string` WHERE `entry` = 2000000237;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000237','Thank again, $n.  Now I\'ll just wait here until it\'s safe to leave.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Add gossip_menu for npc (4968)
UPDATE `creature_template` SET `gossip_menu_id` = 2465 WHERE `entry` = 4968;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 2465;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('2465','0','0','Lady Jaina, this may sound like an odd request... but I have a young ward who is quite shy. You are a hero to him, and he asked me to get your autograph.','1','1','5850','0','2465','0','0','','562');

DELETE FROM `gossip_menu` WHERE `entry` IN (2465, 5850);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('2465','3158','0','0'),
('5850','7012','0','0');

DELETE FROM `conditions` WHERE `condition_entry` IN (562, 323, 322);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('322','16','18642','1'),
('323','9','558','0'),
('562','-1','323','322');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 2465;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('2465','0','15','23122','0','0','0','0','0','0','0','0','0','0','0','0','Create Jaina\'s Autograph');

-- Add gossip_menu for npc (11056)
UPDATE `creature_template` SET `gossip_menu_id` = 3228, `npcflag` = `npcflag` | 131 WHERE `entry` = 11056;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 3228;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('3228','0','0','I need a vitreous focuser.','1','1','-1','0','3223','0','0',NULL,'621'),
('3228','1','1','I wish to purchase arcane quickener from you.','3','128','0','0','0','0','0',NULL,'76'),
('3228','2','1','What does the Felstone Field Cauldron need?','1','1','3224','0','0','0','0',NULL,'76'),
('3228','3','1','What does the Dalson\'s Tears Cauldron need?','1','1','3225','0','0','0','0',NULL,'76'),
('3228','4','1','What does the Writhing Haunt Cauldron need?','1','1','3226','0','0','0','0',NULL,'76'),
('3228','5','1','What does the Gahrron\'s Withering Cauldron need?','1','1','3227','0','0','0','0',NULL,'76');

DELETE FROM `gossip_menu` WHERE `entry` IN (3228, 3224, 3225, 3226, 3227);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('3224','3980','0','0'),
('3225','3981','0','0'),
('3226','3982','0','0'),
('3227','3983','0','0'),
('3228','3984','0','0'),
('3228','3985','0','76');

DELETE FROM `conditions` WHERE `condition_entry` IN (76, 621, 495);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('76','8','5238','0'),
('495','24','13370','1'),
('621','-1','76','495');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 3223;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('3223','0','15','17529','0','0','0','0','0','0','0','0','0','0','0','0','cast Vitreous Focuser');

-- Add gossip_menu for npc (8879)
UPDATE `creature_template` SET `gossip_menu_id` = 1561 WHERE `entry` = 8879;

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (1561, 1565, 1564, 1562, 1563);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('1561','0','0','I am ready, Historian Archesonus.','1','1','1565','0','0','0','0','','122'),
('1562','0','0','Unbelievable! How dare they??','1','1','1563','0','0','0','0','','0'),
('1563','0','0','Of course I will help!','1','1','-1','0','1563','0','0','','0'),
('1564','0','0','Interesting, continue please.','1','1','1562','0','0','0','0','','0'),
('1565','0','0','That is tragic. How did this happen?','1','1','1564','0','0','0','0','','0');

DELETE FROM `gossip_menu` WHERE `entry` IN (1561, 1565, 1564, 1562, 1563);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('1561','2234','0','0'),
('1561','2235','0','122'),
('1562','2238','0','0'),
('1563','2239','0','0'),
('1564','2237','0','0'),
('1565','2236','0','0');

DELETE FROM `conditions` WHERE `condition_entry` = 122;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('122','9','3702','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 1563;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1563','0','7','3702','0','0','0','0','0','0','0','0','0','0','0','0','give questcredit - The Smoldering Ruins of Thaurissan');

-- Add gossip_menu for npc (7775)
UPDATE `creature_template` SET `gossip_menu_id` = 1802, `npcflag` = `npcflag` | 131 WHERE `entry` = 7775;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 1802;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('1802','0','1','Buy somethin\', will ya?','3','128','0','0','0','0','0',NULL,'157');

DELETE FROM `gossip_menu` WHERE `entry` = 1802;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('1802','2433','0','0'),
('1802','2434','0','157');

DELETE FROM `conditions` WHERE `condition_entry` = 157;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('157','9','3909','0');

-- Add gossip_menu for npc (3052)
UPDATE `creature_template` SET `gossip_menu_id` = 24 WHERE `entry` = 3052;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 24;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('24','0','0','Tell me a story, Skorn.','1','1','23','0','0','0','0','','188');

DELETE FROM `gossip_menu` WHERE `entry` IN (23, 24);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('23','523','0','0'),
('24','522','0','0');

DELETE FROM `conditions` WHERE `condition_entry` = 188;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('188','22','770','0');

-- Add gossip_menu for npc (3057)
UPDATE `creature_template` SET `gossip_menu_id` = 5851 WHERE `entry` = 3057;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 5851;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('5851','0','0','I know this is rather silly but a young ward who is a bit shy would like your hoofprint.','1','1','20021','0','5851','0','0',NULL,'623');

DELETE FROM `gossip_menu` WHERE `entry` IN (5851, 20021);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('5851','7013','0','0'),
('20021','7014','0','0');

DELETE FROM `conditions` WHERE `condition_entry` IN (623, 500, 501);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('500','24','18643','1'),
('501','9','925','0'),
('623','-1','501','500');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 5851;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('5851','0','15','23123','0','0','0','0','0','0','0','0','0','0','0','0','get - Cairne\'s Hoofprint');

-- Add gossip_menu for npc (12944)
UPDATE `creature_template` SET `gossip_menu_id` = 4781, `npcflag` = `npcflag` | 131 WHERE `entry` = 12944;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 4781;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('4781','0','1','Show me what I have access to, Lokhtos.','3','128','0','0','0','0','0','','81'),
('4781','1','0','Hmm, I listen. Also that you offer?','1','1','-1','0','4781','0','0',NULL,'683');

DELETE FROM `gossip_menu` WHERE `entry` = 4781;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('4781','3673','0','0'),
('4781','5834','0','81');

DELETE FROM `conditions` WHERE `condition_entry` IN (81, 683, 680, 682, 681, 678, 679);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('81','5','59','4'),
('678','2','17203','1'),
('679','24','18628','1'),
('680','-1','678','679'),
('681','8','7604','0'),
('682','-3','681','0'),
('683','-1','680','682');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 4781;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('4781','0','15','23059','0','0','0','0','0','0','0','0','0','0','0','0','cast Create Thorium Brotherhood Contract');

-- Add gossip_menu for npc (11064)
UPDATE `creature_template` SET `gossip_menu_id` = 3141 WHERE `entry` = 11064;

DELETE FROM `gossip_menu` WHERE `entry` = 3141;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('3141','3873','3141','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 3141;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('3141','0','8','11064','1','0','0','0','0','0','0','0','0','0','0','0',''),
('3141','2','29','1','2','11064','5','0','0','0','0','0','0','0','0','0','');

-- Add gossip_menu for npc (7564)
UPDATE `creature_template` SET `gossip_menu_id` = 922, `npcflag` = `npcflag` | 131 WHERE `entry` = 7564;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 922;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('922','0','1','Yes! I want more of that fabulous Noggenfogger Elixir!','3','128','0','0','0','0','0','','221'),
('922','1','0','Seen any strange things in the desert lately?','1','1','1423','0','0','0','0','','0');

DELETE FROM `gossip_menu` WHERE `entry` IN (922, 1423);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('922','1493','0','0'),
('1423','2055','0','0');

DELETE FROM `conditions` WHERE `condition_entry` = 221;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('221','8','2662','0');

-- Add gossip_menu for npc (9529)
UPDATE `creature_template` SET `gossip_menu_id` = 20022 WHERE `entry` = 9529;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 20022;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('20022','0','0','I need a Cenarion beacon.','1','1','-1','0','2208','0','0',NULL,'628');

DELETE FROM `gossip_menu` WHERE `entry` = 20022;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('20022','2842','0','0'),
('20022','2843','0','5'),
('20022','2849','0','161');

DELETE FROM `conditions` WHERE `condition_entry` IN (628, 161, 228);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('161','8','4102','0'),
('228','24','11511','1'),
('628','-1','161','228');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 2208;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('2208','0','15','15120','0','0','0','0','0','0','0','0','0','0','0','0','cast Cenarion Beacon'),
('2208','0','0','0','0','0','0','0','2000000318','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` = 2000000318;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000318','Here\'s a beacon, $N. Keep it to yourself, if you\'re gonna find mutilated things that we need.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Add gossip_menu for npc (9528)
UPDATE `creature_template` SET `gossip_menu_id` = 2208 WHERE `entry` = 9528;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 2208;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('2208','0','0','I need a Cenarion beacon.','1','1','-1','0','2208','0','0','','540'),
('2208','1','0','What plants are in Felwood that might be corrupted?','1','1','0','0','0','0','0','','0');

DELETE FROM `gossip_menu` WHERE `entry` = 2208;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('2208','2844','0','0'),
('2208','2845','0','4'),
('2208','2848','0','113');

DELETE FROM `conditions` WHERE `condition_entry` IN (540, 113);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('113','8','4101','0'),
('540','-1','113','228');

-- Add gossip_menu for npc (4489)
UPDATE `creature_template` SET `gossip_menu_id` = 4763 WHERE `entry` = 4489;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 4763;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('4763','0','0','My answer - Ysera.','1','1','-1','0','476301','0','0',NULL,'160'),
('4763','1','0','My answer - Neltharion.','1','1','-1','0','476302','0','0',NULL,'160'),
('4763','2','0','My answer - Nozdormu.','1','1','-1','0','476301','0','0',NULL,'160'),
('4763','3','0','My answer - Alexstrasza.','1','1','-1','0','476301','0','0',NULL,'160'),
('4763','4','0','My answer - Malygos.','1','1','-1','0','476301','0','0',NULL,'160');

DELETE FROM `gossip_menu` WHERE `entry` = 4763;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('4763','5819','0','0'),
('4763','5820','0','160');

DELETE FROM `conditions` WHERE `condition_entry` = 160;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('160','9','6627','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` IN (476301, 476302);
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('476302','0','7','6627','5','0','0','0','0','0','0','0','0','0','0','0','Quest complete 6627'),
('476301','0','15','6766','0','0','0','0','0','0','0','0','0','0','0','0','cast Test of Lore');

-- Add gossip_menu for npc (3442) close #10
UPDATE `creature_template` SET `gossip_menu_id` = 21 WHERE `entry` = 3442;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 21;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('21','0','0','Than I can help?','1','1','22','0','0','0','0',NULL,'0'),
('21','1','0','Can you tell me about this shard?','1','1','20024','0','21','0','0',NULL,'513');

DELETE FROM `gossip_menu` WHERE `entry` IN (21, 22, 20024);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
('21','518','0','163'),
('21','519','0','0'),
('22','520','0','0'),
('20024','2013','0','0');

DELETE FROM `conditions` WHERE `condition_entry` IN (513, 163);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('163','8','1094','0'),
('513','9','6981','0');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 21;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('21','0','7','6981','0','0','0','0','0','0','0','0','0','0','0','0','quest complete 6981');

-- Fix quest (6129 and 6124) close #39
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 12297 WHERE `entry` = 6129;
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 12299 WHERE `entry` = 6124;

-- Fix Quest (5902) close #26
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 4362;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('4362','0','0','Place Termite Barrel on the crate.','1','1','0','0','4362','0','0','','716');

DELETE FROM `conditions` WHERE `condition_entry` IN (716, 712, 715, 713, 714);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
('712','2','15044','1'),
('713','9','5902','0'),
('714','9','5904','0'),
('715','-2','713','714'),
('716','-1','712','715');

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 4362;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('4362','0','9','0','60','177491','5','0','0','0','0','0','0','0','0','0','Respawn Termite Barrel');

DELETE FROM `gameobject` WHERE `guid` = 82668;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
('82668','177491','0','2449.43','-1662.39','104.37','2.18166','0','0','0.88701','0.461749','-120','255','1');

-- Quest StartScript for Quest (8305)
UPDATE `quest_template` SET `StartScript` = 8305 WHERE `entry` = 8305;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 8305;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('8305','5','15','25201','0','0','0','0','0','0','0','0','0','0','0','0','');

-- Quest StartScript for Quest (434)
UPDATE `quest_template` SET `StartScript` = 434 WHERE `entry` = 434;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 434;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('434','45','7','434','0','0','0','0','0','0','0','0','0','0','0','0','');

-- Quest StartScript for Quest (753)
UPDATE `quest_template` SET `StartScript` = 753 WHERE `entry` = 753;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 753;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('753','0','0','2','0','0','0','0','2000000027','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` = 2000000027;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000027','Greatmother Hawkwind gestures to the pitcher of water sitting on the edge of the well.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest StartScript for Quest (790)
UPDATE `quest_template` SET `StartScript` = 790 WHERE `entry` = 790;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 790;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('790','1','0','0','0','0','0','0','2000005017','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` = 2000005017;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000005017','Go swiftly $N. My fate is in your hands.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest StartScript for Quest (947)
UPDATE `quest_template` SET `StartScript` = 947 WHERE `entry` = 947;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 947;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('947','1','1','2','0','0','0','0','0','0','0','0','0','0','0','0',''),
('947','1','0','0','2','0','0','0','2000005346','0','0','0','0','0','0','0',''),
('947','5','0','0','2','0','0','0','2000005347','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000005346, 2000005347);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000005346','Thank you, $N. And luck to you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005347','Cliffspring Falls lies along the mountains to the east and north.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest StartScript for Quest (993)
UPDATE `quest_template` SET `StartScript` = 993 WHERE `entry` = 993;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 993;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('993','4','1','1','0','0','0','0','0','0','0','0','0','0','0','0',''),
('993','4','0','0','0','0','0','0','2000005016','0','0','0','0','0','0','0',''),
('993','1','0','2','0','0','0','0','2000005015','0','0','0','0','0','0','0',''),
('993','1','15','10403','0','0','0','4','0','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000005015, 2000005016);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000005015','Terenthis begins to cast a spell as you take the cloak from him.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005016','Go now, $N. Find Volcor... and remember, the magics protecting you will fail if you interact with anyone, save for talking.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest StartScript for Quest (1221)
UPDATE `quest_template` SET `StartScript` = 1221 WHERE `entry` = 1221;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 1221;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1221','0','0','0','0','0','0','0','2000000107','0','0','0','0','0','0','0',''),
('1221','0','1','3','0','0','0','0','0','0','0','0','0','0','0','0',''),
('1221','2','3','0','0','0','0','0','0','0','0','0','-929.023','-3696.98','7.97395','1.7352',''),
('1221','5','1','25','0','0','0','0','0','0','0','0','0','0','0','0',''),
('1221','8','3','0','0','0','0','0','0','0','0','0','-928.778','-3697.25','7.99705','6.17741',''),
('1221','9','3','0','0','0','0','0','0','0','0','0','-928.982','-3697.23','8.06642','3.08923','');

DELETE FROM `db_script_string` WHERE `entry` = 2000000107;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000107','Hey $N! Don\'t forget to grab a crate, a manual and a command stick!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (609)
UPDATE `quest_template` SET `CompleteScript` = 609 WHERE `entry` = 609;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 609;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('609','2','0','2','0','0','0','0','2000000132','0','0','0','0','0','0','0',''),
('609','5','0','0','0','0','0','0','2000000133','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000132, 2000000133);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000132','%s tries opening Maury\'s Clubbed Foot...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000133','Bah! $N, this foot won\'t budge!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (621)
UPDATE `quest_template` SET `CompleteScript` = 621 WHERE `entry` = 621;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 621;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('621','2','0','0','0','0','0','0','2000000130','0','0','0','0','0','0','0',''),
('621','4','0','0','0','0','0','0','2000000131','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000130, 2000000131);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000130','Thank you, $N.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000131','I\'m sure I can find a use for this mixture...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (630)
UPDATE `quest_template` SET `CompleteScript` = 630 WHERE `entry` = 630;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 630;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('630','2','1','3','0','0','0','0','0','0','0','0','0','0','0','0',''),
('630','5','0','0','0','0','0','0','2000000134','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` = 2000000134;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000134','Thank you again for your aid. May the wind always be at your back during your travels.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (640)
UPDATE `quest_template` SET `CompleteScript` = 640 WHERE `entry` = 640;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 640;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('640','0','15','4093','0','0','0','4','0','0','0','0','0','0','0','0',''),
('640','5','0','0','0','0','0','0','2000000118','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` = 2000000118;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000118','Easier then I expected... the sigil of Thoradin is whole, once again.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (670)
UPDATE `quest_template` SET `CompleteScript` = 670 WHERE `entry` = 670;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 670;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('670','1','0','0','0','0','0','0','2000000041','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` = 2000000041;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000041','Wait, $N!!! It looks like we\'re going to need some help here...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (702)
UPDATE `quest_template` SET `CompleteScript` = 702 WHERE `entry` = 702;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 702;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('702','0','15','4153','0','0','0','4','0','0','0','0','0','0','0','0',''),
('702','5','0','2','0','0','0','0','2000000115','0','0','0','0','0','0','0',''),
('702','9','0','0','0','0','0','0','2000000116','0','0','0','0','0','0','0',''),
('702','13','1','15','0','0','0','0','0','0','0','0','0','0','0','0',''),
('702','14','0','0','0','0','0','0','2000000117','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000115, 2000000116, 2000000117);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000115','%s watches as his blood begins to stir, and the guile of the raptor slips through him.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000116','What is this power that flows through me? Is this the power of shamanism that Tor\'gan spoke of...?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000117','Amazing! I feel... renewed. My strength returns!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (748)
UPDATE `quest_template` SET `CompleteScript` = 748 WHERE `entry` = 748;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 748;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('748','0','15','4983','0','0','0','0','0','0','0','0','0','0','0','0',''),
('748','0','0','2','0','0','0','0','2000000170','0','0','0','0','0','0','0',''),
('748','8','0','0','3','0','0','0','2000000171','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000170, 2000000171);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000170','%s begins a rite of creation...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000171','I have created the totem. You, $N, must cleanse the well.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (756)
UPDATE `quest_template` SET `CompleteScript` = 756 WHERE `entry` = 756;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 756;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('756','0','0','2','0','0','0','0','2000000172','0','0','0','0','0','0','0',''),
('756','0','15','4983','0','0','0','0','0','0','0','0','0','0','0','0',''),
('756','8','0','0','3','0','0','0','2000000173','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000172, 2000000173);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000172','%s creates a new totem...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000173','The totem is made, $N.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (759)
UPDATE `quest_template` SET `CompleteScript` = 759 WHERE `entry` = 759;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 759;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('759','0','0','2','0','0','0','0','2000000174','0','0','0','0','0','0','0',''),
('759','0','15','4983','0','0','0','0','0','0','0','0','0','0','0','0',''),
('759','8','0','0','3','0','0','0','2000000175','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000174, 2000000175);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000174','%s transforms the items $N gave him into a totem of cleansing...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000175','The totem is made. The well may now be cleansed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (950)
UPDATE `quest_template` SET `CompleteScript` = 950 WHERE `entry` = 950;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 950;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('950','1','0','2','0','0','0','0','2000000090','0','0','0','0','0','0','0',''),
('950','4','0','2','0','0','0','0','2000000091','0','0','0','0','0','0','0',''),
('950','8','0','0','0','0','0','0','2000000092','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000090, 2000000091, 2000000092);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000090','Onu studies the parchment from the Twilight Tome...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000091','Onu is struck by unleashed magic!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000092','Hmm...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (985)
UPDATE `quest_template` SET `CompleteScript` = 985 WHERE `entry` = 985;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 985;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('985','0','10','3695','56000','0','0','0','0','0','0','0','6408.39','400.412','12.0573','6.09157',''),
('985','2','3','0','700','3695','50','4','0','0','0','0','6428.33','397.389','11.092','5.17761','force buddy to move'),
('985','4','0','0','0','0','0','0','2000005384','0','0','0','0','0','0','0',''),
('985','5','3','0','700','3695','50','4','0','0','0','0','6437.47','365.101','13.9416','5.17761','force buddy to move'),
('985','10','3','0','0','3695','50','4','0','0','0','0','0','0','0','3.95241','force buddy to move'),
('985','16','0','2','0','0','0','0','2000005385','0','0','0','0','0','0','0',''),
('985','20','0','0','0','0','0','0','2000005386','0','0','0','0','0','0','0',''),
('985','20','1','6','0','0','0','0','0','0','0','0','0','0','0','0',''),
('985','24','0','2','0','0','0','0','2000005387','0','0','0','0','0','0','0',''),
('985','29','0','0','0','0','0','0','2000005388','0','0','0','0','0','0','0',''),
('985','29','1','1','0','0','0','0','0','0','0','0','0','0','0','0',''),
('985','35','0','2','0','0','0','0','2000005389','0','0','0','0','0','0','0',''),
('985','35','15','6238','0','0','0','4','0','0','0','0','0','0','0','0',''),
('985','40','0','0','0','0','0','0','2000005390','0','0','0','0','0','0','0',''),
('985','40','1','1','0','0','0','0','0','0','0','0','0','0','0','0',''),
('985','43','0','2','0','0','0','0','2000005391','0','0','0','0','0','0','0',''),
('985','46','0','0','0','0','0','0','2000005392','0','0','0','0','0','0','0',''),
('985','46','1','1','0','0','0','0','0','0','0','0','0','0','0','0',''),
('985','50','0','2','0','0','0','0','2000005393','0','0','0','0','0','0','0',''),
('985','52','3','0','700','3695','50','4','0','0','0','0','6428.33','397.389','11.092','5.17761','force buddy to move'),
('985','55','0','0','0','0','0','0','2000005394','0','0','0','0','0','0','0',''),
('985','55','1','1','0','0','0','0','0','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000005384, 2000005385, 2000005386, 2000005387, 2000005388, 2000005389, 2000005390, 2000005391, 2000005392, 2000005393, 2000005394);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000005384','What was that noise? It sounded like a roar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005385','Grimclaw roars at Terenthis to get his attention.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005386','Grimclaw?! Easy there, my friend... where is your master Volcor?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005387','Grimclaw begins to moan and roar at Terenthis while stomping his paws on the ground.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005388','Whoa, whoa there, my friend. One moment...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005389','Terenthis begins to cast a spell on Grimclaw.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005390','There... that should help. Now, tell me what\'s happened, Grimclaw.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005391','Grimclaw roars at Terenthis more, but this time the druid seems to understand the bear.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005392','I understand, my friend. I shall find someone to help your master. Go back to him now, or at least stay close.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005393','Grimclaw roars in acknowledgement at Terenthis.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005394','If you have the time, Grimclaw and his master Volcor could use your help. If you\'re interested, speak with me further...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1062)
UPDATE `quest_template` SET `CompleteScript` = 1062 WHERE `entry` = 1062;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1062;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1062','4','0','0','0','0','0','0','2000000106','0','0','0','0','0','0','0',''),
('1062','1','0','0','0','0','0','0','2000000105','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000105, 2000000106);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000105','The spirits of Stonetalon still rage, $N.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000106','I fear we may never soothe them...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1063)
UPDATE `quest_template` SET `CompleteScript` = 1063 WHERE `entry` = 1063;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1063;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1063','0','0','2','0','0','0','0','2000000108','0','0','0','0','0','0','0',''),
('1063','2','0','0','0','0','0','0','2000000109','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000108, 2000000109);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000108','%s listens to $N\'s plea.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000109','You were right to come. My wisdom will be yours.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1066)
UPDATE `quest_template` SET `CompleteScript` = 1066 WHERE `entry` = 1066;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1066;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1066','0','0','2','0','0','0','0','2000000110','0','0','0','0','0','0','0',''),
('1066','4','0','0','0','0','0','0','2000000111','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000110, 2000000111);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000110','%s creates his toxin...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000111','There we are, $N. The toxin is ready.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1067)
UPDATE `quest_template` SET `CompleteScript` = 1067 WHERE `entry` = 1067;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1067;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1067','0','0','2','0','0','0','0','2000000112','0','0','0','0','0','0','0',''),
('1067','4','0','0','0','0','0','0','2000000113','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000112, 2000000113);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000112','%s fills a container with the toxin.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000113','The toxin is ready, $N.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1112)
UPDATE `quest_template` SET `CompleteScript` = 1112 WHERE `entry` = 1112;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1112;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1112','1','0','2','0','0','0','0','2000000176','0','0','0','0','0','0','0',''),
('1112','2','9','93887','10','0','0','0','0','0','0','0','0','0','0','0','resp gobject'),
('1112','4','0','2','0','0','0','0','2000000177','0','0','0','0','0','0','0',''),
('1112','8','0','0','0','0','0','0','2000000178','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000176, 2000000177, 2000000178);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000176','%s places the crate of parts on the ground.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000177','%s grabs a part and puts it in his pocket...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000178','There, that should do it...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

DELETE FROM `gameobject` WHERE `guid` = 93887;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
('93887','19878','1','-6232.08','-3855.08','-58.75','4.04244','0','0','0.900263','-0.435347','-10','255','1');

-- Quest CompleteScript for Quest (1116)
UPDATE `quest_template` SET `CompleteScript` = 1116 WHERE `entry` = 1116;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1116;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1116','0','0','2','0','0','0','0','2000000126','0','0','0','0','0','0','0',''),
('1116','1','0','2','0','0','0','0','2000000127','0','0','0','0','0','0','0',''),
('1116','1','15','6903','0','0','0','4','0','0','0','0','0','0','0','0',''),
('1116','4','0','0','0','0','0','0','2000000128','0','0','0','0','0','0','0',''),
('1116','7','0','0','0','0','0','0','2000000128','0','0','0','0','0','0','0',''),
('1116','9','0','0','0','0','0','0','2000000129','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000126, 2000000127, 2000000128, 2000000129);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000126','%s snorts a speck of dream dust up his nose...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000127','%s is dazed...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000128','ACHOO!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000129','Wow! $N, that dream dust is powerful stuff!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1117)
UPDATE `quest_template` SET `CompleteScript` = 1117 WHERE `entry` = 1117;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1117;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1117','1','0','2','0','0','0','0','2000005019','0','0','0','0','0','0','0',''),
('1117','2','1','94','0','0','0','0','0','0','0','0','0','0','0','0',''),
('1117','7','1','0','0','0','0','0','0','0','0','0','0','0','0','0',''),
('1117','8','0','0','0','0','0','0','2000005020','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000005019, 2000005020);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000005019','%s begins to dance.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005020','Hahah! $N, you make quite a partner!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1169)
UPDATE `quest_template` SET `CompleteScript` = 1169 WHERE `entry` = 1169;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1169;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1169','0','0','2','0','0','0','0','2000000124','0','0','0','0','0','0','0',''),
('1169','1','15','6741','0','0','0','4','0','0','0','0','0','0','0','0',''),
('1169','12','0','0','0','0','0','0','2000000125','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000124, 2000000125);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000124','%s begins to cast a spell over the hearts and tongues.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000125','The brood of Onyxia!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1176)
UPDATE `quest_template` SET `CompleteScript` = 1176 WHERE `entry` = 1176;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1176;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1176','2','0','0','0','0','0','0','2000000114','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` = 2000000114;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000114','Okay, crew. Get to work on getting these bones installed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1383)
UPDATE `quest_template` SET `CompleteScript` = 1383 WHERE `entry` = 1383;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1383;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1383','15','3','0','0','0','0','8','0','0','0','0','0','0','0','3.14159',''),
('1383','10','1','0','0','0','0','0','0','0','0','0','0','0','0','0',''),
('1383','10','0','0','0','0','0','0','2000000136','0','0','0','0','0','0','0',''),
('1383','6','1','69','0','0','0','0','0','0','0','0','0','0','0','0',''),
('1383','4','3','0','0','0','0','8','0','0','0','0','0','0','0','6.23291',''),
('1383','1','0','0','0','0','0','0','2000000135','0','0','0','0','0','0','0',''),
('1383','0','29','2','2','5414','10','0','0','0','0','0','0','0','0','0','5414 - npc_flag removed'),
('1383','16','0','0','0','0','0','0','2000000137','0','0','0','0','0','0','0',''),
('1383','16','29','2','1','5414','10','0','0','0','0','0','0','0','0','0','5414 - npc_flag added');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000136, 2000000135, 2000000137);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000135','The serum will only take a few minutes to prepare, $N.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000136','Almost done...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000137','At last, the serum is complete, $N. Now, come closer. We must talk.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1391)
UPDATE `quest_template` SET `CompleteScript` = 1391 WHERE `entry` = 1391;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1391;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1391','20','3','0','0','0','0','0','0','0','0','0','-10424.4','-3239.73','20.1786','3.8633',''),
('1391','19','3','0','0','0','0','0','0','0','0','0','-10422.1','-3237.58','20.1786','3.80072',''),
('1391','17','3','0','0','0','0','0','0','0','0','0','-10420.6','-3240.03','20.1786','2.11212',''),
('1391','16','3','0','0','0','0','0','0','0','0','0','-10423.5','-3240.63','20.1786','4.68979',''),
('1391','15','1','0','0','0','0','0','0','0','0','0','0','0','0','0',''),
('1391','14','0','0','0','0','0','0','2000000123','0','0','0','0','0','0','0',''),
('1391','14','15','7293','0','0','0','4','0','0','0','0','0','0','0','0',''),
('1391','13','0','2','0','0','0','0','2000000122','0','0','0','0','0','0','0',''),
('1391','8','1','64','0','0','0','0','0','0','0','0','0','0','0','0',''),
('1391','7','0','0','0','0','0','0','2000000121','0','0','0','0','0','0','0',''),
('1391','2','0','0','0','0','0','0','2000000120','0','0','0','0','0','0','0',''),
('1391','0','0','2','0','0','0','0','2000000119','0','0','0','0','0','0','0',''),
('1391','22','3','0','0','0','0','0','0','0','0','0','-10422.4','-3238.96','20.1786','0.236333',''),
('1391','26','15','5','0','0','0','4','0','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000123, 2000000122, 2000000121, 2000000120, 2000000119);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000119','%s takes big swig of ale.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000120','That was refreshing. Now there\'s information that needs to be told...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000121','I believe the Forsaken are misleading the allies of the Horde... wait... I feel so... dizzy...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000122','%s writhes in pain.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000123','AAAAAAAAAAAAAAAARGH!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (1445)
UPDATE `quest_template` SET `CompleteScript` = 1445 WHERE `entry` = 1445;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1445;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('1445','0','0','0','0','0','0','0','2000000138','0','0','0','0','0','0','0',''),
('1445','3','15','7437','0','0','0','4','0','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` = 2000000138;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000138','I hereby destroy these instruments of evil! For the Horde!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (3908)
UPDATE `quest_template` SET `CompleteScript` = 3908 WHERE `entry` = 3908;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 3908;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('3908','42','3','0','0','0','0','0','0','0','0','0','6395.57','-2536.75','541.548','5.66753',''),
('3908','34','3','0','0','0','0','0','0','0','0','0','6385.99','-2529.26','539.03','5.66753',''),
('3908','31','3','0','0','0','0','0','0','0','0','0','6370.3','-2524.19','532.27','6.26836',''),
('3908','30','0','0','0','0','0','0','2000005021','0','0','0','0','0','0','0',''),
('3908','27','1','16','0','0','0','0','0','0','0','0','0','0','0','0',''),
('3908','26','0','0','0','0','0','0','2000005022','0','0','0','0','0','0','0',''),
('3908','23','3','0','0','0','0','0','0','0','0','0','6364.25','-2524','527.058','2.9265',''),
('3908','21','0','2','0','0','0','0','2000005023','0','0','0','0','0','0','0',''),
('3908','20','1','61','0','0','0','0','0','0','0','0','0','0','0','0',''),
('3908','15','0','0','0','0','0','0','2000005024','0','0','0','0','0','0','0',''),
('3908','8','3','0','0','0','0','0','0','0','0','0','6370.12','-2525.52','532.268','2.82283',''),
('3908','2','3','0','0','0','0','0','0','0','0','0','6384.54','-2527.25','538.736','2.52438',''),
('3908','1','29','3','2','9298','10','0','0','0','0','0','0','0','0','0','9298 - npc_flag removed'),
('3908','1','0','0','0','0','0','0','2000005025','0','0','0','0','0','0','0',''),
('3908','47','3','0','0','0','0','0','0','0','0','0','0','0','0','2.86475',''),
('3908','48','0','0','0','0','0','0','2000005026','0','0','0','0','0','0','0',''),
('3908','49','29','3','1','9298','10','0','0','0','0','0','0','0','0','0','9298 - npc_flag added');

DELETE FROM `db_script_string` WHERE `entry` IN (2000005021, 2000005022, 2000005023, 2000005024, 2000005025, 2000005026);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000005025','Please, follow me.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005024','I haven\'t really figured out what it is, but there\'s something strange about the hot springs...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005023','%s tosses the sword into the shallow pool.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005022','I\'ve found that when I throw something into this water, it has improved incredibly when I retrieve it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005021','Well, whatever it is, it works quite well!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000005026','And I am determined to find out more... So if you need my help again, you know where I\'ll be.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (4974)
UPDATE `quest_template` SET `CompleteScript` = 4974 WHERE `entry` = 4974;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 4974;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('4974','1','0','6','0','0','0','0','2000000002','0','0','0','0','0','0','0',''),
('4974','1','1','5','0','0','0','0','0','0','0','0','0','0','0','0',''),
('4974','5','15','16609','0','0','0','0','0','0','0','0','0','0','0','0',''),
('4974','6','0','6','0','0','0','0','2000000003','0','0','0','0','0','0','0',''),
('4974','6','1','1','0','0','0','0','0','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` IN (2000000002, 2000000003);
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000002','Honor your heroes! On this day, they have dealt a great blow against one of our most hated enemies! The false Warchief, Rend Blackhand, has fallen! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('2000000003','Be bathed in my power! Drink in my might! Battle for the glory of the Horde!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Quest CompleteScript for Quest (5341)
UPDATE `quest_template` SET `CompleteScript` = 5341 WHERE `entry` = 5341;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 5341;
INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('5341','1','0','1','0','0','0','0','2000000001','0','0','0','0','0','0','0',''),
('5341','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','');

DELETE FROM `db_script_string` WHERE `entry` = 2000000001;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('2000000001','The deeds are mine, brother! Soon you shall be out of my way for good!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Add npc movement for npc (1655) Thanks Ego
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 44990;

DELETE FROM `creature_movement_template` WHERE `entry` = 1655;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
('1655','1','2742.71','785.519','119.133','25000','0','0','0','0','0','0','0','0','0','0.454','0','0'),
('1655','2','2747.48','789.889','119.131','0','0','0','0','0','0','0','0','0','0','0.981','0','0'),
('1655','3','2749.94','797.442','119.108','0','0','0','0','0','0','0','0','0','0','0.871','0','0'),
('1655','4','2753.93','798.877','119.091','0','0','0','0','0','0','0','0','0','0','0.086','0','0'),
('1655','5','2756.69','798.914','119.131','0','0','0','0','0','0','0','0','0','0','5.933','0','0'),
('1655','6','2763.93','796.199','114.367','0','0','0','0','0','0','0','0','0','0','5.395','0','0'),
('1655','7','2764.54','794.093','114.367','0','0','0','0','0','0','0','0','0','0','4.295','0','0'),
('1655','8','2762.54','791.399','114.367','0','0','0','0','0','0','0','0','0','0','3.644','0','0'),
('1655','9','2758.8','790.731','114.367','0','0','0','0','0','0','0','0','0','0','2.941','0','0'),
('1655','10','2752.16','792.589','114.367','0','0','0','0','0','0','0','0','0','0','3.467','0','0'),
('1655','11','2751.12','799.975','114.367','0','0','0','0','0','0','0','0','0','0','1.29676','0','0'),
('1655','12','2752.03','803.195','114.245','15000','0','0','0','0','0','0','0','0','0','1.32032','0','0'),
('1655','13','2748.36','790.155','114.367','0','0','0','0','0','0','0','0','0','0','4.268','0','0'),
('1655','14','2746.26','783.31','114.837','80000','0','0','0','0','0','0','0','0','0','1.247','0','0'),
('1655','15','2748.36','790.155','114.367','0','0','0','0','0','0','0','0','0','0','1.268','0','0'),
('1655','16','2751.12','799.975','114.367','0','0','0','0','0','0','0','0','0','0','1.29676','0','0'),
('1655','17','2752.03','803.195','114.245','15000','0','0','0','0','0','0','0','0','0','1.32032','0','0'),
('1655','18','2752.16','792.589','114.367','0','0','0','0','0','0','0','0','0','0','0.467','0','0'),
('1655','19','2758.8','790.731','114.367','0','0','0','0','0','0','0','0','0','0','5.941','0','0'),
('1655','20','2762.54','791.399','114.367','0','0','0','0','0','0','0','0','0','0','0.644','0','0'),
('1655','21','2764.54','794.093','114.367','0','0','0','0','0','0','0','0','0','0','1.295','0','0'),
('1655','22','2763.93','796.199','114.367','0','0','0','0','0','0','0','0','0','0','2.395','0','0'),
('1655','23','2756.69','798.914','119.131','0','0','0','0','0','0','0','0','0','0','2.933','0','0'),
('1655','24','2753.93','798.877','119.091','0','0','0','0','0','0','0','0','0','0','3.086','0','0'),
('1655','25','2749.94','797.442','119.108','0','0','0','0','0','0','0','0','0','0','3.871','0','0'),
('1655','26','2747.48','789.889','119.131','0','0','0','0','0','0','0','0','0','0','3.981','0','0'),
('1655','27','2742.71','785.519','119.133','0','0','0','0','0','0','0','0','0','0','3.454','0','0');

-- Add npc movement for npc (1533) Thanks Ego
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 49222;

DELETE FROM `creature_movement_template` WHERE `entry` = 1533;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
('1533','1','2882.23','1037.63','111.597','0','0','0','0','0','0','0','0','0','0','5.32251','0','0'),
('1533','2','2891.75','1028.41','107.154','0','0','0','0','0','0','0','0','0','0','5.50315','0','0'),
('1533','3','2897.44','1009.81','108.33','0','0','0','0','0','0','0','0','0','0','4.79315','0','0'),
('1533','4','2898.23','975.086','114.218','0','0','0','0','0','0','0','0','0','0','4.68382','0','0'),
('1533','5','2898.81','957.889','115.079','0','0','0','0','0','0','0','0','0','0','5.0828','0','0'),
('1533','6','2900.9','948.054','115.272','0','0','0','0','0','0','0','0','0','0','5.16605','0','0'),
('1533','7','2908.08','932.171','114.899','0','0','0','0','0','0','0','0','0','0','4.74586','0','0'),
('1533','8','2908.56','927.233','114.845','0','0','0','0','0','0','0','0','0','0','4.37987','0','0'),
('1533','9','2904.41','921.068','114.925','0','0','0','0','0','0','0','0','0','0','3.86936','0','0'),
('1533','10','2897.89','915.506','114.76','0','0','0','0','0','0','0','0','0','0','3.54421','0','0'),
('1533','11','2891.89','912.366','114.579','0','0','0','0','0','0','0','0','0','0','3.88998','0','0'),
('1533','12','2864.54','888.054','112.785','0','0','0','0','0','0','0','0','0','0','3.82715','0','0'),
('1533','13','2846.08','873.334','112.199','0','0','0','0','0','0','0','0','0','0','3.4211','0','0'),
('1533','14','2822.72','864.899','111.841','0','0','0','0','0','0','0','0','0','0','3.7761','0','0'),
('1533','15','2805.19','861.231','111.841','0','0','0','0','0','0','0','0','0','0','2.99463','0','0'),
('1533','16','2792.86','863.311','111.756','0','0','0','0','0','0','0','0','0','0','2.82891','0','0'),
('1533','17','2785.89','866.45','111.558','0','0','0','0','0','0','0','0','0','0','2.45427','0','0'),
('1533','18','2763.86','884.346','111.468','0','0','0','0','0','0','0','0','0','0','2.18174','0','0'),
('1533','19','2752.15','900.057','111.775','0','0','0','0','0','0','0','0','0','0','2.0655','0','0'),
('1533','20','2745.14','912.963','110.819','0','0','0','0','0','0','0','0','0','0','1.79297','0','0'),
('1533','21','2735.78','942.471','109.498','0','0','0','0','0','0','0','0','0','0','1.70579','0','0'),
('1533','22','2733.88','952.497','109.278','0','0','0','0','0','0','0','0','0','0','1.65788','0','0'),
('1533','23','2733.97','964.451','109.262','0','0','0','0','0','0','0','0','0','0','0.938454','0','0'),
('1533','24','2735.98','972.289','109.316','0','0','0','0','0','0','0','0','0','0','0.947093','0','0'),
('1533','25','2748.28','980.282','109.316','0','0','0','0','0','0','0','0','0','0','0.524548','0','0'),
('1533','26','2759.92','988.789','109.336','0','0','0','0','0','0','0','0','0','0','0.960444','0','0'),
('1533','27','2767.27','997.694','109.877','0','0','0','0','0','0','0','0','0','0','1.189','0','0'),
('1533','28','2770.28','1005.85','109.477','0','0','0','0','0','0','0','0','0','0','1.49294','0','0'),
('1533','29','2772.9','1017.25','108.61','0','0','0','0','0','0','0','0','0','0','1.44465','0','0'),
('1533','30','2773.85','1027.46','108.478','0','0','0','0','0','0','0','0','0','0','1.20904','0','0'),
('1533','31','2790.31','1042.25','110.684','0','0','0','0','0','0','0','0','0','0','0.133824','0','0'),
('1533','32','2810.03','1038.34','111.127','0','0','0','0','0','0','0','0','0','0','0.012089','0','0'),
('1533','33','2824.45','1037.32','112.118','0','0','0','0','0','0','0','0','0','0','0.042716','0','0'),
('1533','34','2839.4','1037.63','113.927','0','0','0','0','0','0','0','0','0','0','0.019154','0','0'),
('1533','35','2853.29','1041.9','115.65','0','0','0','0','0','0','0','0','0','0','0.321532','0','0'),
('1533','36','2861.56','1043.2','115.985','0','0','0','0','0','0','0','0','0','0','0.681244','0','0'),
('1533','37','2882.23','1037.63','111.597','180000','153301','0','0','0','0','0','0','0','0','5.32251','0','0');

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 153301;
INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('153301','0','20','1','0','1533','5','0','0','0','0','0','0','0','0','0','movement chenged to 1:random'),
('153301','175','20','2','0','1533','5','0','0','0','0','0','0','0','0','0','movement chenged to 2:waypoint');

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
UPDATE `db_version` SET `version` = 'ZeroDatabase 2.0.5 for MaNGOSZero z2293+ and ScriptDevZero z2639+';
