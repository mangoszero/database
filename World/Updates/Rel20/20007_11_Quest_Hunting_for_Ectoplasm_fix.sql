INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_11';

-- IMPORTANT! THIS REQUIRES THE CURRENT VERSION OF THE SERVER CORE !!!!!!!!!!!!!
-- ===============================================================
-- This makes use of the condition: CONDITION_GAMEOBJECT_IN_RANGE 38 (see GameObject.h and GameObject.cpp)

-- Quest: Hunting for Ectoplasm 

-- conditions table
-- Create new record for Ectoplasmic Distiller using the new condition (CONDITION_GAMEOBJECT_IN_RANGE)
DELETE FROM conditions WHERE condition_entry = 1733 AND type = 38;
INSERT INTO conditions (condition_entry, type, value1, value2) VALUES (1733, 38, 181054, 13);

-- creature_loot_template
-- Tortured Sentinel (http://www.wowhead.com/?npc=12179)
UPDATE creature_loot_template SET condition_id=1733 WHERE entry=12179 and item=21937;

-- Tortured Druid (http://www.wowhead.com/?npc=12178)
UPDATE creature_loot_template SET condition_id=1733 WHERE entry=12178 and item=21937;

-- Suffering Highborne (http://www.wowhead.com/?npc=7523)
UPDATE creature_loot_template SET condition_id=1733 WHERE entry=7523 and item=21936;

-- Anguished Highborne (http://www.wowhead.com/?npc=7524
UPDATE creature_loot_template SET condition_id=1733 WHERE entry=7524 and item=21936;

-- Eyeless Watcher (http://www.wowhead.com/?npc=8539)
UPDATE creature_loot_template SET condition_id=1733 WHERE entry=8539 and item=23198;

-- Death Singer (http://www.wowhead.com/?npc=8542)
UPDATE creature_loot_template SET condition_id=1733 WHERE entry=8542 and item=21935;

-- Hate Shrieker (http://www.wowhead.com/?npc=8541)
UPDATE creature_loot_template SET condition_id=1733 WHERE entry=8541 and item=21935;

-- Unseen Servant (http://www.wowhead.com/?npc=8538)
UPDATE creature_loot_template SET condition_id=1733 WHERE entry=8538 and item=21935;

-- Torn Screamer (http://www.wowhead.com/?npc=8540)
UPDATE creature_loot_template SET condition_id=1733 WHERE entry=8540 and item=21935;
