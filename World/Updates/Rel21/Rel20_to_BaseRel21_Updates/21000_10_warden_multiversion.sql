-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

  SET @cOldRev = 'required_21000_08_warden_checks'; 

  -- Set the new revision string
  SET @cNewRev = 'required_21000_10_warden_multiversion';

  -- Set thisRevision to the column name of db_version in the currently selected database
  SET @cThisRev := ((SELECT column_name FROM information_schema.`COLUMNS` WHERE table_name='db_version' AND table_schema=(SELECT DATABASE() AS thisDB FROM DUAL) AND column_name LIKE 'required%'));

  -- Set friendly Version Text
  SET @cThisVersion = 'MaNGOSZero Database Rev 21000_10';
 
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
    -- Warden: support clients of different versions; for `type` and `comment`, see warden_checks table
    DROP TABLE IF EXISTS `warden_build_specific`;
    CREATE TABLE `warden_build_specific` (
      `id` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Check ID from warden_checks',
      `build` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Client build',
      `data` VARCHAR(48) NOT NULL DEFAULT '',
      `str` VARCHAR(20) NOT NULL DEFAULT '',
      `address` INT(10) UNSIGNED NOT NULL DEFAULT 0,
      `length` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0,
      `result` VARCHAR(24) NOT NULL DEFAULT '',
      PRIMARY KEY (`id`,`build`)
    ) ENGINE = MyISAM DEFAULT CHARSET = utf8;
    -- version
    INSERT IGNORE INTO `db_version` SET `Version` = @cThisVersion;

    -- If this is purely an incremental update, include this line
    SET @cNewRev = @cThisVersion;

    -- -- -- -- Normal Update / Insert / Delete statements will go here  -- -- -- -- --
    INSERT INTO `warden_build_specific` (`id`,`build`,`address`,`length`,`result`) VALUES
     (38, 6005,0x7C6246,11,'25FFFFDFFB0D0020000089'),
     (90, 6005,0x7C62B2,4,'D893FEC0'),
     (134,6005,0x7C62A9,4,'488C11C1'),
     (158,6005,0x7C629E,2,'3075'),
     (262,6005,0x7C4995,3,'8B4908'),
     (634,6005,0x7C641A,3,'8B4F78');
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
