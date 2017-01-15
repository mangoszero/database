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
    SET @cOldContent = '3'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '5';
    SET @cNewContent = '4';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'MC_Updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'a variety of fixes for MC';

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
-- MC Fixes
--

-- Lucifron
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '13031');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.2', `groupid` = '0' WHERE (`entry` = '12118' AND `item` = '34011');
UPDATE `creature_loot_template` SET `groupid` = '0' WHERE (`entry` = '12118' AND `item` = '34012');
UPDATE `creature_loot_template` SET `condition_id` = '0' WHERE `entry` = '12118';
UPDATE `reference_loot_template` SET `condition_id` = '0' WHERE `entry` = '34012';

-- Fire demon guard
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '12030');
UPDATE `creature_linking_template` SET `flag` = '1671' WHERE (`entry` = '12119' AND `map` = '409');

-- Magmadar
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.2', `groupid` = '0' WHERE (`entry` = '11982') AND (`item` = '34011');
UPDATE `creature_loot_template` SET `groupid` = '0' WHERE (`entry` = '11982') AND (`item` = '34013');
UPDATE `reference_loot_template` SET `condition_id` = '0' WHERE `entry` = '34013';

-- Gehennas
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '13030');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.2', `groupid` = '0' WHERE (`entry` = '12259') AND (`item` = '34011');
UPDATE `creature_loot_template` SET `groupid` = '0' WHERE (`entry` = '12259') AND (`item` = '34014');
UPDATE `creature_loot_template` SET `condition_id` = '0' WHERE `entry` = '12259';
UPDATE `reference_loot_template` SET `condition_id` = '0' WHERE `entry` = '34014';

-- Fire demon
UPDATE `creature_linking_template` SET `flag` = '1159' WHERE (`entry` = '11661') AND (`map` = '409');
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = '11661';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1166101', '11661', '9', '0', '100', '1', '0'   , '5'   , '5000', '9000',  '11', '15502', '1','0','0','0','0','0','0','0','0','0',' Flamewaker - Cast Sunder Armor ');
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1166102', '11661', '0', '0', '100', '1', '5000', '8000', '7000', '9000',  '11', '19730', '4','0','0','0','0','0','0','0','0','0',' Flamewaker - Cast Strike ');
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1166103', '11661', '9', '0', '100', '1', '0'   , '8'   , '9000', '12000', '11', '20277', '0','1','0','0','0','0','0','0','0','0',' Flamewaker - Cast Fist of Ragnaros');

-- Gard
UPDATE `creature_model_info` SET `bounding_radius` = '2', `combat_reach` = '2' WHERE (`modelid` = '12110');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.2', `groupid` = '0' WHERE (`entry` = '12057') AND (`item` = '34011');
UPDATE `creature_loot_template` SET `groupid` = '0' WHERE (`entry` = '12057') AND (`item` = '34015');
UPDATE `reference_loot_template` SET `condition_id` = '0' WHERE `entry` = '34015';
DELETE FROM `creature_loot_template` WHERE (`entry` = '12057') AND (`item` = '18564');

-- Fire oath by
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '5781');
UPDATE `creature_linking_template` SET `flag` = '1159' WHERE (`entry` = '12099') AND (`map` = '409');

-- Buddha Burton Baron
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '12129');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.2', `groupid` = '0' WHERE (`entry` = '12056') AND (`item` = '34011');
UPDATE `creature_loot_template` SET `groupid` = '0' WHERE (`entry` = '12056') AND (`item` = '34027');
UPDATE `creature_loot_template` SET `condition_id` = '0' WHERE `entry` = '12056';
UPDATE `reference_loot_template` SET `condition_id` = '0' WHERE `entry` = '34027';
DELETE FROM `creature_loot_template` WHERE (`entry` = '12056') AND (`item` = '18563');

-- Shazzrah
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '13032');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.2', `groupid` = '0' WHERE (`entry` = '12264') AND (`item` = '34011');
UPDATE `creature_loot_template` SET `groupid` = '0' WHERE (`entry` = '12264') AND (`item` = '34026');

-- Sulfuron pioneers
UPDATE `creature_loot_template` SET `groupid` = '0' WHERE (`entry` = '12098') AND (`item` = '34029');

-- Fire demon worship
UPDATE `creature_linking_template` SET `flag` = '1159' WHERE (`entry` = '11662') AND (`map` = '409');

-- Golemagg
UPDATE `creature_model_info` SET `bounding_radius` = '1.6', `combat_reach` = '1.6' WHERE (`modelid` = '11986');
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.2', `groupid` = '0' WHERE (`entry` = '11988') AND (`item` = '34011');
UPDATE `creature_loot_template` SET `groupid` = '0' WHERE (`entry` = '11988') AND (`item` = '34028');
UPDATE `reference_loot_template` SET `condition_id` = '0' WHERE `entry` = '34028';

-- Molten Fury dog
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '11997');
UPDATE `creature_linking_template` SET `flag` = '1191' WHERE (`entry` = '11672') AND (`map` = '409');

-- Majordomo
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '12029');
UPDATE `gameobject_loot_template` SET `groupid` = '0' WHERE (`entry` = '16719') AND (`item` = '12000');

-- Fire Fairy English
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '12002');
UPDATE `creature_linking_template` SET `flag` = '1159' WHERE (`entry` = '11664') AND (`map` = '409');
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = '11664';

-- Fire demon Physician
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '13029');
UPDATE `creature_linking_template` SET `flag` = '1159' WHERE (`entry` = '11663') AND (`map` = '409');
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = '11663';

-- Giant nugget
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '8269');
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = '11658';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1165801', '11658', '9', '0', '100', '1', '0',    '10',    '6000', '9000',  '11', '18945', '4','1','0','0','0','0','0','0','0','0',' giant nugget - cast repel ');
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1165802', '11658', '0', '0', '100', '1', '6000', '10000', '7000', '10000', '11', '18944', '0','0','0','0','0','0','0','0','0','0',' giant nugget - cast hit ');

-- Nugget Destroyer
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '12162');
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = '11659';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1165901', '11659', '9', '0', '100', '1', '0',    '10',    '7000', '10000', '11', '20276', '4','0','0','0','0','0','0','0','0','0',' nugget Destroyer - cast down ');
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1165902', '11659', '0', '0', '100', '1', '9000', '12000', '8000', '11000', '11', '19129', '0','1','0','0','0','0','0','0','0','0',' nugget Destroyer - cast severe tremor ');

-- Nugget Giants | nugget Destroyer
DELETE FROM `creature_linking` WHERE `guid` = '56700';
DELETE FROM `creature_linking` WHERE `guid` = '56701';
DELETE FROM `creature_linking` WHERE `guid` = '56702';
DELETE FROM `creature_linking` WHERE `guid` = '56703';
DELETE FROM `creature_linking` WHERE `guid` = '56704';
DELETE FROM `creature_linking` WHERE `guid` = '56705';
DELETE FROM `creature_linking` WHERE `guid` = '56706';
DELETE FROM `creature_linking` WHERE `guid` = '56707';
DELETE FROM `creature_linking` WHERE `guid` = '56708';
DELETE FROM `creature_linking` WHERE `guid` = '56709';
DELETE FROM `creature_linking` WHERE `guid` = '56710';
DELETE FROM `creature_linking` WHERE `guid` = '56711';
DELETE FROM `creature_linking` WHERE `guid` = '56712';
DELETE FROM `creature_linking` WHERE `guid` = '56713';
DELETE FROM `creature_linking` WHERE `guid` = '56714';
DELETE FROM `creature_linking` WHERE `guid` = '56715';
DELETE FROM `creature_linking` WHERE `guid` = '56716';
DELETE FROM `creature_linking` WHERE `guid` = '56717';
DELETE FROM `creature_linking` WHERE `guid` = '56718';
DELETE FROM `creature_linking` WHERE `guid` = '56719';
DELETE FROM `creature_linking` WHERE `guid` = '56747';
DELETE FROM `creature_linking` WHERE `guid` = '56748';
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56700', '56701', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56701', '56700', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56702', '56703', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56703', '56702', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56704', '56705', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56705', '56704', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56706', '56707', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56707', '56706', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56708', '56709', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56709', '56708', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56710', '56711', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56711', '56710', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56712', '56713', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56713', '56712', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56714', '56715', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56715', '56714', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56716', '56717', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56717', '56716', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56718', '56719', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56719', '56718', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56747', '56748', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56748', '56747', '5');

-- King of Fire
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '12231');

-- Lava minions
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '2172');

-- Lava Annihilator
UPDATE `creature_model_info` SET `bounding_radius` = '2', `combat_reach` = '2' WHERE (`modelid` = '12164');
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = '11665';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1166501', '11665', '0', '0', '100', '1', '5000', '5000',  '5000', '5000',  '13', '-100' , '1','0','0','0','0','0','0','0','0','0','lava Annihilator - handover target');

-- Lava persons
UPDATE `creature_model_info` SET `bounding_radius` = '2', `combat_reach` = '2' WHERE (`modelid` = '12239');
UPDATE `creature_ai_scripts` SET `action1_param1` = '25787', `comment` = 'Lava person - cast surging' WHERE (`id` = '1210101');

-- Ancient Molten vicious dog
UPDATE `creature_model_info` SET `bounding_radius` = '2', `combat_reach` = '2' WHERE (`modelid` = '12189');

-- Flame imp
UPDATE `creature_model_info` SET `bounding_radius` = '2', `combat_reach` = '2' WHERE (`modelid` = '12190');

-- Molten vicious dog
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '12168');
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = '11671';
DELETE FROM `creature_linking_template` WHERE `entry` = '11671';
INSERT INTO `creature_linking_template` (`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES ('11671', '409', '11982', '1024', '0');
DELETE FROM `creature_linking` WHERE `guid` = '56629';
DELETE FROM `creature_linking` WHERE `guid` = '56630';
DELETE FROM `creature_linking` WHERE `guid` = '56631';
DELETE FROM `creature_linking` WHERE `guid` = '56632';
DELETE FROM `creature_linking` WHERE `guid` = '56633';
DELETE FROM `creature_linking` WHERE `guid` = '56634';
DELETE FROM `creature_linking` WHERE `guid` = '56635';
DELETE FROM `creature_linking` WHERE `guid` = '56636';
DELETE FROM `creature_linking` WHERE `guid` = '56637';
DELETE FROM `creature_linking` WHERE `guid` = '56638';
DELETE FROM `creature_linking` WHERE `guid` = '56639';
DELETE FROM `creature_linking` WHERE `guid` = '56640';
DELETE FROM `creature_linking` WHERE `guid` = '56641';
DELETE FROM `creature_linking` WHERE `guid` = '56642';
DELETE FROM `creature_linking` WHERE `guid` = '56643';
DELETE FROM `creature_linking` WHERE `guid` = '56644';
DELETE FROM `creature_linking` WHERE `guid` = '56646';
DELETE FROM `creature_linking` WHERE `guid` = '56647';
DELETE FROM `creature_linking` WHERE `guid` = '56648';
DELETE FROM `creature_linking` WHERE `guid` = '56649';
DELETE FROM `creature_linking` WHERE `guid` = '56650';
DELETE FROM `creature_linking` WHERE `guid` = '56651';
DELETE FROM `creature_linking` WHERE `guid` = '56652';
DELETE FROM `creature_linking` WHERE `guid` = '56653';
DELETE FROM `creature_linking` WHERE `guid` = '56654';
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56629', '56630', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56630', '56631', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56631', '56632', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56632', '56633', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56633', '56629', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56634', '56635', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56635', '56636', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56636', '56637', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56637', '56638', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56638', '56634', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56639', '56640', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56640', '56641', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56641', '56642', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56642', '56643', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56643', '56639', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56644', '56646', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56646', '56647', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56647', '56648', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56648', '56649', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56649', '56634', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56650', '56651', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56651', '56652', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56652', '56653', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56653', '56654', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56654', '56650', '5');

-- Lava Reaver
UPDATE `creature_model_info` SET `bounding_radius` = '2', `combat_reach` = '2' WHERE (`modelid` = '12163');

-- Flame guard
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '5488');

-- Fire Walker
UPDATE `creature_model_info` SET `bounding_radius` = '1', `combat_reach` = '1' WHERE (`modelid` = '1070');

-- Lava element | lava Marauders | Flame guard | Fire Walker
DELETE FROM `creature_linking` WHERE `guid` = '56722';
DELETE FROM `creature_linking` WHERE `guid` = '56723';
DELETE FROM `creature_linking` WHERE `guid` = '56724';
DELETE FROM `creature_linking` WHERE `guid` = '56729';
DELETE FROM `creature_linking` WHERE `guid` = '56730';
DELETE FROM `creature_linking` WHERE `guid` = '56731';
DELETE FROM `creature_linking` WHERE `guid` = '56732';
DELETE FROM `creature_linking` WHERE `guid` = '56750';
DELETE FROM `creature_linking` WHERE `guid` = '56751';
DELETE FROM `creature_linking` WHERE `guid` = '56775';
DELETE FROM `creature_linking` WHERE `guid` = '56776';
DELETE FROM `creature_linking` WHERE `guid` = '56781';
DELETE FROM `creature_linking` WHERE `guid` = '56782';
DELETE FROM `creature_linking` WHERE `guid` = '56783';
DELETE FROM `creature_linking` WHERE `guid` = '56792';
DELETE FROM `creature_linking` WHERE `guid` = '56793';
DELETE FROM `creature_linking` WHERE `guid` = '56794';
DELETE FROM `creature_linking` WHERE `guid` = '56795';
DELETE FROM `creature_linking` WHERE `guid` = '56797';
DELETE FROM `creature_linking` WHERE `guid` = '56798';
DELETE FROM `creature_linking` WHERE `guid` = '56799';
DELETE FROM `creature_linking` WHERE `guid` = '91257';
DELETE FROM `creature_linking` WHERE `guid` = '91258';
DELETE FROM `creature_linking` WHERE `guid` = '91259';
DELETE FROM `creature_linking` WHERE `guid` = '91260';
DELETE FROM `creature_linking` WHERE `guid` = '91261';
DELETE FROM `creature_linking` WHERE `guid` = '91262';
DELETE FROM `creature_linking` WHERE `guid` = '91263';
DELETE FROM `creature_linking` WHERE `guid` = '91264';
DELETE FROM `creature_linking` WHERE `guid` = '91265';
DELETE FROM `creature_linking` WHERE `guid` = '91266';
DELETE FROM `creature_linking` WHERE `guid` = '91267';
DELETE FROM `creature_linking` WHERE `guid` = '91268';
DELETE FROM `creature_linking` WHERE `guid` = '91269';
DELETE FROM `creature_linking` WHERE `guid` = '91270';
DELETE FROM `creature_linking` WHERE `guid` = '91271';
DELETE FROM `creature_linking` WHERE `guid` = '91277';
DELETE FROM `creature_linking` WHERE `guid` = '91278';
DELETE FROM `creature_linking` WHERE `guid` = '91279';
DELETE FROM `creature_linking` WHERE `guid` = '91286';
DELETE FROM `creature_linking` WHERE `guid` = '91287';
DELETE FROM `creature_linking` WHERE `guid` = '91288';
DELETE FROM `creature_linking` WHERE `guid` = '91289';
DELETE FROM `creature_linking` WHERE `guid` = '91290';
DELETE FROM `creature_linking` WHERE `guid` = '91291';
DELETE FROM `creature_linking` WHERE `guid` = '91292';
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56722', '56723', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56723', '56724', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56724', '56722', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56729', '56730', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56730', '56731', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56731', '56732', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56732', '56729', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56750', '56751', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56751', '56775', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56775', '56776', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56776', '56750', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56781', '56782', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56782', '56783', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56783', '56781', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56792', '56793', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56793', '56794', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56794', '56795', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56795', '56792', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56797', '56798', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56798', '56799', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('56799', '56797', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91257', '91258', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91258', '91259', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91259', '91260', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91260', '91257', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91261', '91262', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91262', '91263', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91263', '91264', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91264', '91261', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91265', '91266', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91266', '91267', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91267', '91265', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91268', '91269', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91269', '91270', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91270', '91271', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91271', '91268', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91277', '91278', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91278', '91279', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91279', '91277', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91286', '91287', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91287', '91288', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91288', '91289', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91289', '91286', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91290', '91291', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91291', '91292', '5');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES ('91292', '91290', '5');

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
