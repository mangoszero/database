-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 09';

-- This makes the egg gameobject in the Cluck quest the correct size (it was 2/3 the size of a human)
UPDATE gameobject_template SET size=0.2 WHERE entry=161513;
