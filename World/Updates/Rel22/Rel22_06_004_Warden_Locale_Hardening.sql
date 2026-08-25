-- ----------------------------------------------------------------
-- Add verified Classic Windows locale profiles and protect the two
-- interface-signature dispatch tables used by the client.
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
    SET @cOldContent = '003';

    SET @cNewVersion = '22';
    SET @cNewStructure = '06';
    SET @cNewContent = '004';
    SET @cNewDescription = 'Warden_Locale_Hardening';
    SET @cNewComment = 'Add verified locale profiles and interface signature checks';

    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `structure` DESC, `content` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version` = @cOldVersion AND `structure` = @cOldStructure AND `content` = @cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version` = @cNewVersion AND `structure` = @cNewStructure AND `content` = @cNewContent);

    IF (@cCurResult = @cOldResult) THEN
        START TRANSACTION;

        -- Require every canonical 22/06/003 identity while preserving
        -- operator-added rows and enabled-state choices.
        SET @cRequiredSeedRows :=
          (SELECT COUNT(*) FROM `warden_checks`
           WHERE (`build`,`platform`,`locale`) IN
             ((5875,0x57696E,0x656E5553),
              (6005,0x57696E,0x656E4742),
              (6141,0x57696E,0x7A68434E))
             AND `check_id` IN (1,2,827,1107,1135,1566,65536));
        IF @cRequiredSeedRows <> 21 THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Required Warden rows are missing; restore the canonical 22/06/003 seed';
        END IF;

        -- The new IDs carry stable audit identity and cannot be reassigned.
        IF EXISTS
          (SELECT 1 FROM `warden_checks`
           WHERE (`build`,`platform`,`locale`) IN
             ((5875,0x57696E,0x656E5553),
              (6005,0x57696E,0x656E4742),
              (6141,0x57696E,0x7A68434E))
             AND `check_id` IN (65537,65538)) THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Custom Warden check IDs 65537/65538 conflict; renumber them before retrying';
        END IF;

        -- A locally authored version of a new exact profile needs an explicit
        -- operator merge; silently combining two baselines would be unsafe.
        IF EXISTS
          (SELECT 1 FROM `warden_checks`
           WHERE (`build`,`platform`,`locale`) IN
             ((5875,0x57696E,0x6B6F4B52),
              (5875,0x57696E,0x7A685457),
              (5875,0x57696E,0x66724652),
              (5875,0x57696E,0x65734553),
              (6005,0x57696E,0x64654445))) THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Custom rows already use a new Warden locale profile; merge or remove them before retrying';
        END IF;

        -- Preserve custom check order while reserving 80 and 90 for the two
        -- appended canonical checks. Descending order avoids transient unique
        -- key collisions as every existing slot from 80 upward moves by 20.
        IF EXISTS
          (SELECT 1 FROM `warden_checks`
           WHERE (`build`,`platform`,`locale`) IN
             ((5875,0x57696E,0x656E5553),
              (6005,0x57696E,0x656E4742),
              (6141,0x57696E,0x7A68434E))
             AND `sort_order` > 65515) THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Warden sort_order relocation would overflow; renumber values above 65515 before retrying';
        END IF;

        UPDATE `warden_checks`
        SET `sort_order` = `sort_order` + 20
        WHERE (`build`,`platform`,`locale`) IN
          ((5875,0x57696E,0x656E5553),
           (6005,0x57696E,0x656E4742),
           (6141,0x57696E,0x7A68434E))
          AND `sort_order` >= 80
        ORDER BY `sort_order` DESC;

        INSERT INTO `warden_checks`
        (`build`,`platform`,`locale`,`check_id`,`type`,`enabled`,`sort_order`,
         `evidence_class`,`module`,`address`,`length`,`request`,`expected`,`comment`)
        VALUES
        -- Harden the three profiles introduced by 22/06/003.
        (5875,0x57696E,0x656E5553,65537,243,1,80,1,X'',4631212,16,X'',
         0x1CA9460029A9460036A946009EA94600,
         'GlueXML interface-signature dispatch invariant'),
        (5875,0x57696E,0x656E5553,65538,243,1,90,1,X'',4784584,16,X'',
         0x5EFF48006BFF480078FF480095FF4800,
         'FrameXML interface-signature dispatch invariant'),
        (6005,0x57696E,0x656E4742,65537,243,1,80,1,X'',4631212,16,X'',
         0x1CA9460029A9460036A946009EA94600,
         'GlueXML interface-signature dispatch invariant'),
        (6005,0x57696E,0x656E4742,65538,243,1,90,1,X'',4784584,16,X'',
         0x5EFF48006BFF480078FF480095FF4800,
         'FrameXML interface-signature dispatch invariant'),
        (6141,0x57696E,0x7A68434E,65537,243,1,80,1,X'',4631212,16,X'',
         0x1CA9460029A9460036A946009EA94600,
         'GlueXML interface-signature dispatch invariant'),
        (6141,0x57696E,0x7A68434E,65538,243,1,90,1,X'',4788152,16,X'',
         0x4E0D49005B0D4900680D4900850D4900,
         'FrameXML interface-signature dispatch invariant'),

        -- 1.12.1 build 5875 Korean.
        (5875,0x57696E,0x6B6F4B52,65536,87,1,10,0,X'',0,0,X'',X'',
         'Delivered-module timing health'),
        (5875,0x57696E,0x6B6F4B52,1,152,1,20,3,X'',0,0,
         0x444246696C6573436C69656E745C417265615461626C652E646263,
         0x755D6D7F49BB34114433386D559261ED3AA23F00,
         'Effective AreaTable baseline; corroboration only'),
        (5875,0x57696E,0x6B6F4B52,2,139,1,30,3,X'',0,0,0x4F4B4159,
         0xED9995EC9DB8,'Localized OKAY callback; addons may mutate globals'),
        (5875,0x57696E,0x6B6F4B52,1107,243,1,40,1,X'',6392064,32,X'',
         0x558BEC8B51408B450C81E2FF7DA075508950108B450850E824DA1A005DC20800,
         'Re-authored complete client function invariant'),
        (5875,0x57696E,0x6B6F4B52,827,243,1,50,1,X'',8151558,13,X'',
         0x25FFFFDFFB0D00200000894640,
         'Re-authored complete air-swim invariant'),
        (5875,0x57696E,0x6B6F4B52,1566,243,1,60,2,X'',4803152,5,X'',
         0xA1C0EACE00,'Source-backed RemoveLuaProtection entry mutation'),
        (5875,0x57696E,0x6B6F4B52,1135,243,1,70,3,X'',8445948,4,X'',
         0xBB8D243F,'Wall-climb constant without active malicious fixture'),
        (5875,0x57696E,0x6B6F4B52,65537,243,1,80,1,X'',4631212,16,X'',
         0x1CA9460029A9460036A946009EA94600,
         'GlueXML interface-signature dispatch invariant'),
        (5875,0x57696E,0x6B6F4B52,65538,243,1,90,1,X'',4784584,16,X'',
         0x5EFF48006BFF480078FF480095FF4800,
         'FrameXML interface-signature dispatch invariant'),

        -- 1.12.1 build 5875 Traditional Chinese. The expectations describe
        -- a clean executable; modified distributions must not be whitelisted.
        (5875,0x57696E,0x7A685457,65536,87,1,10,0,X'',0,0,X'',X'',
         'Delivered-module timing health'),
        (5875,0x57696E,0x7A685457,1,152,1,20,3,X'',0,0,
         0x444246696C6573436C69656E745C417265615461626C652E646263,
         0x2A70E6402A40A4F9E9960CED419DBA5E6DEB8536,
         'Effective AreaTable baseline; corroboration only'),
        (5875,0x57696E,0x7A685457,2,139,1,30,3,X'',0,0,0x4F4B4159,
         0xE7A2BAE5AE9A,'Localized OKAY callback; addons may mutate globals'),
        (5875,0x57696E,0x7A685457,1107,243,1,40,1,X'',6392064,32,X'',
         0x558BEC8B51408B450C81E2FF7DA075508950108B450850E824DA1A005DC20800,
         'Re-authored complete client function invariant'),
        (5875,0x57696E,0x7A685457,827,243,1,50,1,X'',8151558,13,X'',
         0x25FFFFDFFB0D00200000894640,
         'Re-authored complete air-swim invariant'),
        (5875,0x57696E,0x7A685457,1566,243,1,60,2,X'',4803152,5,X'',
         0xA1C0EACE00,'Source-backed RemoveLuaProtection entry mutation'),
        (5875,0x57696E,0x7A685457,1135,243,1,70,3,X'',8445948,4,X'',
         0xBB8D243F,'Wall-climb constant without active malicious fixture'),
        (5875,0x57696E,0x7A685457,65537,243,1,80,1,X'',4631212,16,X'',
         0x1CA9460029A9460036A946009EA94600,
         'GlueXML interface-signature dispatch invariant'),
        (5875,0x57696E,0x7A685457,65538,243,1,90,1,X'',4784584,16,X'',
         0x5EFF48006BFF480078FF480095FF4800,
         'FrameXML interface-signature dispatch invariant'),

        -- 1.12.1 build 5875 French.
        (5875,0x57696E,0x66724652,65536,87,1,10,0,X'',0,0,X'',X'',
         'Delivered-module timing health'),
        (5875,0x57696E,0x66724652,1,152,1,20,3,X'',0,0,
         0x444246696C6573436C69656E745C417265615461626C652E646263,
         0xAF2D81AF013A9BA6BB92CE171E43FA903C9E8C09,
         'Effective AreaTable baseline; corroboration only'),
        (5875,0x57696E,0x66724652,2,139,1,30,3,X'',0,0,0x4F4B4159,
         0x4F4B,'Localized OKAY callback; addons may mutate globals'),
        (5875,0x57696E,0x66724652,1107,243,1,40,1,X'',6392064,32,X'',
         0x558BEC8B51408B450C81E2FF7DA075508950108B450850E824DA1A005DC20800,
         'Re-authored complete client function invariant'),
        (5875,0x57696E,0x66724652,827,243,1,50,1,X'',8151558,13,X'',
         0x25FFFFDFFB0D00200000894640,
         'Re-authored complete air-swim invariant'),
        (5875,0x57696E,0x66724652,1566,243,1,60,2,X'',4803152,5,X'',
         0xA1C0EACE00,'Source-backed RemoveLuaProtection entry mutation'),
        (5875,0x57696E,0x66724652,1135,243,1,70,3,X'',8445948,4,X'',
         0xBB8D243F,'Wall-climb constant without active malicious fixture'),
        (5875,0x57696E,0x66724652,65537,243,1,80,1,X'',4631212,16,X'',
         0x1CA9460029A9460036A946009EA94600,
         'GlueXML interface-signature dispatch invariant'),
        (5875,0x57696E,0x66724652,65538,243,1,90,1,X'',4784584,16,X'',
         0x5EFF48006BFF480078FF480095FF4800,
         'FrameXML interface-signature dispatch invariant'),

        -- 1.12.1 build 5875 Spanish.
        (5875,0x57696E,0x65734553,65536,87,1,10,0,X'',0,0,X'',X'',
         'Delivered-module timing health'),
        (5875,0x57696E,0x65734553,1,152,1,20,3,X'',0,0,
         0x444246696C6573436C69656E745C417265615461626C652E646263,
         0x1ECEC2C6596B8411FA5FE153EDFB9A6EE43360E9,
         'Effective AreaTable baseline; corroboration only'),
        (5875,0x57696E,0x65734553,2,139,1,30,3,X'',0,0,0x4F4B4159,
         0x41636570746172,'Localized OKAY callback; addons may mutate globals'),
        (5875,0x57696E,0x65734553,1107,243,1,40,1,X'',6392064,32,X'',
         0x558BEC8B51408B450C81E2FF7DA075508950108B450850E824DA1A005DC20800,
         'Re-authored complete client function invariant'),
        (5875,0x57696E,0x65734553,827,243,1,50,1,X'',8151558,13,X'',
         0x25FFFFDFFB0D00200000894640,
         'Re-authored complete air-swim invariant'),
        (5875,0x57696E,0x65734553,1566,243,1,60,2,X'',4803152,5,X'',
         0xA1C0EACE00,'Source-backed RemoveLuaProtection entry mutation'),
        (5875,0x57696E,0x65734553,1135,243,1,70,3,X'',8445948,4,X'',
         0xBB8D243F,'Wall-climb constant without active malicious fixture'),
        (5875,0x57696E,0x65734553,65537,243,1,80,1,X'',4631212,16,X'',
         0x1CA9460029A9460036A946009EA94600,
         'GlueXML interface-signature dispatch invariant'),
        (5875,0x57696E,0x65734553,65538,243,1,90,1,X'',4784584,16,X'',
         0x5EFF48006BFF480078FF480095FF4800,
         'FrameXML interface-signature dispatch invariant'),

        -- 1.12.2 build 6005 German.
        (6005,0x57696E,0x64654445,65536,87,1,10,0,X'',0,0,X'',X'',
         'Delivered-module timing health'),
        (6005,0x57696E,0x64654445,1,152,1,20,3,X'',0,0,
         0x444246696C6573436C69656E745C417265615461626C652E646263,
         0xA0B3DC2D78AD892F2436BCD937BE51B4989D64C1,
         'Effective AreaTable baseline; corroboration only'),
        (6005,0x57696E,0x64654445,2,139,1,30,3,X'',0,0,0x4F4B4159,
         0x4F4B,'Localized OKAY callback; addons may mutate globals'),
        (6005,0x57696E,0x64654445,1107,243,1,40,1,X'',6392064,32,X'',
         0x558BEC8B51408B450C81E2FF7DA075508950108B450850E864DA1A005DC20800,
         'Re-authored complete client function invariant'),
        (6005,0x57696E,0x64654445,827,243,1,50,1,X'',8151622,13,X'',
         0x25FFFFDFFB0D00200000894640,
         'Re-authored complete air-swim invariant'),
        (6005,0x57696E,0x64654445,1566,243,1,60,2,X'',4803152,5,X'',
         0xA1C0EACE00,'Source-backed RemoveLuaProtection entry mutation'),
        (6005,0x57696E,0x64654445,1135,243,1,70,3,X'',8445948,4,X'',
         0xBB8D243F,'Wall-climb constant without active malicious fixture'),
        (6005,0x57696E,0x64654445,65537,243,1,80,1,X'',4631212,16,X'',
         0x1CA9460029A9460036A946009EA94600,
         'GlueXML interface-signature dispatch invariant'),
        (6005,0x57696E,0x64654445,65538,243,1,90,1,X'',4784584,16,X'',
         0x5EFF48006BFF480078FF480095FF4800,
         'FrameXML interface-signature dispatch invariant');

        SET @cRequiredExpandedRows :=
          (SELECT COUNT(*) FROM `warden_checks`
           WHERE (`build`,`platform`,`locale`) IN
             ((5875,0x57696E,0x656E5553),
              (5875,0x57696E,0x6B6F4B52),
              (5875,0x57696E,0x7A685457),
              (5875,0x57696E,0x66724652),
              (5875,0x57696E,0x65734553),
              (6005,0x57696E,0x656E4742),
              (6005,0x57696E,0x64654445),
              (6141,0x57696E,0x7A68434E))
             AND `check_id` IN
               (1,2,827,1107,1135,1566,65536,65537,65538));
        IF @cRequiredExpandedRows <> 72 THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Expanded Warden canonical row validation failed';
        END IF;

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
