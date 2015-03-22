-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_15';

-- Guardian of Blizzard non-combat fix (requires ScriptDev script fix)
-- -- script fix: https://github.com/mangoszero/server/pull/285
UPDATE creature_template SET FactionAlliance = 73, FactionHorde = 73, AIName = 'EventAI' WHERE Entry = 5764;