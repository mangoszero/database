-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_02';

-- Cuergo's Gold fix to spawn pirates and chest

-- Set the chance for the key to drop to 100%
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE entry=7899 and item=9275;
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE entry=7901 and item=9275;
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE entry=7902 and item=9275;

-- add script to the Inconspicuous Landmark game object
UPDATE gameobject_template SET ScriptName='go_inconspicuous_landmark' WHERE entry=142189;

-- add script to the Pirate's Treasure game object
UPDATE gameobject_template SET ScriptName='go_pirate_treasure' WHERE entry=142194;