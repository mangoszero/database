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
    SET @cOldStructure = '7'; 
    SET @cOldContent = '3'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '8';
    SET @cNewContent = '1';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'warden_refactor';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'warden_refactor';

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
-- Table structure for table `warden`
--

DROP TABLE IF EXISTS `warden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warden` (
  `id` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Check ID from warden_checks',
  `build` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Client build',
  `type` TINYINT(3) UNSIGNED DEFAULT NULL COMMENT 'Check Type',
  `data` VARCHAR(48) NOT NULL DEFAULT '',
  `str` VARCHAR(20) NOT NULL DEFAULT '',
  `address` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `length` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `result` VARCHAR(24) NOT NULL DEFAULT '',
  `comment` VARCHAR(50) DEFAULT '' COMMENT 'Description of what the check is',
  PRIMARY KEY (`id`,`build`)
) ENGINE=MYISAM AUTO_INCREMENT=790 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Grabs all the entries in three phases:
-- 1: Pulls in all the main entries as 5875
-- 2: Pulls in all the entries in build specific
INSERT INTO `warden` 
(`id`, `build`, `type`, `data`, `str`, `address`, `length`, `result`, `comment`)  
(SELECT id,'5875' AS `build`,`type`,`data`,str,address,`length`,result,`COMMENT` FROM warden_checks)
UNION
(SELECT warden_build_specific.id,build,`type`,warden_build_specific.`DATA`,warden_build_specific.str,warden_build_specific.address,warden_build_specific.`LENGTH`,warden_build_specific.result,`comment` FROM warden_build_specific
LEFT JOIN warden_checks ON warden_build_specific.id=warden_checks.`id`
ORDER BY `id`, `build`);

DROP TABLE warden_build_specific;
DROP TABLE warden_checks;

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