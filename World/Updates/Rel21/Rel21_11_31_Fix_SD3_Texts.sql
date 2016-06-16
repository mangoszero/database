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
    SET @cOldStructure = '11'; 
    SET @cOldContent = '30';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '31';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Fix_SD3_Texts';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fix_SD3_Texts';

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

    --
-- Dumping data for table `gossip_texts`
--

DELETE FROM `gossip_texts` WHERE `entry` IN (-3000000,-3000105,-3000106,-3000107,-3000108,-3000109,-3000110,-3230000);
DELETE FROM `gossip_texts` WHERE `entry` IN (-3033000,-3043000,-3090000,-3230001,-3230002,-3409000,-3409001,-3409002);
DELETE FROM `gossip_texts` WHERE `entry` IN (-3469000,-3469001,-3469002,-3469003,-3469004,-3509000,-3509001);

/*!40000 ALTER TABLE `gossip_texts` DISABLE KEYS */;
INSERT INTO `gossip_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `comment`) VALUES 
(-3000000,'[PH] SD2 unknown text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GOSSIP_ID_UNKNOWN_TEXT'),
(-3000105,'Ezekiel said that you might have a certain book...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'dirty larry GOSSIP_ITEM_BOOK'),
(-3000106,'Let Marshal Windsor know that I am ready.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'squire rowe GOSSIP_ITEM_WINDSOR'),
(-3000107,'I am ready, as are my forces. Let us end this masquerade!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'reginald windsor GOSSIP_ITEM_START'),
(-3000108,'I need a moment of your time, sir.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'prospector anvilward GOSSIP_ITEM_MOMENT'),
(-3000109,'I am ready, Oronok. Let us destroy Cyrukh and free the elements!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'oronok torn-heart GOSSIP_ITEM_FIGHT'),
(-3000110,'Why... yes, of course. I\'ve something to show you right inside this building, Mr. Anvilward.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'prospector anvilward GOSSIP_ITEM_SHOW'),
(-3033000,'Please unlock the courtyard door.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'deathstalker adamant/ sorcerer ashcrombe - GOSSIP_ITEM_DOOR'),
(-3043000,'Let the event begin!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Disciple of Naralex - GOSSIP_ITEM_BEGIN'),
(-3090000,'I am ready to begin.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'emi shortfuse GOSSIP_ITEM_START'),
(-3230000,'You\'re free, Dughal! Get out of here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'dughal GOSSIP_ITEM_DUGHAL'),
(-3230001,'Get out of here, Tobias, you\'re free!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'tobias GOSSIP_ITEM_TOBIAS'),
(-3230002,'Your bondage is at an end, Doom\'rel. I challenge you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'doomrel GOSSIP_ITEM_CHALLENGE'),
(-3409000,'Tell me more.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'majordomo_executus GOSSIP_ITEM_SUMMON_1'),
(-3409001,'What else do you have to say?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'majordomo_executus GOSSIP_ITEM_SUMMON_2'),
(-3409002,'You challenged us and we have come. Where is this master you speak of?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'majordomo_executus GOSSIP_ITEM_SUMMON_3'),

(-3469000,'I\'ve made no mistakes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'victor_nefarius GOSSIP_ITEM_NEFARIUS_1'),
(-3469001,'You have lost your mind, Nefarius. You speak in riddles.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'victor_nefarius GOSSIP_ITEM_NEFARIUS_2'),
(-3469002,'Please do.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'victor_nefarius GOSSIP_ITEM_NEFARIUS_3'),
(-3469003,'I cannot, Vaelastrasz! Surely something can be done to heal you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'vaelastrasz GOSSIP_ITEM_VAEL_1'),
(-3469004,'Vaelastrasz, no!!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'vaelastrasz GOSSIP_ITEM_VAEL_2'),
(-3509000,'Let\'s find out.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'andorov GOSSIP_ITEM_START'),
(-3509001,'Let\'s see what you have.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'andorov GOSSIP_ITEM_TRADE');
/*!40000 ALTER TABLE `gossip_texts` ENABLE KEYS */;
   

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

