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
    SET @cOldVersion = '22';
    SET @cOldStructure = '04';
    SET @cOldContent = '039';

    -- New Values
    SET @cNewVersion = '22';
    SET @cNewStructure = '04';
    SET @cNewContent = '040';
                            -- DESCRIPTION IS 30 Characters MAX
    SET @cNewDescription = 'Anticheat_DebugVis_Commands';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Add .anticheat and .debug vis / .debug visual GM command-table rows mirroring the non-cluster GM commands added by the server PRs.';

    -- Evaluate all settings
    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @oldResult := (SELECT `description` FROM `db_version` WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @newResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @oldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

    -- Add the non-cluster Anti-Cheat and Debug Visualizer GM commands mirroring
    -- the server-side command tables (Chat.cpp anticheatCommandTable /
    -- debugVisCommandTable + .debug visual). Cluster (.cluster*) and gateway
    -- (.gateway*) commands are intentionally EXCLUDED -- they are fork-specific
    -- and not upstreamed. Security values map to this fork's AccountTypes enum
    -- (SharedDefines/ServerDefines.h): SEC_GAMEMASTER=2, SEC_ADMINISTRATOR=3.

    INSERT INTO `command` (`id`, `command_text`, `security`, `help_text`) VALUES
    (812,'anticheat',2,'Syntax: .anticheat $subcommand\r\n\r\nParent group for the Anti-Cheat console. Use a subcommand (status, top, report, reload, set, warn, jail, unjail, delete, test, rubberband, score) to inspect or manage detection state.'),
    (813,'anticheat status',2,'Syntax: .anticheat status [$playername]\r\n\r\nShows the current Anti-Cheat detection state for a player (or yourself with no arg): active detectors, recent violation counts and current score.'),
    (814,'anticheat top',2,'Syntax: .anticheat top [$count]\r\n\r\nLists the players with the highest current Anti-Cheat violation scores. Optional count limits how many rows are shown.'),
    (815,'anticheat report',2,'Syntax: .anticheat report [$playername]\r\n\r\nPrints a detailed Anti-Cheat violation report for the named player (or yourself), breaking the score down by detector category.'),
    (816,'anticheat reload',2,'Syntax: .anticheat reload\r\n\r\nReloads the Anti-Cheat configuration (thresholds, toggles and tunables) from the server config without a restart.'),
    (817,'anticheat set',3,'Syntax: .anticheat set $option $value\r\n\r\nSets an Anti-Cheat runtime option (threshold or toggle) to the given value. Administrator-only.'),
    (818,'anticheat warn',2,'Syntax: .anticheat warn $playername\r\n\r\nIssues an Anti-Cheat warning to the named player, raising their tracked violation state.'),
    (819,'anticheat jail',2,'Syntax: .anticheat jail $playername\r\n\r\nJails (restricts/teleports to holding) the named player flagged by the Anti-Cheat system.'),
    (820,'anticheat unjail',2,'Syntax: .anticheat unjail $playername\r\n\r\nReleases the named player from Anti-Cheat jail and clears the jailed state.'),
    (821,'anticheat delete',3,'Syntax: .anticheat delete $playername\r\n\r\nDeletes the stored Anti-Cheat violation records for the named player. Administrator-only.'),
    (822,'anticheat test',3,'Syntax: .anticheat test $detector\r\n\r\nFires a synthetic Anti-Cheat detection for the named detector to validate the pipeline. Administrator-only.'),
    (823,'anticheat rubberband',2,'Syntax: .anticheat rubberband $playername\r\n\r\nForces a corrective rubberband (position snap-back) on the named player via the Anti-Cheat movement system.'),
    (824,'anticheat score',3,'Syntax: .anticheat score $playername $value\r\n\r\nManually sets the Anti-Cheat violation score for the named player. Administrator-only.'),
    (825,'debug vis',2,'Syntax: .debug vis $subcommand\r\n\r\nParent group for the in-game debug visualizer. Use a subcommand (cells, los, path, collision, height, clear) to spawn or clear diagnostic markers.'),
    (826,'debug vis cells',2,'Syntax: .debug vis cells\r\n\r\nVisualizes the grid/cell boundaries around your current position using debug markers.'),
    (827,'debug vis los',2,'Syntax: .debug vis los\r\n\r\nVisualizes the line-of-sight ray from you to your target, marking blocking geometry.'),
    (828,'debug vis path',2,'Syntax: .debug vis path\r\n\r\nVisualizes the navmesh path your selected creature would take to its current destination.'),
    (829,'debug vis collision',2,'Syntax: .debug vis collision\r\n\r\nVisualizes nearby VMAP/collision geometry around your current position with debug markers.'),
    (830,'debug vis height',2,'Syntax: .debug vis height\r\n\r\nVisualizes sampled terrain/VMAP height under and around your current position.'),
    (831,'debug vis clear',2,'Syntax: .debug vis clear\r\n\r\nRemoves all debug-visualizer markers previously spawned by the .debug vis commands.'),
    (832,'debug visual',2,'Syntax: .debug visual\r\n\r\nToggles or spawns a debug visual marker at your current position for quick on-the-fly checks.');

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
            SET @newResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

            SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,@newResult AS `===== DB is now on Version =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @newResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cCurResult AS `===== DB is already on Version =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
                IF(@oldResult IS NULL) THEN    -- Something has gone wrong
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @oldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@oldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                ELSE
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@oldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
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
