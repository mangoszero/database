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
    SET @cOldContent = '14'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '15';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Taelan_fixes';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fixed missing Taelan waypoint';

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

-- The Rake
UPDATE creature_template SET MeleeBaseAttackTime = 1200 WHERE Entry = 5807;

DELETE FROM script_waypoint where entry=1842;
INSERT INTO script_waypoint VALUES
(1842, 0, 2941.748, -1391.816, 167.237, 0, 'SAY_ESCORT_START'),
(1842, 1, 2940.561,-1393.641, 165.943, 0, ''),
(1842, 2, 2932.194,-1410.657, 165.943, 0, ''),
(1842, 3, 2921.808,-1405.087, 165.943, 0, ''),
(1842, 4, 2916.479,-1402.582, 165.943, 0, ''),
(1842, 5, 2918.523,-1398.121, 165.943, 0, ''),
(1842, 6, 2922.801,-1389.494, 160.842, 0, ''),
(1842, 7, 2924.931,-1385.645, 160.842, 0, ''),
(1842, 8, 2930.931,-1388.654, 160.842, 0, ''),
(1842, 9, 2946.701,-1396.646, 160.842, 0, ''),
(1842, 10, 2948.721,-1392.789, 160.842, 0, ''),
(1842, 11, 2951.979,-1386.616, 155.948, 0, ''),
(1842, 12, 2953.836,-1383.326, 155.948, 0, ''),
(1842, 13, 2951.192,-1381.740, 155.948, 0, ''),
(1842, 14, 2946.675,-1379.287, 152.020, 0, ''),
(1842, 15, 2942.795,-1377.661, 152.020, 0, ''),
(1842, 16, 2935.488,-1392.522, 152.020, 0, ''),
(1842, 17, 2921.167,-1384.796, 152.020, 0, ''),
(1842, 18, 2915.331,-1395.354, 152.020, 0, ''),
(1842, 19, 2926.250,-1401.263, 152.028, 0, ''),
(1842, 20, 2930.321,-1403.479, 150.521, 0, ''),
(1842, 21, 2933.936,-1405.357, 150.521, 0, ''),
(1842, 22, 2929.221,-1415.786, 150.504, 0, ''),
(1842, 23, 2921.173,-1431.680, 150.781, 0, ''),
(1842, 24, 2917.470,-1438.781, 150.781, 0, ''),
(1842, 25, 2913.048, -1453.524, 148.098, 0, 'SAY_TAELAN_MOUNT'),
(1842, 26, 2913.832,-1474.930, 146.224, 0, ''),
(1842, 27, 2906.815,-1487.061, 146.224, 0, ''),
(1842, 28, 2900.644,-1496.575, 146.306, 0, ''),
(1842, 29, 2885.249,-1501.585, 146.020, 0, ''),
(1842, 30, 2863.877,-1500.380, 146.681, 0, ''),
(1842, 31, 2846.509,-1487.183, 146.332, 0, ''),
(1842, 32, 2823.752,-1490.987, 145.782, 0, ''),
(1842, 33, 2800.984,-1510.907, 145.049, 0, ''),
(1842, 34, 2789.488,-1525.215, 143.729, 0, ''),
(1842, 35, 2776.964,-1542.305, 139.435, 0, ''),
(1842, 36, 2762.032,-1561.804, 133.763, 0, ''),
(1842, 37, 2758.741,-1569.599, 131.514, 0, ''),
(1842, 38, 2765.488,-1588.793, 129.721, 0, ''),
(1842, 39, 2779.613,-1613.120, 129.132, 0, ''),
(1842, 40, 2757.654,-1638.032, 128.236, 0, ''),
(1842, 41, 2741.308,-1659.790, 126.457, 0, ''),
(1842, 42, 2729.797,-1677.571, 126.499, 0, ''),
(1842, 43, 2716.778,-1694.648, 126.301, 0, ''),
(1842, 44, 2706.658,-1709.474, 123.420, 0, ''),
(1842, 45, 2699.506,-1720.572, 120.265, 0, ''),
(1842, 46, 2691.977,-1738.466, 114.994, 0, ''),
(1842, 47, 2690.514,-1757.045, 108.764, 0, ''),
(1842, 48, 2691.953,-1780.309, 99.890, 0, ''),
(1842, 49, 2689.344,-1803.264, 89.130, 0, ''),
(1842, 50, 2697.849,-1820.550, 80.681, 0, ''),
(1842, 51, 2701.934,-1836.706, 73.700, 0, ''),
(1842, 52, 2698.088,-1853.866, 68.999, 0, ''),
(1842, 53, 2693.657,-1870.237, 66.882, 0, ''),
(1842, 54, 2682.347,-1885.251, 66.009, 0, ''), 
(1842, 55, 2668.229, -1900.796, 66.256, 0, 'SAY_REACH_TOWER - escort paused');


-- Repair quest 'What Is Going On' quest id =3982
UPDATE quest_template SET SpecialFlags = 2 WHERE entry = 3982;

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
