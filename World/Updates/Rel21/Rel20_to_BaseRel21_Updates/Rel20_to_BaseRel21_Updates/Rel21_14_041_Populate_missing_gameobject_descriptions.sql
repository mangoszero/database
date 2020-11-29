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
    SET @cOldContent = '040';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '14';
    SET @cNewContent = '041';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Update_GO_Descriptions';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Update_GameObject_Descriptions';

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

-- update M0 Creature_template from M1
UPDATE creature_template SET subname='Crocilisk Trainer' WHERE entry=2876;

-- update M0 from M2
UPDATE creature_template SET subname='Outland Armor Quartermaster' WHERE entry=12778;
UPDATE creature_template SET subname='Outland Armor Quartermaster' WHERE entry=12788;

-- update m0 from M3
UPDATE creature_template SET subname='The Den Mother' WHERE entry=534;
UPDATE creature_template SET subname='Grik\'nir\'s Servant' WHERE entry=946;
UPDATE creature_template SET subname='Gunsmith' WHERE entry=1073;
UPDATE creature_template SET subname='Innkeeper' WHERE entry=1156;
UPDATE creature_template SET subname='PH MODEL WIP' WHERE entry=2694;
UPDATE creature_template SET subname='Innkeeper' WHERE entry=3628;
UPDATE creature_template SET subname='Engineering Trainer' WHERE entry=4941;
UPDATE creature_template SET subname='Engineering Supplies' WHERE entry=7876;
UPDATE creature_template SET subname='Marshal Expeditions' WHERE entry=9117;
UPDATE creature_template SET subname='Marshal Expeditions' WHERE entry=9270;
UPDATE creature_template SET subname='Marshal Expeditions' WHERE entry=9271;
UPDATE creature_template SET subname='Marshal Expeditions' WHERE entry=9272;
UPDATE creature_template SET subname='Marshal Expeditions' WHERE entry=9618;
UPDATE creature_template SET subname='Marshal Expeditions' WHERE entry=9997;
UPDATE creature_template SET subname='Marshal Expeditions' WHERE entry=9998;
UPDATE creature_template SET subname='Marshal Expeditions' WHERE entry=10302;
UPDATE creature_template SET subname='Marshal Expeditions' WHERE entry=10977;
UPDATE creature_template SET subname='Argent Crusade' WHERE entry=11616;
UPDATE creature_template SET subname='Chieftain' WHERE entry=11858;
UPDATE creature_template SET subname='Outland Armor Quartermaster' WHERE entry=12778;
UPDATE creature_template SET subname='Outland Armor Quartermaster' WHERE entry=12788;
UPDATE creature_template SET subname='King of the Foulweald' WHERE entry=12918;

-- Update M0/M1/M2 Gameobjects from M3
UPDATE gameobject_template SET name='Longtoo - Teapee' WHERE entry=3265;
UPDATE gameobject_template SET name='Fire Pit' WHERE entry=6287;
UPDATE gameobject_template SET name='Bowel with Boobles' WHERE entry=176157;
UPDATE gameobject_template SET name='Brazier' WHERE entry=176326;
UPDATE gameobject_template SET name='Pull rope Bell' WHERE entry=177271;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184093;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184095;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184096;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184097;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184098;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184099;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184100;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184101;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184102;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184103;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184104;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184105;
UPDATE gameobject_template SET name='scroll' WHERE entry=184461;
UPDATE gameobject_template SET name='Logs on fire' WHERE entry=184507;
UPDATE gameobject_template SET name='Logs on fire' WHERE entry=184508;
UPDATE gameobject_template SET name='Logs on fire' WHERE entry=184509;
UPDATE gameobject_template SET name='Logs on fire' WHERE entry=184511;
UPDATE gameobject_template SET name='Logs on fire' WHERE entry=184512;
UPDATE gameobject_template SET name='Logs on fire' WHERE entry=184513;
UPDATE gameobject_template SET name='Logs on fire' WHERE entry=184514;
UPDATE gameobject_template SET name='Wooden Board' WHERE entry=184515;
UPDATE gameobject_template SET name='Large x2 Fire' WHERE entry=184579;
UPDATE gameobject_template SET name='Large x2 Fire' WHERE entry=184580;
UPDATE gameobject_template SET name='Large x2 Fire' WHERE entry=184581;
UPDATE gameobject_template SET name='Large x2 Fire' WHERE entry=184582;
UPDATE gameobject_template SET name='Large x2 Fire' WHERE entry=184583;
UPDATE gameobject_template SET name='Large x2 Fire' WHERE entry=184584;
UPDATE gameobject_template SET name='Large x2 Fire' WHERE entry=184585;
UPDATE gameobject_template SET name='Fire' WHERE entry=185571;
UPDATE gameobject_template SET name='Fire' WHERE entry=185572;
UPDATE gameobject_template SET name='Fire' WHERE entry=185573;


-- update M0 GameObjects from ytdb
UPDATE gameobject_template SET name='Fire Pit' WHERE entry=6286;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18047;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18048;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18049;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18050;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18051;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18052;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18053;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18054;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18055;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18056;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18057;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18058;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18059;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18060;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18061;
UPDATE gameobject_template SET name='Stand up Torch' WHERE entry=18062;
UPDATE gameobject_template SET name='Fire on ground' WHERE entry=56809;
UPDATE gameobject_template SET name='Fire Pit' WHERE entry=56810;
UPDATE gameobject_template SET name='Fire With Boiling Water' WHERE entry=103773;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=126337;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=126338;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=126339;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=126340;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=126341;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=126342;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=126345;
UPDATE gameobject_template SET name='Bed' WHERE entry=174849;
UPDATE gameobject_template SET name='Lever' WHERE entry=175432;
UPDATE gameobject_template SET name='Locked Cage' WHERE entry=175786;
UPDATE gameobject_template SET name='SmallBrazier31' WHERE entry=179874;
UPDATE gameobject_template SET name='SmallBrazier19' WHERE entry=179875;
UPDATE gameobject_template SET name='SmallBrazier03' WHERE entry=179876;
UPDATE gameobject_template SET name='SmallBrazier04' WHERE entry=179877;
UPDATE gameobject_template SET name='SmallBrazier01' WHERE entry=179878;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=183497;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=183498;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=183499;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=183500;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=183501;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=183502;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184094;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=184114;
UPDATE gameobject_template SET name='Large Fire' WHERE entry=184416;
UPDATE gameobject_template SET name='Large x2 Fire' WHERE entry=184563;
UPDATE gameobject_template SET name='Large x2 Fire' WHERE entry=184564;
UPDATE gameobject_template SET name='Cooking Fire' WHERE entry=184565;


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
