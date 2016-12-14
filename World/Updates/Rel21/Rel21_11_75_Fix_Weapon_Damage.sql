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
    SET @cOldContent = '74';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '75';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'fix_Weapon_Damage';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'fix_Weapon_Damage';

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

-- fixed Weapon Damage
UPDATE item_template SET dmg_min2 = '7' , dmg_max2 = '16' WHERE entry = '10567'; 
UPDATE item_template SET dmg_min2 = '1' WHERE entry = '17753'; 
UPDATE item_template SET dmg_min2 = '1' , dmg_max2 = '5' WHERE entry = '2825'; 
UPDATE item_template SET dmg_min2 = '1' , dmg_max2 = '4' WHERE entry = '13040'; 
UPDATE item_template SET dmg_min2 = '3' , dmg_max2 = '6' WHERE entry = '6469'; 
UPDATE item_template SET dmg_min2 = '1' , dmg_max2 = '11' WHERE entry = '2099'; 
UPDATE item_template SET dmg_min2 = '1' , dmg_max2 = '4' WHERE entry = '13146'; 
UPDATE item_template SET dmg_min2 = '1' , dmg_max2 = '3' WHERE entry = '9412';
UPDATE item_template SET dmg_min2 = '2' , dmg_max2 = '4' WHERE entry = '16004';
UPDATE item_template SET dmg_min1 = '31' , dmg_max1 = '58' WHERE entry = '10567'; 
UPDATE item_template SET dmg_min1 = '47' , dmg_max1 = '88' WHERE entry = '2825'; 
UPDATE item_template SET dmg_min1 = '71' , dmg_max1 = '108' WHERE entry = '13040'; 
UPDATE item_template SET dmg_min1 = '48' , dmg_max1 = '89' WHERE entry = '13146';
-- Quillshooter
UPDATE 'item_template' SET 'spellid_1'=0, 'spelltrigger_1'=0,'dmg_type2'= 3 WHERE 'entry'=10567;
-- Dark Iron Rifle
UPDATE 'item_template' SET 'spellid_1'=0, 'spelltrigger_1'=0,'dmg_type2'= 5 WHERE 'entry'=16004;
-- Verdant keeper's Aim
UPDATE 'item_template' SET 'spellid_1'=0, 'spelltrigger_1'=0,'dmg_max2'= 4,'dmg_type2'= 3 WHERE 'entry'=17753;
-- Shell Launcher Shotgun
UPDATE 'item_template' SET 'spellid_1'=0, 'spelltrigger_1'=0,'dmg_type2'= 2 WHERE 'entry'=13146;
-- Heartseeking Crossbow
UPDATE 'item_template' SET 'spellid_1'=0, 'spelltrigger_1'=0,'dmg_type2'= 5 WHERE 'entry'=13040;
-- Galgann's Blaster
UPDATE 'item_template' SET 'spellid_1'=0, 'spelltrigger_1'=0,'dmg_type2'= 2 WHERE 'entry'=9412;
-- VenomStrike
UPDATE 'item_template' SET 'spellid_1'=0, 'spelltrigger_1'=0,'dmg_type2'= 3 WHERE 'entry'=6469;
-- Bow of Searing Arrows
UPDATE 'item_template' SET 'spellid_1'=0, 'spelltrigger_1'=0,'dmg_type2'= 2 WHERE 'entry'=2825;
-- Dwarven handcannon 
UPDATE 'item_template' SET 'spellid_1'=0, 'spelltrigger_1'=0,'dmg_type2'= 2 WHERE 'entry'=2099;


    

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

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;

