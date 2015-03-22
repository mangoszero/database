-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_27';

-- Mana regeneration enabled for mana users
UPDATE creature_template SET RegenerateHealth=2 WHERE RegenerateHealth<>2 AND MinLevelMana>0 AND UnitClass IN (2,8);

-- change tested in-game
ALTER TABLE creature_template CHANGE RegenerateHealth RegenerateStats tinyint(3) unsigned;
