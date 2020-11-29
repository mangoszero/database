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
    SET @cOldContent = '029';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '14';
    SET @cNewContent = '030';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'CMangosMerge';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'CMangosMerge';

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

-- Mana Fiend (15527) - arcane damage
UPDATE `creature_template` SET `DamageSchool`='6' WHERE `Entry`='15527';


-- Fixed restock time of GO 160836 (Relic Coffer) that had default 30 sec restock time
-- This closes #53
UPDATE gameobject_template SET data2 = 3 * 60 * 60 WHERE entry = 160836;


-- Fixed reward text for quest 7266 (The Balance of Light and Shadow)
-- Thanks @MantisLord for pointing out
UPDATE quest_template SET OfferRewardText='Your tenacity and courage are astounding, $gpriest:priestess;. You have earned the right to hold the Splinter of Nordrassil. Only one task remains: The Eye of Shadow must be recovered. Scour the world.' WHERE entry=7622;


-- C'Thun tentacles
UPDATE `creature_template` SET `MinLootGold`='0', `MaxLootGold`='0' WHERE `Entry`='15334';
UPDATE `creature_template` SET `MinLootGold`='0', `MaxLootGold`='0' WHERE `Entry`='15726';
UPDATE `creature_template` SET `MinLootGold`='0', `MaxLootGold`='0' WHERE `Entry`='15589';

REPLACE INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES
('26404', '1', '15904', '0'),
('26404', '1', '15910', '0');


-- Silithus Desert Rager waypoints
UPDATE `creature` SET `position_x`='-8045.317', `position_y`='855.6702', `position_z`='5.927633', `orientation`='0.7521993', `spawntimesecs`='300', `spawndist`='0', `MovementType`='2' WHERE `guid`='46162';

SET @POINT := 0;
DELETE FROM `creature_movement` WHERE `id`='46162';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('46162', @POINT := @POINT + 1, '-8022.585', '876.9368', '2.172176000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-8006.447', '909.0712', '2.090139000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7987.618', '917.1655', '-2.07923000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7951.830', '948.0961', '1.699238000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7921.522', '979.9969', '2.378899000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7910.272', '1015.631', '0.260562700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7887.458', '1051.221', '-0.85247120', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7884.939', '1079.010', '3.711354000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7857.702', '1109.327', '4.415514000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7859.641', '1143.647', '3.261113000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7880.210', '1157.769', '0.388845800', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7919.751', '1186.201', '1.785163000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7928.635', '1218.761', '-0.04938245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7929.441', '1246.068', '-4.02060600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7954.325', '1253.593', '-2.41060400', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7968.536', '1283.847', '-6.96792700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7985.560', '1288.578', '-4.16031000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-8010.808', '1320.621', '-6.88121200', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-8024.723', '1347.410', '-6.15563600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-8041.958', '1377.362', '-4.07812900', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-8024.723', '1347.410', '-6.15563600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-8010.808', '1320.621', '-7.18977100', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7985.560', '1288.578', '-4.16031000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7968.536', '1283.847', '-6.96792700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7954.325', '1253.593', '-2.41060400', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7929.441', '1246.068', '-4.02060600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7928.635', '1218.761', '-0.04938245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7919.751', '1186.201', '1.785163000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7880.210', '1157.769', '0.388845800', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7859.641', '1143.647', '3.261113000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7857.702', '1109.327', '4.415514000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7884.939', '1079.010', '3.711354000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7887.458', '1051.221', '-0.85247120', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7910.272', '1015.631', '0.260562700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7921.522', '979.9969', '2.378899000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7951.830', '948.0961', '1.699238000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-7987.618', '917.1655', '-2.07923000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-8006.447', '909.0712', '2.090139000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-8022.585', '876.9368', '2.172176000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46162', @POINT := @POINT + 1, '-8042.387', '851.9227', '6.090662000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `position_x`='-8048.763', `position_y`='1693.516', `position_z`='8.242535', `orientation`='6.184236', `spawntimesecs`='300', `spawndist`='0', `MovementType`='2' WHERE `guid`='46163';

SET @POINT := 0;
DELETE FROM `creature_movement` WHERE `id`='46163';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('46163', @POINT := @POINT + 1, '-8010.479', '1689.703', '7.81325000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7965.536', '1678.660', '-2.0200630', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7916.718', '1669.907', '-2.5061470', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7896.167', '1641.877', '0.20778040', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7892.074', '1596.901', '0.67733350', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7918.715', '1574.599', '-0.4602141', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7882.705', '1555.979', '-0.7998466', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7849.170', '1550.501', '-0.1495302', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7817.004', '1547.087', '-0.3931077', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7789.861', '1576.263', '0.39980820', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7753.563', '1558.379', '1.82247500', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7741.675', '1517.828', '-1.8862790', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7723.951', '1490.017', '2.73659700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7691.932', '1478.855', '4.34895300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7649.387', '1475.625', '5.98139200', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7691.932', '1478.855', '4.34895300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7723.865', '1489.888', '2.71132900', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7741.675', '1517.828', '-1.8862790', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7753.563', '1558.379', '1.82247500', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7789.861', '1576.263', '0.39980820', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7817.004', '1547.087', '-0.3931077', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7849.100', '1550.502', '-0.3245790', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7882.705', '1555.979', '-0.7998466', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7918.715', '1574.599', '-0.4602141', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7892.074', '1596.901', '0.67733350', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7896.167', '1641.877', '0.20778040', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7916.718', '1669.907', '-2.5061470', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-7965.536', '1678.660', '-2.0200630', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-8010.479', '1689.703', '7.81325000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('46163', @POINT := @POINT + 1, '-8048.308', '1693.605', '8.25345700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');


-- Lady Onyxia - update model
UPDATE `creature_template` SET `ModelId1`='17251' WHERE `Entry`='12756';


-- Fixed caps in OfferRewardText of quest 9131 (Binding of the Dreadnaught)
UPDATE quest_template SET OfferRewardText='This will do, for now. If you get more, you know where to find me.' WHERE entry=9131;


-- Added missing waypoint for creature 43527 in LBRS
DELETE FROM creature_movement WHERE id=43527 AND POINT=5;
INSERT INTO creature_movement (id,POINT,position_x,position_y,position_z,orientation) VALUES
(43527,5, -17.082922,-460.110382,16.551907, 0.109955);


-- Ohgan
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `CreatureTypeFlags`='12', `SpeedWalk`='1', `HealthMultiplier`='30', `DamageMultiplier`='17', `ArmorMultiplier`='1', `MinMeleeDmg`='83.1', `MaxMeleeDmg`='110.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1600' WHERE `Entry`='14988';

-- Bloodlord Mandokir
UPDATE `creature_template` SET `SpeedWalk`='1', `DamageMultiplier`='17', `MinMeleeDmg`='137.3', `MaxMeleeDmg`='182.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `RangedBaseAttackTime`='2500' WHERE `Entry`='11382';

-- Spawn of Mar'li
REPLACE INTO `creature_template_addon` (`entry`, `auras`) VALUES ('15041', '24087');

UPDATE `creature_template` SET `MinLevel`='60', `SpeedWalk`='1', `HealthMultiplier`='2', `DamageMultiplier`='5', `ArmorMultiplier`='1', `MinMeleeDmg`='72.7', `MaxMeleeDmg`='96.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `RangedBaseAttackTime`='1400' WHERE `Entry`='15041';


-- Ossirian Crystal
UPDATE `gameobject_template` SET `type`='10', `data10`='25186' WHERE `entry`='180619';


-- Flightmasters
UPDATE `creature_template` SET `healthmultiplier`='3', `armormultiplier`='1' WHERE `Entry`='15177';
UPDATE `creature_template` SET `healthmultiplier`='3', `armormultiplier`='1' WHERE `Entry`='15178';
UPDATE `creature_template` SET `healthmultiplier`='3', `armormultiplier`='1' WHERE `Entry`='16227';
UPDATE `creature_template` SET `healthmultiplier`='3', `armormultiplier`='1' WHERE `Entry`='10583';
UPDATE `creature_template` SET `rank`='0', `healthmultiplier`='1.15', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2835';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='13177';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='12740';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='10897';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='11138';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='11139';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='11899';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='11900';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='11901';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='12577';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='12578';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='12596';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='12616';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='12617';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='12636';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='10378';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2851';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2858';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2859';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2861';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2941';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2995';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='3305';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='3310';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='3615';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='3838';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='3841';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='4267';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='4312';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='4314';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='4317';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='4319';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='4321';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='4407';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='4551';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='6026';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='6706';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='6726';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='7823';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='7824';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='8018';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='8019';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='8020';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='8609';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='8610';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='1387';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='1571';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='1572';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='1573';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2226';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2299';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2389';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2409';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='2432';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='352';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='523';
UPDATE `creature_template` SET `healthmultiplier`='3', `powermultiplier`='3', `armormultiplier`='1' WHERE `Entry`='931';


-- Naxxramas - Tesla Coil template
UPDATE `gameobject_template` SET `size`='1.780591', `data5`='1' WHERE `entry`='181477';

-- Naxxramas - Sapphiron
UPDATE `creature_template` SET `SpeedWalk`=(2.5 / 2.5), `SpeedRun`=(15 / 7) WHERE `Entry`='15989';

REPLACE INTO `creature_template_addon` (`entry`, `auras`) VALUES
('15989', '19818'),
('17025', '29327');

REPLACE INTO `creature_template` (`Entry`, `Name`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `ModelId3`, `ModelId4`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `SchoolImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES
('17025', 'Sapphiron\'s Wing Buffet', '60', '60', '15880', '0', '0', '0', '114', '114', '0', '0', '10', '3', '3', '0', '0', '33554944', '0', '0', '0', (2.5 / 2.5), (8 / 7), '1', '0', '1.35', '1', '1', '1', '1', '1', '4120', '4120', '0', '0', '103.9', '137.9', '0', '0', '3791', '252', '26', '2000', '2000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


-- Quests: Hallowed Scroll, Glyphic Scroll, Encrypted Scroll
UPDATE `quest_template` SET `PrevQuestId`='364' WHERE `entry` IN ('3098', '3097', '3096');


-- AQ40 - The Master's Eye
UPDATE `creature_template` SET `UnitFlags`='768', `CreatureTypeFlags`='4' WHERE `Entry`='15963';
UPDATE `creature_template_addon` SET `auras`='18430' WHERE `entry`='15963';
UPDATE `creature` SET `position_x`='-8953.297', `position_y`='1233.641', `position_z`='-99.71796', `orientation`='5.305801' WHERE `guid`='88072';


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
