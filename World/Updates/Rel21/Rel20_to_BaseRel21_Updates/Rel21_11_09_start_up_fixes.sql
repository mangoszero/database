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
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '11'; 
    SET @cOldContent = '8'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '9';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'start up fixes';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'server start up fixes';

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


-- NPC does not have a movement path set up in either of the movement tables
-- disabling movement type (this is also how it is in mangos One) 
UPDATE creature SET MovementType = 0 WHERE guid = 42162;

-- creatures set to the same as in mangos One
UPDATE creature_linking_template SET flag = 7 WHERE entry IN (11663, 11664); 

-- The creatures do not exist, therefore deleting these entries
DELETE FROM db_scripts WHERE id IN (569, 571);
UPDATE gossip_menu_option SET action_script_id = 0 WHERE action_script_id IN (569, 571);

UPDATE db_scripts SET data_flags = 7 WHERE script_guid IN (1955, 1956, 1959, 1960); 
UPDATE db_scripts SET search_radius = 60 WHERE script_guid IN (1951, 1952, 1955, 1956, 1959, 1960);  

DELETE FROM pet_levelstats WHERE creature_entry = 4661;
-- pet_levelstats missing entries
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 1, 80, 48, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 2, 100, 59, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 3, 120, 70, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 4, 140, 81, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 5, 160, 92, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 6, 180, 103, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 7, 200, 114, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 8, 220, 125, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 9, 240, 136, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 10, 260, 147, 694, 29, 25, 29, 22, 26);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 11, 291, 158, 734, 30, 25, 32, 23, 28);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 12, 322, 180, 782, 31, 26, 36, 24, 31);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 13, 354, 203, 827, 32, 28, 43, 26, 32);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 14, 368, 227, 878, 33, 28, 44, 25, 35);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 15, 421, 251, 925, 34, 30, 48, 26, 37);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 16, 455, 275, 975, 36, 30, 52, 27, 39);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 17, 490, 300, 1022, 38, 31, 55, 28, 42);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 18, 528, 314, 1068, 39, 33, 59, 28, 44);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 19, 566, 351, 1120, 40, 33, 63, 29, 46);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 20, 606, 377, 1165, 42, 35, 67, 30, 49);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 21, 653, 400, 1232, 44, 36, 80, 31, 51);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 22, 699, 423, 1282, 46, 36, 84, 32, 53);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 23, 746, 447, 1330, 47, 38, 89, 33, 55);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 24, 823, 476, 1378, 49, 39, 93, 34, 58);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 25, 854, 504, 1427, 50, 40, 97, 35, 61);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 26, 911, 543, 1474, 52, 41, 101, 36, 62);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 27, 966, 564, 1524, 53, 42, 105, 37, 65);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 28, 1047, 592, 1572, 55, 43, 110, 38, 67);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 29, 1129, 620, 1619, 56, 44, 114, 39, 70);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 30, 1210, 648, 1667, 58, 46, 118, 40, 72);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 31, 1292, 676, 1715, 59, 47, 123, 40, 74);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 32, 1373, 720, 1766, 61, 48, 127, 41, 77);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 33, 1455, 742, 1812, 62, 49, 131, 42, 79);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 34, 1573, 793, 1861, 63, 51, 135, 43, 82);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 35, 1690, 845, 2000, 65, 52, 136, 44, 84);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 36, 1760, 879, 2154, 66, 53, 137, 45, 87);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 37, 1827, 916, 2248, 68, 53, 138, 46, 89);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 38, 1900, 952, 2331, 70, 55, 139, 47, 91);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 39, 1974, 988, 2483, 72, 56, 144, 48, 94);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 40, 2041, 1026, 2770, 74, 58, 150, 49, 97);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 41, 2127, 1063, 2856, 76, 59, 153, 50, 99);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 42, 2171, 1103, 3034, 81, 59, 156, 51, 102);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 43, 2215, 1187, 3228, 86, 61, 169, 52, 104);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 44, 2259, 1214, 2463, 89, 62, 172, 53, 107);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 45, 2303, 1240, 2638, 91, 64, 175, 54, 109);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 46, 2347, 1267, 2862, 94, 65, 178, 55, 112);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 47, 2391, 1294, 3021, 96, 66, 181, 56, 115);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 48, 2435, 1320, 3218, 99, 68, 184, 57, 117);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 49, 2479, 1347, 3370, 101, 69, 187, 58, 120);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 50, 2523, 1391, 3528, 104, 71, 190, 59, 123);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 51, 2568, 1435, 3963, 107, 72, 193, 61, 126);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 52, 2661, 1481, 4132, 109, 73, 199, 62, 128);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 53, 2755, 1527, 4286, 112, 75, 203, 63, 131);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 54, 2848, 1573, 4307, 114, 76, 207, 64, 133);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 55, 2942, 1620, 4389, 117, 77, 213, 65, 136);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 56, 3036, 1666, 4476, 119, 79, 218, 66, 139);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 57, 3129, 1714, 4532, 122, 80, 222, 67, 142);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 58, 3223, 1763, 4599, 124, 82, 227, 68, 144);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 59, 3317, 1824, 4673, 127, 83, 230, 69, 147);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4661, 60, 3419, 1874, 4745, 129, 85, 249, 70, 150);

DELETE FROM pet_levelstats WHERE creature_entry = 4196;
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 1, 80, 48, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 2, 100, 59, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 3, 120, 70, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 4, 140, 81, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 5, 160, 92, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 6, 180, 103, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 7, 200, 114, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 8, 220, 125, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 9, 240, 136, 0, 0, 0, 0, 0, 0);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 10, 260, 147, 694, 29, 25, 29, 22, 26);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 11, 291, 158, 734, 30, 25, 32, 23, 28);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 12, 322, 180, 782, 31, 26, 36, 24, 31);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 13, 354, 203, 827, 32, 28, 43, 26, 32);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 14, 368, 227, 878, 33, 28, 44, 25, 35);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 15, 421, 251, 925, 34, 30, 48, 26, 37);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 16, 455, 275, 975, 36, 30, 52, 27, 39);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 17, 490, 300, 1022, 38, 31, 55, 28, 42);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 18, 528, 314, 1068, 39, 33, 59, 28, 44);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 19, 566, 351, 1120, 40, 33, 63, 29, 46);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 20, 606, 377, 1165, 42, 35, 67, 30, 49);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 21, 653, 400, 1232, 44, 36, 80, 31, 51);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 22, 699, 423, 1282, 46, 36, 84, 32, 53);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 23, 746, 447, 1330, 47, 38, 89, 33, 55);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 24, 823, 476, 1378, 49, 39, 93, 34, 58);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 25, 854, 504, 1427, 50, 40, 97, 35, 61);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 26, 911, 543, 1474, 52, 41, 101, 36, 62);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 27, 966, 564, 1524, 53, 42, 105, 37, 65);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 28, 1047, 592, 1572, 55, 43, 110, 38, 67);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 29, 1129, 620, 1619, 56, 44, 114, 39, 70);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 30, 1210, 648, 1667, 58, 46, 118, 40, 72);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 31, 1292, 676, 1715, 59, 47, 123, 40, 74);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 32, 1373, 720, 1766, 61, 48, 127, 41, 77);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 33, 1455, 742, 1812, 62, 49, 131, 42, 79);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 34, 1573, 793, 1861, 63, 51, 135, 43, 82);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 35, 1690, 845, 2000, 65, 52, 136, 44, 84);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 36, 1760, 879, 2154, 66, 53, 137, 45, 87);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 37, 1827, 916, 2248, 68, 53, 138, 46, 89);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 38, 1900, 952, 2331, 70, 55, 139, 47, 91);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 39, 1974, 988, 2483, 72, 56, 144, 48, 94);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 40, 2041, 1026, 2770, 74, 58, 150, 49, 97);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 41, 2127, 1063, 2856, 76, 59, 153, 50, 99);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 42, 2171, 1103, 3034, 81, 59, 156, 51, 102);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 43, 2215, 1187, 3228, 86, 61, 169, 52, 104);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 44, 2259, 1214, 2463, 89, 62, 172, 53, 107);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 45, 2303, 1240, 2638, 91, 64, 175, 54, 109);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 46, 2347, 1267, 2862, 94, 65, 178, 55, 112);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 47, 2391, 1294, 3021, 96, 66, 181, 56, 115);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 48, 2435, 1320, 3218, 99, 68, 184, 57, 117);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 49, 2479, 1347, 3370, 101, 69, 187, 58, 120);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 50, 2523, 1391, 3528, 104, 71, 190, 59, 123);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 51, 2568, 1435, 3963, 107, 72, 193, 61, 126);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 52, 2661, 1481, 4132, 109, 73, 199, 62, 128);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 53, 2755, 1527, 4286, 112, 75, 203, 63, 131);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 54, 2848, 1573, 4307, 114, 76, 207, 64, 133);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 55, 2942, 1620, 4389, 117, 77, 213, 65, 136);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 56, 3036, 1666, 4476, 119, 79, 218, 66, 139);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 57, 3129, 1714, 4532, 122, 80, 222, 67, 142);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 58, 3223, 1763, 4599, 124, 82, 227, 68, 144);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 59, 3317, 1824, 4673, 127, 83, 230, 69, 147);
INSERT INTO pet_levelstats (creature_entry, level, hp, mana, armor, str, agi, sta, inte, spi) VALUES (4196, 60, 3419, 1874, 4745, 129, 85, 249, 70, 150);


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
