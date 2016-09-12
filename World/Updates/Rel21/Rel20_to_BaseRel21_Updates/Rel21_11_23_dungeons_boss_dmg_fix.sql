-- ----------------------------------------
-- Added to prevent timeout's while loading
-- ----------------------------------------
SET GLOBAL net_read_timeout=30;
SET GLOBAL net_write_timeout=60;
SET GLOBAL net_buffer_length=1000000; 
SET GLOBAL max_allowed_packet=1000000000;
SET GLOBAL connect_timeout=10000000;

-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update (v1.3)
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
    SET @cOldStructure = '11'; 
    SET @cOldContent = '22'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '23';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'dungeon_boss_dmg_fix';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fix damage of instance bosses';

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

-- Fixed dungeon Boss Damage

-- Zul'Farrak
UPDATE creature_template SET `MinMeleeDmg` = '411' , `MaxMeleeDmg` = '488' WHERE `Entry` = '8127'; 
UPDATE creature_template SET `MinMeleeDmg` = '411' , `MaxMeleeDmg` = '488' WHERE `Entry` = '7271'; 
UPDATE creature_template SET `MinMeleeDmg` = '396' , `MaxMeleeDmg` = '471' WHERE `Entry` = '7275'; 
UPDATE creature_template SET `MinMeleeDmg` = '384' , `MaxMeleeDmg` = '458' WHERE `Entry` = '7273'; 
UPDATE creature_template SET `MinMeleeDmg` = '64' , `MaxMeleeDmg` = '82' WHERE `Entry` = '10081'; 
UPDATE creature_template SET `MinMeleeDmg` = '411' , `MaxMeleeDmg` = '488' WHERE `Entry` = '7267'; 
UPDATE creature_template SET `MinMeleeDmg` = '359' , `MaxMeleeDmg` = '426' WHERE `Entry` = '10082'; 
-- Uldaman
UPDATE creature_template SET `MinMeleeDmg` = '157' , `MaxMeleeDmg` = '174' WHERE `Entry` = '6910';
UPDATE creature_template SET `MinMeleeDmg` = '225' , `MaxMeleeDmg` = '251' WHERE `Entry` = '7228';
UPDATE creature_template SET `MinMeleeDmg` = '228' , `MaxMeleeDmg` = '256' WHERE `Entry` = '7206';
UPDATE creature_template SET `MinMeleeDmg` = '185' , `MaxMeleeDmg` = '208' WHERE `Entry` = '7291';
UPDATE creature_template SET `MinMeleeDmg` = '203' , `MaxMeleeDmg` = '226' WHERE `Entry` = '4854';
UPDATE creature_template SET `MinMeleeDmg` = '262' , `MaxMeleeDmg` = '295' WHERE `Entry` = '2748';

-- Sunken Temple
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '5717';
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '5716';
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '5715';
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '5714';
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '5713';
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '5712';
UPDATE creature_template SET `MinMeleeDmg` = '474' , `MaxMeleeDmg` = '564' WHERE `Entry` = '8580'; 
UPDATE creature_template SET `MinMeleeDmg` = '474' , `MaxMeleeDmg` = '564' WHERE `Entry` = '5721'; 
UPDATE creature_template SET `MinMeleeDmg` = '459' , `MaxMeleeDmg` = '547' WHERE `Entry` = '5720'; 
UPDATE creature_template SET `MinMeleeDmg` = '459' , `MaxMeleeDmg` = '547' WHERE `Entry` = '8443'; 
UPDATE creature_template SET `MinMeleeDmg` = '501' , `MaxMeleeDmg` = '594' WHERE `Entry` = '5710'; 
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '5711'; 
UPDATE creature_template SET `MinMeleeDmg` = '474' , `MaxMeleeDmg` = '564' WHERE `Entry` = '5719';
UPDATE creature_template SET `MinMeleeDmg` = '459' , `MaxMeleeDmg` = '547' WHERE `Entry` = '5722'; 
UPDATE creature_template SET `MinMeleeDmg` = '483' , `MaxMeleeDmg` = '575' WHERE `Entry` = '5709';

-- Blackrock Spire
UPDATE creature_template SET `MinMeleeDmg` = '672' , `MaxMeleeDmg` = '708' WHERE `Entry` = '10363'; 
UPDATE creature_template SET `MinMeleeDmg` = '429' , `MaxMeleeDmg` = '463' WHERE `Entry` = '9816'; 
UPDATE creature_template SET `MinMeleeDmg` = '391' , `MaxMeleeDmg` = '425' WHERE `Entry` = '10264'; 
UPDATE creature_template SET `MinMeleeDmg` = '284' , `MaxMeleeDmg` = '318' WHERE `Entry` = '10509'; 
UPDATE creature_template SET `MinMeleeDmg` = '314' , `MaxMeleeDmg` = '349' WHERE `Entry` = '10899'; 
UPDATE creature_template SET `MinMeleeDmg` = '1138' , `MaxMeleeDmg` = '1180' WHERE `Entry` = '10429'; 
UPDATE creature_template SET `MinMeleeDmg` = '389' , `MaxMeleeDmg` = '425' WHERE `Entry` = '10339'; 
UPDATE creature_template SET `MinMeleeDmg` = '672' , `MaxMeleeDmg` = '708' WHERE `Entry` = '10430'; 
UPDATE creature_template SET `MinMeleeDmg` = '2083' , `MaxMeleeDmg` = '2513' WHERE `Entry` = '16042'; 
UPDATE creature_template SET `MinMeleeDmg` = '541' , `MaxMeleeDmg` = '643' WHERE `Entry` = '9218';
UPDATE creature_template SET `MinMeleeDmg` = '743' , `MaxMeleeDmg` = '853' WHERE `Entry` = '9236';
UPDATE creature_template SET `MinMeleeDmg` = '541' , `MaxMeleeDmg` = '643' WHERE `Entry` = '9237';
UPDATE creature_template SET `MinMeleeDmg` = '711' , `MaxMeleeDmg` = '791' WHERE `Entry` = '16080';
UPDATE creature_template SET `MinMeleeDmg` = '371' , `MaxMeleeDmg` = '396' WHERE `Entry` = '10569';
UPDATE creature_template SET `MinMeleeDmg` = '349' , `MaxMeleeDmg` = '375' WHERE `Entry` = '10376';
UPDATE creature_template SET `MinMeleeDmg` = '832' , `MaxMeleeDmg` = '991' WHERE `Entry` = '10584'; 
UPDATE creature_template SET `MinMeleeDmg` = '520' , `MaxMeleeDmg` = '620' WHERE `Entry` = '9736'; 
UPDATE creature_template SET `MinMeleeDmg` = '832' , `MaxMeleeDmg` = '991' WHERE `Entry` = '10268'; 
UPDATE creature_template SET `MinMeleeDmg` = '541' , `MaxMeleeDmg` = '643' WHERE `Entry` = '10220'; 
UPDATE creature_template SET `MinMeleeDmg` = '1123' , `MaxMeleeDmg` = '1290' WHERE `Entry` = '9568'; 
UPDATE creature_template SET `MinMeleeDmg` = '520' , `MaxMeleeDmg` = '620' WHERE `Entry` = '9596'; 
UPDATE creature_template SET `MinMeleeDmg` = '486' , `MaxMeleeDmg` = '577' WHERE `Entry` = '9219';

-- Blackrock Depths
UPDATE creature_template SET `MinMeleeDmg` = '250' , `MaxMeleeDmg` = '278' WHERE `Entry` = '9025'; 
UPDATE creature_template SET `MinMeleeDmg` = '255' , `MaxMeleeDmg` = '281' WHERE `Entry` = '9018'; 
UPDATE creature_template SET `MinMeleeDmg` = '270' , `MaxMeleeDmg` = '299' WHERE `Entry` = '9319'; 
UPDATE creature_template SET `MinMeleeDmg` = '474' , `MaxMeleeDmg` = '564' WHERE `Entry` = '9024'; 
UPDATE creature_template SET `MinMeleeDmg` = '257' , `MaxMeleeDmg` = '286' WHERE `Entry` = '9041'; 
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '9056'; 
UPDATE creature_template SET `MinMeleeDmg` = '267' , `MaxMeleeDmg` = '297' WHERE `Entry` = '9017'; 
UPDATE creature_template SET `MinMeleeDmg` = '287' , `MaxMeleeDmg` = '323' WHERE `Entry` = '9016'; 
UPDATE creature_template SET `MinMeleeDmg` = '270' , `MaxMeleeDmg` = '298' WHERE `Entry` = '9033'; 
UPDATE creature_template SET `MinMeleeDmg` = '273' , `MaxMeleeDmg` = '302' WHERE `Entry` = '8983';
UPDATE creature_template SET `MinMeleeDmg` = '276' , `MaxMeleeDmg` = '307' WHERE `Entry` = '9537';
UPDATE creature_template SET `MinMeleeDmg` = '276' , `MaxMeleeDmg` = '306' WHERE `Entry` = '9502';
UPDATE creature_template SET `MinMeleeDmg` = '263' , `MaxMeleeDmg` = '292' WHERE `Entry` = '9543';
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '9499';
UPDATE creature_template SET `MinMeleeDmg` = '279' , `MaxMeleeDmg` = '311' WHERE `Entry` = '9156';
UPDATE creature_template SET `MinMeleeDmg` = '277' , `MaxMeleeDmg` = '309' WHERE `Entry` = '8923'; 
UPDATE creature_template SET `MinMeleeDmg` = '304' , `MaxMeleeDmg` = '342' WHERE `Entry` = '9938'; 
UPDATE creature_template SET `MinMeleeDmg` = '292' , `MaxMeleeDmg` = '326' WHERE `Entry` = '9019'; 
UPDATE creature_template SET `MinMeleeDmg` = '274' , `MaxMeleeDmg` = '305' WHERE `Entry` = '8929'; 

-- Stratholme
UPDATE creature_template SET `MinMeleeDmg` = '500' , `MaxMeleeDmg` = '595' WHERE `Entry` = '10393'; 
UPDATE creature_template SET `MinMeleeDmg` = '279' , `MaxMeleeDmg` = '311' WHERE `Entry` = '11082'; 
UPDATE creature_template SET `MinMeleeDmg` = '265' , `MaxMeleeDmg` = '297' WHERE `Entry` = '10558'; 
UPDATE creature_template SET `MinMeleeDmg` = '288' , `MaxMeleeDmg` = '320' WHERE `Entry` = '10516'; 
UPDATE creature_template SET `MinMeleeDmg` = '242' , `MaxMeleeDmg` = '265' WHERE `Entry` = '10808'; 
UPDATE creature_template SET `MinMeleeDmg` = '405' , `MaxMeleeDmg` = '439' WHERE `Entry` = '10997'; 
UPDATE creature_template SET `MinMeleeDmg` = '384' , `MaxMeleeDmg` = '416' WHERE `Entry` = '10811'; 
UPDATE creature_template SET `MinMeleeDmg` = '402' , `MaxMeleeDmg` = '435' WHERE `Entry` = '10813'; 
UPDATE creature_template SET `MinMeleeDmg` = '1053' , `MaxMeleeDmg` = '1252' WHERE `Entry` = '16102'; 
UPDATE creature_template SET `MinMeleeDmg` = '1053' , `MaxMeleeDmg` = '1252' WHERE `Entry` = '16101';
UPDATE creature_template SET `MinMeleeDmg` = '362' , `MaxMeleeDmg` = '396' WHERE `Entry` = '10809';
UPDATE creature_template SET `MinMeleeDmg` = '281' , `MaxMeleeDmg` = '312' WHERE `Entry` = '10436';
UPDATE creature_template SET `MinMeleeDmg` = '391' , `MaxMeleeDmg` = '425' WHERE `Entry` = '10437';
UPDATE creature_template SET `MinMeleeDmg` = '768' , `MaxMeleeDmg` = '944' WHERE `Entry` = '10438';
UPDATE creature_template SET `MinMeleeDmg` = '315' , `MaxMeleeDmg` = '354' WHERE `Entry` = '10435';
UPDATE creature_template SET `MinMeleeDmg` = '442' , `MaxMeleeDmg` = '485' WHERE `Entry` = '10439'; 
UPDATE creature_template SET `MinMeleeDmg` = '925' , `MaxMeleeDmg` = '1103' WHERE `Entry` = '10440'; 

-- Scholomance
UPDATE creature_template SET `MinMeleeDmg` = '399' , `MaxMeleeDmg` = '430' WHERE `Entry` = '10506'; 
UPDATE creature_template SET `MinMeleeDmg` = '305' , `MaxMeleeDmg` = '336' WHERE `Entry` = '10503'; 
UPDATE creature_template SET `MinMeleeDmg` = '394' , `MaxMeleeDmg` = '425' WHERE `Entry` = '11622'; 
UPDATE creature_template SET `MinMeleeDmg` = '275' , `MaxMeleeDmg` = '305' WHERE `Entry` = '10433'; 
UPDATE creature_template SET `MinMeleeDmg` = '385' , `MaxMeleeDmg` = '416' WHERE `Entry` = '10432'; 
UPDATE creature_template SET `MinMeleeDmg` = '399' , `MaxMeleeDmg` = '432' WHERE `Entry` = '10508'; 
UPDATE creature_template SET `MinMeleeDmg` = '661' , `MaxMeleeDmg` = '752' WHERE `Entry` = '16118'; 
UPDATE creature_template SET `MinMeleeDmg` = '385' , `MaxMeleeDmg` = '416' WHERE `Entry` = '10505'; 
UPDATE creature_template SET `MinMeleeDmg` = '366' , `MaxMeleeDmg` = '391' WHERE `Entry` = '11261'; 
UPDATE creature_template SET `MinMeleeDmg` = '392' , `MaxMeleeDmg` = '426' WHERE `Entry` = '10901';
UPDATE creature_template SET `MinMeleeDmg` = '392' , `MaxMeleeDmg` = '426' WHERE `Entry` = '10507';
UPDATE creature_template SET `MinMeleeDmg` = '392' , `MaxMeleeDmg` = '426' WHERE `Entry` = '10504';
UPDATE creature_template SET `MinMeleeDmg` = '385' , `MaxMeleeDmg` = '416' WHERE `Entry` = '10502';
UPDATE creature_template SET `MinMeleeDmg` = '401' , `MaxMeleeDmg` = '432' WHERE `Entry` = '1853';
UPDATE creature_template SET `MinMeleeDmg` = '873' , `MaxMeleeDmg` = '1039' WHERE `Entry` = '14516';

-- Maraudon
UPDATE creature_template SET `MinMeleeDmg` = '422' , `MaxMeleeDmg` = '502' WHERE `Entry` = '13282'; 
UPDATE creature_template SET `MinMeleeDmg` = '422' , `MaxMeleeDmg` = '502' WHERE `Entry` = '12258'; 
UPDATE creature_template SET `MinMeleeDmg` = '411' , `MaxMeleeDmg` = '488' WHERE `Entry` = '12236'; 
UPDATE creature_template SET `MinMeleeDmg` = '422' , `MaxMeleeDmg` = '503' WHERE `Entry` = '12237'; 
UPDATE creature_template SET `MinMeleeDmg` = '434' , `MaxMeleeDmg` = '516' WHERE `Entry` = '12225'; 
UPDATE creature_template SET `MinMeleeDmg` = '446' , `MaxMeleeDmg` = '531' WHERE `Entry` = '12203'; 
UPDATE creature_template SET `MinMeleeDmg` = '446' , `MaxMeleeDmg` = '531' WHERE `Entry` = '13601'; 
UPDATE creature_template SET `MinMeleeDmg` = '446' , `MaxMeleeDmg` = '531' WHERE `Entry` = '13596'; 
UPDATE creature_template SET `MinMeleeDmg` = '526' , `MaxMeleeDmg` = '626' WHERE `Entry` = '12201'; 

-- Dire Maul
UPDATE creature_template SET `MinMeleeDmg` = '278' , `MaxMeleeDmg` = '307' WHERE `Entry` = '14354'; 
UPDATE creature_template SET `MinMeleeDmg` = '284' , `MaxMeleeDmg` = '316' WHERE `Entry` = '11490'; 
UPDATE creature_template SET `MinMeleeDmg` = '278' , `MaxMeleeDmg` = '307' WHERE `Entry` = '13280'; 
UPDATE creature_template SET `MinMeleeDmg` = '278' , `MaxMeleeDmg` = '307' WHERE `Entry` = '14327'; 
UPDATE creature_template SET `MinMeleeDmg` = '247' , `MaxMeleeDmg` = '267' WHERE `Entry` = '11492'; 
UPDATE creature_template SET `MinMeleeDmg` = '291' , `MaxMeleeDmg` = '332' WHERE `Entry` = '16097'; 
UPDATE creature_template SET `MinMeleeDmg` = '288' , `MaxMeleeDmg` = '322' WHERE `Entry` = '14326'; 
UPDATE creature_template SET `MinMeleeDmg` = '541' , `MaxMeleeDmg` = '643' WHERE `Entry` = '14322'; 
UPDATE creature_template SET `MinMeleeDmg` = '288' , `MaxMeleeDmg` = '322' WHERE `Entry` = '14321'; 
UPDATE creature_template SET `MinMeleeDmg` = '288' , `MaxMeleeDmg` = '322' WHERE `Entry` = '14323'; 
UPDATE creature_template SET `MinMeleeDmg` = '595' , `MaxMeleeDmg` = '708' WHERE `Entry` = '14325'; 
UPDATE creature_template SET `MinMeleeDmg` = '873' , `MaxMeleeDmg` = '1039' WHERE `Entry` = '11501'; 
UPDATE creature_template SET `MinMeleeDmg` = '854' , `MaxMeleeDmg` = '1015' WHERE `Entry` = '14324'; 
UPDATE creature_template SET `MinMeleeDmg` = '391' , `MaxMeleeDmg` = '425' WHERE `Entry` = '11489'; 
UPDATE creature_template SET `MinMeleeDmg` = '384' , `MaxMeleeDmg` = '416' WHERE `Entry` = '11488'; 
UPDATE creature_template SET `MinMeleeDmg` = '391' , `MaxMeleeDmg` = '423' WHERE `Entry` = '11487'; 
UPDATE creature_template SET `MinMeleeDmg` = '272' , `MaxMeleeDmg` = '299' WHERE `Entry` = '11467'; 
UPDATE creature_template SET `MinMeleeDmg` = '400' , `MaxMeleeDmg` = '435' WHERE `Entry` = '11496'; 
UPDATE creature_template SET `MinMeleeDmg` = '914' , `MaxMeleeDmg` = '1088' WHERE `Entry` = '14506'; 
UPDATE creature_template SET `MinMeleeDmg` = '854' , `MaxMeleeDmg` = '1015' WHERE `Entry` = '11486'; 

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
		IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
		ELSE
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
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

DROP PROCEDURE IF EXISTS `update_mangos`;
