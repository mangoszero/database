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
    SET @cOldStructure = '4'; 
    SET @cOldContent = '1'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '4';
    SET @cNewContent = '2';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'many, many updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'many, many updates';

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

        -- Many authors: 
        -- cala
        -- cyberium
        -- DDuarte
        -- Grz3s
        -- jpiolho
        -- Muehe
        -- neotmiren
        -- Scotty0100
        -- stfx
        -- Tobschinski
        -- Xfurry
        -- zingzah
                

-- AQ40
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15543';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15511';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15544';

-- AQ20
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15168';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15343';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15461';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15462';

UPDATE `creature_template` SET `ModelId1`='15465' WHERE `Entry`='15343';

UPDATE `creature` SET `position_x`='-8845.518', `position_y`='2260.144', `position_z`='21.46967', `orientation`='4.642576' WHERE `id`='15340';

UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15324';
UPDATE `creature_template` SET `FactionAlliance`='15', `FactionHorde`='15', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15168';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `RangedBaseAttackTime`='1500' WHERE `Entry`='15343';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15327';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15325';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `Scale`='0', `MeleeBaseAttackTime`='2000' WHERE `Entry`='15348';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='1300', `RangedBaseAttackTime`='1300' WHERE `Entry`='15344';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `Scale`='0', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15387';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15391';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15392';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15390';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15389';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15386';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15385';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15388';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15341';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='800', `RangedBaseAttackTime`='800' WHERE `Entry`='15323';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15320';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `Scale`='0', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='15370';
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15964';
UPDATE `creature_template` SET `FactionAlliance`='148', `FactionHorde`='148', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15335';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `Scale`='0', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15521';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15333';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='15336', `RangedBaseAttackTime`='15336' WHERE `Entry`='15336';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15319';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15318';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='1200', `RangedBaseAttackTime`='1200' WHERE `Entry`='15369';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15934';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15555';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='15339';
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60' WHERE `Entry`='15590';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15355';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15537';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='1300', `RangedBaseAttackTime`='1300' WHERE `Entry`='15538';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15461';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15462';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15338';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15340';
UPDATE `creature_template` SET `FactionAlliance`='1878', `FactionHorde`='1878', `MeleeBaseAttackTime`='1200', `RangedBaseAttackTime`='1200' WHERE `Entry`='15505';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15514';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15507';

UPDATE `creature_template` SET `MinLevel`='61' WHERE `Entry`='11338';
UPDATE `creature_template` SET `MinLevel`='60' WHERE `Entry`='11831';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15264';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15262';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15263';
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15502';
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15504';
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `RangedBaseAttackTime`='2000' WHERE `Entry`='15503';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15247';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15233';
UPDATE `creature_template` SET `MinLevel`='61', `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15230';
UPDATE `creature_template` SET `MinLevel`='60', `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15622';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='15544';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='15621';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15543';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='15511';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='1200', `RangedBaseAttackTime`='1200' WHERE `Entry`='15516';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600' WHERE `Entry`='15984';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15300';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15229';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15510';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `Scale`='0', `MeleeBaseAttackTime`='2000' WHERE `Entry`='15630';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15962';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15240';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='1300', `RangedBaseAttackTime`='1300' WHERE `Entry`='15299';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15235';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15236';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600' WHERE `Entry`='15249';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15509';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15277';
UPDATE `creature_template` SET `MinLevel`='60', `RangedBaseAttackTime`='2000' WHERE `Entry`='15316';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15275';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15276';
UPDATE `creature_template` SET `MinLevel`='63', `MaxLevel`='63', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15963';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15250';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310', `Scale`='0' WHERE `Entry`='15246';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15252';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15312';
UPDATE `creature_template` SET `FactionAlliance`='310', `FactionHorde`='310' WHERE `Entry`='15311';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='2700', `RangedBaseAttackTime`='2700' WHERE `Entry`='15517';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `MeleeBaseAttackTime`='1000', `RangedBaseAttackTime`='1000' WHERE `Entry`='15718';
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60' WHERE `Entry`='15957';
UPDATE `creature_template` SET `FactionAlliance`='35', `FactionHorde`='35', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15380';
UPDATE `creature_template` SET `FactionAlliance`='35', `FactionHorde`='35', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15379';
UPDATE `creature_template` SET `FactionAlliance`='35', `FactionHorde`='35', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15378';
UPDATE `creature_template` SET `FactionAlliance`='370', `FactionHorde`='370', `Scale`='0', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='15589';
UPDATE `creature_template` SET `Scale`='0', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15727';
UPDATE `creature_template` SET `FactionAlliance`='370', `FactionHorde`='370' WHERE `Entry`='15896';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15809';
UPDATE `creature_template` SET `MinLevel`='60', `ModelId1`='15948', `FactionAlliance`='370', `FactionHorde`='370', `Scale`='0', `MeleeBaseAttackTime`='2000' WHERE `Entry`='15334';
UPDATE `creature_template` SET `MinLevel`='60', `FactionAlliance`='16', `FactionHorde`='16', `Scale`='0', `MeleeBaseAttackTime`='1000', `RangedBaseAttackTime`='1000' WHERE `Entry`='15725';
UPDATE `creature_template` SET `MinLevel`='60', `FactionAlliance`='16', `FactionHorde`='16', `Scale`='0', `MeleeBaseAttackTime`='1000', `RangedBaseAttackTime`='1000' WHERE `Entry`='15726';
UPDATE `creature_template` SET `FactionAlliance`='370', `FactionHorde`='370', `Scale`='0', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='15728';
UPDATE `creature_template` SET `MinLevel`='60', `FactionAlliance`='16', `FactionHorde`='16', `Scale`='0', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='15802';
UPDATE `creature_template` SET `MinLevel`='63', `MaxLevel`='63', `Scale`='0' WHERE `Entry`='15904';
UPDATE `creature_template` SET `MinLevel`='63', `MaxLevel`='63', `Scale`='0' WHERE `Entry`='15910';

UPDATE `gameobject` SET `orientation`='5.340709' WHERE `id`='179148';
UPDATE `gameobject` SET `animprogress`='100' WHERE `id`='179116';

UPDATE `gameobject_template` SET `flags`='32', `size`='5' WHERE `entry`='179148';
UPDATE `gameobject_template` SET `faction`='114', `flags`='32' WHERE `entry`='179116';

UPDATE `gameobject` SET `animprogress`='100' WHERE `id`='179117';
UPDATE `gameobject` SET `animprogress`='100' WHERE `id`='176966';

UPDATE `gameobject_template` SET `faction`='114', `flags`='32' WHERE `entry`='179117';
UPDATE `gameobject_template` SET `faction`='114', `flags`='32' WHERE `entry`='176966';

UPDATE `gameobject` SET `animprogress`='100' WHERE `id`='179365';

UPDATE `gameobject_template` SET `faction`='114', `flags`='32' WHERE `entry`='179365';

UPDATE `gameobject` SET `animprogress`='100' WHERE `id`='179364';
UPDATE `gameobject` SET `animprogress`='100' WHERE `id`='176965';
UPDATE `gameobject` SET `animprogress`='100' WHERE `id`='176964';

UPDATE `gameobject_template` SET `faction`='114', `flags`='32' WHERE `entry`='179364';
UPDATE `gameobject_template` SET `faction`='114', `flags`='32' WHERE `entry`='176965';
UPDATE `gameobject_template` SET `faction`='114', `flags`='32' WHERE `entry`='176964';

UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='175533';
UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='175532';
UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='175531';
UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='175530';
UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='175529';
UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='175528';
UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='164725';

UPDATE `gameobject` SET `animprogress`='100' WHERE `id`='177807';

UPDATE `gameobject_template` SET `faction`='14', `flags`='0' WHERE `entry`='177807';

UPDATE `creature_template` SET `MeleeBaseAttackTime`='4000', `RangedBaseAttackTime`='4000' WHERE `Entry`='12435';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14456';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12557';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12422';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12420';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12416';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='13996';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='13020';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2400', `RangedBaseAttackTime`='2400' WHERE `Entry`='12467';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12463';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12465';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12464';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12468';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14022';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14024';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14025';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14023';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12017';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12459';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12458';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12457';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='16604';
UPDATE `creature_template` SET `FactionAlliance`='103', `FactionHorde`='103', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12461';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12460';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14401';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11983';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14601';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11981';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14020';
UPDATE `creature_template` SET `FactionAlliance`='14', `FactionHorde`='14', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11583';
UPDATE `creature_template` SET `FactionAlliance`='103', `FactionHorde`='103', `MeleeBaseAttackTime`='1000', `RangedBaseAttackTime`='1000' WHERE `Entry`='14605';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14668';
UPDATE `creature_template` SET `FactionAlliance`='103', `FactionHorde`='103' WHERE `Entry`='14261';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14262';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14263';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14264';
UPDATE `creature_template` SET `FactionAlliance`='103', `FactionHorde`='103' WHERE `Entry`='14302';
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='13976';
-- Fixed missing equipment of various NPCs in Blackwing Lair and Onyxia Lair
-- Thanks Tobschinski for reporting and researching. This closes #760 and closes #762 
UPDATE `creature_template` SET `EquipmentTemplateId` = 2164 WHERE `Entry` IN (14456, 12416); -- Blackwing Guardsman, Blackwing Legionnaire
UPDATE `creature_template` SET `EquipmentTemplateId` = 1427 WHERE `Entry` = 12557; -- Grethok the Controller
UPDATE `creature_template` SET `EquipmentTemplateId` = 1371 WHERE `Entry` = 12420; -- Blackwing Mage
UPDATE `creature_template` SET `EquipmentTemplateId` = 1003 WHERE `Entry` = 12459; -- Blackwing Warlock
UPDATE `creature_template` SET `EquipmentTemplateId` = 1845 WHERE `Entry` = 12457; -- Blackwing Spellbinder
UPDATE `creature_template` SET `EquipmentTemplateId` = 1428 WHERE `Entry` = 12458; -- Blackwing Taskmaster
UPDATE `creature_template` SET `EquipmentTemplateId` = 1872 WHERE `Entry` = 12422; -- Death Talon Dragonspawn
UPDATE `creature_template` SET `EquipmentTemplateId` = 1742 WHERE `Entry` = 12467; -- Death Talon Captain
UPDATE `creature_template` SET `EquipmentTemplateId` = 155 WHERE `Entry` = 12464; -- Death Talon Seether
UPDATE `creature_template` SET `EquipmentTemplateId` = 417 WHERE `Entry` IN (12461, 14261, 14262, 14263, 14264, 14265); -- Death Talon Overseer, Blue/Green/Bronze/Red/Black Drakonid
UPDATE `creature_template` SET `EquipmentTemplateId` = 2415 WHERE `Entry` IN (12017, 14302); -- Broodlord Lashlayer, Chromatic Drakonid
UPDATE `creature_template` SET `EquipmentTemplateId` = 1184 WHERE `Entry` = 14101; -- Enraged Felguard

SET @ENTRY := 2422;

DELETE FROM `creature_equip_template_raw` WHERE `entry` BETWEEN @ENTRY AND @ENTRY + 4;
INSERT INTO `creature_equip_template_raw` VALUES
(@ENTRY, 18388, 0, 0, 33490434, 0, 0, 529, 0, 0), -- lance
(@ENTRY + 1, 20300, 0, 0, 50268674, 0, 0, 529, 0, 0), -- 2H staff
(@ENTRY + 2, 19673, 0, 0, 50267138, 0, 0, 781, 0, 0), -- one hand mace
(@ENTRY + 3, 8376, 0, 0, 33488898, 0, 0, 1037, 0, 0), -- one hand big sword
(@ENTRY + 4, 6529, 6530, 0, 50266116, 50266116, 0, 1815, 1815, 0); -- bottle right and left hand

UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY WHERE `Entry` IN (12463, 12129); -- Death Talon Flamescale, Onyxian Warder
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 1 WHERE `Entry` = 12465; -- Death Talon Wyrmkin
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 2 WHERE `Entry` = 12468; -- Death Talon Hatcher
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 3 WHERE `Entry` = 12460; -- Death Talon Wyrmguard
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 4 WHERE `Entry` = 13996; -- Blackwing Technician
-- Lakeshire
-- Erin
UPDATE creature SET Spawndist = 0, MovementType = 2 WHERE guid = 6156;
DELETE FROM creature_movement WHERE id = 6156;

UPDATE creature_template SET MovementType = 2 WHERE entry = 850;
DELETE FROM creature_movement_template WHERE entry = 850;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(850,1,-9174.33,-2109.71,88.95,20000,85001,5.89073,0,0),(850,2,-9192.52,-2098.69,87.7837,0,0,2.69796,0,0),(850,3,-9208.23,-2090.51,85.3921,0,0,2.93672,0,0),
(850,4,-9220.96,-2089.61,81.1544,0,0,2.99563,0,0),(850,5,-9234.93,-2085.46,76.4945,0,0,3.5242,0,0),(850,6,-9242.56,-2096.16,73.6174,0,0,4.4274,0,0),
(850,7,-9249.78,-2122.28,65.0417,0,0,4.23341,0,0),(850,8,-9256.07,-2139.82,64.0223,0,0,4.75962,0,0),(850,9,-9254.31,-2147.89,64.0695,0,0,5.67539,0,0),
(850,10,-9238.9,-2148.92,64.3411,0,0,5.73586,0,0),(850,11,-9237.57,-2152.63,64.3492,0,0,4.67165,0,0),(850,12,-9218.89,-2155.42,64.3544,0,0,0.401173,0,0),
(850,13,-9216.46,-2151.99,64.3544,1000,85002,1.36486,0,0),(850,14,-9216.22,-2147.52,64.3544,0,0,1.57299,0,0),(850,15,-9216.22,-2147.52,64.3544,60000,85001,4.75856,0,0),
(850,16,-9218.43,-2154.78,64.3544,0,0,3.38647,0,0),(850,17,-9231.99,-2155.23,64.3576,0,0,3.21212,0,0),(850,18,-9237.01,-2157.84,64.3576,0,0,2.06465,0,0),
(850,19,-9237.87,-2149.49,64.3426,0,0,2.80273,0,0),(850,20,-9248.67,-2148.45,63.9334,0,0,2.40164,0,0),(850,21,-9256.32,-2138.6,63.8953,0,0,1.32093,0,0),
(850,22,-9251.08,-2121.47,65.2993,0,0,1.57654,0,0),(850,23,-9253.26,-2112.42,66.5815,0,0,2.24648,0,0),(850,24,-9261.04,-2106.96,66.8522,15000,85002,2.66117,0,0),
(850,25,-9251.76,-2113.45,66.6836,0,0,5.22157,0,0),(850,26,-9246.46,-2127.76,64.1511,0,0,4.62939,0,0),(850,27,-9248.61,-2135.95,63.9343,0,0,4.37257,0,0),
(850,28,-9254.32,-2148.24,64.056,0,0,4.10161,0,0),(850,29,-9271.21,-2158.97,61.1872,0,0,3.23767,0,0),(850,30,-9277.96,-2157.76,59.2388,0,0,2.87639,0,0),
(850,31,-9310.03,-2148.39,63.4841,60000,85001,2.82141,0,0),(850,32,-9300.57,-2151.61,63.3088,0,0,5.96445,0,0),(850,33,-9278.2,-2158.05,59.202,0,0,0.11559,0,0),
(850,34,-9261.5,-2157.36,64.0706,0,0,0.584478,0,0),(850,35,-9252.47,-2139.73,64.0216,0,0,1.20494,0,0),(850,36,-9244.6,-2120.1,65.1008,0,0,1.41229,0,0),
(850,37,-9242.08,-2095.47,73.8924,0,0,0.926126,0,0),(850,38,-9233.67,-2085.3,76.8089,0,0,6.22599,0,0),(850,39,-9219.75,-2090.06,81.5803,0,0,6.26762,0,0),
(850,40,-9207.11,-2090.25,85.8603,0,0,6.01079,0,0),(850,41,-9198.75,-2092.32,87.6703,0,0,5.73827,0,0),(850,42,-9174.33,-2109.71,88.95,25000,0,5.89073,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id IN (85001,85002);

INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(85001,1,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON'),
(85002,1,25,0,0,0,0,0,0,0,0,0,0,0,0,0,'RUN OFF');
-- Madison
UPDATE creature_model_info SET modelid_other_gender = 0 WHERE modelid = 257; -- should't use male model
UPDATE creature SET position_x = -9327.604, position_y = -2202.139, position_z = 61.898, orientation = 2.485968, spawndist = 0, MovementType = 2 WHERE guid = 6150;
DELETE FROM creature_movement WHERE id = 6150;
UPDATE creature_template SET MovementType = 2 WHERE entry = 848;
DELETE FROM creature_movement_template WHERE entry = 848;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(848,1,-9327.604,-2202.139,61.898,30000,84801,2.485968,0,0),(848,2,-9315.13,-2208.34,61.8977,0,0,6.15947,0,0),(848,3,-9293.39,-2209.66,61.821,0,0,0.401712,0,0),
(848,4,-9287.74,-2206.22,62.7899,0,0,1.06066,0,0),(848,5,-9281.29,-2171.65,59.6998,0,0,1.24138,0,0),(848,6,-9267.21,-2137.46,62.1799,0,0,1.15106,0,0),
(848,7,-9262.62,-2131.42,65.3403,0,0,0.903661,0,0),(848,8,-9248.75,-2116.83,66.1153,0,0,1.05681,0,0),(848,9,-9245.36,-2104.48,70.2651,0,0,1.35526,0,0),
(848,10,-9243.86,-2085.17,75.3524,0,0,1.35526,0,0),(848,11,-9239.41,-2057.41,76.8398,0,0,1.72205,0,0),(848,12,-9248.06,-2044.15,77.0034,0,0,1.84378,0,0),
(848,13,-9248.36,-2023.24,77.0013,60000,84801,1.58853,0,0),(848,14,-9248.64,-2045.46,77.0022,0,0,4.91676,0,0),(848,15,-9239.96,-2068.09,75.8833,0,0,4.69999,0,0),
(848,16,-9240.93,-2088.38,75.2944,0,0,4.6725,0,0),(848,17,-9245.53,-2099.99,71.8304,0,0,4.55862,0,0),(848,18,-9247.71,-2120.82,65.1585,0,0,4.58611,0,0),
(848,19,-9254.52,-2145.7,64.0393,0,0,4.56255,0,0),(848,20,-9255.4,-2185.46,64.0101,0,0,3.76379,0,0),(848,21,-9270.92,-2193.77,64.0897,0,0,4.53035,0,0),
(848,22,-9276.26,-2211.56,64.0588,0,0,4.10466,0,0),(848,23,-9293.97,-2213.25,61.6685,0,0,3.07815,0,0),(848,24,-9316.85,-2209.62,61.8983,0,0,2.81976,0,0),
(848,25,-9327.604,-2202.139,61.898,120000,84801,2.485968,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 84801;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(84801,1,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON');
-- Rachel & Nathan
UPDATE creature SET position_x = -9262.288086, position_y = -2204.600342, position_z = 63.933990, orientation = 3.567484, spawndist = 0, MovementType = 2 WHERE guid = 6154;
UPDATE creature SET position_x = -9262.288086, position_y = -2204.600342, position_z = 63.933990, orientation = 3.567484, spawndist = 0, MovementType = 0 WHERE guid = 6155;
DELETE FROM creature_movement WHERE id IN (6154,6155);
UPDATE creature_template SET MovementType = 2 WHERE entry = 849;
DELETE FROM creature_movement_template WHERE entry = 849;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(849,1,-9262.288086,-2204.600342,63.933990,2000,84901,3.567484,0,0),(849,2,-9282.55,-2212.77,63.4702,0,0,3.37348,0,0),(849,3,-9316.21,-2213.16,61.8981,0,0,3.07503,0,0),
(849,4,-9342.98,-2208.78,61.8981,0,0,2.00139,0,0),(849,5,-9344.81,-2183.14,61.8981,0,0,0.826432,0,0),(849,6,-9333.46,-2184.53,61.8981,0,0,4.18637,0,0),
(849,7,-9342.04,-2206.52,61.8981,0,0,5.47914,0,0),(849,8,-9326.1,-2210.98,61.8981,0,0,6.27006,0,0),(849,9,-9293.37,-2209.15,61.8213,0,0,0.311687,0,0),
(849,10,-9286.83,-2203.5,62.899,0,0,1.07195,0,0),(849,11,-9280.69,-2175.14,60.2934,0,0,1.17013,0,0),(849,12,-9270.13,-2152.55,61.1369,0,0,1.28794,0,0),
(849,13,-9264.35,-2133.3,64.3245,0,0,0.769574,0,0),(849,14,-9249.2,-2126.65,64.3418,0,0,0.193481,0,0),(849,15,-9209.35,-2136.65,63.9347,0,0,6.19989,0,0),
(849,16,-9190.63,-2136.43,63.942,0,0,5.98547,0,0),(849,17,-9184.8,-2144.66,63.9756,0,0,5.00216,0,0),(849,18,-9178.52,-2182.85,64.0438,0,0,4.63302,0,0),
(849,19,-9192.09,-2199.42,63.9338,0,0,1.98231,0,0),(849,20,-9198.02,-2179.83,63.9338,0,0,2.40328,0,0),(849,21,-9207.62,-2174.96,63.9338,0,0,3.09365,0,0),
(849,22,-9239.17,-2175.39,63.9338,0,0,3.65965,0,0),(849,23,-9247.98,-2186.89,64.0099,0,0,3.71473,0,0),(849,24,-9262.78,-2190.39,64.0897,0,0,4.22838,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 84901;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(84901,1,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON');
-- link
DELETE FROM creature_linking WHERE guid = 6155;
INSERT INTO creature_linking (guid, master_guid, flag) VALUES
(6155, 6154, 512);
-- Faction is wrongly set for quest 3642 (A Pledge for Secrecy) is was set to Alliance
-- while only Horde should be able to get it.
-- Thanks Kelzior for reporting and @Muehe for researching the issue. This closes #763 
-- Source: http://www.wowwiki.com/Quest:The_Pledge_of_Secrecy_%28Stranglethorn_Vale%29
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 3642;

UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16' WHERE `Entry`='15505';

UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8370';
UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8390';
UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8436';
UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8440';
UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8437';
UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8441';
UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8438';
UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8442';
UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8439';
UPDATE `quest_template` SET `ExclusiveGroup`='0' WHERE `entry`='8443';
-- Fixed respawn time of herbs in Dire Maul. Set respawn time to 40 min instead of 3
-- Thanks @scotty0100 for pointing and researching. This closes #765  
UPDATE `gameobject` SET `spawntimesecs` = 40 * 60 WHERE `map` = 429 AND `id` IN (176584, 142145, 142144);

DELETE FROM `creature` WHERE `guid` IN ('45813', '45814', '45815', '45816', '45817', '45758', '45759', '45812', '45822', '45821', '45820', '45811', '45819', '45760', '45809', '45761', '45810', '45818');

UPDATE `creature` SET `modelid`='0', `position_x`='-22.6325', `position_y`='-486.186', `position_z`='90.7531', `orientation`='3.14159' WHERE `guid`='45757';

DELETE FROM `creature` WHERE `guid` BETWEEN '4802' AND '4819';
INSERT INTO `creature` VALUES
('4819', '9692', '229', '0', '0', '-37.5607', '-521.641', '87.7160', '3.45575', '7200', '0', '0', '8613', '0', '0', '0'),
('4818', '9696', '229', '0', '0', '-36.2227', '-523.632', '87.4320', '3.56047', '7200', '0', '0', '2784', '0', '0', '0'),
('4802', '9583', '229', '0', '0', '-53.6383', '-442.827', '78.2854', '4.70957', '7200', '0', '0', '8883', '0', '0', '2'),
('4803', '9693', '229', '0', '0', '-72.4302', '-520.961', '82.3316', '3.40339', '7200', '0', '0', '7107', '0', '0', '0'),
('4804', '9268', '229', '0', '0', '-77.5619', '-516.932', '81.4632', '4.52040', '7200', '0', '0', '8613', '0', '0', '0'),
('4806', '9696', '229', '0', '0', '-47.1127', '-480.153', '77.9991', '2.82743', '7200', '0', '0', '2784', '0', '0', '0'),
('4807', '9692', '229', '0', '0', '-49.4956', '-482.156', '77.9991', '2.37365', '7200', '0', '0', '8613', '0', '0', '0'),
('4808', '9696', '229', '0', '0', '-51.8879', '-483.818', '77.9991', '1.88496', '7200', '0', '0', '2784', '0', '0', '0'),
('4809', '9693', '229', '0', '0', '-57.4802', '-487.082', '77.9991', '3.22886', '7200', '0', '0', '7107', '0', '0', '0'),
('4810', '9583', '229', '0', '0', '-58.8099', '-481.005', '77.9991', '4.41568', '7200', '0', '0', '8883', '0', '0', '0'),
('4811', '9268', '229', '0', '0', '-63.3201', '-485.629', '77.9991', '0.85521', '7200', '0', '0', '8613', '0', '0', '0'),
('4812', '9583', '229', '0', '0', '-56.9907', '-427.546', '77.8323', '1.44862', '7200', '0', '0', '8883', '0', '0', '0'),
('4814', '9583', '229', '0', '0', '-43.5588', '-515.171', '88.5866', '3.70166', '7200', '0', '0', '8883', '0', '0', '0'),
('4815', '9268', '229', '0', '0', '-49.6838', '-514.303', '88.3960', '5.44524', '7200', '0', '0', '8613', '0', '0', '0'),
('4816', '9693', '229', '0', '0', '-47.7750', '-520.564', '87.5643', '1.30227', '7200', '0', '0', '7107', '0', '0', '0'),
('4817', '9696', '229', '0', '0', '-38.1504', '-519.232', '88.0403', '3.36848', '7200', '0', '0', '2784', '0', '0', '0'),
('4805', '9216', '229', '0', '0', '-79.4547', '-523.615', '82.6267', '0.80285', '7200', '0', '0', '14355', '0', '0', '0'),
('4813', '9216', '229', '0', '0', '-49.0348', '-427.765', '77.8322', '1.64061', '7200', '0', '0', '14355', '0', '0', '0');

DELETE FROM `creature_movement` WHERE `id`='4802';
INSERT INTO `creature_movement` VALUES
('4802', '1', '-53.7135', '-469.510', '77.8413', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '2', '-57.2509', '-477.311', '77.9158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '3', '-61.6685', '-480.695', '77.9158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '4', '-68.0847', '-485.191', '77.9158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '5', '-76.1309', '-488.445', '77.9158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '6', '-78.7550', '-497.510', '77.9866', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '7', '-77.5000', '-506.460', '79.4722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '8', '-73.2358', '-515.496', '81.0900', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '9', '-65.7134', '-519.569', '82.9049', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '10', '-57.8619', '-517.623', '86.6360', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '11', '-50.2694', '-512.905', '88.2413', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '12', '-47.6077', '-508.537', '88.6223', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '13', '-43.8517', '-499.036', '90.1431', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '14', '-33.9322', '-488.698', '90.6663', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '15', '-43.8517', '-499.036', '90.1431', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '16', '-47.6077', '-508.537', '88.6223', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '17', '-50.2694', '-512.905', '88.2413', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '18', '-57.8619', '-517.623', '86.6360', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '19', '-65.7134', '-519.569', '82.9049', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '20', '-73.2358', '-515.496', '81.0900', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '21', '-77.5000', '-506.460', '79.4722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '22', '-78.7550', '-497.510', '77.9866', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '23', '-76.1309', '-488.445', '77.9158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '24', '-68.0847', '-485.191', '77.9158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '25', '-61.6685', '-480.695', '77.9158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '26', '-57.2509', '-477.311', '77.9158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '27', '-53.7135', '-469.510', '77.8413', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('4802', '28', '-53.3688', '-431.997', '78.2854', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

UPDATE `quest_template` SET `Objectives`='Seek out Witch Doctor Unbagwa and have him summon Mokk the Savage. Bring the Heart of Mokk to Fin Fizracket.' WHERE `entry`='348';

UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='2416';
-- -----------------
-- author: @Grz3s
-- -----------------

-- Dun Morogh - updates
-- Gnome Engineer - 2 spawns removed (should never be there)
-- Leper Gnome - movement

-- Gnome Engineer
-- should be found only in Dun Morogh airfield.
DELETE FROM creature WHERE guid IN (86178,86175);
DELETE FROM creature_addon WHERE guid IN (86178,86175);
DELETE FROM creature_movement WHERE id IN (86178,86175);
DELETE FROM game_event_creature WHERE guid IN (86178,86175);
DELETE FROM game_event_creature_data WHERE guid IN (86178,86175);
DELETE FROM creature_battleground WHERE guid IN (86178,86175);
DELETE FROM creature_linking WHERE guid IN (86178,86175) OR master_guid IN (86178,86175);

-- Leper Gnome 
UPDATE creature SET spawndist = 10, MovementType = 1 WHERE guid IN (2414,2420,2426,2422,2427,2425,2412,2416,2421,2428,2438,2441,2455,2458,2467,2468,2461,2469,2460,2451);

-- -----------------
-- author: @Killyana
-- -----------------

-- Zixil <Merchant Supreme>
-- Zixil <Merchant Supreme> and his guard will patrol between Tarren Mill and Southshore.
-- Source: TrinityCore/TrinityCore@dd0b329

UPDATE creature SET position_x = -36.31, position_y = -916.366, position_z = 55.075, orientation = 1.062, Spawndist = 0, MovementType = 2 WHERE guid = 15424;
UPDATE creature SET position_x = -37.248, position_y = -914.605, position_z = 55.343, orientation = 0.826, Spawndist = 0, MovementType = 0 WHERE guid = 15423;
DELETE FROM creature_movement WHERE id = 15424;
UPDATE creature_template SET MovementType = 2 WHERE entry = 3537;
DELETE FROM creature_movement_template WHERE entry = 3537;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(3537, 1, -36.31, -916.366, 55.075, 180000, 0, 1.062, 0, 0), 
(3537, 2, -28.532600, -902.440735, 55.908634, 0, 0, 0, 0, 0),
(3537, 3, -26.338741, -896.902466, 56.039452, 0, 0, 0, 0, 0),
(3537, 4, -51.500923, -836.734619, 56.524872, 0, 0, 0, 0, 0),
(3537, 5, -17.165236, -802.633240, 58.751846, 0, 0, 0, 0, 0),
(3537, 6, -20.983173, -719.063965, 69.290993, 0, 0, 0, 0, 0),
(3537, 7, -149.228104, -712.801025, 64.445107, 0, 0, 0, 0, 0),
(3537, 8, -226.017303, -722.711487, 60.861263, 0, 0, 0, 0, 0),
(3537, 9, -325.539337, -754.267334, 54.089657, 0, 0, 0, 0, 0),
(3537, 10, -377.870178, -776.472351, 54.472977, 0, 0, 0, 0, 0),
(3537, 11, -403.164459, -680.892700, 54.499004, 0, 0, 0, 0, 0),
(3537, 12, -331.617737, -671.147278, 54.918808, 0, 0, 0, 0, 0),
(3537, 13, -341.247772, -713.172363, 57.733025, 0, 0, 0, 0, 0),
(3537, 14, -340.614716, -711.776184, 57.733025, 120000, 0, 0, 0, 0),
(3537, 15, -325.247681, -677.673950, 54.596302, 0, 0, 0, 0, 0), 
(3537, 16, -339.869904, -673.187561, 55.012871, 0, 0, 0, 0, 0),
(3537, 17, -385.749298, -685.196350, 54.387272, 0, 0, 0, 0, 0),
(3537, 18, -413.708405, -656.887817, 54.488979, 0, 0, 0, 0, 0),
(3537, 19, -440.757660, -585.658386, 53.424225, 0, 0, 0, 0, 0),
(3537, 20, -520.923462, -558.851501, 39.920975, 0, 0, 0, 0, 0),
(3537, 21, -569.159912, -567.547302, 32.809437, 0, 0, 0, 0, 0),
(3537, 22, -594.511536, -575.940979, 31.982075, 0, 0, 0, 0, 0),
(3537, 23, -650.699402, -560.431763, 26.120964, 0, 0, 0, 0, 0),
(3537, 24, -691.624939, -568.642334, 24.540937, 0, 0, 0, 0, 0),
(3537, 25, -707.109802, -562.611023, 22.809536, 0, 0, 0, 0, 0),
(3537, 26, -724.787048, -549.384033, 20.291832, 0, 0, 0, 0, 0),
(3537, 27, -811.109985, -542.174927, 15.771987, 0, 0, 0, 0, 0),
(3537, 28, -817.549683, -533.020020, 15.160646, 180000, 0, 0, 0, 0),
(3537, 29, -811.109985, -542.174927, 15.771987, 0, 0, 0, 0, 0),
(3537, 30, -724.787048, -549.384033, 20.291832, 0, 0, 0, 0, 0),
(3537, 31, -707.109802, -562.611023, 22.809536, 0, 0, 0, 0, 0),
(3537, 32, -691.624939, -568.642334, 24.540937, 0, 0, 0, 0, 0),
(3537, 33, -650.699402, -560.431763, 26.120964, 0, 0, 0, 0, 0),
(3537, 34, -594.511536, -575.940979, 31.982075, 0, 0, 0, 0, 0),
(3537, 35, -569.159912, -567.547302, 32.809437, 0, 0, 0, 0, 0),
(3537, 36, -520.923462, -558.851501, 39.920975, 0, 0, 0, 0, 0),
(3537, 37, -440.757660, -585.658386, 53.424225, 0, 0, 0, 0, 0),
(3537, 38, -413.708405, -656.887817, 54.488979, 0, 0, 0, 0, 0),
(3537, 39, -385.749298, -685.196350, 54.387272, 0, 0, 0, 0, 0),
(3537, 40, -339.869904, -673.187561, 55.012871, 0, 0, 0, 0, 0),
(3537, 41, -325.247681, -677.673950, 54.596302, 0, 0, 0, 0, 0), 
(3537, 42, -340.614716, -711.776184, 57.733025, 120000, 0, 0, 0, 0),
(3537, 43, -341.247772, -713.172363, 57.733025, 0, 0, 0, 0, 0),
(3537, 44, -331.617737, -671.147278, 54.918808, 0, 0, 0, 0, 0),
(3537, 45, -403.164459, -680.892700, 54.499004, 0, 0, 0, 0, 0),
(3537, 46, -377.870178, -776.472351, 54.472977, 0, 0, 0, 0, 0),
(3537, 47, -325.539337, -754.267334, 54.089657, 0, 0, 0, 0, 0),
(3537, 48, -226.017303, -722.711487, 60.861263, 0, 0, 0, 0, 0),
(3537, 49, -149.228104, -712.801025, 64.445107, 0, 0, 0, 0, 0),
(3537, 50, -20.983173, -719.063965, 69.290993, 0, 0, 0, 0, 0),
(3537, 51, -17.165236, -802.633240, 58.751846, 0, 0, 0, 0, 0),
(3537, 52, -51.500923, -836.734619, 56.524872, 0, 0, 0, 0, 0),
(3537, 53, -26.338741, -896.902466, 56.039452, 0, 0, 0, 0, 0),
(3537, 54, -28.532600, -902.440735, 55.908634, 0, 0, 0, 0, 0),
(3537, 55, -38.973717, -917.010193, 55.065174, 0, 0, 1.062, 0, 0);
-- link
DELETE FROM creature_linking WHERE guid = 15423;
INSERT INTO creature_linking (guid, master_guid, flag) VALUES
(15423, 15424, 128+512);
-- Marshal Dughan 
-- Marshal Dughan - gossip added
-- missing text
-- Source: TrinityCore/TrinityCore#12615

-- Marshal Dughan
UPDATE creature_template SET npcFlags = 3, GossipMenuId = 6159 WHERE Entry = 240;
DELETE FROM gossip_menu WHERE entry = 6159; 
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(6159, 6157, 0, 0);
-- missing text added
DELETE FROM npc_text WHERE ID = 6157;
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, prob0, em0_0, em0_1) VALUES 
(6157, 'Ach, it\'s hard enough keeping order around here without all these new troubles popping up!  I hope you have good news, $n...', 'Ach, it\'s hard enough keeping order around here without all these new troubles popping up!  I hope you have good news, $n...', 0, 1, 5, 5);
-- Mountaineer Stormpike
-- Mountaineer Stormpike - gossip added and missing text
-- Source: TrinityCore/TrinityCore#12711

-- Mountaineer Stormpike
UPDATE creature_template SET npcFlags = 3, GossipMenuId = 694 WHERE entry = 1343;
DELETE FROM gossip_menu WHERE entry = 694;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(694, 1244, 0, 0);
DELETE FROM npc_text WHERE ID = 1244;
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, prob0, em0_0, em0_1) VALUES 
(1244, 'Well, if it isn\'t a young, bristling $c, no doubt drawn here by talk of my exploits in fields of battle!$B$BNo time for stories now, for there are great, important deeds that need doing!  So if you\'re looking for glory, then luck shines on you today...', 'Well, if it isn\'t a young, bristling $c, no doubt drawn here by talk of my exploits in fields of battle!$B$BNo time for stories now, for there are great, important deeds that need doing!  So if you\'re looking for glory, then luck shines on you today...', 0, 1, 0, 0);
-- Added missing spawns of rare NPC 14339 (Death Howl) in Felwood
-- Put them into a pool
-- Source: YTDB

SET @GUID := 84971;
SET @POOL := 1214;

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 1 AND @GUID + 3;
INSERT INTO `creature` VALUES
(@GUID + 1, 14339, 1, 0, 0, 4265.29, -1110.32, 319.876, 0.659343, 28800, 5, 0, 2672, 0, 0, 1),
(@GUID + 2, 14339, 1, 0, 0, 4136.53, -1137.87, 295.424, 3.21189, 28800, 5, 0, 2672, 0, 0, 1),
(@GUID + 3, 14339, 1, 0, 0, 3711.72, -1587.78, 202.667, 2.08249, 28800, 5, 0, 2672, 0, 0, 1);
UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` = 14339;

DELETE FROM `pool_creature_template` WHERE `id` = 14339;
INSERT INTO `pool_creature_template` VALUES
(14339, @POOL, 0, 'Death Howl (14339)');

DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` VALUES
(@POOL, 1, 'Death Howl (14339)');

-- Fixed gossip menu of NPC 11016 (Captured Arko'narin) in Felwood
-- Source: UDB
-- note: this script was altered because the records destined to be 332 and 333 already exists as 340 and 341
UPDATE `gossip_menu` SET `condition_id` = 340 WHERE `entry` = 3129 AND `text_id` = 4113;
DELETE FROM `gossip_menu` WHERE `entry` = 3129 AND `text_id` = 4114;
INSERT INTO `gossip_menu` VALUES
(3129, 4114, 0, 341);

-- Added missing equipment to NPC 11018 (Arko'narin) and NPC 11141 (Spirit of Trey Lightforge) in Felwood
UPDATE `creature_template` SET `EquipmentTemplateId` = 1248 WHERE `Entry` IN (11018, 11141);

-- Updated stats of NPCs 11016, 11018, 11019, 11020 & 11141 involved in quest Rescue from Jaedenar
-- Health and/or armor values were wrong or using later expansion values. They are now
-- reverted to what they were in Classic
UPDATE `creature_template` SET `MinLevelHealth` = 5361, `MaxLevelHealth` = 5361, `HealthMultiplier` = 2.6, `Armor` = 3714, `MinLootGold` = 0, `MaxLootGold` = 0, `ArmorMultiplier` = 1 WHERE `Entry` = 11018;
UPDATE `creature_template` SET `MinLevelHealth` = 4124, `MaxLevelHealth` = 4124, `HealthMultiplier` = 2, `Armor` = 2857, `ArmorMultiplier` = 1 WHERE `Entry` = 11016;
UPDATE `creature_template` SET `Armor` = 3126 WHERE `Entry` = 11141;
UPDATE `creature_template` SET `MinLevelHealth` = 3544, `MaxLevelHealth` = 3544, `HealthMultiplier` = 2, `ArmorMultiplier` = 1 WHERE `Entry` IN (11019, 11020);

UPDATE `creature_model_info` SET `modelid_other_gender`='0' WHERE `modelid`='2582';

UPDATE `creature_template` SET `SpeedWalk`='2' WHERE `Entry`='14321';
UPDATE `creature_template` SET `SpeedWalk`='2' WHERE `Entry`='14323';
UPDATE `creature_template` SET `SpeedWalk`='2' WHERE `Entry`='14326';
UPDATE `creature_template` SET `ModelId1`='14430', `SpeedWalk`=('10' / '2.5'), `SpeedRun`=('10' / '7') WHERE `Entry`='14386';
-- Added missing WP to creature 10807 (Brumeran) in Winterspring
-- Source: http://www.wowhead.com/npc=10807/brumeran#map
DELETE FROM `creature_movement_template` WHERE `entry` = 10807;
INSERT INTO `creature_movement_template` VALUES
(10807, 1, 5794.21, -4756.73, 776.631, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 2, 5767.78, -4750.23, 776.266, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 3, 5741.93, -4739.3, 776.337, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 4, 5729.39, -4728.64, 776.861, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 5, 5716.83, -4712.63, 780.549, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 6, 5701.37, -4690.78, 780.221, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 7, 5685.64, -4666.45, 775.247, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 8, 5663.94, -4633.49, 770.941, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 9, 5652.06, -4612.04, 769.91, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 10, 5605.16, -4523.35, 761.301, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 11, 5596.44, -4510.74, 761.037, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 12, 5578.46, -4501.28, 758.607, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 13, 5546.2, -4498.32, 757.152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 14, 5536.28, -4498.46, 756.273, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 15, 5548.03, -4498.12, 757.283, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 16, 5580.57, -4501.62, 758.791, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 17, 5596.8, -4510.74, 761.013, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 18, 5607.1, -4525.25, 761.14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 19, 5652.85, -4611.9, 769.809, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 20, 5663.82, -4632.54, 770.918, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 21, 5688.06, -4666.14, 775.173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 22, 5701.32, -4688.96, 779.968, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 23, 5716.02, -4709.93, 780.711, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 24, 5732.58, -4729.74, 776.94, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 25, 5743.5, -4739.83, 776.143, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 26, 5768.83, -4750.62, 776.265, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 27, 5791.36, -4756.39, 776.534, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 28, 5800.65, -4754.66, 775.339, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 29, 5810.53, -4747.72, 770.679, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 30, 5825.56, -4722.8, 761.2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 31, 5847.45, -4695.13, 756.06, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 32, 5846.56, -4653.15, 751.855, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 33, 5852.02, -4626.78, 748.715, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 34, 5857.67, -4617.24, 746.566, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 35, 5873.96, -4604.09, 740.28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 36, 5906.14, -4580.95, 726.465, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 37, 5933.6, -4552.5, 719.467, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 38, 5948.97, -4526.39, 714.178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 39, 5966, -4490.83, 706.834, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 40, 5983.18, -4454.48, 707.231, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 41, 6004.34, -4417.37, 710.368, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 42, 6043.83, -4367.21, 715.066, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 43, 6083.28, -4327.06, 725.178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 44, 6120.37, -4306.62, 731.31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 45, 6166.59, -4284.45, 744.508, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 46, 6191.89, -4270.68, 738.337, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 47, 6245.56, -4242.19, 736.044, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 48, 6307.77, -4218.71, 722.994, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 49, 6355.26, -4200.94, 713.745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 50, 6392.92, -4182.05, 703.888, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 51, 6357.57, -4201.57, 713.224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 52, 6311.36, -4220.95, 723.374, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 53, 6246.39, -4244.92, 735.806, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 54, 6192.39, -4270.93, 738.002, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 55, 6168.06, -4284.54, 744.458, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 56, 6124.04, -4304.35, 731.797, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 57, 6081.23, -4327.11, 724.821, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 58, 6044.83, -4366.46, 715.08, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 59, 6007.47, -4413.15, 710.907, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 60, 5983.53, -4455.11, 707.048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 61, 5965.38, -4490.02, 706.943, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 62, 5948.68, -4526.07, 714.223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 63, 5934.61, -4551.4, 719.322, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 64, 5907.66, -4580.78, 725.546, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 65, 5873.21, -4606.02, 740.637, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 66, 5862.26, -4614.75, 744.791, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 67, 5853.82, -4625.17, 748.087, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 68, 5845.46, -4654.04, 752.156, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 69, 5844.74, -4689.32, 755.539, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 70, 5824.63, -4722.99, 761.315, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 71, 5809.48, -4746.69, 770.559, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(10807, 72, 5799.53, -4755.23, 775.666, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);
UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` = 10807;
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 10807;

-- Moved waypoints for Ursius to creature_movement_template table
-- because this NPC is unique 
DELETE FROM `creature_movement` WHERE `id` = 41757;
DELETE FROM `creature_movement_template` WHERE `entry` = 10806;
INSERT INTO `creature_movement_template` VALUES 
(10806, 1, 7392.47, -4863.76, 717.538, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 2, 7386.98, -4854.89, 717.025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 3, 7382.2, -4849.15, 714.358, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 4, 7377.91, -4843.06, 709.955, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 5, 7374.17, -4833.31, 707.622, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 6, 7367.56, -4826.19, 706.673, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 7, 7356.6, -4819.11, 705.119, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 8, 7346.57, -4817.34, 704.422, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 9, 7338.89, -4814.45, 701.118, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 10, 7332.93, -4808.81, 695.472, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 11, 7324.25, -4803.01, 694.299, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 12, 7313.4, -4808.02, 696.404, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 13, 7304.99, -4811.13, 695.083, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 14, 7294.66, -4812.62, 688.862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 15, 7280.04, -4809.81, 685.032, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 16, 7267.66, -4804.58, 683.578, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 17, 7256.03, -4799.48, 684.846, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 18, 7246.93, -4792.95, 688.579, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 19, 7233.74, -4783.62, 692.866, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 20, 7227.48, -4781.13, 699.379, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 21, 7222.56, -4779.32, 702.658, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 22, 7214.65, -4774.53, 706.959, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 23, 7206.99, -4768.56, 715.328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 24, 7197.63, -4766.04, 718.111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 25, 7187.17, -4766.88, 722.862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 26, 7176.04, -4767.88, 726.34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 27, 7158.39, -4772.67, 728.308, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 28, 7146.15, -4775.98, 730.806, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 29, 7130.09, -4779.49, 732.639, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 30, 7119.01, -4778.06, 733.071, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 31, 7107.81, -4778.12, 736.737, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 32, 7093.41, -4773.02, 740.822, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 33, 7080.23, -4769.07, 743.451, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 34, 7063.14, -4761.69, 744.717, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 35, 7048.81, -4751.61, 741.236, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 36, 7040.23, -4731.74, 734.484, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 37, 7033.46, -4721.02, 734.604, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 38, 7022.16, -4709.08, 735.978, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 39, 7013.91, -4698.55, 739.685, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 40, 7009.08, -4688.44, 743.001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 41, 7010.87, -4675.89, 746.968, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 42, 7017.92, -4665.31, 752.719, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 43, 7020.02, -4651.64, 756.594, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 44, 7012.05, -4647.55, 755.447, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 45, 7002.2, -4644.09, 751.775, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 46, 6993.5, -4640.75, 749.158, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 47, 6980.03, -4632, 750.785, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 48, 6976.06, -4642.05, 748.789, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 49, 6994.9, -4644.68, 749.273, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 50, 7004.91, -4647.66, 753.137, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 51, 7013.32, -4650.74, 755.831, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 52, 7025.52, -4660.47, 755.501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 53, 7025.86, -4674.66, 750.418, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 54, 7024.98, -4684.34, 748.902, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 55, 7017.76, -4686.15, 747.49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 56, 7010.29, -4689.55, 742.97, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 57, 7012.05, -4702.11, 737.811, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 58, 7016.5, -4714.78, 735.262, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 59, 7020.46, -4724.02, 736.569, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 60, 7027.68, -4739.57, 739.237, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 61, 7034.47, -4752.03, 742.704, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 62, 7045.98, -4764.76, 746.637, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 63, 7058.23, -4774.53, 750.034, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 64, 7068.01, -4778.17, 749.764, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 65, 7078.76, -4779.57, 747.332, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 66, 7092.94, -4779.63, 744.443, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 67, 7105.6, -4776.52, 737.177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 68, 7115.29, -4775.7, 733.084, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 69, 7130.93, -4776.73, 731.908, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 70, 7153.58, -4774.45, 729.665, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 71, 7164.17, -4770.8, 727.533, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 72, 7174.96, -4761.62, 727.535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 73, 7184.6, -4760.66, 724.858, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 74, 7198.73, -4761.51, 719.09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 75, 7212.3, -4758.14, 717.17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 76, 7224.75, -4755.78, 710.305, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 77, 7228.49, -4758.9, 707.014, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 78, 7223.53, -4769.22, 702.701, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 79, 7220.49, -4775.61, 703.898, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 80, 7216.82, -4782.13, 703.347, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 81, 7213.77, -4789.75, 700.667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 82, 7217.39, -4793.82, 697.248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 83, 7220, -4797.1, 694.03, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 84, 7229.3, -4799.91, 690.164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 85, 7247.28, -4804.95, 686.025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 86, 7270.05, -4806.01, 683.494, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 87, 7286.59, -4803.12, 683.779, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 88, 7291.67, -4814.98, 688.04, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 89, 7297.18, -4814.11, 690.571, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 90, 7305.28, -4812.83, 695.358, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 91, 7313.95, -4810.56, 696.792, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 92, 7316.1, -4815.38, 699.242, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 93, 7312.7, -4823.64, 702.979, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 94, 7314.2, -4831.71, 706.757, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 95, 7318.58, -4832.64, 709.229, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 96, 7325.25, -4833.66, 715.018, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 97, 7332.31, -4830.25, 714.763, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 98, 7342.48, -4825.56, 709.241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 99, 7347.32, -4823.64, 707.8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 100, 7356.01, -4821.47, 705.914, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 101, 7367.44, -4826.87, 707.032, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 102, 7372.68, -4835.88, 709.016, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 103, 7378.35, -4843.68, 710.309, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 104, 7382.27, -4850.01, 715.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10806, 105, 7386.34, -4856.25, 717.67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` = 10806;
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 10806;

-- Added missing equipment to NPC 10196 (General Cobaltann) and changed its rank to rare elite
-- Added missing spawns position and added them to a pool
UPDATE `creature_template` SET `Rank` = 2, `EquipmentTemplateId` = 1747 WHERE `Entry` = 10196;

SET @GUID := 84834;
SET @POOL := 1215;

DELETE FROM `creature` WHERE `guid` IN (@GUID + 1, @GUID + 2);
INSERT INTO `creature` VALUES
(@GUID + 1, 10196, 1, 0, 1317, 6153.17, -4164.74, 797.163, 1.70246, 43200, 5, 0, 8097, 7860, 0, 1),
(@GUID + 2, 10196, 1, 0, 1317, 6189.21, -4553.49, 714.408, 1.57288, 43200, 5, 0, 8097, 7860, 0, 1);
UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` = 10196;

DELETE FROM `pool_creature_template` WHERE `id` = 10196;
INSERT INTO `pool_creature_template` VALUES
(10196, @POOL, 0, 'General Cobaltann (10196)');

DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` VALUES
(@POOL, 1, 'General Cobaltann (10196)');

-- Added missing GO 177414 (Gem of Elune), 177415 (Light of Elune), 177416 (Aura of Elune) in Winterspring
DELETE FROM `gameobject` WHERE `guid` IN (127, 128, 129, 130, 150, 151, 153, 158);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(127, 177414, 1, 5514.49, -4917.57, 850.538, 2.3911, 0, 0, 0.930417, 0.366502, -900, 100, 1),
(128, 177415, 1, 5510.28, -4929.31, 845.214, 1.62064, 0, 0, 0.724507, 0.689267, -600, 255, 1),
(129, 177415, 1, 5520.35, -4925.22, 843.644, 2.13507, 0, 0, 0.876015, 0.482283, -600, 255, 1),
(130, 177415, 1, 5526.7, -4916.41, 843.452, 3.01865, 0, 0, 0.998111, 0.0614331, -600, 255, 1),
(150, 177415, 1, 5501.69, -4920.04, 848.791, 0.155868, 0, 0, 0.0778553, 0.996965, -600, 255, 1),
(151, 177415, 1, 5505.09, -4909.36, 848.961, 5.63402, 0, 0, 0.318914, -0.947784, -600, 255, 1),
(153, 177415, 1, 5515.71, -4905.82, 846.322, 4.62478, 0, 0, 0.737392, -0.675466, -600, 255, 1),
(158, 177416, 1, 5514.49, -4917.57, 845.538, 2.3911, 0, 0, 0.930417, 0.366502, -900, 100, 1);

UPDATE `gameobject_template` SET `size` = 8 WHERE `entry` = 177414;
UPDATE `gameobject_template` SET `size` = 0.5 WHERE `entry` = 177415;
UPDATE `gameobject_template` SET `size` = 5 WHERE `entry` = 177416;
-- Fixed respawn time of minerals in Dire Maul. Set respawn time to 40 min instead of 3
-- Thanks @scotty0100 for pointing and researching. This closes #770  
UPDATE `gameobject` SET `spawntimesecs` = 40 * 60 WHERE `map` = 429 AND `id` = 175404;
-- Removed wrong GO in Dustwallow Marsh: they were added in TBC
-- There are several 'floating' Blackhoof Cages & a floating Campfire within the Bluefen area.
-- This closes #773 
-- Source for deletion for classic:
-- http://www.wowhead.com/item=33061/grimtotem-key#comments (Added 2.3)
-- http://wowwiki.wikia.com/Blackhoof_Village

/* Blackhoof Cages */
DELETE FROM gameobject WHERE guid IN (11183,11184,11185,11707,11708,11710,11719);

/* Burning Embers */
DELETE FROM gameobject WHERE guid='7633';
-- Shy-Rotam Quest and NPCs should be tameable
-- This quest was Horde only in Classic. In 2.3 it was changed to be both sides.
-- Also, both Shy-Rotam and Sian-Rotam should be tameable NPCs. SQL for fixes for these below.
-- This closes #771 
-- Source: http://www.wowhead.com/npc=10737/shy-rotam#comments

/* Set quest Shy-Rotam to be Horde only */
UPDATE quest_template SET RequiredRaces='178' WHERE entry IN ('5054', '5055', '5056');

/* Shy-Rotam ID 10737 to tameable */
UPDATE creature_template SET CreatureTypeFlags='1' WHERE Entry='10737';

/* Sian-Rotam ID: 10741 to tameable */
UPDATE creature_template SET CreatureTypeFlags='1' WHERE Entry='10741';
-- Changing spell used in companion items to implemented ones
UPDATE `item_template` SET `spellid_1`= 26529 WHERE `entry`= 21308;
UPDATE `item_template` SET `spellid_1`= 26533 WHERE `entry`= 21301;
UPDATE `item_template` SET `spellid_1`= 26536, `Flags`= 1024 WHERE `entry`= 21305;
UPDATE `item_template` SET `spellid_1`= 26045 WHERE `entry`= 21309;
-- Correcting the scale of companion npcs
UPDATE `creature_template` SET `Scale`= 0 WHERE `Entry`= 15705;
UPDATE `creature_template` SET `Scale`= 0 WHERE `Entry`= 15710;

-- Reducing Wondervolt trap radius so effect is confined within
-- pad
UPDATE `gameobject_template` SET `data2`= 1 WHERE `entry`= 180797;

-- Goli was AWOL against his will, changed to correct location
-- UPDATE `creature` SET `position_y`=-952.68 WHERE `guid`=86181;

DELETE FROM creature_template WHERE Entry = 15729;
-- Adding missing Winter Helper to DB for spell 26157
INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (15729, 'Father Winter\'s Helper (BIG) gm', NULL, 1, 1, 15687, 15803, 35, 35, 1, 0, 10, 3, 3, 0, 0, 0, 0, 2, 0, 1.2, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');


-- Adding entries for Menethil Wondervolt station
DELETE FROM gameobject WHERE guid BETWEEN 41950 AND 41957;
-- Wondervolt
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41950, 180796, 0, -3755.18, -775.606, 9.87997, -2.46091, 0, 0, 0, 0, 180, 100, 1);
-- Trap
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41951, 180797, 0, -3755.38, -775.585, 9.87012, 0.59341, 0, 0, 0, 0, 180, 100, 1);
-- Smokywood Pastures Sign
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41952, 178746, 0, -3757.98, -769.912, 9.46039, 2.35619, 0, 0, 0, 0, 180, 100, 1);
-- Christmas Tree
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41953, 178667, 0, -3751.6, -767.777, 9.84089, -0.104719, 0, 0, 0, 0, 180, 100, 1);
-- 1st Stocking
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41954, 178434, 0, -3757.23, -775.569, 14.8131, -3.01941, 0, 0, 0, 0, 180, 100, 1);
-- 2nd Stocking
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41955, 178435, 0, -3756.75, -774.392, 14.7831, 2.63544, 0, 0, 0, 0, 180, 100, 1);
-- 1st Present
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41956, 180798, 0, -3756.7, -777.645, 9.89885, -2.16421, 0, 0, 0, 0, 180, 100, 1);
-- 2nd Present
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41957, 180799, 0, -3755.98, -778.003, 9.89892, -2.07694, 0, 0, 0, 0, 180, 100, 1);

DELETE FROM creature_template WHERE Entry = 15730;
-- Adding Pat's Snowcloud Guy
INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES (15730, 'Pat\'s Snowcloud Guy', '', 60, 60, 21955, 15294, 114, 114, 0, 0, 10, 1, 3, 0, 0, 33554432, 0, 2, 0, 1.1, 1.14286, 1, 0, 1, 1, 1, 1, -1, 1, 4400, 4400, 0, 0, 50, 73, 0, 0, 20, 28, 0, 2000, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- Pat + Wonderform npcs
DELETE FROM creature WHERE guid IN (54900, 54901); 
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (54900, 15730, 0, 15294, 0, -3754.8, -775.607, 9.98073, 1.81514, 180, 0, 0, 100, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (54901, 15732, 0, 13349, 0, -3756.79, -770.778, 9.6816, 3.29867, 180, 0, 0, 3800, 0, 0, 0);


-- Adding entries for Gadetzan Wondervolt station
DELETE FROM gameobject WHERE guid BETWEEN 41958 AND 41965;
-- Wondervolt
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41958, 180796, 1, -7166.08, -3918.11, 9.39414, 0.994837, 0, 0, 0, 0, 180, 100, 1);
-- Trap
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41959, 180797, 1, -7166.08, -3918.05, 9.39524, -2.00713, 0, 0, 0, 0, 180, 100, 1);
-- Smokywood Pastures Sign
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41960, 178746, 1, -7162.93, -3911.53, 9.63193, 0.383971, 0, 0, 0, 0, 180, 100, 1);
-- Christmas Tree
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41961, 178667, 1, -7184.51, -3918.14, 24.4141, 0.942477, 0, 0, 0, 0, 180, 100, 1);
-- 1st Stocking
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41962, 178434, 1, -7164.25, -3916.59, 14.8622, 0.349065, 0, 0, 0, 0, 180, 100, 1);
-- 2nd Stocking
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41963, 178435, 1, -7163.8, -3918.61, 14.5926, 0.139624, 0, 0, 0, 0, 180, 100, 1);
-- 1st Present
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41964, 180798, 1, -7165.23, -3915.61, 9.42218, -0.174532, 0, 0, 0, 0, 180, 100, 1);
-- 2nd Present
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41965, 180799, 1, -7166.09, -3915.61, 9.44391, 1.37881, 0, 0, 0, 0, 180, 100, 1);

DELETE FROM creature WHERE guid BETWEEN 54902 AND 54908;

-- Pat + Wonderform npcs
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (54902, 15730, 1, 15294, 0, -7166.18, -3918.02, 9.4828, 2.44346, 180, 0, 0, 100, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (54903, 15732, 1, 13349, 0, -7163.48, -3913.22, 9.61368, 0.0523599, 180, 0, 0, 3800, 0, 0, 0);

-- Adding Pat's Snowcloud Guy to other Wondervolts
-- IF
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (54904, 15730, 0, 15294, 0, -5049.6, -817.202, 495.352, 2.09439, 180, 0, 0, 100, 0, 0, 0);
-- SW
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (54905, 15730, 0, 15294, 0, -8823.58, 540.349, 97.0268, 2.44346, 180, 0, 0, 100, 0, 0, 0);
-- Tirisfal
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (54906, 15730, 0, 15294, 0, 2051.28, 272.469, 57.0336, -2.44346, 180, 0, 0, 100, 0, 0, 0);
-- Org
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (54907, 15730, 1, 15294, 0, 1332.11, -4607.79, 23.9229, -1.95477, 180, 0, 0, 100, 0, 0, 0);
-- Booty Bay
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (54908, 15730, 0, 15294, 0, -14294.5, 516.209, 9.07392, -2.47837, 180, 0, 0, 100, 0, 0, 0);

-- Adding Snowcloud effect
DELETE FROM game_event_creature_data WHERE guid IN (54900, 54902);
DELETE FROM game_event_creature_data WHERE guid BETWEEN 54904 AND 54908;
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (54900, 0, 0, 0, 26000, 0, 2);
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (54902, 0, 0, 0, 26000, 0, 2);
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (54904, 0, 0, 0, 26000, 0, 2);
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (54905, 0, 0, 0, 26000, 0, 2);
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (54906, 0, 0, 0, 26000, 0, 2);
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (54907, 0, 0, 0, 26000, 0, 2);
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (54908, 0, 0, 0, 26000, 0, 2);

-- Adding objects and npcs to Winter Veil event
DELETE FROM game_event_gameobject WHERE guid BETWEEN 41950 AND 41965;
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41950, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41951, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41952, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41953, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41954, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41955, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41956, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41957, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41958, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41959, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41960, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41961, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41962, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41963, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41964, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41965, 2);

DELETE FROM game_event_creature WHERE guid BETWEEN 54900 AND 54908;
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (54900, 2);
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (54901, 2);
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (54902, 2);
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (54903, 2);
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (54904, 2);
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (54905, 2);
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (54906, 2);
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (54907, 2);
INSERT INTO `game_event_creature` (`guid`,`event`) VALUES (54908, 2);

-- Increasing size of objs 180798 and 180799 to match screenshot
UPDATE `gameobject_template` SET `size`= 1.25 WHERE `entry`= 180798;
UPDATE `gameobject_template` SET `size`= 1.25 WHERE `entry`= 180799;

-- Adding Hardpacked Snowball to item_template
DELETE FROM item_template WHERE entry = 21038;
INSERT INTO `item_template` (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`, `ExtraFlags`) VALUES (21038, 0, 8, 'Hardpacked Snowball', 29169, 1, 64, 5, 10, 0, 0, 32767, -1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25677, 0, -1, 0, 30000, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2597, 0, 0, 0, 0, 0, 0, 300, 0);
UPDATE `gameobject_template` SET `data1`= 17489 where `entry`=180654;
DELETE FROM gameobject_loot_template WHERE entry = 17489;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (17489, 21038, 100, 0, 5, 5, 0);

-- Adding presents under Tanaris tree
DELETE FROM gameobject WHERE guid BETWEEN 41966 AND 41973;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41966, 178432, 1, -7182.56, -3916.65, 24.494, 3.594, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41967, 178432, 1, -7183.23, -3918.79, 23.988, 1.956, 0, 0, 0.829382, 0.558682, 180, 100, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41968, 178432, 1, -7185.44, -3918.36, 24.284, 1.761, 0, 0, 0.771057, 0.636766, 180, 100, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41969, 178431, 1, -7185.26, -3917.59, 24.024, 5.691, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41970, 178431, 1, -7184.08, -3919.38, 23.48, 1.914, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41971, 178428, 1, -7184.92, -3918.98, 23.885, 1.709, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41972, 178428, 1, -7182.86, -3917.96, 24.048, 3.296, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (41973, 178430, 1, -7185.62, -3919.05, 23.729, 1.918, 0, 0, 0, 0, 180, 100, 1);

DELETE FROM game_event_gameobject WHERE guid BETWEEN 41966 AND 41973;
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41966, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41967, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41968, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41969, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41970, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41971, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41972, 2);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (41973, 2);
-- Adding missing modelid for red girl winter helper
UPDATE `creature_template` SET `ModelId2`= 15800 WHERE `Entry`= 15835;
-- Fixed stats of some spawned creatures in Blackrock Spire and Felwood after [1020] and [1024]
UPDATE creature, creature_template SET creature.curhealth = creature_template.MinLevelHealth, creature.curmana = creature_template.MinLevelMana WHERE creature.id = creature_template.entry AND creature_template.RegenerateStats & 1;

-- Added missing cleanup from [1027]
UPDATE `creature` SET `equipment_id` = 0 WHERE `id` = 10196;

-- Fixed missing model from [1031]
UPDATE `creature_template` SET `ModelId1` = 15294 WHERE `Entry` = 15730;

DELETE FROM `creature` WHERE `guid` IN ('178', '591', '593', '594', '598', '599', '651', '654', '656', '657', '686', '695', '715');
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('178', '4624', '0', '0', '0', '-14423.6', '424.668', '21.8532', '3.719140', '300', '0', '0', '12652', '0', '0', '2'),
('591', '4624', '0', '0', '0', '-14449.2', '451.524', '20.5557', '5.001510', '300', '0', '0', '12652', '0', '0', '2'),
('593', '4624', '0', '0', '0', '-14256.7', '338.710', '27.2934', '2.565270', '300', '0', '0', '12652', '0', '0', '2'),
('594', '4624', '0', '0', '0', '-14298.5', '435.710', '31.5745', '0.612118', '300', '0', '0', '12652', '0', '0', '2'),
('598', '4624', '0', '0', '0', '-14400.6', '413.038', '7.93467', '0.712614', '300', '0', '0', '12652', '0', '0', '2'),
('599', '4624', '0', '0', '0', '-14316.7', '446.802', '23.4093', '1.798240', '300', '0', '0', '12652', '0', '0', '2'),
('651', '4624', '0', '0', '0', '-14451.0', '462.469', '15.4349', '3.682770', '300', '0', '0', '12652', '0', '0', '2'),
('654', '4624', '0', '0', '0', '-14434.8', '416.849', '8.81870', '0.661698', '300', '0', '0', '12652', '0', '0', '2'),
('656', '4624', '0', '0', '0', '-14431.6', '511.808', '5.77141', '2.603190', '300', '0', '0', '12652', '0', '0', '2'),
('657', '4624', '0', '0', '0', '-14299.9', '503.528', '9.25196', '4.147560', '300', '0', '0', '12652', '0', '0', '2'),
('686', '4624', '0', '0', '0', '-14302.3', '511.123', '8.82953', '3.860820', '300', '0', '0', '12652', '0', '0', '2'),
('695', '4624', '0', '0', '0', '-14473.9', '487.356', '26.8084', '5.547340', '300', '0', '0', '12652', '0', '0', '2'),
('715', '4624', '0', '0', '0', '-14437.2', '399.063', '31.7274', '2.060510', '300', '0', '0', '12652', '0', '0', '2');

DELETE FROM `creature_movement` WHERE `id` IN ('178', '591', '593', '594', '598', '599', '651', '654', '656', '657', '686', '695', '715');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('178', '1', '-14442.4', '414.102', '25.0155', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '2', '-14445.7', '412.951', '25.0162', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '3', '-14455', '423.15', '25.0954', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '4', '-14461.4', '430.758', '25.2104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '5', '-14468.4', '441.477', '30.2791', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '6', '-14471.2', '446.957', '30.544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '7', '-14472.9', '454.424', '30.4841', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '8', '-14472.3', '461.029', '30.6343', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '9', '-14479.2', '463.782', '30.7789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '10', '-14482.8', '467.095', '31.5195', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '11', '-14479.2', '472.917', '31.5351', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '12', '-14482.5', '467.054', '31.6192', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '13', '-14479', '463.804', '30.8692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '14', '-14472', '461.054', '30.8692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '15', '-14472.5', '454.304', '30.6192', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '16', '-14471', '447.304', '30.6192', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '17', '-14468.3', '441.804', '30.3692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '18', '-14461.3', '431.054', '25.6192', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '19', '-14454.8', '423.304', '25.6192', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '20', '-14445.8', '413.304', '25.3692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '21', '-14442.3', '414.304', '25.3692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('178', '22', '-14424.3', '424.192', '21.7033', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '1', '-14444.9', '445.531', '20.4134', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '2', '-14441.3', '438.778', '20.4903', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '3', '-14440.8', '432.276', '20.3793', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '4', '-14435.4', '430.078', '20.2879', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '5', '-14433.8', '427.503', '20.2863', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '6', '-14440.7', '422.971', '15.5599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '7', '-14442.9', '426.732', '15.5587', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '8', '-14438.8', '432.066', '15.5848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '9', '-14434.1', '432.398', '15.5545', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '10', '-14431.3', '428.801', '15.5621', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '11', '-14439.6', '423.793', '9.06026', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '12', '-14441.4', '425.5', '9.06026', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '13', '-14443.9', '430.25', '4.18761', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '14', '-14438.3', '434.884', '4.19606', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '15', '-14439.3', '437.73', '4.19911', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '16', '-14444.7', '430.757', '4.18845', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '17', '-14441.4', '425.5', '9.06026', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '18', '-14431.3', '428.801', '15.5621', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '19', '-14434.1', '432.398', '15.5545', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '20', '-14438.8', '432.066', '15.5848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '21', '-14442.9', '426.732', '15.5587', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '22', '-14440.7', '422.971', '15.5599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '23', '-14433.8', '427.503', '20.2863', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '24', '-14435.4', '430.078', '20.2879', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '25', '-14440.6', '432.196', '20.3668', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '26', '-14441.3', '438.778', '20.4903', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '27', '-14444.9', '445.531', '20.4134', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('591', '28', '-14449.4', '451.391', '20.4759', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '1', '-14265.8', '348.704', '31.1595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '2', '-14271', '353.64', '32.7479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '3', '-14276.1', '364.71', '33.6137', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '4', '-14277.9', '380.406', '35.3847', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '5', '-14274.2', '395.879', '37.1044', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '6', '-14271.1', '404.903', '36.8936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '7', '-14269.9', '416.31', '36.7034', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '8', '-14274.9', '426.285', '35.3947', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '9', '-14287', '434.52', '33.2376', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '10', '-14274.9', '426.285', '35.3947', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '11', '-14269.9', '416.31', '36.7034', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '12', '-14271', '405.088', '36.9146', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '13', '-14274.2', '395.879', '37.1044', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '14', '-14277.9', '380.406', '35.3847', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '15', '-14276.1', '364.71', '33.6137', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '16', '-14271', '353.64', '32.7479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '17', '-14265.8', '348.704', '31.1595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('593', '18', '-14257', '339.076', '27.2743', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '1', '-14287', '428.87', '33.7043', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '2', '-14280.9', '424.514', '35.3712', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '3', '-14277.2', '419.943', '36.423', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '4', '-14275.8', '411.91', '37.235', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '5', '-14276.6', '402.768', '37.0483', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '6', '-14279', '390.305', '36.3309', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '7', '-14281.4', '379.503', '35.133', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '8', '-14279.8', '368.264', '33.6549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '9', '-14277.5', '359.923', '33.2561', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '10', '-14273.1', '350.615', '32.7842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '11', '-14268.5', '346.023', '31.3686', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '12', '-14273.1', '350.615', '32.7842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '13', '-14277.5', '359.923', '33.2561', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '14', '-14279.8', '368.264', '33.6549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '15', '-14281.4', '379.503', '35.133', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '16', '-14279', '390.305', '36.3309', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '17', '-14276.6', '402.703', '37.0651', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '18', '-14275.8', '411.91', '37.235', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '19', '-14277.2', '419.943', '36.423', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '20', '-14280.9', '424.514', '35.3712', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '21', '-14287', '428.87', '33.7043', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('594', '22', '-14298', '435.509', '31.579', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '1', '-14392.1', '420.434', '7.54837', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '2', '-14385.4', '425.173', '7.36117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '3', '-14373.1', '430.034', '7.31295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '4', '-14360.3', '433.72', '7.36588', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '5', '-14344.8', '443.056', '7.4693', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '6', '-14337.3', '451.978', '7.67435', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '7', '-14327.3', '466.137', '8.1809', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '8', '-14317.2', '485.579', '8.59669', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '9', '-14308.3', '506.756', '8.64147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '10', '-14294.1', '534.231', '8.6887', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '11', '-14286.1', '552.673', '8.70584', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '12', '-14294.1', '534.231', '8.6887', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '13', '-14308.3', '506.756', '8.64147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '14', '-14317.2', '485.579', '8.59669', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '15', '-14327.3', '466.137', '8.1809', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '16', '-14337.3', '451.978', '7.67435', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '17', '-14344.8', '443.056', '7.4693', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '18', '-14360.3', '433.72', '7.36588', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '19', '-14373.1', '430.034', '7.31295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '20', '-14385.4', '425.173', '7.36117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '21', '-14392.1', '420.434', '7.54837', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('598', '22', '-14400', '412.727', '7.77239', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '1', '-14318.6', '455.081', '23.4482', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '2', '-14314.7', '468.257', '18.4367', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '3', '-14314.7', '474.267', '18.3547', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '4', '-14307.9', '487.469', '13.2721', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '5', '-14301.7', '497.471', '10.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '6', '-14298.1', '505.389', '8.96902', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '7', '-14301.7', '509.774', '8.6758', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '8', '-14307.6', '504.115', '8.64554', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '9', '-14309.8', '498.715', '8.6345', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '10', '-14313.3', '490.275', '8.6164', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '11', '-14317.3', '482.241', '8.59652', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '12', '-14323', '471.202', '8.39456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '13', '-14330', '457.738', '7.90804', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '14', '-14341.2', '443.758', '7.48909', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '15', '-14353.5', '435.965', '7.38517', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '16', '-14369', '429.004', '7.37672', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '17', '-14382.4', '424.817', '7.3554', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '18', '-14394.1', '421.125', '7.63872', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '19', '-14405.2', '422.36', '8.48729', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '20', '-14412.8', '428.759', '8.93994', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '21', '-14420.9', '435.219', '9.53649', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '22', '-14425.8', '441.807', '12.1688', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '23', '-14429.8', '447.25', '15.4427', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '24', '-14431.9', '447.814', '15.4255', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '25', '-14432.5', '445.842', '15.4692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '26', '-14426.6', '438.212', '18.0541', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '27', '-14422.9', '432.659', '21.3357', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '28', '-14419.3', '428.27', '22.0601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '29', '-14415.8', '424.096', '22.1281', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '30', '-14394.2', '414.212', '22.6782', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '31', '-14392.2', '409.483', '22.7452', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '32', '-14392.5', '402.863', '22.712', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '33', '-14387.6', '390.908', '22.9852', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '34', '-14382', '384.972', '23.2067', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '35', '-14375', '380.035', '23.1574', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '36', '-14365.2', '378.422', '23.3867', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '37', '-14355.3', '380.67', '23.3598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '38', '-14342.3', '385.995', '23.4673', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '39', '-14326.5', '392.474', '23.8077', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '40', '-14320', '399.283', '24.0117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '41', '-14315', '416.881', '23.6653', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '42', '-14313.4', '427.522', '23.1797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '43', '-14314.8', '435.38', '22.9005', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('599', '44', '-14316.6', '447.09', '23.2387', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('651', '1', '-14466.6', '453.068', '15.3329', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('651', '2', '-14467', '449.978', '15.4687', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('651', '3', '-14463.1', '446.736', '15.4737', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('651', '4', '-14454.3', '434.906', '15.1878', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('651', '5', '-14442.7', '415.397', '15.0957', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('651', '6', '-14453.6', '434.036', '15.1696', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('651', '7', '-14437.8', '449.306', '15.3789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('651', '8', '-14449.8', '463.889', '15.3359', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '1', '-14425.3', '424.265', '8.99519', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '2', '-14423.7', '428.519', '8.96744', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '3', '-14428.8', '437.855', '6.48981', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '4', '-14436.4', '449.562', '3.69352', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '5', '-14445.5', '463.716', '3.84649', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '6', '-14436.9', '448.047', '3.69427', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '7', '-14448.3', '439.089', '3.86408', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '8', '-14436.9', '448.047', '3.69427', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '9', '-14445.5', '463.716', '3.84649', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '10', '-14436.4', '449.562', '3.69352', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '11', '-14428.8', '437.855', '6.48981', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '12', '-14423.7', '428.519', '8.96744', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '13', '-14425.3', '424.265', '8.99519', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('654', '14', '-14434.6', '416.965', '8.75356', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '1', '-14439.1', '495.388', '13.4074', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '2', '-14447.8', '482.138', '15.1096', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '3', '-14442.6', '462.937', '15.3824', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '4', '-14435.3', '448.752', '15.3969', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '5', '-14424.8', '444.452', '12.9438', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '6', '-14417.7', '434.207', '8.95462', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '7', '-14409.2', '423.573', '8.68512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '8', '-14396.8', '416.179', '7.87222', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '9', '-14393.1', '406.336', '6.71033', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '10', '-14396.8', '416.179', '7.87222', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '11', '-14409.2', '423.573', '8.68512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '12', '-14417.7', '434.166', '8.93865', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '13', '-14424.8', '444.452', '12.9438', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '14', '-14435.3', '448.752', '15.3969', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '15', '-14442.6', '462.937', '15.3824', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '16', '-14447.8', '482.138', '15.1096', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '17', '-14439.1', '495.388', '13.4074', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('656', '18', '-14431.2', '512.273', '5.49217', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '1', '-14312.8', '483.192', '14.819', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '2', '-14317.7', '466.225', '19.1429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '3', '-14323.2', '444.298', '22.747', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '4', '-14316.2', '432.447', '22.7259', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '5', '-14319', '417.219', '23.4741', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '6', '-14322.2', '399.648', '24.0779', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '7', '-14334.9', '395.419', '23.3598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '8', '-14343.8', '390.811', '23.2622', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '9', '-14363.4', '383.449', '23.4848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '10', '-14375.8', '383.213', '22.6782', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '11', '-14390.6', '399.044', '22.8109', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '12', '-14375.8', '383.213', '22.6782', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '13', '-14363.4', '383.449', '23.4848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '14', '-14343.8', '390.811', '23.2622', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '15', '-14334.9', '395.419', '23.3598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '16', '-14322.2', '399.648', '24.0779', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '17', '-14319', '417.219', '23.4741', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '18', '-14316.2', '432.447', '22.7259', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '19', '-14323.2', '444.298', '22.747', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '20', '-14317.7', '466.225', '19.1429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '21', '-14312.8', '483.192', '14.819', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('657', '22', '-14299.8', '503.744', '9.08229', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '1', '-14313', '501.729', '8.61711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '2', '-14318.6', '485.781', '8.58937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '3', '-14326.1', '472.565', '8.3757', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '4', '-14333.1', '460.482', '7.92616', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '5', '-14341.3', '449.143', '7.56401', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '6', '-14352.6', '440.766', '7.4209', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '7', '-14361.9', '436.575', '7.37137', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '8', '-14376.2', '431.316', '7.31533', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '9', '-14361.9', '436.575', '7.37137', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '10', '-14352.6', '440.766', '7.4209', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '11', '-14341.3', '449.143', '7.56401', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '12', '-14333.1', '460.482', '7.92616', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '13', '-14326.1', '472.565', '8.3757', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '14', '-14318.6', '485.781', '8.58937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '15', '-14313', '501.729', '8.61711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('686', '16', '-14301.7', '513.679', '8.67555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '1', '-14465.5', '479.746', '26.8295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '2', '-14466.8', '471.284', '30.7113', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '3', '-14469.5', '462.674', '30.6577', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '4', '-14472.3', '454.081', '30.4917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '5', '-14470.2', '446.919', '30.5566', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '6', '-14474.8', '441.263', '30.705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '7', '-14474.5', '434.851', '33.2027', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '8', '-14473.8', '431.647', '34.314', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '9', '-14478.6', '428.314', '34.249', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '10', '-14473.8', '431.647', '34.314', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '11', '-14474.5', '434.851', '33.2027', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '12', '-14474.8', '441.263', '30.705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '13', '-14470.2', '446.919', '30.5566', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '14', '-14472.3', '454.081', '30.4917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '15', '-14469.5', '462.674', '30.6577', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '16', '-14467', '470.439', '30.7043', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '17', '-14465.5', '479.746', '26.8295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('695', '18', '-14474', '487.33', '26.7089', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '1', '-14443.3', '410.566', '25.0075', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '2', '-14457.4', '426.895', '25.1528', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '3', '-14466.7', '441.322', '29.8059', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '4', '-14455.6', '425.828', '25.131', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '5', '-14443.5', '432.869', '20.2956', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '6', '-14455.6', '425.828', '25.131', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '7', '-14466.7', '441.322', '29.8059', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '8', '-14457.4', '426.895', '25.1528', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '9', '-14443.3', '410.566', '25.0075', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('715', '10', '-14437.1', '398.968', '31.7248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `UnitFlags`='64', `SpeedWalk`='1', `SpeedRun`=('10' / '7'), `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='10200';

UPDATE `creature` SET `modelid`='0',`position_x`='8021.76', `position_y`='-3946.803', `position_z`='687.1479', `orientation`='6.225225', `MovementType`='2' WHERE `id`='10200';

SET @WP :='0';
DELETE FROM `creature_movement_template` WHERE `entry`='10200';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('10200', @WP := @WP + '1', '8028.811', '-3947.212', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8037.275', '-3942.646', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8046.581', '-3938.139', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8052.147', '-3930.226', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8053.363', '-3919.330', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8042.460', '-3905.253', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8036.599', '-3897.281', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8026.449', '-3889.370', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8018.806', '-3883.733', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8010.596', '-3876.309', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8000.862', '-3872.118', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '7992.011', '-3874.467', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '7985.668', '-3879.896', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '7980.295', '-3887.226', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '7982.961', '-3899.094', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '7988.211', '-3905.684', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8000.712', '-3905.205', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8007.098', '-3908.700', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8012.041', '-3917.679', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8013.973', '-3929.078', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8014.293', '-3941.990', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('10200', @WP := @WP + '1', '8018.936', '-3946.639', '687.1479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
-- Fixed quest 590 (A Rogue's Deal)
-- Thanks Scotty0100 and Tobschinski for pointing. This closes #66 
UPDATE `creature_template` SET `UnitFlags` = 33536 WHERE `Entry` = 6784;
UPDATE `creature_template` SET `NpcFlags` = 0, `UnitFlags` = 32768, `ExtraFlags` = 0 WHERE `Entry` = 7980;

UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='9', `PowerMultiplier`='2', `DamageMultiplier`='7', `ArmorMultiplier`='1', `MinLevelHealth`='25056', `MaxLevelHealth`='25056', `MinMeleeDmg`='117.5', `MaxMeleeDmg`='155.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2400', `RangedBaseAttackTime`='2400' WHERE `Entry`='9938';
UPDATE `creature_template` SET `MinLevel`='57', `MaxLevel`='57', `FactionAlliance`='15', `FactionHorde`='15', `ExtraFlags`='0', `HealthMultiplier`='3', `PowerMultiplier`='2', `ArmorMultiplier`='1', `MinLevelHealth`='8352', `MaxLevelHealth`='8352', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `ResistanceHoly`='0', `ResistanceFire`='0', `ResistanceNature`='0', `ResistanceFrost`='0', `ResistanceShadow`='0', `ResistanceArcane`='0', `MovementType`='1' WHERE `Entry`='8982';
-- Added missing end script for quest 1059 (Reclaiming the Charred Vale 2) in Feralas
-- Thanks @Zingzah for reporting. This closes #618 
-- NPCs, spells and texts are correct
-- waypoints and timers are guesswork based on screens and retail experience (no video source found)
-- Sources:
-- http://wowwiki.wikia.com/Quest:Reclaiming_the_Charred_Vale_%282%29
-- http://www.wowhead.com/spell=6537/call-of-the-forest#screenshots:id=87812
-- http://www.wowhead.com/quest=1059/reclaiming-the-charred-vale#comments

SET @ENTRY := 2000005780;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1059;
INSERT INTO `dbscripts_on_quest_end` VALUES
(1059, 0, 29, 2, 0x02, 0, 0, 0, @ENTRY, 0, 0, 0, 0, 0, 0, 0, ''),
(1059, 1, 0, 0, 0, 0, 0, 0, @ENTRY, 0, 0, 0, 0, 0, 0, 0, ''),
(1059, 2, 32, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Unpause WP movement');

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` IN (404802, 404808);
INSERT INTO `dbscripts_on_creature_movement` VALUES
(404802, 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Pause WP movement'),
(404802, 1, 29, 2, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(404802, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.0091, ''),
(404808, 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Pause WP movement'),
(404808, 2, 0, 0, 0, 0, 0, 0, @ENTRY + 1, 0, 0, 0, 0, 0, 0, 0, ''),
(404808, 4, 15, 6537, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(404808, 6, 10, 4059, 50000, 0, 0, 0, 0, 0, 0, 0, -4479.45, -768.01, -37.36, 0, ''),
(404808, 7, 10, 4059, 50000, 0, 0, 0, 0, 0, 0, 0, -4486.55, -769.80, -37.23, 0, ''),
(404808, 8, 10, 4059, 50000, 0, 0, 0, 0, 0, 0, 0, -4484.95, -767.87, -36.61, 0, ''),
(404808, 9, 10, 4059, 50000, 0, 0, 0, 0, 0, 0, 0, -4484.90, -770.79, -37.62, 0, ''),
(404808, 10, 10, 4059, 50000, 0, 0, 0, 0, 0, 0, 0, -4484.07, -765.04, -35.74, 0, ''),
(404808, 11, 10, 4059, 50000, 0, 0, 0, 0, 0, 0, 0, -4485.88, -764.05, -35.19, 0, ''),
(404808, 14, 0, 0, 0, 0, 0, 0, @ENTRY + 2, 0, 0, 0, 0, 0, 0, 0, ''),
(404808, 13, 14, 6537, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(404808, 27, 32, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'Unpause WP movement'),
(405901, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'RUN ON');

DELETE FROM `db_script_string` WHERE `entry` IN (@ENTRY, @ENTRY + 1, @ENTRY + 2);
INSERT INTO `db_script_string` VALUES
(@ENTRY, 'We must hurry.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL),
(@ENTRY + 1, 'Spirits of the forest come forth and heed nature\'s call!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL),
(@ENTRY + 2, 'Spirits of the forest, you are needed! Make haste to the Charred Vale!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 25, NULL);

UPDATE quest_template SET `completeScript` = 1059 WHERE `entry` = 1059;

DELETE FROM `creature_movement_template` WHERE `entry` = 4048;
INSERT INTO `creature_movement_template` VALUES
(4048, 1, -4524.14, -787.884, -41.5917, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.0091, 0, 0),
(4048, 2, -4524.14, -787.884, -41.5917, 0, 404802, 0, 0, 0, 0, 0, 0, 0, 5.0091, 0, 0),
(4048, 3, -4524.14, -787.884, -41.5917, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.0091, 0, 0),
(4048, 4, -4524.24, -782.628, -41.5763, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 5, -4520.69, -775.438, -41.0733, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 6, -4514.55, -770.937, -40.0658, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 7, -4503.63, -774.032, -40.224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 8, -4488.25, -767.98, -36.61, 0, 404808, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 9, -4488.25, -767.98, -36.61, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 10, -4499.17, -773.174, -39.449, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 11, -4514.09, -771.136, -40.0971, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 12, -4520.48, -775.049, -41.0191, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 13, -4524.16, -782.978, -41.2406, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4048, 14, -4524.12, -788.099, -41.6929, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);
UPDATE `creature_template` SET `MovementType` = 2  WHERE `Entry` = 4048;
UPDATE `creature` SET `MovementType` = 2  WHERE `id` = 4048;

DELETE FROM `creature_movement_template` WHERE `entry` = 4059;
INSERT INTO `creature_movement_template` VALUES
(4059, 1, -4484.5, -759, -33.57, 0, 405901, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4059, 2, -4484.5, -759, -33.57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4059, 3, -4483, -755.56, -31.94, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4059, 4, -4481, -686.51, -14.39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(4059, 5, -4472, -571.90, 5.91, 40000, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);


-- 
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 4059;
INSERT INTO `creature_ai_scripts` VALUES
(405901, 4059, 1, 0, 100, 0, 7500, 10500, 0, 0, 48, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Forest Wisp - Start WP movement after 7 sec');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `Entry` = 4059;

DELETE FROM `creature` WHERE `guid` IN ('30643', '30634', '30639', '30644', '30633', '30638');
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('30633', '4979', '1', '0', '0', '-3722.21', '-4411.7', '25.5215', '0.539303', '300', '0', '0', '5506', '0', '0', '2'),
('30634', '4979', '1', '0', '0', '-3720.66', '-4413.08', '25.433', '1.47898', '300', '0', '0', '5506', '0', '0', '0'),
('30638', '4979', '1', '0', '0', '-3848.94', '-4560.71', '8.43613', '2.19426', '300', '0', '0', '5506', '0', '0', '2'),
('30639', '4979', '1', '0', '0', '-3849.88', '-4561.8', '8.39056', '2.43677', '300', '0', '0', '5506', '0', '0', '0'),
('30643', '4979', '1', '0', '0', '-3675.16', '-4387.73', '10.4938', '5.38544', '300', '0', '0', '5506', '0', '0', '0'),
('30644', '4979', '1', '0', '0', '-3677.63', '-4387.38', '10.5402', '5.20393', '300', '0', '0', '5506', '0', '0', '2');

DELETE FROM `creature_movement` WHERE `id` IN ('30633', '30638', '30644');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30633', '1', '-3717.42', '-4408.83', '23.7117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '2', '-3716.33', '-4406.07', '22.8911', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '3', '-3714.12', '-4401.88', '21.2508', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '4', '-3711.31', '-4397.12', '19.1346', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '5', '-3707.58', '-4393.85', '17.6031', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '6', '-3702.78', '-4392.34', '15.8197', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '7', '-3698.07', '-4392.3', '14.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '8', '-3694.07', '-4392.27', '12.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '9', '-3689.36', '-4390.58', '11.1055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '10', '-3684.42', '-4388.74', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '11', '-3679.36', '-4387.08', '10.6055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '12', '-3671.72', '-4382.73', '9.98055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '13', '-3663.63', '-4376.57', '9.42848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '14', '-3656.5', '-4371.02', '9.42848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '15', '-3648.75', '-4364.48', '9.31833', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '16', '-3638.18', '-4356.13', '7.6716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '17', '-3628.49', '-4349.18', '6.40688', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '18', '-3622.19', '-4344.1', '7.94125', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '19', '-3615.57', '-4338.37', '8.93629', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '20', '-3608.65', '-4332.64', '9.29181', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '21', '-3602.14', '-4327.35', '8.87288', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '22', '-3596.22', '-4322.26', '7.68153', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '23', '-3590.09', '-4317.26', '6.35448', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '24', '-3596.22', '-4322.26', '7.68153', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '25', '-3602.14', '-4327.35', '8.87288', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '26', '-3608.65', '-4332.64', '9.29181', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '27', '-3615.57', '-4338.37', '8.93629', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '28', '-3622.19', '-4344.1', '7.94125', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '29', '-3628.49', '-4349.18', '6.40688', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '30', '-3638.18', '-4356.13', '7.6716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '31', '-3648.75', '-4364.48', '9.31833', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '32', '-3656.5', '-4371.02', '9.42848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '33', '-3663.63', '-4376.57', '9.42848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '34', '-3671.72', '-4382.73', '9.98055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '35', '-3679.36', '-4387.08', '10.6055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '36', '-3684.42', '-4388.74', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '37', '-3689.12', '-4390.49', '11.1676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '38', '-3693.83', '-4392.19', '12.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '39', '-3698.07', '-4392.3', '14.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '40', '-3702.78', '-4392.34', '15.8197', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '41', '-3707.58', '-4393.85', '17.6031', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '42', '-3711.31', '-4397.12', '19.1346', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '43', '-3714.12', '-4401.88', '21.2508', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '44', '-3716.33', '-4406.07', '22.8911', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '45', '-3717.42', '-4408.83', '23.7117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30633', '46', '-3720.2', '-4411.71', '25.0374', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '1', '-3851.78', '-4556.76', '8.51621', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '2', '-3852.17', '-4552.48', '8.51499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '3', '-3850.77', '-4548.56', '8.7352', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '4', '-3847.18', '-4545.05', '8.88999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '5', '-3842.38', '-4543.41', '9.13877', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '6', '-3836.77', '-4543.73', '9.26499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '7', '-3831.5', '-4542.56', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '8', '-3826.08', '-4538.28', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '9', '-3818.59', '-4530.98', '9.22531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '10', '-3811.4', '-4523.84', '9.35031', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '11', '-3805.23', '-4517.91', '10.4477', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '12', '-3798.93', '-4511.39', '11.5426', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '13', '-3797.2', '-4507.07', '11.5426', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '14', '-3799.83', '-4500.17', '11.6676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '15', '-3804.23', '-4490.73', '11.7957', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '16', '-3807.88', '-4483.95', '12.618', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '17', '-3810.6', '-4476.68', '12.7459', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '18', '-3812.46', '-4470.15', '12.7459', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '19', '-3812.67', '-4462.84', '12.7781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '20', '-3812.58', '-4455.46', '12.7781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '21', '-3812.33', '-4449.71', '12.7781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '22', '-3812.38', '-4444.56', '12.7781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '23', '-3812.48', '-4438.14', '12.7781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '24', '-3812.36', '-4431.71', '12.82', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '25', '-3812.3', '-4425.38', '12.82', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '26', '-3811.18', '-4419.55', '12.7861', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '27', '-3809.26', '-4414.73', '12.82', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '28', '-3806.4', '-4410.12', '12.7219', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '29', '-3801.35', '-4402.95', '11.6691', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '30', '-3793.6', '-4396.9', '10.7063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '31', '-3785.82', '-4394.92', '10.6611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '32', '-3779.05', '-4393.7', '10.6611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '33', '-3771.48', '-4391.56', '10.6611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '34', '-3766.4', '-4389.29', '10.9889', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '35', '-3758.06', '-4385.5', '10.6113', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '36', '-3750.42', '-4381.6', '10.6318', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '37', '-3745.29', '-4378.93', '10.7363', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '38', '-3735.17', '-4373.58', '10.7363', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '39', '-3726.87', '-4369.02', '10.7372', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '40', '-3717.56', '-4364.58', '10.6842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '41', '-3712.79', '-4364.15', '10.6842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '42', '-3706.82', '-4366.41', '10.6842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '43', '-3698.76', '-4372.17', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '44', '-3694.31', '-4376.28', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '45', '-3687.09', '-4381.38', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '46', '-3682.49', '-4385.98', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '47', '-3677.53', '-4391.69', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '48', '-3674.07', '-4396.02', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '49', '-3672.61', '-4402.34', '10.7372', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '50', '-3672.15', '-4410.61', '10.7372', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '51', '-3672.05', '-4418.5', '11.1122', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '52', '-3672.09', '-4425.54', '11.2008', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '53', '-3672.24', '-4433.62', '11.4767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '54', '-3672.69', '-4440.82', '11.3771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '55', '-3673.58', '-4449.68', '11.4672', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '56', '-3674.48', '-4457.58', '11.3703', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '57', '-3675.3', '-4462.34', '11.5922', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '58', '-3677.77', '-4467.21', '11.5852', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '59', '-3682.02', '-4472.67', '11.6907', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '60', '-3686.85', '-4477.44', '11.9248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '61', '-3692.57', '-4482.54', '12.0191', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '62', '-3698.75', '-4486.67', '12.1907', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '63', '-3704.46', '-4489.62', '12.4539', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '64', '-3710.61', '-4492.65', '12.5472', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '65', '-3717.51', '-4495.35', '12.7923', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '66', '-3724.75', '-4498.05', '12.8438', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '67', '-3732.78', '-4500.54', '13.1685', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '68', '-3740.7', '-4502.7', '12.9721', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '69', '-3746.78', '-4504.31', '13.0283', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '70', '-3755.56', '-4506.8', '12.8584', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '71', '-3765.09', '-4508.93', '12.5996', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '72', '-3771.08', '-4509.97', '12.4503', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '73', '-3779.97', '-4510.99', '12.161', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '74', '-3786.38', '-4511.42', '11.9843', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '75', '-3794.54', '-4511.67', '11.5426', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '76', '-3798.15', '-4511.75', '11.5426', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '77', '-3805.08', '-4517.67', '10.4961', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '78', '-3811.38', '-4523.96', '9.35031', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '79', '-3819.12', '-4531.47', '9.22531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '80', '-3826.08', '-4537.8', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '81', '-3831.15', '-4542.71', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '82', '-3832.62', '-4547.19', '9.29182', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '83', '-3831.59', '-4553.3', '9.01716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '84', '-3832', '-4556.87', '8.89216', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '85', '-3833.97', '-4559.6', '8.75156', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '86', '-3836.64', '-4562.13', '8.63999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '87', '-3840.11', '-4563.24', '8.51499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '88', '-3844.78', '-4563', '8.51743', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '89', '-3848.75', '-4561.32', '8.38999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30638', '90', '-3849.17', '-4560.99', '8.38999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '1', '-3674.51', '-4393.2', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '2', '-3672.79', '-4398.38', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '3', '-3672.44', '-4404.9', '10.7372', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '4', '-3671.95', '-4414.38', '10.972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '5', '-3672.13', '-4426.93', '11.3307', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '6', '-3672.26', '-4438.6', '11.3258', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '7', '-3672.94', '-4447.44', '11.4079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '8', '-3673.63', '-4456.24', '11.4289', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '9', '-3675.2', '-4463.04', '11.4672', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '10', '-3680.84', '-4471.64', '11.6702', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '11', '-3686.95', '-4478.47', '11.9368', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '12', '-3693.94', '-4483.8', '12.0657', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '13', '-3700.45', '-4488.1', '12.4044', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '14', '-3711.8', '-4493.5', '12.5472', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '15', '-3722.4', '-4497.82', '12.7972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '16', '-3731.12', '-4500.83', '12.9351', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '17', '-3740.66', '-4502.35', '13.0144', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '18', '-3746.65', '-4504.58', '12.9966', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '19', '-3753.49', '-4506.83', '12.8584', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '20', '-3766.35', '-4510.25', '12.4834', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '21', '-3778.9', '-4511.29', '12.1371', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '22', '-3787.08', '-4511.7', '11.9057', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '23', '-3793.22', '-4512.13', '11.5426', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '24', '-3799.68', '-4512.47', '11.5426', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '25', '-3807.47', '-4519.95', '9.93454', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '26', '-3813.56', '-4526.24', '9.22531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '27', '-3822.23', '-4534.29', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '28', '-3829.23', '-4541.18', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '29', '-3832.53', '-4544.67', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '30', '-3832.76', '-4548.83', '9.0948', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '31', '-3832.46', '-4552.68', '9.01716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '32', '-3832.75', '-4556.14', '8.89216', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '33', '-3834.68', '-4559.43', '8.82065', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '34', '-3838.37', '-4562.57', '8.51499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '35', '-3842.99', '-4563.37', '8.47373', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '36', '-3846.42', '-4562.59', '8.38999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '37', '-3849.34', '-4561.17', '8.38999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '38', '-3851.45', '-4558.08', '8.35825', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '39', '-3852.54', '-4553.6', '8.51499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '40', '-3851.77', '-4549.3', '8.71884', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '41', '-3849.26', '-4545.97', '8.79111', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '42', '-3845.14', '-4543.48', '9.13999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '43', '-3840.7', '-4543.09', '9.17734', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '44', '-3836.55', '-4543.68', '9.26499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '45', '-3832.79', '-4544.5', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '46', '-3828.8', '-4540.87', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '47', '-3821.43', '-4533.64', '9.26716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '48', '-3814.8', '-4527.37', '9.22531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '49', '-3809.86', '-4521.9', '9.53951', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '50', '-3803.51', '-4515.37', '11.0686', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '51', '-3799.07', '-4511.37', '11.5426', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '52', '-3797.8', '-4506.29', '11.4935', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '53', '-3800.24', '-4500.31', '11.5661', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '54', '-3803.82', '-4491.3', '11.8709', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '55', '-3807.22', '-4483.62', '12.5238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '56', '-3810.2', '-4477.06', '12.7459', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '57', '-3812.22', '-4471.62', '12.7459', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '58', '-3813.02', '-4465.97', '12.7781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '59', '-3812.67', '-4457.76', '12.7781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '60', '-3812.48', '-4448.54', '12.7781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '61', '-3812.27', '-4440.84', '12.7781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '62', '-3812.21', '-4433.04', '12.82', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '63', '-3812', '-4425.17', '12.82', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '64', '-3810.59', '-4418', '12.82', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '65', '-3807.82', '-4411.6', '12.695', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '66', '-3803.43', '-4405.27', '12.1135', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '67', '-3798.33', '-4399.81', '11.2009', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '68', '-3791.81', '-4396.18', '10.6611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '69', '-3785.61', '-4394.88', '10.6611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '70', '-3780.72', '-4393.98', '10.6611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '71', '-3774.76', '-4392.36', '10.6611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '72', '-3768.42', '-4389.96', '10.7861', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '73', '-3762.41', '-4387.45', '10.8559', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '74', '-3755.59', '-4383.67', '10.6113', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '75', '-3749.57', '-4380.62', '10.749', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '76', '-3744.38', '-4377.82', '10.7363', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '77', '-3738.33', '-4374.68', '10.7363', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '78', '-3730.73', '-4371.1', '10.7372', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '79', '-3723.89', '-4367.27', '10.7372', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '80', '-3717.72', '-4364.71', '10.6842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '81', '-3712.27', '-4364.29', '10.6842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '82', '-3706.31', '-4365.81', '10.6842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '83', '-3701.69', '-4368.37', '10.7372', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '84', '-3696.77', '-4372.97', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '85', '-3690.5', '-4378.75', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '86', '-3684.71', '-4381.92', '10.7305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '87', '-3680.61', '-4384.81', '10.6055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30644', '88', '-3676.47', '-4388.26', '10.5094', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_linking` WHERE `guid` IN ('30634', '30639', '30643');
INSERT INTO `creature_linking` VALUES
('30643', '30644', '512'),
('30634', '30633', '512'),
('30639', '30638', '512');

SET @GUID := '12242';

UPDATE `creature` SET `modelid`='0', `position_x`='736.248', `position_y`='-456.79', `position_z`='-52.8932', `orientation`='5.40292', `spawndist`='0', `currentwaypoint`='0' WHERE `id`=@GUID;

SET @POINT := '0';

DELETE FROM `creature_movement` WHERE `id`=(SELECT `guid` FROM `creature` WHERE `id`=@GUID);
DELETE FROM `creature_movement_template` WHERE `entry`=@GUID;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, @POINT := @POINT + 1, '755.9363', '-480.6198', '-52.90856', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '769.3544', '-505.1759', '-52.85908', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '784.3037', '-508.379', '-53.0263', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '801.0869', '-492.0177', '-53.81177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '814.9312', '-484.2513', '-55.0167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '822.5286', '-461.7411', '-56.28494', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '828.3035', '-448.5358', '-56.35105', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '793.596', '-424.0394', '-53.79723', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '829.3204', '-448.1856', '-56.35316', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '862.0096', '-424.002', '-52.43996', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '886.9448', '-405.5167', '-52.09523', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '880.3082', '-369.967', '-52.04964', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '856.7214', '-349.8064', '-52.04964', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '826.5951', '-346.6646', '-51.92785', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '807.8654', '-346.475', '-51.7706', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '775.6643', '-328.4655', '-50.0463', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '756.8548', '-327.6703', '-51.55397', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '745.7422', '-340.5418', '-50.73648', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '718.0483', '-329.1714', '-51.41955', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '704.3214', '-351.085', '-52.00996', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '690.3201', '-374.0625', '-52.06044', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '655.8417', '-358.8916', '-52.05203', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '642.3574', '-347.1523', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '620.6495', '-351.6401', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '608.4368', '-379.101', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '620.1765', '-351.2938', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '650.0255', '-343.3729', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '646.0782', '-315.0015', '-52.0653', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '634.4776', '-286.2214', '-52.94971', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '633.8284', '-260.07', '-53.10785', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '629.4022', '-228.5276', '-59.41068', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '633.8284', '-260.07', '-53.10785', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '634.4776', '-286.2214', '-52.94971', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '646.0782', '-315.0015', '-52.0653', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '650.0255', '-343.3729', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '620.1765', '-351.2938', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '608.4368', '-379.101', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '620.6495', '-351.6401', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '642.3574', '-347.1523', '-52.01936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '655.8417', '-358.8916', '-52.05203', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '690.3201', '-374.0625', '-52.06044', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '704.3214', '-351.085', '-52.00996', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '718.0483', '-329.1714', '-51.41955', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '745.7422', '-340.5418', '-50.73648', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '756.8548', '-327.6703', '-51.55397', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '775.6643', '-328.4655', '-50.0463', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '807.8654', '-346.475', '-51.7706', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '826.327', '-346.6367', '-51.91992', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '856.7214', '-349.8064', '-52.04964', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '880.3082', '-369.967', '-52.04964', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '886.9448', '-405.5167', '-52.09523', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '862.0096', '-424.002', '-52.43996', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '829.3204', '-448.1856', '-56.35316', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '793.596', '-424.0394', '-53.79723', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '828.3035', '-448.5358', '-56.35105', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '822.5286', '-461.7411', '-56.28494', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '814.9387', '-484.2289', '-55.03092', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '801.0869', '-492.0177', '-53.81177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '784.3037', '-508.379', '-53.0263', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '769.3544', '-505.1759', '-52.85908', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '755.9363', '-480.6198', '-52.90856', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + 1, '736.6956', '-455.5942', '-52.88465', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 90828

UPDATE `creature` SET `modelid`='0', `position_x`='861.324', `position_y`='-258.804', `position_z`='-49.8696', `orientation`='4.42832', `spawndist`='0', `MovementType`='2' WHERE `guid`='90828';

DELETE FROM `creature_movement` WHERE `id`='90828';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('90828', '1', '854.438', '-282.389', '-49.934', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '2', '861.951', '-299.681', '-49.936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '3', '871.463', '-303.62', '-49.936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '4', '883.993', '-313.336', '-49.936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '5', '898.929', '-313.426', '-49.936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '6', '896.321', '-334.966', '-49.7995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '7', '894.078', '-359.278', '-49.9362', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '8', '896.321', '-334.966', '-49.7995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '9', '898.929', '-313.426', '-49.936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '10', '883.993', '-313.336', '-49.936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '11', '871.463', '-303.62', '-49.936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '12', '861.951', '-299.681', '-49.936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '13', '854.474', '-282.47', '-49.936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90828', '14', '860.654', '-258.971', '-49.971', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 47738

UPDATE `creature` SET `modelid`='0', `position_x`='562.103', `position_y`='-282.939', `position_z`='-43.1013', `orientation`='0.00912', `spawndist`='0', `MovementType`='2' WHERE `guid`='47738';

DELETE FROM `creature_movement` WHERE `id`='47738';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('47738', '1', '595.023', '-282.501', '-43.1034', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47738', '2', '633.051', '-282.096', '-43.2186', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47738', '3', '653.19', '-284.079', '-43.1904', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47738', '4', '688.829', '-280.882', '-43.1993', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47738', '5', '724.116', '-276.83', '-42.8501', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47738', '6', '688.829', '-280.882', '-43.1993', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47738', '7', '653.19', '-284.079', '-43.1904', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47738', '8', '633.051', '-282.096', '-43.2186', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47738', '9', '595.023', '-282.501', '-43.1034', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47738', '10', '560.518', '-281.275', '-43.1014', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 90728

UPDATE `creature` SET `modelid`='0', `position_x`='754.091', `position_y`='-73.9451', `position_z`='-46.2159', `orientation`='0.84735', `spawndist`='0' WHERE `guid`='90728';

DELETE FROM `creature_movement` WHERE `id`='90728';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('90728', '1', '761.283', '-65.8021', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '2', '762.053', '-59.3832', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '3', '740.873', '-15.4984', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '4', '733.056', '-6.43943', '-46.1815', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '5', '710.789', '-8.89487', '-45.9405', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '6', '706.555', '13.0863', '-45.5852', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '7', '710.562', '22.7446', '-45.4594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '8', '696.138', '34.8861', '-45.467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '9', '691.576', '46.4976', '-45.467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '10', '696.138', '34.8861', '-45.467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '11', '710.562', '22.7446', '-45.4594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '12', '706.555', '13.0863', '-45.5852', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '13', '710.789', '-8.89487', '-45.9405', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '14', '733.056', '-6.43943', '-46.1815', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '15', '740.873', '-15.4984', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '16', '762.053', '-59.3832', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '17', '761.283', '-65.8021', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90728', '18', '747.48', '-80.9312', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 45943

UPDATE `creature` SET `modelid`='0', `position_x`='699.724', `position_y`='-128.184', `position_z`='-45.6961', `orientation`='3.9079', `spawndist`='0' WHERE `guid`='45943';

DELETE FROM `creature_movement` WHERE `id`='45943';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('45943', '1', '682.134', '-145.115', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '2', '652.99', '-131.139', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '3', '626.382', '-119.613', '-46.2041', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '4', '625.212', '-88.7561', '-45.9408', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '5', '587.486', '-89.0767', '-45.4716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '6', '582.532', '-72.8387', '-45.4674', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '7', '587.486', '-89.0767', '-45.4716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '8', '625.212', '-88.7561', '-45.9408', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '9', '626.382', '-119.613', '-46.2041', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '10', '652.99', '-131.139', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '11', '682.134', '-145.115', '-46.2337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45943', '12', '700.327', '-127.72', '-45.7609', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 47836

UPDATE `creature` SET `modelid`='0', `position_x`='614.934', `position_y`='-57.1995', `position_z`='-59.9881', `orientation`='2.23727', `spawndist`='0' WHERE `guid`='47836';

DELETE FROM `creature_movement` WHERE `id`='47836';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('47836', '1', '608.582', '-49.123', '-60.0567', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '2', '583.026', '-48.0046', '-60.0359', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '3', '569.448', '-59.0047', '-60.0201', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '4', '575.228', '-61.9547', '-60.0105', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '5', '595.55', '-62.0733', '-52.0719', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '6', '595.334', '-81.3019', '-45.4656', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '7', '594.804', '-104.408', '-45.4327', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '8', '595.334', '-81.3019', '-45.4656', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '9', '595.55', '-62.0733', '-52.0719', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '10', '575.228', '-61.9547', '-60.0105', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '11', '569.448', '-59.0047', '-60.0201', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '12', '583.026', '-48.0046', '-60.0359', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '13', '608.582', '-49.123', '-60.0567', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47836', '14', '619.276', '-60.7888', '-60.0573', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 45868

UPDATE `creature` SET `modelid`='0', `position_x`='722.875', `position_y`='171.915', `position_z`='-71.9736', `orientation`='4.0795', `spawndist`='0' WHERE `guid`='45868';

DELETE FROM `creature_movement` WHERE `id`='45868';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('45868', '1', '709.072', '153.098', '-72.1472', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '2', '684.26', '141.267', '-73.0777', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '3', '672.939', '126.329', '-73.3347', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '4', '646.748', '121.308', '-73.2764', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '5', '626.573', '87.8224', '-73.245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '6', '615.804', '54.5907', '-73.2435', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '7', '626.423', '31.1992', '-73.9867', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '8', '641.05', '-2.70842', '-73.2486', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '9', '654.979', '-23.1092', '-73.2679', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '10', '661.686', '-38.4629', '-73.3256', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '11', '688.575', '-56.3307', '-72.5608', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '12', '723.935', '-91.0813', '-71.6334', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '13', '688.575', '-56.3307', '-72.5608', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '14', '661.686', '-38.4629', '-73.3256', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '15', '654.979', '-23.1092', '-73.2679', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '16', '641.05', '-2.70842', '-73.2486', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '17', '626.423', '31.1992', '-73.9867', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '18', '615.804', '54.5907', '-73.2435', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '19', '626.573', '87.8224', '-73.245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '20', '646.748', '121.308', '-73.2764', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '21', '672.939', '126.329', '-73.3347', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '22', '684.26', '141.267', '-73.0777', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '23', '709.072', '153.098', '-72.1472', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('45868', '24', '723.607', '172.848', '-72.049', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 47793

UPDATE `creature` SET `modelid`='0', `position_x`='698.705', `position_y`='-112.313', `position_z`='-71.5597', `orientation`='2.35222', `spawndist`='0', `MovementType`='2' WHERE `guid`='47793';

DELETE FROM `creature_movement` WHERE `id`='47793';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('47793', '1', '676.798', '-90.2307', '-71.3314', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '2', '648.377', '-55.4042', '-73.2871', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '3', '633.829', '-22.9795', '-73.2442', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '4', '615.686', '24.084', '-73.6782', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '5', '637.238', '62.4306', '-73.2463', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '6', '658.546', '104.195', '-73.2762', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '7', '656.38', '138.719', '-73.314', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '8', '666.779', '156.764', '-73.2472', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '9', '670.164', '186.106', '-72.2097', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '10', '666.779', '156.764', '-73.2472', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '11', '656.38', '138.719', '-73.314', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '12', '658.546', '104.195', '-73.2762', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '13', '637.238', '62.4306', '-73.2463', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '14', '615.686', '24.084', '-73.6782', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '15', '633.829', '-22.9795', '-73.2442', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '16', '648.268', '-55.2706', '-73.3191', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '17', '676.798', '-90.2307', '-71.3314', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47793', '18', '697.865', '-114.558', '-71.6739', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 47795

UPDATE `creature` SET `modelid`='0', `position_x`='543.279', `position_y`='31.168', `position_z`='-70.6287', `spawndist`='0' WHERE `guid`='47795';

DELETE FROM `creature_movement` WHERE `id`='47795';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('47795', '1', '559.336', '25.6248', '-70.9375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47795', '2', '585.917', '30.7769', '-71.5727', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47795', '3', '593.018', '17.1292', '-72.0339', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47795', '4', '574.099', '8.61546', '-70.391', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47795', '5', '558.878', '15.2068', '-70.477', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47795', '6', '543.641', '12.3111', '-70.38', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47795', '7', '532.831', '13.9816', '-70.7128', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47795', '8', '527.879', '24.4454', '-70.8921', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47795', '9', '541.627', '30.8387', '-70.7471', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 47716

UPDATE `creature` SET `position_x`='953.696', `position_y`='-333.891', `position_z`='-71.658', `orientation`='5.45262', `spawndist`='0' WHERE `guid`='47716';

DELETE FROM `creature_movement` WHERE `id`='47716';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('47716', '1', '966.938', '-348.388', '-71.7394', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '2', '983.848', '-364.54', '-65.9521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '3', '971.354', '-385.583', '-61.7422', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '4', '959.036', '-399.658', '-60.8377', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '5', '941.767', '-415.445', '-55.1021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '6', '918.571', '-399.838', '-49.4846', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '7', '899.659', '-377.061', '-49.9357', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '8', '918.571', '-399.838', '-49.4846', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '9', '941.767', '-415.445', '-55.1021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '10', '959.036', '-399.658', '-60.8377', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '11', '971.295', '-385.683', '-61.6674', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '12', '983.899', '-364.589', '-65.9473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '13', '967.006', '-348.462', '-71.711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47716', '14', '951.51', '-331.141', '-71.7394', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 90810

UPDATE `creature` SET `modelid`='0', `position_x`=' 808.8599', `position_y`='-36.32873', `position_z`='-53.71901', `orientation`='2.305541', `spawndist`='0', `MovementType`='2' WHERE `guid`='90810';

DELETE FROM `creature_movement` WHERE `id`='90810';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('90810', '1', '795.791', '-21.86399', '-53.65269', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '2', '802.4556', '-8.263514', '-53.68124', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '3', '798.2274', '7.701714', '-53.70551', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '4', '781.1216', '8.112905', '-53.70006', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '5', '777.2592', '21.72934', '-53.67865', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '6', '761.2012', '22.35078', '-53.64519', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '7', '762.3487', '41.59404', '-53.70325', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '8', '799.3561', '43.34861', '-53.67487', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '9', '803.8307', '32.75117', '-53.63648', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '10', '799.3561', '43.34861', '-53.67487', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '11', '762.3487', '41.59404', '-53.70325', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '12', '761.2012', '22.35078', '-53.64519', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '13', '777.2592', '21.72934', '-53.67865', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '14', '781.1216', '8.112905', '-53.70006', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '15', '798.2274', '7.701714', '-53.70551', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '16', '802.4556', '-8.263514', '-53.68124', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '17', '795.791', '-21.86399', '-53.65269', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90810', '18', '813.2817', '-40.84308', '-53.73804', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 90591

UPDATE `creature` SET `modelid`='0', `position_x`='771.2347', `position_y`='54.82289', `position_z`='-53.72943', `orientation`='3.631114', `spawndist`='0', `MovementType`='2' WHERE `guid`='90591';

DELETE FROM `creature_movement` WHERE `id`='90591';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('90591', '1', '762.993', '50.43193', '-53.71109', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '2', '761.4188', '29.33115', '-53.62895', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '3', '762.9675', '9.711073', '-53.70116', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '4', '769.3185', '-3.635589', '-53.72075', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '5', '777.6145', '-18.19811', '-53.69268', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '6', '792.4933', '-18.67612', '-53.638', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '7', '802.6974', '-9.927484', '-53.67644', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '8', '803.8586', '12.95672', '-53.67821', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '9', '803.3323', '36.05414', '-53.6515', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '10', '788.0638', '46.94962', '-53.71598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('90591', '11', '773.9392', '57.17932', '-53.70298', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- 47294

UPDATE `creature` SET `modelid`='0', `position_x`='753.3763', `position_y`='41.77242', `position_z`='-53.55002', `orientation`='3.071779', `spawndist`='0', `MovementType`='2' WHERE `guid`='47294';

DELETE FROM `creature_movement` WHERE `id`='47294';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('47294', '1', '764.5972', '45.60373', '-53.73522', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '2', '774.8519', '60.06964', '-53.67472', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '3', '774.8519', '60.06964', '-53.67472', '5000', '4729401', '0', '0', '0', '0', '0', '0', '0', '2.251475', '0', '0'),
('47294', '4', '784.5489', '54.02416', '-53.73522', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '5', '785.1476', '35.85176', '-53.69954', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '6', '776.2892', '27.4625', '-53.6479', '20000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '7', '783.7801', '14.00154', '-53.69062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '8', '786.7015', '-12.90366', '-53.69477', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '9', '784.7334', '-32.3172', '-53.71082', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '10', '784.6624', '-39.48956', '-53.74002', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '11', '781.2883', '-46.3105', '-53.74668', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '12', '778.1983', '-33.92217', '-53.73601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '13', '783.9739', '-27.30031', '-53.69369', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '14', '762.94', '8.657146', '-53.70293', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '15', '761.0406', '41.19921', '-53.69276', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('47294', '16', '753.7232', '41.79961', '-53.63493', '25000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `dbscripts_on_creature_movement` WHERE `id`='4729401';
INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('4729401', '0', '1', '69', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Weapon Technician - state_usestanding'),
('4729401', '5', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Weapon Technician - oneshot_none');
-- 47631

UPDATE `creature` SET `modelid`='0', `position_x`='960.0227', `position_y`='-340.8864', `position_z`='-71.45806', `orientation`='5.654867', `MovementType`='2' WHERE `guid`='47631';

DELETE FROM `creature_movement` WHERE `id`='47631';
DELETE FROM `creature_movement_template` WHERE `entry`='9056';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('9056', '1', '975.1074', '-354.1521', '-69.12189', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '2', '984.4438', '-363.9444', '-65.90663', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '3', '984.3798', '-372.8271', '-66.40864', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '4', '976.4786', '-381.1849', '-63.92666', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '5', '962.8773', '-395.4465', '-60.83775', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '6', '950.4175', '-408.5885', '-57.13513', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '7', '941.7361', '-417.3307', '-55.03955', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '8', '931.4461', '-413.3182', '-55.3833', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '9', '923.4091', '-403.9856', '-51.10405', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '10', '914.4991', '-394.1788', '-49.44118', '3000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '11', '905.6043', '-403.5466', '-48.72953', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '12', '905.6043', '-403.5466', '-48.72953', '15000', '4763101', '0', '0', '0', '0', '0', '0', '0', '4.39823', '0', '0'),
('9056', '13', '912.6644', '-392.947', '-49.27441', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '14', '918.4413', '-398.0002', '-49.63673', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '15', '926.4142', '-407.2958', '-52.62156', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '16', '930.0383', '-418.3499', '-55.38773', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '17', '930.1507', '-424.8481', '-55.86452', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '18', '927.5943', '-433.7152', '-56.52362', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '19', '927.5943', '-433.7152', '-56.52362', '15000', '4763102', '0', '0', '0', '0', '0', '0', '0', '4.049164', '0', '0'),
('9056', '20', '936.1234', '-427.9398', '-56.10722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '21', '939.6413', '-426.6046', '-55.76141', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '22', '944.4061', '-426.6593', '-54.99844', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '23', '946.326', '-428.0528', '-54.6023', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '24', '946.326', '-428.0528', '-54.6023', '3000', '4763103', '0', '0', '0', '0', '0', '0', '0', '0.1570796', '0', '0'),
('9056', '25', '943.7764', '-418.105', '-54.94675', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '26', '947.0441', '-410.4389', '-55.96638', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '27', '955.1072', '-403.4389', '-59.51071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '28', '961.6575', '-396.6303', '-60.83775', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '29', '968.2845', '-389.0584', '-60.83775', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '30', '978.0145', '-379.6125', '-64.63842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '31', '986.5466', '-370.8159', '-66.56243', '90000', '4763104', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '32', '974.0306', '-355.6249', '-69.1521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '33', '967.597', '-349.4773', '-71.39046', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('9056', '34', '963.2667', '-343.7354', '-71.73941', '210000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` IN ('4763101', '4763102', '4763103', '4763104');
INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('4763101', '3', '1', '133', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fineous Darkvire - state_usestanding_nosheathe'),
('4763101', '13', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fineous Darkvire - oneshot_none'),
('4763102', '3', '1', '173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fineous Darkvire - state_work'),
('4763102', '13', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fineous Darkvire - oneshot_none'),
('4763103', '1', '1', '16', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fineous Darkvire - oneshot_kneel'),
('4763104', '0', '20', '1', '3', '0', '0', '8', '0', '0', '0', '0', '0', '0', '0', '0', 'Fineous Darkvire - movementtype_random'),
('4763104', '90', '20', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fineous Darkvire - movementtype_waypoint');

DELETE FROM `creature` WHERE `guid` IN ('91106', '91107');
DELETE FROM `creature_addon` WHERE `guid` IN ('91106', '91107');

DELETE FROM `creature` WHERE `guid` IN ('47648', '47646', '47640', '47632', '47607', '47608');
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('47648', '8904', '230', '0', '0', '1420.51', '-737.976', '-85.0699', '5.13127', '7200', '0', '0', '2470', '5013', '0', '0'),
('47646', '8904', '230', '0', '0', '1345.29', '-806.316', '-85.0695', '0.750492', '7200', '0', '0', '2470', '5013', '0', '0'),
('47640', '8904', '230', '0', '0', '1395.83', '-821.299', '-91.8982', '0.0349066', '7200', '0', '0', '2470', '5013', '0', '0'),
('47632', '8904', '230', '0', '0', '1359.29', '-823.739', '-91.8983', '2.07694', '7200', '0', '0', '2470', '5013', '0', '0'),
('47607', '8904', '230', '0', '0', '1406.23', '-804.881', '-85.0685', '1.01229', '7200', '0', '0', '2470', '5013', '0', '0'),
('47608', '8904', '230', '0', '0', '1424.55', '-772.501', '-91.8962', '3.12414', '7200', '0', '0', '2470', '5013', '0', '0');







UPDATE `creature` SET `modelid`='0', `spawndist`='10', `MovementType`='1' WHERE `guid`='90601';
UPDATE `creature` SET `modelid`='0', `spawndist`='10', `MovementType`='1' WHERE `guid`='47565';
-- Fixed quest 3801 (Dark Iron Legacy) in Blackrock Mountain
-- Missing condition added for gossip
-- Missing end script added

SET @COND := 205;

DELETE FROM `conditions` WHERE `condition_entry` = @COND;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
(@COND, 9, 3801, 0);

UPDATE `gossip_menu_option` SET `condition_id` = @COND WHERE `menu_id` = 1663;
UPDATE `gossip_menu` SET `script_id` = 166601 WHERE `entry` = 1666;

UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `entry` = 3801;

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 166601;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(166601, 0, 7, 3801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'complete quest');

DELETE FROM `mail_loot_template` WHERE `entry`='110';
INSERT INTO `mail_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
('110', '20645', '100', '0', '1', '1', '0');

UPDATE `quest_template` SET `RewMailTemplateId`='110', `RewMailDelaySecs`='86400' WHERE `entry`='8287';

-- Wandering Eye of Kilrogg
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `HealthMultiplier`='0.1', `ArmorMultiplier`='1', `MinLevelHealth`='305', `MaxLevelHealth`='305', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MinLootGold`='0', `MaxLootGold`='0', `MovementType`='1' WHERE `Entry`='14386';

UPDATE `creature_template_classlevelstats` SET `BaseDamageExp0`='34.482' WHERE `Level`='61' and`Class`='1';
-- Added missing GO 165554 (Heart of the Mountain) in Blackrock Depths
DELETE FROM `gameobject` WHERE `guid` = 1344;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(1344, 165554, 230, 802.907, -356.401, -48.9423, -0.785397, 0, 0, -0.382683, 0.92388, 120, 255, 1);

UPDATE `creature` SET `modelid`='0', `position_x`='837.646', `position_y`='-346.113', `position_z`='-52.0496', `orientation`='0.163293', `spawndist`='0', `MovementType`='2' WHERE `guid`='54767';
UPDATE `creature` SET `modelid`='0', `position_x`='788.881', `position_y`='-336.129', `position_z`='-50.4012', `orientation`='2.12786', `spawndist`='0', `MovementType`='2' WHERE `guid`='54721';
UPDATE `creature` SET `modelid`='0', `position_x`='617.64', `position_y`='-223.231', `position_z`='-61.1964', `orientation`='5.81495', `spawndist`='0' WHERE `guid`='54733';

DELETE FROM `creature_movement` WHERE `id` IN ('54721', '54767', '54733');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('54721', '1', '784.514', '-329.119', '-50.0284', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '2', '764.984', '-324.438', '-51.5668', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '3', '749.575', '-337.565', '-50.711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '4', '726.619', '-332.595', '-50.9028', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '5', '710.256', '-333.295', '-51.8757', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '6', '689.742', '-330.869', '-52.1619', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '7', '674.977', '-327.453', '-52.1277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '8', '664.431', '-341.292', '-52.4921', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '9', '674.977', '-327.453', '-52.1277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '10', '689.742', '-330.869', '-52.1619', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '11', '710.256', '-333.295', '-51.8757', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '12', '726.619', '-332.595', '-50.9028', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '13', '749.332', '-337.513', '-50.7263', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '14', '764.902', '-324.507', '-51.5706', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '15', '784.514', '-329.119', '-50.0284', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54721', '16', '792.5', '-339.12', '-51.1177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54767', '1', '869.798', '-340.816', '-50.5748', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54767', '2', '882.282', '-377.741', '-52.0554', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54767', '3', '886.861', '-419.037', '-52.3727', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54767', '4', '886.861', '-419.037', '-52.3727', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54767', '5', '882.282', '-377.741', '-52.0554', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54767', '6', '869.798', '-340.816', '-50.5748', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54767', '7', '829.586', '-349.214', '-52.0311', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '1', '629.567', '-229.285', '-59.0616', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '2', '630.475', '-251.076', '-52.8189', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '3', '635.491', '-278.567', '-53.5015', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '4', '642.036', '-307.16', '-52.0211', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '5', '644.665', '-314.411', '-52.0764', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '6', '652.222', '-324.701', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '7', '650.916', '-339.38', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '8', '631.083', '-348.107', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '9', '618.584', '-352.651', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '10', '615.864', '-362.478', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '11', '601.241', '-383.172', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '12', '615.727', '-362.671', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '13', '618.584', '-352.651', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54733', '14', '631.083', '-348.107', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='753.899', `position_y`='-478.24', `position_z`='-52.9061', `orientation`='5.36458', `spawndist`='0', `MovementType`='2' WHERE `guid`='55090';
UPDATE `creature` SET `modelid`='0', `position_x`='807.818', `position_y`='-373.907', `position_z`='-59.0394', `orientation`='4.50135', `spawndist`='0', `MovementType`='2' WHERE `guid`='54362';
UPDATE `creature` SET `modelid`='0', `position_x`='712.483', `position_y`='-340.126', `position_z`='51.8134', `orientation`='4.2224', `spawndist`='0', `MovementType`='2' WHERE `guid`='54682';

DELETE FROM `creature_movement` WHERE `id` IN ('55090', '54362', '54682');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('55090', '1', '763.721', '-491.101', '-52.9628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '2', '771.351', '-514.9', '-52.809', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '3', '778.083', '-526.269', '-50.1292', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '4', '795.591', '-531.922', '-46.8029', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '5', '806.335', '-516.47', '-41.7183', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '6', '803.93', '-498.025', '-40.1386', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '7', '790.813', '-490.499', '-39.9062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '8', '775.956', '-484.787', '-40.554', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '9', '771', '-468.174', '-41.1924', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '10', '748.947', '-467.97', '-38.6926', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '11', '733.283', '-472.854', '-40.6056', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '12', '732.63', '-485.955', '-41.1771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '13', '737.17', '-503.406', '-41.0881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '14', '731.663', '-522.193', '-41.3618', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '15', '743.795', '-546.76', '-33.0687', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '16', '761.255', '-559.478', '-32.9473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '17', '770.305', '-540.82', '-36.2739', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '18', '761.255', '-559.478', '-32.9473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '19', '743.795', '-546.76', '-33.0687', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '20', '731.642', '-522.264', '-41.3582', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '21', '737.17', '-503.406', '-41.0881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '22', '732.63', '-485.955', '-41.1771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '23', '733.283', '-472.854', '-40.6056', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '24', '748.947', '-467.97', '-38.6926', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '25', '771', '-468.174', '-41.1924', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '26', '775.956', '-484.787', '-40.554', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '27', '790.813', '-490.499', '-39.9062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '28', '803.93', '-498.025', '-40.1386', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '29', '806.335', '-516.47', '-41.7183', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '30', '795.591', '-531.922', '-46.8029', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '31', '778.083', '-526.269', '-50.1292', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '32', '771.351', '-514.9', '-52.809', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '33', '763.721', '-491.101', '-52.9628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('55090', '34', '745.018', '-470.13', '-52.932', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '1', '802.307', '-399.631', '-58.6786', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '2', '794.326', '-424.056', '-53.7634', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '3', '804.861', '-435.457', '-54.3872', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '4', '828.242', '-447.366', '-56.3251', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '5', '863.367', '-424.879', '-52.4803', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '6', '880.127', '-407.996', '-51.9375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '7', '881.719', '-383.418', '-52.0587', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '8', '870.876', '-356.302', '-51.9569', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '9', '847.458', '-345.491', '-52.0496', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '10', '826.787', '-344.677', '-51.8641', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '11', '808.003', '-347.446', '-51.7879', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '12', '775.91', '-328.178', '-50.0448', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '13', '756.83', '-326.607', '-51.5775', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '14', '775.91', '-328.178', '-50.0448', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '15', '808.003', '-347.446', '-51.7879', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '16', '826.787', '-344.677', '-51.8641', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '17', '847.458', '-345.491', '-52.0496', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '18', '870.876', '-356.302', '-51.9569', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '19', '881.719', '-383.418', '-52.0587', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '20', '880.127', '-407.996', '-51.9375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '21', '863.367', '-424.879', '-52.4803', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '22', '828.242', '-447.366', '-56.3251', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '23', '804.861', '-435.457', '-54.3872', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '24', '794.326', '-424.056', '-53.7634', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '25', '802.307', '-399.631', '-58.6786', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54362', '26', '806.3', '-374.526', '-59.1968', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '1', '704.78', '-354.567', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '2', '688.518', '-374.707', '-52.0337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '3', '664.968', '-367.766', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '4', '653.587', '-356.119', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '5', '632.64', '-350.617', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '6', '619.242', '-351.718', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '7', '605.31', '-377.231', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '8', '618.102', '-353.072', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '9', '646.418', '-346.681', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '10', '656.121', '-333.659', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '11', '642.682', '-309.279', '-52.0213', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '12', '636.873', '-290.451', '-52.4324', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '13', '633.122', '-257.915', '-53.0354', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '14', '631.546', '-229.03', '-59.214', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '15', '632.252', '-273.576', '-53.5685', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '16', '639.393', '-299.352', '-52.0207', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '17', '649.654', '-322.972', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '18', '662.256', '-329.124', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '19', '675.187', '-326.388', '-52.0826', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '20', '692.328', '-322.362', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '21', '709.139', '-325.213', '-51.851', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '22', '692.328', '-322.362', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '23', '675.211', '-326.383', '-52.0797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '24', '662.4', '-329.094', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '25', '649.654', '-322.972', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '26', '639.393', '-299.352', '-52.0207', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '27', '632.252', '-273.576', '-53.5685', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '28', '631.546', '-229.03', '-59.214', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '29', '633.122', '-257.915', '-53.0354', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '30', '636.835', '-290.33', '-52.5084', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '31', '642.682', '-309.279', '-52.0213', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '32', '656.121', '-333.659', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '33', '646.418', '-346.681', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '34', '618.102', '-353.072', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '35', '605.31', '-377.231', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '36', '619.242', '-351.718', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '37', '632.64', '-350.617', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '38', '653.587', '-356.119', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '39', '664.968', '-367.766', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '40', '688.518', '-374.707', '-52.0337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '41', '704.78', '-354.567', '-52.0194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('54682', '42', '714.44', '-332.152', '-51.7661', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_movement` WHERE `id` IN ('138185', '138184');

UPDATE `creature` SET `position_x`='491.2311', `position_y`='97.38786', `position_z`='-2.500396', `orientation`='4.031711', `currentwaypoint`='0', `MovementType`='0' WHERE `guid`='138185';
UPDATE `creature` SET `position_x`='410.7114', `position_y`='-3.150411', `position_z`='-24.55797', `orientation`='5.288348', `spawndist`='3', `currentwaypoint`='0', `MovementType`='1' WHERE `guid`='138184';
-- Added missing equipment to three NPCs in Blackrock Depths
-- Watchman Doomgrip, Gorosh the Dervish and Ok'thor the Breaker

SET @ENTRY := 2427;

DELETE FROM `creature_equip_template_raw` WHERE `entry` IN (@ENTRY, @ENTRY + 1);
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(@ENTRY, 19126, 19126, 0, 50267138, 50267138, 0, 781, 781, 0),
(@ENTRY + 1, 5136, 0, 0, 50267138, 0, 0, 781, 0, 0);


UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY WHERE `Entry` = 9027;
UPDATE `creature_template` SET `EquipmentTemplateId` = 173 WHERE `Entry` = 9030;
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 1 WHERE `Entry` = 9476;
-- Added missing lore text to GOs 153556 (Thaurissan Relic) in Burning Steppes
-- Thanks thetrueanimal for pointing. This closes #649 
-- sources: http://www.wowhead.com/object=153556/thaurissan-relic#comments
-- http://www.wowhead.com/quest=3701/the-smoldering-ruins-of-thaurissan

SET @ENTRY := 2000000352;
SET @CHAT_TYPE := 4;
SET @GUID := 4603;
SET @NPC := 8887;

DELETE FROM `db_script_string` WHERE `entry` BETWEEN @ENTRY + 1 AND @ENTRY + 8;
INSERT INTO `db_script_string` VALUES
(@ENTRY + 1, 'You will perish here. <Your mind fills with visions of chaos and destruction.>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, @CHAT_TYPE, 0, 0, NULL),
(@ENTRY + 2, 'Leave this place. <The relic emits a white hot arc of flame. A memory has been gained: A lone Dark Iron dwarf is surrounded by seven corpses, kneeling before a monolith of flame.>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, @CHAT_TYPE, 0, 0, NULL),
(@ENTRY + 3, 'Defiler... you will be punished for this incursion. <A symbol of flame radiates from the relic before it crumbles to the earth.>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, @CHAT_TYPE, 0, 0, NULL),
(@ENTRY + 4, 'Help us, outsider. <The relic crumbles to dust. A vision of eight Dark Iron dwarves performing some sort of ritual fills your head.>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, @CHAT_TYPE, 0, 0, NULL),
(@ENTRY + 5, 'Your existence is acknowledged. <The relic turns to dust. Your head throbs with newfound wisdom. Something evil lurks in the heart of the mountain.>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, @CHAT_TYPE, 0, 0, NULL),
(@ENTRY + 6, 'Leave this place. <The relic emits a white hot arc of flame. A memory has been gained: A lone Dark Iron dwarf is surrounded by seven corpses, kneeling before a monolith of flame.>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, @CHAT_TYPE, 0, 0, NULL),
(@ENTRY + 7, 'He cannot be defeated. <The relic burns to nothing. The memories it held are now your own. This city was destroyed by a being not of this world.>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, @CHAT_TYPE, 0, 0, NULL),
(@ENTRY + 8, 'Do not taint these ruins, mortal. <You are engulfed in a blinding flash of light. A creature composed entirely of flame is the only thing you can remember seeing.>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, @CHAT_TYPE, 0, 0, NULL);

DELETE FROM `dbscripts_on_go_use` WHERE `id` IN (4511, 4512, 4538, 4539, 4540, 4594, 4611, 6782, 6786, 6797, 6811, 6845, 6848, 4542,
 4513, 4514, 4515, 4541, 4612, 6770, 6784, 6793, 6802, 6841, 6847, 6853);
INSERT INTO `dbscripts_on_go_use` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(4511, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4512, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4538, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4539, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4540, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4594, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4611, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6782, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6786, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6797, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6811, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6845, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6848, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4542, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4513, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4514, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4515, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4541, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(4612, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6770, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6784, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6793, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6802, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6841, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6847, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper'),
(6853, 1, 0, @CHAT_TYPE, 0, @NPC, @GUID, 19, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, @ENTRY + 8, 0, 0, 0, 0, 'Thaurissan relic - random whisper');

UPDATE `quest_template` SET `SpecialFlags`='2', `ReqCreatureOrGOId1`='0', `ReqCreatureOrGOCount1`='0' WHERE `entry`='1173';
-- Added support for Dark Coffer event in Blackrock Depths
-- Added missing GO (portraits and nameplates) and put them into pools
-- Fixed texts on nameplates GOs
-- Added script to spawn Dark Keepers NPCs (one per instance)
-- Added waypoints for one of the Dark Keeper
-- Prevent exploit of the Dark Coffer
-- Various fixes: flags, factions, respawn time...
-- This closes #178 and closes #380
-- Thanks @nekoi and @scotty0100 for reporting
-- Thanks @evil-at-wow and @Tobschinski for data and researching

SET @GUID := 160005;
SET @POOL := 15007;
SET @TIME := 3 * 60 * 60 * 1000; -- 3 hours

-- Added missing GO spawns (Dark Keeper Nameplate and Dark Keeper Portrait)
-- Fixed spawn time
DELETE FROM `gameobject` WHERE `guid` BETWEEN @GUID + 1 AND @GUID + 10;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID + 1, 164820, 230, 831.54, -339.529, -46.682, 0.802851, 0, 0, 0.390731, 0.920505, @TIME, 100, 1),
(@GUID + 2, 164821, 230, 831.54, -339.529, -46.682, 0.802851, 0, 0, 0.390731, 0.920505, @TIME, 100, 1),
(@GUID + 3, 164822, 230, 831.54, -339.529, -46.682, 0.802851, 0, 0, 0.390731, 0.920505, @TIME, 100, 1),
(@GUID + 4, 164823, 230, 831.54, -339.529, -46.682, 0.802851, 0, 0, 0.390731, 0.920505, @TIME, 100, 1),
(@GUID + 5, 164824, 230, 831.54, -339.529, -46.682, 0.802851, 0, 0, 0.390731, 0.920505, @TIME, 100, 1),
(@GUID + 6, 164818, 230, 831.471, -339.58, -46.7698, 0.820305, 0, 0, 0.398749, 0.91706, @TIME, 100, 1),
(@GUID + 7, 161456, 230, 831.471, -339.58, -46.7698, 0.820305, 0, 0, 0.398749, 0.91706, @TIME, 100, 1),
(@GUID + 8, 161457, 230, 831.471, -339.58, -46.7698, 0.820305, 0, 0, 0.398749, 0.91706, @TIME, 100, 1),
(@GUID + 9, 161458, 230, 831.471, -339.58, -46.7698, 0.820305, 0, 0, 0.398749, 0.91706, @TIME, 100, 1),
(@GUID + 10, 161459, 230, 831.471, -339.58, -46.7698, 0.820305, 0, 0, 0.398749, 0.91706, @TIME, 100, 1);
UPDATE `gameobject` SET `spawntimesecs` = @TIME WHERE `id` IN (164825, 164819);

-- Fixed wrong flags for some of the Dark Keeper Nameplate
UPDATE `gameobject_template` SET `flags` = 0 WHERE `entry` IN (164820, 164825);

-- Group all the GOs into pools and pools of pools to have only one Dark Keeper per instance
DELETE FROM `pool_gameobject` WHERE `guid` IN (@GUID + 1, @GUID + 2, @GUID + 3, @GUID + 4, @GUID + 5, @GUID + 6, @GUID + 7, @GUID + 8, @GUID + 9, @GUID + 10, 43130, 43131);
INSERT INTO `pool_gameobject` VALUES
(43130, @POOL, 100 ,'Dark Keeper Nameplate'),
(43131, @POOL, 100 ,'Dark Keeper Nameplate'),
(@GUID + 1, @POOL + 1, 100, 'Dark Keeper Nameplate'),
(@GUID + 7, @POOL + 1, 100, 'Dark Keeper Nameplate'),
(@GUID + 2, @POOL + 2, 100, 'Dark Keeper Nameplate'),
(@GUID + 8, @POOL + 2, 100, 'Dark Keeper Nameplate'),
(@GUID + 3, @POOL + 3, 100, 'Dark Keeper Nameplate'),
(@GUID + 9, @POOL + 3, 100, 'Dark Keeper Nameplate'),
(@GUID + 4, @POOL + 4, 100, 'Dark Keeper Nameplate'),
(@GUID + 10, @POOL + 4, 100, 'Dark Keeper Nameplate'),
(@GUID + 5, @POOL + 5, 100, 'Dark Keeper Nameplate'),
(@GUID + 6, @POOL + 5, 100, 'Dark Keeper Nameplate');

DELETE FROM `pool_pool` WHERE `pool_id` BETWEEN @POOL AND @POOL + 5;
INSERT INTO `pool_pool` VALUES
(@POOL, @POOL + 6, 0, 'Dark Keeper Nameplate'),
(@POOL + 1, @POOL + 6, 0, 'Dark Keeper Nameplate'),
(@POOL + 2, @POOL + 6, 0, 'Dark Keeper Nameplate'),
(@POOL + 3, @POOL + 6, 0, 'Dark Keeper Nameplate'),
(@POOL + 4, @POOL + 6, 0, 'Dark Keeper Nameplate'),
(@POOL + 5, @POOL + 6, 0, 'Dark Keeper Nameplate');

DELETE FROM `pool_template` WHERE `entry` BETWEEN @POOL AND @POOL + 6;
INSERT INTO `pool_template` VALUES
(@POOL, 2, 'Dark Keeper Nameplate'),
(@POOL + 1, 2, 'Dark Keeper Nameplate'),
(@POOL + 2, 2, 'Dark Keeper Nameplate'),
(@POOL + 3, 2, 'Dark Keeper Nameplate'),
(@POOL + 4, 2, 'Dark Keeper Nameplate'),
(@POOL + 5, 2, 'Dark Keeper Nameplate'),
(@POOL + 6, 1, 'MASTER - Dark Keeper Nameplate');

-- Fixed the name plate texts which were using wrong text or bad line breaks
UPDATE `page_text` SET `text` = 'Vorfalk Irongourd$B$BVorfalk works the store room of the Grim Guzzler, and his sacrifice to the Dark Keepers runs deep.$B$BMay his spirit hold strong.' WHERE `entry` = 1431;
UPDATE `page_text` SET `text` = 'Bethek Stormbrow$B$BBethek\'s wanderings take him deep within Blackrock. The secrets of the mountain beckon him.$B$BMay his spirit never falter.' WHERE `entry` = 1432;
UPDATE `page_text` SET `text` = 'Uggel Hammerhand$B$BUggel is a skilled and solemn chiseler, and when not burdened with the dark key, his hands shape great works in the Hall of Crafting.' WHERE `entry` = 1433;
UPDATE `page_text` SET `text` = 'Zimrel Darktooth$B$BWhen the madness of the dark key takes hold of Zimrel, only the screams of the dying can soothe him.$B$BFor his sacrifice, he will always have a bench above the arena.  May our blood sports temper the rage in his heart.' WHERE `entry` = 1434;
UPDATE `page_text` SET `text` = 'Ofgut Stonefist$B$BThose fallen before Dark Keeper Ofgut\'s hammer cannot be counted.$B$BThe soldiers of the West Garrison bow in awe as he passes.  For who among them can look into the eyes of Ofgut and see the secrets the dark key whispers?.' WHERE `entry` = 1435;
UPDATE `page_text` SET `text` = 'Pelver Deepstomp$B$BDark Keeper Pelver is our most honored disciple.  He has borne the key for longer than any, and it has cost him dearly.  When he is called for his burden, he is guarded in the Domicile.$B$BHis sacrifice is cherished, and he will remain in our hearts for many years... after the darkness takes him.' WHERE `entry` = 1436;

-- Added script for each Dark Keeper portrait in order to spawn the respective Dark Keeper NPC and his guards
DELETE FROM `dbscripts_on_go_template_use` WHERE `id` IN (161456, 161457, 161458, 161459, 164818, 164819);
INSERT INTO `dbscripts_on_go_template_use` VALUES
(161456, 0, 10, 9437, @TIME, 0, 0, 0, 0, 0, 0, 0, 815.276, -168.652, -49.6699, 6.23083, 'Spawn Dark Keeper Vorfalk and his guards'),
(161456, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 816.276, -167.652, -49.6699, 5.58505, 'Spawn Dark Keeper Vorfalk and his guards'),
(161456, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 817.276, -166.652, -49.6699, 4.88692, 'Spawn Dark Keeper Vorfalk and his guards'),
(161458, 0, 10, 9439, @TIME, 0, 0, 0, 0, 0, 0, 0, 901.537, -359.291, -49.908, 3.31613, 'Spawn Dark Keeper Uggel and his guards'),
(161458, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 903.295, -356.783, -49.8522, 3.68264, 'Spawn Dark Keeper Uggel and his guards'),
(161458, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 902.896, -361.966, -50.0812, 2.74017, 'Spawn Dark Keeper Uggel and his guards'),
(161459, 0, 10, 9441, @TIME, 0, 0, 0, 0, 0, 0, 0, 549.701, -214.474, -36.8893, 0.331613, 'Spawn Dark Keeper Zimrel and his guards'),
(161459, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 549.796, -217.958, -36.8654, 0.890118, 'Spawn Dark Keeper Zimrel and his guards'),
(161459, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 548.083, -212.932, -36.8628, 6.26573, 'Spawn Dark Keeper Zimrel and his guards'),
(164818, 0, 10, 9442, @TIME, 0, 0, 0, 0, 0, 0, 0, 679.491, -7.79026, -59.9754, 1.8326, 'Spawn Dark Keeper Ofgut and his guards'),
(164818, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 680.491, -6.79026, -59.9754, 2.18166, 'Spawn Dark Keeper Ofgut and his guards'),
(164818, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 681.491, -5.79026, -59.9754, 2.58309, 'Spawn Dark Keeper Ofgut and his guards'),
(164819, 0, 10, 9443, @TIME, 0, 0, 0, 0, 0, 0, 0, 802.755, -245.25, -43.2198, 2.93215, 'Spawn Dark Keeper Pelver and his guards'),
(164819, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 805.289, -243.172, -43.2198, 3.42085, 'Spawn Dark Keeper Pelver and his guards'),
(164819, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 801.935, -248.841, -43.2198, 1.95477, 'Spawn Dark Keeper Pelver and his guards'),
(161457, 0, 10, 9438, @TIME, 0, 0, 0, 0, 0, 0, 0, 862.461, -309.724, -49.8757, 3.85883, 'Spawn Dark Keeper Bethek and his guards'),
(161457, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 863.219, -305.041, -49.8751, 3.68264, 'Spawn Dark Keeper Bethek and his guards'),
(161457, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 860.947, -302.54, -49.8787, 4.04916, 'Spawn Dark Keeper Bethek and his guards'),
(161457, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 864.232, -303.735, -49.8527, 3.735, 'Spawn Dark Keeper Bethek and his guards'),
(161457, 0, 10, 9445, @TIME, 0, 0, 0, 0, 0, 0, 0, 862.676, -301.922, -49.8527, 3.9619, 'Spawn Dark Keeper Bethek and his guards');

-- Made Dark Coffer (GO 160845) usable by players only once they have open the Dark Coffer Door (GO 174565) 
DELETE FROM `dbscripts_on_go_template_use` WHERE `id` = 174565;
INSERT INTO `dbscripts_on_go_template_use` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(174565, 0, 27, 0x08, 0, 160845, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- Fixed spawn time of GO 160836 (Relic Coffer): they were respawning in 10 min, making them easily exploitable
UPDATE `gameobject` SET `spawntimesecs` = @TIME WHERE `id` = 160836;

-- Fixed faction and movement of the Dark Keepers: they are Dark Iron Dwarves and not wolves.
-- Only NPC 9438 (Dark Keeper Bethek) should move (WP movement)
UPDATE `creature_template` SET `FactionAlliance` = 54, `FactionHorde` = 54, `MovementType` = 0 WHERE `Entry` IN (9437, 9445, 9439, 9441, 9442, 9443);
UPDATE `creature_template` SET `FactionAlliance` = 54, `FactionHorde` = 54, `MovementType` = 2 WHERE `Entry` = 9438;
UPDATE `creature_template` SET `EquipmentTemplateId` = 156 WHERE `Entry` = 9445;

-- Waypoints for NPC 9438 (Dark Keeper Bethek)
-- He will now spawn in the back of the player using the Nameplate and kick his/her ass
DELETE FROM `creature_movement_template` WHERE `entry` = 9438;
INSERT INTO `creature_movement_template` VALUES
(9438, 1, 855.505, -309.724, -50.1398, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(9438, 2, 847.214, -316.912, -50.2843, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(9438, 3, 842.652, -321.334, -50.2848, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(9438, 4, 839.316, -324.232, -50.6638, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(9438, 5, 833.983, -329.089, -50.6638, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(9438, 6, 822.84, -339.999, -50.1851, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(9438, 7, 810.483, -350.225, -50.5781, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(9438, 8, 806.646, -353.272, -50.1957, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(9438, 9, 806.646, -353.272, -50.1957, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.715585, 0, 0);

-- Linked Dark Guards with Dark Keeper Bethek: aggro and follow
DELETE FROM `creature_linking_template` WHERE `entry` = 9445;
INSERT INTO `creature_linking_template` VALUES
(9445, 230, 9438, 515, 20);

UPDATE `creature` SET `modelid`='0', `position_x`='-3175.54', `position_y`='-2868.45', `position_z`='34.8193', `orientation`='1.963480', `spawndist`='0', `MovementType`='2' WHERE `guid`='8479';
UPDATE `creature` SET `modelid`='0', `position_x`='-3138.59', `position_y`='-2928.90', `position_z`='34.5513', `orientation`='1.649140', `spawndist`='0' WHERE `guid`='24050';
UPDATE `creature` SET `modelid`='0', `position_x`='-3095.63', `position_y`='-2871.48', `position_z`='34.1132', `orientation`='0.204674', `spawndist`='0', `MovementType`='2' WHERE `guid`='30450';

DELETE FROM `creature_movement` WHERE `id` IN ('8479', '24050', '30450');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('8479', '1', '-3180.15', '-2857.3', '35.9913', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('8479', '2', '-3176.94', '-2844.8', '35.2267', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('8479', '3', '-3170.16', '-2833.04', '34.6933', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('8479', '4', '-3160.74', '-2825.33', '34.3194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('8479', '5', '-3170.16', '-2833.04', '34.6933', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('8479', '6', '-3176.94', '-2844.8', '35.2267', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('8479', '7', '-3180.15', '-2857.3', '35.9913', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('8479', '8', '-3177.65', '-2866.58', '35.3351', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '1', '-3140.23', '-2907.91', '34.3162', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '2', '-3141.59', '-2888.42', '33.9922', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '3', '-3139.52', '-2875.64', '34.761', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '4', '-3137.37', '-2864.11', '34.7546', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '5', '-3131.76', '-2857.62', '34.9704', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '6', '-3122.09', '-2848.02', '34.8454', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '7', '-3111.08', '-2839.94', '34.3261', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '8', '-3098.52', '-2827.34', '34.363', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '9', '-3104.83', '-2842.1', '34.3349', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '10', '-3110.89', '-2851.87', '34.8088', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '11', '-3118.15', '-2869.64', '34.953', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '12', '-3118.79', '-2878.74', '35.078', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '13', '-3123.36', '-2885.75', '34.828', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '14', '-3128.95', '-2889.75', '34.578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '15', '-3129.52', '-2902.29', '34.116', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('24050', '16', '-3128.31', '-2913.81', '34.3355', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '1', '-3081.79', '-2868.61', '34.6922', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '2', '-3074.66', '-2870.62', '35.5564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '3', '-3068.83', '-2878.9', '39.7268', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '4', '-3075.73', '-2879.89', '35.0886', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '5', '-3082.28', '-2878.8', '34.1155', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '6', '-3090.32', '-2882.07', '34.8022', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '7', '-3094.6', '-2885.3', '35.1155', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '8', '-3099.95', '-2890.04', '34.6797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '9', '-3101.65', '-2898.47', '34.4566', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '10', '-3100.24', '-2912.59', '36.0703', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '11', '-3096.2', '-2918.31', '40.525', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '12', '-3092.2', '-2921.99', '42.586', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '13', '-3095.92', '-2918.65', '40.525', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '14', '-3100.24', '-2912.59', '36.0703', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '15', '-3101.64', '-2898.68', '34.453', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '16', '-3099.95', '-2890.04', '34.6797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '17', '-3094.6', '-2885.3', '35.1155', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '18', '-3090.32', '-2882.07', '34.8022', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '19', '-3082.28', '-2878.8', '34.1155', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '20', '-3075.73', '-2879.89', '35.0886', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '21', '-3068.83', '-2878.9', '39.7268', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '22', '-3074.66', '-2870.62', '35.5564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '23', '-3081.79', '-2868.61', '34.6922', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30450', '24', '-3089.66', '-2871.72', '33.9905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_ai_scripts` WHERE `id`='847701';
DELETE FROM `creature_ai_scripts` WHERE `id`='1037501';

UPDATE `creature_template` SET `AIName`='' WHERE `Entry`='8477';
UPDATE `creature_template` SET `AIName`='' WHERE `Entry`='10375';

SET @GUID := '3526';
SET @POOL := '25469';

DELETE FROM `creature` WHERE `id` IN ('10374', '10375', '10376', '10596');
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID + 0, '10374', '229', '0', '0', '-127.297', '-520.325', '11.7612', '1.586780', '7200', '0', '0', '8613', '0', '0', '2'),
(@GUID + 1, '10376', '229', '0', '0', '-138.318', '-468.999', '13.8768', '0.206570', '7200', '2', '0', '9156', '0', '0', '1'),
(@GUID + 2, '10374', '229', '0', '0', '-138.318', '-468.999', '13.8768', '0.206570', '7200', '2', '0', '8613', '0', '0', '1'),
(@GUID + 3, '10374', '229', '0', '0', '-143.059', '-478.358', '12.8284', '0.798163', '7200', '2', '0', '8613', '0', '0', '1'),
(@GUID + 4, '10374', '229', '0', '0', '-115.997', '-546.753', '2.13922', '5.827920', '7200', '2', '0', '8613', '0', '0', '1'),
(@GUID + 5, '10374', '229', '0', '0', '-109.584', '-558.254', '5.97215', '5.016080', '7200', '2', '0', '8613', '0', '0', '1'),
(@GUID + 6, '10374', '229', '0', '0', '-139.079', '-543.960', '7.28465', '1.544500', '7200', '2', '0', '8613', '0', '0', '1'),
(@GUID + 7, '10374', '229', '0', '0', '-146.663', '-538.030', '7.51950', '2.933440', '7200', '2', '0', '8613', '0', '0', '1'),
(@GUID + 8, '10375', '229', '0', '0', '-136.728', '-474.423', '12.8312', '2.082020', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 9, '10375', '229', '0', '0', '-142.430', '-473.287', '14.7701', '0.926899', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 10, '10375', '229', '0', '0', '-138.021', '-483.627', '11.5026', '4.643740', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 11, '10375', '229', '0', '0', '-144.252', '-486.798', '12.2607', '3.249650', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 12, '10375', '229', '0', '0', '-104.987', '-548.240', '2.40518', '4.187700', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 13, '10375', '229', '0', '0', '-103.748', '-553.987', '4.86079', '4.825850', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 14, '10375', '229', '0', '0', '-110.213', '-551.456', '3.32568', '4.707060', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 15, '10375', '229', '0', '0', '-116.352', '-553.506', '4.88814', '5.401010', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 16, '10375', '229', '0', '0', '-135.254', '-538.651', '7.12265', '7.144860', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 17, '10375', '229', '0', '0', '-141.288', '-537.482', '6.93766', '5.602510', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 18, '10375', '229', '0', '0', '-147.480', '-544.562', '7.88285', '1.102460', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 19, '10375', '229', '0', '0', '-139.028', '-532.190', '6.68119', '2.221220', '7200', '3', '0', '2699', '0', '0', '1'),
(@GUID + 20, '10596', '229', '0', '0', '-135.51', '-565.850', '10.1700', '0.670000', '1000000', '2', '0', '23688', '0', '0', '1');

DELETE FROM `creature_movement` WHERE `id`=@GUID + 0;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 0, '1', '-127.151', '-511.369', '11.3636', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '2', '-127.429', '-493.976', '11.3567', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '3', '-127.005', '-504.143', '11.3607', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '4', '-126.588', '-516.658', '11.7612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '5', '-126.609', '-520.664', '11.7612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '6', '-122.625', '-521.096', '11.7612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '7', '-116.240', '-521.575', '11.0583', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '8', '-104.837', '-520.382', '10.8036', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '9', '-116.714', '-521.250', '11.0689', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '10', '-125.462', '-520.888', '11.7612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '11', '-127.024', '-530.692', '11.3652', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '12', '-126.508', '-540.155', '11.3652', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '13', '-126.758', '-552.192', '11.3652', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '14', '-127.207', '-540.946', '11.3652', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '15', '-126.976', '-530.475', '11.3652', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '16', '-127.018', '-521.193', '11.7612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '17', '-130.026', '-520.442', '11.7612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '18', '-136.242', '-520.639', '11.3496', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '19', '-141.835', '-520.482', '11.3498', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '20', '-133.624', '-520.864', '11.3495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID + 0, '21', '-127.177', '-520.906', '11.7612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 1, @GUID + 2) OR `pool_entry`=@POOL;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID + 1, @POOL, '10', 'LBRS - Crystal Fang / Spire Spider'),
(@GUID + 2, @POOL, '90', 'LBRS - Crystal Fang / Spire Spider');

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL, '1', 'LBRS - Crystal Fang / Spire Spider');

UPDATE `creature_template` SET `MinLevel`='57', `Family`='3', `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='1', `DamageMultiplier`='3.7', `ArmorMultiplier`='1', `MinMeleeDmg`='73.4', `MaxMeleeDmg`='99.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='10374';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `Family`='3', `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `PowerMultiplier`='1', `DamageMultiplier`='3.7', `MinMeleeDmg`='77.9', `MaxMeleeDmg`='103.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='10376';
UPDATE `creature_template` SET `Family`='3', `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `PowerMultiplier`='1', `DamageMultiplier`='5.7', `MinMeleeDmg`='76.4', `MaxMeleeDmg`='101.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='10596';
UPDATE `creature_template` SET `UnitFlags`='32768', `CreatureTypeFlags`='73', `SpeedWalk`='1', `DamageMultiplier`='1.5', `MinMeleeDmg`='70.5', `MaxMeleeDmg`='95.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3327', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='10375';


SET @WP := '0';

UPDATE `creature` SET `position_x`='44.49939', `position_y`='-372.6492', `position_z`='48.79031', `orientation`='4.893657', `spawntimesecs`='7200' WHERE `id`='10799';

DELETE FROM `creature_movement_template` WHERE `entry`='10799';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('10799', @WP := @WP + 1, '49.90298', '-402.1319', '48.80593', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '58.41603', '-418.7091', '45.02646', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '71.58976', '-436.8153', '41.41042', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '78.66329', '-463.2451', '35.48121', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '81.10400', '-479.9030', '30.86245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '73.26363', '-487.8571', '27.89152', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '54.61135', '-489.3818', '28.67157', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '44.71681', '-491.0370', '29.58880', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '52.60767', '-511.5597', '29.21095', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '50.58394', '-533.1805', '26.77670', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '50.20008', '-560.1547', '30.55615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '50.46281', '-576.0350', '30.58301', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '39.67855', '-579.5101', '31.06995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '17.70854', '-578.2368', '26.56120', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-5.465746', '-576.0652', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-27.13421', '-574.5060', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-47.66818', '-572.6104', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-60.44478', '-573.6581', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-43.34514', '-571.0668', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-36.48037', '-563.5282', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-48.50640', '-537.1736', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-36.48037', '-563.5282', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-43.34514', '-571.0668', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-60.44478', '-573.6581', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-47.66818', '-572.6104', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-27.13421', '-574.5060', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '-5.465746', '-576.0652', '29.19087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '17.42213', '-578.2202', '26.65305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '39.67855', '-579.5101', '31.06995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '50.46281', '-576.0350', '30.58301', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '50.20008', '-560.1547', '30.55615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '50.54165', '-533.7271', '26.73937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '52.60767', '-511.5597', '29.21095', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '44.71681', '-491.0370', '29.58880', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '54.37603', '-489.4010', '28.65347', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '73.26363', '-487.8571', '27.89152', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '81.10400', '-479.9030', '30.86245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '78.66329', '-463.2451', '35.48121', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '71.58976', '-436.8153', '41.41042', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '58.41603', '-418.7091', '45.02646', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '49.90298', '-402.1319', '48.80593', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10799', @WP := @WP + 1, '46.01845', '-387.0023', '48.69103', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @GUID := '267';
SET @POOL := '25470';
SET @ENTRY := '175785';

DELETE FROM `gameobject` WHERE `id`=@ENTRY;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID + 0, @ENTRY, '229', '-10.52417', '-391.3383', '48.82137', '0', '0', '0', '-0.8746195', '0.4848101', '0', '0', '1'),
(@GUID + 1, @ENTRY, '229', '-12.27355', '-446.6286', '-18.64427', '0', '0', '0', '0.9170599', '0.3987495', '0', '0', '1'),
(@GUID + 2, @ENTRY, '229', '-18.37604', '-299.2709', '31.61826', '0', '0', '0', '0.9996567', '0.02620165', '0', '0', '1'),
(@GUID + 3, @ENTRY, '229', '-16.12174', '-492.5576', '90.65852', '0', '0', '0', '0.3665009', '0.93041770', '0', '0', '1');

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL, '1', 'LBRS - Inconspicuous Documents');

DELETE FROM `pool_gameobject_template` WHERE `id`=@ENTRY OR `pool_entry`=@POOL;
INSERT INTO `pool_gameobject_template` (`id`, `pool_entry`, `chance`, `description`) VALUES
(@ENTRY, @POOL, '0', 'LBRS - Inconspicuous Documents');

DELETE FROM `gameobject` WHERE `guid`='82573';
UPDATE `gameobject` SET `position_x`='-34.73237', `position_y`='-589.6146', `position_z`='30.93392', `orientation`='0', `rotation2`='0.7253742', `rotation3`='0.6883547' WHERE `guid`='82567';
UPDATE `gameobject` SET `position_x`='-36.29766', `position_y`='-589.6169', `position_z`='31.01031', `orientation`='0', `rotation2`='0.5224981', `rotation3`='0.8526405' WHERE `guid`='82568';
UPDATE `gameobject` SET `position_x`='-37.10931', `position_y`='-589.6414', `position_z`='30.95476', `orientation`='0', `rotation2`='0.6018143', `rotation3`='0.7986361' WHERE `guid`='82569';
UPDATE `gameobject` SET `position_x`='-35.6387', `position_y`='-589.6323', `position_z`='30.98253', `orientation`='0', `rotation2`='-0.8338852', `rotation3`='0.5519379' WHERE `guid`='82570';
UPDATE `gameobject` SET `position_x`='-37.78564', `position_y`='-589.6395', `position_z`='30.99642', `orientation`='0', `rotation2`='-0.9996567', `rotation3`='0.02620165' WHERE `guid`='82571';
UPDATE `gameobject` SET `position_y`='-589.6351', `position_z`='30.99642', `orientation`='0', `rotation2`='-0.2923717', `rotation3`='0.9563047' WHERE `guid`='82572';

UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='100' WHERE `entry`='9196' and`item`='12534';
-- Improved quest 4283 (Jail Break!) in Blackrock Depths
-- Fixed NPC 9682 (Marshal Reginald Windsor) factions, flags and speed
-- Faction is re-set based on SD2 script for the quest. After updating template of escortee NPC,
-- template faction is applied and faction was wrong. Set to same faction as SD2.
-- This closes #774
UPDATE `creature_template` SET `FactionAlliance`=231, `FactionHorde`=231, `UnitFlags`= 320, `CreatureTypeFlags`= 4096 WHERE `Entry`=9682;
UPDATE `creature_template` SET `SpeedWalk` = 1.14286, `SpeedRun` = 1.7, `MinLootGold` = 0, `MaxLootGold` = 0 WHERE `Entry` IN (9023, 9682);
-- Fixed some script texts used in quest 4322 (Jail Break!) in Blackrock Depths
SET @STRING_START := 2000005099;

DELETE FROM db_script_string WHERE entry in (@STRING_START,@STRING_START+1,@STRING_START+2,@STRING_START+3);
INSERT INTO db_script_string (entry, content_default) VALUES
(@STRING_START,'Get him out of there!'),
(@STRING_START+1,'Perhaps Ograbisi will use your head as a tiny little hat when I\'m through with you.'),
(@STRING_START+2,'Where I come from, you get shanked for opening another inmate\'s cell door!'),
(@STRING_START+3,'Ograbisi needs new hat.');

UPDATE `dbscripts_on_go_template_use` SET `dataint` = @STRING_START WHERE `id` = 170562;
UPDATE `dbscripts_on_go_template_use` SET `dataint` = @STRING_START + 1 WHERE `id` = 170569;
UPDATE `dbscripts_on_go_template_use` SET `dataint` = @STRING_START + 2 WHERE `id` = 170567;
UPDATE `dbscripts_on_go_template_use` SET `dataint` = @STRING_START + 3 WHERE `id` = 170568;

UPDATE `creature_template` SET `MinLevel`='62', `MaxLevel`='62', `HealthMultiplier`='25', `DamageMultiplier`='10', `ArmorMultiplier`='1', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10363';
UPDATE `creature_template` SET `DamageMultiplier`='9.1', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10814';
UPDATE `creature_template` SET `DamageMultiplier`='3.9', `MinMeleeDmg`='68.4', `MaxMeleeDmg`='92.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2788', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500', `ResistanceHoly`='0' WHERE `Entry`='10442';
UPDATE `creature_template` SET `DamageMultiplier`='3.75', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='10447';
UPDATE `creature_template` SET `MinLevel`='62', `MaxLevel`='62', `HealthMultiplier`='25', `DamageMultiplier`='10', `ArmorMultiplier`='1', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10430';
UPDATE `creature_template` SET `DamageMultiplier`='6', `ArmorMultiplier`='2', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10319';
UPDATE `creature_template` SET `DamageMultiplier`='6', `MinMeleeDmg`='119.5', `MaxMeleeDmg`='161.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2300', `RangedBaseAttackTime`='2300' WHERE `Entry`='10317';
UPDATE `creature_template` SET `DamageMultiplier`='7.5', `ArmorMultiplier`='0.5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='161.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10318';
UPDATE `creature_template` SET `DamageMultiplier`='6', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10371';
UPDATE `creature_template` SET `DamageMultiplier`='5', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3489', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9096';
UPDATE `creature_template` SET `DamageMultiplier`='3.9', `MinMeleeDmg`='92.9', `MaxMeleeDmg`='125.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2832', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10083';
UPDATE `creature_template` SET `DamageMultiplier`='6', `ArmorMultiplier`='1.5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='6095', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10366';
UPDATE `creature_template` SET `DamageMultiplier`='6', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10372';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `DamageMultiplier`='2.5', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10161';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `DamageMultiplier`='3.9', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3489', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10258';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `DamageMultiplier`='3.5', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3489', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10683';
UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `SpeedWalk`='1', `SpeedRun`='1.428571429', `DamageMultiplier`='6', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10264';
UPDATE `creature_template` SET `MinLevel`='62', `MaxLevel`='62', `FactionAlliance`='40', `FactionHorde`='40', `CreatureTypeFlags`='8', `HealthMultiplier`='10', `DamageMultiplier`='6.5', `ArmorMultiplier`='1', `MinMeleeDmg`='129.5', `MaxMeleeDmg`='171.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4391', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2400', `RangedBaseAttackTime`='2400' WHERE `Entry`='10429';
UPDATE `creature_template` SET `MinLevel`='62', `MaxLevel`='62', `FactionAlliance`='40', `FactionHorde`='40', `Scale`='0', `SpeedWalk`='1', `Rank`='3', `HealthMultiplier`='10', `DamageMultiplier`='6.5', `ArmorMultiplier`='1', `MinLevelHealth`='32370', `MaxLevelHealth`='32370', `MinMeleeDmg`='129.5', `MaxMeleeDmg`='171.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4391', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2400', `RangedBaseAttackTime`='2400', `MinLootGold`='6929', `MaxLootGold`='34647', `LootId`='15776', `EquipmentTemplateId`='1082', `AIName`='EventAI' WHERE `Entry`='15776';
UPDATE `creature_template` SET `FactionAlliance`='40', `FactionHorde`='40', `DamageMultiplier`='5', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10339';
UPDATE `creature_template` SET `MinLevel`='60', `HealthMultiplier`='5', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10762';
UPDATE `creature_template` SET `MinLevel`='59', `DamageMultiplier`='4', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9819';
UPDATE `creature_template` SET `MinLevel`='59', `HealthMultiplier`='3', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinLevelHealth`='8883', `MaxLevelHealth`='9156', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10681';
UPDATE `creature_template` SET `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9818';
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MaxLevelHealth`='7326', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10680';
UPDATE `creature_template` SET `DamageMultiplier`='4', `DamageVariance`='1', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9817';
UPDATE `creature_template` SET `DamageMultiplier`='2', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10316';
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `HealthMultiplier`='8', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9816';
UPDATE `creature_template` SET `MinLevel`='61', `MaxLevel`='61', `FactionAlliance`='40', `FactionHorde`='40', `Scale`='0', `SpeedWalk`='1', `HealthMultiplier`='4', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinLevelHealth`='12576', `MaxLevelHealth`='12576', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='4091', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MinLootGold`='981', `MaxLootGold`='1286', `LootId`='15796', `MechanicImmuneMask`='0', `MovementType`='1', `EquipmentTemplateId`='1138', `AIName`='EventAI' WHERE `Entry`='15796';
UPDATE `creature_template` SET `DamageMultiplier`='6', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='10899';
UPDATE `creature_template` SET `HealthMultiplier`='3', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinLevelHealth`='8883', `MaxLevelHealth`='8883', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3489', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='10509';
UPDATE `creature_template` SET `DamageMultiplier`='4', `ArmorMultiplier`='3', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10742';
UPDATE `creature_template` SET `DamageMultiplier`='1.2', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='258', `RangedAttackPower`='28' WHERE `Entry`='16066';
UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `MinLevelHealth`='3052', `MaxLevelHealth`='3052', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `RangedBaseAttackTime`='2000' WHERE `Entry`='16048';
UPDATE `creature_template` SET `SpeedWalk`='1', `HealthMultiplier`='45', `ArmorMultiplier`='1', `MinLevelHealth`='119925', `MaxLevelHealth`='119925', `MinMeleeDmg`='1329', `MaxMeleeDmg`='1759', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3795', `MeleeAttackPower`='252', `RangedAttackPower`='27' WHERE `Entry`='16073';
UPDATE `creature_template` SET `MinMeleeDmg`='1329', `MaxMeleeDmg`='1759', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3795', `MeleeAttackPower`='252', `RangedAttackPower`='27' WHERE `Entry`='16042';

UPDATE `creature_template` SET `ResistanceHoly`='0' WHERE NOT `ResistanceHoly`='0';
-- Fixed respawn time of NPCs 8901 (Anvilrage Reservist) in front of General Angerforge in Blackrock Depths
-- Made them respawn on General Angerforge fight reset. This contributes to #179 
UPDATE `creature` SET `spawntimesecs` = 3 * 60 * 60 WHERE `guid` IN (45955, 45956, 45958, 45959);

DELETE FROM `creature_linking` WHERE `guid` IN (45955, 45956, 45958, 45959);
INSERT INTO `creature_linking` VALUES
(45955, 45954, 1031),
(45956, 45954, 1031),
(45958, 45954, 1031),
(45959, 45954, 1031);

UPDATE `creature_template` SET `UnitFlags`='32832' WHERE `Entry`='10080';
UPDATE `creature_template` SET `UnitFlags`='32832' WHERE `Entry`='10081';

DELETE FROM `creature_loot_template` WHERE `entry`='255' AND `item` IN ('11614', '11615', '12827', '12830');

UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-`ChanceOrQuestChance` WHERE `item`='20087' AND `ChanceOrQuestChance`>'0';

DELETE FROM `creature` WHERE `guid`='45808';

DELETE FROM `creature` WHERE `guid` BETWEEN '7745' AND '7763' OR `id` IN ('9701', '10177');
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('7745', '10177', '229', '0', '0', '-68.8686', '-343.093', '55.1160', '1.81514', '7200', '2', '0', '3876', '0', '0', '1'),
('7746', '10177', '229', '0', '0', '-73.5343', '-331.947', '56.8824', '3.94444', '7200', '2', '0', '3876', '0', '0', '1'),
('7744', '10177', '229', '0', '0', '-66.8659', '-352.762', '54.4785', '1.08210', '7200', '2', '0', '3876', '0', '0', '1'),
('7747', '10177', '229', '0', '0', '-72.0317', '-347.075', '54.8219', '1.36136', '7200', '2', '0', '3876', '0', '0', '1'),
('7748', '10177', '229', '0', '0', '-71.5690', '-358.213', '54.5978', '2.39110', '7200', '2', '0', '3876', '0', '0', '1'),
('7749', '10177', '229', '0', '0', '-75.4103', '-341.562', '55.3937', '4.90438', '7200', '2', '0', '3876', '0', '0', '1'),
('7750', '10177', '229', '0', '0', '-79.7917', '-328.192', '58.5470', '5.95157', '7200', '2', '0', '3876', '0', '0', '1'),
('7751', '10177', '229', '0', '0', '-102.763', '-349.062', '60.7782', '1.51844', '7200', '2', '0', '3876', '0', '0', '1'),
('7752', '10177', '229', '0', '0', '-108.382', '-341.040', '61.1785', '1.64061', '7200', '2', '0', '3876', '0', '0', '1'),
('7753', '10177', '229', '0', '0', '-107.424', '-351.940', '59.7058', '4.48550', '7200', '2', '0', '3876', '0', '0', '1'),
('7754', '10177', '229', '0', '0', '-112.261', '-336.356', '62.3371', '4.92183', '7200', '2', '0', '3876', '0', '0', '1'),
('7755', '10177', '229', '0', '0', '-110.012', '-356.647', '58.5433', '4.36332', '7200', '2', '0', '3876', '0', '0', '1'),
('7756', '10177', '229', '0', '0', '-111.704', '-348.742', '60.0788', '0.82031', '7200', '2', '0', '3876', '0', '0', '1'),
('7757', '10177', '229', '0', '0', '-108.927', '-364.601', '56.6248', '1.04720', '7200', '2', '0', '3876', '0', '0', '1'),
('7758', '9701', '229', '0', '0', '-77.2828', '-324.738', '59.1126', '4.991640', '7200', '2', '0', '3876', '0', '0', '1'),
('7759', '9701', '229', '0', '0', '-80.2467', '-313.909', '59.7635', '0.45379', '7200', '2', '0', '3876', '0', '0', '1'),
('7760', '9701', '229', '0', '0', '-80.8737', '-298.923', '61.8178', '5.18363', '7200', '2', '0', '3876', '0', '0', '1'),
('7761', '9701', '229', '0', '0', '-109.429', '-324.918', '64.3253', '0.03491', '7200', '2', '0', '3876', '0', '0', '1'),
('7762', '9701', '229', '0', '0', '-112.332', '-331.009', '63.2146', '3.07178', '7200', '2', '0', '3876', '0', '0', '1'),
('7763', '9701', '229', '0', '0', '-112.900', '-323.074', '64.3181', '5.41052', '7200', '2', '0', '3876', '0', '0', '1');

UPDATE `creature_template` SET `MinLevel`='58', `UnitFlags`='32768', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='1.35', `ArmorMultiplier`='1', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10177';
UPDATE `creature_template` SET `MinLevel`='58', `UnitFlags`='32768', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='1.35', `ArmorMultiplier`='1', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9701';

UPDATE `creature` SET `modelid`='0', `MovementType`='1', `spawndist`='1', `spawntimesecs`='7200' WHERE `guid` IN ('160088', '160091', '160089', '160093', '160092', '160090');

UPDATE `creature` SET `modelid`='0', `position_x`='-19.7833', `position_y`='-365.125', `position_z`='50.1377', `orientation`='5.49779', `spawntimesecs`='7200', `MovementType`='2' WHERE `guid`='44456';

DELETE FROM `creature_movement` WHERE `id`='44456';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('44456', '1', '-29.4354', '-374.537', '49.2465', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('44456', '2', '-35.8591', '-385.568', '48.6559', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('44456', '3', '-46.1924', '-393.206', '49.2342', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('44456', '4', '-61.7472', '-396.152', '44.5767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('44456', '5', '-88.6538', '-400.578', '37.8984', '30000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('44456', '6', '-54.4929', '-392.754', '46.3396', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('44456', '7', '-32.5814', '-377.415', '49.0143', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('44456', '8', '-25.1649', '-365.964', '50.3259', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('44456', '9', '-19.7295', '-365.061', '50.0607', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('44456', '10', '-19.7295', '-365.061', '50.0607', '30000', '0', '0', '0', '0', '0', '0', '0', '0', '5.5676', '0', '0');
DELETE FROM `creature` WHERE `guid`='31839';

SET @ENTRY := '936';
SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@ENTRY);
SET @WP := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-9245.81', `position_y`='-2167.49', `position_z`='64.1168', `orientation`='3.58002', `MovementType`='2' WHERE `guid`='10080';

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`='936';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('936', '20', '-9245.68', '-2167.47', '63.9388', '15000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('936', '19', '-9245.3', '-2171.29', '63.9388', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '18', '-9212.64', '-2174.06', '64.0584', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '17', '-9187.23', '-2160.7', '64.0584', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '16', '-9187.41', '-2138.51', '64.0064', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '15', '-9212.24', '-2135.42', '64.0584', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '14', '-9232.15', '-2130.65', '64.0584', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '13', '-9246.59', '-2118.7', '65.591', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '12', '-9245.79', '-2099.05', '72.1959', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '11', '-9235.08', '-2087.05', '76.554', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '10', '-9189.04', '-2094.36', '87.8603', '15000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('936', '9', '-9206.65', '-2088.98', '86.1227', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '8', '-9220.59', '-2089.07', '81.4125', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '7', '-9234.09', '-2083.62', '76.7928', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '6', '-9234.39', '-2072.97', '76.5348', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '5', '-9239.85', '-2075.51', '75.7547', '15000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('936', '4', '-9243.47', '-2098.98', '72.6224', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '3', '-9246.5', '-2115.22', '66.5529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '2', '-9254.05', '-2135.93', '63.9399', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
('936', '1', '-9253.7', '-2167.14', '64.0579', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');-- Fixed quest 4136 (Ribbly Screwspigot) in Blackrock Depths
-- Added missing condition for gossip menu
-- Added missing script
-- Thanks Nekoi for pointing and @scotty0100 for providing solid basis for the fix
-- This closes #182

SET @ENTRY := 2000005626;
SET @CONDITION := 844;

DELETE FROM `conditions` WHERE `condition_entry` = @CONDITION;
INSERT INTO `conditions` VALUES
(@CONDITION, 9, 4136, 0);

UPDATE `gossip_menu_option` SET `action_menu_id`=-1, `action_script_id`=197001, `condition_id` = @CONDITION WHERE `menu_id`=1970 AND `id`=1;

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 197001;
INSERT INTO `dbscripts_on_gossip` VALUES
(197001, 0, 22, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ribbly - update faction'),
(197001, 0, 22, 21, 0, 10043, 46616, 0x10, 0, 0, 0, 0, 0, 0, 0, 0, 'Ribbly Crony - update faction'),
(197001, 0, 22, 21, 0, 10043, 46617, 0x10, 0, 0, 0, 0, 0, 0, 0, 0, 'Ribbly Crony - update faction'),
(197001, 0, 22, 21, 0, 10043, 46618, 0x10, 0, 0, 0, 0, 0, 0, 0, 0, 'Ribbly Crony - update faction'),
(197001, 3, 0, 0, 0, 0, 0, 0, @ENTRY, 0, 0, 0, 0, 0, 0, 0, ''),
(197001, 5, 26, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ribbly  - attack player');

DELETE FROM `db_script_string` WHERE `entry` = @ENTRY;
INSERT INTO `db_script_string` VALUES
(@ENTRY, 'No! Get away from me! Help!!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL);

SET @SCRIPTID := '5';

UPDATE `creature_template` SET `SpeedWalk`=('2.5' / '2.5') WHERE `entry` IN ('10408', '10409', '10809');
UPDATE `creature_template` SET `SpeedRun`=('8' / '7') WHERE `entry` IN ('10409');
UPDATE `creature_template` SET `SpeedRun`=('10' / '7') WHERE `entry` IN ('10408', '10809');

UPDATE `creature_movement` SET `script_id`=@SCRIPTID WHERE `id` IN (SELECT `guid` FROM `creature` WHERE `id` IN ('10408', '10409', '10809') AND `point`='1');

DELETE FROM `dbscripts_on_creature_movement` WHERE `id`=@SCRIPTID;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(@SCRIPTID, '0', '25', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stratholme - Gargoyles - RUN ON');

UPDATE `creature_template` SET `UnitFlags`='64', `CreatureTypeFlags`='72', `MinMeleeDmg`='88.3', `MaxMeleeDmg`='119.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='218', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2000' WHERE `Entry`='4475';
UPDATE `creature_template` SET `UnitFlags`='64', `CreatureTypeFlags`='72', `MinMeleeDmg`='90.0', `MaxMeleeDmg`='122.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='224', `RangedAttackPower`='22' WHERE `Entry`='4474';

UPDATE `creature_template` SET `UnitFlags`='64', `CreatureTypeFlags`='72', `MinMeleeDmg`='85.7', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000' WHERE `Entry`='1794';
UPDATE `creature_template` SET `UnitFlags`='64', `CreatureTypeFlags`='72', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='118.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='220', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000' WHERE `Entry`='1795';
UPDATE `creature_template` SET `UnitFlags`='64', `CreatureTypeFlags`='72', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='132.4', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000' WHERE `Entry`='1802';
UPDATE `creature_template` SET `UnitFlags`='64', `CreatureTypeFlags`='72', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='129.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000' WHERE `Entry`='1804';

DELETE FROM `creature` WHERE `guid`='6858';
-- Fixed rank of NPC 16184 (Nerubian Overseer) because it was rare elite in Classic
UPDATE `creature_template` SET `rank` = 2 WHERE `Entry` = 16184;
-- Fixed rank of NPC 1852 (Araj the Summoner) because it is elite but not rare
UPDATE `creature_template` SET `rank` = 1 WHERE `Entry` = 1852;

-- Removed useless creature addon and moved them to creature_template_addon for NPC 10580 (Fetid Zombie) in Western Plaguelands
DELETE FROM `creature_template_addon` WHERE `entry` = 10580;
INSERT INTO `creature_template_addon` VALUES
(10580, 0, 0, 1, 16, 0, 0, NULL);

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 10580);

-- Fixed stats of NPC 10717 (Temporal Parasite) that was dealing too much damage and was missing mana
UPDATE `creature_template` SET `InhabitType` = 1, `UnitClass` = 2, `MinLevelHealth` = 2823, `MaxLevelHealth` = 3006, `HealthMultiplier` = 1.35, `MinLevelMana` = 2117, `MaxLevelMana` = 2241, `ArmorMultiplier` = 1 WHERE `Entry` = 10717;
UPDATE `creature_template` SET `MinMeleeDmg` = 93, `MaxMeleeDmg` = 130, `MeleeAttackPower` = 238, `MeleeBaseAttackTime` = 2000  WHERE `Entry` = 10717;

-- Added missing spell target
DELETE FROM `spell_script_target` WHERE `entry` = 16613;
INSERT INTO `spell_script_target` VALUES (16613, 0, 175795, 0);

-- Fixed stats of one undead NPC at Dalson's Tear in Western Plaguelands
UPDATE `creature_template` SET `MinMeleeDmg` = 88, `MaxMeleeDmg` = 122, `MeleeAttackPower` = 224, `RangedAttackPower` = 22, `MeleeBaseAttackTime` = 2000, `Armor` = 3180 WHERE `Entry` = 1785; -- Skeletal Terror

-- Fixed stats NPC 1796 (Freezing Ghoul) in Andorhal in Western Plaguelands: it was dealing too much damage (still having its elite damage)
-- also fixed Fire resistance of NPC 1795 (Searing Ghoul)
UPDATE `creature_template` SET `ResistanceFire` = 150 WHERE `Entry` = 1795; -- Searing Ghoul 
UPDATE `creature_template` SET `MinMeleeDmg` = 94, `MaxMeleeDmg` = 127, `MeleeAttackPower` = 234, `RangedAttackPower` = 22, `MeleeBaseAttackTime` = 2000 WHERE `Entry` = 1796; -- Freezeing Ghoul

-- Deleted NPC 10979 at Dalson's Tear in Western Plaguelands as it is summoned
DELETE FROM `creature` WHERE `guid` = 52635;
DELETE FROM `creature_addon` WHERE `guid` = 52635;

-- Fixed speed of NPC 11076 (Cauldron Lord Razarch) in Western Plaguelands who was moving too fast (walk/run speed were inverted)
UPDATE `creature_template` SET `SpeedWalk` = 1.14286, `SpeedRun` = 1.89 WHERE `Entry` = 11076;

-- Added missing WP to NPC 10816 (Wandering Skeleton) because
-- it was very static for a wandering one
-- Source: http://www.wowhead.com/npc=10816/wandering-skeleton#comments
DELETE FROM `creature_movement_template` WHERE `entry` = 10816;
INSERT INTO `creature_movement_template` VALUES
(10816, 1, 1936.95, -1635.07, 60.0263, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.59485, 0, 0),
(10816, 2, 1930.95, -1657.73, 59.31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.44345, 0, 0),
(10816, 3, 1912, -1660.12, 61.2311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.33997, 0, 0),
(10816, 4, 1902.82, -1651.78, 60.0138, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.40377, 0, 0),
(10816, 5, 1886.67, -1651.37, 61.2298, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.95355, 0, 0),
(10816, 6, 1882.75, -1629.76, 61.5077, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.75032, 0, 0),
(10816, 7, 1899.4, -1616.07, 60.4586, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.688462, 0, 0),
(10816, 8, 1915.49, -1615.05, 61.0254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0632846, 0, 0),
(10816, 9, 1927.59, -1627.02, 60.4777, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.4307, 0, 0),
(10816, 10, 1925.09, -1627, 60.455, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.942, 0, 0);

UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` = 10816;
UPDATE `creature` SET `position_x` = 1936.95, `position_y` = -1635.07, `position_z` = 60.0263, `MovementType` = 2 WHERE `id` = 10816;

-- Fixed drop chance of quest item 12738 (Dalson Outhouse Key) as it should only drop once the first part of the quest line is completed
-- Source: http://www.wowwiki.com/Locked_Away_quest_chain
SET @CONDITION := 1336;

DELETE FROM `conditions` WHERE `condition_entry` = @CONDITION;
INSERT INTO `conditions` VALUES (@CONDITION, 8, 5058, 0);

UPDATE `creature_loot_template` SET `condition_id` = @CONDITION WHERE `item` = 12738;
UPDATE `quest_template` SET `SpecialFlags` = 0 WHERE `entry` = 5058;

-- Removed spawns of NPC 10979 (Scarlet Hounds) because they should be summoned
DELETE FROM `creature` WHERE `guid` IN (52664, 52666, 52667, 52665, 52668);
DELETE FROM `creature_addon` WHERE `guid` IN (52664, 52666, 52667, 52665, 52668);

-- Improved gossip menu of NPC 10739 (Mulgris Deepriver) in Western Plaguelands
SET @COND := 803;

DELETE FROM `conditions` WHERE `condition_entry` = @COND;
INSERT INTO `conditions` VALUES (@COND, 8, 4985, 0);

UPDATE `gossip_menu` SET `condition_id` = @COND WHERE `entry` = 2921 AND `text_id` = 3635;

-- Improved gossip menu of NPC 10304 (Aurora Skycaller) in Eastern Plaguelands
DELETE FROM `conditions` WHERE `condition_entry` IN (@COND + 1, @COND + 2);
INSERT INTO `conditions` VALUES
(@COND + 1, 9, 5247, 0),
(@COND + 2, 8, 5245, 0);

UPDATE `gossip_menu_option` SET `action_menu_id` = 50100, `condition_id` = @COND + 1 WHERE `menu_id` = 4743 AND `id` = 0;
UPDATE `gossip_menu_option` SET `action_menu_id` = 50101, `condition_id` = @COND + 1 WHERE `menu_id` = 4743 AND `id` = 1;

DELETE FROM `gossip_menu` WHERE `entry` IN (50100, 50101);
INSERT INTO `gossip_menu` VALUES
(50100, 5796, 0, 0),
(50101, 5797, 0, 0);

UPDATE `gossip_menu` SET `condition_id` = 3 WHERE `entry` = 4743 AND `text_id` = 5795;
UPDATE `gossip_menu` SET `condition_id` = @COND + 2 WHERE `entry` = 4743 AND `text_id` = 5817;

-- Added missing spawns of rare NPC 10821 (Hed'mush the Rotting) in Eastern Plaguelands
-- Put them into a pool
-- Source: YTDB

SET @GUID := 84946;
SET @POOL := 1060;

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 1 AND @GUID + 3;
INSERT INTO `creature` VALUES
(@GUID + 1, 10821, 0, 0, 0, 1853.9, -3720, 162.224, 1.254, 28800, 0, 0, 3758, 0, 0, 0),
(@GUID + 2, 10821, 0, 0, 0, 2524.42, -4757.21, 100.484, 2.33279, 28800, 0, 0, 3758, 0, 0, 0),
(@GUID + 3, 10821, 0, 0, 0, 3157.01, -4327.84, 133.152, 2.43097, 28800, 5, 0, 3758, 0, 0, 1);

UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` = 10821;

DELETE FROM `pool_creature_template` WHERE `id` = 10821;
INSERT INTO `pool_creature_template` VALUES
(10821, @POOL, 0, 'Hed\'mush the Rotting (10821)');

DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` VALUES
(@POOL, 1, 'Hed\'mush the Rotting (10821)');

UPDATE `creature_template` SET `SpeedWalk`='1', `MinMeleeDmg`='25', `MaxMeleeDmg`='33.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='60', `RangedAttackPower`='2', `MeleeBaseAttackTime`='2000' WHERE `Entry`='2184';

UPDATE `creature_template` SET `UnitFlags`='559168', `CreatureTypeFlags`='72', `SpeedWalk`='1', `Rank`='0', `ArmorMultiplier`='1', `MinLevelHealth`='1848', `MaxLevelHealth`='1919', `MinMeleeDmg`='75.6', `MaxMeleeDmg`='102.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2780', `MeleeAttackPower`='188', `RangedAttackPower`='17', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='7276';

UPDATE `creature_template` SET `MinLevel`='59', `NpcFlags`='3', `UnitFlags`='32832', `CreatureTypeFlags`='72', `HealthMultiplier`='8', `PowerMultiplier`='1', `DamageMultiplier`='7', `ArmorMultiplier`='1', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25' WHERE `Entry`='14326';
UPDATE `creature_template` SET `NpcFlags`='3', `UnitFlags`='32832', `CreatureTypeFlags`='72', `PowerMultiplier`='1', `DamageMultiplier`='7', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MovementType`='1' WHERE `Entry`='14321';
UPDATE `creature_template` SET `NpcFlags`='3', `UnitFlags`='32832', `CreatureTypeFlags`='72', `PowerMultiplier`='1', `DamageMultiplier`='7', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MovementType`='1' WHERE `Entry`='14323';

UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0', `groupid`='1' WHERE `entry`='21133' and`item`='20943';
UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0', `groupid`='1' WHERE `entry`='21133' and`item`='20945';
UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0', `groupid`='1' WHERE `entry`='21133' and`item`='20947';
UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0', `groupid`='1' WHERE `entry`='21133' and`item`='20948';
UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0', `groupid`='1' WHERE `entry`='21133' and`item`='21167';
UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0', `groupid`='1' WHERE `entry`='21133' and`item`='21245';

UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0' WHERE `entry`='20809' and`item`='20944';
UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0' WHERE `entry`='20809' and`item`='21165';
UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0' WHERE `entry`='20809' and`item`='21166';
UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0' WHERE `entry`='20809' and`item`='21245';
UPDATE `item_loot_template` SET `ChanceOrQuestChance`='0' WHERE `entry`='20809' and`item`='21751';

UPDATE `creature_template` SET `MinLevel`='53', `MaxLevel`='53', `SpeedWalk`='1', `HealthMultiplier`='1.3', `DamageVariance`='1.35', `ArmorMultiplier`='1', `MinMeleeDmg`='54.0', `MaxMeleeDmg`='71.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3163', `MeleeAttackPower`='218', `RangedAttackPower`='22', `MeleeBaseAttackTime`='1200', `RangedBaseAttackTime`='1200', `SkinningLootId`='10077', `ResistanceFire`='0', `ResistanceNature`='0', `ResistanceFrost`='0', `ResistanceShadow`='0', `ResistanceArcane`='0', `MovementType`='1' WHERE `Entry`='10077';

DELETE FROM `skinning_loot_template` WHERE `entry`='10077';
INSERT INTO `skinning_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
('10077', '8170', '50', '1', '1', '2', '0'),
('10077', '4304', '45', '1', '1', '2', '0'),
('10077', '8171', '3', '1', '1', '1', '0'),
('10077', '8169', '2', '1', '1', '1', '0');


UPDATE `creature_template_classlevelstats` SET `BaseDamageExp0`='35.775' WHERE `Level`='63' and`Class`='1';

DELETE FROM `creature` WHERE `id`='3450';

UPDATE `creature_template_classlevelstats` SET `BaseDamageExp0`='33.1092' WHERE `Level`='63' and`Class`='2';

UPDATE `creature_template_classlevelstats` SET `BaseDamageExp0`='32.6201' WHERE `Level`='62' and`Class`='2';

-- Lucifron
UPDATE `creature_template` SET `DamageMultiplier`='16', `MinMeleeDmg`='102.2', `MaxMeleeDmg`='135.3', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12118';

-- Magmadar
UPDATE `creature_template` SET `DamageMultiplier`='17', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11982';

-- Gehennas
UPDATE `creature_template` SET `DamageMultiplier`='16', `MinMeleeDmg`='102.2', `MaxMeleeDmg`='135.3', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12259';

-- Garr
UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12057';

-- Baron Geddon
UPDATE `creature_template` SET `DamageMultiplier`='14', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12056';

-- Shazzrah
UPDATE `creature_template` SET `DamageMultiplier`='16', `MinMeleeDmg`='102.2', `MaxMeleeDmg`='135.3', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12264';

-- Sulfuron Harbinger
UPDATE `creature_template` SET `DamageMultiplier`='16', `ArmorMultiplier`='1.25', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12098';

-- Golemagg
UPDATE `creature_template` SET `DamageMultiplier`='20', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11988';

-- Majordomo Executus
UPDATE `creature_template` SET `DamageMultiplier`='14', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12018';

-- Ragnaros
UPDATE `creature_template` SET `DamageMultiplier`='13', `MinMeleeDmg`='153.8', `MaxMeleeDmg`='203.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `RangedBaseAttackTime`='2800' WHERE `Entry`='11502';

-- Molten Giant
UPDATE `creature_template` SET `DamageMultiplier`='15', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11658';

-- Firelord
UPDATE `creature_template` SET `DamageMultiplier`='12', `MinMeleeDmg`='79.4', `MaxMeleeDmg`='107.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `RangedBaseAttackTime`='1500' WHERE `Entry`='11668';

-- Lava Spawn
UPDATE `creature_template` SET `DamageMultiplier`='5', `MinMeleeDmg`='77.9', `MaxMeleeDmg`='103.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='12265';

-- Lava Annihilator
UPDATE `creature_template` SET `DamageMultiplier`='18', `MinMeleeDmg`='84.7', `MaxMeleeDmg`='114.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `RangedBaseAttackTime`='1600' WHERE `Entry`='11665';

-- Lava Surger
UPDATE `creature_template` SET `DamageVariance`='13', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12101';

-- Ancient Core Hound
UPDATE `creature_template` SET `DamageMultiplier`='16', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11673';

-- Flame Imp
UPDATE `creature_template` SET `DamageMultiplier`='3', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11669';

-- Core Hound
UPDATE `creature_template` SET `DamageMultiplier`='10', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11671';

-- Flamewaker Protector
UPDATE `creature_template` SET `DamageMultiplier`='13', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133.0', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12119';

-- Molten Destroyer
UPDATE `creature_template` SET `DamageMultiplier`='16', `MinMeleeDmg`='109.8', `MaxMeleeDmg`='145.6', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11659';

-- Flamewaker
UPDATE `creature_template` SET `DamageMultiplier`='13', `MinMeleeDmg`='100.4', `MaxMeleeDmg`='133', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11661';

-- Firesworn
UPDATE `creature_template` SET `DamageMultiplier`='14', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='12099';

-- Lava Elemental
UPDATE `creature_template` SET `DamageMultiplier`='12', `MinMeleeDmg`='132.3', `MaxMeleeDmg`='178.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2500', `RangedBaseAttackTime`='2500' WHERE `Entry`='12076';

-- Lava Reaver
UPDATE `creature_template` SET `DamageMultiplier`='16', `MinMeleeDmg`='86.3', `MaxMeleeDmg`='116.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='268', `RangedAttackPower`='32', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600' WHERE `Entry`='12100';

-- Firewalker
UPDATE `creature_template` SET `DamageMultiplier`='10', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2000' WHERE `Entry`='11666';

-- Flameguard
UPDATE `creature_template` SET `DamageMultiplier`='10', `MinMeleeDmg`='105.8', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='262', `RangedAttackPower`='30', `MeleeBaseAttackTime`='2000' WHERE `Entry`='11667';

-- Flamewaker Priest [NO DAMAGE CALC - BASEDAMAGE WRONG?]
UPDATE `creature_template` SET `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11662';

-- Core Rager
UPDATE `creature_template` SET `DamageMultiplier`='14', `MinMeleeDmg`='107.9', `MaxMeleeDmg`='143.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeBaseAttackTime`='2000' WHERE `Entry`='11672';

-- Flamewaker Elite
UPDATE `creature_template` SET `DamageMultiplier`='14', `ArmorMultiplier`='1.25', `MinMeleeDmg`='120.5', `MaxMeleeDmg`='159.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `RangedBaseAttackTime`='2400' WHERE `Entry`='11664';

-- Flamewaker Healer
UPDATE `creature_template` SET `DamageMultiplier`='12', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0' WHERE `Entry`='11663';

-- Son of Flame
UPDATE `creature_template` SET `DamageMultiplier`='12', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='12143';


UPDATE `creature_template` SET `MinLevel`='60', `MaxLevel`='60', `SpeedWalk`='1', `Rank`='2', `HealthMultiplier`='3', `DamageMultiplier`='4', `ArmorMultiplier`='1', `MinLevelHealth`='9156', `MaxLevelHealth`='9156', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='10198';
UPDATE `creature_template` SET `MinLevel`='59', `HealthMultiplier`='3', `DamageMultiplier`='4', `ArmorMultiplier`='1.25', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='7428';
UPDATE `creature_template` SET `DamageMultiplier`='4', `ArmorMultiplier`='1.25', `MinMeleeDmg`='94.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000' WHERE `Entry`='7429';

-- Accursed Slitherblade
UPDATE `creature_template` SET `MinLevel`='35', `MaxLevel`='35', `HealthMultiplier`='1.1', `ArmorMultiplier`='1', `MinLevelHealth`='1342', `MaxLevelHealth`='1342', `Armor`='1373' WHERE `Entry`='14229';

-- Antilos
UPDATE `creature_template` SET `MinLevel`='50', `MaxLevel`='50', `HealthMultiplier`='1.25', `ArmorMultiplier`='1', `MinLevelHealth`='2768', `MaxLevelHealth`='2668' WHERE `Entry`='6648';

-- Araga
UPDATE `creature_template` SET `HealthMultiplier`='1.1', `ArmorMultiplier`='1', `MinLevelHealth`='1342', `MaxLevelHealth`='1342', `Armor`='1373' WHERE `Entry`='14222';

-- Blind Hunter
UPDATE `creature_template` SET `HealthMultiplier`='5', `ArmorMultiplier`='1', `MinLevelHealth`='5285', `MaxLevelHealth`='5285' WHERE `Entry`='4425';

-- Bruegal Ironknuckle
UPDATE `creature_template` SET `HealthMultiplier`='3', `ArmorMultiplier`='1', `MinLevelHealth`='2250', `MaxLevelHealth`='2250' WHERE `Entry`='1720';

-- Burgel Eye
UPDATE `creature_template` SET `HealthMultiplier`='1.15', `ArmorMultiplier`='1', `MinLevelHealth`='1305', `MaxLevelHealth`='1305' WHERE `Entry`='14230';

-- Captain Beld
UPDATE `creature_template` SET `ArmorMultiplier`='1', `MinLevelHealth`='222', `MaxLevelHealth`='222' WHERE `Entry`='6124';

-- Darkmist Widow
UPDATE `creature_template` SET `HealthMultiplier`='1.15', `ArmorMultiplier`='1', `MinLevelHealth`='1752', `MaxLevelHealth`='1752' WHERE `Entry`='4380';

-- Diamond Head
UPDATE `creature_template` SET `MinLevel`='45', `MaxLevel`='45', `HealthMultiplier`='1.2', `MinLevelHealth`='2217', `MaxLevelHealth`='2217' WHERE `Entry`='5345';

-- Elder Mystic Razorsnout
UPDATE `creature_template` SET `MinLevelHealth`='903', `MaxLevelHealth`='903', `HealthMultiplier`='3', `ArmorMultiplier`='1' WHERE `Entry`='3270';

-- Foreman Jerris
UPDATE `creature_template` SET `MinLevel`='62', `MaxLevel`='62', `HealthMultiplier`='3', `ArmorMultiplier`='1' WHERE `Entry`='1843';

-- Foulbelly
UPDATE `creature_template` SET `HealthMultiplier`='5', `ArmorMultiplier`='1' WHERE `Entry`='2601';

-- Gatekeeper Rageroar
UPDATE `creature_template` SET `MinLevel`='50', `MaxLevel`='50', `MinLevelHealth`='2768', `MaxLevelHealth`='2768', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='6651';

-- General Colbatann
UPDATE `creature_template` SET `MinLevel`='57', `MinLevelHealth`='8352' WHERE `Entry`='10196';

-- General Fangferror
UPDATE `creature_template` SET `MinLevel`='51', `MaxLevel`='51', `MinLevelHealth`='2979', `MaxLevelHealth`='2979', `HealthMultiplier`='1.3', `ArmorMultiplier`='1' WHERE `Entry`='6650';

-- Giggler
UPDATE `creature_template` SET `MinLevel`='34', `MaxLevel`='34', `MinLevelHealth`='1279', `MaxLevelHealth`='1279', `HealthMultiplier`='1.1', `ArmorMultiplier`='1' WHERE `Entry`='14228';

-- Gilmorian
UPDATE `creature_template` SET `MinLevel`='43', `MaxLevel`='43', `HealthMultiplier`='1.2', `ArmorMultiplier`='1' WHERE `Entry`='14447';

-- Gish the Unmoving
UPDATE `creature_template` SET `MinLevel`='56', `MaxLevel`='56', `MinLevelHealth`='3643', `MaxLevelHealth`='3643', `HealthMultiplier`='1.35', `ArmorMultiplier`='1' WHERE `Entry`='10825';

-- Gnawbone
UPDATE `creature_template` SET `MinLevel`='24', `MaxLevel`='24', `HealthMultiplier`='1.02' WHERE `Entry`='14425';

-- Gorgon'och
UPDATE `creature_template` SET `MinLevel`='54', `MaxLevel`='54', `MinLevelHealth`='2633', `MaxLevelHealth`='2633', `HealthMultiplier`='1.3', `ArmorMultiplier`='1' WHERE `Entry`='9604';

-- Gretheer
UPDATE `creature_template` SET `MinLevel`='57', `MaxLevel`='57', `HealthMultiplier`='1.35', `ArmorMultiplier`='1' WHERE `Entry`='14472';

-- Grizzle Snowpaw
UPDATE `creature_template` SET `MinLevelHealth`='3198', `MaxLevelHealth`='3198', `HealthMultiplier`='1.35', `ArmorMultiplier`='1' WHERE `Entry`='10199';

-- Hahk'Zor
UPDATE `creature_template` SET `MinLevel`='54', `MaxLevel`='54', `MinLevelHealth`='3292', `MaxLevelHealth`='3292', `HealthMultiplier`='1.3', `ArmorMultiplier`='1' WHERE `Entry`='9602';

-- Heggin Stonewhisker
UPDATE `creature_template` SET `MinLevelHealth`='585', `MaxLevelHealth`='585', `HealthMultiplier`='0.9', `ArmorMultiplier`='1' WHERE `Entry`='5847';

-- Immolatus
UPDATE `creature_template` SET `MinLevel`='56', `MaxLevel`='56', `HealthMultiplier`='3', `ArmorMultiplier`='1' WHERE `Entry`='7137';

-- Jalinde Summerdrake
UPDATE `creature_template` SET `MinLevelHealth`='2672', `MaxLevelHealth`='2672', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='8214';

-- Kaskk
UPDATE `creature_template` SET `MinLevelHealth`='1752', `MaxLevelHealth`='1752', `HealthMultiplier`='1.15', `ArmorMultiplier`='1' WHERE `Entry`='14226';

-- Kazon
UPDATE `creature_template` SET `MinLevelHealth`='840', `MaxLevelHealth`='840', `HealthMultiplier`='1.05', `ArmorMultiplier`='1' WHERE `Entry`='584';

-- Korvok
UPDATE `creature_template` SET `MinLevel`='36', `MaxLevel`='36', `MinLevelHealth`='1468', `MaxLevelHealth`='1468', `HealthMultiplier`='1.15', `ArmorMultiplier`='1' WHERE `Entry`='2603';

-- Kregg Keelhaul
UPDATE `creature_template` SET `MinLevelHealth`='2487', `MaxLevelHealth`='2487', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='8203';

-- Krellack
UPDATE `creature_template` SET `MinLevelHealth`='3508', `MaxLevelHealth`='3508', `HealthMultiplier`='1.3', `ArmorMultiplier`='1' WHERE `Entry`='14476';

-- Krethis Shadowspinner
UPDATE `creature_template` SET `MinLevelHealth`='301', `MaxLevelHealth`='301', `ArmorMultiplier`='1' WHERE `Entry`='12433';

-- Krom'Grul
UPDATE `creature_template` SET `MinLevelHealth`='2633', `MaxLevelHealth`='2633', `HealthMultiplier`='1.3', `ArmorMultiplier`='1' WHERE `Entry`='8977';

-- Kurmokk
UPDATE `creature_template` SET `MinLevelHealth`='1981', `MaxLevelHealth`='1981', `HealthMultiplier`='1.2', `ArmorMultiplier`='1' WHERE `Entry`='14491';

-- Lord Angler
UPDATE `creature_template` SET `MinLevel`='44', `MaxLevel`='44', `MinLevelHealth`='2138', `MaxLevelHealth`='2138', `HealthMultiplier`='1.2', `ArmorMultiplier`='1' WHERE `Entry`='14236';

-- Lord Sinslayer
UPDATE `creature_template` SET `MinLevel`='16', `MinLevelHealth`='356' WHERE `Entry`='7017';

-- Magister Hawkhelm
UPDATE `creature_template` SET `MinLevelHealth`='3082', `MaxLevelHealth`='3082', `HealthMultiplier`='1.3', `ArmorMultiplier`='1' WHERE `Entry`='6647';

-- Magronos the Unyielding
UPDATE `creature_template` SET `MinLevel`='56', `MaxLevel`='56', `MinLevelHealth`='3643', `MaxLevelHealth`='3643', `HealthMultiplier`='1.35', `ArmorMultiplier`='1' WHERE `Entry`='8297';

-- Malfunctioning Reaver
UPDATE `creature_template` SET `MinLevelHealth`='3643', `MaxLevelHealth`='3643', `HealthMultiplier`='1.35', `ArmorMultiplier`='1' WHERE `Entry`='8981';

-- Ma'ruk Wyrmscale
UPDATE `creature_template` SET `MinLevelHealth`='617', `MaxLevelHealth`='617', `HealthMultiplier`='1.02', `ArmorMultiplier`='1' WHERE `Entry`='2090';

-- Master Digger
UPDATE `creature_template` SET `MinLevelHealth`='328', `MaxLevelHealth`='328', `ArmorMultiplier`='1' WHERE `Entry`='1424';

-- Meshlok the Harvester
UPDATE `creature_template` SET `MinLevelHealth`='6186', `MaxLevelHealth`='6186', `HealthMultiplier`='3', `ArmorMultiplier`='1' WHERE `Entry`='12237';

-- Monnos the Elder
UPDATE `creature_template` SET `MinLevel`='54', `MinLevelHealth`='7599' WHERE `Entry`='6646';

-- Nefaru
UPDATE `creature_template` SET `MinLevel`='34', `MaxLevel`='34', `HealthMultiplier`='1.1', `ArmorMultiplier`='1' WHERE `Entry`='534';

-- Oozeworm
UPDATE `creature_template` SET `MinLevelHealth`='1981', `MaxLevelHealth`='1981', `HealthMultiplier`='1.2', `ArmorMultiplier`='1' WHERE `Entry`='14237';

-- Panzor the Invincible
UPDATE `creature_template` SET `MinLevelHealth`='13920', `MaxLevelHealth`='13920', `HealthMultiplier`='5', `ArmorMultiplier`='1' WHERE `Entry`='8923';

-- Omgorn the Lost
UPDATE `creature_template` SET `MinLevelHealth`='2768', `MaxLevelHealth`='2768', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='8201';

-- Rak'shiri
UPDATE `creature_template` SET `MinLevel`='57', `MaxLevel`='57', `HealthMultiplier`='1.35', `ArmorMultiplier`='1' WHERE `Entry`='10200';

-- Rekk'tilac
UPDATE `creature_template` SET `MinLevel`='48', `MaxLevel`='48', `MinLevelHealth`='2577', `MaxLevelHealth`='2577', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='8277';

-- Razormaw Matriarch
UPDATE `creature_template` SET `MinLevel`='31', `MaxLevel`='31', `MinLevelHealth`='1106', `MaxLevelHealth`='1106', `ArmorMultiplier`='1' WHERE `Entry`='1140';

-- Ripscale
UPDATE `creature_template` SET `MinLevelHealth`='1750', `MaxLevelHealth`='1750', `HealthMultiplier`='1.2', `ArmorMultiplier`='1' WHERE `Entry`='14233';

-- Ruul Onestone
UPDATE `creature_template` SET `HealthMultiplier`='3', `ArmorMultiplier`='1' WHERE `Entry`='2602';

-- Scald
UPDATE `creature_template` SET `MinLevelHealth`='2672', `MaxLevelHealth`='2672', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='8281';

-- Sludge Beast
UPDATE `creature_template` SET `MinLevelHealth`='449', `MaxLevelHealth`='449', `ArmorMultiplier`='1' WHERE `Entry`='3295';

-- Smoldar
UPDATE `creature_template` SET `MinLevel`='50', `MaxLevel`='50', `MinLevelHealth`='2768', `MaxLevelHealth`='2768', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='8278';

-- Soriid the Devourer
UPDATE `creature_template` SET `MinLevel`='50', `MaxLevel`='50', `MinLevelHealth`='2768', `MaxLevelHealth`='2768', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='8204';

-- Spiteflayer
UPDATE `creature_template` SET `MinLevel`='52', `MaxLevel`='52', `HealthMultiplier`='1.3', `ArmorMultiplier`='1' WHERE `Entry`='8299';

-- Takk the Leaper
UPDATE `creature_template` SET `MinLevelHealth`='1347', `MaxLevelHealth`='1347', `HealthMultiplier`='3', `ArmorMultiplier`='1' WHERE `Entry`='5842';

-- Sri'skulk
UPDATE `creature_template` SET `MinLevelHealth`='341', `MaxLevelHealth`='341', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='10359';

-- Terrowulf Packlord
UPDATE `creature_template` SET `MinLevelHealth`='1162', `MaxLevelHealth`='1162', `HealthMultiplier`='1.1', `ArmorMultiplier`='1' WHERE `Entry`='3792';

-- Thauris Balgarr
UPDATE `creature_template` SET `MinLevelHealth`='3758', `MaxLevelHealth`='3758', `HealthMultiplier`='1.35', `ArmorMultiplier`='1' WHERE `Entry`='8978';

-- The Reak
UPDATE `creature_template` SET `MinLevel`='49', `MaxLevel`='49', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='8212';

-- The Rot
UPDATE `creature_template` SET `MinLevel`='43', `MaxLevel`='43', `MinLevelHealth`='2059', `MaxLevelHealth`='2059', `HealthMultiplier`='1.2', `ArmorMultiplier`='1' WHERE `Entry`='14235';

-- The Ongar
UPDATE `creature_template` SET `MinLevelHealth`='2979', `MaxLevelHealth`='2979', `HealthMultiplier`='1.3', `ArmorMultiplier`='1' WHERE `Entry`='14345';

-- Threggil
UPDATE `creature_template` SET `MinLevelHealth`='115', `MaxLevelHealth`='115' WHERE `Entry`='14432';

-- Thunderstomp
UPDATE `creature_template` SET `MinLevelHealth`='664', `MaxLevelHealth`='664', `HealthMultiplier`='1.02', `ArmorMultiplier`='1' WHERE `Entry`='5832';

-- Uhk'loc
UPDATE `creature_template` SET `MinLevel`='53', `MinLevelHealth`='3188' WHERE `Entry`='6585';

-- Ursol'lok
UPDATE `creature_template` SET `MinLevel`='31', `MaxLevel`='31', `MinLevelHealth`='1257', `MaxLevelHealth`='1257', `HealthMultiplier`='1.25', `ArmorMultiplier`='1' WHERE `Entry`='12037';

-- Uruson
UPDATE `creature_template` SET `MinLevel`='7', `MaxLevel`='7', `ArmorMultiplier`='1' WHERE `Entry`='14428';

-- Volchan
UPDATE `creature_template` SET `MinLevel`='60', `HealthMultiplier`='4', `ArmorMultiplier`='1' WHERE `Entry`='10119';

-- Zul'Brin Warpbranch
UPDATE `creature_template` SET `MinLevel`='59', `MaxLevel`='59', `MinLevelHealth`='2798', `MaxLevelHealth`='2798', `HealthMultiplier`='1.35', `ArmorMultiplier`='1' WHERE `Entry`='10823';

-- Removed two apparently wrongly spawned NPCs: Cliff Giant #51697 & Land Walker #51692
-- Thanks Neotmiren for pointing and fixing. This closes #781
DELETE FROM creature WHERE guid IN (51697, 51692); 
-- Fix model of NPC 8096 (Protector of the People) in Westfall
-- Thanks @Neotmiren for pointing and fixing. This closes #785
UPDATE `creature` SET `modelid` = 0 WHERE `id` = 8096;
UPDATE `creature_template` SET `ModelId2` = 7310 WHERE `Entry` = 8096;
UPDATE `creature_model_info` SET `modelid_other_gender` = 0 WHERE `modelid` = 7310;
-- Fixed stats of NPC's minion Voidwalker and Succubus: they were using Imp's stats
-- Source: UDB/YTDB. This closes #787 
DELETE FROM `pet_levelstats` WHERE `creature_entry` IN (8996, 10928);
INSERT INTO `pet_levelstats` (`creature_entry`, `level`, `hp`, `mana`, `armor`, `str`, `agi`, `sta`, `inte`, `spi`) VALUES
 -- Voidwalker Minion
(8996, 1, 80, 48, 0, 0, 0, 0, 0, 0),
(8996, 2, 100, 59, 0, 0, 0, 0, 0, 0),
(8996, 3, 120, 70, 0, 0, 0, 0, 0, 0),
(8996, 4, 140, 81, 0, 0, 0, 0, 0, 0),
(8996, 5, 160, 92, 0, 0, 0, 0, 0, 0),
(8996, 6, 180, 103, 0, 0, 0, 0, 0, 0),
(8996, 7, 200, 114, 0, 0, 0, 0, 0, 0),
(8996, 8, 220, 125, 0, 0, 0, 0, 0, 0),
(8996, 9, 240, 136, 0, 0, 0, 0, 0, 0),
(8996, 10, 260, 147, 694, 29, 25, 29, 22, 26),
(8996, 11, 291, 158, 734, 30, 25, 32, 23, 28),
(8996, 12, 322, 180, 782, 31, 26, 36, 24, 31),
(8996, 13, 354, 203, 827, 32, 28, 43, 26, 32),
(8996, 14, 368, 227, 878, 33, 28, 44, 25, 35),
(8996, 15, 421, 251, 925, 34, 30, 48, 26, 37),
(8996, 16, 455, 275, 975, 36, 30, 52, 27, 39),
(8996, 17, 490, 300, 1022, 38, 31, 55, 28, 42),
(8996, 18, 528, 314, 1068, 39, 33, 59, 28, 44),
(8996, 19, 566, 351, 1120, 40, 33, 63, 29, 46),
(8996, 20, 606, 377, 1165, 42, 35, 67, 30, 49),
(8996, 21, 653, 400, 1232, 44, 36, 80, 31, 51),
(8996, 22, 699, 423, 1282, 46, 36, 84, 32, 53),
(8996, 23, 746, 447, 1330, 47, 38, 89, 33, 55),
(8996, 24, 823, 476, 1378, 49, 39, 93, 34, 58),
(8996, 25, 854, 504, 1427, 50, 40, 97, 35, 61),
(8996, 26, 911, 543, 1474, 52, 41, 101, 36, 62),
(8996, 27, 966, 564, 1524, 53, 42, 105, 37, 65),
(8996, 28, 1047, 592, 1572, 55, 43, 110, 38, 67),
(8996, 29, 1129, 620, 1619, 56, 44, 114, 39, 70),
(8996, 30, 1210, 648, 1667, 58, 46, 118, 40, 72),
(8996, 31, 1292, 676, 1715, 59, 47, 123, 40, 74),
(8996, 32, 1373, 720, 1766, 61, 48, 127, 41, 77),
(8996, 33, 1455, 742, 1812, 62, 49, 131, 42, 79),
(8996, 34, 1573, 793, 1861, 63, 51, 135, 43, 82),
(8996, 35, 1690, 845, 2000, 65, 52, 136, 44, 84),
(8996, 36, 1760, 879, 2154, 66, 53, 137, 45, 87),
(8996, 37, 1827, 916, 2248, 68, 53, 138, 46, 89),
(8996, 38, 1900, 952, 2331, 70, 55, 139, 47, 91),
(8996, 39, 1974, 988, 2483, 72, 56, 144, 48, 94),
(8996, 40, 2041, 1026, 2770, 74, 58, 150, 49, 97),
(8996, 41, 2127, 1063, 2856, 76, 59, 153, 50, 99),
(8996, 42, 2171, 1103, 3034, 81, 59, 156, 51, 102),
(8996, 43, 2215, 1187, 3228, 86, 61, 169, 52, 104),
(8996, 44, 2259, 1214, 2463, 89, 62, 172, 53, 107),
(8996, 45, 2303, 1240, 2638, 91, 64, 175, 54, 109),
(8996, 46, 2347, 1267, 2862, 94, 65, 178, 55, 112),
(8996, 47, 2391, 1294, 3021, 96, 66, 181, 56, 115),
(8996, 48, 2435, 1320, 3218, 99, 68, 184, 57, 117),
(8996, 49, 2479, 1347, 3370, 101, 69, 187, 58, 120),
(8996, 50, 2523, 1391, 3528, 104, 71, 190, 59, 123),
(8996, 51, 2568, 1435, 3963, 107, 72, 193, 61, 126),
(8996, 52, 2661, 1481, 4132, 109, 73, 199, 62, 128),
(8996, 53, 2755, 1527, 4286, 112, 75, 203, 63, 131),
(8996, 54, 2848, 1573, 4307, 114, 76, 207, 64, 133),
(8996, 55, 2942, 1620, 4389, 117, 77, 213, 65, 136),
(8996, 56, 3036, 1666, 4476, 119, 79, 218, 66, 139),
(8996, 57, 3129, 1714, 4532, 122, 80, 222, 67, 142),
(8996, 58, 3223, 1763, 4599, 124, 82, 227, 68, 144),
(8996, 59, 3317, 1824, 4673, 127, 83, 230, 69, 147),
(8996, 60, 3419, 1874, 4745, 129, 85, 249, 70, 150),

 -- Succubus Minion
(10928, 1, 40, 48, 0, 0, 0, 0, 0, 0),
(10928, 2, 49, 59, 0, 0, 0, 0, 0, 0),
(10928, 3, 58, 70, 0, 0, 0, 0, 0, 0),
(10928, 4, 68, 81, 0, 0, 0, 0, 0, 0),
(10928, 5, 77, 92, 0, 0, 0, 0, 0, 0),
(10928, 6, 86, 103, 0, 0, 0, 0, 0, 0),
(10928, 7, 95, 114, 0, 0, 0, 0, 0, 0),
(10928, 8, 104, 125, 0, 0, 0, 0, 0, 0),
(10928, 9, 113, 136, 0, 0, 0, 0, 0, 0),
(10928, 10, 123, 147, 0, 0, 0, 0, 0, 0),
(10928, 11, 132, 158, 0, 0, 0, 0, 0, 0),
(10928, 12, 150, 180, 0, 0, 0, 0, 0, 0),
(10928, 13, 169, 203, 0, 0, 0, 0, 0, 0),
(10928, 14, 189, 227, 0, 0, 0, 0, 0, 0),
(10928, 15, 209, 251, 0, 0, 0, 0, 0, 0),
(10928, 16, 229, 275, 0, 0, 0, 0, 0, 0),
(10928, 17, 250, 300, 0, 0, 0, 0, 0, 0),
(10928, 18, 262, 314, 0, 0, 0, 0, 0, 0),
(10928, 19, 293, 351, 0, 0, 0, 0, 0, 0),
(10928, 20, 303, 377, 0, 42, 35, 67, 31, 49),
(10928, 21, 325, 393, 0, 44, 36, 80, 31, 51),
(10928, 22, 349, 420, 0, 46, 36, 84, 32, 53),
(10928, 23, 373, 447, 0, 47, 38, 79, 33, 55),
(10928, 24, 400, 476, 0, 49, 39, 83, 34, 58),
(10928, 25, 440, 504, 0, 50, 40, 87, 35, 61),
(10928, 26, 469, 534, 0, 52, 41, 91, 36, 62),
(10928, 27, 501, 564, 0, 53, 42, 95, 37, 65),
(10928, 28, 534, 592, 0, 55, 43, 99, 38, 67),
(10928, 29, 566, 620, 0, 56, 44, 103, 39, 70),
(10928, 30, 599, 648, 800, 58, 46, 107, 40, 72),
(10928, 31, 631, 676, 856, 59, 47, 111, 40, 74),
(10928, 32, 680, 720, 921, 61, 48, 115, 41, 77),
(10928, 33, 728, 742, 987, 62, 49, 119, 42, 79),
(10928, 34, 661, 793, 1047, 63, 51, 123, 43, 82),
(10928, 35, 699, 845, 1107, 65, 52, 127, 44, 84),
(10928, 36, 737, 879, 1167, 66, 53, 131, 45, 87),
(10928, 37, 776, 916, 1227, 68, 53, 135, 46, 89),
(10928, 38, 814, 952, 1288, 70, 55, 139, 47, 91),
(10928, 39, 852, 988, 1345, 72, 56, 143, 48, 94),
(10928, 40, 890, 1026, 1409, 74, 58, 148, 49, 97),
(10928, 41, 928, 1063, 1462, 76, 59, 152, 50, 99),
(10928, 42, 976, 1103, 1528, 81, 59, 156, 51, 102),
(10928, 43, 1005, 1187, 1586, 86, 61, 160, 52, 104),
(10928, 44, 1043, 1214, 1642, 89, 62, 164, 53, 107),
(10928, 45, 1081, 1240, 1708, 91, 64, 169, 54, 109),
(10928, 46, 1119, 1267, 1769, 94, 65, 173, 55, 112),
(10928, 47, 1158, 1294, 1826, 96, 66, 178, 56, 115),
(10928, 48, 1196, 1320, 1889, 99, 68, 182, 57, 117),
(10928, 49, 1234, 1347, 1950, 101, 69, 186, 58, 120),
(10928, 50, 1277, 1391, 2003, 104, 71, 191, 59, 123),
(10928, 51, 1320, 1435, 2055, 107, 72, 195, 61, 126),
(10928, 52, 1364, 1481, 2108, 109, 73, 199, 62, 128),
(10928, 53, 1407, 1527, 2161, 112, 75, 204, 63, 131),
(10928, 54, 1450, 1573, 2213, 114, 76, 208, 64, 134),
(10928, 55, 1493, 1620, 2266, 117, 77, 213, 65, 136),
(10928, 56, 1536, 1666, 2318, 119, 79, 217, 66, 139),
(10928, 57, 1580, 1714, 2371, 122, 80, 221, 67, 142),
(10928, 58, 1623, 1763, 2424, 124, 82, 226, 68, 144),
(10928, 59, 1666, 1824, 2476, 127, 83, 230, 69, 147),
(10928, 60, 1709, 1874, 2529, 129, 85, 234, 70, 150)
;-- Fixed stats of "trash" NPCs in Blackrock Depths
-- Anvilrage Overseer 8889
UPDATE creature_template SET MinLevel = 48, HealthMultiplier = 3, DamageMultiplier = 2.9, MeleeAttackPower = 200, RangedAttackPower=19, MinMeleeDmg=80, MaxMeleeDmg=110, MeleeBaseAttackTime = 2000 WHERE Entry = 8889;
-- Anvilrage Warden 8890
UPDATE creature_template SET DamageMultiplier = 3, MeleeAttackPower = 206, RangedAttackPower=20, MinMeleeDmg=83, MaxMeleeDmg=112, MeleeBaseAttackTime = 2000 WHERE Entry = 8890;
-- Anvilrage Guardsman 8891
UPDATE creature_template SET DamageMultiplier = 3.1, MeleeAttackPower = 210, RangedAttackPower=20, MinMeleeDmg=85, MaxMeleeDmg=114, MeleeBaseAttackTime = 2000 WHERE Entry = 8891;
-- Anvilrage Footman 8892
UPDATE creature_template SET MinLevelHealth=6876, MaxLevelHealth=7113, HealthMultiplier = 3, DamageMultiplier = 3.6, MeleeAttackPower = 214, RangedAttackPower=21, MinMeleeDmg=86, MaxMeleeDmg=117, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8892;
-- Anvilrage Soldier 8893
UPDATE creature_template SET MinLevelHealth=7113, MaxLevelHealth=7359, HealthMultiplier = 3, DamageMultiplier = 3.30, MeleeAttackPower = 218, RangedAttackPower=22, MinMeleeDmg=88, MaxMeleeDmg=119, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8893;
-- Anvilrage Medic 8894
UPDATE creature_template SET MinLevel=52, MinLevelHealth=4980, MaxLevelHealth=5151, MinLevelMana=9300, MaxLevelMana=9530, HealthMultiplier = 3, PowerMultiplier=2, DamageMultiplier = 4, MeleeAttackPower = 97, RangedAttackPower=23, MinMeleeDmg=63, MaxMeleeDmg=89, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8894;
-- Anvilrage Officer 8895
UPDATE creature_template SET MinLevelHealth=5886, MaxLevelHealth=6078, MinLevelMana=3964, MaxLevelMana=4082, HealthMultiplier = 3, PowerMultiplier=2, DamageMultiplier = 3.4, MeleeAttackPower = 210, RangedAttackPower=20, MinMeleeDmg=84, MaxMeleeDmg=114, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8895;
-- Anvilrage Marshal 8898
UPDATE creature_template SET MinLevelHealth=6078, MaxLevelHealth=6273, MinLevelMana=4082, MaxLevelMana=4234, HealthMultiplier = 3, PowerMultiplier=2, DamageMultiplier = 3.5, MeleeAttackPower = 214, RangedAttackPower=21, MinMeleeDmg=84, MaxMeleeDmg=114, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8898;
-- Anvilrage Reservist 8901
UPDATE creature_template SET MinLevel=54,MinLevelHealth=760, MaxLevelHealth=784, HealthMultiplier = 0.3, DamageMultiplier = 1, MeleeAttackPower = 228, RangedAttackPower=23, MinMeleeDmg=92, MaxMeleeDmg=125, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8901;
-- Anvilrage Captain 8903
UPDATE creature_template SET MinLevel=55, MinLevelHealth=7842, MaxLevelHealth=8097, HealthMultiplier = 3, DamageMultiplier = 3.6, MeleeAttackPower = 234, RangedAttackPower=23, MinMeleeDmg=94, MaxMeleeDmg=127, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8903;

-- Reginald Windsor
UPDATE creature_template SET MinLevelHealth = 8536, MaxLevelHealth = 8536, HealthMultiplier = 3.6, PowerMultiplier = 2, DamageMultiplier = 3.5, MinMeleeDmg = 54, MaxMeleeDmg = 72, MeleeAttackPower = 214, ArmorMultiplier = 1 WHERE Entry = 9023;
-- Marshal Reginald Windsor
UPDATE creature_template SET MinLevelHealth = 8536, MaxLevelHealth = 8536,  HealthMultiplier = 3.6, PowerMultiplier = 2, DamageMultiplier = 7.5, MinMeleeDmg = 54, MaxMeleeDmg = 72, MeleeAttackPower = 214, ArmorMultiplier = 1 WHERE Entry = 9682;

-- Doomforge Arcanasmith 8900
UPDATE creature_template SET MaxLevelHealth = 2379, MaxLevelMana = 5013, HealthMultiplier = 1.3, DamageMultiplier = 1.75, MinMeleeDmg = 65, MaxMeleeDmg = 93, MeleeAttackPower = 101, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8900;
-- Ragereaver Golem 8906
UPDATE creature_template SET MinLevelHealth = 7599, MaxLevelHealth = 7842, MinLevelMana=0, MaxLevelMana=0, HealthMultiplier = 3, DamageMultiplier = 3.6, MinMeleeDmg = 92, MaxMeleeDmg = 125, MeleeAttackPower = 228, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8906;
-- Wrath Hammer Construct 8907
UPDATE creature_template SET MinLevelHealth = 7842, MaxLevelHealth = 8097, HealthMultiplier = 3, DamageMultiplier = 3.6, MinMeleeDmg = 94, MaxMeleeDmg = 127, MeleeAttackPower = 234, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8907;
-- Weapon Technician 8920
UPDATE creature_template SET MinLevelHealth = 2614, MaxLevelHealth = 2699, HealthMultiplier = 1.0, DamageMultiplier = 1.75, MinMeleeDmg = 94, MaxMeleeDmg = 127, MeleeAttackPower = 234, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8920;

-- Ribbly Screwspigot 9543
UPDATE creature_template SET MinLevel=53, HealthMultiplier = 3.0, PowerMultiplier = 2, DamageMultiplier = 3.3, MinMeleeDmg = 90, MaxMeleeDmg = 119, MeleeAttackPower = 218, RangedAttackPower=22, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 9543;
-- Ribbly's Crony 10043
UPDATE creature_template SET MinLevel=48, HealthMultiplier = 3.0, PowerMultiplier = 2, DamageMultiplier = 3.2, MinMeleeDmg = 80, MaxMeleeDmg = 117, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 10043;

-- Fireguard Destroyer 8911
UPDATE creature_template SET MinLevelHealth = 7599, MaxLevelHealth = 8097, HealthMultiplier = 3.0, PowerMultiplier = 2, DamageMultiplier = 3.6, MinMeleeDmg = 92, MaxMeleeDmg = 127, MeleeAttackPower = 234, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8911;
-- Blazing Fireguard 8910
UPDATE creature_template SET MaxLevelHealth = 6078, MaxLevelMana=4082, DamageMultiplier = 3.40, MinMeleeDmg = 82, MaxMeleeDmg = 114, MeleeAttackPower = 210, RangedAttackPower=20, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8910;
-- Fireguard 8909
UPDATE creature_template SET MinLevelHealth = 5316, MaxLevelHealth = 5691, MinLevelMana=3614, MaxLevelMana=3846, HealthMultiplier = 3.0, PowerMultiplier = 2, DamageMultiplier = 3.20, MinMeleeDmg = 79, MaxMeleeDmg = 109, MeleeAttackPower = 202, RangedAttackPower=19, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1, ResistanceFrost= -52 WHERE Entry = 8909;

-- Doomforge Craftsman 8897
UPDATE creature_template SET MinLevelHealth = 3082, MaxLevelHealth = 3293, HealthMultiplier = 1.3, PowerMultiplier = 1, DamageMultiplier = 1.7, MinMeleeDmg = 88, MaxMeleeDmg = 122, MeleeAttackPower = 224, RangedAttackPower=22, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8897;
-- Doomforge Dragoon 8899
UPDATE creature_template SET MinLevelHealth = 7599, MaxLevelHealth = 7842, HealthMultiplier = 3, PowerMultiplier = 2, DamageMultiplier=3.5, MinMeleeDmg = 92, MaxMeleeDmg = 125, MeleeAttackPower = 228, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8899;

-- Shadowforge Citizen 8902
UPDATE creature_template SET MinLevelHealth = 2026, MaxLevelHealth = 2159, MinLevelMana=2041, MaxLevelMana=2163, HealthMultiplier = 1.0, PowerMultiplier = 1, DamageMultiplier = 1.8, MinMeleeDmg = 86, MaxMeleeDmg = 118, MeleeAttackPower = 220, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8902;
-- Shadowforge Flame Keeper 9956
UPDATE creature_template SET MinMeleeDmg = 92, MaxMeleeDmg = 125, MeleeAttackPower = 228, RangedAttackPower=23, MeleeBaseAttackTime = 2000 WHERE Entry = 9956;
-- Shadowforge Senator 8904
UPDATE creature_template SET MinLevel=55, MinLevelHealth = 2471, MaxLevelHealth = 2550, MinLevelMana=5013, MaxLevelMana=5206, HealthMultiplier = 1.35, PowerMultiplier = 1, DamageMultiplier = 1.75, MinMeleeDmg = 67, MaxMeleeDmg = 94, MeleeAttackPower = 104, RangedAttackPower=24, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8904;
-- Shadowforge Peasant 8896
UPDATE creature_template SET MinLevelHealth = 2466, MaxLevelHealth = 2634, MinLevelMana=1923, MaxLevelMana=2041, HealthMultiplier = 1.3, PowerMultiplier = 1, DamageMultiplier = 1.7, MinMeleeDmg = 82, MaxMeleeDmg = 114, MeleeAttackPower = 210, RangedAttackPower=20, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8896;

-- Molten War Golem 8908
UPDATE creature_template SET MaxLevelHealth = 11874, MaxLevelMana=4326, DamageMultiplier = 5.5, MinMeleeDmg = 87, MaxMeleeDmg = 118, MeleeAttackPower = 220, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8908;
-- Warbringer Construct 8905
UPDATE creature_template SET MinLevelHealth = 7359, MaxLevelHealth = 7599, HealthMultiplier=3, DamageMultiplier = 3.6, MinMeleeDmg = 90, MaxMeleeDmg = 122, MeleeAttackPower = 224, RangedAttackPower=22, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 8905;

-- Blackbreath Crony 9541
UPDATE creature_template SET DamageMultiplier = 3.3, MinMeleeDmg = 90, MaxMeleeDmg = 119, MeleeAttackPower = 218, RangedAttackPower=22, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 9541;
-- Hurley Blackbreath 9537
UPDATE creature_template SET MinLevelHealth = 13070, MaxLevelHealth = 13070, HealthMultiplier=5, PowerMultiplier = 2, DamageMultiplier = 7.5, MinMeleeDmg = 94, MaxMeleeDmg = 125, MeleeAttackPower = 228, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1, UnitFlags=33088 WHERE Entry = 9537;

-- Hammered Patron 9554
UPDATE creature_template SET MinLevelHealth = 6186, MaxLevelHealth = 7113, HealthMultiplier=3, PowerMultiplier = 2, DamageMultiplier = 3.5, MinMeleeDmg = 80, MaxMeleeDmg = 117, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier = 1 WHERE Entry = 9554;
-- Grim Patron 9545
UPDATE creature_template SET DamageMultiplier = 1.6, MinMeleeDmg = 80, MaxMeleeDmg = 117, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000 WHERE Entry = 9545;
-- Guzzling Patron 9547
UPDATE creature_template SET DamageMultiplier = 1.85, MinMeleeDmg = 57, MaxMeleeDmg = 87, MeleeAttackPower = 95, RangedAttackPower=22, MeleeBaseAttackTime = 2000 WHERE Entry = 9547;

-- Twilight's Hammer Torturer 8912
UPDATE creature_template SET DamageMultiplier = 3.1, MinMeleeDmg = 77, MaxMeleeDmg = 106, MeleeAttackPower = 198, RangedAttackPower=19, MeleeBaseAttackTime = 2000 WHERE Entry = 8912;
-- Twilight Emissary 8913
UPDATE creature_template SET MinLevelHealth = 4980, MaxLevelHealth = 5151, MinLevelMana=9300, MaxLevelMana=9530, HealthMultiplier = 3, PowerMultiplier = 2, DamageMultiplier = 3.3, MinMeleeDmg = 63, MaxMeleeDmg = 89, MeleeAttackPower = 97, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier=1 WHERE Entry = 8913;
-- Twilight Bodyguard 8914
UPDATE creature_template SET MinLevelHealth = 5886, MaxLevelHealth = 6078, MinLevelMana=3964, MaxLevelMana=4082, HealthMultiplier = 3, PowerMultiplier = 2, DamageMultiplier = 3.4, MinMeleeDmg = 84, MaxMeleeDmg = 114, MeleeAttackPower = 210, RangedAttackPower=20, MeleeBaseAttackTime = 2000, ArmorMultiplier=1 WHERE Entry = 8914;
-- Twilight's Hammer Ambassador 8915
UPDATE creature_template SET DamageMultiplier = 1.75, MinMeleeDmg = 86, MaxMeleeDmg = 116, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000 WHERE Entry = 8915;
-- Twilight's Hammer Executioner 9398
UPDATE creature_template SET MinLevelHealth = 7842, MaxLevelHealth = 8097, HealthMultiplier = 3, PowerMultiplier = 2, DamageMultiplier = 4, MinMeleeDmg = 94, MaxMeleeDmg = 127, MeleeAttackPower = 234, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier=1 WHERE Entry = 9398;

-- Dark Guard 9445
UPDATE creature_template SET MinLevelHealth = 7359, MaxLevelHealth = 7599, HealthMultiplier = 3, PowerMultiplier = 2, DamageMultiplier = 3.4, MinMeleeDmg = 90, MaxMeleeDmg = 122, MeleeAttackPower = 224, RangedAttackPower=22, MeleeBaseAttackTime = 2000, ArmorMultiplier=1 WHERE Entry = 9445;

-- Bloodhound 8921
 UPDATE creature_template SET DamageMultiplier = 3, MinMeleeDmg = 83, MaxMeleeDmg = 112, MeleeAttackPower = 206, RangedAttackPower=20, MeleeBaseAttackTime = 2000 WHERE Entry = 8921;
-- Bloodhound Mastiff 8922
UPDATE creature_template SET MinLevelHealth = 3293, MaxLevelHealth = 3398, HealthMultiplier = 3, PowerMultiplier = 2, DamageMultiplier = 3, MinMeleeDmg = 92, MaxMeleeDmg = 125, MeleeAttackPower = 228, RangedAttackPower=23, MeleeBaseAttackTime = 2000, ArmorMultiplier=1 WHERE Entry = 8922;

-- Dredge Worm 8925
UPDATE creature_template SET MaxLevelHealth = 4268, HealthMultiplier = 1.8, PowerMultiplier = 1, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier=1, MinMeleeDmg = 85, MaxMeleeDmg = 117, DamageMultiplier = 2 WHERE Entry = 8925;
-- Deep Stinger 8926
UPDATE creature_template SET MaxLevelHealth = 7113, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier=1, MinMeleeDmg = 85, MaxMeleeDmg = 117, DamageMultiplier = 3 WHERE Entry = 8926;
-- Dark Screecher 8927
UPDATE creature_template SET MaxLevelHealth = 2371, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier=1, MinMeleeDmg = 85, MaxMeleeDmg = 117, DamageMultiplier = 1.6 WHERE Entry = 8927;
-- Burrowing Thundersnout 8928
UPDATE creature_template SET MinLevelHealth = 5538, MaxLevelHealth = 5928, HealthMultiplier = 2.5, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier=1, MinMeleeDmg = 85, MaxMeleeDmg = 117, DamageMultiplier = 3 WHERE Entry = 8928;
-- Borer Beetle 8932
UPDATE creature_template SET MinLevelHealth = 2215, MaxLevelHealth = 2371, HealthMultiplier = 1, PowerMultiplier = 1, DamageMultiplier = 1.6, MinMeleeDmg = 85, MaxMeleeDmg = 117, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier=1 WHERE Entry = 8932;
-- Cave Creeper 8933
UPDATE creature_template SET MinLevel=50, MinLevelHealth = 5538, MaxLevelHealth = 5928, HealthMultiplier = 2.5, PowerMultiplier = 1, MeleeAttackPower = 214, RangedAttackPower=21, MeleeBaseAttackTime = 2000, ArmorMultiplier=1, MinMeleeDmg = 85, MaxMeleeDmg = 117, DamageMultiplier = 3 WHERE Entry = 8933;

-- Arena Spectator 8916
UPDATE creature_template SET MinLevelHealth = 2561, MaxLevelHealth = 2735, HealthMultiplier = 1.35, ArmorMultiplier=1, DamageMultiplier = 1.7, MinMeleeDmg = 82, MaxMeleeDmg = 114, MeleeAttackPower = 210, RangedAttackPower=20, MeleeBaseAttackTime = 2000 WHERE Entry = 8916;

-- Stats cleanup
UPDATE creature, creature_template SET creature.curhealth = creature_template.MinLevelHealth, creature.curmana = creature_template.MinLevelMana WHERE creature.id = creature_template.entry AND creature_template.RegenerateStats & 1;

DELETE FROM `creature_template` WHERE `Entry` = '1849';
INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES
('1849', 'Dreadwhisper', '', '58', '58', '4629', '0', '21', '21', '0', '0', '6', '3', '3', '0', '0', '64', '0', '0', '0', '1', '1.14286', '1', '4', '1.35', '1', '1', '1', '1', '1', '3876', '3876', '0', '0', '99.7', '132.4', '0', '0', '3435', '242', '25', '2000', '2000', '0', '0', '0', '0', '0', '0', '0', '0', '8388624', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'EventAI');


DELETE FROM `creature_ai_scripts` WHERE `creature_id` = '1849';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
('184901', '1849', '11', '0', '100', '0', '0', '0', '0', '0', '11', '12552', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Dreadwhisper - Criple'),
('184902', '1849', '0', '0', '100', '1', '15000', '30000', '30000', '30000', '11', '17228', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Dreadwhisper - Shadow Bolt Volley '),
('184903', '1849', '0', '0', '100', '1', '5000', '15000', '15000', '15000', '11', '7068', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Dreadwhisper - Veil of Shadow');
-- Fixed stats of boss NPCs in Blackrock Depths

-- Lord Roccor
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `PowerMultiplier`='2', `DamageMultiplier`='3.6', `ArmorMultiplier`='1.5', `MinMeleeDmg`='86.3', `MaxMeleeDmg`='114.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='210', `RangedAttackPower`='20', `MeleeBaseAttackTime`='2000', `ResistanceFire`='153', `ResistanceNature`='153', `ResistanceFrost`='0', `ResistanceShadow`='0', `ResistanceArcane`='0' WHERE `Entry`='9025';

-- Houndmaster Grebmar
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `PowerMultiplier`='2', `DamageMultiplier`='3.7', `MinMeleeDmg`='88.3', `MaxMeleeDmg`='117.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='214', `RangedAttackPower`='14', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9319';

-- High Interrogator Gerstahn
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `DamageMultiplier`='3.3', `MinMeleeDmg`='82.2', `MaxMeleeDmg`='108.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='202', `RangedAttackPower`='19', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9018';

-- High Justice Grimstone
UPDATE `creature_template` SET `UnitFlags`='832', `DynamicFlags`='0', `PowerMultiplier`='2', `DamageMultiplier`='3.7', `MinMeleeDmg`='88.3', `MaxMeleeDmg`='117.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3108', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10096';

-- Anub'shiah [UNKNOWN SWINGTIMER]

-- Eviscerator [UNKNOWN SWINGTIMER]

-- Gorosh the Dervish [UNKNOWN SWINGTIMER]

-- Grizzle [UNKNOWN SWINGTIMER]

-- Hedrum the Creeper
UPDATE `creature_template` SET `MinLevel`='53', `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='5.5', `ArmorMultiplier`='1', `MinLevelHealth`='20851', `MaxLevelHealth`='20851', `MinMeleeDmg`='108.0', `MaxMeleeDmg`='143.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3163', `MeleeAttackPower`='218', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2400', `RangedBaseAttackTime`='2400' WHERE `Entry`='9032';

-- Ok'thor the Breaker
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1.6', `HealthMultiplier`='8', `PowerMultiplier`='8', `DamageMultiplier`='4.25', `ArmorMultiplier`='1', `MinLevelHealth`='15696', `MaxLevelHealth`='15696', `MinLevelMana`='15856', `MaxLevelMana`='15856', `MinMeleeDmg`='83.8', `MaxMeleeDmg`='111.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2544', `MeleeAttackPower`='206', `RangedAttackPower`='20', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9030';

-- Pyromancer Loregrain

-- Warder Stilgiss
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `HealthMultiplier`='4', `PowerMultiplier`='5', `DamageMultiplier`='3.5', `ArmorMultiplier`='1', `MinLevelHealth`='8636', `MaxLevelHealth`='8636', `MinLevelMana`='10815', `MaxLevelMana`='10815', `MinMeleeDmg`='89.3', `MaxMeleeDmg`='118.2', `Armor`='2699', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='220', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9041';

-- Verek
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `HealthMultiplier`='4', `PowerMultiplier`='2', `DamageMultiplier`='4.5', `ArmorMultiplier`='1', `MinLevelHealth`='10456', `MaxLevelHealth`='10456', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='124.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3327', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9042';

-- Watchman Doomgrip
UPDATE `creature_template` SET `FactionAlliance`='54', `FactionHorde`='54', `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='5', `PowerMultiplier`='2', `DamageMultiplier`='5', `ArmorMultiplier`='1', `MinLevelHealth`='10455', `MaxLevelHealth`='10455', `MinLevelMana`='4234', `MaxLevelMana`='4234', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2654', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9476';

-- Dark Keeper Bethek
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='3.5', `ArmorMultiplier`='1', `MinLevelHealth`='6273', `MaxLevelHealth`='6273', `MinLevelMana`='4234', `MaxLevelMana`='4234', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2654', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='9437';

-- Dark Keeper Ofgut
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='3.5', `ArmorMultiplier`='1', `MinLevelHealth`='6273', `MaxLevelHealth`='6273', `MinLevelMana`='4234', `MaxLevelMana`='4234', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2654', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='9438';

-- Dark Keeper Pelver
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='3.5', `ArmorMultiplier`='1', `MinLevelHealth`='6273', `MaxLevelHealth`='6273', `MinLevelMana`='4234', `MaxLevelMana`='4234', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2654', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='9441';

-- Dark Keeper Uggel
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='3.5', `ArmorMultiplier`='1', `MinLevelHealth`='6273', `MaxLevelHealth`='6273', `MinLevelMana`='4234', `MaxLevelMana`='4234', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2654', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='9442';

-- Dark Keeper Vorfalk
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='3.5', `ArmorMultiplier`='1', `MinLevelHealth`='6273', `MaxLevelHealth`='6273', `MinLevelMana`='4234', `MaxLevelMana`='4234', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2654', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='9443';

-- Dark Keeper Zimrel
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='3', `PowerMultiplier`='2', `DamageMultiplier`='3.5', `ArmorMultiplier`='1', `MinLevelHealth`='6273', `MaxLevelHealth`='6273', `MinLevelMana`='4234', `MaxLevelMana`='4234', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2654', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='9439';

-- Fineous Darkvire 

-- Lord Incendius
UPDATE `creature_template` SET `MinLevel`='55', `MaxLevel`='55', `UnitFlags`='32832', `CreatureTypeFlags`='72', `HealthMultiplier`='6.5', `PowerMultiplier`='5', `DamageMultiplier`='5', `ArmorMultiplier`='1', `MinLevelHealth`='16991', `MaxLevelHealth`='16991', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='124.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3244', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `ResistanceFire`='0', `ResistanceNature`='0', `ResistanceFrost`='0', `ResistanceShadow`='0', `ResistanceArcane`='0' WHERE `Entry`='9017';

-- Bael'Gar
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `HealthMultiplier`='10', `PowerMultiplier`='2', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinLevelHealth`='25330', `MaxLevelHealth`='25330', `MinMeleeDmg`='110.5', `MaxMeleeDmg`='146.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3216', `MeleeAttackPower`='224', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2400', `RangedBaseAttackTime`='2400' WHERE `Entry`='9016';

-- General Angerforge
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `HealthMultiplier`='8', `PowerMultiplier`='2', `DamageMultiplier`='6.5', `ArmorMultiplier`='1', `MinLevelHealth`='22272', `MaxLevelHealth`='22272', `MinMeleeDmg`='88.1', `MaxMeleeDmg`='116.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3326', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='9033';

-- Golem Lord Argelmach
UPDATE `creature_template` SET `HealthMultiplier`='6', `PowerMultiplier`='8', `DamageMultiplier`='6.25', `ArmorMultiplier`='1', `MinLevelHealth`='13362', `MaxLevelHealth`='13362', `MinLevelMana`='17928', `MaxLevelMana`='17928', `MinMeleeDmg`='91.1', `MaxMeleeDmg`='120.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2744', `MeleeAttackPower`='224', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2000' WHERE `Entry`='8983';

-- Ribbly Screwspigot

-- Hurley Blackbreath [NO DAMAGE CALC - MISSING IN BESTIARY]
UPDATE `creature_template` SET `FactionAlliance`='54', `FactionHorde`='54', `UnitFlags`='33088', `CreatureTypeFlags`='72', `HealthMultiplier`='5', `PowerMultiplier`='2', `ArmorMultiplier`='1', `MinLevelHealth`='13070', `MaxLevelHealth`='13070', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3271', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9537';

-- Phalanx
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `PowerMultiplier`='2', `DamageMultiplier`='7', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='124.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MovementType`='1' WHERE `Entry`='9502';

-- Plugger Spazzring [NO DAMAGE CALC - UNKNOWN VARIANCE FORMULAR]
	
-- Ambassador Flamelash
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `HealthMultiplier`='10', `PowerMultiplier`='2', `DamageMultiplier`='5', `ArmorMultiplier`='1', `MinLevelHealth`='27840', `MaxLevelHealth`='27840', `MinMeleeDmg`='97.9', `MaxMeleeDmg`='129.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3380', `MeleeAttackPower`='283', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9156';

-- Panzor the Invincible
UPDATE `creature_template` SET `FactionAlliance`='54', `FactionHorde`='54', `NpcFlags`='32832', `CreatureTypeFlags`='72', `HealthMultiplier`='5', `PowerMultiplier`='2', `DamageMultiplier`='6', `ArmorMultiplier`='1.5', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='127.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='8923';

-- Doom'rel
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `DamageMultiplier`='3.7', `MinMeleeDmg`='89.3', `MaxMeleeDmg`='118.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2699', `MeleeAttackPower`='220', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9039';

-- Dope'rel
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `UnitClass`='1', `PowerMultiplier`='2', `DamageMultiplier`='4', `ArmorMultiplier`='0.5', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='127.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9040';

-- Gloom'rel
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `PowerMultiplier`='2', `DamageMultiplier`='5.6', `MinMeleeDmg`='95.9', `MaxMeleeDmg`='127.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9037';

-- Anger'rel
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `PowerMultiplier`='2', `DamageMultiplier`='4', `MinMeleeDmg`='94.0', `MaxMeleeDmg`='124.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9035';

-- Hate'rel
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `DamageMultiplier`='4', `MinMeleeDmg`='87.5', `MaxMeleeDmg`='115.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9034';

-- Vile'rel
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `DamageMultiplier`='3.6', `MinMeleeDmg`='89.3', `MaxMeleeDmg`='118.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='220', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9036';

-- Seeth'rel
UPDATE `creature_template` SET `CreatureTypeFlags`='72', `DamageMultiplier`='3.6', `MinMeleeDmg`='89.3', `MaxMeleeDmg`='118.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2699', `MeleeAttackPower`='220', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9038';

-- Magmus [ALREADY DONE]

-- Emperor Dagran Thaurissan
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `HealthMultiplier`='9', `PowerMultiplier`='2', `DamageMultiplier`='7.25', `ArmorMultiplier`='1', `MinLevelHealth`='26649', `MaxLevelHealth`='26649', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3489', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000' WHERE `Entry`='9019';

-- Christmas Emperor Dagran Thaurissan
UPDATE `creature_template` SET `MinLevel`='59', `MaxLevel`='59', `FactionAlliance`='54', `FactionHorde`='54', `Scale`='0', `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `PowerMultiplier`='2', `DamageMultiplier`='7.25', `MinLevelHealth`='26649', `MaxLevelHealth`='26649', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3489', `MeleeAttackPower`='248', `RangedAttackPower`='25' WHERE `Entry`='15775';

-- Princess Moira Bronzebeard
UPDATE `creature_template` SET `HealthMultiplier`='6.5', `PowerMultiplier`='3', `DamageMultiplier`='4.5', `ArmorMultiplier`='1', `MinLevelHealth`='14931', `MaxLevelHealth`='14931', `MinLevelMana`='6867', `MaxLevelMana`='6867', `MinMeleeDmg`='92.9', `MaxMeleeDmg`='123.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2788', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000' WHERE `Entry`='8929';

-- High Priestess of Thaurissan
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='6.5', `PowerMultiplier`='3', `DamageMultiplier`='4.5', `ArmorMultiplier`='1', `MinLevelHealth`='14931', `MaxLevelHealth`='14931', `MinLevelMana`='6867', `MaxLevelMana`='6867', `MinMeleeDmg`='92.9', `MaxMeleeDmg`='123', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2788', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='10076';

-- Theldren [UNKNOWN SWINGTIMER]

-- Lefty [UNKNOWN SWINGTIMER]

-- Rotfang [UNKNOWN SWINGTIMER]

-- Malgen Longspear [UNKNOWN SWINGTIMER]

-- Gnashjaw [UNKNOWN SWINGTIMER]

-- Va'jashni [UNKNOWN SWINGTIMER]

-- Volida [UNKNOWN SWINGTIMER]

-- Snokh Blackspine [UNKNOWN SWINGTIMER]

-- Korv [UNKNOWN SWINGTIMER]

-- Rezznik [UNKNOWN SWINGTIMER]

-- Eviscerator
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='9', `PowerMultiplier`='5', `DamageMultiplier`='7.5', `ArmorMultiplier`='1', `MinLevelHealth`='18234', `MaxLevelHealth`='18234', `MinLevelMana`='10205', `MaxLevelMana`='10205', `MinMeleeDmg`='55.7', `MaxMeleeDmg`='73.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2610', `MeleeAttackPower`='210', `RangedAttackPower`='20', `MeleeBaseAttackTime`='1300', `RangedBaseAttackTime`='1300', `AIName`='EventAI' WHERE `Entry`='9029';

DELETE FROM `creature_ai_scripts` WHERE `creature_id`='9029';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
('902901', '9029', '0', '0', '100', '1', '4000', '8000', '6000', '12000', '11', '14331', '1', '32', '0', '0', '0', '0', '0', '0', '0', '0', 'Eviscerator - Vicious Rend'),
('902902', '9029', '0', '0', '100', '1', '6000', '12000', '12000', '24000', '11', '15245', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Eviscerator - Shadow Bolt Volley'),
('902903', '9029', '0', '0', '100', '1', '6000', '12000', '12000', '24000', '11', '7121', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Eviscerator - Anti-Magic Shield');

UPDATE `creature_template` SET `UnitFlags`='32832', `SpeedWalk`='1', `MinMeleeDmg`='49.7', `MaxMeleeDmg`='66.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='120', `RangedAttackPower`='12', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='14221';

UPDATE `creature` SET `modelid`='0', `position_x`='717.6572', `position_y`='-846.4034', `position_z`='160.7536', `orientation`='3.351032', `MovementType`='2' WHERE `id`='14221';

SET @POINT := '0';

DELETE FROM `creature_movement_template` WHERE `entry`='14221';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('14221', @POINT := @POINT + '1', '710.1757', '-847.2303', '158.9778', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '700.1337', '-853.0627', '158.5158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '684.4196', '-847.6795', '158.4978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '666.9366', '-858.7391', '158.4978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '663.8845', '-866.6437', '158.4985', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '662.6373', '-879.3889', '158.2913', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '659.8421', '-884.8450', '158.6172', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '666.7291', '-899.7902', '164.6245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '669.0222', '-904.2005', '164.4140', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '667.2293', '-921.9614', '164.4140', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '666.7783', '-939.5458', '164.8495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '673.5872', '-950.2739', '164.3495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '684.3471', '-959.2615', '164.3495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '698.7084', '-966.3210', '164.6530', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '708.3213', '-976.5755', '165.5618', '30000', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '700.1210', '-957.0955', '164.6795', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '715.2240', '-933.3687', '164.3436', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '716.5434', '-899.9173', '166.3662', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '715.2043', '-866.5953', '161.6596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '717.6572', '-846.4034', '160.7536', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14221', @POINT := @POINT + '1', '717.6572', '-846.4034', '160.7536', '30000', '0', '0', '0', '0', '0', '0', '0', '0', '3.351032', '0', '0');

-- Anub-Shiah
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='8', `PowerMultiplier`='5', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinLevelHealth`='16208', `MaxLevelHealth`='16208', `MinLevelMana`='10205', `MaxLevelMana`='10205', `MinMeleeDmg`='77.1', `MaxMeleeDmg`='102.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2610', `MeleeAttackPower`='210', `RangedAttackPower`='20', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='9031';

-- Gorosh the Dervish
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='1', `HealthMultiplier`='6', `PowerMultiplier`='2', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinLevelHealth`='16194', `MaxLevelHealth`='16194', `MinMeleeDmg`='86.3', `MaxMeleeDmg`='114.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3327', `MeleeAttackPower`='234', `RangedAttackPower`='23', `MeleeBaseAttackTime`='1800', `RangedBaseAttackTime`='1800' WHERE `Entry`='9027';

-- Grizzle
UPDATE `creature_template` SET `UnitFlags`='32832', `CreatureTypeFlags`='72', `SpeedWalk`='0.666668', `HealthMultiplier`='9', `PowerMultiplier`='2', `DamageMultiplier`='6', `ArmorMultiplier`='1', `MinLevelHealth`='22797', `MaxLevelHealth`='22797', `MinMeleeDmg`='92.1', `MaxMeleeDmg`='122.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3244', `MeleeAttackPower`='224', `RangedAttackPower`='22', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9028';
-- Linked all NPCs in The Manufactory to NPC 8983 (Golem Lord Argelmach) in Blackrock Depths
-- Moved creature addons for golems to template addons and moved the stone aura to ACID for better handling
-- This closes #154 thanks to jeeron for reporting and to @xfurry and thetrueanimal for researching/suggesting a fix
-- Source: https://www.youtube.com/watch?v=KWEahci7MZ0

DELETE FROM `creature_linking_template` WHERE `map` = 230 AND `entry` IN (8900, 8906, 8907, 8920);
INSERT INTO `creature_linking_template` VALUES
(8900, 230, 8983, 1, 100), -- Doomforge Arcanasmith : not all of them, only those in The Manufactory, those in Halls of Crafting are not linked
(8906, 230, 8920, 1, 12), -- Ragereaver Golem
(8907, 230, 8983, 1, 0), -- Wrath Hammer Construct
(8920, 230, 8983, 1, 100); -- Weapon Technician : not all of them, only those in The Manufactory, those in Shadowforge City are not linked

DELETE FROM `creature_linking` WHERE `guid` = 45932;
INSERT INTO `creature_linking` VALUES
(45932, 45931, 1);

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (8906, 8907));
DELETE FROM `creature_template_addon` WHERE `entry` IN (8906, 8907);
INSERT INTO `creature_template_addon` VALUES
(8906, 0, 0, 1, 16, 0, 0, NULL),
(8907, 0, 0, 1, 16, 0, 0, NULL);

UPDATE `creature` SET `modelid`='0', `position_x`='3439.25', `position_y`='-4980.96', `position_z`='195.8113', `orientation`='2.321288' WHERE `guid`='86607';

UPDATE `creature_template` SET `UnitFlags`='32768', `SpeedWalk`='1', `DamageMultiplier`='1.25', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1', `EquipmentTemplateId`='2429' WHERE `Entry`='10822';

DELETE FROM `creature_equip_template_raw` WHERE `entry`='2429';
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
('2429', '5290', '0', '0', '33489666', '0', '0', '781', '0', '0');

UPDATE `creature_template` SET `MinLevel`='48', `MaxLevel`='48', `FactionAlliance`='16', `FactionHorde`='16', `UnitFlags`='64', `SpeedWalk`='1', `HealthMultiplier`='1.25', `DamageMultiplier`='1.25', `ArmorMultiplier`='1', `MinMeleeDmg`='80.4', `MaxMeleeDmg`='106.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='196', `RangedAttackPower`='19', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='5347';

UPDATE `creature` SET `modelid`='0', `position_x`='-5802.390', `position_y`='1577.410', `position_z`='73.78505', `MovementType`='2' WHERE `guid`='51840';

SET @POINT := '0';
DELETE FROM `creature_movement_template` WHERE `entry`='5347';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('5347', @POINT := @POINT + '1', '-5771.840', '1553.960', '69.56287', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5740.690', '1535.510', '68.61464', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5705.140', '1546.160', '69.12675', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5673.370', '1580.830', '69.91760', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5646.900', '1594.460', '70.99152', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5613.440', '1575.120', '64.29109', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5576.160', '1568.940', '60.28103', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5565.660', '1594.916', '67.81759', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5560.140', '1629.560', '68.72121', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5555.990', '1650.140', '68.10619', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5526.420', '1648.400', '50.91718', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5491.720', '1619.420', '47.95635', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5455.810', '1596.310', '47.60862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5412.830', '1618.730', '50.18225', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5378.369', '1646.102', '49.86166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5393.750', '1672.950', '51.37539', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5417.440', '1697.570', '61.02838', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5451.480', '1689.920', '56.94900', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5485.370', '1705.930', '58.49550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5523.350', '1695.240', '60.49908', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5549.170', '1714.110', '75.12833', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5591.390', '1713.790', '82.83695', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5631.340', '1708.570', '86.39445', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5673.967', '1694.068', '90.81719', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5704.540', '1686.800', '90.89021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5731.920', '1661.130', '87.00084', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5762.200', '1647.850', '84.15019', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5793.000', '1617.910', '82.89826', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5347', @POINT := @POINT + '1', '-5802.390', '1577.410', '73.78505', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');


UPDATE `creature_template` SET `MinLevel`='41', `MaxLevel`='41', `Scale`='0', `UnitFlags`='64', `HealthMultiplier`='1.2', `ArmorMultiplier`='1', `MinLevelHealth`='1902', `MaxLevelHealth`='1902', `MinMeleeDmg`='58.7', `MaxMeleeDmg`='77.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='2101', `MeleeAttackPower`='142', `RangedAttackPower`='15', `MeleeBaseAttackTime`='2000', `ResistanceFire`='0', `ResistanceNature`='0', `ResistanceFrost`='0', `ResistanceShadow`='0', `ResistanceArcane`='0', `MovementType`='1' WHERE `Entry`='14234';

UPDATE `creature_template` SET `MinLevel`='52', `MaxLevel`='52', `UnitFlags`='32832', `SpeedWalk`='1', `HealthMultiplier`='1.3', `ArmorMultiplier`='1', `MinLevelHealth`='3082', `MaxLevelHealth`='3082', `MinMeleeDmg`='88.3', `MaxMeleeDmg`='117.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3108', `MeleeAttackPower`='214', `RangedAttackPower`='21', `MeleeBaseAttackTime`='2000', `ResistanceFire`='0', `ResistanceNature`='0', `ResistanceShadow`='0', `ResistanceArcane`='0', `MovementType`='1' WHERE `Entry`='14343';

UPDATE `creature_template` SET `MinLevel`='19', `MaxLevel`='19', `UnitFlags`='64', `SpeedWalk`='1', `ArmorMultiplier`='1', `MinLevelHealth`='449', `MaxLevelHealth`='449', `MinMeleeDmg`='27.6', `MaxMeleeDmg`='36.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='817', `MeleeAttackPower`='68', `RangedAttackPower`='3', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1', `AIName`='EventAI' WHERE `Entry`='14266';

DELETE FROM `creature_ai_scripts` WHERE `creature_id`='14266';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
('1426601', '14266', '11', '0', '100', '0', '0', '0', '0', '0', '11', '11919', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Shanda the Spinner - Poison Proc');

UPDATE `creature_template` SET `Scale`='0', `UnitFlags`='64', `SpeedWalk`='1', `ArmorMultiplier`='2', `MinMeleeDmg`='75.6', `MaxMeleeDmg`='100.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='184', `RangedAttackPower`='17', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='5345';

UPDATE `creature_template` SET `MinLevel`='48', `MaxLevel`='48', `FactionAlliance`='16', `FactionHorde`='16', `UnitFlags`='64', `SpeedWalk`='1', `HealthMultiplier`='1.25', `ArmorMultiplier`='1', `MinMeleeDmg`='80.4', `MaxMeleeDmg`='106.6', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='196', `RangedAttackPower`='19', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='5346';

UPDATE `creature` SET `modelid`='0', `position_x`='-5188.988', `position_y`='1825.247', `position_z`='115.7616', `orientation`='4.312038', `spawndist`='3', `MovementType`='1' WHERE `guid`='51841';
UPDATE `creature` SET `modelid`='0', `position_x`='-5168.509', `position_y`='1840.464', `position_z`='114.0250', `orientation`='2.338799' WHERE `guid`='50984';

UPDATE `creature_template` SET `Scale`='0', `UnitFlags`='64', `SpeedWalk`='1.4', `SpeedRun`='1.428571429', `MinMeleeDmg`='92.9', `MaxMeleeDmg`='123.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='228', `RangedAttackPower`='23', `MeleeBaseAttackTime`='2000' WHERE `Entry`='14478';

UPDATE `creature` SET `modelid`='0', `position_x`='-6518.560', `position_y`='1786.397', `position_z`='8.675016', `spawndist`='0' WHERE `guid`='43125';

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(SELECT `guid` FROM `creature` WHERE `id`='14478');
DELETE FROM `creature_movement_template` WHERE `entry`='14478';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('14478', @POINT := @POINT + '1', '-6513.018', '1813.922', '4.013925', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6487.165', '1817.592', '3.343527', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6463.739', '1787.981', '8.027637', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6442.454', '1782.878', '10.88384', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6413.579', '1788.175', '4.621660', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6382.024', '1780.843', '2.502150', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6345.296', '1774.620', '4.610785', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6325.381', '1751.388', '1.960434', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6316.682', '1718.207', '2.535166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6304.689', '1690.992', '1.901709', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6279.769', '1689.267', '4.675986', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6274.726', '1643.707', '4.396110', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6275.510', '1612.685', '5.163792', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6295.463', '1580.651', '0.492463', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6310.759', '1549.342', '2.731886', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6332.532', '1518.061', '1.550802', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6355.264', '1514.468', '4.780538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6391.027', '1513.292', '4.346939', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6421.498', '1502.604', '5.614395', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6453.850', '1490.276', '6.788818', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6487.023', '1501.032', '5.496054', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6522.183', '1504.034', '2.713829', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6552.034', '1512.453', '3.947961', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6577.897', '1544.810', '0.103735', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6579.297', '1580.114', '3.186564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6578.358', '1614.054', '8.826277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6598.862', '1645.875', '6.050514', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6593.506', '1689.174', '4.137568', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6587.823', '1725.753', '4.022511', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6582.305', '1748.842', '3.366025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6554.310', '1776.093', '3.573771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14478', @POINT := @POINT + '1', '-6518.560', '1786.397', '8.675016', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature_template` SET `MinLevel`='60', `HealthMultiplier`='20', `DamageMultiplier`='8.5', `ArmorMultiplier`='1', `MinLevelHealth`='61040', `MaxLevelHealth`='61040', `MinMeleeDmg`='77.9', `MaxMeleeDmg`='103.4', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='6584';

UPDATE `creature_template` SET `MinLevel`='42', `SpeedWalk`='1', `HealthMultiplier`='3', `DamageMultiplier`='2.2', `ArmorMultiplier`='1', `MinMeleeDmg`='58.1', `MaxMeleeDmg`='76.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='142', `RangedAttackPower`='13', `MeleeBaseAttackTime`='2000', `DamageSchool`='2' WHERE `Entry`='2745';

UPDATE `creature_template` SET `FactionAlliance`='16', `FactionHorde`='16', `UnitFlags`='64', `SpeedWalk`='1', `SpeedRun`='1.428571429', `DamageMultiplier`='1.7', `MinMeleeDmg`='21.5', `MaxMeleeDmg`='28.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='80', `RangedAttackPower`='5', `MeleeBaseAttackTime`='1300', `RangedBaseAttackTime`='1300' WHERE `Entry`='5828';

UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='10417';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='10438';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='10812';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='10984';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='11121';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='12128';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='12156';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='12800';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='12801';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='12802';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='13419';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='14262';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='14263';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='14264';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='14502';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='14503';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15067';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15088';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15181';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15182';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15185';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15195';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15197';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15199';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15207';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15208';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15209';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15211';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15212';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15220';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15307';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15667';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='15744';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16020';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16033';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16067';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16149';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16163';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16194';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16215';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16216';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16236';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16290';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16297';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16446';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16447';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='16803';
UPDATE `creature_template` SET `Rank`='1' WHERE `Entry`='1050';

UPDATE `creature` SET `modelid`='0', `position_x`='-639.0886', `position_y`='-3664.568', `position_z`='95.22452', `orientation`='2.440573', `spawndist`='1', `MovementType`='1' WHERE `id`='5828';

UPDATE `creature_template` SET `SpeedWalk`='1', `SpeedRun`='2.142857143', `Rank`='2', `DamageMultiplier`='1.7', `MinMeleeDmg`='30.5', `MaxMeleeDmg`='40.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='74', `RangedAttackPower`='4', `MeleeBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='5831';

UPDATE `creature` SET `modelid`='0', `position_x`='-715.678', `position_y`='-3581.36', `position_z`='92.3236', `orientation`='4.86482', `MovementType`='2' WHERE `guid`='20433';

DELETE FROM `creature_movement_template` WHERE `entry`='5831';
INSERT INTO `creature_movement_template` VALUES
('5831', '38', '-715.575', '-3582.03', '92.3202', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '37', '-718.461', '-3563.25', '92.4140', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '36', '-714.682', '-3548.67', '93.9140', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '35', '-698.236', '-3537.26', '92.6640', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '34', '-671.141', '-3522.95', '91.8839', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '33', '-650.802', '-3498.19', '91.8199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '32', '-652.568', '-3476.71', '93.8199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '31', '-639.502', '-3449.70', '93.8133', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '30', '-623.082', '-3433.78', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '29', '-601.774', '-3430.94', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '28', '-583.176', '-3440.61', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '27', '-567.257', '-3454.55', '92.2805', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '26', '-554.641', '-3469.96', '92.9621', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '25', '-544.309', '-3489.59', '92.9094', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '24', '-541.695', '-3517.06', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '23', '-546.260', '-3538.08', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '22', '-540.395', '-3560.10', '93.1640', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '21', '-537.209', '-3579.71', '93.4125', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '20', '-519.625', '-3594.80', '93.7065', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '19', '-496.266', '-3591.78', '93.5876', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '18', '-464.342', '-3564.53', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '17', '-455.548', '-3552.11', '91.9140', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '16', '-455.237', '-3516.19', '95.3331', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '15', '-474.164', '-3490.81', '93.2984', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '14', '-493.592', '-3469.16', '94.1670', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '13', '-508.566', '-3457.70', '93.4341', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '12', '-521.856', '-3444.02', '94.6973', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '11', '-532.917', '-3435.41', '93.4966', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '10', '-559.095', '-3427.52', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '9', '-568.124', '-3434.60', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '8', '-592.714', '-3457.25', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '7', '-598.635', '-3474.48', '92.5627', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '6', '-608.157', '-3497.97', '94.3281', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '5', '-631.250', '-3524.16', '93.1640', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '4', '-649.281', '-3550.45', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '3', '-664.382', '-3573.64', '91.7890', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '2', '-685.513', '-3594.81', '91.8542', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5831', '1', '-702.322', '-3593.87', '93.8325', '0', '583101', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `dbscripts_on_creature_movement` WHERE `id`='583101';
INSERT INTO `dbscripts_on_creature_movement` VALUES
('583101', '0', '25', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Swiftmane - RUN ON');

UPDATE `creature_template` SET `SpeedWalk`='1', `DamageMultiplier`='1.7', `MinMeleeDmg`='22.1', `MaxMeleeDmg`='29.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='68', `RangedAttackPower`='3', `MeleeBaseAttackTime`='1600', `RangedBaseAttackTime`='1600', `MovementType`='1' WHERE `Entry`='5835';

UPDATE `creature` SET `modelid`='0', `equipment_id`='0', `position_x`='1060.825', `position_y`='-3089.710', `position_z`='105.2289', `MovementType`='2' WHERE `id`='5835';

SET @POINT := '0';
DELETE FROM `creature_movement_template` WHERE `entry`='5835';
INSERT INTO `creature_movement_template` VALUES
('5835', @POINT := @POINT + '1', '1061.986', '-3086.345', '105.1251', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1061.634', '-3082.626', '105.1249', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1060.180', '-3079.965', '105.1250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1058.067', '-3075.866', '105.5008', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1054.894', '-3071.720', '105.1248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1051.250', '-3069.849', '105.1248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1047.294', '-3069.876', '105.2895', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1043.630', '-3072.360', '105.7200', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1038.298', '-3076.431', '105.3281', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1033.588', '-3075.666', '105.1248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1031.403', '-3070.742', '105.1248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1030.159', '-3066.548', '105.0886', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1031.585', '-3060.083', '102.1546', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1032.791', '-3056.734', '100.4098', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1035.055', '-3054.109', '98.96556', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1039.284', '-3052.886', '98.45665', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1043.775', '-3054.494', '96.87997', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1049.612', '-3058.207', '93.91737', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1053.437', '-3062.934', '91.81248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1055.306', '-3067.910', '91.71753', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1057.021', '-3073.869', '91.74790', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1058.284', '-3077.768', '91.74529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1059.488', '-3082.520', '91.74529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1059.709', '-3086.135', '91.74529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1054.993', '-3091.561', '89.71048', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1051.957', '-3093.599', '87.61989', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1047.680', '-3095.379', '84.87052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1043.322', '-3097.008', '82.05359', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1039.548', '-3097.979', '80.94704', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1032.461', '-3100.741', '80.94704', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1028.604', '-3104.469', '80.99876', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1025.096', '-3106.792', '80.99876', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1021.447', '-3109.207', '80.99876', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1017.709', '-3109.375', '80.82066', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1017.246', '-3113.847', '80.93858', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1015.240', '-3116.812', '81.25938', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1013.111', '-3118.452', '81.71165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1010.256', '-3117.703', '81.96433', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1009.359', '-3115.536', '81.93699', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1009.965', '-3111.183', '81.45860', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1012.349', '-3109.547', '80.85960', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1013.989', '-3110.127', '80.97349', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1019.784', '-3109.268', '81.41851', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1023.758', '-3107.677', '80.99876', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1026.932', '-3105.576', '80.99876', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1036.321', '-3099.220', '80.94704', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1043.881', '-3096.502', '82.47501', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1048.609', '-3095.175', '85.44218', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1054.600', '-3092.406', '89.33358', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1058.679', '-3089.168', '91.74529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1060.600', '-3083.751', '91.74529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1059.441', '-3080.283', '91.74529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1058.013', '-3076.833', '91.74529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1055.768', '-3074.566', '91.74231', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1053.489', '-3072.353', '91.74322', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1048.930', '-3072.945', '91.73545', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1041.483', '-3075.292', '91.73331', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1037.056', '-3077.865', '91.77201', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1030.979', '-3080.973', '91.75402', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1023.379', '-3082.191', '91.73473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1015.590', '-3080.345', '91.71867', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1016.861', '-3076.982', '91.72570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1019.508', '-3077.520', '91.73126', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1020.740', '-3079.885', '91.73131', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1023.992', '-3081.433', '91.73708', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1030.161', '-3080.516', '91.75265', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1035.140', '-3078.666', '91.76655', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1039.213', '-3076.151', '91.73331', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1044.727', '-3073.745', '91.73195', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1048.532', '-3072.013', '91.73095', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1052.280', '-3069.468', '91.74916', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1053.241', '-3067.037', '91.76199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1052.287', '-3063.901', '91.64170', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1051.005', '-3060.317', '93.13999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1046.463', '-3055.466', '95.48847', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1043.437', '-3054.262', '97.09176', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1039.259', '-3053.316', '98.44495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1035.709', '-3054.802', '98.98147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1033.222', '-3056.353', '100.1441', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1030.545', '-3058.914', '101.8723', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1029.746', '-3062.890', '103.9907', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1028.885', '-3066.461', '105.0688', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1027.566', '-3071.804', '105.1248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1026.921', '-3074.341', '105.1623', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1029.291', '-3078.578', '105.1248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1031.795', '-3080.060', '105.1248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1034.149', '-3084.094', '105.1250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1035.669', '-3087.390', '104.9839', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1037.765', '-3091.234', '104.7197', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1040.766', '-3093.771', '105.0264', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1044.164', '-3096.444', '105.4315', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1048.075', '-3097.355', '105.6495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1055.781', '-3094.849', '105.5749', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1059.139', '-3093.441', '105.4970', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5835', @POINT := @POINT + '1', '1060.825', '-3089.710', '105.2289', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature_template` SET `UnitFlags`='64', `MinMeleeDmg`='13.9', `MaxMeleeDmg`='18.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='46', `RangedAttackPower`='1', `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500', `MovementType`='1' WHERE `Entry`='5865';

UPDATE `creature` SET `modelid`='0', `position_x`='542.3774', `position_y`='-2402.823', `position_z`='91.79166', `orientation`='1.328636', `spawndist`='3', `MovementType`='1' WHERE `guid`='51810';

UPDATE `creature_template` SET `UnitFlags`='64', `SpeedWalk`='0.666668', `Rank`='2', `DamageMultiplier`='5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `ResistanceShadow`='0', `MovementType`='1' WHERE `Entry`='11447';
UPDATE `creature_template` SET `UnitFlags`='64', `SpeedWalk`='1', `Rank`='2', `DamageMultiplier`='12', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3075', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='11497';
UPDATE `creature_template` SET `SpeedWalk`='1', `Rank`='2', `DamageMultiplier`='10', `MinMeleeDmg`='99.8', `MaxMeleeDmg`='132.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3435', `MeleeAttackPower`='242', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1', `EquipmentTemplateId`='2430' WHERE `Entry`='11498';

DELETE FROM `creature_equip_template_raw` WHERE `entry`='2430';
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
('2430', '782', '0', '0', '33489666', '0', '0', '781', '0', '0');


UPDATE `creature_template` SET `SpeedWalk`='0.66668', `DamageMultiplier`='1.7', `MinMeleeDmg`='25.0', `MaxMeleeDmg`='33.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='60', `RangedAttackPower`='2', `MeleeBaseAttackTime`='2000' WHERE `Entry`='5841';

DELETE FROM `creature` WHERE `guid`='6875';

UPDATE `creature_template` SET `SpeedWalk`='1', `Rank`='2', `DamageMultiplier`='3.5', `MinMeleeDmg`='94.00', `MaxMeleeDmg`='124.7', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='228', `RangedAttackPower`='23' WHERE `Entry`='2931';

UPDATE `creature_template` SET `UnitFlags`='64', `SpeedWalk`='1.4', `SpeedRun`='10' / '7', `DamageMultiplier`='3.9', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='14474';

UPDATE `creature_template` SET `UnitFlags`='64', `SpeedWalk`='1', `Rank`='2', `DamageMultiplier`='1.7', `MinMeleeDmg`='48.6', `MaxMeleeDmg`='64.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='118', `RangedAttackPower`='11', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='5937';

UPDATE `creature_template` SET `UnitFlags`='64', `SpeedWalk`='1', `Rank`='2', `DamageMultiplier`='1.4', `ArmorMultiplier`='1.5', `MinMeleeDmg`='56.0', `MaxMeleeDmg`='74.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='136', `RangedAttackPower`='14', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='2749';

UPDATE `creature_template` SET `UnitFlags`='64', `SpeedWalk`='1', `Rank`='2', `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinLevelHealth`='1686', `MaxLevelHealth`='1686', `MinMeleeDmg`='32', `MaxMeleeDmg`='42.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='922', `MeleeAttackPower`='78', `RangedAttackPower`='4', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='5864';

UPDATE `creature_template` SET `UnitFlags`='64', `SpeedWalk`='1', `UnitClass`='2', `DamageMultiplier`='2.2', `MinMeleeDmg`='58.1', `MaxMeleeDmg`='76.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='1841', `MeleeAttackPower`='142', `RangedAttackPower`='13', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='2601';
-- Fixed model of two NPCs in BRD Ring of Law event
-- Thanks Tobschinski for pointing. This contributes to 793
UPDATE `creature_template` SET `ModelId1` = 7347 WHERE `Entry` = 8926;
UPDATE `creature_template` SET `ModelId1` = 1955 WHERE `Entry` = 8927;
-- Remade the Manufactory in Blackrock Depths
-- Thanks @Tobischinski for pointing and researchin and @evil-at-wow for providing all the data
-- This closes #776

DELETE FROM `creature` WHERE `guid` IN (90809, 90586, 90587, 47293, 47259, 90589, 47260, 47257, 90590, 90894, 90808, 90816, 90813, 90594, 47295, 47292, 90892, 90810, 90591, 47294, 90812, 90595, 90588, 90895, 90593, 47255, 47258, 90814, 90815, 47256, 90817, 90811, 90592);
DELETE FROM `creature_addon` WHERE `guid` IN (90809, 90586, 80587, 47293, 90589, 47260, 47257, 90590, 90894, 90808, 90816, 90813, 90594, 47295, 47292, 90892, 90810, 90591, 47294, 90812, 90595, 90588, 90895, 90593, 47255, 47258, 90814, 90815, 47256, 90817, 90811, 90592);
DELETE FROM `creature_movement` WHERE `id` IN (90809, 90586, 80587, 47293, 90589, 47260, 47257, 90590, 90894, 90808, 90816, 90813, 90594, 47295, 47292, 90892, 90810, 90591, 47294, 90812, 90595, 90588, 90895, 90593, 47255, 47258, 90814, 90815, 47256, 90817, 90811, 90592);

SET @TIME := 2 * 60 * 60;
SET @DOOM := 8900;
SET @WEAP := 8920;
SET @RAGE := 8906;
SET @WRAT := 8907;
SET @GUID := 154622;
SET @POOL := 25471;

-- Static Doomforge Arcanasmith / Weapon Technician
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 0 AND @GUID + 15;
INSERT INTO `creature` VALUES
(@GUID + 0, @DOOM, 230, 0, 0, 759.862, 58.2598, -53.6085, 3.9619, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 1, @WEAP, 230, 0, 0, 759.862, 58.2598, -53.6085, 3.9619, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 2, @DOOM, 230, 0, 0, 756.804, 55.0023, -53.5866, 0.715585, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 3, @WEAP, 230, 0, 0, 756.804, 55.0023, -53.5866, 0.715585, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 4, @DOOM, 230, 0, 0, 756.6, 52.5513, -53.5831, 3.90954, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 5, @WEAP, 230, 0, 0, 756.6, 52.5513, -53.5831, 3.90954, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 6, @DOOM, 230, 0, 0, 760.166, 55.6209, -53.6182, 3.24631, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 7, @WEAP, 230, 0, 0, 760.166, 55.6209, -53.6182, 3.24631, @TIME, 0, 0, 9298, 0, 0, 0),
-- 
(@GUID + 8, @DOOM, 230, 0, 0, 809.952, 49.7623, -53.559, 1.22173, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 9, @WEAP, 230, 0, 0, 809.952, 49.7623, -53.559, 1.22173, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 10, @DOOM, 230, 0, 0, 804.537, 50.8482, -53.5804, 0.139626, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 11, @WEAP, 230, 0, 0, 804.537, 50.8482, -53.5804, 0.139626, @TIME, 0, 0, 9298, 0, 0, 0),
--
(@GUID + 12, @DOOM, 230, 0, 0, 786.798, -42.1107, -53.6505, 0.366519, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 13, @WEAP, 230, 0, 0, 786.798, -42.1107, -53.6505, 0.366519, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 14, @DOOM, 230, 0, 0, 793.538, -34.395, -53.631, 5.28835, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 15, @WEAP, 230, 0, 0, 793.538, -34.395, -53.631, 5.28835, @TIME, 0, 0, 9298, 0, 0, 0);

DELETE FROM `pool_creature` WHERE `guid` BETWEEN @GUID + 0 AND @GUID + 15;
INSERT INTO `pool_creature` VALUES
(@GUID + 0, @POOL + 0, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 1, @POOL + 0, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 2, @POOL + 1, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 3, @POOL + 1, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 4, @POOL + 2, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 5, @POOL + 2, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 6, @POOL + 3, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 7, @POOL + 3, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 8, @POOL + 4, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 9, @POOL + 4, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 10, @POOL + 5, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 11, @POOL + 5, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 12, @POOL + 6, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 13, @POOL + 6, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 14, @POOL + 7, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 15, @POOL + 7, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician');

DELETE FROM `pool_template` WHERE `entry` BETWEEN @POOL AND @POOL + 7;
INSERT INTO `pool_template` VALUES
(@POOL + 0, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 1, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 2, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 3, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 4, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 5, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 6, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 7, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician');

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 16 AND @GUID + 27;
INSERT INTO `creature` VALUES
(@GUID + 16, @DOOM, 230, 0, 0, 759.628, 61.429, -53.5742, 3.21141, @TIME, 0, 0, 9298, 0, 0, 0),
--
(@GUID + 17, @WEAP, 230, 0, 0, 755.346, 51.0896, -53.57, 1.0472, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 18, @WEAP, 230, 0, 0, 755.999, 61.6141, -53.5721, 6.21337, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 19, @WEAP, 230, 0, 0, 757.366, 59.5952, -53.5933, 0.837758, @TIME, 0, 0, 9298, 0, 0, 0),
--
(@GUID + 20, @WEAP, 230, 0, 0, 778.728, 42.3766, -53.6518, 2.19911, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 21, @WEAP, 230, 0, 0, 776.288, 43.6711, -53.6518, 0.418879, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 22, @WEAP, 230, 0, 0, 781.008, 46.79, -53.6518, 3.52557, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 23, @WEAP, 230, 0, 0, 778.715, 47.5265, -53.6518, 4.7822, @TIME, 0, 0, 9298, 0, 0, 0),
--
(@GUID + 24, @WEAP, 230, 0, 0, 791.143, -40.9252, -53.6506, 3.85718, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 25, @WEAP, 230, 0, 0, 787.464, -40.3752, -53.6493, 5.23599, @TIME, 0, 0, 9298, 0, 0, 0),
--
(@GUID + 26, @WEAP, 230, 0, 0, 806.096, 54.2448, -53.5767, 5.48033, @TIME, 0, 0, 9298, 0, 0, 0),
-- 
(@GUID + 27, @WEAP, 230, 0, 0, 794.78, -35.9308, -53.6368, 2.04204, @TIME, 0, 0, 9298, 0, 0, 0);

-- Static Wrath Hammer Construct and Ragereaver Golem
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 28 AND @GUID + 33;
INSERT INTO `creature` VALUES
(@GUID + 28, @RAGE, 230, 0, 0, 779.212, 44.9612, -53.6518, 3.19395, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 29, @WRAT, 230, 0, 0, 779.212, 44.9612, -53.6518, 3.19395, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 30, @RAGE, 230, 0, 0, 807.141, 52.1214, -53.5713, 3.1765, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 31, @WRAT, 230, 0, 0, 807.141, 52.1214, -53.5713, 3.1765, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 32, @RAGE, 230, 0, 0, 789.356, -42.4263, -53.6514, 1.95477, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 33, @WRAT, 230, 0, 0, 789.356, -42.4263, -53.6514, 1.95477, @TIME, 0, 0, 9298, 0, 0, 0);

DELETE FROM `pool_creature` WHERE `guid` BETWEEN @GUID + 28 AND @GUID + 33;
INSERT INTO `pool_creature` VALUES
(@GUID + 28, @POOL + 8, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 29, @POOL + 8, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 30, @POOL + 9, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 31, @POOL + 9, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 32, @POOL + 10, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 33, @POOL + 10, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct');

DELETE FROM `pool_template` WHERE `entry` BETWEEN @POOL + 8 AND @POOL + 10;
INSERT INTO `pool_template` VALUES
(@POOL + 8, 1, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 9, 1, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 10, 1, 'BRD - Ragereaver Golem/Wrath Hammer Construct');



DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 34 AND @GUID + 41;
INSERT INTO `creature` VALUES
(@GUID + 34, @RAGE, 230, 0, 0, 794.549, 2.11547, -53.6519, 3.28122, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 35, @WRAT, 230, 0, 0, 794.549, 2.11547, -53.6519, 3.28122, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 36, @RAGE, 230, 0, 0, 793.348, -9.29995, -53.6518, 3.07178, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 37, @WRAT, 230, 0, 0, 793.348, -9.29995, -53.6518, 3.07178, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 38, @RAGE, 230, 0, 0, 780.244, -9.44037, -53.6513, 1.72788, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 39, @WRAT, 230, 0, 0, 780.244, -9.44037, -53.6513, 1.72788, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 40, @RAGE, 230, 0, 0, 779.154, 1.81084, -53.6518, 0.0174533, @TIME, 0, 0, 9298, 0, 0, 0),
(@GUID + 41, @WRAT, 230, 0, 0, 779.154, 1.81084, -53.6518, 0.0174533, @TIME, 0, 0, 9298, 0, 0, 0);

DELETE FROM `pool_creature` WHERE `guid` BETWEEN @GUID + 34 AND @GUID + 41;
INSERT INTO `pool_creature` VALUES
(@GUID + 34, @POOL + 11, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 35, @POOL + 11, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 36, @POOL + 12, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 37, @POOL + 12, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 38, @POOL + 13, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 39, @POOL + 13, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 40, @POOL + 14, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@GUID + 41, @POOL + 14, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct');

DELETE FROM `pool_pool` WHERE `pool_id` BETWEEN @POOL + 11 AND @POOL + 14;
INSERT INTO `pool_pool` VALUES
(@POOL + 11, @POOL + 15, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 12, @POOL + 15, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 13, @POOL + 16, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 14, @POOL + 16, 0, 'BRD - Ragereaver Golem/Wrath Hammer Construct');

DELETE FROM `pool_template` WHERE `entry` BETWEEN @POOL + 11 AND @POOL + 16;
INSERT INTO `pool_template` VALUES
(@POOL + 11, 1, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 12, 1, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 13, 1, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 14, 1, 'BRD - Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 15, 1, 'BRD - Master Ragereaver Golem/Wrath Hammer Construct'),
(@POOL + 16, 1, 'BRD - Master Ragereaver Golem/Wrath Hammer Construct');

-- Patrols
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 42 AND @GUID + 51;
INSERT INTO `creature` VALUES
(@GUID + 42, @DOOM, 230, 0, 0, 803.859, 12.9567, -53.6615, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2),
(@GUID + 43, @WEAP, 230, 0, 0, 803.859, 12.9567, -53.6615, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2),
(@GUID + 44, @WEAP, 230, 0, 0, 762.349, 41.594, -53.7146, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2),
(@GUID + 45, @DOOM, 230, 0, 0, 782.138, -45.6668, -53.7721, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2),
(@GUID + 46, @WEAP, 230, 0, 0, 782.138, -45.6668, -53.7721, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2),
(@GUID + 47, @DOOM, 230, 0, 0, 792.438, 45.7173, -53.7176, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2),
(@GUID + 48, @WEAP, 230, 0, 0, 792.438, 45.7173, -53.7176, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2),
(@GUID + 49, @WEAP, 230, 0, 0, 773.925, 3.11658, -53.7172, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2),
(@GUID + 50, @DOOM, 230, 0, 0, 811.87, -25.2166, -53.6904, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2),
(@GUID + 51, @WEAP, 230, 0, 0, 811.87, -25.2166, -53.6904, 3.9619, @TIME, 0, 0, 9298, 0, 0, 2);

DELETE FROM `pool_creature` WHERE `guid` BETWEEN @GUID + 42 AND @GUID + 51;
INSERT INTO `pool_creature` VALUES
(@GUID + 42, @POOL + 17, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 43, @POOL + 17, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 45, @POOL + 18, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 46, @POOL + 18, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 47, @POOL + 19, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 48, @POOL + 19, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 50, @POOL + 20, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@GUID + 51, @POOL + 20, 0, 'BRD - Doomforge Arcanasmith/Weapon Technician');

DELETE FROM `pool_template` WHERE `entry` BETWEEN @POOL + 17 AND @POOL + 20;
INSERT INTO `pool_template` VALUES
(@POOL + 17, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 18, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 19, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician'),
(@POOL + 20, 1, 'BRD - Doomforge Arcanasmith/Weapon Technician');

DELETE FROM `creature_movement` WHERE `id` BETWEEN @GUID + 42 AND @GUID + 51;
INSERT INTO `creature_movement` VALUES 
-- First patrol (two possible spawns)
(@GUID + 42, 1, 803.859, 12.9567, -53.6615, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 2, 803.332, 36.0541, -53.6688, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 3, 788.064, 46.9496, -53.7332, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 4, 773.939, 57.1793, -53.7083, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 5, 762.993, 50.4319, -53.7269, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 6, 761.421, 29.3542, -53.6321, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 7, 762.968, 9.71107, -53.701, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 8, 769.319, -3.63559, -53.7241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 9, 777.615, -18.1981, -53.7212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 10, 792.493, -18.6761, -53.6741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 42, 11, 802.697, -9.92748, -53.6707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 1, 803.859, 12.9567, -53.6615, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 2, 803.332, 36.0541, -53.6688, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 3, 788.064, 46.9496, -53.7332, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 4, 773.939, 57.1793, -53.7083, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 5, 762.993, 50.4319, -53.7269, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 6, 761.421, 29.3542, -53.6321, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 7, 762.968, 9.71107, -53.701, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 8, 769.319, -3.63559, -53.7241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 9, 777.615, -18.1981, -53.7212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 10, 792.493, -18.6761, -53.6741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 43, 11, 802.697, -9.92748, -53.6707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Second patrol
(@GUID + 44, 1, 762.349, 41.594, -53.7146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 2, 799.356, 43.3486, -53.6921, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 3, 803.831, 32.7512, -53.6365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 4, 799.356, 43.3486, -53.6921, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 5, 762.349, 41.594, -53.7146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 6, 761.201, 22.3508, -53.6527, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 7, 777.259, 21.7293, -53.6562, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 8, 781.122, 8.1129, -53.6999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 9, 798.227, 7.70171, -53.6888, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 10, 802.456, -8.26351, -53.6719, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 11, 795.791, -21.864, -53.6543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 12, 813.282, -40.8431, -53.746, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 13, 795.791, -21.864, -53.6543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 14, 802.456, -8.26351, -53.6719, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 15, 798.227, 7.70171, -53.6888, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 16, 781.122, 8.1129, -53.6999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 17, 777.259, 21.7293, -53.6562, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 44, 18, 761.201, 22.3508, -53.6527, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Third patrol (two possible spawns)
(@GUID + 45, 1, 782.138, -45.6668, -53.7721, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 2, 778.198, -33.9222, -53.7311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 3, 783.974, -27.3003, -53.6742, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 4, 762.94, 8.65715, -53.71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 5, 761.041, 41.1992, -53.7038, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 6, 753.723, 41.7996, -53.6441, 40000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 7, 764.597, 45.6037, -53.7352, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 8, 774.852, 60.0696, -53.6795, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 9, 774.852, 60.0696, -53.6795, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 10, 784.549, 54.0242, -53.7352, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 11, 785.148, 35.8518, -53.6995, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 12, 776.289, 27.4625, -53.6255, 20000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 13, 776.729, 26.9007, -53.6282, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 14, 783.783, 14.001, -53.6906, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 15, 786.595, -12.3495, -53.7113, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 16, 784.733, -32.3172, -53.7235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 17, 784.662, -39.4896, -53.7492, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 45, 18, 781.288, -46.3105, -53.7746, 35000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 1, 782.138, -45.6668, -53.7721, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 2, 778.198, -33.9222, -53.7311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 3, 783.974, -27.3003, -53.6742, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 4, 762.94, 8.65715, -53.71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 5, 761.041, 41.1992, -53.7038, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 6, 753.723, 41.7996, -53.6441, 40000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 7, 764.597, 45.6037, -53.7352, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 8, 774.852, 60.0696, -53.6795, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 9, 774.852, 60.0696, -53.6795, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 10, 784.549, 54.0242, -53.7352, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 11, 785.148, 35.8518, -53.6995, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 12, 776.289, 27.4625, -53.6255, 20000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 13, 776.729, 26.9007, -53.6282, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 14, 783.783, 14.001, -53.6906, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 15, 786.595, -12.3495, -53.7113, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 16, 784.733, -32.3172, -53.7235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 17, 784.662, -39.4896, -53.7492, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 46, 18, 781.288, -46.3105, -53.7746, 35000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Fourth patrol (two possible spawns)
(@GUID + 47, 1, 792.438, 45.7173, -53.7176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 2, 795.405, 38.8804, -53.6981, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 3, 800.774, 35.1317, -53.6755, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 4, 800.455, 27.8962, -53.6365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 5, 800.281, 15.0601, -53.6782, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 6, 804.687, -0.79423, -53.6417, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 7, 809.65, -1.35354, -53.5894, 40000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 8, 808.37, -0.974017, -53.6027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 9, 798.703, -14.2282, -53.6685, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 10, 785.097, -22.9216, -53.6839, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 11, 778.349, -26.1744, -53.6948, 30000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 12, 779.015, -25.8711, -53.6937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 13, 770.726, -10.8395, -53.731, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 14, 765.311, 6.20587, -53.7134, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 15, 763.947, 21.5177, -53.6724, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 16, 777.62, 24.3637, -53.6415, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 17, 787.35, 36.6482, -53.6692, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 18, 790.302, 56.138, -53.7397, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 19, 791.537, 60.003, -53.6842, 15000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 20, 790.544, 58.6389, -53.6977, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 21, 791.594, 46.1057, -53.7208, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 47, 22, 791.594, 46.1057, -53.7208, 30000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 1, 792.438, 45.7173, -53.7176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 2, 795.405, 38.8804, -53.6981, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 3, 800.774, 35.1317, -53.6755, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 4, 800.455, 27.8962, -53.6365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 5, 800.281, 15.0601, -53.6782, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 6, 804.687, -0.79423, -53.6417, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 7, 809.65, -1.35354, -53.5894, 40000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 8, 808.37, -0.974017, -53.6027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 9, 798.703, -14.2282, -53.6685, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 10, 785.097, -22.9216, -53.6839, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 11, 778.349, -26.1744, -53.6948, 30000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 12, 779.015, -25.8711, -53.6937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 13, 770.726, -10.8395, -53.731, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 14, 765.311, 6.20587, -53.7134, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 15, 763.947, 21.5177, -53.6724, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 16, 777.62, 24.3637, -53.6415, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 17, 787.35, 36.6482, -53.6692, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 18, 790.302, 56.138, -53.7397, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 19, 791.537, 60.003, -53.6842, 15000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 20, 790.544, 58.6389, -53.6977, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 21, 791.594, 46.1057, -53.7208, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 48, 22, 791.594, 46.1057, -53.7208, 30000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Fifth patrol
(@GUID + 49, 1, 773.925, 3.11658, -53.7172, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 2, 774.192, -10.6106, -53.7327, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 3, 786.545, -21.9167, -53.6825, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 4, 785.527, -33.0789, -53.726, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 5, 789.237, -36.13, -53.7359, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 6, 785.527, -33.0789, -53.726, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 7, 786.545, -21.9167, -53.6825, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 8, 774.192, -10.6106, -53.7327, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 9, 773.925, 3.11658, -53.7172, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 10, 781.98, 7.79252, -53.6991, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 11, 783.496, 44.9433, -53.7352, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 12, 784.57, 58.7309, -53.6953, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 13, 783.496, 44.9433, -53.7352, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 49, 14, 781.98, 7.79252, -53.6991, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- Sixth patrol (two possible spawns)
(@GUID + 50, 1, 811.87, -25.2166, -53.6904, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 2, 796.794, -14.5872, -53.6733, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 3, 803.802, -5.47762, -53.6552, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 4, 800.327, 11.2513, -53.6704, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 5, 803.43, 28.3222, -53.6365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 6, 803.879, 39.4262, -53.672, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 7, 810.038, 40.6187, -53.6542, 40000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 8, 809.069, 40.2641, -53.6568, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 9, 801.317, 31.8698, -53.6365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 10, 796.212, 24.2951, -53.6492, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 11, 780.355, 12.836, -53.6862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 12, 774.289, 3.12628, -53.7185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 13, 758.585, 1.25146, -53.714, 40000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 14, 768.231, 0.35128, -53.72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 15, 775.579, -15.6753, -53.7378, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 16, 791.5, -26.4753, -53.7006, 20000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 17, 791.093, -26.4291, -53.7006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 18, 795.717, -22.4336, -53.6528, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 50, 19, 812.793, -25.571, -53.6914, 45000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 1, 811.87, -25.2166, -53.6904, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 2, 796.794, -14.5872, -53.6733, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 3, 803.802, -5.47762, -53.6552, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 4, 800.327, 11.2513, -53.6704, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 5, 803.43, 28.3222, -53.6365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 6, 803.879, 39.4262, -53.672, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 7, 810.038, 40.6187, -53.6542, 40000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 8, 809.069, 40.2641, -53.6568, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 9, 801.317, 31.8698, -53.6365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 10, 796.212, 24.2951, -53.6492, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 11, 780.355, 12.836, -53.6862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 12, 774.289, 3.12628, -53.7185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 13, 758.585, 1.25146, -53.714, 40000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 14, 768.231, 0.35128, -53.72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 15, 775.579, -15.6753, -53.7378, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 16, 791.5, -26.4753, -53.7006, 20000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 17, 791.093, -26.4291, -53.7006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 18, 795.717, -22.4336, -53.6528, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(@GUID + 51, 19, 812.793, -25.571, -53.6914, 45000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Stats cleanup
UPDATE creature, creature_template SET creature.curhealth = creature_template.MinLevelHealth, creature.curmana = creature_template.MinLevelMana WHERE creature.id = creature_template.entry AND creature_template.RegenerateStats & 1;


-- Kashoch the Reaver
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `Entry`='10198';

DELETE FROM `creature_ai_scripts` WHERE `creature_id`='10198';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
('1019801', '10198', '11', '0', '100', '0', '0', '0', '0', '0', '11', '8876', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Kashoch the Reaver - Thrash'),
('1019802', '10198', '0', '0', '100', '1', '4000', '8000', '6000', '12000', '11', '11427', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Kashoch the Reaver - Cleave');

-- Azurous
UPDATE `creature_template` SET `FactionAlliance`='103', `FactionHorde`='103', `UnitFlags`='64', `SpeedWalk`='1', `Rank`='2', `PowerMultiplier`='3', `DamageMultiplier`='3.9', `MinMeleeDmg`='101.8', `MaxMeleeDmg`='135.0', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='248', `RangedAttackPower`='25', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='10202';

DELETE FROM `creature_ai_scripts` WHERE `id`='1020202';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1020202', '10202', '0', '0', '100', '1', '10000', '20000', '20000', '30000', '11', '16099', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Azurous - Frost Breath');
UPDATE `creature_ai_scripts` SET `event_type`='11', `event_flags`='0', `event_param1`='0', `event_param2`='0', `event_param3`='0', `event_param4`='0', `action1_param1`='8876', `action1_param2`='0', `action1_param3`='2', `comment`='Azurous - Thrash' WHERE `id`='1020201';

UPDATE `creature` SET `modelid`='0', `position_x`='5986.524', `position_y`='-5055.288', `position_z`='795.3389', `orientation`='0.4098937' WHERE `guid`='51890';

SET @POINT := '0';

DELETE FROM `creature_movement_template` WHERE `entry`='10202';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('10202', @POINT := @POINT + '1', '6019.497', '-5040.973', '784.7110', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6064.572', '-5021.378', '783.7690', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6110.539', '-5029.359', '791.5023', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6143.759', '-5048.502', '788.6542', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6182.437', '-5064.908', '783.3755', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6224.185', '-5048.121', '777.5784', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6255.662', '-5044.650', '774.0142', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6295.048', '-5045.930', '768.9189', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6333.048', '-5046.227', '760.8947', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6378.587', '-5045.983', '751.7699', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6408.906', '-5042.450', '747.1038', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6438.631', '-5018.775', '739.4670', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6466.921', '-4989.887', '733.5924', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6484.619', '-4964.162', '728.3881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6500.905', '-4934.625', '725.9751', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6510.156', '-4904.851', '721.8889', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6535.346', '-4877.962', '709.6600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6559.993', '-4860.916', '701.8981', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6560.690', '-4846.943', '702.0397', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6551.316', '-4819.473', '703.5016', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6550.175', '-4785.075', '698.3546', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6574.485', '-4751.122', '696.6307', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6583.190', '-4721.823', '699.9848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6580.944', '-4680.032', '700.6795', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6568.839', '-4646.381', '694.2059', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6559.538', '-4618.036', '699.1639', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6552.842', '-4585.877', '703.9992', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6525.884', '-4563.002', '713.3481', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6495.584', '-4547.865', '716.1367', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6458.242', '-4526.247', '723.9024', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6450.272', '-4486.055', '733.4114', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6460.925', '-4454.014', '729.6072', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6449.634', '-4421.929', '723.3950', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6424.509', '-4403.555', '722.5399', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6389.606', '-4387.151', '731.3281', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6364.207', '-4363.729', '738.5326', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6362.864', '-4328.876', '726.9081', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6356.477', '-4298.460', '720.3398', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6338.967', '-4285.139', '725.5330', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6317.179', '-4280.970', '733.0714', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6280.007', '-4269.131', '735.8939', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6258.955', '-4251.505', '735.4764', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6260.608', '-4236.567', '734.0861', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6286.389', '-4221.496', '724.3796', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6327.709', '-4218.922', '721.2304', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6365.357', '-4205.964', '711.0905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6380.780', '-4186.573', '705.8233', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6365.357', '-4205.964', '711.0905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6327.709', '-4218.922', '721.2304', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6286.389', '-4221.496', '724.3796', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6260.608', '-4236.567', '734.0861', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6258.955', '-4251.505', '735.4764', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6280.007', '-4269.131', '735.8939', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6317.179', '-4280.970', '733.0714', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6338.889', '-4285.093', '725.6608', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6356.398', '-4298.412', '720.1580', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6362.864', '-4328.876', '726.9081', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6364.207', '-4363.729', '738.5326', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6389.606', '-4387.151', '731.3281', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6424.509', '-4403.555', '722.5399', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6449.634', '-4421.929', '723.3950', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6460.925', '-4454.014', '729.6072', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6450.272', '-4486.055', '733.4114', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6458.242', '-4526.247', '723.9024', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6495.584', '-4547.865', '716.1367', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6525.884', '-4563.002', '713.3481', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6552.842', '-4585.877', '703.9992', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6559.538', '-4618.036', '699.1639', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6568.839', '-4646.381', '694.2059', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6580.944', '-4680.032', '700.6795', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6583.190', '-4721.823', '699.9848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6574.485', '-4751.122', '696.6307', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6550.175', '-4785.075', '698.3546', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6551.271', '-4819.074', '703.5016', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6560.692', '-4846.882', '702.2216', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6559.995', '-4860.855', '701.9147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6535.346', '-4877.962', '709.6600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6510.156', '-4904.851', '721.8889', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6500.905', '-4934.625', '725.9751', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6484.619', '-4964.162', '728.3881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6466.921', '-4989.887', '733.5924', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6438.633', '-5018.775', '739.5107', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6408.906', '-5042.450', '747.1038', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6378.587', '-5045.983', '751.7699', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6333.245', '-5046.217', '760.8995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6295.048', '-5045.930', '768.9189', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6255.662', '-5044.650', '774.0142', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6224.249', '-5048.050', '777.6802', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6182.588', '-5064.937', '783.4294', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6143.759', '-5048.502', '788.6542', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6110.539', '-5029.359', '791.5023', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6064.572', '-5021.378', '783.7690', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '6019.497', '-5040.973', '784.7110', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('10202', @POINT := @POINT + '1', '5977.622', '-5059.156', '798.2071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- Hematos
UPDATE `creature_template` SET `UnitFlags`='64', `Rank`='2', `PowerMultiplier`='2', `DamageMultiplier`='5', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='8976';

--  Volchan
UPDATE `creature_template` SET `SpeedWalk`='1', `SpeedRun`='1.4285714129', `Rank`='2', `HealthMultiplier`='5', `PowerMultiplier`='2', `DamageMultiplier`='5', `MinMeleeDmg`='96.8', `MaxMeleeDmg`='128.2', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='238', `RangedAttackPower`='24', `MeleeBaseAttackTime`='2000' WHERE `Entry`='10119';
-- Added missing script from update [1139]

SET @GUID := 154622;

UPDATE `creature_movement` SET `script_id` = 4729401 WHERE `point` = 9 AND `id` IN (@GUID + 45, @GUID + 46);
-- Added missing spawn of NPC 5981 (Portal Seeker) in Blasted Lands
-- Thanks Neotmiren for pointing, researching and fixing. This closes #779

SET @GUID := 159993;

DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO creature (guid,id,map,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,curhealth,curmana,MovementType) VALUES
(@GUID, 5981, 0, -11351.9, -2754.5, 7.95043, 2.103, 430, 7, 2131, 0, 2);
UPDATE creature_template SET MovementType = 2 WHERE Entry = 5981;

DELETE FROM `creature_movement_template` WHERE `entry` = 5981;
INSERT INTO `creature_movement_template` VALUES
(5981, 1, -11351.9, -2754.5, 7.95043, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 13, -11370.7, -2855.8, 4.71995, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 12, -11396.9, -2926.05, 3.04129, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 11, -11331, -2986.1, 3.21401, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 10, -11380.8, -3012.74, -4.27558, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 9, -11444.1, -3037.88, 1.11443, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 8, -11500.1, -3041.02, -0.783425, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 7, -11444, -3037.98, 1.11936, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 6, -11380.8, -3013.05, -4.29948, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 5, -11330.8, -2986.01, 3.24732, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 4, -11396.7, -2926.03, 3.05246, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 3, -11370.9, -2855.73, 4.67282, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 2, -11358.7, -2797.01, 5.45784, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(5981, 14, -11358.6, -2796.98, 5.47431, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);

UPDATE `creature_template` SET `UnitFlags`='64', `SpeedWalk`='1', `Rank`='2', `DamageMultiplier`='1.7', `MinMeleeDmg`='27.6', `MaxMeleeDmg`='36.5', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='68', `RangedAttackPower`='3', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='14267';

UPDATE `creature` SET `modelid`='0', `position_x`='-4983.443', `position_y`='-4009.711', `position_z`='299.5536', `spawndist`='0' WHERE `id`='14267';

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(SELECT `guid` FROM `creature` WHERE `id`='14267');
DELETE FROM `creature_movement_template` WHERE `entry`='14267';
INSERT INTO `creature_movement_template` VALUES
('14267', @POINT := @POINT + '1', '-4939.537', '-3988.177', '297.6642', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4934.412', '-3956.615', '299.3215', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4930.901', '-3929.371', '300.8730', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4947.590', '-3919.897', '304.7906', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4964.144', '-3915.315', '304.2408', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4979.532', '-3920.973', '306.6892', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4992.262', '-3902.353', '304.6826', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4966.503', '-3892.559', '308.4520', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4938.917', '-3897.534', '306.8287', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4922.351', '-3899.447', '304.1685', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4902.495', '-3875.902', '301.9054', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4901.661', '-3855.753', '303.3250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4894.049', '-3836.621', '303.6957', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4882.614', '-3858.981', '303.0668', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4882.659', '-3888.173', '303.5529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4876.704', '-3915.521', '303.2025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4866.463', '-3938.079', '303.7190', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4866.313', '-3951.324', '303.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4870.636', '-3979.350', '299.5655', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4885.615', '-3994.896', '298.7455', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4907.389', '-3993.521', '297.6739', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4933.758', '-3980.665', '298.4330', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4953.597', '-4002.146', '299.0535', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14267', @POINT := @POINT + '1', '-4983.443', '-4009.711', '299.5536', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature_template` SET `SpeedWalk`='1.388888', `Rank`='2', `DamageMultiplier`='1.7', `MinMeleeDmg`='25.8', `MaxMeleeDmg`='34.4', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='60', `RangedAttackPower`='3', `MeleeBaseAttackTime`='2000' WHERE `Entry`='5830';

UPDATE `creature` SET `modelid`='0', `position_x`='578.5403', `position_y`='-1335.659', `position_z`='92.83743', `spawndist`='0', `MovementType`='2' WHERE `id`='5830';

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(SELECT `guid` FROM `creature` WHERE `id`='5830');
DELETE FROM `creature_movement_template` WHERE `entry`='5830';
INSERT INTO `creature_movement_template` VALUES
('5830', @POINT := @POINT + '1', '591.0984', '-1326.512', '92.29165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '605.8834', '-1321.843', '91.79165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '624.9481', '-1316.583', '91.79165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '643.6866', '-1307.641', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '668.6307', '-1300.918', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '692.3193', '-1303.288', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '718.7735', '-1311.100', '91.85694', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '742.3602', '-1321.819', '92.64588', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '754.9189', '-1329.235', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '761.7515', '-1348.345', '91.72881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '758.3610', '-1361.865', '91.72881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '746.0123', '-1375.537', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '722.1871', '-1385.720', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '699.2408', '-1382.385', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '686.0149', '-1369.511', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '675.7952', '-1361.891', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '665.3279', '-1355.352', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '652.1882', '-1344.566', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '636.4287', '-1334.760', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '628.5359', '-1323.144', '91.79165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '623.6190', '-1314.026', '91.79165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '615.4075', '-1298.601', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '604.1143', '-1284.030', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '587.8508', '-1269.006', '92.06193', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '576.0312', '-1259.969', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '560.8948', '-1256.678', '92.04676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '545.4825', '-1255.181', '91.87135', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '534.8517', '-1253.385', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '526.5915', '-1260.618', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '510.4008', '-1285.216', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '510.3910', '-1306.537', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '515.1241', '-1321.950', '91.79163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '521.8954', '-1336.838', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '529.7821', '-1343.760', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '556.7917', '-1356.994', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '567.0636', '-1368.908', '91.79165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '574.6062', '-1382.896', '91.79165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '578.4109', '-1399.870', '93.36684', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '584.3145', '-1420.103', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '588.7415', '-1440.735', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '577.5681', '-1461.407', '92.66666', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '567.4086', '-1473.391', '92.44877', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '555.5693', '-1487.626', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '538.3452', '-1499.215', '93.13493', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '517.2163', '-1501.068', '94.51033', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '492.0973', '-1496.377', '94.32227', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '474.5859', '-1480.677', '93.07898', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '464.5303', '-1462.176', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '460.6976', '-1444.193', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '466.9402', '-1424.123', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '470.6940', '-1413.053', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '482.4163', '-1399.121', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '502.0721', '-1380.881', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '527.9912', '-1362.113', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '542.1295', '-1349.177', '91.79166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '562.3475', '-1341.453', '91.87980', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5830', @POINT := @POINT + '1', '578.5403', '-1335.659', '92.83743', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature_template` SET `ModelId1`='3188', `FactionAlliance`='72', `FactionHorde`='72', `Scale`='0', `UnitFlags`='64', `DamageMultiplier`='1.25', `MinMeleeDmg`='62.4', `MaxMeleeDmg`='82.7', `MeleeAttackPower`='152', `RangedAttackPower`='15', `MeleeBaseAttackTime`='2000', `MovementType`='1', `AIName`='EventAI' WHERE `Entry`='14491';

UPDATE `creature` SET `modelid`='0', `position_x`='-13769.472', `position_y`='-210.8100', `position_z`='28.15880', `orientation`='1.6824140', `MovementType`='2' WHERE `guid`='49126';

DELETE FROM `creature` WHERE `guid` BETWEEN '134210' AND '134219';
DELETE FROM `pool_creature_template` WHERE `id`='14491';
DELETE FROM `pool_template` WHERE `entry`='1120';

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(SELECT `guid` FROM `creature` WHERE `id`='14491');
DELETE FROM `creature_movement_template` WHERE `entry`='14491';
INSERT INTO `creature_movement_template` VALUES
('14491', @POINT := @POINT + '1', '-13771.36', '-194.1479', '23.58299', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13800.65', '-171.2549', '16.75194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13825.32', '-138.9485', '17.06193', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13839.20', '-104.7389', '15.74479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13854.54', '-89.10059', '16.51101', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13880.08', '-68.98720', '22.91978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13884.61', '-54.92849', '27.63699', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13903.91', '-29.40885', '29.51131', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13907.90', '-7.800998', '27.44344', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13917.54', '25.832030', '15.02404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13918.52', '50.220270', '15.45375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13935.58', '86.903320', '15.89105', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13958.01', '96.246320', '15.29974', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13977.52', '107.88300', '13.94238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13996.92', '126.20390', '14.47534', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-14008.00', '152.99420', '13.52247', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-14009.72', '182.66020', '13.35314', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-14022.42', '197.13040', '13.20641', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-14057.04', '213.87030', '13.23114', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-14022.42', '197.13040', '13.20641', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-14009.72', '182.66020', '13.35314', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-14008.00', '152.99420', '13.52247', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13996.92', '126.20390', '14.47534', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13977.52', '107.88300', '13.94238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13958.01', '96.246320', '15.29974', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13935.58', '86.903320', '15.89105', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13918.52', '50.220270', '15.45375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13917.63', '26.220700', '14.77404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13907.90', '-7.800998', '27.44344', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13903.91', '-29.40885', '29.51131', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13884.61', '-54.92849', '27.63699', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13880.08', '-68.98720', '22.91978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13854.54', '-89.10059', '16.51101', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13839.20', '-104.7389', '15.74479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13825.32', '-138.9485', '17.06193', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13800.65', '-171.2549', '16.75194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13771.36', '-194.1479', '23.58299', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14491', @POINT := @POINT + '1', '-13768.64', '-210.9160', '28.39240', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_ai_scripts` WHERE `creature_id`='14491';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
('1449101', '14491', '2', '0', '100', '1', '20', '0', '180000', '180000', '11', '8599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Kurmokk - Enrage');


DELETE FROM `creature_template_spells` WHERE `entry`='14401';
INSERT INTO `creature_template_spells` (`entry`, `spell1`, `spell2`, `spell3`, `spell4`) VALUES
('14401', '22968', '0', '0', '0');

UPDATE `creature_template` SET `DamageMultiplier`='4.1', `ArmorMultiplier`='1.25', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='140.3', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='5093', `MeleeAttackPower`='258', `RangedAttackPower`='28', `MeleeBaseAttackTime`='2000' WHERE `Entry`='6560';

-- ----------------------------------------------------------------------------------------------------------------------------------

SET @GUID := '24431';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-6744.571', `position_y`='-1077.546', `position_z`='-268.5274', `orientation`='1.361357', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '-6711.656', '-1108.708', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6682.979', '-1108.199', '-271.1924', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6651.713', '-1113.189', '-267.5897', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6619.104', '-1088.037', '-270.9252', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6588.510', '-1053.210', '-271.9723', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6586.182', '-1015.168', '-270.7180', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6584.640', '-986.2390', '-269.9778', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6555.813', '-956.9913', '-271.6791', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6525.006', '-926.4108', '-271.0986', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6489.867', '-917.7697', '-274.0823', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6455.813', '-888.3906', '-274.5465', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6450.829', '-852.9542', '-270.7776', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6480.448', '-814.0076', '-270.4459', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6485.567', '-782.8757', '-272.1277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6512.534', '-750.5513', '-270.0567', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6516.315', '-720.3055', '-272.0823', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6487.937', '-683.9786', '-271.9155', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6481.567', '-653.4081', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6468.971', '-634.2039', '-269.6146', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6484.428', '-612.2490', '-272.0045', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6491.592', '-581.8387', '-269.6660', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6484.428', '-612.2490', '-272.0045', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6468.971', '-634.2039', '-269.6146', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6481.567', '-653.4081', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6487.937', '-683.9786', '-271.9155', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6516.315', '-720.3055', '-272.0823', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6512.534', '-750.5513', '-270.0567', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6485.567', '-782.8757', '-272.1277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6480.448', '-814.0076', '-270.4459', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6450.829', '-852.9542', '-270.7776', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6455.813', '-888.3906', '-274.5465', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6489.867', '-917.7697', '-274.0823', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6525.006', '-926.4108', '-271.0986', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6555.813', '-956.9913', '-271.6791', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6584.640', '-986.2390', '-269.9778', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6586.182', '-1015.168', '-270.7180', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6588.510', '-1053.210', '-271.9723', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6619.104', '-1088.037', '-270.9252', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6651.713', '-1113.189', '-267.5897', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6682.979', '-1108.199', '-271.1924', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6711.656', '-1108.708', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6743.542', '-1076.250', '-276.2250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- ----------------------------------------------------------------------------------------------------------------------------------

SET @GUID := '24425';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-6874.849', `position_y`='-1459.312', `position_z`='-272.1708', `orientation`='5.497643', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '-6851.878', '-1482.292', '-271.4614', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6817.788', '-1485.854', '-271.5074', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6783.627', '-1513.602', '-272.1169', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6750.147', '-1516.210', '-271.5523', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6715.845', '-1549.696', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6687.260', '-1552.257', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6679.914', '-1578.100', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6652.870', '-1586.599', '-271.6429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6624.472', '-1596.196', '-271.9393', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6607.181', '-1579.626', '-271.8143', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6584.481', '-1582.995', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6552.275', '-1581.677', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6518.662', '-1552.166', '-271.6872', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6482.581', '-1584.299', '-273.8513', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6450.570', '-1615.578', '-274.2537', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6419.396', '-1613.630', '-271.6156', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6385.435', '-1615.773', '-271.9722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6355.984', '-1586.887', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6351.242', '-1549.959', '-270.9722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6325.322', '-1518.390', '-269.7968', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6308.345', '-1484.733', '-269.5082', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6325.322', '-1518.390', '-269.7968', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6351.242', '-1549.959', '-270.9722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6355.984', '-1586.887', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6385.435', '-1615.773', '-271.9722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6419.396', '-1613.630', '-271.6156', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6450.570', '-1615.578', '-274.2537', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6482.581', '-1584.299', '-273.8513', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6518.662', '-1552.166', '-271.6872', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6552.275', '-1581.677', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6584.481', '-1582.995', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6607.181', '-1579.626', '-271.8143', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6624.472', '-1596.196', '-271.9393', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6652.870', '-1586.599', '-271.6429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6679.914', '-1578.100', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6687.260', '-1552.257', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6715.845', '-1549.696', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6750.147', '-1516.210', '-271.5523', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6783.627', '-1513.602', '-272.1169', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6817.788', '-1485.854', '-271.5074', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6851.878', '-1482.292', '-271.4614', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6876.223', '-1457.582', '-272.3776', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- ----------------------------------------------------------------------------------------------------------------------------------

SET @GUID := '24432';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-6891.165', `position_y`='-1422.5', `position_z`='-271.0223', `orientation`='0.2617994', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '-6886.211', '-1385.538', '-271.8830', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6913.807', '-1382.579', '-276.1308', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6943.412', '-1353.450', '-272.1136', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6919.776', '-1314.213', '-276.0858', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6945.720', '-1285.219', '-275.4511', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6950.577', '-1251.383', '-274.3698', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6949.858', '-1221.387', '-271.9329', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6969.786', '-1220.096', '-274.8842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6986.175', '-1187.529', '-274.4135', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7021.282', '-1156.061', '-275.7023', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7001.495', '-1134.193', '-276.1000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6979.710', '-1116.048', '-275.5695', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6951.801', '-1085.102', '-271.7148', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6916.178', '-1084.084', '-273.0026', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6882.856', '-1084.194', '-276.2250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6851.495', '-1082.112', '-276.2250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6817.052', '-1084.354', '-276.1054', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6788.648', '-1081.910', '-276.2250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6755.470', '-1086.097', '-276.2250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6722.536', '-1111.396', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6755.470', '-1086.097', '-276.2250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6788.648', '-1081.910', '-276.2250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6817.052', '-1084.354', '-276.1054', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6851.495', '-1082.112', '-276.2250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6882.856', '-1084.194', '-276.2250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6916.178', '-1084.084', '-273.0026', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6951.801', '-1085.102', '-271.7148', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6979.710', '-1116.048', '-275.5695', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7001.495', '-1134.193', '-276.1000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7021.282', '-1156.061', '-275.7023', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6986.175', '-1187.529', '-274.4135', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6969.786', '-1220.096', '-274.8842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6949.858', '-1221.387', '-271.9329', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6950.577', '-1251.383', '-274.3698', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6945.720', '-1285.219', '-275.4511', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6919.776', '-1314.213', '-276.0858', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6943.412', '-1353.450', '-272.1136', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6913.807', '-1382.579', '-276.1308', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6886.211', '-1385.538', '-271.8830', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6890.979', '-1418.999', '-273.0072', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- ----------------------------------------------------------------------------------------------------------------------------------

SET @GUID := '24427';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-6925.257', `position_y`='-2079.8', `position_z`='-271.8733', `orientation`='1.008164', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '-6908.143', '-2052.634', '-271.3118', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6909.474', '-2016.580', '-270.3705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6913.665', '-1985.028', '-269.6525', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6910.982', '-1952.316', '-271.1199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6919.143', '-1921.936', '-272.0674', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6917.963', '-1886.380', '-271.9283', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6921.425', '-1857.059', '-270.9354', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6891.077', '-1825.559', '-271.0610', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6908.075', '-1794.692', '-269.1186', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6914.038', '-1757.281', '-272.2008', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6940.097', '-1722.657', '-272.1147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6951.734', '-1688.477', '-271.8495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6950.760', '-1653.570', '-272.0905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6977.597', '-1620.255', '-273.2445', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6978.897', '-1579.373', '-275.0939', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6982.229', '-1544.668', '-275.3087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6946.721', '-1516.982', '-275.3710', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6914.174', '-1484.285', '-276.1518', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6888.010', '-1450.262', '-274.3786', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6895.103', '-1416.950', '-273.8961', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6888.010', '-1450.262', '-274.3786', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6914.174', '-1484.285', '-276.1518', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6946.660', '-1516.894', '-275.5150', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6982.229', '-1544.668', '-275.3087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6978.897', '-1579.373', '-275.0939', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6977.597', '-1620.255', '-273.2445', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6950.760', '-1653.570', '-272.0905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6951.734', '-1688.477', '-271.8495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6940.097', '-1722.657', '-272.1147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6914.038', '-1757.281', '-272.2008', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6908.075', '-1794.692', '-269.1186', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6891.077', '-1825.559', '-271.0610', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6921.425', '-1857.059', '-270.9354', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6917.963', '-1886.380', '-271.9283', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6919.143', '-1921.936', '-272.0674', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6910.982', '-1952.316', '-271.1199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6913.665', '-1985.028', '-269.6525', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6909.474', '-2016.580', '-270.3705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6908.143', '-2052.634', '-271.3118', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6922.595', '-2080.379', '-271.8986', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- ----------------------------------------------------------------------------------------------------------------------------------

SET @GUID := '24428';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-7301.554', `position_y`='-2279.127', `position_z`='-267.213', `orientation`='6.10646', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '-7282.325', '-2282.561', '-266.7482', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7254.710', '-2283.785', '-270.0211', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7221.588', '-2279.380', '-270.3090', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7178.518', '-2279.097', '-269.4742', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7151.030', '-2282.101', '-267.7916', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7122.478', '-2288.068', '-267.1912', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7092.300', '-2287.877', '-268.1418', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7060.814', '-2283.320', '-269.5229', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7036.783', '-2277.972', '-269.8832', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7015.984', '-2262.911', '-270.7254', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7000.760', '-2241.408', '-271.3663', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6986.168', '-2210.889', '-269.6000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6974.682', '-2182.026', '-270.9774', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6970.170', '-2147.299', '-272.9504', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6974.772', '-2112.625', '-272.0025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6971.613', '-2086.302', '-271.4291', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6970.653', '-2044.799', '-271.4677', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6971.613', '-2086.302', '-271.4291', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6974.772', '-2112.625', '-272.0025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6970.160', '-2147.295', '-272.9382', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6974.672', '-2182.021', '-271.0568', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-6986.115', '-2210.842', '-269.6117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7000.760', '-2241.408', '-271.3663', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7015.984', '-2262.911', '-270.7254', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7036.783', '-2277.972', '-269.8832', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7060.814', '-2283.320', '-269.5229', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7092.300', '-2287.877', '-268.1418', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7122.478', '-2288.068', '-267.1912', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7151.030', '-2282.101', '-267.7916', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7178.518', '-2279.097', '-269.4742', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7221.588', '-2279.380', '-270.3090', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7254.710', '-2283.785', '-270.0211', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7282.325', '-2282.561', '-266.7482', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7299.705', '-2279.417', '-267.0243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- ----------------------------------------------------------------------------------------------------------------------------------

SET @GUID := '24426';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-7706.32', `position_y`='-2139.49', `position_z`='-268.4008', `orientation`='5.41768', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '-7690.299', '-2158.309', '-272.1707', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7683.585', '-2171.203', '-270.0922', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7671.823', '-2187.010', '-269.5380', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7653.816', '-2202.189', '-269.7295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7627.557', '-2221.542', '-270.7054', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7596.835', '-2220.911', '-272.1502', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7570.771', '-2222.122', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7530.580', '-2222.668', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7514.868', '-2230.510', '-271.7750', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7500.882', '-2237.000', '-270.8737', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7478.713', '-2249.222', '-271.3842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7458.290', '-2262.415', '-269.5457', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7440.160', '-2270.738', '-269.5778', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7415.043', '-2275.460', '-269.5153', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7389.215', '-2278.059', '-269.5160', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7365.116', '-2280.731', '-269.6332', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7323.948', '-2293.510', '-269.2842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7365.116', '-2280.731', '-269.6332', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7389.215', '-2278.059', '-269.5160', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7415.043', '-2275.460', '-269.5153', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7440.160', '-2270.738', '-269.5778', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7458.290', '-2262.415', '-269.5457', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7478.713', '-2249.222', '-271.3842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7500.882', '-2237.000', '-270.8737', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7514.868', '-2230.510', '-271.7750', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7530.580', '-2222.668', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7570.771', '-2222.122', '-272.0972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7596.835', '-2220.911', '-272.1502', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7627.557', '-2221.542', '-270.7054', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7653.816', '-2202.189', '-269.7295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7671.823', '-2187.010', '-269.5380', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7683.585', '-2171.203', '-270.0922', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7690.299', '-2158.309', '-272.1707', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7705.927', '-2141.799', '-267.8692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- ----------------------------------------------------------------------------------------------------------------------------------

SET @GUID := '24429';
SET @POINT := '0';

UPDATE `creature` SET `modelid`='0', `position_x`='-7882.646', `position_y`='-2083.102', `position_z`='-269.6619', `orientation`='0.1195567', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '-7838.250', '-2077.800', '-272.2795', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7823.158', '-2075.188', '-274.5982', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7794.592', '-2090.528', '-269.7422', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7752.852', '-2080.029', '-272.1380', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7704.335', '-2075.953', '-273.4637', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7668.208', '-2085.918', '-272.1127', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7651.125', '-2116.191', '-272.0373', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7680.606', '-2151.196', '-271.8611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7683.385', '-2182.313', '-268.7267', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7655.787', '-2201.760', '-269.7295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7636.090', '-2222.606', '-269.4544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7607.408', '-2224.891', '-271.1236', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7636.090', '-2222.606', '-269.4544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7655.787', '-2201.760', '-269.7295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7683.385', '-2182.313', '-268.7267', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7680.606', '-2151.196', '-271.8611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7651.125', '-2116.191', '-272.0373', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7668.208', '-2085.918', '-272.1127', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7704.335', '-2075.953', '-273.4637', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7752.792', '-2080.038', '-272.0536', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7794.592', '-2090.528', '-269.7422', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7823.158', '-2075.188', '-274.5982', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7838.250', '-2077.800', '-272.2795', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '-7871.755', '-2086.252', '-270.9144', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `spell_target_position` WHERE `id`='26220';
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`)
VALUES ('26220', '531', '-8563.56', '2040.69', '-97', '4.9426');

UPDATE `quest_template` SET `PrevQuestId`='8461' WHERE `entry`='8467';

UPDATE `creature` SET `modelid`='0', `spawndist`='0', `MovementType`='0' WHERE `id`='11516';

SET @GUID := '39359';
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='6998.405', `position_y`='-2124.38', `position_z`='589.217', `orientation`='0', `MovementType`='2' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`='11558';
INSERT INTO `creature_movement_template` VALUES
('11558', @POINT := @POINT + '1', '7031.818', '-2119.087', '586.5599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('11558', @POINT := @POINT + '1', '7049.333', '-2116.203', '586.4012', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('11558', @POINT := @POINT + '1', '7059.674', '-2115.573', '586.4418', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('11558', @POINT := @POINT + '1', '7085.175', '-2116.508', '582.4188', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('11558', @POINT := @POINT + '1', '7059.865', '-2115.562', '586.5015', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('11558', @POINT := @POINT + '1', '7049.333', '-2116.203', '586.4012', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('11558', @POINT := @POINT + '1', '7031.818', '-2119.087', '586.5679', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('11558', @POINT := @POINT + '1', '7000.174', '-2123.915', '588.5158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @GUID := '39685';
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='7025.413', `position_y`='-2129.193', `position_z`='605.0363', `orientation`='1.291544', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '7022.205', '-2154.976', '594.6618', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7022.062', '-2176.411', '592.7449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7005.899', '-2190.952', '587.4102', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6993.098', '-2203.730', '586.9760', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6985.287', '-2222.637', '583.5713', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6978.516', '-2237.384', '582.9865', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6972.774', '-2252.150', '584.3915', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6963.883', '-2262.671', '587.7775', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6938.069', '-2262.126', '589.8793', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6916.303', '-2284.507', '589.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6938.069', '-2262.126', '589.8793', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6963.745', '-2262.835', '587.8318', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6972.690', '-2252.366', '584.4597', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6978.516', '-2237.384', '582.9865', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6985.287', '-2222.637', '583.5713', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6993.098', '-2203.730', '586.9760', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7005.899', '-2190.952', '587.4102', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7022.062', '-2176.411', '592.7449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7022.205', '-2154.976', '594.6618', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7025.473', '-2127.168', '602.7562', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @GUID := '39721';
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='6831.052', `position_y`='-2105.397', `position_z`='625.7256', `orientation`='5.870968', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '6861.227', '-2118.594', '624.9129', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6872.077', '-2119.138', '621.5582', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6889.064', '-2104.111', '618.3158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6904.970', '-2087.587', '616.8079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6931.437', '-2081.785', '615.0275', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6949.078', '-2077.913', '612.6089', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6973.942', '-2077.549', '609.5292', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6992.606', '-2068.745', '607.9701', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7003.582', '-2069.158', '608.5594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7013.248', '-2074.656', '605.4859', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7018.258', '-2092.183', '601.7110', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7020.412', '-2103.148', '601.8949', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7025.168', '-2115.448', '604.9564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7020.412', '-2103.148', '601.8949', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7018.258', '-2092.183', '601.7110', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7013.248', '-2074.656', '605.4859', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7003.582', '-2069.158', '608.5594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6992.825', '-2068.754', '607.9570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6973.942', '-2077.549', '609.5292', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6949.078', '-2077.913', '612.6089', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6931.437', '-2081.785', '615.0275', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6904.970', '-2087.587', '616.8079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6889.150', '-2104.021', '618.3832', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6872.077', '-2119.138', '621.5582', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6861.416', '-2118.674', '624.6057', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '6828.422', '-2103.566', '626.0240', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @GUID := '39360';
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='7098.979', `position_y`='-2133.087', `position_z`='583.0118', `orientation`='0.8901179', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '7095.828', '-2121.545', '579.1931', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7081.223', '-2115.833', '583.0578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7064.823', '-2116.140', '585.7307', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7047.048', '-2116.423', '586.3578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7024.865', '-2120.003', '586.5849', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7046.836', '-2116.457', '586.3970', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7064.598', '-2116.144', '585.7569', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7081.223', '-2115.833', '583.0578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7095.828', '-2121.545', '579.1931', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7098.671', '-2134.876', '575.7117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @GUID := '39354';
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='7262.518', `position_y`='-2183.3', `position_z`='557.6961', `orientation`='3.945828', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '7252.949', '-2193.239', '560.9904', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7236.648', '-2193.185', '564.5721', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7215.199', '-2189.851', '565.7800', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7198.736', '-2188.620', '565.3500', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7183.260', '-2183.077', '566.4570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7165.008', '-2165.219', '565.8566', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7142.976', '-2161.157', '566.7985', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7120.088', '-2156.991', '568.0010', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7104.307', '-2151.730', '571.6407', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7098.696', '-2136.954', '575.3649', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7104.307', '-2151.730', '571.6407', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7120.088', '-2156.991', '568.0010', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7142.976', '-2161.157', '566.7985', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7165.008', '-2165.219', '565.8566', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7183.260', '-2183.077', '566.4570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7198.736', '-2188.620', '565.3500', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7215.199', '-2189.851', '565.7800', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7236.648', '-2193.185', '564.5721', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7252.917', '-2193.272', '561.0329', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7262.740', '-2183.327', '557.5908', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

SET @GUID := '39353';
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='7379.257', `position_y`='-2205.77', `position_z`='535.443', `orientation`='3.641864', `spawndist`='0', `MovementType`='2' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` VALUES
(@GUID, @POINT := @POINT + '1', '7366.813', '-2205.410', '536.4895', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7347.722', '-2200.018', '535.3674', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7327.252', '-2194.810', '537.0091', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7319.292', '-2188.173', '539.6313', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7316.772', '-2171.578', '543.1376', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7312.691', '-2157.716', '546.9731', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7300.049', '-2151.267', '549.9345', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7284.350', '-2149.601', '553.5342', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7274.504', '-2160.827', '557.1345', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7262.698', '-2180.895', '557.1959', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7274.458', '-2160.906', '557.1588', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7283.938', '-2149.754', '553.5929', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7300.049', '-2151.267', '549.9345', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7312.691', '-2157.716', '546.9731', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7316.772', '-2171.578', '543.1376', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7319.292', '-2188.173', '539.6313', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7327.252', '-2194.810', '537.0091', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7347.710', '-2200.015', '535.3946', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7366.664', '-2205.368', '536.4964', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '7381.741', '-2204.716', '534.7780', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature_template_classlevelstats` SET `BaseDamageExp0`='31.837' WHERE `Level`='61' and`Class`='2';

SET @GUID := (SELECT  `guid` FROM `creature` WHERE `id`='14278');
SET @POINT := '0';
UPDATE `creature_template` SET `SpeedWalk`='1.2', `MinMeleeDmg`='39.3', `MaxMeleeDmg`='52.1', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='96', `RangedAttackPower`='8', `MeleeBaseAttackTime`='2000', `MovementType`='1' WHERE `Entry`='14278';
UPDATE `creature` SET `modelid`='0', `position_x`='-883.28', `position_y`='-1036.26', `position_z`='30.49453', `orientation`='3.344934', `MovementType`='2' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`='14278';
INSERT INTO `creature_movement_template` VALUES
('14278', @POINT := @POINT + '1', '-899.7490', '-1039.656', '30.37254', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14278', @POINT := @POINT + '1', '-925.4506', '-1045.888', '30.47285', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14278', @POINT := @POINT + '1', '-956.1846', '-1014.903', '30.77754', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14278', @POINT := @POINT + '1', '-954.6239', '-983.0110', '30.47286', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14278', @POINT := @POINT + '1', '-943.6620', '-964.6547', '30.45305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14278', @POINT := @POINT + '1', '-922.4212', '-948.1688', '31.49447', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14278', @POINT := @POINT + '1', '-901.6521', '-959.9968', '30.36947', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14278', @POINT := @POINT + '1', '-879.9400', '-972.8907', '30.47107', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14278', @POINT := @POINT + '1', '-869.3699', '-999.7962', '30.47107', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('14278', @POINT := @POINT + '1', '-879.4504', '-1032.248', '30.47285', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- Ancient Protector
SET @GUID := '49857';
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='9983.682', `position_y`='2045.124', `position_z`='1328.656', `orientation`='2.194992' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, @POINT := @POINT + '1', '9961.919', '2075.339', '1328.544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9965.915', '2090.447', '1329.121', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9966.134', '2106.592', '1328.414', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9965.078', '2125.257', '1328.769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9968.492', '2155.663', '1329.175', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9968.492', '2155.663', '1329.175', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '4.694936', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9942.159', '2158.076', '1328.208', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9942.159', '2158.076', '1328.208', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '4.747295', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9940.522', '2121.686', '1328.219', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9940.983', '2097.813', '1328.715', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9935.438', '2072.527', '1328.721', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9953.167', '2042.370', '1329.106', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9953.167', '2042.370', '1329.106', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0.08726646', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9983.079', '2046.026', '1328.544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@GUID, @POINT := @POINT + '1', '9983.079', '2046.026', '1328.544', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '4.677482', '0', '0');

-- Huntress Skymane
SET @ENTRY := '14378';
SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@ENTRY);
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='9937.492', `position_y`='2509.925', `position_z`='1317.899', `orientation`='4.250524' WHERE `guid`='46216';
DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@ENTRY;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@ENTRY, @POINT := @POINT + '1', '9934.845', '2504.607', '1317.881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9933.505', '2502.286', '1317.881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9931.775', '2500.849', '1317.921', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9929.057', '2500.652', '1317.997', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9918.979', '2508.099', '1317.511', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9917.283', '2509.890', '1317.308', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9915.525', '2521.381', '1317.148', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9914.626', '2523.595', '1316.932', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9913.533', '2525.348', '1316.690', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9907.015', '2533.012', '1316.177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9905.482', '2533.702', '1315.972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9903.213', '2534.096', '1315.589', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9896.527', '2534.522', '1316.006', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9886.226', '2534.427', '1318.751', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9854.982', '2533.488', '1320.892', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9825.171', '2532.564', '1321.052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9789.950', '2531.943', '1319.854', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9776.548', '2531.544', '1318.925', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9769.356', '2531.154', '1320.454', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9767.588', '2531.534', '1321.087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9764.525', '2532.300', '1322.156', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9736.575', '2537.274', '1331.960', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9726.991', '2538.126', '1335.331', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9723.632', '2540.354', '1335.677', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9721.653', '2542.902', '1335.677', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9710.676', '2562.697', '1335.675', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9691.403', '2586.067', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9666.763', '2605.763', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9663.600', '2607.967', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9661.927', '2610.403', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9661.103', '2613.186', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9659.822', '2627.531', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9658.547', '2628.941', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9654.964', '2629.389', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9652.197', '2626.193', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9652.265', '2623.642', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9653.908', '2602.251', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9654.321', '2600.849', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9656.183', '2598.450', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9661.168', '2596.108', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9663.255', '2594.923', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9665.192', '2593.212', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9683.416', '2575.189', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9702.045', '2556.368', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9711.033', '2542.860', '1335.680', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9712.059', '2513.477', '1335.680', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9709.944', '2499.129', '1335.678', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9686.857', '2471.142', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9661.401', '2446.295', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9659.697', '2443.971', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9658.896', '2441.078', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9658.383', '2437.548', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9654.817', '2413.695', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9655.167', '2410.476', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9656.116', '2408.800', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9660.053', '2406.618', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9662.481', '2407.192', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9664.225', '2408.921', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9665.176', '2411.423', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9665.354', '2414.144', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9664.271', '2432.980', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9665.229', '2435.956', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9695.222', '2463.222', '1335.677', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9713.304', '2489.688', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9719.495', '2512.306', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9720.287', '2513.848', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9722.419', '2515.672', '1335.676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9729.856', '2518.506', '1334.586', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9735.124', '2520.266', '1332.734', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9736.726', '2520.529', '1332.167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9766.791', '2522.688', '1321.450', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9776.266', '2523.301', '1318.891', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9807.236', '2524.392', '1320.614', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9827.915', '2524.931', '1321.114', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9852.384', '2525.862', '1321.083', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9878.071', '2526.711', '1319.323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9894.906', '2529.189', '1316.535', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9909.726', '2533.668', '1316.378', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9910.847', '2535.159', '1316.365', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9913.321', '2539.019', '1316.662', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9922.596', '2545.774', '1317.307', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9939.886', '2553.770', '1316.844', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9944.878', '2555.716', '1316.444', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9946.142', '2555.788', '1316.317', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9970.481', '2541.573', '1316.552', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9982.519', '2526.076', '1316.408', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9983.063', '2524.382', '1316.468', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9982.894', '2522.087', '1316.488', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9978.963', '2519.387', '1317.085', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9968.582', '2510.826', '1317.692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9966.939', '2506.628', '1317.386', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9964.396', '2498.458', '1316.622', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9963.428', '2496.605', '1316.495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9961.617', '2494.321', '1316.544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.460', '2481.621', '1316.245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.141', '2478.519', '1316.245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.900', '2444.029', '1323.012', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9950.918', '2406.309', '1328.163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9951.813', '2372.257', '1330.051', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9952.048', '2347.561', '1330.745', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9953.081', '2310.857', '1336.548', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9953.782', '2289.469', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9953.672', '2270.071', '1340.670', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9955.032', '2250.605', '1334.954', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9954.898', '2229.241', '1331.776', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9955.754', '2200.319', '1328.330', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9955.946', '2176.617', '1327.580', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9955.340', '2148.661', '1327.830', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9953.308', '2119.954', '1327.769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9957.024', '2095.751', '1327.801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9952.513', '2076.105', '1327.801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9952.513', '2073.932', '1327.801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9954.760', '2069.536', '1327.926', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9973.545', '2042.184', '1328.137', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9974.004', '2040.551', '1328.137', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9972.787', '2038.654', '1328.137', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9969.603', '2038.984', '1328.137', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9967.370', '2040.953', '1328.035', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9957.313', '2052.815', '1328.367', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9955.881', '2055.001', '1328.329', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9954.635', '2057.547', '1328.373', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9946.692', '2073.500', '1327.794', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9946.453', '2077.417', '1327.801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9951.131', '2094.519', '1327.801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9951.546', '2096.966', '1327.801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9951.196', '2099.706', '1327.801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9950.028', '2136.157', '1327.705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.285', '2181.962', '1327.603', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9948.413', '2224.646', '1330.972', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.032', '2253.350', '1335.409', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9950.259', '2270.027', '1340.687', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.621', '2288.903', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9948.974', '2311.088', '1336.548', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9947.622', '2346.411', '1330.760', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9947.481', '2372.315', '1330.039', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9947.573', '2406.613', '1328.108', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9946.794', '2444.887', '1322.822', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9947.043', '2473.771', '1316.543', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9946.339', '2481.540', '1316.245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9943.713', '2484.507', '1316.515', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9941.126', '2486.058', '1316.745', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9933.913', '2491.383', '1317.766', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9933.145', '2494.476', '1317.902', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9933.655', '2496.918', '1317.870', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9936.654', '2504.626', '1317.881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9937.353', '2506.569', '1317.881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9936.716', '2507.736', '1317.881', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

-- Huntress Ravenoak
SET @ENTRY := '14379';
SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@ENTRY);
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='10130.43', `position_y`='2577.263', `position_z`='1324.224', `orientation`='5.441463', `spawndist`='0' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@ENTRY;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@ENTRY, @POINT := @POINT + '1', '10141.19', '2565.228', '1321.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10142.36', '2562.295', '1321.798', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10143.79', '2553.874', '1321.798', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10140.74', '2548.878', '1321.923', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10120.08', '2539.568', '1321.684', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10107.54', '2537.902', '1320.304', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10098.92', '2536.347', '1319.321', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10090.91', '2529.963', '1317.507', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10090.29', '2526.435', '1317.594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10099.54', '2510.198', '1317.763', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10108.54', '2492.170', '1317.602', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10109.87', '2483.666', '1317.563', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10104.17', '2464.978', '1317.459', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10105.29', '2454.704', '1318.763', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10106.12', '2442.883', '1318.861', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10104.32', '2411.591', '1316.345', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10098.77', '2392.371', '1316.550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10099.89', '2389.500', '1316.604', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10107.35', '2385.018', '1316.978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10115.67', '2379.915', '1317.353', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10127.53', '2374.583', '1319.478', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10133.71', '2372.879', '1320.352', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10142.16', '2372.354', '1321.360', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10152.84', '2371.748', '1323.194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10163.95', '2367.417', '1324.744', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10169.94', '2361.327', '1326.082', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10172.47', '2350.917', '1327.884', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10174.81', '2346.637', '1328.173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10182.47', '2339.694', '1328.039', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10185.93', '2333.111', '1327.829', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10186.51', '2328.583', '1327.898', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10181.39', '2314.363', '1327.830', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10170.86', '2294.655', '1327.872', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10155.12', '2273.715', '1328.549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10140.39', '2259.703', '1328.087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10131.01', '2249.278', '1327.739', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10126.19', '2246.830', '1327.705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10120.07', '2247.956', '1327.580', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10114.01', '2253.089', '1327.580', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10098.96', '2271.402', '1328.175', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10088.49', '2287.248', '1329.363', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10081.59', '2295.719', '1329.564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10075.93', '2295.842', '1329.488', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10067.78', '2290.903', '1329.488', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10055.84', '2285.361', '1329.468', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10035.52', '2280.124', '1328.993', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10019.12', '2281.627', '1335.943', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10009.49', '2282.591', '1341.057', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10001.86', '2282.778', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9974.475', '2279.730', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9958.831', '2279.625', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9954.916', '2282.523', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9950.621', '2289.635', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9948.640', '2298.739', '1338.218', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9948.245', '2316.274', '1336.548', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9947.918', '2327.039', '1334.304', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9946.038', '2352.682', '1330.656', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9944.608', '2386.319', '1329.331', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9942.545', '2429.390', '1325.195', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9943.560', '2456.695', '1320.440', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9945.888', '2478.355', '1316.335', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9945.462', '2483.710', '1316.209', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9941.516', '2488.427', '1316.874', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9934.638', '2492.629', '1317.829', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9931.781', '2496.816', '1317.902', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9923.838', '2505.300', '1318.094', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9918.912', '2507.741', '1317.503', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9915.424', '2512.410', '1317.085', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9914.591', '2520.892', '1316.923', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9910.341', '2527.942', '1316.421', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9909.560', '2533.262', '1316.421', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9912.560', '2537.834', '1316.571', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9924.190', '2546.505', '1317.251', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9941.216', '2553.063', '1316.754', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.143', '2553.751', '1316.442', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9955.251', '2548.693', '1316.787', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9961.833', '2545.140', '1316.981', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9968.583', '2541.928', '1316.862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9987.741', '2520.834', '1316.185', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9993.467', '2514.215', '1316.238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10002.20', '2510.385', '1316.525', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10012.16', '2506.149', '1319.015', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10031.35', '2500.337', '1318.437', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10036.81', '2500.605', '1318.422', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10051.14', '2508.172', '1318.381', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10062.54', '2514.762', '1320.093', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10074.39', '2521.597', '1319.614', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10084.52', '2527.638', '1317.594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10089.42', '2533.484', '1317.886', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10095.45', '2538.912', '1319.045', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10101.06', '2539.833', '1319.652', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10116.98', '2542.476', '1321.312', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10124.51', '2544.185', '1321.726', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10131.54', '2546.765', '1321.837', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10136.55', '2550.135', '1321.678', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10139.29', '2553.622', '1321.798', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10139.45', '2557.882', '1321.923', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10138.06', '2563.778', '1322.168', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10135.03', '2566.400', '1322.563', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10132.25', '2571.297', '1323.270', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10131.47', '2574.562', '1323.755', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '10133.98', '2573.481', '1323.259', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');
-- Updated NPC 5709 (Shade of Eranikus) in Sunken Temple: it is now unattackable
-- until Jammal'An is defeated
-- This closes #710 thanks at evilatwow for providing the details
-- Requires https://github.com/scriptdev2/scriptdev2-classic/commit/22f5d731089055c96bec77674be223bd18207f32
UPDATE `creature_template` SET `UnitFlags` = `UnitFlags` | 128 WHERE `Entry` = 5709;

-- Huntress Leafrunner
SET @ENTRY := '14380';
SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@ENTRY);
SET @POINT := '0';
UPDATE `creature` SET `modelid`='0', `position_x`='9629.786', `position_y`='2347.465', `position_z`='1327.814', `orientation`='6.15194', `spawndist`='0' WHERE `guid`=@GUID;
DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@ENTRY;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@ENTRY, @POINT := @POINT + '1', '9638.431', '2346.324', '1327.555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9642.419', '2345.290', '1327.555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9646.583', '2338.545', '1327.555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9651.487', '2331.639', '1327.608', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9657.660', '2327.231', '1327.608', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9666.333', '2319.357', '1327.700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9675.031', '2310.875', '1327.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9683.046', '2301.887', '1327.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9690.498', '2290.400', '1327.693', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9696.083', '2281.541', '1327.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9703.657', '2272.612', '1327.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9713.594', '2265.065', '1327.558', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9722.450', '2259.798', '1327.558', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9728.661', '2257.945', '1327.558', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9732.499', '2259.535', '1327.558', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9739.262', '2264.789', '1327.610', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9744.646', '2271.522', '1327.745', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9753.025', '2281.126', '1327.745', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9761.169', '2288.400', '1327.745', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9766.561', '2293.850', '1327.745', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9768.287', '2297.788', '1327.602', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9767.628', '2303.676', '1327.534', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9763.534', '2310.935', '1327.917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9758.542', '2320.253', '1328.392', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9752.692', '2329.334', '1328.729', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9746.058', '2335.501', '1328.771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9740.735', '2340.184', '1328.285', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9733.448', '2342.196', '1327.968', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9728.343', '2347.025', '1327.624', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9724.544', '2351.812', '1327.499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9719.772', '2357.380', '1327.499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9716.239', '2359.507', '1327.499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9713.919', '2358.900', '1327.499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9713.397', '2357.470', '1327.499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9715.076', '2355.188', '1327.499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9722.508', '2348.681', '1327.387', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9731.412', '2339.112', '1327.911', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9738.889', '2335.746', '1328.719', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9742.572', '2333.895', '1328.969', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9748.336', '2329.593', '1328.979', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9752.227', '2325.577', '1328.802', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9755.486', '2319.336', '1328.479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9756.311', '2314.428', '1328.285', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9760.533', '2310.068', '1327.979', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9762.571', '2305.798', '1327.908', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9771.149', '2298.075', '1327.395', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9779.689', '2289.906', '1327.500', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9783.950', '2287.094', '1327.588', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9791.250', '2283.944', '1327.716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9798.119', '2283.382', '1327.408', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9804.935', '2283.008', '1326.901', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9814.322', '2278.783', '1327.145', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9822.917', '2276.220', '1327.083', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9832.749', '2277.004', '1327.020', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9843.302', '2278.076', '1326.685', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9858.146', '2278.747', '1327.309', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9869.672', '2278.275', '1328.654', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9880.758', '2278.403', '1333.929', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9890.188', '2279.551', '1338.621', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9899.403', '2279.797', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9912.734', '2278.861', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9924.001', '2278.351', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9936.090', '2278.166', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9943.570', '2279.430', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9947.863', '2282.394', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.195', '2285.000', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.310', '2287.860', '1341.390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9949.212', '2293.424', '1341.014', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9948.451', '2304.298', '1336.548', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9948.394', '2313.227', '1336.548', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9948.185', '2323.522', '1335.337', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9947.305', '2336.464', '1331.538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9946.194', '2354.281', '1330.606', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9945.447', '2375.022', '1329.949', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9944.130', '2409.817', '1327.685', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9942.999', '2428.544', '1325.305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9942.942', '2447.719', '1322.232', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9944.978', '2470.112', '1317.458', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9946.156', '2480.067', '1316.245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9945.303', '2483.645', '1316.221', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9937.996', '2489.999', '1317.360', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9932.352', '2496.281', '1317.902', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9923.413', '2503.712', '1318.043', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9919.168', '2505.463', '1317.522', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9915.682', '2505.947', '1316.991', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9907.494', '2505.247', '1316.045', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9899.113', '2503.240', '1318.117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9888.548', '2501.814', '1317.874', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9882.413', '2498.562', '1315.876', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9878.960', '2494.411', '1315.862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9876.619', '2488.410', '1315.853', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9876.187', '2481.462', '1316.107', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9877.872', '2476.743', '1317.799', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9880.842', '2470.346', '1317.878', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9883.099', '2465.261', '1317.301', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9886.263', '2458.912', '1317.370', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9886.657', '2453.557', '1317.245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9883.715', '2439.952', '1316.120', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9878.992', '2428.082', '1316.381', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9863.950', '2399.860', '1316.916', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9850.006', '2376.192', '1316.352', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9843.149', '2368.845', '1315.745', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9840.700', '2365.624', '1316.859', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9837.719', '2360.185', '1316.715', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9838.506', '2348.590', '1314.842', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9839.290', '2340.451', '1314.305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9839.903', '2333.726', '1314.305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9839.616', '2321.726', '1315.656', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9839.226', '2310.679', '1318.187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9840.335', '2308.157', '1318.489', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9843.700', '2303.417', '1319.433', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9846.722', '2298.525', '1320.629', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9849.659', '2288.964', '1324.027', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9850.785', '2280.185', '1326.279', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9851.716', '2269.079', '1327.139', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9851.055', '2260.467', '1327.667', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9849.521', '2250.543', '1327.667', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9846.156', '2241.251', '1327.768', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9842.947', '2232.971', '1327.705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9838.708', '2226.465', '1327.705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9835.183', '2221.209', '1327.830', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9830.405', '2218.199', '1327.933', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9824.442', '2216.953', '1327.894', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9816.691', '2216.248', '1327.757', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9806.703', '2217.334', '1327.769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9798.703', '2220.233', '1327.714', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9791.346', '2224.926', '1327.681', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9781.249', '2231.720', '1327.705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9769.538', '2238.827', '1327.769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9759.598', '2244.793', '1327.735', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9747.959', '2250.432', '1327.610', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9739.264', '2255.175', '1327.610', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9727.248', '2261.617', '1327.558', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9719.518', '2265.091', '1327.558', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9712.614', '2270.799', '1327.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9704.029', '2278.192', '1327.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9698.979', '2283.580', '1327.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9696.374', '2289.908', '1327.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9690.615', '2298.115', '1327.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9681.883', '2308.396', '1327.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9673.433', '2317.446', '1327.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9667.442', '2324.237', '1327.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9662.449', '2327.011', '1327.608', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9658.771', '2330.163', '1327.608', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9650.278', '2338.987', '1327.555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9647.562', '2342.802', '1327.555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9644.049', '2347.352', '1327.555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9640.743', '2349.446', '1327.599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9636.612', '2349.854', '1327.769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9632.391', '2350.492', '1327.862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9630.265', '2349.638', '1327.884', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '9632.665', '2347.168', '1327.848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature_template` SET `FactionAlliance`='14', `FactionHorde`='14', `Scale`='0', `UnitFlags`='33554432', `SpeedRun`='0.75', `MinMeleeDmg`='103.9', `MaxMeleeDmg`='137.9', `MinRangedDmg`='0', `MaxRangedDmg`='0', `Armor`='3791', `MeleeAttackPower`='252', `RangedAttackPower`='26', `AIName`='EventAI' WHERE `Entry`='16129';

DELETE FROM `creature_ai_scripts` WHERE `creature_id`='16129';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
('1612901', '16129', '1', '0', '100', '0', '5000', '5000', '0', '0', '11', '27812', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Shadow Fissure - Void Blast');

UPDATE `creature_template` SET `AIName`='EventAI' WHERE `Entry`='16427';

DELETE FROM `creature_ai_scripts` WHERE `creature_id`='16427';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
('1642701', '16427', '11', '0', '100', '0', '0', '0', '0', '0', '11', '28458', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Soldier of the Frozen Wastes - Dark Blast');

DELETE FROM `creature_template` WHERE `entry` IN ('16783', '16784', '16785');
INSERT INTO `creature_template` (`Entry`, `Name`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `Civilian`, `AIName`) VALUES
('16783', 'Plague Slime (Blue)', '61', '61', '11139', '0', '21', '21', '0', '0', '10', '3', '3', '0', '0', '0', '0', '0', '8', '0.8', '0.285714', '1', '1', '45', '1', '1', '1', '1', '1', '141480', '141480', '0', '0', '2745', '2815', '172.1', '240.07', '4091', '1283', '100', '1150', '1265', '0', '6051', '7906', '16243', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ''),
('16784', 'Plague Slime (Red)', '61', '61', '681', '0', '21', '21', '0', '0', '10', '3', '3', '0', '0', '0', '0', '0', '8', '0.8', '0.285714', '1', '1', '45', '1', '1', '1', '1', '1', '141480', '141480', '0', '0', '2745', '2815', '172.1', '240.07', '4091', '1283', '100', '1150', '1265', '0', '6051', '7906', '16243', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', ''),
('16785', 'Plague Slime (Green)', '61', '61', '11137', '0', '21', '21', '0', '0', '10', '3', '3', '0', '0', '0', '0', '0', '8', '0.8', '0.285714', '1', '1', '45', '1', '1', '1', '1', '1', '141480', '141480', '0', '0', '2745', '2815', '172.1', '240.07', '4091', '1283', '100', '1150', '1265', '0', '6051', '7906', '16243', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '');

UPDATE `gameobject` SET `position_x`='2587.961', `position_y`='-3017.167', `position_z`='241.3043', `orientation`='3.141593', `rotation2`='-1', `rotation3`='0', `animprogress`='100' WHERE `guid`='21294';

UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15975';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15974';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16068';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16029';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16368';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16451';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16452';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='15976';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16027';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16127';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16145';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16163';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16164';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16146';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16400';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16165';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16390';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16017';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16449';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16446';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='16861';


UPDATE `creature` SET `modelid`='0', `position_x`='3086.039', `position_y`='-3386.805', `position_z`='298.4013', `orientation`='3.1764990' WHERE `guid`='88261';
UPDATE `creature` SET `modelid`='0', `position_x`='3054.923', `position_y`='-3356.802', `position_z`='298.4012', `orientation`='4.7298420' WHERE `guid`='88262';
UPDATE `creature` SET `modelid`='0', `position_x`='3087.452', `position_y`='-3367.567', `position_z`='298.4010', `orientation`='3.8920840' WHERE `guid`='88263';
UPDATE `creature` SET `modelid`='0', `position_x`='3074.640', `position_y`='-3353.271', `position_z`='298.4011', `orientation`='4.0666170' WHERE `guid`='88264';
UPDATE `creature` SET `modelid`='0', `position_x`='3136.614', `position_y`='-3353.291', `position_z`='294.0508', `orientation`='2.4609140' WHERE `guid`='88267';
UPDATE `creature` SET `modelid`='0', `position_x`='3088.140', `position_y`='-3305.500', `position_z`='294.0250', `orientation`='5.5676000' WHERE `guid`='88268';
UPDATE `creature` SET `modelid`='0', `position_x`='3157.593', `position_y`='-3332.373', `position_z`='294.0485', `orientation`='2.5481810' WHERE `guid`='88278';
UPDATE `creature` SET `modelid`='0', `position_x`='3109.138', `position_y`='-3284.198', `position_z`='294.0352', `orientation`='5.6374140' WHERE `guid`='88279';
UPDATE `creature` SET `modelid`='0', `position_x`='3174.143', `position_y`='-3291.926', `position_z`='294.7139', `orientation`='3.8048180' WHERE `guid`='88280';
UPDATE `creature` SET `modelid`='0', `position_x`='3149.682', `position_y`='-3265.699', `position_z`='294.5758', `orientation`='4.2236970' WHERE `guid`='88281';
UPDATE `creature` SET `modelid`='0', `position_x`='3168.316', `position_y`='-3280.821', `position_z`='294.9196', `orientation`='4.0666170' WHERE `guid`='88724';
UPDATE `creature` SET `modelid`='0', `position_x`='3159.187', `position_y`='-3270.790', `position_z`='294.8397', `orientation`='3.9793510' WHERE `guid`='88725';
UPDATE `creature` SET `modelid`='0', `position_x`='3011.567', `position_y`='-3189.042', `position_z`='294.1461', `orientation`='0.1047198', `spawndist`='1', `MovementType`='1' WHERE `guid`='88726';
UPDATE `creature` SET `modelid`='0', `position_x`='3023.057', `position_y`='-3187.803', `position_z`='294.1461', `orientation`='3.0543260', `spawndist`='1', `MovementType`='1' WHERE `guid`='88727';

DELETE FROM `creature` WHERE `guid` IN('88484', '88485');
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('88484', '16017', '533', '0', '0', '3009.262', '-3178.272', '294.1461', '3.366432', '3520', '1', '0', '88032', '0', '0', '1'),
('88485', '16017', '533', '0', '0', '3020.173', '-3177.851', '294.1461', '6.056293', '3520', '1', '0', '88032', '0', '0', '1');

UPDATE `creature` SET `modelid`='0', `position_x`='3096.716', `position_y`='-3292.511', `position_z`='294.5972', `orientation`='5.602507', `MovementType`='0' WHERE `guid`='88270';
UPDATE `creature` SET `modelid`='0', `position_x`='3149.040', `position_y`='-3345.118', `position_z`='294.5925', `orientation`='2.460914', `MovementType`='0' WHERE `guid`='88272';

DELETE FROM `creature_movement` WHERE `id` IN ('88270', '88272');

UPDATE `creature` SET `modelid`='0', `position_x`='-644.602', `position_y`='512.406', `position_z`='-272.998', `orientation`='1.35457', `spawntimesecs`='1800', `spawndist`='0', `MovementType`='2' WHERE `guid`='30143';

DELETE FROM `creature_movement` WHERE `id`='30143';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30143', '45', '-739.957', '557.628', '-303.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '46', '-717.644', '552.360', '-300.474', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '47', '-694.687', '547.437', '-293.879', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '48', '-670.469', '540.196', '-285.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '49', '-640.771', '529.846', '-273.061', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '50', '-643.777', '511.738', '-273.062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '44', '-754.181', '572.554', '-303.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '43', '-754.067', '592.240', '-303.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '42', '-748.994', '614.791', '-310.535', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '41', '-741.027', '641.893', '-319.187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '40', '-735.820', '670.718', '-328.270', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '39', '-727.032', '694.194', '-330.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '38', '-707.421', '706.391', '-330.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '37', '-684.131', '701.498', '-330.962', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '36', '-666.277', '697.114', '-331.799', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '35', '-651.783', '694.365', '-328.874', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '34', '-632.855', '692.141', '-327.059', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '33', '-637.027', '706.925', '-327.056', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '32', '-667.857', '715.439', '-324.987', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '31', '-695.022', '722.327', '-318.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '30', '-721.290', '719.670', '-318.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '29', '-739.127', '702.301', '-318.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '28', '-746.609', '687.276', '-318.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '27', '-752.096', '660.962', '-309.737', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '26', '-758.149', '636.062', '-302.208', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '25', '-766.533', '606.338', '-292.413', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '24', '-758.149', '636.062', '-302.208', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '23', '-752.096', '660.962', '-309.737', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '22', '-746.609', '687.276', '-318.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '21', '-739.127', '702.301', '-318.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '20', '-721.290', '719.670', '-318.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '19', '-695.022', '722.327', '-318.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '18', '-667.857', '715.439', '-324.987', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '17', '-637.027', '706.925', '-327.056', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '16', '-632.855', '692.141', '-327.059', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '15', '-651.783', '694.365', '-328.874', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '14', '-666.277', '697.114', '-331.799', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '13', '-684.131', '701.498', '-330.962', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '12', '-707.421', '706.391', '-330.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '11', '-727.032', '694.194', '-330.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '10', '-735.820', '670.718', '-328.270', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '9', '-741.027', '641.893', '-319.187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '8', '-748.994', '614.791', '-310.535', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '7', '-754.067', '592.240', '-303.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '6', '-754.181', '572.554', '-303.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '5', '-739.957', '557.628', '-303.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '4', '-717.644', '552.360', '-300.474', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '3', '-694.687', '547.437', '-293.879', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '2', '-670.469', '540.196', '-285.783', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30143', '1', '-640.771', '529.846', '-273.061', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-894.855', `position_y`='397.924', `position_z`='-272.519', `orientation`='1.40283', `spawntimesecs`='1800', `spawndist`='0', `MovementType`='2' WHERE `guid`='30141';

DELETE FROM `creature_movement` WHERE `id`='30141';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30141', '1', '-890.732', '422.234', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '2', '-880.317', '431.704', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '3', '-853.094', '428.800', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '4', '-829.955', '426.405', '-272.602', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '5', '-784.237', '419.781', '-272.578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '6', '-761.810', '411.242', '-272.578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '7', '-756.636', '388.790', '-272.578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '8', '-762.376', '360.669', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '9', '-768.185', '319.563', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '10', '-776.393', '288.366', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '11', '-798.922', '281.951', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '12', '-840.639', '289.840', '-272.607', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '13', '-882.196', '294.143', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '14', '-901.243', '300.200', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '15', '-906.519', '327.149', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '16', '-900.599', '360.755', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30141', '17', '-895.579', '397.062', '-272.596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-445.317', `position_y`='207.375', `position_z`='-207.823', `orientation`='1.58319', `spawntimesecs`='1800', `spawndist`='0', `MovementType`='2' WHERE `guid`='30140';

DELETE FROM `creature_movement` WHERE `id`='30140';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30140', '1', '-445.727', '240.449', '-207.960', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '2', '-452.575', '254.154', '-207.934', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '3', '-470.160', '262.695', '-207.917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '4', '-513.443', '262.288', '-207.904', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '5', '-546.600', '275.132', '-207.880', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '6', '-561.003', '309.061', '-213.367', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '7', '-559.208', '348.035', '-226.040', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '8', '-552.732', '385.997', '-231.667', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '9', '-546.476', '411.262', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '10', '-517.223', '411.910', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '11', '-489.928', '432.148', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '12', '-466.543', '462.255', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '13', '-455.236', '500.509', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '14', '-462.632', '545.029', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '15', '-485.715', '575.266', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '16', '-527.179', '599.641', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '17', '-544.401', '593.652', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '18', '-569.650', '599.277', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '19', '-607.075', '581.481', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '20', '-632.904', '554.956', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '21', '-645.848', '527.711', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '22', '-650.649', '489.373', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '23', '-645.848', '527.711', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '24', '-632.904', '554.956', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '25', '-607.075', '581.481', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '26', '-569.650', '599.277', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '27', '-544.401', '593.652', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '28', '-527.179', '599.641', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '29', '-485.715', '575.266', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '30', '-462.632', '545.029', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '31', '-455.176', '500.711', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '32', '-466.543', '462.255', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '33', '-489.928', '432.148', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '34', '-517.223', '411.910', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '35', '-546.476', '411.262', '-230.601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '36', '-552.732', '385.997', '-231.667', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '37', '-559.208', '348.035', '-226.040', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '38', '-561.003', '309.061', '-213.367', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '39', '-547.065', '275.352', '-207.906', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '40', '-513.443', '262.288', '-207.904', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '41', '-470.218', '262.723', '-207.937', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '42', '-452.575', '254.154', '-207.934', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '43', '-445.727', '240.449', '-207.960', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30140', '44', '-446.388', '214.340', '-207.907', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-471.39', `position_y`='48.4756', `position_z`='-207.954', `orientation`='6.03304', `MovementType`='2' WHERE `guid`='30137';

DELETE FROM `creature_movement_template` WHERE `entry`='7079';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('7079', '1', '-440.007', '40.4573', '-208.528', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '2', '-403.428', '48.1517', '-208.920', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '3', '-393.459', '63.5904', '-209.678', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '4', '-406.709', '75.8918', '-210.990', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '5', '-421.506', '82.5705', '-210.045', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '6', '-428.759', '100.234', '-209.626', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '7', '-409.098', '109.523', '-210.525', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '8', '-393.271', '112.121', '-209.804', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '9', '-380.830', '95.3402', '-210.582', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '10', '-372.115', '112.371', '-209.234', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '11', '-372.697', '137.794', '-208.769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '12', '-396.703', '139.501', '-210.381', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '13', '-372.697', '137.794', '-208.769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '14', '-396.703', '139.501', '-210.381', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '15', '-372.697', '137.794', '-208.769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '16', '-372.115', '112.371', '-209.234', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '17', '-380.830', '95.3402', '-210.582', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '18', '-393.271', '112.121', '-209.804', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '19', '-409.098', '109.523', '-210.525', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '20', '-428.759', '100.234', '-209.626', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '21', '-421.506', '82.5705', '-210.045', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '22', '-406.709', '75.8918', '-210.990', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '23', '-393.459', '63.5904', '-209.678', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '24', '-403.428', '48.1517', '-208.920', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '25', '-440.007', '40.4573', '-208.528', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('7079', '26', '-471.277', '47.9361', '-208.061', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='6223';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='6222';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='6224';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='7603';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='6391';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='6392';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='6407';
UPDATE `creature_template` SET `Scale`='0' WHERE `Entry`='9676';

UPDATE `creature` SET `modelid`='0', `position_x`='-9266.45', `position_y`='-2181.94', `position_z`='64.2375', `orientation`='4.7822', `spawndist`='0' WHERE `guid`='10088';

DELETE FROM `creature_movement` WHERE `id`='10088';
DELETE FROM `creature_movement_template` WHERE `entry`='934';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('934', '18', '-9297.22', '-2212.78', '61.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '17', '-9311.43', '-2210.67', '61.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '16', '-9322.40', '-2210.03', '61.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '15', '-9335.03', '-2207.95', '61.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '14', '-9344.36', '-2206.35', '61.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '13', '-9335.00', '-2207.96', '61.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '12', '-9322.40', '-2210.03', '61.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '11', '-9311.43', '-2210.67', '61.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '10', '-9296.33', '-2212.81', '61.8978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '9', '-9285.21', '-2216.08', '63.2600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '8', '-9284.11', '-2226.77', '63.3911', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '7', '-9283.65', '-2243.70', '63.5711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '6', '-9281.13', '-2260.52', '65.9722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '5', '-9275.42', '-2273.58', '67.4109', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '4', '-9271.06', '-2266.03', '66.2466', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '3', '-9270.65', '-2245.76', '64.0462', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '2', '-9269.66', '-2222.43', '64.0023', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '1', '-9268.26', '-2200.00', '64.0579', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '19', '-9285.21', '-2216.08', '63.2600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '20', '-9284.11', '-2226.77', '63.3911', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '21', '-9283.65', '-2243.70', '63.5711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '22', '-9281.13', '-2260.52', '65.9722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '23', '-9275.42', '-2273.58', '67.4109', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '24', '-9271.06', '-2266.03', '66.2466', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '25', '-9270.65', '-2245.76', '64.0462', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '26', '-9269.66', '-2222.43', '64.0023', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '27', '-9268.26', '-2200.00', '64.0579', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('934', '28', '-9266.45', '-2182.23', '64.0896', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='178187';
UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='178190';
UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='178189';
UPDATE `gameobject_template` SET `name`='Molten Core Circle BARON' WHERE `entry`='178188';

DELETE FROM `gameobject` WHERE `guid`='43164';
DELETE FROM `gameobject` WHERE `guid`='43162';

UPDATE `creature` SET `modelid`='0', `position_x`='-9776.48', `position_y`='-1383.62', `position_z`='62.9761', `orientation`='3.24447', `MovementType`='2' WHERE `guid`='81362';

DELETE FROM `creature_movement` WHERE `id`='81362';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('81362', '1', '-9787.19', '-1384.73', '62.7444', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '2', '-9796.35', '-1393.70', '62.8526', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '3', '-9799.68', '-1403.43', '62.7082', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '4', '-9797.45', '-1413.29', '62.7204', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '5', '-9791.16', '-1420.47', '62.6992', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '6', '-9780.90', '-1422.89', '62.6632', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '7', '-9771.84', '-1421.92', '62.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '8', '-9762.63', '-1412.12', '62.8456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '9', '-9760.81', '-1402.71', '62.7160', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '10', '-9763.66', '-1392.01', '62.8187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '11', '-9760.81', '-1402.71', '62.7160', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '12', '-9762.63', '-1412.12', '62.8456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '13', '-9771.84', '-1421.92', '62.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '14', '-9780.90', '-1422.89', '62.6632', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '15', '-9791.16', '-1420.47', '62.6992', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '16', '-9797.45', '-1413.29', '62.7204', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '17', '-9799.68', '-1403.43', '62.7082', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '18', '-9796.35', '-1393.70', '62.8526', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '19', '-9787.19', '-1384.73', '62.7444', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81362', '20', '-9776.63', '-1383.53', '62.7928', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-9776.60', `position_y`='-1394.83', `position_z`='98.0706', `orientation`='1.01229', `MovementType`='2' WHERE `guid`='81365';

DELETE FROM `creature_movement` WHERE `id`='81365';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('81365', '1', '-9788.50', '-1399.94', '97.8873', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81365', '2', '-9788.50', '-1399.94', '97.8873', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '4.34587', '0', '0'),
('81365', '3', '-9783.52', '-1412.02', '97.8873', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81365', '4', '-9783.52', '-1412.02', '97.8873', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '5.84685', '0', '0'),
('81365', '5', '-9771.30', '-1406.96', '97.8868', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81365', '6', '-9771.30', '-1406.96', '97.8868', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '1.16937', '0', '0'),
('81365', '7', '-9776.59', '-1394.81', '97.8873', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('81365', '8', '-9776.59', '-1394.81', '97.8873', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '2.74017', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-9798.49', `position_y`='695.4', `position_z`='33.2954', `orientation`='0.303533', `MovementType`='2' WHERE `guid`='80484';
UPDATE `creature` SET `modelid`='0', `position_x`='-9802.66', `position_y`='715.261', `position_z`='33.2008', `orientation`='2.39323', `spawndist`='2', `MovementType`='1' WHERE `guid`='80486';
UPDATE `creature` SET `modelid`='0', `position_x`='-9800.45', `position_y`='706.165', `position_z`='68.3899', `orientation`='4.53786', `MovementType`='2' WHERE `guid`='80488';

DELETE FROM `creature_movement` WHERE `id`='80484';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('80484', '20', '-9798.45', '695.196', '33.1121', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '19', '-9787.98', '698.690', '33.0633', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '18', '-9780.42', '708.031', '33.1796', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '17', '-9779.39', '719.580', '33.0247', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '16', '-9784.11', '729.628', '33.0265', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '15', '-9790.60', '734.172', '33.0179', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '14', '-9800.77', '735.681', '32.9617', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '13', '-9810.42', '732.059', '33.0151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '12', '-9817.44', '723.679', '33.1373', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '11', '-9818.05', '711.803', '33.0275', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '10', '-9812.93', '700.995', '33.1397', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '9', '-9818.05', '711.803', '33.0275', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '8', '-9817.44', '723.679', '33.1373', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '7', '-9810.42', '732.059', '33.0151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '6', '-9800.77', '735.681', '32.9617', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '5', '-9790.60', '734.172', '33.0179', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '4', '-9784.11', '729.628', '33.0265', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '3', '-9779.39', '719.580', '33.0247', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '2', '-9780.44', '707.820', '33.1363', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80484', '1', '-9787.98', '698.690', '33.0633', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_movement` WHERE `id`='80488';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('80488', '8', '-9800.41', '706.331', '68.2065', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '4.5204', '0', '0'),
('80488', '7', '-9800.41', '706.331', '68.2065', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80488', '6', '-9807.69', '717.244', '68.2060', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '2.89725', '0', '0'),
('80488', '5', '-9807.69', '717.244', '68.2060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80488', '4', '-9796.79', '723.860', '68.2065', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '1.32645', '0', '0'),
('80488', '3', '-9796.79', '723.860', '68.2065', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('80488', '2', '-9789.82', '713.630', '68.2065', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '6.14356', '0', '0'),
('80488', '1', '-9789.82', '713.630', '68.2065', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');
UPDATE `creature` SET `modelid`='0', `position_x`='-7324.43', `position_y`='-1963.29', `position_z`='298.114', `orientation`='0.372189', `spawndist`='0' WHERE `guid`='6825';

DELETE FROM `creature_movement` WHERE `id`='6825';
DELETE FROM `creature_movement_template` WHERE `entry`='5833';
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('5833', '1', '-7310.08', '-1957.69', '298.075', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '2', '-7292.15', '-1949.40', '299.021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '3', '-7267.91', '-1944.40', '296.293', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '4', '-7237.89', '-1957.55', '306.862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '5', '-7200.45', '-1957.60', '313.028', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '6', '-7194.84', '-1935.50', '320.013', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '7', '-7187.06', '-1901.58', '317.027', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '8', '-7171.25', '-1866.99', '312.428', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '9', '-7191.67', '-1900.20', '315.428', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '10', '-7211.13', '-1900.20', '305.948', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '11', '-7233.34', '-1883.14', '293.816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '12', '-7211.13', '-1900.20', '306.243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '13', '-7191.67', '-1900.29', '315.525', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '14', '-7171.27', '-1866.96', '312.351', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '15', '-7187.07', '-1901.55', '317.053', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '16', '-7194.84', '-1935.50', '320.013', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '17', '-7200.45', '-1957.60', '313.028', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '18', '-7237.89', '-1957.55', '306.862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '19', '-7267.91', '-1944.40', '296.293', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '20', '-7291.48', '-1949.41', '298.971', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '21', '-7309.88', '-1957.60', '298.049', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('5833', '22', '-7324.22', '-1962.19', '298.071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature` WHERE `id`='15622';

DELETE FROM `creature` WHERE `id`='15240' AND NOT `guid` IN ('87939', '87940', '87941', '87942', '87943', '87944');

DELETE FROM `creature` WHERE `guid` IN ('87614', '87615', '87616', '87645', '87646', '87647');

UPDATE `creature` SET `modelid`='0', `spawndist`='0', `MovementType`='0' WHERE `guid`='19429';
UPDATE `creature` SET `modelid`='0', `position_x`='-553.944', `position_y`='-2653.44', `position_z`='95.6559', `orientation`='0.316595', `spawndist`='0' WHERE `guid`='19362';
UPDATE `creature` SET `modelid`='0', `position_x`='-367.167', `position_y`='-2681.01', `position_z`='95.8854', `orientation`='3.19327', `MovementType`='2' WHERE `guid`='19414';

DELETE FROM `creature_movement` WHERE `id`='19414';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('19414', '28', '-460.017', '-2647.73', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '27', '-468.405', '-2649.95', '95.6132', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '26', '-479.967', '-2651.96', '95.7716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '25', '-489.848', '-2653.92', '95.9882', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '24', '-500.155', '-2654.21', '95.7104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '23', '-512.330', '-2653.76', '95.7104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '22', '-522.795', '-2653.78', '95.6166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '21', '-533.184', '-2653.43', '95.6110', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '20', '-542.432', '-2652.44', '95.6451', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '19', '-556.021', '-2653.35', '95.6451', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '18', '-545.598', '-2653.41', '95.6451', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '17', '-530.309', '-2653.53', '95.7243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '16', '-523.879', '-2653.36', '95.7973', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '15', '-514.545', '-2654.25', '95.5854', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '14', '-505.194', '-2654.48', '95.6239', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '13', '-493.581', '-2653.50', '95.8632', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '12', '-479.756', '-2651.99', '95.7465', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '11', '-468.138', '-2650.63', '95.6132', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '10', '-461.114', '-2651.47', '95.6664', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '9', '-454.066', '-2653.78', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '8', '-448.375', '-2656.48', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '7', '-442.527', '-2666.11', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '6', '-436.032', '-2672.72', '95.9098', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '5', '-422.983', '-2677.02', '95.8058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '4', '-413.551', '-2678.43', '95.6808', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '3', '-404.426', '-2679.80', '95.6808', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '2', '-389.371', '-2680.57', '95.8606', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '1', '-379.930', '-2681.67', '95.8499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '29', '-455.149', '-2644.95', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '30', '-446.630', '-2635.44', '95.5521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '31', '-443.346', '-2629.74', '95.5714', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '32', '-436.613', '-2622.90', '95.5714', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '33', '-427.226', '-2614.27', '95.7067', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '34', '-421.762', '-2610.43', '95.7067', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '35', '-413.255', '-2603.05', '95.6533', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '36', '-406.652', '-2594.34', '95.8492', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '37', '-400.366', '-2587.71', '95.8492', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '38', '-388.716', '-2577.13', '95.7429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '39', '-382.738', '-2570.09', '95.8679', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '40', '-373.626', '-2559.09', '95.8195', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '41', '-365.175', '-2548.80', '95.8005', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '42', '-357.873', '-2537.29', '95.8005', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '43', '-353.513', '-2526.43', '95.7550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '44', '-347.587', '-2509.65', '94.8800', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '45', '-350.739', '-2520.79', '95.5621', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '46', '-352.899', '-2529.23', '95.7550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '47', '-356.498', '-2538.37', '95.8005', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '48', '-362.634', '-2546.36', '95.8005', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '49', '-368.777', '-2553.83', '95.8195', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '50', '-376.912', '-2563.51', '95.8195', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '51', '-384.230', '-2571.78', '95.7429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '52', '-395.816', '-2583.54', '95.7429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '53', '-403.507', '-2590.65', '95.8492', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '54', '-413.216', '-2602.31', '95.7424', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '55', '-422.831', '-2611.84', '95.7067', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '56', '-426.375', '-2615.15', '95.7067', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '57', '-435.597', '-2626.75', '95.6964', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '58', '-441.538', '-2629.50', '95.2521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '59', '-447.190', '-2635.60', '95.5521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '60', '-450.068', '-2641.54', '95.4979', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '61', '-454.332', '-2647.89', '95.5521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '62', '-456.026', '-2651.07', '95.6187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '63', '-460.999', '-2661.78', '95.6534', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '64', '-459.936', '-2665.67', '95.5521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '65', '-462.007', '-2672.62', '95.4958', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '66', '-469.116', '-2682.71', '95.6498', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '67', '-474.369', '-2690.49', '95.6554', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '68', '-478.128', '-2696.80', '95.2804', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '69', '-473.329', '-2690.08', '95.5434', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '70', '-470.676', '-2685.78', '95.6991', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '71', '-467.040', '-2679.63', '95.7699', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '72', '-464.333', '-2674.88', '95.6054', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '73', '-461.596', '-2669.54', '95.5749', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '74', '-460.476', '-2663.79', '95.5521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '75', '-460.372', '-2659.53', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '76', '-460.250', '-2654.55', '95.8021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '77', '-459.111', '-2652.08', '95.7079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '78', '-456.019', '-2650.17', '95.5101', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '79', '-453.567', '-2649.99', '95.5521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '80', '-449.000', '-2654.20', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '81', '-446.131', '-2659.33', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '82', '-442.955', '-2664.19', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '83', '-438.828', '-2669.29', '95.8708', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '84', '-432.410', '-2674.38', '95.8058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '85', '-426.581', '-2676.19', '95.7252', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '86', '-411.233', '-2678.51', '95.7323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '87', '-399.449', '-2679.54', '95.7539', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '88', '-389.188', '-2679.66', '95.7512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '89', '-374.194', '-2679.74', '95.8789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19414', '90', '-371.330', '-2682.44', '95.8789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_movement` WHERE `id`='19362';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('19362', '1', '-546.402', '-2650.97', '95.6451', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '2', '-533.157', '-2651.63', '95.8268', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '3', '-522.873', '-2652.35', '95.7983', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '4', '-503.562', '-2651.99', '95.7104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '5', '-487.555', '-2651.38', '95.8417', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '6', '-480.694', '-2649.46', '95.8632', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '7', '-467.780', '-2646.92', '95.7382', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '8', '-459.763', '-2643.58', '95.8021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '9', '-449.808', '-2637.17', '95.5521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '10', '-443.390', '-2625.73', '95.5714', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '11', '-432.168', '-2615.41', '95.6701', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '12', '-419.064', '-2605.66', '95.8071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '13', '-406.211', '-2590.17', '95.9070', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '14', '-392.416', '-2575.68', '95.7510', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '15', '-372.083', '-2552.10', '95.8195', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '16', '-361.617', '-2538.30', '95.8005', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '17', '-351.410', '-2520.73', '95.5556', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '18', '-360.416', '-2542.24', '95.8005', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '19', '-373.892', '-2561.65', '95.8195', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '20', '-390.645', '-2581.53', '95.7429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '21', '-402.923', '-2594.76', '95.8492', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '22', '-411.435', '-2604.01', '95.8317', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '23', '-422.207', '-2614.52', '95.7067', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '24', '-431.066', '-2623.02', '95.7067', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '25', '-438.150', '-2630.17', '95.6964', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '26', '-450.400', '-2643.29', '95.5521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '27', '-449.929', '-2650.01', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '28', '-444.563', '-2657.22', '95.6422', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '29', '-439.804', '-2663.72', '95.8021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '30', '-431.802', '-2670.21', '95.8058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '31', '-419.932', '-2674.65', '95.6808', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '32', '-407.508', '-2675.86', '95.7645', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '33', '-395.310', '-2676.88', '95.7539', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '34', '-387.008', '-2677.53', '95.8789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '35', '-373.465', '-2677.13', '95.8789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '36', '-363.879', '-2676.20', '95.8362', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '37', '-348.530', '-2675.37', '95.8183', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '38', '-349.673', '-2681.12', '96.0862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '39', '-358.941', '-2682.51', '95.8362', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '40', '-369.135', '-2684.97', '95.8789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '41', '-378.154', '-2685.51', '95.8789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '42', '-390.743', '-2686.61', '96.0847', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '43', '-398.805', '-2686.19', '95.8789', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '44', '-408.128', '-2685.01', '95.8195', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '45', '-421.949', '-2681.01', '95.8058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '46', '-427.811', '-2680.48', '95.9554', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '47', '-433.066', '-2679.00', '95.9308', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '48', '-438.384', '-2677.37', '96.2892', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '49', '-443.024', '-2672.21', '96.2211', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '50', '-445.805', '-2666.91', '95.7717', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '51', '-449.513', '-2659.07', '95.6771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '52', '-451.567', '-2655.46', '95.6776', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '53', '-461.787', '-2653.58', '95.8021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '54', '-470.933', '-2653.32', '95.6132', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '55', '-476.853', '-2654.56', '95.7230', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '56', '-486.598', '-2657.55', '96.1747', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '57', '-495.890', '-2658.16', '96.2103', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '58', '-504.723', '-2658.76', '95.9494', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '59', '-510.133', '-2658.15', '95.7104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '60', '-516.568', '-2657.32', '95.6005', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '61', '-524.912', '-2657.02', '95.7104', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '62', '-534.101', '-2656.30', '95.7701', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '63', '-544.258', '-2656.30', '95.7139', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '64', '-551.084', '-2655.98', '95.6754', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('19362', '65', '-553.186', '-2653.43', '95.6451', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='-189.706', `position_y`='277.083', `position_z`='-48.4021', `orientation`='1.296810', `spawndist`='0', `MovementType`='2' WHERE `guid`='30081';
UPDATE `creature` SET `modelid`='0', `position_x`='-144.605', `position_y`='223.960', `position_z`='-46.1905', `orientation`='0.596879', `spawndist`='0', `MovementType`='2' WHERE `guid`='30085';
UPDATE `creature` SET `modelid`='0', `position_x`='-107.367', `position_y`='351.402', `position_z`='-47.2184', `orientation`='1.296810', `spawndist`='0', `MovementType`='2' WHERE `guid`='33523';

DELETE FROM `creature_movement` WHERE `id`='30081';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30081', '1', '-186.122', '284.889', '-47.9277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '2', '-184.537', '290.529', '-48.2939', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '3', '-181.906', '297.890', '-50.6951', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '4', '-180.537', '306.196', '-52.5285', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '5', '-178.855', '315.518', '-53.1097', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '6', '-176.023', '323.062', '-52.1430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '7', '-166.295', '323.899', '-50.5788', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '8', '-161.012', '321.039', '-49.6787', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '9', '-154.187', '319.611', '-48.9430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '10', '-147.616', '323.359', '-47.8096', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '11', '-144.867', '328.990', '-45.8678', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '12', '-140.307', '330.953', '-44.4280', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '13', '-134.932', '328.717', '-44.3512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '14', '-129.093', '319.235', '-44.3214', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '15', '-122.974', '316.957', '-44.8064', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '16', '-114.836', '317.766', '-46.7871', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '17', '-122.974', '316.957', '-44.8064', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '18', '-129.093', '319.235', '-44.3214', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '19', '-134.932', '328.717', '-44.3512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '20', '-140.307', '330.953', '-44.4280', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '21', '-144.773', '329.030', '-45.8512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '22', '-147.616', '323.359', '-47.8096', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '23', '-154.187', '319.611', '-48.9430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '24', '-161.012', '321.039', '-49.6787', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '25', '-166.295', '323.899', '-50.5788', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '26', '-176.023', '323.062', '-52.1430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '27', '-178.855', '315.518', '-53.1097', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '28', '-180.506', '306.386', '-52.5748', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '29', '-181.906', '297.890', '-50.6951', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '30', '-184.435', '290.816', '-48.3882', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '31', '-186.122', '284.889', '-47.9277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30081', '32', '-189.706', '277.083', '-48.4021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_movement` WHERE `id`='33523';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('33523', '20', '-107.367', '351.402', '-47.2184', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '19', '-94.7018', '350.589', '-49.0758', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '18', '-84.5173', '353.872', '-50.8818', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '17', '-74.8239', '357.502', '-51.4498', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '16', '-67.5208', '362.644', '-50.7932', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '15', '-64.3753', '369.092', '-50.2486', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '14', '-56.0625', '371.559', '-50.5752', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '13', '-46.5493', '368.680', '-49.2223', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '12', '-44.3358', '362.808', '-48.0807', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '11', '-40.5576', '353.328', '-46.9238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '10', '-32.346', '347.496', '-44.5815', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '9', '-40.5853', '353.397', '-46.8918', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '8', '-44.3358', '362.808', '-48.0807', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '7', '-46.5493', '368.680', '-49.2223', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '6', '-56.0625', '371.559', '-50.5752', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '5', '-64.3753', '369.092', '-50.2486', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '4', '-67.5208', '362.644', '-50.7932', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '3', '-74.8239', '357.502', '-51.4498', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '2', '-84.5173', '353.872', '-50.8818', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('33523', '1', '-94.7018', '350.589', '-49.0758', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_movement` WHERE `id`='30085';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('30085', '1', '-133.322', '231.628', '-47.7201', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '2', '-128.497', '235.402', '-47.7797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '3', '-123.754', '240.053', '-48.3936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '4', '-122.252', '246.016', '-48.2522', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '5', '-122.236', '251.897', '-48.4177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '6', '-121.885', '258.539', '-47.5953', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '7', '-125.347', '266.097', '-46.0830', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '8', '-130.547', '281.654', '-45.8065', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '9', '-136.135', '288.273', '-46.0188', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '10', '-140.443', '293.482', '-46.2818', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '11', '-140.142', '300.930', '-46.0073', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '12', '-140.431', '293.771', '-46.2399', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '13', '-136.135', '288.273', '-46.0188', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '14', '-130.713', '281.851', '-45.8294', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '15', '-125.347', '266.097', '-46.0830', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '16', '-121.888', '258.545', '-47.6056', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '17', '-122.236', '251.897', '-48.4177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '18', '-122.252', '246.016', '-48.2522', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '19', '-123.671', '240.135', '-48.3101', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '20', '-128.497', '235.402', '-47.7797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '21', '-133.322', '231.628', '-47.7201', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('30085', '22', '-144.274', '224.024', '-46.1978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');
-- Made some of the Grim Guzzler patrons dance on the tables
UPDATE `creature_addon` SET `emote` = 10 WHERE `guid` IN (90741, 91011, 48168, 91066, 46620, 90738, 90888);

-- Fixed flags of NPC 9537 (Hurley Blackbreath) and NPCs 9541 (Blackbreath Crony)
UPDATE `creature_template` SET `FactionAlliance` = 54, `FactionHorde` = 54, `UnitFlags` = 33088, `MovementType` = 0 WHERE `Entry` IN (9537, 9541);

-- Fixed equipment of NPC 9537 (Hurley Blackbreath) and NPCs 9541 (Blackbreath Crony)
UPDATE `creature_template` SET `EquipmentTemplateId` = 1309 WHERE `Entry` = 9537;
UPDATE `creature_template` SET `EquipmentTemplateId` = 954 WHERE `Entry` = 9541;

DELETE FROM `creature_linking_template` WHERE `entry` = 9541;
INSERT INTO `creature_linking_template` (`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES
(9541, 230, 9537, 3, 0);

UPDATE `creature` SET `modelid`='0', `position_x`='3110.31', `position_y`='-3333.07', `position_z`='293.712', `orientation`='5.49792' WHERE `guid`='88269';

DELETE FROM `creature_movement` WHERE `id`='88269';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('88269', '1', '3119.63', '-3342.39', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '2', '3126.20', '-3344.95', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '3', '3132.59', '-3340.74', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '4', '3139.65', '-3333.70', '293.625', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '5', '3147.05', '-3325.68', '293.626', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '6', '3156.76', '-3316.76', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '7', '3159.58', '-3307.46', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '8', '3151.30', '-3298.50', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '9', '3142.82', '-3289.66', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '10', '3133.79', '-3280.20', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '11', '3124.37', '-3283.02', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '12', '3115.83', '-3292.97', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '13', '3107.54', '-3301.68', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '14', '3100.09', '-3309.10', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '15', '3096.53', '-3315.12', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '16', '3098.17', '-3321.92', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '17', '3105.72', '-3329.35', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '18', '3096.04', '-3342.59', '294.535', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '19', '3089.53', '-3352.05', '299.151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '20', '3080.94', '-3360.32', '298.318', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '21', '3090.22', '-3352.67', '299.114', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '22', '3098.56', '-3345.29', '294.538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88269', '23', '3110.56', '-3333.55', '293.628', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='3165.05', `position_y`='-3325.43', `position_z`='294.606', `orientation`='0.942478' WHERE `guid`='88720';

DELETE FROM `creature_movement` WHERE `id`='88720';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('88720', '21', '3132.47', '-3243.82', '294.086', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '20', '3118.06', '-3238.51', '294.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '19', '3110.50', '-3233.31', '294.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '18', '3104.61', '-3223.00', '294.062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '17', '3102.01', '-3217.84', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '16', '3088.78', '-3219.72', '294.211', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '15', '3062.66', '-3225.54', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '14', '3088.78', '-3219.72', '294.211', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '13', '3102.01', '-3217.84', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '12', '3104.61', '-3223.00', '294.062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '11', '3110.50', '-3233.31', '294.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '10', '3118.06', '-3238.51', '294.060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '9', '3132.47', '-3243.82', '294.086', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '8', '3132.82', '-3258.02', '294.504', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '7', '3134.09', '-3269.03', '294.447', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '6', '3145.96', '-3276.27', '294.712', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '5', '3159.74', '-3284.69', '294.892', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '4', '3165.63', '-3293.16', '294.701', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '3', '3170.73', '-3299.80', '294.598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '2', '3176.23', '-3307.65', '294.536', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '1', '3174.62', '-3318.04', '294.531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '22', '3132.82', '-3258.02', '294.504', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '23', '3134.09', '-3269.03', '294.447', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '24', '3145.96', '-3276.27', '294.712', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '25', '3159.74', '-3284.69', '294.892', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '26', '3165.63', '-3293.16', '294.701', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '27', '3170.73', '-3299.80', '294.598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '28', '3176.23', '-3307.65', '294.536', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '29', '3174.62', '-3318.04', '294.531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88720', '30', '3165.18', '-3325.20', '294.523', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `creature` SET `modelid`='0', `position_x`='3102.07', `position_y`='-3209.2', `position_z`='294.146', `orientation`='1.6057' WHERE `guid`='88721';

DELETE FROM `creature_movement` WHERE `id`='88721';
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('88721', '1', '3103.86', '-3199.29', '293.925', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '2', '3110.06', '-3189.07', '293.965', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '3', '3117.29', '-3183.44', '293.987', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '4', '3124.22', '-3180.93', '293.996', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '5', '3134.68', '-3179.75', '293.999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '6', '3147.70', '-3183.07', '293.983', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '7', '3156.94', '-3191.08', '293.949', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '8', '3163.03', '-3198.68', '293.917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '9', '3165.09', '-3211.21', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '10', '3162.97', '-3223.67', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '11', '3155.37', '-3234.20', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '12', '3146.97', '-3240.26', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '13', '3138.72', '-3243.33', '294.084', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '14', '3146.97', '-3240.26', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '15', '3155.37', '-3234.20', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '16', '3162.97', '-3223.67', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '17', '3165.12', '-3211.40', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '18', '3163.03', '-3198.68', '293.917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '19', '3156.94', '-3191.08', '293.949', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '20', '3147.70', '-3183.07', '293.983', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '21', '3134.68', '-3179.75', '293.999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '22', '3124.22', '-3180.93', '293.996', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '23', '3117.29', '-3183.44', '293.987', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '24', '3110.06', '-3189.07', '293.965', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '25', '3103.86', '-3199.29', '293.925', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88721', '26', '3102.40', '-3208.72', '294.063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

UPDATE `gameobject` SET `position_x`='-8429.594', `position_y`='2048.813', `position_z`='153.3087', `rotation2`='-0.9824495', `rotation3`='0.1865285', `spawntimesecs`='7200', `animprogress`='100' WHERE `guid`='21785';

UPDATE `creature` SET `equipment_id`='0', `position_x`='-8159.37', `position_y`='2144.16', `position_z`='129.564', `orientation`='4.084070' WHERE `guid`='87564';
UPDATE `creature` SET `equipment_id`='0', `position_x`='-8156.46', `position_y`='2119.58', `position_z`='129.203', `orientation`='3.577920' WHERE `guid`='87565';
UPDATE `creature` SET `equipment_id`='0', `position_x`='-8206.18', `position_y`='2164.81', `position_z`='129.467', `orientation`='5.026550' WHERE `guid`='87566';
UPDATE `creature` SET `equipment_id`='0', `position_x`='-8182.61', `position_y`='2166.21', `position_z`='129.640', `orientation`='4.642580' WHERE `guid`='87567';
UPDATE `creature` SET `equipment_id`='0', `position_x`='-8314.34', `position_y`='2119.22', `position_z`='118.263', `orientation`='0.541052' WHERE `guid`='87568';
UPDATE `creature` SET `equipment_id`='0', `position_x`='-8297.35', `position_y`='2075.67', `position_z`='118.269', `orientation`='0.610865' WHERE `guid`='87569';
UPDATE `creature` SET `equipment_id`='0', `position_x`='-8288.92', `position_y`='2054.50', `position_z`='118.300', `orientation`='0.523599' WHERE `guid`='87570';
UPDATE `creature` SET `equipment_id`='0', `position_x`='-8321.97', `position_y`='2142.68', `position_z`='118.266', `orientation`='0.628318' WHERE `guid`='87571';

UPDATE `creature` SET `position_x`='-8377.00', `position_y`='2070.66', `position_z`='144.884', `orientation`='1.80392', `currentwaypoint`='0' WHERE `guid`='87734';
UPDATE `creature` SET `position_x`='-8277.65', `position_y`='2067.65', `position_z`='118.259', `orientation`='1.77493', `currentwaypoint`='0' WHERE `guid`='87736';
UPDATE `creature` SET `position_x`='-8258.03', `position_y`='2124.34', `position_z`='120.573', `orientation`='6.19592', `currentwaypoint`='0' WHERE `guid`='88074';

UPDATE `creature` SET `modelid`='0', `position_x`='-8346.052', `position_y`='2080.981', `position_z`='125.7325', `orientation`='0.4014257' WHERE `guid`='88075';

DELETE FROM `creature_movement` WHERE `id` IN ('88074', '87736', '87734');
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
('88074', '4', '-8185.17', '2123.69', '129.196', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '5', '-8181.45', '2105.02', '129.196', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '6', '-8191.38', '2086.59', '129.196', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '7', '-8181.45', '2105.02', '129.196', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '8', '-8185.17', '2123.69', '129.196', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '9', '-8202.72', '2136.73', '129.335', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '10', '-8233.33', '2128.12', '131.175', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '11', '-8242.23', '2125.75', '127.535', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '12', '-8256.74', '2124.26', '120.296', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '3', '-8202.72', '2136.73', '129.335', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '2', '-8234.38', '2128.12', '130.800', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('88074', '1', '-8242.23', '2125.75', '127.535', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '10', '-8277.3', '2070.66', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '9', '-8282.95', '2093.24', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '8', '-8273.95', '2106.07', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '7', '-8277.97', '2116.79', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '6', '-8292.52', '2119.10', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '5', '-8307.77', '2141.70', '118.366', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '4', '-8292.52', '2119.10', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '3', '-8277.97', '2116.79', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '2', '-8273.95', '2106.07', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87736', '1', '-8282.95', '2093.24', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '27', '-8378.51', '2073.5', '144.801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '26', '-8368.56', '2053.3', '144.849', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '25', '-8357.45', '2041.96', '144.822', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '24', '-8347.22', '2036.59', '142.472', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '23', '-8338.97', '2041.95', '136.526', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '22', '-8332.79', '2047.07', '133.123', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '21', '-8325.95', '2055.94', '133.055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '20', '-8321.34', '2065.85', '133.032', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '19', '-8326.16', '2076.21', '126.811', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '18', '-8328.96', '2085.23', '125.633', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '17', '-8322.37', '2089.84', '125.615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '16', '-8315.77', '2092.71', '122.294', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '15', '-8310.04', '2094.40', '118.796', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '14', '-8297.13', '2093.87', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '13', '-8289.84', '2100.81', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '12', '-8292.68', '2108.07', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '11', '-8302.85', '2107.91', '118.300', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '10', '-8311.38', '2097.5', '118.862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '9', '-8316.98', '2095.26', '122.407', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '8', '-8323.72', '2093.62', '125.604', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '7', '-8331.44', '2092.25', '125.627', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '5', '-8342.34', '2116.06', '133.091', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '6', '-8338.46', '2108.83', '132.695', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '4', '-8356.40', '2116.52', '133.101', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '3', '-8368.37', '2117.77', '136.244', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '2', '-8379.47', '2113.17', '143.654', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0'),
('87734', '1', '-8383.19', '2096.75', '144.826', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '0', '0');

DELETE FROM `creature_loot_template` WHERE `item`='21156';

UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21786';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21787';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21788';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21789';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21791';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21790';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21792';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21793';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21794';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21795';
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `guid`='21796';
UPDATE `gameobject` SET `spawntimesecs`='7200', `animprogress`='100' WHERE `guid`='21783';
UPDATE `gameobject` SET `spawntimesecs`='7200', `animprogress`='100' WHERE `guid`='21784';
UPDATE `gameobject` SET `spawntimesecs`='7200', `animprogress`='100' WHERE `guid`='21797';
UPDATE `gameobject` SET `spawntimesecs`='7200', `animprogress`='100' WHERE `guid`='21798';
UPDATE `gameobject` SET `spawntimesecs`='7200', `animprogress`='100' WHERE `guid`='21799';

UPDATE `creature_linking` SET `master_guid`='88270' WHERE `guid`='88268';
UPDATE `creature_linking` SET `guid`='88724' WHERE `guid`='88274';
UPDATE `creature_linking` SET `guid`='88725' WHERE `guid`='88275';

DELETE FROM `creature_linking` WHERE `guid` IN ('88279', '88484', '88485', '88727');
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES
('88279', '88270', '3'),
('88484', '88726', '3'),
('88485', '88726', '3'),
('88727', '88726', '3');

UPDATE `creature_template` SET `MinLevel`='17', `SpeedWalk`='1', `HealthMultiplier`='3', `DamageMultiplier`='1.7', `ArmorMultiplier`='1', `MinMeleeDmg`='25.0', `MaxMeleeDmg`='34.8', `MinRangedDmg`='0', `MaxRangedDmg`='0', `MeleeAttackPower`='64', `RangedAttackPower`='3' WHERE `Entry`='3640';

UPDATE `creature_template` SET `DamageMultiplier`='1.35', `DamageVariance`='1' WHERE `Entry`='10077';
UPDATE `creature_template` SET `DamageMultiplier`='13', `DamageVariance`='1' WHERE `Entry`='12101';

-- Remy "Two Times"
UPDATE creature_template SET npcFlags = 3, GossipMenuId = 5032 WHERE entry = 241;
DELETE FROM gossip_menu WHERE entry = 5032;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(5032, 6157, 0, 0);
DELETE FROM npc_text WHERE ID = 6157;
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, prob0, em0_0, em0_1) VALUES 
(6157, 'Hey there, friend. My name\'s Remy. I\'m from Redridge to the east, and came here looking for business, looking for business. You got any...got any??', 'Hey there, friend. My name\'s Remy. I\'m from Redridge to the east, and came here looking for business, looking for business. You got any...got any??', 0, 1, 0, 0);

-- Marshal Dughan - gossip corrected
UPDATE creature_template SET npcFlags = 3, GossipMenuId = 11611 WHERE Entry = 240;
DELETE FROM gossip_menu WHERE entry IN (6159, 11611); 
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(11611, 16211, 0, 0);
-- missing text added
DELETE FROM npc_text WHERE ID IN (6157,16211);
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, prob0, em0_0, em0_1) VALUES 
(16211, 'Ach, it\'s hard enough keeping order around here without all these new troubles popping up!  I hope you have good news, $n...', 'Ach, it\'s hard enough keeping order around here without all these new troubles popping up!  I hope you have good news, $n...', 0, 1, 5, 5);

-- Lanti'gah - Barrens
UPDATE creature SET position_x = -292.942444, position_y = -1909.355591, position_z = 91.666786, orientation = 2.13, spawndist = 10, MovementType = 1 WHERE guid = 13100;

-- q.4129 'The Knife Revealed'
DELETE FROM dbscripts_on_quest_end WHERE id = 4129;
INSERT INTO dbscripts_on_quest_end (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(4129,0,29,131,2,0,0,0,0,0,0,0,0,0,0,0,'npcFlags removed'),
(4129,2,0,0,0,0,0,0,2000000521,0,0,0,0,0,0,0,''),
(4129,3,15,15050,0,0,0,0,0,0,0,0,0,0,0,0,''),
(4129,10,0,0,0,0,0,0,2000000522,0,0,0,0,0,0,0,''),
(4129,12,29,131,1,0,0,0,0,0,0,0,0,0,0,0,'npcFlags added');
UPDATE quest_template SET CompleteScript = 4129 WHERE entry = 4129;
DELETE FROM db_script_string WHERE entry BETWEEN 2000000521 AND 2000000522;
INSERT INTO db_script_string (entry, content_default, sound, type, language, emote, comment) VALUES
(2000000521,'I will need to focus my energies onto this knife. By doing so, I should catch some of the stronger psychic impressions associated with it.',0,0,0,0,NULL),
(2000000522,'I... I\'ve seen enough I think... so very draining...',0,0,0,462,NULL);

-- Quintis Jonespyre
-- temp. solution (we need to find gossipID)
DELETE FROM npc_gossip WHERE npc_guid = 51258;
INSERT INTO npc_gossip (npc_guid, textid) VALUES
(51258, 2575);

-- q.2943 'Return to Troyas'
DELETE FROM dbscripts_on_quest_end WHERE id = 2943;
INSERT INTO dbscripts_on_quest_end (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(2943,0,29,3,2,0,0,0,0,0,0,0,0,0,0,0,'npcFlags removed'),
(2943,1,0,0,0,0,0,0,2000000523,0,0,0,0,0,0,0,''),
(2943,2,3,0,0,0,0,0,0,0,0,0,-4476.23,3230.55,13.7301,4.20931,''),
(2943,4,3,0,0,0,0,0,0,0,0,0,0,0,0,4.99471,''),
(2943,5,0,0,0,0,0,0x02,2000000524,0,0,0,0,0,0,0,''),
(2943,10,0,0,0,0,0,0,2000000525,0,0,0,0,0,0,0,''),
(2943,12,3,0,0,0,0,0,0,0,0,0,-4474.9,3232.88,13.7295,0.951991,''),
(2943,14,29,3,1,0,0,0,0,0,0,0,0,0,0,0,'npcFlags added');
UPDATE quest_template SET CompleteScript = 2943 WHERE entry = 2943;
DELETE FROM db_script_string WHERE entry BETWEEN 2000000523 AND 2000000525;
INSERT INTO db_script_string (entry, content_default, sound, type, language, emote, comment) VALUES
(2000000523,'A History... Hmmmm... Let me examine this for a moment.',0,0,0,0,NULL),
(2000000524,'%s skims the pages of the book.',0,2,0,0,NULL),
(2000000525,'Amazing! I think I have found it, $N.',0,0,0,0,NULL);

-- q.3463 'Set Them Ablaze!'
DELETE FROM dbscripts_on_quest_end WHERE id = 3463;
INSERT INTO dbscripts_on_quest_end (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(3463,1,31,8479,100,0,0,0,0,0,0,0,0,0,0,0,'search for Kalaran Windblade'),
(3463,2,18,0,0,8479,5921,7 | 0x10,0,0,0,0,0,0,0,0,'desp'),
(3463,3,10,8480,54000,0,0,0,0,0,0,0,-6679.93,-1194.36,240.297,2.96706,'summon Kalaran the Deceiver');
UPDATE quest_template SET CompleteScript = 3463 WHERE entry = 3463;

-- Kalaran Windblade
UPDATE creature SET spawntimesecs = 120 WHERE id = 8479;

-- Kalaran the Deceiver
UPDATE creature_template SET MovementType = 2 WHERE entry = 8480;
DELETE FROM creature_movement_template WHERE entry = 8480;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(8480, 1, -6679.93,-1194.36,240.297,45000,848001,2.96706,0,0),
(8480, 2, -6879.3,-1187.34,253.384,0,0,3.10877,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 848001;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(848001,1,21,1,0,0,0,0x04,0,0,0,0,0,0,0,0,'Kalaran the Deceiver - active'),
(848001,1,0,0,0,0,0,0,2000000526,0,0,0,0,0,0,0,''),
(848001,3,0,0,0,0,0,0,2000000527,0,0,0,0,0,0,0,''),
(848001,7,0,0,0,0,0,0,2000000528,0,0,0,0,0,0,0,''),
(848001,13,0,0,0,8509,20,7,2000000529,0,0,0,0,0,0,0,''),
(848001,15,3,0,0,0,0,0,0,0,0,0,0,0,0,4.65994,''),
(848001,18,0,0,0,0,0,0,2000000530,0,0,0,0,0,0,0,''),
(848001,22,0,0,0,0,0,0,2000000531,0,0,0,0,0,0,0,''),
(848001,27,0,0,0,0,0,0,2000000532,0,0,0,0,0,0,0,''),
(848001,32,0,0,0,8509,20,7,2000000533,0,0,0,0,0,0,0,''),
(848001,35,0,0,0,0,0,0,2000000534,0,0,0,0,0,0,0,''),
(848001,38,0,0,0,0,0,0,2000000535,0,0,0,0,0,0,0,''),
(848001,41,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON'),
(848001,44,0,0,0,0,0,0,2000000536,0,0,0,0,0,0,0,''),
(848001,48,21,0,0,0,0,0x04,0,0,0,0,0,0,0,0,'Kalaran the Deceiver - unactive');
DELETE FROM db_script_string WHERE entry BETWEEN 2000000526 AND 2000000536;
INSERT INTO db_script_string (entry, content_default, sound, type, language, emote, comment) VALUES
(2000000526,'Glorious, indeed, Maltrake. It looks as if my plan worked perfectly. Wouldn\'t you say so, mortal?',0,0,0,0,NULL),
(2000000527,'%s lets loose a reptilian laugh... at least you think it\'s a laugh.',0,2,0,0,NULL),
(2000000528,'You would not have helped the legion of Blackrock had we just asked for your assistance, now would you?',0,0,0,0,NULL),
(2000000529,'What will we do with them, master? They are of no use to us anymore.',0,0,0,1,NULL),
(2000000530,'SILENCE FOOL!',0,0,0,0,NULL),
(2000000531,'They will live of only to see the fruits of their labor: the destruction and chaos that will surely ensue as the legion of Blackrock invade the gorge.',0,0,0,0,NULL),
(2000000532,'I leave you now, mortals. Alive and with these trinkets. Maltrake! Present them with the trinkets!',0,0,0,0,NULL),
(2000000533,'Right away, master!',0,0,0,0,NULL),
(2000000534,'%s begins to flap his massive wings faster. He is preparing for flight.',0,2,0,0,NULL),
(2000000535,'Oh yes, the molt - do not lose it. There are those of my kin in the Burning Steppes that would craft items that only the molt of the black dragonflight could fortify.',0,0,0,0,NULL),
(2000000536,'The legion of Blackrock comes, dwarflings! We shall scorch the earth and set fire to the heavens. None shall survive...',0,1,0,0,NULL);

-- Torwa Pathfinder
-- new gossip after q. 4289
-- additional menu should be available after q.4290
UPDATE gossip_menu SET condition_id = 1145 WHERE entry = 2188 AND text_id = 2821;
UPDATE gossip_menu_option SET condition_id = 1146 WHERE menu_id = 2188;
DELETE FROM conditions WHERE condition_entry IN (1146, 1147); 
INSERT INTO conditions (condition_entry, type, value1, value2) VALUES
(1147, 8, 4289, 0),
(1146, 8, 4290, 0);


-- q.4321 'Making Sense of It'

-- first: fix start_script
DELETE FROM dbscripts_on_quest_start WHERE id = 4321;
INSERT INTO dbscripts_on_quest_start (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(4321,0,29,3,2,0,0,0,0,0,0,0,0,0,0,0,'npcFlags removed'),
(4321,1,1,6,0,0,0,0,0,0,0,0,0,0,0,0,''),
(4321,2,0,0,0,0,0,0,2000000030,0,0,0,0,0,0,0,''),
(4321,5,1,22,0,0,0,0,0,0,0,0,0,0,0,0,''),
(4321,5,7,4321,0,0,0,0,0,0,0,0,0,0,0,0,''),
(4321,6,29,3,1,0,0,0,0,0,0,0,0,0,0,0,'npcFlags added');
UPDATE quest_template SET StartScript = 4321 WHERE entry = 4321;
-- second: missing end_script added 
DELETE FROM dbscripts_on_quest_end WHERE id = 4321;
INSERT INTO dbscripts_on_quest_end (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(4321,1,21,1,0,0,0,0x04,0,0,0,0,0,0,0,0,'J.D. Collie - active'),
(4321,2,9,63180,30,0,0,0,0,0,0,0,-6034.46,-1014.57,-216.735,6.07572,''),
(4321,3,0,0,0,0,0,0,2000000540,0,0,0,0,0,0,0,''),
(4321,3,3,0,0,0,0,0,0,0,0,0,0,0,0,2.36912,''),
(4321,8,0,0,0,0,0,0,2000000541,0,0,0,0,0,0,0,''),
(4321,12,3,0,0,0,0,0,0,0,0,0,0,0,0,0.872665,''),
(4321,12,0,0,0,0,0,0,2000000542,0,0,0,0,0,0,0,''),
(4321,13,21,0,0,0,0,0x04,0,0,0,0,0,0,0,0,'J.D. Collie - unactive');
UPDATE quest_template SET CompleteScript = 4321 WHERE entry = 4321;
DELETE FROM db_script_string WHERE entry BETWEEN 2000000540 AND 2000000542;
INSERT INTO db_script_string (entry, content_default, sound, type, language, emote, comment) VALUES
(2000000540, 'Now, let\'s see... If I am correct, then... Hmmm...', 0, 0, 0, 4, NULL),
(2000000541, 'Blue plus red... I predict...', 0, 0, 0, 0, NULL),
(2000000542, '$N, that\'s it! I have finally figured it out!', 0, 0, 0, 0, NULL);

-- missing object added - UDB free guid reused
DELETE FROM gameobject WHERE guid = 63180;
INSERT INTO gameobject VALUES ( 63180, 174683, 1, -6034.46, -1014.57, -216.735, 6.07572, 0, 0, 0.103548, -0.994624, -30, 255, 1);

-- Arathandris Silversky
-- still menu_id and text_id for this option
UPDATE gossip_menu_option SET condition_id = 5 WHERE menu_id = 2208 AND id = 1;

-- The Book of Ur
UPDATE gameobject SET spawntimesecs = 2 WHERE guid = 40667;

-- Warbringer Construct 8905
-- UnitFlags corrected
-- Not-selectable 0x2000000 & not_attackable 0x100 - are added only for 4 of them in Black Vault by aura 
UPDATE creature_template SET UnitFlags = 64 WHERE Entry = 8905;

-- Weegli Blastfuse - Script Update 
-- Ukorz Sandscalp can yell without any error.
UPDATE dbscripts_on_creature_movement SET search_radius = 37996, data_flags = 0x10 WHERE id = 760713 and delay = 5;

-- Overlord Mok'Morokk - update
-- after defeted in quest "Challenge Overlord Mok'Morokk" he should respawn quicker for other players.
UPDATE creature SET spawntimesecs = 60 WHERE guid = 31442;

-- Improved quest 4265 based on UDB script by @Grz3s
UPDATE dbscripts_on_quest_start SET datalong2 = 18000 WHERE id = 4265 AND delay = 1;
UPDATE dbscripts_on_quest_start SET data_flags = 7 WHERE id = 4265 AND delay in (2, 6, 7, 12);
UPDATE dbscripts_on_quest_start SET delay = 13 WHERE delay = 12 AND id = 4265;
-- Slim's Friend
-- part of q.1249 'The Missing Diplomat' Part:11
DELETE FROM dbscripts_on_creature_death WHERE id = 4971;
INSERT INTO dbscripts_on_creature_death (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(4971,1,0,0,0,0,0,0,2000000602,0,0,0,0,0,0,0,'');
DELETE FROM db_script_string WHERE entry = 2000000602;
INSERT INTO db_script_string (entry, content_default, sound, type, language, emote, comment) VALUES
(2000000602,'Whoa! This is way more than what I bargained for, you\'re on your own, Slim!',0,0,0,0,NULL);

-- Scarlet Hound - should be only spawned as Scarlet Hunters Pet
DELETE FROM creature_addon WHERE guid IN (SELECT guid FROM creature WHERE id = 10979);
DELETE FROM creature_movement WHERE id IN (SELECT guid FROM creature WHERE id = 10979);
DELETE FROM creature WHERE id = 10979;
-- Mottled Worg - spawn point corrected
-- This closes #796
UPDATE creature SET position_x = 1012.858887, position_y = 1488.146973, position_z = 41.295895, orientation = 0.157890, spawndist = 5, movementType = 1 WHERE guid = 17952;
-- Removed wrong drop chance for item 12236 (Pure Un'Goro Sample) from NPC 7035 (Firegut Ogre)
-- This closes #798
DELETE FROM creature_loot_template WHERE entry = 7035 AND item = 12236;
-- Fixed damage of NPC 14986 (Shade of Jin'do): they must do shadow damage instead of physical
UPDATE `creature_template` SET `DamageSchool` = 5 WHERE `Entry` = 14986;

DELETE FROM `creature` WHERE `guid`='5721';

DELETE FROM `gameobject` WHERE `guid` IN ('7564', '7561', '51297');

DELETE FROM mangos_string WHERE entry=58;

INSERT INTO mangos_string VALUES
(58,'Using script library',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
-- Fixed a few errors introduced in previous commits

-- Removed emote that was not existing in Classic and replace it by state change
UPDATE `db_script_string` SET `emote` = 0 WHERE `entry` = 2000000522;
DELETE FROM dbscripts_on_quest_end WHERE id = 4129 AND delay IN (9, 11);
INSERT INTO dbscripts_on_quest_end (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(4129,9,1,64,0,0,0,0,0,0,0,0,0,0,0,0,''),
(4129,11,28,0,0,0,0,0,0,0,0,0,0,0,0,0,'');

-- Readded npc_text mistakenly removed in a previous commit
DELETE FROM npc_text WHERE ID = 6157;
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, prob0, em0_0, em0_1) VALUES
(6157, 'Hey there, friend. My name\'s Remy. I\'m from Redridge to the east, and came here looking for business, looking for business. You got any...got any??', 'Hey there, friend. My name\'s Remy. I\'m from Redridge to the east, and came here looking for business, looking for business. You got any...got any??', 0, 1, 0, 0);

-- Fixed condition with wrong entry
DELETE FROM conditions WHERE condition_entry IN (1145, 1147);
INSERT INTO conditions (condition_entry, type, value1, value2) VALUES
(1145, 8, 4289, 0);

-- Removed pickpocket and loot templates id from 3 NPCs: the entries were not existing and they should have none
UPDATE `creature_template` SET `PickpocketLootId` = 0, `LootId` = 0 WHERE `Entry` IN (5776, 5777, 5778);

-- Removed loot templates from NPCs that should have none
UPDATE `creature_template` SET `LootId` = 0 WHERE `Entry` IN (255, 15776, 15796);

-- Fixed wrong modelId of NPC 8927 (Dark Screecher) caused by a typo
UPDATE `creature_template` SET `ModelId1` = 1955 WHERE `Entry` = 8927;

-- Removed a few lingering creature addons left after the creature spawns were removed
DELETE FROM `creature_addon` WHERE `guid` IN (31839, 47259, 51692, 51697, 90587);
-- Fixed movement animation of water-only NPCs and of some NPCs that should walk
-- at water bottom instead of swimming
-- This closes #795
-- Thanks @Neotmiren for reporting and providing many data on how to fix this
-- Requires CMaNGOS core updates https://github.com/cmangos/mangos-classic/commit/7800ce6cdc171062751ac2b19aba51a1b7055fba
UPDATE creature_template SET ExtraFlags=ExtraFlags|0x8000 WHERE (InhabitType&2)!=0 AND (CreatureType IN (5) OR family IN (8));
UPDATE creature_template SET ExtraFlags=ExtraFlags|0x10000 WHERE (InhabitType&2)!=0 AND (CreatureType IN (5));
UPDATE `quest_template` SET `Details` = '$N, can you take one of the seeds you brought me to my friend, Rellian Greenspyre?  He is a druid in Darnassus, and when last we spoke he revealed his interest in my work with the Timberlings.  He had some ideas himself, and he will appreciate a specimen seed to work with.$B$BThank you, $N.  You have been a great help to me.  I hope that, some day, you will see the fruit of my labors.$B$BYou will usually find Rellian walking the pathways of the Cenarion Enclave in Darnassus.' WHERE `entry` = 922;-- Scripted quest 3982 (What is Going On?) in Blackrock Depths
-- This closes #688
-- Due to very little sources, timers, spawn points
-- and numbers of NPC per waves are educated guesswork
-- based on the following sources:
-- https://web.archive.org/web/20070105160522/http://wow.allakhazam.com/db/quest.html?wquest=3982
-- http://www.wowhead.com/quest=3982
-- http://www.wowhead.com/npc=9020

SET @WAVE_TIMER := 40; -- in seconds
SET @QUEST_CREDIT_TIMER := 50 + @WAVE_TIMER; -- in seconds
SET @ENTRY := 2000000186;

UPDATE `quest_template` SET `SpecialFlags` = 3, `StartScript` = 3982 WHERE `entry` = 3982;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 3982;
INSERT INTO dbscripts_on_quest_start (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(3982,0,21,1,0,0,0,0,0,0,0,0,0,0,0,0,'Gor\'shak active'),
(3982,1,22,495,0x01,0,0,0,0,0,0,0,0,0,0,0,'temp faction'),
(3982,1,0,0,0,0,0,0,@ENTRY,0,0,0,0,0,0,0,'say'),
(3982,3,10,8891,300000,0,0,0,0,0,0,0,379.509,-191.971,-69.718,3.4033,'1st wave'),
(3982,4,3,0,0,8891,20,0,0,0,0,0,372.17,-178.30,-70.03,3.4033,'move inside cell'),
(3982,4,10,8891,300000,0,0,0,0,0,0,0,376.053,-192.092,-70.561,1.8162,'1st wave'),
(3982,4,10,8891,300000,0,0,0,0,0,0,0,374.817,-190.909,-70.725,1.2256,'1st wave'),
(3982,3 + @WAVE_TIMER,34,317,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if player is dead or out of range'),
(3982,4 + @WAVE_TIMER,34,318,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if npc is dead'),
(3982,5 + @WAVE_TIMER,10,9398,300000,0,0,0,0,0,0,0,379.509,-191.971,-69.718,3.4033,'2nd wave'),
(3982,6 + @WAVE_TIMER,3,0,0,9398,20,0,0,0,0,0,372.17,-178.30,-70.03,3.4033,'move inside cell'),
(3982,6 + @WAVE_TIMER,10,8891,300000,0,0,0,0,0,0,0,376.053,-192.092,-70.561,1.8162,'2nd wave'),
(3982,6 + @WAVE_TIMER,10,8891,300000,0,0,0,0,0,0,0,374.817,-190.909,-70.725,1.2256,'2nd wave'),
(3982,7 + @QUEST_CREDIT_TIMER,34,317,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if player is dead or out of range'),
(3982,7 + @QUEST_CREDIT_TIMER,34,318,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if npc is dead'),
(3982,8 + @QUEST_CREDIT_TIMER,7,3982,0,0,0,0,0,0,0,0,0,0,0,0,'quest credit'),
(3982,9 + @QUEST_CREDIT_TIMER,21,0,0,0,0,0,0,0,0,0,0,0,0,0,'Gor\'shak unactive');

DELETE FROM `db_script_string` WHERE `entry` = @ENTRY;
INSERT INTO `db_script_string` VALUES (@ENTRY, 'Defend yourself, fool!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL);
-- Added missing Giant Surf Glider elite creatures in Tanaris
-- This closes #797 
-- These creatures are important for Hunters as the source of Bite, rank 7 (the only source ability available at the lowest possible level).
-- "It seems since this last patch that the giant elite turtles have been replaced by the smaller non elites.. I went all the way down there to tame one to learn bite 7 and there were NONE to be found, the place was covered with the normal ones.. :-("
-- By Sabrina on 2007/03/21 (Patch 2.0.10)
-- source: http://www.wowhead.com/npc=5432/giant-surf-glider


DELETE FROM `creature` WHERE `guid` IN (23660, 23692, 23621, 23642, 23703, 23623, 23659, 23628, 23691, 23653, 23615, 23681, 23677, 23640, 23630, 23651, 23635, 23696, 23683);
INSERT INTO creature (guid, id, map, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, curhealth, curmana, MovementType) VALUES
(23660, 5432, 1, -10260, -3792, 0.569, 2.841, 430, 4, 6702, 0, 1),
(23692, 5432, 1, -10257, -3874, 2.209, 2.441, 430, 4, 6702, 0, 1),
(23621, 5432, 1, -10254, -4093, 0.567, 3.711, 430, 4, 6702, 0, 1),
(23642, 5432, 1, -10200, -3943, 3.372, 1.621, 430,15, 6702, 0, 1),
(23703, 5432, 1, -10145, -3699, 0.151, 1.476, 430,15, 6702, 0, 1),
(23623, 5432, 1, -10103, -3846, 5.825, 0.791, 430,15, 6702, 0, 1),
(23659, 5432, 1, -10100, -4246, 0.558, 3.181, 430,15, 6702, 0, 1),
(23628, 5432, 1, -10021, -3726, 7.162, 0.37,  430,15, 6702, 0, 1),
(23691, 5432, 1, -10007, -3596, 0.59,  1.329, 430,15, 6702, 0, 1),
(23653, 5432, 1,  -9989, -4221, 6.916, 1.987, 430,15, 6702, 0, 1),
(23615, 5432, 1,  -9944, -4370, 0.551, 3.518, 430,15, 6702, 0, 1),
(23681, 5432, 1,  -9855, -3637, 11.177,6.259, 430,15, 6702, 0, 1),
(23677, 5432, 1,  -9855, -3556, 0.715, 2.209, 430,15, 6702, 0, 1),
(23640, 5432, 1,  -9836, -4304, 8.469, 1.723, 430,15, 6702, 0, 1),
(23630, 5432, 1,  -9754, -4453, 0.569, 4.148, 430,15, 6702, 0, 1),
(23651, 5432, 1,  -9718, -4372, 5.972, 3.225, 430,15, 6702, 0, 1),
(23635, 5432, 1,  -9628, -4404, 0.569, 1.831, 430,15, 6702, 0, 1);

UPDATE `creature_template` SET CreatureTypeFlags=CreatureTypeFlags|1, PetSpellDataId = 5931, SpeedWalk = 1 WHERE entry = 5432; -- tameable, has Bite 7
-- Fixed quest 3092 text to reflect actual player name
UPDATE `quest_template` SET `RequestItemsText` = 'Welcome to Camp Narache, $N. I hear good things about you. Your bloodline is strong, and many of the elders consider you skilled already. But that we will test.$B$BThe plains of Mulgore will be your home for sometime--you should do your best to learn it very well. One day you will travel to unfamilar lands to master greater skills. You must be ready.', `OfferRewardText` = 'And it is my job to make sure you are prepared by teaching you the basics of our profession--how to tame your pet, how to fire your rifle, and many other skills that will become necessary.$B$BHunters are a strong part of our tradition and history, $N. You would do well to remember how important you are to the tribe. You will be respected and revered if you serve our people well.' WHERE `entry` = 3092;
-- Added missing equipment for NPC 9398 (Twilight's Hammer Executioner) in Blackrock Depths
-- Source: Trinity DB
UPDATE `creature_template` SET `EquipmentTemplateId` = 156 WHERE `Entry` = 9398;
-- Moon Priestess Amara (GUID 46394) should be followed by Huntress Nhemai (GUID 46414) and Huntress Yaeliura (GUID 46416)
-- They previously had individual waypoint movement, which desyncs the group when Amara is stoping to give/accept her quest
-- Waypoints and timers are guesswork and still open to improvement but far better than the previous ones were.
-- This closes #799 

-- Updated Spawn positions
UPDATE creature SET position_x = '9847.158203',position_y = '1033.056885',position_z = '1304.841553',orientation = '1.598161', spawndist = 0 WHERE guid = '46394';
UPDATE creature SET position_x = '9848.743164',position_y = '1030.924561',position_z = '1304.877075',orientation = '1.598161', spawndist = 0 WHERE guid = '46416';
UPDATE creature SET position_x = '9844.817383',position_y = '1030.817139',position_z = '1304.843262',orientation = '1.598161', spawndist = 0 WHERE guid = '46414';

-- Link patrol together
UPDATE creature SET MovementType = 0 WHERE guid IN (46414,46416);
DELETE FROM creature_linking_template WHERE entry IN (2151,10604,10606);
INSERT INTO creature_linking_template VALUES (10604,1,2151,515,0); -- AGGRO_ON_AGGRO,TO_AGGRO_ON_AGGRO,FOLLOW
INSERT INTO creature_linking_template VALUES (10606,1,2151,515,0); -- AGGRO_ON_AGGRO,TO_AGGRO_ON_AGGRO,FOLLOW

-- Set new Waypoints,with 1 or 2 minute waittime on turning points
DELETE FROM creature_movement WHERE id IN (46394,46414,46416);
DELETE FROM creature_movement_template WHERE entry IN (2151,10604,10606);
INSERT INTO creature_movement_template (entry,point,position_x,position_y,position_z,orientation,waittime,script_id) VALUES
(2151,1,9848.04,1041.22,1304.85,100,0,0),
(2151,2,9858.52,1069.36,1307.46,100,0,0),
(2151,3,9875.29,1083.34,1308.01,100,0,0),
(2151,4,9882.02,1097.79,1307.99,100,0,0),
(2151,5,9883.15,1111.71,1307.96,100,0,0),
(2151,6,9890,1120.49,1307.86,100,0,0),
(2151,7,9907.28,1132.35,1307.9,100,0,0),
(2151,8,9914.82,1147.38,1307.86,100,0,0),
(2151,9,9918.2,1163.74,1307.88,100,0,0),
(2151,10,9916.63,1182.79,1308.02,100,0,0),
(2151,11,9911.21,1195.08,1308.58,100,0,0),
(2151,12,9909.48,1204.53,1308.46,100,0,0),
(2151,13,9911.23,1216.3,1307.86,100,0,0),
(2151,14,9922.35,1235.1,1307.82,100,0,0),
(2151,15,9930.69,1241.98,1307.91,100,0,0),
(2151,16,9939.68,1245.05,1307.84,100,0,0),
(2151,17,9950.57,1245.9,1307.82,100,0,0),
(2151,18,9974.05,1243.7,1307.86,100,0,0),
(2151,19,9986.35,1244.66,1307.86,100,0,0),
(2151,20,9996.67,1249.89,1307.86,100,0,0),
(2151,21,10004.9,1258.47,1307.86,100,0,0),
(2151,22,10019.9,1280.59,1307.57,100,60000,0),
(2151,23,10004.9,1258.47,1307.86,100,0,0),
(2151,24,9996.67,1249.89,1307.86,100,0,0),
(2151,25,9986.35,1244.66,1307.86,100,0,0),
(2151,26,9974.05,1243.7,1307.86,100,0,0),
(2151,27,9950.57,1245.9,1307.82,100,0,0),
(2151,28,9939.68,1245.05,1307.84,100,0,0),
(2151,29,9930.69,1241.98,1307.91,100,0,0),
(2151,30,9922.35,1235.1,1307.82,100,0,0),
(2151,31,9911.23,1216.3,1307.86,100,0,0),
(2151,32,9909.48,1204.53,1308.46,100,0,0),
(2151,33,9911.21,1195.08,1308.58,100,0,0),
(2151,34,9916.63,1182.79,1308.02,100,0,0),
(2151,35,9918.2,1163.74,1307.88,100,0,0),
(2151,36,9914.82,1147.38,1307.86,100,0,0),
(2151,37,9907.28,1132.35,1307.9,100,0,0),
(2151,38,9890,1120.49,1307.86,100,0,0),
(2151,39,9883.15,1111.71,1307.96,100,0,0),
(2151,40,9882.02,1097.79,1307.99,100,0,0),
(2151,41,9875.29,1083.34,1308.01,100,0,0),
(2151,42,9858.52,1069.36,1307.46,100,0,0),
(2151,43,9848.04,1041.22,1304.85,100,0,0),
(2151,44,9847.16,1033.06,1304.84,100,0,0),
(2151,45,9846.97,1016.45,1305.5,100,0,0),
(2151,46,9846.9,1001.48,1305.45,100,0,0),
(2151,47,9848.38,984.463,1305.21,100,120000,0),
(2151,48,9847.17,1002.49,1305.47,100,0,0),
(2151,49,9847.01,1016.18,1305.5,100,0,0),
(2151,50,9847.45,1033.03,1304.85,100,0,0);
-- Added more flavor text to NPC 9500 (Mistress Nagmara) in Blackrock Depths
-- Now she will have chit-chat with the nearby patrons while she wanders
-- in the Grim Guzzler bar
-- Also added gossip menu option for players having completed the 
-- Potion of Love quest (4201), the script will be handled by SD2
-- source: https://www.youtube.com/watch?v=GR_CQ-eC6ns
-- http://www.wowhead.com/npc=9500/mistress-nagmara#comments
-- and Trinity DB

SET @ENTRY := 2000000260;

DELETE FROM `db_script_string` WHERE `entry` BETWEEN @ENTRY + 1 AND @ENTRY + 7;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(@ENTRY + 1, 'Hey Nagmara! How about a mug of Dark Iron Ale?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL),
(@ENTRY + 2, 'Nagmara! Have any mutton left?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@ENTRY + 3, 'Mistress, you tell Plugger that I want more of his ale. I can\'t get enough!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL),
(@ENTRY + 4, 'Hey Nag, how about you slice me off a piece of that...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL),
(@ENTRY + 5, 'You got it!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL),
(@ENTRY + 6, 'Coming right up!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL),
(@ENTRY + 7, 'I\'ll bring it right over, baby...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL);

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 950001;
INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(950001, 0, 0, 0, 0, 9545, 20, 0, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Grim Patron - Say 1, 2, 3 or 4'),
(950001, 0, 36, 0, 0, 9545, 20, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Face Nagmara'),
(950001, 1, 36, 0, 0, 9545, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mistress Nagmara - Face Grim Patron'),
(950001, 2, 0, 0, 0, 0, 0, 0, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, 0, 0, 0, 0, 0, 'Mistress Nagmara - Say 1, 2 or 3'),
(950001, 4, 36, 1, 0, 9545, 20, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - restore orientation'),
(950001, 5, 36, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mistress Nagmara - restore orientation');

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 950002;
INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(950002, 0, 0, 0, 0, 9547, 20, 0, @ENTRY + 1, @ENTRY + 2, @ENTRY + 3, @ENTRY + 4, 0, 0, 0, 0, 'Grim Patron - Say 1, 2, 3 or 4'),
(950002, 0, 36, 0, 0, 9547, 20, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Face Nagmara'),
(950002, 1, 36, 0, 0, 9547, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mistress Nagmara - Face Guzzling Patron'),
(950002, 2, 0, 0, 0, 0, 0, 0, @ENTRY + 5, @ENTRY + 6, @ENTRY + 7, 0, 0, 0, 0, 0, 'Mistress Nagmara - Say 1, 2 or 3'),
(950002, 4, 36, 1, 0, 9547, 20, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - restore orientation'),
(950002, 5, 36, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mistress Nagmara - restore orientation');

UPDATE `creature_movement_template` SET `script_id` = 950002, waittime = 5000 WHERE `entry` = 9500 AND `point` = 7;
UPDATE `creature_movement_template` SET `script_id` = 950002, waittime = 5000 WHERE `entry` = 9500 AND `point` = 15;
UPDATE `creature_movement_template` SET `script_id` = 950001, waittime = 5000 WHERE `entry` = 9500 AND `point` = 12;

SET @CONDITION := 125;

DELETE FROM `conditions` WHERE `condition_entry` = @CONDITION;
INSERT INTO `conditions` VALUES
(@CONDITION, 8, 4201, 0);

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 2076;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES 
(2076, 0, 0, 'Why don\'t you and Rocknot go find somewhere private...', 1, 1, -1, 0, 0, 0, 0, '', @CONDITION);

DROP TABLE IF EXISTS `custom_texts`;
CREATE TABLE `custom_texts` (
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Custom Texts';

DROP TABLE IF EXISTS `gossip_texts`;
CREATE TABLE `gossip_texts` (
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `comment` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Gossip Texts';

DROP TABLE IF EXISTS `script_texts`;
CREATE TABLE `script_texts` (
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY  (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Script Texts';

DROP TABLE IF EXISTS `script_waypoint`;
CREATE TABLE script_waypoint (
  entry mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'creature_template entry',
  pointid mediumint(8) unsigned NOT NULL DEFAULT '0',
  location_x float NOT NULL DEFAULT '0',
  location_y float NOT NULL DEFAULT '0',
  location_z float NOT NULL DEFAULT '0',
  waittime int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'waittime in millisecs',
  point_comment text,
  PRIMARY KEY (entry, pointid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Script Creature waypoints';
-- Moved creature_addons of NPC 5431 (Surf Glider) to creature_template_addon since they are all using the same addon
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 5431);
DELETE FROM `creature_template_addon` WHERE `entry` = 5431;
INSERT INTO `creature_template_addon` VALUES
(5431, 0, 0, 1, 16, 0, 0, NULL);
        

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
