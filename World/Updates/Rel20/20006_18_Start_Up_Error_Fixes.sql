-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_18';

-- Fixes for the start up errors (world-eventai.log and Live World Mode)


-- world-eventai.log error fixes
-- =============================

-- missing/deleted
DELETE FROM creature_ai_texts WHERE entry IN (-1133, -1134, -1136);

INSERT INTO creature_ai_texts (entry, content_default, sound, TYPE, LANGUAGE, emote, COMMENT) VALUES (-1136, 'Anu\dora!', 0, 0, 0, 0, 7999);

INSERT INTO creature_ai_texts (entry, content_default, sound, TYPE, LANGUAGE, emote, COMMENT) VALUES (-1133, 'For Kalimdor!', 0, 0, 0, 0, 7999);

INSERT INTO creature_ai_texts (entry, content_default, sound, TYPE, LANGUAGE, emote, COMMENT) VALUES (-1134, 'Endu\di Rifa!', 0, 0, 0, 0, 7999);

UPDATE creature_ai_scripts SET action1_param2 = -1133, action1_param3 = -1134 WHERE id = 799905;

-- EventAI not required - Guardian of Blizzard - (implemented by ScriptDev)
UPDATE creature_template SET AIName = '' WHERE Entry = 5764;

-- water elemental
DELETE FROM creature_ai_texts WHERE entry = -148;
INSERT INTO creature_ai_texts (entry, content_default, sound, TYPE, LANGUAGE, emote, COMMENT) VALUES (-148, '[Kalimag] Ma reth bromo zoln kilagrin dra ma zoern tu ko fraht ko kadrom Ma krin drinor zoln drinor Ma krin kan aasrugel korsul', 0, 0, 0, 0, 8666);

-- dwarf dude
-- http://www.wowhead.com/npc=10817/dug...ammer#comments
UPDATE creature_ai_texts SET COMMENT = 10817 WHERE entry= -1160;
DELETE FROM creature_ai_scripts WHERE id = 1081710;
INSERT INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, COMMENT) VALUES (1081710, 10817, 4, 0, 100, 0, 0, 0, 0, 0, 1, -1160, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Say on Aggro');

DELETE FROM creature_ai_scripts WHERE id = 1081711;
INSERT INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, COMMENT) VALUES ('1081711', '10817', '1', '0', '100', '1', '120000', '120000', '120000', '120000', '1', '-1161', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Duggan Wildhammer - Random Say OOC');

DELETE FROM creature_ai_texts WHERE entry = -1161 AND COMMENT = 10817;
INSERT INTO creature_ai_texts (entry, content_default, sound, TYPE, LANGUAGE, emote, COMMENT) VALUES ('-1161', 'Ooooooooh... $B To the plaguelands went old Duggan, ta\' send them Scourge back inta\' th\' groun\'. $B Where th\' scent of death is on th\' wind and everythin\' is mostly brown. $B An\' when he did arrive there, what\'d his dwarf eyes see? $B A hundred crates of barley there ta\' be makin\' inta\' mead! $B But tha\' mead was cursed with th\' plague o\' death, and now old Duggan, too. $B An\' surrounded by the Lich King\'s beasts, what could old Duggan do? $B But though I feel the plague within, my hopes \'ave not yet sunk. $B If\'n I\'m gonna be Scourge anyway, I might as well be drunk!', '0', '0', '0', '0', '10817');

-- Tortured Druid
-- http://www.wowwiki.com/Tortured_Druid
DELETE FROM creature_ai_scripts WHERE id = 1217804;
INSERT INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, COMMENT) VALUES ('1217804', '12178', '6', '0', '75', '2', '0', '0', '0', '0', '1', '-1147', '0', '0', '12', '13136', '1', '300000', '0', '0', '0', '0', 'Tortured Druid - Shout and summon drone');

-- 2nd lot of errors (Live World mode)

-- Misha - movement type 14 - follow - MoveMaster.h, line 56
UPDATE creature SET MovementType= 14 WHERE guid = 590005;

UPDATE creature SET MovementType = 14 WHERE guid = 14516; -- should be set as follower (14)

UPDATE creature SET MovementType = 14 WHERE guid = 14515; -- should be set as follower (14)

UPDATE creature SET MovementType = 14 WHERE guid = 14517; -- should be set as follower (14)

UPDATE creature SET spawndist = 0, MovementType = 0 WHERE guid = 11453;

UPDATE creature SET MovementType = 0 WHERE guid = 79750;

-- Donna chasing William (SW)
-- Moved slightly closer to William and set as movement type of follower (14)
UPDATE creature SET position_x = -8741.086, position_y = 551.811, position_z = 99.461, MovementType = 14 WHERE guid = 79721;