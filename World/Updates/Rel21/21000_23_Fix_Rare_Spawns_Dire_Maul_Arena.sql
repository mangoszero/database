-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

  -- old revision
  SET @cOldRev := '21.1.0';

  -- Set the new revision string
  SET @cNewRev := '21.1.0';

  -- Set thisRev to the one in db_version in the currently selected database
  SELECT CONCAT(`version`, ".",`structure`, ".", `content`) INTO @cThisRev FROM `db_version`;

  -- Only Proceed if the old values match
  IF @cThisRev = @cOldRev THEN

  -- Set description and comment
  SET @cDescription := 'rare_elites_dm_arena';
  SET @cComment := '';

    -- Make this all a single transaction
    START TRANSACTION;

    -- version
    -- TRUNCATE `db_version`;
    -- INSERT IGNORE INTO `db_version` VALUES (21, 1, 1, @cDescription, @cComment);

    -- -- -- -- Normal Update / Insert / Delete statements will go here  -- -- -- -- --
  
        -- Correct some attributes & make 3 rare elites spawn in Dire Maul Arena 
        REPLACE INTO `creature_template` VALUES (11447, 'Mushgog', NULL, 60, 60, 14382, 0, 14, 14, 0, 0, 4, 1, 1, 0, 0, 0, 0, 0, 0, 3.58, 1.14286, 1, 2, 20, 0, 1, 1, 1, 1, 61040, 61040, 0, 0, 571, 737, 61.732, 84.8815, 0, 302, 100, 1150, 1265, 0, 168, 838, 0, 0, 0, 0, 0, 8395857, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI');
        REPLACE INTO `creature_template` VALUES (11497, 'The Razza', NULL, 60, 60, 10807, 0, 14, 14, 0, 0, 1, 4, 3, 0, 0, 0, 0, 0, 0, 1.79, 1.14286, 2, 2, 30, 10, 1, 1, 1, 1, 73260, 73260, 24340, 24340, 571, 737, 61.732, 84.8815, 0, 302, 100, 1150, 1265, 0, 168, 838, 0, 0, 0, 0, 0, 8395857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI');
        REPLACE INTO `creature_template` VALUES (11498, 'Skarr the Unbreakable', NULL, 58, 58, 10169, 0, 14, 14, 0, 0, 7, 1, 1, 0, 0, 0, 0, 0, 0, 3.58, 1.14286, 1, 2, 20, 0, 1, 1, 1, 1, 57420, 57420, 0, 0, 380, 491, 61.732, 84.8815, 0, 201, 100, 1150, 1265, 0, 168, 838, 0, 0, 0, 0, 0, 8395857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI');

        INSERT INTO `creature` VALUES (590013, 11447, 1, 0, 0, -3755.33, 1094.43, 131.969, 3.11817, 21600, 10, 0, 61040, 0, 0, 1);
        INSERT INTO `creature` VALUES (590014, 11497, 1, 0, 0, -3755.33, 1094.43, 131.969, 3.11817, 21600, 10, 0, 73260, 24340, 0, 1);
        INSERT INTO `creature` VALUES (590015, 11498, 1, 0, 0, -3755.33, 1094.43, 131.969, 3.11817, 21600, 10, 0, 57420, 0, 0, 1);

        INSERT INTO `pool_template` VALUES (1701, 1, 'Dire Maul Arena - Rare Elites');

        INSERT INTO `pool_creature` VALUES (590013, 1701, 0, 'Dire Maul Arena - Mushgog');
        INSERT INTO `pool_creature` VALUES (590014, 1701, 0, 'Dire Maul Arena - The Razza');
        INSERT INTO `pool_creature` VALUES (590015, 1701, 0, 'Dire Maul Arena - Skarr the Unbreakable');  

        -- Loot tables
        -- Mushgog loot table
        INSERT INTO `creature_loot_template` VALUES (11447, 765, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 1973, 1.58, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 2453, 1.58, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 3818, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 3946, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 3947, 1.58, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 3951, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 3994, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 4625, 1.58, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 4696, 11.12, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 5267, 2.38, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 5759, 1.58, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 6622, 5.56, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 8754, 1.58, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 8766, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 8838, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 8839, 1.58, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 8846, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 8948, 1.58, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 9402, 0.019, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 10286, 14.28, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 10309, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13000, 3.96, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13001, 2.38, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13002, 7.14, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13004, 2.38, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13006, 4.76, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13007, 7.94, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13023, 2.38, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13028, 4.76, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13047, 0.8, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13053, 8.74, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13060, 21.42, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13070, 7.94, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13072, 7.94, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13075, 2.38, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13083, 2.38, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13096, 15.88, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13101, 9.52, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13107, 3.18, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13116, 10.32, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13123, 0.8, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13133, 1.58, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13135, 4.76, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13146, 1.58, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13446, 5.56, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13463, 8.74, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13465, 3.18, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13468, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13817, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 13824, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 14498, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 14862, 1.58, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 14977, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 15194, 0.8, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11447, 15282, 0.8, 2, 1, 1, 0);

        -- The Razza loot table
        INSERT INTO `creature_loot_template` VALUES (11497, 1973, 2.1, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 4500, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 4696, 8.72, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 5267, 4.06, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 5759, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 6622, 3.88, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 7909, 0.26, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 7910, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 9402, 4.48, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 11979, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 12036, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13000, 7.08, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13001, 16.56, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13002, 11.56, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13004, 3.54, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13006, 4.82, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13007, 4.82, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13015, 17.86, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13023, 3.02, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13028, 21.3, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13047, 2.58, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13053, 19.92, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13060, 17.24, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13070, 2.58, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13072, 22, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13075, 4.58, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13083, 6.56, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13096, 16.22, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13101, 10.7, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13107, 5.7, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13113, 3.44, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13116, 21.48, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13123, 3.88, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13133, 19.4, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13135, 10.86, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13146, 3.36, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13463, 0.18, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13464, 0.18, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 13468, 0.18, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14317, 0.6, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14323, 0.18, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14325, 0.18, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14330, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14455, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14465, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14498, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14800, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14862, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14863, 0.78, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 14969, 0.26, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15193, 0.18, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15272, 0.18, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15282, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15288, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15325, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15431, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15433, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15660, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15664, 0.34, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15665, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15672, 0.18, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15674, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15675, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15683, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11497, 15986, 0.34, 2, 1, 1, 0);

        -- Skarr the Unbreakable loot table
        INSERT INTO `creature_loot_template` VALUES (11498, 1973, 15.14, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3944, 0.28, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3945, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3946, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3947, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3948, 0.28, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3950, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3951, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3970, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3971, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3972, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3973, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3975, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3987, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3990, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3992, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3994, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3995, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3997, 0.42, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 3998, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 4500, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 4696, 17.9, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 5267, 1.64, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 5759, 0.92, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 6622, 1.42, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 7909, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 7910, 0.28, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 8083, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 8086, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 8752, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 8766, 2.34, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 8952, 4.04, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 9402, 0.11, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 10305, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 10306, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 10307, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 10308, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 10309, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 11978, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 12695, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13000, 4.48, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13001, 5.48, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13002, 21.1, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13004, 7.04, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13006, 3.7, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13007, 8.24, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13015, 6.32, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13023, 1.14, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13028, 8.88, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13036, 3.12, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13044, 3.62, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13047, 6.26, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13053, 17.48, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13060, 17.84, 0, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13070, 8.24, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13072, 19.18, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13075, 1.28, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13077, 3.06, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13083, 6.26, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13091, 3.12, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13096, 16.34, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13101, 19.76, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13107, 5.18, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13113, 1.2, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13116, 5.76, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13118, 3.26, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13123, 4.2, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13133, 7.82, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13135, 17.12, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13146, 9.1, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13444, 0.56, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13446, 0.78, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13463, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13464, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13465, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13816, 0.28, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13817, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13818, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13819, 0.28, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13820, 0.36, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13822, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13823, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13824, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 13825, 1.2, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14047, 23.52, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14305, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14310, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14314, 0.28, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14320, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14327, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14457, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14458, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14492, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14494, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14499, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14508, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14676, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14677, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14683, 0.36, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14684, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14800, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14854, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14865, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14932, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14969, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 14971, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15179, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15192, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15239, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15256, 0.22, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15265, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15266, 0.36, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15276, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15282, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15426, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15434, 0.08, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15674, 0.28, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15681, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 15746, 0.14, 2, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 18335, 0.08, 1, 1, 1, 0);
        INSERT INTO `creature_loot_template` VALUES (11498, 19284, 0.08, 1, 1, 1, 0);

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
