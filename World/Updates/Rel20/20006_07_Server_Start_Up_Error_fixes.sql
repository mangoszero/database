-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_07';

--                         ******************        FIXES BY ARKADUS        ***************

-- Server Start Up Error fixes

UPDATE `creature_ai_scripts`
SET `action1_param2` = 1, `action1_param3` = 0, `event_flags` = 1, `event_param3` = 15000, `event_param4` = 30000
WHERE (`id` = 43101 OR `id` = 446601 OR `id` = 463702 OR `id` = 536401 OR `id` = 562301 OR `id` = 598201 OR `id` = 1474801 OR `id` = 178703 OR `id` = 255603 OR `id` = 260602 OR `id` = 264906 OR `id` = 402402 OR `id` = 648803 OR `id` = 702702 OR `id` = 727404 OR `id` = 779703) AND `action1_param1` = 7160;

UPDATE `creature_ai_scripts`
SET `action1_param1` = 8242
WHERE `id` = 184605 AND `action1_param1` = 15655;

UPDATE `creature_ai_scripts`
SET `action1_param2` = 0
WHERE `event_type` = 10 AND `action1_type` = 12 AND `action1_param1` = 15138;

UPDATE `creature_ai_scripts`
SET `action1_param1` = 20537, `action1_param2` = 1, `action1_param3` = 0, `event_flags` = 1, `event_param1` = 15000, `event_param2` = 30000
WHERE (`action1_param1` = 15122 OR `action1_param1` = 20537) AND `event_type` = 13 AND `action1_type` = 11;

UPDATE `creature_ai_scripts`
SET `action1_param2` = 1, `action1_param2` = 0, `event_flags` = 1
WHERE (`action1_param1` = 12555 OR `action1_param1` = 15615 OR `action1_param1` = 15621 OR `action1_param1` = 11978 OR `action1_param1` = 15614 OR `action1_param1` = 25788) AND `event_type` = 13 AND `action1_type` = 11;

UPDATE `creature_ai_scripts`
SET `action1_param2` = 1, `action1_param2` = 0, `action1_param3` = 0, `event_flags` = 1, `event_param1` = 4000, `event_param2` = 8000
WHERE (`id` = 184504 OR `id` = 184605) AND `action1_param1` = 8242;

UPDATE `creature_ai_scripts`
SET `action1_param2` = 1, `action1_param2` = 0, `action1_param3` = 0, `event_flags` = 1, `event_param1` = 15000, `event_param2` = 30000
WHERE (`id` = 1432105 OR `id` = 1432305 OR `id` = 1432605 OR `id` = 58702 OR `id` = 154004 OR `id` = 166404 OR `id` = 1383908 OR `id` = 312902 OR `id` = 319204 OR `id` = 373906 OR `id` = 432806 OR `id` = 560106 OR `id` = 580903 OR `id` = 606906) AND `action1_param1` = 11972 OR `action1_param1` = 72;

UPDATE `creature_ai_scripts`
SET `action1_type` = 32, `action2_type` = 32, `action3_type` = 32, `action1_param2` = 1, `action2_param2` = 1, `action3_param2` = 1, `action1_param3` = 4, `action2_param3` = 5, `action3_param3` = 6
WHERE `id` = 684602;

UPDATE `creature_ai_scripts`
SET `action1_param2` = 1, `action1_param3` = 0
WHERE `id` = 1082406 OR `id` = 1082407 OR `id` = 1571802;

UPDATE `creature_ai_scripts`
SET `action1_param1` = 11976
WHERE `id` = 1082407;

UPDATE `creature_ai_scripts`
SET `event_type` = 9, `event_flags` = 1, `event_param1` = 0, `event_param2` = 5, `event_param3` = 7000, `event_param4` = 14000, `action1_param2` = 1, `action1_param3` = 0
WHERE `action1_type` = 11 AND `action1_param1` = 11978;

UPDATE `creature_ai_scripts`
SET `action1_param2` = 0, `action1_param3` = 0
WHERE `id` = 1145502;

UPDATE `creature_template`
SET `AIName` = ""
WHERE `Entry` = 4509;

UPDATE `creature_ai_scripts`
SET `event_flags` = 0
WHERE `id` = 1521501;

UPDATE `creature_ai_scripts`
SET `action2_type` = 32, `event_chance` = 5
WHERE `id` = 327402 OR `id` = 327502 OR `id` = 339703;

UPDATE `creature_ai_scripts`
SET `action1_type` = 32, `action2_type` = 0
WHERE `id` = 177203 OR `id` = 177303;

UPDATE `creature_ai_scripts`
SET `action2_type` = 0, `action2_param2` = 0
WHERE `id` = 494903;

DELETE FROM `creature_ai_scripts` WHERE `id` = 1018206;
