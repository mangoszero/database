-- ----------------------------------------
-- Added to prevent timeout's while loading
-- ----------------------------------------
SET GLOBAL net_read_timeout=30;
SET GLOBAL net_write_timeout=60;
SET GLOBAL net_buffer_length=1000000; 
SET GLOBAL max_allowed_packet=1000000000;
SET GLOBAL connect_timeout=10000000;

-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update (v1.3)
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT structure FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurContent := (SELECT content FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '22'; 
    SET @cOldStructure = '4'; 
    SET @cOldContent = '16';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '4';
    SET @cNewContent = '17';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Add_Pathing_To_Loch_Modan_Guards';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Add_Pathing_To_Loch_Modan_Guards';

    -- Evaluate all settings
    SET @cCurResult := (SELECT description FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cOldResult := (SELECT description FROM db_version WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;

        -- UPDATE THE DB VERSION
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
        SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

    UPDATE `creature` SET movementtype=2 WHERE guid=8840;
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 0,  -5415.239746,  -2884.385742,  343.519531, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 1,  -5432.297363,  -2883.956787,  345.217834, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 2,  -5444.791504,  -2881.922852,  346.964417, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 3,  -5464.030273,  -2877.264893,  349.817749, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 4,  -5487.141602,  -2872.376221,  353.539703, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 5,  -5506.448730,  -2868.508057,  356.451050, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 6,  -5533.789551,  -2861.661621,  360.392578, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 7,  -5545.386719,  -2850.213379,  361.888672, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 8,  -5560.532715,  -2832.375244,  364.725281, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 9,  -5574.330078,  -2817.729980,  366.059357, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 10,  -5583.198242,  -2811.916992,  366.307220, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 11,  -5601.158203,  -2803.087646,  366.431580, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 12,  -5635.218750,  -2786.343262,  365.043762, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 13,  -5655.990234,  -2778.852295,  363.909180, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 14,  -5689.398438,  -2767.362549,  362.391083, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 15,  -5682.724121,  -2770.942139,  362.908783, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 16,  -5655.307617,  -2779.150146,  363.964661, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 17,  -5628.135742,  -2789.800293,  365.431519, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 18,  -5604.625488,  -2801.207275,  366.324219, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 19,  -5575.690918,  -2816.217041,  366.198853, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 20,  -5559.996582,  -2832.539307,  364.662567, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 21,  -5545.449707,  -2850.456787,  361.880859, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 22,  -5536.974121,  -2860.896484,  360.654144, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 23,  -5517.088379,  -2866.139404,  358.032959, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 24,  -5499.866211,  -2869.808594,  355.604675, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 25,  -5483.358398,  -2873.183105,  352.907715, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 26,  -5463.750977,  -2877.191162,  349.779846, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 27,  -5442.751465,  -2881.483887,  346.678497, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 28,  -5428.075195,  -2884.484131,  344.635193, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 29,  -5417.793457,  -2884.432129,  343.663513, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8840, 30,  -5407.727539,  -2884.445801,  342.942413, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
UPDATE `creature` SET movementtype=2 WHERE guid=8736;
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 0,  -5352.977051,  -2981.122803,  324.196686, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 1,  -5363.939941,  -2988.710449,  326.173950, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 2,  -5382.013672,  -3005.893311,  330.278320, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 3,  -5389.429688,  -3015.569824,  327.580475, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 4,  -5382.851562,  -3007.670410,  329.334991, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 5,  -5375.187988,  -2999.264404,  330.628845, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 6,  -5372.964844,  -2996.858154,  329.332336, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 7,  -5363.523926,  -2989.066162,  326.164734, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 8,  -5348.437500,  -2980.566406,  324.047241, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 9,  -5338.778320,  -2988.624512,  323.838959, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 10,  -5334.264648,  -2988.453613,  325.176422, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 11,  -5327.500488,  -2987.942871,  325.176422, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 12,  -5320.537598,  -2987.324707,  322.429749, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 13,  -5310.479004,  -2986.941895,  322.120972, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 14,  -5318.568848,  -2987.088379,  322.120972, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 15,  -5326.098633,  -2987.061768,  325.176300, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 16,  -5333.636719,  -2987.399902,  325.176300, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 17,  -5338.930176,  -2986.756592,  323.971161, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 18,  -5343.698730,  -2978.095703,  324.238281, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 19,  -5348.883789,  -2965.573975,  323.878265, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 20,  -5355.371094,  -2950.861816,  323.877319, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 21,  -5370.129883,  -2951.708984,  323.745392, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 22,  -5367.962402,  -2959.606201,  326.430237, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 23,  -5364.921875,  -2969.070801,  326.780060, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 24,  -5367.340820,  -2969.662842,  326.639191, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 25,  -5377.866211,  -2972.621582,  323.168823, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 26,  -5387.594727,  -2959.951904,  322.058350, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 27,  -5380.918945,  -2969.012451,  322.058350, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 28,  -5378.128418,  -2971.619873,  323.168732, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 29,  -5374.496582,  -2971.531250,  323.168732, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 30,  -5364.273438,  -2969.200439,  326.780853, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 31,  -5367.111328,  -2960.550049,  326.502075, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 32,  -5368.783691,  -2953.101807,  323.742004, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 33,  -5355.785156,  -2951.473145,  323.894989, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 34,  -5351.974121,  -2962.425537,  323.852478, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 35,  -5349.648438,  -2971.988770,  324.260986, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 36,  -5348.201172,  -2977.940186,  324.278442, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8736, 37,  -5353.327148,  -2980.875732,  324.222473, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
UPDATE `creature` SET movementtype=2 WHERE guid=8745;
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 0,  -5348.740234,  -2965.050049,  323.816010, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 1,  -5354.416992,  -2953.471191,  323.945129, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 2,  -5368.316406,  -2935.564209,  327.855804, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 3,  -5387.028320,  -2914.734619,  335.692108, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 4,  -5394.018555,  -2906.899902,  338.466644, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 5,  -5408.200684,  -2885.440918,  342.974792, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 6,  -5396.428223,  -2904.365234,  339.183838, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 7,  -5386.116211,  -2916.833252,  335.078247, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 8,  -5367.694824,  -2937.340332,  327.387573, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 9,  -5352.861328,  -2953.853271,  323.919495, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 10,  -5345.783203,  -2978.547607,  324.331055, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 11,  -5339.417480,  -2991.139648,  323.724182, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 12,  -5336.520020,  -3023.473145,  324.003174, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 13,  -5337.797363,  -3008.875977,  324.180511, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 14,  -5339.392578,  -2989.909912,  323.728424, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 15,  -5345.563965,  -2977.375244,  324.301697, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8745, 16,  -5349.755371,  -2959.955322,  323.664246, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 1,  -5239.137207,  -2880.286865,  338.853821, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 2,  -5253.560059,  -2884.623779,  339.252777, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 3,  -5268.589844,  -2882.833984,  338.959808, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 4,  -5279.957520,  -2879.816650,  338.723206, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 5,  -5287.784668,  -2875.253418,  338.794128, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 6,  -5300.902344,  -2868.083984,  339.203979, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 7,  -5316.276367,  -2863.398926,  339.339752, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 8,  -5335.132812,  -2859.656006,  339.917358, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 9,  -5352.464844,  -2859.253662,  339.898804, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid
    

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL ABOVE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

        -- If we get here ok, commit the changes
        IF bRollback = TRUE THEN
            ROLLBACK;
            SHOW ERRORS;
            SELECT '* UPDATE FAILED *' AS `===== Status =====`,@cCurResult AS `===== DB is on Version: =====`;



        ELSE
            COMMIT;
            SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,@cNewResult AS `===== DB is now on Version =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cCurResult AS `===== DB is already on Version =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
		IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
		ELSE
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                END IF;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;

