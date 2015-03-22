-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_06';

-- Tyr's Hand

-- Tortured undead at odd angle (were obstructed)
UPDATE creature SET position_x=1594.56, position_y=-5313.1, position_z=69.84, orientation=3.1 WHERE guid = 53036;
UPDATE creature SET position_x=1598.14, position_y=-5314.94, position_z=70.0242, orientation=3.13426 WHERE guid = 84825;
UPDATE creature SET position_x=1603.62, position_y=-5306.68, position_z=70.045, orientation=4.9 WHERE guid = 86149;

-- Light's Hope Chapel

DELETE FROM gossip_menu WHERE entry IN (96, 97, 98, 99, 100, 101); 

-- no chit chat
-- Korfax, Champion of the Light
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (96, 8415, 0, 0);
UPDATE gossip_menu_option SET action_menu_id=96 WHERE menu_id=7099 and id=1;
-- Rohan The Assassin
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (97, 8409, 0, 0);
UPDATE gossip_menu_option SET action_menu_id= 97 WHERE menu_id=7101 and id=1;
-- Huntsman Leopold
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (98, 8408, 0, 0);
UPDATE gossip_menu_option SET action_menu_id= 98 WHERE menu_id=7102 and id=1;
-- Archmage Angela Dosantos
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (99, 8414, 0, 0);
UPDATE gossip_menu_option SET action_menu_id= 99 WHERE menu_id=7096 and id=1;
-- Miranda
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (100, 8499, 0, 0);
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (100, 8500, 0, 0);
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (100, 8502, 0, 0);
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (100, 8503, 0, 0);
UPDATE gossip_menu_option SET action_menu_id=269 WHERE menu_id=3461 and id=2;
-- Rayne
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (101, 8416, 0, 0);
UPDATE gossip_menu_option SET action_menu_id= 101 WHERE menu_id=7104 and id=1; 

-- Jackanory Time
-- ==============

-- Archmage Angela Dosantos (story teller)
-- http://wow.gamepedia.com/Angela_Dosantos 

DELETE FROM gossip_menu WHERE entry IN (86, 87, 88, 89, 90, 91, 92, 93, 94, 95);
DELETE FROM gossip_menu_option WHERE menu_id IN (86, 87, 88, 89, 90, 91, 92, 93, 94);

-- It is said that Kel'Thuzad seeks the legendary Atiesh, greatstaff of the Guardian.
-- Yes, the very staff once held by Medivh.
-- What is Atiesh?

UPDATE gossip_menu_option SET action_menu_id=86 WHERE menu_id=7096 and id=0;

-- Like Kel'Thuzad, I too was once a mage of the Kirin Tor. And like Kel'Thuzad, I seek the legendary Atiesh, greatstaff of the Guardian. Our fates are intertwined as such, <class>.
-- What Guardian? I don't understand any of this.
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (86, 8388, 0, 0);

INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES (86, 0, 0, 'What Guardian? I don\t understand any of this.', 1, 1, 87, 0, 0, 0, 0, '', 0);

-- Progeny of Aegwynn, he that would be the last Guardian of Tirisfal... Medivh..
-- Please continue.
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (87, 8389, 0, 0);
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES (87, 0, 0, 'Please continue.', 1, 1, 88, 0, 0, 0, 0, '', 0);

-- It is a story of legend and one that I do not have the time nor the inclination to retell. Just know that Medivh was the last of the Guardians. The greatstaff of Atiesh was a focal point of his power and a focal point of corruption.
-- What corruption?
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (88, 8390, 0, 0);
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES (88, 0, 0, 'What corruption?', 1, 1, 89, 0, 0, 0, 0, '', 0);

-- The corruption of a fallen titan. The corruption of the Destroyer. After all, the staff was forged from the seed of hate. That is, of course, what has brought me here...
-- Please continue.
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (89, 8391, 0, 0);
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES (89, 0, 0, 'Please continue.', 1, 1, 90, 0, 0, 0, 0, '', 0);

-- After the fall of Karazhan, the Kirin Tor dispatched an assembly of mages to search the tower and seize all items of import... for the purposes of "research." It was then that the fabled staff was discovered and brought back to Dalaran.
-- Please continue.
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (90, 8392, 0, 0);
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES (90, 0, 0, 'Please continue.', 1, 1, 91, 0, 0, 0, 0, '', 0);

-- What followed were a series of tragic events, leading to the death of every Kirin Tor mage that came into contact with Atiesh.
-- You see, it was an artifact with sentience. A sentience granted to it by Sargeras...
-- What?
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (91, 8393, 0, 0);
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES (91, 0, 0, 'What?', 1, 1, 92, 0, 0, 0, 0, '', 0);

-- <Angela nods.>
-- After the deaths, the Six decided that the best course of action was to seal the staff behind impenetrable barriers of magic and appoint a watcher: A guardian of the staff... I would be that watcher.
-- This is disturbing. Please continue.
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (92, 8394, 0, 0);
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES (92, 0, 0, 'This is disturbing. Please continue.', 1, 1, 93, 0, 0, 0, 0, '', 0);

-- There is not much more to tell. Dalaran was nearly wholly destroyed by Archimonde, the staff lost, presumably shattered by the barrier's fail-safe mechanisms.
-- There are those that believe the staff to be the cause of Archimonde's reprisal.
-- Please, tell me more.
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (93, 8395, 0, 0);
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES (93, 0, 0, 'Please, tell me more.', 1, 1, 94, 0, 0, 0, 0, '', 0);

-- After the fall of Dalaran, I took my leave from the Kirin Tor. I spent years watching over Atiesh, only to have my purpose amongst the Kirin Tor taken away from me in one fell swoop. I would find the staff, though it might take a lifetime. That is how I came to join the Argent Dawn and why I am here now.
-- Is there anything else?
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (94, 8396, 0, 0);
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES (94, 0, 0, 'Is there anything else?', 1, 1, 95, 0, 0, 0, 0, '', 0);

-- I have tracked the various fragments of the staff across this world and in doing so, discovered Kel'Thuzad's plans to reform the staff. He has already collected several of the staff's fragments - which are being held by his most trusted lieutenants.
-- I cannot emphasize enough the importance of keeping the greatstaff of the Guardian out of Kel'Thuzad's grasp. Frankly, I do not know what the result would be, other than a catastrophe of epic proportion.
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES (95, 8397, 0, 0);

-- FIN 