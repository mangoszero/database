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
    SET @cOldContent = '006';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '21';
    SET @cNewContent = '007';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'DB_Cleanup_pt2';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'DB_Cleanup_pt2';

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
		
-- Fix EndText Field
UPDATE `quest_template` SET `EndText`=REPLACE(`EndText`,'$b','$B') WHERE `EndText` LIKE '%$b%';
UPDATE `quest_template` SET `EndText`=REPLACE(`EndText`,'$c','$C') WHERE `EndText` LIKE '%$c%';
UPDATE `quest_template` SET `EndText`=REPLACE(`EndText`,'$g','$G') WHERE `EndText` LIKE '%$g%';
UPDATE `quest_template` SET `EndText`=REPLACE(`EndText`,'$n','$N') WHERE `EndText` LIKE '%$n%';
UPDATE `quest_template` SET `EndText`=REPLACE(`EndText`,'$r','$R') WHERE `EndText` LIKE '%$r%';
UPDATE `quest_template` SET `EndText`=LEFT(`EndText`,LENGTH(`EndText`)-1) WHERE `EndText` LIKE '%. ';
UPDATE `quest_template` SET `EndText`=REPLACE(`EndText`,'.  ','. ') WHERE `EndText` LIKE '%.  %';
UPDATE `quest_template` SET `EndText`=REPLACE(`EndText`,',  ',', ') WHERE `EndText` LIKE '%,  %';
UPDATE `quest_template` SET `EndText`=LEFT(`EndText`,LENGTH(`EndText`)-4) WHERE RIGHT(EndText,4)='$B$B';
UPDATE `quest_template` SET `EndText`=LEFT(`EndText`,LENGTH(`EndText`)-2) WHERE RIGHT(EndText,2)='$B';

-- Fix ObjectiveText1 Field
UPDATE `quest_template` SET `ObjectiveText1`=REPLACE(`ObjectiveText1`,'$b','$B') WHERE `ObjectiveText1` LIKE '%$b%';
UPDATE `quest_template` SET `ObjectiveText1`=REPLACE(`ObjectiveText1`,'$c','$C') WHERE `ObjectiveText1` LIKE '%$c%';
UPDATE `quest_template` SET `ObjectiveText1`=REPLACE(`ObjectiveText1`,'$g','$G') WHERE `ObjectiveText1` LIKE '%$g%';
UPDATE `quest_template` SET `ObjectiveText1`=REPLACE(`ObjectiveText1`,'$n','$N') WHERE `ObjectiveText1` LIKE '%$n%';
UPDATE `quest_template` SET `ObjectiveText1`=REPLACE(`ObjectiveText1`,'$r','$R') WHERE `ObjectiveText1` LIKE '%$r%';
UPDATE `quest_template` SET `ObjectiveText1`=LEFT(`ObjectiveText1`,LENGTH(`ObjectiveText1`)-1) WHERE `ObjectiveText1` LIKE '%. ';
UPDATE `quest_template` SET `ObjectiveText1`=REPLACE(`ObjectiveText1`,'.  ','. ') WHERE `ObjectiveText1` LIKE '%.  %';
UPDATE `quest_template` SET `ObjectiveText1`=REPLACE(`ObjectiveText1`,',  ',', ') WHERE `ObjectiveText1` LIKE '%,  %';
UPDATE `quest_template` SET `ObjectiveText1`=LEFT(`ObjectiveText1`,LENGTH(`ObjectiveText1`)-4) WHERE RIGHT(ObjectiveText1,4)='$B$B';
UPDATE `quest_template` SET `ObjectiveText1`=LEFT(`ObjectiveText1`,LENGTH(`ObjectiveText1`)-2) WHERE RIGHT(ObjectiveText1,2)='$B';

-- Fix ObjectiveText2 Field
UPDATE `quest_template` SET `ObjectiveText2`=REPLACE(`ObjectiveText2`,'$b','$B') WHERE `ObjectiveText2` LIKE '%$b%';
UPDATE `quest_template` SET `ObjectiveText2`=REPLACE(`ObjectiveText2`,'$c','$C') WHERE `ObjectiveText2` LIKE '%$c%';
UPDATE `quest_template` SET `ObjectiveText2`=REPLACE(`ObjectiveText2`,'$g','$G') WHERE `ObjectiveText2` LIKE '%$g%';
UPDATE `quest_template` SET `ObjectiveText2`=REPLACE(`ObjectiveText2`,'$n','$N') WHERE `ObjectiveText2` LIKE '%$n%';
UPDATE `quest_template` SET `ObjectiveText2`=REPLACE(`ObjectiveText2`,'$r','$R') WHERE `ObjectiveText2` LIKE '%$r%';
UPDATE `quest_template` SET `ObjectiveText2`=LEFT(`ObjectiveText2`,LENGTH(`ObjectiveText2`)-1) WHERE `ObjectiveText2` LIKE '%. ';
UPDATE `quest_template` SET `ObjectiveText2`=REPLACE(`ObjectiveText2`,'.  ','. ') WHERE `ObjectiveText2` LIKE '%.  %';
UPDATE `quest_template` SET `ObjectiveText2`=REPLACE(`ObjectiveText2`,',  ',', ') WHERE `ObjectiveText2` LIKE '%,  %';
UPDATE `quest_template` SET `ObjectiveText2`=LEFT(`ObjectiveText2`,LENGTH(`ObjectiveText2`)-4) WHERE RIGHT(ObjectiveText2,4)='$B$B';
UPDATE `quest_template` SET `ObjectiveText2`=LEFT(`ObjectiveText2`,LENGTH(`ObjectiveText2`)-2) WHERE RIGHT(ObjectiveText2,2)='$B';

-- Fix ObjectiveText3 Field
UPDATE `quest_template` SET `ObjectiveText3`=REPLACE(`ObjectiveText3`,'$b','$B') WHERE `ObjectiveText3` LIKE '%$b%';
UPDATE `quest_template` SET `ObjectiveText3`=REPLACE(`ObjectiveText3`,'$c','$C') WHERE `ObjectiveText3` LIKE '%$c%';
UPDATE `quest_template` SET `ObjectiveText3`=REPLACE(`ObjectiveText3`,'$g','$G') WHERE `ObjectiveText3` LIKE '%$g%';
UPDATE `quest_template` SET `ObjectiveText3`=REPLACE(`ObjectiveText3`,'$n','$N') WHERE `ObjectiveText3` LIKE '%$n%';
UPDATE `quest_template` SET `ObjectiveText3`=REPLACE(`ObjectiveText3`,'$r','$R') WHERE `ObjectiveText3` LIKE '%$r%';
UPDATE `quest_template` SET `ObjectiveText3`=LEFT(`ObjectiveText3`,LENGTH(`ObjectiveText3`)-1) WHERE `ObjectiveText3` LIKE '%. ';
UPDATE `quest_template` SET `ObjectiveText3`=REPLACE(`ObjectiveText3`,'.  ','. ') WHERE `ObjectiveText3` LIKE '%.  %';
UPDATE `quest_template` SET `ObjectiveText3`=REPLACE(`ObjectiveText3`,',  ',', ') WHERE `ObjectiveText3` LIKE '%,  %';
UPDATE `quest_template` SET `ObjectiveText3`=LEFT(`ObjectiveText3`,LENGTH(`ObjectiveText3`)-4) WHERE RIGHT(ObjectiveText3,4)='$B$B';
UPDATE `quest_template` SET `ObjectiveText3`=LEFT(`ObjectiveText3`,LENGTH(`ObjectiveText3`)-2) WHERE RIGHT(ObjectiveText3,2)='$B';

-- Fix ObjectiveText4 Field
UPDATE `quest_template` SET `ObjectiveText4`=REPLACE(`ObjectiveText4`,'$b','$B') WHERE `ObjectiveText4` LIKE '%$b%';
UPDATE `quest_template` SET `ObjectiveText4`=REPLACE(`ObjectiveText4`,'$c','$C') WHERE `ObjectiveText4` LIKE '%$c%';
UPDATE `quest_template` SET `ObjectiveText4`=REPLACE(`ObjectiveText4`,'$g','$G') WHERE `ObjectiveText4` LIKE '%$g%';
UPDATE `quest_template` SET `ObjectiveText4`=REPLACE(`ObjectiveText4`,'$n','$N') WHERE `ObjectiveText4` LIKE '%$n%';
UPDATE `quest_template` SET `ObjectiveText4`=REPLACE(`ObjectiveText4`,'$r','$R') WHERE `ObjectiveText4` LIKE '%$r%';
UPDATE `quest_template` SET `ObjectiveText4`=LEFT(`ObjectiveText4`,LENGTH(`ObjectiveText4`)-1) WHERE `ObjectiveText4` LIKE '%. ';
UPDATE `quest_template` SET `ObjectiveText4`=REPLACE(`ObjectiveText4`,'.  ','. ') WHERE `ObjectiveText4` LIKE '%.  %';
UPDATE `quest_template` SET `ObjectiveText4`=REPLACE(`ObjectiveText4`,',  ',', ') WHERE `ObjectiveText4` LIKE '%,  %';
UPDATE `quest_template` SET `ObjectiveText4`=LEFT(`ObjectiveText4`,LENGTH(`ObjectiveText4`)-4) WHERE RIGHT(ObjectiveText4,4)='$B$B';
UPDATE `quest_template` SET `ObjectiveText4`=LEFT(`ObjectiveText4`,LENGTH(`ObjectiveText4`)-2) WHERE RIGHT(ObjectiveText4,2)='$B';

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


