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
    SET @cOldStructure = '04';
    SET @cOldContent = '033';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '04';
    SET @cNewContent = '034';
                            -- DESCRIPTION IS 30 Characters MAX
    SET @cNewDescription = 'Fishing_And_Creature_Fixes';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Murloc Scout ranged weapon; Loch Modan fishing loot fix; add fishing for 5 missing zones; fix Feralas loot; fix Spotted Yellowtail vendor stack.';

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

    -- Murloc Scout (entry 578) uses EventAI script to cast Shoot (spell 6660) as a ranged attack,
    -- but had no ranged weapon equipped, resulting in no visible projectile animation.
    -- Equip with Monster Throwing Spear (item 5870) in the ranged slot.
REPLACE INTO `creature_equip_template` (`entry`, `equipentry1`, `equipentry2`, `equipentry3`) VALUES (578, 0, 0, 5870);
UPDATE `creature_template` SET `EquipmentTemplateId`=578 WHERE `entry`=578;

    -- Fishing loot drop rates below are sourced from epochhead.com/fishing/<zone-name>,
    -- a community database with empirical catch data from the Epoch private server.

    -- Zone 38 (Loch Modan) previously had a single fishing_loot_template entry:
    -- Raw Loch Frenzy (6317) at 25% with groupid=0 (standalone), causing empty loot
    -- windows 75% of the time and never producing "fish got away" (zone_skill=-20
    -- means any fishing skill guarantees a catch). Drop rates sourced from
    -- epochhead.com/fishing/loch-modan (485 attempts, 589 catches).

    -- Remove the old broken entry.
DELETE FROM `fishing_loot_template` WHERE `entry` = 38;

    -- Add the main fish reference (always fires, selects one fish from ref template 11038).
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(38, 11038, 100, 1, -11038, 1, 0);

    -- Add bonus items as independent drops alongside the main fish.
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(38, 20709,  7,    0, 1, 1, 0),  -- Rumsey Rum Light        (7.22% per cast)
(38, 20708,  5,    0, 1, 1, 0),  -- Tightly Sealed Trunk    (4.95% per cast)
(38,  3820,  3,    0, 1, 1, 0),  -- Stranglekelp            (3.30% per cast)
(38,  6645,  1,    0, 1, 1, 0),  -- Bloated Mud Snapper     (0.82% per cast)
(38,  3385,  1,    0, 1, 1, 0),  -- Lesser Mana Potion      (0.62% per cast)
(38,  6310,  0.5,  0, 1, 1, 0),  -- 19 Pound Catfish        (0.41% per cast)
(38,   818,  0.25, 0, 1, 1, 0),  -- Tigerseye               (0.21% per cast)
(38,   858,  0.25, 0, 1, 1, 0),  -- Lesser Healing Potion   (0.21% per cast)
(38,  6309,  0.25, 0, 1, 1, 0);  -- 17 Pound Catfish        (0.21% per cast)

    -- Create reference loot template 11038: Loch Modan fish distribution (groupid=1).
    -- ExplicitlyChanced items are rolled sequentially; the final item (Oily Blackmouth)
    -- uses chance=0 (EqualChanced) to catch the remaining ~6.8% of rolls.
REPLACE INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(11038,  6289, 34.2, 1, 1, 1, 0),  -- Raw Longjaw Mud Snapper      (35.26% of catches)
(11038,  6308, 21.2, 1, 1, 1, 0),  -- Raw Bristle Whisker Catfish  (21.86% of catches)
(11038,  6317, 15.6, 1, 1, 1, 0),  -- Raw Loch Frenzy              (16.08% of catches)
(11038,  6291, 14.0, 1, 1, 1, 0),  -- Raw Brilliant Smallfish      (14.43% of catches)
(11038, 21071,  8.2, 1, 1, 1, 0),  -- Raw Sagefish                  (8.45% of catches)
(11038,  6358,  0,   1, 1, 1, 0);  -- Oily Blackmouth               (7.01% of catches, equal-chance remainder)

    -- Zone 36 (Alterac Mountains): was completely missing. Mid-to-high level inland
    -- freshwater zone (level 30-42). Uses reference template 11006 (Bristle Whisker Catfish
    -- base), consistent with same-tier zones Arathi Highlands (45) and Desolace (405).
DELETE FROM `fishing_loot_template` WHERE `entry` = 36;
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(36, 11006, 100, 1, -11006, 1, 0);

    -- Zone 46 (Searing Gorge): was completely missing. High-level zone (level 43-54).
    -- Uses reference template 11008 (Nightfin Snapper/Sunscale Salmon base), consistent
    -- with same-tier zones Hinterlands (47) and Felwood (361).
DELETE FROM `fishing_loot_template` WHERE `entry` = 46;
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(46, 11008, 100, 1, -11008, 1, 0);

    -- Zone 51 (Burning Steppes): was completely missing. High-level zone (level 50-58).
    -- Uses reference template 11008, same as Searing Gorge and other high-level zones.
DELETE FROM `fishing_loot_template` WHERE `entry` = 51;
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(51, 11008, 100, 1, -11008, 1, 0);

    -- Zone 357 (Feralas): had 10 direct items in groupid=1 (mincountOrRef=1, not a
    -- reference), with chances summing to only ~41.6%, causing ~58% empty fishing catches.
    -- All other zones use reference templates. Replace with reference template 11008
    -- (matching Hinterlands/Felwood fish profile) plus Winter Squid seasonal bonus,
    -- consistent with other coastal high-level zones Azshara (16) and Tanaris (440).
DELETE FROM `fishing_loot_template` WHERE `entry` = 357;
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(357, 11008, 100, 1, -11008, 1, 0),  -- main fish (always fires)
(357, 13755,  10, 0, -13755, 1, 0);  -- Winter Squid seasonal bonus (10%)

    -- Zone 400 (Thousand Needles): was completely missing. Mid-level inland zone
    -- (level 24-35). Uses reference template 11006 (Bristle Whisker Catfish base),
    -- consistent with same-tier zones Arathi Highlands (45) and Silverpine Forest (130).
DELETE FROM `fishing_loot_template` WHERE `entry` = 400;
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(400, 11006, 100, 1, -11006, 1, 0);

    -- Zone 493 (Moonglade): was completely missing. Druid-access sacred lake zone.
    -- Epochhead data shows Redgill, Sunscale Salmon, Oily Blackmouth, Mithril Head
    -- Trout, Lightning Eel, Nightfin Snapper — matching template 11008 profile.
DELETE FROM `fishing_loot_template` WHERE `entry` = 493;
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
(493, 11008, 100, 1, -11008, 1, 0);

    -- Spotted Yellowtail (item 6887) sold by Laird the Fish Vendor in Auberdine
    -- had BuyCount=1 (sold singly). Should be 5 like Striped Yellowtail (item 21552).
UPDATE `item_template` SET `BuyCount` = 5 WHERE `entry` = 6887 AND `BuyCount` = 1;

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


