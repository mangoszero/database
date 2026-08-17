-- ----------------------------------------------------------------
-- Replace the legacy opaque Warden table with exact typed profiles.
-- IMPORTANT: export any custom `warden` rows before applying this
-- intentionally destructive update. No automatic conversion is safe.
-- ----------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SHOW ERRORS;
        SELECT '* UPDATE FAILED *' AS `===== Status =====`,
               @cCurResult AS `===== DB is on Version: =====`;
        RESIGNAL;
    END;

    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT `structure` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cCurContent := (SELECT `content` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);

    SET @cOldVersion = '22';
    SET @cOldStructure = '06';
    SET @cOldContent = '002';

    SET @cNewVersion = '22';
    SET @cNewStructure = '06';
    SET @cNewContent = '003';
    SET @cNewDescription = 'Warden_Checks';
    SET @cNewComment = 'Replace legacy Warden rows with exact typed checks';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- At 22/06/002 this name is unowned. Removing it makes a failed
        -- non-transactional DDL attempt safely re-runnable.
        DROP TABLE IF EXISTS `warden_checks`;
        CREATE TABLE `warden_checks` (
          `build` SMALLINT UNSIGNED NOT NULL,
          `platform` VARBINARY(4) NOT NULL,
          `locale` BINARY(4) NOT NULL,
          `check_id` INT UNSIGNED NOT NULL,
          `type` TINYINT UNSIGNED NOT NULL,
          `enabled` TINYINT UNSIGNED NOT NULL,
          `sort_order` SMALLINT UNSIGNED NOT NULL,
          `evidence_class` TINYINT UNSIGNED NOT NULL,
          `module` VARBINARY(255) NOT NULL DEFAULT '',
          `address` INT UNSIGNED NOT NULL DEFAULT 0,
          `length` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
          `request` VARBINARY(255) NOT NULL DEFAULT '',
          `expected` VARBINARY(255) NOT NULL DEFAULT '',
          `comment` VARCHAR(255) NOT NULL DEFAULT '',
          PRIMARY KEY (`build`,`platform`,`locale`,`check_id`),
          UNIQUE KEY `uq_warden_checks_profile_order`
            (`build`,`platform`,`locale`,`sort_order`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC
          COMMENT='Exact typed Warden check catalogue';

        INSERT INTO `warden_checks`
        (`build`,`platform`,`locale`,`check_id`,`type`,`enabled`,`sort_order`,
         `evidence_class`,`module`,`address`,`length`,`request`,`expected`,`comment`)
        VALUES
        (5875,0x57696E,0x656E5553,65536,87,1,10,0,X'',0,0,X'',X'',
         'Delivered-module timing health'),
        (5875,0x57696E,0x656E5553,1,152,1,20,3,X'',0,0,
         0x444246696C6573436C69656E745C417265615461626C652E646263,
         0x7D88154D3411811985F5D81177C5453248133443,
         'Effective AreaTable baseline; corroboration only'),
        (5875,0x57696E,0x656E5553,2,139,1,30,3,X'',0,0,0x4F4B4159,
         0x4F6B6179,'Localized OKAY callback; addons may mutate globals'),
        (5875,0x57696E,0x656E5553,1107,243,1,40,1,X'',6392064,32,X'',
         0x558BEC8B51408B450C81E2FF7DA075508950108B450850E824DA1A005DC20800,
         'Re-authored complete client function invariant'),
        (5875,0x57696E,0x656E5553,827,243,1,50,1,X'',8151558,13,X'',
         0x25FFFFDFFB0D00200000894640,
         'Re-authored complete air-swim invariant'),
        (5875,0x57696E,0x656E5553,1566,243,1,60,2,X'',4803152,5,X'',
         0xA1C0EACE00,'Source-backed RemoveLuaProtection entry mutation'),
        (5875,0x57696E,0x656E5553,1135,243,1,70,3,X'',8445948,4,X'',
         0xBB8D243F,'Wall-climb constant without active malicious fixture'),

        (6005,0x57696E,0x656E4742,65536,87,1,10,0,X'',0,0,X'',X'',
         'Delivered-module timing health'),
        (6005,0x57696E,0x656E4742,1,152,1,20,3,X'',0,0,
         0x444246696C6573436C69656E745C417265615461626C652E646263,
         0x7D88154D3411811985F5D81177C5453248133443,
         'Effective AreaTable baseline; corroboration only'),
        (6005,0x57696E,0x656E4742,2,139,1,30,3,X'',0,0,0x4F4B4159,
         0x4F6B6179,'Localized OKAY callback; addons may mutate globals'),
        (6005,0x57696E,0x656E4742,1107,243,1,40,1,X'',6392064,32,X'',
         0x558BEC8B51408B450C81E2FF7DA075508950108B450850E864DA1A005DC20800,
         'Re-authored complete client function invariant'),
        (6005,0x57696E,0x656E4742,827,243,1,50,1,X'',8151622,13,X'',
         0x25FFFFDFFB0D00200000894640,
         'Re-authored complete air-swim invariant'),
        (6005,0x57696E,0x656E4742,1566,243,1,60,2,X'',4803152,5,X'',
         0xA1C0EACE00,'Source-backed RemoveLuaProtection entry mutation'),
        (6005,0x57696E,0x656E4742,1135,243,1,70,3,X'',8445948,4,X'',
         0xBB8D243F,'Wall-climb constant without active malicious fixture'),

        (6141,0x57696E,0x7A68434E,65536,87,1,10,0,X'',0,0,X'',X'',
         'Delivered-module timing health'),
        (6141,0x57696E,0x7A68434E,1,152,1,20,3,X'',0,0,
         0x444246696C6573436C69656E745C417265615461626C652E646263,
         0xC5A1DE4C1CD412EB4D2E02AFAB6131B737EFCAF0,
         'Effective AreaTable baseline; corroboration only'),
        (6141,0x57696E,0x7A68434E,2,139,1,30,3,X'',0,0,0x4F4B4159,
         0xE7A1AEE5AE9A,'Localized OKAY callback; addons may mutate globals'),
        (6141,0x57696E,0x7A68434E,1107,243,1,40,1,X'',6401184,32,X'',
         0x558BEC8B51408B450C81E2FF7DA075508950108B450850E864EB1A005DC20800,
         'Re-authored complete client function invariant'),
        (6141,0x57696E,0x7A68434E,827,243,1,50,1,X'',8165094,13,X'',
         0x25FFFFDFFB0D00200000894640,
         'Re-authored complete air-swim invariant'),
        (6141,0x57696E,0x7A68434E,1566,243,1,60,2,X'',4806720,5,X'',
         0xA1E031CF00,'Source-backed RemoveLuaProtection entry mutation'),
        (6141,0x57696E,0x7A68434E,1135,243,1,70,3,X'',8462780,4,X'',
         0xBB8D243F,'Wall-climb constant without active malicious fixture');

        IF (SELECT COUNT(*) FROM `warden_checks`) <> 21
           OR (SELECT COUNT(DISTINCT `build`,`platform`,`locale`)
               FROM `warden_checks`) <> 3
           OR (SELECT COUNT(*) FROM `warden_checks` WHERE `enabled` = 1) <> 21 THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Warden check seed validation failed';
        END IF;

        -- The recoverable legacy table is removed only after the complete new
        -- seed has validated successfully.
        DROP TABLE IF EXISTS `warden`;

        INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure,
            @cNewContent, @cNewDescription, @cNewComment);
        SET @cNewResult := (SELECT `description` FROM `db_version`
            WHERE `version` = @cNewVersion AND `structure` = @cNewStructure
              AND `content` = @cNewContent);
        COMMIT;
        SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,
               @cNewResult AS `===== DB is now on Version =====`;
    ELSE
        IF (@cCurResult = @cNewResult) THEN
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,
                   @cCurResult AS `===== DB is already on Version =====`;
        ELSE
            IF (@cCurResult IS NULL) THEN
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,
                       'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
                SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure,
                    '_', @cCurContent, ' - ', @cCurResult);
                SET @cOldOutput = CONCAT(@cOldVersion, '_', @cOldStructure,
                    '_', @cOldContent, ' - ',
                    COALESCE(@cOldResult, 'IS NOT APPLIED'));
                SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,
                       @cOldOutput AS `=== Expected ===`,
                       @cCurOutput AS `===== Found Version =====`;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

CALL update_mangos();

DROP PROCEDURE IF EXISTS `update_mangos`;
