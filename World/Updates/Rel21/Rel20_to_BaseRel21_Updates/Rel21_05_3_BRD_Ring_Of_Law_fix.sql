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
    SET @cOldStructure = '5'; 
    SET @cOldContent = '2'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '5';
    SET @cNewContent = '3';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'BRD_Ring_Of_Law';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'BRD Ring Of Law fix';

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

		-- Author: Tobschinsk

-- Fixed model used by trash mobs in the Ring of Law in Blackrock Depths
-- This updates #793
-- Thanks @Tobschinski for providing the data
UPDATE `creature_template` SET `ModelId1` = 7347, `ModelId2` = 3247, `ModelId3` = 2489 WHERE `Entry` = 8926; -- Deep Stinger
UPDATE `creature_template` SET `ModelId1` = 1195, `ModelId2` = 1954 WHERE `Entry` = 8927; -- Dark Screecher
UPDATE `creature_template` SET `ModelId1` = 8184, `ModelId2` = 9033, `ModelId3` = 3005, `ModelId4` = 2194 WHERE `Entry` = 8928; -- Burrowing Thundersnout
UPDATE `creature_template` SET `ModelId1` = 8182, `ModelId2` = 9030, `ModelId3` = 9031, `ModelId4` = 9032 WHERE `Entry` = 8925; -- Dredge Worm
UPDATE `creature_template` SET `ModelId1` = 8014, `ModelId2` = 909, `ModelId3` = 821, `ModelId4` = 520 WHERE `Entry` = 8933; -- Cave Creeper
UPDATE `creature_template` SET `ModelId1` = 7470, `ModelId2` = 9354, `ModelId3` = 9028, `ModelId4` = 9029 WHERE `Entry` = 8932; -- Borer Beetle

DELETE FROM `creature_template` WHERE `entry` IN ('5776', '5777', '5778');
INSERT INTO `creature_template` (`Entry`, `Name`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `ModelId3`, `ModelId4`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES
('5776', 'Evolving Ectoplasm (Red)', '17', '18', '4267', '0', '0', '0', '14', '14', '0', '0', '10', '3', '3', '0', '0', '64', '0', '0', '0', '1', '1.14286', '1', '1', '3', '1', '1.7', '1', '1', '1', '1158', '1251', '0', '0', '25.0', '34.8', '0', '0', '782', '64', '3', '2000', '2000', '0', '0', '0', '5776', '5776', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', ''),
('5777', 'Evolving Ectoplasm (Green)', '17', '18', '2568', '0', '0', '0', '14', '14', '0', '0', '10', '3', '3', '0', '0', '64', '0', '0', '0', '1', '1.14286', '1', '1', '3', '1', '1.7', '1', '1', '1', '1158', '1251', '0', '0', '25.0', '34.8', '0', '0', '782', '64', '3', '2000', '2000', '0', '0', '0', '5777', '5777', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', ''),
('5778', 'Evolving Ectoplasm (Black)', '17', '18', '4535', '0', '0', '0', '14', '14', '0', '0', '10', '3', '3', '0', '0', '64', '0', '0', '0', '1', '1.14286', '1', '1', '3', '1', '1.7', '1', '1', '1', '1158', '1251', '0', '0', '25.0', '34.8', '0', '0', '782', '64', '3', '2000', '2000', '0', '0', '0', '5778', '5778', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '');


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
