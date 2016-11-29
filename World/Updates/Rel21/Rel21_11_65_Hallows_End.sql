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
    SET @cOldContent = '64';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '65';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Hallow\'s End';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Adds implementation of Hallow\'s End events and quests';

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





-- Hallow's End:
-- Adds Wickerman's Festival event
-- Adds Pumpking Bag loot drops
-- Fixes quests

-- This is the event that occurs at 8pm every evening. Preceding this are reminders at 30, 15 and 5 minutes before the event starts by Darkcaller Yanka.
-- Upon starting, Sylvanas is summoned as the Banshee Queen and delivers her speech after which,
-- wickerman embers are summoned around the wickerman (which give a buff) and Darkcaller Yanka starts dancing.
-- This lasts the night when the dancing stops and the embers despawn. 

SET @IN_MINUTE = 60;
SET @IN_HOUR = 3600;

/* Wickerman Embers */
DELETE FROM `game_event` WHERE entry = 24;
INSERT INTO `game_event` (`entry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `description`) VALUES (24, '2016-10-18 20:01:07', '2020-12-31 22:59:59', 1440, 600, 0, 'Hallow\'s End - Wickerman Ember\'s');

DELETE FROM gameobject WHERE guid IN (37875, 37876, 37877, 37878, 37886, 37887);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(37875, 180437, 0, 1739.410034, 508.948639, 40.772842, 4.315085, 0, 0, 0, 0, 300, 100, 1),
(37876, 180437, 0, 1722.443481, 508.140778, 40.494492, 5.355066, 0, 0, 0, 0, 300, 100, 1),
(37877, 180437, 0, 1721.620728, 499.970856, 41.403786, 0.032173, 0, 0, 0, 0, 300, 100, 1),
(37878, 180437, 0, 1743.792236, 501.707825, 41.423393, 3.427584, 0, 0, 0, 0, 300, 100, 1),
(37886, 180437, 0, 1734.531494, 510.871857, 40.652969, 4.601748, 0, 0, 0, 0, 300, 100, 1),
(37887, 180437, 0, 1733.452759, 494.314789, 42.159492, 1.446059, 0, 0, 0, 0, 300, 100, 1);

DELETE FROM game_event_gameobject WHERE guid IN (37875, 37876, 37877, 37878, 37886, 37887);
INSERT INTO game_event_gameobject VALUES
(37875, 24),
(37876, 24),
(37877, 24),
(37878, 24),
(37886, 24),
(37887, 24);

/* Yanka calls before Wickerman lighting */
-- Linked event
DELETE FROM `game_event` WHERE entry = 25;
INSERT INTO `game_event` (`entry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `description`) VALUES (25, '2016-10-18 19:30:00', '2020-12-31 22:59:59', 1440, 45, 0, 'Hallow\'s End - Banshee Queen');

-- Invisible trigger
DELETE FROM creature WHERE guid = 160005;
INSERT INTO `creature` VALUES
(160005, 12999, 0, 0, 0, 1732.31, 520.874, 36.3326, 1.30942, 300, 0, 0, 9763, 0, 0, 2);
DELETE FROM creature_movement WHERE id = 160005;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(160005, 1, 1732.31, 520.874, 36.3326, 86400000, 16000501, 0, 0, 0, 0, 0, 0, 0, 1.30942, 0, 0);
DELETE FROM game_event_creature WHERE guid = 160005;
INSERT INTO game_event_creature VALUES
(160005, 25);

-- Script for Yanka announces
DELETE FROM db_scripts WHERE id=16000501;
INSERT INTO `db_scripts` (`script_type`, `id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(3, 16000501, 1, 0, 0, 0, 15197, 20, 0, 2000000508, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Yanka 30 Mins to Festival Start, triggered by creature_movement 160005'),
(3, 16000501, 15*@IN_MINUTE, 0, 0, 0, 15197, 20, 0, 2000000509, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Yanka 15 Mins to Festival Start'),
(3, 16000501, 25*@IN_MINUTE, 0, 0, 0, 15197, 20, 0, 2000000510, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Yanka 5 Mins to Festival Start'),
(3, 16000501, 30*@IN_MINUTE, 0, 0, 0, 15197, 20, 0, 2000000511, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Yanka Festival Start'),
(3, 16000501, 30*@IN_MINUTE+1, 10, 15193, 72000, 0, 0, 0, 0, 0, 0, 0, 1734.6, 508.803, 41.2847, 1.6173, 'Hallow\'s End: Summon Banshee Queen'),
(3, 16000501, 10*@IN_HOUR, 43, 0, 0, 180433, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Reset Wickerman'),
(3, 16000501, 10*@IN_HOUR, 1, 26, 0, 15197, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Yanka Stops Dancing');

/* Banshee Queen event */
-- Adding WP Movement to Banshee Queen, increasing size to match screenshot, setting non-attackable and always active
UPDATE `creature_template` SET `MovementType`= 2, `Scale`= 2, `UnitFlags`= 130, `ExtraFlags`= 4096  WHERE `Entry`= 15193;
DELETE FROM creature_movement_template WHERE entry = 15193;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(15193, 1, 1734.6, 508.803, 41.2847, 72000, 1519301, 0, 0, 0, 0, 0, 0, 0, 1.6173, 0, 0);

-- Adding Ghost Visual Aura (22650)
DELETE FROM creature_template_addon WHERE entry=15193;
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES
(15193, 0, 0, 0, 0, 0, 0, '22650');

-- DBscript for Banshee Queen event
DELETE FROM `db_scripts` WHERE id = 1519301;
INSERT INTO `db_scripts` (`script_type`, `id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(3, 1519301, 1, 0, 0, 0, 0, 0, 0, 2000000500, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Banshee Queen Speech Part 1, triggered by summon in db_scripts 16000501'),
(3, 1519301, 9, 0, 0, 0, 0, 0, 0, 2000000501, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Banshee Queen Speech Part 2'),
(3, 1519301, 18, 0, 0, 0, 0, 0, 0, 2000000502, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Banshee Queen Speech Part 3'),
(3, 1519301, 27, 0, 0, 0, 0, 0, 0, 2000000503, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Banshee Queen Speech Part 4'),
(3, 1519301, 49, 0, 0, 0, 0, 0, 0, 2000000504, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Banshee Queen Speech Part 5'),
(3, 1519301, 58, 0, 0, 0, 0, 0, 0, 2000000505, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Banshee Queen Speech Part 6'),
(3, 1519301, 68, 15, 14292, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Banshee Queen Throw Torch'),
(3, 1519301, 70, 13, 0, 0, 180433, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Activate Wickerman'),
(3, 1519301, 71, 1, 10, 0, 15197, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hallow\'s End: Yanka Dance');

-- Add Wickerman as target for spell Tosing Torch
DELETE FROM spell_script_target WHERE entry=14292;
INSERT INTO `spell_script_target` VALUES (14292, 0, 180433, 0);

--  Sylvanas' speech texts to db_script_string
DELETE FROM db_script_string WHERE entry BETWEEN 2000000500 AND 2000000511;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(2000000500, 'Children of the Night, heed your Queen\'s call!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 22, 'Hallow\'s End: Banshee Queen Speech Part 1'),
(2000000501, 'I join you in celebration of this most revered of nights - the night we Forsaken broke the Scourge\'s yoke of oppression!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 1, 'Hallow\'s End: Banshee Queen Speech Part 2'),
(2000000502, 'It is this night that our enemies fear us the most. It is THIS night that we show our enemies what it means to stand against the Forsaken!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 1, 'Hallow\'s End: Banshee Queen Speech Part 3'),
(2000000503, 'We burn the effigy of the Wickerman as a symbol of our struggle against those who would oppose us. We wear the ashes of the burnt Wickerman as a symbol of our neverending fight against those who would enslave us.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 1, 'Hallow\'s End: Banshee Queen Speech Part 4'),
(2000000504, 'Now is the time to shake the world to its foundations! NOW is the time to remind those who would enslave us that we shall never yield!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 5, 'Hallow\'s End: Banshee Queen Speech Part 5'),
(2000000505, 'NOW is the time of the Forsaken! Power to the Forsaken - NOW AND FOREVER!!!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 15, 'Hallow\'s End: Banshee Queen Speech Part 6'),
(2000000508, 'The burning of the Wickerman will begin in thirty minutes! Come to the festival - located just west of the Undercity - and celebrate Hallow\'s End and our liberation from the Scourge!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 1, 'Hallow\'s End: Yanka 30 Mins to Festival Start'),
(2000000509, 'The burning of the Wickerman will begin in fifteen minutes! Come to the festival - located just west of the Undercity - and celebrate Hallow\'s End and our liberation from the Scourge!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 1, 'Hallow\'s End: Yanka 15 Mins to Festival Start'),
(2000000510, 'The burning of the Wickerman will begin in five minutes! Come to the festival - located just west of the Undercity - and celebrate Hallow\'s End and our liberation from the Scourge!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 1, 'Hallow\'s End: Yanka 5 Mins to Festival Start'),
(2000000511, 'The Wickerman Festival now begins! Power to the Forsaken!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 1, 1, 'Hallow\'s End: Yanka Festival Start');

-- Adding entries for the Wickerman's Festival
-- Wickerman
DELETE FROM gameobject WHERE guid=37870;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37870, 180433, 0, 1734.04, 504.05, 42.2861, 1.4131, 0, 0, 0.649213, 0.760607, 300, 100,1);
DELETE FROM game_event_gameobject WHERE guid=37870;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37870, 12);

-- Adjusting size and removing player interaction
UPDATE `gameobject_template` SET `flags`= 16, `size`= 4 WHERE `entry`= 180433;


-- Pumpkins
DELETE FROM gameobject WHERE guid=37879;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37879, 180405, 0, 1746.07, 517.066, 38.936, 3.40519, 0, 0, 0.991327, -0.131419, 300, 100, 1);
DELETE FROM game_event_gameobject WHERE guid=37879;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37879, 12);
DELETE FROM gameobject WHERE guid=37880;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37880, 180406, 0, 1728, 475.099, 63.6779, 3.49316, 0, 0, 0.98459, -0.174878, 300, 100, 1);
DELETE FROM game_event_gameobject WHERE guid=37880;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37880, 12);
DELETE FROM gameobject WHERE guid=37881;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37881, 180406, 0, 1719.67, 522.979, 36.8828, 3.30702, 0, 0, 0.996581, -0.0826182, 300, 100, 1);
DELETE FROM game_event_gameobject WHERE guid=37881;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37881, 12);

-- Forsaken Banners
DELETE FROM gameobject WHERE guid=37867;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37867, 180432, 0, 1732.167358, 474.855957, 61.656750, 1.52646, 0, 0, 0, 0, 300, 100, 1);
DELETE FROM game_event_gameobject WHERE guid=37867;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37867, 12);
DELETE FROM gameobject WHERE guid=37868;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37868, 180432, 0, 1749.28, 507.611, 39.2312, 1.49635, 0, 0, 0.680301, 0.732933, 300, 100, 1);
DELETE FROM game_event_gameobject WHERE guid=37868;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37868, 12);
DELETE FROM gameobject WHERE guid=37869;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37869, 180432, 0, 1712.63, 507.05, 38.2495, 1.58824, 0, 0, 0.713246, 0.700914, 300, 100, 1);
DELETE FROM game_event_gameobject WHERE guid=37869;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37869, 12);

-- Wickerman Guardians
DELETE FROM creature WHERE guid=85632;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `Deathstate`, `MovementType`) VALUES (85632, 15195, 0, 0, 0, 1713.1, 511.295, 37.2005, 1.48063, 300, 0, 0, 45780, 0, 0, 0);
DELETE FROM game_event_creature WHERE guid=85632;
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES (85632, 12);
DELETE FROM creature WHERE guid=85633;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `Deathstate`, `MovementType`) VALUES (85633, 15195, 0, 0, 0, 1750.57, 511.697, 37.7587, 1.25444, 300, 0, 0, 45780, 0, 0, 0);
DELETE FROM game_event_creature WHERE guid=85633;
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES (85633, 12);
DELETE FROM creature WHERE guid=85634;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `Deathstate`, `MovementType`) VALUES (85634, 15195, 0, 0, 0, 1729.046387, 552.650269, 34.302891, 4.543876, 300, 0, 0, 45780, 0, 0, 0);
DELETE FROM game_event_creature WHERE guid=85634;
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES (85634, 12);

-- Making them guards
UPDATE `creature_template` SET `UnitFlags`= 36864, `ExtraFlags`= 1024 WHERE `Entry`= 15195;

-- Adding Wickerman Guardian Ember GO to DB to support spell 27005
DELETE FROM gameobject_template WHERE entry=180574;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `faction`, `flags`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `mingold`, `maxgold`) VALUES (180574, 2, 6421, 'Wickerman Guardian Ember', 0, 0, 5, 43, 0, 0, 6535, 0, 0, 19700, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Adding Gossip menu and options for Wickerman Ember
DELETE FROM gossip_menu WHERE entry=6535 AND text_id IN (7737, 7738);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES (6535, 7737, 0, 1370);
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES (6535, 7738, 0, 1371);
DELETE FROM gossip_menu_option WHERE menu_id=6535 AND id=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES (6535, 0, 0, 'Smear the ash on my face like war paint!', 1, 0, -1, 0, 653501, 0, 0, NULL, 1370);
DELETE FROM db_scripts WHERE id=653501;
INSERT INTO `db_scripts` (`script_type`, `id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (2, 653501, 0, 15, 24705, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Invocation of the Wickerman');

DELETE FROM conditions WHERE condition_entry IN (1370, 1371);
-- Adding condition entry option when not buffed with 24705
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES (1370, 11, 24705, 0);
-- Adding condition entry option when already buffed with 24705
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES (1371, 1, 24705, 0);

-- Darkcaller Yanka
UPDATE `creature` SET `position_x`= 1732.31, `position_y`= 520.874, `position_z`= 36.3326, `orientation`= 1.309420 WHERE `id`= 15197;

-- Adding Gossip_menu
DELETE FROM gossip_menu WHERE entry=6537 AND text_id =7740;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES (6537, 7740, 0, 0);
UPDATE `creature_template` SET `NpcFlags`= 7, `GossipMenuId`= 6537 WHERE `Entry`= 15197;

-- Bonfires
DELETE FROM gameobject WHERE guid IN (37871,37872,37873,37874,37885);
DELETE FROM game_event_gameobject WHERE guid IN (37871,37872,37873,37874,37885);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37871, 180434, 0, 1758.89, 513.276, 35.8655, 1.28897, 0, 0, 0.600788, 0.799409, 300, 0, 1);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37871, 12);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37872, 180434, 0, 1704.48, 518.689, 35.4045, 1.30704, 0, 0, 0.607984, 0.793949, 300, 0, 1);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37872, 12);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37873, 180434, 0, 1743.098389, 473.444763, 61.655338, 1.4092, 0, 0, 0, 0, 300, 0, 1);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37873, 12);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37874, 180434, 0, 1712.852661, 472.536041, 61.646259, 1.589838, 0, 0, 0, 0, 300, 0, 1);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37874, 12);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (37885, 180434, 0, 1738.741821, 551.096802, 33.496574, 4.59492, 0, 0, 0, 0, 300, 100, 1);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (37885, 12);

-- Added drops for item 20400 (Pumpkin Bag) that should only drop for Hallow's End
SET @CONDITION := 162;

DELETE FROM `conditions` WHERE `condition_entry` = @CONDITION;
INSERT INTO `conditions` VALUES
(@CONDITION, 12, 12, 0);

DELETE FROM `creature_loot_template` WHERE `item` = 20400;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES 
(193, 20400, 0.08, 0, 1, 1, @CONDITION),
(1045, 20400, 0.32, 0, 1, 1, @CONDITION),
(1046, 20400, 0.16, 0, 1, 1, @CONDITION),
(1047, 20400, 0.03, 0, 1, 1, @CONDITION),
(1048, 20400, 0.08, 0, 1, 1, @CONDITION),
(1559, 20400, 0.1, 0, 1, 1, @CONDITION),
(1783, 20400, 0.04, 0, 1, 1, @CONDITION),
(1784, 20400, 0.08, 0, 1, 1, @CONDITION),
(1785, 20400, 0.08, 0, 1, 1, @CONDITION),
(1787, 20400, 0.031, 0, 1, 1, @CONDITION),
(1788, 20400, 0.2, 0, 1, 1, @CONDITION),
(1789, 20400, 0.03, 0, 1, 1, @CONDITION),
(1791, 20400, 0.04, 0, 1, 1, @CONDITION),
(1793, 20400, 0.037, 0, 1, 1, @CONDITION),
(1794, 20400, 0.03, 0, 1, 1, @CONDITION),
(1795, 20400, 0.035, 0, 1, 1, @CONDITION),
(1796, 20400, 0.06, 0, 1, 1, @CONDITION),
(1800, 20400, 0.08, 0, 1, 1, @CONDITION),
(1801, 20400, 0.04, 0, 1, 1, @CONDITION),
(1802, 20400, 0.06, 0, 1, 1, @CONDITION),
(1804, 20400, 0.032, 0, 1, 1, @CONDITION),
(1805, 20400, 0.12, 0, 1, 1, @CONDITION),
(1806, 20400, 0.06, 0, 1, 1, @CONDITION),
(1808, 20400, 0.06, 0, 1, 1, @CONDITION),
(1809, 20400, 0.06, 0, 1, 1, @CONDITION),
(1812, 20400, 0.08, 0, 1, 1, @CONDITION),
(1813, 20400, 0.02, 0, 1, 1, @CONDITION),
(1815, 20400, 0.06, 0, 1, 1, @CONDITION),
(1816, 20400, 0.04, 0, 1, 1, @CONDITION),
(1817, 20400, 0.025, 0, 1, 1, @CONDITION),
(1821, 20400, 0.04, 0, 1, 1, @CONDITION),
(1822, 20400, 0.04, 0, 1, 1, @CONDITION),
(1824, 20400, 0.06, 0, 1, 1, @CONDITION),
(1826, 20400, 0.08, 0, 1, 1, @CONDITION),
(1827, 20400, 0.22, 0, 1, 1, @CONDITION),
(1831, 20400, 0.06, 0, 1, 1, @CONDITION),
(1832, 20400, 0.22, 0, 1, 1, @CONDITION),
(1833, 20400, 0.06, 0, 1, 1, @CONDITION),
(1834, 20400, 0.26, 0, 1, 1, @CONDITION),
(1835, 20400, 0.06, 0, 1, 1, @CONDITION),
(1836, 20400, 0.12, 0, 1, 1, @CONDITION),
(1841, 20400, 1.4, 0, 1, 1, @CONDITION),
(1845, 20400, 0.05, 0, 1, 1, @CONDITION),
(1883, 20400, 0.057, 0, 1, 1, @CONDITION),
(1884, 20400, 0.08, 0, 1, 1, @CONDITION),
(2648, 20400, 0.1, 0, 1, 1, @CONDITION),
(2681, 20400, 0.06, 0, 1, 1, @CONDITION),
(2852, 20400, 0.0950071, 0, 1, 1, @CONDITION),
(2931, 20400, 0.12, 0, 1, 1, @CONDITION),
(3094, 20400, 0.02, 0, 1, 1, @CONDITION),
(4370, 20400, 0.181, 0, 1, 1, @CONDITION),
(4374, 20400, 0.286, 0, 1, 1, @CONDITION),
(4472, 20400, 0.06, 0, 1, 1, @CONDITION),
(4474, 20400, 0.06, 0, 1, 1, @CONDITION),
(4475, 20400, 0.08, 0, 1, 1, @CONDITION),
(4493, 20400, 0.06, 0, 1, 1, @CONDITION),
(4494, 20400, 0.06, 0, 1, 1, @CONDITION),
(5271, 20400, 0.14, 0, 1, 1, @CONDITION),
(5273, 20400, 0.06, 0, 1, 1, @CONDITION),
(5277, 20400, 0.1, 0, 1, 1, @CONDITION),
(5280, 20400, 0.04, 0, 1, 1, @CONDITION),
(5319, 20400, 0.3, 0, 1, 1, @CONDITION),
(5708, 20400, 0.02, 0, 1, 1, @CONDITION),
(5977, 20400, 0.08, 0, 1, 1, @CONDITION),
(5978, 20400, 0.06, 0, 1, 1, @CONDITION),
(5981, 20400, 0.054, 0, 1, 1, @CONDITION),
(5988, 20400, 0.02, 0, 1, 1, @CONDITION),
(5991, 20400, 0.06, 0, 1, 1, @CONDITION),
(5993, 20400, 0.08, 0, 1, 1, @CONDITION),
(6004, 20400, 0.04, 0, 1, 1, @CONDITION),
(6005, 20400, 0.04, 0, 1, 1, @CONDITION),
(6006, 20400, 0.08, 0, 1, 1, @CONDITION),
(6007, 20400, 0.1, 0, 1, 1, @CONDITION),
(6008, 20400, 0.1, 0, 1, 1, @CONDITION),
(6009, 20400, 0.06, 0, 1, 1, @CONDITION),
(6010, 20400, 0.14, 0, 1, 1, @CONDITION),
(6011, 20400, 0.1, 0, 1, 1, @CONDITION),
(6129, 20400, 0.24, 0, 1, 1, @CONDITION),
(6130, 20400, 0.12, 0, 1, 1, @CONDITION),
(6131, 20400, 0.16, 0, 1, 1, @CONDITION),
(6135, 20400, 0.04, 0, 1, 1, @CONDITION),
(6136, 20400, 0.04, 0, 1, 1, @CONDITION),
(6137, 20400, 0.06, 0, 1, 1, @CONDITION),
(6138, 20400, 0.08, 0, 1, 1, @CONDITION),
(6140, 20400, 0.14, 0, 1, 1, @CONDITION),
(6143, 20400, 0.04, 0, 1, 1, @CONDITION),
(6144, 20400, 0.041, 0, 1, 1, @CONDITION),
(6146, 20400, 0.06, 0, 1, 1, @CONDITION),
(6147, 20400, 0.06, 0, 1, 1, @CONDITION),
(6148, 20400, 0.04, 0, 1, 1, @CONDITION),
(6188, 20400, 0.02, 0, 1, 1, @CONDITION),
(6189, 20400, 0.14, 0, 1, 1, @CONDITION),
(6195, 20400, 0.06, 0, 1, 1, @CONDITION),
(6196, 20400, 0.02, 0, 1, 1, @CONDITION),
(6198, 20400, 0.06, 0, 1, 1, @CONDITION),
(6199, 20400, 0.06, 0, 1, 1, @CONDITION),
(6200, 20400, 0.08, 0, 1, 1, @CONDITION),
(6201, 20400, 0.04, 0, 1, 1, @CONDITION),
(6202, 20400, 0.06, 0, 1, 1, @CONDITION),
(6347, 20400, 0.06, 0, 1, 1, @CONDITION),
(6348, 20400, 0.02, 0, 1, 1, @CONDITION),
(6349, 20400, 0.02, 0, 1, 1, @CONDITION),
(6350, 20400, 0.06, 0, 1, 1, @CONDITION),
(6351, 20400, 0.04, 0, 1, 1, @CONDITION),
(6352, 20400, 0.04, 0, 1, 1, @CONDITION),
(6370, 20400, 0.03, 0, 1, 1, @CONDITION),
(6371, 20400, 0.1, 0, 1, 1, @CONDITION),
(6378, 20400, 0.04, 0, 1, 1, @CONDITION),
(6379, 20400, 0.04, 0, 1, 1, @CONDITION),
(6380, 20400, 0.02, 0, 1, 1, @CONDITION),
(6498, 20400, 0.14, 0, 1, 1, @CONDITION),
(6499, 20400, 0.18, 0, 1, 1, @CONDITION),
(6500, 20400, 0.1, 0, 1, 1, @CONDITION),
(6501, 20400, 0.34, 0, 1, 1, @CONDITION),
(6502, 20400, 0.22, 0, 1, 1, @CONDITION),
(6503, 20400, 0.3, 0, 1, 1, @CONDITION),
(6504, 20400, 0.14, 0, 1, 1, @CONDITION),
(6508, 20400, 0.02, 0, 1, 1, @CONDITION),
(6510, 20400, 0.08, 0, 1, 1, @CONDITION),
(6512, 20400, 0.06, 0, 1, 1, @CONDITION),
(6513, 20400, 0.06, 0, 1, 1, @CONDITION),
(6514, 20400, 0.04, 0, 1, 1, @CONDITION),
(6516, 20400, 0.04, 0, 1, 1, @CONDITION),
(6517, 20400, 0.04, 0, 1, 1, @CONDITION),
(6518, 20400, 0.06, 0, 1, 1, @CONDITION),
(6519, 20400, 0.08, 0, 1, 1, @CONDITION),
(6520, 20400, 0.08, 0, 1, 1, @CONDITION),
(6521, 20400, 0.08, 0, 1, 1, @CONDITION),
(6527, 20400, 0.08, 0, 1, 1, @CONDITION),
(6551, 20400, 0.08, 0, 1, 1, @CONDITION),
(6552, 20400, 0.02, 0, 1, 1, @CONDITION),
(6553, 20400, 0.048, 0, 1, 1, @CONDITION),
(6554, 20400, 0.14, 0, 1, 1, @CONDITION),
(6555, 20400, 0.18, 0, 1, 1, @CONDITION),
(6557, 20400, 0.04, 0, 1, 1, @CONDITION),
(6559, 20400, 0.08, 0, 1, 1, @CONDITION),
(6560, 20400, 0.1, 0, 1, 1, @CONDITION),
(7025, 20400, 0.04, 0, 1, 1, @CONDITION),
(7026, 20400, 0.04, 0, 1, 1, @CONDITION),
(7027, 20400, 0.08, 0, 1, 1, @CONDITION),
(7028, 20400, 0.06, 0, 1, 1, @CONDITION),
(7029, 20400, 0.02, 0, 1, 1, @CONDITION),
(7031, 20400, 0.06, 0, 1, 1, @CONDITION),
(7032, 20400, 0.08, 0, 1, 1, @CONDITION),
(7033, 20400, 0.04, 0, 1, 1, @CONDITION),
(7034, 20400, 0.04, 0, 1, 1, @CONDITION),
(7035, 20400, 0.06, 0, 1, 1, @CONDITION),
(7036, 20400, 0.03, 0, 1, 1, @CONDITION),
(7037, 20400, 0.06, 0, 1, 1, @CONDITION),
(7038, 20400, 0.1, 0, 1, 1, @CONDITION),
(7039, 20400, 0.04, 0, 1, 1, @CONDITION),
(7040, 20400, 0.14, 0, 1, 1, @CONDITION),
(7041, 20400, 0.14, 0, 1, 1, @CONDITION),
(7042, 20400, 0.16, 0, 1, 1, @CONDITION),
(7043, 20400, 0.12, 0, 1, 1, @CONDITION),
(7044, 20400, 0.1, 0, 1, 1, @CONDITION),
(7045, 20400, 0.12, 0, 1, 1, @CONDITION),
(7046, 20400, 0.12, 0, 1, 1, @CONDITION),
(7047, 20400, 0.04, 0, 1, 1, @CONDITION),
(7048, 20400, 0.04, 0, 1, 1, @CONDITION),
(7049, 20400, 0.06, 0, 1, 1, @CONDITION),
(7055, 20400, 0.06, 0, 1, 1, @CONDITION),
(7092, 20400, 0.1, 0, 1, 1, @CONDITION),
(7093, 20400, 0.04, 0, 1, 1, @CONDITION),
(7098, 20400, 0.08, 0, 1, 1, @CONDITION),
(7100, 20400, 0.06, 0, 1, 1, @CONDITION),
(7101, 20400, 0.08, 0, 1, 1, @CONDITION),
(7106, 20400, 0.04, 0, 1, 1, @CONDITION),
(7107, 20400, 0.08, 0, 1, 1, @CONDITION),
(7108, 20400, 0.06, 0, 1, 1, @CONDITION),
(7109, 20400, 0.04, 0, 1, 1, @CONDITION),
(7110, 20400, 0.06, 0, 1, 1, @CONDITION),
(7111, 20400, 0.06, 0, 1, 1, @CONDITION),
(7112, 20400, 0.1, 0, 1, 1, @CONDITION),
(7113, 20400, 0.04, 0, 1, 1, @CONDITION),
(7114, 20400, 0.08, 0, 1, 1, @CONDITION),
(7115, 20400, 0.06, 0, 1, 1, @CONDITION),
(7118, 20400, 0.06, 0, 1, 1, @CONDITION),
(7120, 20400, 0.08, 0, 1, 1, @CONDITION),
(7125, 20400, 0.06, 0, 1, 1, @CONDITION),
(7126, 20400, 0.06, 0, 1, 1, @CONDITION),
(7132, 20400, 0.08, 0, 1, 1, @CONDITION),
(7135, 20400, 0.32, 0, 1, 1, @CONDITION),
(7136, 20400, 0.03, 0, 1, 1, @CONDITION),
(7138, 20400, 0.08, 0, 1, 1, @CONDITION),
(7139, 20400, 0.06, 0, 1, 1, @CONDITION),
(7149, 20400, 0.02, 0, 1, 1, @CONDITION),
(7156, 20400, 0.08, 0, 1, 1, @CONDITION),
(7157, 20400, 0.08, 0, 1, 1, @CONDITION),
(7158, 20400, 0.08, 0, 1, 1, @CONDITION),
(7369, 20400, 0.06, 0, 1, 1, @CONDITION),
(7370, 20400, 0.06, 0, 1, 1, @CONDITION),
(7371, 20400, 0.04, 0, 1, 1, @CONDITION),
(7372, 20400, 0.04, 0, 1, 1, @CONDITION),
(7376, 20400, 0.08, 0, 1, 1, @CONDITION),
(7379, 20400, 0.06, 0, 1, 1, @CONDITION),
(7428, 20400, 0.08, 0, 1, 1, @CONDITION),
(7429, 20400, 0.18, 0, 1, 1, @CONDITION),
(7430, 20400, 0.08, 0, 1, 1, @CONDITION),
(7431, 20400, 0.02, 0, 1, 1, @CONDITION),
(7432, 20400, 0.04, 0, 1, 1, @CONDITION),
(7433, 20400, 0.02, 0, 1, 1, @CONDITION),
(7434, 20400, 0.04, 0, 1, 1, @CONDITION),
(7435, 20400, 0.14, 0, 1, 1, @CONDITION),
(7436, 20400, 0.18, 0, 1, 1, @CONDITION),
(7437, 20400, 0.14, 0, 1, 1, @CONDITION),
(7438, 20400, 0.06, 0, 1, 1, @CONDITION),
(7439, 20400, 0.06, 0, 1, 1, @CONDITION),
(7440, 20400, 0.06, 0, 1, 1, @CONDITION),
(7441, 20400, 0.08, 0, 1, 1, @CONDITION),
(7442, 20400, 0.06, 0, 1, 1, @CONDITION),
(7443, 20400, 0.06, 0, 1, 1, @CONDITION),
(7444, 20400, 0.06, 0, 1, 1, @CONDITION),
(7445, 20400, 0.04, 0, 1, 1, @CONDITION),
(7446, 20400, 0.06, 0, 1, 1, @CONDITION),
(7447, 20400, 0.062, 0, 1, 1, @CONDITION),
(7448, 20400, 0.04, 0, 1, 1, @CONDITION),
(7449, 20400, 0.06, 0, 1, 1, @CONDITION),
(7450, 20400, 0.04, 0, 1, 1, @CONDITION),
(7451, 20400, 0.08, 0, 1, 1, @CONDITION),
(7452, 20400, 0.08, 0, 1, 1, @CONDITION),
(7453, 20400, 0.06, 0, 1, 1, @CONDITION),
(7454, 20400, 0.04, 0, 1, 1, @CONDITION),
(7455, 20400, 0.02, 0, 1, 1, @CONDITION),
(7456, 20400, 0.12, 0, 1, 1, @CONDITION),
(7457, 20400, 0.04, 0, 1, 1, @CONDITION),
(7458, 20400, 0.04, 0, 1, 1, @CONDITION),
(7459, 20400, 0.04, 0, 1, 1, @CONDITION),
(7460, 20400, 0.04, 0, 1, 1, @CONDITION),
(7461, 20400, 0.26, 0, 1, 1, @CONDITION),
(7462, 20400, 0.26, 0, 1, 1, @CONDITION),
(7463, 20400, 0.24, 0, 1, 1, @CONDITION),
(7523, 20400, 0.06, 0, 1, 1, @CONDITION),
(7524, 20400, 0.04, 0, 1, 1, @CONDITION),
(7664, 20400, 0.1, 0, 1, 1, @CONDITION),
(7665, 20400, 0.16, 0, 1, 1, @CONDITION),
(7668, 20400, 0.034, 0, 1, 1, @CONDITION),
(7669, 20400, 0.02, 0, 1, 1, @CONDITION),
(7670, 20400, 0.04, 0, 1, 1, @CONDITION),
(7671, 20400, 0.14, 0, 1, 1, @CONDITION),
(7728, 20400, 0.1, 0, 1, 1, @CONDITION),
(7734, 20400, 0.96, 0, 1, 1, @CONDITION),
(7735, 20400, 1.56, 0, 1, 1, @CONDITION),
(7846, 20400, 0.14, 0, 1, 1, @CONDITION),
(7885, 20400, 0.06, 0, 1, 1, @CONDITION),
(7886, 20400, 0.02, 0, 1, 1, @CONDITION),
(7995, 20400, 0.08, 0, 1, 1, @CONDITION),
(7996, 20400, 0.06, 0, 1, 1, @CONDITION),
(8198, 20400, 0.02, 0, 1, 1, @CONDITION),
(8213, 20400, 0.76, 0, 1, 1, @CONDITION),
(8217, 20400, 0.14, 0, 1, 1, @CONDITION),
(8282, 20400, 0.46, 0, 1, 1, @CONDITION),
(8298, 20400, 0.48, 0, 1, 1, @CONDITION),
(8300, 20400, 0.3, 0, 1, 1, @CONDITION),
(8391, 20400, 0.1, 0, 1, 1, @CONDITION),
(8408, 20400, 0.08, 0, 1, 1, @CONDITION),
(8419, 20400, 0.06, 0, 1, 1, @CONDITION),
(8519, 20400, 0.1, 0, 1, 1, @CONDITION),
(8520, 20400, 0.08, 0, 1, 1, @CONDITION),
(8521, 20400, 0.08, 0, 1, 1, @CONDITION),
(8522, 20400, 0.06, 0, 1, 1, @CONDITION),
(8523, 20400, 0.053, 0, 1, 1, @CONDITION),
(8524, 20400, 0.1, 0, 1, 1, @CONDITION),
(8525, 20400, 0.06, 0, 1, 1, @CONDITION),
(8526, 20400, 0.08, 0, 1, 1, @CONDITION),
(8527, 20400, 0.04, 0, 1, 1, @CONDITION),
(8528, 20400, 0.06, 0, 1, 1, @CONDITION),
(8529, 20400, 0.06, 0, 1, 1, @CONDITION),
(8530, 20400, 0.06, 0, 1, 1, @CONDITION),
(8531, 20400, 0.04, 0, 1, 1, @CONDITION),
(8532, 20400, 0.06, 0, 1, 1, @CONDITION),
(8534, 20400, 0.08, 0, 1, 1, @CONDITION),
(8535, 20400, 0.08, 0, 1, 1, @CONDITION),
(8538, 20400, 0.02, 0, 1, 1, @CONDITION),
(8539, 20400, 0.06, 0, 1, 1, @CONDITION),
(8540, 20400, 0.04, 0, 1, 1, @CONDITION),
(8541, 20400, 0.06, 0, 1, 1, @CONDITION),
(8542, 20400, 0.06, 0, 1, 1, @CONDITION),
(8543, 20400, 0.04, 0, 1, 1, @CONDITION),
(8544, 20400, 0.08, 0, 1, 1, @CONDITION),
(8545, 20400, 0.08, 0, 1, 1, @CONDITION),
(8546, 20400, 0.04, 0, 1, 1, @CONDITION),
(8547, 20400, 0.14, 0, 1, 1, @CONDITION),
(8548, 20400, 0.1, 0, 1, 1, @CONDITION),
(8550, 20400, 0.06, 0, 1, 1, @CONDITION),
(8551, 20400, 0.06, 0, 1, 1, @CONDITION),
(8553, 20400, 0.06, 0, 1, 1, @CONDITION),
(8555, 20400, 0.06, 0, 1, 1, @CONDITION),
(8556, 20400, 0.02, 0, 1, 1, @CONDITION),
(8557, 20400, 0.06, 0, 1, 1, @CONDITION),
(8558, 20400, 0.08, 0, 1, 1, @CONDITION),
(8560, 20400, 0.06, 0, 1, 1, @CONDITION),
(8561, 20400, 0.08, 0, 1, 1, @CONDITION),
(8562, 20400, 0.06, 0, 1, 1, @CONDITION),
(8563, 20400, 0.04, 0, 1, 1, @CONDITION),
(8564, 20400, 0.06, 0, 1, 1, @CONDITION),
(8565, 20400, 0.02, 0, 1, 1, @CONDITION),
(8596, 20400, 0.06, 0, 1, 1, @CONDITION),
(8597, 20400, 0.06, 0, 1, 1, @CONDITION),
(8598, 20400, 0.04, 0, 1, 1, @CONDITION),
(8600, 20400, 0.06, 0, 1, 1, @CONDITION),
(8601, 20400, 0.08, 0, 1, 1, @CONDITION),
(8602, 20400, 0.06, 0, 1, 1, @CONDITION),
(8603, 20400, 0.06, 0, 1, 1, @CONDITION),
(8605, 20400, 0.08, 0, 1, 1, @CONDITION),
(8606, 20400, 0.02, 0, 1, 1, @CONDITION),
(8607, 20400, 0.02, 0, 1, 1, @CONDITION),
(8675, 20400, 0.04, 0, 1, 1, @CONDITION),
(8718, 20400, 0.08, 0, 1, 1, @CONDITION),
(8761, 20400, 0.04, 0, 1, 1, @CONDITION),
(8764, 20400, 0.04, 0, 1, 1, @CONDITION),
(8766, 20400, 0.04, 0, 1, 1, @CONDITION),
(8891, 20400, 0.14, 0, 1, 1, @CONDITION),
(8892, 20400, 0.28, 0, 1, 1, @CONDITION),
(8893, 20400, 0.22, 0, 1, 1, @CONDITION),
(8894, 20400, 0.2, 0, 1, 1, @CONDITION),
(8895, 20400, 0.22, 0, 1, 1, @CONDITION),
(8896, 20400, 0.034, 0, 1, 1, @CONDITION),
(8897, 20400, 0.1, 0, 1, 1, @CONDITION),
(8898, 20400, 0.26, 0, 1, 1, @CONDITION),
(8899, 20400, 0.22, 0, 1, 1, @CONDITION),
(8900, 20400, 0.08, 0, 1, 1, @CONDITION),
(8902, 20400, 0.08, 0, 1, 1, @CONDITION),
(8903, 20400, 0.2, 0, 1, 1, @CONDITION),
(8904, 20400, 0.1, 0, 1, 1, @CONDITION),
(8905, 20400, 0.2, 0, 1, 1, @CONDITION),
(8906, 20400, 0.26, 0, 1, 1, @CONDITION),
(8907, 20400, 0.26, 0, 1, 1, @CONDITION),
(8908, 20400, 0.18, 0, 1, 1, @CONDITION),
(8909, 20400, 0.16, 0, 1, 1, @CONDITION),
(8910, 20400, 0.28, 0, 1, 1, @CONDITION),
(8911, 20400, 0.24, 0, 1, 1, @CONDITION),
(8912, 20400, 0.14, 0, 1, 1, @CONDITION),
(8913, 20400, 0.08, 0, 1, 1, @CONDITION),
(8914, 20400, 0.28, 0, 1, 1, @CONDITION),
(8915, 20400, 0.14, 0, 1, 1, @CONDITION),
(8916, 20400, 0.1, 0, 1, 1, @CONDITION),
(8920, 20400, 0.046, 0, 1, 1, @CONDITION),
(8922, 20400, 0.08, 0, 1, 1, @CONDITION),
(8925, 20400, 0.08, 0, 1, 1, @CONDITION),
(8927, 20400, 0.06, 0, 1, 1, @CONDITION),
(8932, 20400, 0.08, 0, 1, 1, @CONDITION),
(8957, 20400, 0.06, 0, 1, 1, @CONDITION),
(8961, 20400, 0.06, 0, 1, 1, @CONDITION),
(8977, 20400, 0.02, 0, 1, 1, @CONDITION),
(8978, 20400, 0.48, 0, 1, 1, @CONDITION),
(9026, 20400, 0.24, 0, 1, 1, @CONDITION),
(9043, 20400, 0.4, 0, 1, 1, @CONDITION),
(9044, 20400, 0.3, 0, 1, 1, @CONDITION),
(9045, 20400, 0.42, 0, 1, 1, @CONDITION),
(9096, 20400, 0.32, 0, 1, 1, @CONDITION),
(9097, 20400, 0.32, 0, 1, 1, @CONDITION),
(9098, 20400, 0.32, 0, 1, 1, @CONDITION),
(9163, 20400, 0.04, 0, 1, 1, @CONDITION),
(9164, 20400, 0.034, 0, 1, 1, @CONDITION),
(9166, 20400, 0.04, 0, 1, 1, @CONDITION),
(9167, 20400, 0.06, 0, 1, 1, @CONDITION),
(9176, 20400, 0.034, 0, 1, 1, @CONDITION),
(9197, 20400, 0.3, 0, 1, 1, @CONDITION),
(9198, 20400, 0.44, 0, 1, 1, @CONDITION),
(9199, 20400, 0.32, 0, 1, 1, @CONDITION),
(9200, 20400, 0.36, 0, 1, 1, @CONDITION),
(9201, 20400, 0.36, 0, 1, 1, @CONDITION),
(9216, 20400, 0.38, 0, 1, 1, @CONDITION),
(9239, 20400, 0.32, 0, 1, 1, @CONDITION),
(9240, 20400, 0.36, 0, 1, 1, @CONDITION),
(9241, 20400, 0.28, 0, 1, 1, @CONDITION),
(9257, 20400, 0.3, 0, 1, 1, @CONDITION),
(9258, 20400, 0.32, 0, 1, 1, @CONDITION),
(9259, 20400, 0.4, 0, 1, 1, @CONDITION),
(9260, 20400, 0.18, 0, 1, 1, @CONDITION),
(9261, 20400, 0.38, 0, 1, 1, @CONDITION),
(9262, 20400, 0.34, 0, 1, 1, @CONDITION),
(9263, 20400, 0.26, 0, 1, 1, @CONDITION),
(9264, 20400, 0.42, 0, 1, 1, @CONDITION),
(9265, 20400, 0.3, 0, 1, 1, @CONDITION),
(9266, 20400, 0.4, 0, 1, 1, @CONDITION),
(9267, 20400, 0.24, 0, 1, 1, @CONDITION),
(9268, 20400, 0.3, 0, 1, 1, @CONDITION),
(9269, 20400, 0.44, 0, 1, 1, @CONDITION),
(9376, 20400, 0.06, 0, 1, 1, @CONDITION),
(9398, 20400, 0.07, 0, 1, 1, @CONDITION),
(9416, 20400, 0.06, 0, 1, 1, @CONDITION),
(9438, 20400, 0.18, 0, 1, 1, @CONDITION),
(9439, 20400, 0.54, 0, 1, 1, @CONDITION),
(9441, 20400, 0.18, 0, 1, 1, @CONDITION),
(9442, 20400, 0.34, 0, 1, 1, @CONDITION),
(9443, 20400, 0.48, 0, 1, 1, @CONDITION),
(9445, 20400, 0.18, 0, 1, 1, @CONDITION),
(9447, 20400, 0.2, 0, 1, 1, @CONDITION),
(9448, 20400, 0.2, 0, 1, 1, @CONDITION),
(9449, 20400, 0.2, 0, 1, 1, @CONDITION),
(9450, 20400, 0.14, 0, 1, 1, @CONDITION),
(9451, 20400, 0.24, 0, 1, 1, @CONDITION),
(9452, 20400, 0.24, 0, 1, 1, @CONDITION),
(9454, 20400, 0.04, 0, 1, 1, @CONDITION),
(9462, 20400, 0.03, 0, 1, 1, @CONDITION),
(9464, 20400, 0.1, 0, 1, 1, @CONDITION),
(9476, 20400, 0.33, 0, 1, 1, @CONDITION),
(9477, 20400, 0.04, 0, 1, 1, @CONDITION),
(9516, 20400, 0.14, 0, 1, 1, @CONDITION),
(9517, 20400, 0.04, 0, 1, 1, @CONDITION),
(9518, 20400, 0.14, 0, 1, 1, @CONDITION),
(9522, 20400, 0.36, 0, 1, 1, @CONDITION),
(9541, 20400, 0.2, 0, 1, 1, @CONDITION),
(9545, 20400, 0.02, 0, 1, 1, @CONDITION),
(9547, 20400, 0.02, 0, 1, 1, @CONDITION),
(9554, 20400, 0.2, 0, 1, 1, @CONDITION),
(9583, 20400, 0.3, 0, 1, 1, @CONDITION),
(9622, 20400, 0.08, 0, 1, 1, @CONDITION),
(9677, 20400, 0.54, 0, 1, 1, @CONDITION),
(9678, 20400, 0.46, 0, 1, 1, @CONDITION),
(9680, 20400, 0.16, 0, 1, 1, @CONDITION),
(9681, 20400, 0.1, 0, 1, 1, @CONDITION),
(9690, 20400, 0.04, 0, 1, 1, @CONDITION),
(9691, 20400, 0.025, 0, 1, 1, @CONDITION),
(9692, 20400, 0.52, 0, 1, 1, @CONDITION),
(9693, 20400, 0.4, 0, 1, 1, @CONDITION),
(9694, 20400, 0.06, 0, 1, 1, @CONDITION),
(9695, 20400, 0.06, 0, 1, 1, @CONDITION),
(9696, 20400, 0.06, 0, 1, 1, @CONDITION),
(9697, 20400, 0.03, 0, 1, 1, @CONDITION),
(9698, 20400, 0.04, 0, 1, 1, @CONDITION),
(9701, 20400, 0.08, 0, 1, 1, @CONDITION),
(9716, 20400, 0.32, 0, 1, 1, @CONDITION),
(9717, 20400, 0.3, 0, 1, 1, @CONDITION),
(9817, 20400, 0.56, 0, 1, 1, @CONDITION),
(9818, 20400, 0.54, 0, 1, 1, @CONDITION),
(9819, 20400, 0.54, 0, 1, 1, @CONDITION),
(9860, 20400, 0.06, 0, 1, 1, @CONDITION),
(9861, 20400, 0.16, 0, 1, 1, @CONDITION),
(9862, 20400, 0.08, 0, 1, 1, @CONDITION),
(9878, 20400, 0.06, 0, 1, 1, @CONDITION),
(9879, 20400, 0.055, 0, 1, 1, @CONDITION),
(9956, 20400, 0.08, 0, 1, 1, @CONDITION),
(10040, 20400, 0.04, 0, 1, 1, @CONDITION),
(10043, 20400, 0.02, 0, 1, 1, @CONDITION),
(10077, 20400, 0.36, 0, 1, 1, @CONDITION),
(10083, 20400, 0.3, 0, 1, 1, @CONDITION),
(10119, 20400, 0.14, 0, 1, 1, @CONDITION),
(10177, 20400, 0.16, 0, 1, 1, @CONDITION),
(10196, 20400, 0.22, 0, 1, 1, @CONDITION),
(10197, 20400, 0.14, 0, 1, 1, @CONDITION),
(10221, 20400, 0.08, 0, 1, 1, @CONDITION),
(10258, 20400, 0.2, 0, 1, 1, @CONDITION),
(10316, 20400, 0.18, 0, 1, 1, @CONDITION),
(10317, 20400, 0.22, 0, 1, 1, @CONDITION),
(10318, 20400, 0.26, 0, 1, 1, @CONDITION),
(10319, 20400, 0.24, 0, 1, 1, @CONDITION),
(10366, 20400, 0.14, 0, 1, 1, @CONDITION),
(10372, 20400, 0.12, 0, 1, 1, @CONDITION),
(10374, 20400, 0.22, 0, 1, 1, @CONDITION),
(10375, 20400, 0.08, 0, 1, 1, @CONDITION),
(10381, 20400, 0.32, 0, 1, 1, @CONDITION),
(10382, 20400, 0.28, 0, 1, 1, @CONDITION),
(10384, 20400, 0.38, 0, 1, 1, @CONDITION),
(10385, 20400, 0.12, 0, 1, 1, @CONDITION),
(10388, 20400, 7.14, 0, 1, 1, @CONDITION),
(10390, 20400, 0.3, 0, 1, 1, @CONDITION),
(10391, 20400, 0.155, 0, 1, 1, @CONDITION),
(10394, 20400, 0.26, 0, 1, 1, @CONDITION),
(10398, 20400, 0.32, 0, 1, 1, @CONDITION),
(10399, 20400, 0.46, 0, 1, 1, @CONDITION),
(10400, 20400, 0.16, 0, 1, 1, @CONDITION),
(10405, 20400, 0.3, 0, 1, 1, @CONDITION),
(10406, 20400, 0.3, 0, 1, 1, @CONDITION),
(10407, 20400, 0.28, 0, 1, 1, @CONDITION),
(10408, 20400, 0.36, 0, 1, 1, @CONDITION),
(10409, 20400, 0.36, 0, 1, 1, @CONDITION),
(10411, 20400, 0.12, 0, 1, 1, @CONDITION),
(10412, 20400, 0.28, 0, 1, 1, @CONDITION),
(10413, 20400, 0.36, 0, 1, 1, @CONDITION),
(10414, 20400, 0.18, 0, 1, 1, @CONDITION),
(10416, 20400, 0.3, 0, 1, 1, @CONDITION),
(10417, 20400, 0.14, 0, 1, 1, @CONDITION),
(10418, 20400, 0.34, 0, 1, 1, @CONDITION),
(10419, 20400, 0.28, 0, 1, 1, @CONDITION),
(10420, 20400, 0.34, 0, 1, 1, @CONDITION),
(10421, 20400, 0.3, 0, 1, 1, @CONDITION),
(10422, 20400, 0.24, 0, 1, 1, @CONDITION),
(10423, 20400, 0.34, 0, 1, 1, @CONDITION),
(10424, 20400, 0.36, 0, 1, 1, @CONDITION),
(10425, 20400, 0.28, 0, 1, 1, @CONDITION),
(10426, 20400, 0.28, 0, 1, 1, @CONDITION),
(10442, 20400, 0.1, 0, 1, 1, @CONDITION),
(10447, 20400, 0.24, 0, 1, 1, @CONDITION),
(10463, 20400, 0.32, 0, 1, 1, @CONDITION),
(10464, 20400, 0.34, 0, 1, 1, @CONDITION),
(10469, 20400, 0.34, 0, 1, 1, @CONDITION),
(10470, 20400, 0.36, 0, 1, 1, @CONDITION),
(10471, 20400, 0.108, 0, 1, 1, @CONDITION),
(10476, 20400, 0.146, 0, 1, 1, @CONDITION),
(10477, 20400, 0.26, 0, 1, 1, @CONDITION),
(10478, 20400, 0.32, 0, 1, 1, @CONDITION),
(10480, 20400, 0.08, 0, 1, 1, @CONDITION),
(10481, 20400, 0.06, 0, 1, 1, @CONDITION),
(10485, 20400, 0.12, 0, 1, 1, @CONDITION),
(10486, 20400, 0.26, 0, 1, 1, @CONDITION),
(10487, 20400, 0.34, 0, 1, 1, @CONDITION),
(10488, 20400, 0.28, 0, 1, 1, @CONDITION),
(10489, 20400, 0.3, 0, 1, 1, @CONDITION),
(10491, 20400, 0.26, 0, 1, 1, @CONDITION),
(10495, 20400, 0.113, 0, 1, 1, @CONDITION),
(10498, 20400, 0.28, 0, 1, 1, @CONDITION),
(10499, 20400, 0.3, 0, 1, 1, @CONDITION),
(10500, 20400, 0.14, 0, 1, 1, @CONDITION),
(10580, 20400, 0.06, 0, 1, 1, @CONDITION),
(10605, 20400, 0.04, 0, 1, 1, @CONDITION),
(10608, 20400, 0.16, 0, 1, 1, @CONDITION),
(10648, 20400, 0.08, 0, 1, 1, @CONDITION),
(10659, 20400, 0.06, 0, 1, 1, @CONDITION),
(10660, 20400, 0.04, 0, 1, 1, @CONDITION),
(10661, 20400, 0.08, 0, 1, 1, @CONDITION),
(10662, 20400, 0.66, 0, 1, 1, @CONDITION),
(10663, 20400, 0.08, 0, 1, 1, @CONDITION),
(10664, 20400, 0.06, 0, 1, 1, @CONDITION),
(10678, 20400, 0.08, 0, 1, 1, @CONDITION),
(10680, 20400, 0.48, 0, 1, 1, @CONDITION),
(10681, 20400, 0.64, 0, 1, 1, @CONDITION),
(10683, 20400, 0.16, 0, 1, 1, @CONDITION),
(10717, 20400, 0.1, 0, 1, 1, @CONDITION),
(10737, 20400, 0.28, 0, 1, 1, @CONDITION),
(10738, 20400, 0.2, 0, 1, 1, @CONDITION),
(10742, 20400, 0.46, 0, 1, 1, @CONDITION),
(10762, 20400, 0.46, 0, 1, 1, @CONDITION),
(10801, 20400, 0.1, 0, 1, 1, @CONDITION),
(10802, 20400, 0.1, 0, 1, 1, @CONDITION),
(10806, 20400, 0.1, 0, 1, 1, @CONDITION),
(10807, 20400, 0.12, 0, 1, 1, @CONDITION),
(10814, 20400, 0.2, 0, 1, 1, @CONDITION),
(10816, 20400, 0.12, 0, 1, 1, @CONDITION),
(10916, 20400, 0.08, 0, 1, 1, @CONDITION),
(10919, 20400, 0.04, 0, 1, 1, @CONDITION),
(10946, 20400, 0.36, 0, 1, 1, @CONDITION),
(10981, 20400, 0.02, 0, 1, 1, @CONDITION),
(10982, 20400, 0.06, 0, 1, 1, @CONDITION),
(10983, 20400, 0.14, 0, 1, 1, @CONDITION),
(10986, 20400, 0.08, 0, 1, 1, @CONDITION),
(10987, 20400, 0.18, 0, 1, 1, @CONDITION),
(10990, 20400, 0.02, 0, 1, 1, @CONDITION),
(10991, 20400, 0.08, 0, 1, 1, @CONDITION),
(10996, 20400, 0.06, 0, 1, 1, @CONDITION),
(11032, 20400, 0.44, 0, 1, 1, @CONDITION),
(11043, 20400, 0.137, 0, 1, 1, @CONDITION),
(11257, 20400, 0.44, 0, 1, 1, @CONDITION),
(11284, 20400, 0.24, 0, 1, 1, @CONDITION),
(11290, 20400, 0.1, 0, 1, 1, @CONDITION),
(11291, 20400, 0.06, 0, 1, 1, @CONDITION),
(11346, 20400, 0.3, 0, 1, 1, @CONDITION),
(11350, 20400, 0.36, 0, 1, 1, @CONDITION),
(11351, 20400, 0.36, 0, 1, 1, @CONDITION),
(11353, 20400, 0.26, 0, 1, 1, @CONDITION),
(11355, 20400, 0.14, 0, 1, 1, @CONDITION),
(11357, 20400, 0.22, 0, 1, 1, @CONDITION),
(11360, 20400, 0.18, 0, 1, 1, @CONDITION),
(11361, 20400, 0.24, 0, 1, 1, @CONDITION),
(11365, 20400, 0.168, 0, 1, 1, @CONDITION),
(11368, 20400, 0.12, 0, 1, 1, @CONDITION),
(11370, 20400, 0.02, 0, 1, 1, @CONDITION),
(11371, 20400, 0.34, 0, 1, 1, @CONDITION),
(11372, 20400, 0.38, 0, 1, 1, @CONDITION),
(11440, 20400, 0.22, 0, 1, 1, @CONDITION),
(11441, 20400, 0.32, 0, 1, 1, @CONDITION),
(11442, 20400, 0.24, 0, 1, 1, @CONDITION),
(11443, 20400, 0.24, 0, 1, 1, @CONDITION),
(11444, 20400, 0.3, 0, 1, 1, @CONDITION),
(11445, 20400, 0.36, 0, 1, 1, @CONDITION),
(11448, 20400, 0.34, 0, 1, 1, @CONDITION),
(11450, 20400, 0.32, 0, 1, 1, @CONDITION),
(11451, 20400, 0.24, 0, 1, 1, @CONDITION),
(11452, 20400, 0.12, 0, 1, 1, @CONDITION),
(11453, 20400, 0.2, 0, 1, 1, @CONDITION),
(11454, 20400, 0.34, 0, 1, 1, @CONDITION),
(11455, 20400, 0.28, 0, 1, 1, @CONDITION),
(11456, 20400, 0.26, 0, 1, 1, @CONDITION),
(11457, 20400, 0.18, 0, 1, 1, @CONDITION),
(11458, 20400, 0.36, 0, 1, 1, @CONDITION),
(11459, 20400, 0.34, 0, 1, 1, @CONDITION),
(11461, 20400, 0.62, 0, 1, 1, @CONDITION),
(11462, 20400, 0.38, 0, 1, 1, @CONDITION),
(11464, 20400, 0.3, 0, 1, 1, @CONDITION),
(11465, 20400, 0.16, 0, 1, 1, @CONDITION),
(11469, 20400, 0.46, 0, 1, 1, @CONDITION),
(11470, 20400, 0.24, 0, 1, 1, @CONDITION),
(11471, 20400, 0.32, 0, 1, 1, @CONDITION),
(11472, 20400, 0.36, 0, 1, 1, @CONDITION),
(11473, 20400, 0.32, 0, 1, 1, @CONDITION),
(11475, 20400, 0.32, 0, 1, 1, @CONDITION),
(11476, 20400, 0.16, 0, 1, 1, @CONDITION),
(11477, 20400, 0.12, 0, 1, 1, @CONDITION),
(11480, 20400, 0.36, 0, 1, 1, @CONDITION),
(11483, 20400, 0.38, 0, 1, 1, @CONDITION),
(11484, 20400, 0.4, 0, 1, 1, @CONDITION),
(11516, 20400, 0.06, 0, 1, 1, @CONDITION),
(11551, 20400, 0.28, 0, 1, 1, @CONDITION),
(11553, 20400, 0.1, 0, 1, 1, @CONDITION),
(11582, 20400, 0.26, 0, 1, 1, @CONDITION),
(11598, 20400, 0.2, 0, 1, 1, @CONDITION),
(11600, 20400, 0.14, 0, 1, 1, @CONDITION),
(11602, 20400, 0.08, 0, 1, 1, @CONDITION),
(11603, 20400, 0.2, 0, 1, 1, @CONDITION),
(11604, 20400, 0.2, 0, 1, 1, @CONDITION),
(11605, 20400, 0.1, 0, 1, 1, @CONDITION),
(11611, 20400, 0.056, 0, 1, 1, @CONDITION),
(11613, 20400, 0.06, 0, 1, 1, @CONDITION),
(11657, 20400, 0.58, 0, 1, 1, @CONDITION),
(11663, 20400, 0.14, 0, 1, 1, @CONDITION),
(11675, 20400, 0.02, 0, 1, 1, @CONDITION),
(11678, 20400, 0.04, 0, 1, 1, @CONDITION),
(11679, 20400, 0.6, 0, 1, 1, @CONDITION),
(11698, 20400, 0.14, 0, 1, 1, @CONDITION),
(11721, 20400, 0.12, 0, 1, 1, @CONDITION),
(11722, 20400, 0.14, 0, 1, 1, @CONDITION),
(11723, 20400, 0.14, 0, 1, 1, @CONDITION),
(11724, 20400, 0.2, 0, 1, 1, @CONDITION),
(11725, 20400, 0.12, 0, 1, 1, @CONDITION),
(11726, 20400, 0.22, 0, 1, 1, @CONDITION),
(11727, 20400, 0.06, 0, 1, 1, @CONDITION),
(11728, 20400, 0.2, 0, 1, 1, @CONDITION),
(11729, 20400, 0.14, 0, 1, 1, @CONDITION),
(11730, 20400, 0.18, 0, 1, 1, @CONDITION),
(11731, 20400, 0.1, 0, 1, 1, @CONDITION),
(11732, 20400, 0.14, 0, 1, 1, @CONDITION),
(11733, 20400, 0.16, 0, 1, 1, @CONDITION),
(11734, 20400, 0.04, 0, 1, 1, @CONDITION),
(11735, 20400, 0.06, 0, 1, 1, @CONDITION),
(11736, 20400, 0.06, 0, 1, 1, @CONDITION),
(11737, 20400, 0.06, 0, 1, 1, @CONDITION),
(11738, 20400, 0.04, 0, 1, 1, @CONDITION),
(11739, 20400, 0.04, 0, 1, 1, @CONDITION),
(11740, 20400, 0.06, 0, 1, 1, @CONDITION),
(11741, 20400, 0.06, 0, 1, 1, @CONDITION),
(11744, 20400, 0.14, 0, 1, 1, @CONDITION),
(11745, 20400, 0.08, 0, 1, 1, @CONDITION),
(11746, 20400, 0.06, 0, 1, 1, @CONDITION),
(11747, 20400, 0.08, 0, 1, 1, @CONDITION),
(11830, 20400, 0.46, 0, 1, 1, @CONDITION),
(11831, 20400, 0.26, 0, 1, 1, @CONDITION),
(11837, 20400, 0.02, 0, 1, 1, @CONDITION),
(11838, 20400, 0.06, 0, 1, 1, @CONDITION),
(11839, 20400, 0.06, 0, 1, 1, @CONDITION),
(11840, 20400, 0.12, 0, 1, 1, @CONDITION),
(11873, 20400, 0.04, 0, 1, 1, @CONDITION),
(11880, 20400, 0.06, 0, 1, 1, @CONDITION),
(11881, 20400, 0.08, 0, 1, 1, @CONDITION),
(11882, 20400, 0.08, 0, 1, 1, @CONDITION),
(11883, 20400, 0.06, 0, 1, 1, @CONDITION),
(11885, 20400, 0.08, 0, 1, 1, @CONDITION),
(11887, 20400, 0.18, 0, 1, 1, @CONDITION),
(11898, 20400, 0.14, 0, 1, 1, @CONDITION),
(12047, 20400, 0.06, 0, 1, 1, @CONDITION),
(12048, 20400, 0.08, 0, 1, 1, @CONDITION),
(12050, 20400, 0.04, 0, 1, 1, @CONDITION),
(12051, 20400, 0.04, 0, 1, 1, @CONDITION),
(12052, 20400, 0.14, 0, 1, 1, @CONDITION),
(12053, 20400, 0.12, 0, 1, 1, @CONDITION),
(12121, 20400, 0.02, 0, 1, 1, @CONDITION),
(12122, 20400, 0.16, 0, 1, 1, @CONDITION),
(12127, 20400, 0.08, 0, 1, 1, @CONDITION),
(12128, 20400, 0.46, 0, 1, 1, @CONDITION),
(12129, 20400, 0.06, 0, 1, 1, @CONDITION),
(12157, 20400, 0.66, 0, 1, 1, @CONDITION),
(12158, 20400, 0.56, 0, 1, 1, @CONDITION),
(12178, 20400, 0.04, 0, 1, 1, @CONDITION),
(12179, 20400, 0.028, 0, 1, 1, @CONDITION),
(12250, 20400, 0.12, 0, 1, 1, @CONDITION),
(12262, 20400, 0.16, 0, 1, 1, @CONDITION),
(12377, 20400, 0.04, 0, 1, 1, @CONDITION),
(12378, 20400, 0.06, 0, 1, 1, @CONDITION),
(12379, 20400, 0.06, 0, 1, 1, @CONDITION),
(12380, 20400, 0.06, 0, 1, 1, @CONDITION),
(12387, 20400, 0.14, 0, 1, 1, @CONDITION),
(12418, 20400, 0.06, 0, 1, 1, @CONDITION),
(12475, 20400, 0.15, 0, 1, 1, @CONDITION),
(12800, 20400, 0.54, 0, 1, 1, @CONDITION),
(13021, 20400, 0.32, 0, 1, 1, @CONDITION),
(13022, 20400, 0.16, 0, 1, 1, @CONDITION),
(13036, 20400, 0.12, 0, 1, 1, @CONDITION),
(13089, 20400, 1.8, 0, 1, 1, @CONDITION),
(13136, 20400, 0.04, 0, 1, 1, @CONDITION),
(13137, 20400, 0.08, 0, 1, 1, @CONDITION),
(13143, 20400, 0.58, 0, 1, 1, @CONDITION),
(13145, 20400, 0.04, 0, 1, 1, @CONDITION),
(13146, 20400, 0.03, 0, 1, 1, @CONDITION),
(13147, 20400, 0.12, 0, 1, 1, @CONDITION),
(13155, 20400, 0.36, 0, 1, 1, @CONDITION),
(13160, 20400, 0.18, 0, 1, 1, @CONDITION),
(13176, 20400, 0.16, 0, 1, 1, @CONDITION),
(13179, 20400, 0.08, 0, 1, 1, @CONDITION),
(13180, 20400, 0.05, 0, 1, 1, @CONDITION),
(13181, 20400, 0.08, 0, 1, 1, @CONDITION),
(13196, 20400, 0.26, 0, 1, 1, @CONDITION),
(13197, 20400, 0.28, 0, 1, 1, @CONDITION),
(13276, 20400, 0.1, 0, 1, 1, @CONDITION),
(13279, 20400, 0.06, 0, 1, 1, @CONDITION),
(13284, 20400, 0.2, 0, 1, 1, @CONDITION),
(13285, 20400, 0.4, 0, 1, 1, @CONDITION),
(13296, 20400, 0.03, 0, 1, 1, @CONDITION),
(13297, 20400, 0.14, 0, 1, 1, @CONDITION),
(13299, 20400, 0.42, 0, 1, 1, @CONDITION),
(13300, 20400, 0.04, 0, 1, 1, @CONDITION),
(13301, 20400, 0.069, 0, 1, 1, @CONDITION),
(13316, 20400, 0.38, 0, 1, 1, @CONDITION),
(13324, 20400, 0.02, 0, 1, 1, @CONDITION),
(13326, 20400, 0.06, 0, 1, 1, @CONDITION),
(13327, 20400, 0.04, 0, 1, 1, @CONDITION),
(13328, 20400, 0.04, 0, 1, 1, @CONDITION),
(13329, 20400, 0.02, 0, 1, 1, @CONDITION),
(13330, 20400, 0.02, 0, 1, 1, @CONDITION),
(13332, 20400, 0.02, 0, 1, 1, @CONDITION),
(13333, 20400, 0.02, 0, 1, 1, @CONDITION),
(13334, 20400, 0.06, 0, 1, 1, @CONDITION),
(13335, 20400, 0.08, 0, 1, 1, @CONDITION),
(13336, 20400, 0.1, 0, 1, 1, @CONDITION),
(13358, 20400, 0.08, 0, 1, 1, @CONDITION),
(13359, 20400, 0.02, 0, 1, 1, @CONDITION),
(13396, 20400, 0.16, 0, 1, 1, @CONDITION),
(13397, 20400, 0.12, 0, 1, 1, @CONDITION),
(13424, 20400, 0.04, 0, 1, 1, @CONDITION),
(13425, 20400, 0.06, 0, 1, 1, @CONDITION),
(13426, 20400, 0.1, 0, 1, 1, @CONDITION),
(13427, 20400, 0.06, 0, 1, 1, @CONDITION),
(13428, 20400, 0.06, 0, 1, 1, @CONDITION),
(13437, 20400, 1, 0, 1, 1, @CONDITION),
(13440, 20400, 0.1, 0, 1, 1, @CONDITION),
(13442, 20400, 0.07, 0, 1, 1, @CONDITION),
(13443, 20400, 0.16, 0, 1, 1, @CONDITION),
(13448, 20400, 0.18, 0, 1, 1, @CONDITION),
(13526, 20400, 0.78, 0, 1, 1, @CONDITION),
(13530, 20400, 0.46, 0, 1, 1, @CONDITION),
(13539, 20400, 0.72, 0, 1, 1, @CONDITION),
(13551, 20400, 0.94, 0, 1, 1, @CONDITION),
(13576, 20400, 0.22, 0, 1, 1, @CONDITION),
(13797, 20400, 0.02, 0, 1, 1, @CONDITION),
(13798, 20400, 0.12, 0, 1, 1, @CONDITION),
(13957, 20400, 0.2, 0, 1, 1, @CONDITION),
(13996, 20400, 0.12, 0, 1, 1, @CONDITION),
(14282, 20400, 0.04, 0, 1, 1, @CONDITION),
(14283, 20400, 0.06, 0, 1, 1, @CONDITION),
(14303, 20400, 0.52, 0, 1, 1, @CONDITION),
(14351, 20400, 0.2, 0, 1, 1, @CONDITION),
(14370, 20400, 0.02, 0, 1, 1, @CONDITION),
(14398, 20400, 0.58, 0, 1, 1, @CONDITION),
(14399, 20400, 0.38, 0, 1, 1, @CONDITION),
(14400, 20400, 0.14, 0, 1, 1, @CONDITION),
(14455, 20400, 0.02, 0, 1, 1, @CONDITION),
(14458, 20400, 0.06, 0, 1, 1, @CONDITION),
(14460, 20400, 0.12, 0, 1, 1, @CONDITION),
(14462, 20400, 0.08, 0, 1, 1, @CONDITION),
(14523, 20400, 0.12, 0, 1, 1, @CONDITION),
(14532, 20400, 0.36, 0, 1, 1, @CONDITION),
(14564, 20400, 0.04, 0, 1, 1, @CONDITION),
(14821, 20400, 0.32, 0, 1, 1, @CONDITION),
(14825, 20400, 0.32, 0, 1, 1, @CONDITION),
(14880, 20400, 0.42, 0, 1, 1, @CONDITION),
(14882, 20400, 0.34, 0, 1, 1, @CONDITION),
(14883, 20400, 0.56, 0, 1, 1, @CONDITION),
(15043, 20400, 0.54, 0, 1, 1, @CONDITION),
(15201, 20400, 0.08, 0, 1, 1, @CONDITION),
(15209, 20400, 0.22, 0, 1, 1, @CONDITION),
(15211, 20400, 0.12, 0, 1, 1, @CONDITION),
(15212, 20400, 0.12, 0, 1, 1, @CONDITION),
(15213, 20400, 0.04, 0, 1, 1, @CONDITION),
(15307, 20400, 0.16, 0, 1, 1, @CONDITION),
(15541, 20400, 0.06, 0, 1, 1, @CONDITION),
(15756, 20400, 0.18, 0, 1, 1, @CONDITION),
(16022, 20400, 0.04, 0, 1, 1, @CONDITION);

DELETE FROM `reference_loot_template` WHERE `item` = 20400;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(5759, 20400, 5.9, 0, 1, 1, @CONDITION);

-- Provides db script for spell 24706 with SPELL_EFFECT_SEND_EVENT 9417
DELETE
FROM
	db_scripts
WHERE
	id = 9417;
INSERT INTO
	db_scripts(`script_type`, `id`, `command`, `datalong`, `datalong2`, `comments`)
VALUES
	(8, 9417, 8, 15415, 1, 'Quest 1657: credit for objective');

-- Provides event linking for emotes in quests 8358, 8360, 8353, 8354, 8355, 8356, 8359
UPDATE
	quest_template
SET
	ReqCreatureOrGoCount1 = 0
WHERE
	entry IN (
		8358,
		8360,
		8353,
		8354,
		8355,
		8356,
		8359
	);

-- Horde
-- Quest 8359: Innkeeper Gryshka /flex
DELETE
FROM
	creature_ai_scripts
WHERE
	creature_id = 6929;
INSERT INTO
	creature_ai_scripts(`id`, `creature_id`, `event_type`, `event_param1`, `action1_type`, `action1_param1`, `action1_param2`, `comment`)
VALUES
	(692901, 6929, 22, 41, 15, 8359, 6, 'Innkeeper Gryshka - Complete quest 8359 on /flex emote');
UPDATE
	creature_template
SET
	AIName = 'EventAI'
WHERE
	entry = 6929;

-- Quest 8354: Innkeeper Norman /chicken
DELETE
FROM
	creature_ai_scripts
WHERE
	creature_id = 6741;
INSERT INTO
	creature_ai_scripts(`id`, `creature_id`, `event_type`, `event_param1`, `action1_type`, `action1_param1`, `action1_param2`, `comment`)
VALUES
	(674101, 6741, 22, 22, 15, 8354, 6, 'Innkeeper Norman - Complete quest 8354 on /chicken emote');
UPDATE
	creature_template
SET
	AIName = 'EventAI'
WHERE
	entry = 6741;

-- Quest 8360: Innkeeper Pala /dance
DELETE
FROM
	creature_ai_scripts
WHERE
	creature_id = 6746;
INSERT INTO
	creature_ai_scripts(`id`, `creature_id`, `event_type`, `event_param1`, `action1_type`, `action1_param1`, `action1_param2`, `comment`)
VALUES
	(674601, 6746, 22, 34, 15, 8360, 6, 'Innkeeper Pala - Complete quest 8360 on /dance emote');
UPDATE
	creature_template
SET
	AIName = 'EventAI'
WHERE
	entry = 6746;

-- Quest 8358: Kali Remik /train
DELETE
FROM
	creature_ai_scripts
WHERE
	creature_id = 11814;
INSERT INTO
	creature_ai_scripts(`id`, `creature_id`, `event_type`, `event_param1`, `action1_type`, `action1_param1`, `action1_param2`, `comment`)
VALUES
	(1181401, 11814, 22, 264, 15, 8358, 6, 'Kali Remik - Complete quest 8358 on /train emote');
UPDATE
	creature_template
SET
	AIName = 'EventAI'
WHERE
	entry = 11814;

-- Alliance
-- Quest 8356: Innkeeper Allison /flex
DELETE
FROM
	creature_ai_scripts
WHERE
	creature_id = 6740;
INSERT INTO
	creature_ai_scripts(`id`, `creature_id`, `event_type`, `event_param1`, `action1_type`, `action1_param1`, `action1_param2`, `comment`)
VALUES
	(674001, 6740, 22, 41, 15, 8356, 6, 'Innkeeper Allison - Complete quest 8356 on /flex emote');
UPDATE
	creature_template
SET
	AIName = 'EventAI'
WHERE
	entry = 6740;

-- Quest 8353: Innkeeper Firebrew /chicken
DELETE
FROM
	creature_ai_scripts
WHERE
	creature_id = 5111;
INSERT INTO
	creature_ai_scripts(`id`, `creature_id`, `event_type`, `event_param1`, `action1_type`, `action1_param1`, `action1_param2`, `comment`)
VALUES
	(511101, 5111, 22, 22, 15, 8353, 6, 'Innkeeper Firebrew - Complete quest 8353 on /chicken emote');
UPDATE
	creature_template
SET
	AIName = 'EventAI'
WHERE
	entry = 5111;

-- Quest 8357: Innkeeper Saelienne /dance
DELETE
FROM
	creature_ai_scripts
WHERE
	creature_id = 6735;
INSERT INTO
	creature_ai_scripts(`id`, `creature_id`, `event_type`, `event_param1`, `action1_type`, `action1_param1`, `action1_param2`, `comment`)
VALUES
	(673501, 6735, 22, 34, 15, 8357, 6, 'Innkeeper Saelienne - Complete quest 8357 on /dance emote');
UPDATE
	creature_template
SET
	AIName = 'EventAI'
WHERE
	entry = 6735;

-- Quest 8355: Talvash del Kissel /train
DELETE
FROM
	creature_ai_scripts
WHERE
	creature_id = 6826;
INSERT INTO
	creature_ai_scripts(`id`, `creature_id`, `event_type`, `event_param1`, `action1_type`, `action1_param1`, `action1_param2`, `comment`)
VALUES
	(682601, 6826, 22, 264, 15, 8355, 6, 'Talvash del Kissel - Complete quest 8355 on /train emote');
UPDATE
	creature_template
SET
	AIName = 'EventAI'
WHERE
	entry = 6826;
  
  
  
  
  
  



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

SELECT * FROM db_version
