
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
    SET @cOldContent = '004';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '14';
    SET @cNewContent = '005';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'LBRS Urok Event';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'LBRS Urok Event';

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


-- UBRS Urok Event

DELETE FROM gameobject WHERE guid IN (66197,66201,66203,66204,66208,66209,66210,66211);
INSERT INTO gameobject (guid, id, map, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
( 66197, 175571, 229, -47.9095, -369.089, 51.5425, 1.378809, 0, 0, 0.400546, -0.916277, -65, 255, 1),
( 66201, 175571, 229, -27.8804, -385.891, 48.5067, 3.700105, 0, 0, 0.400546, -0.916277, -65, 255, 1),
( 66203, 175571, 229, -13.7275, -384.816, 48.9746, 3.68265, 0, 0, 0.400546, -0.916277, -65, 255, 1),
( 66204, 175571, 229, -12.3689, -376.475, 49.335, 5.044002, 0, 0, 0.835255, -0.549863, -65, 255, 1),
( 66208, 175571, 229, -24.8824, -369.619, 49.7059, 3.403396, 0, 0, 0.835255, -0.549863, -65, 255, 1),
( 66209, 175571, 229, -34.5437, -370.233, 50.3396, 5.358161, 0, 0, 0.835255, -0.549863, -65, 255, 1),
( 66210, 175584, 229, -14.3415, -395.729, 48.5381, 2.862335, 0, 0, 0.839392, 0.543527, -7200, 255, 1),
( 66211, 175589, 229, -14.3415, -395.729, 48.5381, 2.862335, 0, 0, 0.839392, 0.543527, 30, 255, 1);
UPDATE gameobject SET position_y = -395.729 WHERE guid = 99791;
UPDATE creature_template SET FactionAlliance = 40, FactionHorde = 40, MovementType = 2, ExtraFlags = 0 WHERE entry IN (10584,10601,10602);
DELETE FROM creature_movement_template WHERE entry IN (10584,10601,10602);
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(10584,1,-18.9341,-389.926,48.6219,1000,10584,255,0,0),
(10601,1,-18.9341,-389.926,48.6219,1000,10601,255,0,0),
(10602,1,-18.9341,-389.926,48.6219,1000,10602,255,0,0);
DELETE FROM db_scripts WHERE id IN (10584,10601,10602);
INSERT INTO db_scripts (script_guid, script_type, id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(10584,3,10584,0,20,1,10,0,0,8,0,0,0,0,0,0,0,0,'movement chenged to 1:random'),
(10601,3,10601,0,20,1,10,0,0,8,0,0,0,0,0,0,0,0,'movement chenged to 1:random'),
(10602,3,10602,0,20,1,10,0,0,8,0,0,0,0,0,0,0,0,'movement chenged to 1:random');
INSERT INTO db_scripts (script_type, id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(8,4845,0,9,66210,7200,0,0,0,0,0,0,0,0,0,0,0,'respawn gobject'),
(8,4845,0,9,66197,65,0,0,0,0,0,0,0,0,0,0,0,'respawn gobject'),
(8,4845,0,9,66201,65,0,0,0,0,0,0,0,0,0,0,0,'respawn gobject'),
(8,4845,1,9,66203,65,0,0,0,0,0,0,0,0,0,0,0,'respawn gobject'),
(8,4845,1,9,66204,65,0,0,0,0,0,0,0,0,0,0,0,'respawn gobject'),
(8,4845,1,9,66208,65,0,0,0,0,0,0,0,0,0,0,0,'respawn gobject'),
(8,4845,1,9,66209,65,0,0,0,0,0,0,0,0,0,0,0,'respawn gobject'),
-- Wave 1
(8,4845,5,10,10602,432000,0,0,0,1,0,0,0,-33.04, -385.57, 48.60, 5.98,'summon MAGUS'),
(8,4845,5,10,10601,432000,0,0,0,1,0,0,0,-16.12, -376.99, 49.20, 4.89,'summon ENFORCER'),
(8,4845,5,10,10601,432000,0,0,0,1,0,0,0,-25.13, -376.60, 48.94, 5.17,'summon ENFORCER'),
-- Wave 2
(8,4845,13,10,10602,432000,0,0,0,1,0,0,0,-14.93, -381.99, 49.04, 4.70,'summon MAGUS'),
(8,4845,28,10,10602,432000,0,0,0,1,0,0,0,-35.47, -371.36, 50.22, 4.79,'summon MAGUS'),
(8,4845,28,10,10601,432000,0,0,0,1,0,0,0,-47.54, -368.11, 51.67, 5.70,'summon ENFORCER'),
-- Wave 3
(8,4845,42,10,10602,432000,0,0,0,1,0,0,0,-33.04, -385.57, 48.60, 5.98,'summon MAGUS'),
(8,4845,42,10,10602,432000,0,0,0,1,0,0,0,-14.58, -375.16, 49.31, 4.73,'summon MAGUS'),
(8,4845,42,10,10601,432000,0,0,0,1,0,0,0,-24.91, -376.41, 48.95, 4.67,'summon ENFORCER'),
-- Spawn Urok
(8,4845,58,10,10602,432000,0,0,0,1,0,0,0,-47.54, -368.11, 51.67, 5.70,'summon MAGUS'),
(8,4845,66,10,10584,432000,0,0,0,1,0,0,0,-23.97, -391.89, 48.58, 1.68,'summon Urok');

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL ABOVE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

        -- If we get here ok, commit the changes
        IF bRollback = TRUE THEN
            ROLLBACK;
            SHOW ERRORS;
            SELECT '* UPDATE FAILED *' AS `===== STATUS =====`,@cCurResult AS `===== DB IS ON VERSION: =====`;



        ELSE
            COMMIT;
            SELECT '* UPDATE COMPLETE *' AS `===== STATUS =====`,@cNewResult AS `===== DB IS NOW ON VERSION =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== STATUS =====`,@cCurResult AS `===== DB IS already ON VERSION =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== STATUS =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
		IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
		    SET @cCurVersion := (SELECT `VERSION` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== STATUS =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== FOUND VERSION =====`;
		ELSE
		    SET @cCurVersion := (SELECT `VERSION` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `VERSION` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SELECT '* UPDATE SKIPPED *' AS `===== STATUS =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== FOUND VERSION =====`;
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