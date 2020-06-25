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
    SET @cOldContent = '012';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '21';
    SET @cNewContent = '013';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'DB_Cleanup_Pt5';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'DB_Cleanup_Pt5';

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
		
UPDATE `quest_template` SET `RequestItemsText`='You have found a sickly, corrupted version of what appears to be a Night Dragon plant. The fruits that hang from the plant appear rotten and poisonous. It desperately needs some sort of attention if it is to be turned back to normal.' WHERE `entry`='4119';
UPDATE `quest_template` SET `RequestItemsText`='You have found a sickly, corrupted version of what appears to be a Night Dragon plant. The fruits that hang from the plant appear rotten and poisonous. It desperately needs some sort of attention if it is to be turned back to normal.' WHERE `entry`='4447';
UPDATE `quest_template` SET `RequestItemsText`='Once the towers are marked, they\'ll become top priority targets for our attack on Andorhal. I suspect that once we neutralize the towers, the main threat of Andorhal will emerge. From that point on, we\'ll have a straight-up fight for control of the city!$B$BYou\'re back to report success, yes? Don\'t forget the beacon torch as well; we must maintain control of our materiel.' WHERE `entry`='5097';
UPDATE `quest_template` SET `title`='A Smokywood Pastures\' Thank You!' WHERE `entry`='6984';
UPDATE `quest_template` SET `title`='A Smokywood Pastures\' Thank You!' WHERE `entry`='7045';
UPDATE `quest_template` SET `details`='Lord Wishock is causing quite a stir amongst the House of Nobles. He was made aware of our little "establishment" down here and is lobbying for a full investigation. I have a plan to keep Wishock "preoccupied", but I\'ll need your help. $B$BThere is a flower growing in the Garden of Stalvan on the outskirts of Darkshire. This small white flower is known as the Tear of Tilloa. I will also need a Musquash Root, found only at the very base of the falls far beneath the Stonewrought Dam in the Wetlands.' WHERE `entry`='335';
UPDATE `quest_template` SET `details`='I\'m as anxious as you are to try out my portable shredder unit, $R, but before I can make the kit, I\'m going to need materials - lots of materials!$B$BTo be exact, I\'m going to need a mountain of thorium, mithril, and iron. I will also need one steamsaw per unit. You\'ll have to get those at the lumber mill.$B$BWhen I was nosing around in here (before my capture) I noticed a pile of steamsaws at the Stormpike lumber camp.' WHERE `entry`='6861';
UPDATE `quest_template` SET `details`='I\'m as anxious as you are to try out my portable shredder unit, $R, but before I can make the kit, I\'m going to need materials - lots of materials!$B$BTo be exact, I\'m going to need a mountain of thorium, mithril, and iron. I will also need one steamsaw per unit. You\'ll have to get those at the lumber mill.$B$BWhen I was nosing around in here (before my capture) I noticed a pile of steamsaws at the Stormpike lumber camp.' WHERE `entry`='6862';
UPDATE `quest_template` SET `details`='Give \'em a limp, $N. They must learn that the gnomish people won\'t take to being bullied!' WHERE `entry`='7424';
UPDATE `quest_template` SET `details`='Give \'em a limp, $N. They must learn that the gnomish people won\'t take to being bullied!' WHERE `entry`='7424';

		
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


