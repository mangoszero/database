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
    SET @cNewDescription = 'loot_and_npc_fixes';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'multiple_loot_fixes_and_other_fixes';

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
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-7' WHERE `Item`=4805 AND `entry`=3035;
			-- Update drop rate of Swoop Gizzard to 5%,7%,8% from respective droppers for Quest Mazzranche
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-5' WHERE `Item`=4807 AND `entry`=2969;
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-7' WHERE `Item`=4807 AND `entry`=2970;
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-8' WHERE `Item`=4807 AND `entry`=2971;
			-- Update drop rate of Prarie Wolf Heart to 7 percent 9 percent 10 percent for droppers for Quest Mazzranche
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-7' WHERE `Item`=4804 AND `entry`=2958;
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-9' WHERE `Item`=4804 AND `entry`=2959;
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-10' WHERE `Item`=4804 AND `entry`=2960;
			-- Update drop rate of Plainstrider Scale to 6 percent 8 percent 9 percent for droppers for Quest Mazzranche
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-6' WHERE `Item`=4806 AND `entry`=2956;
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-8' WHERE `Item`=4806 AND `entry`=2957;
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-9' WHERE `Item`=4806 AND `entry`=3068;
			-- Update location of Korklar Stormer that was making it impossible to kill them since they spawned under the floor.
				UPDATE `creature` SET `position_z`='97.1452' WHERE `guid`=20534;
			-- Update Shadowguard so it works correctly
				UPDATE `spell_proc_event` SET `SchoolMask`='127', `procFlags`='20088', `Cooldown`='3' WHERE `entry`='18137';
			-- Fix Starving Mountain Lion having stealth and correct loot rate for Mountain Lion Blood
				DELETE FROM `creature_ai_scripts` WHERE `id`=238401;
				UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-33 WHERE `entry`=2384 AND `item`=3496;
			-- Fix Magistrate Burnside casting AOE spells on ranged chars.
				REPLACE INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (233510, 2335, 9, 0, 100, 1, 0, 3, 16000, 20000, 11, 7739, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Burnside - Cast Inferno Shell');
			-- Fix Galak Windchaser stuck in pillar
				REPLACE INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (20990, 4096, 1, 9412, 0, -5182.99, -2491.24, -51.9351, 0.921129, 300, 5, 0, 583, 618, 0, 1);
			-- Fix Treant Ally and removes ones that shouldn't be there.
				INSERT INTO `creature_linking_template` (`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES (5806, 1, 4057, 513, 15);
				REPLACE INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (405701, 4057, 11, 0, 100, 0, 0, 0, 0, 0, 12, 5806, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Cenarius - Summon Treant Ally on Spawn');
				REPLACE INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `ModelId3`, `ModelId4`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `SchoolImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (5806, 'Treant Ally', '', 22, 23, 9590, 0, 0, 0, 124, 124, 0, 0, 4, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1.14286, 1, 0, 0.932384, 0, 1, 1, 1, 1, 524, 613, 0, 0, 102, 131, 68.4288, 94.0896, 940, 54, 100, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 23, 23, 46, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
				DELETE FROM `creature` WHERE `guid` IN (29974,29975,29977,29978,29980);
			-- Fix Barrens Alliance Outrider Elites
				INSERT INTO `creature_linking_template` (`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES (5798, 1, 5797, 513, 5);
				INSERT INTO `creature_linking_template` (`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES (5799, 1, 5798, 513, 5);
				INSERT INTO `creature_linking_template` (`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES (5800, 1, 5799, 513, 5);
			-- Fix RFC Searing Blade Warlock not summoning voidwalker
				UPDATE `creature_ai_scripts` SET `action1_param1`=23501 WHERE `id`=1132402;
			-- FIX RFC Trogg's flee at 20%
				INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (1131802, 11318, 2, 0, 100, 0, 25, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragefire Trogg - Flee at 20%');
				INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (1131911, 11319, 2, 0, 100, 0, 25, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragefire Shaman - Flee at 20%');
			-- Fix Lord Melenas spawn point.
				UPDATE `creature` SET `position_x`=10171.00, `position_y`=1180.34, `position_z`=1329.80, `orientation`=5.4977, `spawntimesecs`=600 WHERE `guid`=49850;
			-- Update Ashenvale Outrunner run speed
				UPDATE `creature_template` SET `SpeedRun`=1.14286 WHERE `Entry`=12856;
			-- Update Torek's Assault Grunts to run with him
				INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES (32378, 32373, 513);
				INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES (32379, 32373, 513);
				INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES (32380, 32373, 513);
			-- Update Hillsbrad Named mobs to call for help when they aggro.
				INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (240402, 2404, 4, 0, 100, 0, 0, 0, 0, 0, 39, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Blacksmith Verringtan - Call for Help on Aggro');
				INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (244802, 2448, 4, 0, 100, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Clerk Horrace Whitesteed - Call for Help on Aggro');
				INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (23201, 232, 4, 0, 100, 0, 0, 0, 0, 0, 39, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Farmer Ray - Call For Help On Aggro');
				INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (240302, 2403, 4, 0, 100, 0, 0, 0, 0, 0, 39, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Farmer Getz - Call for Help On Aggro');
				INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (242702, 2427, 4, 0, 100, 0, 0, 0, 0, 0, 39, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jailor Eston - Call for help on aggro');
				INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (242810, 2428, 4, 0, 100, 0, 0, 0, 0, 0, 39, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jailor Marlgen - Call for help on aggro');





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
