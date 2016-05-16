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
    SET @cOldContent = '24'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '25';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'quest_item_drop_fixes';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'quest_item_drop_fixes';

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


-- ----------------------------
-- Updates of creature_loot_template
-- ----------------------------

-- Old gorilla --- valley mist misty valley orangutan visceral
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='1557') AND (`item`='3919');

-- Giant Owl --- giant wing wing owl feathers
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='1995') AND (`item`='3411');

-- Giant Owl --- wing evil giant owl wing feathers
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='1996') AND (`item`='3411');

-- Giant Owl --- giant wing wing hunting owl feathers
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='1997') AND (`item`='3411');

-- Woods lurk --- woods spider silk
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='1998') AND (`item`='3412');

-- Woods tarantula spider silk woods ---
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='1999') AND (`item`='3412');

-- Woods spider webs spider silk woods ---
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2000') AND (`item`='3412');

-- Giant spider --- woods woods spider silk
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-100' WHERE (`entry`='2001') AND (`item`='3412');

-- I'm fine Stomper --- moss of tumor
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2027') AND (`item`='5170');

-- I'm fine moss muddy beast --- the tumor
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2029') AND (`item`='5170');

-- I'm fine moss of tumor elders ---
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2030') AND (`item`='5170');

-- Old Nightsaber --- Nightsaber teeth
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2033') AND (`item`='3409');

-- Wild Nightsaber --- Nightsaber teeth
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-100' WHERE (`entry`='2034') AND (`item`='3409');

-- Nightsaber --- Nightsaber teeth
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2042') AND (`item`='3409');

-- Yaiba predator --- Nightsaber teeth
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2043') AND (`item`='3409');

-- Broken Ridge Ogre --- dirty knuckles
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2252') AND (`item`='2843');

-- Broken Ridge Ogre --- regained books
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2252') AND (`item`='3658');

-- Broken Ridge Manbing --- dirty knuckles
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2253') AND (`item`='2843');

-- Broken Ridge Manbing --- regained books
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2253') AND (`item`='3658');

-- Broken Ridge abuser --- dirty knuckles
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2254') AND (`item`='2843');

-- Broken Ridge abuser --- regained books
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2254') AND (`item`='3658');

-- Broken Ridge Master --- dirty knuckles
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2255') AND (`item`='2843');

-- Broken Ridge Master --- regained books
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2255') AND (`item`='3658');

-- Broken Ridge performer --- dirty knuckles
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2256') AND (`item`='2843');

-- Broken Ridge performer --- regained books
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2256') AND (`item`='3658');

-- Broken Ridge militants --- dirty knuckles
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2287') AND (`item`='2843');

-- Broken Ridge militants regained books ---
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2287') AND (`item`='3658');

-- Predator Ridge --- dirty broken knuckles
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='2416') AND (`item`='2843');

-- Predator Ridge broken --- regained books
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-100' WHERE (`entry`='2416') AND (`item`='3658');

-- Wu Wing Harpy Wings Harpy --- witch claws
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='3276') AND (`item`='5064');

-- Wing Rogue --- witch witch wing Harpy's claws
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='3277') AND (`item`='5064');

-- Slayer --- witch witch wing wing Harpy's claws
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='3278') AND (`item`='5064');

-- Witch witch wing wing ambush --- Harpy's claws
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='3279') AND (`item`='5064');

-- Windcaller --- wing witch witch wing Harpy's claws
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='3280') AND (`item`='5064');

-- Venture capital company executives --- cat emerald
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-100' WHERE (`entry`='3283') AND (`item`='5097');

-- Venture capital firm oversight --- cat emerald
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-100' WHERE (`entry`='3286') AND (`item`='5097');

-- Serena Bloodfeather --- witch wing Harpy's claws
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='3452') AND (`item`='5064');

-- Fear scorpion --- salt scorpion venom
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='4139') AND (`item`='5794');

-- Fear of looters --- salt scorpion scorpion venom
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='4140') AND (`item`='5794');

-- Salt crust hardened shell turtle ---
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='4142') AND (`item`='5795');

-- Salt crust Snapjaw --- hardened shell
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='4143') AND (`item`='5795');

-- Salt crust dig hardened shell turtle ---
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='4144') AND (`item`='5795');

-- Evil thorn fear scorpion --- salt scorpion venom
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='5937') AND (`item`='5794');

-- Test Bopp La --- cat emerald
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-100' WHERE (`entry`='9336') AND (`item`='5097');

-- Twilight Rangers --- Nightsaber teeth
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-80' WHERE (`entry`='14430') AND (`item`='3409');

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
