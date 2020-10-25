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
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '22'; 
    SET @cOldContent = '018';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '22';
    SET @cNewContent = '019';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'P1_FIX_Solenor_the_slayer';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'P1_FIX_Solenor_the_slayer';

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

		DELETE FROM`script_binding` WHERE `bind` = 14536;
		INSERT `script_binding` (`type`, `ScriptName`, `bind`, `data`) VALUES (0, 'npc_solenor_the_slayer', 14536, 0);

		DELETE FROM `gossip_menu` WHERE  `entry` = 52004;
		INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES (52004, 7044, 0, 0);

		UPDATE `creature_template` SET `GossipMenuId` = 52004 WHERE `Entry` = 14536;
		UPDATE `creature` SET `orientation` = 4.8044, `spawntimesecs`= 10800,  `MovementType` = 2 WHERE id = 14536;

		DELETE FROM `gossip_texts` WHERE `entry` = -3509002;
		INSERT INTO `gossip_texts` (`entry`, `content_default`, `content_loc0`, `content_loc2`, `comment`) 
		VALUES (-3509002, 'A gnome, really ? Show me your real face, daemon !', 'A gnome, really ? Show me your real face, daemon !', 'Un gnome, vraiment ? Montre moi ton vrai visage, démon !', 'nelson the nice GOSSIP_ITEM_NELSON_THE_NICE');
		
		/* THE CLEANER - Appears if somenone interferes in the hunter combat with solenor */
		UPDATE `creature_template` SET `SpeedRun`=2.6, `MechanicImmuneMask`=650870623 , `MinLootGold` = '0', `MaxLootGold` = '0'  WHERE `entry`=14503;
		
		UPDATE `creature_template` SET `SpeedRun`=0.33, `SpeedWalk`=0.33 WHERE `entry`=14761;
		
		
		DELETE FROM `script_texts` WHERE `entry` IN (-1001252, -1001253);
		INSERT INTO `script_texts` (`entry`, `content_default`, `sound`,`type`,`language`,`emote`,`comment`) VALUES
		(-1001252,'%s is immobilized.',0,2,0,0,'npc_solenor EMOTE_IMMOBILIZED'),
		(-1001253,'You dare interfere with this being''s testing? The battle must be fought alone! You shall all pay for this interference!',0,0,0,0,'the_cleaner SAY_THE_CLEANER_AGGRO')
		;
		
		/*
			Waypoints for Nelson The nice (friendly form of Solenor)
		*/
		DELETE FROM creature_movement_template WHERE entry=14536;
		INSERT INTO creature_movement_template (entry,  point, position_x, position_y, position_z, orientation, waittime, script_id) VALUES
		(14536, 1, -7723.94, 1672.61, 6.99932, 4.782, 0, 0),
		(14536, 2, -7723.53, 1666.73, 7.2381, 4.782, 0, 0),
		(14536, 3, -7723.16, 1661.32, 7.4734, 4.782, 0, 0),
		(14536, 4, -7722.62, 1653.71, 7.75759, 4.782, 0, 0),
		(14536, 5, -7722.81, 1647.13, 7.91095, 4.684, 0, 0),
		(14536, 6, -7723.02, 1639.51, 7.89681, 4.684, 0, 0),
		(14536, 7, -7723.35, 1627.47, 7.38225, 4.684, 0, 0),
		(14536, 8, -7723.53, 1620.89, 6.83515, 4.684, 0, 0),
		(14536, 9, -7723.83, 1609.98, 5.41355, 4.684, 0, 0),
		(14536, 10, -7723.35, 1602.29, 3.85762, 4.775, 0, 0),
		(14536, 11, -7722.86, 1594.68, 1.79496, 4.775, 0, 0),
		(14536, 12, -7723.88, 1582.68, 0.34014, 4.628, 0, 0),
		(14536, 13, -7724.21, 1572.82, -0.056111, 4.678, 0, 0),
		(14536, 14, -7723.73, 1565.2, 0.44632, 4.775, 0, 0),
		(14536, 15, -7722.96, 1553.19, -0.093045, 4.775, 0, 0),
		(14536, 16, -7726.78, 1546.58, -0.909012, 4.188, 0, 0),
		(14536, 17, -7733.28, 1546.13, 0.007443, 3.211, 0, 0),
		(14536, 18, -7740.79, 1544.56, 1.08576, 3.264, 0, 0),
		(14536, 19, -7749.48, 1543.48, 1.58189, 3.264, 0, 0),
		(14536, 20, -7760.25, 1542.15, 0.900917, 3.362, 0, 0),
		(14536, 21, -7767.76, 1540.47, 0.76182, 3.362, 0, 0),
		(14536, 22, -7773.09, 1539.27, 0.90416, 3.362, 0, 0),
		(14536, 23, -7785.86, 1536.41, 1.30292, 3.362, 0, 0),
		(14536, 24, -7795.42, 1534.26, 1.48728, 3.362, 0, 0),
		(14536, 25, -7803.96, 1532.35, 1.31336, 3.362, 0, 0),
		(14536, 26, -7813.59, 1530.19, 0.882178, 3.362, 0, 0),
		(14536, 27, -7821.23, 1529.25, 0.492903, 3.264, 0, 0),
		(14536, 28, -7831.03, 1528.03, 0.171037, 3.264, 0, 0),
		(14536, 29, -7838.6, 1527.1, 0.147077, 3.264, 0, 0),
		(14536, 30, -7849.44, 1525.76, 0.011675, 3.264, 0, 0),
		(14536, 31, -7854.86, 1525.09, -0.299024, 3.264, 0, 0),
		(14536, 32, -7854.86, 1525.09, -0.299024, 2.331, 0, 0),
		(14536, 33, -7864.65, 1535.38, -2.00175, 2.331, 0, 0),
		(14536, 34, -7870.69, 1541.71, -2.63201, 2.331, 0, 0),
		(14536, 35, -7877.49, 1548.86, -1.72241, 2.331, 0, 0),
		(14536, 36, -7889.51, 1561.49, -1.73218, 2.331, 0, 0),
		(14536, 37, -7896.32, 1568.63, 0.39502, 2.331, 0, 0),
		(14536, 38, -7896.32, 1568.63, 0.39502, 2.331, 0, 0),
		(14536, 39, -7902.35, 1574.97, 1.27937, 2.331, 0, 0),
		(14536, 40, -7912.87, 1586.02, 0.354109, 2.331, 0, 0),
		(14536, 41, -7918.91, 1592.36, -2.88522, 2.331, 0, 0),
		(14536, 42, -7924.94, 1598.7, -4.35761, 2.331, 0, 0),
		(14536, 43, -7929.48, 1603.46, -3.07459, 2.331, 0, 0),
		(14536, 44, -7937.54, 1609.16, -2.27474, 2.526, 0, 0),
		(14536, 45, -7944.16, 1614.88, -2.34859, 2.429, 0, 0),
		(14536, 46, -7951.63, 1621.33, -2.20943, 2.429, 0, 0),
		(14536, 47, -7959.1, 1627.78, -0.426467, 2.429, 0, 0),
		(14536, 48, -7962.35, 1630.59, -0.42542, 2.429, 0, 0),
		(14536, 49, -7976.38, 1642.72, 3.58954, 2.429, 0, 0),
		(14536, 50, -7983.99, 1643.29, 6.34064, 3.066, 0, 0),
		(14536, 51, -7989.44, 1643.7, 8.30937, 3.066, 0, 0),
		(14536, 52, -7997.12, 1644.27, 11.0857, 3.066, 0, 0),
		(14536, 53, -8010.24, 1645.26, 16.577, 3.066, 0, 0),
		(14536, 54, -8009.91, 1649.65, 16.4068, 1.495, 0, 0),
		(14536, 55, -8009.18, 1659.43, 15.3411, 1.495, 0, 0),
		(14536, 56, -8008.04, 1674.64, 10.7737, 1.495, 0, 0),
		(14536, 57, -8007.83, 1688.84, 7.07297, 1.593, 0, 0),
		(14536, 58, -8007.98, 1695.42, 5.53078, 1.593, 0, 0),
		(14536, 59, -8002.69, 1703.75, 3.03121, 1.005, 0, 0),
		(14536, 60, -7994.75, 1718.06, 1.28656, 1.103, 0, 0),
		(14536, 61, -7990.34, 1726.81, 0.271978, 1.103, 0, 0),
		(14536, 62, -7984.91, 1737.55, -1.67144, 1.103, 0, 0),
		(14536, 63, -7979.99, 1747.3, -3.34872, 1.103, 0, 0),
		(14536, 64, -7976.55, 1754.11, -3.64768, 1.103, 0, 0),
		(14536, 65, -7971.6, 1763.92, -1.33611, 1.103, 0, 0),
		(14536, 66, -7968.63, 1769.8, -0.638402, 1.103, 0, 0),
		(14536, 67, -7959.18, 1772.39, 0.043781, 0.267, 0, 0),
		(14536, 68, -7949.66, 1775, 0.854808, 0.267, 0, 0),
		(14536, 69, -7942.3, 1777.02, 1.30295, 0.267, 0, 0),
		(14536, 70, -7934.12, 1780.12, 1.34465, 0.361, 0, 0),
		(14536, 71, -7923.91, 1783.98, 1.97957, 0.361, 0, 0),
		(14536, 72, -7916.77, 1786.68, 2.64666, 0.361, 0, 0),
		(14536, 73, -7916.77, 1786.68, 2.64666, 0.361, 0, 0),
		(14536, 74, -7908.65, 1789.76, 2.82543, 0.361, 0, 0),
		(14536, 75, -7888.53, 1792.4, 1.20374, 6.205, 0, 0),
		(14536, 76, -7880.85, 1791.8, 0.239228, 6.205, 0, 0),
		(14536, 77, -7871.01, 1791.04, 1.0017, 6.205, 0, 0),
		(14536, 78, -7861.17, 1790.27, 1.85499, 6.205, 0, 0),
		(14536, 79, -7855.73, 1789.84, 2.02605, 6.205, 0, 0),
		(14536, 80, -7850.52, 1781.54, 0.762147, 5.272, 0, 0),
		(14536, 81, -7850.52, 1781.54, 0.762147, 5.272, 0, 0),
		(14536, 82, -7843.54, 1770.39, -0.002306, 5.272, 0, 0),
		(14536, 83, -7830.85, 1757.25, 0.513463, 5.664, 0, 0),
		(14536, 84, -7830.85, 1757.25, 0.513463, 5.664, 0, 0),
		(14536, 85, -7821.04, 1750.27, 1.60067, 5.664, 0, 0),
		(14536, 86, -7808.36, 1740.08, 3.85629, 5.517, 0, 0),
		(14536, 87, -7808.36, 1740.08, 3.85629, 5.517, 0, 0),
		(14536, 88, -7799.73, 1731.78, 4.13775, 5.517, 0, 0),
		(14536, 89, -7781.99, 1717.37, 2.64011, 5.712, 0, 0),
		(14536, 90, -7774.6, 1710.94, 1.70334, 5.567, 0, 0),
		(14536, 91, -7767.15, 1704.46, 1.0991, 5.567, 0, 0),
		(14536, 92, -7761.39, 1699.46, 1.62084, 5.567, 0, 0),
		(14536, 93, -7755.59, 1694.41, 2.40594, 5.567, 0, 0),
		(14536, 94, -7748.09, 1687.89, 4.62263, 5.567, 0, 0),
		(14536, 95, -7743.12, 1683.57, 5.96238, 5.567, 0, 0),
		(14536, 96, -7737.06, 1681.2, 7.02291, 5.909, 0, 0),
		(14536, 97, -7727.87, 1677.6, 7.20446, 5.909, 0, 0);
		
		
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


