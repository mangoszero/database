-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_24';

-- [812] update requirements of q:1004 to meet other quests (ExclusiveGroup and the next one)
UPDATE `quest_template` SET `MinLevel`=55 WHERE `entry`=1004;
