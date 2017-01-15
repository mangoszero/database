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

  SET @cOldRev = 'required_21000_17_dbdocslanguage';

  -- Set the new revision string
  SET @cNewRev = 'required_21000_18_Update_for_quest_502_and_5203';

  -- Set thisRevision to the column name of db_version in the currently selected database
  SET @cThisRev := ((SELECT column_name FROM information_schema.`COLUMNS` WHERE table_name='db_version' AND table_schema=(SELECT DATABASE() AS thisDB FROM DUAL) AND column_name LIKE 'required%'));

  -- Set friendly Version Text
  SET @cThisVersion = 'MaNGOSZero Database Rev 21000_18';
 
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

-- Script Update for Quest 5203 Escape from Jaedenar
-- Spirit of Trey Lightforge now got his equipment 
UPDATE script_waypoint SET waittime = 0 WHERE entry = 11016 AND pointid = 35;
UPDATE script_waypoint SET waittime = 5000 WHERE entry = 11016 AND pointid = 36;
UPDATE script_waypoint SET point_comment = '' WHERE entry = 11016 AND pointid = 35;
UPDATE script_waypoint SET point_comment = 'SAY_SECOND_STOP' WHERE entry = 11016 AND pointid = 36;
UPDATE creature_template SET EquipmentTemplateId = 1248 WHERE entry = 11141;

-- New Quest end Script for Quest 502 Elixir of Pain
-- Enraged Stanley now have correct faction
DELETE FROM `dbscripts_on_quest_end` WHERE id = 502;
INSERT INTO `dbscripts_on_quest_end` VALUES('502','2','0','2','0','0','0','0','2000000207','0','0','0','0','0','0','0','Stanley Text Emote');
INSERT INTO `dbscripts_on_quest_end` VALUES('502','10','39','2275','0','0','0','0','0','0','0','0','0','0','0','0','Stanley Change Entry');
INSERT INTO `dbscripts_on_quest_end` VALUES('502','120','39','2274','0','0','0','0','0','0','0','0','0','0','0','0','Enraged Stanley Change Entry');
UPDATE creature_template SET FactionAlliance = 44 WHERE entry = 2275;
UPDATE creature_template SET FactionHorde = 44 WHERE entry = 2275;

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
