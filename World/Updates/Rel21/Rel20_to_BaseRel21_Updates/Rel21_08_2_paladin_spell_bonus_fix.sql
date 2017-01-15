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
    SET @cOldStructure = '8'; 
    SET @cOldContent = '1'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '8';
    SET @cNewContent = '2';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Paladin Spell bonus fix';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Paladin Spell bonus fix';

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

    DELETE FROM `spell_bonus_data` WHERE  `entry` IN (26573,879,24275,20424,20154,25735,25736,25737,25738,25739,25740,25713,25742); 
    INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `one_hand_direct_bonus`, `two_hand_direct_bonus`, `direct_bonus_done`, `one_hand_direct_bonus_done`, `two_hand_direct_bonus_done`, `direct_bonus_taken`, `one_hand_direct_bonus_taken`, `two_hand_direct_bonus_taken`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES ('20424', '0.2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Paladin - Seal of Command Proc');
    INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `one_hand_direct_bonus`, `two_hand_direct_bonus`, `direct_bonus_done`, `one_hand_direct_bonus_done`, `two_hand_direct_bonus_done`, `direct_bonus_taken`, `one_hand_direct_bonus_taken`, `two_hand_direct_bonus_taken`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES ('25735', '0', '0.1', '0.125', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Paladin - Seal of Righteousness Dummy Proc');
    INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `one_hand_direct_bonus`, `two_hand_direct_bonus`, `direct_bonus_done`, `one_hand_direct_bonus_done`, `two_hand_direct_bonus_done`, `direct_bonus_taken`, `one_hand_direct_bonus_taken`, `two_hand_direct_bonus_taken`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES ('25736', '0', '0.1', '0.125', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Paladin - Seal of Righteousness Dummy Proc');
    INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `one_hand_direct_bonus`, `two_hand_direct_bonus`, `direct_bonus_done`, `one_hand_direct_bonus_done`, `two_hand_direct_bonus_done`, `direct_bonus_taken`, `one_hand_direct_bonus_taken`, `two_hand_direct_bonus_taken`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES ('25737', '0', '0.1', '0.125', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Paladin - Seal of Righteousness Dummy Proc');
    INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `one_hand_direct_bonus`, `two_hand_direct_bonus`, `direct_bonus_done`, `one_hand_direct_bonus_done`, `two_hand_direct_bonus_done`, `direct_bonus_taken`, `one_hand_direct_bonus_taken`, `two_hand_direct_bonus_taken`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES ('25738', '0', '0.1', '0.125', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Paladin - Seal of Righteousness Dummy Proc');
    INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `one_hand_direct_bonus`, `two_hand_direct_bonus`, `direct_bonus_done`, `one_hand_direct_bonus_done`, `two_hand_direct_bonus_done`, `direct_bonus_taken`, `one_hand_direct_bonus_taken`, `two_hand_direct_bonus_taken`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES ('25739', '0', '0.1', '0.125', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Paladin - Seal of Righteousness Dummy Proc');
    INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `one_hand_direct_bonus`, `two_hand_direct_bonus`, `direct_bonus_done`, `one_hand_direct_bonus_done`, `two_hand_direct_bonus_done`, `direct_bonus_taken`, `one_hand_direct_bonus_taken`, `two_hand_direct_bonus_taken`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES ('25740', '0', '0.1', '0.125', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Paladin - Seal of Righteousness Dummy Proc');
    INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `one_hand_direct_bonus`, `two_hand_direct_bonus`, `direct_bonus_done`, `one_hand_direct_bonus_done`, `two_hand_direct_bonus_done`, `direct_bonus_taken`, `one_hand_direct_bonus_taken`, `two_hand_direct_bonus_taken`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES ('25742', '0', '0.1', '0.125', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Paladin - Seal of Righteousness Dummy Proc');
    INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `one_hand_direct_bonus`, `two_hand_direct_bonus`, `direct_bonus_done`, `one_hand_direct_bonus_done`, `two_hand_direct_bonus_done`, `direct_bonus_taken`, `one_hand_direct_bonus_taken`, `two_hand_direct_bonus_taken`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES ('25713', '0', '0.1', '0.125', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Paladin - Seal of Righteousness Dummy Proc');

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
