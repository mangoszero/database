-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 12';

-- Delete Corrupted Whipper Root entries
DELETE FROM gameobject_loot_template where item = 11951;

-- REMOVE UNWANTED CLEANSED WHIPPER ROOT RECORDS (there are 2 of each, but only one of each is needed/correct - see table https://www.getmangos.eu/issue.php?issueid=653 )
DELETE FROM gameobject WHERE `guid`='17660';
DELETE FROM gameobject WHERE `guid`='17662';
DELETE FROM gameobject WHERE `guid`='17664';
DELETE FROM gameobject WHERE `guid`='18176';
DELETE FROM gameobject WHERE `guid`='18178';
DELETE FROM gameobject WHERE `guid`='18180';

-- New gameobject_loot_template records for Cleansed Whipper Root
-- Cleansed Whipper Root (gameobject_template: 164883, 174622, 174623, 174624, 174625, 174687)
INSERT INTO gameobject_loot_template (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('164883', '11951', '10', '0', '1', '3', '0'),('174622', '11951', '10', '0', '1', '3', '0'),('174623', '11951', '10', '0', '1', '3', '0'),('174624', '11951', '10', '0', '1', '3', '0'),('174625', '11951', '10', '0', '1', '3', '0'),('174687', '11951', '10', '0', '1', '3', '0');

-- Replace Cleansed Whipper Root gameobject_template records
-- The plants will now be lootable
DELETE FROM gameobject_template where name = "Cleansed Whipper Root";
INSERT INTO gameobject_template (`entry`, `type`, `displayId`, `name`, `faction`, `flags`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `mingold`, `maxgold`, `ScriptName`) VALUES ('164883', '3', '3255', 'Cleansed Whipper Root', '0', '0', '2', '43', '164883', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ''),('174622', '3', '3255', 'Cleansed Whipper Root', '0', '0', '2', '43', '174622', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ''),('174623', '3', '3255', 'Cleansed Whipper Root', '0', '0', '2', '43', '174623', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ''),('174624', '3', '3255', 'Cleansed Whipper Root', '0', '0', '2', '43', '174624', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ''),('174625', '3', '3255', 'Cleansed Whipper Root', '0', '0', '2', '43', '174625', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ''),('174687', '3', '3255', 'Cleansed Whipper Root', '0', '0', '2', '43', '174687', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '');

-- INCORRECT GUID WAS USED FOR SPAWNING CLEANSED WHIPPER ROOT
UPDATE dbscripts_on_quest_end SET datalong = 48882 WHERE id = 4443;


