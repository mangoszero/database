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
    SET @cOldContent = '052';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '14';
    SET @cNewContent = '053';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'HarvestFestivalGo';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'HarvestFestivalGo';

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


-- Insert missing Harvest Festival gameobjects
DELETE
FROM
	`gameobject`
WHERE
	`guid` IN (
		31415,
		31416,
		31417,
		31418,
		31419,
		34188,
		34189,
		34190,
		34191,
		34192,
		34193,
		34194
	);
INSERT INTO
	`gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`)
VALUES
	(31415, 180372, 0, -5082.25, -800.448, 496.03, -0.191986, 0, 0, 0.095846, -0.995396, 10, 100, 1),
	(31416, 180372, 0, -5085.64, -799.931, 496.03, -0.226893, 0, 0, 0.113203, -0.993572, 10, 100, 1),
	(31417, 180372, 0, -5089.05, -799.469, 496.03, -2.11185, 0, 0, 0.870356, -0.492423, 10, 100, 1),
	(31418, 180371, 0, -5077.29, -800.179, 496.03, 2.32129, 0, 0, 0.91706, 0.398749, 10, 100, 1),
	(31419, 180371, 0, -5089.05, -799.469, 496.03, -2.11185, 0, 0, 0.870356, -0.492423, 10, 100, 1),
	(34188, 180372, 1, 1326.97, -4416.36, 27.5984, -1.6057, 0, 0, 0.71934, -0.694658, 10, 100, 1),
	(34189, 180371, 1, 1340.36, -4414.08, 28.0881, 1.98968, 0, 0, 0.838671, 0.544639, 10, 100, 1),
	(34190, 180371, 1, 1341.04, -4421.81, 27.6249, 0.383972, 0, 0, 0.190809, 0.981627, 10, 100, 1),
	(34191, 180371, 1, 1337.53, -4411.01, 28.0848, -0.680679, 0, 0, 0.333807, -0.942641, 10, 100, 1),
	(34192, 180371, 1, 1329.31, -4413.13, 27.6023, 0.680678, 0, 0, 0.333807, 0.942641, 10, 100, 1),
	(34193, 180370, 1, 1327.37, -4423.33, 27.4349, 2.53073, 0, 0, 0.953717, 0.300706, 10, 100, 1),
	(34194, 180370, 1, 1330.72, -4425.71, 27.4281, 0.750492, 0, 0, 0.366501, 0.930418, 10, 100, 1);
-- Bind added Harvest Festival gameobjects to Harvest Festival event 33
DELETE
FROM
	`game_event_gameobject`
WHERE
	`guid` IN (
		31415,
		31416,
		31417,
		31418,
		31419,
		34188,
		34189,
		34190,
		34191,
		34192,
		34193,
		34194
	);
INSERT INTO
	`game_event_gameobject` (`guid`, `event`)
VALUES
	(31415, 33),
	(31416, 33),
	(31417, 33),
	(31418, 33),
	(31419, 33),
	(34188, 33),
	(34189, 33),
	(34190, 33),
	(34191, 33),
	(34192, 33),
	(34193, 33),
	(34194, 33);

-- Update spawntime from 180 to 10
UPDATE
	`gameobject`
SET
	`spawntimesecs` = 10
WHERE
	`guid` IN (
		31388,
		31967,
		29870,
		31968,
		31965,
		31389,
		31392,
		31418,
		31393,
		31391,
		31395,
		30875,
		31415,
		29868,
		31396,
		31416,
		30362,
		31969,
		31417,
		31419,
		30364,
		35784,
		34189,
		35777,
		35780,
		34190,
		35774,
		35778,
		34191,
		35786,
		35776,
		34192,
		35785,
		35775,
		35779,
		35781,
		34047,
		35783,
		34193,
		35787,
		34046,
		34194,
		34188,
		34048,
		35788
	);

-- Pool the different foods at the table
-- Make way for the pools
UPDATE
	`pool_template`
SET
	`entry` = 30001
WHERE
	`entry` = 1701 AND
	`description` = 'Dire Maul Arena - Rare Elites';
UPDATE
	`pool_creature`
SET
	`pool_entry` = 30001
WHERE
	`guid` IN (590013, 590014, 590015);

DELETE
FROM
	`pool_template`
WHERE
	`entry` IN (
		1701,
		1702,
		1703,
		1704,
		1705,
		1706,
		1707,
		1708,
		1709,
		1710,
		1711,
		1712,
		1713,
		1714,
		1715
	);
INSERT INTO
	`pool_template` (`entry`, `max_limit`, `description`)
VALUES
	(1701, 1, 'Orgrimmar Harvest Festival Food 1'),
	(1702, 1, 'Orgrimmar Harvest Festival Food 2'),
	(1703, 1, 'Orgrimmar Harvest Festival Food 3'),
	(1704, 1, 'Orgrimmar Harvest Festival Food 4'),
	(1705, 1, 'Orgrimmar Harvest Festival Food 5'),
	(1706, 1, 'Orgrimmar Harvest Festival Food 6'),
	(1707, 1, 'Orgrimmar Harvest Festival Food 7'),
	(1708, 1, 'Orgrimmar Harvest Festival Food 8'),
	(1709, 1, 'Ironforge Harvest Festival Food 1'),
	(1710, 1, 'Ironforge Harvest Festival Food 2'),
	(1711, 1, 'Ironforge Harvest Festival Food 3'),
	(1712, 1, 'Ironforge Harvest Festival Food 4'),
	(1713, 1, 'Ironforge Harvest Festival Food 5'),
	(1714, 1, 'Ironforge Harvest Festival Food 6'),
	(1715, 1, 'Ironforge Harvest Festival Food 7');
DELETE
FROM
	`pool_gameobject`
WHERE
	`guid` IN (
		31388,
		31967,
		29870,
		31968,
		31965,
		31389,
		31392,
		31418,
		31393,
		31391,
		31395,
		30875,
		31415,
		29868,
		31396,
		31416,
		30362,
		31969,
		31417,
		31419,
		30364,
		35784,
		34189,
		35777,
		35780,
		34190,
		35774,
		35778,
		34191,
		35786,
		35776,
		34192,
		35785,
		35775,
		35779,
		35781,
		34047,
		35783,
		34193,
		35787,
		34046,
		34194,
		34188,
		34048,
		35788
	);
INSERT INTO
	`pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`)
VALUES
	(31388, 1709, 33.33, 'Ironforge Harvest Festival Boar 1'),
	(31967, 1709, 33.33, 'Ironforge Harvest Festival Fish 1'),
	(29870, 1709, 33.34, 'Ironforge Harvest Festival Fruit 1'),
	(31968, 1710, 33.33, 'Ironforge Harvest Festival Boar 2'),
	(31965, 1710, 33.33, 'Ironforge Harvest Festival Fish 2'),
	(31389, 1710, 33.34, 'Ironforge Harvest Festival Fruit 2'),
	(31392, 1711, 33.33, 'Ironforge Harvest Festival Boar 3'),
	(31418, 1711, 33.33, 'Ironforge Harvest Festival Fish 3'),
	(31393, 1711, 33.34, 'Ironforge Harvest Festival Fruit 3'),
	(31391, 1712, 33.33, 'Ironforge Harvest Festival Boar 4'),
	(31395, 1712, 33.33, 'Ironforge Harvest Festival Fish 4'),
	(30875, 1712, 33.34, 'Ironforge Harvest Festival Fruit 4'),
	(31415, 1713, 33.33, 'Ironforge Harvest Festival Boar 5'),
	(29868, 1713, 33.33, 'Ironforge Harvest Festival Fish 5'),
	(31396, 1713, 33.34, 'Ironforge Harvest Festival Fruit 5'),
	(31416, 1714, 33.33, 'Ironforge Harvest Festival Boar 6'),
	(30362, 1714, 33.33, 'Ironforge Harvest Festival Fish 6'),
	(31969, 1714, 33.34, 'Ironforge Harvest Festival Fruit 6'),
	(31417, 1715, 33.33, 'Ironforge Harvest Festival Boar 7'),
	(31419, 1715, 33.33, 'Ironforge Harvest Festival Fish 7'),
	(30364, 1715, 33.34, 'Ironforge Harvest Festival Fruit 7'),
	(35784, 1701, 33.33, 'Orgrimmar Harvest Festival Boar 1'),
	(34189, 1701, 33.33, 'Orgrimmar Harvest Festival Fish 1'),
	(35777, 1701, 33.34, 'Orgrimmar Harvest Festival Fruit 1'),
	(35780, 1702, 33.33, 'Orgrimmar Harvest Festival Boar 2'),
	(34190, 1702, 33.33, 'Orgrimmar Harvest Festival Fish 2'),
	(35774, 1702, 33.34, 'Orgrimmar Harvest Festival Fruit 2'),
	(35778, 1703, 33.33, 'Orgrimmar Harvest Festival Boar 3'),
	(34191, 1703, 33.33, 'Orgrimmar Harvest Festival Fish 3'),
	(35786, 1703, 33.34, 'Orgrimmar Harvest Festival Fruit 3'),
	(35776, 1704, 33.33, 'Orgrimmar Harvest Festival Boar 4'),
	(34192, 1704, 33.33, 'Orgrimmar Harvest Festival Fish 4'),
	(35785, 1704, 33.34, 'Orgrimmar Harvest Festival Fruit 4'),
	(35775, 1705, 33.33, 'Orgrimmar Harvest Festival Boar 5'),
	(35779, 1705, 33.33, 'Orgrimmar Harvest Festival Fish 5'),
	(35781, 1705, 33.34, 'Orgrimmar Harvest Festival Fruit 5'),
	(34047, 1706, 33.33, 'Orgrimmar Harvest Festival Boar 6'),
	(35783, 1706, 33.33, 'Orgrimmar Harvest Festival Fish 6'),
	(34193, 1706, 33.34, 'Orgrimmar Harvest Festival Fruit 6'),
	(35787, 1707, 33.33, 'Orgrimmar Harvest Festival Boar 7'),
	(34046, 1707, 33.33, 'Orgrimmar Harvest Festival Fish 7'),
	(34194, 1707, 33.34, 'Orgrimmar Harvest Festival Fruit 7'),
	(34188, 1708, 33.33, 'Orgrimmar Harvest Festival Boar 8'),
	(34048, 1708, 33.33, 'Orgrimmar Harvest Festival Fish 8'),
	(35788, 1708, 33.34, 'Orgrimmar Harvest Festival Fruit 8');



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
