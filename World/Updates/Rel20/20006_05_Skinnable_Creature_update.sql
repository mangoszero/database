-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_05';

--                         ******************        FIXES BY ARKADUS        ***************

-- Creature Skinnable Update - creatures that shouldnt be skinnable or lootable

UPDATE `creature_template`
SET `SkinningLootId` = 0
WHERE `Entry` = 1933 OR `Entry` = 15316 OR `Entry` = 7381 OR `Entry` = 7382 OR `Entry` = 7384 OR `Entry` = 7385 OR `Entry` = 7389 OR `Entry` = 7390 OR `Entry` = 2230 OR `Entry` = 7395 OR `Entry` = 7553 OR `Entry` = 7555 OR `Entry` = 7562 OR `Entry` = 7565 OR `Entry` = 7567 OR `Entry` = 8662 OR `Entry` = 12372 OR `Entry` = 12373 OR `Entry` = 12374 OR `Entry` = 14602 OR `Entry` = 14869 OR `Entry` = 15412 OR `Entry` = 1512 OR `Entry` = 1984 OR `Entry` = 2032 OR `Entry` = 2955 OR `Entry` = 3098 OR `Entry` = 708 OR `Entry` = 1985 OR `Entry` = 2961 OR `Entry` = 3124 OR `Entry` = 1513 OR `Entry` = 2966 OR `Entry` = 3281 OR `Entry` = 2098 OR `Entry` = 2954;

DELETE FROM `skinning_loot_template`
WHERE `entry` = 1933 OR `entry` = 2098;
