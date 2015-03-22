-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_02';

UPDATE creature_template SET RegenerateStats=1 WHERE UnitClass IN (1, 4) AND RegenerateStats != 0;
UPDATE creature_template SET RegenerateStats=RegenerateStats|2 WHERE UnitClass IN (2, 8);

UPDATE creature_template SET MinLevelMana = 0, MaxLevelMana = 0, PowerMultiplier = 0 where UnitClass = 1 or UnitClass = 4 and MinLevelMana > 0;
