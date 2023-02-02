-- ----------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update
-- Now compatible with newer MySql Databases (v1.5)
-- ----------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT `structure` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cCurContent := (SELECT `content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '22'; 
    SET @cOldStructure = '02'; 
    SET @cOldContent = '001';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '03';
    SET @cNewContent = '001';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'remove_item_text';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'remove_item_text';

    -- Evaluate all settings
    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
		
RENAME TABLE item_instance TO item_instance_old;
RENAME TABLE item_text TO item_text_old;
RENAME TABLE mail TO mail_old;

DROP TABLE IF EXISTS `item_instance_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_instance_new` (
  `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the item. This number is unique for each item instance.',
  `owner_guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the character who has ownership of this item. (See character.guid)',
  `data` LONGTEXT DEFAULT NULL COMMENT 'Much like the playerbytes fields in the characters table.',
  `text` LONGTEXT DEFAULT NULL COMMENT 'The Name of the Item',
  PRIMARY KEY (`guid`),
  KEY `idx_owner_guid` (`owner_guid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item System';

INSERT INTO `item_instance_new`
SELECT `guid`,`owner_guid`,`data`,`text` FROM item_instance_old LEFT JOIN item_text_old ON item_instance_old.`guid`=item_text_old.`id`;


DROP TABLE IF EXISTS `mail_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_new` (
  `id` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Unique message id. Every new message gets a new auto incremented id.',
  `messageType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'message_type.',
  `stationery` TINYINT(3) NOT NULL DEFAULT '41' COMMENT 'The StationeryID (See Stationery.dbc).',
  `mailTemplateId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Mail Template Id (See MailTemplate.dbc)',
  `sender` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Guid of the character who sends the mail.',
  `receiver` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Guid of the character who receives the mail.',
  `subject` LONGTEXT DEFAULT NULL COMMENT 'The Subject of the mail.',
  `body` LONGTEXT DEFAULT NULL COMMENT 'The Body of the mail',
  `has_items` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean value showing whether or not atems have been sent.',
  `expire_time` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current Unix Time + Unix Time till expiry.',
  `deliver_time` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current Unix Time + Unix Time till delivery.',
  `money` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Amount of money sent.',
  `cod` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Amount of money needed (COD).',
  `checked` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'checked_flag.',
  PRIMARY KEY (`id`),
  KEY `idx_receiver` (`receiver`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Mail System';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `mail_new`
SELECT `mail_old`.`id`,`messageType`,`stationery`,`mailTemplateId`,`sender`,`receiver`,`subject`,`text`,`has_items`,`expire_time`,`deliver_time`,`money`,`cod`,`checked` FROM mail_old LEFT JOIN item_text_old ON mail_old.`itemTextId`=item_text_old.`id`;

RENAME TABLE item_instance_new TO item_instance;
RENAME TABLE mail_new TO mail;

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
            -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
            -- UPDATE THE DB VERSION
            -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
            INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
            SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

            SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,@cNewResult AS `===== DB is now on Version =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cCurResult AS `===== DB is already on Version =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
                IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                ELSE
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                END IF;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;


