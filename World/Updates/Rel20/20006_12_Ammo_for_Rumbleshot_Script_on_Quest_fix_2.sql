-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_12';

--                         ******************        FIXES BY ARKADUS        ***************

-- Ammo for Rumbleshot Script on Quest Complete

UPDATE `creature_template`
SET `FactionHorde` = 55, `FactionAlliance` = 55
WHERE `Entry` = 15436 OR `Entry` = 12385;