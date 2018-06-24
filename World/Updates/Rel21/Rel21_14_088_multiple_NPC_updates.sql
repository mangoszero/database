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
    SET @cOldStructure = '14'; 
    SET @cOldContent = '087';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '14';
    SET @cNewContent = '088';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'multiple NPC updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'multiple NPC updates';

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

    -- Update drop rate of Flatland Cougar Femur for Quest Mazzranche to correct 7 percent
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-7 WHERE `Item`=4805 AND `entry`=3035;

	-- Update drop rate of Swoop Gizzard to 5%,7%,8% from respective droppers for Quest Mazzranche
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-5 WHERE `Item`=4807 AND `entry`=2969;
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-7 WHERE `Item`=4807 AND `entry`=2970;
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-8 WHERE `Item`=4807 AND `entry`=2971;

	-- Update drop rate of Prarie Wolf Heart to 7 percent 9 percent 10 percent for droppers for Quest Mazzranche
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-7 WHERE `Item`=4804 AND `entry`=2958;
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-9 WHERE `Item`=4804 AND `entry`=2959;
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-10 WHERE `Item`=4804 AND `entry`=2960;

	-- Update drop rate of Plainstrider Scale to 6 percent 8 percent 9 percent for droppers for Quest Mazzranche
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-6 WHERE `Item`=4806 AND `entry`=2956;
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-8 WHERE `Item`=4806 AND `entry`=2957;
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-9 WHERE `Item`=4806 AND `entry`=3068;

	-- Update location of Korklar Stormer that was making it impossible to kill them since they spawned under the floor.
	UPDATE `creature` SET `position_z`='95.077' WHERE `guid`=20534;

	-- Update Shadowguard so it works correctly
	UPDATE `spell_proc_event` SET `SchoolMask`= 127, `procFlags`=20088, `Cooldown`=3 WHERE `entry`=18137;

	-- Fix Starving Mountain Lion having stealth and correct loot rate for Mountain Lion Blood
	UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-33 WHERE `entry`=2384 AND `item`=3496;

	-- Fix Magistrate Burnside casting AOE spells on ranged chars.
	UPDATE `creature_ai_scripts` SET `event_type` = 9, `event_param1` = 0 WHERE `id` = 233510;

	-- Fix Galak Windchaser stuck in pillar
	UPDATE `creature` SET `position_x` = -5182.99, `position_y` = -2491.24, `position_z` = -51.9351, `orientation` = 0.921129 WHERE `guid` = 20990;
				
	-- Remove permanent Treant ally spawns.
	DELETE FROM `creature` WHERE `id` IN (5806);

	-- Fix Barrens Alliance Outrider Elites
	DELETE FROM `creature_linking_template` WHERE `master_entry` IN (5797);
	INSERT INTO `creature_linking_template` (`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES 
	(5798, 1, 5797, 3, 15),
	(5799, 1, 5797, 3, 15),
	(5800, 1, 5797, 3, 15);

	-- FIX RFC Trogg's flee at 20%
	DELETE FROM `creature_ai_scripts` WHERE `id` IN (1131802,1131911);
	INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES 
	(1131802, 11318, 2, 0, 100, 0, 25, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragefire Trogg - Flee at 20%'),
	(1131911, 11319, 2, 0, 100, 0, 15, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragefire Shaman - Flee at 0-15% Health');
					
	-- Fix Lord Melenas spawn point. (Credit: Trinitycore)
	SET @guid := (SELECT MAX(guid) FROM `creature`);
	DELETE FROM `creature` WHERE `id` = 2038;
	INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`, 
	`spawntimesecs`, `curhealth`, `curmana`, `MovementType`  ) VALUES
	(@guid+1, 2038, 1, 1013, 10107.1, 1206.24, 1311.55, 4.46804, 300, 155, 165, 0),
	(@guid+2, 2038, 1, 1013, 10127.8, 1202.00, 1323.30, 3.01113, 300, 155, 165, 0),
	(@guid+3, 2038, 1, 1013, 10127.3, 1125.23, 1338.11, 3.58055, 300, 155, 165, 0);

	SET @poolentry := (SELECT MAX(entry) FROM `pool_template`);
		INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
	(@poolentry+1, 1, 'Spawn pool for Lord Melenas');

	INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES
	(@guid+1, @poolentry+1, 'Lord Melenas spawn #1'),
	(@guid+2, @poolentry+1, 'Lord Melenas spawn #2'),
	(@guid+3, @poolentry+1, 'Lord Melenas spawn #3');
					
	-- Update Ashenvale Outrunner run speed
	UPDATE `creature_template` SET `SpeedRun`=1.14286 WHERE `Entry`=12856;
				
	-- Update Torek's Assault Grunts to run with him
	DELETE FROM `creature_linking` WHERE `guid` IN (32378,32379,32380) OR `master_guid` = 32373;
	INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES 
	(32378, 32373, 513),
	(32379, 32373, 513),
	(32380, 32373, 513);


    

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

