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
    SET @cOldContent = '022';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '22';
    SET @cNewContent = '023';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Klinkran_the_crazed';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Q7636_P3_FIX_Klinkran_the_crazed';

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

		-- SD3 Script binding for KLINFRAN_THE_AMIABLE (friendly form of npc_klinfran_the_crazed)
		DELETE FROM`script_binding` WHERE `bind` = 14529;
		INSERT INTO `script_binding` (`type`, `ScriptName`, `bind`, `data`) VALUES (0, 'npc_klinfran_the_crazed', 14529, 0);

		-- Gossip menu for KLINFRAN_THE_AMIABLE (friendly form of npc_klinfran_the_crazed)
		DELETE FROM `gossip_menu` WHERE  `entry` = 52006;
		INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES (52006, 7043, 0, 0);

		UPDATE `creature_template` SET `GossipMenuId` = 52006 WHERE `Entry` = 14529;
		
		DELETE FROM `gossip_texts` WHERE `entry` = -3509004;
		INSERT INTO `gossip_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `comment`) 
		VALUES (-3509004, 'Show me your real face, daemon !', 'Show me your real face, daemon !', 'Montre moi ton vrai visage, démon !', 'npc_klinfran_the_crazed GOSSIP_ITEM_KLINFRAN_THE_AMIABLE');
		
		-- Update KLINFRAN_THE_AMIABLE creature settings
		-- Enable waypoint movementType => 2
		UPDATE `creature` SET `spawntimesecs`= 10800,  `MovementType` = 2 WHERE id = 14529;


		-- Waypoints for KLINFRAN_THE_AMIABLE (friendly form of npc_klinfran_the_crazed)
		DELETE FROM creature_movement_template WHERE entry=14529;
		INSERT INTO creature_movement_template (entry,  point, position_x, position_y, position_z, orientation, waittime, script_id) VALUES
		(14529,1,-8313.42,-998.049,175.241,5.545,0,0),
		(14529,2,-8310.17,-1002.44,174.264,5.35,0,0),
		(14529,3,-8306.13,-1006.11,172.951,5.545,0,0),
		(14529,4,-8301.26,-1010.54,170.893,5.545,0,0),
		(14529,5,-8298.05,-1013.46,168.333,5.545,0,0),
		(14529,6,-8293.67,-1016.72,164.132,5.642,0,0),
		(14529,7,-8288.87,-1019.32,160.067,5.787,0,0),
		(14529,8,-8283.66,-1020.94,156.811,5.981,0,0),
		(14529,9,-8276.37,-1023.2,153.697,5.981,0,0),
		(14529,10,-8269.37,-1028.45,150.862,5.639,0,0),
		(14529,11,-8264.16,-1032.36,149.221,5.639,0,0),
		(14529,12,-8258.96,-1036.27,148.245,5.639,0,0),
		(14529,13,-8251.96,-1041.52,146.624,5.639,0,0),
		(14529,14,-8247.38,-1046.15,145.074,5.491,0,0),
		(14529,15,-8247.38,-1046.15,145.074,5.491,0,0),
		(14529,16,-8236.61,-1057.05,143.101,5.491,0,0),
		(14529,17,-8231.24,-1062.48,142.758,5.491,0,0),
		(14529,18,-8224.31,-1069.5,143.212,5.491,0,0),
		(14529,19,-8218.94,-1074.93,144.057,5.491,0,0),
		(14529,20,-8218.94,-1074.93,144.057,5.491,0,0),
		(14529,21,-8212.05,-1081.9,145.928,5.491,0,0),
		(14529,22,-8198.97,-1095.14,148.989,5.491,0,0),
		(14529,23,-8193.09,-1100.01,148.947,5.592,0,0),
		(14529,24,-8188.02,-1104.2,148.297,5.592,0,0),
		(14529,25,-8182.51,-1103.69,146.753,0.091,0,0),
		(14529,26,-8174.91,-1103,144.124,0.091,0,0),
		(14529,27,-8167.37,-1104.16,140.824,6.129,0,0),
		(14529,28,-8158.72,-1105.5,137.858,6.129,0,0),
		(14529,29,-8151.18,-1106.67,135.505,6.129,0,0),
		(14529,30,-8144.15,-1109.63,133.699,5.884,0,0),
		(14529,31,-8138,-1115.86,132.751,5.491,0,0),
		(14529,32,-8130.38,-1130.35,132.221,5.196,0,0),
		(14529,33,-8126.95,-1134.6,132.049,5.391,0,0),
		(14529,34,-8126.95,-1134.6,132.049,5.391,0,0),
		(14529,35,-8121.45,-1141.41,131.576,5.391,0,0),
		(14529,36,-8115.96,-1148.22,131.202,5.391,0,0),
		(14529,37,-8111.83,-1153.34,130.947,5.391,0,0),
		(14529,38,-8108.4,-1157.59,130.906,5.391,0,0),
		(14529,39,-8098.11,-1170.34,131.044,5.391,0,0),
		(14529,40,-8091.96,-1177.97,131.839,5.391,0,0),
		(14529,41,-8086.76,-1181.89,132.316,5.636,0,0),
		(14529,42,-8086.76,-1181.89,132.316,6.029,0,0),
		(14529,43,-8079.38,-1183.81,131.832,0.581,0,0),
		(14529,44,-8068.98,-1174.35,131.15,0.873,0,0),
		(14529,45,-8064.67,-1165.47,131.088,1.118,0,0),
		(14529,46,-8060.39,-1156.65,131.088,1.118,0,0),
		(14529,47,-8056.57,-1148.78,131.087,1.118,0,0),
		(14529,48,-8052.75,-1140.91,131.087,1.118,0,0),
		(14529,49,-8052.75,-1140.91,131.087,1.118,0,0),
		(14529,50,-8045.45,-1121.55,131.087,1.313,0,0),
		(14529,51,-8045.45,-1121.55,131.087,1.313,0,0),
		(14529,52,-8043.51,-1114.17,131.087,1.313,0,0),
		(14529,53,-8040.73,-1103.61,131.087,1.313,0,0),
		(14529,54,-8036.28,-1086.68,131.087,1.313,0,0),
		(14529,55,-8033.77,-1077.14,131.087,1.313,0,0),
		(14529,56,-8032.87,-1064.93,131.087,1.313,0,0),
		(14529,57,-8031.19,-1058.56,131.124,1.313,0,0),
		(14529,58,-8028.24,-1049.15,130.849,1.266,0,0),
		(14529,59,-8024.8,-1043.53,130.644,1.021,0,0),
		(14529,60,-8024.8,-1043.53,130.644,1.021,0,0),
		(14529,61,-8013.94,-1025.8,129.86,1.021,0,0),
		(14529,62,-8010.54,-1016.54,129.507,1.219,0,0),
		(14529,63,-8010.54,-1016.54,129.507,1.219,0,0),
		(14529,64,-8006.78,-1006.29,128.977,1.219,0,0),
		(14529,65,-8003.39,-997.02,128.25,1.464,0,0),
		(14529,66,-8001.87,-982.82,127.701,1.464,0,0),
		(14529,67,-8000.82,-973.006,127.76,1.464,0,0),
		(14529,68,-7999.89,-964.306,128.139,1.464,0,0),
		(14529,69,-7998.96,-955.606,128.573,1.464,0,0),
		(14529,70,-7997.69,-943.703,129.018,1.464,0,0),
		(14529,71,-7996.76,-935.003,129.428,1.121,0,0),
		(14529,72,-7992.96,-927.12,129.484,1.121,0,0),
		(14529,73,-7988.67,-918.228,129.489,1.121,0,0),
		(14529,74,-7984.9,-910.397,129.487,1.121,0,0),
		(14529,75,-7980.19,-900.615,129.56,1.121,0,0),
		(14529,76,-7974.35,-884.183,129.307,1.366,0,0),
		(14529,77,-7975.4,-876.626,129.674,1.709,0,0),
		(14529,78,-7975.4,-876.626,129.674,1.709,0,0),
		(14529,79,-7978.43,-854.926,131.854,1.709,0,0),
		(14529,80,-7984.28,-850.027,132.385,2.444,0,0),
		(14529,81,-7988.8,-843.799,132.197,2.199,0,0),
		(14529,82,-7995.27,-834.91,132.329,2.199,0,0),
		(14529,83,-8001.03,-826.984,132.57,2.199,0,0),
		(14529,84,-8001.03,-826.984,132.57,2.397,0,0),
		(14529,85,-8013.13,-815.84,132.818,2.397,0,0),
		(14529,86,-8013.13,-815.84,132.818,2.397,0,0),
		(14529,87,-8021.16,-808.443,132.665,2.397,0,0),
		(14529,88,-8037.6,-795.842,132.351,2.642,0,0),
		(14529,89,-8037.6,-795.842,132.351,2.642,0,0),
		(14529,90,-8054.94,-786.392,132.3,2.642,0,0),
		(14529,91,-8054.94,-786.392,132.3,2.642,0,0),
		(14529,92,-8064.52,-781.164,132.031,2.984,0,0),
		(14529,93,-8071.02,-780.137,132.052,2.984,0,0),
		(14529,94,-8090.5,-777.059,131.931,2.984,0,0),
		(14529,95,-8090.5,-777.059,131.931,2.984,0,0),
		(14529,96,-8101.28,-775.354,131.476,2.984,0,0),
		(14529,97,-8121.84,-774.682,130.428,3.28,0,0),
		(14529,98,-8131.62,-776.046,129.844,3.28,0,0),
		(14529,99,-8131.62,-776.046,129.844,3.28,0,0),
		(14529,100,-8142.43,-777.554,129.056,3.28,0,0),
		(14529,101,-8153.19,-779.053,129.53,3.917,0,0),
		(14529,102,-8164.13,-789.794,129.89,3.917,0,0),
		(14529,103,-8164.13,-789.794,129.89,3.917,0,0),
		(14529,104,-8173.47,-798.965,129.398,3.917,0,0),
		(14529,105,-8185.09,-815.636,129.543,4.31,0,0),
		(14529,106,-8188.95,-824.72,129.364,4.31,0,0),
		(14529,107,-8188.95,-824.72,129.364,4.31,0,0),
		(14529,108,-8191.25,-839.404,130.622,4.8,0,0),
		(14529,109,-8191.25,-839.404,130.622,4.8,0,0),
		(14529,110,-8190.38,-849.236,131.652,4.8,0,0),
		(14529,111,-8190.02,-865.541,132.181,4.602,0,0),
		(14529,112,-8190.97,-874.238,132.179,4.602,0,0),
		(14529,113,-8190.97,-874.238,132.179,4.602,0,0),
		(14529,114,-8192.18,-885.162,132.948,4.602,0,0),
		(14529,115,-8197.96,-903.53,133.295,4.21,0,0),
		(14529,116,-8202.68,-912.119,133.456,4.21,0,0),
		(14529,117,-8208.14,-917.448,133.66,3.914,0,0),
		(14529,118,-8208.14,-917.448,133.66,3.914,0,0),
		(14529,119,-8215.2,-924.341,133.981,3.965,0,0),
		(14529,120,-8221.9,-931.569,135.217,3.965,0,0),
		(14529,121,-8232.42,-945.449,135.919,4.162,0,0),
		(14529,122,-8232.42,-945.449,135.919,4.162,0,0),
		(14529,123,-8240.66,-959.644,136.117,4.213,0,0),
		(14529,124,-8244.33,-966.381,136.45,4.213,0,0),
		(14529,125,-8246.59,-973.668,136.184,4.411,0,0),
		(14529,126,-8246.59,-973.668,136.184,4.411,0,0),
		(14529,127,-8250.86,-983.737,139.728,4.213,0,0),
		(14529,128,-8251.87,-990.239,142.03,4.756,0,0),
		(14529,129,-8249.8,-998.741,143.319,4.951,0,0),
		(14529,130,-8247.37,-1012.66,144.982,4.806,0,0),
		(14529,131,-8248.66,-1019.11,146.043,4.514,0,0),
		(14529,132,-8251.58,-1029.6,147.216,4.367,0,0),
		(14529,133,-8255.5,-1034.89,147.874,4.074,0,0),
		(14529,134,-8261.31,-1031.81,149.021,2.654,0,0),
		(14529,135,-8266.14,-1029.26,150.273,2.654,0,0),
		(14529,136,-8272.88,-1025.69,152.196,2.654,0,0),
		(14529,137,-8278.64,-1022.64,154.411,2.654,0,0),
		(14529,138,-8278.64,-1022.64,154.411,2.654,0,0),
		(14529,139,-8283.46,-1020.09,156.866,2.852,0,0),
		(14529,140,-8288.7,-1018.54,160.137,2.852,0,0),
		(14529,141,-8300.22,-1015.11,169.145,2.852,0,0),
		(14529,142,-8302.87,-1011.59,171.346,2.215,0,0),
		(14529,143,-8302.87,-1011.59,171.346,2.215,0,0),
		(14529,144,-8310.08,-1001.99,174.292,2.215,0,0),
		(14529,145,-8314.66,-995.891,175.714,2.215,0,0);
		
		
	
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


