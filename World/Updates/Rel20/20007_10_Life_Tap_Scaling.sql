-- [815] Life Tap is not scaled with spell damage/healing (PARTIAL FIX)
-- however the numbers are strange, probably due to spell levels
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_10';

DELETE FROM `spell_bonus_data` WHERE `entry`=1454;
INSERT INTO `spell_bonus_data` (`entry`,`ap_bonus`,`comments`) VALUES (1454,1,'Life Tap - no scaling with SP');
