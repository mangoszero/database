-- revision
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_12';

-- [815] Life Tap is not scaled with spell damage/healing (final DB Fix, one core bug left)
-- the only problem left is that the "reducing HP loss" aura 28830 is applied BEFORE calculating mana gain, so less mana is gained

DELETE FROM `spell_bonus_data` WHERE `entry`=1454;
INSERT INTO `spell_bonus_data` (`entry`,`comments`) VALUES (1454,'Life Tap - no scaling with SP');
