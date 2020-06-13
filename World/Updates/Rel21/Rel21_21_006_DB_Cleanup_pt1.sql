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
    SET @cOldContent = '005';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '21';
    SET @cNewContent = '006';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'DB_Cleanup_pt1';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'DB_Cleanup_pt1';

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
		
-- Fix Details Field
UPDATE `quest_template` SET `details`=REPLACE(`details`,'$b','$B') WHERE `details` LIKE '%$b%';
UPDATE `quest_template` SET `details`=REPLACE(`details`,'$c','$C') WHERE `details` LIKE '%$c%';
UPDATE `quest_template` SET `details`=REPLACE(`details`,'$g','$G') WHERE `details` LIKE '%$g%';
UPDATE `quest_template` SET `details`=REPLACE(`details`,'$n','$N') WHERE `details` LIKE '%$n%';
UPDATE `quest_template` SET `details`=REPLACE(`details`,'$r','$R') WHERE `details` LIKE '%$r%';
UPDATE `quest_template` SET `details`=LEFT(`details`,LENGTH(`details`)-1) WHERE `details` LIKE '%. ';
UPDATE `quest_template` SET `details`=REPLACE(`details`,'.  ','. ') WHERE `details` LIKE '%.  %';
UPDATE `quest_template` SET `details`=REPLACE(`details`,',  ',', ') WHERE `details` LIKE '%,  %';
UPDATE `quest_template` SET `details`=LEFT(`details`,LENGTH(`details`)-4) WHERE RIGHT(details,4)='$B$B';
UPDATE `quest_template` SET `details`=LEFT(`details`,LENGTH(`details`)-2) WHERE RIGHT(details,2)='$B';

-- Fix Objectives Field
UPDATE `quest_template` SET `Objectives`=REPLACE(`Objectives`,'$b','$B') WHERE `Objectives` LIKE '%$b%';
UPDATE `quest_template` SET `Objectives`=REPLACE(`Objectives`,'$c','$C') WHERE `Objectives` LIKE '%$c%';
UPDATE `quest_template` SET `Objectives`=REPLACE(`Objectives`,'$g','$G') WHERE `Objectives` LIKE '%$g%';
UPDATE `quest_template` SET `Objectives`=REPLACE(`Objectives`,'$n','$N') WHERE `Objectives` LIKE '%$n%';
UPDATE `quest_template` SET `Objectives`=REPLACE(`Objectives`,'$r','$R') WHERE `Objectives` LIKE '%$r%';
UPDATE `quest_template` SET `Objectives`=LEFT(`Objectives`,LENGTH(`Objectives`)-1) WHERE `Objectives` LIKE '%. ';
UPDATE `quest_template` SET `Objectives`=REPLACE(`Objectives`,'.  ','. ') WHERE `Objectives` LIKE '%.  %';
UPDATE `quest_template` SET `Objectives`=REPLACE(`Objectives`,',  ',', ') WHERE `Objectives` LIKE '%,  %';
UPDATE `quest_template` SET `Objectives`=LEFT(`Objectives`,LENGTH(`Objectives`)-4) WHERE RIGHT(Objectives,4)='$B$B';
UPDATE `quest_template` SET `Objectives`=LEFT(`Objectives`,LENGTH(`Objectives`)-2) WHERE RIGHT(Objectives,2)='$B';

-- Fix OfferRewardText Field
UPDATE `quest_template` SET `OfferRewardText`=REPLACE(`OfferRewardText`,'$b','$B') WHERE `OfferRewardText` LIKE '%$b%';
UPDATE `quest_template` SET `OfferRewardText`=REPLACE(`OfferRewardText`,'$c','$C') WHERE `OfferRewardText` LIKE '%$c%';
UPDATE `quest_template` SET `OfferRewardText`=REPLACE(`OfferRewardText`,'$g','$G') WHERE `OfferRewardText` LIKE '%$g%';
UPDATE `quest_template` SET `OfferRewardText`=REPLACE(`OfferRewardText`,'$n','$N') WHERE `OfferRewardText` LIKE '%$n%';
UPDATE `quest_template` SET `OfferRewardText`=REPLACE(`OfferRewardText`,'$r','$R') WHERE `OfferRewardText` LIKE '%$r%';
UPDATE `quest_template` SET `OfferRewardText`=LEFT(`OfferRewardText`,LENGTH(`OfferRewardText`)-1) WHERE `OfferRewardText` LIKE '%. ';
UPDATE `quest_template` SET `OfferRewardText`=REPLACE(`OfferRewardText`,'.  ','. ') WHERE `OfferRewardText` LIKE '%.  %';
UPDATE `quest_template` SET `OfferRewardText`=REPLACE(`OfferRewardText`,',  ',', ') WHERE `OfferRewardText` LIKE '%,  %';
UPDATE `quest_template` SET `OfferRewardText`=LEFT(`OfferRewardText`,LENGTH(`OfferRewardText`)-4) WHERE RIGHT(OfferRewardText,4)='$B$B';
UPDATE `quest_template` SET `OfferRewardText`=LEFT(`OfferRewardText`,LENGTH(`OfferRewardText`)-2) WHERE RIGHT(OfferRewardText,2)='$B';

-- Fix RequestItemsText Field
UPDATE `quest_template` SET `RequestItemsText`=REPLACE(`RequestItemsText`,'$b','$B') WHERE `RequestItemsText` LIKE '%$b%';
UPDATE `quest_template` SET `RequestItemsText`=REPLACE(`RequestItemsText`,'$c','$C') WHERE `RequestItemsText` LIKE '%$c%';
UPDATE `quest_template` SET `RequestItemsText`=REPLACE(`RequestItemsText`,'$g','$G') WHERE `RequestItemsText` LIKE '%$g%';
UPDATE `quest_template` SET `RequestItemsText`=REPLACE(`RequestItemsText`,'$n','$N') WHERE `RequestItemsText` LIKE '%$n%';
UPDATE `quest_template` SET `RequestItemsText`=REPLACE(`RequestItemsText`,'$r','$R') WHERE `RequestItemsText` LIKE '%$r%';
UPDATE `quest_template` SET `RequestItemsText`=LEFT(`RequestItemsText`,LENGTH(`RequestItemsText`)-1) WHERE `RequestItemsText` LIKE '%. ';
UPDATE `quest_template` SET `RequestItemsText`=REPLACE(`RequestItemsText`,'.  ','. ') WHERE `RequestItemsText` LIKE '%.  %';
UPDATE `quest_template` SET `RequestItemsText`=REPLACE(`RequestItemsText`,',  ',', ') WHERE `RequestItemsText` LIKE '%,  %';
UPDATE `quest_template` SET `RequestItemsText`=LEFT(`RequestItemsText`,LENGTH(`RequestItemsText`)-4) WHERE RIGHT(RequestItemsText,4)='$B$B';
UPDATE `quest_template` SET `RequestItemsText`=LEFT(`RequestItemsText`,LENGTH(`RequestItemsText`)-2) WHERE RIGHT(RequestItemsText,2)='$B';


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


