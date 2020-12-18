-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update (v1.4)
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
    SET @cOldStructure = '23'; 
    SET @cOldContent = '001';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '24'; -- If The Update contains any 'ALTER DATABASE' statements, increment this and set cNewContent to 001
    SET @cNewContent = '001';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Update deprecated ROW_FORMAT';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Update deprecated ROW_FORMAT field';

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

-- Mangos 0
ALTER TABLE areatrigger_tavern ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE areatrigger_teleport ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE battleground_events ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE battleground_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE battlemaster_entry ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE command ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE conditions ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_addon ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_ai_scripts ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_ai_summons ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_ai_texts ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_battleground ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_equip_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_equip_template_raw ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_item_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_linking ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_linking_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_loot_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_model_info ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_movement ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_movement_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_onkill_reputation ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_spells ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_template_addon ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_template_classlevelstats ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE creature_template_spells ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE custom_texts ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE db_scripts ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE db_script_string ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE disables ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE disenchant_loot_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE exploration_basexp ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE fishing_loot_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_event ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_event_mail ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_event_creature ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_event_creature_data ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_event_gameobject ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_event_quest ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_graveyard_zone ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE gameobject_battleground ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE gameobject_loot_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE gameobject_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_tele ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE game_weather ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE gossip_menu ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE gossip_menu_option ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE gossip_texts ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE instance_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE npc_trainer ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE npc_trainer_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pet_levelstats ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE playercreateinfo ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE playercreateinfo_action ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE playercreateinfo_item ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE player_classlevelstats ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE player_levelstats ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE player_xp_for_level ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE reputation_reward_rate ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_affect ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_area ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_facing ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_pet_auras ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_proc_event ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_proc_item_enchant ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_script_target ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE item_enchantment_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE item_loot_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE item_required_target ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE item_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE locales_command ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE locales_creature ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE locales_gameobject ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE locales_gossip_menu_option ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE locales_item ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE locales_npc_text ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE locales_page_text ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE locales_points_of_interest ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE locales_quest ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE mail_loot_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE mangos_string ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE npc_text ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE npc_vendor ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE npc_vendor_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE page_text ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE petcreateinfo_spell ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pet_name_generation ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pickpocketing_loot_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE playercreateinfo_spell ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE points_of_interest ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pool_creature ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pool_creature_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pool_gameobject ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pool_gameobject_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pool_pool ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE pool_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE quest_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE reference_loot_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE reputation_spillover_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE reserved_name ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE script_binding ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE script_texts ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE script_waypoint ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE skill_fishing_base_level ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE skinning_loot_template ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_bonus_data ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_chain ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_elixir ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_learn_spell ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_linked ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_target_position ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE spell_threat ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE transports ROW_FORMAT=DYNAMIC ENGINE=INNODB;
ALTER TABLE warden ROW_FORMAT=DYNAMIC ENGINE=INNODB;

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

