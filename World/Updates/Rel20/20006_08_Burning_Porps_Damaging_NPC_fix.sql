-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_08';

--                         ******************        FIXES BY ARKADUS        ***************

-- Burning props damaging NPC's FIX

UPDATE `gameobject_template`
SET
`faction` = 0
WHERE `entry` = 179900 OR `data2` = 2061 OR `data2` = 2066 OR `name` = "Fire" OR `name` = "Campfire" OR `name` = "Bonfire Damage" OR `entry` = 176510 OR `entry` = 178559 OR `entry` = 179065 OR `entry` = 181029 OR `entry` = 181376;