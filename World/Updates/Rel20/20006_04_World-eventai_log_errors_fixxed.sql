-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_04';

-- The are fixes for all but one of the errors found at this time in the world-eventai.log file (the last error is core related, but the fix is known and will be addressed immediately)

-- incorrect target
UPDATE creature_ai_scripts SET action1_param2 = 1 WHERE id IN (43101, 58702, 154004, 166404, 178703, 264906, 312902, 319204, 373906, 463702, 536401, 560106, 580803, 580903, 598201, 606906, 639102, 727404, 779703, 945111, 1047203, 1082406, 1082407, 1102204, 1146102, 1148606, 1156101, 1236902, 1280109, 1383908, 1432105, 1432305, 1432605, 1552702, 1562102);

-- Sargath
UPDATE creature_template SET AIName = ' ' WHERE Entry = 4509;

-- Kolkar Pack Runner / Kolkar Maraude / Kolkar Bloodcharger
-- action set to Stand (47), when it should be Summon (Verog The Dervish)
UPDATE creature_ai_scripts SET action2_type = 12 WHERE id IN (327402, 327502, 339703);

-- Gnolls (Nightlash - The Dead Fields quest)
-- Rot Hide Mystic / Rot Hide Gladerunner
-- action set to Stand (47), when it should be Summon
UPDATE creature_ai_scripts SET action1_type = 12 WHERE id IN (177203, 177303);

-- incorrect target
UPDATE creature_ai_scripts SET action1_param2 = 0 WHERE id IN (193801, 193701, 195201, 212101, 214001, 355101, 355201, 355301, 355401, 355501, 355601, 355701, 588601, 638901, 838501, 955301, 997901);

-- non repeatable event
UPDATE creature_ai_scripts SET event_flags = 0 WHERE id = 1521501;

-- invalid target type for event (OOC) - this is summoning 3 mobs, so target changed to self
UPDATE creature_ai_scripts SET action1_param2 = 0, action2_param2 = 0, action3_param2 = 0 WHERE id = 684602;

-- incorrect target (for OOC)
UPDATE creature_ai_scripts SET action1_param2=0 WHERE id=1145502;

-- incorrect target type for event 9 (in range)
UPDATE creature_ai_scripts SET action1_param2 = 0 WHERE id = 1571802;

-- Thrall
UPDATE creature_ai_scripts SET action2_type = 0, action2_param2 = 0 WHERE id = 494903;
