-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

  SET @cOldRev = 'required_21000_02_Waypoint_update'; 

  -- Set the new revision string
  SET @cNewRev = 'required_21000_04_Fix_CreatureAI_Chestloot_Equip_Errors';

  -- Set thisRevision to the column name of db_version in the currently selected database
  SET @cThisRev := ((SELECT column_name FROM information_schema.`COLUMNS` WHERE table_name='db_version' AND table_schema=(SELECT DATABASE() AS thisDB FROM DUAL) AND column_name LIKE 'required%'));

  -- Set friendly Version Text
  SET @cThisVersion = 'MaNGOSZero Database Rev 21000_04';

 
  -- Only Proceed if the old values match
  IF @cThisRev = @cOldRev THEN
    -- Make this all a single transaction
    START TRANSACTION;

    -- Apply the Version Change from Old Version to New Version
    -- SET @query = CONCAT('ALTER TABLE db_version CHANGE COLUMN ',@cOldRev, ' ' ,@cNewRev,' bit;');
    -- PREPARE stmt1 FROM @query;
    -- EXECUTE stmt1;
    -- DEALLOCATE PREPARE stmt1;
    -- The Above block is required for making table changes
    -- version
    INSERT IGNORE INTO `db_version` SET `Version` = @cThisVersion;

    -- If this is purely an incremental update, include this line
    SET @cNewRev = @cThisVersion;

    -- -- -- -- Normal Update / Insert / Delete statements will go here  -- -- -- -- --
	

-- This fixes errors caused by some commits

-- this fixes multi spawns of unique creatures
-- Verog the Derwish
UPDATE `creature_ai_scripts`
SET `action2_type` = 49, `event_chance` = 5
WHERE `id` = 327402 OR `id` = 327502 OR `id` = 339703;

-- Nightlash
UPDATE `creature_ai_scripts`
SET `action1_type` = 49, `action2_type` = 0
WHERE `id` = 177203 OR `id` = 177303;

-- this fixes a wrong command id caused by a backport of a cmangos commit
UPDATE `dbscripts_on_quest_end`
SET `command` = 36
WHERE `command` = 35;

-- This are actually the same so let use creature_equip_template instead raw data 
UPDATE `creature_template` SET `EquipmentTemplateId` = 331 WHERE `EquipmentTemplateId` = 335;

-- Disabling Grouploot for Chests, it was not implemented in Classic

UPDATE `gameobject_template` SET `data15` = 0 WHERE `type` = 3;

    
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
