-- Quest #5621, 5624, 5625, 5648, 5650, Garments of the Light

-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 04';

-- General adjustments to all NPCs
UPDATE `creature_template` SET  `unitflags` = unitflags|512, `extraflags` = extraflags|2048, `RegenerateHealth` = 0 WHERE `entry` IN (12423,12427,12428,12429,12430);

-- Adjustments to Mountaineer Dolf (#12427)
UPDATE `creature_template` SET  `factionAlliance` = 57, `factionHorde` = 57 WHERE `entry` = 12427;

-- Adjustments to Grunt Kor'ja (#12430)
UPDATE `creature_template` SET  `factionAlliance` = 85, `factionHorde` = 85 WHERE `entry` = 12430;

-- Adjustments to Guard Roberts (#12423)
UPDATE `creature_template` SET  `factionAlliance` = 11, `factionHorde` = 11 WHERE `entry` = 12423;

-- Move nearby wolfs ~8 yards to the west in order to keep Guard Roberts save
UPDATE `creature` SET `position_x` = '-9511.353516', `position_y` = '-106.877281', `position_z` = '61.101341' WHERE guid = '81087';
UPDATE `creature` SET `position_x` = '-9514.691406', `position_y` = '-105.825020', `position_z` = '61.491528' WHERE guid = '79636';
UPDATE `creature` SET `position_x` = '-9516.968750', `position_y` = '-105.327599', `position_z` = '61.761623' WHERE guid = '81088';