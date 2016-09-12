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
    SET @cOldContent = '29';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '30';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'BOE_Drop_Chance';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'BOE_Drop_Chance';

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

    -- data sources : http://en.60wdb.com

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18401';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18306';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18357';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18358';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18356';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18359';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18360';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18361';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18362';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18363';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '13280' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14327' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11490' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11492' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11489' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11488' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11467' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11496' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11487' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11486' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14326' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14322' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14321' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14323' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14325' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14324' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '11501' AND `item` = '18364';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '0.4' WHERE `entry` = '14354' AND `item` = '18364';

UPDATE reference_loot_template SET ChanceOrQuestChance = '0.05' WHERE item IN (12982,12983,12984,1483,2879,1974,12985,12987,6332,12988,1484,2567,1318,6468,2911,12990,12992,12994,12996,2271,2807,2059,3415,1121,890,1935,12997,1482,1486,2256,3413,2194,2205,2236,12989,12998,12999,1481,3021,1489,1491,4320,2292,3416,3417,4446,4454,13010,13016,2011,2800,13041,13062,2098,3414,4253,1454,1978,13011,13012,1493,13032,2549,13057,9486,9488);
UPDATE reference_loot_template SET ChanceOrQuestChance = '0.05' WHERE item IN (3203,1975,1727,13005,720,13031,9487,9490,13097,13099,2870,13131,1976,13024,2039,9485,13079,9509,13094,13114,2878,7754,4438,7786,1717,2264,776,791,8226,9508,13106,7787,12974,1488,2278,13048,13049,18948,9491,9510,7727,13127,7753,2912,2721,13019,13037,13087,7729,2877,7752,5819,9405,3020,2299,13063,7728,7730,13108,13137,9395,13033,2565,13084,13124,10332,9406,9428,2277,13045,3844,8225,13110,10582,10584,2951,9384,9385,9386,6331);
UPDATE reference_loot_template SET ChanceOrQuestChance = '0.05' WHERE item IN (1726,2262,9435,8223,13093,13105,10571,7757,10573,5756,5257,1678,934,4262,9391,6327,9420,13025,2276,13081,13103,13121,10567,7755,7759,7761,10578,9375,9378,9381,936,937,9393,1992,9718,7736,13119,1602,8006,13129,10570,10572,7758,7760,10583,10328,9396,9397,13020,1265,18238,10574,10581,9383,9392,1716,13017,4327,13038,13054,13088,13199,9424,9426,9434,13034,13042,13064,13117,13138,1722,9427,13132,1714,1718,9422,9431,13029,2802,13058);
UPDATE reference_loot_template SET ChanceOrQuestChance = '0.05' WHERE item IN (13095,13100,1715,9425,9429,13051,7938,13068,13071,13115,13145,9359,8345,8347,1713,9423,9430,9432,13026,9465,2815,13074,13082,9511,9512,10631,10634,8346,1720,9433,4090,9482,7954,13102,13128,10624,10627,13021,5616,754,4091,9480,13076,6440,13112,10623,10628,13018,13039,2040,13055,7939,9481,9483,7961,13089,13109,13134,10625,10632,13035,13043,2564,13065,9484,18709,18710,7959,18711,18712,13125,13139,862,10626,10629,8348,8349);
UPDATE reference_loot_template SET ChanceOrQuestChance = '0.05' WHERE item IN (17054,17055,13046,13066,13085,7734,11603,10630,10633,8367,13009,13030,12531,12542,13059,12549,13073,7960,11302,12400,17050,15045,18634,13008,12528,13052,12550,13126,13144,5266,13014,13027,12527,12546,13067,13111,1607,12624,1203,1721,15046,15061,15067,12535,6660,12552,18697,12555,14134,13120,13122,11608,18295,16004,16022,15057,15064,13022,12774,8190,13056,12547,12551,18698,20296,13130,18289,18296,18298,15802,13003,13013,12776,12777,13040,12532,18699,13077,16671,13091);
UPDATE reference_loot_template SET ChanceOrQuestChance = '0.05' WHERE item IN (16681,16683,14136,16697,18745,13118,16703,16710,16714,16722,12628,11607,16735,24222,16039,15048,15056,15060,15065,13036,12781,13044,18700,13070,16673,16680,16685,16696,18744,14137,16702,16713,16716,12625,16723,12631,13146,16736,19043,19044,19047,19051,19052,19056,17061,15050,13004,18638,13007,15063,15066,13047,18701,16672,16676,16684,13101,16692,18743,16705,16712,16717,13135,16724,4696,12632,16737,16999,18338,18340,18344,1973,15049,13002,15058,18671,18673,13060,18702,13072);
UPDATE reference_loot_template SET ChanceOrQuestChance = '0.05' WHERE item IN (15138,13096,18742,14138,20295,12633,9402,13001,15051,18639,15059,15062,13053,18741,18486,14139,13116,13133,12636,16007,15047,14536,13260,13015,13028,18676,18678,20480,20481,13083,21278,18736,13107,14140,13123,18504,18506,12620,18508,20665,20668,20671,20674,13000,15052,13006,18407,18408,18409,18413,12794,20476,20477,20478,20479,13075,23090,23091,23092,23093,13113,20537,20538,20539,20549,20550,20551,12618,12619,5267,20695,20696,20697,6622,13023,12783,12784,12790,12796,12797);
UPDATE reference_loot_template SET ChanceOrQuestChance = '0.05' WHERE item IN (12798,19048,19049,19050,19057,19058,19059,19998,19999,20258,20259,20261,20263,21800,21801,21802,21803,21804,21805,17015,17016,22660,23197,23199,23203,22195,22197,19921,19682,19683,19684,22756,19685,22757,19686,22758,19687,22759,19688,22760,19689,22761,19690,22762,19691,22763,19692,22764,19693,19694,19695,20720,20721,20722);


    

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

