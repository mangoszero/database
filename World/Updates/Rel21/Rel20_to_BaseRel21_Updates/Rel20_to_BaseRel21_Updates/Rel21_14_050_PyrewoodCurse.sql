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
    SET @cOldContent = '049';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '14';
    SET @cNewContent = '050';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'PyrewoodCurse';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'PyrewoodCurse';

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


-- Changed handling of Pyrewood Village - Worgen Curse to game_event_creature_data enabling smoother transition
-- Delete records from game_event_creature
DELETE
FROM
	`game_event_creature`
WHERE
	`event` = -3 OR
	`event` = 3;
-- Delete worgen records from creature
DELETE
FROM
	`creature`
WHERE
	`guid` IN (
		160557,
		160556,
		160555,
		160554,
		160553,
		160552,
		160551,
		160550,
		160549,
		160548,
		160547,
		160546,
		160545,
		160544,
		160543,
		160542,
		160541,
		160540,
		160539,
		160538,
		160537,
		160536,
		160535,
		160534,
		160533,
		160532,
		160531,
		160530,
		160529,
		160528,
		160527,
		160526,
		160525,
		160524,
		160523,
		160522,
		160521,
		160520,
		160519,
		160518,
		160517,
		160516,
		160515,
		160514,
		160513,
		160512,
		160511
	);
-- Insert records into game_event_creature_data
DELETE
FROM
	`game_event_creature_data`
WHERE
	`guid` IN (
		17663,
		17905,
		17908,
		17910,
		17911,
		18220,
		18221,
		18235,
		18236,
		18237,
		18238,
		18239,
		18291,
		18306,
		18307,
		18309,
		18310,
		18350,
		18354,
		18355,
		18400,
		18404,
		18405,
		18407,
		18408,
		18409,
		18411,
		18413,
		18996,
		19002,
		19005,
		19007,
		19012,
		19015,
		19019,
		19084,
		19219,
		19220,
		19222,
		19223,
		19224,
		19227,
		19228,
		19229,
		19316,
		19343,
		19008
	);
INSERT INTO
	`game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`)
VALUES
	(17663, 1896, 0, 0, 7671, 7671, 3),
	(17905, 1896, 0, 0, 7671, 7671, 3),
	(17908, 1892, 0, 0, 7671, 7671, 3),
	(17910, 1893, 0, 0, 7671, 7671, 3),
	(17911, 1893, 0, 0, 7671, 7671, 3),
	(18220, 1896, 0, 0, 7671, 7671, 3),
	(18221, 1896, 0, 0, 7671, 7671, 3),
	(18235, 3531, 0, 0, 7671, 7671, 3),
	(18236, 1893, 0, 0, 7671, 7671, 3),
	(18237, 1893, 0, 0, 7671, 7671, 3),
	(18238, 1896, 0, 0, 7671, 7671, 3),
	(18239, 1893, 0, 0, 7671, 7671, 3),
	(18291, 1893, 0, 0, 7671, 7671, 3),
	(18306, 1893, 0, 0, 7671, 7671, 3),
	(18307, 3529, 0, 0, 7671, 7671, 3),
	(18309, 3533, 0, 0, 7671, 7671, 3),
	(18310, 1896, 0, 0, 7671, 7671, 3),
	(18350, 1893, 0, 0, 7671, 7671, 3),
	(18354, 1896, 0, 0, 7671, 7671, 3),
	(18355, 1896, 0, 0, 7671, 7671, 3),
	(18400, 1893, 0, 0, 7671, 7671, 3),
	(18404, 1892, 0, 0, 7671, 7671, 3),
	(18405, 1896, 0, 0, 7671, 7671, 3),
	(18407, 1896, 0, 0, 7671, 7671, 3),
	(18408, 1892, 0, 0, 7671, 7671, 3),
	(18409, 1896, 0, 0, 7671, 7671, 3),
	(18411, 1893, 0, 0, 7671, 7671, 3),
	(18413, 1893, 0, 0, 7671, 7671, 3),
	(18996, 1893, 0, 0, 7671, 7671, 3),
	(19002, 1892, 0, 0, 7671, 7671, 3),
	(19005, 1892, 0, 0, 7671, 7671, 3),
	(19007, 1896, 0, 0, 7671, 7671, 3),
	(19012, 1893, 0, 0, 7671, 7671, 3),
	(19015, 1893, 0, 0, 7671, 7671, 3),
	(19019, 1893, 0, 0, 7671, 7671, 3),
	(19084, 1892, 0, 0, 7671, 7671, 3),
	(19219, 1892, 0, 0, 7671, 7671, 3),
	(19220, 1893, 0, 0, 7671, 7671, 3),
	(19222, 1892, 0, 0, 7671, 7671, 3),
	(19223, 1892, 0, 0, 7671, 7671, 3),
	(19224, 1892, 0, 0, 7671, 7671, 3),
	(19227, 1892, 0, 0, 7671, 7671, 3),
	(19228, 1893, 0, 0, 7671, 7671, 3),
	(19229, 1892, 0, 0, 7671, 7671, 3),
	(19316, 1892, 0, 0, 7671, 7671, 3),
	(19343, 1892, 0, 0, 7671, 7671, 3),
	(19008, 1893, 0, 0, 7671, 7671, 3);



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
