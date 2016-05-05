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
    SET @cOldContent = '10'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '11';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'fix various issues';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fix various issues on the tracker';

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

/* Bugfixes */

/* Bugfix for https://www.getmangos.eu/issue.php?issueid=1047 */
/* Unable to obtain a Bolt of Charged Bramble */
UPDATE gameobject_template SET data2 = 10 WHERE entry = 103661;
/*  */
UPDATE quest_template SET OfferRewardText = 'What the...?! Don''t sneak up on me like that! And keep your voice down! What in the name of the Shadow are you doing sneakin'' up on me for? Can''t you see I''m busy, you daft fool?$B$BWhat do you mean, what am I doing? I''m waiting for the next Dark Portal to open, what the heck do you think I''m doing? Speak your peace and be off with you... ''fore the guards notice the two of us hiding in the bushes together. I have a reputation to maintain.' WHERE entry = 2745;

/* Bugfix for https://www.getmangos.eu/issue.php?issueid=1076 */
/* Defenders of Darrowshire ,the a Darrowshire Spirits unlimited conversation until the quest is completed */
UPDATE db_scripts SET delay = 60 WHERE id = 3141 AND command = 29;

/* Bugfix for https://www.getmangos.eu/issue.php?issueid=1074 */
/* 'Thaurissan Relic' fix */
UPDATE gameobject_template SET data1 = 3701 WHERE entry = 153556;

/* Bugfix for https://www.getmangos.eu/issue.php?issueid=1087 */
/* Achellios the Banished  waypoints */
DELETE FROM creature_movement_template WHERE entry=5933;
INSERT INTO creature_movement_template( `entry`, `point`, `position_x`, `position_y`, `position_z` )
VALUES	(5933, 1, -5065.414551, -1433.431885, -52.054058),
	(5933, 2, -5080.285156, -1409.718994, -52.203053),
	(5933, 3, -5096.495605, -1378.726807, -51.724346),
	(5933, 4, -5104.196289, -1358.002808, -50.824722),
	(5933, 5, -5112.802734, -1324.146851, -50.094719),
	(5933, 6, -5111.580078, -1301.388672, -49.267933),
	(5933, 7, -5107.584473, -1280.802734, -48.943916),
	(5933, 8, -5096.659180, -1257.089233, -48.471100),
	(5933, 9, -5082.086914, -1233.186279, -50.992100),
	(5933, 10, -5065.160156, -1214.561768, -54.094868),
	(5933, 11, -5048.077148, -1208.920410, -54.393391),
	(5933, 12, -5025.265625, -1212.702515, -53.574635),
	(5933, 13, -5007.475098, -1223.781250, -50.797726),
	(5933, 14, -4988.770508, -1237.379517, -47.942184),
	(5933, 15, -4965.532227, -1252.931885, -46.213470),
	(5933, 16, -4945.341309, -1262.725708, -48.321907),
	(5933, 17, -4957.100098, -1257.528564, -47.172382),
	(5933, 18, -4974.348145, -1245.551147, -46.548256),
	(5933, 19, -4997.272949, -1229.474365, -49.777657),
	(5933, 20, -5014.469727, -1217.421753, -52.319622),
	(5933, 21, -5032.637695, -1209.560913, -54.186928),
	(5933, 22, -5056.286133, -1214.395996, -54.073860),
	(5933, 23, -5073.804199, -1225.945801, -52.395935),
	(5933, 24, -5089.777344, -1243.745728, -49.314560),
	(5933, 25, -5098.031250, -1259.230591, -48.500839),
	(5933, 26, -5106.213379, -1282.815308, -48.529831),
	(5933, 27, -5109.097656, -1303.605347, -48.834938),
	(5933, 28, -5108.130859, -1322.882935, -49.570202),
	(5933, 29, -5104.601074, -1343.582642, -50.142941),
	(5933, 30, -5101.294922, -1364.320801, -50.986908),
	(5933, 31, -5092.989258, -1385.642334, -52.071144),
	(5933, 32, -5081.424316, -1403.168579, -52.366920);
UPDATE creature SET movementtype = 2 WHERE id = 5933;	

DELETE FROM creature_linking_template WHERE entry=4250;
INSERT INTO creature_linking_template(`entry`, `map`, `master_entry`, `flag`, `search_range`) VALUES (4250, 1, 5933, 513, 0);

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
