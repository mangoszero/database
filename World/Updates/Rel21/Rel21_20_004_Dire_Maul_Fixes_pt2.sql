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
    SET @cOldContent = '003';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '20';
    SET @cNewContent = '004';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Dire_Maul_Fixes_pt2';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Fix Broken trap quest an more other things';

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
		
		/*
			Script binding for go_fixed trap
		*/
		DELETE FROM `script_binding` WHERE `ScriptName` = 'go_fixed_trap' ;
		INSERT INTO `script_binding`
			(`type`,`ScriptName`,`bind`,`data`)
		VALUES 
			(1, 'go_fixed_trap', 179512,0);


		/*
			Correct faction settings for :
				- Guard Slip'kik
				- Captain Kromcrush
				- Guard Mol'dar
		*/
		UPDATE `creature_template` 
		SET 
			`FactionAlliance` = 1374, 
			`FactionHorde` = 1374 
		WHERE 
			`Entry` IN( 14326, 14323, 14325);


		/*
			Missing script texts
		*/
		DELETE FROM `script_texts` WHERE `entry` IN (-1429004, -1429003 );
			
		INSERT INTO `script_texts` (`entry`, `content_default`, `comment`) 
		VALUES (-1429004, 'D\'oh !','SAY_SLIPKIK_TRAP'),
			   (-1429003,'The king is dead - OH NOES! Summon Mizzle da Crafty! He knows what to do next!','SAY_CHORUSH_KING_DEAD');

		/*
			Quest 1193 "A broken trap" should be repetable if you come back in the instance when its is rebooted.
		*/
		UPDATE `quest_template` 
		SET 
			`SpecialFlags` = 1
		WHERE 
			`entry` = 1193;

		/*
			Despawn GO which gives the quest 1193 "A broken trap"
		*/
		DELETE FROM `db_scripts` 
		WHERE `script_type` = 1 AND `id` = 1193 AND `command` = 40;

		INSERT INTO `db_scripts` 
			(`script_type`, `id`, `delay`, `command`,`datalong`, `datalong2`, `comments`) 
		VALUES 
			(1, 1193, 2, 40, 12657, 3600, 'Unspawn Broken trap after quest 1193 end');
		
		/*
			Fix missing gossip_menu_actions for buffs with : 
				- Guard Slip'kik
				- Guard Fengus
				- Guard Mol'dar
		*/
		
		-- ####### Slip'kik #######
		DELETE FROM `gossip_menu` WHERE entry = 52000 AND `text_id` = 6906 AND `script_id` = 0;
		INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES (52000, 6906, 0, 0);
		
		UPDATE `gossip_menu_option` 
		SET 
			`action_script_id` = 510041 ,
			`action_menu_id`   = 52000
		WHERE `menu_id` = 51002 AND `id` = 0;
		
		-- Wrong npc text for gossip intro text , so update it :
		UPDATE `npc_text` SET `text0_0` = 'I show you how smart I am, boss!  You be extra smart with mighty magic mojo now!$B$BUm... maybe Slip\'kik use magic on self. Dat would be good idea...' 
		WHERE (`ID` = 6906);


		-- ####### Fengus #######
		DELETE FROM `gossip_menu` WHERE entry = 52002 AND `text_id` = 6904 AND `script_id` = 0;
		INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) 
		VALUES (52002, 6904, 0, 0);
		
		UPDATE `gossip_menu_option` 
		SET 
			`action_script_id` = 510031 ,			
			`action_menu_id`   = 52002,
			`option_text`= 'I am, am I? Well what have you got for the new big dog of Gordok, Fengus?'
			
		WHERE `menu_id` = 51003 AND `id` = 0;
		
		
		
		-- ####### Moldar #######
		DELETE FROM `gossip_menu` WHERE `entry` = 52001 AND `text_id` = 6908 AND `script_id` = 0;
		INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) 
		VALUES (52001, 6908, 0, 0);
		
		UPDATE `gossip_menu_option` 
		SET 
			`action_script_id` = 510021,
			`action_menu_id`   = 52001
		WHERE `menu_id` = 51004 AND `id` = 0;
				
		/*
			Must Hide gossip menu if not king of gordok and npc flag will be set on King gordok death
			For Komcrush captain
		*/
		UPDATE `gossip_menu` SET `condition_id` = 976 WHERE (`entry` = 5739) and (`text_id` = 6914) and (`script_id` = 0);
		UPDATE `gossip_menu_option` SET `condition_id` = 976 WHERE (`menu_id` = 5739) and (`id` = 1);


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


