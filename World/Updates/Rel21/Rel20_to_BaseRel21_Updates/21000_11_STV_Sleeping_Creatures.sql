-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

  SET @cOldRev = 'required_21000_10_warden_multiversion';

  -- Set the new revision string
  SET @cNewRev = 'required_21000_11_STV_Sleeping_Creatures';

  -- Set thisRevision to the column name of db_version in the currently selected database
  SET @cThisRev := ((SELECT column_name FROM information_schema.`COLUMNS` WHERE table_name='db_version' AND table_schema=(SELECT DATABASE() AS thisDB FROM DUAL) AND column_name LIKE 'required%'));

  -- Set friendly Version Text
  SET @cThisVersion = 'MaNGOSZero Database Rev 21000_11';
 
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
    -- version
    INSERT IGNORE INTO `db_version` SET `Version` = @cThisVersion;

    -- If this is purely an incremental update, include this line
    SET @cNewRev = @cThisVersion;

    -- -- -- -- Normal Update / Insert / Delete statements will go here  -- -- -- -- --
	
    -- Stranglethorn Vale creatures (panthers and tigers) will now fall asleep between the hours of 9pm and 5am
    
    -- ***************   FOR THIS TO WORK, YOU'LL NEED THE LATEST (17th of May 2015) SERVER CORE   ***************
    -- specifically, the stranglethorn_vale.cpp file and the precompiled.h file (World.h now included for the in-game time of day)

    
    -- TIGERS
    -- ======
    
    -- Stranglethorn Tigress
    -- ENTRY: 772

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 772 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (type, ScriptName, bind, data) VALUES (0, 'mob_sleeping_creature', 772, 0);

    -- Stranglethorn Tiger
    -- ENTRY: 682

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 682 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (type, ScriptName, bind, data) VALUES (0, 'mob_sleeping_creature', 682, 0);

    -- Young Stranglethorn Tiger
    -- ENTRY:  681

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 681 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (type, ScriptName, bind, data) VALUES (0, 'mob_sleeping_creature', 681, 0);

    -- Elder Stranglethorn Tiger
    -- ENTRY:  1085

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 1085 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (type, ScriptName, bind, data) VALUES (0, 'mob_sleeping_creature', 1085, 0);


    -- PANTHERS
    -- ========

    -- Shadowmaw Panther
    -- ENTRY:  684

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 684 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (type, ScriptName, bind, data) VALUES (0, 'mob_sleeping_creature', 684, 0);

    -- Elder Shadowmaw Panther
    -- ENTRY:  1713

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 1713 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (type, ScriptName, bind, data) VALUES (0, 'mob_sleeping_creature', 1713, 0);

    -- Young Panther
    -- ENTRY:  683

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 683 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (type, ScriptName, bind, data) VALUES (0, 'mob_sleeping_creature', 683, 0);

    -- Panther
    -- ENTRY:  736

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 736 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (type, ScriptName, bind, data) VALUES (0, 'mob_sleeping_creature', 736, 0);


    
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
