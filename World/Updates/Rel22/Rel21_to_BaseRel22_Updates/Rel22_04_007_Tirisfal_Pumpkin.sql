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
    SET @cOldContent = '006';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '04';
    SET @cNewContent = '007';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Tirisfal Pumpkin';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Tirisfal Pumpkin';

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

	-- Add more spawns and adjust respawn time from 360 to 120.
	DELETE FROM `gameobject` WHERE `id` = 375;
	INSERT INTO `gameobject` (`guid`,`id`, `map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
	(45042,375,0,2431.47,1591.2,37.0613,0.488692,0,0,0.241922,0.970296,120,100,1),
	(45043,375,0,2351.13,1324.59,33.3334,0.293625,0,0,0.146286,0.989242,120,255,1),
	(45157,375,0,2284.49,1470.76,33.4333,1.22173,0,0,0.573576,0.819152,120,100,1),
	(45194,375,0,2293.58,1396.66,33.4333,-1.55334,0,0,-0.700908,0.713252,120,100,1),
	(45195,375,0,2259.64,1430.03,33.4525,2.3911,0,0,0.930417,0.366502,120,100,1),
	(45196,375,0,2304,1439.05,33.4333,-0.750491,0,0,-0.366501,0.930418,120,100,1),
	(45197,375,0,2355.96,1348.1,33.4333,2.84489,0,0,0.989016,0.147808,120,100,1),
	(45198,375,0,2348.16,1405.88,33.3189,1.46608,0,0,0.669132,0.743144,120,100,1),
	(45200,375,0,2279.18,1450.29,33.4333,-1.74533,0,0,-0.766045,0.642787,120,100,1),
	(45201,375,0,2263.35,1480.02,33.4491,1.97222,0,0,0.833885,0.551938,120,100,1);
	INSERT INTO `gameobject` (`id`, `map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
	(375,0,2363.91,1348.38,33.3324,3.84784,0,0,0.938297,-0.345831,120,255,1),
	(375,0,2360.47,1399.62,33.0846,3.9146,0,0,0.926233,-0.376952,120,255,1),
	(375,0,2340.72,1352.37,33.3341,0.344954,0,0,0.171623,0.985163,120,255,1),
	(375,0,2341.88,1344.28,33.3341,5.63673,0,0,0.31763,-0.948215,120,255,1),
	(375,0,2305.16,1357.46,33.3335,4.13272,0,0,0.879701,-0.475526,120,255,1),
	(375,0,2329.93,1378.17,33.3335,0.446058,0,0,0.221185,0.975232,120,255,1),
	(375,0,2318.93,1398,33.3335,2.74335,0,0,0.980241,0.197809,120,255,1),
	(375,0,2305.13,1347.16,33.3334,4.94245,0,0,0.621275,-0.783592,120,255,1),
	(375,0,2300.79,1352.3,33.3334,3.07713,0,0,0.999481,0.0322268,120,255,1),
	(375,0,2276.21,1362.27,33.3335,3.29704,0,0,0.996981,-0.0776452,120,255,1),
	(375,0,2265.59,1354.08,33.3335,4.40528,0,0,0.80694,-0.590634,120,255,1),
	(375,0,2268.72,1403.56,33.3334,0.24895,0,0,0.124154,0.992263,120,255,1),
	(375,0,2287.5,1419.42,33.3334,0.307855,0,0,0.153321,0.988177,120,255,1),
	(375,0,2304.68,1471.36,33.3334,1.05791,0,0,0.504632,0.863335,120,255,1),
	(375,0,2304.19,1477.65,33.3334,1.05791,0,0,0.504632,0.863335,120,255,1),
	(375,0,2294.94,1477.74,33.3334,6.25332,0,0,0.0149322,-0.999889,120,255,1),
	(375,0,2333.19,1478.31,33.3334,0.468867,0,0,0.232292,0.972646,120,255,1),
	(375,0,2339.75,1485.74,33.435,0.417816,0,0,0.207392,0.978258,120,255,1),
	(375,0,2362.05,1474.94,33.3341,5.06267,0,0,0.57308,-0.8195,120,255,1),
	(375,0,2337,1446.25,33.3341,4.10919,0,0,0.885234,-0.465147,120,255,1),
	(375,0,2337.31,1453.2,33.3341,2.26351,0,0,0.905159,0.425073,120,255,1);
	DELETE FROM `gameobject` WHERE `id` = 375;
	INSERT INTO `gameobject` (`guid`,`id`, `map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
	(45042,375,0,2431.47,1591.2,37.0613,0.488692,0,0,0.241922,0.970296,120,100,1),
	(45043,375,0,2351.13,1324.59,33.3334,0.293625,0,0,0.146286,0.989242,120,255,1),
	(45157,375,0,2284.49,1470.76,33.4333,1.22173,0,0,0.573576,0.819152,120,100,1),
	(45194,375,0,2293.58,1396.66,33.4333,-1.55334,0,0,-0.700908,0.713252,120,100,1),
	(45195,375,0,2259.64,1430.03,33.4525,2.3911,0,0,0.930417,0.366502,120,100,1),
	(45196,375,0,2304,1439.05,33.4333,-0.750491,0,0,-0.366501,0.930418,120,100,1),
	(45197,375,0,2355.96,1348.1,33.4333,2.84489,0,0,0.989016,0.147808,120,100,1),
	(45198,375,0,2348.16,1405.88,33.3189,1.46608,0,0,0.669132,0.743144,120,100,1),
	(45200,375,0,2279.18,1450.29,33.4333,-1.74533,0,0,-0.766045,0.642787,120,100,1),
	(45201,375,0,2263.35,1480.02,33.4491,1.97222,0,0,0.833885,0.551938,120,100,1);
	INSERT INTO `gameobject` (`id`, `map`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
	(375,0,2363.91,1348.38,33.3324,3.84784,0,0,0.938297,-0.345831,120,255,1),
	(375,0,2360.47,1399.62,33.0846,3.9146,0,0,0.926233,-0.376952,120,255,1),
	(375,0,2340.72,1352.37,33.3341,0.344954,0,0,0.171623,0.985163,120,255,1),
	(375,0,2341.88,1344.28,33.3341,5.63673,0,0,0.31763,-0.948215,120,255,1),
	(375,0,2305.16,1357.46,33.3335,4.13272,0,0,0.879701,-0.475526,120,255,1),
	(375,0,2329.93,1378.17,33.3335,0.446058,0,0,0.221185,0.975232,120,255,1),
	(375,0,2318.93,1398,33.3335,2.74335,0,0,0.980241,0.197809,120,255,1),
	(375,0,2305.13,1347.16,33.3334,4.94245,0,0,0.621275,-0.783592,120,255,1),
	(375,0,2300.79,1352.3,33.3334,3.07713,0,0,0.999481,0.0322268,120,255,1),
	(375,0,2276.21,1362.27,33.3335,3.29704,0,0,0.996981,-0.0776452,120,255,1),
	(375,0,2265.59,1354.08,33.3335,4.40528,0,0,0.80694,-0.590634,120,255,1),
	(375,0,2268.72,1403.56,33.3334,0.24895,0,0,0.124154,0.992263,120,255,1),
	(375,0,2287.5,1419.42,33.3334,0.307855,0,0,0.153321,0.988177,120,255,1),
	(375,0,2304.68,1471.36,33.3334,1.05791,0,0,0.504632,0.863335,120,255,1),
	(375,0,2304.19,1477.65,33.3334,1.05791,0,0,0.504632,0.863335,120,255,1),
	(375,0,2294.94,1477.74,33.3334,6.25332,0,0,0.0149322,-0.999889,120,255,1),
	(375,0,2333.19,1478.31,33.3334,0.468867,0,0,0.232292,0.972646,120,255,1),
	(375,0,2339.75,1485.74,33.435,0.417816,0,0,0.207392,0.978258,120,255,1),
	(375,0,2362.05,1474.94,33.3341,5.06267,0,0,0.57308,-0.8195,120,255,1),
	(375,0,2337,1446.25,33.3341,4.10919,0,0,0.885234,-0.465147,120,255,1),
	(375,0,2337.31,1453.2,33.3341,2.26351,0,0,0.905159,0.425073,120,255,1);

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


