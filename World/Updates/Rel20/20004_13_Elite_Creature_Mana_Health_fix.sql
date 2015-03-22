-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 13';

-- Author: Talendrys
-- Tester and sub-author (corrected the mana script): tonaus 

-- Correct the amount of health for the elite/boss creatures
UPDATE creature_template, creature_template_classlevelstats SET HealthMultiplier = MinLevelHealth/BaseHealthExp0
WHERE creature_template_classlevelstats.Level = MinLevel;

-- Correct the amount of mana for the elite/boss creatures
UPDATE creature_template, creature_template_classlevelstats SET ManaMultiplier = MinLevelMana/BaseMana
WHERE creature_template_classlevelstats.Level = MinLevel and BaseMana != 0;
