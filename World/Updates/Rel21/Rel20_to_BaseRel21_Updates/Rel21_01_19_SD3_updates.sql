-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
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
    SET @cOldStructure = '1'; 
    SET @cOldContent = '18'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '1';
    SET @cNewContent = '19';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'SD3_Updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Updates to SD3';

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

-- add script WP for ...
DELETE FROM `script_waypoint` WHERE `entry`=9456 AND `pointid` IN (0,1,2,3);
INSERT INTO `script_waypoint` values(9456, 3, -263.99, -1961.64, 94.94, 0, "Infront of Deathgate's Binker");
INSERT INTO `script_waypoint` values(9456, 2, -261.82, -1923.24, 91.77, 0, "Nearing Deathgate's Binker");
INSERT INTO `script_waypoint` values(9456, 1, -286.50, -1890.81, 92.34, 0, "Between First Bunker and Destroyed Structure");
INSERT INTO `script_waypoint` values(9456, 0, -283.66, -1858.45, 92.47, 0, "Start");

-- WP type movement for ...
update creature_template set MovementType=2 where entry=9456;

-- add scripts
DELETE FROM `script_binding` WHERE `type`=0 AND `bind` IN (9523,9524,9526);
insert into script_binding values(0, "npc_warlord_kromzar", 9456, 0);
insert into script_binding values(0, "npc_kolkar_invader", 9524, 0);
insert into script_binding values(0, "npc_kolkar_invader", 9523, 0);

-- textes
update script_texts set content_default="Kolkar are the strongest!" where entry = -1000894;
update script_texts set content_default="Kolkar invaders are retreating!" where entry = -1000893;
update script_texts set content_default="Our foes will fall!" where entry = -1000897;
update script_texts set content_default="Defend the bunkers!" where entry = -1000896;
update script_texts set content_default="For the Horde!" where entry = -1000895;
update script_texts set content_default="Beware $N! Look to the west!" where entry = -1000891;
update script_texts set content_default="A defender has fallen!" where entry = -1000892;


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
                SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurResult AS `===== Found Version =====`;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;