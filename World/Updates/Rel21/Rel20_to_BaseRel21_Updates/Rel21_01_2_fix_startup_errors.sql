-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos` ()

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
    SET @cOldContent = '1'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '1';
    SET @cNewContent = '2';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Fix startup errors';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = '';

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

    -- Correct scriptname
    UPDATE script_binding SET scriptname='spell_npc_redemption_target' WHERE scriptname='spell_symbol_of_life';

    -- TIGERS
    -- ======
    
    -- Stranglethorn Tigress
    -- ENTRY: 772

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 772 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (TYPE, ScriptName, bind, DATA) VALUES (0, 'mob_sleeping_creature', 772, 0);

    -- Stranglethorn Tiger
    -- ENTRY: 682

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 682 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (TYPE, ScriptName, bind, DATA) VALUES (0, 'mob_sleeping_creature', 682, 0);

    -- Young Stranglethorn Tiger
    -- ENTRY:  681

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 681 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (TYPE, ScriptName, bind, DATA) VALUES (0, 'mob_sleeping_creature', 681, 0);

    -- Elder Stranglethorn Tiger
    -- ENTRY:  1085

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 1085 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (TYPE, ScriptName, bind, DATA) VALUES (0, 'mob_sleeping_creature', 1085, 0);


    -- PANTHERS
    -- ========

    -- Shadowmaw Panther
    -- ENTRY:  684

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 684 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (TYPE, ScriptName, bind, DATA) VALUES (0, 'mob_sleeping_creature', 684, 0);

    -- Elder Shadowmaw Panther
    -- ENTRY:  1713

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 1713 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (TYPE, ScriptName, bind, DATA) VALUES (0, 'mob_sleeping_creature', 1713, 0);

    -- Young Panther
    -- ENTRY:  683

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 683 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (TYPE, ScriptName, bind, DATA) VALUES (0, 'mob_sleeping_creature', 683, 0);

    -- Panther
    -- ENTRY:  736

    -- Add script to creature
    DELETE FROM script_binding WHERE bind = 736 AND ScriptName = 'mob_sleeping_creature';
    INSERT INTO script_binding (TYPE, ScriptName, bind, DATA) VALUES (0, 'mob_sleeping_creature', 736, 0);

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