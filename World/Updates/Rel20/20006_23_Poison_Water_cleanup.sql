-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_23';

-- remove foreign replicas after completion of q:748
DELETE FROM `dbscripts_on_quest_end` WHERE `id`=748 AND `dataint` IN (2000000170,2000000171);
