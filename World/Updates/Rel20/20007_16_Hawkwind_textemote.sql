INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_16';

-- On quest 753 start: DB script

-- change questgiver n:2991 text type to textemote
UPDATE `db_script_string` SET `content_default`='%s gestures to the pitcher of water sitting on the edge of the well.',`type`=2 WHERE `entry`=2000000027;
