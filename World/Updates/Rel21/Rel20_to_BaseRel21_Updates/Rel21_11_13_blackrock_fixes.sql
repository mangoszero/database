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
    SET @cOldContent = '12'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '13';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Blackrock fixes';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Some Blackrock fixes and Fixed quest 2936';

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

-- Fixed stats and flags for creatures summoned by Scarshield Warlocks in Lower Blackrock Spire

-- Scarshield Portal (9707)
UPDATE creature_template SET UnitFlags = 33555200 WHERE Entry = 9707;

-- Burning Imp (9708)
UPDATE creature_template SET SpeedWalk=1, DamageMultiplier=1.4, MinMeleeDmg=92, MaxMeleeDmg=125, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=228, RangedAttackPower=23, MeleeBaseAttackTime=2000, RangedBaseAttackTime=2000, AIName='EventAI' WHERE Entry=9708;

-- Burning Felhound (10261)
UPDATE creature_template SET SpeedWalk=1, DamageMultiplier=2.0, MinMeleeDmg=111, MaxMeleeDmg=150, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=228, RangedAttackPower=23, MeleeBaseAttackTime=2400, RangedBaseAttackTime=2400 WHERE Entry=10261;
-- Burning Felguard (10263)
UPDATE creature_template SET FactionAlliance=90,FactionHorde=90, Rank=2, SpeedWalk=1, DamageMultiplier=4.5, MinMeleeDmg=110, MaxMeleeDmg=149, MinRangedDmg=0, MaxRangedDmg=0, MeleeAttackPower=238, RangedAttackPower=24, MeleeBaseAttackTime=2300, RangedBaseAttackTime=2300 WHERE Entry=10263;


-- Fixed spawns position and pools for rare ogres NPCs in Lower Blackrock Spire
-- Thanks @metalica for reporting.
-- Sources:
-- http://www.wowhead.com/npc=9219/spirestone-butcher#comments
-- http://www.wowhead.com/npc=9217/spirestone-lord-magus#comments
-- http://www.wowhead.com/npc=9218/spirestone-battle-lord#comments

SET @POOL := 25501;

-- Spirestone Battle Lord (9218)
UPDATE creature SET position_x=-52.41, position_y=-306.9, position_z=43.34, orientation=5.53 WHERE id = 9218;
UPDATE creature_template SET Rank=2 WHERE Entry=9218;

DELETE FROM pool_creature WHERE guid IN (43517, 43519);
INSERT INTO pool_creature VALUES
(43517, @POOL + 1, 0, 'Spirestone Battle Lord/Placeholder'),
(43519, @POOL + 1, 15, 'Spirestone Battle Lord/Placeholder');

DELETE FROM pool_template WHERE entry = @POOL + 1;
INSERT INTO pool_template VALUES
(@POOL + 1, 1, 'Spirestone Battle Lord/Placeholder');

-- Spirestone Lord Magus (9217)
UPDATE creature SET position_x=-58.87, position_y=-320.75, position_z=44.13, orientation=5.53 WHERE id = 9217;
UPDATE creature_template SET Rank=2, EquipmentTemplateId=1023 WHERE Entry=9217;

DELETE FROM pool_creature WHERE guid IN (43516, 43521);
INSERT INTO pool_creature VALUES
(43516, @POOL + 2, 0, 'Spirestone Lord Magus/Placeholder'),
(43521, @POOL + 2, 30, 'Spirestone Lord Magus/Placeholder');

DELETE FROM pool_template WHERE entry = @POOL + 2;
INSERT INTO pool_template VALUES
(@POOL + 2, 1, 'Spirestone Lord Magus/Placeholder');

-- Spirestone Butcher (9219)
UPDATE creature SET position_x=-37.05, position_y=-387.07, position_z=31.8, orientation=4.65, MovementType=2 WHERE id = 9219;
UPDATE creature_template SET Rank=2 WHERE Entry=9219;

DELETE FROM creature_movement_template WHERE entry = 9219;
INSERT INTO creature_movement_template VALUES
(9219, 1, -37.05, -387.07, 31.8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.65, 0, 0),
(9219, 2, -36.5, -478.69, 29.99, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.6, 0, 0);

UPDATE creature SET MovementType=2 WHERE guid = 43507;

DELETE FROM creature_movement WHERE id = 43507;
INSERT INTO creature_movement VALUES
(43507, 1, -37.05, -387.07, 31.8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.65, 0, 0),
(43507, 2, -36.5, -478.69, 29.99, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.6, 0, 0);

DELETE FROM pool_creature WHERE guid IN (43507, 43523);
INSERT INTO pool_creature VALUES
(43507, @POOL + 3, 0, 'Spirestone Butcher/Placeholder'),
(43523, @POOL + 3, 30, 'Spirestone Butcher/Placeholder');

DELETE FROM pool_template WHERE entry = @POOL + 3;
INSERT INTO pool_template VALUES
(@POOL + 3, 1, 'Spirestone Butcher/Placeholder');


-- Fixed quest 2936 (The Spider God) in Zul'Farrak
-- Gossip menu was missing
-- Thanks TheTrueAnimal for pointing and Rushor and trimken for providing data
-- Source: http://www.wowhead.com/object=142715/tablet-of-theka#comments
-- http://www.wowhead.com/quest=2936/the-spider-god

SET @CONDITION := 832;

DELETE FROM `conditions` WHERE `condition_entry` = @CONDITION;
INSERT INTO `conditions` VALUES
(@CONDITION, 9, 2936, 0);

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 1053;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, condition_id) VALUES
(1053, 0, 0, 'Continue.', 1, 1, 1054, 0, 0, 0, 0, '', @CONDITION);

DELETE FROM `gossip_menu` WHERE `entry` = 1054;
INSERT INTO `gossip_menu` VALUES
(1054, 1654, 105401, 0);

DELETE FROM `db_scripts` WHERE `id` = 105301 AND script_type=2;
INSERT INTO `db_scripts` (`script_type`,`id`,`delay`,`command`,`datalong`,`datalong2`,`buddy_entry`,`search_radius`,`data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`,`x`,`y`,`z`,`o`,`comments`) VALUES
(2,105401, 0, 7, 2936, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

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
