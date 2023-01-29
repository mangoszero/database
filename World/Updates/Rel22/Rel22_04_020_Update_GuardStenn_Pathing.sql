-- ----------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update
-- Now compatible with newer MySql Databases (v1.5)
-- ----------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT `structure` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cCurContent := (SELECT `content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '22'; 
    SET @cOldStructure = '04'; 
    SET @cOldContent = '019';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '04';
    SET @cNewContent = '020';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Update_GuardStenn_Pathing';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Update_GuardStenn_Pathing';

    -- Evaluate all settings
    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

    DELETE FROM `creature_movement` WHERE id=8376;
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 0,  -5240.657715,  -2880.643066,  338.885559, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 1,  -5259.471191,  -2883.016602,  339.083344, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 2,  -5270.679688,  -2882.660889,  338.903625, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 3,  -5279.370117,  -2879.691162,  338.722473, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 4,  -5291.707520,  -2873.074219,  338.819122, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 5,  -5302.002441,  -2868.012207,  339.249939, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 6,  -5318.393066,  -2862.350830,  339.423340, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 7,  -5335.552246,  -2858.912354,  339.942688, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 8,  -5356.757812,  -2858.982666,  339.937103, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 9,  -5369.049805,  -2862.526123,  340.512604, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 10,  -5383.001465,  -2873.090332,  340.829437, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 11,  -5394.941895,  -2880.707520,  341.861481, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 12,  -5407.792969,  -2883.023926,  342.916443, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 13,  -5400.855957,  -2882.085693,  342.334351, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 14,  -5387.406738,  -2875.804443,  341.175049, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 15,  -5378.090820,  -2869.494141,  340.705048, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 16,  -5372.440918,  -2865.202148,  340.550385, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 17,  -5355.868164,  -2858.804688,  339.933319, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 18,  -5343.654297,  -2858.372803,  340.156433, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 19,  -5326.365234,  -2861.080566,  339.680054, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 20,  -5309.761719,  -2865.286133,  339.327820, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 21,  -5298.361816,  -2870.210449,  339.102081, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 22,  -5286.249512,  -2877.230713,  338.678528, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 23,  -5275.155762,  -2881.719238,  338.769958, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 24,  -5256.666016,  -2884.022949,  339.193420, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 25,  -5238.162598,  -2879.765381,  338.820526, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 26,  -5213.482422,  -2860.223877,  336.828522, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 27,  -5198.581055,  -2852.251465,  335.962372, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 28,  -5185.771484,  -2848.631348,  335.445282, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 29,  -5165.248535,  -2844.190186,  334.289703, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 30,  -5144.662598,  -2840.046387,  332.068359, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 31,  -5130.923340,  -2837.356445,  330.496246, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 32,  -5110.314453,  -2833.321533,  328.236420, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 33,  -5093.247070,  -2829.472656,  327.232727, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 34,  -5079.721191,  -2825.896240,  327.282440, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 35,  -5057.197754,  -2816.484619,  327.448090, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 36,  -5038.671387,  -2806.600098,  327.070160, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 37,  -5022.552246,  -2796.457764,  326.563904, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 38,  -5037.411133,  -2805.681885,  327.021271, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 39,  -5046.333984,  -2811.208252,  327.383270, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 40,  -5062.078125,  -2818.739014,  327.419922, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 41,  -5075.265625,  -2823.434570,  327.314819, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 42,  -5088.587891,  -2827.732178,  327.248566, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 43,  -5102.150391,  -2831.146240,  327.301697, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 44,  -5115.924316,  -2833.643555,  329.025543, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 45,  -5133.131348,  -2836.810791,  330.748901, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 46,  -5157.141113,  -2841.688232,  333.320648, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 47,  -5174.287598,  -2845.171387,  334.964905, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 48,  -5187.809570,  -2848.719971,  335.618622, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 49,  -5204.225098,  -2854.127441,  336.250732, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO creature_movement (id, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES (8376, 50,  -5220.612305,  -2865.791016,  337.386047, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

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
            -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
            -- UPDATE THE DB VERSION
            -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
            INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
            SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

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
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                ELSE
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
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


