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
    SET @cOldStructure = '12'; 
    SET @cOldContent = '3';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '12';
    SET @cNewContent = '4';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Encrypted_Letter';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Encrypted Letter and various text fixes';

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

UPDATE quest_template SET OfferRewardText = 'You\'re gonna find a number of outfits that covet our skills, $N. Adventurers, SI:7... heck, even the Defias Brotherhood wouldn\'t mind a spy or two inside Stormwind. But you remember this, you\'re your own man. Don\'t let nobody bully you into doing something you don\'t wanna do! Besides, we hold all the cards... at least, we do before the game\'s done. Know what I mean?$B$BAnyway, just wanted to introduce myself and let you know that I\'m here if you need any training. Come by anytime.' WHERE entry = 3102 AND Title = 'Encrypted Letter';
UPDATE db_script_string SET content_default = 'The invisibility liquor is ready for you, $n.' WHERE entry = 2000000134;
UPDATE db_script_string SET content_default = 'Oooooo hot hot hot! If that won\'t put spring IN your step, I don\'t know what will!' WHERE entry = 2000000046;
UPDATE page_text SET text = 'King Llane I of the House of Wrynn $B$BLiege Lord of Stormwind $B$BDefender of Azeroth ' WHERE entry = 2292;
UPDATE page_text SET text = 'Archbishop Alonsus Faol $B$BBenevolent patron of the Church of Light. $B$BThough he began his good work in Stratholme, Lordaeron, Archbishop Faol was a great friend to the people of Stormwind. In the dark days after the Second War, he helped to reform the Brotherhood of Northshire and raised vast funds to rebuild Stormwind city itself. $B$BThis Cathedral stands not only as a bastion of the Holy Light, but as a lasting testament to one man\'s noble spirit and generosity. ' WHERE entry = 2291;
UPDATE page_text SET text = 'Nessa, $B$BIt is good to hear from you. The collection of bones and scales  you sent me was incredible.  Never have I seen fish of that size off the mainland.  The fishers of Rut\'theran must pull in easily a ton of fish each day! I envy the size of their bounty, but I am a small bit troubled as well.  Could our new world tree make the fish grow to such a size?  If that is so, what other effects might it have? $B$BQuestions to ponder, $B-Laird ' WHERE entry = 2513;
UPDATE page_text SET text = 'managed to get the better of the ugly brute, but he\'s now nursing a nasty cut on his arm. Looks like I\'ll have to do the chores for a while. $B$BDAY THREE $B$BCold. Snowed a bit around noon. $B$BDAY FOUR $B$BThe lad was back and in good spirits today, so we took our first look at the trolls. Frostmane, I\'d say, judging by the markings on their skin and the various trinkets they wore on their bodies. ' WHERE entry = 81;
UPDATE page_text SET text = 'DAY FIVE $B$BHad the lad watch over the camp and I snuck over to the cave and took a look around. The trolls\' numbers are somewhat troublesome. The Mountaineers might have to be summoned in force if the cave is to be cleared of the troll infestation. $B$BI realize I have not mentioned the troggs of late. They appear in the area in greater numbers, but they are so primitive that they do not pose much of a threat. Time may say if this is true or not. ' WHERE entry = 82;	
UPDATE page_text SET text = 'And not a drop of ale for almost a week now. $B$BDAY SIX $B$BCold again. Snows. Trolls. No ale. $B$BDAY SEVEN $B$BSnow below so white, Sky above so blue, Wolves will howl the night, Not a drop of brew. $B$BDAY EIGHT $B$BThe trolls are perhaps not as large a problem as we initially thought. They have some ' WHERE entry = 83;
UPDATE page_text SET text = 'A Report on the State of the Frostmane Trolls in the General Area of Dun Morogh $B$BThe trolls situated in Dun Morogh are largely centralized in Frostmane Hold, a mountain cave on the western border. They have sufficient numbers to cause some concern, however, they seem more than content to stay in their cave. This is, no doubt, because they do not wish to incur the wrath of the dwarves again, and risk total extermination. Their actions can be considered territorial, if anything, and it is ' where entry = 88;
UPDATE page_text SET text = 'my belief that they pose no real threat to us, so long as we do not encroach upon their territory. This may be a situation unappealing to the dwarven populace, but given the dispersal of military resources, it may be prudent to relegate the extermination of the trolls to a lower level of importance, and continue to focus on the threat posed by the troggs and the Dark Irons. $B$BEnclosed, you will also find a copy of my brother Grelin\'s report on Anvilmar. $B$BSigned, $BSenir Whitebeard ' where entry = 89;
UPDATE page_text SET text = 'A Report on the State of the Frostmane Trolls in the General Area of Coldridge Valley $B$BPrepared by Grelin Whitebeard, Senate Special Envoy $B$BFrom the time that I have spent observing the movement of the Frostmane trolls in the Coldridge Valley area, I have determined that they pose no large threat to dwarven settlements in the area. Moreover, they are a threat that can be eliminated with little additional support from the army. Through the assistance of Mountaineers already stationed in ' WHERE entry = 90;
UPDATE page_text SET text = 'Coldridge Valley and mercenaries (paid with funds set aside by the Senate prior to my dispatchment), I am confident that the problem will be solved in short order. $B$BThis action has been authorized with the sanction given to me by King Bronzebeard. ' WHERE entry = 91;
UPDATE page_text SET text = 'To the Schneiders, $B$BGood day.  I trust business in the canal district is good.  We are booming here in the trader\'s square. $B$BWe are in need of knitted cloth goods, as our supply is all but depleted.  Please send the standard load as soon as you are able. $B$BGood fortune, and I hope your son Thurman\'s studies progress well, $B$B--Harlan Bagley ' WHERE entry = 336;
		
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
