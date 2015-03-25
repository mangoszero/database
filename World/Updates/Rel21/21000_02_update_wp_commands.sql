-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

  SET @cOldRev = 'required_21000_01_Release21_initial'; 

  -- Set the new revision string
  SET @cNewRev = 'required_21000_01_Release21_initial';

  -- Set thisRevision to the column name of db_version in the currently selected database
  SET @cThisRev := ((SELECT column_name FROM information_schema.`COLUMNS` WHERE table_name='db_version' AND table_schema=(SELECT DATABASE() AS thisDB FROM DUAL) AND column_name LIKE 'required%'));

  -- Set friendly Version Text
  SET @cThisVersion = 'MaNGOSZero Database Rev 21000_02';

 
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

    -- -- -- -- Normal Update / Insert / Delete statements will go here  -- -- -- -- --
    -- version
    INSERT IGNORE INTO `db_version` SET `Version` = @cThisVersion;

    -- If this is purely an incremental update, include this line
    SET @cNewRev = @cThisVersion;
          
    -- Update WP Commands    
    DELETE FROM command WHERE NAME='wp add' OR NAME='wp modify' OR NAME='wp show';
    INSERT INTO command VALUES
    ('wp add',2,'Syntax: .wp add [Selected Creature or dbGuid] [pathId [wpOrigin] ]'),
    ('wp modify',2,'Syntax: .wp modify command [dbGuid, id] [value]\r\nwhere command must be one of: waittime  | scriptid | orientation | del | move\r\nIf no waypoint was selected, one can be chosen with dbGuid and id.\r\nThe commands have the following meaning:\r\n waittime (Set the time the npc will wait at a point (in ms))\r\n scriptid (Set the DB-Script that will be executed when the wp is reached)\r\n orientation (Set the orientation of this point) \r\n del (Remove the waypoint from the path)\r\n move (Move the wayoint to the current position of the player)'),
    ('wp show',2,'Syntax: .wp show command [dbGuid] [pathId [wpOrigin] ]\r\nwhere command can have one of the following values\r\non (to show all related wp)\r\nfirst (to see only first one)\r\nlast (to see only last one)\r\noff (to hide all related wp)\r\ninfo (to get more info about theses wp)\r\n\r\nFor using info you have to do first show on and than select a Visual-Waypoint and do the show info!\r\nwith pathId and wpOrigin you can specify which path to show (optional)');
     

    -- Update Mangos Strings
    DELETE FROM mangos_string WHERE entry BETWEEN 220 AND 252;
    INSERT INTO mangos_string VALUES
    (220,'Cannot find waypoint id %u for %s (in path %i, loaded from %s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (221,'Last Waypoint not found for %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (222,'%s has no path or path empty, path-id %i (loaded from %s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (223,'Creature (GUID: %u) No waypoints found - This is a MaNGOS db problem (single float).',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (224,'Cannot access %s on map, maybe you are too far away from its spawn location',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (225,'Creature (GUID: %u) not found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (226,'You must select a visual waypoint.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (227,'No visual waypoints found',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (228,'Could not create visual waypoint with creatureID: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (229,'All visual waypoints removed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (230,'Could not add waypoint %u to %s (pathId %i stored by %s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (231,'No GUID provided.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (232,'No waypoint number provided.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (233,'Argument required for \'%s\'.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (234,'Added Waypoint %u to %s (PathId %i, path stored by %s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (235,'UNUSED',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (236,'Waypoint changed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (237,'Waypoint %s modified.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (238,'WP export successfull.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (239,'No waypoints found inside the database.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (240,'File imported.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (241,'Waypoint removed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (242,'UNUSED',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (243,'UNUSED',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (244,'UNUSED',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (245,'UNUSED',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (246,'Waypoint %u for %s (from pathId %i, stored by %s)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (247,' Waittime: %d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (248,' Orientation: %f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (249,' ScriptId: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (250,'ScriptID set to non-existing id %u, add it to DBScriptsEngine and reload the table.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (251,'UNUSED',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
    (252,'AIScriptName: %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
    
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
