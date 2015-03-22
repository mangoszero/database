-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_03';

-- Creatures that should have RegerateStats set to 3 (regen health and mana
UPDATE creature_template SET RegenerateStats=3 WHERE entry IN (660, 4803, 4980, 4996, 6221, 7843, 12265, 14832, 14865, 14868, 14871, 16109);

-- Creatures that should have RegerateStats set to 0 (no regen)
UPDATE creature_template SET RegenerateStats=0 WHERE entry IN (12423, 12427, 12428, 12429, 12430, 13020, 13148, 14484, 14485);
