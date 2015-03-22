
-- Add the Revision update into the revision column
INSERT INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 02';

-- Remove Invalid class for this core
DELETE FROM creature_template_classlevelstats WHERE class=4;

-- Update Two invalid AIName entries
UPDATE creature_template SET AIName = 'EventAI' WHERE Entry = 3902;
UPDATE creature_template SET AIName = 'EventAI' WHERE Entry = 16385;
