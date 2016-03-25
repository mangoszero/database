-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT structure FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurContent := (SELECT content FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '6'; 
    SET @cOldContent = '1'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '7';
    SET @cNewContent = '1';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'dbscripts_refactor';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'dbscripts_refactor';

    -- Evaluate all settings
    SET @cCurResult := (SELECT description FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cOldResult := (SELECT description FROM db_version WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;

        -- UPDATE THE DB VERSION
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
        SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

--
-- Table structure for table `db_scripts`
--

DROP TABLE IF EXISTS `db_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_scripts` (
  `script_guid` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `script_type` SMALLINT(2) UNSIGNED NOT NULL DEFAULT '0',
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `delay` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `command` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `datalong` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `datalong2` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `buddy_entry` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `search_radius` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `data_flags` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `dataint` INT(11) NOT NULL DEFAULT '0',
  `dataint2` INT(11) NOT NULL DEFAULT '0',
  `dataint3` INT(11) NOT NULL DEFAULT '0',
  `dataint4` INT(11) NOT NULL DEFAULT '0',
  `x` FLOAT NOT NULL DEFAULT '0',
  `y` FLOAT NOT NULL DEFAULT '0',
  `z` FLOAT NOT NULL DEFAULT '0',
  `o` FLOAT NOT NULL DEFAULT '0',
  `comments` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`script_guid`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Now add all the existing entries into this new table, setting a unique id plus the new type
INSERT INTO db_scripts
(`script_type`,`id`,`delay`,`command`,`datalong`,`datalong2`,`buddy_entry`,`search_radius`,`data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`,`x`,`y`,`z`,`o`,`comments`)

SELECT 0,dbscripts_on_quest_start.* FROM dbscripts_on_quest_start
UNION
SELECT 1,dbscripts_on_quest_end.* FROM dbscripts_on_quest_end
UNION
SELECT 2,dbscripts_on_gossip.* FROM dbscripts_on_gossip
UNION
SELECT 3,dbscripts_on_creature_movement.* FROM dbscripts_on_creature_movement
UNION
SELECT 4,dbscripts_on_creature_death.* FROM dbscripts_on_creature_death
UNION
SELECT 5,dbscripts_on_spell.* FROM dbscripts_on_spell
UNION
SELECT 6,dbscripts_on_go_use.* FROM dbscripts_on_go_use
UNION
SELECT 7,dbscripts_on_go_template_use.* FROM dbscripts_on_go_template_use
UNION
SELECT 8,dbscripts_on_event.* FROM dbscripts_on_event;

-- Now remove the old tables
DROP TABLE IF EXISTS `dbscripts_on_quest_start`;
DROP TABLE IF EXISTS `dbscripts_on_quest_end`;
DROP TABLE IF EXISTS `dbscripts_on_gossip`;
DROP TABLE IF EXISTS `dbscripts_on_creature_movement`;
DROP TABLE IF EXISTS `dbscripts_on_creature_death`;
DROP TABLE IF EXISTS `dbscripts_on_spell`;
DROP TABLE IF EXISTS `dbscripts_on_go_use`;
DROP TABLE IF EXISTS `dbscripts_on_go_template_use`;
DROP TABLE IF EXISTS `dbscripts_on_event`;

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL ABOVE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

        -- If we get here ok, commit the changes
        IF bRollback = TRUE THEN
            ROLLBACK;
            SHOW ERRORS;
            SELECT '* UPDATE FAILED *' AS `===== Status =====`,@cCurResult AS `===== DB is on Version: =====`;



        ELSE
            COMMIT;
            SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,@cNewResult AS `===== DB is now on Version =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cCurResult AS `===== DB is already on Version =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
                SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurResult AS `===== Found Version =====`;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;