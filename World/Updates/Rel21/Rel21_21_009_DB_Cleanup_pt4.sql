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
    SET @cOldStructure = '21'; 
    SET @cOldContent = '008';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '21';
    SET @cNewContent = '009';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'DB_Cleanup_pt4';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'DB_Cleanup_pt4';

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
		
UPDATE `quest_template` SET `RequestItemsText`='' WHERE `entry`='8101';
UPDATE `quest_template` SET `RequestItemsText`='' WHERE `entry`='8110';
UPDATE `quest_template` SET `RequestItemsText`='' WHERE `entry`='8116';

UPDATE `quest_template` SET `RequestItemsText`='A Corruptor\'s Scourgestone is the insignia of the Scourge\'s overlords. A powerful being that holds a position of authority over the Scourge will always possess one. To slay such a malevolent creature would surely advance the cause of the Argent Dawn, and all good causes!$B$BOn behalf of the Argent Dawn, I will give you a valor token in exchange for just a single one of these insignia. Use caution in acquiring one, $N - such powerful beings are not to be trifled with.' WHERE `entry`='5404';
UPDATE `quest_template` SET `RequestItemsText`='A Corruptor\'s Scourgestone is the insignia of the Scourge\'s overlords. A powerful being that holds a position of authority over the Scourge will always possess one. To slay such a malevolent creature would surely advance the cause of the Argent Dawn, and all good causes!$B$BOn behalf of the Argent Dawn, I will give you a valor token in exchange for just a single one of these insignia. Use caution in acquiring one, $N - such powerful beings are not to be trifled with.' WHERE `entry`='5406';

UPDATE `quest_template` SET `details`='' WHERE `entry`='6861';
UPDATE `quest_template` SET `details`='' WHERE `entry`='6862';

UPDATE `quest_template` SET `RequestItemsText`='You appear to have uncovered the wreckage of... a robotic chicken? The voice from within the egg crackles to life again:$B$B"Yes, excellent work! This is indeed my homing robot, though my sensors indicate that it needs a jump start before it can fly back to Booty Bay for repairs. Go ahead and place the beacon inside the rover - the beacon will take care of the rest!"' WHERE `entry`='351';

UPDATE `quest_template` SET `details`='Back so soon? You\'ll be a real miner in no time, $C. So, you already know the drill; I need you to go out, mine up a mess of copper ore, smelt it into bars and bring it back to me here. I know that\'s something you\'re capable of, the question is, are you willing?' WHERE `entry`='8533';

UPDATE `quest_template` SET `details`='What! You again? Well I\'ll be a monkey\'s uncle... except that I\'m a gnome. Slicky Gastronome to be precise! So you\'re back to help out again, eh? Well, I can\'t say as I blame you. Don\'t you just love the smell of all of that food? <drool>$B$BEnough loitering! Get out there and bring me back more rainbow fin albacore!' WHERE `entry`='8525';

UPDATE `quest_template` SET `details`='Back so soon? Stop making me re-evaluate my low opinion of you, $C, you\'re making me feel all gooey inside. So, as you can tell we still don\'t have enough iron bars for all of the weapons, armor, steam tanks and whatnot that need building for the bug hunt. Think you have it in you to bring back another stack of twenty iron bars in between all of those trips to Zul\'Gurub, or wherever it is that you kids hang out these days?' WHERE `entry`='8495';

UPDATE `quest_template` SET `details`='It is so good to see you again, $N. I hope that you\'ve been doing well. It\'s true that we are still in need of thorium bars. If you have them to spare I am collecting them for the Ahn\'Qiraj war effort.' WHERE `entry`='8500';

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


