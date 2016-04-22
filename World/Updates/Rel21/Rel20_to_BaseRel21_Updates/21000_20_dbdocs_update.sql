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

  SET @cOldRev = 'required_21000_18_Update_for_quest_502_and_5203';

  -- Set the new revision string
  SET @cNewRev = 'required_21000_18_Update_for_quest_502_and_5203';

  -- Set thisRevision to the column name of db_version in the currently selected database
  SET @cThisRev := ((SELECT column_name FROM information_schema.`COLUMNS` WHERE table_name='db_version' AND table_schema=(SELECT DATABASE() AS thisDB FROM DUAL) AND column_name LIKE 'required%'));

  -- Set friendly Version Text
  SET @cThisVersion = 'MaNGOSZero Database Rev 21000_20';
 
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

DELETE FROM `dbdocssubtables` WHERE `subtableId`= 51 AND languageId=0;
INSERT  INTO `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) VALUES (51,0,'Creature Linking Flags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Hex</b></th>
<th><b>FlagName</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>0x1</td><td align=\'center\' valign=\'middle\'>FLAG_AGGRO_ON_AGGRO</td><td align=\'left\' valign=\'middle\'>The "slave" aggroes when the "master" aggroes</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>0x2</td><td align=\'center\' valign=\'middle\'>FLAG_TO_AGGRO_ON_AGGRO</td><td align=\'left\' valign=\'middle\'>The master aggroes when the slave aggroes</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>0x4</td><td align=\'center\' valign=\'middle\'>FLAG_RESPAWN_ON_EVADE</td><td align=\'left\' valign=\'middle\'>The slave respawns when the master evades</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>0x8</td><td align=\'center\' valign=\'middle\'>FLAG_TO_RESPAWN_ON_EVADE</td><td align=\'left\' valign=\'middle\'>the master respawns when the slave evades</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'center\' valign=\'middle\'>0x10</td><td align=\'center\' valign=\'middle\'>FLAG_DESPAWN_ON_DEATH</td><td align=\'left\' valign=\'middle\'>the slave despawns when the master dies</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>32</td><td align=\'center\' valign=\'middle\'>0x20</td><td align=\'center\' valign=\'middle\'>FLAG_SELFKILL_ON_DEATH</td><td align=\'left\' valign=\'middle\'>the slave goes suicide when the master dies</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>64</td><td align=\'center\' valign=\'middle\'>0x40</td><td align=\'center\' valign=\'middle\'>FLAG_RESPAWN_ON_DEATH</td><td align=\'left\' valign=\'middle\'>the slave respawn when the master dies</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>128</td><td align=\'center\' valign=\'middle\'>0x80</td><td align=\'center\' valign=\'middle\'>FLAG_RESPAWN_ON_RESPAWN</td><td align=\'left\' valign=\'middle\'>the slave respawns on master respawn</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>256</td><td align=\'center\' valign=\'middle\'>0x100</td><td align=\'center\' valign=\'middle\'>FLAG_DESPAWN_ON_RESPAWN</td><td align=\'left\' valign=\'middle\'>the slave despawns on master respawn (TODO: check for slave != master)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>512</td><td align=\'center\' valign=\'middle\'>0x200</td><td align=\'center\' valign=\'middle\'>FLAG_FOLLOW</td><td align=\'left\' valign=\'middle\'>the slave follows the master, very basic, see TODO notes in commit, or post below</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>1024</td><td align=\'center\' valign=\'middle\'>0x400</td><td align=\'center\' valign=\'middle\'>FLAG_CANT_SPAWN_IF_BOSS_DEAD</td><td align=\'left\' valign=\'middle\'>the slave cannot respawn while boss is dead</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>2048</td><td align=\'center\' valign=\'middle\'>0x800</td><td align=\'center\' valign=\'middle\'>FLAG_CANT_SPAWN_IF_BOSS_ALIVE</td><td align=\'left\' valign=\'middle\'>the slave cannot respawn while boss is alive</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4096</td><td align=\'center\' valign=\'middle\'>0x1000</td><td align=\'center\' valign=\'middle\'>FLAG_DESPAWN_ON_EVADE</td><td align=\'left\' valign=\'middle\'>the slave despawn after the master evade</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>8192</td><td align=\'center\' valign=\'middle\'>0x2000</td><td align=\'center\' valign=\'middle\'>FLAG_DESPAWN_ON_DESPAWN</td><td align=\'left\' valign=\'middle\'>the slave despawn after the master despawns</td></tr>
</table>
','Value|Hex|FlagName|<Description
1|0x1|FLAG_AGGRO_ON_AGGRO|The "slave" aggroes when the "master" aggroes
2|0x2|FLAG_TO_AGGRO_ON_AGGRO|The master aggroes when the slave aggroes
4|0x4|FLAG_RESPAWN_ON_EVADE|The slave respawns when the master evades
8|0x8|FLAG_TO_RESPAWN_ON_EVADE|the master respawns when the slave evades
16|0x10|FLAG_DESPAWN_ON_DEATH|the slave despawns when the master dies
32|0x20|FLAG_SELFKILL_ON_DEATH|the slave goes suicide when the master dies
64|0x40|FLAG_RESPAWN_ON_DEATH|the slave respawn when the master dies
128|0x80|FLAG_RESPAWN_ON_RESPAWN|the slave respawns on master respawn
256|0x100|FLAG_DESPAWN_ON_RESPAWN|the slave despawns on master respawn (TODO: check for slave != master)
512|0x200|FLAG_FOLLOW|the slave follows the master, very basic, see TODO notes in commit, or post below
1024|0x400|FLAG_CANT_SPAWN_IF_BOSS_DEAD|the slave cannot respawn while boss is dead
2048|0x800|FLAG_CANT_SPAWN_IF_BOSS_ALIVE|the slave cannot respawn while boss is alive
4096|0x1000|FLAG_DESPAWN_ON_EVADE|the slave despawn after the master evade
8192|0x2000|FLAG_DESPAWN_ON_DESPAWN|the slave despawn after the master despawns');

UPDATE `dbdocsfields` SET `FieldComment` = 'This flag determines how a linked creature will act.', `fieldNotes` = 'This flag determines how a linked creature will act, when the master is changing it\'s combat state. Flags provide support for combat state, non combat state and life state.<br /><br />The following flags determine the behaviour if the master is in combat state.<br /><br />¬Subtable:51̼¬<br /><br />' WHERE `fieldId`= '137' AND `languageId`= 0;
UPDATE `dbdocsfields` SET `FieldComment` = 'This flag determines how a linked creature will act.', `fieldNotes` = 'This flag determines how a linked creature will act, when the master is changing it\'s combat state. <br />Flags provide support for combat state, non combat state and life state.<br /><br />The following flags determine the behaviour if the master is in combat state.<br /><br />¬Subtable:51¬<br /><br />' WHERE `fieldId`= '133' AND `languageId`= 0;

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
