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
    SET @cOldContent = '003';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '21';
    SET @cNewContent = '004';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Big_Command_Help_Sync_pt2';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'The_Big_Command_Help_Sync_pt2';

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
		
-- M0

DELETE FROM `command` WHERE `id` IN (125,126,129,137,138,164,165,166,174,178,180,182,183,188,192,198);
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('125','instance unbind','3','Syntax: .instance unbind all\r\n\r\nAll of the selected player\'s binds will be cleared.\r\n.instance unbind #mapid\r\nOnly the specified #mapid instance will be cleared.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('126','itemmove','2','Syntax: .itemmove #sourceslotid #destinationslotid\r\n\r\nMove an item from slots #sourceslotid to #destinationslotid in your inventory\r\n\r\nNot yet implemented');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('129','learn all','3','Syntax: .learn all\r\n\r\nLearn all big set different spells, maybe useful for Administrators.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('137','learn all_recipes','2','Syntax: .learn all_recipes [$profession]\r\n\r\nLearns all recipes of specified profession and sets skill level to max.\r\nExample: .learn all_recipes enchanting');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('138','levelup','3','Syntax: .levelup [$playername] [#numberoflevels]\r\n\r\nIncrease/decrease the level of character with $playername (or the selected if not name provided) by #numberoflevels Or +1 if no #numberoflevels provided). If #numberoflevels is omitted, the level will be increase by 1. If #numberoflevels is 0, the same level will be restarted. If no character is selected and name not provided, increase your level. Command can be used for offline character. All stats and dependent values recalculated. At level decrease talents can be reset if need. Also at level decrease equipped items with greater level requirement can be lost.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('164','maxskill','3','Syntax: .maxskill\r\n\r\nSets all skills of the targeted player to their maximum values for its current level.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('165','modify aspeed','1','Syntax: .modify aspeed #rate\r\n\r\nModify all speeds -run,swim,run back,swim back- of the selected player to \"normalbase speed for this move type\"*rate. If no player is selected, modify your speed.\r\n\r\n#rate may range from 0.1 to GM.MaxSpeedFactor defined in mangosd.conf.\"');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('166','modify bwalk','1','Syntax: .modify bwalk #rate\r\n\r\nModify the speed of the selected player while running backwards to \"normal walk back speed\"*rate. If no player is selected, modify your speed.\r\n\r\n#rate may range from 0.1 to GM.MaxSpeedFactor defined in mangosd.conf.\"');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('174','modify money','1','Syntax: .modify money #money\r\n\r\nAdd or remove money to the selected player. If no player is selected, modify your money.\r\n\r\n #gold can be negative to remove money.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('178','modify rep','2','Syntax: .modify rep #repId (#repvalue | $rankname [#delta])\r\n\r\nSets the selected players reputation with faction #repId to #repvalue or to $reprank.\r\nIf the reputation rank name is provided, the resulting reputation will be the lowest reputation for that rank plus the delta amount, if specified.\r\nYou can use \'.pinfo rep\' to list all known reputation ids, or use \'.lookup faction $name\' to locate a specific faction id.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('180','modify speed','1','Syntax: .modify speed #rate\r\n\r\nModify the running speed of the selected player to \"normal base run speed\"*rate. If no player is selected, modify your speed.\r\n\r\n#rate may range from 0.1 to GM.MaxSpeedFactor defined in mangosd.conf.\"');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('182','modify swim','1','Syntax: .modify swim #rate\r\n\r\nModify the swim speed of the selected player to \"normal swim speed\"*rate. If no player is selected, modify your speed.\r\n\r\n#rate may range from 0.1 to GM.MaxSpeedFactor defined in mangosd.conf.\"');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('183','movegens','3','Syntax: .movegens\r\n\r\nShow movement generators stack for selected creature or player.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('188','npc additem','2','Syntax: .npc additem #itemId <#maxcount><#incrtime>\r\n\r\nAdd item #itemid to item list of selected vendor. Also optionally set max count item in vendor item list and time to item count restoring.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('192','npc changelevel','2','Syntax: .npc changelevel #level\r\n\r\nChange the level of the selected creature to #level.\r\n\r\n#level may range from 1 to 63.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('198','npc info','3','Syntax: .npc info\r\n\r\nDisplay a list of details for the selected creature.\r\n\r\nThe list includes:-\r\nGUID, Faction, NPC flags, Entry ID, Model ID,\r\n- Level,\r\n- Health (current/maximum),\r\n- Field flags, dynamic flags, faction template,\r\n- Position information,\r\n- and the creature type, e.g. if the creature is a vendor.');

DELETE FROM `command` WHERE `id` IN (200,205,207,208,240,241,244,247,248,253,275,288,292,295,298,299,301,306);
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('200','npc name','2','Syntax: .npc name $name\r\n\r\nChange the name of the selected creature or character to $name.\r\n\r\nCommand disabled.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('205','npc setmovetype','2','Syntax: .npc setmovetype [#creature_guid] stay/random/way [NODEL]\r\n\r\nSet for creature pointed by #creature_guid (or selected if #creature_guid not provided) movement type and move it to respawn position (if creature alive). Any existing waypoints for creature will be removed from the database if you do not use NODEL. If the creature is dead then movement type will applied at creature respawn.\r\nMake sure you use NODEL, if you want to keep the waypoints.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('207','npc spawntime','2','Syntax: .npc spawntime #time\r\n\r\nAdjust spawntime of selected creature to time.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('208','npc subname','2','Syntax: .npc subname $Name\r\n\r\nChange the subname of the selected creature or player to $Name.\r\n\r\nCommand disabled.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('240','reset spells','3','Syntax: .reset spells [Playername]\r\n\r\nRemoves all non-original spells from spellbook.\r\nPlayername can be name of offline character.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('241','reset stats','3','Syntax: .reset stats [Playername]\r\n\r\nResets(recalculate) all stats of the targeted player to their original values at current level.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('244','revive','3','Syntax: .revive\r\n\r\nRevive the selected player. If no player is selected, it will revive you.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('247','send items','3','Syntax: .send items #playername \"#subject\" \"#text\" itemid1[:count1] itemid2[:count2] ... itemidN[:countN]\r\n\r\nSend a mail to a player. Subject and mail text must be in \"\". If for itemid not provided related count values then expected 1, if count > max items in stack then items will be send in required amount stacks. All stacks amount in mail limited to 12.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('248','send mail','1','Syntax: .send mail #playername \"#subject\" \"#text\"\r\n\r\nSend a mail to a player. Subject and mail text must be in \"\".');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('253','send money','3','Syntax: .send money #playername \"#subject\" \"#text\" #money\r\n\r\nSend mail with money to a player. Subject and mail text must be in \"\".');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('275','taxicheat','1','Syntax: .taxicheat on/off\r\n\r\nTemporary grant access or remove to all taxi routes for the selected character. If no character is selected, hide or reveal all routes to you.\r\n\r\nVisited taxi nodes still accessible after removing access.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('288','ticket respond','2','Syntax: .ticket respond (#ID|$name) $response_text\r\n\r\nSend your responce to the ticket as whisper chat.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('292','trigger active','2','Syntax: .trigger active\r\n\r\nShow list of areatriggers with activation zone including current character position.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('295','unban account','3','Syntax: .unban account $Name\r\n\r\nUnban accounts for account name pattern.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('298','unlearn','3','Syntax: .unlearn #spell [all]\r\n\r\nUnlearn for selected player a spell #spell.  If \'all\' provided then all ranks unlearned.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('299','unmute','1','Syntax: .unmute [$playerName]\r\n\r\nRestore chat messaging for any character from account of character $playerName (or selected). Character can be offline.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('301','wchange','3','Syntax: .wchange #weathertype #status\r\n\r\nSet current weather to #weathertype with an intensity of #status.\r\n\r\n#weathertype can be 1 for rain, 2 for snow, and 3 for sand. #status can be 0 for disabled, and 1 for enabled.');
INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES('306','wp show','2','Syntax: .wp show command [dbGuid] [pathId [wpOrigin]\r\n\r\nwhere command can have one of the following values\r\non (to show all related wp)\r\nfirst (to see only first one)\r\nlast (to see only last one)\r\noff (to hide all related wp)\r\ninfo (to get more info about theses wp)\r\n\r\nFor using info you have to do first show on and than select a Visual-Waypoint and do the show info!\r\nwith pathId and wpOrigin you can specify which path to show (optional)');

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


