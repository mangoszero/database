-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
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
    SET @cOldStructure = '5'; 
    SET @cOldContent = '4'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '5';
    SET @cNewContent = '5';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'mass updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'mass updates and fixes';

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

-- Added support for Shadowforge Bridge event in BRD

DELETE FROM `creature_movement_template` WHERE `entry` = 8891;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(8891, 1, 685.89, -279.73, -43.1944, 0, 889101, 0, 0, 0, 0, 0, 0, 0, 0.471239, 0, 0),
(8891, 2, 685.89, -279.73, -43.1944, 10800000, 0, 0, 0, 0, 0, 0, 0, 0, 0.471239, 0, 0);

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 889101;
INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(889101, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'RUN OFF'),
(889101, 1, 25, 0, 0, 8891, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'RUN OFF'),
(889101, 2, 20, 1, 5, 8891, 40, 8, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(889101, 3, 20, 1, 5, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, '');
-- Tiragarde Keep -- Durotar
-- Lieutenant Benedict
UPDATE creature SET spawndist = 2, MovementType = 1 WHERE guid = 12375;
-- Kul Tiras Sailor
UPDATE creature SET position_x = -269.383301, position_y = -5102.149414, position_z = 25.244852, orientation = 0.509760, spawndist = 2, MovementType = 1 WHERE guid = 12390;
UPDATE creature SET position_x = -269.668579, position_y = -5126.734375, position_z = 24.341846, orientation = 1.491503 WHERE guid = 12362;
DELETE FROM creature WHERE guid = 87652; -- UDB free guid used
INSERT INTO creature (guid, id, map, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES
(87652,3128,1,0,0,-238.422,-5123.03,25.2439,2.17782,300,0,0,102,0,0,0);
-- Kul Tiras Marine
DELETE FROM creature WHERE guid IN (87646,87647); -- UDB free guid used
INSERT INTO creature (guid, id, map, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES
(87646,3129,1,0,0,-247.053,-5079.62,24.0052,1.40748,300,5,0,120,0,0,1),
(87647,3129,1,0,0,-246.869,-5099.97,23.7838,1.59755,300,2,0,137,0,0,1);
UPDATE creature SET position_x = -242.581970, position_y = -5112.193359, position_z = 25.243891, orientation = 3.825583, spawndist = 2, MovementType = 1 WHERE guid = 12366;
-- movement
UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid = 12998;
DELETE FROM creature_movement WHERE id = 12998;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(12998,1,-230.719,-5125.15,42.4774,0,0,4.84967,0,0),
(12998,2,-230.686,-5131.19,45.7119,0,0,4.94392,0,0),
(12998,3,-229.064,-5132.69,45.8029,0,0,0.112142,0,0),
(12998,4,-222.909,-5132.9,49.2699,0,0,0.129417,0,0),
(12998,5,-221.358,-5132.17,49.2699,0,0,1.26353,0,0),
(12998,6,-221.043,-5127.19,49.2699,0,0,1.92955,0,0),
(12998,7,-224.449,-5124.92,49.2699,0,0,1.96568,0,0),
(12998,8,-225.147,-5115.53,49.3237,0,0,1.59811,0,0),
(12998,9,-224.832,-5124.48,49.2703,0,0,5.66176,0,0),
(12998,10,-220.976,-5127.14,49.2703,0,0,4.73971,0,0),
(12998,11,-221.009,-5131.62,49.2703,0,0,4.01086,0,0),
(12998,12,-223.324,-5132.8,49.2703,0,0,3.09981,0,0),
(12998,13,-229.317,-5132.73,45.712,0,0,2.85241,0,0),
(12998,14,-230.802,-5130.94,45.712,0,0,1.62875,0,0),
(12998,15,-230.745,-5125.24,42.477,0,0,1.27454,0,0),
(12998,16,-229.071,-5123.85,42.477,0,0,0.0980134,0,0),
(12998,17,-221.9,-5124.38,38.2719,0,0,6.06076,0,0),
(12998,18,-220.41,-5126.12,38.2719,0,0,5.22509,0,0),
(12998,19,-220.741,-5128.71,38.2719,0,0,3.75012,0,0),
(12998,20,-224.215,-5129.94,38.2719,0,0,3.24432,0,0),
(12998,21,-231.927,-5129.92,34.0668,0,0,2.97807,0,0),
(12998,22,-233.333,-5128.56,34.0668,0,0,2.05209,0,0),
(12998,23,-232.741,-5126.2,34.0668,0,0,0.63366,0,0),
(12998,24,-229.79,-5125.62,34.0668,0,0,0.926575,0,0),
(12998,25,-228.711,-5122.72,34.0653,0,0,1.53919,0,0),
(12998,26,-228.582,-5108.82,34.0653,0,0,1.62637,0,0),
(12998,27,-228.8,-5098.57,41.3473,0,0,1.83214,0,0),
(12998,28,-231.072,-5095.27,41.3473,0,0,2.6788,0,0),
(12998,29,-235.625,-5093.99,41.3473,0,0,3.27335,0,0),
(12998,30,-252,-5094,41.3473,0,0,0.124686,0,0),
(12998,31,-232.244,-5094.07,41.3473,0,0,5.88636,0,0),
(12998,32,-228.875,-5098.53,41.3473,0,0,4.98001,0,0),
(12998,33,-228.729,-5108.67,34.0658,0,0,4.75033,0,0),
(12998,34,-229.067,-5111.95,34.0658,0,0,3.95159,0,0),
(12998,35,-234.399,-5112.87,34.0658,0,0,3.16069,0,0),
(12998,36,-252.847,-5113.07,34.0658,0,0,3.14106,0,0),
(12998,37,-231.446,-5112.98,34.0658,0,0,5.69596,0,0),
(12998,38,-228.84,-5117.89,34.0658,0,0,4.85323,0,0),
(12998,39,-228.85,-5124.55,34.0658,0,0,3.98065,0,0),
(12998,40,-231.059,-5125.75,34.0658,0,0,3.32014,0,0),
(12998,41,-233.287,-5126.61,34.0658,0,0,4.3977,0,0),
(12998,42,-233.166,-5129.52,34.0658,0,0,5.47134,0,0),
(12998,43,-231.672,-5129.95,34.0669,0,0,0.149476,0,0),
(12998,44,-224.454,-5129.98,38.2726,0,0,0.170682,0,0),
(12998,45,-221.865,-5129.24,38.2726,0,0,0.696113,0,0),
(12998,46,-220.17,-5126.07,38.2726,0,0,1.53649,0,0),
(12998,47,-221.888,-5124.38,38.2719,0,0,3.21017,0,0),
(12998,48,-229.382,-5123.85,42.4772,0,0,3.53454,0,0);
-- Journal of Jandice Barov
-- shouldnt be a static spawn
DELETE FROM gameobject WHERE id = 180794;
-- book must be droped by Jandice Barov on her death
DELETE FROM dbscripts_on_creature_death WHERE id = 10503;
INSERT INTO dbscripts_on_creature_death (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(10503, 1, 0, 0, 0, 0, 0, 0, 2000000612, 0, 0, 0, 0, 0, 0, 0, ''),
(10503, 1, 15, 26096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jandice Barov - Summon Journal of Jandice Barov on Death');
-- gossip
DELETE FROM gossip_menu WHERE entry = 6799;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(6799, 8120, 0, 0),
(6799, 8121, 0, 80),
(6799, 8122, 0, 81);
DELETE FROM gossip_menu_option WHERE menu_id = 6799;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(6799, 0, 0, ' Decipher the pattern and learn its content.', 1, 1, -1, 0, 6799, 0, 0, NULL, 80);
DELETE FROM dbscripts_on_gossip WHERE id = 6799;
INSERT INTO dbscripts_on_gossip (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(6799, 0, 15, 26095, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Learn Felcloth Bag');
DELETE FROM conditions WHERE condition_entry BETWEEN 77 AND 81;
INSERT INTO conditions (condition_entry, type, value1, value2) VALUES
(77, 7, 197, 280),
(78, 17, 26086, 1),
(79, 17, 26086, 0),
(80, -1, 77, 78),
(81, -1, 77, 79);
-- texts added
DELETE FROM db_script_string WHERE entry = 2000000612;
INSERT INTO db_script_string (entry, content_default, sound, type, language, emote, comment) VALUES
(2000000612,'%s loosens her grasp on the journal she had been clutching.',0,2,0,0,NULL);
DELETE FROM npc_text WHERE ID IN (8121,8122);
INSERT INTO npc_text (ID,text0_0,text0_1,lang0,prob0) VALUES
(8121,'The journal of Jandice Barov is filled with rantings and ravings about the undead. Towards the end of the book is what appears to be a tailoring pattern for the creation of a bag of some sort.','',0,1),
(8122,'UDB Missing text','',0,1);

-- The Prophet Skeram
UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='102.2', `MaxMeleeDmg`='135.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='27' WHERE `Entry`='15263';

-- Lord Kri
UPDATE `creature_template` SET `DamageMultiplier`='25', `MinMeleeDmg`='137.3', `MaxMeleeDmg`='182.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15511';
	-- Vem
	UPDATE `creature_template` SET `SpeedWalk`=('6' / '2.5'), `DamageMultiplier`='18', `MinMeleeDmg`='137.3', `MaxMeleeDmg`='182.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15544';
	-- Princess Yauj
	UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15543';
		-- Yauj Brood [NOBESTIARY][RECHECK]
		UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='2.5', `ArmorMultiplier`='1', `MinLevelHealth`='9156', `MaxLevelHealth`='9156', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15621';

-- Battleguard Sartura
UPDATE `creature_template` SET `PowerMultiplier`='150', `DamageMultiplier`='30', `MinMeleeDmg`='65.9', `MaxMeleeDmg`='87.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15516';
	-- Sartura's Royal Guard
	UPDATE `creature_template` SET `SpeedWalk`=('7' / '2.5'), `DamageMultiplier`='18', `MinMeleeDmg`='84.7', `MaxMeleeDmg`='112.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15984';

-- Fankriss
UPDATE `creature_template` SET `PowerMultiplier`='180', `DamageMultiplier`='20', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15510';
	-- Brood of Fankriss
	UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('12' / '7'), `PowerMultiplier`='50', `DamageMultiplier`='26', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15630';
	-- Vekniss Hatchling [NOBESTIARY]
	UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='9', `ArmorMultiplier`='1', `MinLevelHealth`='9156', `MaxLevelHealth`='9156', `MinLevelMana`='0', `MaxLevelMana`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15962';

-- Viscidus
UPDATE `creature_template` SET `DamageMultiplier`='33', `MinMeleeDmg`='71.4', `MaxMeleeDmg`='94.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15299';
	-- Glob of Viscidus [NOBESTIARY]
	UPDATE `creature_template` SET `ModelId1`='12349', `HealthMultiplier`='3', `ArmorMultiplier`='1', `MinLevelHealth`='9156', `MaxLevelHealth`='9156', `MinLevelMana`='0', `MaxLevelMana`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15667';
	-- Viscidus Trigger [NOSNIFF][NOBESTIARY]
		-- TO DO!

-- Princess Huhuran
UPDATE `creature_template` SET `PowerMultiplier`='150', `DamageMultiplier`='25', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15509';

-- Emperor Vek'lor
UPDATE `creature_template` SET `DamageMultiplier`='30', `ArmorMultiplier`='1.2', `MinMeleeDmg`='102.2', `MaxMeleeDmg`='135.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='27' WHERE `Entry`='15276';
	-- Emperor Vek'nilash
	UPDATE `creature_template` SET `PowerMultiplier`='180', `DamageMultiplier`='30', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15275';
	-- The Master's Eye [NOBESTIARY]
	UPDATE `creature_template` SET `SpeedRun`=('8' / '7'), `ArmorMultiplier`='1', `MinLevelHealth`='3331', `MaxLevelHealth`='3331', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15963';
	-- Qiraji Scarab
	UPDATE `creature_template` SET `ArmorMultiplier`='1', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15316';
	-- Qiraji Scorpion
	UPDATE `creature_template` SET `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15317';

-- Ouro
UPDATE `creature_template` SET `DamageMultiplier`='35', `MinMeleeDmg`='148.3', `MaxMeleeDmg`='196.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15517';
	-- Ouro Trigger [NOSNIFF][NOBESTIARY]
		-- TO DO!
	-- Ouro Scarab [NOBESTIARY]
	UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1', `ArmorMultiplier`='1', `MinLevelHealth`='9156', `MaxLevelHealth`='9156', `MinMeleeDmg`='52.0', `MaxMeleeDmg`='68.9', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15718';
	-- Ouro Spawner [NOBESTIARY]
	UPDATE `creature_template` SET `Scale`='0', `UnitFlags`='33554432', `ExtraFlags`='0', `MinLevelHealth`='3052', `MaxLevelHealth`='3052', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15957';
	-- Dirt Mound [NOBESTIARY]
	UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `SpeedWalk`=('12' / '2.5'), `SpeedRun`=('12' / '7'), `ArmorMultiplier`='1', `MinLevelHealth`='3052', `MaxLevelHealth`='3052', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15712';

-- C'Thun
UPDATE `creature_template` SET `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15727';
	-- Eye of C'Thun [NOBESTIARY]
	UPDATE `creature_template` SET `NpcFlags`='0', `HealthMultiplier`='400', `PowerMultiplier`='150', `ArmorMultiplier`='1', `MinLevelHealth`='1332400', `MaxLevelHealth`='1332400', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='137.3', `MaxMeleeDmg`='182.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15589';
	-- C'Thun Transformation Visual [NOSNIFF][NOBESTIARY]
		-- TO DO!
	-- C'Thun Portal [NOBESTIARY]
	UPDATE `creature_template` SET `MinLevel`='63', `MaxLevel`='63', `NpcFlags`='0', `HealthMultiplier`='400', `ArmorMultiplier`='1', `MinLevelHealth`='1332400', `MaxLevelHealth`='1332400', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15896';
	-- Tentacle Portal [NOBESTIARY]
	UPDATE `creature_template` SET `HealthMultiplier`='400', `ArmorMultiplier`='1', `MinLevelHealth`='1332400', `MaxLevelHealth`='1332400', `MaxMeleeDmg`='109.8', `MinRangedDmg`='145.6', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15904';
	-- Giant Tentacle Portal [NOBESTIARY]
	UPDATE `creature_template` SET `HealthMultiplier`='400', `ArmorMultiplier`='1', `MinLevelHealth`='1332400', `MaxLevelHealth`='1332400', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15910';
	-- Giant Eye Tentacle [NOBESTIARY]
	UPDATE `creature_template` SET `CreatureTypeFlags`='8', `HealthMultiplier`='12', `ArmorMultiplier`='1', `MinLevelHealth`='36624', `MaxLevelHealth`='36624', `MinLevelMana`='0', `MaxLevelMana`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15334';
	-- Giant Claw Tentacle [NOBESTIARY]
	UPDATE `creature_template` SET `UnitFlags`='0', `HealthMultiplier`='30', `ArmorMultiplier`='1', `MinLevelHealth`='91560', `MaxLevelHealth`='91560', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15728';
	-- Claw Tentacle [NOBESTIARY]
	UPDATE `creature_template` SET `CreatureTypeFlags`='8', `HealthMultiplier`='0.5', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinLevelHealth`='1526', `MaxLevelHealth`='1526', `MinMeleeDmg`='52.0', `MaxMeleeDmg`='68.9', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15725';
	-- Eye Tentacle [NOBESTIARY]
	UPDATE `creature_template` SET `CreatureTypeFlags`='8', `HealthMultiplier`='0.75', `ArmorMultiplier`='1', `MinLevelHealth`='2289', `MaxLevelHealth`='2289', `MinLevelMana`='0', `MaxLevelMana`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15726';
	-- Mouth Tentacle Mount Visual [NOSNIFF][NOBESTIARY]
		-- TO DO!
	-- Flesh Tentacle [NOBESTIARY]
	UPDATE `creature_template` SET `CreatureTypeFlags`='8', `SpeedWalk`=('6' / '2.5'), `SpeedRun`=('10' / '7'), `HealthMultiplier`='8', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinLevelHealth`='24416', `MaxLevelHealth`='24416', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15802';
	-- Vanquished Tentacle [NOBESTIARY]
	UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `Scale`='0', `HealthMultiplier`='2', `ArmorMultiplier`='1', `MinLevelHealth`='6104', `MaxLevelHealth`='6104', `MinLevelMana`='0', `MaxLevelMana`='0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15901';
	-- Giant Claw Tentacle Test [NOTEMPLATE][NOSNIFF][NOBESTIARY]
		-- TO DO!
	-- Giant Claw Tentacle Test [NOTEMPLATE][NOSNIFF][NOBESTIARY]
		-- TO DO!

-- ----------------------------------------------------------------------------------------------------------------------------------------

-- Anubisath Sentinel
UPDATE `creature_template` SET `DamageMultiplier`='17', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15264';

-- Obsidian Eradicator [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='70', `DamageMultiplier`='20', `ArmorMultiplier`='1', `MinLevelHealth`='170940', `MaxLevelHealth`='170940', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24' WHERE `Entry`='15262';

-- Vekniss Guardian
UPDATE `creature_template` SET `DamageMultiplier`='15', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15233';

-- Vekniss Drone
UPDATE `creature_template` SET `DamageMultiplier`='2', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15300';

-- Qiraji Brainwasher
UPDATE `creature_template` SET `DamageMultiplier`='12', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15247';

-- Vekniss Warrior
UPDATE `creature_template` SET `HealthMultiplier`='16', `DamageMultiplier`='12', `ArmorMultiplier`='1', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15230';
	-- Vekniss Borer [NOBESTIARY]
	UPDATE `creature_template` SET `HealthMultiplier`='2.5', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinLevelHealth`='7630', `MaxLevelHealth`='7630', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15622';

-- Vekniss Soldier
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='8', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15229';

-- Vekniss Hive Crawler
UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='15240';

-- Vekniss Stinger
UPDATE `creature_template` SET `DamageMultiplier`='12', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='15235';

-- Vekniss Wasp
UPDATE `creature_template` SET `DamageMultiplier`='8', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15236';

-- Qiraji Lasher
UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='84.7', `MaxMeleeDmg`='112.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15249';

-- Anubisasth Defender
UPDATE `creature_template` SET `DamageMultiplier`='30', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='15277';
	-- Anubisath Warrior
	UPDATE `creature_template` SET `MinLevel`='61', `MaxLevel`='61', `FactionAlliance`='310', `FactionHorde`='310', `HealthMultiplier`='12', `DamageMultiplier`='3', `ArmorMultiplier`='1', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15537';
	-- Anubisath Swarmguard
	UPDATE `creature_template` SET `MinLevel`='61', `MaxLevel`='61', `FactionAlliance`='310', `FactionHorde`='310', `HealthMultiplier`='2', `DamageMultiplier`='15', `ArmorMultiplier`='1', `MinMeleeDmg`='68.8', `MaxMeleeDmg`='91.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15538';

-- Qiraji Champion
UPDATE `creature_template` SET `DamageMultiplier`='25', `MinMeleeDmg`='109.9', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15252';

-- Qiraji Slayer
UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='98.5', `MaxMeleeDmg`='130.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='244', `RangedAttackPower`='25' WHERE `Entry`='15250';

-- Qiraji Mindslayer
UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15246';

-- Anubisath Warder
UPDATE `creature_template` SET `DamageMultiplier`='28', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15311';

-- Obsidian Nullifier [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='50', `DamageMultiplier`='25', `ArmorMultiplier`='1', `MinLevelHealth`='125750', `MaxLevelHealth`='125750', `MinMeleeDmg`='98.5', `MaxMeleeDmg`='130.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3316', `MeleeAttackPower`='244', `RangedAttackPower`='25', `EquipmentTemplateId`='0' WHERE `Entry`='15312';

-- ----------------------------------------------------------------------------------------------------------------------------------------
-- Added missing items to NPC vendor Nathaniel Steenwick
-- They were removed during TBC
-- This contributes to #809  
DELETE FROM `npc_vendor` WHERE `entry` = 4592 AND `item` IN (2946, 3107, 3111, 3137, 15326);
INSERT INTO `npc_vendor`(`entry`,`item`,`maxcount`,`incrtime`,`condition_id`) VALUES
(4592,2946,0,0,0),
(4592,3111,0,0,0),
(4592,3137,0,0,0),
(4592,15326,0,0,0),
(4592,3107,0,0,0);
-- Removing incorrect midsummer stations for each area

-- Stations not implemented Razor Hill, Morgan's Vigil, Brill,
-- Chillwind, Bloodhoof Village 

-- Eastern Kingdoms
-- Goldshire

DELETE FROM `gameobject` WHERE `guid` IN (50646, 52565, 50792, 51841, 50891, 50805, 51591, 51592, 50933, 50822, 51987, 51593, 51040, 51840);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50646, 52565, 50792, 51841, 50891, 50805, 51591, 51592, 50933, 50822, 51987, 51593, 51040, 51840);

DELETE FROM `creature` WHERE `guid` IN (94619, 94560, 94559, 94561, 94904, 94849);

DELETE FROM `game_event_creature` WHERE `guid` IN (94619, 94560, 94559, 94561, 94904, 94849);

DELETE FROM `creature_addon` WHERE `guid` IN (94619, 94560, 94559, 94561, 94904, 94849);

-- Westfall

DELETE FROM `gameobject` WHERE `guid` IN (51974, 51790, 51013, 51528, 50930, 50821, 50870, 51787, 50739, 50801, 51789, 54316,  52539, 51973, 51788, 51533);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51974, 51790, 51013, 51528, 50930, 50821, 50870, 51787, 50739, 50801, 51789, 54316,  52539, 51973, 51788, 51533);

DELETE FROM `creature` WHERE `guid` IN (94672, 94670, 94671, 94669, 94878, 94819);

DELETE FROM `game_event_creature` WHERE `guid` IN (94672, 94670, 94671, 94669, 94878, 94819);

DELETE FROM `creature_addon` WHERE `guid` IN (94672, 94670, 94671, 94669, 94878, 94819);


-- Darkshire

DELETE FROM `gameobject` WHERE `guid` IN (51818, 51567, 52562, 50644, 50789, 50896, 50837, 50917, 50788, 51570, 51015, 51566, 51571, 51568);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51818, 51567, 52562, 50644, 50789, 50896, 50837, 50917, 50788, 51570, 51015, 51566, 51571, 51568);

DELETE FROM `creature` WHERE `guid` IN (94646, 94647, 94648, 94645, 94900, 94821);

DELETE FROM `game_event_creature` WHERE `guid` IN (94646, 94647, 94648, 94645, 94900, 94821);

DELETE FROM `creature_addon` WHERE `guid` IN (94646, 94647, 94648, 94645, 94900, 94821);

-- Lakeshire

DELETE FROM `gameobject` WHERE `guid` IN (51039, 51780, 51781, 51523, 50675, 52538, 50779, 50819, 50777, 50914, 50867, 51520, 51783);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51039, 51780, 51781, 51523, 50675, 52538, 50779, 50819, 50777, 50914, 50867, 51520, 51783);

DELETE FROM `creature` WHERE `guid` IN (94600, 94599, 94548, 94618, 94877, 94848);

DELETE FROM `game_event_creature` WHERE `guid` IN (94600, 94599, 94548, 94618, 94877, 94848);

DELETE FROM `creature_addon` WHERE `guid` IN (94600, 94599, 94548, 94618, 94877, 94848);


-- Stonard

DELETE FROM `gameobject` WHERE `guid` IN (50910, 50834, 50732, 50775, 51454, 50863, 51025, 52558, 50974, 51453);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50910, 50834, 50732, 50775, 51454, 50863, 51025, 52558, 50974, 51453);

DELETE FROM `creature` WHERE `guid` IN (94598, 94650, 94651, 94652, 94897, 94836);

DELETE FROM `game_event_creature` WHERE `guid` IN (94598, 94650, 94651, 94652, 94897, 94836);

DELETE FROM `creature_addon` WHERE `guid` IN (94598, 94650, 94651, 94652, 94897, 94836);

-- Nethergarde

DELETE FROM `gameobject` WHERE `guid` IN (51589, 51587, 52564, 50574, 50890, 50804, 50918, 50846, 50745, 51590, 51588, 51833, 51031, 51585, 51834, 51986);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51589, 51587, 52564, 50574, 50890, 50804, 50918, 50846, 50745, 51590, 51588, 51833, 51031, 51585, 51834, 51986);

DELETE FROM `creature` WHERE `guid` IN (94558, 94607, 94606, 94608, 94902, 94841);

DELETE FROM `game_event_creature` WHERE `guid` IN (94558, 94607, 94606, 94608, 94902, 94841);

DELETE FROM `creature_addon` WHERE `guid` IN (94558, 94607, 94606, 94608, 94902, 94841);

-- Booty Bay

DELETE FROM `gameobject` WHERE `guid` IN (51792, 51529, 51012, 51791, 51804, 51805, 50738, 50740, 50741, 50737, 52560, 52561, 50690, 50689, 50869, 50872);


DELETE FROM `game_event_gameobject` WHERE `guid` IN (51792, 51529, 51012, 51791, 51804, 51805, 50738, 50740, 50741, 50737, 52560, 52561, 50690, 50689, 50869, 50872);

DELETE FROM `creature` WHERE `guid` IN (94710, 94654, 94693, 94694, 94898, 94901, 94822);

DELETE FROM `game_event_creature` WHERE `guid` IN (94710, 94654, 94693, 94694, 94898, 94901, 94822);

DELETE FROM `creature_addon` WHERE `guid` IN (94710, 94654, 94693, 94694, 94898, 94901, 94822);


-- Burning Steppes, Flame Crest

DELETE FROM `gameobject` WHERE `guid` IN (50934, 50793, 50876, 50695, 52567, 51599, 51033, 51600);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50934, 50793, 50876, 50695, 52567, 51599, 51033, 51600);

DELETE FROM `creature` WHERE `guid` IN (94684, 94685, 94686, 94683, 94907, 94846);

DELETE FROM `game_event_creature` WHERE `guid` IN (94684, 94685, 94686, 94683, 94907, 94846);

DELETE FROM `creature_addon` WHERE `guid` IN (94684, 94685, 94686, 94683, 94907, 94846);

-- Kargath

DELETE FROM `gameobject` WHERE `guid` IN (50839, 50746, 50919, 50898, 50694, 52547, 51032);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50839, 50746, 50919, 50898, 50694, 52547, 51032);

DELETE FROM `creature` WHERE `guid` IN (94565, 94564, 94611, 94883, 94845);

DELETE FROM `game_event_creature` WHERE `guid` IN (94565, 94564, 94611, 94883, 94845);

DELETE FROM `creature_addon` WHERE `guid` IN (94565, 94564, 94611, 94883, 94845);

-- Kharanos

DELETE FROM `gameobject` WHERE `guid` IN (51598, 50942, 50847, 50749, 51597, 50748, 50874, 51034, 51844, 51988, 51848, 51989, 51846, 51847, 50643, 52566);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51598, 50942, 50847, 50749, 51597, 50748, 50874, 51034, 51844, 51988, 51848, 51989, 51846, 51847, 50643, 52566);

DELETE FROM `creature` WHERE `guid` IN (94609, 94562, 94621, 94620, 94905, 94843);

DELETE FROM `game_event_creature` WHERE `guid` IN (94609, 94562, 94621, 94620, 94905, 94843);

DELETE FROM `creature_addon` WHERE `guid` IN (94609, 94562, 94621, 94620, 94905, 94843);

-- Thelsamar

DELETE FROM `gameobject` WHERE `guid` IN (50806, 50892, 50823, 50751, 50920, 50649, 52568, 51603, 51035, 51853, 51849, 51601, 51855, 51604, 51854);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50806, 50892, 50823, 50751, 50920, 50649, 52568, 51603, 51035, 51853, 51849, 51601, 51855, 51604, 51854);

DELETE FROM `creature` WHERE `guid` IN (94623, 94563, 94622, 94610, 94906, 94844);

DELETE FROM `game_event_creature` WHERE `guid` IN (94623, 94563, 94622, 94610, 94906, 94844);

DELETE FROM `creature_addon` WHERE `guid` IN (94623, 94563, 94622, 94610, 94906, 94844);

-- Wetlands

DELETE FROM `gameobject` WHERE `guid` IN (50678, 52540, 51537, 50783, 50887, 50782, 50835, 51975, 50916, 51976, 51535, 51027, 51793, 51794, 51534);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50678, 52540, 51537, 50783, 50887, 50782, 50835, 51975, 50916, 51976, 51535, 51027, 51793, 51794, 51534);

DELETE FROM `creature` WHERE `guid` IN (94602, 94706, 94549, 94705, 94879, 94838);

DELETE FROM `game_event_creature` WHERE `guid` IN (94602, 94706, 94549, 94705, 94879, 94838);

DELETE FROM `creature_addon` WHERE `guid` IN (94602, 94706, 94549, 94705, 94879, 94838);

-- Arathi, Refuge Point

DELETE FROM `gameobject` WHERE `guid` IN (51578, 51812, 51985, 50552, 50553, 52542, 52543, 51821, 51981, 51579, 51982, 51014, 51030, 51573, 51813, 51554, 51577, 51820, 51552, 50787, 50802, 50803, 50786, 51814, 51822, 50888, 50897, 50845, 50836, 50931, 50941, 51580, 51815);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51578, 51812, 51985, 50552, 50553, 52542, 52543, 51821, 51981, 51579, 51982, 51014, 51030, 51573, 51813, 51554, 51577, 51820, 51552, 50787, 50802, 50803, 50786, 51814, 51822, 50888, 50897, 50845, 50836, 50931, 50941, 51580, 51815);

DELETE FROM `creature` WHERE `guid` IN (94635, 94634, 94637, 94636, 94881, 94882, 94823, 94840);

DELETE FROM `game_event_creature` WHERE `guid` IN (94635, 94634, 94637, 94636, 94881, 94882, 94823, 94840);

DELETE FROM `creature_addon` WHERE `guid` IN (94635, 94634, 94637, 94636, 94881, 94882, 94823, 94840);

-- Arathi, Hammerfall

DELETE FROM `gameobject` WHERE `guid` IN (51819, 50791, 50790, 51557, 50838, 50932, 50686, 52563, 50889, 51984, 51558, 51983, 51029);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51819, 50791, 50790, 51557, 50838, 50932, 50686, 52563, 50889, 51984, 51558, 51983, 51029);

DELETE FROM `creature` WHERE `guid` IN (94643, 94644, 94642, 94641, 94903, 94842);

DELETE FROM `game_event_creature` WHERE `guid` IN (94643, 94644, 94642, 94641, 94903, 94842);

DELETE FROM `creature_addon` WHERE `guid` IN (94643, 94644, 94642, 94641, 94903, 94842);


-- Hinterlands, Aerie Peak

DELETE FROM `gameobject` WHERE `guid` IN (52578, 51527, 51524, 50677, 50780, 50736, 50886, 51972, 50820, 50915, 51784, 51026, 51786, 51785);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (52578, 51527, 51524, 50677, 50780, 50736, 50886, 51972, 50820, 50915, 51784, 51026, 51786, 51785);

DELETE FROM `creature` WHERE `guid` IN (94601, 94640, 94638, 94639, 94914, 94837);

DELETE FROM `game_event_creature` WHERE `guid` IN (94601, 94640, 94638, 94639, 94914, 94837);

DELETE FROM `creature_addon` WHERE `guid` IN (94601, 94640, 94638, 94639, 94914, 94837);

-- Hinterlands, Raventusk

DELETE FROM `gameobject` WHERE `guid` IN (52537, 50648, 51778, 51777, 50866, 50776, 50800, 50818, 50929, 51009 ,51779, 51519, 51971);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (52537, 50648, 51778, 51777, 50866, 50776, 50800, 50818, 50929, 51009 ,51779, 51519, 51971);

DELETE FROM `creature` WHERE `guid` IN (94673, 94674, 94702, 94703, 94876, 94818);

DELETE FROM `game_event_creature` WHERE `guid` IN (94673, 94674, 94702, 94703, 94876, 94818);

DELETE FROM `creature_addon` WHERE `guid` IN (94673, 94674, 94702, 94703, 94876, 94818);


-- Hillsbrad, Southshore

DELETE FROM `gameobject` WHERE `guid` IN (52572, 50977, 51617, 50842, 50938, 50759, 50878, 50758, 51869, 51036, 51867);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (52572, 50977, 51617, 50842, 50938, 50759, 50878, 50758, 51869, 51036, 51867);

DELETE FROM `creature` WHERE `guid` IN (94612, 94566, 94568, 94567, 94909, 94847);

DELETE FROM `game_event_creature` WHERE `guid` IN (94612, 94566, 94568, 94567, 94909, 94847);

DELETE FROM `creature_addon` WHERE `guid` IN (94612, 94566, 94568, 94567, 94909, 94847);

-- Silverpine, Sepulcher

DELETE FROM `gameobject` WHERE `guid` IN (52570, 54315, 51856, 50937,50841, 51616, 50756, 50757, 50894, 51041, 51614);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (52570, 54315, 51856, 50937,50841, 51616, 50756, 50757, 50894, 51041, 51614);

DELETE FROM `creature` WHERE `guid` IN (94679, 94680, 94678, 94677, 94908, 94850);

DELETE FROM `game_event_creature` WHERE `guid` IN (94679, 94680, 94678, 94677, 94908, 94850);

DELETE FROM `creature_addon` WHERE `guid` IN (94679, 94680, 94678, 94677, 94908, 94850);

-- Hillsbrad, Taren Mill

DELETE FROM `gameobject` WHERE `guid` IN (50753, 50824, 50936, 50752, 50893, 52551, 51605, 50957, 51609, 51018, 51608);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50753, 50824, 50936, 50752, 50893, 52551, 51605, 50957, 51609, 51018, 51608);

DELETE FROM `creature` WHERE `guid` IN (94660, 94659, 94657, 94658, 94884, 94824);

DELETE FROM `game_event_creature` WHERE `guid` IN (94660, 94659, 94657, 94658, 94884, 94824);

DELETE FROM `creature_addon` WHERE `guid` IN (94660, 94659, 94657, 94658, 94884, 94824);

-- Undercity

DELETE FROM `gameobject` WHERE `guid` IN (50947, 50968, 50967, 50966, 50946, 50986, 52573, 50939, 50924, 50831, 50809, 50700, 50794, 50989, 50571);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50947, 50968, 50967, 50966, 50946, 50986, 52573, 50939, 50924, 50831, 50809, 50700, 50794, 50989, 50571);

DELETE FROM `creature` WHERE `guid` IN (94570, 94569, 94615, 94571, 94860, 94911, 94801);

DELETE FROM `game_event_creature` WHERE `guid` IN (94570, 94569, 94615, 94571, 94860, 94911, 94801);

DELETE FROM `creature_addon` WHERE `guid` IN (94570, 94569, 94615, 94571, 94860, 94911, 94801);

-- ********************************************************
-- Kalimdor

-- Teldrassil, Dolanaar

DELETE FROM `gameobject` WHERE `guid` IN (50873, 50902, 50832, 50742, 50703, 51339, 51574, 51576, 50992, 51337, 52557, 50676, 51338);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50873, 50902, 50832, 50742, 50703, 51339, 51574, 51576, 50992, 51337, 52557, 50676, 51338);

DELETE FROM `creature` WHERE `guid` IN (94578, 94536, 94577, 94576, 94912, 94803, 47575, 46889);

DELETE FROM `game_event_creature` WHERE `guid` IN (94578, 94536, 94577, 94576, 94912, 94803, 47575, 46889);

DELETE FROM `creature_addon` WHERE `guid` IN (94578, 94536, 94577, 94576, 94912, 94803, 47575, 46889);

-- Darkshore, Auberdine

DELETE FROM `gameobject` WHERE `guid` IN (51636, 50582, 52530, 51637, 51369, 51022, 51635, 51634, 50905, 50814, 50721, 50720, 50884, 51717, 51639, 51638);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51636, 50582, 52530, 51637, 51369, 51022, 51635, 51634, 50905, 50814, 50721, 50720, 50884, 51717, 51639, 51638);

DELETE FROM `creature` WHERE `guid` IN (94544, 94617, 94616, 94543, 94869, 94833);

DELETE FROM `game_event_creature` WHERE `guid` IN (94544, 94617, 94616, 94543, 94869, 94833);

DELETE FROM `creature_addon` WHERE `guid` IN (94544, 94617, 94616, 94543, 94869, 94833);

-- Ashenvale, Astranaar

DELETE FROM `gameobject` WHERE `guid` IN (51611, 51712, 51021, 51353, 51713, 51354, 51612, 51613, 51355, 50554, 52528, 50716, 50717, 50857, 50812, 51357, 50903, 51615);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51611, 51712, 51021, 51353, 51713, 51354, 51612, 51613, 51355, 50554, 52528, 50716, 50717, 50857, 50812, 51357, 50903, 51615);

DELETE FROM `creature` WHERE `guid` IN (94746, 94745, 94743, 94744, 94868, 94832);

DELETE FROM `game_event_creature` WHERE `guid` IN (94746, 94745, 94743, 94744, 94868, 94832);

DELETE FROM `creature_addon` WHERE `guid` IN (94746, 94745, 94743, 94744, 94868, 94832);

-- Ashenvale, Splintertree

DELETE FROM `gameobject` WHERE `guid` IN (50813, 50719, 50904, 50718, 50687, 50858, 52554, 50998, 51362, 51363);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50813, 50719, 50904, 50718, 50687, 50858, 52554, 50998, 51362, 51363);

DELETE FROM `creature` WHERE `guid` IN (94588, 94542, 94541, 94587, 94893, 94810);

DELETE FROM `game_event_creature` WHERE `guid` IN (94588, 94542, 94541, 94587, 94893, 94810);

DELETE FROM `creature_addon` WHERE `guid` IN (94588, 94542, 94541, 94587, 94893, 94810);

-- Winterspring, Everlook NE

DELETE FROM `gameobject` WHERE `guid` IN (51020, 50755, 50754, 50856, 52552, 50685, 51352, 51351, 51610);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51020, 50755, 50754, 50856, 52552, 50685, 51352, 51351, 51610);

DELETE FROM `creature` WHERE `guid` IN (94584, 94585, 94539, 94583, 94891);

DELETE FROM `game_event_creature` WHERE `guid` IN (94584, 94585, 94539, 94583, 94891);

DELETE FROM `creature_addon` WHERE `guid` IN (94584, 94585, 94539, 94583, 94891);

-- Winterspring, Everlook NW

DELETE FROM `gameobject` WHERE `guid` IN (51019, 51347, 51607, 50714, 50711, 51606, 50877, 52550, 50693, 51348);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51019, 51347, 51607, 50714, 50711, 51606, 50877, 52550, 50693, 51348);

DELETE FROM `creature` WHERE `guid` IN (94581, 94538, 94537, 94890, 94830);

DELETE FROM `game_event_creature` WHERE `guid` IN (94581, 94538, 94537, 94890, 94830);

DELETE FROM `creature_addon` WHERE `guid` IN (94581, 94538, 94537, 94890, 94830);

-- Stonetalon, Sun Rock Retreat

DELETE FROM `gameobject` WHERE `guid` IN (50973, 52525, 50701, 50735, 50865, 50901, 51275, 51276, 51010, 51274);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50973, 52525, 50701, 50735, 50865, 50901, 51275, 51276, 51010, 51274);

DELETE FROM `creature` WHERE `guid` IN (94709, 94574, 94707, 94708, 94865, 94828);

DELETE FROM `game_event_creature` WHERE `guid` IN (94709, 94574, 94707, 94708, 94865, 94828);

DELETE FROM `creature_addon` WHERE `guid` IN (94709, 94574, 94707, 94708, 94865, 94828);

-- The Barrens, Crossroads

DELETE FROM `gameobject` WHERE `guid` IN (51390, 52556, 50976, 50880, 50727, 50726, 50830, 50922, 51389, 51388, 51002);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51390, 52556, 50976, 50880, 50727, 50726, 50830, 50922, 51389, 51388, 51002);

DELETE FROM `creature` WHERE `guid` IN (94730, 94729, 94732, 94731, 94896, 94813);

DELETE FROM `game_event_creature` WHERE `guid` IN (94730, 94729, 94732, 94731, 94896, 94813);

DELETE FROM `creature_addon` WHERE `guid` IN (94730, 94729, 94732, 94731, 94896, 94813);

-- Desolace, Nijel's Point

DELETE FROM `gameobject` WHERE `guid` IN (51368, 50642, 52553, 51625, 51367, 51365, 51364, 50825, 50883, 50928, 50760, 50772, 51366, 50999, 51716, 51715);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51368, 50642, 52553, 51625, 51367, 51365, 51364, 50825, 50883, 50928, 50760, 50772, 51366, 50999, 51716, 51715);

DELETE FROM `creature` WHERE `guid` IN (94540, 94591, 94589, 94590, 94894, 94809);

DELETE FROM `game_event_creature` WHERE `guid` IN (94540, 94591, 94589, 94590, 94894, 94809);

DELETE FROM `creature_addon` WHERE `guid` IN (94540, 94591, 94589, 94590, 94894, 94809);

-- Desolace, Shadowprey Village

DELETE FROM `gameobject` WHERE `guid` IN (51645, 52532, 50696, 50827, 50907, 50762, 51720, 50723, 51381, 50879, 51024, 51646);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51645, 52532, 50696, 50827, 50907, 50762, 51720, 50723, 51381, 50879, 51024, 51646);

DELETE FROM `creature` WHERE `guid` IN (94593, 94546, 94545, 94594, 94871, 94835);

DELETE FROM `game_event_creature` WHERE `guid` IN (94593, 94546, 94545, 94594, 94871, 94835);

DELETE FROM `creature_addon` WHERE `guid` IN (94593, 94546, 94545, 94594, 94871, 94835);

-- Feralas, Feathermoon
-- Just the one random brazier here it seems

DELETE FROM `gameobject` WHERE `guid` IN (51375);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51375);

-- Feralas, Camp Mojache

DELETE FROM `gameobject` WHERE `guid` IN (50908, 50829, 50724, 50763, 50828, 50859, 52555, 51648, 51383, 51647, 51382, 51000);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50908, 50829, 50724, 50763, 50828, 50859, 52555, 51648, 51383, 51647, 51382, 51000);

DELETE FROM `creature` WHERE `guid` IN (94682, 94687, 94681, 94688, 94895, 94811);

DELETE FROM `game_event_creature` WHERE `guid` IN (94682, 94687, 94681, 94688, 94895, 94811);

DELETE FROM `creature_addon` WHERE `guid` IN (94682, 94687, 94681, 94688, 94895, 94811);

-- Dustwallow Marsh, Theramore

DELETE FROM `gameobject` WHERE `guid` IN (50722, 50885, 50761, 50826, 50906, 50645, 52531, 51372, 51642, 51641, 51640, 51023, 51373, 51718);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50722, 50885, 50761, 50826, 50906, 50645, 52531, 51372, 51642, 51641, 51640, 51023, 51373, 51718);

DELETE FROM `creature` WHERE `guid` IN (94592, 94742, 94740, 94741, 94870, 94834);

DELETE FROM `game_event_creature` WHERE `guid` IN (94592, 94742, 94740, 94741, 94870, 94834);

DELETE FROM `creature_addon` WHERE `guid` IN (94592, 94742, 94740, 94741, 94870, 94834);

-- Dustwallow Marsh, Brackenwall Village

DELETE FROM `gameobject` WHERE `guid` IN (51218, 52535, 50810, 50861, 50699, 50816, 50729, 50909, 51005, 51219, 51402);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51218, 52535, 50810, 50861, 50699, 50816, 50729, 50909, 51005, 51219, 51402);

DELETE FROM `creature` WHERE `guid` IN (94535, 94534, 94533, 94532, 94875, 94817);

DELETE FROM `game_event_creature` WHERE `guid` IN (94535, 94534, 94533, 94532, 94875, 94817);

DELETE FROM `creature_addon` WHERE `guid` IN (94535, 94534, 94533, 94532, 94875, 94817);

-- Thousand Needles, Freewind Post

DELETE FROM `gameobject` WHERE `guid` IN (50725, 50921, 50764, 50860, 51386, 52533, 50978, 51001, 51387);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50725, 50921, 50764, 50860, 51386, 52533, 50978, 51001, 51387);

DELETE FROM `creature` WHERE `guid` IN (94595, 94596, 94872, 94812);

DELETE FROM `game_event_creature` WHERE `guid` IN (94595, 94596, 94872, 94812);

DELETE FROM `creature_addon` WHERE `guid` IN (94595, 94596, 94872, 94812);

-- Tanaris, Gadgetzan East

DELETE FROM `gameobject` WHERE `guid` IN (50707, 50709, 50710, 50708, 50854, 50853, 50683, 50684, 52527, 52546, 51586, 51343, 51594, 51342, 51346, 50994, 51017);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50707, 50709, 50710, 50708, 50854, 50853, 50683, 50684, 52527, 52546, 51586, 51343, 51594, 51342, 51346, 50994, 51017);

DELETE FROM `creature` WHERE `guid` IN (94717, 94715, 94716, 94733, 94867, 94887, 94831, 94807);

DELETE FROM `game_event_creature` WHERE `guid` IN (94717, 94715, 94716, 94733, 94867, 94887, 94831, 94807);

DELETE FROM `creature_addon` WHERE `guid` IN (94717, 94715, 94716, 94733, 94867, 94887, 94831, 94807);

-- Tanaris, Gadgetzan West

DELETE FROM `gameobject` WHERE `guid` IN (52548, 52549, 50691, 50692, 51345, 51350, 51349, 51595, 50712, 50747, 50713, 50750, 50855, 50875, 50995, 50996, 51344, 51596, 51602);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (52548, 52549, 50691, 50692, 51345, 51350, 51349, 51595, 50712, 50747, 50713, 50750, 50855, 50875, 50995, 50996, 51344, 51596, 51602);

DELETE FROM `creature` WHERE `guid` IN (94723, 94695, 94698, 94725, 94889, 94892, 94806, 94808);

DELETE FROM `game_event_creature` WHERE `guid` IN (94723, 94695, 94698, 94725, 94889, 94892, 94806, 94808);

DELETE FROM `creature_addon` WHERE `guid` IN (94723, 94695, 94698, 94725, 94889, 94892, 94806, 94808);

-- Silithus, Cenarion Hold South

DELETE FROM `gameobject` WHERE `guid` IN (51584, 52545, 51581, 49313, 50688, 50851, 50706, 50744, 51582, 51583, 51016);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (51584, 52545, 51581, 49313, 50688, 50851, 50706, 50744, 51582, 51583, 51016);

DELETE FROM `creature` WHERE `guid` IN (94690, 94691, 94692, 94689, 94886, 94829);

DELETE FROM `game_event_creature` WHERE `guid` IN (94690, 94691, 94692, 94689, 94886, 94829);

DELETE FROM `creature_addon` WHERE `guid` IN (94690, 94691, 94692, 94689, 94886, 94829);

-- Silithus, Cenarion Hold East

DELETE FROM `gameobject` WHERE `guid` IN (50704, 50705, 50743, 50702, 49312, 50680, 50679, 50850, 50852, 52526, 52544, 51335, 51340, 51575, 50991, 50993, 51341, 51336);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50704, 50705, 50743, 50702, 49312, 50680, 50679, 50850, 50852, 52526, 52544, 51335, 51340, 51575, 50991, 50993, 51341, 51336);

DELETE FROM `creature` WHERE `guid` IN (94699, 94700, 94738, 94649, 94866, 94888, 94804, 94805);

DELETE FROM `game_event_creature` WHERE `guid` IN (94699, 94700, 94738, 94649, 94866, 94888, 94804, 94805);

DELETE FROM `creature_addon` WHERE `guid` IN (94699, 94700, 94738, 94649, 94866, 94888, 94804, 94805);

-- *************************************************************

-- Removing incorrect event items, npcs, gamobjects etc.

-- Flame of Shattrath, Alliance Bonfire, Horde Bonfire, master -- -- fire eater, midsummer vendors

-- Flame of Shattrath

DELETE FROM `gameobject_template` WHERE `entry`= 188352;

-- Midsummer Merchant + Costumes (added in 2.4)

DELETE FROM `creature_template` WHERE `Entry` IN (16979, 16985, 16986);

-- Torch Target Braziers

DELETE FROM `gameobject_template` WHERE `entry`= 187708;-- Changing Stormwind event area

-- Changing Celebrants to Firebreathers

UPDATE `creature` SET `id`= 17038, `modelid`= 16412 WHERE `guid`= 94675;
UPDATE `creature` SET `id`= 17038, `modelid`= 16433 WHERE `guid`= 94676;

-- Removing Torch Target Braziers

DELETE FROM `gameobject` WHERE `guid` IN (50971, 50962);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50971, 50962);

-- Slight adjustment to flame position + trap

UPDATE `gameobject` SET `position_x`= -8833.23, `position_y`= 859.132, `position_z`= 98.8978, `orientation`= -2.07694 WHERE `guid`= 50981;

UPDATE `gameobject` SET `position_x`= -8833.23, `position_y`= 859.132, `position_z`= 98.8978, `orientation`= -2.07694 WHERE `guid`= 52577;

-- Adding Tent + Decorations

DELETE FROM gameobject WHERE guid BETWEEN 55020 AND 55029;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55020, 181301, 0, -8828.97, 872.496, 98.6609, 1.17717, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55021, 181392, 0, -8830.448242, 868.839722, 102.123, 4.29844, 0, 0, 0.837326, -0.546704, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55022, 181392, 0, -8827.67, 876.27, 102.123, 1.20095, 0, 0, 0.565033, 0.825068, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55023, 181305, 0, -8825.919922, 873.322021, 98.660896, 5.907331, 0, 0, 0.565033, 0.825068, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55024, 181307, 0, -8827.055664, 873.295105, 99.720879, 3.714509, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55025, 181307, 0, -8824.352539, 873.181519, 99.716415, 1.837407, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55026, 181391, 0, -8825.827148, 873.296570, 99.716537, 2.698978, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55027, 181302, 0, -8830.484375, 876.028015, 98.566925, 6.162577, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55028, 181302, 0, -8827.839844, 868.646, 98.760399, 1.226356, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55029, 181302, 0, -8827.809570, 868.665588, 100.004204, 1.689745, 0, 0, 0, 0, 180, 100, 1);


DELETE FROM game_event_gameobject WHERE guid BETWEEN 55020 AND 55029;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55020, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55021, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55022, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55023, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55024, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55025, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55026, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55027, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55028, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55029, 1);

-- Adding festival Loremaster, Flamekeeper and relocating 
-- Firebreathers

DELETE FROM creature WHERE guid BETWEEN 95000 AND 95001;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95000, 16817, 0, 16354, 0, -8829.290039, 853.587769, 99.180504, 6.009315, 180, 0, 0, 6900, 0, 0, 0);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95001, 16788, 0, 16338, 0, -8828.253906, 864.704834, 98.861595, 6.049497, 180, 0, 0, 6900, 0, 0, 0);

DELETE FROM game_event_creature_data WHERE guid = 95001;
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (95001, 16788, 0, 0, 29246, 29246, 1);

UPDATE `creature` SET `position_x`= -8830.818359, `position_y`= 872.003235, `position_z`= 98.649483, `orientation`= 5.974578 WHERE `guid`= 94676;

UPDATE `creature` SET `position_x`= -8825.745117, `position_y`= 870.474976, `position_z`= 98.732155, `orientation`= 2.852017 WHERE `guid`= 94675;

DELETE FROM game_event_creature WHERE guid BETWEEN 95000 AND 95001;
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES (95000, 1);

INSERT INTO `game_event_creature` (`guid`, `event`) VALUES (95001, 1);

-- *************************************************************


-- Changing Ironforge event area

-- Removing Torch Target Braziers

DELETE FROM `gameobject` WHERE `guid` IN (50970, 50950, 50948, 50949, 50969);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50970, 50950, 50948, 50949, 50969);

-- Adjusting Crate positions + adding braziers

UPDATE `gameobject` SET `position_x`= -4691.859863, `position_y`= -1220.469971, `position_z`= 501.660004, `orientation`= 3.11753, `rotation2`= 0.999928, `rotation3`= 0.0120311  WHERE `guid`= 50798;

UPDATE `gameobject` SET `position_x`= -4690.669922, `position_y`= -1221.900024, `position_z`= 501.660004, `orientation`= 0, `rotation2`= 0, `rotation3`= 1 WHERE `guid`= 50768;

UPDATE `gameobject` SET `position_x`= -4691.290039, `position_y`= -1221.130005, `position_z`= 502.903015, `orientation`= 2.19469, `rotation2`= 0.89, `rotation3`= 0.455961 WHERE `guid`= 50767;

DELETE FROM gameobject WHERE guid IN (55030, 55031);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55030, 181355, 0, -4694.629883, -1219.928467, 501.660004, 2.253594, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55031, 181355, 0, -4706.125, -1229.371338, 501.660004, 2.210395, 0, 0, 0, 0, 180, 100, 1);

DELETE FROM game_event_gameobject WHERE guid IN (55030, 55031);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55030, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55031, 1);

-- Updating Loremaster and adding Flamekeeper

UPDATE `creature` SET `position_x`= -4702.790039, `position_y`= -1218.050049 WHERE `guid`= 94857;

DELETE FROM creature WHERE guid = 95002;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95002, 16788, 0, 16339, 0, -4699.388184, -1215.956421, 501.659607, 1.581940, 180, 0, 0, 6900, 0, 0, 0);

DELETE FROM game_event_creature WHERE guid = 95002 AND event = 1;
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95002,1);

DELETE FROM game_event_creature_data WHERE guid = 95002;
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (95002, 16788, 0, 0, 29245, 29245, 1);

-- Changing 2 Celebrants to IF Firebreathers

UPDATE `creature` SET `id`= 17048, `position_x`= -4706.531250, `position_y`= -1221.005737, `position_z`= 501.660004, `orientation`= 4.4537, `modelid`= 16413 WHERE `guid`= 94663;

UPDATE `creature` SET `id`= 17048, `position_x`= -4693.685059, `position_y`= -1222.138672, `position_z`= 501.660004, `orientation`= 5.87741, `modelid`= 16434 WHERE `guid`= 94661;

-- Removing remaining Celebrants

DELETE FROM `creature` WHERE `guid` IN (94662, 94664);

DELETE FROM `game_event_creature` WHERE `guid` IN (94662, 94664);

DELETE FROM `creature_addon` WHERE `guid` IN (94662, 94664);

-- *************************************************************

-- Changing Darnassus Event Area

-- Removing Torch Target Braziers

DELETE FROM `gameobject` WHERE `guid` IN (50954, 50959, 50953, 50958, 50952);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50954, 50959, 50953, 50958, 50952);

-- Setting Flame of Darnassus to correct model

UPDATE `gameobject_template` SET `displayId`= 6754 WHERE `entry`= 181334;

-- Slight adjustment to Flame position

UPDATE `gameobject` SET `position_x`= 8704.969727,`position_y`= 932.635986, `position_z`= 14.726300, `orientation`= 3.40724, `rotation2`= 0.991192, `rotation3`= -0.132434 WHERE `guid`= 50985;

UPDATE `gameobject` SET `position_x`= 8704.969727,`position_y`= 932.635986, `position_z`= 14.726300, `orientation`= 3.40724, `rotation2`= 0.991192, `rotation3`= -0.132434 WHERE `guid`= 52534;

-- Slight adjustment of Loremaster's position

UPDATE `creature` SET `position_x`= 8701.287109, `position_y`= 939.087097, `position_z`= 14.080829, `orientation`= 1.671578 WHERE `guid`= 94855;

-- Adding 2 Darn Firebreathers by changing 2 celebrant npcs

UPDATE `creature` SET `id`= 17049, `modelid`= 0, `position_x`= 8697.292969, `position_y`= 929.417908, `position_z`= 15.778015, `orientation`= 6.094326 WHERE `guid`= 94727;

UPDATE `creature` SET `id`= 17049, `modelid`= 0, `position_x`= 8700.335938, `position_y`= 928.731812, `position_z`= 15.883267, `orientation`= 2.854552 WHERE `guid`= 94529;

-- Removing 2 remaining celebrants

DELETE FROM `creature` WHERE `guid` IN (94728, 94747);

DELETE FROM `game_event_creature` WHERE `guid` IN (94728, 94747);

DELETE FROM `creature_addon` WHERE `guid` IN (94728, 94747);

-- Adding Flamekeeper

DELETE FROM creature WHERE guid = 95003;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95003, 16788, 1, 16338, 0, 8711.143555, 934.722717, 14.820390, 2.373151, 180, 0, 0, 6900, 0, 0, 0);

DELETE FROM game_event_creature WHERE guid = 95003;
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95003,1);

DELETE FROM game_event_creature_data WHERE guid = 95003;
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (95003, 16788, 0, 0, 29246, 29246, 1);

-- Adding tent,tables and decorations

DELETE FROM gameobject WHERE guid BETWEEN 55032 AND 55039;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55032, 181301, 1, 8713.120117, 928.921021, 15.230100, 0.902662, 0, 0, 0.436164, 0.899867, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55033, 181392, 1, 8710.602656, 925.819453, 18.596324, 4.032491, 0, 0, 0.902417, -0.430863, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55034, 181392, 1, 8715.522656, 932.062878, 18.706324, 0.879107, 0, 0, 0.425535, 0.904942, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55035, 181355, 1, 8706.299805, 927.255737, 15.613177, 1.861283, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55036, 181355, 1, 8714.546875, 934.973267, 14.940084, 1.861283, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55037, 181305, 1, 8716.241211, 929.633484, 15.441314, 1.042100, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55038, 181302, 1, 8708.734375, 927.564148, 15.257755, 0.755429, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55039, 181302, 1, 8708.337891, 927.585815, 16.501081, 3.107706, 0, 0, 0, 0, 180, 100, 1);

DELETE FROM game_event_gameobject WHERE guid BETWEEN 55032 AND 55039;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55032, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55033, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55034, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55035, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55036, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55037, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55038, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55039, 1);

-- Adjusting Ribbon Pole position

UPDATE `gameobject` SET `position_x`= 8729.666992, `position_y`= 928.159058, `position_z`= 19.578243 WHERE `guid`= 51003;

-- ***********************************************************
-- Changing Undercity Event Area

-- Adjusting Flame of the Undercity to correct model

UPDATE `gameobject_template` SET `displayId`= 6755 WHERE `entry`= 181335;

DELETE FROM gameobject WHERE guid BETWEEN 55040 AND 55049;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55040 AND 55049;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55040, 181335, 0, 1642.060059, 239.867004, 62.591579, 0.0009408, 0, 0, 0.0004704, 1, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55040, 1);

-- Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55041, 181605, 0, 1650, 228.962006, 62.591599, 2.258957, 0, 0, 0.90419, 00.42713, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55041, 1);

-- Table, mugs, crates and braziers

DELETE FROM gameobject WHERE guid BETWEEN 55042 AND 55049;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55042 AND 55049;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55042, 181305, 0, 1640.038696, 234.286026, 62.591599, 2.726269, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55042, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55043, 181307, 0, 1640.696655, 234.167191, 63.582661, 2.985538, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55043, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55044, 181307, 0, 1638.000366, 233.696701, 63.582962, 0.39765, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55044, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55045, 181302, 0, 1638.088501, 244.059906, 62.591518, 3.475719, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55045, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55046, 181302, 0, 1636.944336, 245.123138, 62.591648, 3.60924, 0, 0, 0.972788, -0.231698, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55046, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55047, 181302, 0, 1637.110840, 244.775665, 63.834652, 2.796351, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55047, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55048, 181355, 0, 1631.430054, 233.30995, 62.591599, .0997790, 0, 0, 0.0498688, 0.998756, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55048, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55049, 181355, 0, 1631.827271, 246.979446, 62.591541, 5.753376, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55049, 1);

-- Adding Festival NPCs

-- Adjusting UC and TB Fireeater to match Org, they can't be    -- dummies

UPDATE `creature_template` SET `MinLevel`= 59, `MaxLevel`= 60, `MinLevelHealth`= 5800, `MaxLevelHealth`= 6800, `MinMeleeDmg`= 118, `MaxMeleeDmg`= 125, `MeleeAttackPower`= 56, `RangedAttackPower`= 100, `EquipmentTemplateId`= 0 WHERE `Entry` IN (17050, 17051);



-- Adding UC Fireeater x 3

DELETE FROM creature WHERE guid BETWEEN 95004 AND 95008;
DELETE FROM game_event_creature WHERE guid BETWEEN 95004 AND 95008;
DELETE FROM game_event_creature_data WHERE guid BETWEEN 95004 AND 95008;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95004, 17051, 0, 0, 0, 1646.161743, 234.941940, 62.591473, 3.609430, 180, 0, 0, 5800, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95004,1);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95005, 17051, 0, 0, 0, 1644.038208, 233.989410, 62.591473, 0.528861, 180, 0, 0, 5800, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95005,1);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95008, 17051, 0, 0, 0, 1638.525146, 244.587646, 62.591881, 5.516111, 180, 0, 0, 5800, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95008,1);

-- Adding Flamekeeper + Talespinner

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95006, 16788, 0, 0, 0, 1647.563599, 243.818588, 62.591999, 0.167576, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (95006, 16788, 0, 0, 29243, 29243, 1);


INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95006,1);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95007, 16818, 0, 0, 0, 1636.232788, 235.524689, 62.591728, 3.91, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95007,1);


-- ***********************************************************
-- Changing Thunderbluff Event Area

-- Adjusting Flame of Thunderbluff to correct model

UPDATE `gameobject_template` SET `displayId`= 6755 WHERE `entry`= 181337;

-- Removing Torch Target Braziers

DELETE FROM `gameobject` WHERE `guid` IN (50955, 50961, 50945, 50956, 50965);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50955, 50961, 50945, 50956, 50965);

-- Adjusting flame + trap + Music Doodad position

UPDATE `gameobject` SET `position_x`= -1036.25, `position_y`= 297.622009, `position_z`= 135.535995, `orientation`= 3.7342, `rotation2`= 0.956422, `rotation3`= -0.291989 WHERE `guid` IN (50988, 52571, 50556);

-- Adjusting Ribbon Pole position

UPDATE `gameobject` SET `position_x`= -1034.626831, `position_y`= 314.926910, `position_z`= 134.5901345, `orientation`= 4.802892 WHERE `guid`= 51004;

-- Adding Festival Tent plus decorations

DELETE FROM gameobject WHERE guid BETWEEN 55050 AND 55052;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55050 AND 55052;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55050, 181301, 1, -1025.579956, 305.342987, 135.737, 4.129651, 0, 0, 0.88043, -0.474177, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55050, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55051, 181392, 1, -1027.849976, 301.919281, 139.237, 4.121787, 0, 0, 0.882286, -0.470713, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55051, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55052, 181392, 1, -1023.356018, 308.676056, 139.297998, 0.988048, 0, 0, 0.474173, 0.880432, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55052, 1);

UPDATE `gameobject` SET `position_x`= -1028.280029, `position_y`= 307.638, `position_z`= 135.645996, `orientation`= 5.90386, `rotation2`= 0.188526, `rotation3`= -0.982068 WHERE `guid`= 50815;

UPDATE `gameobject` SET `position_x`= -1028.713989, `position_y`= 306.373260, `position_z`= 136.635590, `orientation`= 1.218961 WHERE `guid`= 52681;

UPDATE `gameobject` SET `position_x`= -1025.785278, `position_y`= 307.362061, `position_z`= 135.710632, `orientation`= 4.408456 WHERE `guid`= 50881;

UPDATE `gameobject` SET `position_x`= -1024.372803, `position_y`= 301.703949, `position_z`= 135.746155, `orientation`= 3.941922 WHERE `guid`= 50698;

UPDATE `gameobject` SET `position_x`= -1022.721985, `position_y`= 302.327454, `position_z`= 135.745941, `orientation`= 4.00972 WHERE `guid`= 50766;

UPDATE `gameobject` SET `position_x`= -1023.349365, `position_y`= 302.138092, `position_z`= 136.989090, `orientation`= 3.404959 WHERE `guid`= 50774;

-- Adjusting position of Festival Talespinner

UPDATE `creature` SET `position_x`= -1038.963013, `position_y`= 291.748016, `position_z`= 135.723007, `orientation`= 4.214638 WHERE `guid`= 94858;

-- Changing 2 Celebrants to Fireeaters and adjusting position

UPDATE `creature` SET `id`= 17050, `modelid`= 0, `position_x`= -1044.517212, `position_y`= 298.881165, `position_z`= 135.177994, `orientation`= 0.287644 WHERE `guid`= 94627;

UPDATE `creature` SET `id`= 17050, `modelid`= 0, `position_x`= -1040.790771, `position_y`= 303.779572, `position_z`= 135.085327, `orientation`= 4.575921 WHERE `guid`= 94628;

-- Adding Festival Flamekeeper

DELETE FROM creature WHERE guid = 95009;
DELETE FROM game_event_creature_data WHERE guid = 95009;
DELETE FROM game_event_creature WHERE guid = 95009 AND event = 1;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95009, 16788, 1, 0, 0, -1032.178711, 291.725474, 135.746017, 5.168897, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (95009, 16788, 0, 0, 29244, 29244, 1);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95009,1);

-- Removing 2 remaining Celebrants

DELETE FROM `creature` WHERE `guid` IN (94531, 94547);

DELETE FROM `game_event_creature` WHERE `guid` IN (94531, 94547);

DELETE FROM `creature_addon` WHERE `guid` IN (94531, 94547);

-- ************************************************************
-- Changing Orgrimmar Event Area
-- Adjusting Flame of Orgrimmar to correct model

UPDATE `gameobject_template` SET `displayId`= 6755 WHERE `entry`= 181336;

-- Removing Torch Target Braziers

DELETE FROM `gameobject` WHERE `guid` IN (50963, 50944, 50960, 50964, 50951);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50963, 50944, 50960, 50964, 50951);

-- Adjusting flame + trap + Music Doodad position

UPDATE `gameobject` SET `position_x`= 1952.989990, `position_y`= -4271.149902, `position_z`= 30.582199, `orientation`= 4.163355, `rotation2`= 0.104528, `rotation3`= -0.994522 WHERE `guid` IN (50987, 52524, 50564);

-- Adjusting Ribbon Pole position

UPDATE `gameobject` SET `position_x`= 1970.861694, `position_y`= -4272.415039, `position_z`= 31.572199, `orientation`= 3.050056 WHERE `guid`= 51038;

-- Adding 2 braziers

DELETE FROM gameobject WHERE guid BETWEEN 55053 AND 55057;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55053 AND 55057;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55053, 181355, 1, 1959.713501, -4274.917969, 30.922344, 4.110346, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55053, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55054, 181355, 1, 1965.048462, -4280.224609, 29.808430, 3.709791, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55054, 1);

-- Adding Festival Tent plus decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55055, 181301, 1, 1984.260010, -4281.899902, 28.079399, 3.301377, 0, 0, 0.99681, -0.0798087, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55055, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55056, 181392, 1, 1980.330688, -4282.589844, 31.505100, 3.289589, 0, 0, 0.997263, -0.0739311, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55056, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55057, 181392, 1, 1988.210205, -4281.278809, 31.555100, 0.179410, 0, 0, 0.0895847, 0.995979, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55057, 1);

UPDATE `gameobject` SET `position_x`= 1982.112915, `position_y`= -4283.093262, `position_z`= 28.375153, `orientation`= 1.154067 WHERE `guid`= 50833;

UPDATE `gameobject` SET `position_x`= 1982.090820, `position_y`= -4284.826660, `position_z`= 29.140230, `orientation`= 1.183139 WHERE `guid`= 50923;

UPDATE `gameobject` SET `position_x`= 1980.060303, `position_y`= -4281.240723, `position_z`= 28.909554, `orientation`= 3.261298 WHERE `guid`= 50765;

UPDATE `gameobject` SET `position_x`= 1982.680054, `position_y`= -4280.770020, `position_z`= 29.966400, `orientation`= 3.09305, `rotation2`= 0.999705, `rotation3`= 0.0242711 WHERE `guid`= 50773;

-- Adjusting Festival Talespinner position

UPDATE `creature` SET `position_x`= 1946.978271, `position_y`= -4280.548828, `position_z`= 29.428894, `orientation`= 4.538936 WHERE `guid`= 94861;

-- Adding Flamekeeper

DELETE FROM creature WHERE guid = 95010;
DELETE FROM game_event_creature_data WHERE guid = 95010;
DELETE FROM game_event_creature WHERE guid = 95010 AND event = 1;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95010, 16788, 1, 0, 0, 1953.880127, -4278.317383, 30.072861, 4.117185, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (95010, 16788, 0, 0, 29243, 29243, 1);


INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95010,1);

-- Changing 3 Celebrants to Fireeaters and adjusting position

UPDATE `creature` SET `id`= 17041, `modelid`= 0, `position_x`= 1958.104858, `position_y`= -4279.344238, `position_z`= 29.902580, `orientation`= 4.373998 WHERE `guid`= 94629;

UPDATE `creature` SET `id`= 17041, `modelid`= 0, `position_x`= 1957.071533, `position_y`= -4283.166504, `position_z`= 29.028059, `orientation`= 1.310948 WHERE `guid`= 94630;

UPDATE `creature` SET `id`= 17041, `modelid`= 0, `position_x`= 1963.100952, `position_y`= -4291.017578, `position_z`= 27.349636, `orientation`= 2.210230 WHERE `guid`= 94530;

-- Removing remaining Celebrant

DELETE FROM `creature` WHERE `guid`= 94597;

DELETE FROM `game_event_creature` WHERE `guid`= 94597;

DELETE FROM `creature_addon` WHERE `guid`= 94597;-- Adding Dungeon Flames

-- Flame of Stratholme + trap

DELETE FROM gameobject WHERE guid BETWEEN 55000 AND 55007;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55000 AND 55007;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55000, 181348, 329, 3685.874756, -3163.117686, 126.721336, 3.79137, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55000, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55001, 181376, 329, 3685.874756, -3163.117686, 126.721336, 3.79137, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55001, 1);

-- Flame of Scholomance + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55002, 181349, 289, 95.805183, 65.143349, 97.732285, 0.462622, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55002, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55003, 181376, 289, 95.805183, 65.143349, 97.732285, 0.462622, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55003, 1);

-- Flame of Dire Maul + trap

-- Correcting typo

UPDATE `gameobject_template` SET `displayId`= 6756 WHERE `entry`= 181346;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55004, 181346, 429, 536.585938, 602.549683, -4.754742, 5.746147, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55004, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55005, 181376, 429, 536.585938, 602.549683, -4.754742, 5.746147, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55005, 1);

-- Flame of Blackrock Spire + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55006, 181347, 229, -15.528411, -364.131348, 49.609948, 6.234912, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55006, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55007, 181376, 229, -15.528411, -364.131348, 49.609948, 6.234912, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55007, 1);-- *************************************************************
-- Adding Stations for Darkshore, Ashenvale, The Barrens and 
-- Stonetalon
-- *************************************************************

-- Creating Darkshore area station

-- Adding Flame of Darkshore + trap
DELETE FROM gameobject WHERE guid IN (55058, 55068);
DELETE FROM game_event_gameobject WHERE guid IN (55058, 55068);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55058, 181563, 1, 4373.799805, 222.264008, 51.9646, 2.93812, 0, 0, 0.994829, 0.101563, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55058, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55068, 181376, 1, 4373.799805, 222.264008, 51.9646, 2.93812, 0, 0, 0.994829, 0.101563, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55068, 1);

-- Adding Festival Tent plus decorations
DELETE FROM gameobject WHERE guid BETWEEN 55059 AND 55067;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55059 AND 55067;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55059, 181301, 1, 4365.770020, 229.151001, 53.441299, 2.36164, 0, 0, 0.924919, 0.380165, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55059, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55060, 181392, 1, 4368.569824, 231.994995, 56.844002, 0.781851, 0, 0, 0.381044, 0.924557, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55060, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55061, 181392, 1, 4362.939941, 226.328003, 56.887501, 3.915588, 0, 0, 0.926046, -0.377411, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55061, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55062, 181305, 1, 4363.600098, 229.546997, 53.518799, 0.361213, 0, 0, 0.179626, 0.983735, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55062, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55064, 181388, 1, 4363.402832, 229.911957, 54.511944, 1.930352, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55064, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55065, 181302, 1, 4369.309082, 228.704742, 52.986015, 5.751314, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55065, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55066, 181302, 1, 4367.660156, 227.104004, 52.902599, 2.04816, 0, 0, 0.854237, 0.519884, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55066, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55067, 181302, 1, 4368.864746, 227.733597, 54.165325, 0.148906, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55067, 1);

-- Adding Ribbon Pole
DELETE FROM gameobject WHERE guid BETWEEN 55069 AND 55070;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55069 AND 55070;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55069, 181605, 1, 4367.744141, 217.926193, 52.576050, 0.621974, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55069, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55070, 181355, 1, 4362.059082, 225.520432, 53.225056, 0.107539, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (55070, 1);

-- Adding Midsummer Celebrants x 3
DELETE FROM creature WHERE guid BETWEEN 95011 AND 95013;
DELETE FROM creature_addon WHERE guid BETWEEN 95011 AND 95013;
DELETE FROM game_event_creature WHERE guid BETWEEN 95011 AND 95013;
DELETE FROM game_event_creature_data WHERE guid BETWEEN 95011 AND 95013;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95011, 16781, 1, 16442, 0, 4376.079590, 217.106186, 51.841034, 3.325726, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95011,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95011, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (95011, 0, 16442, 0, 0, 0, 1);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95012, 16781, 1, 16431, 0, 4371.717285, 216.442398, 52.289520, 0.152716, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95012,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95012, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (95012, 0, 16431, 0, 0, 0, 1);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95013, 16781, 1, 16431, 0, 4373.311523, 228.445236, 52.545147, 3.934414, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95013,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95013, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (95013, 0, 16431, 0, 0, 0, 1);

-- Creating Ashenvale area station

-- Adding Flame of Ashenvale + trap
DELETE FROM gameobject WHERE guid BETWEEN 55071 AND 55076;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55071 AND 55076;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55071, 181561, 1, 1919.910034, -2037.510010, 103.607002, 1.81061, 0, 0, 0.786613, 0.617446, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55071, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55072, 181376, 1, 1919.910034, -2037.510010, 103.607002, 1.81061, 0, 0, 0.786613, 0.617446, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55072, 1);

-- Creating The Barrens area station

-- Adding Flame of the Barrens + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55073, 181560, 1, -912.270020, -3348.790039, 94.522102, 0.097327, 0, 0, 0.0486443, 0.998816, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55073, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55074, 181376, 1, -912.270020, -3348.790039, 94.522102, 0.097327, 0, 0, 0.0486443, 0.998816, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55074, 1);

-- Creating Stonetalon area station

-- Adding Flame of Stonetalon + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55075, 181562, 1, 553.571543, 348.186523, 53.396599, 5.998054, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55075, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55076, 181376, 1, 553.571543, 348.186523, 53.396599, 5.998054, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55076, 1);

-- Creating the Winterspring area station

-- Adding Flame of Winterspring + trap
DELETE FROM gameobject WHERE guid BETWEEN 55147 AND 55168;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55147 AND 55168;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55147, 181340, 1, 6492.490234, -2498.570068, 568.147021, 3.07177, 0, 0, 0.999391, 0.0349056, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55147, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55148, 181376, 1, 6492.490234, -2498.570068, 568.147021, 3.07177, 0, 0, 0.999391, 0.0349056, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55148, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55149, 181301, 1, 6487.939941, -2489.810059, 567.856995, 3.40635, 0, 0, 0.991251, -0.131993, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55149, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55150, 181392, 1, 6491.844238, -2488.768555, 571.342004, 0.252197, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55150, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55151, 181392, 1, 6483.992188, -2490.926025, 571.377007, 3.4095, 0, 0, 0.991042, -0.133552, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55151, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55152, 181305, 1, 6490.808105, -2489.089111, 568.227539, 2.871499, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55152, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55153, 181302, 1, 6484.049316, -2488.093994, 567.636780, 1.874043, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55153, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55154, 181302, 1, 6484.025879, -2488.252441, 568.880371, 5.011691, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55154, 1);

-- Adding Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55155, 181605, 1, 6483.430664, -2476.308838, 569.403809, 3.313632, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55155, 1);

-- Creating the Azshara area station

-- Adding Flame of Azshara + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55156, 181342, 1, 3879.189941, -5377.359863, 141.001999, 5.33246, 0, 0, 0.457661, -0.8891247, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55156, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55157, 181376, 1, 3879.189941, -5377.359863, 141.001999, 5.33246, 0, 0, 0.457661, -0.8891247, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55157, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55158, 181301, 1, 3881.290039, -5389.700195, 141.324997, 4.362501, 0, 0, 0.819388, -0.573239, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55158, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55159, 181392, 1, 3877.580078, -5388.379883, 144.908005, 2.79169, 0, 0, 0.984735, 0.174059, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55159, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55160, 181392, 1, 3885.060059, -5391.129883, 144.796005, 5.94428, 0, 0, 0.168641, -0.985678, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55160, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55161, 181305, 1, 3879.149902, -5388.930176, 140.968994, 0.452771, 0, 0, 0.224457, 0.974484, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55161, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55162, 181307, 1, 3879.249023, -5389.719727, 141.960236, 5.192645, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55162, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55164, 181307, 1, 3879.585938, -5388.280762, 141.972992, 2.047124, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55164, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55165, 181302, 1, 3883.300049, -5388.390137, 141.580002, 0.51874, 0, 0, 0.256472, 0.966552, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55165, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55166, 181302, 1, 3884.469971, -5389.629883, 141.459, 0.982896, 0, 0, 0.471903, 0.88165, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55166, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55167, 181355, 1, 3886.889648, -5385.532227, 141.874496, 1.301178, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55167, 1);

-- Adding Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55168, 181605, 1, 3897.534424, -5389.211426, 139.648697, 2.659907, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55168, 1);

-- Adding Celebrants
DELETE FROM creature WHERE guid BETWEEN 95029 AND 95030;
DELETE FROM game_event_creature WHERE guid BETWEEN 95029 AND 95030;
DELETE FROM creature_addon WHERE guid BETWEEN 95029 AND 95030;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95029, 16781, 1, 16431, 0, 3880.343994, -5385.739258, 141.409454, 1.285683, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95029,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95029, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95030, 16781, 1, 16431, 0, 3881.667725, -5382.371094, 141.834702, 4.258420, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95030,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95030, 0, 0, 1, 16, 0, 0, NULL);

-- Creating the Un'goro area station

-- Adding Flame of Un'goro + trap
DELETE FROM gameobject WHERE guid BETWEEN 55169 AND 55194;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55169 AND 55194;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55169, 181343, 1, -7838, -2068.179932, -271.778992, 0.446949, 0, 0, 0.221619, 0.975133, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55169, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55170, 181376, 1, -7838, -2068.179932, -271.778992, 0.446949, 0, 0, 0.221619, 0.975133, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55170, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55171, 181301, 1, -7828.620117, -2060.540039, -271.688995, 4.07473, 0, 0, 0.893116, -0.449826, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55171, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55172, 181392, 1, -7831.839844, -2058.199951, -268.192993, 2.51886, 0, 0, 0.951915, 0.306361, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55172, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55173, 181392, 1, -7825.399902, -2062.919922, -268.197998, 5.629815, 0, 0, 0.320903, -0.947112, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55173, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55174, 181302, 1, -7285.3125, -2058.766846, -271.788208, 4.933961, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55174, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55175, 181302, 1, -7826.498535, -2057.897705, -271.817932, 5.220634, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55175, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55176, 181302, 1, -7825.757324, -2058.004639, -270.616730, 1.399671, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55176, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55177, 181302, 1, -7828.419922, -2064.580078, -271.371002, 3.64936, 0, 0, 0.967944, -0.251165, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55177, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55178, 181302, 1, -7829.059570, -2066.142822, -271.318359, 3.213942, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55178, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55179, 181355, 1, -7830.569824, -2070.489990, -271.670013, 1.839018, 0, 0, 0.795305, 0.60621, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55179, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55180, 181355, 1, -7838.819824, -2058.350098, -272.071014, 4.799968, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55180, 1);

-- Adding Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55181, 181605, 1, -7823.888184, -2049.480713, -272.871582, 4.074018, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55181, 1);

-- Adding Celebrants
DELETE FROM creature WHERE guid BETWEEN 95031 AND 95032;
DELETE FROM game_event_creature WHERE guid BETWEEN 95031 AND 95032;
DELETE FROM creature_addon WHERE guid BETWEEN 95031 AND 95032;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95031, 16781, 1, 16431, 0, -7841.166016, -2061.074219, -271.908875, 0.535801, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95031,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95031, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95032, 16781, 1, 16433, 0, -7836.196777, -2059.242676, -271.733551, 3.536021, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95032,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95032, 0, 0, 1, 16, 0, 0, NULL);

-- Creating the Silithus area station

-- Adding Flame of Silithus + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55182, 181339, 1, -6395.720215, -176.996994, 7.623330, 6.27133, 0, 0, 0.00592982, -0.999982, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55182, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55183, 181376, 1, -6395.720215, -176.996994, 7.623330, 6.27133, 0, 0, 0.00592982, -0.999982, 180, 100, 1);


INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55183, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55184, 181301, 1, -6385.990234, -179.253998, 7.901400, 2.455040, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55184, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55185, 181392, 1, -6382.850098, -181.813004, 11.367800, 5.608418, 0, 0, 0.331018, -0.943624, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55185, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55186, 181392, 1, -6389.210938, -176.719482, 11.401830, 2.439336, 0, 0, 0.938986, 0.343956, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55186, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55187, 181305, 1, -6387.890137, -182.302002, 7.673500, 2.513937, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55187, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55188, 181388, 1, -6388.390137, -182.401001, 8.663651, 2.513937, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55188, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55189, 181302, 1, -6387.562988, -175.771622, 8.371091, 4.094521, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55189, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55190, 181302, 1, -6388.382324, -177.018799, 8.267485, 3.265926, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55190, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55191, 181302, 1, -6388.369141, -176.692612, 9.500423, 3.383742, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55191, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55192, 181355, 1, -6384.713867, -189.082260, 6.954593, 1.781520, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55192, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55193, 181306, 1, -6382.580566, -178.797241, 8.224311, 3.305194, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55193, 1);

-- Adding Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55194, 181605, 1, -6391.829590, -194.590179, 5.218790, 1.686483, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55194, 1);


-- Adding Celebrants
DELETE FROM creature WHERE guid BETWEEN 95033 AND 95034;
DELETE FROM game_event_creature WHERE guid BETWEEN 95033 AND 95034;
DELETE FROM creature_addon WHERE guid BETWEEN 95033 AND 95034;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95033, 16781, 1, 16412, 0, -6392.991699, -183.166443, 7.490734, 5.225489, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95033,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95033, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95034, 16781, 1, 16434, 0, -6392.391602, -184.935608, 7.267998, 1.883618, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95034,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95034, 0, 0, 1, 16, 0, 0, NULL);-- Creating Westfall area station

-- Adding Flame of Westfall + trap
DELETE FROM gameobject WHERE guid BETWEEN 55077 AND 55146;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55077 AND 55146;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55077, 181565, 0, -11276.900391, 1851.439941, 40.17800, 2.18846, 0, 0, 0.888575, 0.458732, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55077, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55078, 181376, 0, -11276.900391, 1851.439941, 40.17800, 2.18846, 0, 0, 0.888575, 0.458732, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55078, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55079, 181301, 0, -11277.303711, 1836.428345, 39.835659, 3.156183, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55079, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55080, 181392, 0, -11273.5, 1837.800049, 43.394100, 0.379795, 0, 0, 0.188758, 0.982024, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55080, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55081, 181392, 0, -11281.052734, 1835.008301, 43.317999, 3.522177, 0, 0, 0.981949, -0.189147, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55081, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55082, 181302, 0, -11281.900391, 1839.619995, 40.031601, 3.317979, 0, 0, 0, -0.1891, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55082, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55083, 181302, 0, -11280.400391, 1839.640015, 40.066898, 3.48164, 0, 0, 0.985581, -0.169207, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55083, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55084, 181302, 0, -11281.288086, 1839.536621, 41.274647, 0.651846, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55084, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55085, 181306, 0, -11282.239258, 1834.550781, 39.147171, 3.58924, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55085, 1);

-- Creating Wetlands area station

-- Adding Flame of Wetlands + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55086, 181567, 0, -2616.469974, -2529.409912, 79.190399, 4.55157, 0, 0, 0.761619, -0.648025, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55086, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55087, 181376, 0, -2616.469974, -2529.409912, 79.190399, 4.55157, 0, 0, 0.761619, -0.648025, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55087, 1);

-- Adding Midsummer Celebrant
DELETE FROM creature WHERE guid BETWEEN 95014 AND 95028;
DELETE FROM game_event_creature WHERE guid BETWEEN 95014 AND 95028;
DELETE FROM creature_addon WHERE guid BETWEEN 95014 AND 95028;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95014, 16781, 0, 16431, 0, -2622.926514, -2530.955322, 79.228798, 2.226024, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95014,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95014, 0, 0, 1, 16, 0, 0, NULL);

-- Creating Hillsbrad area station

-- Adding Flame of Hillsbrad + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55088, 181566, 0, -325.529999, -674.729980, 54.654800, 5.56236, 0, 0, 0.352659, -0.935752, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55088, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55089, 181376, 0, -325.529999, -674.729980, 54.654800, 5.56236, 0, 0, 0.352659, -0.935752, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55089, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55090, 181301, 0, -312.201477, -678.40100, 54.975601, 4.655217, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55090, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55091, 181392, 0, -316.066010, -679.268982, 57.778790, 3.32946, 0, 0, 0.995591, -0.0937957, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55091, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55092, 181392, 0, -308.243042, -677.538757, 58.496537, 0.211427, 0, 0, 0.105517, 0.994418, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55092, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55093, 181305, 0, -311.066833, -677.057373, 54.927109, 4.062232, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55093, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55094, 181388, 0, -311.252014, -675.838013, 55.917099, 5.327570, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55094, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55095, 181302, 0, -308.834656, -680.930725, 55.57, 2.85981, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55095, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55096, 181355, 0, -311.295410, -686.493652, 55.817631, 2.388569, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55096, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55097, 181355, 0, -306.818298, -670.257385, 54.478985, 3.209312, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55097, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55098, 181302, 0, -316.533356, -683.004761, 54.904514, 0.810702, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55098, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55099, 181302, 0, -316.510986, -683.215027, 56.147499, 1.977012, 0, 0, 0.935205, 0.549939, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55099, 1);

-- Adding Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55100, 181605, 0, -315.901855, -663.303955, 54.222061, 4.054404, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55100, 1);

-- Adding Midsummer Celebrant

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95015, 16781, 0, 16413, 0, -317.227783, -680.390686, 54.695543, 3.720608, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95015,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95015, 0, 0, 1, 16, 0, 0, NULL);

-- Creating Silverpine area station

-- Adding Flame of Silverpine + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55101, 181564, 0, -278.221985, 1171.189941, 63.659698, 3.4908, 0, 0, 0.984796, -0.173716, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55101, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55102, 181376, 0, -278.221985, 1171.189941, 63.659698, 3.4908, 0, 0, 0.984796, -0.173716, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55102, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55103, 181301, 0, -269.922546, 1162.896729, 63.769085, 2.38731, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55103, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55104, 181392, 0, -267.229004, 1165.739990, 67.296997, 0.80602, 0, 0, 0.392189, 0.919885, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55104, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55105, 181392, 0, -272.692996, 1159.949951, 67.247002, 3.960193, 0, 0, 0.9174, -0.397966, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55105, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55106, 181355, 0, -265.117645, 1168.118530, 63.777679, 2.848847, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55106, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55107, 181305, 0, -266.175995, 1161.180054, 63.654099, 1.32124, 0, 0, 0.613608, 0.789611, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55107, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55108, 181388, 0, -267.658569, 1160.525513, 64.645172, 1.698233, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55108, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55109, 181302, 0, -270.510132, 1159.011841, 63.684921, 3.23683, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55109, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55110, 181302, 0, -270.788361, 1169.002930, 63.717621, 3.5824, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55110, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55111, 181306, 0, -271.760193, 1162.960327, 63.779465, 2.207953, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55111, 1);

-- Adding Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55112, 181605, 0, -263.594330, 1174.463013, 63.781612, 4.517024, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55112, 1);

-- Adding Celebrants

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95016, 16781, 0, 16433, 0, -267.348816, 1158.932495, 63.568790, 2.188314, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95016,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95016, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95017, 16781, 0, 16444, 0, -270.507568, 1160.886597, 63.728283, 6.276309, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95017,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95017, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95018, 16781, 0, 16431, 0, -276.193390, 1164.746216, 63.953812, 3.185755, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95018,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95018, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95019, 16781, 0, 16412, 0, -279.930634, 1163.624756, 64.128166, 0.314335, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95019,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95019, 0, 0, 1, 16, 0, 0, NULL);

-- Creating Plaguelands area station

-- Adding Flame of the Plaguelands + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55113, 181338, 0, 1930.939941, -4411.569824, 73.882004, 4.3395, 0, 0, 0.825927, -0.563777, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55113, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55114, 181376, 0, 1930.939941, -4411.569824, 73.882004, 4.3395, 0, 0, 0.825927, -0.563777, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55114, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55115, 181301, 0, 1918.164917, -4416.745605, 74.486679, 5.105258, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55115, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55116, 181392, 0, 1921.930054, -4415.200195, 77.996399, 0.392881, 0, 0, 0.19518, 0.980768, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55116, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55117, 181392, 0, 1914.469971, -4418.319824, 78.097504, 3.540758, 0, 0, 0.980149, -0.198261, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55117, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55118, 181305, 0, 1921.670044, -4417.410156, 74.493301, 5.205799, 0, 0, 0.513014, -0.85838, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55118, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55119, 181388, 0, 1922.946167, -4417.606934, 75.503891, 0.591722, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55119, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55120, 181306, 0, 1916.794922, -4420.214844, 74.805016, 0.590168, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55120, 1);

-- Adding Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55121, 181605, 0, 1928.430054, -4422.299805, 75.454399, 1.304875, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55121, 1);

-- Adding Celebrants

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95020, 16781, 0, 16433, 0, 1925.090210, -4406.501465, 73.980965, 3.741023, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95020,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95020, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95021, 16781, 0, 16442, 0, 1922.740479, -4407.929688, 74.046410, 0.564086, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95021,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95021, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95022, 16781, 0, 16431, 0, 1935.463745, -4415.734375, 74.295624, 3.643505, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95022,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95022, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95023, 16781, 0, 16448, 0, 1933.085449, -4417.371582, 74.552567, 0.741458, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95023,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95023, 0, 0, 1, 16, 0, 0, NULL);

-- Creating the Hinterlands area station

-- Adding Flame of the Hinterlands + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55122, 181345, 0, 97.891998, -3965.679932, 138.777003, 2.5887, 0, 0, 0.962031, 0.272939, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55122, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55123, 181376, 0, 97.891998, -3965.679932, 138.777003, 2.5887, 0, 0, 0.962031, 0.272939, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55123, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55124, 181301, 0, 111.031998, -3961.179932, 138.227997, 0.813327, 0, 0, 0.395547, 0.918446, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55124, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55125, 181392, 0, 113.910004, -3963.889893, 141.723007, 5.52965, 0, 0, 0.367919, -0.929858, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55125, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55126, 181392, 0, 108.111458, -3958.464111, 141.820999, 2.395897, 0, 0, 0.931294, 0.364268, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55126, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55127, 181355, 0, 107.437759, -3965.104248, 138.655731, 3.198562, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55127, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55128, 181302, 0, 109.987564, -3957.429199, 138.209030, 1.09763, 0, 0, 0.521678, 0.853142, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55128, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55129, 181302, 0, 115.342453, -3960.576904, 138.420593, 0.869869, 0, 0, 0.421351, 0.906898, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55129, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55130, 181305, 0, 104.834999, -3959.060059, 138.535004, 5.436956, 0, 0, 0.410601, -0.911815, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55130, 1);

-- Adding Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55131, 181605, 0, 107.727264, -3972.540771, 137.132431, 2.511345, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55131, 1);

-- Adding Celebrants

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95024, 16781, 0, 16432, 0, 100.626068, -3959.244629, 138.659042, 3.500152, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95024,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95024, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95025, 16781, 0, 16445, 0, 95.138115, -3960.265137, 138.860947, 0.185771, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95025,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95025, 0, 0, 1, 16, 0, 0, NULL);

-- Creating the Searing Gorge area station

-- Adding Flame of Searing Gorge + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55132, 181341, 0, -7186.470215, -1055.660034, 240.326996, 4.48405, 0, 0, 0.783057, -0.62195, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55132, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55133, 181376, 0, -7186.470215, -1055.660034, 240.326996, 4.48405, 0, 0, 0.783057, -0.62195, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55133, 1);

-- Adding Tent + decorations

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55134, 181301, 0, -7184.084473, -1044.486816, 240.515396, 4.503677, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55134, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55135, 181392, 0, -7184.209961, -1040.709961, 244.046005, 1.378683, 0, 0, 0.636028, 0.771666, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55135, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55136, 181392, 0, -7185.910156, -1048.630005, 244.064996, 4.481006, 0, 0, 0.78003, -0.620758, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55136, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55137, 181302, 0, -7188.562988, -1044.328003, 240.668396, 4.339655, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55137, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55138, 181302, 0, -7188.533691, -1044.363525, 241.911346, 5.443135, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55138, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55139, 181302, 0, -7181.200195, -1043.089966, 240.514999, 5.113268, 0, 0, 0.552164, -0.833735, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55139, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55140, 181305, 0, -7183.810059, -1047.829956, 240.516006, 2.03168, 0, 0, 0.849924, 0.526906, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55140, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55141, 181307, 0, -7183.738281, -1047.853149, 241.507141, 2.014400, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55141, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55142, 181388, 0, -7183.057129, -1046.599365, 241.507141, 1.327177, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55142, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55143, 181306, 0, -7183.979980, -1044.109985, 240.514999, 4.802559, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55143, 1);

-- Adding Ribbon Pole

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55144, 181605, 0, -7199.019043, -1052.545288, 241.488159, 5.994596, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55144, 1);

-- Adding Celebrants

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95026, 16781, 0, 16433, 0, -7190.332031, -1049.587036, 240.590393, 4.655375, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95026,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95026, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95027, 16781, 0, 16442, 0, -7180.489258, -1053.551392, 241.471237, 4.875292, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95027,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95027, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95028, 16781, 0, 16448, 0, -7179.443848, -1057.860229, 241.513229, 1.714063, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95028,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95028, 0, 0, 1, 16, 0, 0, NULL);

-- Creating the Blasted Lands area station

-- Adding Flame of the Blasted Lands + trap

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55145, 181344, 0, -11261.270508, -3058.094238, -0.157815, 1.593153, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55145, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55146, 181376, 0, -11261.270508, -3058.094238, -0.157815, 1.593153, 0, 0, 0, 0, 180, 100, 1);

-- Matching IF + Darn Firebreather template to SW, can't be dummy -- templates

UPDATE `creature_template` SET `MinLevel`= 23, `MaxLevel`=33, `FactionAlliance`= 774, `FactionHorde`= 774, `UnitFlags`= 33536, `MinLevelHealth`= 1300, `MaxLevelHealth`= 1500, `MinMeleeDmg`= 46, `MaxMeleeDmg`= 61, `MinRangedDmg`= 32, `MaxRangedDmg`= 47, `Armor`= 1281, `MeleeAttackPower`= 112, `RangedAttackPower`= 10, `MeleeBaseAttackTime`= 2000, `RangedBaseAttackTime`= 2000 WHERE `Entry` IN (17048, 17049);

-- Adding female model to IF Firebreather

UPDATE `creature_template` SET `modelid2`= 16413 WHERE `entry`= 17048;

-- Adding additional model to Darn Firebreather

UPDATE `creature_template` SET `ModelId2`= 16435 WHERE `Entry`= 17049;

-- Adding additional (gender) models for Org, TB and UC 
-- Fireeaters

UPDATE `creature_template` SET `ModelId2`= 16438 WHERE `Entry`= 17041;

UPDATE `creature_template` SET `ModelId2`= 16446 WHERE `Entry`= 17050;

UPDATE `creature_template` SET `ModelId2`= 16444 WHERE `Entry`= 17051;


-- *************************************************************

-- *************************************************************
-- Adding dummy templates for Midsummer Celebrant models
-- *************************************************************
DELETE FROM creature_template WHERE Entry BETWEEN 25870 AND 25878;

INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (25870, 'Midsummer Celebrant Costume: Dwarf', NULL, 1, 1, 16434, 16413, 35, 35, 1, 0, 7, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (25871, 'Midsummer Celebrant Costume: Gnome', NULL, 1, 1, 16447, 16448, 35, 35, 1, 0, 7, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (25872, 'Midsummer Celebrant Costume: Goblin', NULL, 1, 1, 16431, 29243, 35, 35, 1, 0, 7, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (25873, 'Midsummer Celebrant Costume: Human', NULL, 1, 1, 16412, 16433, 35, 35, 1, 0, 7, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');


INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (25874, 'Midsummer Celebrant Costume: Night Elf', NULL, 1, 1, 16414, 16435, 35, 35, 1, 0, 7, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (25875, 'Midsummer Celebrant Costume: Orc', NULL, 1, 1, 16436, 16438, 35, 35, 1, 0, 7, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (25876, 'Midsummer Celebrant Costume: Tauren', NULL, 1, 1, 16442, 16432, 35, 35, 1, 0, 7, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (25877, 'Midsummer Celebrant Costume: Troll', NULL, 1, 1, 16445, 16446, 35, 35, 1, 0, 7, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (25878, 'Midsummer Celebrant Costume: Undead', NULL, 1, 1, 16443, 16444, 35, 35, 1, 0, 7, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- *************************************************************
-- Quest, Item and Spell Fixes
-- *************************************************************

-- Adjusting Cinder Elemental to correct size

UPDATE `creature_template` SET `Scale`= 0 WHERE `Entry`= 17003;

-- Fixing Objective placement in A Light in Dark Places quests

UPDATE `quest_template` SET `ObjectiveText3`= 'Flame of Stratholme', `ObjectiveText4`= 'Flame of the Scholomance' WHERE `entry` IN (9319, 9386);

/* Removing incorrect quest requirement for quest 9386 and making it non-repeatable */

UPDATE `quest_template` SET `PrevQuestId`= 0, `SpecialFlags`= 0 WHERE `entry`= 9386;


/* Correcting Next Quest ID for stealing flames quests. Should be horde -> 9339 and alliance -> 9365  + adding fire festival fortitude buff on each stealing flames quest completion*/

UPDATE `quest_template` SET `NextQuestId`= 9339, `CompleteScript`= 16818 WHERE `entry` IN (9330, 9331, 9332);

UPDATE `quest_template` SET `NextQuestId`= 9365, `CompleteScript`= 16817 WHERE `entry` IN (9324, 9325, 9326);

INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (16817, 0, 15, 29235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Loremaster cast Fire Festival Fortitude');

INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (16818, 0, 15, 29235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Talespinner cast Fire Festival Fortitude');

UPDATE `quest_template` SET `CompleteScript`= 16817 WHERE `entry` IN (9324, 9325, 9326);

UPDATE `quest_template` SET `CompleteScript`= 16818 WHERE `entry` IN (9330, 9331, 9332);

/* Adding correct OfferRewardText for A Thief's Rewards quests and removing incorrect Details and Objectives entries */

UPDATE `quest_template` SET `OfferRewardText`= 'You\'ve proven yourself, today, $n.$b$bWhile I have little else to give you, I do have this crown\; a fitting gift for a conqueror. May it light your way.', `Details`= '', `Objectives`= '' WHERE `entry` IN (9365, 9339);

/* Adding missing details to quest 9386 and swapping objective texts for both quests 9319 and 9386 to match object objectives */

UPDATE `quest_template` SET `RequestItemsText`= 'Have you found your way through the dark?', `ObjectiveText1`= 'Flame of Dire Maul', `ObjectiveText2`= 'Flame of Blackrock Spire', `RewItemId1`= 23083, `RewItemId2`= 23247, `RewItemCount1`= 1, `RewItemCount2`= 10 WHERE `entry`= 9386;

UPDATE `quest_template` SET `ObjectiveText1`= 'Flame of Dire Maul', `ObjectiveText2`= 'Flame of Blackrock Spire' WHERE `entry`= 9319;


/* Updating Blasted Lands station objects according to new screenshots */

-- Adjusting Flame and Trap position

UPDATE `gameobject` SET `position_x`= -11261.900391, `position_y`= -3053.909912, `position_z`= -0.156340, `orientation`= 5.93953 WHERE `guid`= 55145;

UPDATE `gameobject` SET `position_x`= -11261.900391, `position_y`= -3053.909912, `position_z`= -0.156340 WHERE `guid`= 55146;

-- Adding Tent, banners, crates, tables and jug

DELETE FROM gameobject WHERE guid BETWEEN 55204 AND 55214;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55204 AND 55214;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55204, 181301, 0, -11270.900391, -3061.050049, -0.153401, 5.56205, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55204, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55205, 181392, 0, -11273.900391, -3058.439941, 3.388370, 2.424374, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55205, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55206, 181392, 0, -11267.900391, -3603.669922, 3.315840, 5.573808, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55206, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55207, 181302, 0, -11275.200195, -3060.499756, -0.1035, 2.652892, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55207, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55208, 181302, 0, -11275.400391, -3060.678955, 1.140652, 2.326959, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55208, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55209, 181302, 0, -11268.5, -3063.010010, 0.1035, 3.202671, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55209, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55210, 181305, 0, -11273.299805, -3056.960107, -0.033783, 0.080735, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55210, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55211, 181388, 0, -11273.473633, -3055.583496, 0.968239, 0.075235, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55211, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55212, 181307, 0, -11272.541016, -3057.840088, 0.956728, 0.153771, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55212, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55213, 181605, 0, -11280.736328, -3047.902344, -0.157182, 5.942150, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55213, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55214, 181306, 0, -11268.228516, -3060.491211, -0.152213, 0.862024, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55214, 1);

-- Adding Celebrants

DELETE FROM creature WHERE guid BETWEEN 95040 AND 95044;
DELETE FROM game_event_creature WHERE guid BETWEEN 95040 AND 95044;
DELETE FROM creature_addon WHERE guid BETWEEN 95040 AND 95044;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95040, 16781, 0, 16412, 0, -11272.982422, -3051.255615, 0.159584, 6.070206, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95040,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95040, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95041, 16781, 0, 16448, 0, -11267.452148, -3052.153809, 0.116553, 3.098812, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95041,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95041, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95042, 16781, 0, 16446, 0, -11262.132813, -3059.610107, -0.306684, 0.255664, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95042,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95042, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95043, 16781, 0, 16438, 0, -11258.366211, -3058.961670, -0.163597, 3.202472, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95043,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95043, 0, 0, 1, 16, 0, 0, NULL);-- Minor Adjustments to Pavillion and 1 Streamer

UPDATE `gameobject` SET `orientation`= 3.38446 WHERE `guid`= 55090;

UPDATE `gameobject` SET `position_z`= 58.496498, `orientation`= 3.38838 WHERE `guid`= 55091;

-- Adding 1 Celebrant

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95044, 16781, 0, 16431, 0, -322.454071, -681.170715, 54.582485, 0.250718, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95044,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95044, 0, 0, 1, 16, 0, 0, NULL);-- *************************************************************
/* Adding 2 more SW Firebreathers to match screenshot */

DELETE FROM creature WHERE guid BETWEEN 95035 AND 95036;
DELETE FROM game_event_creature WHERE guid BETWEEN 95035 AND 95036;
DELETE FROM creature_addon WHERE guid BETWEEN 95035 AND 95036;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95035, 17038, 0, 0, 0, -8840.254883, 860.392761, 98.643417, 0.990736, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95035,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95035, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95036, 17038, 0, 0, 0, -8838.719727, 862.813232, 98.677147, 4.063140, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95036,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95036, 0, 0, 1, 16, 0, 0, NULL);

/* Adding 3 more crates */
DELETE FROM gameobject WHERE guid BETWEEN 55195 AND 55198;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55195 AND 55198;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55195, 181302, 0, -8837.142578, 868.572571, 98.649353, 5.55539, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55195, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55196, 181302, 0, -8838.290039, 867.385010, 98.659698, 5.55539, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55196, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55197, 181302, 0, -8837.688477, 867.989014, 99.9008, 5.512188, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55197, 1);

-- And one extra brazier

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55198, 181355, 0, -8812.620117, 847.026978, 99.033600, 2.866815, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55198, 1);
-- ************************************************************/* Updating Westfall station objects according to new screenshots */

UPDATE `gameobject` SET `position_x`= -11276.099609, `position_y`= 1826.109985, `position_z`= 38.913601 WHERE `guid`= 55077;

UPDATE `gameobject` SET `position_x`= -11276.099609, `position_y`= 1826.109985, `position_z`= 38.913601 WHERE `guid`= 55078;

UPDATE `gameobject` SET `id`= 181301, `position_x`= -11281.299805, `position_y`= 1811.530029, `position_z`= 39.698502 WHERE `guid`= 55079;

UPDATE `gameobject` SET `position_x`= -11277.5, `position_y`= 1812.910034, `position_z`= 43.152599 WHERE `guid`= 55080;

UPDATE `gameobject` SET `position_x`= -11285.0, `position_y`= 1810.089966, `position_z`= 43.152599 WHERE `guid`= 55081;

UPDATE `gameobject` SET `position_x`= -11285.700195, `position_y`= 1815.140015, `position_z`= 39.594299 WHERE `guid`= 55082;

UPDATE `gameobject` SET `position_x`= -11284.299805, `position_y`= 1815.119995, `position_z`= 39.602001 WHERE `guid`= 55083;

UPDATE `gameobject` SET `position_x`= -11284.799805, `position_y`= 1814.979980, `position_z`= 40.845001 WHERE `guid`= 55084;

UPDATE `gameobject` SET `position_x`= -11285.0, `position_y`= 1811.689941, `position_z`= 40.026001 WHERE `guid`= 55085;

/* Adding 2 Braziers, Table, decoration and Ribbon Pole */
DELETE FROM gameobject WHERE guid BETWEEN 55199 AND 55203;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55199 AND 55203;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55199, 181305, 0, -11279.200195, 1809.140015, 39.544601, 1.871959, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55199, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55200, 181388, 0, -11280.099609, 1809.099976, 40.546700, 1.582934, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55200, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55201, 181605, 0, -11267.5, 1817.160034, 39.174301, 4.959472, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55201, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55202, 181355, 0, -11270.53125, 1816.706177, 39.551220, 3.84264, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55202, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55203, 181355, 0, -11286.0, 1805.979980, 39.745098, 3.84264, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55203, 1);

/* Adding 3 Midsummer Celebrants */
DELETE FROM creature WHERE guid BETWEEN 95037 AND 95039;
DELETE FROM game_event_creature WHERE guid BETWEEN 95037 AND 95039;
DELETE FROM creature_addon WHERE guid BETWEEN 95037 AND 95039;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95037, 16781, 0, 16442, 0, -11273.797852, 1818.903442, 39.669495, 2.012646, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95037,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95037, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95038, 16781, 0, 16431, 0, -11282.905273, 1824.866699, 38.863388, 1.517845, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95038,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95038, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95039, 16781, 0, 16442, 0, -11284.153320, 1828.104004, 38.743839, 5.904294, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95039,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95039, 0, 0, 1, 16, 0, 0, NULL);-- Adjusting position of flame, trap

UPDATE `gameobject` SET `position_x`= -1041.069946, `position_y`= -3434.100098, `position_z`= 70.304398, `orientation`= 0.883685 WHERE `guid`= 55073;

UPDATE `gameobject` SET `position_x`= -1041.069946, `position_y`= -3434.100098, `position_z`= 70.304398 WHERE `guid`= 55074;

/* Adding Pavillion, streamers, table and Ribbon Pole */
DELETE FROM gameobject WHERE guid BETWEEN 55227 AND 55235;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55227 AND 55235;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55227, 181301, 1, -1046.839966, -3423.830078, 71.994400, 2.6562, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55227, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55228, 181392, 1, -1048.709961, -3427.429932, 75.413200, 4.217703, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55228, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55229, 181392, 1, -1045.030029, -3420.389893, 75.518204, 1.080036, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55229, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55230, 181305, 1, -1043.880005, -3420.550049, 72.523602, 5.29093, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55230, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55231, 181388, 1, -1042.970093, -3420.005127, 73.525024, 4.819679, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55231, 1);

/* Adding 3 more camp crates as well */

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55232, 181302, 1, -1047.920044, -3427.040039, 72.194199, 2.02366, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55232, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55233, 181302, 1, -1047.890015, -3425.419922, 72.1893, 1.2683, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55233, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55234, 181302, 1, -1048.060059, -3426.070068, 73.435797, 2.64023, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55234, 1);

/* Ribbon Pole */

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55235, 181605, 1, -1032.652832, -3426.601807, 72.532333, 2.875844, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55235, 1);

/* Adding Midsummer Celebrant x 2 */
DELETE FROM creature WHERE guid BETWEEN 95050 AND 95051;
DELETE FROM game_event_creature WHERE guid BETWEEN 95050 AND 95051;
DELETE FROM creature_addon WHERE guid BETWEEN 95050 AND 95051;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95050, 16781, 1, 16434, 0, -1047.068726, -3432.122803, 71.458862, 5.006632, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95050,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95050, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95051, 16781, 1, 16413, 0, -1045.859741, -3436.854248, 70.766495, 1.650622, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95051,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95051, 0, 0, 1, 16, 0, 0, NULL);-- Adjusting position of flame, trap

UPDATE `gameobject` SET `position_x`= 560.520020, `position_y`= 342.829010, `position_z`= 52.904598 WHERE `guid`= 55075;

UPDATE `gameobject` SET `position_x`= 560.520020, `position_y`= 342.829010, `position_z`= 52.904598 WHERE `guid`= 55076;

/* Adding Pavillion, streamers, table and Ribbon Pole */
DELETE FROM gameobject WHERE guid BETWEEN 55221 AND 55226;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55221 AND 55226;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55221, 181301, 1, 548.839478, 345.732574, 53.274487, 3.950503, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55221, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55222, 181392, 1, 551.593018, 348.585999, 56.825199, 0.856044, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55222, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55223, 181392, 1, 546.090027, 342.786987, 56.825199, 3.95052, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55223, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55224, 181305, 1, 546.492004, 343.041992, 53.213501, 0.753528, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55224, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55225, 181388, 1, 546.316528, 343.170959, 54.204848, 6.278019, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55225, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55226, 181605, 1, 552.390991, 332.783997, 52.913601, 1.545992, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55226, 1);

/* Adding Midsummer Celebrants x4 */
DELETE FROM creature WHERE guid BETWEEN 95046 AND 95049;
DELETE FROM game_event_creature WHERE guid BETWEEN 95046 AND 95049;
DELETE FROM creature_addon WHERE guid BETWEEN 95046 AND 95049;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95046, 16781, 1, 16431, 0, 556.757996, 348.036377, 53.367111, 0.089070, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95046,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95046, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95047, 16781, 1, 16431, 0, 562.158936, 349.072388, 53.653721, 3.446642, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95047,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95047, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95048, 16781, 1, 16442, 0, 554.068726, 338.359894, 53.525078, 6.199457, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95048,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95048, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95049, 16781, 1, 16431, 0, 561.205139, 336.826263, 59.570110, 2.987181, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95049,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95049, 0, 0, 1, 16, 0, 0, NULL);-- Adjusting position of flame, trap and npc

UPDATE `gameobject` SET `position_x`= -2624.469971, `position_y`= -2508.330078, `position_z`= 82.138702 WHERE `guid`= 55086;

UPDATE `gameobject` SET `position_x`= -2624.469971, `position_y`= -2508.330078, `position_z`= 82.138702 WHERE `guid`= 55087;

UPDATE `creature` SET `position_x`= -2629.909912, `position_y`= -2517.419922, `position_z`= 81.178902 WHERE `guid`= 95014;

/* Adding Pavillion, streamers, Brazier, table and Ribbon Pole */
DELETE FROM gameobject WHERE guid BETWEEN 55215 AND 55220;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55215 AND 55220;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55215, 181301, 0, -2639.300049, -2513.320068, 81.394302, 5.483973, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55215, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55216, 181392, 0, -2642.169922, -2510.419922, 84.9776, 2.34858, 0, 0, 0.922416, 0.386197, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55216, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55217, 181392, 0, -2636.489990, -2516.219971, 84.952797, 5.49488, 0, 0, 0.384026, -0.923322, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55217, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55218, 181355, 0, -2631.949951, -2498.020020, 81.0849, 5.330825, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55218, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55219, 181605, 0, -2647.080078, -2499.770020, 79.992897, 5.805990, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55219, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55220, 181305, 0, -2638.989990, -2511.419922, 81.252403, 5.23658, 0, 0, 0.499745, -0.866172, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55220, 1);

-- Adding 1 more Celebrant
DELETE FROM creature WHERE guid = 95045;
DELETE FROM game_event_creature WHERE guid = 95045;
DELETE FROM creature_addon WHERE guid = 95045;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95045, 16781, 0, 16433, 0, -2636.152588, -2510.169434, 81.593987, 5.432929, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95045,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95045, 0, 0, 1, 16, 0, 0, NULL);/* Adding Pavillion, streamers, table, decoration + ribbon pole */

DELETE FROM gameobject WHERE guid BETWEEN 55244 AND 55249;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55244 AND 55249;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55244, 181301, 1, 1939.670044, -2032.560059, 100.454002, 2.864103, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55244, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55245, 181392, 1, 1938.580444, -2036.459961, 104.027997, 4.432524, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55245, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55246, 181392, 1, 1940.729980, -2028.790039, 104.015001, 1.290931, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55246, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55247, 181305, 1, 1926.040039, -2046.599976, 103.142998, 4.99725, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55247, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55248, 181388, 1, 1926.262085, -2046.787476, 104.118317, 2.106959, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55248, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55249, 181605, 1, 1942.170044, -2044.729980, 98.388199, 2.467471, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55249, 1);


/* Adding 2 Midsummer Celebrants */
DELETE FROM creature WHERE guid BETWEEN 95054 AND 95055;
DELETE FROM game_event_creature WHERE guid BETWEEN 95054 AND 95055;
DELETE FROM creature_addon WHERE guid BETWEEN 95054 AND 95055;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95054, 16781, 1, 16435, 0, 1924.703857, -2034.776245, 103.631592, 2.357754, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95054,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95054, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95055, 16781, 1, 16438, 0, 1921.596558, -2031.728638, 103.454041, 5.605379, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95055,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95055, 0, 0, 1, 16, 0, 0, NULL);/* Adding 1 Brazier and 2 camp crates*/

DELETE FROM gameobject WHERE guid BETWEEN 55241 AND 55243;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55241 AND 55243;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55241, 181355, 1, 3872.619385, -5386.805664, 140.272034, 0.934256, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55241, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55242, 181302, 1, 3881.280029, -5393.835449, 142.208817, 0.294152, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55242, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55243, 181302, 1, 3881.315674, -5393.832520, 143.453308, 2.583596, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55243, 1);
/* Adjusting position of pavillion, streamers, table, mug and crates */

UPDATE `gameobject` SET `position_x`= 1969.670044, `position_y`= -4289.609863, `position_z`= 27.055700, `orientation`= 5.94132, `id`= 181301 WHERE `guid`= 55055;

UPDATE `gameobject` SET `position_x`= 1965.959961, `position_y`= -4288.290039, `position_z`= 30.604799, `orientation`= 2.80027 WHERE `guid`= 55056;

UPDATE `gameobject` SET `position_x`= 1973.469971, `position_y`= -4290.899902, `position_z`= 30.478100, `orientation`= 5.93008 WHERE `guid`= 55057;

UPDATE `gameobject` SET `position_x`= 1967.630005, `position_y`= -4287.109863, `position_z`= 28.265699, `orientation`= 5.24521 WHERE `guid`= 50765;

UPDATE `gameobject` SET `position_x`= 1967.569946, `position_y`= -4287.109863, `position_z`= 29.5086, `orientation`= 4.95068 WHERE `guid`= 50773;

UPDATE `gameobject` SET `position_x`= 1968.119995, `position_y`= -4291.75, `position_z`= 27.0353, `orientation`= 2.030257 WHERE `guid`= 50833;

UPDATE `gameobject` SET `position_x`= 1967.560059, `position_y`= -4292.149902, `position_z`= 28.0313, `orientation`= 0.883685 WHERE `guid`= 50923;-- Adding 1 camp crate

DELETE FROM gameobject WHERE guid BETWEEN 55236 AND 55240;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55236 AND 55240;
DELETE FROM gameobject WHERE guid = 55250;
DELETE FROM game_event_gameobject WHERE guid = 55250;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55240, 181302, 0, -7188.770020, -1045.770020, 240.667999, 5.857, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55240, 1);-- Correcting Camp Table position

UPDATE `gameobject` SET `position_x`= 1639.589966, `position_y`= 233.817993, `position_z`= 62.592602, `orientation`= 4.24288 WHERE `guid`= 55042;

-- Correcting camp crates positions

UPDATE `gameobject` SET `position_x`= 1636.339966, `position_y`= 242.705002, `position_z`= 62.591599, `orientation`= 0.218625 WHERE `guid`= 55045;

UPDATE `gameobject` SET `position_x`= 1636.130005, `position_y`= 244.139999, `position_z`= 62.591599, `orientation`= 0.206842 WHERE `guid`= 55046;

UPDATE `gameobject` SET `position_x`= 1636.160034, `position_y`= 243.669006, `position_z`= 63.834702, `orientation`= 2.79635 WHERE `guid`= 55047;

-- Adding damage trap for flame

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55250, 181376, 0, 1642.060059, 239.867004, 62.591579, 0.0009408, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55250, 1);/* Adding 2 Braziers, camp crate and camp jug */

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55236, 181355, 1, 6493.922852, -2479.422852, 570.136475, 5.781697, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55236, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55237, 181355, 1, 6479.264648, -2497.549072, 570.777893, 0.283913, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55237, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55238, 181302, 1, 6485.390137, -2487.693604, 567.797852, 4.642872, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55238, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55239, 181306, 1, 6491.560059, -2491.169922, 568.237976, 0.225009, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55239, 1);

-- Adjusting Camp Table position slightly

UPDATE `gameobject` SET `position_x`= 6489.509766, `position_y`= -2489.870117, `position_z`= 567.874023, `orientation`= 2.8715 WHERE `guid`= 55152;

/* Adding 2 Midsummer Celebrants */
DELETE FROM creature WHERE guid BETWEEN 95052 AND 95053;
DELETE FROM game_event_creature WHERE guid BETWEEN 95052 AND 95053;
DELETE FROM creature_addon WHERE guid BETWEEN 95052 AND 95053;

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95052, 16781, 1, 16432, 0, 6499.048828, -2501.116211, 568.842590, 3.597698, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95052,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95052, 0, 0, 1, 16, 0, 0, NULL);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (95053, 16781, 1, 16435, 0, 6495.344727, -2503.615479, 568.827637, 0.569987, 180, 0, 0, 0, 0, 0, 0);

INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (95053,1);

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES (95053, 0, 0, 1, 16, 0, 0, NULL);/* Changing goblin male midsummer celebrant model from 29243 which didn't exist in vanilla to 15762 (same clothing as dwarf celebrant model) */

UPDATE `creature_template` SET `ModelId2`= 15762 WHERE `Entry`= 25872;

-- Updating Midsummer Bonfire (obj 181288) to Spellfocus

UPDATE `gameobject_template` SET `type`= 8, `displayId`= 0, `data0`= 1365, `data1`= 10, `data2`= 181431, `data10`= 0 WHERE `entry`= 181288;

-- Adding to Capital City Flames

-- IF

DELETE FROM gameobject WHERE guid BETWEEN 55251 AND 55277;
DELETE FROM game_event_gameobject WHERE guid BETWEEN 55251 AND 55277;

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55251, 181288, 0, -4700.28, -1224.34, 501.659, -2.14675, 0, 0, 0.878817, -0.477159, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55251, 1);

-- SW

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55252, 181288, 0, -8833.23, 859.132, 98.8978, -2.07694, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55252, 1);

-- Darnassus

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55253, 181288, 1, 8704.97, 932.636, 14.7263, 3.40724, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55253, 1);

-- Undercity

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55254, 181288, 0, 1642.06, 239.867, 62.5916, 0.0009408, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55254, 1);

-- Orgrimmar

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55255, 181288, 1, 1952.99, -4271.15, 30.5822, 4.16335, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55255, 1);

-- Thunderbluff

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55256, 181288, 1, -1036.25, 297.622, 135.536, 3.7342, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55256, 1);

-- Kalimdor Flames
-- Silithus

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55257, 181288, 1, -6395.72, -176.997, 7.62333, 6.27133, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55257, 1);

-- Winterspring

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55258, 181288, 1, 6493.44, -2497.71, 568.263, 3.07177, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55258, 1);

-- Azshara

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55259, 181288, 1, 3879.19, -5377.36, 141.002, 5.33246, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55259, 1);

-- Un'goro

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55260, 181288, 1, -7838, -2068.18, -271.779, 0.446949, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55260, 1);

-- The Barrens

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55261, 181288, 1, -1041.07, -3434.1, 70.3044, 0.883685, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55261, 1);

-- Ashenvale

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55262, 181288, 1, 1919.91, -2037.51, 103.607, 1.81061, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55262, 1);

-- Stonetalon

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55263, 181288, 1, 560.52, 342.829, 52.9046, 5.99805, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55263, 1);

-- Darkshore

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55264, 181288, 1, 4373.8, 222.264, 51.9646, 2.93812, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55264, 1);

-- Eastern Kingdoms
-- The Plaguelands

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55265, 181288, 0, 1930.94, -4411.57, 73.882, 4.3395, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55265, 1);

-- Searing Gorge

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55266, 181288, 0, -7186.47, -1055.66, 240.327, 4.48405, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55266, 1);

-- Blasted Lands

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55267, 181288, 0, -11261.9, -3053.91, -0.15634, 5.93953, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55267, 1);

-- Hinterlands

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55268, 181288, 0, 97.892, -3965.68, 138.777, 2.5887, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55268, 1);

-- Silverpine

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55269, 181288, 0, -278.222, 1171.19, 63.6597, 3.4908, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55269, 1);

-- Westfall

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55270, 181288, 0, -11276.1, 1826.11, 38.9136, 2.18846, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55270, 1);

-- Hillsbrad

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55271, 181288, 0, -325.53, -674.73, 54.6548, 5.56236, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55271, 1);

-- Wetlands

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55272, 181288, 0, -2624.47, -2508.33, 82.1387, 4.55157, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55272, 1);

-- Dungeon Flames

-- Dire Maul

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55273, 181288, 429, 536.586, 602.55, -4.75474, 5.74615, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55273, 1);

-- LBRS

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55274, 181288, 229, -15.5284, -364.131, 49.6099, 6.23491, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55274, 1);

-- Stratholme

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55275, 181288, 329, 3685.87, -3163.12, 126.721, 3.79137, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55275, 1);

-- Scholomance

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55276, 181288, 289, 95.8052, 65.1433, 97.7323, 0.462622, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55276, 1);

-- Adding missing trap for Westfall Flame

INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (55277, 181376, 0, -11276.1, 1826.11, 38.9136, 2.18846, 0, 0, 0, 0, 180, 100, 1);

INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (55277, 1);

/* Fixing up db warnings for low current health of some npcs. Setting current health to maximum health */

UPDATE `creature` SET `curhealth`= 42 WHERE `id`= 16781;

UPDATE `creature` SET `curhealth`= 1500 WHERE `id`= 17049;

UPDATE `creature` SET `curhealth`= 6800 WHERE `id`= 17041;

UPDATE `creature` SET `curhealth`= 6800 WHERE `id`= 17050;

UPDATE `creature` SET `curhealth`= 1500 WHERE `id`= 17048;

UPDATE `creature` SET `curhealth`= 6900 WHERE `id`= 16788;

UPDATE `creature` SET `curhealth`= 1500 WHERE `id`= 17038;

UPDATE `creature` SET `curhealth`= 6900 WHERE `id`= 16818;

/* Adding complete script entry for flame turn-in quests to quest id from npc id as is currently */

UPDATE `quest_template` SET `CompleteScript`= 9324 WHERE `entry`= 9324;
UPDATE `quest_template` SET `CompleteScript`= 9325 WHERE `entry`= 9325;
UPDATE `quest_template` SET `CompleteScript`= 9326 WHERE `entry`= 9326;
UPDATE `quest_template` SET `CompleteScript`= 9330 WHERE `entry`= 9330;
UPDATE `quest_template` SET `CompleteScript`= 9331 WHERE `entry`= 9331;
UPDATE `quest_template` SET `CompleteScript`= 9332 WHERE `entry`= 9332;

DELETE FROM dbscripts_on_quest_end WHERE id BETWEEN 9324 and 9332;

INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (9324, 0, 15, 29235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Loremaster cast Fire Festival Fortitude');

INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (9325, 0, 15, 29235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Loremaster cast Fire Festival Fortitude');

INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (9326, 0, 15, 29235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Loremaster cast Fire Festival Fortitude');

INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (9330, 0, 15, 29235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Talespinner cast Fire Festival Fortitude');

INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (9331, 0, 15, 29235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Talespinner cast Fire Festival Fortitude');

INSERT INTO `dbscripts_on_quest_end` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (9332, 0, 15, 29235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Talespinner cast Fire Festival Fortitude');

/* Removing incorrect entry */

DELETE FROM `dbscripts_on_quest_end` WHERE `id` IN (16817,16818);/* Removing creature_addon entries for midsummer npcs and adding creature_template_addon entries for each midsummer npc type */

-- Midsummer Celebrant

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 16781);

DELETE FROM creature_template_addon WHERE entry = 16781;
INSERT INTO `creature_template_addon` VALUES (16781, 0, 0, 1, 16, 0, 0, (NULL));

-- Firebreathers

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 17038);

DELETE FROM creature_template_addon WHERE entry = 17038;
INSERT INTO `creature_template_addon` VALUES (17038, 0, 0, 1, 16, 0, 0, (NULL));

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 17048);
UPDATE `creature_template_addon` SET `auras`= '(NULL)' WHERE `entry`= 17048;                                                             

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 17049);

UPDATE `creature_template_addon` SET `auras`= '(NULL)' WHERE `entry`= 17049;                                                             
 

-- Fireeaters

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 17041);

DELETE FROM creature_template_addon WHERE entry = 17041;
INSERT INTO `creature_template_addon` VALUES (17041, 0, 0, 1, 16, 0, 0, (NULL));

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 17050);

DELETE FROM creature_template_addon WHERE entry = 17050;
INSERT INTO `creature_template_addon` VALUES (17050, 0, 0, 1, 16, 0, 0, (NULL));

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 17051);

DELETE FROM creature_template_addon WHERE entry = 17051;
INSERT INTO `creature_template_addon` VALUES (17051, 0, 0, 1, 16, 0, 0, (NULL));

-- Flamekeepers

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 16788);

DELETE FROM creature_template_addon WHERE entry = 16788;
INSERT INTO `creature_template_addon` VALUES (16788, 0, 0, 1, 16, 0, 0, (NULL));

-- Loremasters

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 16817);

-- This npc(16817) already in DB

-- Talespinners

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 16818);

DELETE FROM creature_template_addon WHERE entry = 16818;
INSERT INTO `creature_template_addon` VALUES (16818, 0, 0, 1, 16, 0, 0, (NULL));

-- Deleting wrong version objects and npcs

/* Removing Alliance, Horde, Ahune Bonfires*/

DELETE FROM `gameobject_template` WHERE `name` IN ('Alliance Bonfire', 'Horde Bonfire', 'Ahune Bonfire');


/* Missed deleting Stranglethorn Alliance Station (just outside Booty) on first cleanup, so deleting now */

DELETE FROM `gameobject` WHERE `guid` IN (50681, 50682, 51011, 51028, 51798, 51525, 51797, 50778, 50785, 50781, 50784, 51526, 51545, 50868, 50871, 52541, 52559, 51782, 51799);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (50681, 50682, 51011, 51028, 51798, 51525, 51797, 50778, 50785, 50781, 50784, 51526, 51545, 50868, 50871, 52541, 52559, 51782, 51799);


DELETE FROM `creature` WHERE `guid` IN (94603, 94550, 94551, 94552, 94820, 94839, 94899, 94880);

DELETE FROM `game_event_creature` WHERE `guid` IN (94603, 94550, 94551, 94552, 94820, 94839, 94899, 94880);

DELETE FROM `creature_addon` WHERE `guid` IN (94820, 94839, 94899, 94880);

/* Deleting Midsummer Bonfire + Despawner creature and creature_template entries */

DELETE FROM `creature_template` WHERE `ENTRY` IN (16592, 16606);

DELETE FROM `creature` WHERE `id`= 16592;

DELETE FROM `game_event_creature` WHERE `guid` IN (47614, 94864, 94873, 94910, 94913, 94918);

DELETE FROM `creature_addon` WHERE `guid` IN (47614, 94864, 94873, 94910, 94913, 94918);

DELETE FROM `creature_template_addon` WHERE `entry`= 16592;
-- Instructor Razuvious
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='90', `MinMeleeDmg`='192.2', `MaxMeleeDmg`='254.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='3500', `RangedBaseAttackTime`='3500' WHERE `Entry`='16061';
	-- Deathknight Understudy
	UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='45.5', `ArmorMultiplier`='2', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16803';

-- Gothik the Harvester
UPDATE `creature_template` SET `DamageMultiplier`='27.5', `MinMeleeDmg`='102.2', `MaxMeleeDmg`='135.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='27', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16060';
	-- Unrelenting Trainee [NOBESTIARY]
		-- TO DO
	-- Unrelenting Death Knight
	UPDATE `creature_template` SET `DamageMultiplier`='24', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='16125';
	-- Unrelenting Rider
	UPDATE `creature_template` SET `DamageMultiplier`='22', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133.0', `MeleeAttackPower`='246', `RangedAttackPower`='26' WHERE `Entry`='16126';
	-- Spectral Trainee
	UPDATE `creature_template` SET `DamageMultiplier`='6', `MinMeleeDmg`='98.5', `MaxMeleeDmg`='130.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='244', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16127';
	-- Spectral Deathknight
	UPDATE `creature_template` SET `DamageMultiplier`='24', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='16148';
	-- Spectral Rider
	UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='16150';
	-- Spectral Horse [NO BESTIARY]
		-- TO DO

-- Thane Korth'azz
UPDATE `creature_template` SET `HealthMultiplier`='180', `PowerMultiplier`='2', `DamageMultiplier`='25', `ArmorMultiplier`='1', `MinLevelHealth`='599580', `MaxLevelHealth`='599580', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16064';
	-- Lady Blaumeux
	UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='35', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16065';
	-- Highlord Mograine
	UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='24', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16062';
	-- Sir Zeliek
	UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='35', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16063';

-- Anub'Rekhan
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='35', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15956';
	-- Crypt Guard
		UPDATE `creature_template` SET `DamageMultiplier`='30', `MinMeleeDmg`='52.9', `MaxMeleeDmg`='70.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1000', `RangedBaseAttackTime`='1000' WHERE `Entry`='16573';
	-- Corpse Scarab [NOBESTIARY][NODMGMULT]
	UPDATE `creature_template` SET `Scale`='0', `HealthMultiplier`='2', `DamageMultiplier`='1', `ArmorMultiplier`='1', `MinLevelHealth`='6104', `MaxLevelHealth`='6104', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='52', `MaxMeleeDmg`='68.9', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1000', `RangedBaseAttackTime`='1000' WHERE `Entry`='16698';

-- Grand Widow Faerlina
UPDATE `creature_template` SET `PowerMultiplier`='20', `DamageMultiplier`='50', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15953';
	-- Naxxramas Worshipper
		-- TO DO
	-- Naxxramas Follower
		-- TO DO

-- Maexxna
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='50', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15952';
	-- Maexxna Spiderling
	UPDATE `creature_template` SET `HealthMultiplier`='1.25', `DamageMultiplier`='1.5', `MinLevelHealth`='3815', `MaxLevelHealth`='3815', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='17055';

-- Patchwerk [NODMGMULT]

-- Grobbulus
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='40', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15931';
	-- Grobbulus Cloud [NOBESTIARY]
	UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `SpeedWalk`=('0.01' / '2.5'), `SpeedRun`=('0.01' / '7'), `HealthMultiplier`='1.35', `ArmorMultiplier`='1', `MinLevelHealth`='4120', `MaxLevelHealth`='4120', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='16363';
	-- Fallout Slime
	UPDATE `creature_template` SET `Scale`='0', `PowerMultiplier`='2', `DamageMultiplier`='32', `MinMeleeDmg`='93.5', `MaxMeleeDmg`='124.1', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='16290';
	-- Sewage Slime [NOSNIFF]
		-- TO DO

-- Gluth
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='45', `MinMeleeDmg`='87.9', `MaxMeleeDmg`='116.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600' WHERE `Entry`='15932';
	-- Zombie Chow [NOBESTIARY]
	UPDATE `creature_template` SET `ModelId2`='10975', `ModelId3`='5432', `ModelId4`='5265', `HealthMultiplier`='40', `PowerMultiplier`='3', `ArmorMultiplier`='1', `MinLevelHealth`='122080', `MaxLevelHealth`='122080', `MinMeleeDmg`='155.9', `MaxMeleeDmg`='206.8', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='3000', `RangedBaseAttackTime`='3000' WHERE `Entry`='16360';

-- Thaddius
UPDATE `creature_template` SET `HealthMultiplier`='2000', `PowerMultiplier`='2', `DamageMultiplier`='50', `ArmorMultiplier`='1', `MinLevelHealth`='6662000', `MaxLevelHealth`='6662000', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='109.9', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15928';
	-- Stalagg
	UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='56.25', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15929';
	-- Feugen
	UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='56.25', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15930';

-- Noth the Plaguebringer
UPDATE `creature_template` SET `HealthMultiplier`='500', `PowerMultiplier`='30', `DamageMultiplier`='50', `ArmorMultiplier`='1', `MinLevelHealth`='1665500', `MaxLevelHealth`='1665500', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15954';
	-- Plagued Warrior [NOBESTIARY]
		-- TO DO
	-- Plagued Champion [NOBESTIARY]
		-- TO DO
	-- Plagued Guardian [NOSNIFF]
		-- TO DO

-- Heigan
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='50', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15936';

-- Loatheb
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='80', `MinMeleeDmg`='68.6', `MaxMeleeDmg`='91.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='1250', `RangedBaseAttackTime`='1250' WHERE `Entry`='16011';
	-- Spore
	UPDATE `creature_template` SET `HealthMultiplier`='0.1', `ArmorMultiplier`='1', `MinLevelHealth`='305', `MaxLevelHealth`='305', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='16286';

-- Sapphiron
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='70', `MinMeleeDmg`='98.9', `MaxMeleeDmg`='131.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='15989';
	-- Blizzard [NOBESTIARY]
	UPDATE `creature_template` SET `MinLevel`='63', `MaxLevel`='63', `Rank`='3', `ArmorMultiplier`='1', `MinLevelHealth`='3331', `MaxLevelHealth`='3331', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16474';
	-- Sapphiron's Wing Buffet [NOTEMPLATE][NOBESTIARY]
		-- TO DO

-- Kel'Thuzad
UPDATE `creature_template` SET `UnitClass`='2', `HealthMultiplier`='1200', `PowerMultiplier`='600', `DamageMultiplier`='62.5', `ArmorMultiplier`='1', `MinLevelHealth`='3198000', `MaxLevelHealth`='3198000', `MinMeleeDmg`='102.2', `MaxMeleeDmg`='135.3', `MeleeAttackPower`='252', `RangedAttackPower`='27', `MeleeBaseAttackTime`='2000' WHERE `Entry`='15990';
	-- Unstoppable Abimonation [NOBESTIARY]
		-- TO DO
	-- Soldier of the Frozen Wastes
		-- TO DO
	-- Soul Weaver
		-- TO DO
	-- Guardian of Icecrown
	UPDATE `creature_template` SET `Scale`='0', `CreatureTypeFlags`='72', `Rank`='1', `DamageMultiplier`='20', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16441';

-- ----------------------------------------------------------------------------------------------------------------------------------------

-- Infectious Ghoul
UPDATE `creature_template` SET `DamageMultiplier`='35', `MinMeleeDmg`='79.4', `MaxMeleeDmg`='105.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='16244';

-- Plague Slime
UPDATE `creature_template` SET `DamageMultiplier`='60', `MinMeleeDmg`='95.2', `MaxMeleeDmg`='126.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='16243';
	-- Plague Slime (Blue)
	UPDATE `creature_template` SET `DamageMultiplier`='60', `MinMeleeDmg`='95.2', `MaxMeleeDmg`='126.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='16783';
	-- Plague Slime (Red)
	UPDATE `creature_template` SET `DamageMultiplier`='60', `MinMeleeDmg`='95.2', `MaxMeleeDmg`='126.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='16784';
	-- Plague Slime (Green)
	UPDATE `creature_template` SET `DamageMultiplier`='60', `MinMeleeDmg`='95.2', `MaxMeleeDmg`='126.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='16785';

-- Stoneskin Gargoyle
UPDATE `creature_template` SET `UnitClass`='2', `HealthMultiplier`='105', `PowerMultiplier`='10', `DamageMultiplier`='36', `ArmorMultiplier`='1', `MinMeleeDmg`='98.5', `MaxMeleeDmg`='130.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='244', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16168';

-- Mutated Grub
UPDATE `creature_template` SET `DamageMultiplier`='8', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16297';

-- Frenzied Bat
UPDATE `creature_template` SET `Scale`='0', `DamageMultiplier`='6', `MinMeleeDmg`='77.9', `MaxMeleeDmg`='103.1', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='16036';

-- Plagued Bat
UPDATE `creature_template` SET `Scale`='0', `DamageMultiplier`='6', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16037';

-- Plague Beast
UPDATE `creature_template` SET `DamageMultiplier`='22', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16034';

-- Diseased Maggot
UPDATE `creature_template` SET `DamageMultiplier`='12.5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='16056';

-- Rotting Maggot
UPDATE `creature_template` SET `DamageMultiplier`='10', `MinMeleeDmg`='129.9', `MaxMeleeDmg`='172.4', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='16057';

-- Carrion Spinner
UPDATE `creature_template` SET `DamageMultiplier`='22', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15975';

-- Dread Creeper
UPDATE `creature_template` SET `DamageMultiplier`='24', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15974';

-- Necro Stalker [NOSNIFF]
UPDATE `creature_template` SET `DamageMultiplier`='26', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16453';

-- Crypt Reaver
UPDATE `creature_template` SET `DamageMultiplier`='50', `MinMeleeDmg`='63.5', `MaxMeleeDmg`='84.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1200', `RangedBaseAttackTime`='1200' WHERE `Entry`='15978';

-- Venom Stalker
UPDATE `creature_template` SET `DamageMultiplier`='32', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15976';

-- Tomb Horror
UPDATE `creature_template` SET `DamageMultiplier`='32', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15979';

-- Spirit of Naxxramas [NOSNIFF]
UPDATE `creature_template` SET `PowerMultiplier`='10', `DamageMultiplier`='25', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16449';

-- Plagued Ghoul
UPDATE `creature_template` SET `DamageMultiplier`='35', `MinMeleeDmg`='79.4', `MaxMeleeDmg`='105.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='16447';

-- Necropolis Acolyte [NOSNIFF]
UPDATE `creature_template` SET `ModelId2`='16161', `DamageMultiplier`='25', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='246', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16368';

-- Plagued Gargoyle [NOSNIFF]
UPDATE `creature_template` SET `UnitClass`='2', `HealthMultiplier`='100', `PowerMultiplier`='3', `DamageMultiplier`='37.5', `ArmorMultiplier`='1', `MinMeleeDmg`='98.5', `MaxMeleeDmg`='130.4', `MaxRangedDmg`='0', `Armor`='3316', `MeleeAttackPower`='244', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16446';

-- Plagued Deathhound [NOSNIFF]
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='30', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16448';

-- Deathknight Vindicator [NOSNIFF]
UPDATE `creature_template` SET `UnitClass`='2', `HealthMultiplier`='50', `PowerMultiplier`='10', `DamageMultiplier`='40', `ArmorMultiplier`='1', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='246', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16451';

-- Patchwork Golem
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='37.5', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16017';

-- Bile Retcher
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='35', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16018';

-- Sludge Belcher
UPDATE `creature_template` SET `DamageMultiplier`='28', `MinMeleeDmg`='134.9', `MaxMeleeDmg`='178.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='16029';

-- Embalming Slime
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='31.25', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16024';

-- Living Monstrosity
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='27.5', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16021';

-- Surgical Assistant
UPDATE `creature_template` SET `PowerMultiplier`='5', `DamageMultiplier`='15', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16022';

-- Mad Scientist
UPDATE `creature_template` SET `UnitClass`='1', `HealthMultiplier`='16', `PowerMultiplier`='2', `DamageMultiplier`='15', `ArmorMultiplier`='1', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16020';

-- Living Poison
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='9', `MinMeleeDmg`='132.3', `MaxMeleeDmg`='175.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `RangedBaseAttackTime`='2500' WHERE `Entry`='16027';

-- Stitched Spewer
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='37.5', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16025';

-- Toxic Tunnel [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='1.35', `ArmorMultiplier`='1', `MinLevelHealth`='4120', `MaxLevelHealth`='4120', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='16400';

-- Risen Deathknight
UPDATE `creature_template` SET `DamageMultiplier`='22', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16154';

-- Bony Construct
UPDATE `creature_template` SET `PowerMultiplier`='3', `DamageMultiplier`='26', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16167';

-- Skeletal Smith
UPDATE `creature_template` SET `DamageMultiplier`='12', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16193';

-- Doom Touched Warrior [NOSNIFF]
UPDATE `creature_template` SET `DamageMultiplier`='22', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16157';

-- Unholy Axe
UPDATE `creature_template` SET `DamageMultiplier`='34', `MinMeleeDmg`='95.2', `MaxMeleeDmg`='126.3', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='16194';

-- Unholy Swords
UPDATE `creature_template` SET `DamageMultiplier`='22', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16215';

-- Unholy Staff
UPDATE `creature_template` SET `DamageMultiplier`='33', `MinMeleeDmg`='84.7', `MaxMeleeDmg`='112.2', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600' WHERE `Entry`='16216';

SET @GUID  := '42160';
SET @ENTRY := '14479';
SET @POOL  := '25492';

UPDATE `creature_template` SET `SpeedWalk`='1', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000' WHERE `Entry`='14479';

DELETE FROM `creature_movement` WHERE `id` IN (42160, 42161);
DELETE FROM `creature_movement_template` WHERE `entry`= 14479;
DELETE FROM `creature` WHERE `id` = 25492;
DELETE FROM `creature` WHERE `guid` IN (42160, 42161, 42162);

INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID + '0', @ENTRY, '1', '0', '0', '-7952.431', '1900.059', '1.454241', '0.6839152', '21000', '0', '0', '3297', '2434', '0', '2'),
(@GUID + '1', @ENTRY, '1', '0', '0', '-7023.303', '1197.827', '6.639199', '0.2720481', '21000', '0', '0', '3297', '2434', '0', '2'),
(@GUID + '2', @ENTRY, '1', '0', '0', '-6732.618', '1586.897', '10.03530', '0.6052270', '21000', '0', '0', '3297', '2434', '0', '2');

SET @POINT := '0';

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + '0', @POINT := @POINT + '1', '-7933.409', '1915.553', '4.745111', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7899.944', '1913.035', '3.638075', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7880.021', '1903.608', '4.840346', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7874.553', '1886.315', '5.245306', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7896.264', '1870.850', '5.104681', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7912.292', '1852.625', '4.846241', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7913.682', '1834.233', '3.933521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7923.220', '1822.200', '3.554747', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7939.812', '1820.074', '3.946807', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7950.682', '1834.833', '3.785096', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7941.653', '1859.440', '4.833069', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7948.324', '1881.011', '3.527304', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '0', @POINT := @POINT + '1', '-7951.504', '1902.775', '2.120600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @POINT := '0';

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + '1', @POINT := @POINT + '1', '-7008.006', '1202.084', '7.700902', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6995.428', '1208.250', '8.820854', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6979.564', '1207.478', '9.471367', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6957.870', '1199.927', '9.185988', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6946.232', '1190.906', '9.908278', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6949.811', '1169.085', '10.86482', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6962.905', '1163.869', '11.56198', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6964.529', '1154.799', '10.73739', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6976.600', '1144.452', '9.615312', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6984.484', '1136.351', '9.539872', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6981.354', '1123.549', '7.882970', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6985.575', '1116.994', '8.541417', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6994.624', '1117.175', '9.183019', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6998.787', '1125.470', '9.350011', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-6998.452', '1135.539', '8.714189', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7012.332', '1141.683', '6.041239', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7022.462', '1149.656', '6.685770', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7030.819', '1149.059', '6.414530', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7036.089', '1145.387', '6.349092', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7040.804', '1147.568', '6.349092', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7041.828', '1153.085', '6.349092', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7035.541', '1164.167', '6.259127', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7032.510', '1173.299', '6.809674', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7025.639', '1180.353', '6.848492', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + '1', @POINT := @POINT + '1', '-7023.183', '1198.596', '6.662579', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @POINT := '0';

-- INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
-- (@GUID + '2', @POINT := @POINT + '1', '-7008.006', '1202.084', '7.700902', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL, '1', 'Silithus - Twilight Lord Everun');

DELETE FROM `pool_creature_template` WHERE `id`=@ENTRY AND `pool_entry`=@POOL;
INSERT INTO `pool_creature_template` (`id`, `pool_entry`, `chance`, `description`) VALUES
('14479', @POOL, '0', 'Twilight Lord Everun (14479)');
-- Add missing spell script target for 17652
-- creature 10498
DELETE FROM spell_script_target WHERE entry IN (17652);
INSERT INTO spell_script_target (entry,type,targetEntry,inverseEffectMask) VALUES
(17652,1,11263,0);

-- Kurinnaxx
UPDATE `creature_template` SET `DamageMultiplier`='16', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15348';

-- General Rajaxx
UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15341';

	-- Captain Qeez
	UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15391';

	-- Captain Tuubid
	UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15392';

	-- Captain Drenn
	UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15389';

	-- Captain Xurrem
	UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15390';

	-- Major Yeggeth
	UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15386';

	-- Major Pakkon
	UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15388';

	-- Colonel Zerran
	UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15385';

	-- Qiraji Warrior
	UPDATE `creature_template` SET `DamageMultiplier`='6', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15387';

	-- Swarmguard Needler
	UPDATE `creature_template` SET `DamageMultiplier`='9', `MinMeleeDmg`='68.8', `MaxMeleeDmg`='91.2', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15344';

-- Moam
UPDATE `creature_template` SET `DamageMultiplier`='17', `MinMeleeDmg`='102.2', `MaxMeleeDmg`='135.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='27' WHERE `Entry`='15340';

	-- Mana Fiend
	UPDATE `creature_template` SET `MinLevel`='60', `HealthMultiplier`='6', `PowerMultiplier`='5', `DamageMultiplier`='8', `ArmorMultiplier`='1', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15527';

-- Buru
UPDATE `creature_template` SET `DamageMultiplier`='6', `MinMeleeDmg`='127.8', `MaxMeleeDmg`='169.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='27' WHERE `Entry`='15370';

	-- Buru Egg [NOBESTIARY]
		-- TO DO

	-- Buru Egg Trigger [NOBESTIARY]
		-- TO DO

	-- Hive'Zara Hatchling
	UPDATE `creature_template` SET `DamageMultiplier`='6', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='1037.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15521';

-- Ayamiss
UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='65.9', `MaxMeleeDmg`='87.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15369';

	-- Hive'Zara Larva
	UPDATE `creature_template` SET `DamageMultiplier`='0.1', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15555';

	-- Hive'Zara Stinger
	UPDATE `creature_template` SET `DamageMultiplier`='7', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15934';

	-- Hive'Zara Swarmer
	UPDATE `creature_template` SET `DamageMultiplier`='1.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1000', `RangedBaseAttackTime`='1000' WHERE `Entry`='15546';

-- Ossirian the Unscarred
UPDATE `creature_template` SET `DamageMultiplier`='24', `MinMeleeDmg`='98.9', `MaxMeleeDmg`='131.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='15339';

	-- Ossirian Crystal Trigger [NOBESTIARY]
		-- TO DO

	-- Sand Vortex [NOBESTIARY]
		-- TO DO

-- -------------------------------------------------------------------------------------------------------------------------------------------

-- Qiraji Gladiator
UPDATE `creature_template` SET `DamageMultiplier`='24', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15324';

-- Vile Scarab
UPDATE `creature_template` SET `DamageMultiplier`='1.5', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='124.7', `MaxRangedDmg`='0', `MeleeAttackPower`='228', `RangedAttackPower`='23' WHERE `Entry`='15168';

-- Qiraji Swarmguard
UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='79.4', `MaxMeleeDmg`='105.2', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15343';

-- Hive'Zara Wasp
UPDATE `creature_template` SET `DamageMultiplier`='10', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15325';

-- Hive'Zara Stinger
UPDATE `creature_template` SET `DamageMultiplier`='5', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15327';

-- Hive'Zara Sandstalker
UPDATE `creature_template` SET `DamageMultiplier`='7', `MinMeleeDmg`='42.3', `MaxMeleeDmg`='56.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15323';

-- Hive'Zara Soldier
UPDATE `creature_template` SET `DamageMultiplier`='8', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='15320';

-- Flesh Hunter
UPDATE `creature_template` SET `DamageMultiplier`='10', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='15335';

-- Silicate Feeder [NO BESTIARY]
	-- TO DO

-- Hive'Zara Collector
UPDATE `creature_template` SET `DamageMultiplier`='6', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15319';

-- Hive'Zara Drone
UPDATE `creature_template` SET `DamageMultiplier`='5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15318';

-- Hive'Zara Tail Lasher
UPDATE `creature_template` SET `DamageMultiplier`='8', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15336';

-- Anubisath Guardian
UPDATE `creature_template` SET `DamageMultiplier`='12', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='15355';

-- Obsidian Destroyer
UPDATE `creature_template` SET `DamageMultiplier`='14', `MinMeleeDmg`='98.5', `MaxMeleeDmg`='130.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='244', `RangedAttackPower`='25' WHERE `Entry`='15338';

-- Shrieker Scarab
UPDATE `creature_template` SET `DamageMultiplier`='3.4', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15461';

-- Canal Frenzy
UPDATE `creature_template` SET `DamageMultiplier`='4', `MinMeleeDmg`='62.4', `MaxMeleeDmg`='82.7', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='15505';

-- Razorgore the Untamed
UPDATE `creature_template` SET `DamageMultiplier`='11', `MinMeleeDmg`='219.7', `MaxMeleeDmg`='291.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='12435';

	-- Grethok the Controller
	UPDATE `creature_template` SET `MinLevel`='62', `MaxLevel`='62', `HealthMultiplier`='25', `PowerMultiplier`='10', `DamageMultiplier`='18', `ArmorMultiplier`='1', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='246', `RangedAttackPower`='26' WHERE `Entry`='12557';

	-- Blackwing Guardsman
	UPDATE `creature_template` SET `DamageMultiplier`='14', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='14456';

	-- Blackwing Orb Trigger [NOBESTIARY]
	UPDATE `creature_template` SET `FactionAlliance`='35', `FactionHorde`='35', `SpeedWalk`='1', `ArmorMultiplier`='1', `MinLevelHealth`='42', `MaxLevelHealth`='42', `MinMeleeDmg`='1.5', `MaxMeleeDmg`='1.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='15', `MeleeAttackPower`='9', `RangedAttackPower`='0', `RangedBaseAttackTime`='2000' WHERE `Entry`='14453';

	-- Blackwing Spell Marker [NOBESTIARY]
	UPDATE `creature_template` SET `MinMeleeDmg`='1.5', `MaxMeleeDmg`='1.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='15', `MeleeAttackPower`='9', `RangedAttackPower`='0' WHERE `Entry`='16604';

	-- Blackwing Legionnaire
	UPDATE `creature_template` SET `DamageMultiplier`='7', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='12416';

	-- Blackwing Mage
	UPDATE `creature_template` SET `DamageMultiplier`='4', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24' WHERE `Entry`='12420';

	-- Death Talon Dragonspawn
	UPDATE `creature_template` SET `DamageMultiplier`='14', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='12422';

-- Vaelastrasz the Corrupt
UPDATE `creature_template` SET `DamageMultiplier`='35', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='13020';

-- Broodlord Lashlayer
UPDATE `creature_template` SET `DamageMultiplier`='25', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='12017';

-- Firemaw
UPDATE `creature_template` SET `DamageMultiplier`='25', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='11983';

-- Ebonroc
UPDATE `creature_template` SET `DamageMultiplier`='25', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='14601';

-- Flamegor
UPDATE `creature_template` SET `DamageMultiplier`='25', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='11981';

-- Chromaggus
UPDATE `creature_template` SET `DamageMultiplier`='30', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='14020';

	-- Chromatic Drakonid
	UPDATE `creature_template` SET `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14302';

-- Nefarian
UPDATE `creature_template` SET `DamageMultiplier`='35', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4691', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='11583';

	-- Blue Drakonid
	UPDATE `creature_template` SET `DamageMultiplier`='5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14261';

	-- Red Drakonid
	UPDATE `creature_template` SET `DamageMultiplier`='5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14264';

	-- Green Drakonid
	UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14262';

	-- Bronze Drakonid
	UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='5', `DamageMultiplier`='5', `ArmorMultiplier`='1', `MinLevelHealth`='15260', `MaxLevelHealth`='15260', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14263';

	-- Black Drakonid
	UPDATE `creature_template` SET `DamageMultiplier`='5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14265';

	-- Bone Construct
	UPDATE `creature_template` SET `DamageMultiplier`='5', `MinMeleeDmg`='52.0', `MaxMeleeDmg`='69.0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14605';

-- ------------------------------------------------------------------------------------------------------------------------------------------

-- Death Talon Captain
UPDATE `creature_template` SET `DamageMultiplier`='24', `MinMeleeDmg`='129.5', `MaxMeleeDmg`='171.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='12467';

-- Death Talon Flamescale
UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='12463';

-- Death Talon Hatcher
UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='98.5', `MaxMeleeDmg`='130.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='244', `RangedAttackPower`='25' WHERE `Entry`='12468';

-- Death Talon Overseer
UPDATE `creature_template` SET `DamageMultiplier`='22', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='12461';

-- Death Talon Seether
UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30' WHERE `Entry`='12464';

-- Death Talon Wyrmguard
UPDATE `creature_template` SET `DamageMultiplier`='25', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32' WHERE `Entry`='12460';

-- Death Talon Wyrmkin
UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='98.5', `MaxMeleeDmg`='130.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='244', `RangedAttackPower`='25' WHERE `Entry`='12465';

-- Blackwing Technician
UPDATE `creature_template` SET `DamageMultiplier`='5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='13996';

-- Blackwing Spellbinder
UPDATE `creature_template` SET `DamageMultiplier`='15', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='246', `RangedAttackPower`='26' WHERE `Entry`='12457';

-- Blackwing Warlock
UPDATE `creature_template` SET `DamageMultiplier`='15', `MinMeleeDmg`='98.5', `MaxMeleeDmg`='130.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='244', `RangedAttackPower`='25' WHERE `Entry`='12459';

	-- Demon Portal [NOBESTIARY]
	UPDATE `creature_template` SET `MinLevel`='61', `MaxLevel`='61', `ArmorMultiplier`='1', `MinLevelHealth`='3144', `MaxLevelHealth`='3144', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MinLootGold`='0', `MaxLootGold`='0' WHERE `Entry`='14081';

	-- Enraged Felguard
	UPDATE `creature_template` SET `DamageMultiplier`='15', `MinMeleeDmg`='119.5', `MaxMeleeDmg`='158.6', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2300', `RangedBaseAttackTime`='2300', `FactionAlliance`='40', `FactionHorde`='40' WHERE `Entry`='14101';

-- Blackwing Taskmaster
UPDATE `creature_template` SET `DamageMultiplier`='15', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='246', `RangedAttackPower`='26' WHERE `Entry`='12458';

-- Master Elemental Shaper Krixix
UPDATE `creature_template` SET `DamageMultiplier`='3', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14401';

-- Corrupted Red Whelp [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='1.5', `DamageMultiplier`='3', `ArmorMultiplier`='1', `MinLevelHealth`='4578', `MaxLevelHealth`='4578', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14022';

-- Corrupted Green Whelp
UPDATE `creature_template` SET `DamageMultiplier`='3', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14023';

-- Corrupted Blue Whelp
UPDATE `creature_template` SET `DamageMultiplier`='3', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14024';

-- Corrupted Bronze Whelp [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='1.5', `DamageMultiplier`='3', `ArmorMultiplier`='1', `MinLevelHealth`='4578', `MaxLevelHealth`='4578', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='14025';

-- Added missing areatrigger relation to quest 6185 (Eastern Plagues)
-- quest can now be completed
DELETE FROM `areatrigger_involvedrelation` WHERE `id` = 2726;
INSERT INTO `areatrigger_involvedrelation` (`id`, `quest`)
VALUES (2726, 6185);

UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `entry` = 6185;
-- Updated some rare NPCs in the Western and Eastern Plaguelands: stats, waypoints and/or spawn points
UPDATE creature_template SET SpeedWalk=1.1, MeleeAttackPower=110, RangedAttackPower=25, MinMeleeDmg=72, MaxMeleeDmg=100, DamageMultiplier=1.2, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000, UnitFlags=32768 WHERE Entry=10823; -- Zul'Brin Warpbranch
UPDATE creature_template SET SpeedRun=2, MeleeAttackPower=124, RangedAttackPower=12, MinMeleeDmg=51, MaxMeleeDmg=68, DamageMultiplier=1, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000 WHERE Entry=2258; -- Stone Fury
UPDATE creature_template SET SpeedWalk=1.1, MeleeAttackPower=228, RangedAttackPower=23, MinMeleeDmg=94, MaxMeleeDmg=125, DamageMultiplier=1.25, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000 WHERE Entry=10817; -- Duggan Wildhammer
UPDATE creature_template SET SpeedWalk=1.1, MeleeAttackPower=242, RangedAttackPower=25, MinMeleeDmg=100, MaxMeleeDmg=132, DamageMultiplier=1.2, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000 WHERE Entry=1844; -- Foreman Marcrid
UPDATE creature_template SET MeleeAttackPower=258, RangedAttackPower=28, MinMeleeDmg=106, MaxMeleeDmg=140, DamageMultiplier=5.5, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000 WHERE Entry=11896; -- Borelgore
UPDATE creature_template SET FactionAlliance=16, FactionHorde=16, SpeedWalk=1.1,MeleeAttackPower=252, RangedAttackPower=26, MinMeleeDmg=104, MaxMeleeDmg=138, DamageMultiplier=5, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000 WHERE Entry=11897; -- Duskwing
UPDATE creature_template SET MeleeAttackPower=238, RangedAttackPower=24, MinMeleeDmg=98, MaxMeleeDmg=130, DamageMultiplier=1.25, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000 WHERE Entry=10821; -- Hed'mush the Rotting


-- Waypoint movement to Stone Fury (source: PSMDB)
DELETE FROM `creature_movement_template` WHERE `entry` = 2258;
INSERT INTO `creature_movement_template` VALUES
(2258, 1, 664.315, -1027.59, 160.39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.55749, 0, 0),
(2258, 2, 654.02, -1032.34, 163.127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.56752, 0, 0),
(2258, 3, 634.638, -1041.36, 163.816, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.42055, 0, 0),
(2258, 4, 622.304, -1055.48, 163.186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.61123, 0, 0),
(2258, 5, 620.168, -1114.91, 160.186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.09796, 0, 0),
(2258, 6, 627.218, -1131.61, 159.535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.01767, 0, 0),
(2258, 7, 631.939, -1149.35, 155.421, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.67646, 0, 0),
(2258, 8, 629.934, -1192.34, 145.181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.80191, 0, 0),
(2258, 9, 633.981, -1229.12, 136.877, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.82198, 0, 0),
(2258, 10, 634.73, -1271.43, 121.429, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.58112, 0, 0),
(2258, 11, 627.306, -1321.81, 106.197, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.56607, 0, 0),
(2258, 12, 629.422, -1375.57, 93.9589, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.12304, 0, 0),
(2258, 13, 643.925, -1408.88, 87.1831, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.42411, 0, 0),
(2258, 14, 668.443, -1437.6, 81.8552, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.85564, 0, 0),
(2258, 15, 708.689, -1455.94, 81.4619, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.1818, 0, 0),
(2258, 16, 745.689, -1459.7, 80.3421, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.1818, 0, 0),
(2258, 17, 708.769, -1455.86, 81.4599, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.67848, 0, 0),
(2258, 18, 667.903, -1437.37, 81.9153, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.28709, 0, 0),
(2258, 19, 643.733, -1408.63, 87.2146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.0362, 0, 0),
(2258, 20, 629.19, -1375.19, 94.0446, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.64982, 0, 0),
(2258, 21, 627.374, -1321.59, 106.257, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.49929, 0, 0),
(2258, 22, 634.783, -1271.27, 121.478, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.53943, 0, 0),
(2258, 23, 633.98, -1228.57, 137.007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.58961, 0, 0),
(2258, 24, 629.947, -1191.76, 145.328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.57957, 0, 0),
(2258, 25, 631.939, -1148.87, 155.504, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.84552, 0, 0),
(2258, 26, 627.116, -1131.07, 159.662, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.96595, 0, 0),
(2258, 27, 620.092, -1114.7, 160.189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.53441, 0, 0),
(2258, 28, 622.218, -1054.98, 163.22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.857007, 0, 0),
(2258, 29, 634.789, -1041.15, 163.826, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.495724, 0, 0),
(2258, 30, 653.802, -1032.34, 163.225, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.420457, 0, 0);
UPDATE `creature` SET `position_x` = 664.315, `position_y` = -1027.59, `position_z` = 160.39, `MovementType` = 2 WHERE `id` = 2258;
UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` = 2258;

-- More possible spawns for Duggan Wildhammer (source TBC-DB)
DELETE FROM `creature` WHERE `guid` BETWEEN 98712 AND 98717;
INSERT INTO `creature` VALUES
(98712, 10817, 0, 0, 0, 2189.54, -3599.32, 173.598, 3.03903, 28800, 5, 0, 3398, 0, 0, 1),
(98713, 10817, 0, 0, 0, 2176.73, -3655.03, 173.374, 2.67697, 28800, 5, 0, 3398, 0, 0, 1),
(98714, 10817, 0, 0, 0, 2208.08, -2801.23, 86.7184, 3.35556, 28800, 5, 0, 3398, 0, 0, 1),
(98715, 10817, 0, 0, 0, 1931.66, -2674.2, 61.8024, 2.96914, 28800, 5, 0, 3398, 0, 0, 1),
(98716, 10817, 0, 0, 0, 1727.15, -3039.13, 76.1341, 5.21066, 28800, 5, 0, 3398, 0, 0, 1),
(98717, 10817, 0, 0, 0, 1827.76, -3271.44, 125.274, 3.4066, 28800, 5, 0, 3398, 0, 0, 1);

SET @POOL := 1216;
DELETE FROM `pool_creature_template` WHERE `id` = 10817;
INSERT INTO `pool_creature_template` VALUES
(10817, @POOL, 0, 'Duggan Wildhammer (10817)');
DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` VALUES (@POOL, 1, 'Duggan Wildhammer (10817)');

-- Added missing spell script target for 29437 for Midsummer Fire Festival Fury buff
DELETE FROM spell_script_target WHERE entry IN (29437);
INSERT INTO spell_script_target (entry, type, targetEntry, inverseEffectMask) VALUES
(29437, 0, 181288, 0);

-- Partly revert change in [1228]
UPDATE `gameobject_template` SET `data2` = 0, `data10` = 28859 WHERE `entry` = 181288;

-- Remove duplicate GOs
DELETE FROM `gameobject` WHERE `id` = 181431 AND `guid` < 50000;

-- Improved scripts when using Capital Flames
-- 3: Horde
-- 4: Alliance
INSERT INTO `dbscripts_on_go_template_use` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(181332, 0, 34, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stop if player is Alliance'),    
(181332, 1, 15, 29101, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Create Flame Stormwind'),
(181333, 0, 34, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stop if player is Alliance'),
(181333, 1, 15, 29102, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Create Flame Ironforge'),
(181334, 0, 34, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stop if player is Alliance'),
(181334, 1, 15, 29099, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Create Flame Darnassus'),
(181336, 0, 34, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stop if player is Horde'),
(181336, 1, 15, 29130, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Create Flame Orgrimmar'),
(181337, 0, 34, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stop if player is Horde'),
(181337, 1, 15, 29132, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Create Flame Thunder Bluff'),
(181335, 0, 34, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stop if player is Horde'),
(181335, 1, 15, 29133, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Create Flame Undercity');
-- The Wailing Caverns
-- Main Hall

-- Duplicates removed
DELETE FROM creature WHERE guid IN (27349,26256,27359,27367,27360);
DELETE FROM creature_addon WHERE guid IN (27349,26256,27359,27367,27360);
DELETE FROM creature_movement WHERE id IN (27349,26256,27359,27367,27360);
-- Missing added
DELETE FROM creature WHERE guid IN (27353,18688); -- empty guids from creatures deleted in this instance
INSERT INTO creature (guid, id, map, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES
(27353,3636,43,0,0,18.9434,284.015,-87.7345,0.44334,7200,5,0,1251,0,0,1),
(18688,3636,43,0,0,4.29095,303.612,-87.6656,1.08737,7200,5,0,1251,0,0,1);

-- Deviate Moccasin / NIGHTMARE_ECTOPLASM / MUTANUS - they must ignore MMaps to work correctly
UPDATE creature_template SET ExtraFlags = 16384 WHERE entry IN (3654,5762,5763);

-- Deviate Guardian/Ravager
UPDATE creature SET position_x = -107.136887, position_y = 243.697266, position_z = -93.119705, orientation = 4.852786, spawndist = 2, MovementType = 1 WHERE guid = 26202;
UPDATE creature SET position_x = -100.263298, position_y = 180.224976, position_z = -78.493256, orientation = 2.959969, spawndist = 2, MovementType = 1 WHERE guid = 26224;
UPDATE creature SET position_x = -4.321824, position_y = 307.168152, position_z = -88.147560, spawndist = 2, MovementType = 1 WHERE guid = 27364;
-- snake
UPDATE creature SET position_x = -53.176250, position_y = 263.859100, position_z = -92.843735 WHERE guid = 26238;
-- Deviate Crocolisk
UPDATE creature_template SET SpeedWalk = 1 WHERE entry = 5053;
UPDATE creature SET spawndist = 5, MovementType = 1 WHERE guid IN (26197,33978,18678,26206,33970,26257,26258,26254,27365,27374);

-- Evolving Ectoplasm
UPDATE creature_template_addon SET auras = 7940 WHERE entry = 3640;
-- #26200
UPDATE creature SET spawndist = 0, movementType = 2 WHERE guid IN (26200,26229,27363);
DELETE FROM creature_movement WHERE id IN (26200,26229,27363);
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(26200,1,-68.1524,203.433,-93.674,0,0,1.31066,0,0),
(26200,2,-69.961,212.707,-93.5038,0,0,2.09606,0,0),
(26200,3,-78.7136,218.987,-94.0952,0,0,2.09606,0,0),
(26200,4,-85.6643,225.037,-93.2043,0,0,2.44714,0,0),
(26200,5,-100.668,231.587,-91.4226,0,0,3.39276,0,0),
(26200,6,-110.268,230.005,-90.4413,0,0,4.17815,0,0),
(26200,7,-111.443,214.012,-85.3093,0,0,4.86302,0,0),
(26200,8,-108.986,203.938,-81.9642,0,0,4.96669,0,0),
(26200,9,-111.286,213.68,-85.2575,0,0,1.56234,0,0),
(26200,10,-110.096,229.464,-90.3296,0,0,0.552158,0,0),
(26200,11,-101.01,231.305,-91.2858,0,0,5.88676,0,0),
(26200,12,-86.0461,225.309,-93.0858,0,0,5.63151,0,0),
(26200,13,-78.9576,219.426,-94.0533,0,0,5.70848,0,0),
(26200,14,-70.0722,212.752,-93.5082,0,0,5.14928,0,0),
(26200,15,-68.2919,203.988,-93.6674,0,0,4.37077,0,0),
(26200,16,-79.1239,186.051,-93.1735,0,0,4.21762,0,0),
-- #26229 
(26229,1,-36.9481,192.669,-96.5478,0,0,4.9423,0,0),
(26229,2,-33.0708,177.147,-96.3141,0,0,4.47578,0,0),
(26229,3,-37.9909,156.333,-94.9096,0,0,4.24645,0,0),
(26229,4,-48.0045,140.481,-91.8653,0,0,4.39803,0,0),
(26229,5,-55.4778,122.223,-89.6402,0,0,4.28965,0,0),
(26229,6,-47.8948,140.425,-91.8465,0,0,1.01611,0,0),
(26229,7,-38.109,156.232,-94.8953,0,0,1.43865,0,0),
(26229,8,-33.0733,177.137,-96.3138,0,0,1.55803,0,0),
(26229,9,-37.0588,192.811,-96.5582,0,0,1.51248,0,0),
(26229,10,-35.1795,210.319,-96.2248,0,0,1.47164,0,0),
(26229,11,-32.656,228.21,-94.9624,0,0,1.5541,0,0),
(26229,12,-33.2975,242.874,-93.6593,0,0,1.96958,0,0),
(26229,13,-39.2168,256.586,-92.8235,0,0,1.65856,0,0),
(26229,14,-40.962,275.043,-92.4866,0,0,1.92874,0,0),
(26229,15,-46.6966,286.608,-92.4283,0,0,2.32772,0,0),
(26229,16,-57.9612,295.736,-90.1559,0,0,2.57512,0,0),
(26229,17,-46.9098,286.265,-92.4936,0,0,5.36407,0,0),
(26229,18,-41.2171,274.316,-92.5108,0,0,5.04913,0,0),
(26229,19,-39.8032,256.102,-92.8306,0,0,5.0672,0,0),
(26229,20,-33.2436,242.648,-93.6555,0,0,4.96667,0,0),
(26229,21,-33.0231,228.434,-94.9126,0,0,4.54963,0,0),
(26229,22,-34.8833,210.837,-96.1466,0,0,4.60932,0,0),
-- #27363
(27363,1,51.8623,209.877,-89.2127,0,0,2.15017,0,0),
(27363,2,48.2785,222.57,-88.5033,0,0,1.79282,0,0),
(27363,3,51.5756,212.811,-88.8591,0,0,5.61535,0,0),
(27363,4,60.3946,207.222,-91.6151,0,0,5.98288,0,0),
(27363,5,70.9029,206.649,-93.1381,0,0,0.284024,0,0),
(27363,6,83.4113,213.794,-92.9334,0,0,0.987741,0,0),
(27363,7,88.5347,230.272,-95.2437,0,0,0.879356,0,0),
(27363,8,96.3243,238.458,-95.8381,0,0,0.489013,0,0),
(27363,9,101.659,238.844,-95.8739,0,0,6.10775,0,0),
(27363,10,107.732,236.449,-96.0159,0,0,5.85878,0,0),
(27363,11,101.679,239.024,-95.8774,0,0,3.06974,0,0),
(27363,12,93.7623,237.393,-95.9306,0,0,3.64465,0,0),
(27363,13,87.7015,230.192,-95.2919,0,0,4.38214,0,0),
(27363,14,83.8539,215.539,-93.0563,0,0,4.17403,0,0),
(27363,15,77.8885,209.165,-92.959,0,0,3.55357,0,0),
(27363,16,71.0565,206.448,-93.1129,0,0,3.3101,0,0),
(27363,17,61.4155,207.113,-91.7314,0,0,3.10197,0,0);

-- Druid of the Fang
UPDATE creature SET spawndist = 0, movementType = 2 WHERE guid IN (26239,27348,27357,26225);
DELETE FROM creature_movement WHERE id IN (26239,27348,27357,26225);
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
-- #26239 
(26239,1,-56.3975,265.139,-92.8434,0,0,2.85711,0,0),
(26239,2,-62.6119,267.854,-92.8434,0,0,2.3521,0,0),
(26239,3,-66.2731,274.048,-92.8434,0,0,1.86437,0,0),
(26239,4,-65.887,278.532,-92.5521,0,0,1.13097,0,0),
(26239,5,-62.0234,283.8,-91.974,0,0,0.756338,0,0),
(26239,6,-56.3948,286.851,-91.9572,0,0,0.270962,0,0),
(26239,7,-48.7796,283.578,-92.8443,0,0,5.73341,0,0),
(26239,8,-44.9437,278.699,-92.6976,0,0,5.164,0,0),
(26239,9,-42.87,272.868,-92.6368,0,0,4.90325,0,0),
(26239,10,-44.9356,268.481,-92.8257,0,0,3.99455,0,0),
(26239,11,-50.2492,264.342,-92.8442,0,0,3.51874,0,0),
-- #27348 
(27348,1,9.68975,197.043,-84.0878,0,0,4.78291,0,0),
(27348,2,10.2678,207.534,-84.3362,0,0,1.36014,0,0),
(27348,3,14.5732,222.643,-84.5247,0,0,1.23291,0,0),
(27348,4,20.72,235.967,-85.4468,0,0,1.00907,0,0),
(27348,5,29.986,250.396,-87.5133,0,0,1.6688,0,0),
(27348,6,28.1387,262.184,-87.385,0,0,2.24136,0,0),
(27348,7,13.8197,277.082,-86.2148,0,0,2.11648,0,0),
(27348,8,3.75275,292.614,-85.5411,0,0,2.31047,0,0),
(27348,9,-11.572,306.829,-88.4024,0,0,2.41493,0,0),
(27348,10,-30.8699,319.153,-89.2336,0,0,2.56023,0,0),
(27348,11,-11.0633,306.451,-88.3487,0,0,5.51254,0,0),
(27348,12,4.12528,291.684,-85.5452,0,0,5.45546,0,0),
(27348,13,14.0051,276.815,-86.2056,0,0,5.48688,0,0),
(27348,14,27.9405,261.821,-87.3832,0,0,5.11067,0,0),
(27348,15,30.0687,249.523,-87.435,0,0,4.55225,0,0),
(27348,16,25.2162,240.198,-86.165,0,0,4.21453,0,0),
(27348,17,14.3869,222.38,-84.5234,0,0,4.30878,0,0),
(27348,18,10.1017,210.273,-84.1564,0,0,4.59466,0,0),
(27348,19,9.74381,204.494,-84.1363,0,0,4.71718,0,0),
-- #27357 
(27357,1,49.4473,218.755,-88.6672,0,0,1.55818,0,0),
(27357,2,48.178,232.093,-88.5543,0,0,1.74275,0,0),
(27357,3,49.4085,218.762,-88.6588,0,0,4.3974,0,0),
(27357,4,43.1834,206.45,-88.2157,0,0,3.95129,0,0),
(27357,5,25.8099,200.155,-86.0444,0,0,3.69133,0,0),
(27357,6,13.8656,193.124,-84.9796,0,0,3.9694,0,0),
(27357,7,9.89033,184.731,-85.4648,0,0,4.57337,0,0),
(27357,8,10.3683,175.054,-86.6094,0,0,4.5875,0,0),
(27357,9,7.91235,167.02,-86.6623,0,0,4.41943,0,0),
(27357,10,1.81814,153.567,-88.56,0,0,4.26314,0,0),
(27357,11,-15.7426,119.127,-89.8857,0,0,4.28277,0,0),
(27357,12,-25.4447,101.016,-89.8553,0,0,4.52467,0,0),
(27357,13,-28.177,82.8804,-91.1606,0,0,4.39744,0,0),
(27357,14,-37.892,68.0999,-88.5432,0,0,4.08249,0,0),
(27357,15,-27.7804,83.4066,-91.2526,0,0,1.12704,0,0),
(27357,16,-25.3866,101.015,-89.871,0,0,1.10112,0,0),
(27357,17,-6.3389,137.829,-88.4654,0,0,1.10907,0,0),
(27357,18,7.90365,167.725,-86.6462,0,0,1.45639,0,0),
(27357,19,10.7275,177.886,-86.4483,0,0,1.52079,0,0),
(27357,20,9.73913,186.363,-85.4123,0,0,1.43911,0,0),
(27357,21,12.2051,191.933,-84.7278,0,0,0.766027,0,0),
(27357,22,26.7711,200.425,-86.1275,0,0,0.398735,0,0),
(27357,23,40.3936,204.973,-87.9399,0,0,0.621003,0,0),
(27357,24,46.2976,209.539,-88.3763,0,0,0.958724,0,0),
-- #26225
(26225,1,-40.4414,150.653,-94.0708,0,0,4.2188,0,0),
(26225,2,-46.9905,138.931,-91.4253,0,0,4.11278,0,0),
(26225,3,-63.7112,117.635,-89.222,0,0,3.83396,0,0),
(26225,4,-73.6791,111.54,-88.6808,0,0,3.68474,0,0),
(26225,5,-60.8873,122.093,-89.4241,0,0,0.904425,0,0),
(26225,6,-43.415,143.576,-92.526,0,0,1.13062,0,0),
(26225,7,-37.8829,157.212,-95.03,0,0,1.21701,0,0),
(26225,8,-36.1888,195.916,-96.7587,0,0,1.54295,0,0),
(26225,9,-35.4668,166.732,-96.1359,0,0,4.7356,0,0);

-- Kresh
UPDATE creature SET Spawndist = 0, MovementType = 2 WHERE guid = 27368;
DELETE FROM creature_movement WHERE id = 27368;
UPDATE creature_template SET MovementType = 2, SpeedWalk = 1 WHERE entry = 3653;
DELETE FROM creature_movement_template WHERE entry = 3653;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(3653,1,-44.8007,305.259,-106.417,0,0,5.56568,0,0),
(3653,2,-32.5041,290.754,-106.417,0,0,5.35127,0,0),
(3653,3,-20.8746,273.006,-106.417,0,0,5.13136,0,0),
(3653,4,-11.3159,247.89,-106.344,0,0,4.74102,0,0),
(3653,5,-8.17325,223.437,-106.163,0,0,4.71353,0,0),
(3653,6,-7.57741,202.096,-106.163,0,0,4.67584,0,0),
(3653,7,-8.89105,181.096,-106.163,0,0,4.6405,0,0),
(3653,8,-11.3937,163.913,-106.163,0,0,4.3499,0,0),
(3653,9,-16.1442,149.352,-106.163,0,0,4.39702,0,0),
(3653,10,-28.404,128.264,-106.163,0,0,4.12606,0,0),
(3653,11,-46.7483,102.631,-106.163,0,0,4.25958,0,0),
(3653,12,-52.9205,90.712,-106.163,0,0,4.53492,0,0),
(3653,13,-55.1093,83.4505,-106.163,0,0,4.22312,0,0),
(3653,14,-58.6901,76.3781,-106.163,0,0,3.97022,0,0),
(3653,15,-62.9525,72.3359,-106.163,0,0,3.48328,0,0),
(3653,16,-75.996,71.5946,-106.163,0,0,3.36782,0,0),
(3653,17,-84.1777,69.2621,-106.163,0,0,3.64035,0,0),
(3653,18,-92.3134,65.9368,-106.163,0,0,3.27122,0,0),
(3653,19,-100.357,66.2251,-106.259,0,0,2.80312,0,0),
(3653,20,-120.69,71.8824,-106.442,0,0,3.06701,0,0),
(3653,21,-139.212,71.107,-106.166,0,0,3.45657,0,0),
(3653,22,-150.104,65.7444,-106.311,0,0,3.89404,0,0),
(3653,23,-155.877,58.1956,-106.361,0,0,4.52157,0,0),
(3653,24,-154.651,32.4415,-106.648,0,0,4.82708,0,0),
(3653,25,-154.773,12.4538,-105.7,0,0,4.348,0,0),
(3653,26,-158.958,2.82365,-106.208,0,0,4.04719,0,0),
(3653,27,-173.109,-6.59597,-106.397,0,0,3.51705,0,0),
(3653,28,-190.102,-9.4344,-106.243,0,0,3.1267,0,0),
(3653,29,-169.26,-5.08474,-106.375,0,0,0.448495,0,0),
(3653,30,-156.951,6.08111,-106.009,0,0,1.07681,0,0),
(3653,31,-153.483,21.6673,-105.47,0,0,1.55198,0,0),
(3653,32,-154.685,51.2861,-106.352,0,0,1.34699,0,0),
(3653,33,-149.849,64.9798,-106.338,0,0,0.953333,0,0),
(3653,34,-139.068,71.1707,-106.154,0,0,0.311758,0,0),
(3653,35,-120.406,72.0676,-106.439,0,0,6.03417,0,0),
(3653,36,-109.081,70.1327,-106.401,0,0,6.08915,0,0),
(3653,37,-97.633,66.0886,-106.184,0,0,6.23837,0,0),
(3653,38,-88.6407,66.2216,-106.161,0,0,0.385583,0,0),
(3653,39,-80.4933,71.5953,-106.161,0,0,0.338459,0,0),
(3653,40,-63.3656,72.3782,-106.161,0,0,0.422497,0,0),
(3653,41,-56.8746,77.2352,-106.161,0,0,1.02333,0,0),
(3653,42,-52.9606,90.3188,-106.161,0,0,1.29036,0,0),
(3653,43,-45.6264,103.709,-106.161,0,0,0.948714,0,0),
(3653,44,-28.8159,127.738,-106.161,0,0,0.960495,0,0),
(3653,45,-19.063,141.466,-106.161,0,0,1.03118,0,0),
(3653,46,-12.2858,158.042,-106.161,0,0,1.45451,0,0),
(3653,47,-9.01831,171.966,-106.161,0,0,1.39561,0,0),
(3653,48,-7.55996,201.698,-106.161,0,0,1.60766,0,0),
(3653,49,-7.859,222.945,-106.161,0,0,1.6862,0,0),
(3653,50,-11.2468,247.599,-106.339,0,0,1.77652,0,0),
(3653,51,-16.3697,265.351,-106.417,0,0,1.88648,0,0),
(3653,52,-26.2989,282.527,-106.417,0,0,2.17315,0,0),
(3653,53,-39.9706,301.609,-106.417,0,0,2.38128,0,0),
(3653,54,-50.4176,309.288,-106.417,0,0,2.53836,0,0),
(3653,55,-72.4502,323.797,-106.162,0,0,2.38442,0,0),
(3653,56,-76.8971,329.161,-106.162,0,0,1.99722,0,0),
(3653,57,-77.1239,335.797,-106.162,0,0,1.3634,0,0),
(3653,58,-72.0056,353.657,-106.173,0,0,1.36733,0,0),
(3653,59,-70.9167,374.263,-105.182,0,0,1.67756,0,0),
(3653,60,-75.7733,401.265,-107.862,0,0,1.57546,0,0),
(3653,61,-72.2112,417.555,-107.009,0,0,0.850539,0,0),
(3653,62,-57.6043,427.606,-105.979,0,0,0.556015,0,0),
(3653,63,-71.9469,416.472,-107.104,0,0,4.17591,0,0),
(3653,64,-76.9202,400.773,-107.867,0,0,4.80423,0,0),
(3653,65,-75.4612,388.477,-106.392,0,0,4.93382,0,0),
(3653,66,-69.6617,368.65,-105.263,0,0,4.83172,0,0),
(3653,67,-72.0043,352.597,-106.162,0,0,4.49793,0,0),
(3653,68,-77.3223,330.255,-106.162,0,0,5.07125,0,0),
(3653,69,-73.4961,323.783,-106.162,0,0,5.64066,0,0),
(3653,70,-66.2326,318.345,-106.592,0,0,5.80559,0,0);-- The Wailing Caverns
-- Left Wing

-- Duplicates removed
DELETE FROM creature WHERE guid IN (33938,27379,33967,33960,27388,33936);
DELETE FROM creature_addon WHERE guid IN (33938,27379,33967,33960,27388,33936);
DELETE FROM creature_movement WHERE id IN (33938,27379,33967,33960,27388,33936);

-- Deviate Viper
UPDATE creature SET position_x = 5.956939, position_y = 455.083618, position_z = -77.977341, spawndist = 2, MovementType = 1 WHERE guid = 33948;
UPDATE creature SET position_x = 17.332829, position_y = 434.110718, position_z = -80.834145, spawndist = 2, MovementType = 1 WHERE guid = 33949;
UPDATE creature SET position_x = -27.127914, position_y = 381.332458, position_z = -60.059540, spawndist = 2, MovementType = 1 WHERE guid = 27372;
UPDATE creature SET position_x = -7.147677, position_y = 504.356445, position_z = -56.001366, spawndist = 5, MovementType = 1 WHERE guid = 33951;
UPDATE creature SET position_x = -19.490566, position_y = 488.676270, position_z = -55.430050, spawndist = 5, MovementType = 1 WHERE guid = 33947;

-- Deviate Adder
UPDATE creature SET position_x = -84.996887, position_y = 481.093903, position_z = -66.405075, orientation = 0.965283 WHERE guid = 33934;
UPDATE creature SET spawndist = 0, movementType = 2 WHERE guid IN (33952,33934);
DELETE FROM creature_movement WHERE id IN (33952,33934);
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
-- #33952 
(33952,1,18.3882,471.101,-88.0586,0,0,2.39738,0,0),
(33952,2,29.0196,455.613,-86.1838,0,0,5.12664,0,0),
(33952,3,31.3535,445.19,-85.3345,0,0,4.96956,0,0),
(33952,4,31.8656,437.95,-84.0014,0,0,4.49518,0,0),
(33952,5,29.3349,432.054,-83.1705,0,0,3.61004,0,0),
(33952,6,22.6037,431.228,-81.9907,0,0,2.87134,0,0),
(33952,7,17.624,434.439,-80.9945,0,0,2.17155,0,0),
(33952,8,12.3668,444.198,-79.534,0,0,2.17862,0,0),
(33952,9,6.53194,452.764,-77.8434,0,0,2.87526,0,0),
(33952,10,1.70567,452.306,-76.3355,0,0,4.16683,0,0),
(33952,11,0.497222,446.235,-74.9738,0,0,4.91399,0,0),
(33952,12,4.66517,437.492,-73.3332,0,0,5.01209,0,0),
(33952,13,4.9966,431.932,-71.3576,0,0,4.44897,0,0),
(33952,14,0.990924,422.873,-67.8055,0,0,4.08219,0,0),
(33952,15,-8.8705,415.241,-65.0212,0,0,3.83086,0,0),
(33952,16,-16.7775,409.627,-60.6643,0,0,3.74054,0,0),
(33952,17,-9.80849,414.747,-64.8074,0,0,0.649997,0,0),
(33952,18,1.41618,423.453,-68.0128,0,0,0.94138,0,0),
(33952,19,5.25315,433.678,-72.0517,0,0,1.55792,0,0),
(33952,20,4.72326,438.894,-73.789,0,0,1.87679,0,0),
(33952,21,0.419972,446.218,-74.9489,0,0,1.80453,0,0),
(33952,22,1.03652,451.119,-75.9471,0,0,1.05291,0,0),
(33952,23,3.76451,453.807,-77.2048,0,0,0.275362,0,0),
(33952,24,8.33111,453.161,-78.4086,0,0,5.69147,0,0),
(33952,25,13.1434,442.055,-79.5827,0,0,5.09379,0,0),
(33952,26,18.5203,433.383,-81.3881,0,0,5.65141,0,0),
(33952,27,24.043,430.722,-82.1867,0,0,6.26598,0,0),
(33952,28,29.6276,432.259,-83.2049,0,0,0.811386,0,0),
(33952,29,32.2469,436.867,-83.8849,0,0,1.45669,0,0),
(33952,30,31.5933,445.346,-85.3358,0,0,1.79805,0,0),
(33952,31,29.0614,454.303,-86.0651,0,0,1.97476,0,0),
-- #33934
(33934,1,-81.3997,486.056,-65.0403,0,0,0.838834,0,0),
(33934,2,-76.5929,489.002,-63.4276,0,0,0.0997735,0,0),
(33934,3,-68.2558,483.684,-61.237,0,0,5.50096,0,0),
(33934,4,-55.36,473.697,-57.5728,0,0,5.44206,0,0),
(33934,5,-49.505,464.937,-56.59,0,0,5.20644,0,0),
(33934,6,-55.0437,474.004,-57.5264,0,0,2.41278,0,0),
(33934,7,-74.0426,488.033,-62.9592,0,0,2.89894,0,0),
(33934,8,-77.8686,488.177,-63.8568,0,0,3.54666,0,0),
(33934,9,-83.133,484.854,-65.4919,0,0,4.09565,0,0),
(33934,10,-85.6188,479.08,-66.9086,0,0,4.50092,0,0),
(33934,11,-86.6055,468.673,-68.7278,0,0,4.31635,0,0),
(33934,12,-90.6928,463.931,-69.9754,0,0,3.61499,0,0),
(33934,13,-98.2663,463.126,-70.671,0,0,3.238,0,0),
(33934,14,-110.833,460.458,-71.7726,0,0,3.71002,0,0),
(33934,15,-115.395,456.6,-72.3846,0,0,4.20797,0,0),
(33934,16,-117.256,450.734,-72.6647,0,0,4.60983,0,0),
(33934,17,-112.016,436.477,-72.8273,0,0,5.14389,0,0),
(33934,18,-108.051,430.357,-73.3957,0,0,4.82817,0,0),
(33934,19,-111.652,414.39,-73.8526,0,0,4.38992,0,0),
(33934,20,-107.801,430.569,-73.4287,0,0,1.76826,0,0),
(33934,21,-116.12,451.115,-72.6451,0,0,1.47531,0,0),
(33934,22,-115.575,456.322,-72.403,0,0,1.15015,0,0),
(33934,23,-108.838,460.621,-71.6793,0,0,0.32941,0,0),
(33934,24,-90.2806,463.658,-69.9699,0,0,0.705616,0,0),
(33934,25,-86.2516,468.787,-68.6661,0,0,1.12152,0,0),
(33934,26,-85.1272,480.383,-66.5854,0,0,1.38855,0,0);

-- Druid of the Fang
UPDATE creature SET spawndist = 5, MovementType = 1 WHERE guid = 27384;
UPDATE creature SET position_x = 40.250111, position_y = 477.857727, position_z = -65.968185, orientation = 5.372137 WHERE guid = 33964;
UPDATE creature SET position_x = 21.978088, position_y = 507.476837, position_z = -58.773094, spawndist = 10, MovementType = 1 WHERE guid = 33956;
UPDATE creature SET position_x = -31.707466, position_y = 473.150970, position_z = -53.801693, spawndist = 5, MovementType = 1 WHERE guid = 33946;
UPDATE creature SET spawndist = 0, movementType = 2 WHERE guid IN (33964);
DELETE FROM creature_movement WHERE id IN (33964);
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
-- #33964 
(33964,1,51.2705,462.79,-65.6538,0,0,5.22684,0,0),
(33964,2,61.4426,441.233,-64.5607,0,0,5.12474,0,0),
(33964,3,66.6446,427.09,-64.1669,0,0,4.75718,0,0),
(33964,4,65.3818,411.521,-63.7163,0,0,4.08119,0,0),
(33964,5,66.97,428.045,-64.2591,0,0,1.77447,0,0),
(33964,6,53.7275,457.406,-65.408,0,0,2.00774,0,0),
(33964,7,50.3768,465.739,-65.2606,0,0,2.14518,0,0),
(33964,8,40.5128,478.114,-65.9229,0,0,1.91192,0,0),
(33964,9,41.5158,488.841,-64.2444,0,0,1.89115,0,0),
(33964,10,36.7258,497.087,-62.1721,0,0,2.54217,0,0),
(33964,11,27.2896,504.402,-60.0476,0,0,1.36015,0,0),
(33964,12,32.4338,515.703,-58.0155,0,0,1.94056,0,0),
(33964,13,27.5284,523.319,-57.4901,0,0,2.58359,0,0),
(33964,14,17.4092,523.534,-57.0785,0,0,3.55198,0,0),
(33964,15,-0.718095,509.193,-56.2755,0,0,3.84257,0,0),
(33964,16,-22.3696,489.422,-54.4679,0,0,3.87006,0,0),
(33964,17,-32.7447,475.967,-53.7104,0,0,4.08605,0,0),
(33964,18,-21.6127,490.094,-54.6732,0,0,0.889474,0,0),
(33964,19,-7.64358,498.594,-56.1589,0,0,0.818003,0,0),
(33964,20,0.0910954,509.674,-56.3452,0,0,0.766952,0,0),
(33964,21,12.5018,517.24,-57.3461,0,0,0.863243,0,0),
(33964,22,17.3274,523.661,-57.0825,0,0,0.429703,0,0),
(33964,23,27.2714,523.02,-57.5083,0,0,5.84895,0,0),
(33964,24,33.1255,514.965,-58.1352,0,0,5.12639,0,0),
(33964,25,41.5672,488.218,-64.3173,0,0,5.06356,0,0);-- The Wailing Caverns
-- Right Wing

-- Duplicates removed
DELETE FROM creature WHERE guid IN (38144,38113,85947,85961,38117);
DELETE FROM creature_addon WHERE guid IN (38144,38113,85947,85961,38117);
DELETE FROM creature_movement WHERE id IN (38144,38113,85947,85961,38117);

-- Skum
UPDATE creature SET position_x = -283.573700, position_y = -310.881409, position_z = -69.183708, orientation = 0.564664, spawndist = 10, MovementType = 1 WHERE guid = 87131;

-- Deviate Faerie Dragon
UPDATE creature SET position_x = 3.990831, position_y = -48.752422, position_z = -66.029633, orientation = 4.191853 WHERE guid = 517;
-- should have reduced chance to spawn in WC
DELETE FROM pool_template WHERE entry = 25493;
INSERT INTO pool_template (entry, max_limit, description) VALUES 
(25493,1,'WC - Deviate Faerie Dragon / Druid of the Fang');
DELETE FROM pool_creature WHERE pool_entry = 25493;
INSERT INTO pool_creature (guid, pool_entry, chance, description) VALUES 
(517,25493,35,'WC - Deviate Faerie Dragon'),
(85959,25493,65,'WC - Druid of the Fang');

-- Deviate Lasher
UPDATE creature SET spawndist = 5, MovementType = 1 WHERE guid IN (18679,18681,18680);

-- Deviate Shambler
UPDATE creature SET position_x = 22.807135, position_y = -151.118713, position_z = -78.651627 WHERE guid = 85963;
UPDATE creature SET position_x = -7.038766, position_y = -71.016472, position_z = -67.098122, spawndist = 5, MovementType = 1 WHERE guid = 85954;
UPDATE creature SET position_x = -166.194336, position_y = -89.008423, position_z = -67.355522, spawndist = 5, MovementType = 1 WHERE guid = 45723;
UPDATE creature SET position_x = -226.982697, position_y = 44.669109, position_z = -82.440079, spawndist = 5, MovementType = 1 WHERE guid = 38114;
UPDATE creature SET position_x = -112.500587, position_y = -104.252632, position_z = -75.274391, spawndist = 2, MovementType = 1 WHERE guid = 45724;
UPDATE creature SET position_x = 10.453961, position_y = -231.321625, position_z = -77.228943, spawndist = 5, MovementType = 1 WHERE guid = 87105;
UPDATE creature SET position_x = 38.975677, position_y = -164.936310, position_z = -82.935074, spawndist = 2, MovementType = 1 WHERE guid = 87113;
UPDATE creature SET spawndist = 0, movementType = 2 WHERE guid IN (38116,38168,85963);
DELETE FROM creature_movement WHERE id IN (38116,38168,85963);
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
-- #38116 
(38116,1,-241.193,42.2694,-83.8524,0,0,3.15753,0,0),
(38116,2,-257.169,41.459,-86.9647,0,0,3.66727,0,0),
(38116,3,-268.754,32.5239,-87.9437,0,0,3.1882,0,0),
(38116,4,-279.79,33.354,-88.8636,0,0,2.70361,0,0),
(38116,5,-302.306,48.9864,-93.0104,0,0,2.86854,0,0),
(38116,6,-321.468,52.3916,-96.2298,0,0,3.42146,0,0),
(38116,7,-335.7,45.4104,-98.3198,0,0,4.00894,0,0),
(38116,8,-340.7,36.0533,-99.0784,0,0,4.69929,0,0),
(38116,9,-339.409,28.5987,-100.247,0,0,5.25928,0,0),
(38116,10,-332.995,21.5768,-103.176,0,0,5.70217,0,0),
(38116,11,-338.99,28.3312,-100.283,0,0,1.99666,0,0),
(38116,12,-340.614,36.4627,-99.0447,0,0,1.45787,0,0),
(38116,13,-335.639,46.0422,-98.2416,0,0,0.692109,0,0),
(38116,14,-322.301,52.3214,-96.3296,0,0,0.144241,0,0),
(38116,15,-302.867,49.2066,-93.0867,0,0,5.72843,0,0),
(38116,16,-280.559,33.8918,-88.9843,0,0,6.06065,0,0),
(38116,17,-269.405,32.6903,-87.9801,0,0,0.513374,0,0),
(38116,18,-256.297,40.9856,-86.9004,0,0,0.286394,0,0),
(38116,19,-241.16,42.102,-83.8425,0,0,0.329591,0,0),
(38116,20,-217.971,49.149,-82.2794,0,0,0.628828,0,0),
(38116,21,-207.092,59.329,-82.3576,0,0,0.997965,0,0),
(38116,22,-196.834,74.8148,-81.7144,0,0,0.661029,0,0),
(38116,23,-186.296,84.9382,-79.5481,0,0,0.424624,0,0),
(38116,24,-174.414,87.8771,-77.7629,0,0,6.19573,0,0),
(38116,25,-164.768,80.992,-76.0056,0,0,5.37342,0,0),
(38116,26,-147.974,53.8704,-75.8208,0,0,5.05691,0,0),
(38116,27,-141.957,42.629,-75.4675,0,0,4.98623,0,0),
(38116,28,-141.45,22.0252,-74.8123,0,0,4.63673,0,0),
(38116,29,-145.667,8.31579,-74.5782,0,0,4.39718,0,0),
(38116,30,-155.675,-14.5223,-78.0544,0,0,4.62495,0,0),
(38116,31,-153.295,-27.8904,-80.1074,0,0,5.36714,0,0),
(38116,32,-142.287,-38.5889,-78.8823,0,0,5.72842,0,0),
(38116,33,-152.379,-27.9155,-79.9458,0,0,2.06061,0,0),
(38116,34,-155.651,-14.4576,-78.042,0,0,1.38988,0,0),
(38116,35,-145.77,7.76751,-74.5628,0,0,1.27992,0,0),
(38116,36,-145.77,7.76751,-74.5628,0,0,1.27992,0,0),
(38116,37,-142.01,35.0579,-75.3986,0,0,1.81321,0,0),
(38116,38,-143.771,45.6428,-75.3807,0,0,2.06454,0,0),
(38116,39,-153.842,59.4346,-75.6966,0,0,2.13915,0,0),
(38116,40,-164.62,80.9623,-76.0071,0,0,2.30251,0,0),
(38116,41,-175.641,87.215,-78.0969,0,0,3.05964,0,0),
(38116,42,-184.698,85.9708,-79.4345,0,0,3.53637,0,0),
(38116,43,-197.63,74.554,-81.7961,0,0,4.0783,0,0),
(38116,44,-217.403,50.4437,-82.285,0,0,3.8199,0,0),
-- #38168
(38168,1,-163.207,-96.9781,-66.663,0,0,5.75562,0,0),
(38168,2,-147.497,-101.802,-68.5947,0,0,6.27759,0,0),
(38168,3,-128.496,-102.5,-71.5074,0,0,0.273224,0,0),
(38168,4,-120.008,-95.097,-72.086,0,0,1.09868,0,0),
(38168,5,-115.215,-75.2305,-69.3508,0,0,1.11831,0,0),
(38168,6,-98.7366,-61.618,-67.1226,0,0,0.615658,0,0),
(38168,7,-72.1005,-51.2044,-61.7233,0,0,0.391819,0,0),
(38168,8,-99.5672,-62.2831,-67.2459,0,0,3.79332,0,0),
(38168,9,-114.608,-75.3549,-69.5214,0,0,4.17816,0,0),
(38168,10,-120.449,-94.6039,-71.8979,0,0,4.03522,0,0),
(38168,11,-128.759,-102.215,-71.4281,0,0,3.4933,0,0),
(38168,12,-147.378,-101.769,-68.6083,0,0,3.06918,0,0),
(38168,13,-162.921,-96.9254,-66.6689,0,0,2.53511,0,0),
(38168,14,-172.51,-86.2992,-67.6991,0,0,1.85339,0,0),
(38168,15,-173.39,-74.8943,-68.2057,0,0,1.44733,0,0),
(38168,16,-172.706,-85.6673,-67.6947,0,0,4.96198,0,0),
-- #85963
(85963,1,29.286,-162.936,-81.8688,0,0,4.85667,0,0),
(85963,2,28.182,-173.572,-83.5399,0,0,4.28255,0,0),
(85963,3,16.1552,-183.5,-83.0248,0,0,3.66994,0,0),
(85963,4,-1.6968,-185.095,-80.7507,0,0,4.15375,0,0),
(85963,5,-6.77331,-200.482,-79.1849,0,0,4.70968,0,0),
(85963,6,-3.68555,-216.02,-75.899,0,0,4.89582,0,0),
(85963,7,-7.23298,-228.119,-73.028,0,0,4.25965,0,0),
(85963,8,-26.7252,-246.039,-68.2434,0,0,3.64704,0,0),
(85963,9,-7.8933,-228.985,-72.7269,0,0,1.11885,0,0),
(85963,10,-3.70738,-216.133,-75.8558,0,0,1.5783,0,0),
(85963,11,-6.38523,-200.621,-79.2912,0,0,1.58245,0,0),
(85963,12,-0.725946,-186.789,-80.8895,0,0,0.565363,0,0),
(85963,13,14.953,-183.662,-82.9322,0,0,0.418483,0,0),
(85963,14,28.237,-173.451,-83.5226,0,0,1.16449,0,0),
(85963,15,29.3999,-163.131,-81.9668,0,0,2.06298,0,0),
(85963,16,23.2016,-152.043,-78.9337,0,0,2.38131,0,0),
(85963,17,2.10258,-137.804,-76.5998,0,0,2.62086,0,0),
(85963,18,-30.1591,-123.821,-72.1101,0,0,2.78187,0,0),
(85963,19,1.53461,-137.419,-76.5367,0,0,5.71297,0,0),
(85963,20,22.1765,-150.683,-78.5273,0,0,5.65799,0,0);

-- Druid of the Fang
UPDATE creature SET spawndist = 0, MovementType = 0 WHERE guid = 85948;
UPDATE creature SET spawndist = 5, MovementType = 1 WHERE guid = 85919;
UPDATE creature SET spawndist = 5, MovementType = 1 WHERE guid = 87122;
UPDATE creature SET spawndist = 5, MovementType = 1 WHERE guid = 18682;
UPDATE creature SET position_x = -341.693024, position_y = -112.663597, position_z = -63.787231, spawndist = 5, MovementType = 1 WHERE guid = 87150;
UPDATE creature SET position_x = -214.287292, position_y = 46.809830, position_z = -82.261520, spawndist = 5, MovementType = 1 WHERE guid = 33987;
UPDATE creature SET position_x = -176.696625, position_y = -92.646103, position_z = -67.163155, spawndist = 5, MovementType = 1 WHERE guid = 45722;
UPDATE creature SET position_x = -329.414398, position_y = -84.181580, position_z = -65.576790, spawndist = 5, MovementType = 1 WHERE guid = 87153;

-- Evolving Ectoplasm
UPDATE creature SET position_x = -110.559517, position_y = -260.382935, position_z = -57.422146, orientation = 2.382781 WHERE guid = 86047;
UPDATE creature SET spawndist = 0, movementType = 2 WHERE guid IN (38142,86047,87157);
DELETE FROM creature_movement WHERE id IN (38142,86047,87157);
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
-- #38142
(38142,1,-350.974,31.0695,-100.592,0,0,1.7402,0,0),
(38142,2,-351.788,41.0876,-100.147,0,0,1.43783,0,0),
(38142,3,-347.339,49.4633,-99.1387,0,0,0.68879,0,0),
(38142,4,-336.402,53.256,-97.9688,0,0,0.103668,0,0),
(38142,5,-312.729,50.5003,-94.6583,0,0,6.13945,0,0),
(38142,6,-291.86,46.1814,-91.512,0,0,5.79781,0,0),
(38142,7,-280.678,36.3304,-89.1863,0,0,5.97295,0,0),
(38142,8,-263.52,36.9492,-87.3749,0,0,0.166829,0,0),
(38142,9,-238.667,41.2443,-83.4696,0,0,6.01412,0,0),
(38142,10,-220.935,35.1547,-82.4884,0,0,0.387526,0,0),
(38142,11,-198.897,58.9616,-82.4193,0,0,1.17271,0,0),
(38142,12,-195.385,75.752,-81.5061,0,0,1.17899,0,0),
(38142,13,-183.378,88.3891,-79.3061,0,0,0.289136,0,0),
(38142,14,-171.484,91.2173,-77.3679,0,0,5.97306,0,0),
(38142,15,-163.106,85.5603,-75.9694,0,0,5.50183,0,0),
(38142,16,-151.344,64.7209,-75.8932,0,0,5.16647,0,0),
(38142,17,-143.995,38.4453,-75.6764,0,0,4.95048,0,0),
(38142,18,-139.451,5.96934,-74.4381,0,0,4.87195,0,0),
(38142,19,-134.782,-33.7224,-77.1659,0,0,4.52323,0,0),
(38142,20,-136.786,-44.3986,-78.842,0,0,4.30096,0,0),
(38142,21,-141.118,-49.3827,-78.7078,0,0,3.70014,0,0),
(38142,22,-149.677,-55.6208,-77.09,0,0,3.54306,0,0),
(38142,23,-171.933,-61.6922,-72.176,0,0,3.44881,0,0),
(38142,24,-149.235,-55.7584,-77.1013,0,0,0.516917,0,0),
(38142,25,-140.16,-49.1157,-78.7086,0,0,0.874273,0,0),
(38142,26,-135.532,-41.8277,-78.5371,0,0,1.28959,0,0),
(38142,27,-134.492,-32.9108,-77.1015,0,0,1.56632,0,0),
(38142,28,-136.449,-16.7871,-76.3314,0,0,1.71555,0,0),
(38142,29,-139.388,5.44889,-74.552,0,0,1.65664,0,0),
(38142,30,-143.965,38.5244,-75.6675,0,0,1.75089,0,0),
(38142,31,-151.563,64.9649,-75.8898,0,0,2.04542,0,0),
(38142,32,-163.332,85.8414,-75.9659,0,0,2.34387,0,0),
(38142,33,-172.358,91.2293,-77.5342,0,0,2.82432,0,0),
(38142,34,-180.071,90.9801,-78.9868,0,0,3.433,0,0),
(38142,35,-195.65,75.7468,-81.5234,0,0,4.24588,0,0),
(38142,36,-201.077,52.6642,-82.1164,0,0,4.11001,0,0),
(38142,37,-221.619,35.6366,-82.3932,0,0,3.20288,0,0),
(38142,38,-229.538,37.0909,-82.3751,0,0,2.7929,0,0),
(38142,39,-238.57,41.3212,-83.4619,0,0,3.06622,0,0),
(38142,40,-263.201,36.9681,-87.3377,0,0,3.32882,0,0),
(38142,41,-281.6,36.9127,-89.3543,0,0,2.63767,0,0),
(38142,42,-292.172,46.6155,-91.5915,0,0,2.75941,0,0),
(38142,43,-312.89,50.7145,-94.6917,0,0,3.08535,0,0),
(38142,44,-336.385,53.0905,-97.954,0,0,3.24243,0,0),
(38142,45,-346.969,49.7175,-99.0876,0,0,3.7765,0,0),
(38142,46,-349.946,46.301,-99.6044,0,0,4.21298,0,0),
(38142,47,-351.877,39.3114,-100.228,0,0,4.80281,0,0),
(38142,48,-350.779,30.2739,-100.625,0,0,5.33844,0,0),
(38142,49,-339.655,21.6589,-101.701,0,0,5.9214,0,0),
(38142,50,-313.309,14.4102,-106.172,0,0,6.05099,0,0),
(38142,51,-293.229,12.7872,-105.805,0,0,6.25519,0,0),
(38142,52,-315.887,15.0052,-106.098,0,0,2.96515,0,0),
(38142,53,-340.819,22.63,-101.44,0,0,2.72168,0,0),
-- #86047
(86047,1,-92.1335,-263.5,-55.1471,0,0,6.02698,0,0),
(86047,2,-106.231,-261.353,-56.7172,0,0,2.73224,0,0),
(86047,3,-120.101,-253.275,-60.6152,0,0,2.38902,0,0),
(86047,4,-139.359,-231.038,-69.0037,0,0,2.36938,0,0),
(86047,5,-151.376,-220.705,-71.1936,0,0,2.18795,0,0),
(86047,6,-153.009,-209.864,-69.7622,0,0,1.62639,0,0),
(86047,7,-146.822,-194.599,-67.9765,0,0,1.1473,0,0),
(86047,8,-136.908,-184.485,-67.9747,0,0,0.695698,0,0),
(86047,9,-123.475,-183.161,-68.5726,0,0,0.032036,0,0),
(86047,10,-100.027,-189.878,-69.2976,0,0,5.88011,0,0),
(86047,11,-92.9727,-197.987,-69.0403,0,0,5.06173,0,0),
(86047,12,-86.1435,-234.91,-67.3263,0,0,4.72008,0,0),
(86047,13,-88.5791,-206.593,-68.7181,0,0,2.01046,0,0),
(86047,14,-93.7853,-193.261,-69.1191,0,0,2.56024,0,0),
(86047,15,-109.382,-186.175,-68.2055,0,0,2.86654,0,0),
(86047,16,-129.302,-182.523,-68.2975,0,0,3.0786,0,0),
(86047,17,-140.864,-187.701,-68.3682,0,0,3.7776,0,0),
(86047,18,-150.024,-201.89,-68.2674,0,0,4.31167,0,0),
(86047,19,-152.654,-214.459,-70.5901,0,0,4.90542,0,0),
(86047,20,-146.049,-226.086,-70.5659,0,0,5.36488,0,0),
(86047,21,-130.668,-237.694,-65.8215,0,0,5.60049,0,0),
(86047,22,-120.01,-253.226,-60.5953,0,0,5.33346,0,0),
(86047,23,-111.762,-260.232,-57.7123,0,0,5.89501,0,0),
-- #87157
(87157,1,-363.202,-124.745,-64.5286,0,0,5.37462,0,0),
(87157,2,-351.567,-139.68,-62.6226,0,0,5.55212,0,0),
(87157,3,-336.065,-152.713,-62.5707,0,0,5.90241,0,0),
(87157,4,-322.947,-155.601,-61.6374,0,0,0.110092,0,0),
(87157,5,-312.726,-146.397,-61.6134,0,0,1.05257,0,0),
(87157,6,-307.947,-129.021,-61.4873,0,0,1.37458,0,0),
(87157,7,-303.853,-114.418,-63.221,0,0,0.85622,0,0),
(87157,8,-300.46,-104.332,-63.9405,0,0,1.73508,0,0),
(87157,9,-307.52,-87.7816,-64.5265,0,0,2.2613,0,0),
(87157,10,-316.789,-74.3077,-64.6553,0,0,2.0139,0,0),
(87157,11,-318.486,-57.8479,-64.3392,0,0,1.61334,0,0),
(87157,12,-299.255,-27.578,-60.9011,0,0,1.07613,0,0),
(87157,13,-296.014,-16.0174,-59.9064,0,0,2.13956,0,0),
(87157,14,-301.692,-15.5349,-59.7131,0,0,3.91149,0,0),
(87157,15,-310.984,-28.9368,-60.89,0,0,3.86515,0,0),
(87157,16,-326.361,-35.7607,-63.2927,0,0,3.66802,0,0),
(87157,17,-341.033,-53.6849,-64.2189,0,0,4.08271,0,0),
(87157,18,-354.261,-77.6512,-65.5206,0,0,4.23586,0,0),
(87157,19,-362.873,-94.2526,-65.9622,0,0,4.02144,0,0),
(87157,20,-373.72,-100.064,-65.2587,0,0,4.11177,0,0);

-- Deviate Dreadfang / Venomwing
UPDATE creature SET position_x = -216.087051, position_y = -326.585144, position_z = -71.001495, spawndist = 10, MovementType = 1 WHERE guid = 87132;
UPDATE creature SET position_x = -360.120270, position_y = -117.154121, position_z = -64.733063, spawndist = 5, MovementType = 1 WHERE guid = 87156;
UPDATE creature SET position_x = -248.955383, position_y = -216.704453, position_z = -63.100262, spawndist = 5, MovementType = 1 WHERE guid = 87130;
UPDATE creature SET spawndist = 0, movementType = 2 WHERE guid = 38122;
DELETE FROM creature_movement WHERE id = 38122;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(38122,1,-208.549,58.0016,-49.601,0,0,6.06974,0,0),
(38122,2,-203.835,54.7533,-49.2746,0,0,5.43749,0,0),
(38122,3,-199.685,46.4123,-48.9119,0,0,5.21208,0,0),
(38122,4,-197.392,41.2041,-48.6779,0,0,5.93308,0,0),
(38122,5,-192.449,41.5195,-47.8548,0,0,0.744733,0,0),
(38122,6,-179.34,54.9077,-43.814,0,0,1.23011,0,0),
(38122,7,-177.227,63.0098,-43.5805,0,0,1.74062,0,0),
(38122,8,-182.851,69.7657,-45.6939,0,0,2.64618,0,0),
(38122,9,-193.14,70.3026,-47.7897,0,0,3.75202,0,0),
(38122,10,-196.643,63.5984,-48.3302,0,0,4.56491,0,0),
(38122,11,-189.152,56.1746,-47.3711,0,0,5.96683,0,0),
(38122,12,-174.955,55.8997,-42.2382,0,0,6.19852,0,0),
(38122,13,-165.256,50.6814,-39.4577,0,0,5.64874,0,0),
(38122,14,-157.318,42.6426,-35.5535,0,0,5.36208,0,0),
(38122,15,-153.533,37.0276,-32.6655,0,0,5.28354,0,0),
(38122,16,-146.112,23.6438,-28.4371,0,0,5.20107,0,0),
(38122,17,-153.574,37.4096,-32.7856,0,0,2.18094,0,0),
(38122,18,-157.071,42.8507,-35.5542,0,0,2.33881,0,0),
(38122,19,-164.853,50.4357,-39.3263,0,0,2.44484,0,0),
(38122,20,-175.119,55.5717,-42.3054,0,0,3.19297,0,0),
(38122,21,-185.059,55.6917,-46.2679,0,0,3.06103,0,0),
(38122,22,-193.243,58.1374,-48.1044,0,0,2.56544,0,0),
(38122,23,-196.708,63.5264,-48.3384,0,0,1.69443,0,0),
(38122,24,-194.343,68.5748,-47.9196,0,0,0.840706,0,0),
(38122,25,-188.65,71.3681,-47.0857,0,0,0.275219,0,0),
(38122,26,-182.183,69.6568,-45.4077,0,0,5.82799,0,0),
(38122,27,-177.402,63.6642,-43.6598,0,0,4.94835,0,0),
(38122,28,-179.533,54.5513,-43.8893,0,0,4.10876,0,0),
(38122,29,-190.949,42.8993,-47.4698,0,0,3.55742,0,0),
(38122,30,-198.366,42.2613,-48.7994,0,0,2.89297,0,0),
(38122,31,-201.596,51.2377,-49.1721,0,0,1.96227,0,0),
(38122,32,-205.358,57.1103,-49.3369,0,0,2.71233,0,0),
(38122,33,-211.604,58.3914,-49.856,0,0,3.32268,0,0),
(38122,34,-220.119,58.1735,-49.0032,0,0,2.96791,0,0),
(38122,35,-230.435,59.9715,-49.5928,0,0,3.21346,0,0),
(38122,36,-245.867,58.3075,-51.8376,0,0,3.44123,0,0),
(38122,37,-262.987,52.1493,-54.1098,0,0,3.66507,0,0),
(38122,38,-269.738,46.4245,-54.6324,0,0,4.3837,0,0),
(38122,39,-272.867,29.4482,-59.3862,0,0,4.54471,0,0),
(38122,40,-276.413,17.8821,-61.3901,0,0,4.27375,0,0),
(38122,41,-273.023,29.1812,-59.436,0,0,1.28924,0,0),
(38122,42,-269.989,46.11,-54.7535,0,0,0.975077,0,0),
(38122,43,-262.959,52.3755,-54.0855,0,0,0.485774,0,0),
(38122,44,-245.125,58.3236,-51.7314,0,0,0.104855,0,0),
(38122,45,-234.488,59.2599,-50.0718,0,0,6.25131,0,0),
(38122,46,-220.257,58.488,-49.0034,0,0,6.26701,0,0);
-- Wailing Caverns:
-- Spawn Distance adjustments:
-- 15-rane (used for select critters):
UPDATE creature SET spawndist=15, MovementType=1 WHERE guid IN (38145, 87154);
-- 10-range:
UPDATE creature SET spawndist=10, MovementType=1 WHERE guid IN (33964, 33957, 33932, 45722, 85901, 38121);
-- 7-range:
UPDATE creature SET spawndist=7, MovementType=1 WHERE guid IN (33946, 33987, 85919, 85965, 86137, 86013, 87143, 87156, 18682, 26203, 38147);
-- 6-range:
UPDATE creature SET spawndist=6, MovementType=1 WHERE guid IN (33956, 85959, 18679, 18681, 18680);
-- 0 (DISABLE):
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN (85948);

-- Spawn Distance Adjustments to already spawned lashers:
UPDATE creature SET spawndist=6, MovementType=1 WHERE guid IN (18686, 18683, 18684, 18685, 33980, 33981, 33982, 38126, 38120, 38132, 38127, 45721, 48752, 85920, 85916, 85912, 85917, 85918, 85989, 87112, 85988, 87111, 87110, 87106, 87109, 87103, 87098, 87102, 87101, 87097, 86104, 87120, 87119, 87118, 87135, 87137, 87138, 87136, 87151, 87149, 87152, 87148);

-- Critter Adjustments:
UPDATE creature SET spawndist=15, MovementType=1 WHERE guid IN (38135, 38125, 33985, 33978, 33979, 18677, 26219, 26238, 26215, 26222, 26226, 26201, 26222, 26238, 27358, 27358, 27347, 27370, 27373, 27377, 33937, 33968, 33953, 33940);
UPDATE creature SET position_x = '17.817574', position_y = '435.634857', position_z = '-81.148735', orientation = '3.737468' WHERE guid = '33937'; -- Snake (ID 2914)
UPDATE creature SET position_x = '-70.924637', position_y = '371.368103', position_z = '-105.181313', orientation = '5.058896' WHERE guid = '27370';
UPDATE creature SET position_x = '-23.271814', position_y = '132.678024', position_z = '-106.161560', orientation = '1.518708' WHERE guid = '26219'; -- (Bile Toad 3835)
-- Disciple of Naralex, gossip text. (Pre-Awakening Ritual)
UPDATE creature_template SET GossipMenuId  = '201' WHERE entry='3678';

SET @ENTRY :='2431';

UPDATE `creature_template` SET `EquipmentTemplateId`=@ENTRY WHERE `Entry`='7228';

DELETE FROM `creature_equip_template_raw` WHERE `entry`=@ENTRY;
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(@ENTRY, '1595', '0', '0', '50267394', '0', '0', '273', '0', '0');
-- Defias Blackguard
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=28, MaxMeleeDmg=39, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=636;
-- Defias Conjurer
UPDATE creature_template SET DamageMultiplier=1.2, MinMeleeDmg=16, MaxMeleeDmg=23, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=24, RangedAttackPower=13 WHERE Entry=619;
-- Defias Evoker
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=18, MaxMeleeDmg=26, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=27, RangedAttackPower=13 WHERE Entry=1729;
-- Defias Henchman
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=22, MaxMeleeDmg=31, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=56, RangedAttackPower=2 WHERE Entry=594;
-- Defias Magician
UPDATE creature_template SET DamageMultiplier=1.2, MinMeleeDmg=22, MaxMeleeDmg=31, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=56, RangedAttackPower=2 WHERE Entry=1726;
-- Defias Miner
UPDATE creature_template SET MinLevel = 18, ArmorMultiplier=1, DamageMultiplier=1.0, MinMeleeDmg=25, MaxMeleeDmg=35, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=3 WHERE Entry=598;
-- Defias Overseer
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=25, MaxMeleeDmg=35, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=3 WHERE Entry=634;
-- Defias Pirate
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=28, MaxMeleeDmg=39, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=657;
-- Defias Squallshaper
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=20, MaxMeleeDmg=29, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=30, RangedAttackPower=14 WHERE Entry=1732;
-- Defias Squallshaper
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=20, MaxMeleeDmg=29, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=30, RangedAttackPower=14 WHERE Entry=1732;
-- Defias Strip Miner
UPDATE creature_template SET DamageMultiplier=1.0, MinMeleeDmg=26, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3 WHERE Entry=4416;
-- Defias Taskmaster
UPDATE creature_template SET MinLevel = 18, ArmorMultiplier=1, DamageMultiplier=1.7, MinMeleeDmg=26, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3 WHERE Entry=4417;
-- Defias Watchman
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=23, MaxMeleeDmg=33, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=60, RangedAttackPower=2 WHERE Entry=1725;
-- Defias Wizard
UPDATE creature_template SET MinLevel = 18, ArmorMultiplier=1, DamageMultiplier=2.0, MinMeleeDmg=18, MaxMeleeDmg=28, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=28, RangedAttackPower=13 WHERE Entry=4418;
-- Defias Worker
UPDATE creature_template SET DamageMultiplier=1.0, MinMeleeDmg=23, MaxMeleeDmg=33, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=60, RangedAttackPower=2 WHERE Entry=1727;

-- Goblin Engineer
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=26, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3 WHERE Entry=622;
-- Goblin Shipbuilder
UPDATE creature_template SET HealthMultiplier=3, MinLevelHealth=1347, MaxLevelHealth=1452, ArmorMultiplier=1, MinLevelMana=0, MaxLevelMana=0, DamageMultiplier=1.7, MinMeleeDmg=28, MaxMeleeDmg=39, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=3947;
-- Goblin Woodcarver
UPDATE creature_template SET HealthMultiplier=3, MinLevelHealth=1251, MaxLevelHealth=1347, ArmorMultiplier=1, MinLevelMana=0, MaxLevelMana=0, DamageMultiplier=1.7, MinMeleeDmg=26, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3 WHERE Entry=641;

-- Skeletal Miner
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=25, MaxMeleeDmg=35, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=3 WHERE Entry=623;
-- Undead Excavator
UPDATE creature_template SET HealthMultiplier=3, MinLevelHealth=1158, MaxLevelHealth=1251, ArmorMultiplier=1, MinLevelMana=0, MaxLevelMana=0, DamageMultiplier=1.7, MinMeleeDmg=25, MaxMeleeDmg=35, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=3 WHERE Entry=624;
-- Undead Dynamiter
UPDATE creature_template SET HealthMultiplier=3, MinLevelHealth=1158, MaxLevelHealth=1251, ArmorMultiplier=1, MinLevelMana=0, MaxLevelMana=0, DamageMultiplier=1.7, MinMeleeDmg=25, MaxMeleeDmg=35, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=3 WHERE Entry=625;

-- Brainwashed Noble
UPDATE creature_template SET HealthMultiplier=3, ArmorMultiplier=1, DamageMultiplier=1.2, MinMeleeDmg=19, MaxMeleeDmg=26, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=27, RangedAttackPower=13 WHERE Entry=596;
-- Captain Greenskin
UPDATE creature_template SET DamageMultiplier=3, MinMeleeDmg=29, MaxMeleeDmg=39, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=647;
-- Cookie
UPDATE creature_template SET DamageMultiplier=2.45, MinMeleeDmg=29, MaxMeleeDmg=39, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=645;
-- Edwin VanCleef
UPDATE creature_template SET HealthMultiplier=8, MinLevelHealth=4168, MaxLevelHealth=4168, ArmorMultiplier=1, DamageMultiplier=2.45, MinMeleeDmg=23, MaxMeleeDmg=30, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=74, RangedAttackPower=4 WHERE Entry=639;
-- Foreman Thistlenettle
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=29, MaxMeleeDmg=39, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=626;
-- Gilnid
UPDATE creature_template SET DamageMultiplier=2.45, MinMeleeDmg=29, MaxMeleeDmg=39, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=1763;
-- Marisa du'Paige
UPDATE creature_template SET DamageMultiplier=1.2, MinMeleeDmg=19, MaxMeleeDmg=26, MeleeAttackPower=27, RangedAttackPower=13 WHERE Entry=599;
-- Miner Johnson
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=28, MaxMeleeDmg=37, MeleeAttackPower=68, RangedAttackPower=3 WHERE Entry=3586;
-- Mr. Smite
UPDATE creature_template SET DamageMultiplier=2.45, MinMeleeDmg=29, MaxMeleeDmg=39, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=646;
-- Rhahk'Zor
UPDATE creature_template SET DamageMultiplier=2.45, MinMeleeDmg=48, MaxMeleeDmg=64, MeleeAttackPower=68, RangedAttackPower=3 WHERE Entry=644;
-- Sneed's Shredder
UPDATE creature_template SET DamageMultiplier=3.3, MinMeleeDmg=29, MaxMeleeDmg=39, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=642;
-- Sneed
UPDATE creature_template SET DamageMultiplier=3.3, MinMeleeDmg=29, MaxMeleeDmg=39, MeleeAttackPower=70, RangedAttackPower=4 WHERE Entry=643;

UPDATE `gameobject_template` SET `faction`='114', `data3`='3000' WHERE `entry`='144065';
-- Fixed movement of two NPCs in Felwood
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (40659, 40665);

-- Alzzin the Wildshaper [58]
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('10.0' / '7.0'), `DamageMultiplier`='5.5', `MinMeleeDmg`='60.4', `MaxMeleeDmg`='80.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='1300', `RangedBaseAttackTime`='1300' WHERE `Entry`='11492';

-- Alzzin's Minion [56]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('15' / '7.0'), `DamageMultiplier`='0.5', `MinMeleeDmg`='38.4', `MaxMeleeDmg`='50.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='800', `RangedBaseAttackTime`='800' WHERE `Entry`='11460';

-- Death Lash [57-58]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `PowerMultiplier`='1.5', `DamageMultiplier`='6', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `ResistanceFire`='0', `ResistanceNature`='0', `ResistanceFrost`='0', `ResistanceShadow`='0', `ResistanceArcane`='0' WHERE `Entry`='13285';

-- Fel Lash [56]
UPDATE `creature_template` SET `MinLevel`='56', `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='6', `PowerMultiplier`='2', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinMeleeDmg`='89.3', `MaxMeleeDmg`='118.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='220', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='13197';

-- Hydroling [57]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `MinMeleeDmg`='20', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `DamageSchool`='4' WHERE `Entry`='14350';

-- Hydrospawn [57]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('9.02778' / '7.0'), `DamageMultiplier`='6.5', `MinMeleeDmg`='91.1', `MaxMeleeDmg`='120.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='224', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='13280';

-- Ironbark the Redeemed [58] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `MinMeleeDmg`='99.8', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14241';

-- Isalien [60]
UPDATE `creature_template` SET `CreatureTypeFlags`='0', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='6', `MinMeleeDmg`='125.8', `MaxMeleeDmg`='166.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2600', `RangedBaseAttackTime`='2600' WHERE `Entry`='16097';

-- Isalien Trigger [60] [NOBESTIARY]
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `FactionAlliance`='114', `FactionHorde`='114', `HealthMultiplier`='1.35', `MinLevelHealth`='4496', `MaxLevelHealth`='4496', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `RangedBaseAttackTime`='2000' WHERE `Entry`='16045';

-- Empyrean [60]
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `DamageMultiplier`='6', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26' WHERE `Entry`='16098';

-- Lethtendris [57]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='6', `MinMeleeDmg`='91.1', `MaxMeleeDmg`='120.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='224', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14327';

-- Old Ironbark [58] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='1.25', `ArmorMultiplier`='1', `MinLevelHealth`='3589', `MaxLevelHealth`='3589', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11491';

-- Phase Lasher [54-55]
UPDATE `creature_template` SET `MinLevel`='54', `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='6', `PowerMultiplier`='2', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinMeleeDmg`='92.1', `MaxMeleeDmg`='127.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3271', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='13196';

-- Pimgib [56]
UPDATE `creature_template` SET `MinLevel`='56', `MaxLevel`='56', `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `PowerMultiplier`='3', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinMeleeDmg`='89.3', `MaxMeleeDmg`='118.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='220', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14349';

-- Pusillin [57]
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('18' / '7.0'), `DamageMultiplier`='4', `MinMeleeDmg`='91.1', `MaxMeleeDmg`='120.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2744', `MeleeAttackPower`='224', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14354';

-- Warpwood Crusher [56]
UPDATE `creature_template` SET `MinLevel`='56', `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.77778' / '2.5'), `HealthMultiplier`='6', `PowerMultiplier`='1.5', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinMeleeDmg`='119.9', `MaxMeleeDmg`='145.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='13021';

-- Warpwood Guardian [57-58]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='3.8', `ArmorMultiplier`='1.5', `MinMeleeDmg`='91.1', `MaxMeleeDmg`='123.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4141', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `ResistanceFire`='-58' WHERE `Entry`='11461';

-- Warpwood Stomper [57-58]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `PowerMultiplier`='1.5', `DamageMultiplier`='3.8', `ArmorMultiplier`='1.25',`MinMeleeDmg`='122.4', `MaxMeleeDmg`='164.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4275', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500', `ResistanceFire`='-58' WHERE `Entry`='11465';

-- Warpwood Tangler [55-56]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='3.6', `ArmorMultiplier`='1.25', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='118.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3354', `MeleeAttackPower`='220', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `ResistanceFire`='-56' WHERE `Entry`='11464';

-- Warpwood Treant [54-55]
UPDATE `creature_template` SET `MinLevel`='54', `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `PowerMultiplier`='1.5', `DamageMultiplier`='3.5', `ArmorMultiplier`='1.25', `MinMeleeDmg`='92.1', `MaxMeleeDmg`='124.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4071', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `ResistanceFire`='-55' WHERE `Entry`='11462';

-- Whip Lasher [54]
UPDATE `creature_template` SET `MinLevel`='54', `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='0.75', `DamageMultiplier`='0.75', `ArmorMultiplier`='1', `MinMeleeDmg`='92.1', `MaxMeleeDmg`='122.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='224', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='13022';

-- Wildspawn Betrayer [55-56]
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `PowerMultiplier`='1.5', `DamageMultiplier`='3.6', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3327', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11454';

-- Wildspawn Felsworn [55-56] [NODMGMULT]
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `MinMeleeDmg`='292', `MaxMeleeDmg`='393', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1686', `MeleeAttackPower`='104', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11455';

-- Wildspawn Hellcaller [56-57]
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='3.7', `MinMeleeDmg`='89.3', `MaxMeleeDmg`='120.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2744', `MeleeAttackPower`='224', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11457';

-- Wildspawn Imp [56]
UPDATE `creature_template` SET `MinLevel`='56', `FactionAlliance`='16', `FactionHorde`='16', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `ArmorMultiplier`='1', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='127.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='13276';

-- Wildspawn Rogue [56-57]
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `PowerMultiplier`='1.5', `DamageMultiplier`='3.7', `MinMeleeDmg`='71.9', `MaxMeleeDmg`='97.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='11452';

-- Wildspawn Satyr [55-56]
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `PowerMultiplier`='1.5', `DamageMultiplier`='3.6', `ArmorMultiplier`='1.25', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='127.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4141', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11451';

-- Wildspawn Shadowstalker [56]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `PowerMultiplier`='1.5', `DamageMultiplier`='3.6', `MinMeleeDmg`='71.9', `MaxMeleeDmg`='95.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='11456';

-- Wildspawn Trickster [56-57]
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='3.7', `MinMeleeDmg`='89.3', `MaxMeleeDmg`='120.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2744', `MeleeAttackPower`='224', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11453';

-- Zevrim Thornhoof [57]
UPDATE `creature_template` SET `MinLevel`='57', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='8', `DamageMultiplier`='6.5', `ArmorMultiplier`='1', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11490';

UPDATE `creature` SET `modelid`='0', `position_x`='-503.135', `position_y`='582.624', `position_z`='-230.6010', `orientation`='2.741180', `spawndist`='0', `MovementType`='2' WHERE `guid`='30186';
UPDATE `creature` SET `modelid`='0', `position_x`='-529.127', `position_y`='526.401', `position_z`='-273.0680', `orientation`='2.513030', `spawndist`='0', `MovementType`='2' WHERE `guid`='30278';
UPDATE `creature` SET `modelid`='0', `position_x`='-617.866', `position_y`='521.326', `position_z`='-273.0690', `orientation`='5.915490', `spawndist`='0', `MovementType`='2' WHERE `guid`='30279';
UPDATE `creature` SET `modelid`='0', `position_x`='-507.445', `position_y`='422.019', `position_z`='-230.6010', `orientation`='0.570874', `spawndist`='0', `MovementType`='2' WHERE `guid`='32013';

DELETE FROM `creature_movement` WHERE `id` IN ('30278', '30279', '32013', '30186');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30278', '10', '-526.675', '524.619', '-273.068', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30278', '9', '-521.2060', '507.233', '-273.067', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30278', '8', '-523.5720', '491.817', '-273.069', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30278', '7', '-532.7750', '480.186', '-273.069', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30278', '6', '-553.5550', '475.599', '-273.067', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30278', '5', '-569.5510', '477.793', '-273.076', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30278', '4', '-580.6870', '498.944', '-273.076', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30278', '3', '-584.0870', '529.736', '-273.073', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30278', '2', '-565.1860', '544.829', '-273.073', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30278', '1', '-544.7730', '537.774', '-273.070', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '11', '-622.531', '522.641', '-273.062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '10', '-587.104', '508.355', '-273.077', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '9', '-585.4900', '487.777', '-273.079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '8', '-502.1940', '181.335', '-155.236', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '7', '-601.2440', '467.478', '-273.092', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '6', '-637.8530', '438.359', '-273.064', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '5', '-673.0290', '411.361', '-273.064', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '4', '-637.8530', '438.359', '-273.064', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '3', '-601.1290', '467.570', '-273.084', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '2', '-585.4900', '487.777', '-273.079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '1', '-587.1040', '508.355', '-273.077', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '10', '-513.909', '418.426', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '9', '-495.8350', '429.647', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '8', '-468.0340', '461.691', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '7', '-458.9660', '499.773', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '6', '-462.5300', '539.847', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '5', '-488.9830', '575.050', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '4', '-462.5300', '539.847', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '3', '-458.9660', '499.773', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '2', '-468.0340', '461.691', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('32013', '1', '-495.8350', '429.647', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '10', '-566.064', '596.358', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '9', '-603.9720', '581.169', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '8', '-632.9300', '549.396', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '7', '-645.6080', '506.450', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '6', '-638.9070', '472.245', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '5', '-645.6080', '506.450', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '4', '-632.9300', '549.396', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '3', '-603.9720', '581.169', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '2', '-566.0640', '596.358', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '1', '-529.9410', '593.970', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '11', '-529.941', '593.970', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30186', '12', '-496.669', '579.886', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-569.716', `position_y`='132.406', `position_z`='-202.059', `orientation`='4.44676', `spawndist`='0' WHERE `guid`='30134';

DELETE FROM `creature_movement` WHERE `id`=(SELECT `guid` FROM `creature` WHERE `id`='7897');
DELETE FROM `creature_movement_template` WHERE `entry`='7897';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('7897', '1', '-574.488', '113.327', '-201.832', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7897', '2', '-574.915', '96.9830', '-201.557', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7897', '3', '-571.492', '84.7931', '-203.301', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7897', '4', '-563.095', '77.1981', '-203.549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7897', '5', '-554.813', '75.1497', '-201.725', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7897', '6', '-571.492', '84.7931', '-203.301', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7897', '7', '-574.915', '96.9830', '-201.557', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7897', '8', '-574.488', '113.327', '-201.832', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7897', '9', '-572.200', '123.274', '-202.141', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7897', '10', '-570.78', '128.660', '-202.141', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');
-- Fixed level, health, mana and damage stats of the creatures (trash,
-- rares and bosses) in the Wailing Caverns. They are now similar to what they
-- were back in Classic.
-- Several sources were used with cross-checking: Bestiary, WoW Dungeon
-- Companion, various web archives (wowwiki, allakhazam...)
-- This closes #488

-- ---------------------
-- Trash mobs
-- ---------------------
-- Deviate Coiler
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=22, MaxMeleeDmg=31, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=56, RangedAttackPower=2, MeleeBaseAttackTime=2000 WHERE Entry=3630;
-- Deviate Stinglash
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=23, MaxMeleeDmg=33, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=60, RangedAttackPower=2, MeleeBaseAttackTime=2000 WHERE Entry=3631;
-- Deviate Creeper
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=22, MaxMeleeDmg=31, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=56, RangedAttackPower=2, MeleeBaseAttackTime=2000 WHERE Entry=3632;
-- Deviate Slayer
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=23, MaxMeleeDmg=33, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=60, RangedAttackPower=2, MeleeBaseAttackTime=2000 WHERE Entry=3633;
-- Deviate Stalker
UPDATE creature_template SET MinLevel=15, MaxLevel=16, DamageMultiplier=1.7, MinMeleeDmg=22, MaxMeleeDmg=31, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=56, RangedAttackPower=2, MeleeBaseAttackTime=2000 WHERE Entry=3634;
-- Deviate Ravager
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=26, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3, MeleeBaseAttackTime=2000 WHERE Entry=3636;
-- Deviate Guardian
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=26, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3, MeleeBaseAttackTime=2000 WHERE Entry=3637;
-- Deviate Lurker
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=23, MaxMeleeDmg=33, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=60, RangedAttackPower=2, MeleeBaseAttackTime=2000 WHERE Entry=3641;
-- Deviate Adder
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=26, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3, MeleeBaseAttackTime=2000 WHERE Entry=5048;
-- Deviate Crocolisk
UPDATE creature_template SET DamageMultiplier=1.0, MinMeleeDmg=26, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3, MeleeBaseAttackTime=2000 WHERE Entry=5053;
-- Deviate Lasher
UPDATE creature_template SET MinLevel=19, MaxLevel=20, HealthMultiplier=0.3, MaxLevelHealth=145, ArmorMultiplier=1, DamageMultiplier=1.15, MinMeleeDmg=28, MaxMeleeDmg=39, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=70, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=5055;
-- Deviate Dreadfang
UPDATE creature_template SET HealthMultiplier=3, MinLevelHealth=1452, MaxLevelHealth=1563, ArmorMultiplier=1, DamageMultiplier=1.7, MinMeleeDmg=29, MaxMeleeDmg=40, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=74, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=5056;
-- Deviate Viper
UPDATE creature_template SET MinLevel=20, HealthMultiplier=2.5, MinLevelHealth=1452, MaxLevelHealth=1452, ArmorMultiplier=1, DamageMultiplier=1.7, MinMeleeDmg=29, MaxMeleeDmg=39, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=70, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=5755;
-- Deviate Venomwing
UPDATE creature_template SET HealthMultiplier=3, MinLevelHealth=1452, MaxLevelHealth=1563, ArmorMultiplier=1, DamageMultiplier=1.7, MinMeleeDmg=29, MaxMeleeDmg=40, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=74, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=5756;
-- Deviate Shambler
UPDATE creature_template SET HealthMultiplier=3, MaxLevelHealth=1299, MaxLevelMana=490, ArmorMultiplier=1, DamageMultiplier=1.7, MinMeleeDmg=26, MaxMeleeDmg=36, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=5761;
-- Deviate Moccasin
UPDATE creature_template SET HealthMultiplier=3, MinLevelHealth=1452, MaxLevelHealth=1563, ArmorMultiplier=1, DamageMultiplier=1.7, MinMeleeDmg=29, MaxMeleeDmg=40, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=74, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=5762;
-- Deviate Nightmare
UPDATE creature_template SET MinLevel=19, MaxLevel=21, HealthMultiplier=1, MinLevelHealth=449, MaxLevelHealth=521, ArmorMultiplier=1, DamageMultiplier=1.0, MinMeleeDmg=28, MaxMeleeDmg=40, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=74, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=5914;
-- Deviate Python
UPDATE creature_template SET DamageMultiplier=1.0, MinMeleeDmg=26, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3, MeleeBaseAttackTime=2000 WHERE Entry=8886;

-- Devouring Ectoplasm
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=23, MaxMeleeDmg=33, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=60, RangedAttackPower=2, MeleeBaseAttackTime=2000 WHERE Entry=3638;
-- Evolving Ectoplasm 3640
-- Previously done
-- Nightmare Ectoplasm
UPDATE creature_template SET MaxLevelHealth=521, MinLevelHealth=484, ArmorMultiplier=1, DamageMultiplier=1.0, MinMeleeDmg=29, MaxMeleeDmg=40, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=74, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=5763;
-- Cloned Ectoplasm
UPDATE creature_template SET MaxLevelHealth=1158, MinLevelHealth=1068, HealthMultiplier=3, ArmorMultiplier=1, DamageMultiplier=1.7, MinMeleeDmg=23, MaxMeleeDmg=33, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=60, RangedAttackPower=2, MeleeBaseAttackTime=2000 WHERE Entry=5780;

-- Druid of the Fang
UPDATE creature_template SET MaxLevelHealth=1299, MaxLevelMana=980, ArmorMultiplier=1, DamageMultiplier=1.7, MinMeleeDmg=26, MaxMeleeDmg=36, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=3840;


-- ---------------------
-- Bosses and rares mobs
-- ---------------------
-- Deviate Faerie Dragon
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=29, MaxMeleeDmg=39, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=70, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=5912;
-- Boahn
UPDATE creature_template SET DamageMultiplier=1.25, MinMeleeDmg=27, MaxMeleeDmg=36, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=3672;
-- Kresh
UPDATE creature_template SET MaxLevelHealth=1452, MinLevelHealth=1452, HealthMultiplier=3, ArmorMultiplier=1, DamageMultiplier=1.7, MinMeleeDmg=29, MaxMeleeDmg=39, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=70, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=3653;
-- Lady Anacondra
UPDATE creature_template SET DamageMultiplier=2.5, MinMeleeDmg=27, MaxMeleeDmg=36, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=3671;
-- Lord Cobrahn
UPDATE creature_template SET DamageMultiplier=2.5, MinMeleeDmg=27, MaxMeleeDmg=36, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=3669;
-- Lord Pythas
UPDATE creature_template SET MaxLevelHealth=2320, MinLevelHealth=2320, HealthMultiplier=5, MinLevelMana=510, MaxLevelMana=510, ArmorMultiplier=1, DamageMultiplier=2.86, MinMeleeDmg=28, MaxMeleeDmg=38, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=3670;
-- Lord Serpentis
UPDATE creature_template SET MaxLevelHealth=2784, MinLevelHealth=2784, HealthMultiplier=6, PowerMultiplier=3, MinLevelMana=1530, MaxLevelMana=1530, ArmorMultiplier=1, DamageMultiplier=2.86, MinMeleeDmg=28, MaxMeleeDmg=38, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=3673;
-- Mad Magglish
UPDATE creature_template SET DamageMultiplier=1.7, MinMeleeDmg=26, MaxMeleeDmg=25, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=64, RangedAttackPower=3, MeleeBaseAttackTime=2000 WHERE Entry=3655;
-- Mutanus the Devourer
UPDATE creature_template SET MaxLevelHealth=4496, MinLevelHealth=4496, HealthMultiplier=8, ArmorMultiplier=1, DamageMultiplier=2.4, MinMeleeDmg=32, MaxMeleeDmg=42, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=78, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=3654;
-- Skum
UPDATE creature_template SET MaxLevelHealth=3906, MinLevelHealth=3906, HealthMultiplier=7.5, ArmorMultiplier=1, DamageMultiplier=2.0, MinMeleeDmg=31, MaxMeleeDmg=40, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=74, RangedAttackPower=4, MeleeBaseAttackTime=2000 WHERE Entry=3674;
-- Trigore the Lasher
UPDATE creature_template SET DamageMultiplier=1.25, MinMeleeDmg=28, MaxMeleeDmg=37, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=68, RangedAttackPower=3, MeleeBaseAttackTime=2000 WHERE Entry=3652;
-- Verdan the Everliving
UPDATE creature_template SET MaxLevelHealth=4168, MinLevelHealth=4168, HealthMultiplier=8, ArmorMultiplier=1, DamageMultiplier=5.4, MinMeleeDmg=53, MaxMeleeDmg=71, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=74, RangedAttackPower=4 WHERE Entry=5775;
UPDATE `creature_template` SET `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10447';

-- Olaf [40] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3.5', `DamageMultiplier`='1', `ArmorMultiplier`='1', `MinLevelHealth`='5106', `MaxLevelHealth`='5106', `MinMeleeDmg`='56.0', `MaxMeleeDmg`='74.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1964', `MeleeAttackPower`='136', `RangedAttackPower`='14', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='6908';

-- Eric "The Swift" [40] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('15.0' / '7.0'), `HealthMultiplier`='3', `DamageMultiplier`='1', `ArmorMultiplier`='1', `MinLevelHealth`='4572', `MaxLevelHealth`='4572', `MinMeleeDmg`='56.0', `MaxMeleeDmg`='74.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1964', `MeleeAttackPower`='136', `RangedAttackPower`='14', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='6907';

-- Baelog [41] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='1', `ArmorMultiplier`='1', `MinLevelHealth`='4755', `MaxLevelHealth`='4755', `MinMeleeDmg`='58.7', `MaxMeleeDmg`='77.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2101', `RangedAttackPower`='15', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='6906';

-- Remains of a Paladin [35]
UPDATE `creature_template` SET `UnitFlags`='768', `ExtraFlags`='0', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='1.1', `ArmorMultiplier`='1', `MinLevelHealth`='1110', `MaxLevelHealth`='1110', `MinMeleeDmg`='45.2', `MaxMeleeDmg`='59.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1149', `MeleeAttackPower`='110', `RangedAttackPower`='11', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='6912';

-- Revelosh [40]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='2', `ArmorMultiplier`='1', `MinLevelHealth`='3678', `MaxLevelHealth`='3678', `MinLevelMana`='2566', `MaxLevelMana`='2566', `MinMeleeDmg`='52.1', `MaxMeleeDmg`='69.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1619', `MeleeAttackPower`='128', `RangedAttackPower`='13', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='6910';

-- Ironaya [40]
UPDATE `creature_template` SET `FactionAlliance`='416', `FactionHorde`='416', `SpeedWalk`=('4.16667' / '2.5'), `HealthMultiplier`='10', `DamageMultiplier`='4.5', `ArmorMultiplier`='1', `MinLevelHealth`='15240', `MaxLevelHealth`='15240', `MinMeleeDmg`='81.2', `MaxMeleeDmg`='107.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1964', `MeleeAttackPower`='136', `RangedAttackPower`='14', `MeleeBaseAttackTime`='2900', `RangedBaseAttackTime`='2900' WHERE `Entry`='7228';

-- Obsidian Sentinel [42]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='5', `DamageMultiplier`='3.5', `ArmorMultiplier`='1', `MinLevelHealth`='8255', `MaxLevelHealth`='8255', `MinMeleeDmg`='62.4', `MaxMeleeDmg`='82.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2246', `MeleeAttackPower`='152', `RangedAttackPower`='15', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7023';

-- Obsidian Shard [?] [NOSNIFF][NOBESTIARY]
	-- TO DO

-- Ancient Stone Keeper [44]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='5', `DamageMultiplier`='3.5', `ArmorMultiplier`='2', `MinLevelHealth`='8910', `MaxLevelHealth`='8910', `MinMeleeDmg`='86.4', `MaxMeleeDmg`='114.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='5114', `MeleeAttackPower`='174', `RangedAttackPower`='16', `MeleeBaseAttackTime`='2400', `RangedBaseAttackTime`='2400' WHERE `Entry`='7206';

-- Sand Storm [?] [NOSNIFF][NOBESTIARY]
	-- TO DO

-- Galgann Firehammer [45] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='9', `DamageMultiplier`='1', `ArmorMultiplier`='1', `MinLevelHealth`='13302', `MaxLevelHealth`='13302', `MinMeleeDmg`='70.4', `MaxMeleeDmg`='93.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2211', `MeleeAttackPower`='172', `RangedAttackPower`='15', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7291';

-- Grimlok [45]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='5', `PowerMultiplier`='2', `DamageMultiplier`='2.5', `ArmorMultiplier`='1', `MinLevelHealth`='7390', `MaxLevelHealth`='7390', `MinLevelMana`='3068', `MaxLevelMana`='3068', `MinMeleeDmg`='70.4', `MaxMeleeDmg`='93.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2211', `MeleeAttackPower`='172', `RangedAttackPower`='15', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4854';

-- Archaedas [47]
UPDATE `creature_template` SET `SpeedWalk`=('3.75' / '2.5'), `DamageMultiplier`='2.7', `MinMeleeDmg`='102.5', `MaxMeleeDmg`='135.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2835', `MeleeAttackPower`='192', `RangedAttackPower`='18', `MeleeBaseAttackTime`='2600', `RangedBaseAttackTime`='2600' WHERE `Entry`='2748';

-- Lore Keeper of Norgannon [60] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('3.75' / '2.5'), `HealthMultiplier`='1.35', `ArmorMultiplier`='1', `MinLevelHealth`='4120', `MaxLevelHealth`='4120', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7172';

-- Annora [54]
UPDATE `creature_template` SET `UnitFlags`='768', `ExtraFlags`='0', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='1.3', `ArmorMultiplier`='1', `MinLevelHealth`='3293', `MaxLevelHealth`='3293', `MinMeleeDmg`='92.1', `MaxMeleeDmg`='122.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3216', `MeleeAttackPower`='224', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11073';

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Stonevault Geomancer [43-44]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='2.4', `ArmorMultiplier`='1', `MinLevelHealth`='4119', `MaxLevelHealth`='4278', `MinLevelMana`='1432', `MaxLevelMana`='1483', `MinMeleeDmg`='61.9', `MaxMeleeDmg`='88.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2082', `MeleeAttackPower`='166', `RangedAttackPower`='15', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4853';

-- Stonevault Brawler [43-44]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='2.4', `ArmorMultiplier`='0.3', `MinLevelHealth`='5148', `MaxLevelHealth`='5346', `MinMeleeDmg`='66.6', `MaxMeleeDmg`='95.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='767', `MeleeAttackPower`='174', `RangedAttackPower`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4855';

-- Stonevault Mauler [44-45]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='2.5', `ArmorMultiplier`='0.3', `MinLevelHealth`='5346', `MaxLevelHealth`='5544', `MinMeleeDmg`='72.0', `MaxMeleeDmg`='100.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='808', `MeleeAttackPower`='184', `RangedAttackPower`='17', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7320';

-- Stonevault Flameweaver [44-45] [UNITCLASSMAGE]
	-- TO DO

-- Stonevault Cave Lurker [38-39]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='1.9', `ArmorMultiplier`='1', `MinMeleeDmg`='52.7', `MaxMeleeDmg`='72.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1834', `MeleeAttackPower`='132', `RangedAttackPower`='13', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4850';

-- Stonevault Oracle [37-38]
UPDATE `creature_template` SET `MinLevel`='37', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `PowerMultiplier`='1', `DamageMultiplier`='1.8', `ArmorMultiplier`='1', `MaxLevelHealth`='3567', `MaxLevelMana`='1189', `MinMeleeDmg`='47.7', `MaxMeleeDmg`='64.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1418', `MeleeAttackPower`='120', `RangedAttackPower`='12', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4852';

-- Stonevault Ambusher [35]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `ArmorMultiplier`='0.3', `MinMeleeDmg`='48.6', `MaxMeleeDmg`='64.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='118', `RangedAttackPower`='11', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7175';

-- Stonevault Rockchewer [36-37] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='1.7', `MinMeleeDmg`='62.2', `MaxMeleeDmg`='85.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1593', `MeleeAttackPower`='124', `RangedAttackPower`='12', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='4851';

-- Cleft Scorpid [35-36]
UPDATE `creature_template` SET `Scale`='0', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='0.75', `ArmorMultiplier`='1', `MinLevelHealth`='915', `MaxLevelHealth`='957', `MinMeleeDmg`='48.6', `MaxMeleeDmg`='66.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='120', `RangedAttackPower`='12', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7078';

-- Deadly Cleft Scorpid [42-43]
UPDATE `creature_template` SET `Scale`='0', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='0.75', `ArmorMultiplier`='1', `MinLevelHealth`='1238', `MaxLevelHealth`='1287', `MinMeleeDmg`='62.4', `MaxMeleeDmg`='88.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2397', `MeleeAttackPower`='162', `RangedAttackPower`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7405';

-- Venomlash Scorpid [39-40]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='2', `ArmorMultiplier`='1', `MinLevelHealth`='4377', `MaxLevelHealth`='4572', `MinMeleeDmg`='54.3', `MaxMeleeDmg`='74.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1964', `MeleeAttackPower`='136', `RangedAttackPower`='14', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7022';

-- Jadespine Basilisk [39-40]
UPDATE `creature_template` SET `SpeedWalk`=('2.77778' / '2.5'), `HealthMultiplier`='2', `DamageMultiplier`='2', `ArmorMultiplier`='1', `MinLevelHealth`='4377', `MaxLevelHealth`='4572', `MinMeleeDmg`='54.3', `MaxMeleeDmg`='74.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1964', `MeleeAttackPower`='136', `RangedAttackPower`='14', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4863';

-- Shrike Bat [38-39]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='1.9', `ArmorMultiplier`='1', `MinLevelHealth`='4185', `MaxLevelHealth`='4377', `MinMeleeDmg`='52.7', `MaxMeleeDmg`='72.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1834', `MeleeAttackPower`='132', `RangedAttackPower`='13', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4861';

-- Shadowforge Relic Hunter [39-40]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='2', `ArmorMultiplier`='1', `MinLevelHealth`='3540', `MaxLevelHealth`='3678', `MinLevelMana`='1236', `MaxLevelMana`='1283', `MinMeleeDmg`='50.5', `MaxMeleeDmg`='69.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1619', `MeleeAttackPower`='128', `RangedAttackPower`='13', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4847';

-- Shadowforge Geologist [40-41]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='2.1', `ArmorMultiplier`='1', `MinLevelHealth`='3678', `MaxLevelHealth`='3804', `MinLevelMana`='1283', `MaxLevelMana`='1332', `MinMeleeDmg`='52.1', `MaxMeleeDmg`='72.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1727', `MeleeAttackPower`='132', `RangedAttackPower`='13', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7030';

-- Shadowforge Sharpshooter [43-44]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='2.4', `ArmorMultiplier`='1', `MinLevelHealth`='5148', `MaxLevelHealth`='5346', `MinMeleeDmg`='66.6', `MaxMeleeDmg`='95.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2557', `MeleeAttackPower`='174', `RangedAttackPower`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7290';

-- Shadowforge Archaeologist [43-44]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='2.4', `ArmorMultiplier`='1', `MinLevelHealth`='5148', `MaxLevelHealth`='5346', `MinMeleeDmg`='66.6', `MaxMeleeDmg`='95.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2557', `MeleeAttackPower`='174', `RangedAttackPower`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4849';

-- Shadowforge Darkcaster [43-44]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='2.4', `ArmorMultiplier`='1', `MinLevelHealth`='4119', `MaxLevelHealth`='4278', `MinLevelMana`='1432', `MaxLevelMana`='1483', `MinMeleeDmg`='61.9', `MaxMeleeDmg`='88.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2082', `MeleeAttackPower`='166', `RangedAttackPower`='15', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4848';

-- Stone Steward [43-44]
UPDATE `creature_template` SET `MinLevel`='43', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='3', `ArmorMultiplier`='2', `MinLevelHealth`='5148', `MaxLevelHealth`='5348', `MinMeleeDmg`='66.6', `MaxMeleeDmg`='95.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='5114', `MeleeAttackPower`='174', `RangedAttackPower`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4860';

-- Vault Warder [45]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='4', `DamageMultiplier`='3', `ArmorMultiplier`='10', `MinLevelHealth`='7392', `MaxLevelHealth`='7392', `MinMeleeDmg`='94.6', `MaxMeleeDmg`='125.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='27250', `MeleeAttackPower`='184', `RangedAttackPower`='17', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='10120';

-- Stone Keeper [46]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='3', `ArmorMultiplier`='2', `MinLevelHealth`='5757', `MaxLevelHealth`='5757', `MinMeleeDmg`='108.1', `MaxMeleeDmg`='143.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='5560', `MeleeAttackPower`='188', `RangedAttackPower`='17', `MeleeBaseAttackTime`='2800', `RangedBaseAttackTime`='2800' WHERE `Entry`='4857';

-- Earthen Guardian [44-45]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='0.25', `ArmorMultiplier`='1', `MinLevelHealth`='446', `MaxLevelHealth`='462', `MinMeleeDmg`='82.8', `MaxMeleeDmg`='115.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2725', `MeleeAttackPower`='184', `RangedAttackPower`='17', `MeleeBaseAttackTime`='2300', `RangedBaseAttackTime`='2300' WHERE `Entry`='7076';

-- Earthen Custodian [44-45] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='0.25', `ArmorMultiplier`='1', `MinLevelHealth`='446', `MaxLevelHealth`='462', `MinMeleeDmg`='72.0', `MaxMeleeDmg`='100.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2725', `MeleeAttackPower`='184', `RangedAttackPower`='17', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7309';

-- Earthen Stonebreaker [44-45]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `ArmorMultiplier`='1', `MinLevelHealth`='1782', `MaxLevelHealth`='1848', `MinMeleeDmg`='90.0', `MaxMeleeDmg`='125.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2725', `MeleeAttackPower`='184', `RangedAttackPower`='17', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='7396';

-- Earthen Rocksmacher [42-43]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `ArmorMultiplier`='1', `MinLevelHealth`='1651', `MaxLevelHealth`='1716', `MinMeleeDmg`='84.2', `MaxMeleeDmg`='119.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2397', `MeleeAttackPower`='162', `RangedAttackPower`='16', `MeleeBaseAttackTime`='2700', `RangedBaseAttackTime`='2700' WHERE `Entry`='7011';

-- Earthen Stonecarver [44-45] [UNITCLASSMAGE]
	-- TO DO

-- Earthen Sculptor [42-43] [UNITCLASSMAGE]
	-- TO DO

-- Earthen Hallshaper [44-45] [UNITCLASSMAGE]
	-- TO DO
-- Several improvements in the Deadmines to bring them back to Classic times
-- Original work by @k59 and @Tobschinski, reviewed by @Muehe
-- This contribute to #487 

-- --------------------------------------------------------------------------------------------
-- Captain Greenskin (GUID 79333), Defias Pirate (GUID 79334), Defias Squallshaper (GUID 79335)
-- --------------------------------------------------------------------------------------------

-- Adjust spawn position of Captain Greenskin (ID 79333)
-- NOTE: this spawnpoint is closer to the two adds
-- NOTE: tried to adjust currentwaypoint to 5, didn't seem to work, he always went to wp 1 after spawn
UPDATE creature SET position_x = '-63.720577', position_y = '-808.797729', position_z = '41.234196', orientation = '5.771376' WHERE guid = '79333'; 

-- NOTE: make old point 5 new point 1 to match new spawn position
-- NOTE: orientation changed to 100
-- NOTE: don't know if this waittimes were meant to be in seconds but think so, changed accordingly (added 000)
DELETE FROM creature_movement WHERE id=79333;
DELETE FROM creature_movement_template WHERE entry=647;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, orientation, waittime, script_id) VALUES
(647,1,-56.0753,-808.808,41.9326,100,2000,0),
(647,2,-56.8627,-831.469,41.896,100,3000,0),
(647,3,-83.5775,-833.452,39.5389,100,0,0),
(647,4,-102.49,-824.696,38.0774,100,2000,0),
(647,5,-102.277,-814.224,38.0795,100,2000,0),
(647,6,-92.37,-808.028,38.7975,100,0,0);

-- Linking Captain Greenskin and his accompanying adds:
DELETE FROM creature_linking WHERE guid IN (79334, 79333, 79335);
INSERT INTO creature_linking  VALUES (79334, 79333, 515); -- AGGRO_ON_AGGRO, TO_AGGRO_ON_AGGRO, FOLLOW
INSERT INTO creature_linking  VALUES (79335, 79333, 515); -- AGGRO_ON_AGGRO, TO_AGGRO_ON_AGGRO, FOLLOW

-- Removed unneeded and wrong creature_addon (the template one is enough and correct)
DELETE FROM creature_addon WHERE guid=79333; -- Captain Greenskin

-- -------------------
-- Cookie (GUID 79334)
-- -------------------

-- Removed unneeded and wrong creature_addon (the template one is enough and correct)
DELETE FROM creature_addon WHERE guid='79344'; -- Cookie

-- Removed duplicate waypoints movement, the template one is enough
DELETE FROM creature_movement WHERE id=79344;
-- Fixed waittime values that were set in seconds when milliseconds are expected
UPDATE creature_movement_template SET waittime=waittime*1000 WHERE entry = 644;

-- -------------------
-- Gilnid (GUID 79206)
-- -------------------

-- Update spawndistance and MovementType for Gilnid:
UPDATE creature SET spawndist=5, MovementType=1 WHERE guid=79206;

-- -------------------------------------------------------
-- Defias Miner(GUID 79172) (in front of Rare-Spawn)
-- Not sure on this, but I think none of the Miners should
-- have MovementType 1. I actually saw this bug once on
-- 79134, he would walk right up to the instance entry 
-- (which should be a safe-zone IIRC) then bug into the
-- wall there. In current DB, 8 miners have MovementType 1
-- -------------------------------------------------------

-- Movement type idle for Defias Miner(GUID 79172, 79134)
-- NOTE: added 79134
UPDATE creature SET MovementType=0 WHERE id=598 AND MovementType<>2;

-- -------------------------------------------------------------
-- Defias Blackguard (GUID 79345, 79346), Mr. Smite (GUID 79337)
-- Took code from #273, seemed cleaner
-- -------------------------------------------------------------

DELETE FROM creature WHERE guid IN (79345, 79346);
INSERT INTO creature (guid, id, map, modelid, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, deathstate, movementtype) VALUES
(79345, 636, 36, 2314, -0.640532, -784.670654, 9.693322, 0.721177, 43200, 0, 0, 1352, 0, 0, 0), 
(79346, 636, 36, 2314, -4.788263, -779.289795, 9.801838, 0.685834, 43200, 0, 0, 1352, 0, 0, 0);  

DELETE from creature_linking WHERE master_guid= 79337;
INSERT INTO creature_linking (guid, master_guid, flag) 
VALUES
(79345, 79337, 3), -- AGGRO_ON_AGGRO, TO_AGGRO_ON_AGGRO
(79346, 79337, 3); -- AGGRO_ON_AGGRO, TO_AGGRO_ON_AGGRO

UPDATE creature_template SET FactionAlliance=27, FactionHorde=27 WHERE Entry=646;

-- ---------------------------------------------------
-- Defias Blackguard (GUID 79368, 79369, 79370, 79383)
-- Edwin VanCleef (GUID 79336)
-- Took code from #272, seemed cleaner
-- ---------------------------------------------------

DELETE FROM creature WHERE guid IN (79368, 79369, 79370, 79383);
INSERT INTO creature (guid, id, map, modelid, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, deathstate, movementtype)
VALUES
(79368, 636, 36, 2314, -78.363602, -824.518005, 39.912899, 2.708640, 43200, 0, 0, 1352, 0, 0, 0), 
(79369, 636, 36, 2314, -78.175720, -815.210999, 39.907925, 3.675046, 43200, 0, 0, 1352, 0, 0, 0);  

DELETE from creature_linking WHERE master_guid= 79336;
INSERT INTO creature_linking (guid, master_guid, flag)
VALUES (79368, 79336, 3), -- AGGRO_ON_AGGRO, TO_AGGRO_ON_AGGRO
(79369, 79336, 3); -- AGGRO_ON_AGGRO, TO_AGGRO_ON_AGGRO
-- Fixed end script emote having wrong type (whisper instead of yell) for quest 3321
UPDATE `db_script_string` SET `type` = 1, `emote` = 22 WHERE `entry` = 2000000076;
-- Fixed stats of NPC 15720 (Timbermaw Ancestor) 
UPDATE creature_template SET UnitClass=8, HealthMultiplier=0.2, ArmorMultiplier=1, DamageMultiplier=1.2, MinMeleeDmg=74, MaxMeleeDmg=102, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=112, RangedAttackPower=25, MeleeBaseAttackTime=2000, EquipmentTemplateId=1254 WHERE entry=15720;
/*Delete Ice Deflector, Accurate Scope and Goblin Jumper Cable Schematics from npc_vendor table of Supper-seller 680*/
DELETE FROM `npc_vendor` WHERE `item`=13308 AND `entry`=12246;
DELETE FROM `npc_vendor` WHERE `item`=13310 AND `entry`=12246;
DELETE FROM `npc_vendor` WHERE `item`=7561 AND `entry`=12246;
-- Removed NPC 12246 (Super-Seller 680) & 12245 (Vendor-Tron 1000) in Desolace
-- because they should be spawned by script
DELETE FROM `creature` WHERE `id` IN (12246, 12245);
-- Fixed level, health, mana and damage stats of the creatures (trash,
-- and bosses) in Scholomance. They are now similar to what they
-- were back in Classic.
-- Several sources were used with cross-checking: Bestiary, WoW Dungeon
-- Companion, various web archives (wowwiki, allakhazam...)


-- ---------------------
-- Trash mobs
-- ---------------------

-- Dark Shade
UPDATE creature_template SET MinLevelHealth=8613, MaxLevelHealth=8883, HealthMultiplier=3, ArmorMultiplier=1, DamageMultiplier=1.8, MinMeleeDmg=100, MaxMeleeDmg=135, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=248, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=11284;
-- Diseased Ghoul
UPDATE creature_template SET DamageMultiplier=3.9, MinMeleeDmg=70, MaxMeleeDmg=95, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=248, RangedAttackPower=25, MeleeBaseAttackTime=1400 WHERE Entry=10495;
-- Necrofiend
UPDATE creature_template SET DamageMultiplier=1.0, MinMeleeDmg=100, MaxMeleeDmg=138, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=252, RangedAttackPower=26, MeleeBaseAttackTime=2000 WHERE Entry=11551;
-- Plagued Hatchling
UPDATE creature_template SET MinLevelHealth=3758, MaxLevelHealth=3997, HealthMultiplier=1.35, ArmorMultiplier=1, MinLevelMana=0, MaxLevelMana=0, DamageMultiplier=1.0, MinMeleeDmg=98, MaxMeleeDmg=135, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=248, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=10678;
-- Ragged Ghoul
UPDATE creature_template SET MaxLevel=59, ArmorMultiplier=1, DamageMultiplier=3.9, MinMeleeDmg=100, MaxMeleeDmg=135, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=248, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=10497;
-- Reanimated Corpse
UPDATE creature_template SET DamageMultiplier=1.0, MinMeleeDmg=100, MaxMeleeDmg=135, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=248, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=10481;

-- Risen Aberration
UPDATE creature_template SET DamageMultiplier=2.5, MinMeleeDmg=98, MaxMeleeDmg=132, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=242, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=10485;
-- Risen Bonewarder
UPDATE creature_template SET DamageMultiplier=3.9, MinMeleeDmg=93, MaxMeleeDmg=125, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=234, RangedAttackPower=23, MeleeBaseAttackTime=2000 WHERE Entry=10491;
-- Risen Construct
UPDATE creature_template SET DamageMultiplier=7.5, MinMeleeDmg=100, MaxMeleeDmg=140, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=258, RangedAttackPower=28, MeleeBaseAttackTime=2000 WHERE Entry=10488;
-- Risen Guard
UPDATE creature_template SET DamageMultiplier=3.8, MinMeleeDmg=98, MaxMeleeDmg=135, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=248, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=10489;
-- Risen Guardian
UPDATE creature_template SET UnitClass=2, HealthMultiplier=0.3, ArmorMultiplier=1, DamageMultiplier=0.33, MinMeleeDmg=102, MaxMeleeDmg=140, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=258, RangedAttackPower=28, MeleeBaseAttackTime=2000 WHERE Entry=11598;
-- Risen Lackey
UPDATE creature_template SET MinLevelHealth=261, MaxLevelHealth=270, HealthMultiplier=0.1, ArmorMultiplier=1, DamageMultiplier=1.0, MinMeleeDmg=94, MaxMeleeDmg=127, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=234, RangedAttackPower=23, MeleeBaseAttackTime=2000 WHERE Entry=10482;
-- Risen Protector
UPDATE creature_template SET DamageMultiplier=3.9, MinMeleeDmg=93, MaxMeleeDmg=128, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=238, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=10487;
-- Risen Warrior
UPDATE creature_template SET DamageMultiplier=6, MinMeleeDmg=122, MaxMeleeDmg=168, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=258, RangedAttackPower=28, MeleeBaseAttackTime=2400 WHERE Entry=10486;

-- Scholomance Adept
UPDATE creature_template SET DamageMultiplier=3.9, MinMeleeDmg=93, MaxMeleeDmg=125, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=234, RangedAttackPower=23, MeleeBaseAttackTime=2000 WHERE Entry=10469;
-- Scholomance Neophyte
UPDATE creature_template SET DamageMultiplier=3.8, MinMeleeDmg=69, MaxMeleeDmg=98, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=107, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=10470;
-- Scholomance Acolyte
UPDATE creature_template SET DamageMultiplier=3.8, MinMeleeDmg=91, MaxMeleeDmg=123, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=228, RangedAttackPower=23, MeleeBaseAttackTime=2000 WHERE Entry=10471;
-- Scholomance Occultist
UPDATE creature_template SET DamageMultiplier=3.9, MinMeleeDmg=93, MaxMeleeDmg=125, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=234, RangedAttackPower=23, MeleeBaseAttackTime=2000 WHERE Entry=10472;
-- Scholomance Student
UPDATE creature_template SET DamageMultiplier=3.6, MinMeleeDmg=100, MaxMeleeDmg=135, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=248, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=10475;
-- Scholomance Necrolyte
UPDATE creature_template SET DamageMultiplier=3.8, MinMeleeDmg=91, MaxMeleeDmg=123, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=228, RangedAttackPower=23, MeleeBaseAttackTime=2000 WHERE Entry=10476;
-- Scholomance Necromancer
UPDATE creature_template SET DamageMultiplier=3.9, MinMeleeDmg=93, MaxMeleeDmg=125, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=234, RangedAttackPower=23, MeleeBaseAttackTime=2000 WHERE Entry=10477;
-- Scholomance Handler
UPDATE creature_template SET DamageMultiplier=4.0, MinMeleeDmg=95, MaxMeleeDmg=128, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=238, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=11257;
-- Scholomance Dark Summoner
UPDATE creature_template SET DamageMultiplier=3.9, MinMeleeDmg=93, MaxMeleeDmg=125, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=234, RangedAttackPower=23, MeleeBaseAttackTime=2000 WHERE Entry=11582;

-- Skulking Corpse
UPDATE creature_template SET MinLevel=58, HealthMultiplier=0.5, DamageMultiplier=0.75, MinMeleeDmg=102, MaxMeleeDmg=135, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=248, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=10479;
-- Spectral Projection
UPDATE creature_template SET MinLevelHealth=2871, ArmorMultiplier=1, MinMeleeDmg=100, MaxMeleeDmg=138, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=252, RangedAttackPower=26, MeleeBaseAttackTime=2000 WHERE Entry=11263;
-- Spectral Researcher
UPDATE creature_template SET DamageMultiplier=3.9, MinMeleeDmg=93, MaxMeleeDmg=128, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=238, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=10499;
-- Spectral Teacher
UPDATE creature_template SET DamageMultiplier=3.9, MinMeleeDmg=93, MaxMeleeDmg=130, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=244, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=10500;
-- Spectral Tutor
UPDATE creature_template SET DamageMultiplier=4, MinMeleeDmg=93, MaxMeleeDmg=128, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=238, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=10498;

-- Splintered Skeleton
UPDATE creature_template SET DamageMultiplier=4, MinMeleeDmg=102, MaxMeleeDmg=138, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=252, RangedAttackPower=26, MeleeBaseAttackTime=2000 WHERE Entry=10478;

-- Unstable Corpse
UPDATE creature_template SET HealthMultiplier=1.35, ArmorMultiplier=1, DamageMultiplier=1, MinMeleeDmg=100, MaxMeleeDmg=135, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=248, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=10480;


-- ---------------------
-- Bosses
-- ---------------------

-- Blood Steward of Kirtonos
UPDATE creature_template SET DamageMultiplier=4.5, MinMeleeDmg=99, MaxMeleeDmg=130, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=244, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=14861;
-- Darkmaster Gandling
UPDATE creature_template SET UnitClass=2, MinLevel=61, HealthMultiplier=20, PowerMultiplier=3, ArmorMultiplier=1, DamageMultiplier=2.5, MinMeleeDmg=99, MaxMeleeDmg=130, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=244, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=1853;
-- Doctor Theolen Krastinov
UPDATE creature_template SET DamageMultiplier=11, MinMeleeDmg=78, MaxMeleeDmg=103, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=252, RangedAttackPower=26, MeleeBaseAttackTime=1500 WHERE Entry=11261;
-- Instructor Malicia
UPDATE creature_template SET DamageMultiplier=5, MinMeleeDmg=97, MaxMeleeDmg=128, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=238, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=10505;
-- Jandice Barov
UPDATE creature_template SET DamageMultiplier=5, MinMeleeDmg=99, MaxMeleeDmg=130, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=255, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=10503;
-- Kirtonos the Herald
UPDATE creature_template SET DamageMultiplier=12, MinMeleeDmg=97, MaxMeleeDmg=128, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=238, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=10506;
-- Lady Illucia Barov
UPDATE creature_template SET DamageMultiplier=6.5, MinMeleeDmg=97, MaxMeleeDmg=128, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=238, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=10502;
-- Lord Alexei Barov
UPDATE creature_template SET MinLevel=60, HealthMultiplier=9, ArmorMultiplier=1, DamageMultiplier=6.0, MinMeleeDmg=104, MaxMeleeDmg=138, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=252, RangedAttackPower=26, MeleeBaseAttackTime=2000 WHERE Entry=10504;
-- Lorekeeper Polkelt
UPDATE creature_template SET DamageMultiplier=4, MinMeleeDmg=104, MaxMeleeDmg=138, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=252, RangedAttackPower=26, MeleeBaseAttackTime=2000 WHERE Entry=10901;
-- Marduk Blackpool
UPDATE creature_template SET DamageMultiplier=6.25, MinMeleeDmg=93, MaxMeleeDmg=123, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=228, RangedAttackPower=23, MeleeBaseAttackTime=2000 WHERE Entry=10433;
-- Ras Frostwhisper
UPDATE creature_template SET MinLevel=62, HealthMultiplier=13, PowerMultiplier=6, ArmorMultiplier=1, DamageMultiplier=4.0, MinMeleeDmg=100, MaxMeleeDmg=133, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=246, RangedAttackPower=26, MeleeBaseAttackTime=2000 WHERE Entry=10508;
-- Rattlegore
UPDATE creature_template SET DamageMultiplier=7, MinMeleeDmg=99, MaxMeleeDmg=130, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=244, RangedAttackPower=25, MeleeBaseAttackTime=2000 WHERE Entry=11622;
-- The Ravenian
UPDATE creature_template SET DamageMultiplier=7, MinMeleeDmg=104, MaxMeleeDmg=138, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=252, RangedAttackPower=26, MeleeBaseAttackTime=2000 WHERE Entry=10507;
-- Vectus
UPDATE creature_template SET DamageMultiplier=4.5, MinMeleeDmg=97, MaxMeleeDmg=128, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=238, RangedAttackPower=24, MeleeBaseAttackTime=2000 WHERE Entry=10432;
-- Fixed equipment template of a few NPCs
-- Thanks @Tobschinski for reporting. This closes #812
UPDATE `creature_template` SET `EquipmentTemplateId` = 1695 WHERE `Entry` = 9596; -- Bannok Grimaxe
UPDATE `creature_template` SET `EquipmentTemplateId` = 920 WHERE `Entry` = 10080; -- Sandarr Dunereaver
UPDATE `creature_template` SET `EquipmentTemplateId` = 1130 WHERE `Entry` = 11143; -- Postmaster Malown
UPDATE `creature` SET `equipment_id` = 0 WHERE `id` = 15312; -- Obsidian Nullifier
-- Updating Vendor-tron and Super-seller movement to stationary
UPDATE `creature_template` SET `MovementType`=0 WHERE `entry`=12245;
UPDATE `creature_template` SET `MovementType`=0 WHERE `entry`=12246;

-- Clean-up
UPDATE `creature`, `creature_template` SET creature.curhealth = creature_template.MinLevelHealth,creature.curmana = creature_template.MinLevelMana WHERE creature.id = creature_template.entry AND creature_template.RegenerateStats = 1;
-- Klaven's Tower - Westfall
-- Waypoints for creatures around that area
-- Malformed Defias Drone
-- Defias Drone
-- Venture Co. Drone
-- Defias Tower Sentry
-- links

-- Westfall

-- Malformed Defias Drone
UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid = 90331;
DELETE FROM creature_movement WHERE id = 90331;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(90331,1,-11134.4,503.49,31.4924, 0, 0,6.17858, 0, 0),
(90331,2,-11119.2,505.719,31.2719, 0, 0,0.162428, 0, 0),
(90331,3,-11106.1,508.068,30.7254, 0, 0,0.771897, 0, 0),
(90331,4,-11097.9,522.042,29.9763, 0, 0,1.36566, 0, 0),
(90331,5,-11100.9,540.766,33.265, 0, 0,1.76621, 0, 0),
(90331,6,-11104.7,562.978,33.3401, 0, 0,1.75836, 0, 0),
(90331,7,-11110.4,573.659,33.5301, 0, 0,2.44715, 0, 0),
(90331,8,-11129,586.351,34.1176, 0, 0,2.8532, 0, 0),
(90331,9,-11140,586.164,34.4978, 0, 0,3.41869, 0, 0),
(90331,10,-11156.5,574.538,33.6152, 0, 0,3.83338, 0, 0),
(90331,11,-11166.2,558.462,33.5352, 0, 0,4.36666, 0, 0),
(90331,12,-11168.7,542.361,33.3797, 0, 0,4.78371, 0, 0),
(90331,13,-11163.5,527.759,33.3205, 0, 0,5.2353, 0, 0),
(90331,14,-11154.6,518.101,32.2379, 0, 0,5.56124, 0, 0),
(90331,15,-11146.8,511.963,32.5598, 0, 0,5.62407, 0, 0);

-- Defias Drone
UPDATE creature SET position_x = -11065.390625, position_y = 503.793762, position_z = 22.676664, orientation = 2.466318, spawndist = 0, MovementType = 2 WHERE guid = 66989;
DELETE FROM creature_movement WHERE id = 66989;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(66989,1,-11072.2,508.853,24.8021, 0, 0,2.45061, 0, 0),
(66989,2,-11080.5,515.885,26.1464, 0, 0,2.45847, 0, 0),
(66989,3,-11092.1,525.413,29.6541, 0, 0,2.77185, 0, 0),
(66989,4,-11100.2,529.407,31.2408, 0, 0,2.33281, 0, 0),
(66989,5,-11103.7,534.984,32.6456, 0, 0,1.85764, 0, 0),
(66989,6,-11107,546.109,33.8103, 0, 0,1.49086, 0, 0),
(66989,7,-11105.5,554.917,33.4921, 0, 0,1.55212, 0, 0),
(66989,8,-11106.7,564.058,33.2482, 0, 0,1.8655, 0, 0),
(66989,9,-11110.5,571.955,33.3912, 0, 0,2.36422, 0, 0),
(66989,10,-11116.3,576.251,33.3609, 3000, 0,2.54879, 0, 0),
(66989,11,-11112.4,576.758,33.6797, 0, 0,5.50581, 0, 0),
(66989,12,-11108.1,572.881,33.6452, 0, 0,5.32203, 0, 0),
(66989,13,-11104.9,567.346,33.5479, 0, 0,4.97724, 0, 0),
(66989,14,-11102.7,558.91,33.437, 0, 0,4.67487, 0, 0),
(66989,15,-11102.7,552.037,33.6585, 0, 0,4.58298, 0, 0),
(66989,16,-11104.2,543.763,33.6709, 0, 0,4.71179, 0, 0),
(66989,17,-11099.8,534.054,32.1437, 0, 0,5.5443, 0, 0),
(66989,18,-11091.1,527.534,29.8738, 0, 0,5.68253, 0, 0),
(66989,19,-11078.8,517.76,26.1589, 0, 0,5.54901, 0, 0),
(66989,20,-11070.2,509.893,24.6128, 0, 0,5.56079, 0, 0),
(66989,21,-11064,504.684,22.4856, 0, 0,5.60006, 0, 0),
(66989,22,-11065.9,504.269,22.9024, 3000, 0,2.44276, 0, 0);
-- link with second Defias Drone
DELETE FROM creature_linking WHERE guid = 66990;
INSERT INTO creature_linking (guid, master_guid, flag) VALUES
(66990, 66989, 515);

-- Venture Co. Drone
UPDATE creature SET position_x = -11102.582031, position_y = 544.798035, position_z = 33.626236, orientation = 4.462696, spawndist = 0, MovementType = 2 WHERE guid = 66992;
DELETE FROM creature_movement WHERE id = 66992;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(66992,1,-11103.2,530.823,31.8316, 0, 0,4.65353, 0, 0),
(66992,2,-11105,519.364,30.8736, 0, 0,4.28204, 0, 0),
(66992,3,-11106.8,511.95,31.1417, 3000, 0,4.08176, 0, 0),
(66992,4,-11114.1,505.521,30.9313, 0, 0,3.66472, 0, 0),
(66992,5,-11127.2,500.049,31.919, 0, 0,3.19505, 0, 0),
(66992,6,-11142.9,504.602,32.1449, 0, 0,2.61543, 0, 0),
(66992,7,-11157.8,512.947,30.8424, 0, 0,2.64684, 0, 0),
(66992,8,-11170.1,520.713,32.6791, 0, 0,2.26592, 0, 0),
(66992,9,-11169.5,539.733,33.3686, 0, 0,1.57477, 0, 0),
(66992,10,-11170.2,552.948,34.0339, 0, 0,1.18207, 0, 0),
(66992,11,-11160.4,573.238,33.3233, 0, 0,0.981012, 0, 0),
(66992,12,-11146.9,585.606,35.0119, 0, 0,0.509772, 0, 0),
(66992,13,-11134.1,590.105,34.7976, 0, 0,0.144562, 0, 0),
(66992,14,-11121.6,588.518,34.5425, 0, 0,5.96829, 0, 0),
(66992,15,-11112.1,582.693,34.3821, 0, 0,5.51984, 0, 0),
(66992,16,-11104.8,572.473,33.868, 0, 0,5.01247, 0, 0),
(66992,17,-11103.4,560.609,33.3978, 0, 0,4.80827, 0, 0),
(66992,18,-11102.8,544.496,33.6181, 0, 0,4.67083, 0, 0);
-- link with second Venture Co. Drone
DELETE FROM creature_linking WHERE guid = 66993;
INSERT INTO creature_linking (guid, master_guid, flag) VALUES
(66993, 66992, 515);

-- Defias Tower Sentry
UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid = 66995;
DELETE FROM creature_movement WHERE id = 66995;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(66995,1,-11137.9,528.19,61.6491, 0, 0,0.17312, 0, 0),
(66995,2,-11132.5,531.749,61.6491, 0, 0,0.832855, 0, 0),
(66995,3,-11128.7,538.241,61.6491, 0, 0,1.31273, 0, 0),
(66995,4,-11127.7,545.851,61.6491, 0, 0,1.82324, 0, 0),
(66995,5,-11131.4,554.485,61.6491, 0, 0,2.34003, 0, 0),
(66995,6,-11139.1,558.844,61.6491, 0, 0,2.91887, 0, 0),
(66995,7,-11147.1,559.053,61.6491, 0, 0,3.46315, 0, 0),
(66995,8,-11154.2,554.621,61.6491, 0, 0,3.9446, 0, 0),
(66995,9,-11158.1,546.604,61.6491, 0, 0,4.62004, 0, 0),
(66995,10,-11157.2,538.943,61.6491, 0, 0,5.06771, 0, 0),
(66995,11,-11152.6,531.842,61.6491, 0, 0,5.69917, 0, 0),
(66995,12,-11146.3,529.056,61.6491, 0, 0,5.99872, 0, 0);
-- link with second Defias Tower Sentry
DELETE FROM creature_linking WHERE guid = 66994;
INSERT INTO creature_linking (guid, master_guid, flag) VALUES
(66994, 66995, 515);-- Klaven Mortwake - Westfall
-- missing texts added
-- waypoints

-- Westfall
-- Klaven Mortwake
UPDATE creature SET position_x = -11124.1, position_y = 545.44, position_z = 70.4323, orientation = 1.72551, Spawndist = 0, MovementType = 2 WHERE guid = 66996;
UPDATE creature_template SET MovementType = 2 WHERE Entry = 7053;
DELETE FROM creature_movement_template WHERE entry = 7053;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES 
(7053, 1, -11124.1,545.44,70.4323, 24000, 705301, 1.72551, 0, 0),
(7053, 2, -11128.9,544.692,70.4022, 0, 0, 2.7881, 0, 0),
(7053, 3, -11133.4,550.86,70.3957, 180000, 0, 2.27306, 0, 0),
(7053, 4, -11132.2,539.132,70.3766, 180000, 0, 3.65131, 0, 0),
(7053, 5, -11133.4,550.86,70.3957, 180000, 0, 2.27306, 0, 0),
(7053, 6, -11132.2,539.132,70.3766, 180000, 0, 3.65131, 0, 0),
(7053, 7, -11128.9,544.692,70.4022, 3000, 705302, 2.7881, 0, 0);
DELETE FROM dbscripts_on_creature_movement WHERE id BETWEEN 705301 AND 705302;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(705301,1,0,0,0,0,0,0,2000000786,0,0,0,0,0,0,0,''),
(705301,5,0,0,0,0,0,0,2000000787,0,0,0,0,0,0,0,''),
(705301,12,0,0,0,0,0,0,2000000788,0,0,0,0,0,0,0,''),
(705301,14,0,0,0,0,0,0,2000000789,0,0,0,0,0,0,0,''),
(705301,19,0,0,0,0,0,0,2000000790,0,0,0,0,0,0,0,''),
(705302,1,20,0,0,0,0,0,0,0,0,0,0,0,0,0,'movement chenged to 0:idle');
DELETE FROM db_script_string WHERE entry BETWEEN 2000000786 AND 2000000790;
INSERT INTO db_script_string (entry, content_default, sound, type, language, emote, comment) VALUES
(2000000786,'%s wildly flips through the pages of a large tome.',0,2,0,0,NULL),
(2000000787,'The sweet irony -- Stormwind forces cut down in defense of their city, only to rise and fight alongside the Brotherhood as instruments of destruction. ',0,0,0,11,NULL),
(2000000788,'And should one die, two shall rise!',0,0,0,5,NULL),
(2000000789,'%s shuffles through the books.',0,2,0,0,NULL),
(2000000790,'Now where did I put the Venture Company formulations?',0,0,0,0,NULL);
-- Added missing visual events for quest Krastinov, The Butcher in Scholomance

SET @GUID := 10228;

DELETE FROM `gameobject` WHERE `guid` IN (@GUID + 1, @GUID + 2);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID + 1, 176546, 289, 196.871, -73.8801, 85.2284, 2.46091, 0, 0, 0.942641, 0.333807, -30, 100, 1),
(@GUID + 2, 176547, 289, 165.317, -81.145, 85.2284, 3.00197, 0, 0, 0.997564, 0.069757, -30, 100, 1);

DELETE FROM `dbscripts_on_event` WHERE `id` IN (5438, 5439);
INSERT INTO `dbscripts_on_event` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(5439, 1, 9, @GUID + 1, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'respawn gobject'),
(5438, 1, 9, @GUID + 2, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'respawn gobject');
-- Made creature Plagued Hatchlings have random movement
UPDATE `creature` SET `MovementType` = 1, `spawndist` = 3 WHERE `id` = 10678;
-- Closed Ras Frostwhisper Laboratory's door in Scholomance
UPDATE `gameobject` SET `state` = 1 WHERE `id` = 177370;
-- Removed wrong spawn of Risen Lackey because this NPC is summoned
DELETE FROM `creature` WHERE `guid` = 48962;
-- Added missing equipment to NPC 10579 (Kirtonos the Herald) and NPC 11439 (Illusion of Jandice Barov)
SET @ENTRY := 2434;
DELETE FROM `creature_equip_template_raw` WHERE `entry` = @ENTRY;
INSERT INTO `creature_equip_template_raw` VALUES (@ENTRY, 20256, 0, 0, 50268674, 0, 0, 529, 0, 0);

UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY WHERE `Entry` = 10579;
UPDATE `creature_template` SET `EquipmentTemplateId` = 1221 WHERE `Entry` = 11439;
-- Fixed stats of NPC 16119 (Bone Minion)
UPDATE creature_template SET DamageMultiplier=1.5, MinMeleeDmg=104, MaxMeleeDmg=138, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=252, RangedAttackPower=26, MeleeBaseAttackTime=2000 WHERE Entry=16119;

-- Clean-up
UPDATE creature, creature_template SET creature.curhealth = creature_template.MinLevelHealth,creature.curmana = creature_template.MinLevelMana WHERE creature.id = creature_template.entry AND creature_template.RegenerateStats = 1;
-- Remade the entrance room in Scholomance
-- Thanks @evil-at-wow for all these fine data!
-- Contributes to #716 

-- Initial clean-up
DELETE FROM `creature` WHERE `guid` IN (48761, 48586, 48762, 91408, 48765, 48760, 48772, 91414, 91413, 48770, 48773, 48771, 91415, 91416, 48763, 48764, 48477, 91420,
48470, 48476, 48469, 48769, 48767, 48768, 48766, 48548, 48575, 91411, 91412, 48570, 48585, 91409, 91410, 48563, 48479, 48478, 
91418, 91417, 91419, 49018, 91384, 91402);
DELETE FROM `creature_movement` WHERE `id` IN (48761, 48586, 48762, 91408, 48765, 48760, 48772, 91414, 91413, 48770, 48773, 48771, 91415, 91416, 48763, 48764, 48477, 91420,
48470, 48476, 48469, 48769, 48767, 48768, 48766, 48548, 48575, 91411, 91412, 48570, 48585, 91409, 91410, 48563, 48479, 48478, 
91418, 91417, 91419, 49018, 91384, 91402);
DELETE FROM `creature_addon` WHERE `guid` IN (48761, 48586, 48762, 91408, 48765, 48760, 48772, 91414, 91413, 48770, 48773, 48771, 91415, 91416, 48763, 48764, 48477, 91420,
48470, 48476, 48469, 48769, 48767, 48768, 48766, 48548, 48575, 91411, 91412, 48570, 48585, 91409, 91410, 48563, 48479, 48478, 
91418, 91417, 91419, 49018, 91384, 91402);
DELETE FROM `creature_linking` WHERE `guid` IN (48761, 48586, 48762, 91408, 48765, 48760, 48772, 91414, 91413, 48770, 48773, 48771, 91415, 91416, 48763, 48764, 48477, 91420,
48470, 48476, 48469, 48769, 48767, 48768, 48766, 48548, 48575, 91411, 91412, 48570, 48585, 91409, 91410, 48563, 48479, 48478, 
91418, 91417, 91419, 49018, 91384, 91402);

SET @GUID := 154673;
SET @POOL := 25493;

-- ------------------------------
-- Patrolling Necrofiend
-- ------------------------------
DELETE FROM `creature` WHERE `guid` = @GUID + 1;
INSERT INTO `creature` VALUES
(@GUID + 1, 11551, 289, 0, 0, 209.233, 73.2819, 104.798, 0, 7200, 0, 0, 8613, 0, 0, 2);

DELETE FROM `creature_movement` WHERE `id` = @GUID + 1;
INSERT INTO `creature_movement` VALUES
(@GUID + 1, 1, 206.346, 80.7189, 104.244, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID + 1, 2, 221.189, 86.5182, 104.715, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID + 1, 3, 207.384, 91.5904, 104.244, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID + 1, 4, 199.815, 104.765, 104.715, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID + 1, 5, 192.953, 90.7216, 104.244, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID + 1, 6, 178.803, 86.621, 104.716, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID + 1, 7, 192.998, 81.0231, 104.244, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID + 1, 8, 199.444, 69.7478, 104.716, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);

-- ------------------------------
-- Group 1
-- ------------------------------
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 2 AND @GUID + 6;
INSERT INTO `creature` VALUES
-- 2 static Risen Aberrations
(@GUID + 2, 10485, 289, 0, 0, 187.034, 86.5012, 104.798, 0, 7200, 3, 0, 2088, 0, 0, 1),
(@GUID + 3, 10485, 289, 0, 0, 195.23, 85.8773, 104.327, 0, 7200, 3, 0, 2088, 0, 0, 1),
-- 1 Diseased Ghould
(@GUID + 4, 10495, 289, 0, 0, 191.688, 90.8574, 104.327, 0, 7200, 3, 0, 8613, 0, 0, 1),
-- 1 pool of 1 Diseased Ghould / 1 Reanimated Corpse
(@GUID + 5, 10495, 289, 0, 0, 191.343, 83.4603, 104.327, 0, 7200, 3, 0, 8613, 0, 0, 1),
(@GUID + 6, 10481, 289, 0, 0, 191.343, 83.4603, 104.327, 0, 7200, 3, 0, 1436, 0, 0, 1);

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 5, @GUID + 6);
INSERT INTO `pool_creature` VALUES
(@GUID + 5, @POOL + 1, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse'),
(@GUID + 6, @POOL + 1, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse');

DELETE FROM `pool_template` WHERE `entry` = @POOL + 1;
INSERT INTO `pool_template` VALUES
(@POOL + 1, 1, 'Scholomance - Diseased Ghould / Reanimated Corpse');

-- ------------------------------
-- Group 2
-- ------------------------------
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 7 AND @GUID + 11;
INSERT INTO `creature` VALUES
-- 2 static Risen Aberrations
(@GUID + 7, 10485, 289, 0, 0, 217.701, 86.1711, 104.798, 0, 7200, 3, 0, 2088, 0, 0, 1),
(@GUID + 8, 10485, 289, 0, 0, 211.762, 82.7032, 104.327, 0, 7200, 3, 0, 2088, 0, 0, 1),
-- 1 Diseased Ghould
(@GUID + 9, 10495, 289, 0, 0, 206.582, 85.9061, 104.327, 0, 7200, 3, 0, 8613, 0, 0, 1),
-- 1 pool of 1 Diseased Ghould / 1 Reanimated Corpse
(@GUID + 10, 10495, 289, 0, 0, 211.313, 88.8732, 104.327, 0, 7200, 3, 0, 8613, 0, 0, 1),
(@GUID + 11, 10481, 289, 0, 0, 211.313, 88.8732, 104.327, 0, 7200, 3, 0, 1436, 0, 0, 1);

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 10, @GUID + 11);
INSERT INTO `pool_creature` VALUES
(@GUID + 10, @POOL + 2, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse'),
(@GUID + 11, @POOL + 2, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse');

DELETE FROM `pool_template` WHERE `entry` = @POOL + 2;
INSERT INTO `pool_template` VALUES
(@POOL + 2, 1, 'Scholomance - Diseased Ghould / Reanimated Corpse');

-- ------------------------------
-- Group 3
-- ------------------------------
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 12 AND @GUID + 16;
INSERT INTO `creature` VALUES
-- 2 static Risen Aberrations
(@GUID + 12, 10485, 289, 0, 0, 182.377, 97.8408, 104.799, 0, 7200, 3, 0, 2088, 0, 0, 1),
(@GUID + 13, 10485, 289, 0, 0, 180.356, 102.901, 104.798, 0, 7200, 3, 0, 2088, 0, 0, 1),
-- 1 Diseased Ghould
(@GUID + 14, 10495, 289, 0, 0, 187.086, 92.537, 104.767, 0, 7200, 3, 0, 8613, 0, 0, 1),
-- 1 pool of 1 Diseased Ghould / 1 Reanimated Corpse
(@GUID + 15, 10495, 289, 0, 0, 179.126, 94.6681, 104.8, 0, 7200, 3, 0, 8613, 0, 0, 1),
(@GUID + 16, 10481, 289, 0, 0, 179.126, 94.6681, 104.8, 0, 7200, 3, 0, 1436, 0, 0, 1);

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 15, @GUID + 16);
INSERT INTO `pool_creature` VALUES
(@GUID + 15, @POOL + 3, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse'),
(@GUID + 16, @POOL + 3, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse');

DELETE FROM `pool_template` WHERE `entry` = @POOL + 3;
INSERT INTO `pool_template` VALUES
(@POOL + 3, 1, 'Scholomance - Diseased Ghould / Reanimated Corpse');

-- ------------------------------
-- Group 4
-- ------------------------------
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 17 AND @GUID + 21;
INSERT INTO `creature` VALUES
-- 2 static Risen Aberrations
(@GUID + 17, 10485, 289, 0, 0, 185.796, 74.2217, 104.799, 0, 7200, 3, 0, 2088, 0, 0, 1),
(@GUID + 18, 10485, 289, 0, 0, 179.384, 83.667, 104.8, 0, 7200, 3, 0, 2088, 0, 0, 1),
-- 1 Diseased Ghould
(@GUID + 19, 10495, 289, 0, 0, 179.885, 73.8904, 104.799, 0, 7200, 3, 0, 8613, 0, 0, 1),
-- 1 pool of 1 Diseased Ghould / 1 Reanimated Corpse
(@GUID + 20, 10495, 289, 0, 0, 185.034, 80.1398, 104.799, 0, 7200, 3, 0, 8613, 0, 0, 1),
(@GUID + 21, 10481, 289, 0, 0, 185.034, 80.1398, 104.799, 0, 7200, 3, 0, 1436, 0, 0, 1);

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 20, @GUID + 21);
INSERT INTO `pool_creature` VALUES
(@GUID + 20, @POOL + 4, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse'),
(@GUID + 21, @POOL + 4, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse');

DELETE FROM `pool_template` WHERE `entry` = @POOL + 4;
INSERT INTO `pool_template` VALUES
(@POOL + 4, 1, 'Scholomance - Diseased Ghould / Reanimated Corpse');

-- ------------------------------
-- Group 5
-- ------------------------------
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 22 AND @GUID + 26;
INSERT INTO `creature` VALUES
-- 2 static Risen Aberrations
(@GUID + 22, 10485, 289, 0, 0, 221.956, 103.89, 104.798, 0, 7200, 3, 0, 2088, 0, 0, 1),
(@GUID + 23, 10485, 289, 0, 0, 221.917, 96.4046, 104.798, 0, 7200, 3, 0, 2088, 0, 0, 1),
-- 1 Diseased Ghould
(@GUID + 24, 10495, 289, 0, 0, 217.536, 99.4131, 104.798, 0, 7200, 3, 0, 8613, 0, 0, 1),
-- 1 pool of 1 Diseased Ghould / 1 Reanimated Corpse
(@GUID + 25, 10495, 289, 0, 0, 215.996, 91.7486, 104.798, 0, 7200, 3, 0, 8613, 0, 0, 1),
(@GUID + 26, 10481, 289, 0, 0, 215.996, 91.7486, 104.798, 0, 7200, 3, 0, 1436, 0, 0, 1);

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 25, @GUID + 26);
INSERT INTO `pool_creature` VALUES
(@GUID + 25, @POOL + 5, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse'),
(@GUID + 26, @POOL + 5, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse');

DELETE FROM `pool_template` WHERE `entry` = @POOL + 5;
INSERT INTO `pool_template` VALUES
(@POOL + 5, 1, 'Scholomance - Diseased Ghould / Reanimated Corpse');

-- ------------------------------
-- Group 6
-- ------------------------------
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 27 AND @GUID + 31;
INSERT INTO `creature` VALUES
-- 2 static Risen Aberrations
(@GUID + 27, 10485, 289, 0, 0, 203.038, 98.6992, 104.798, 0, 7200, 3, 0, 2088, 0, 0, 1),
(@GUID + 28, 10485, 289, 0, 0, 204.37, 92.5006, 104.327, 0, 7200, 3, 0, 2088, 0, 0, 1),
-- 1 Diseased Ghould
(@GUID + 29, 10495, 289, 0, 0, 197.118, 98.0816, 104.798, 0, 7200, 3, 0, 8613, 0, 0, 1),
-- 1 pool of 1 Diseased Ghould / 1 Reanimated Corpse
(@GUID + 30, 10495, 289, 0, 0, 196.721, 91.9017, 104.327, 0, 7200, 3, 0, 8613, 0, 0, 1),
(@GUID + 31, 10481, 289, 0, 0, 196.721, 91.9017, 104.327, 0, 7200, 3, 0, 1436, 0, 0, 1);

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 30, @GUID + 31);
INSERT INTO `pool_creature` VALUES
(@GUID + 30, @POOL + 6, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse'),
(@GUID + 31, @POOL + 6, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse');

DELETE FROM `pool_template` WHERE `entry` = @POOL + 6;
INSERT INTO `pool_template` VALUES
(@POOL + 6, 1, 'Scholomance - Diseased Ghould / Reanimated Corpse');

-- ------------------------------
-- Group 7
-- ------------------------------
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 32 AND @GUID + 36;
INSERT INTO `creature` VALUES
-- 2 static Risen Aberrations
(@GUID + 32, 10485, 289, 0, 0, 214.38, 73.1017, 104.798, 0, 7200, 3, 0, 2088, 0, 0, 1),
(@GUID + 33, 10485, 289, 0, 0, 220.372, 73.5207, 104.798, 0, 7200, 3, 0, 2088, 0, 0, 1),
-- 1 Diseased Ghould
(@GUID + 34, 10495, 289, 0, 0, 215.633, 79.811, 104.798, 0, 7200, 3, 0, 8613, 0, 0, 1),
-- 1 pool of 1 Diseased Ghould / 1 Reanimated Corpse
(@GUID + 35, 10495, 289, 0, 0, 222.002, 82.2615, 104.798, 0, 7200, 3, 0, 8613, 0, 0, 1),
(@GUID + 36, 10481, 289, 0, 0, 222.002, 82.2615, 104.798, 0, 7200, 3, 0, 1436, 0, 0, 1);

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 35, @GUID + 36);
INSERT INTO `pool_creature` VALUES
(@GUID + 35, @POOL + 7, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse'),
(@GUID + 36, @POOL + 7, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse');

DELETE FROM `pool_template` WHERE `entry` = @POOL + 7;
INSERT INTO `pool_template` VALUES
(@POOL + 7, 1, 'Scholomance - Diseased Ghould / Reanimated Corpse');

-- ------------------------------
-- Group 8
-- ------------------------------
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 37 AND @GUID + 41;
INSERT INTO `creature` VALUES
-- 2 static Risen Aberrations
(@GUID + 37, 10485, 289, 0, 0, 204.191, 73.0652, 104.798, 0, 7200, 3, 0, 2088, 0, 0, 1),
(@GUID + 38, 10485, 289, 0, 0, 198.144, 73.889, 104.666, 0, 7200, 3, 0, 2088, 0, 0, 1),
-- 1 Diseased Ghould
(@GUID + 39, 10495, 289, 0, 0, 203.869, 80.8282, 104.327, 0, 7200, 3, 0, 8613, 0, 0, 1),
-- 1 pool of 1 Diseased Ghould / 1 Reanimated Corpse
(@GUID + 40, 10495, 289, 0, 0, 197.559, 79.5891, 104.327, 0, 7200, 3, 0, 8613, 0, 0, 1),
(@GUID + 41, 10481, 289, 0, 0, 197.559, 79.5891, 104.327, 0, 7200, 3, 0, 1436, 0, 0, 1);

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 40, @GUID + 41);
INSERT INTO `pool_creature` VALUES
(@GUID + 40, @POOL + 8, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse'),
(@GUID + 41, @POOL + 8, 0, 'Scholomance - Diseased Ghould / Reanimated Corpse');

DELETE FROM `pool_template` WHERE `entry` = @POOL + 8;
INSERT INTO `pool_template` VALUES
(@POOL + 8, 1, 'Scholomance - Diseased Ghould / Reanimated Corpse');

-- ------------------------------
-- Rats
-- ------------------------------
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 42 AND @GUID + 44;
INSERT INTO `creature` VALUES
(@GUID + 42, 4075, 289, 0, 0, 216.771, 75.3716, 104.798, 0, 7200, 3, 0, 120, 0, 0, 1),
(@GUID + 43, 4075, 289, 0, 0, 210.642, 99.2762, 104.798, 0, 7200, 3, 0, 120, 0, 0, 1),
(@GUID + 44, 4075, 289, 0, 0, 182.771, 69.4884, 104.798, 0, 7200, 3, 0, 120, 0, 0, 1);
-- Defias Tower Patrollers
-- ... small event between Jill and Raven
-- Small note:
-- Small mmaps issue there - already reported on cmangos. (event still works fine) :)

-- Westfall
-- Defias Tower Patroller correct models.
UPDATE creature_model_info SET bounding_radius = 0.208, combat_reach = 1.5, modelid_other_gender = 0 WHERE modelid = 5809;
UPDATE creature_model_info SET modelid_other_gender = 0 WHERE modelid = 5811;

-- Defias Tower Patroller(Patroller Raven)
UPDATE creature SET spawndist = 0, MovementType = 2, modelid = 5811 WHERE guid = 66991;
DELETE FROM creature_movement WHERE id = 66991;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(66991,1,-11151.9,552.766,55.8906, 0, 0,4.95002, 0, 0),
(66991,2,-11150.2,550.355,55.9111, 0, 0,5.71106, 0, 0),
(66991,3,-11141.5,544.132,56.255, 0, 0,4.85341, 0, 0),
(66991,4,-11142.6,542.11,56.0286, 0, 0,4.09943, 0, 0),
(66991,5,-11147.1,534.51,52.4846, 0, 0,4.26829, 0, 0),
(66991,6,-11146.7,532.219,52.4383, 0, 0,5.48094, 0, 0),
(66991,7,-11142.3,531.459,51.4746, 0, 0,6.20821, 0, 0),
(66991,8,-11136.9,532.989,49.7902, 0, 0,0.596542, 0, 0),
(66991,9,-11132.2,537.43,49.2267, 0, 0,1.07406, 0, 0),
(66991,10,-11130.5,542.865,49.2252, 0, 0,1.43299, 0, 0),
(66991,11,-11130.7,547.493,49.7138, 0, 0,1.99691, 0, 0),
(66991,12,-11133.1,552.149,51.2245, 0, 0,2.35191, 0, 0),
(66991,13,-11136.8,555.297,52.7825, 0, 0,2.81843, 0, 0),
(66991,14,-11141.6,556.864,54.3274, 0, 0,3.05877, 0, 0),
(66991,15,-11145.5,556.425,55.3242, 0, 0,3.43576, 0, 0),
(66991,16,-11149.9,554.571,55.8312, 0, 0,3.76955, 0, 0);

-- Defias Tower Patroller(Patroller Jill)
UPDATE creature SET spawndist = 0, MovementType = 2, modelid = 5809 WHERE guid = 66988;
DELETE FROM creature_movement WHERE id = 66988;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(66988,1,-11153.5,546.207,40.6269, 0, 0,5.73933, 0, 0),
(66988,2,-11150.8,546.363,40.6269, 0, 0,0.682932, 0, 0),
(66988,3,-11147.8,550.575,42.432, 0, 0,0.532921, 0, 0),
(66988,4,-11144.3,551.318,44.3101, 0, 0,6.14145, 0, 0),
(66988,5,-11142.6,551.21,45.1275, 0, 0,5.88229, 0, 0),
(66988,6,-11141.7,550.748,45.6448, 0, 0,5.88229, 0, 0),
(66988,7,-11139.3,548.253,46.4923, 0, 0,4.29027, 0, 0),
(66988,8,-11141.2,545.493,46.5627, 26000, 705201,4.10334, 0, 0),
(66988,9,-11145.8,540.158,45.2584, 0, 0,4.13162, 0, 0),
(66988,10,-11148.1,535.534,43.4048, 0, 0,4.29969, 0, 0),
(66988,11,-11148,532.609,43.4048, 0, 0,5.42281, 0, 0),
(66988,12,-11143.1,531.239,43.4048, 0, 0,6.27575, 0, 0),
(66988,13,-11136,533.194,41.2813, 0, 0,0.720626, 0, 0),
(66988,14,-11131.8,538.019,39.0006, 0, 0,1.22351, 0, 0),
(66988,15,-11130.3,545.517,36.2797, 0, 0,1.69003, 0, 0),
(66988,16,-11133.6,550.188,35.9606, 0, 0,2.44402, 0, 0),
(66988,17,-11139.5,554.752,35.9606, 0, 0,2.68356, 0, 0),
(66988,18,-11143.9,556.573,36.4455, 0, 0,3.20035, 0, 0),
(66988,19,-11148.6,555.284,38.2665, 0, 0,3.5475, 0, 0),
(66988,20,-11151.9,553.449,39.5563, 0, 0,4.03052, 0, 0),
(66988,21,-11153.8,550.489,40.6271, 0, 0,4.45149, 0, 0);

DELETE FROM dbscripts_on_creature_movement WHERE id = 705201;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(705201,1,31,7052,12,0,0,0,-26000,0,0,0,0,0,0,0,'search for Raven'),
(705201,2,21,1,0,0,0,0,0,0,0,0,0,0,0,0,'Jill active'),
(705201,2,21,1,0,7052,66991,7 | 0x10,0,0,0,0,0,0,0,0,'Raven active'),
(705201,2,3,0,0,0,0,0,0,0,0,0,0,0,0,5.73848,''),
(705201,3,32,1,0,7052,66991,7 | 0x10,0,0,0,0,0,0,0,0,'movement chenged to 0:idle'),
(705201,3,25,1,0,7052,66991,7 | 0x10,0,0,0,0,0,0,0,0,'RUN ON'),
(705201,3,0,0,0,0,0,0,2000000791,0,0,0,0,0,0,0,''),
(705201,4,3,0,0,7052,66991,7 | 0x10,0,0,0,0,-11138.8,543.77,47.2145,2.54977,''),
(705201,7,25,0,0,7052,66991,7 | 0x10,0,0,0,0,0,0,0,0,'RUN OFF'),
(705201,7,36,0,0,7052,66991,3 | 0x10,0,0,0,0,0,0,0,0,'Face Jill'),
(705201,7,0,0,0,7052,66991,7 | 0x10,2000000792,0,0,0,0,0,0,0,''),
(705201,10,0,0,0,0,0,0,2000000793,0,0,0,0,0,0,0,''),
(705201,16,0,0,0,7052,66991,7 | 0x10,2000000794,2000000795,0,0,0,0,0,0,''),
(705201,22,0,0,0,0,0,0,2000000796,0,0,0,0,0,0,0,''),
(705201,25,32,0,0,7052,66991,7 | 0x10,0,0,0,0,0,0,0,0,'movement chenged to 0:idle'),
(705201,26,21,0,0,0,0,0,0,0,0,0,0,0,0,0,'Jill unactive'),
(705201,26,21,0,0,7052,66991,7 | 0x10,0,0,0,0,0,0,0,0,'Raven unactive');

DELETE FROM db_script_string WHERE entry BETWEEN 2000000791 AND 2000000796;
INSERT INTO db_script_string (entry, content_default, sound, type, language, emote, comment) VALUES
(2000000791,'Hey, Raven...',0,0,0,0,NULL),
(2000000792,'Yea?',0,0,0,0,NULL),
(2000000793,'Can we take a break? My feet are killing me and those ... those things down there are creeping me out.',0,0,0,0,NULL),
(2000000794,'I dunno, Jill. If Klaven comes down while we\'re slacking, we may end up as one of those things!',0,0,0,0,NULL),
(2000000795,'Klaven doesn\'t pay me enough to deal with those zombies, drones or whatever he calls \'em. I don\'t know, Jill. If Klaven comes down while we\'re slacking, we might end up as those things!',0,0,0,0,NULL),
(2000000796,'*Sigh* You\'re probably right, Raven. I\'m going back on patrol....',0,0,0,0,NULL);-- I see dead people...
-- ... they are everywhere and they don't know they are dead.
-- Added the missing ghost NPCs in Caer Darrow
-- Spawn points and equipment from UDB
-- Waypoints from PSMDB
-- Melia and Sammy script (text and waypoints) from data by @evil-at-wow (many thanks :) )
-- Fixed factions, models, mounts and addons for the ghosts and pooled one of the patrol

SET @GUID := 98616;
SET @ENTRY := 2434;

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 1 AND @GUID + 22;
INSERT INTO `creature` VALUES
(@GUID + 1, 11277, 0, 0, 0, 1093.95, -2528.63, 61.2475, 5.74213, 0, 0, 0, 484, 0, 0, 0),
(@GUID + 2, 11277, 0, 0, 0, 1095.56, -2529.47, 61.1291, 2.37365, 0, 0, 0, 484, 0, 0, 0),
(@GUID + 3, 11277, 0, 0, 0, 1148.08, -2559.31, 60.1493, 4.15388, 0, 0, 0, 484, 0, 0, 0),
(@GUID + 4, 11277, 0, 0, 0, 1146.79, -2561.22, 60.1145, 0.959931, 0, 0, 0, 484, 0, 0, 0),
(@GUID + 5, 11279, 0, 0, 0, 1064.06, -2519.78, 60.2259, 3.19395, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 6, 11279, 0, 0, 0, 1056.5, -2536.54, 59.9694, 2.35619, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 7, 11279, 0, 0, 0, 1245.02, -2597.47, 90.3675, 3.52556, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 8, 11280, 0, 0, 0, 1180.07, -2536.72, 85.3681, 1.0821, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 9, 11280, 0, 0, 0, 1187.12, -2532.58, 85.3681, 2.16421, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 10, 11280, 0, 0, 0, 1208.19, -2583.32, 98.2479, 2.72271, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 11, 11282, 0, 0, 0, 1113.59, -2555.59, 59.2532, 3.50681, 0, 0, 0, 42, 0, 0, 0),
(@GUID + 12, 11283, 0, 0, 0, 1111.49, -2556.4, 59.2532, 0.365222, 0, 0, 0, 42, 0, 0, 0),
(@GUID + 13, 11316, 0, 0, 0, 1223.27, -2506.41, 72.9261, 4.10152, 0, 0, 0, 3500, 0, 0, 0),
(@GUID + 15, 11281, 0, 0, 0, 1098.49, -2523.82, 61.3707, 4.6691, 1272, 0, 0, 2371, 0, 0, 0),
(@GUID + 16, 11281, 0, 0, 0, 1031.16, -2498.27, 59.177, 4.73616, 1272, 0, 0, 2371, 0, 0, 2),
(@GUID + 17, 11281, 0, 0, 0, 1090.52, -2541.25, 59.2419, 2.70896, 1272, 0, 0, 2371, 0, 0, 2),
(@GUID + 18, 11281, 0, 0, 0, 1147.93, -2566.49, 60.0373, 2.74489, 1272, 0, 0, 2371, 0, 0, 0),
(@GUID + 19, 11281, 0, 0, 0, 1151.78, -2557.18, 60.0758, 2.79201, 1272, 0, 0, 2371, 0, 0, 0),
(@GUID + 14, 11277, 0, 0, 0, 1155.4, -2383.73, 60.304, 5.43574, 300, 0, 0, 2784, 0, 0, 0),
(@GUID + 20, 11277, 0, 0, 0, 1127.81, -2387.71, 59.264, 1.72159, 300, 0, 0, 2784, 0, 0, 0),
(@GUID + 21, 11287, 0, 0, 0, 1081.91, -2574, 59.957, 0.301, 360, 0, 0, 1536, 0, 0, 0),
(@GUID + 22, 11277, 0, 11014, 0, 1090.52, -2541.25, 59.2419, 2.70896, 1272, 0, 0, 2784, 0, 0, 2);

DELETE FROM `creature_movement` WHERE `id` IN (@GUID + 16, @GUID + 17, @GUID + 22);
INSERT INTO `creature_movement` VALUES 
(@GUID + 16, 1, 1031.16, -2498.27, 59.177, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 4.73616, 0, 0),
(@GUID + 16, 2, 1034.48, -2468.77, 59.9844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.856512, 0, 0),
(@GUID + 16, 3, 1043.48, -2458.4, 60.4699, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.500247, 0, 0),
(@GUID + 16, 4, 1071.23, -2443.23, 61.1634, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0.841458, 0, 0),
(@GUID + 16, 5, 1101.41, -2409.45, 59.8655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.465122, 0, 0),
(@GUID + 16, 6, 1125.81, -2397.36, 59.4695, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.003482, 0, 0),
(@GUID + 16, 7, 1183.61, -2397.16, 60.1768, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0.003482, 0, 0),
(@GUID + 16, 8, 1126.2, -2397.42, 59.4867, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.59711, 0, 0),
(@GUID + 16, 9, 1101.19, -2409.67, 59.8831, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.96843, 0, 0),
(@GUID + 16, 10, 1070.91, -2443.54, 61.1405, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 3.71754, 0, 0),
(@GUID + 16, 11, 1043.16, -2458.72, 60.4674, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.91825, 0, 0),
(@GUID + 16, 12, 1034.42, -2468.71, 59.9897, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.55552, 0, 0),
(@GUID + 17, 1, 1090.52, -2541.25, 59.1419, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 2.70896, 0, 0),
(@GUID + 17, 2, 1095.36, -2543.49, 59.1418, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.08741, 0, 0),
(@GUID + 17, 3, 1118.02, -2601.04, 59.4689, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.50891, 0, 0),
(@GUID + 17, 4, 1132.05, -2612.48, 63.1381, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.05083, 0, 0),
(@GUID + 17, 5, 1161.32, -2620.66, 70.9007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.01069, 0, 0),
(@GUID + 17, 6, 1193.38, -2629.62, 74.0911, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.545408, 0, 0),
(@GUID + 17, 7, 1214.63, -2616.73, 83.1397, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.11242, 0, 0),
(@GUID + 17, 8, 1221.01, -2604.11, 86.3537, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.490212, 0, 0),
(@GUID + 17, 9, 1237.11, -2595.52, 90.1566, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0.490212, 0, 0),
(@GUID + 17, 10, 1221.38, -2603.91, 86.4882, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.17329, 0, 0),
(@GUID + 17, 11, 1214.67, -2616.99, 83.1357, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.70663, 0, 0),
(@GUID + 17, 12, 1193.52, -2629.6, 74.1169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.88873, 0, 0),
(@GUID + 17, 13, 1161.14, -2620.61, 70.8684, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.86364, 0, 0),
(@GUID + 17, 14, 1131.64, -2612.35, 63.038, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.5425, 0, 0),
(@GUID + 17, 15, 1117.74, -2600.92, 59.4468, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.89018, 0, 0),
(@GUID + 17, 16, 1095.2, -2543.02, 59.1423, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.68802, 0, 0),
(@GUID + 22, 1, 1090.52, -2541.25, 59.1419, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 2.70896, 0, 0),
(@GUID + 22, 2, 1095.36, -2543.49, 59.1418, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.08741, 0, 0),
(@GUID + 22, 3, 1118.02, -2601.04, 59.4689, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.50891, 0, 0),
(@GUID + 22, 4, 1132.05, -2612.48, 63.1381, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.05083, 0, 0),
(@GUID + 22, 5, 1161.32, -2620.66, 70.9007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.01069, 0, 0),
(@GUID + 22, 6, 1193.38, -2629.62, 74.0911, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.545408, 0, 0),
(@GUID + 22, 7, 1214.63, -2616.73, 83.1397, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.11242, 0, 0),
(@GUID + 22, 8, 1221.01, -2604.11, 86.3537, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.490212, 0, 0),
(@GUID + 22, 9, 1237.11, -2595.52, 90.1566, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0.490212, 0, 0),
(@GUID + 22, 10, 1221.38, -2603.91, 86.4882, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.17329, 0, 0),
(@GUID + 22, 11, 1214.67, -2616.99, 83.1357, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.70663, 0, 0),
(@GUID + 22, 12, 1193.52, -2629.6, 74.1169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.88873, 0, 0),
(@GUID + 22, 13, 1161.14, -2620.61, 70.8684, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.86364, 0, 0),
(@GUID + 22, 14, 1131.64, -2612.35, 63.038, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.5425, 0, 0),
(@GUID + 22, 15, 1117.74, -2600.92, 59.4468, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.89018, 0, 0),
(@GUID + 22, 16, 1095.2, -2543.02, 59.1423, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.68802, 0, 0);

SET @POOL := 25452;

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 17, @GUID + 22);
INSERT INTO `pool_creature` VALUES
(@GUID + 17, @POOL, 0, 'Caer Darrow ghosts'),
(@GUID + 22, @POOL, 0, 'Caer Darrow ghosts');

DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` VALUES
(@POOL, 1, 'Caer Darrow ghosts');

UPDATE `creature_template` SET `FactionAlliance`= 35, `FactionHorde` = 35 WHERE `Entry` IN (11277, 11279, 11280, 11281, 11282, 11283, 11287, 11316);

UPDATE `creature_template_addon` SET `mount` = 5228 WHERE `entry` = 11281;
UPDATE `creature_template_addon` SET `b2_0_sheath` = 1 WHERE `entry` IN (11277, 11279, 11280, 11287, 11316);

DELETE FROM `creature_addon` WHERE `guid` = @GUID + 8;
INSERT INTO `creature_addon` VALUES
(@GUID + 8, 0, 0, 0, 0, 69, 0, '17622');

DELETE FROM `creature_equip_template_raw` WHERE `entry` BETWEEN @ENTRY + 1 AND @ENTRY + 5;
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(@ENTRY + 1, 1550, 18812, 0, 33490690, 234948100, 0, 781, 4, 0), -- ok
(@ENTRY + 2, 6581, 0, 0, 33492482, 0, 0, 1805, 0, 0), -- ok
(@ENTRY + 3, 6584, 0, 0, 33490690, 0, 0, 781, 0, 0),
(@ENTRY + 4, 6520, 0, 0, 33488900, 0, 0, 1815, 0, 0), -- ok
(@ENTRY + 5, 1661, 24282, 0, 33490690, 33492482, 0, 781, 1815, 0);

UPDATE `creature_template` SET `ModelId2` = 11014, `EquipmentTemplateId` = @ENTRY + 2 WHERE `Entry` = 11277;
UPDATE `creature_template` SET `ModelId2` = 11022, `EquipmentTemplateId` = @ENTRY + 1 WHERE `Entry` = 11279;
UPDATE `creature_template` SET `ModelId2` = 11019, `EquipmentTemplateId` = @ENTRY + 4 WHERE `Entry` = 11280;
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 3 WHERE `Entry` = 11287;
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 5 WHERE `Entry` = 11316;

-- scripted Melia and Sammy
SET @TEXT := 2000000612;

UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` IN (11282, 11283);
UPDATE `creature` SET `MovementType` = 2 WHERE `id` IN (11282, 11283);

DELETE FROM `creature_movement_template` WHERE `entry` IN (11282, 11283);
INSERT INTO `creature_movement_template` VALUES
(11282, 1, 1120.09, -2547.57, 59.2532, 0, 1128201, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(11282, 2, 1111.05, -2537.9, 59.2532, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(11282, 3, 1100.43, -2547.73, 59.2532, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(11282, 4, 1109.6, -2558.2, 59.2532, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(11282, 5, 1113.59, -2555.59, 59.2532, 0, 1128205, 0, 0, 0, 0, 0, 0, 0, 3.4950, 0, 0),
(11282, 6, 1113.59, -2555.59, 59.2532, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.4950, 0, 0),
(11283, 1, 1120.72, -2548.21, 59.2532, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(11283, 2, 1110.95, -2538.51, 59.2532, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(11283, 3, 1100.73, -2547.23, 59.2532, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(11283, 4, 1109.56, -2557.59, 59.2532, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(11283, 5, 1111.49, -2556.4, 59.2532, 0, 1128305, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(11283, 6, 1111.49, -2556.4, 59.2532, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 1128201;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(1128205, 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'pause WP movement'),
(1128205, 6, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.4950, 'Melia face Sammy'),
(1128205, 9, 0, 0, 0, 0, 0, 0, @TEXT + 3, 0, 0, 0, 0, 0, 0, 0, 'Melia'),
(1128205, 14, 0, 0, 0, 11283, 20, 0, @TEXT + 4, 0, 0, 0, 0, 0, 0, 0, 'Sammy'),
(1128205, 16, 0, 0, 0, 0, 0, 0, @TEXT + 5, 0, 0, 0, 0, 0, 0, 0, 'Melia'),
(1128205, 17, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Melia unactive'),
(1128205, 17, 21, 0, 0, 11283, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sammy unactive'),
(1128205, 30, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'unpause WP movement'),
(1128205, 30, 0, 0, 0, 0, 0, 0, @TEXT + 1, 0, 0, 0, 0, 0, 0, 0, 'Melia'),
(1128205, 31, 32, 0, 0, 11283, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sammy unpause WP movement'),
(1128205, 31, 0, 0, 0, 11283, 20, 0, @TEXT + 2, 0, 0, 0, 0, 0, 0, 0, 'Sammy'),

(1128201, 0, 31, 11283, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'search for Sammy'),
(1128201, 1, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Melia active'),
(1128201, 1, 21, 1, 0, 11283, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sammy active'),
(1128201, 1, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Melia - run on'),
(1128201, 1, 25, 1, 0, 11283, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sammy - run on'),

(1128305, 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sammy pause WP movement');

DELETE FROM `db_script_string` WHERE `entry` BETWEEN @TEXT + 1 AND @TEXT + 5;
INSERT INTO `db_script_string` VALUES
(@TEXT + 1, 'Ready. Set. GO!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@TEXT + 2, 'HEY! No fair!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@TEXT + 3, 'I win!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@TEXT + 4, 'You cheated!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@TEXT + 5, 'Wanna race again? Best two out of three!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL);
-- Sentinell Hill - Westfall
-- Lumberjack
DELETE FROM creature_addon WHERE guid IN (44296,45477,45524,89861);
INSERT INTO creature_addon (guid, mount, bytes1, b2_0_sheath, b2_1_flags, emote, moveflags, auras) VALUES
(44296,0,0,1,16,0,0,NULL),
(45477,0,0,1,16,234,0,NULL),
(45524,0,0,1,16,0,0,NULL),
(89861,0,0,1,16,0,0,NULL);
UPDATE creature SET equipment_id = 0, spawndist = 0, MovementType = 2 WHERE guid IN (44296,45524,89861);
DELETE FROM creature_movement WHERE id IN (44296,45524,89861);
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
-- 44296
(44296,1,-10612.1,1181.01,34.5176, 5000, 84203,5.11381, 0, 0),
(44296,2,-10614.8,1180.44,34.0654, 0, 0,3.56192, 0, 0),
(44296,3,-10625.5,1172.63,34.2415, 0, 0,3.88393, 0, 0),
(44296,4,-10636.7,1159.96,33.615, 0, 0,3.9664, 0, 0),
(44296,5,-10643.8,1154.6,33.3617, 0, 0,3.49516, 0, 0),
(44296,6,-10651,1152.99,33.4886, 0, 0,3.77555, 0, 0),
(44296,7,-10653.1,1148.23,33.7335, 0, 0,4.94657, 0, 0),
(44296,8,-10649.3,1141.3,33.7097, 0, 0,4.53648, 0, 0),
(44296,9,-10651.8,1136.93,34.2028, 0, 0,3.85711, 0, 0),
(44296,10,-10660.2,1128.05,34.197, 0, 0,4.53255, 0, 0),
(44296,11,-10660,1124.38,34.197, 0, 0,5.25119, 0, 0),
(44296,12,-10657.3,1121.95,34.197, 0, 0,5.90698, 0, 0),
(44296,13,-10654,1120.34,35.6411, 0, 0,5.72634, 0, 0),
(44296,14,-10650.7,1118.12,35.6286, 6000, 84201,5.67922, 0, 0),
(44296,15,-10653.9,1120.45,35.6388, 0, 0,2.69648, 0, 0),
(44296,16,-10657.1,1122.31,34.1967, 0, 0,2.65721, 0, 0),
(44296,17,-10660.2,1127.8,34.1967, 0, 0,1.20579, 0, 0),
(44296,18,-10657.3,1132.13,34.1967, 0, 0,0.718843, 0, 0),
(44296,19,-10649.3,1139.81,33.7333, 0, 0,1.45555, 0, 0),
(44296,20,-10650.1,1143.1,33.7355, 0, 0,2.14591, 0, 0),
(44296,21,-10653,1148.6,33.737, 0, 0,1.65425, 0, 0),
(44296,22,-10651.6,1152.36,33.527, 0, 0,0.97881, 0, 0),
(44296,23,-10648.3,1153.99,33.4183, 0, 0,0.24996, 0, 0),
(44296,24,-10643.1,1154.56,33.3588, 0, 0,0.440811, 0, 0),
(44296,25,-10633.7,1162.3,34.1228, 0, 0,0.952139, 0, 0),
(44296,26,-10625.3,1172.88,34.2107, 0, 0,0.930148, 0, 0),
(44296,27,-10616.4,1182.21,33.7023, 0, 0,0.34267, 0, 0),
(44296,28,-10612.1,1181.01,34.5176, 97000, 84204,5.11381, 0, 0),
-- 45524
(45524,1,-10628.2,1125.08,33.7849, 0, 0,1.81801, 0, 0),
(45524,2,-10631.9,1139.7,33.7312, 0, 0,1.72611, 0, 0),
(45524,3,-10629.8,1152.02,34.0399, 0, 0,0.853538, 0, 0),
(45524,4,-10624.8,1156.86,34.5346, 0, 0,0.460053, 0, 0),
(45524,5,-10597.5,1160.64,38.4133, 103000, 84202,0.0390802, 0, 0),
(45524,6,-10616,1156.68,35.1913, 0, 0,3.432, 0, 0),
(45524,7,-10624.7,1153.97,34.3801, 0, 0,3.68176, 0, 0),
(45524,8,-10631.2,1139.29,33.7428, 0, 0,4.53705, 0, 0),
(45524,9,-10627.9,1123.15,33.7433, 0, 0,4.92032, 0, 0),
(45524,10,-10623.6,1106.81,33.839, 0, 0,4.71298, 0, 0),
(45524,11,-10624.1,1100.77,33.7959, 0, 0,4.37573, 0, 0),
(45524,12,-10626.3,1098.61,33.7164, 0, 0,3.34293, 0, 0),
(45524,13,-10630.2,1098.87,33.7023, 0, 0,2.58109, 0, 0),
(45524,14,-10636.6,1103.93,34.3049, 0, 0,2.47899, 0, 0),
(45524,15,-10638.7,1105.6,35.6183, 0, 0,2.72796, 0, 0),
(45524,16,-10644.3,1107.04,35.6515, 6000, 84201,3.07197, 0, 0),
(45524,17,-10641.1,1107.4,35.6302, 0, 0,5.73997, 0, 0),
(45524,18,-10638.3,1105.68,35.6181, 0, 0,5.5931, 0, 0),
(45524,19,-10636.5,1104.16,34.3292, 0, 0,5.5931, 0, 0),
(45524,20,-10630.1,1098.96,33.7028, 0, 0,5.92454, 0, 0),
(45524,21,-10626.7,1098.35,33.7094, 0, 0,0.0984525, 0, 0),
(45524,22,-10624.6,1100.14,33.774, 0, 0,0.868928, 0, 0),
(45524,23,-10623.7,1101.87,33.8117, 0, 0,1.58364, 0, 0),
(45524,24,-10624,1107.23,33.8072, 0, 0,1.68574, 0, 0),
-- 89861
(89861,1,-10584.8,1144.22,40.2218, 103000, 84202,3.857178, 0, 0),
(89861,2,-10582.4,1140.78,39.6677, 0, 0,4.94343, 0, 0),
(89861,3,-10583.4,1137.05,39.0197, 0, 0,4.28134, 0, 0),
(89861,4,-10599.1,1117.84,37.7277, 0, 0,3.9986, 0, 0),
(89861,5,-10611.2,1105.3,35.982, 0, 0,3.79833, 0, 0),
(89861,6,-10623.2,1098.3,33.8558, 0, 0,3.27368, 0, 0),
(89861,7,-10628.8,1097.99,33.7034, 0, 0,2.77888, 0, 0),
(89861,8,-10633.6,1099.99,34.1616, 0, 0,2.51027, 0, 0),
(89861,9,-10637.4,1102.69,34.1628, 0, 0,2.53776, 0, 0),
(89861,10,-10639.6,1104.22,35.6187, 0, 0,2.53776, 0, 0),
(89861,11,-10644.4,1106.43,35.651, 6000, 84201,2.84799, 0, 0),
(89861,12,-10639.6,1104.32,35.6182, 0, 0,5.79324, 0, 0),
(89861,13,-10636.9,1102.73,34.2156, 0, 0,5.75004, 0, 0),
(89861,14,-10628.3,1098.14,33.7034, 0, 0,6.14745, 0, 0),
(89861,15,-10617.2,1100.93,34.7838, 0, 0,0.495724, 0, 0),
(89861,16,-10610.1,1106.28,36.1837, 0, 0,0.739197, 0, 0),
(89861,17,-10597.7,1119.31,37.9428, 0, 0,0.845226, 0, 0),
(89861,18,-10582.2,1138.37,39.1972, 0, 0,1.1154, 0, 0),
(89861,19,-10582.3,1141.47,39.7775, 0, 0,1.75786, 0, 0),
(89861,20,-10583.1,1143.39,40.0436, 0, 0,2.16391, 0, 0);
DELETE FROM dbscripts_on_creature_movement WHERE id BETWEEN 84201 AND 84204;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(84201,3,23,308,0,0,0,0x08,0,0,0,0,0,0,0,0,''),
(84202,3,1,234,0,0,0,0,0,0,0,0,0,0,0,0,''),
(84202,97,1,0,0,0,0,0,0,0,0,0,0,0,0,0,''),
(84202,100,23,89,0,0,0,0x08,0,0,0,0,0,0,0,0,''),
(84203,2,23,89,0,0,0,0x08,0,0,0,0,0,0,0,0,''),
(84204,3,1,234,0,0,0,0,0,0,0,0,0,0,0,0,''),
(84204,97,1,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
-- Sentinell Hill - Westfall
-- Westfall Woodworker
DELETE FROM creature_addon WHERE guid IN (44303,45472,45521,89860);
INSERT INTO creature_addon (guid, mount, bytes1, b2_0_sheath, b2_1_flags, emote, moveflags, auras) VALUES
(44303,0,0,1,16,0,0,NULL),
(45472,0,0,1,16,0,0,NULL),
(45521,0,0,1,16,0,0,NULL),
(89860,0,0,1,16,0,0,NULL);
UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid IN (44303,45472,45521,89860);
DELETE FROM creature_movement WHERE id IN (44303,45472,45521,89860);
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
-- 44303
(44303,1,-10662.1,1130.83,34.1967, 15000, 0,2.513274, 0, 0),
(44303,2,-10662.1,1130.83,34.1967, 90000, 667001,2.513274, 0, 0),
(44303,3,-10661.3,1113.16,34.1967, 90000, 667001,4.153883, 0, 0),
-- 45472
(45472,1,-10650.8,1128.61,34.1978, 90000, 667001,4.433136, 0, 0),
(45472,2,-10650.8,1128.61,34.1978, 10000, 0,4.433136, 0, 0),
(45472,3,-10658.8,1134.62,34.1967, 90000, 667001,2.494732, 0, 0),
-- 45521
(45521,1,-10650.1,1115.028,35.6110, 6000, 667002,2.786707, 0, 0),
(45521,2,-10646.4,1113.332,35.6268, 90000, 667001,0.8901179, 0, 0),
-- 89860
(89860,1,-10656.2,1126.87,34.1967, 90000, 667001,5.56733, 0, 0),
(89860,2,-10667.4,1121.39,34.1967, 90000, 667001,3.57242, 0, 0);
DELETE FROM dbscripts_on_creature_movement WHERE id BETWEEN 667001 AND 667002;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(667001,3,1,69,0,0,0,0,0,0,0,0,0,0,0,0,''),
(667001,87,1,0,0,0,0,0,0,0,0,0,0,0,0,0,''),
(667002,3,1,16,0,0,0,0,0,0,0,0,0,0,0,0,'');
SET @TEXTID  := 2000000399;

DELETE FROM `db_script_string` WHERE `entry` BETWEEN @TEXTID + 1 AND @TEXTID + 4;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(@TEXTID + 1, 'So sorry to leave a customer but we have places to go and people to swindle. We will be back sometime later today. Good-bye!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 'Cork Gizelton Leaving Kormek\'s Hut'),
(@TEXTID + 2, 'I am looking for some bodyguards that would like to protect the Gizelton Caravan. We are stopped on the road east of Kormek\'s Hut, north of Kolkar Centaur Village.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 0, 22, 'Cork Quest 5821 Yell'),
(@TEXTID + 3, 'Time for the Gizelton Caravan to head on out! We\'ll be back soon but if you cannot wait, head north to Kormek\'s Hut. We open shop in about an hour.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 'Rigger Gizelton leaving South End '),
(@TEXTID + 4, 'This is Rigger Gizelton asking for assistance escorting my caravan past Mannoroc Coven. I\'m on the road east of Shadowprey village.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 0, 22, 'Rigger Quest 5843 Yell');
-- Timers
SET @TIMER_WAIT := 10 * 60 * 1000;

/*Wps for Cork Gizelton transferred from creature_movement*/
DELETE FROM `creature_movement_template` WHERE `entry` = 11625;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(11625, 1, -1290.31, 1231.38, 109.237, 0, 1162501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- spawn point: all the caravan switch to run mode
(11625, 2, -1277.59, 1225.54, 108.85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 3, -1264.86, 1219.71, 108.452, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 4, -1230.04, 1204.31, 104.374, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 5, -1216.17, 1206.24, 101.889, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 6, -1202.32, 1208.28, 99.7026, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 7, -1188.03, 1207.66, 97.2208, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 8, -1170.99, 1195.93, 94.5615, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 9, -1155.46, 1192.16, 92.4374, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 10, -1127.52, 1190.39, 89.8358, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 11, -1113.58, 1189.12, 89.7403, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 12, -1070.8, 1186.15, 89.7403, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 13, -1037.27, 1183.2, 89.8006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 14, -995.58, 1177.92, 89.7409, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 15, -981.817, 1180.48, 89.8152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 16, -952.606, 1181.99, 89.7313, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 17, -935.445, 1182.25, 91.2113, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 18, -921.448, 1182.53, 93.1746, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 19, -879.467, 1183.72, 97.6043, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 20, -858.976, 1184.22, 99.0322, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 21, -828.316, 1180.2, 99.6657, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 22, -799.811, 1176, 99.3364, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 23, -757.106, 1191.47, 96.9164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 24, -731.879, 1208.14, 92.6956, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 25, -719.12, 1213.91, 91.3297, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 26, -706.36, 1219.67, 90.2856, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 27, -689.935, 1228.43, 89.4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 28, -679.121, 1237.31, 89.17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 29, -661.434, 1247.28, 89.17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 30, -635.655, 1258.2, 89.2063, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 31, -614.489, 1269.64, 89.1686, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 32, -600.078, 1274.85, 89.1238, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 33, -586.268, 1277.15, 89.145, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 34, -546.297, 1287.15, 89.1597, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 35, -541.257, 1300.21, 89.1602, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 36, -536.026, 1313.2, 89.1314, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 37, -525.098, 1338.97, 89.1005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 38, -518.852, 1356.12, 89.0827, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 39, -516.879, 1395.56, 89.0827, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 40, -518.905, 1436.25, 89.0696, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 41, -525.605, 1446.54, 88.4907, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 42, -543.459, 1462.9, 88.3752, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 43, -557.591, 1471.17, 88.9477, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 44, -584.698, 1478.14, 88.3754, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 45, -598.459, 1480.72, 88.3754, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 46, -632.084, 1491.03, 88.3754, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 47, -644.249, 1497.95, 88.3754, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 48, -671.518, 1528.05, 88.3747, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 49, -686.193, 1565.49, 88.3745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 50, -722.407, 1567.28, 91.314, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 51, -750.503, 1560.89, 90.29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 52, -740, 1534.14, 90.3977, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 53, -713.547, 1524.07, 90.2911, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 54, -705.117, 1521.1, 90.3505, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 55, -697.899, 1518.65, 90.3092, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 56, -689.968, 1515.89, 90.2666, @TIMER_WAIT, 1162556, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- Kormek hut, 10 min wait time
(11625, 57, -653.719, 1506.08, 88.3746, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 58, -647.387, 1501.69, 88.3752, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 59, -630.597, 1491.17, 88.3752, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 60, -603.756, 1483.26, 88.3752, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 61, -576.573, 1476.54, 88.3752, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 62, -556.868, 1470.92, 88.8685, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 63, -547.471, 1464.89, 88.3747, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 64, -529.316, 1449.97, 88.402, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 65, -517.699, 1433.75, 89.0816, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 66, -518.09, 1405.76, 89.0816, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 67, -518.149, 1377.76, 89.0816, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 68, -521.289, 1350.76, 89.0816, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 69, -531.625, 1324.74, 89.1339, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 70, -537.391, 1311.99, 89.1594, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 71, -551.845, 1284.12, 89.1594, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 72, -578.054, 1278.57, 89.1685, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 73, -591.957, 1276.92, 89.1634, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 74, -611.806, 1271.05, 89.1694, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 75, -623.928, 1264.06, 89.1694, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 76, -653.384, 1249.74, 89.1694, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 77, -666.372, 1244.51, 89.1694, 0, 1162577, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- North of Kolkar Village, 5 min wait time (handled in script)
(11625, 78, -684.6, 1232.06, 89.2134, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 79, -694.027, 1225.67, 89.6627, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 80, -706.605, 1219.58, 90.2981, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 81, -732.184, 1208.23, 92.7376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 82, -738.514, 1204.75, 93.8662, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 83, -754.159, 1193.91, 96.6195, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 84, -766.62, 1187.59, 97.8394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 85, -792.515, 1177.07, 98.8327, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 86, -802.533, 1175.57, 99.4435, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 87, -821.772, 1178.84, 99.6542, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 88, -835.435, 1181.9, 99.6662, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 89, -848.98, 1184.67, 99.5782, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 90, -861.251, 1185.3, 98.8033, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 91, -889.179, 1183.34, 96.6117, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 92, -903.158, 1182.57, 95.2033, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 93, -931.15, 1182.17, 91.8346, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 94, -945.149, 1182.01, 89.8612, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 95, -959.149, 1181.92, 89.7397, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 96, -974.384, 1182.91, 89.8000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- First ambush
(11625, 97, -1001.65, 1178.06, 89.7398, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 98, -1011.8, 1177.4, 89.7398, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 99, -1033.08, 1182.29, 89.7629, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 100, -1073.62, 1186.33, 89.7398, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 101, -1101.59, 1187.56, 89.7398, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 102, -1129.48, 1190.01, 89.8855, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 103, -1153.93, 1192.36, 92.0000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- Second ambush
(11625, 104, -1166.85, 1194.28, 93.9649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 105, -1184.71, 1203.56, 96.6406, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 106, -1201.45, 1208.2, 99.5698, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 107, -1225.42, 1204.68, 103.502, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 108, -1235.55, 1206.75, 105.129, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 109, -1261.05, 1218.25, 108.207, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 110, -1286.64, 1229.58, 109.112, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 111, -1306.84, 1233.21, 109.771, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- Third ambush
(11625, 112, -1331.25, 1233.54, 110.674, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 113, -1350.02, 1227.22, 111.201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 114, -1389.37, 1212.53, 111.587, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 115, -1415.8, 1202.23, 111.948, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 116, -1424.26, 1196.81, 112.038, 0, 1162501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- quest completion / all the caravan run again
(11625, 117, -1449.27, 1188.13, 111.53, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 118, -1474.53, 1186.42, 109.366, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 119, -1491.78, 1189.4, 106.114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 120, -1502.95, 1198.12, 101.757, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 121, -1512.09, 1209.44, 96.2469, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 122, -1520.19, 1226.67, 89.7861, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 123, -1522.75, 1243.63, 83.3864, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 124, -1520.9, 1257.51, 77.7027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 125, -1518.48, 1273.17, 71.8991, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 126, -1516.17, 1290.94, 66.8473, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 127, -1514.74, 1306.19, 63.4211, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 128, -1511.54, 1328.73, 60.2051, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 129, -1505.75, 1341.47, 59.2142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 130, -1494.42, 1367.08, 58.9254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 131, -1485.84, 1393.02, 58.9251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 132, -1485.47, 1407, 58.9469, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 133, -1487.57, 1434.84, 58.9347, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 134, -1489.45, 1448.71, 58.9302, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 135, -1489.77, 1469.49, 58.9251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 136, -1483.8, 1482.15, 58.9251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 137, -1471.32, 1507.22, 58.9251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 138, -1464.94, 1519.68, 58.9251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 139, -1452.27, 1544.64, 58.9251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 140, -1442.94, 1584.75, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 141, -1452.7, 1610.98, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 142, -1464.1, 1641.7, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 143, -1474.86, 1647.49, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 144, -1500.84, 1657.91, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 145, -1521.76, 1671.96, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 146, -1541.37, 1691.94, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 147, -1551.2, 1701.92, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 148, -1571.41, 1721.29, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 149, -1592.97, 1739.14, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 150, -1613.28, 1758.07, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 151, -1630.32, 1780.27, 58.9255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 152, -1645.92, 1803.52, 58.9296, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 153, -1661.7, 1826.65, 58.9271, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 154, -1681.42, 1858.29, 58.9271, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 155, -1686.38, 1877.21, 59.2059, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 156, -1692.06, 1899.02, 60.7504, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 157, -1699.45, 1908.31, 61.1412, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 158, -1717, 1915.93, 60.0908, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 159, -1738.04, 1917.48, 59.0673, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 160, -1757.16, 1918.92, 58.9757, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 161, -1772.71, 1926.58, 59.1537, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 162, -1791.81, 1939.62, 60.7298, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 163, -1802.7, 1951.89, 60.7237, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 164, -1809.79, 1963.96, 59.7477, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 165, -1815.2, 1976.74, 59.0006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 166, -1817.51, 2008.7, 59.5336, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 167, -1823, 2032.7, 60.6767, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 168, -1821.87, 2042.21, 60.944, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 169, -1813.14, 2068.68, 63.0096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 170, -1810.52, 2082.43, 63.114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 171, -1806.9, 2095.9, 63.1144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 172, -1802.03, 2111.56, 63.6862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 173, -1802.03, 2111.56, 63.6862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 174, -1801.53, 2141.07, 63.006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 175, -1801.53, 2141.07, 63.006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 176, -1802.25, 2155.05, 61.5195, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 177, -1803.02, 2183.03, 59.8215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 178, -1808.36, 2207.2, 59.8215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 179, -1822.66, 2219.86, 59.8215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 180, -1836.76, 2232.87, 59.8215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 181, -1843.44, 2245.11, 59.8215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 182, -1844.75, 2266.9, 59.8215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 183, -1846.34, 2280.81, 59.8215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 184, -1849.89, 2294.13, 59.8215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 185, -1864.58, 2316.31, 59.8215, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 186, -1872.72, 2327.7, 59.8224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 187, -1884.98, 2346.82, 59.8224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 188, -1887.2, 2354.3, 59.8696, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 189, -1893.87, 2379.11, 59.9196, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 190, -1900.07, 2391.67, 59.8224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 191, -1903.97, 2401.47, 59.8223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 192, -1893.82, 2433.49, 59.8217, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 193, -1924.5, 2449.16, 59.8216, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 194, -1943.01, 2415.2, 60.4727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 195, -1936.76, 2412.65, 60.3803, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 196, -1927.83, 2408.84, 60.394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 197, -1920.83, 2406.22, 60.6371, @TIMER_WAIT, 11625197, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- East of Gelkis Village, 10 min wait time
(11625, 198, -1892.03, 2375.61, 59.9178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 199, -1885.29, 2346.94, 59.8216, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 200, -1881.12, 2339.05, 59.8216, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 201, -1864.4, 2316.59, 59.8226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 202, -1852.79, 2300.12, 59.8226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 203, -1847.08, 2287.99, 59.8226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 204, -1844.34, 2264.2, 59.8226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 205, -1842.38, 2243.22, 59.8226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 206, -1840.11, 2237.75, 59.8226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 207, -1830.64, 2226.2, 59.8226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 208, -1810.22, 2209.43, 59.8226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 209, -1802.8, 2194.02, 59.8226, 0, 11625209, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- West of Mannoroc Covent, 5 min wait time (handled in script)
(11625, 210, -1800.41, 2180.08, 59.8226, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 211, -1800.26, 2166.08, 60.1822, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 212, -1801.62, 2148.85, 62.344, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 213, -1801.15, 2134.86, 63.1766, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 214, -1802.26, 2110.11, 63.6737, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 215, -1805.87, 2096.6, 63.1784, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 216, -1809.25, 2083.01, 63.0772, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 217, -1812.63, 2069.43, 63.043, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 218, -1816.72, 2056.04, 61.8496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 219, -1822.89, 2032.23, 60.6524, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 220, -1822.76, 2027.39, 60.3783, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 221, -1815.56, 2003.46, 59.4022, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 222, -1814.41, 1983.18, 58.9549, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 223, -1811.8, 1967.01, 59.4735, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 224, -1803.12, 1951.78, 60.7154, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 225, -1793.24, 1941.87, 60.8439, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 226, -1775.92, 1926.82, 59.3033, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 227, -1759.93, 1918.92, 58.9613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 228, -1751.9, 1917.2, 59.0003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 229, -1737.91, 1917.04, 59.0673, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 230, -1712.18, 1914.85, 60.4394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 231, -1701.72, 1911.02, 61.0949, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 232, -1694.06, 1904.03, 61.03, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 233, -1687.1, 1886.34, 59.7501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 234, -1684.12, 1872.66, 59.0354, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 235, -1673.14, 1845.28, 58.9273, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 236, -1657.63, 1821.97, 58.9273, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 237, -1649.83, 1810.34, 58.9273, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 238, -1634.24, 1787.08, 58.9252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 239, -1626.45, 1775.45, 58.9252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 240, -1605.77, 1750.66, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 241, -1594.91, 1741.83, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 242, -1573.31, 1724.02, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 243, -1553.4, 1704.35, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 244, -1543.67, 1694.29, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 245, -1523.39, 1674.99, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 246, -1505.1, 1659.98, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 247, -1489.89, 1652.47, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 248, -1460.15, 1634.27, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 249, -1453.16, 1621.35, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 250, -1446.87, 1598.31, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 251, -1440.81, 1573.28, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 252, -1445.9, 1553.99, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 253, -1451.91, 1541.35, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 254, -1458.46, 1528.97, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 255, -1471.62, 1504.26, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 256, -1478.08, 1491.84, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 257, -1490.08, 1466.54, 58.9256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 258, -1491.71, 1455.14, 58.9291, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 259, -1488.22, 1427.36, 58.9348, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 260, -1486.41, 1413.48, 58.9418, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 261, -1487.62, 1388.44, 58.9251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 262, -1491.84, 1375.08, 58.9301, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 263, -1502.72, 1349.31, 58.9416, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 264, -1508.49, 1336.58, 59.525, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 265, -1511.68, 1327.41, 60.3754, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 266, -1514.03, 1314.22, 62.0185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 267, -1514.79, 1300.27, 64.5471, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 268, -1516.1, 1286.34, 68.0841, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 269, -1518.52, 1272.55, 72.0932, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 270, -1523.17, 1245.16, 82.7876, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 271, -1522.5, 1234.75, 87.008, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 272, -1517.95, 1221.51, 91.5343, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 273, -1511.76, 1208.2, 96.7403, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 274, -1501.33, 1196.53, 102.475, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 275, -1490.76, 1188.95, 106.376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 276, -1475.92, 1185.48, 109.181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 277, -1452.6, 1187.95, 111.422, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 278, -1433.28, 1193.58, 111.857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 279, -1414.55, 1203.63, 111.886, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 280, -1388.31, 1213.37, 111.599, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 281, -1375.11, 1218.03, 111.465, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 282, -1348.49, 1226.69, 111.175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11625, 283, -1319.41, 1232.27, 110.201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
-- Added script support and miscellaneous fixes to the Gizelton Caravan in Desolace
-- The caravan will now stop 10 min at each end of its path (north, and south) and
-- one of the twi Gizelton brother will spawn a specific vendor NPC at those points
-- The caravan will also wait for 5 min soon after departing to give players the opportunity
-- to take the escort quests
-- Thanks @Rushor for researching and provinding data
-- Thanks @Zingzah for researching, provinding data and doing a lot of preliminary work, some of them are included in this fix
-- This closes #686 

-- Timers
SET @TIMER_RESPAWN := 10 * 60;
SET @TIMER_WAIT := 10 * 60;
SET @TIMER_YELL := 5 * 60;

SET @TEXTID  := 2000000399;
SET @FACTION := 113;

-- Adjust respawn time and movement
UPDATE `creature` SET `spawntimesecs` = @TIMER_RESPAWN, `MovementType` = 0, `spawndist` = 0 WHERE `id` IN (11564, 11626);
UPDATE `creature` SET `spawntimesecs` = @TIMER_RESPAWN, `MovementType` = 2 WHERE `id` = 11625;

-- Clean movement table: only Cork will have a pathway
DELETE FROM `creature_movement` WHERE `id` IN (SELECT `guid` FROM `creature` WHERE `id` IN (11564, 11625, 11626));

-- Optional: make the NPCs move even when no players are in the vicinity
UPDATE `creature_template` SET `ExtraFlags` = `ExtraFlags` + 4096 WHERE `Entry` IN (11564, 11625, 11626);

-- At quest proposal
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` IN (1162577, 11625209);
-- Cork proposes: Bodyguard for Hire
INSERT INTO `dbscripts_on_creature_movement` VALUES
(1162577, 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'pause WP movement'),
(1162577, 1, 0, 0, 0, 0, 0, 0, @TEXTID + 2, 0, 0, 0, 0, 0, 0, 0, 'Cork Yell Bodyguards Quest'),
(1162577, 2, 29, 2, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cork add questgiver status'),
(1162577, @TIMER_YELL, 29, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cork remove questgiver status'),
(1162577, @TIMER_YELL, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'unpause WP movement');
-- Rigger proposes: Gizelton Caravan
INSERT INTO `dbscripts_on_creature_movement` VALUES
(11625209, 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cork pause WP movement'),
(11625209, 1, 0, 0, 0, 11626, 60, 7, @TEXTID + 4, 0, 0, 0, 0, 0, 0, 0, 'Rigger Yell Caravan Quest'),
(11625209, 2, 29, 2, 0x01, 11626, 60, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rigger add questgiver status'),
(11625209, @TIMER_YELL, 29, 2, 2, 11626, 60, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rigger remove questgiver status'),
(11625209, @TIMER_YELL, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cork unpause WP movement');

-- Generic script to make all the caravan run and clean-up flags/faction changes from the escort quests (called at several places)
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 1162501;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(1162501, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cork - run on'),
(1162501, 0, 25, 1, 0, 11626, 60, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rigger - run on'),
(1162501, 0, 29, 1+2, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cork remove questgiver/gossip status'),
(1162501, 0, 29, 1+2, 0x02, 11626, 60, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rigger remove questgiver/gossip status'),
(1162501, 0, 25, 1, 0, 11564, @KODO1, 7 | 0x10, 0, 0, 0, 0, 0, 0, 0, 0, 'Kodo1 - run on'),
(1162501, 0, 25, 1, 0, 11564, @KODO2, 7 | 0x10, 0, 0, 0, 0, 0, 0, 0, 0, 'Kodo2 - run on'),
(1162501, 1, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cork - restore faction'),
(1162501, 1, 22, 0, 0, 11626, 60, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rigger - restore faction'),
(1162501, 1, 22, 0, 0, 11564, @KODO1, 7 | 0x10, 0, 0, 0, 0, 0, 0, 0, 0, 'Kodo1 - restore faction'),
(1162501, 1, 22, 0, 0, 11564, @KODO2, 7 | 0x10, 0, 0, 0, 0, 0, 0, 0, 0, 'Kodo2 - restore faction');

-- At Northern stop
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 1162556;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(1162556, 0, 10, 12245, @TIMER_WAIT * 1000, 0, 0, 0, 0, 0, 0, 0, -692.743, 1522.2, 90.3611, 0.558505, 'Vendor-tron 1000 Summon'),
(1162556, 0, 29, 1, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Add Cork Gossip Flag'),
(1162556, @TIMER_WAIT - 10, 0, 0, 0, 0, 0, 0, @TEXTID + 1, 0, 0, 0, 0, 0, 0, 0, 'Cork departing text'),
(1162556, @TIMER_WAIT, 29, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Remove Cork Gossip Flag');
-- At Southern stop
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 11625197;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(11625197, 0, 10, 12246, @TIMER_WAIT * 1000, 11626, 40, 0, 0, 0, 0, 0, -1926.3, 2412.79, 60.6956, 0.174533, 'Super-seller 680 Summon'),
(11625197, 0, 29, 1, 0x01, 11626, 60, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Add Rigger Gossip Flag'),
(11625197, @TIMER_WAIT - 10, 0, 0, 0, 11626, 60, 7, @TEXTID + 3, 0, 0, 0, 0, 0, 0, 0, 'Rigger departing text'),
(11625197, @TIMER_WAIT, 29, 1, 2, 11626, 60, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Remove Rigger Gossip Flag');
-- q.2358 'Horns of Nez'ra'
UPDATE quest_template SET SpecialFlags = 0, OfferRewardText = 'To deny Ravenholdt the artifact, would be to deny one\'s own existence. Well done, $C. You may yet walk among the assassins of Ravenholdt.$B$BAs a young rogue adventuring in Darkshore, I discovered a tea that replenishes energy in combat. It has served me well throughout the years and now I pass on a taste of the thistle tea to you. Drink of it when you tire, $N, and fight with vigor once more!$B$B', RequestItemsText = 'Do you have the demon prince\'s horns?' WHERE entry = 2358;
-- Few old updates...
-- ... had them few years. (no idea why never had time to add) :)
-- chat between creatures:
-- Guard Kurall + Horde Guard (Barrens)
-- Horde Guard + Horde Guard (Barrens)
-- Horde Guard + Horde Guard (Barrens)
-- Peon + Peon (Barrens)
-- Guard Taruc (Barrens)
-- Grub + Duhng (Barrens)
-- Defias Thug + Defias Thug (Northshire Vineyards) -1
-- Defias Thug + Defias Thug (Northshire Vineyards) -2
-- Defias Thug + Defias Thug (Northshire Vineyards) -3
-- Defias Thug + Defias Thug (Northshire Vineyards) -4


-- chat between creatures

-- Guard Kurall + Horde Guard (Barrens)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 19412;
DELETE FROM creature_movement WHERE id = 19412;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES 
(19412,1,55.2058,-2695.69,92.1666,10000,350102,4.34587,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 350102;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(350102,1,31,14893,10,0,0,0,0,0,0,0,0,0,0,0,'search for 14893'),
(350102,2,1,1,0,14893,13579,7 | 0x10,273,274,6,1,0,0,0,0,''),
(350102,6,1,1,0,0,0,0,273,274,6,1,0,0,0,0,'');

-- Horde Guard + Horde Guard (Barrens)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 19403;
DELETE FROM creature_movement WHERE id = 19403;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES 
(19403,1,-638.53,-3245.05,98.5006,10000,350103,2.32129,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 350103;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(350103,1,31,3501,10,0,0,0,0,0,0,0,0,0,0,0,'search for 3501'),
(350103,2,1,1,0,3501,19428,7 | 0x10,273,274,6,1,0,0,0,0,''),
(350103,6,1,1,0,0,0,0,273,274,6,1,0,0,0,0,'');

-- Horde Guard + Horde Guard (Barrens)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 19361;
DELETE FROM creature_movement WHERE id = 19361;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES  
(19361,8,-39.0541,-2612.88,97.6059,15000,350104,0.314159,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 350104;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(350104,1,31,3501,10,0,0,0,0,0,0,0,0,0,0,0,'search for 3501'),
(350104,2,1,1,0,3501,19402,7 | 0x10,0,0,0,0,0,0,0,0,''),
(350104,6,1,1,0,0,0,0,11,1,0,0,0,0,0,0,''),
(350104,9,1,7,0,0,0,0,0,0,0,0,0,0,0,0,'');

-- Peon + Peon (Barrens)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 13751;
DELETE FROM creature_movement WHERE id = 13751;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES 
(13751,1,-623.98,-3180.06,91.75,3000,1490105,2.40855,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 1490105;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(1490105,1,31,14901,10,0,0,0,0,0,0,0,0,0,0,0,'search for 14901'),
(1490105,2,1,1,0,14901,13772,7 | 0x10,273,274,6,1,0,0,0,0,''),
(1490105,6,1,1,0,0,0,0,273,274,6,1,0,0,0,0,'');

-- Guard Taruc (Barrens)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 13170;
DELETE FROM creature_movement WHERE id = 13170;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES 
(13170,1,-532.145,-2988.94,93.5285,20000,1485901,2.60054,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 1485901;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(1485901,2,1,7,0,0,0,0,0,0,0,0,0,0,0,0,'');

-- Grub + Duhng (Barrens)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 14390;
DELETE FROM creature_movement WHERE id = 14390;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES 
(14390,2,-534.982,-2982.22,93.0775,90000,344301,1.3439,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 344301;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(344301,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,''),
(344301,4,31,8306,10,0,0,0,0,0,0,0,0,0,0,0,'search for 8306'),
(344301,5,1,0,0,8306,14389,3 | 0x10,0,0,0,0,0,0,0,0,''),
(344301,7,36,0,0,8306,14389,3 | 0x10,0,0,0,0,0,0,0,0,''),
(344301,10,1,1,0,8306,14389,7 | 0x10,0,0,0,0,0,0,0,0,''),
(344301,14,3,0,0,8306,14389,7 | 0x10,0,0,0,0,0,0,0,5.91667,''),
(344301,16,1,173,0,8306,14389,7 | 0x10,0,0,0,0,0,0,0,0,'');

-- Defias Thug + Defias Thug (Northshire Vineyards)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 80152;
DELETE FROM creature_movement WHERE id = 80152;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES 
(80152,1,-9033.82,-301.611,74.7497,10000,3804,5.89921,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 3804;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(3804,1,31,38,10,0,0,0,0,0,0,0,0,0,0,0,'search for 38'),
(3804,2,1,1,0,38,80151,7 | 0x10,0,0,0,0,0,0,0,0,''),
(3804,6,1,1,0,0,0,0,0,0,0,0,0,0,0,0,'');

-- Defias Thug + Defias Thug (Northshire Vineyards)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 80184;
DELETE FROM creature_movement WHERE id = 80184;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES  
(80184,1,-9083.31,-301.332,73.4003,3000,0,0.052364,0,0),
(80184,2,-9083.31,-301.332,73.4003,7000,3805,0.052364,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 3805;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(3805,1,31,38,10,0,0,0,0,0,0,0,0,0,0,0,'search for 38'),
(3805,2,1,1,0,38,80185,7 | 0x10,0,0,0,0,0,0,0,0,''),
(3805,6,1,1,0,0,0,0,0,0,0,0,0,0,0,0,'');

-- Defias Thug + Defias Thug (Northshire Vineyards)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 80188;
DELETE FROM creature_movement WHERE id = 80188;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES 
(80188,1,-9077.56,-334.076,73.5351,2000,0,1.29154,0,0),
(80188,2,-9077.56,-334.076,73.5351,8000,3806,1.29154,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 3806;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(3806,1,31,38,10,0,0,0,0,0,0,0,0,0,0,0,'search for 38'),
(3806,2,1,1,0,38,80189,7 | 0x10,0,0,0,0,0,0,0,0,''),
(3806,6,1,1,0,0,0,0,0,0,0,0,0,0,0,0,'');

-- Defias Thug + Defias Thug (Northshire Vineyards)
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 80201;
DELETE FROM creature_movement WHERE id = 80201;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES  
(80201,1,-9073.82,-376.869,73.5351,10000,3807,2.44346,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 3807;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(3807,1,31,38,10,0,0,0,0,0,0,0,0,0,0,0,'search for 38'),
(3807,2,1,1,0,38,80200,7 | 0x10,0,0,0,0,0,0,0,0,''),
(3807,6,1,1,0,0,0,0,0,0,0,0,0,0,0,0,'');-- Added missing alternate gossip texts from warrior, paladin and hunters
-- used when player is not from the required class
-- based on lght versions of commits https://github.com/unified-db/Database/commit/582b9631d4359f549721726d26a8d91663f882a2
-- https://github.com/unified-db/Database/commit/de53b9e2b97c1a07e3d6c2d6abcbd49a7362e515
-- and https://github.com/unified-db/Database/commit/605ee65c0c22e516b016fbe6b75904d0142f21d5 by @Grz3s


-- ------------------------
-- warrior trainers gossips
-- ------------------------

SET @CID := 13; -- condition : is warrior

-- Llane Beshere c.911
DELETE FROM gossip_menu WHERE entry = 4650 AND text_id = 1216;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4650, 1216, 0, @CID); -- warrior only

-- Thran Khorman c.912
DELETE FROM gossip_menu WHERE entry = 4684;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4684, 1215, 0, @CID); -- warrior only

-- Lyria Du Lac   c.913
-- Ander Germaine c.914
DELETE FROM gossip_menu WHERE entry = 4649 AND text_id = 1216;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4649, 1216, 0, @CID); -- warrior only

-- Granis Swiftaxe c.1229
DELETE FROM gossip_menu WHERE entry = 4683 AND text_id = 1215;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4683, 1215, 0, @CID); -- warrior only

-- Kelstrum Stonebreaker c.1901
DELETE FROM gossip_menu WHERE entry = 4569;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4569, 5724, 0, 0), -- all 
(4569, 1215, 0, @CID); -- warrior only

-- Torm Ragetotem c.3041
DELETE FROM gossip_menu WHERE entry = 4526 AND text_id = 1218;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4526, 1218, 0, @CID); -- warrior only

-- Sark Ragetotem c.3042
DELETE FROM gossip_menu WHERE entry = 4525 AND text_id = 1218;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4525, 1218, 0, @CID); -- warrior only

-- Ker Ragetotem c.3043
DELETE FROM gossip_menu WHERE entry = 4527 AND text_id = 1218;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4527, 1218, 0, @CID); -- warrior only

-- Harutt Thunderhorn c.3059
DELETE FROM gossip_menu WHERE entry = 4645 AND text_id = 1218;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4645, 1218, 0, @CID); -- warrior only

-- Krang Stonehoof c.3063
DELETE FROM gossip_menu WHERE entry = 655 AND text_id = 1218;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(655, 1218, 0, @CID); -- warrior only

-- Grezz Ragefist c.3353
DELETE FROM gossip_menu WHERE entry = 4509;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4509, 4985, 0, 0), -- all 
(4509, 1040, 0, @CID); -- warrior only
DELETE FROM gossip_menu_option WHERE menu_id = 4509;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(4509,0,3,'I require warrior training.',5,16,0,0,0,0,0,'',0),
(4509,1,0,'I wish to unlearn my talents.',1,1,4461,0,0,0,0,'',133);

-- Sorek c.3354
DELETE FROM gossip_menu WHERE entry = 4511;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4511, 4985, 0, 0), -- all 
(4511, 1040, 0, @CID); -- warrior only
DELETE FROM gossip_menu_option WHERE menu_id = 4511;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(4511,0,3,'I require warrior training.',5,16,0,0,0,0,0,'',0),
(4511,1,0,'I wish to unlearn my talents.',1,1,4461,0,0,0,0,'',133);

-- Alyissia c.3593
UPDATE gossip_menu SET condition_id = @CID WHERE entry = 4697 AND text_id = 1217;

-- Christoph Walker c.4593
DELETE FROM gossip_menu WHERE entry = 4548;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4548, 4984, 0, 0), -- all 
(4548, 1219, 0, @CID); -- warrior only
DELETE FROM gossip_menu_option WHERE menu_id = 4548;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(4548,0,3,'I require warrior training.',5,16,0,0,0,0,0,'',0),
(4548,1,0,'I wish to unlearn my talents.',1,1,4461,0,0,0,0,'',133);

-- Angela Curthas c.4594
DELETE FROM gossip_menu WHERE entry = 4546 AND text_id = 1219;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4546, 1219, 0, @CID); -- warrior only
DELETE FROM gossip_menu_option WHERE menu_id = 4546;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(4546,0,3,'I require warrior training.',5,16,0,0,0,0,0,'',0),
(4546,1,0,'I wish to unlearn my talents.',1,1,4461,0,0,0,0,'',133);

-- Baltus Fowler c.4595
DELETE FROM gossip_menu WHERE entry = 4547 AND text_id = 1219;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4547, 1219, 0, @CID); -- warrior only
DELETE FROM gossip_menu_option WHERE menu_id = 4547;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(4547,0,3,'I require warrior training.',5,16,0,0,0,0,0,'',0),
(4547,1,0,'I wish to unlearn my talents.',1,1,4461,0,0,0,0,'',133);

-- Kelv Sternhammer c.5113
DELETE FROM gossip_menu WHERE entry = 4570 AND text_id = 1217;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4570, 1217, 0, @CID); -- warrior only

-- Bilban Tosslespanner c.5114
DELETE FROM gossip_menu WHERE entry = 4568;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4568, 4988, 0, 0), -- all 
(4568, 4989, 0, @CID); -- warrior only

-- Wu Shen c.5479
DELETE FROM gossip_menu WHERE entry = 4482 AND text_id = 1216;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4482, 1216, 0, @CID); -- warrior only

-- Ilsa Corbin c.5480
DELETE FROM gossip_menu WHERE entry = 4481 AND text_id = 1216;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4481, 1216, 0, @CID); -- warrior only


-- ------------------------
-- paladin trainers gossips
-- ------------------------

SET @CID := 14;

-- Brother Sammuel c.925
DELETE FROM gossip_menu WHERE entry = 4663 AND text_id = 3977;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4663, 3977, 0, 0);

-- Brother Wilhelm c.927
DELETE FROM gossip_menu WHERE entry = 4664 AND text_id = 3977;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4664, 3977, 0, 0);

-- Lord Grayson Shadowbreaker c.928
DELETE FROM gossip_menu WHERE entry = 4471 AND text_id = 3977;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4471, 3977, 0, 0);

-- Azar Stronghammer c.1232
DELETE FROM gossip_menu WHERE entry = 4677;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4677, 3974, 0, @CID), -- Paladin 
(4677, 3975, 0, 0);

-- Brandur Ironhammer c.5149
DELETE FROM gossip_menu WHERE entry = 2304;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(2304, 3974, 0, @CID), -- Paladin 
(2304, 3975, 0, 0);

-- Arthur the Faithful c.5491
DELETE FROM gossip_menu WHERE entry = 4469 AND text_id = 3977;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4469, 3977, 0, 0);

-- Katherine the Pure c.5492
DELETE FROM gossip_menu WHERE entry = 4470 AND text_id = 3977;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4470, 3977, 0, 0);

-- Brother Karman c.8140
DELETE FROM gossip_menu WHERE entry = 4662 AND text_id = 3977;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4662, 3977, 0, 0);


-- ------------------------
-- hunter trainers gossips
-- ------------------------

SET @CID := 15;

-- Kragg c.1404
DELETE FROM gossip_menu WHERE entry = 4657 AND text_id = 5001;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4657, 5001, 0, @CID); -- hunter

-- Kary Thunderhorn c.3038
DELETE FROM gossip_menu WHERE entry = 4011 AND text_id = 4867;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4011, 4867, 0, @CID); -- hunter

-- Holt Thunderhorn c.3039
DELETE FROM gossip_menu WHERE entry = 4023 AND text_id = 4868;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4023, 4868, 0, @CID); -- hunter    

-- Urek Thunderhorn c.3040
DELETE FROM gossip_menu WHERE entry = 4524 AND text_id = 4997;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4524, 4997, 0, @CID); -- hunter

-- Yaw Sharpmane c.3065
DELETE FROM gossip_menu WHERE entry = 4012 AND text_id = 4868;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4012, 4868, 0, @CID); -- hunter

-- Jen'shan c.3154
DELETE FROM gossip_menu WHERE entry = 4648;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4648, 4987, 0, @CID), -- hunter
(4648, 5004, 0, 0);

-- Thotar c.3171
DELETE FROM gossip_menu WHERE entry = 4017;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4017, 4888, 0, @CID), -- hunter
(4017, 4998, 0, 0);

-- Ormak Grimshot c.3352
DELETE FROM gossip_menu WHERE entry = 4010 AND text_id = 4866;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4010, 4866, 0, @CID); -- hunter

-- Xor'juul c.3406
-- Sian'dur c.3407
DELETE FROM gossip_menu WHERE entry = 4506 AND text_id = 4987;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4506, 4987, 0, @CID); -- hunter

-- Ayanna Everstride c.3596
DELETE FROM gossip_menu WHERE entry = 4695;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4695, 4863, 0, @CID), -- hunter
(4695, 4993, 0, 0);

-- Jocaste c.4146
DELETE FROM gossip_menu WHERE entry = 4008 AND text_id = 4863;
INSERT INTO `gossip_menu` VALUES
(4008, 4863, 0, @CID); -- hunter

-- Daera Brightspear c.5115
DELETE FROM gossip_menu WHERE entry = 4549;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4549, 4999, 0, @CID), -- hunter    
(4549, 5000, 0, 0);

-- Olmin Burningbeard c.5116
DELETE FROM gossip_menu WHERE entry = 4550;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4550, 4890, 0, @CID), -- hunter    
(4550, 5000, 0, 0);

-- Regnus Thundergranite c.5117
DELETE FROM gossip_menu WHERE entry = 4551;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4551, 4999, 0, @CID), -- hunter    
(4551, 5000, 0, 0);

-- Einris Brightspear c.5515
DELETE FROM gossip_menu WHERE entry = 4474;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4474, 4893, 0, @CID), -- hunter    
(4474, 5000, 0, 0);

-- Tendris Warpwood [60]
UPDATE `creature_template` SET `MinLevel`='60', `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='11', `DamageMultiplier`='8', `ArmorMultiplier`='1', `MinLevelHealth`='33572', `MaxLevelHealth`='33572', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11489';

-- Illyanna Ravenoak [60]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='6', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11488';

-- Ferra [60]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='6', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14308';

-- Magister Kalendris [60]
UPDATE `creature_template` SET `MinLevel`='60', `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='8.5', `PowerMultiplier`='4', `DamageMultiplier`='7', `ArmorMultiplier`='1', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11487';

-- Tsu'zee [59]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='8', `MinMeleeDmg`='81.5', `MaxMeleeDmg`='108.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600' WHERE `Entry`='11467';

-- Immol'thar [61]
UPDATE `creature_template` SET `FactionAlliance`='754', `FactionHorde`='754', `SpeedWalk`=('2.5' / '2.5'), `PowerMultiplier`='2', `DamageMultiplier`='8', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11496';

-- Lord Hel'nurath [62] [NOSNIFF]
	-- TO DO

-- Prince Tortheldrin [61] [NOBESTIARY]
	-- TO DO

-- Ironbark Protector [57-59]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.77778' / '2.5'), `DamageMultiplier`='6', `ArmorMultiplier`='2', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='6903', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11459';

-- Petrified Treant [57-59]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='4', `ArmorMultiplier`='1.5', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='5196', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11458';

-- Petrified Guardian [57-59]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='4', `ArmorMultiplier`='1.5', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='5196', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14303';

-- Mana Remnant [57-59]
UPDATE `creature_template` SET `FactionAlliance`='834', `FactionHorde`='834', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='4', `MinMeleeDmg`='91.1', `MaxMeleeDmg`='125.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11483';

-- Arcane Aberration [59-60]
UPDATE `creature_template` SET `MinLevel`='59', `FactionAlliance`='834', `FactionHorde`='834', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `PowerMultiplier`='4', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11480';

-- Eldreth Seether [58-59]
UPDATE `creature_template` SET `ModelId2`='11214', `ModelId3`='11215', `ModelId4`='11216', `FactionAlliance`='16', `FactionHorde`='16', `NpcFlags`='0', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='5.2', `MinMeleeDmg`='79.8', `MaxMeleeDmg`='108.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3489', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600' WHERE `Entry`='11469';

-- Eldreth Darter [58-59]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='3.9', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='125.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2832', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14398';

-- Eldreth Sorcerer [58-59]
UPDATE `creature_template` SET `ModelId2`='11206', `ModelId3`='11211', `ModelId4`='11212', `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='3.9', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='125.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2832', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11470';

-- Rotting Highborne [58-59]
UPDATE `creature_template` SET `MinLevel`='58', `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='1.3', `ArmorMultiplier`='1', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='134.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11477';

-- Eldreth Spirit [57-58]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `PowerMultiplier`='3', `DamageMultiplier`='3', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11472';

-- Eldreth Phantasm [58-59]
UPDATE `creature_template` SET `MinLevel`='58', `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.77778' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='4.5', `ArmorMultiplier`='1', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3489', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11475';

-- Eldreth Apparition [57-58]
UPDATE `creature_template` SET `MinLevel`='57', `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.77778' / '2.5'), `HealthMultiplier`='3', `PowerMultiplier`='3', `DamageMultiplier`='3.8', `ArmorMultiplier`='1', `MinMeleeDmg`='91.1', `MaxMeleeDmg`='123.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2788', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11471';

-- Eldreth Spectre [58-59]
UPDATE `creature_template` SET `MinLevel`='58', `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.77778' / '2.5'), `HealthMultiplier`='3', `PowerMultiplier`='3', `DamageMultiplier`='3.9', `ArmorMultiplier`='1', `MinMeleeDmg`='92.9', `MaxMeleeDmg`='125.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2832', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11473';

-- Skeletal Highborne [57-58]
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`=('2.5' / '2.5'), `MinMeleeDmg`='97.9', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11476';

-- Cadaverous Worm [60] [NOBESTIARY]
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='0.01', `ArmorMultiplier`='1', `MinLevelHealth`='31', `MaxLevelHealth`='31', `MinMeleeDmg`='52.0', `MaxMeleeDmg`='69.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1000', `RangedBaseAttackTime`='1000' WHERE `Entry`='14370';

-- Arcane Torrent [59-60]
UPDATE `creature_template` SET `MinLevel`='59', `FactionAlliance`='834', `FactionHorde`='834', `CreatureTypeFlags`='72', `SpeedWalk`=('8.0' / '2.5'), `SpeedRun`=('8.0' / '7.0'), `HealthMultiplier`='7', `PowerMultiplier`='4', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14399';

-- Arcane Feedback [59-60]
UPDATE `creature_template` SET `MinLevel`='59', `FactionAlliance`='834', `FactionHorde`='834', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='0.8', `ArmorMultiplier`='1', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14400';

-- Residual Monstrosity [59-60] [NOBESTIARY]
UPDATE `creature_template` SET `FactionAlliance`='834', `FactionHorde`='834', `CreatureTypeFlags`='72', `SpeedWalk`=('2.5' / '2.5'), `Unitclass`='2', `HealthMultiplier`='6', `PowerMultiplier`='4', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinLevelHealth`='14214', `MaxLevelHealth`='14652', `MinLevelMana`='9476', `MaxLevelMana`='9736', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11484';

-- Mana Burst [59-60]
UPDATE `creature_template` SET `FactionAlliance`='834', `FactionHorde`='834', `SpeedWalk`=('2.5' / '2.5'), `DamageMultiplier`='0.1', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `DamageSchool`='6' WHERE `Entry`='14397';

-- Highborne Summoner [55] [NOBESTIARY][NOFACTION]
UPDATE `creature_template` SET `ModelId2`='11208', `ModelId3`='11209', `ModelId4`='11210', `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='0.25', `ArmorMultiplier`='1', `MinLevelHealth`='523', `MaxLevelHealth`='523', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2654', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11466';

-- Ancient Equine Spirit [60] [NOBESTIARY]
UPDATE `creature_template` SET `FactionAlliance`='35', `FactionHorde`='35', `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('9.7' / '7.0'), `ArmorMultiplier`='1', `MinLevelHealth`='3052', `MaxLevelHealth`='3052', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14566';
-- Added missing gameobject in Blackfathom Deeps. And revert it to Classic ways.
-- Now players will be able to teleport back to the waters the instance entrance after defeating Aku'Mai
-- Morridune will spawn and offer Alliance players teleport to Darnassus
-- teleport position corrected.
-- Based on https://github.com/unified-db/Database/commit/0cea47a66f90eba2299a4b9749024b9334f610c7 by @Grz3s
-- Other source: WoW Dungeon Guide
-- This closes #638

-- Altar of the Deeps : missing trap added
DELETE FROM gameobject WHERE guid = 14106;
INSERT INTO gameobject (guid, id, map, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(14106, 94040, 48, -839.619, -477.904, -33.7343, 3.14159, 0, 0, 0.926452, 0.376412, 300, 255, 1);

-- Revert spell to the one used in Classic: Players should be teleported to waters at the instance entrance, not get buff 
UPDATE gameobject_template SET data3 = 94040 WHERE entry = 103016;

DELETE FROM spell_target_position WHERE id = 8735;
INSERT INTO `spell_target_position` VALUES
(8735, 1, 4139.14, 883.43, -0.87, 4.53);

-- Morridune

-- Spawn on Aku'mai's death
DELETE FROM dbscripts_on_creature_death WHERE id = 4829; 
INSERT INTO dbscripts_on_creature_death (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(4829,2,31,6729,50,0,0,0x08,0,0,0,0,0,0,0,0,'search for 6729'), -- only one must be spawned
(4829,3,10,6729,300000,0,0,0,0,0,0,0,-857.158,-467.636,-33.9256,5.90677,'');

DELETE FROM creature WHERE id = 6729;
UPDATE creature_template SET UnitFlags = 2, MovementType = 2 WHERE entry = 6729;
DELETE FROM creature_movement_template WHERE entry = 6729;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(6729,1,-857.158,-467.636,-33.9256,1000,672901,5.90677,0,0),
(6729,2,-840.903,-474.555,-34.0673,5000,672902,1.86432,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 672901; 
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(672901,0,29,1,2,0,0,0,0,0,0,0,0,0,0,0,'npcFlags removed'),
(672902,1,0,0,0,0,0,0,2000000813,0,0,0,0,0,0,0,''),
(672902,1,29,1,1,0,0,0,0,0,0,0,0,0,0,0,'npcFlags added'),
(672902,2,32,1,0,0,0,0,0,0,0,0,0,0,0,0,'wp pause');
DELETE FROM db_script_string WHERE entry = 2000000813;
INSERT INTO db_script_string (entry,content_default,sound,type,language,emote,comment) VALUES
(2000000813,'Speak with me to hear my tale.',0,0,0,0,'');
-- teleport possition corrected
DELETE FROM spell_target_position WHERE id = 9268;
INSERT INTO spell_target_position (id, target_map, target_position_x, target_position_y, target_position_z, target_orientation) VALUES
(9268, 1, 9664.01, 2526.15, 1332.16, 0);
-- Fixed NPC 45477 (Lumberjack) in Westfall not using his wood chop emote
-- due to wrong model forced at spawn
UPDATE `creature` SET `modelid` = 0 WHERE `guid` = 45477;

-- Nerub'enkan
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='7.5', `ArmorMultiplier`='1.25', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10437';

-- Baroness Anastari
UPDATE `creature_template` SET `MinLevel`='59', `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='15', `PowerMultiplier`='4', `DamageMultiplier`='7.25', `ArmorMultiplier`='1', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='125.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10436';

-- Maleki the Pallid [UNITCLASSMAGE]
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `MinMeleeDmg`='448', `MaxMeleeDmg`='624', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='115', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10438';

-- Magistrate Barthilas
UPDATE `creature_template` SET `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='7.5', `MinMeleeDmg`='119.7', `MaxMeleeDmg`='158.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2400', `RangedBaseAttackTime`='2400' WHERE `Entry`='10435';

-- Stonespine
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedRun`=('10' / '7'), `PowerMultiplier`='2', `DamageMultiplier`='5', `ArmorMultiplier`='2', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10809';

-- Ramstein the Gorger
UPDATE `creature_template` SET `MinLevel`='61', `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='9', `PowerMultiplier`='2', `DamageMultiplier`='9', `ArmorMultiplier`='1', `MinMeleeDmg`='132.3', `MaxMeleeDmg`='175.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='10439';

-- Baron Rivendare [NOBESTIARY]

	-- Anthion Harmon [NOSNIFF][NOBESTIARY]

	-- Ysida Harmon [NOSNIFF][NOBESTIARY]

-- Skul

-- Stratholme Courier [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`='1', `HealthMultiplier`='4.5', `ArmorMultiplier`='1', `MinLevelHealth`='12528', `MaxLevelHealth`='12528', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11082';

-- Postmaster Malown
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`='1', `DamageMultiplier`='8.25', `MinMeleeDmg`='106.4', `MaxMeleeDmg`='140.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2200', `RangedBaseAttackTime`='2200' WHERE `Entry`='11143';

-- Fras Siabi
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='8.5', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11058';

-- Hearthstinger Forresten
UPDATE `creature_template` SET `SpeedWalk`='1', `HealthMultiplier`='2.5', `PowerMultiplier`='2', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MaxLevelHealth`='6960', `MinMeleeDmg`='97.3', `MaxMeleeDmg`='129.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10558';

-- The Unforgiven
UPDATE `creature_template` SET `MinLevel`='57', `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='4', `PowerMultiplier`='2', `DamageMultiplier`='3.7', `ArmorMultiplier`='1.2', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4064', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `ResistanceFire`='171', `ResistanceNature`='171', `ResistanceFrost`='171', `ResistanceShadow`='171', `ResistanceArcane`='171' WHERE `Entry`='10516';

-- Timmy the Cruel
UPDATE `creature_template` SET `MinLevel`='58', `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='8', `PowerMultiplier`='2', `DamageMultiplier`='13', `ArmorMultiplier`='1', `MinMeleeDmg`='69.8', `MaxMeleeDmg`='92.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='1400', `RangedBaseAttackTime`='1400' WHERE `Entry`='10808';

-- Cannon Master Willey
UPDATE `creature_template` SET `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='7', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10997';

-- Christmas Cannon Master Willey
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `FactionAlliance`='67', `FactionHorde`='67', `Scale`='0', `SpeedWalk`='1', `HealthMultiplier`='12', `PowerMultiplier`='2', `DamageMultiplier`='7', `ArmorMultiplier`='1', `MinLevelHealth`='36624', `MaxLevelHealth`='36624', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MinLootGold`='1629', `MaxLootGold`='2132', `LootId`='15773', `PickpocketLootId`='15773', `EquipmentTemplateId`='2407' WHERE `Entry`='15773';

-- Archivist Galford
UPDATE `creature_template` SET `SpeedWalk`='1', `DamageMultiplier`='6.5', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10811';

-- Balnazzar
UPDATE `creature_template` SET `MinLevel`='62', `SpeedWalk`='1', `HealthMultiplier`='12', `PowerMultiplier`='6', `DamageMultiplier`='9', `ArmorMultiplier`='1', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3555', `MeleeAttackPower`='246', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10813';

-- Grand Crusader Dathrohan [NOSNIFF]
UPDATE `creature_template` SET `SpeedWalk`='1', `DamageMultiplier`='8.5', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='246', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10812';

-- Sothos [NOSNIFF]

-- Jarien [NOSNIFF]

-- Malor the Zealous
UPDATE `creature_template` SET `SpeedWalk`='1', `DamageMultiplier`='6.75', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11032';

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Crimson Monk
UPDATE `creature_template` SET `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='5.5', `MinMeleeDmg`='89.8', `MaxMeleeDmg`='124.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1005', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='11043';

-- Crimson Battle Mage
	-- TO DO

-- Crimson Gallant
UPDATE `creature_template` SET `SpeedWalk`='1', `DamageMultiplier`='4', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10424';

-- Crimson Sorcerer
	-- TO DO

-- Crimson Inquisitor
UPDATE `creature_template` SET `SpeedWalk`='1', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10426';

-- Crimson Defender
UPDATE `creature_template` SET `SpeedWalk`='1', `DamageMultiplier`='3.9', `MinMeleeDmg`='92.9', `MaxMeleeDmg`='125.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2832', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10421';

-- Crimson Priest
	-- TO DO

-- Crimson Rifleman
UPDATE `creature_template` SET `MinMeleeDmg`='97.9', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11054';

-- Crimson Hammersmith
UPDATE `creature_template` SET `SpeedWalk`='1', `PowerMultiplier`='3', `DamageMultiplier`='6', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11120';

-- Crimson Conjuror
	-- TO DO

-- Crimson Initiate
	-- TO DO

-- Crimson Guardsman
UPDATE `creature_template` SET `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='3.8', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10418';

-- Skeletal Berserker
UPDATE `creature_template` SET `ModelId2`='9787', `ModelId3`='9786', `ModelId4`='9788', `SpeedWalk`='1', `DamageMultiplier`='1.75', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10391';

-- Skeletal Guardian
UPDATE `creature_template` SET `ModelId2`='9785', `ModelId3`='7555', `ModelId4`='9790', `SpeedWalk`='1', `DamageMultiplier`='1.8', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='118.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2699', `MeleeAttackPower`='220', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10390';

-- Mangled Cadaver
UPDATE `creature_template` SET `ModelId2`='5431', `ModelId3`='4631', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='3.6', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='127.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10382';

-- Ravaged Cadaver [NOBESTIARY]
UPDATE `creature_template` SET `MinLevel`='56', `ModelId2`='10255', `ModelId3`='5432', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='3.7', `ArmorMultiplier`='1', `MinLevelHealth`='8097', `MaxLevelHealth`='8352', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2744', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10381';

-- Broken Cadaver [NOBESTIARY]
UPDATE `creature_template` SET `MinLevel`='55', `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='0.1', `ArmorMultiplier`='1', `MinLevelHealth`='261', `MaxLevelHealth`='269', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='127.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3327', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10383';

-- Plague Ghoul
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='4.8', `MinMeleeDmg`='88.1', `MaxMeleeDmg`='119.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='10405';

-- Ghoul Ravener
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='4.9', `MinMeleeDmg`='69.8', `MaxMeleeDmg`='94.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='1400', `RangedBaseAttackTime`='1400' WHERE `Entry`='10406';

-- Fleshflayer Ghoul
UPDATE `creature_template` SET `MinLevel`='59', `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='5', `ArmorMultiplier`='1', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10407';

-- Patchwork Horror
UPDATE `creature_template` SET `PowerMultiplier`='2', `DamageMultiplier`='6', `MinMeleeDmg`='137.0', `MaxMeleeDmg`='185.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2800', `RangedBaseAttackTime`='2800' WHERE `Entry`='10414';

-- Undead Postman [NOBESTIARY]

-- Eye of Naxxramas [NOBESTIARY]

-- Spectral Citizen
UPDATE `creature_template` SET `ModelId2`='10484', `ModelId3`='10485', `ModelId4`='10486', `PowerMultiplier`='2', `DamageMultiplier`='3.6', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='127.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3327', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10384';

-- Ghostly Citizen [NOBESTIARY]
UPDATE `creature_template` SET `MinLevel`='56', `ModelId2`='10480', `ModelId3`='10479', `ModelId4`='10481', `HealthMultiplier`='2', `PowerMultiplier`='2', `DamageMultiplier`='3.7', `ArmorMultiplier`='1', `MinLevelHealth`='5398', `MaxLevelHealth`='5568', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `ResistanceFire`='171', `ResistanceNature`='171', `ResistanceFrost`='171', `ResistanceShadow`='171', `ResistanceArcane`='171' WHERE `Entry`='10385';

-- Vengeful Phantom
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='0.3', `ArmorMultiplier`='1', `MinLevelHealth`='809', `MaxLevelHealth`='835', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10387';

-- Spiteful Phantom [NOBESTIARY]

-- Wrath Phantom [NOBESTIARY]

-- Atiesh [NOSNIFF]

-- Aurius [NOSNIFF][NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`='1', `HealthMultiplier`='3', `ArmorMultiplier`='1', `MinLevelHealth`='7326', `MaxLevelHealth`='7326', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10917';

-- Wailing Banshee
UPDATE `creature_template` SET `MinLevel`='58', `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='3.9', `ArmorMultiplier`='1', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10464';

-- Shrieking Banshee
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='3.8', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10463';

-- Crypt Beast
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='4', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10413';

-- Crypt Crawler
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='3.9', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3489', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10412';

-- Thuzadin Acolyte [NOBESTIARY]

-- Thuzadin Necromancer [NOBESTIARY]

-- Thuzadin Shadowcaster [NOBESTIARY]

-- Skeletal Servant
UPDATE `creature_template` SET `MinLevel`='32', `MaxLevel`='32', `HealthMultiplier`='0.25', `ArmorMultiplier`='1', `MinMeleeDmg`='44.8', `MaxMeleeDmg`='59.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='108', `RangedAttackPower`='10' WHERE `Entry`='8477';

-- Rockwing Screecher
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `PowerMultiplier`='2', `DamageMultiplier`='3.9', `ArmorMultiplier`='1.25', `MinMeleeDmg`='79.8', `MaxMeleeDmg`='108.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600' WHERE `Entry`='10409';

-- Rockwing Gargoyle
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `PowerMultiplier`='2', `DamageMultiplier`='3.8', `ArmorMultiplier`='1.25', `MinMeleeDmg`='78.3', `MaxMeleeDmg`='105.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600' WHERE `Entry`='10408';

-- Venom Belcher
UPDATE `creature_template` SET `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='6.1', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10417';

-- Bile Spewer
UPDATE `creature_template` SET `MinLevel`='59', `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='5', `PowerMultiplier`='2', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10416';

-- Bile Slime [NOBESTIARY]

-- Mindless Skeleton
UPDATE `creature_template` SET `MinLevel`='56', `MaxLevel`='57', `ModelId2`='7550', `ModelId3`='7555', `FactionAlliance`='21', `FactionHorde`='21', `SpeedWalk`='1', `HealthMultiplier`='0.11', `ArmorMultiplier`='1', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11197';

-- Undead Scarab

-- Plagued Maggot

-- Plagued Rat

-- Plagued Insect

-- Black Guard Sentry [NOBESTIARY]

-- Black Guard Swordsmith [NOBESTIARY]

-- Mindless Undead

-- Onyxia [63]
UPDATE `creature_template` SET `Scale`='0', `DamageMultiplier`='15', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10184';

-- Onyxian Warder [60-63]
UPDATE `creature_template` SET `DamageMultiplier`='10', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12129';

-- Onyxian Whelp [56-57]
UPDATE `creature_template` SET `MinLevel`='56', `FactionAlliance`='16', `FactionHorde`='16', `DamageMultiplier`='3.7', `ArmorMultiplier`='1', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `ResistanceNature`='0' WHERE `Entry`='11262';
-- Flagglemurk the Cruel
-- drop corrected
-- spawns corrected (missing added)
-- waypoints for first spawn
-- added into pools.

-- Flagglemurk the Cruel
UPDATE creature_template SET SpeedWalk = 1.1 WHERE Entry = 7015;
-- 1st spawn
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 51899;
DELETE FROM creature_movement WHERE id = 51899;
INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES 
(51899,1,5361.57,540.2,1.37434, 0, 0,2.87976, 0, 0),
(51899,2,5327.95,548.109,1.84979, 0, 0,2.85227, 0, 0),
(51899,3,5307.6,556.941,3.30046, 0, 0,2.68734, 0, 0),
(51899,4,5293.22,562.774,3.89359, 0, 0,2.87976, 0, 0),
(51899,5,5270.65,566.584,2.94248, 0, 0,3.04862, 0, 0),
(51899,6,5242.67,569.752,1.94003, 0, 0,2.93081, 0, 0),
(51899,7,5233.17,573.153,2.40135, 0, 0,2.55382, 0, 0),
(51899,8,5254.57,568.294,1.7938, 0, 0,6.15487, 0, 0),
(51899,9,5282.57,565.233,3.65819, 0, 0,6.18628, 0, 0),
(51899,10,5300.56,560.438,3.66182, 0, 0,5.825, 0, 0),
(51899,11,5322.89,549.866,2.0936, 0, 0,6.00957, 0, 0),
(51899,12,5348.78,542.868,1.64609, 0, 0,6.06847, 0, 0),
(51899,13,5395.85,530.913,1.64892, 0, 0,6.05277, 0, 0),
(51899,14,5410.68,528.417,1.41494, 0, 0,0.177984, 0, 0),
(51899,15,5426.57,533.093,1.53774, 0, 0,0.331137, 0, 0),
(51899,16,5444.92,544.012,1.71293, 0, 0,0.582464, 0, 0),
(51899,17,5457.78,553.569,1.9857, 0, 0,0.668858, 0, 0),
(51899,18,5463.9,554.142,2.87976, 0, 0,6.01114, 0, 0),
(51899,19,5469.11,549.074,3.54694, 0, 0,5.09066, 0, 0),
(51899,20,5465.86,539.207,3.31856, 0, 0,4.18352, 0, 0),
(51899,21,5456.49,534.761,3.59431, 0, 0,3.53165, 0, 0),
(51899,22,5421.35,530.068,1.44266, 0, 0,3.20178, 0, 0),
(51899,23,5403.67,528.938,1.57174, 0, 0,2.88762, 0, 0),
(51899,24,5381.54,534.648,1.63599, 0, 0,2.8562, 0, 0);

-- 2nd spawn
-- missing creatures -- 
-- empty guids reused -- UDB ONLY
DELETE FROM creature WHERE guid = 60792;
DELETE FROM creature_addon WHERE guid = 60792;
DELETE FROM creature_movement WHERE id = 60792;
DELETE FROM game_event_creature WHERE guid = 60792;
DELETE FROM game_event_creature_data WHERE guid = 60792;
DELETE FROM creature_battleground WHERE guid = 60792;
DELETE FROM creature_linking WHERE guid = 60792 OR master_guid = 60792;
INSERT INTO creature (guid, id, modelid, map, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, curhealth, curmana, MovementType) VALUES
(60792,7015,0,1,7410.98,-9.27966,0.831176,1.88702,9900,15,356,0,1);

-- Only one can be spawned at at the same time
DELETE FROM pool_template WHERE entry = 1214;
INSERT INTO pool_template (entry, max_limit, description) VALUES 
(1214,1,'Flagglemurk the Cruel');
DELETE FROM pool_creature_template WHERE pool_entry = 1214 OR id = 7015;
INSERT INTO pool_creature_template (id, pool_entry, chance, description) VALUES
(7015, 1214, 0, 'RARE Flagglemurk the Cruel - 7015');

-- Drop correted
DELETE FROM creature_loot_template WHERE  entry = 7015;
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id) VALUES
(7015,730,1.7,0,1,1,0),
(7015,858,2,0,1,1,0),
(7015,1179,1.6,0,1,1,0),
(7015,1468,36,0,1,1,0),
(7015,1506,0.4,0,1,1,0),
(7015,1514,1.7,0,1,1,0),
(7015,1516,0.5,0,1,1,0),
(7015,1734,0.5,0,1,1,0),
(7015,2215,0.6,0,1,1,0),
(7015,2589,32,0,1,3,0),
(7015,5523,19,0,1,1,0),
(7015,5785,1.5,0,1,1,0),
(7015,6266,4,0,1,1,0),
(7015,6268,5,0,1,1,0),
(7015,6289,4,0,1,3,0),
(7015,6336,5,0,1,1,0),
(7015,6512,3,0,1,1,0),
(7015,6537,1.2,0,1,1,0),
(7015,6539,1.7,0,1,1,0),
(7015,6541,1.8,0,1,1,0),
(7015,6542,2,0,1,1,0),
(7015,6543,1.7,0,1,1,0),
(7015,6546,3,0,1,1,0),
(7015,6547,0.7,0,1,1,0),
(7015,6548,3,0,1,1,0),
(7015,6549,2,0,1,1,0),
(7015,6550,1.1,0,1,1,0),
(7015,6551,1.2,0,1,1,0),
(7015,6554,0.9,0,1,1,0),
(7015,6555,4,0,1,1,0),
(7015,6556,1,0,1,1,0),
(7015,6557,3,0,1,1,0),
(7015,6558,1.1,0,1,1,0),
(7015,9746,0.8,0,1,1,0),
(7015,9747,14,0,1,1,0),
(7015,9748,1.2,0,1,1,0),
(7015,9749,3,0,1,1,0),
(7015,9755,0.4,0,1,1,0),
(7015,9756,11,0,1,1,0),
(7015,9757,1.2,0,1,1,0),
(7015,9762,0.6,0,1,1,0),
(7015,9763,8,0,1,1,0),
(7015,9765,1.5,0,1,1,0),
(7015,9785,1.7,0,1,1,0),
(7015,9786,3,0,1,1,0),
(7015,15303,0.6,0,1,1,0),
(7015,24060,1,1,-24060,1,0),
(7015,24062,1,1,-24062,1,0),
(7015,24070,5,1,-24070,1,0),
(7015,24076,1,1,-24076,1,0),
(7015,24077,1,1,-24077,1,0),
(7015,24078,1,1,-24078,1,0);
-- Lady Vespira
-- Add to item drops & movement
-- correct wps still missing
UPDATE creature SET spawndist = 15 WHERE id = 7016;
UPDATE creature SET MovementType = 1 WHERE id = 7016;
UPDATE creature_template SET MovementType = 1 WHERE entry = 7016;

-- drop corrected
DELETE FROM creature_loot_template WHERE  entry = 7016;
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id) VALUES
(7016,858,1.9,0,1,1,0),
(7016,1179,2,0,1,1,0),
(7016,1495,0.2,0,1,1,0),
(7016,1497,0.4,0,1,1,0),
(7016,1498,0.13,0,1,1,0),
(7016,1499,0.17,0,1,1,0),
(7016,1502,0.17,0,1,1,0),
(7016,1503,0.17,0,1,1,0),
(7016,1504,0.2,0,1,1,0),
(7016,1506,0.3,0,1,1,0),
(7016,1507,0.2,0,1,1,0),
(7016,1510,0.3,0,1,1,0),
(7016,1511,0.4,0,1,1,0),
(7016,1512,0.2,0,1,1,0),
(7016,1513,0.3,0,1,1,0),
(7016,1514,0.2,0,1,1,0),
(7016,1515,0.15,0,1,1,0),
(7016,1516,0.17,0,1,1,0),
(7016,1730,0.11,0,1,1,0),
(7016,1732,0.17,0,1,1,0),
(7016,1737,0.19,0,1,1,0),
(7016,2075,0.19,0,1,1,0),
(7016,2214,0.11,0,1,1,0),
(7016,2215,0.2,0,1,1,0),
(7016,2589,36,0,1,3,0),
(7016,2763,0.2,0,1,1,0),
(7016,2777,0.4,0,1,1,0),
(7016,2778,0.3,0,1,1,0),
(7016,3192,0.19,0,1,1,0),
(7016,3284,0.15,0,1,1,0),
(7016,3289,0.13,0,1,1,0),
(7016,3304,0.09,0,1,1,0),
(7016,3374,0.3,0,1,1,0),
(7016,3375,0.3,0,1,1,0),
(7016,4561,0.3,0,1,1,0),
(7016,4686,0.17,0,1,1,0),
(7016,4692,0.09,0,1,1,0),
(7016,4693,0.02,0,1,1,0),
(7016,5069,0.2,0,1,1,0),
(7016,5071,0.09,0,1,1,0),
(7016,5523,33,0,1,1,0),
(7016,6266,3,0,1,1,0),
(7016,6267,10,0,1,1,0),
(7016,6268,3,0,1,1,0),
(7016,6269,11,0,1,1,0),
(7016,6289,5,0,1,1,0),
(7016,6333,0.11,0,1,1,0),
(7016,6336,3,0,1,1,0),
(7016,6337,9,0,1,1,0),
(7016,6506,0.9,0,1,1,0),
(7016,6510,0.7,0,1,1,0),
(7016,6512,3,0,1,1,0),
(7016,6515,1.2,0,1,1,0),
(7016,6518,0.8,0,1,1,0),
(7016,6521,0.9,0,1,1,0),
(7016,6537,0.7,0,1,1,0),
(7016,6542,0.7,0,1,1,0),
(7016,6543,0.6,0,1,1,0),
(7016,6549,0.7,0,1,1,0),
(7016,6550,0.7,0,1,1,0),
(7016,6555,0.8,0,1,1,0),
(7016,6556,0.7,0,1,1,0),
(7016,6558,0.5,0,1,1,0),
(7016,7351,1.5,0,1,1,0),
(7016,9742,1.1,0,1,1,0),
(7016,9743,1.1,0,1,1,0),
(7016,9744,1.5,0,1,1,0),
(7016,9745,0.9,0,1,1,0),
(7016,9746,0.5,0,1,1,0),
(7016,9747,3,0,1,1,0),
(7016,9748,0.7,0,1,1,0),
(7016,9749,0.6,0,1,1,0),
(7016,9750,1.5,0,1,1,0),
(7016,9751,2,0,1,1,0),
(7016,9752,1.4,0,1,1,0),
(7016,9754,1,0,1,1,0),
(7016,9755,2,0,1,1,0),
(7016,9756,4,0,1,1,0),
(7016,9757,0.8,0,1,1,0),
(7016,9758,1.5,0,1,1,0),
(7016,9759,0.6,0,1,1,0),
(7016,9760,1.5,0,1,1,0),
(7016,9761,1.1,0,1,1,0),
(7016,9762,0.8,0,1,1,0),
(7016,9763,3,0,1,1,0),
(7016,9765,0.5,0,1,1,0),
(7016,14090,0.13,0,1,1,0),
(7016,14095,0.2,0,1,1,0),
(7016,14099,0.11,0,1,1,0),
(7016,14365,0.19,0,1,1,0),
(7016,15297,0.09,0,1,1,0),
(7016,15300,0.09,0,1,1,0),
(7016,15495,0.09,0,1,1,0),
(7016,24059,5,1,-24059,1,0),
(7016,24060,1,1,-24060,1,0),
(7016,24062,1,1,-24062,1,0),
(7016,24064,1,1,-24064,1,0);
-- Shadowclaw
-- dop corrected
DELETE FROM creature_loot_template WHERE  entry = 2175;
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id) VALUES
(2175,765,0.05,0,1,1,0),
(2175,774,0.28,0,1,1,0),
(2175,785,0.05,0,1,1,0),
(2175,1210,0.3,0,1,1,0),
(2175,1495,0.11,0,1,1,0),
(2175,1497,0.6,0,1,1,0),
(2175,1498,0.2,0,1,1,0),
(2175,1499,0.18,0,1,1,0),
(2175,1501,0.19,0,1,1,0),
(2175,1502,0.19,0,1,1,0),
(2175,1503,0.18,0,1,1,0),
(2175,1504,0.14,0,1,1,0),
(2175,1506,0.2,0,1,1,0),
(2175,1507,0.12,0,1,1,0),
(2175,1509,0.4,0,1,1,0),
(2175,1510,0.3,0,1,1,0),
(2175,1511,0.19,0,1,1,0),
(2175,1512,0.5,0,1,1,0),
(2175,1513,0.2,0,1,1,0),
(2175,1514,0.11,0,1,1,0),
(2175,1515,0.2,0,1,1,0),
(2175,1516,0.2,0,1,1,0),
(2175,1730,0.12,0,1,1,0),
(2175,1731,0.12,0,1,1,0),
(2175,1732,0.16,0,1,1,0),
(2175,1734,0.18,0,1,1,0),
(2175,2214,0.14,0,1,1,0),
(2175,2215,0.16,0,1,1,0),
(2175,2763,0.2,0,1,1,0),
(2175,2777,0.09,0,1,1,0),
(2175,2778,0.2,0,1,1,0),
(2175,3192,0.2,0,1,1,0),
(2175,3283,0.16,0,1,1,0),
(2175,3291,0.12,0,1,1,0),
(2175,3374,0.14,0,1,1,0),
(2175,3375,0.16,0,1,1,0),
(2175,3653,0.12,0,1,1,0),
(2175,3654,0.11,0,1,1,0),
(2175,4566,0.3,0,1,1,0),
(2175,4577,0.12,0,1,1,0),
(2175,4564,0.19,0,1,1,0),
(2175,4680,0.09,0,1,1,0),
(2175,4686,0.12,0,1,1,0),
(2175,5069,0.09,0,1,1,0),
(2175,5134,13,0,1,1,0),
(2175,6266,8,0,1,1,0),
(2175,6267,5,0,1,1,0),
(2175,6268,9,0,1,1,0),
(2175,6269,4,0,1,1,0),
(2175,6336,7,0,1,1,0),
(2175,6337,4,0,1,1,0),
(2175,6512,8,0,1,1,0),
(2175,6527,0.09,0,1,1,0),
(2175,6537,1.4,0,1,1,0),
(2175,6539,1.6,0,1,1,0),
(2175,6541,1.3,0,1,1,0),
(2175,6542,0.9,0,1,1,0),
(2175,6543,1.2,0,1,1,0),
(2175,6548,1.2,0,1,1,0),
(2175,6549,2,0,1,1,0),
(2175,6550,0.7,0,1,1,0),
(2175,6555,1.8,0,1,1,0),
(2175,6556,0.8,0,1,1,0),
(2175,6557,1.6,0,1,1,0),
(2175,6558,1.1,0,1,1,0),
(2175,7074,84,0,1,1,0),
(2175,9742,0.5,0,1,1,0),
(2175,9743,0.7,0,1,1,0),
(2175,9744,0.8,0,1,1,0),
(2175,9746,3,0,1,1,0),
(2175,9747,4,0,1,1,0),
(2175,9748,1,0,1,1,0),
(2175,9749,0.9,0,1,1,0),
(2175,9750,1.1,0,1,1,0),
(2175,9751,1.1,0,1,1,0),
(2175,9752,1.1,0,1,1,0),
(2175,9755,4,0,1,1,0),
(2175,9756,6,0,1,1,0),
(2175,9757,1.2,0,1,1,0),
(2175,9758,0.8,0,1,1,0),
(2175,9759,2,0,1,1,0),
(2175,9760,0.6,0,1,1,0),
(2175,9762,2,0,1,1,0),
(2175,9763,4,0,1,1,0),
(2175,9765,1.2,0,1,1,0),
(2175,9786,1.1,0,1,1,0),
(2175,14102,0.09,0,1,1,0),
(2175,14113,0.09,0,1,1,0),
(2175,15012,0.12,0,1,1,0),
(2175,15298,0.12,0,1,1,0),
(2175,15301,0.14,0,1,1,0),
(2175,15481,0.02,0,1,1,0),
(2175,15484,0.16,0,1,1,0),
(2175,15945,0.09,0,1,1,0),
(2175,15970,0.11,0,1,1,0);
-- Licillin
-- drop corrected
-- correct movement still missing (prob. waypoints)
DELETE FROM creature_loot_template WHERE  entry = 2191;
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id) VALUES
(2191,774,0.26,0,1,1,0),
(2191,818,0.5,0,1,1,0),
(2191,858,2.6316,0,1,1,0),
(2191,955,0.34,0,1,1,0),
(2191,1179,2.2556,0,1,1,0),
(2191,1181,0.5,0,1,1,0),
(2191,1210,0.07,0,1,1,0),
(2191,1495,0.11,0,1,1,0),
(2191,1497,0.3,0,1,1,0),
(2191,1498,0.2,0,1,1,0),
(2191,1499,0.16,0,1,1,0),
(2191,1501,0.18,0,1,1,0),
(2191,1502,0.11,0,1,1,0),
(2191,1503,0.19,0,1,1,0),
(2191,1504,0.11,0,1,1,0),
(2191,1506,0.13,0,1,1,0),
(2191,1507,0.14,0,1,1,0),
(2191,1509,0.16,0,1,1,0),
(2191,1510,0.2,0,1,1,0),
(2191,1511,0.4,0,1,1,0),
(2191,1512,0.2,0,1,1,0),
(2191,1513,0.2,0,1,1,0),
(2191,1514,0.4,0,1,1,0),
(2191,1515,0.3,0,1,1,0),
(2191,1516,0.3,0,1,1,0),
(2191,1730,0.12,0,1,1,0),
(2191,1731,0.16,0,1,1,0),
(2191,1732,0.09,0,1,1,0),
(2191,1734,0.1,0,1,1,0),
(2191,1735,0.12,0,1,1,0),
(2191,1737,0.2,0,1,1,0),
(2191,2073,0.07,0,1,1,0),
(2191,2079,0.05,0,1,1,0),
(2191,2214,0.18,0,1,1,0),
(2191,2215,0.19,0,1,1,0),
(2191,2287,5.6391,0,1,1,0),
(2191,2455,0.7519,0,1,1,0),
(2191,2589,0.12,0,1,3,0),
(2191,2632,0.13,0,1,1,0),
(2191,2698,0.34,0,1,1,0),
(2191,2763,0.4,0,1,1,0),
(2191,2777,0.13,0,1,1,0),
(2191,2778,0.2,0,1,1,0),
(2191,3013,0.5,0,1,1,0),
(2191,3036,0.07,0,1,1,0),
(2191,3291,0.01,0,1,1,0),
(2191,3292,0.08,0,1,1,0),
(2191,3304,0.11,0,1,1,0),
(2191,3307,0.05,0,1,1,0),
(2191,3308,0.09,0,1,1,0),
(2191,3311,0.07,0,1,1,0),
(2191,3312,0.05,0,1,1,0),
(2191,3374,0.6,0,1,1,0),
(2191,3375,0.13,0,1,1,0),
(2191,4408,0.16,0,1,1,0),
(2191,4564,0.12,0,1,1,0),
(2191,4566,0.05,0,1,1,0),
(2191,4567,0.09,0,1,1,0),
(2191,4569,0.3,0,1,1,0),
(2191,4571,0.06,0,1,1,0),
(2191,4577,0.05,0,1,1,0),
(2191,4680,0.06,0,1,1,0),
(2191,4681,0.11,0,1,1,0),
(2191,4687,0.07,0,1,1,0),
(2191,4693,0.06,0,1,1,0),
(2191,5071,0.13,0,1,1,0),
(2191,5503,0.16,0,1,1,0),
(2191,6266,5,0,1,1,0),
(2191,6268,5,0,1,1,0),
(2191,6336,5,0,1,1,0),
(2191,6512,5,0,1,1,0),
(2191,6537,1.6,0,1,1,0),
(2191,6539,2,0,1,1,0),
(2191,6541,2,0,1,1,0),
(2191,6542,1.2,0,1,1,0),
(2191,6543,1.4,0,1,1,0),
(2191,6546,1.6,0,1,1,0),
(2191,6547,1.4,0,1,1,0),
(2191,6548,2,0,1,1,0),
(2191,6549,3,0,1,1,0),
(2191,6550,1.5,0,1,1,0),
(2191,6551,1.9,0,1,1,0),
(2191,6554,1.4,0,1,1,0),
(2191,6555,2,0,1,1,0),
(2191,6556,1.9,0,1,1,0),
(2191,6557,2,0,1,1,0),
(2191,6558,1.9,0,1,1,0),
(2191,9746,0.7,0,1,1,0),
(2191,9747,11,0,1,1,0),
(2191,9748,1.6,0,1,1,0),
(2191,9749,1.3,0,1,1,0),
(2191,9755,0.8,0,1,1,0),
(2191,9756,14,0,1,1,0),
(2191,9757,1.8,0,1,1,0),
(2191,9759,1.2,0,1,1,0),
(2191,9762,0.9,0,1,1,0),
(2191,9763,12,0,1,1,0),
(2191,9765,1.5,0,1,1,0),
(2191,9785,1.4,0,1,1,0),
(2191,9786,2,0,1,1,0),
(2191,14025,0.05,0,1,1,0),
(2191,14097,0.07,0,1,1,0),
(2191,14102,0.07,0,1,1,0),
(2191,14109,0.1,0,1,1,0),
(2191,14110,0.14,0,1,1,0),
(2191,14113,0.13,0,1,1,0),
(2191,14114,0.07,0,1,1,0),
(2191,14115,0.09,0,1,1,0),
(2191,14116,0.08,0,1,1,0),
(2191,14117,0.01,0,1,1,0),
(2191,15011,0.1,0,1,1,0),
(2191,15013,0.13,0,1,1,0),
(2191,15015,0.15,0,1,1,0),
(2191,15268,0.05,0,1,1,0),
(2191,15300,0.11,0,1,1,0),
(2191,15301,0.08,0,1,1,0),
(2191,15304,0.05,0,1,1,0),
(2191,15480,0.07,0,1,1,0),
(2191,15481,0.05,0,1,1,0),
(2191,15485,0.06,0,1,1,0),
(2191,15490,0.05,0,1,1,0),
(2191,15492,0.05,0,1,1,0),
(2191,15495,0.05,0,1,1,0);
-- Added missing alternate gossip texts from mage, warlock and druid trainers
-- used when player is not from the required class
-- based on light versions of commits https://github.com/unified-db/Database/commit/6fd45fc0178a35d96dab8dcffb34c253c0648f53
-- https://github.com/unified-db/Database/commit/7bfbcde4e1eaeb2e767092f8714d5477b08e032a
-- and https://github.com/unified-db/Database/commit/226c18e1905b36aa5288edddf3da32acb590f4e7 by @Grz3s


-- ------------------------
-- mage trainers gossips
-- ------------------------

SET @CID := 18; -- condition : is mage

-- Marryk Nurribit c.944
-- Bink c.5144
-- Nittlebur Sparkfizzle c.5146
DELETE FROM gossip_menu WHERE entry = 4552 AND text_id = 560;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4552, 560, 0, @CID); -- Mage

-- Magis Sparkmantle c.1228
DELETE FROM gossip_menu WHERE entry = 4685;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4685, 560, 0, @CID), -- Mage
(4685, 561, 0, 0);

-- Isabella c.2124
DELETE FROM gossip_menu WHERE entry = 4654 AND text_id = 562;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4654, 562, 0, @CID); -- Mage

-- Archmage Shymm c.3047
DELETE FROM gossip_menu WHERE entry = 4534 AND text_id = 562;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4534, 562, 0, @CID); -- Mage

-- Kaelystia Hatebringer c.4566
DELETE FROM gossip_menu WHERE entry = 4539 AND text_id = 562;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4539, 562, 0, @CID); -- Mage

-- Pierce Shackleton c.4567
DELETE FROM gossip_menu WHERE entry = 4538 AND text_id = 562;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4538, 562, 0, @CID); -- Mage

-- Anastasia Hartwell c.4568
DELETE FROM gossip_menu WHERE entry = 4537 AND text_id = 562;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4537, 562, 0, @CID); -- Mage

-- Un'Thuwa c.5880
-- Pephredo c.5882
-- Enyo c.5883
-- Mai'ah c.5884
-- Deino c.5885
-- Uthel'nay c.7311
DELETE FROM gossip_menu WHERE entry = 64 AND text_id = 564;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(64, 564, 0, @CID); -- Mage


-- ------------------------
-- warlock trainers gossips
-- ------------------------

SET @CID := 19; -- condition : is warlock

-- Alamar Grimm c.460
DELETE FROM gossip_menu WHERE entry = 4681 AND text_id = 2193;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4681, 2193, 0, @CID); -- Warlock

-- Demisette Cloyce c.461
DELETE FROM gossip_menu WHERE entry = 4503;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4503, 5722, 0, 0),
(4503, 5693, 0, @CID);  -- Warlock

-- Dhugru Gorelust c.3172
DELETE FROM gossip_menu WHERE entry = 4641 AND text_id = 5714;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4641, 5714, 0, @CID); -- Warlock

-- Kaal Soulreaper c.4563
DELETE FROM gossip_menu WHERE entry = 2383 AND text_id = 5714;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(2383, 5714, 0, @CID); -- Warlock

-- Luther Pickman c.4564
DELETE FROM gossip_menu WHERE entry = 4609;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4609, 5719, 0, @CID); -- Warlock

-- Ursula Deline c.5495
DELETE FROM gossip_menu WHERE entry = 4505;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4505, 5722, 0, 0),
(4505, 5693, 0, @CID);  -- Warlock

-- Sandahl c.5496
DELETE FROM gossip_menu WHERE entry = 4504;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4504, 5722, 0, 0),
(4504, 5693, 0, @CID);  -- Warlock

-- Gimrizz Shadowcog c.5612
DELETE FROM gossip_menu WHERE entry = 4682 AND text_id = 2193;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4682, 2193, 0, @CID); -- Warlock


-- ------------------------
-- druid trainers gossips
-- ------------------------

SET @CID := 21; -- condition : is druid

-- Sheal Runetotem c.3034
DELETE FROM gossip_menu WHERE entry = 4606 AND text_id = 5716;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4606, 5716, 0, @CID); -- Druid

-- Kym Wildmane c.3036
DELETE FROM gossip_menu WHERE entry = 4607 AND text_id = 5716;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4607, 5716, 0, @CID); -- Druid

-- Gennia Runetotem c.3064
DELETE FROM gossip_menu WHERE entry = 3926 AND text_id = 4786;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(3926, 4786, 0, @CID); -- Druid

-- Mardant Strongoak c.3597
DELETE FROM gossip_menu WHERE entry = 4688 AND text_id = 4784;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4688, 4784, 0, @CID); -- Druid

-- Fylerian Nightwing c.4219
DELETE FROM gossip_menu WHERE entry = 4571 AND text_id = 4782;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4571, 4782, 0, @CID); -- Druid

-- Sheldras Moontree c.5504
DELETE FROM gossip_menu WHERE entry = 4508;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4508, 5694, 0, @CID), -- Druid
(4508, 4783, 0, 0);

-- Theridran c.5505
DELETE FROM gossip_menu WHERE entry = 3925;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(3925, 4784, 0, @CID), -- Druid
(3925, 4783, 0, 0);

-- Maldryn c.5506
DELETE FROM gossip_menu WHERE entry = 4507;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4507, 5694, 0, @CID), -- Druid
(4507, 4783, 0, 0);

-- Jannos Lighthoof c.8142
DELETE FROM gossip_menu WHERE entry = 4646 AND text_id = 5716;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4646, 5716, 0, @CID); -- Druid

-- Golhine the Hooded c.9465
DELETE FROM gossip_menu WHERE entry = 4605;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4605, 4784, 0, @CID), -- Druid
(4605, 4780, 0, 0);

-- Loganaar c.12042
DELETE FROM gossip_menu WHERE entry = 4687;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4687, 4784, 0, @CID), -- Druid
(4687, 4783, 0, 0);
-- Moonstalker Runt
-- data taken from YTDB thx
DELETE FROM pet_levelstats WHERE creature_entry = 2070;
INSERT INTO pet_levelstats (creature_entry , level , hp , mana , armor , str , agi , sta , inte , spi) values
(2070 , 1 , 48 , 80 , 10 , 20 , 16 , 13 , 20 , 8),
(2070 , 2 , 105 , 106 , 67 , 22 , 17 , 14 , 21 , 9),
(2070 , 3 , 162 , 132 , 124 , 24 , 18 , 15 , 22 , 10),
(2070 , 4 , 219 , 158 , 181 , 26 , 19 , 16 , 23 , 11),
(2070 , 5 , 276 , 184 , 238 , 28 , 20 , 17 , 24 , 12),
(2070 , 6 , 333 , 210 , 295 , 30 , 21 , 18 , 25 , 13),
(2070 , 7 , 390 , 236 , 352 , 32 , 22 , 19 , 26 , 14),
(2070 , 8 , 447 , 262 , 409 , 34 , 23 , 20 , 27 , 15),
(2070 , 9 , 504 , 288 , 466 , 36 , 24 , 21 , 28 , 16),
(2070 , 10 , 561 , 314 , 523 , 38 , 25 , 22 , 29 , 17),
(2070 , 11 , 618 , 340 , 580 , 40 , 26 , 23 , 30 , 18),
(2070 , 12 , 675 , 366 , 637 , 42 , 27 , 24 , 31 , 19),
(2070 , 13 , 732 , 392 , 694 , 44 , 28 , 25 , 32 , 20),
(2070 , 14 , 789 , 418 , 751 , 46 , 29 , 26 , 33 , 21),
(2070 , 15 , 846 , 444 , 808 , 48 , 30 , 27 , 34 , 22),
(2070 , 16 , 903 , 470 , 865 , 50 , 31 , 28 , 35 , 23),
(2070 , 17 , 960 , 496 , 922 , 52 , 32 , 29 , 36 , 24),
(2070 , 18 , 1017 , 522 , 979 , 54 , 33 , 30 , 37 , 25),
(2070 , 19 , 1074 , 548 , 1036 , 56 , 34 , 31 , 38 , 26),
(2070 , 20 , 1131 , 574 , 1093 , 58 , 35 , 32 , 39 , 27),
(2070 , 21 , 1188 , 600 , 1150 , 60 , 36 , 33 , 40 , 28),
(2070 , 22 , 1245 , 626 , 1207 , 62 , 37 , 34 , 41 , 29),
(2070 , 23 , 1302 , 652 , 1264 , 64 , 38 , 35 , 42 , 30),
(2070 , 24 , 1359 , 678 , 1321 , 66 , 39 , 36 , 43 , 31),
(2070 , 25 , 1416 , 704 , 1378 , 68 , 40 , 37 , 44 , 32),
(2070 , 26 , 1473 , 730 , 1435 , 70 , 41 , 38 , 45 , 33),
(2070 , 27 , 1530 , 756 , 1492 , 72 , 42 , 39 , 46 , 34),
(2070 , 28 , 1587 , 782 , 1549 , 74 , 43 , 40 , 47 , 35),
(2070 , 29 , 1644 , 808 , 1606 , 76 , 44 , 41 , 48 , 36),
(2070 , 30 , 1701 , 834 , 1663 , 78 , 45 , 42 , 49 , 37),
(2070 , 31 , 1758 , 860 , 1720 , 80 , 46 , 43 , 50 , 38),
(2070 , 32 , 1815 , 886 , 1777 , 82 , 47 , 44 , 51 , 39),
(2070 , 33 , 1872 , 912 , 1834 , 84 , 48 , 45 , 52 , 40),
(2070 , 34 , 1929 , 938 , 1891 , 86 , 49 , 46 , 53 , 41),
(2070 , 35 , 1986 , 964 , 1948 , 88 , 50 , 47 , 54 , 42),
(2070 , 36 , 2043 , 990 , 2005 , 90 , 51 , 48 , 55 , 43),
(2070 , 37 , 2100 , 1016 , 2062 , 92 , 52 , 49 , 56 , 44),
(2070 , 38 , 2157 , 1042 , 2119 , 94 , 53 , 50 , 57 , 45),
(2070 , 39 , 2214 , 1068 , 2176 , 96 , 54 , 51 , 58 , 46),
(2070 , 40 , 2271 , 1094 , 2233 , 98 , 55 , 52 , 59 , 47),
(2070 , 41 , 2328 , 1120 , 2290 , 100 , 56 , 53 , 60 , 48),
(2070 , 42 , 2385 , 1146 , 2347 , 102 , 57 , 54 , 61 , 49),
(2070 , 43 , 2442 , 1172 , 2404 , 104 , 58 , 55 , 62 , 50),
(2070 , 44 , 2499 , 1198 , 2461 , 106 , 59 , 56 , 63 , 51),
(2070 , 45 , 2556 , 1224 , 2518 , 108 , 60 , 57 , 64 , 52),
(2070 , 46 , 2613 , 1250 , 2575 , 110 , 61 , 58 , 65 , 53),
(2070 , 47 , 2670 , 1276 , 2632 , 112 , 62 , 59 , 66 , 54),
(2070 , 48 , 2727 , 1302 , 2689 , 114 , 63 , 60 , 67 , 55),
(2070 , 49 , 2784 , 1328 , 2746 , 116 , 64 , 61 , 68 , 56),
(2070 , 50 , 2841 , 1354 , 2803 , 118 , 65 , 62 , 69 , 57),
(2070 , 51 , 2898 , 1380 , 2860 , 120 , 66 , 63 , 70 , 58),
(2070 , 52 , 2955 , 1406 , 2917 , 122 , 67 , 64 , 71 , 59),
(2070 , 53 , 3012 , 1432 , 2974 , 124 , 68 , 65 , 72 , 60),
(2070 , 54 , 3069 , 1458 , 3031 , 126 , 69 , 66 , 73 , 61),
(2070 , 55 , 3126 , 1484 , 3088 , 128 , 70 , 67 , 74 , 62),
(2070 , 56 , 3183 , 1510 , 3145 , 130 , 71 , 68 , 75 , 63),
(2070 , 57 , 3240 , 1536 , 3202 , 132 , 72 , 69 , 76 , 64),
(2070 , 58 , 3297 , 1562 , 3259 , 134 , 73 , 70 , 77 , 65),
(2070 , 59 , 3354 , 1588 , 3316 , 136 , 74 , 71 , 78 , 66),
(2070 , 60 , 3411 , 1614 , 3373 , 138 , 75 , 72 , 79 , 67);
-- Added teleport to Chillwind Camp in Western Plaguelands
DELETE FROM `game_tele` WHERE `id` = 419;
INSERT INTO `game_tele` VALUES
(419, 952.3, -1426.74, 64.64, 0.074, 0, 'Chillwind Camp');
-- Darkshore
-- spawns updates

-- Young Reef Crawler
UPDATE creature SET position_x = 6062.000977, position_y = 516.190369, position_z = 6.024218 WHERE guid = 38601; 
-- Missing spawns 
-- missing added - UDB free guids reused
DELETE FROM creature WHERE guid IN (61526,61527,61537,61541,61543,61545,61554,61565,61567,61574,61577,61585,61586,61587,61588,61599,61604,61607,61609,61627);
DELETE FROM creature_addon WHERE guid IN (61526,61527,61537,61541,61543,61545,61554,61565,61567,61574,61577,61585,61586,61587,61588,61599,61604,61607,61609,61627);
DELETE FROM creature_movement WHERE id IN (61526,61527,61537,61541,61543,61545,61554,61565,61567,61574,61577,61585,61586,61587,61588,61599,61604,61607,61609,61627);
DELETE FROM game_event_creature WHERE guid IN (61526,61527,61537,61541,61543,61545,61554,61565,61567,61574,61577,61585,61586,61587,61588,61599,61604,61607,61609,61627);
DELETE FROM game_event_creature_data WHERE guid IN (61526,61527,61537,61541,61543,61545,61554,61565,61567,61574,61577,61585,61586,61587,61588,61599,61604,61607,61609,61627);
DELETE FROM creature_battleground WHERE guid IN (61526,61527,61537,61541,61543,61545,61554,61565,61567,61574,61577,61585,61586,61587,61588,61599,61604,61607,61609,61627);
DELETE FROM creature_linking WHERE guid IN (61526,61527,61537,61541,61543,61545,61554,61565,61567,61574,61577,61585,61586,61587,61588,61599,61604,61607,61609,61627)
OR master_guid IN (61526,61527,61537,61541,61543,61545,61554,61565,61567,61574,61577,61585,61586,61587,61588,61599,61604,61607,61609,61627);
INSERT INTO creature (guid, id, map, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
(61526,2234,1,0,0,6027.74,554.244,1.12908,4.45806,275,10,0,198,0,0,1),
(61527,2234,1,0,0,5978.65,519.066,4.57117,3.43862,275,10,0,198,0,0,1),
(61537,2234,1,0,0,5952.73,552.479,0.820908,4.69525,275,10,0,198,0,0,1),
(61541,2234,1,0,0,5910.58,599.778,0.793617,2.61395,275,10,0,198,0,0,1),
(61543,2234,1,0,0,5948.12,600.71,-1.19927,1.8364,275,10,0,198,0,0,1),
(61545,2234,1,0,0,5911.84,518.51,2.43248,4.42819,275,10,0,198,0,0,1),
(61554,2234,1,0,0,5843.98,536.661,0.0222167,3.48092,275,10,0,198,0,0,1),
(61565,2234,1,0,0,5800.72,538.571,2.34419,3.14713,275,10,0,198,0,0,1),
(61567,2234,1,0,0,5792.79,590.647,-1.27004,4.04248,275,10,0,198,0,0,1),
(61574,2234,1,0,0,5751.19,577.516,2.85258,3.51233,275,10,0,198,0,0,1),
(61577,2234,1,0,0,5701.58,533.092,3.79555,4.10138,275,10,0,198,0,0,1),
(61585,2234,1,0,0,5705.03,604.042,-4.72749,4.65901,275,10,0,198,0,0,1),
(61586,2234,1,0,0,5667.02,510.826,4.15598,2.76621,275,10,0,198,0,0,1),
-- Stormscale Myrmidon
(61587,2181,1,0,0,7581.37,-831.822,14.9534,2.36711,275,10,0,417,0,0,1),
(61588,2181,1,0,0,7527.75,-823.219,17.3281,6.05455,275,10,0,417,0,0,1),
(61599,2181,1,0,0,7552.24,-857.138,15.6165,4.25599,275,10,0,417,0,0,1),
(61604,2181,1,0,0,7589.85,-874.228,14.759,0.317216,275,10,0,417,0,0,1),
(61607,2181,1,0,0,7593.18,-920.479,19.36,0.7649,275,10,0,417,0,0,1),
(61609,2181,1,0,0,7641.08,-915.422,19.0718,1.22829,275,10,0,417,0,0,1),
-- Stormscale Sorceress
(61627,2182,1,0,0,7536.04,-889.868,20.2889,1.54244,275,10,0,405,1202,0,1);-- Complete rework of the Lore Keeper of Norgannon event in Uldaman by @Grz3s
-- q.2278 'The Platinum Discs'
DELETE FROM dbscripts_on_quest_start WHERE id = 2278;
INSERT INTO dbscripts_on_quest_start (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(2278,1,31,7172,50,0,0,0x08,0,0,0,0,0,0,0,0,'search for 7172'), -- only one must be spawned
(2278,2,10,7172,0,0,0,0,0,0,0,0,148.761,309.447,-52.2059,5.16299,'summon: Lore Keeper of Norgannon'),
(2278,4,0,0,0,7172,50,7,2000000817,0,0,0,0,0,0,0,'7172 yell');

DELETE FROM db_script_string WHERE entry IN (2000000817,2000000818);
INSERT INTO db_script_string (entry, content_default, sound, type, language, emote, comment) VALUES 
(2000000817,'Greetings, mortals! I have been activated by the Discs of Norgannon to assist you!',0,1,0,0,NULL),
(2000000818,'The discs are now ready! Engage the Discs of Norgannon once again to retrieve them!',0,1,0,0,NULL);

DELETE FROM dbscripts_on_gossip WHERE id IN (569,571,575);
INSERT INTO dbscripts_on_gossip (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(569, 0, 43, 0, 0, 170353, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'reset dwarf'), -- in case if someone else is in this q. also
(569, 1, 13, 0, 0, 142488, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'activate trogg'),
(571, 0, 43, 0, 0, 142488, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'reset trogg'),  -- in case if someone else is in this q. also or player dont want to read story :)
(571, 1, 13, 0, 0, 170353, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'activate dwarf'),
(575, 0, 0, 0, 0, 0, 0, 0, 2000000818, 0, 0, 0, 0, 0, 0, 0, '7172 yell');

UPDATE gossip_menu_option SET action_script_id = 569 WHERE menu_id = 569;
UPDATE gossip_menu_option SET action_script_id = 571 WHERE menu_id = 571;
UPDATE gossip_menu_option SET action_script_id = 575 WHERE menu_id = 575;

UPDATE `creature` SET `modelid`='0', `position_x`='-432.132', `position_y`='230.477', `position_z`='-211.508', `orientation`='1.59581', `spawndist`='0', `MovementType`='2' WHERE `guid`='30239';
UPDATE `creature` SET `modelid`='0', `position_x`='-538.722', `position_y`='321.578', `position_z`='-220.447', `orientation`='4.69381', `spawndist`='0', `MovementType`='2' WHERE `guid`='30245';
UPDATE `creature` SET `modelid`='0', `position_x`='-446.346', `position_y`='233.419', `position_z`='-207.872', `orientation`='1.63923', `spawndist`='0', `MovementType`='2' WHERE `guid`='30330';

DELETE FROM `creature_movement` WHERE `id` IN ('30239', '30245', '30330');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30239', '1', '-432.3780', '240.297', '-211.538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '2', '-443.0520', '265.788', '-211.541', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '3', '-469.4470', '277.197', '-211.540', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '4', '-491.5410', '277.134', '-211.530', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '5', '-516.2000', '277.284', '-211.539', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '6', '-538.2920', '286.529', '-211.538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '7', '-547.4580', '309.004', '-216.948', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '8', '-546.9060', '330.915', '-223.711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '9', '-546.4820', '351.907', '-231.019', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '10', '-546.906', '330.915', '-223.711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '11', '-547.458', '309.004', '-216.948', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '12', '-538.292', '286.529', '-211.538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '13', '-516.200', '277.284', '-211.539', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '14', '-491.541', '277.134', '-211.530', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '15', '-469.447', '277.197', '-211.540', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '16', '-443.052', '265.788', '-211.541', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '17', '-432.383', '240.496', '-211.538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30239', '18', '-432.523', '220.204', '-211.538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '1', '-538.9720', '308.117', '-216.993', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '2', '-532.0440', '292.607', '-211.549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '3', '-515.2880', '285.370', '-211.550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '4', '-491.9520', '285.240', '-211.544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '5', '-468.8850', '285.454', '-211.551', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '6', '-451.1030', '278.269', '-211.550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '7', '-436.5580', '270.885', '-211.552', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '8', '-430.8330', '257.018', '-211.551', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '9', '-423.3660', '239.032', '-211.550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '10', '-423.556', '219.722', '-211.549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '11', '-423.366', '239.032', '-211.550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '12', '-430.833', '257.018', '-211.551', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '13', '-436.558', '270.885', '-211.552', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '14', '-451.103', '278.269', '-211.550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '15', '-468.885', '285.454', '-211.551', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '16', '-491.952', '285.240', '-211.544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '17', '-515.145', '285.360', '-211.549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '18', '-532.044', '292.607', '-211.549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '19', '-538.977', '307.891', '-216.873', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30245', '20', '-538.368', '347.460', '-229.482', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '1', '-446.7220', '238.904', '-207.942', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '2', '-453.7540', '255.332', '-207.938', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '3', '-470.4910', '262.454', '-207.940', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '4', '-514.4340', '262.572', '-207.954', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '5', '-547.9460', '276.406', '-207.935', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '6', '-561.8510', '309.442', '-213.397', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '7', '-547.9460', '276.406', '-207.935', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '8', '-514.4820', '262.572', '-207.934', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '9', '-470.4910', '262.454', '-207.940', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '10', '-453.754', '255.332', '-207.938', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '11', '-446.752', '238.973', '-207.967', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30330', '12', '-445.588', '220.722', '-207.907', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-870.887', `position_y`='412.753', `position_z`='-316.378', `orientation`='0.629453', `spawntimesecs`='1800', `spawndist`='0', `MovementType`='2' WHERE `guid`='30385';
UPDATE `creature` SET `modelid`='0', `position_x`='-785.107', `position_y`='547.2', `position_z`='-291.131', `orientation`='3.7642', `spawntimesecs`='1800', `spawndist`='0', `MovementType`='2' WHERE `guid`='30392';

DELETE FROM `creature_movement` WHERE `id` IN ('30385', '30392');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30385', '1', '-856.5260', '423.211', '-314.368', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '2', '-844.2770', '432.410', '-312.281', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '3', '-833.3950', '440.807', '-310.187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '4', '-821.3680', '450.877', '-308.104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '5', '-815.8410', '456.337', '-308.104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '6', '-815.6490', '468.987', '-308.104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '7', '-815.8410', '456.337', '-308.104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '8', '-821.3300', '450.915', '-308.104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '9', '-833.3950', '440.807', '-310.187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '10', '-844.277', '432.410', '-312.281', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '11', '-856.526', '423.211', '-314.368', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30385', '12', '-871.910', '411.937', '-316.439', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '1', '-797.6900', '538.168', '-295.578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '2', '-815.5700', '523.729', '-300.245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '3', '-828.7990', '513.014', '-303.937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '4', '-834.0880', '503.896', '-303.937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '5', '-832.4210', '494.262', '-303.937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '6', '-821.0990', '480.042', '-307.016', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '7', '-832.4210', '494.262', '-303.937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '8', '-834.0880', '503.896', '-303.937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '9', '-828.7990', '513.014', '-303.937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '10', '-815.570', '523.729', '-300.245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '11', '-797.690', '538.168', '-295.578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30392', '12', '-778.209', '552.607', '-291.126', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');
-- Added missing alternate gossip texts from rogue, priest and shaman trainers
-- used when player is not from the required class
-- based on light versions of commits https://github.com/unified-db/Database/commit/bfb080cc2d3b0debdce9998a0e0856160c1a5fe6
-- https://github.com/unified-db/Database/commit/16d7790faff3827f3085d2fb7c09c1f58bbee200
-- and https://github.com/unified-db/Database/commit/76fd8bc65c61cbacded4de5401fd6db8baaf9190 by @Grz3s


-- ------------------------
-- rogue trainers gossips
-- ------------------------

SET @CID := 16; -- condition : is rogue

-- Rwag c.3155
UPDATE gossip_menu SET text_id = 638 WHERE entry = 141 AND text_id = 4794;

-- Shenthul c.3401
DELETE FROM gossip_menu WHERE entry = 50199; -- source TC - not sure if its correct
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(50199, 1124, 0, 1024), -- Rogue
(50199, 1038, 0, @CID),
(50199, 4793, 0, 25);
DELETE FROM gossip_menu_option WHERE menu_id = 50199;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(50199, 0, 3, 'Can you train me how to use rogue skills?', 5, 16, 0, 0, 0, 0, 0, NULL, 16),
(50199, 4, 0, '<Take the letter>', 1, 1, -1, 0, 5, 0, 0, NULL, 196),
(50199, 1, 0, 'I wish to unlearn my talents.', 1, 1, 4461, 0, 0, 0, 0, NULL, 136);

-- Carolyn Ward c.4582
DELETE FROM gossip_menu WHERE entry = 4542 AND text_id = 581;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4542, 581, 0, @CID); -- Rogue
DELETE FROM gossip_menu_option WHERE menu_id = 4542;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(4542, 0, 3, 'an you train me how to use rogue skills?', 5, 16, 0, 0, 0, 0, 0, NULL, 16),
(4542, 4, 0, '<Take the letter>', 1, 1, -1, 0, 5, 0, 0, NULL, 196),
(4542, 1, 0, 'I wish to unlearn my talents.', 1, 1, 4461, 0, 0, 0, 0, NULL, 136);

-- Miles Dexter c.4583
DELETE FROM gossip_menu WHERE entry = 4540 AND text_id = 581;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4540, 581, 0, @CID); -- Rogue
DELETE FROM gossip_menu_option WHERE menu_id = 4540;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(4540, 0, 3, 'an you train me how to use rogue skills?', 5, 16, 0, 0, 0, 0, 0, NULL, 16),
(4540, 4, 0, '<Take the letter>', 1, 1, -1, 0, 5, 0, 0, NULL, 196),
(4540, 1, 0, 'I wish to unlearn my talents.', 1, 1, 4461, 0, 0, 0, 0, NULL, 136);

-- Gregory Charles c.4584
DELETE FROM gossip_menu WHERE entry = 4541 AND text_id = 581;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4541, 581, 0, @CID); -- Rogue
DELETE FROM gossip_menu_option WHERE menu_id = 4541;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(4541, 0, 3, 'an you train me how to use rogue skills?', 5, 16, 0, 0, 0, 0, 0, NULL, 16),
(4541, 4, 0, '<Take the letter>', 1, 1, -1, 0, 5, 0, 0, NULL, 196),
(4541, 1, 0, 'I wish to unlearn my talents.', 1, 1, 4461, 0, 0, 0, 0, NULL, 136);

-- Ormyr Flinteye c.5166
DELETE FROM gossip_menu WHERE entry = 4562;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4562, 4834, 0, @CID), -- Rogue
(4562, 4833, 0, 0);


-- ------------------------
-- priest trainers gossips
-- ------------------------

SET @CID := 112; -- condition : is priest

-- High Priestess Laurena c.376
DELETE FROM gossip_menu WHERE entry = 4666 AND text_id = 4433;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4666, 4433, 0, @CID); -- Priest

-- Branstock Khalder c.837
-- Maxan Anvol c.1226
-- Theodrus Frostbeard c.5141
-- Braenna Flintcrag c.5142
-- Toldren Deepiron c.5143
DELETE FROM gossip_menu WHERE entry = 4680 AND text_id = 4436;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4680, 4436, 0, @CID); -- Priest

-- Dark Cleric Duesten c.2123
DELETE FROM gossip_menu WHERE entry = 3645;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(3645, 4439, 0, 0),
(3645, 4442, 0, @CID);
DELETE FROM gossip_menu_option WHERE menu_id = 3645;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
('3645','0','3','Train me.','5','16','0','0','0','0','0','','0'),
('3645','1','0','I wish to unlearn my talents.','1','1','4461','0','0','0','0','','163');

-- Miles Welsh c.3044
-- Malakai Cross c.3045
-- Father Cobb c.3046
-- Aelthalyste c.4606
UPDATE gossip_menu SET text_id = 4439 WHERE entry IN (4533, 4531, 4532, 4544) AND text_id = 4437;

-- Shanda c.3595
-- Laurna Morninglight c.3600
-- Astarii Starseeker c.4090
-- Jandria c.4091
-- Lariia c.4092
DELETE FROM gossip_menu WHERE entry = 4691 AND text_id = 4438;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4691, 4438, 0, @CID); -- Priest
UPDATE gossip_menu_option SET option_text = 'I would like to train further in the ways of the Light.' WHERE menu_id = 4691 AND id = 0;

-- Tai'jin c.3706
-- Ken'jai c.3707
DELETE FROM gossip_menu WHERE entry = 3644 AND text_id = 4441;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(3644, 4441, 0, @CID); -- Priest

-- Father Lankester c.4607
DELETE FROM gossip_menu WHERE entry = 4545;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4545, 4439, 0, 0),
(4545, 4442, 0, @CID);
DELETE FROM gossip_menu_option WHERE menu_id = 4545;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
('4545','1','3','Train me.','5','16','0','0','0','0','0','','0'),
('4545','2','0','I wish to unlearn my talents.','1','1','4461','0','0','0','0','','163');

-- Father Lazarus c.4608
DELETE FROM gossip_menu WHERE entry = 4543;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4543, 4439, 0, 0),
(4543, 4442, 0, @CID);
DELETE FROM gossip_menu_option WHERE menu_id = 4543;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
('4543','1','3','Train me.','5','16','0','0','0','0','0','','0'),
('4543','2','0','I wish to unlearn my talents.','1','1','4461','0','0','0','0','','163');

-- Brother Benjamin c.5484
DELETE FROM gossip_menu WHERE entry = 4468 AND text_id = 4433;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4468, 4433, 0, @CID); -- Priest

-- Brother Joshua c.5489
DELETE FROM gossip_menu WHERE entry = 4666 AND text_id = 4433;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4666, 4433, 0, @CID); -- Priest

-- Nara Meideros c.11397
DELETE FROM gossip_menu WHERE entry = 3643;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(3643, 4437, 0, 0),
(3643, 4438, 0, @CID);

-- Priestess Alathea c.11401
DELETE FROM gossip_menu WHERE entry = 4691;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4691, 4437, 0, 0),
(4691, 4438, 0, @CID);

-- High Priest Rohan c.11406
DELETE FROM gossip_menu WHERE entry = 3642 AND text_id = 4436;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(3642, 4436, 0, @CID); -- Priest


-- ------------------------
-- shaman trainers gossips
-- ------------------------

SET @CID := 17; -- condition : is shaman

-- Haromm c.986
UPDATE gossip_menu_option SET option_text = 'Teach me the ways of the spirits.' WHERE menu_id = 4104 AND id = 0;

-- Siln Skychaser c.3030
DELETE FROM gossip_menu WHERE entry = 4528;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4528, 5005, 0, @CID), -- Shaman
(4528, 5006, 0, 0);

-- Tigor Skychaser c.3031
DELETE FROM gossip_menu WHERE entry = 4530;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4530, 5005, 0, @CID), -- Shaman
(4530, 5006, 0, 0);

-- Beram Skychaser c.3032
DELETE FROM gossip_menu WHERE entry = 4529;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4529, 5005, 0, @CID), -- Shaman
(4529, 5006, 0, 0);

-- Meela Dawnstrider c.3062
-- Narm Skychaser c.3066
DELETE FROM gossip_menu WHERE entry = 4103;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4103, 5005, 0, @CID), -- Shaman
(4103, 5006, 0, 0);

-- Swart c.3173
DELETE FROM gossip_menu WHERE entry = 4104;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4104, 5005, 0, @CID), -- Shaman
(4104, 5006, 0, 0);

-- Kardris Dreamseeker c.3344
DELETE FROM gossip_menu WHERE entry = 4516;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4516, 5005, 0, @CID), -- Shaman
(4516, 5006, 0, 0);

-- Sian'tsu c.3403
DELETE FROM gossip_menu WHERE entry = 4515;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(4515, 5007, 0, @CID), -- Shaman
(4515, 5008, 0, 0);
DELETE FROM gossip_menu_option WHERE menu_id = 4515;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
('4515','0','3','Teach me the ways of the spirits.','5','16','0','0','0','0','0','','0'),
('4515','1','0','I wish to unlearn my talents.','1','1','4461','0','0','0','0','','137');

-- Sagorne Creststrider c.13417
DELETE FROM gossip_menu WHERE entry = 5123;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(5123, 5005, 0, @CID), -- Shaman
(5123, 5006, 0, 0);
-- Fixed position of NPC 1365 for Winter Veil event
-- Goli was AWOL against his will, changed to correct location
UPDATE `creature` SET `position_y`=-952.68 WHERE `guid`=86181;

DELETE FROM `creature` WHERE `id`='6228';
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('30018', '6228', '90', '0', '0', '-670.9108', '686.0709', '-326.8117', '2.99763', '7200', '0', '0', '3660', '1512', '0', '2');

UPDATE `creature` SET `modelid`='0', `position_x`='-670.9108', `position_y`='686.0709', `position_z`='-326.8117', `orientation`='2.99763', `MovementType`='2' WHERE `guid`='30132';

UPDATE `pool_creature` SET `guid`='30132' WHERE `guid`='33458';
UPDATE `pool_creature` SET `guid`='30018' WHERE `guid`='590004';

DELETE FROM `creature_movement_template` WHERE `entry`='6228';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('6228', '1', '-690.7417', '691.1548', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '2', '-705.0435', '694.5044', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '3', '-716.3684', '687.8126', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '4', '-720.5470', '673.1483', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '5', '-726.0272', '652.7717', '-309.0671', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '6', '-733.0097', '624.5742', '-300.0597', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '7', '-740.0170', '596.7194', '-291.1952', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '8', '-743.5058', '581.6875', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '9', '-736.8128', '570.4097', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '10', '-722.5872', '566.3864', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '11', '-701.5124', '561.0034', '-282.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '12', '-694.0079', '559.4506', '-282.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '13', '-701.5124', '561.0034', '-282.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '14', '-722.5872', '566.3864', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '15', '-736.8128', '570.4097', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '16', '-743.5058', '581.6875', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '17', '-740.0170', '596.7194', '-291.1952', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '18', '-733.0516', '624.4052', '-300.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '19', '-726.0313', '652.7551', '-309.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '20', '-720.5470', '673.1483', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '21', '-716.3684', '687.8126', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '22', '-705.0435', '694.5044', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '23', '-690.7417', '691.1548', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('6228', '24', '-669.5505', '685.4362', '-327.0598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_movement` WHERE `id`='30132';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30132', '1', '-690.7417', '691.1548', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '2', '-705.0435', '694.5044', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '3', '-716.3684', '687.8126', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '4', '-720.5470', '673.1483', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '5', '-726.0272', '652.7717', '-309.0671', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '6', '-733.0097', '624.5742', '-300.0597', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '7', '-740.0170', '596.7194', '-291.1952', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '8', '-743.5058', '581.6875', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '9', '-736.8128', '570.4097', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '10', '-722.5872', '566.3864', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '11', '-701.5124', '561.0034', '-282.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '12', '-694.0079', '559.4506', '-282.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '13', '-701.5124', '561.0034', '-282.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '14', '-722.5872', '566.3864', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '15', '-736.8128', '570.4097', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '16', '-743.5058', '581.6875', '-291.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '17', '-740.0170', '596.7194', '-291.1952', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '18', '-733.0516', '624.4052', '-300.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '19', '-726.0313', '652.7551', '-309.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '20', '-720.5470', '673.1483', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '21', '-716.3684', '687.8126', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '22', '-705.0435', '694.5044', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '23', '-690.7417', '691.1548', '-318.0599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30132', '24', '-669.5505', '685.4362', '-327.0598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- Alarm-a-bomb 2600 [20]
UPDATE `creature_template` SET `SpeedRun`=('10' / '7.0'), `MinMeleeDmg`='29.4', `MaxMeleeDmg`='39.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='70', `RangedAttackPower`='4', `RangedBaseAttackTime`='2000' WHERE `Entry`='7897';

-- Kernobee [28] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='1.05', `ArmorMultiplier`='1', `MinLevelHealth`='895', `MaxLevelHealth`='895', `MinMeleeDmg`='39.3', `MaxMeleeDmg`='52.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1130', `MeleeAttackPower`='96', `RangedAttackPower`='8', `RangedBaseAttackTime`='2000' WHERE `Entry`='7850';

-- Tink Sprocketwhistle [24] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='1.02', `ArmorMultiplier`='1', `MinLevelHealth`='664', `MaxLevelHealth`='664', `MinMeleeDmg`='34.5', `MaxMeleeDmg`='45.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='992', `MeleeAttackPower`='84', `RangedAttackPower`='6', `RangedBaseAttackTime`='2000' WHERE `Entry`='9676';

-- Blastmaster Emi Shortfuse [27] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='1.3', `ArmorMultiplier`='1', `MinLevelHealth`='1040', `MaxLevelHealth`='1040', `MinMeleeDmg`='38.4', `MaxMeleeDmg`='51.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1097', `MeleeAttackPower`='92', `RangedAttackPower`='7', `RangedBaseAttackTime`='2000' WHERE `Entry`='7998';

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Viscous Fallout [30]
UPDATE `creature_template` SET `SpeedRun`=('9.02778' / '7.0'), `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2865', `MaxLevelHealth`='2865', `MinMeleeDmg`='42.4', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1200', `MeleeAttackPower`='102', `RangedAttackPower`='9', `RangedBaseAttackTime`='2000' WHERE `Entry`='7079';

-- Grubbis [32]
UPDATE `creature_template` SET `FactionAlliance`='59', `FactionHorde`='59', `HealthMultiplier`='5', `DamageMultiplier`='2.4', `ArmorMultiplier`='1', `MinLevelHealth`='5285', `MaxLevelHealth`='5285', `MinMeleeDmg`='44.8', `MaxMeleeDmg`='59.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1270', `MeleeAttackPower`='108', `RangedAttackPower`='10', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7361';

	-- Chomper [30]
	UPDATE `creature_template` SET `FactionAlliance`='59', `FactionHorde`='59', `SpeedWalk`=('2.77778' / '2.5'), `ArmorMultiplier`='1', `MinLevelHealth`='955', `MaxLevelHealth`='955', `MinMeleeDmg`='42.4', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1200', `MeleeAttackPower`='102', `RangedAttackPower`='9', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='6215';

-- Electrocutioner 6000 [32]
UPDATE `creature_template` SET `HealthMultiplier`='5', `DamageMultiplier`='2.4', `ArmorMultiplier`='1.5', `MinLevelHealth`='5285', `MaxLevelHealth`='5285', `MinMeleeDmg`='44.8', `MaxMeleeDmg`='59.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1905', `MeleeAttackPower`='108', `RangedAttackPower`='10', `RangedBaseAttackTime`='2000' WHERE `Entry`='6235';

-- Crowd Pummeler 9-60 [32] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('10' / '7.0'), `HealthMultiplier`='5', `DamageMultiplier`='2.4', `ArmorMultiplier`='1.5', `MinLevelHealth`='5285', `MaxLevelHealth`='5285', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='44.8', `MaxMeleeDmg`='59.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1905', `MeleeAttackPower`='108', `RangedAttackPower`='10', `RangedBaseAttackTime`='2000' WHERE `Entry`='6229';

-- Dark Iron Ambassador [33]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='5', `PowerMultiplier`='2', `DamageMultiplier`='2.4', `ArmorMultiplier`='1', `MinLevelHealth`='4640', `MaxLevelHealth`='4640', `MinLevelMana`='1926', `MaxLevelMana`='1926', `MinMeleeDmg`='42.8', `MaxMeleeDmg`='56.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1091', `MeleeAttackPower`='104', `RangedAttackPower`='10', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='6228';

	-- Burning Servant [30]
	UPDATE `creature_template` SET `FactionAlliance`='63', `FactionHorde`='63', `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('6.0' / '7.0'), `HealthMultiplier`='0.25', `DamageMultiplier`='0.1', `ArmorMultiplier`='1', `MinLevelHealth`='238', `MaxLevelHealth`='238', `MinMeleeDmg`='42.4', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1200', `MeleeAttackPower`='102', `RangedAttackPower`='9', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `DamageSchool`='2' WHERE `Entry`='7738';
	
		-- Ember [30] [NOBESTIARY]
		UPDATE `creature_template` SET `MinLevel`='30', `MaxLevel`='30', `FactionAlliance`='63', `FactionHorde`='63', `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('6.0' / '7.0'), `HealthMultiplier`='0.25', `DamageMultiplier`='0.1', `ArmorMultiplier`='1', `MinLevelHealth`='238', `MaxLevelHealth`='238', `MinMeleeDmg`='42.4', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1200', `MeleeAttackPower`='102', `RangedAttackPower`='9', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `DamageSchool`='2' WHERE `Entry`='7266';

-- Mekgineer Thermaplugg [34]
UPDATE `creature_template` SET `HealthMultiplier`='8', `PowerMultiplier`='1', `DamageMultiplier`='2.4', `ArmorMultiplier`='2', `MinLevelHealth`='9304', `MaxLevelHealth`='9304', `MinMeleeDmg`='47.3', `MaxMeleeDmg`='62.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2680', `MeleeAttackPower`='114', `RangedAttackPower`='11', `RangedBaseAttackTime`='2000' WHERE `Entry`='7800';

	-- Walking Bomb [30]
	UPDATE `creature_template` SET `SpeedWalk`=('6.0' / '2.5'), `SpeedRun`=('6.0' / '7.0'), `HealthMultiplier`='0.1', `ArmorMultiplier`='2', `MinLevelHealth`='95', `MaxLevelHealth`='95', `MinMeleeDmg`='42.4', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2400', `MeleeAttackPower`='102', `RangedAttackPower`='9', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7915';

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Arcane Nullifier X-21 [32-33]
UPDATE `creature_template` SET `HealthMultiplier`='5', `DamageMultiplier`='2.4', `ArmorMultiplier`='1', `MinLevelHealth`='5285', `MaxLevelHealth`='5550', `MinMeleeDmg`='44.8', `MaxMeleeDmg`='61.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1304', `MeleeAttackPower`='112', `RangedAttackPower`='10', `RangedBaseAttackTime`='2000' WHERE `Entry`='6232';

-- Caverndeep Ambusher [25-27] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='0.9', `ArmorMultiplier`='1', `MinLevelHealth`='629', `MaxLevelHealth`='720', `MinMeleeDmg`='35.8', `MaxMeleeDmg`='51.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1097', `MeleeAttackPower`='92', `RangedAttackPower`='7', `RangedBaseAttackTime`='2000' WHERE `Entry`='6207';
	
-- Caverndeep Burrower [25-27] [NOBESTIARY]
UPDATE `creature_template` SET `MinLevel`='25', `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2097', `MaxLevelHealth`='2400', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='35.8', `MaxMeleeDmg`='51.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1097', `MeleeAttackPower`='92', `RangedAttackPower`='7', `RangedBaseAttackTime`='2000' WHERE `Entry`='6206';

-- Caverndeep Reaver [26-28] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2250', `MaxLevelHealth`='2559', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='36.9', `MaxMeleeDmg`='52.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1130', `MeleeAttackPower`='96', `RangedAttackPower`='8', `RangedBaseAttackTime`='2000' WHERE `Entry`='6211';

-- Corrosive Lurker [28-29]
UPDATE `creature_template` SET `MaxLevel`='29', `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2559', `MaxLevelHealth`='2715', `MinMeleeDmg`='39.3', `MaxMeleeDmg`='54.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1165', `MeleeAttackPower`='100', `RangedAttackPower`='8', `RangedBaseAttackTime`='2000' WHERE `Entry`='6219';

-- Dark Iron Agent [32-33]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='3171', `MaxLevelHealth`='3330', `MinMeleeDmg`='44.8', `MaxMeleeDmg`='61.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1304', `MeleeAttackPower`='112', `RangedAttackPower`='10', `RangedBaseAttackTime`='2000' WHERE `Entry`='6212';

	-- Dark Iron Land Mine [32-33] [NOBESTIARY]
	UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `SpeedRun`=('7.0' / '7.0'), `HealthMultiplier`='0.2', `ArmorMultiplier`='1', `MinLevelHealth`='211', `MaxLevelHealth`='222', `MinMeleeDmg`='44.8', `MaxMeleeDmg`='61.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1304', `MeleeAttackPower`='112', `RangedAttackPower`='10' WHERE `Entry`='8035';

-- Holdout Medic [29-30] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2319', `MaxLevelHealth`='2433', `MinMeleeDmg`='38.1', `MaxMeleeDmg`='52.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1004', `MeleeAttackPower`='94', `RangedAttackPower`='8', `RangedBaseAttackTime`='2000' WHERE `Entry`='6392';

-- Holdout Technician [29-30] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2715', `MaxLevelHealth`='2865', `MinMeleeDmg`='41.0', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1200', `MeleeAttackPower`='102', `RangedAttackPower`='9', `RangedBaseAttackTime`='2000' WHERE `Entry`='6407';

-- Holdout Warrior [29-30] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2715', `MaxLevelHealth`='2865', `MinMeleeDmg`='41.0', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1200', `MeleeAttackPower`='102', `RangedAttackPower`='9' WHERE `Entry`='6391';

-- Irradiated Horror [28-29] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedRun`=('9.02778' / '7.0'), `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2196', `MaxLevelHealth`='2319', `MinLevelMana`='756', `MaxLevelMana`='811', `MinMeleeDmg`='36.8', `MaxMeleeDmg`='50.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='975', `MeleeAttackPower`='94', `RangedAttackPower`='8', `RangedBaseAttackTime`='2000' WHERE `Entry`='6220';
	
-- Irradiated Pillager [24-26] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='1713', `MaxLevelHealth`='1953', `MinLevelMana`='618', `MaxLevelMana`='693', `MinMeleeDmg`='32.1', `MaxMeleeDmg`='45.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='887', `MeleeAttackPower`='84', `RangedAttackPower`='6', `RangedBaseAttackTime`='2000' WHERE `Entry`='6329';

-- Irradiated Slime [27-28]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2400', `MaxLevelHealth`='2559', `MinMeleeDmg`='38.4', `MaxMeleeDmg`='52.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1130', `MeleeAttackPower`='96', `RangedAttackPower`='8', `RangedBaseAttackTime`='2000' WHERE `Entry`='6218';

-- Leprous Assistant [28-29]
UPDATE `creature_template` SET `MinLevel`='28', `ArmorMultiplier`='1', `MinLevelHealth`='853', `MaxLevelHealth`='905', `MinMeleeDmg`='39.3', `MaxMeleeDmg`='54.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1165', `MeleeAttackPower`='100', `RangedAttackPower`='8', `RangedBaseAttackTime`='2000' WHERE `Entry`='7603';

-- Leprous Defender [28-29]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2559', `MaxLevelHealth`='2715', `MinMeleeDmg`='39.3', `MaxMeleeDmg`='54.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1165', `MeleeAttackPower`='100', `RangedAttackPower`='8', `RangedBaseAttackTime`='2000' WHERE `Entry`='6223';

-- Leprous Machinesmith [29-30]
UPDATE `creature_template` SET `ArmorMultiplier`='1', `MinLevelHealth`='905', `MaxLevelHealth`='955', `MinMeleeDmg`='41.0', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1200', `MeleeAttackPower`='102', `RangedAttackPower`='9', `RangedBaseAttackTime`='2000' WHERE `Entry`='6224';

-- Leprous Technician [29-30]
UPDATE `creature_template` SET `ModelId3`='6934', `ModelId4`='6935', `ArmorMultiplier`='1', `MinLevelHealth`='905', `MaxLevelHealth`='955', `MinMeleeDmg`='41.0', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1200', `MeleeAttackPower`='102', `RangedAttackPower`='9', `RangedBaseAttackTime`='2000' WHERE `Entry`='6222';

-- Mechanized Guardian [31-32] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedRun`=('9.02778' / '7.0'), `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='3018', `MaxLevelHealth`='3171', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='43.5', `MaxMeleeDmg`='59.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1270', `MeleeAttackPower`='108', `RangedAttackPower`='10', `RangedBaseAttackTime`='2000' WHERE `Entry`='6234';

-- Mechanized Sentry [28-29] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedRun`=('9.02778' / '7.0'), `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2559', `MaxLevelHealth`='2715', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='39.3', `MaxMeleeDmg`='54.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1165', `MeleeAttackPower`='100', `RangedAttackPower`='8', `RangedBaseAttackTime`='2000' WHERE `Entry`='6233';

-- Mechano-Flamewalker [30-31] [NOBESTIARY]
UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5'), `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2865', `MaxLevelHealth`='3018', `MinLevelMana`='0', `MaxLevelMana`='0', `MinMeleeDmg`='42.4', `MaxMeleeDmg`='57.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1234', `MeleeAttackPower`='106', `RangedAttackPower`='9', `RangedBaseAttackTime`='2000' WHERE `Entry`='6226';

-- Mechano-Frostwalker [31-32] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2550', `MaxLevelHealth`='2664', `MinLevelMana`='878', `MaxLevelMana`='935', `MinMeleeDmg`='40.5', `MaxMeleeDmg`='55.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1063', `MeleeAttackPower`='100', `RangedAttackPower`='9', `RangedBaseAttackTime`='2000' WHERE `Entry`='6227';

-- Mechano-Tank [29-30] [NOBESTIARY]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2715', `MaxLevelHealth`='2865', `MinMeleeDmg`='41.0', `MaxMeleeDmg`='56.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1200', `MeleeAttackPower`='102', `RangedAttackPower`='9', `RangedBaseAttackTime`='2000' WHERE `Entry`='6225';

-- Mobile Alert System [25]
UPDATE `creature_template` SET `SpeedWalk`=('5' / '2.5'), `SpeedRun`=('5' / '7.0'), `MinMeleeDmg`='35.8', `MaxMeleeDmg`='47.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1026', `MeleeAttackPower`='86', `RangedAttackPower`='6', `RangedBaseAttackTime`='2000' WHERE `Entry`='7849';

-- Peacekeeper Security Suit [30-31]
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='2865', `MaxLevelHealth`='3018', `MinMeleeDmg`='42.4', `MaxMeleeDmg`='57.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1234', `MeleeAttackPower`='106', `RangedAttackPower`='9', `RangedBaseAttackTime`='2000' WHERE `Entry`='6230';

SET @ENTRY := '11983';
SET @POINT := '0';

SET @GUID = (SELECT `guid` FROM `creature` WHERE `id`=@ENTRY);

UPDATE `creature` SET `position_x`='-7433.382', `position_y`='-923.8293', `position_z`='465.3545', `orientation`='2.162942', `spawndist`='0' WHERE `guid`='139825';

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@ENTRY;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@ENTRY, @POINT := @POINT + '1', '-7443.802', '-908.3381', '465.3546', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7458.049', '-889.7999', '465.2166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7481.373', '-906.5868', '465.2278', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7507.165', '-922.4193', '457.8560', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7495.893', '-939.4832', '457.8560', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7475.219', '-969.2783', '449.7758', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7483.981', '-998.0866', '449.0793', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7513.288', '-1020.492', '448.9058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7483.981', '-998.0866', '449.0793', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7475.219', '-969.2783', '449.7758', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7495.775', '-939.6525', '457.8949', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7507.165', '-922.4193', '457.8560', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7481.387', '-906.5956', '465.2274', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7458.049', '-889.7999', '465.2166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7443.952', '-908.1151', '465.3283', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-7418.686', '-947.7281', '464.9808', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `MovementType`='0' WHERE `guid` IN ('30206', '33432', '30303', '30309', '31982', '30130', '33495', '30251', '30257', '30332', '30122');
UPDATE `creature` SET `spawndist`='1', `MovementType`='1' WHERE `guid`='30226';

UPDATE `creature` SET `modelid`='0', `position_x`='-657.316', `position_y`='376.562', `position_z`='-266.027', `orientation`='2.23283', `spawndist`='0', `MovementType`='2' WHERE `guid`='30331';

DELETE FROM `creature_movement` WHERE `id`='30331';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30331', '1', '-642.3300', '357.334', '-255.600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '2', '-619.5880', '369.404', '-247.244', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '3', '-639.5770', '402.001', '-233.689', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '4', '-649.4590', '413.697', '-230.633', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '5', '-645.2490', '427.468', '-230.591', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '6', '-637.7900', '433.336', '-230.606', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '7', '-645.2490', '427.468', '-230.591', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '8', '-649.4590', '413.697', '-230.633', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '9', '-639.5770', '402.001', '-233.689', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '10', '-619.588', '369.404', '-247.244', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '11', '-642.330', '357.334', '-255.600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30331', '12', '-664.485', '385.760', '-273.062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_movement` WHERE `id`='30279' AND `point` IN ('8', '9', '10', '11');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30279', '8', '-585.4900', '487.777', '-273.079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '9', '-587.1040', '508.355', '-273.077', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30279', '10', '-622.531', '522.641', '-273.062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-534.864', `position_y`='-31.667', `position_z`='-153.755', `orientation`='1.67356', `spawndist`='0', `MovementType`='2' WHERE `guid`='30217';
UPDATE `creature` SET `modelid`='0', `position_x`='-453.454', `position_y`='180.058', `position_z`='-154.737', `orientation`='3.23850', `spawndist`='0', `MovementType`='2' WHERE `guid`='30216';
UPDATE `creature` SET `modelid`='0', `position_x`='-533.139', `position_y`='70.3675', `position_z`='-201.784', `orientation`='3.02764', `spawndist`='0', `MovementType`='2' WHERE `guid`='30215';
UPDATE `creature` SET `modelid`='0', `position_x`='-543.498', `position_y`='212.750', `position_z`='-155.860', `orientation`='2.39444', `spawndist`='0', `MovementType`='2' WHERE `guid`='30214';
UPDATE `creature` SET `modelid`='0', `position_x`='-554.067', `position_y`='73.9347', `position_z`='-201.257', `orientation`='2.83838', `spawndist`='0', `MovementType`='2' WHERE `guid`='30271';

DELETE FROM `creature_movement` WHERE `id` IN ('30217', '30216', '30215', '30214', '30271', '30226');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30217', '22', '-532.909', '-46.197', '-152.147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '21', '-537.295', '-8.0929', '-156.381', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '20', '-528.433', '16.5616', '-156.506', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '19', '-494.313', '50.8165', '-156.926', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '18', '-509.008', '87.6308', '-154.740', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '17', '-506.075', '120.476', '-154.723', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '16', '-501.404', '147.635', '-154.711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '15', '-487.952', '158.486', '-154.714', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '14', '-508.528', '179.469', '-155.236', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '13', '-531.651', '159.437', '-155.236', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '12', '-557.697', '172.813', '-155.237', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '11', '-527.898', '204.697', '-155.238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '10', '-557.415', '172.668', '-155.236', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '9', '-531.6510', '159.437', '-155.236', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '8', '-508.5280', '179.469', '-155.236', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '7', '-487.9520', '158.486', '-154.714', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '6', '-501.4040', '147.635', '-154.711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '5', '-506.0750', '120.476', '-154.723', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '4', '-509.0080', '87.6308', '-154.740', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '3', '-494.3130', '50.8165', '-156.926', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '2', '-528.4330', '16.5616', '-156.506', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30217', '1', '-537.2950', '-8.0929', '-156.381', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '24', '-412.420', '182.583', '-154.743', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '23', '-457.132', '179.701', '-154.743', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '22', '-471.353', '175.991', '-154.729', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '21', '-503.643', '140.105', '-154.732', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '20', '-508.214', '116.711', '-154.724', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '19', '-508.595', '93.2001', '-154.737', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '18', '-505.569', '75.4867', '-154.747', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '17', '-487.263', '60.5882', '-156.991', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '16', '-466.135', '39.2224', '-154.748', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '15', '-422.126', '38.1663', '-154.772', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '14', '-401.703', '43.4350', '-154.772', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '13', '-368.341', '79.0285', '-154.758', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '12', '-365.645', '119.526', '-154.743', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '11', '-368.341', '79.0285', '-154.758', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '10', '-401.703', '43.4350', '-154.772', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '9', '-422.1260', '38.1663', '-154.772', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '8', '-466.1350', '39.2224', '-154.748', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '7', '-487.2630', '60.5882', '-156.991', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '6', '-505.5690', '75.4867', '-154.747', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '5', '-508.5950', '93.2001', '-154.737', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '4', '-508.2140', '116.711', '-154.724', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '3', '-503.6430', '140.105', '-154.732', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '2', '-471.3530', '175.991', '-154.729', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30216', '1', '-457.1320', '179.701', '-154.743', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '1', '-559.6890', '73.4061', '-201.944', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '2', '-570.9380', '89.0203', '-202.208', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '3', '-574.2950', '116.139', '-201.952', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '4', '-599.6140', '123.211', '-194.325', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '5', '-612.2780', '124.827', '-182.510', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '6', '-630.2140', '125.405', '-183.879', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '7', '-636.3180', '155.386', '-183.916', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '8', '-630.2140', '125.405', '-183.879', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '9', '-612.5040', '124.834', '-182.299', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '10', '-599.614', '123.211', '-194.325', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '11', '-574.295', '116.139', '-201.952', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '12', '-570.938', '89.0203', '-202.208', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '13', '-559.689', '73.4061', '-201.944', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30215', '14', '-535.605', '76.0671', '-202.052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '1', '-566.9340', '234.459', '-159.428', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '2', '-592.2320', '208.268', '-167.276', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '3', '-612.7010', '189.150', '-174.724', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '4', '-634.2010', '167.707', '-182.916', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '5', '-637.1460', '153.498', '-183.910', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '6', '-633.8070', '125.486', '-183.878', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '7', '-612.5100', '125.177', '-182.301', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '8', '-633.8070', '125.486', '-183.878', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '9', '-637.1460', '153.498', '-183.910', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '10', '-634.201', '167.707', '-182.916', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '11', '-612.701', '189.150', '-174.724', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '12', '-592.232', '208.268', '-167.276', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '13', '-566.934', '234.459', '-159.428', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30214', '14', '-543.783', '214.482', '-156.200', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30271', '1', '-561.4270', '76.2373', '-203.034', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30271', '2', '-582.7910', '73.7128', '-203.104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30271', '3', '-582.2740', '94.3503', '-202.999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30271', '4', '-573.7100', '111.221', '-201.717', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30271', '5', '-583.4010', '134.578', '-202.134', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30271', '6', '-573.0480', '151.098', '-202.146', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30271', '7', '-541.0470', '139.806', '-202.151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30271', '8', '-538.9940', '107.757', '-204.531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30271', '9', '-538.8090', '73.1746', '-201.544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-649.0770', `position_y`='710.2050', `position_z`='-327.0590', `orientation`='2.895050', `spawndist`='0', `MovementType`='2' WHERE `guid`='33496';
UPDATE `creature` SET `modelid`='0', `position_x`='-894.0592', `position_y`='405.4672', `position_z`='-272.5592', `orientation`='1.417478', `spawndist`='0', `MovementType`='2' WHERE `guid`='30391';
UPDATE `creature` SET `modelid`='0', `position_x`='-904.2213', `position_y`='336.9221', `position_z`='-272.5963', `orientation`='4.584696', `spawndist`='0', `MovementType`='2' WHERE `guid`='30305';
UPDATE `creature` SET `modelid`='0', `position_x`='-808.3071', `position_y`='183.8812', `position_z`='-273.0040', `orientation`='4.123109', `spawndist`='0', `MovementType`='2' WHERE `guid`='30193';

DELETE FROM `creature_movement` WHERE `id` IN ('33496', '30391', '30305' , '30193');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('33496', '1', '-663.30800', '713.7870', '-327.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '2', '-692.06200', '721.3770', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '3', '-706.10300', '723.0740', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '4', '-720.18000', '719.2160', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '5', '-732.44200', '712.0680', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '6', '-743.69100', '697.2160', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '7', '-749.65400', '677.4550', '-316.9030', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '8', '-752.93500', '662.6220', '-310.3430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '9', '-757.22900', '647.8000', '-307.2220', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '10', '-759.7940', '636.5920', '-302.2560', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '11', '-757.2290', '647.8000', '-307.2220', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '12', '-752.9350', '662.6220', '-310.3430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '13', '-749.6540', '677.4550', '-316.9030', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '14', '-743.6910', '697.2160', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '15', '-732.4420', '712.0680', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '16', '-720.1800', '719.2160', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '17', '-706.1030', '723.0740', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '18', '-692.0620', '721.3770', '-318.0600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '19', '-663.5100', '713.8370', '-326.9740', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33496', '20', '-636.8360', '706.8630', '-327.0560', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '1', '-892.14360', '417.8634', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '2', '-887.64370', '428.2858', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '3', '-877.64480', '432.0456', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '4', '-849.31000', '428.2421', '-272.5962', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '5', '-821.94430', '424.9467', '-272.6001', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '6', '-800.98810', '421.8573', '-272.5783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '7', '-787.42290', '420.0470', '-272.5783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '8', '-773.02470', '418.0743', '-272.5783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '9', '-787.42290', '420.0470', '-272.5783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '10', '-800.9881', '421.8573', '-272.5783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '11', '-821.9443', '424.9467', '-272.6001', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '12', '-849.3100', '428.2421', '-272.5962', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '13', '-877.3787', '432.1456', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '14', '-887.6437', '428.2858', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '15', '-892.1436', '417.8634', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30391', '16', '-895.8994', '393.5089', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '1', '-907.35240', '312.5346', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '2', '-899.08280', '298.9813', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '3', '-864.20410', '293.0017', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '4', '-840.26840', '288.7963', '-272.6062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '5', '-819.07230', '286.8225', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '6', '-790.82460', '282.7360', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '7', '-819.07230', '286.8225', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '8', '-840.26840', '288.7963', '-272.6062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '9', '-864.20410', '293.0017', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '10', '-899.0828', '298.9813', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '11', '-907.3524', '312.5346', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30305', '12', '-902.4189', '343.3759', '-272.5963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '1', '-814.73320', '174.2685', '-273.0794', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '2', '-814.87340', '139.4458', '-268.7184', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '3', '-813.76310', '103.3383', '-264.7315', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '4', '-804.04550', '95.66667', '-264.7315', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '5', '-773.87590', '95.15134', '-260.5661', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '6', '-762.48710', '83.90037', '-260.5661', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '7', '-773.87590', '95.15134', '-260.5661', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '8', '-804.04550', '95.66667', '-264.7315', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '9', '-813.76310', '103.3383', '-264.7315', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '10', '-814.8734', '139.4458', '-268.7184', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '11', '-814.7332', '174.2685', '-273.0794', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30193', '12', '-809.0435', '185.3519', '-273.0791', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');
-- Fixed equipment of NPC 6228 (Dark Iron Ambassador) in Gnomeregan
-- Thanks @Tobschinski for pointing and researching.
-- This closes #815 
UPDATE `creature_template` SET `EquipmentTemplateId` = 97 WHERE `Entry` = 6228;

SET @GUID := '1306';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-12341.2', `position_y`='-974.5643', `position_z`='12.65743', `orientation`='0.9424778', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, @POINT := @POINT + '1', '-12321.05', '-987.2772', '16.12808', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12313.37', '-996.2144', '20.13345', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12306.59', '-1001.415', '22.94863', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12300.15', '-1003.791', '25.79238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12291.49', '-1005.992', '29.77973', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12279.96', '-1000.789', '32.05903', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12268.35', '-989.6176', '33.70088', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12240.50', '-984.7962', '34.09382', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12268.35', '-989.6176', '33.70088', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12279.96', '-1000.789', '32.05903', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12291.49', '-1005.992', '29.77973', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12300.15', '-1003.791', '25.79238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12306.59', '-1001.415', '22.94863', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12313.37', '-996.2144', '20.13345', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12321.05', '-987.2772', '16.12808', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12340.78', '-974.6990', '12.55402', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @GUID := '849';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-12369.03', `position_y`='-963.8366', `position_z`='12.96514', `orientation`='2.86234', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, @POINT := @POINT + '1', '-12378.64', '-963.5593', '15.38248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12389.11', '-960.6632', '19.12296', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12401.97', '-953.1735', '24.97039', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12410.91', '-950.3997', '28.09881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12415.91', '-942.5346', '28.71722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12422.45', '-930.7582', '30.86085', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12434.33', '-915.7142', '35.59836', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12448.60', '-909.0048', '38.77024', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12434.33', '-915.7142', '35.59836', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12422.45', '-930.7582', '30.86085', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12415.91', '-942.5346', '28.71722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12410.91', '-950.3997', '28.09881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12401.97', '-953.1735', '24.97039', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12389.11', '-960.6632', '19.12296', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12378.64', '-963.5593', '15.38248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12369.52', '-963.8800', '12.91348', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @GUID := '856';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-12351.79', `position_y`='-969.2394', `position_z`='13.14888', `orientation`='1.186824', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, @POINT := @POINT + '1', '-12330.23', '-933.8550', '9.336789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12309.27', '-908.3401', '8.683623', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12287.81', '-885.9284', '7.722762', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12271.64', '-855.5601', '7.959990', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12256.04', '-815.6573', '9.877749', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12246.84', '-791.1014', '12.51553', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12256.04', '-815.6573', '9.877749', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12271.64', '-855.5601', '7.959990', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12287.81', '-885.9284', '7.722762', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12309.27', '-908.3401', '8.683623', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12330.23', '-933.8550', '9.336789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-12351.40', '-968.9998', '13.03302', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @ENTRY := '14488';
SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@ENTRY);
SET @POINT := '0';

-- Roloch [38]
UPDATE `creature_template` SET `Speedwalk`=('2.5' / '2.5'), `DamageMultiplier`='1.3', `MinMeleeDmg`='73.7', `MaxMeleeDmg`='97.8', `Armor`='1709', `MeleeAttackPower`='128', `RangedAttackPower`='13', `MeleeBaseAttackTime`='2800', `RangedBaseAttackTime`='2800', `AIName`='EventAI' WHERE `Entry`=@ENTRY;

UPDATE `creature` SET `modelid`='0', `position_x`='-12496.88', `position_y`='-163.6306', `position_z`='12.26969', `orientation`='3.635170', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_ai_scripts` WHERE `id`=1448801;
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
(CONCAT(@ENTRY, '01'), @ENTRY, '0', '0', '100', '1', '7000', '14000', '7000', '14000', '11', '15496', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Roloch - Cleave');

DELETE FROM `creature` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry` BETWEEN @ENTRY AND @ENTRY+31;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@ENTRY, @POINT := @POINT + '1', '-12509.24', '-169.3584', '11.97151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12517.81', '-151.9920', '12.55066', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12520.71', '-121.9006', '13.81736', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12506.26', '-100.3154', '15.06858', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12484.21', '-94.93457', '18.61782', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12472.33', '-116.4159', '14.55938', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12447.72', '-132.1725', '17.05216', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12444.22', '-144.0639', '14.61893', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12430.79', '-151.8704', '15.33278', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12405.83', '-143.3987', '15.71681', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12369.73', '-148.3589', '13.59375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12352.67', '-147.9736', '15.89757', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12342.42', '-143.9570', '17.21934', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12308.82', '-132.3484', '17.78255', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12272.64', '-157.2983', '14.69838', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12242.79', '-196.4817', '16.10491', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12272.64', '-157.2983', '14.69838', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12308.82', '-132.3484', '17.78255', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12342.29', '-143.8990', '17.11802', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12352.67', '-147.9736', '15.89757', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12369.73', '-148.3589', '13.59375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12405.83', '-143.3987', '15.71681', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12430.79', '-151.8704', '15.33278', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12444.22', '-144.0639', '14.61893', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12447.72', '-132.1725', '17.05216', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12472.33', '-116.4159', '14.55938', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12484.21', '-94.93457', '18.61782', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12506.26', '-100.3154', '15.06858', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12520.71', '-121.9006', '13.81736', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12517.81', '-151.9920', '12.55066', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12509.24', '-169.3584', '11.97151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '-12497.74', '-163.8600', '12.31627', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');
-- Fixed NPC 15611 (Cenarion Scout Jalia) not giving Hive'Ashi scout report to players on the quest
-- Thanks @yyhhrr for reporting. This closes https://github.com/cmangos/issues/issues/856
UPDATE `gossip_menu_option` SET `condition_id` = 1111 WHERE `menu_id` = 6691 AND `id` = 0;
-- q.5321 'The Sleeper Has Awakened'
DELETE FROM dbscripts_on_quest_start WHERE id = 5321;
INSERT INTO dbscripts_on_quest_start (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(5321,1,16,6209,2,0,0,0,0,0,0,0,0,0,0,0,'');
UPDATE quest_template SET StartScript = 5321 WHERE entry = 5321;
-- Kerlonian Evershade <Druid of the Claw>
DELETE FROM creature_template_addon WHERE entry = 11218;
INSERT INTO creature_template_addon VALUES
(11218, 0, 3, 1, 1, 0, 0, NULL);
-- Added missing script for quest 3821 (Dreadmaul Rock)
-- The quest is now completable. Thanks @cooler-SAI for reporting.
-- Added missing equipment to NPC 9136 (Sha'ni Proudtusk) in Burning Steppes
-- This closes #817

-- Script when using Sha'ni remains
UPDATE `gossip_menu` SET `script_id` = 2211 WHERE `entry` = 2211;
DELETE FROM `dbscripts_on_gossip` WHERE `id` = 2211;
INSERT INTO `dbscripts_on_gossip` VALUES
(2211, 1, 10, 9136, 60000, 0, 0, 0, 0, 0, 0, 0, -7917.38, -2610.53, 221.123, 5.04026, ''),
(2211, 0, 27, 4, 0, 160445, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(2211, 61, 27, 8, 0, 160445, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- Added missing equipment to NPC 9136 (Sha'ni Proudtusk)
UPDATE `creature_template` SET `EquipmentTemplateId` = 614 WHERE `Entry` = 9136;
-- Fixed quest 1713 (The Summoning): it was using an outdated script
-- preventing the required NPC to be summoned and thus breaking the quest
-- Thanks @RichardGe for pointing and helping. This closes #818

UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` = 6176;
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 6176;

DELETE FROM `creature_movement_template` WHERE `entry` = 6176;
INSERT INTO `creature_movement_template` VALUES
(6176, 1, 250.84, -1470.58, 55.4491, 0, 617601, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 2, 253.05, -1459.09, 52.09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 3, 256.87, -1440.35, 50.09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 4, 273.74, -1433.18, 50.29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 5, 297.77, -1436.7, 46.96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 6, 329.59, -1442.08, 40.31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 7, 332.73, -1455.6, 42.24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 8, 323.83, -1468.92, 42.24, 0, 617608, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 9, 332.73, -1455.6, 42.24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 10, 329.59, -1442.08, 40.31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 11, 297.77, -1436.7, 46.96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 12, 273.74, -1433.18, 50.29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 13, 256.87, -1440.35, 50.09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(6176, 14, 253.05, -1459.09, 52.09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 1713;
INSERT INTO `dbscripts_on_quest_start` VALUES
(1713,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,'unpause WP movement'),
(1713, 1, 0, 0, 0, 0, 0, 0, 2000000029, 0, 0, 0, 0, 0, 0, 0, ''),
(1713,1,29,2,2,0,0,0,0,0,0,0,0,0,0,0,'npcFlags removed');

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` IN (617601, 617608);
INSERT INTO `dbscripts_on_creature_movement` VALUES
(617601,0,32,1,0,0,0,0,0,0,0,0,0,0,0,0,'pause WP movement'),
(617601,1,29,2,1,0,0,0,0,0,0,0,0,0,0,0,'npcFlags added'),
(617601,1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.39626, ''),
(617608,0,32,1,0,0,0,0,0,0,0,0,0,0,0,0,'pause WP movement'),
(617608,1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.8, ''),
(617608, 2, 0, 2, 0, 0, 0, 0, 2000000043, 0, 0, 0, 0, 0, 0, 0, ''),
(617608, 2, 15, 8606, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'cast summon cyclonian'),
(617608,14,32,0,0,0,0,0,0,0,0,0,0,0,0,0,'unpause WP movement');


-- ADDITIONAL FIXES
-- for issues caused by the above and the previous mass update

-- These creatures do not have scripts
UPDATE creature_template SET `AIName` = '' WHERE `Entry` IN (15776, 15796);

-- missing record (details taken from One)
DELETE FROM creature WHERE guid = 45820;
INSERT INTO creature (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('45820', '9268', '229', '7803', '0', '-41.031', '-514.179', '88.564', '4.205', '10800', '0', '0', '8355', '6723', '0', '2');

-- Relates to an creature_template entry (16592) that does not exist in Classic
DELETE FROM spell_script_target WHERE entry = 28861;

-- This was using the incorrect model ID
-- Copied the ones used in One
UPDATE creature_template SET `ModelId1`='1955', `ModelId2`='0', `ModelId3`='1955' WHERE `Entry`='8927';

-- missing records (details taken from One)
DELETE FROM creature WHERE guid IN (23683, 23696, 29117, 29119, 48962);
INSERT INTO  creature (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('23683', '5431', '1', '7114', '0', '-10018.7', '-3585.39', '0.529975', '4.33624', '300', '15', '0', '2577', '0', '0', '1');
INSERT INTO  creature (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('23696', '5431', '1', '7114', '0', '-10184.7', '-3955.52', '5.25584', '4.08735', '300', '15', '0', '2577', '0', '0', '1');
INSERT INTO  creature (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('29117', '12245', '1', '1159', '0', '-692.743', '1522.2', '90.3611', '0.558505', '300', '0', '0', '503', '0', '0', '0');
INSERT INTO  creature (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('29119', '12246', '1', '1159', '0', '-1926.6', '2412.79', '60.6956', '0.174533', '300', '0', '0', '1600', '0', '0', '0');
INSERT INTO  creature (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('48962', '10482', '289', '7550', '0', '183.088', '175.167', '109.701', '0.506145', '7200', '0', '0', '4000', '0', '0', '0');


-- Current health setting was too low
UPDATE creature SET curhealth = 420 WHERE id = 2181;
UPDATE creature SET curhealth = 199 WHERE id = 2234;
UPDATE creature SET curhealth = 2900 WHERE id = 3673;
UPDATE creature SET curhealth = 4640 WHERE id = 6228;
UPDATE creature SET curhealth = 3678 WHERE id = 6910;
UPDATE creature SET curhealth = 1541 WHERE id = 10481;
UPDATE creature SET curhealth = 2099 WHERE id = 10485;
UPDATE creature SET curhealth = 7700 WHERE id = 10917;
UPDATE creature SET curhealth = 2284 WHERE id = 12245;
UPDATE creature SET curhealth = 2100 WHERE id = 12246;
UPDATE creature SET curhealth = 4356 WHERE id = 11277;
UPDATE creature SET curhealth = 3748 WHERE id = 11281;
UPDATE creature SET curhealth = 64 WHERE id = 11282;
UPDATE creature SET curhealth = 64 WHERE id = 11283;
UPDATE creature SET curhealth = 2192 WHERE id = 11287;
UPDATE creature SET curhealth = 14000 WHERE id = 11466;
UPDATE creature SET curhealth = 8733 WHERE id = 11551;
UPDATE creature SET curhealth = 2284 WHERE id = 12245;
UPDATE creature SET curhealth = 2100 WHERE id = 12246;
UPDATE creature SET curhealth = 6900 WHERE id = 14022;
UPDATE creature SET curhealth = 6300 WHERE id = 14025;
UPDATE creature SET curhealth = 1332400 WHERE id = 15589;
UPDATE creature SET curhealth = 6662000 WHERE id = 15928;
UPDATE creature SET curhealth = 3198000 WHERE id = 15990;

-- Current mana setting was too low
UPDATE creature SET curmana = 1236 WHERE id = 4847;
UPDATE creature SET curmana = 1432 WHERE id = 4848;
UPDATE creature SET curmana = 1432 WHERE id = 4853;
UPDATE creature SET curmana = 1926 WHERE id = 6228;
UPDATE creature SET curmana = 1283 WHERE id = 7030;
UPDATE creature SET curmana = 9476 WHERE id = 11484;

-- creature does not move, therefore spawndist must be 0
UPDATE creature SET spawndist = 0 WHERE guid = 30122;
UPDATE creature SET spawndist = 0 WHERE guid = 30130;
UPDATE creature SET spawndist = 0 WHERE guid = 30206;
UPDATE creature SET spawndist = 0 WHERE guid = 30251;
UPDATE creature SET spawndist = 0 WHERE guid = 30257;
UPDATE creature SET spawndist = 0 WHERE guid = 30309;
UPDATE creature SET spawndist = 0 WHERE guid = 30332;
UPDATE creature SET spawndist = 0 WHERE guid = 31982;
UPDATE creature SET spawndist = 0 WHERE guid = 33432;
UPDATE creature SET spawndist = 0 WHERE guid = 33495;
UPDATE creature SET spawndist = 0 WHERE guid = 40659;
UPDATE creature SET spawndist = 0 WHERE guid = 40665;
UPDATE creature SET spawndist = 0 WHERE guid = 79129;
UPDATE creature SET spawndist = 0 WHERE guid = 79131;
UPDATE creature SET spawndist = 0 WHERE guid = 79134;
UPDATE creature SET spawndist = 0 WHERE guid = 79172;
UPDATE creature SET spawndist = 0 WHERE guid = 79180;
UPDATE creature SET spawndist = 0 WHERE guid = 79182;
UPDATE creature SET spawndist = 0 WHERE guid = 79184;
UPDATE creature SET spawndist = 0 WHERE guid = 79194;

-- not lootable
UPDATE creature_template SET LootId = 0 WHERE entry IN (5776, 5777, 5778, 15773);
UPDATE creature_template SET PickpocketLootId = 0 WHERE entry IN (5776, 5777, 5778, 15773);

-- invalid aura for this NPC
DELETE FROM creature_template_addon WHERE entry IN (17048, 17049);


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
                SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurResult AS `===== Found Version =====`;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;
