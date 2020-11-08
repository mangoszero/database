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
    SET @cOldContent = '021';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '22';
    SET @cNewContent = '022';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Artorius_the_Doombringer';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Q7636_P2_FIX_Artorius_the_Doombringer';

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

		DELETE FROM`script_binding` WHERE `bind` = 14531;
		INSERT INTO `script_binding` (`type`, `ScriptName`, `bind`, `data`) VALUES (0, 'npc_artorius_the_doombringer', 14531, 0);

		DELETE FROM `gossip_menu` WHERE  `entry` = 52005;
		INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES (52005, 7045, 0, 0);

		UPDATE `creature_template` SET `GossipMenuId` = 52005 WHERE `Entry` = 14531;
		
		UPDATE `creature` SET `orientation` = 4.8044, `spawntimesecs`= 10800,  `MovementType` = 2 WHERE id = 14531;

		DELETE FROM `gossip_texts` WHERE `entry` = -3509003;
		INSERT INTO `gossip_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `comment`) 
		VALUES (-3509003, 'A tauren, really ? Show me your real face, daemon !', 'A tauren, really ? Show me your real face, daemon !', 'Un tauren, vraiment ? Montre moi ton vrai visage, démon !', 'artorius teh amiable GOSSIP_ITEM_ARTORIUS_THE_AMIABLE');
			
		
		DELETE FROM `script_texts` WHERE `entry` IN (-1001251);
		INSERT INTO `script_texts` (`entry`, `content_default`, `sound`,`type`,`language`,`emote`,`comment`) VALUES
		(-1001251,'%s is stricken by a virulent poison.',0,2,0,0,'npc_artorius EMOTE_POISON');

		-- Waypoints for Nelson The nice (friendly form of Artorius the doombringer)

		DELETE FROM `creature_movement_template` WHERE entry=14536;
		INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `script_id`) VALUES
		(14531,1,7913.4,-4596.38,710.531,0.555,0,0),
		(14531,2,7919.91,-4592.35,711.407,0.555,0,0),
		(14531,3,7924.55,-4589.47,711.916,0.555,0,0),
		(14531,4,7929.19,-4586.59,712.372,0.555,0,0),
		(14531,5,7936.62,-4581.98,713.606,0.555,0,0),
		(14531,6,7936.62,-4581.98,713.606,0.555,0,0),
		(14531,7,7944.06,-4577.37,715.487,0.555,0,0),
		(14531,8,7956.98,-4567.5,717.929,0.8,0,0),
		(14531,9,7960.28,-4561.81,717.638,1.045,0,0),
		(14531,10,7960.28,-4561.81,717.638,1.045,0,0),
		(14531,11,7964.67,-4554.24,716.707,1.045,0,0),
		(14531,12,7963.93,-4542.4,712.473,2.615,0,0),
		(14531,13,7963.93,-4542.4,712.473,2.615,0,0),
		(14531,14,7956.37,-4538.01,707.616,2.615,0,0),
		(14531,15,7948.8,-4533.62,702.981,2.615,0,0),
		(14531,16,7942.2,-4529.79,700.03,2.615,0,0),
		(14531,17,7932.75,-4524.31,698.474,2.615,0,0),
		(14531,18,7922.34,-4518.27,698.361,1.387,0,0),
		(14531,19,7923.73,-4510.77,698.826,1.387,0,0),
		(14531,20,7926.51,-4495.71,702.548,1.387,0,0),
		(14531,21,7926.51,-4495.71,702.548,1.387,0,0),
		(14531,22,7928.5,-4484.98,705.813,1.682,0,0),
		(14531,23,7925.47,-4472.27,708.613,1.927,0,0),
		(14531,24,7925.47,-4472.27,708.613,1.927,0,0),
		(14531,25,7919.58,-4461.92,709.474,2.22,0,0),
		(14531,26,7919.58,-4461.92,709.474,2.22,0,0),
		(14531,27,7909.16,-4450.83,706.686,2.465,0,0),
		(14531,28,7903.21,-4446.05,703.808,2.465,0,0),
		(14531,29,7897.26,-4439.63,700.528,2.317,0,0),
		(14531,30,7897.26,-4439.63,700.528,2.317,0,0),
		(14531,31,7890.56,-4432.39,696.437,2.317,0,0),
		(14531,32,7884.62,-4425.96,693.826,3.15,0,0),
		(14531,33,7870.57,-4427.58,688.877,3.347,0,0),
		(14531,34,7862,-4429.38,686.138,3.347,0,0),
		(14531,35,7853.44,-4431.17,683.177,3.347,0,0),
		(14531,36,7844.7,-4430.83,679.745,3.102,0,0),
		(14531,37,7844.7,-4430.83,679.745,3.102,0,0),
		(14531,38,7818.01,-4434.58,668.309,3.401,0,0),
		(14531,39,7818.01,-4434.58,668.309,3.401,0,0),
		(14531,40,7809.55,-4436.83,665.007,3.401,0,0),
		(14531,41,7799,-4439.63,661.453,3.401,0,0),
		(14531,42,7782.08,-4444.13,657.244,3.401,0,0),
		(14531,43,7782.08,-4444.13,657.244,3.401,0,0),
		(14531,44,7773.63,-4446.38,655.171,3.401,0,0),
		(14531,45,7765.17,-4448.62,652.864,3.401,0,0),
		(14531,46,7749.57,-4453.56,648.809,3.501,0,0),
		(14531,47,7740.4,-4457.02,646.394,3.501,0,0),
		(14531,48,7740.4,-4457.02,646.394,3.501,0,0),
		(14531,49,7731.17,-4460.5,643.643,3.501,0,0),
		(14531,50,7717.94,-4465.48,639.324,3.501,0,0),
		(14531,51,7705.69,-4470.1,636.157,3.501,0,0),
		(14531,52,7694.42,-4474.34,633.766,3.501,0,0),
		(14531,53,7682.67,-4468.5,631.29,2.619,0,0),
		(14531,54,7682.67,-4468.5,631.29,2.619,0,0),
		(14531,55,7666.86,-4461.59,626.749,2.914,0,0),
		(14531,56,7666.86,-4461.59,626.749,2.914,0,0),
		(14531,57,7657.24,-4459.36,624.066,2.914,0,0),
		(14531,58,7647.63,-4457.14,621.855,2.914,0,0),
		(14531,59,7626.35,-4452.22,616.812,2.914,0,0),
		(14531,60,7626.35,-4452.22,616.812,2.914,0,0),
		(14531,61,7614.69,-4449.52,613.703,2.914,0,0),
		(14531,62,7595.52,-4445.09,608.783,2.914,0,0),
		(14531,63,7586.99,-4443.12,607.239,2.914,0,0),
		(14531,64,7570.68,-4437.17,604.292,2.669,0,0),
		(14531,65,7570.68,-4437.17,604.292,2.669,0,0),
		(14531,66,7559.95,-4431.7,603.163,2.669,0,0),
		(14531,67,7553.21,-4428.25,603.352,2.669,0,0),
		(14531,68,7535.84,-4421.87,606.532,2.961,0,0),
		(14531,69,7529.18,-4427.55,607.032,3.847,0,0),
		(14531,70,7529.18,-4427.55,607.032,4.092,0,0),
		(14531,71,7519.02,-4441.79,606.477,4.092,0,0),
		(14531,72,7513.96,-4448.88,606.687,4.092,0,0),
		(14531,73,7504.08,-4459.06,606.521,3.847,0,0),
		(14531,74,7497.3,-4467.62,604.982,4.042,0,0),
		(14531,75,7488.43,-4478.81,603.64,4.042,0,0),
		(14531,76,7479.8,-4480.23,604.074,3.303,0,0),
		(14531,77,7470.13,-4481.81,604.017,3.303,0,0),
		(14531,78,7470.13,-4481.81,604.017,3.501,0,0),
		(14531,79,7461.94,-4484.9,603.523,3.501,0,0),
		(14531,80,7451.72,-4488.75,604.015,3.501,0,0),
		(14531,81,7435.34,-4494.92,606.592,3.501,0,0),
		(14531,82,7435.34,-4494.92,606.592,3.501,0,0),
		(14531,83,7421.01,-4502.34,606.312,3.797,0,0),
		(14531,84,7421.01,-4502.34,606.312,4.139,0,0),
		(14531,85,7415.1,-4511.52,602.447,4.139,0,0),
		(14531,86,7408.57,-4521.63,599.264,4.139,0,0),
		(14531,87,7404.44,-4528.05,597.543,4.139,0,0),
		(14531,88,7398.52,-4537.22,596.386,4.139,0,0),
		(14531,89,7390.12,-4553.69,594.825,4.384,0,0),
		(14531,90,7390.12,-4553.69,594.825,4.975,0,0),
		(14531,91,7397.44,-4568.14,596.71,5.317,0,0),
		(14531,92,7402.42,-4575.33,598.184,5.317,0,0),
		(14531,93,7415.2,-4588.1,601.008,5.76,0,0),
		(14531,94,7415.2,-4588.1,601.008,5.76,0,0),
		(14531,95,7425.64,-4594.1,604.502,5.76,0,0),
		(14531,96,7434.13,-4599,607.945,5.76,0,0),
		(14531,97,7451.42,-4605.13,610.372,6.103,0,0),
		(14531,98,7457.75,-4600.75,609.944,0.605,0,0),
		(14531,99,7464.95,-4595.77,610.954,0.605,0,0),
		(14531,100,7475.25,-4591.93,613.509,0.357,0,0),
		(14531,101,7477.28,-4591.17,613.902,0.357,0,0),
		(14531,102,7487.51,-4587.35,615.082,6.247,0,0),
		(14531,103,7498.49,-4587.74,617.458,6.247,0,0),
		(14531,104,7511.17,-4598.02,624.285,4.777,0,0),
		(14531,105,7511.59,-4604.58,626.979,4.777,0,0),
		(14531,106,7512.09,-4612.2,631.305,4.777,0,0),
		(14531,107,7512.09,-4612.2,631.305,4.777,0,0),
		(14531,108,7512.59,-4619.81,636.06,5.368,0,0),
		(14531,109,7515.91,-4624.14,639.219,5.368,0,0),
		(14531,110,7524.58,-4635.4,644.969,5.368,0,0),
		(14531,111,7524.58,-4635.4,644.969,0.558,0,0),
		(14531,112,7531.11,-4631.32,642.777,0.558,0,0),
		(14531,113,7539.48,-4626.1,640.701,0.806,0,0),
		(14531,114,7550.04,-4615.08,638.415,0.806,0,0),
		(14531,115,7563.5,-4604.11,636.139,0.561,0,0),
		(14531,116,7563.5,-4604.11,636.139,0.561,0,0),
		(14531,117,7586.61,-4591.86,636.012,0.413,0,0),
		(14531,118,7592.64,-4589.21,637.272,0.413,0,0),
		(14531,119,7600.65,-4585.69,637.973,0.413,0,0),
		(14531,120,7600.65,-4585.69,637.973,0.413,0,0),
		(14531,121,7611.67,-4580.85,639.924,0.413,0,0),
		(14531,122,7630.22,-4574.36,645.151,0.215,0,0),
		(14531,123,7630.22,-4574.36,645.151,0.215,0,0),
		(14531,124,7639.86,-4572.25,648.197,0.41,0,0),
		(14531,125,7644.93,-4570.04,649.304,0.41,0,0),
		(14531,126,7665.32,-4562.1,652.39,0.313,0,0),
		(14531,127,7665.32,-4562.1,652.39,0.313,0,0),
		(14531,128,7684.39,-4557.87,654.888,0.068,0,0),
		(14531,129,7684.39,-4557.87,654.888,0.068,0,0),
		(14531,130,7705.13,-4556.45,659.16,0.068,0,0),
		(14531,131,7705.13,-4556.45,659.16,0.068,0,0),
		(14531,132,7724.7,-4555.12,664.672,0.068,0,0),
		(14531,133,7730.69,-4559.84,667.699,5.616,0,0),
		(14531,134,7738.45,-4565.94,671.137,5.616,0,0),
		(14531,135,7738.45,-4565.94,671.137,5.616,0,0),
		(14531,136,7746.2,-4572.05,673.5,5.616,0,0),
		(14531,137,7754.78,-4578.8,675.948,5.616,0,0),
		(14531,138,7762.46,-4584.85,678.841,5.616,0,0),
		(14531,139,7769.33,-4590.26,682.134,5.616,0,0),
		(14531,140,7778.79,-4597.71,686.727,5.616,0,0),
		(14531,141,7785.67,-4603.12,689.915,5.616,0,0),
		(14531,142,7793.42,-4609.23,693.801,5.616,0,0),
		(14531,143,7807.44,-4619.7,700.296,5.666,0,0),
		(14531,144,7815.39,-4625.34,703.078,5.666,0,0),
		(14531,145,7815.39,-4625.34,703.078,5.666,0,0),
		(14531,146,7823.38,-4631.01,706.286,5.861,0,0),
		(14531,147,7831.36,-4634.59,709.327,5.861,0,0),
		(14531,148,7841.33,-4639.06,713.162,0.021,0,0),
		(14531,149,7850.05,-4638.88,714.439,0.021,0,0),
		(14531,150,7868.27,-4633.71,714.233,0.599,0,0),
		(14531,151,7875.49,-4628.78,713.59,0.599,0,0),
		(14531,152,7883.65,-4623.21,712.769,0.599,0,0),
		(14531,153,7891.8,-4617.65,711.935,0.599,0,0),
		(14531,154,7898.69,-4610.59,710.972,0.796,0,0),
		(14531,155,7904.81,-4604.33,710.23,0.796,0,0),
		(14531,156,7909.45,-4599.58,710.154,0.796,0,0);
		
	
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


