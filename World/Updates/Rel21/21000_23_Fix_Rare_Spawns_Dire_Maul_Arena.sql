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
