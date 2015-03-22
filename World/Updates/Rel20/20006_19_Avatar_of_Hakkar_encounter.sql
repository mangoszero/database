-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_19';

-- The Sunken Temple encounter to q:3528, Shade of Hakkar fixing:
-- only one script may be defined for creature, the present case is for SD2
-- also prevent killing the mob during encounter
UPDATE `creature_template` SET `AIName`='',`UnitFlags`=256 WHERE `entry`=8440;

-- clear unused EAI records
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=8440;
