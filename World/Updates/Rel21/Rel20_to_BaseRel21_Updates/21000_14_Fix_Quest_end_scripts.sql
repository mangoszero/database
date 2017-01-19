-- -----------------------------------
-- Added to prevent timeout's while loading
-- -----------------------------------
SET GLOBAL net_read_timeout=30;
SET GLOBAL net_write_timeout=60;
SET GLOBAL net_buffer_length=1000000; 
SET GLOBAL max_allowed_packet=1000000000;
SET GLOBAL connect_timeout=10000000;

-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

  SET @cOldRev = 'required_21000_13_Backports'; 

  -- Set the new revision string
  SET @cNewRev = 'required_21000_14_Fix_quest_end_scripts';

  -- Set thisRevision to the column name of db_version in the currently selected database
  SET @cThisRev := ((SELECT column_name FROM information_schema.`COLUMNS` WHERE table_name='db_version' AND table_schema=(SELECT DATABASE() AS thisDB FROM DUAL) AND column_name LIKE 'required%'));

  -- Set friendly Version Text
  SET @cThisVersion = 'MaNGOSZero Database Rev 21000_14';
 
  -- Only Proceed if the old values match
  IF @cThisRev = @cOldRev THEN
    -- Make this all a single transaction
    START TRANSACTION;

    -- Apply the Version Change from Old Version to New Version
    SET @query = CONCAT('ALTER TABLE db_version CHANGE COLUMN ',@cOldRev, ' ' ,@cNewRev,' bit;');
    PREPARE stmt1 FROM @query;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;
    -- The Above block is required for making table changes
    
    INSERT IGNORE INTO `db_version` SET `Version` = @cThisVersion;

    -- If this is purely an incremental update, include this line
    SET @cNewRev = @cThisVersion;

    -- -- -- -- Normal Update / Insert / Delete statements will go here  -- -- -- -- --

-- This will fix t he wrong text and emotes from Quest 756 and 771
	
DELETE FROM `db_script_string` WHERE entry = 2000005800;
DELETE FROM `db_script_string` WHERE entry = 2000005801;
INSERT INTO `db_script_string` VALUES('2000005800','%s enters a trance...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','2','0','1',NULL);
INSERT INTO `db_script_string` VALUES('2000005801','%s I have created the totem. You, %n, must cleanse the well.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','3','1',NULL);
DELETE FROM `dbscripts_on_quest_end` WHERE id = 756;
INSERT INTO `dbscripts_on_quest_end` VALUES('756','8','0','0','3','0','0','0','2000005801','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('756','0','15','4983','0','0','0','0','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('756','0','0','0','0','0','0','0','2000005800','0','0','0','0','0','0','0','');
-- scripted the quest end script for quest 771 Rite of vision
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 771;
INSERT INTO `dbscripts_on_quest_end` VALUES (771,0,15,5026,0,0,0,0,0,0,0,0,0,0,0,0,'Cast Water of seers');
INSERT INTO `dbscripts_on_quest_end` VALUES (771,0,0,2,0,0,0,0,2000005802,0,0,0,0,0,0,0,'Text emote');
INSERT INTO `dbscripts_on_quest_end` VALUES (771,8,0,0,3,0,0,0,2000005803,0,0,0,0,0,0,0,'Zarlman Say');
DELETE FROM `db_script_string` WHERE `entry` = 2000005802;
DELETE FROM `db_script_string` WHERE `entry` = 2000005803;
INSERT INTO `db_script_string` VALUES (2000005802,"Zarlman Two-Moons begins chanting as he mixes the well stones and ambercom before the Tribal Fire.",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,NULL);
INSERT INTO `db_script_string` VALUES (2000005803,"The Water of the Seers is ready for your consumption, $N.",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,3,0,NULL);
UPDATE `db_script_string` SET content_default = "%s begins a spell of summoning..." WHERE entry = 2000000043;

-- This will fix most of quest 5203, added missing waypoints and texts, also added correct gossip menus for captured arko´narin.
-- Equipment was added to arko´narin
-- more corrections will follow as SD2 updates are needed and a spawn group is still missing.

INSERT INTO script_texts (entry,content_default,sound,TYPE,LANGUAGE,emote,COMMENT) VALUES
(-1001148,'I am ready, $N. Let\'s find my equipment and get out of here. I think I know where it is.',0,0,0,1,'captured arko\'narin SAY_ESCORT_START'),
(-1001149,'Oh my! Look at this... all these candles. I\'m sure they\'re used for some terrible ritual or dark summoning. We best make haste.',0,0,0,18,'captured arko\'narin SAY_FIRST_STOP'),
(-1001150,'There! Over there!',0,0,0,25,'captured arko\'narin SAY_SECOND_STOP'),
(-1001151,'You will not stop me from escaping here, $N!',0,0,0,0,'captured arko\'narin SAY_AGGRO'),
(-1001152,'All I need now is a golden lasso.',0,0,0,0,'captured arko\'narin SAY_EQUIPMENT'),
(-1001153,'DIE DEMON DOGS!',0,0,0,0,'captured arko\'narin SAY_ESCAPE'),
(-1001154,'Ah! Fresh air at last! I never thought I\'d see the day.',0,0,0,4,'captured arko\'narin SAY_FRESH_AIR'),
(-1001155,'BETRAYER!',0,1,0,0,'spirit of trey lightforge SAY_BETRAYER'),
(-1001156,'What was that?! Trey? TREY?',0,0,0,22,'captured arko\'narin SAY_TREY'),
(-1001157,'You kept me in the cell for too long, monster!',0,0,0,0,'captured arko\'narin SAY_ATTACK_TREY'),
(-1001158,'No! My friend... what\'s happened? This is all my fault...',0,0,0,18,'captured arko\'narin SAY_ESCORT_COMPLETE');

DELETE FROM script_waypoint WHERE entry=11016;
INSERT INTO script_waypoint VALUES
(11016, 0, 5004.985, -440.237, 319.059, 4000, 'SAY_ESCORT_START'),
(11016, 1, 4992.224, -449.964, 317.057, 0, ''),
(11016, 2, 4988.549, -457.438, 316.289, 0, ''),
(11016, 3, 4989.978, -464.297, 316.846, 0, ''),
(11016, 4, 4994.038, -467.754, 318.055, 0, ''),
(11016, 5, 5002.307, -466.318, 319.965, 0, ''),
(11016, 6, 5011.801, -462.889, 321.501, 0, ''),
(11016, 7, 5020.533, -460.797, 321.970, 0, ''),
(11016, 8, 5026.836, -463.171, 321.345, 0, ''),
(11016, 9, 5028.663, -476.805, 318.726, 0, ''),
(11016, 10, 5029.503, -487.131, 318.179, 0, ''),
(11016, 11, 5031.178, -497.678, 316.533, 0, ''),
(11016, 12, 5032.720, -504.748, 314.744, 0, ''),
(11016, 13, 5034.997, -513.138, 314.372, 0, ''),
(11016, 14, 5037.493, -521.733, 313.221, 6000, 'SAY_FIRST_STOP'),
(11016, 15, 5049.055, -519.546, 313.221, 0, ''),
(11016, 16, 5059.170, -522.930, 313.221, 0, ''),
(11016, 17, 5062.755, -529.933, 313.221, 0, ''),
(11016, 18, 5063.896, -538.827, 313.221, 0, ''),
(11016, 19, 5062.223, -545.635, 313.221, 0, ''),
(11016, 20, 5061.690, -552.333, 313.101, 0, ''),
(11016, 21, 5060.333, -560.349, 310.873, 0, ''),
(11016, 22, 5055.621, -565.541, 308.737, 0, ''),
(11016, 23, 5049.803, -567.604, 306.537, 0, ''),
(11016, 24, 5043.011, -564.946, 303.682, 0, ''),
(11016, 25, 5038.221, -559.823, 301.463, 0, ''),
(11016, 26, 5039.456, -548.675, 297.824, 0, ''),
(11016, 27, 5043.437, -538.807, 297.801, 0, ''),
(11016, 28, 5056.397, -528.954, 297.801, 0, ''),
(11016, 29, 5064.397, -521.904, 297.801, 0, ''),
(11016, 30, 5067.616, -512.999, 297.196, 0, ''),
(11016, 31, 5065.990, -505.329, 297.214, 0, ''),
(11016, 32, 5062.238, -499.086, 297.448, 0, ''),
(11016, 33, 5065.087, -492.069, 298.054, 0, ''),
(11016, 34, 5071.195, -491.173, 297.666, 0, ''),
(11016, 35, 5087.474, -496.478, 296.677, 5000, 'SAY_SECOND_STOP'),
(11016, 36, 5095.552, -508.639, 296.677, 0, ''),
(11016, 37, 5104.300, -521.014, 296.677, 0, ''),
(11016, 38, 5110.132, -532.123, 296.677, 4000, 'open equipment chest'),
(11016, 39, 5110.132, -532.123, 296.677, 4000, 'cast SPELL_STRENGHT_ARKONARIN'),
(11016, 40, 5110.132, -532.123, 296.677, 4000, 'SAY_EQUIPMENT'),
(11016, 41, 5110.132, -532.123, 296.677, 0, 'SAY_ESCAPE'),
(11016, 42, 5099.748, -510.823, 296.677, 0, ''),
(11016, 43, 5091.944, -497.516, 296.677, 0, ''),
(11016, 44, 5079.375, -486.811, 297.638, 0, ''),
(11016, 45, 5069.212, -488.770, 298.082, 0, ''),
(11016, 46, 5064.242, -496.051, 297.275, 0, ''),
(11016, 47, 5065.084, -505.239, 297.361, 0, ''),
(11016, 48, 5067.818, -515.245, 297.125, 0, ''),
(11016, 49, 5064.617, -521.170, 297.801, 0, ''),
(11016, 50, 5053.221, -530.739, 297.801, 0, ''),
(11016, 51, 5045.725, -538.311, 297.801, 0, ''),
(11016, 52, 5039.695, -548.112, 297.801, 0, ''),
(11016, 53, 5038.778, -557.588, 300.787, 0, ''),
(11016, 54, 5042.014, -566.749, 303.838, 0, ''),
(11016, 55, 5050.555, -568.149, 306.782, 0, ''),
(11016, 56, 5056.979, -564.674, 309.342, 0, ''),
(11016, 57, 5060.791, -556.801, 311.936, 0, ''),
(11016, 58, 5059.581, -551.626, 313.221, 0, ''),
(11016, 59, 5062.826, -541.994, 313.221, 0, ''),
(11016, 60, 5063.554, -531.288, 313.221, 0, ''),
(11016, 61, 5057.934, -523.088, 313.221, 0, ''),
(11016, 62, 5049.471, -519.360, 313.221, 0, ''),
(11016, 63, 5040.789, -519.809, 313.221, 0, ''),
(11016, 64, 5034.299, -515.361, 313.948, 0, ''),
(11016, 65, 5032.001, -505.532, 314.663, 0, ''),
(11016, 66, 5029.915, -495.645, 316.821, 0, ''),
(11016, 67, 5028.871, -487.000, 318.179, 0, ''),
(11016, 68, 5028.109, -475.531, 318.839, 0, ''),
(11016, 69, 5027.759, -465.442, 320.643, 0, ''),
(11016, 70, 5019.955, -460.892, 321.969, 0, ''),
(11016, 71, 5009.426, -464.793, 321.248, 0, ''),
(11016, 72, 4999.567, -468.062, 319.426, 0, ''),
(11016, 73, 4992.034, -468.128, 317.894, 0, ''),
(11016, 74, 4988.168, -461.293, 316.369, 0, ''),
(11016, 75, 4990.624, -447.459, 317.104, 0, ''),
(11016, 76, 4993.475, -438.643, 318.272, 0, ''),
(11016, 77, 4995.451, -430.178, 318.462, 0, ''),
(11016, 78, 4993.564, -422.876, 318.864, 0, ''),
(11016, 79, 4985.401, -420.864, 320.205, 0, ''),
(11016, 80, 4976.515, -426.168, 323.112, 0, ''),
(11016, 81, 4969.832, -429.755, 325.029, 0, ''),
(11016, 82, 4960.702, -425.440, 325.834, 0, ''),
(11016, 83, 4955.447, -418.765, 327.433, 0, ''),
(11016, 84, 4949.702, -408.796, 328.004, 0, ''),
(11016, 85, 4940.017, -403.222, 329.956, 0, ''),
(11016, 86, 4934.982, -401.475, 330.898, 0, ''),
(11016, 87, 4928.693, -399.302, 331.744, 0, ''),
(11016, 88, 4926.935, -398.436, 333.079, 0, ''),
(11016, 89, 4916.163, -393.822, 333.729, 0, ''),
(11016, 90, 4908.393, -396.217, 333.217, 0, ''),
(11016, 91, 4905.610, -396.535, 335.050, 0, ''),
(11016, 92, 4897.876, -395.245, 337.346, 0, ''),
(11016, 93, 4895.206, -388.203, 339.295, 0, ''),
(11016, 94, 4896.945, -382.429, 341.040, 0, ''),
(11016, 95, 4901.885, -378.799, 342.771, 0, ''),
(11016, 96, 4908.087, -380.635, 344.597, 0, ''),
(11016, 97, 4911.910, -385.818, 346.491, 0, ''),
(11016, 98, 4910.104, -393.444, 348.798, 0, ''),
(11016, 99, 4903.500, -396.947, 350.812, 0, ''),
(11016, 100, 4898.083, -394.226, 351.821, 0, ''),
(11016, 101, 4891.333, -393.436, 351.801, 0, ''),
(11016, 102, 4881.203, -395.211, 351.590, 0, ''),
(11016, 103, 4877.843, -395.536, 349.713, 0, ''),
(11016, 104, 4873.972, -394.919, 349.844, 5000, 'SAY_FRESH_AIR'),
(11016, 105, 4873.972, -394.919, 349.844, 3000, 'SAY_BETRAYER'),
(11016, 106, 4873.972, -394.919, 349.844, 2000, 'SAY_TREY'),
(11016, 107, 4873.972, -394.919, 349.844, 0, 'SAY_ATTACK_TREY'),
(11016, 108, 4873.972, -394.919, 349.844, 5000, 'SAY_ESCORT_COMPLETE'),
(11016, 109, 4873.972, -394.919, 349.844, 1000, ''),
(11016, 110, 4863.016, -394.521, 350.650, 0, ''),
(11016, 111, 4848.696, -397.612, 351.215, 0, '');

UPDATE creature_template SET EquipmentTemplateId = 1248 WHERE entry = 11018;
UPDATE quest_template SET SpecialFlags = 2 WHERE entry = 5203;
UPDATE creature_template SET ExtraFlags = 0 WHERE entry = 11016;
UPDATE creature_template SET FactionAlliance = 250 WHERE entry = 11018;
UPDATE creature_template SET FactionHorde = 250 WHERE entry = 11018;

DELETE FROM conditions WHERE condition_entry = 340;
DELETE FROM conditions WHERE condition_entry = 341;
INSERT INTO conditions VALUES (340, 8, 5202, 0);
INSERT INTO conditions VALUES (341, 8, 5203, 0);
UPDATE gossip_menu SET condition_id = 340 WHERE text_id = 4113;
DELETE FROM gossip_menu WHERE text_id = 4114;
INSERT INTO gossip_menu VALUES(3129, 4114, 0, 341); 

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    
    -- If we get here ok, commit the changes
    IF bRollback = TRUE THEN
      ROLLBACK;
      SELECT '* UPDATE FAILED *' AS 'Status',@cThisRev AS 'DB is on Version';
    ELSE
      COMMIT;
      SELECT '* UPDATE COMPLETE *' AS 'Status',@cNewRev AS 'DB is now on Version';
    END IF;
  ELSE
    SELECT '* UPDATE SKIPPED *' AS 'Status',@cOldRev AS 'Required Version',@cThisRev AS 'Found Version';
  END IF;

END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;
