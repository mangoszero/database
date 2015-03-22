-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_10';

--                         ******************        FIXES BY ARKADUS        ***************

-- Scarab_Chests_in_AQ40_AQ20_fix

UPDATE `gameobject` SET `spawntimesecs` = 604800 WHERE `id` = 180690;

REPLACE INTO `gameobject_loot_template`
(`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`)
VALUES
(180690, 21156, 100, 0, 1, 1, 0),
(180690, 20874, 20, 0, 1, 1, 0),
(180690, 20876, 20, 0, 1, 1, 0),
(180690, 20877, 20, 0, 1, 1, 0),
(180690, 20878, 20, 0, 1, 1, 0),
(180690, 20881, 20, 0, 1, 1, 0);

REPLACE INTO `gameobject_loot_template`
(`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`)
VALUES
(180691, 21156, 100, 0, 1, 1, 0),
(180691, 20873, 12.5, 0, 1, 1, 0),
(180691, 20869, 12.5, 0, 1, 1, 0),
(180691, 20866, 12.5, 0, 1, 1, 0),
(180691, 20870, 12.5, 0, 1, 1, 0),
(180691, 20868, 12.5, 0, 1, 1, 0),
(180691, 20871, 12.5, 0, 1, 1, 0),
(180691, 20867, 12.5, 0, 1, 1, 0),
(180691, 20872, 12.5, 0, 1, 1, 0);

DELETE FROM `gameobject_loot_template` WHERE `entry` = 17533 OR `entry` = 17532;

UPDATE `gameobject_template` SET `data1` = 180690 WHERE `entry` = 180690;
UPDATE `gameobject_template` SET `data1` = 180691 WHERE `entry` = 180691;