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
    SET @cOldStructure = '20'; 
    SET @cOldContent = '001';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '20';
    SET @cNewContent = '002';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Item loot template errors';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fix DB errors at core startup related to item_loot_template';

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
		
		
		DELETE FROM `item_loot_template` WHERE `entry` IN (21742,21741,21243,21164,21162,21131,6715,18636);

		/*
			Fix loot template for "Large Rocket Recipes" (entry = 21742)
			See: https://classic.wowhead.com/item=21742/large-rocket-recipes
		*/

		INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) 
		VALUES ('21742', '21727', '100', '1', '1', '1', '0'),
			   ('21742', '21728', '100', '2', '1', '1', '0'),
			   ('21742', '21729', '100', '3', '1', '1', '0');
			   
		/*
			Fix loot template for "Cluster Rocket Recipes"
			See : https://classic.wowhead.com/item=21741/cluster-rocket-recipes
		*/	
		INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) 
		VALUES 	('21741', '21730', '100', '1', '1', '1', '0'),
				('21741', '21731', '100', '2', '1', '1', '0'),
				('21741', '21732', '100', '3', '1', '1', '0');

		/*
			Fix loot template for "Bloated Mightfish"
			See : https://classic.wowhead.com/item=21243/bloated-mightfish
			WARNING : loot percentage is not currently known for everything....
			Added a 100% chance droprate on https://classic.wowhead.com/item=13754/raw-glossy-mightfish#fished-in
			for more "blizzlike" behavior 
		*/	
		INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) 
		VALUES 	('21243', '12361', '25', '1', '1', '1', '0'),
				('21243', '7553', '12.5', '2', '1', '1', '0'),
				('21243', '7910', '37.5', '3', '1', '1', '0'),
				('21243', '13754', '100', '5', '1', '1', '0'),
				('21243', '7909', '37.5', '4', '1', '1', '0');
				
				
		/*
			Fix loot template for "Bloated Rockscale Cod"
			See : https://classic.wowhead.com/item=21164/bloated-rockscale-cod#fished-in
			WARNING : loot percentage is not currently known for everything....
			Added a 100% chance droprate on https://fr.classic.wowhead.com/item=4594
			for more "blizzlike" behavior 
			Also added 50% chance for recipe : https://classic.wowhead.com/item=6369/recipe-rockscale-cod#fished-in
		*/	
		INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) 
		VALUES 	('21164', '12361', '25', '1', '1', '1', '0'),
				('21164', '7553', '12.5', '2', '1', '1', '0'),
				('21164', '7910', '37.5', '3', '1', '1', '0'),
				('21164', '4594', '100', '5', '1', '1', '0'),
				('21164', '6369', '50', '6', '1', '1', '0'),
				('21164', '7909', '37.5', '4', '1', '1', '0');
				
		/*
			Fix loot template for "Bloated Oily Blackmouth"
			See : https://classic.wowhead.com/item=21162/bloated-oily-blackmouth#fished-in
			WARNING : loot percentage is not currently known for everything....
		*/

		INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) 
		VALUES 	
			('21162', '1529', '12.5', '1', '1', '1', '0'),
			('21162', '1206', '12.5', '2', '1', '1', '0'),
			('21162', '6370', '7.5', '3', '1', '1', '0'),
			('21162', '6358', '100', '4', '1', '1', '0')
				;		
				
		/*
			Fix loot for "Bloated Oily Blackmouth"
			See : https://classic.wowhead.com/item=21131/followup-combat-assignment#see-also
			WARNING : Not so much info about it so duplicate behavior of : (Related to AQ quests war effort)
				https://classic.wowhead.com/item=20808/combat-assignment#comments
		*/

		INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) 
		VALUES 	
			('21131', '22648', '25', '1', '1', '1', '0'),
			('21131', '22649', '35', '1', '1', '1', '0'),
			('21131', '22650', '40', '1', '1', '1', '0')
			;
				
				
		/*
			Attempt to fix "Ruined Jumper Cables" 
			See : https://www.wowhead.com/item=6715/ruined-jumper-cables
			Before Patch 1.5, Goblin Jumper Cables used to occasionally break, producing this item. 
			It contained some of the mats needed to make new jumper cables.
			Ref : https://wow.gamepedia.com/Ruined_Jumper_Cables
			So lootable items would be some parts needed to craft : https://www.wowhead.com/item=7148/goblin-jumper-cables#taught-by-item
			 * https://www.wowhead.com/item=3575/iron-bar (up to 6)
			 * https://www.wowhead.com/item=4375/whirring-bronze-gizmo (up to 2)
			 * https://www.wowhead.com/item=814/flask-of-oil (up to 2)
			 * https://www.wowhead.com/item=4306/silk-cloth (up to 2)
			 * https://www.wowhead.com/item=1210/shadowgem (up to 2)
			 * https://www.wowhead.com/item=7191/fused-wiring (1)
		*/

		INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) 
		VALUES 	
			('6715', '3575', '50', '1', '1', '6', '0'),
			('6715', '4375', '33', '2', '1', '2', '0'),
			('6715', '814', '40', '3', '1', '2', '0'),
			('6715', '4306', '40', '4', '1', '2', '0'),
			('6715', '1210', '33', '2', '1', '2', '0'),
			('6715', '7191', '33', '2', '1', '1', '0')
			;


				
		/*
			Attempt to fix "Ruined Jumper Cables XL" 
			See : https://www.wowhead.com/item=18636/ruined-jumper-cables-xl
			Before Patch 1.5, Goblin Jumper Cables used to occasionally break, producing this item. 
			It contained some of the mats needed to make new jumper cables.
			Ref : https://wow.gamepedia.com/Ruined_Jumper_Cables_XL
			So lootable items would be some parts needed to craft : https://classic.wowhead.com/item=18587/goblin-jumper-cables-xl
			 * https://classic.wowhead.com/item=15994/thorium-widget (up to 2)
			 * https://classic.wowhead.com/item=18631/truesilver-transformer (up to 2)
			 * https://classic.wowhead.com/item=7191/fused-wiring (up to 2)
			 * https://classic.wowhead.com/item=14227/ironweb-spider-silk (up to 2)
			 * https://classic.wowhead.com/item=7910/star-ruby (up to 2)

		*/

		INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) 
		VALUES 	
			('18636', '15994', '33.33', '1', '1', '2', '0'),
			('18636', '18631', '33.33', '2', '1', '2', '0'),
			('18636', '7191', '100', '3', '1', '1', '0'),
			('18636', '14227', '40', '4', '1', '2', '0'),
			('18636', '7910', '55', '5', '1', '2', '0')
			;


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


