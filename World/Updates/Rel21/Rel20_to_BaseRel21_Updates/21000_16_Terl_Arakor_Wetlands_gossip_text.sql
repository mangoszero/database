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

  SET @cOldRev = 'required_21000_15_Missing_PVPStats';

  -- Set the new revision string
  SET @cNewRev = 'required_21000_16_Terl_Arakor_Wetlands_gossip_text';

  -- Set thisRevision to the column name of db_version in the currently selected database
  SET @cThisRev := ((SELECT column_name FROM information_schema.`COLUMNS` WHERE table_name='db_version' AND table_schema=(SELECT DATABASE() AS thisDB FROM DUAL) AND column_name LIKE 'required%'));

  -- Set friendly Version Text
  SET @cThisVersion = 'MaNGOSZero Database Rev 21000_16';
 
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

    -- ============ Terl Arakor missing gossip text added ============ --

    UPDATE npc_text SET `prob0`='1', `text1_1`='On my way down here from Dun Algaz I saw a gnoll hunting Threshadons in the middle of a lake. If you\'ve never seen a dog try to use a spear, you\'re in for a treat!', `prob1`='1', `text2_1`='I was up at Whelgar\'s a few days ago attempting to...er...liberate...some titan relics from the bones of the dead raptors, and I saw him! Sarltooth lives! Well, he\'s undead, so I guess he doesn\'t live, but he exists. Sarltooth exists!', `prob2`='1', `text3_0`='They say that the raptor matriarch lives deep within Raptor Ridge, protecting her clutch of eggs.', `prob3`='1', `text4_0`='The Dragonmaw are attempting to push out of the Angerfang Encampment and are already raiding the caravan to the east. They\'ve called in two powerful warriors who are leading the charge. If you\'re up for a challenge, you might find them at the Encampment, planning and strategizing and doing other evil Orcish things.', `prob4`='1' WHERE `ID`='16528';

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
