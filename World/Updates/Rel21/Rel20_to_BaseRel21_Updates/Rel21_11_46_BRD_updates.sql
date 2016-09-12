-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos` ()

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
    SET @cOldContent = '45'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '46';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Grimm Guzzler';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Grimm Guzzler updates from cmangos';

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
 

-- Grimm Guzzler - cmangos commits (BRD Grim Guzzler rework part 1)
-- NPC Phalanx
DELETE FROM script_binding WHERE ScriptName = 'npc_phalanx' AND bind = 9502;
INSERT INTO script_binding VALUES (0, 'npc_phalanx', 9502, 0);
-- NPC Rocknot
DELETE FROM script_binding WHERE ScriptName = 'npc_rocknot' AND bind = 9503;
INSERT INTO script_binding VALUES (0, 'npc_rocknot', 9503, 0);

DELETE FROM script_texts WHERE entry IN (-1230000, -1230036, -1230037, -1230038, -1230039, -1230040);
INSERT INTO script_texts (entry,content_default,sound,type,language,emote,comment) VALUES
(-1230000,'Ah, hits the spot!',0,0,0,0,'rocknot SAY_GOT_BEER'),
(-1230036,'I want more ale! Give me more ale!',0,0,0,0,'rocknot SAY_MORE_BEER'),
(-1230037,'You\'ll pay for that!',0,0,0,0,'Grim Patron SAY_PISSED_PATRON_1'),
(-1230038,'No!',0,0,0,0,'Grim Patron SAY_PISSED_PATRON_2'),
(-1230039,'Oh! Now I\'m pissed!',0,0,0,0,'Grim Patron SAY_PISSED_PATRON_3'),
(-1230040,'Violence! Property damage! None shall pass!!',0,1,0,0,'Phalanx YELL_PHALANX_AGGRO');

DELETE FROM script_waypoint WHERE entry=9502;
INSERT INTO script_waypoint VALUES
(9502, 0,847.848, -230.067, -43.614, 0, ''),
(9502, 1,868.122, -223.884, -43.695, 0, 'YELL_PHALANX_AGGRO');


-- 2nd part of Grimm Guzzler cmangos update
-- NPC Hurley Blackbreath
DELETE FROM script_binding WHERE ScriptName = 'npc_hurley_blackbreath' AND bind = 9537;
INSERT INTO script_binding VALUES (0, 'npc_hurley_blackbreath', 9537, 0);

DELETE FROM script_texts WHERE entry IN (-1230041, -1230042);
INSERT INTO script_texts (entry,content_default,sound,type,language,emote,comment) VALUES
(-1230041,'Get away from those kegs!',0,1,0,0,'Hurley Blackbreath YELL_HURLEY_SPAWN'),
(-1230042,'You\'ll pay for that!',0,0,0,0,'Hurley Blackbreath SAY_HURLEY_AGGRO');

DELETE FROM script_waypoint WHERE entry=9502;
INSERT INTO script_waypoint VALUES
(9502, 0,847.848, -230.067, -43.614, 0, ''),
(9502, 1,868.122, -223.884, -43.695, 0, 'YELL_PHALANX_AGGRO');

DELETE FROM script_waypoint WHERE entry=9537;
INSERT INTO script_waypoint VALUES
(9537, 0, 854.9774, -150.3077, -49.671, 0, ''),
(9537, 1, 855.8161, -149.763, -49.671, 0, 'YELL_HURLEY_SPAWN'),
(9537, 2, 882.6298, -148.1658, -49.75969, 0, ''),
(9537, 3, 883.9604, -148.0866, -49.76004, 0, ''),
(9537, 4, 896.846, -147.319, -49.75753, 0, ''),
(9537, 5, 896.846, -147.319, -49.75753, 0, '');


-- GO Bar Beer Keg 
DELETE FROM script_binding WHERE ScriptName = 'go_bar_beer_keg' AND bind = 164911;
INSERT INTO script_binding VALUES (0, 'go_bar_beer_keg', 164911, 0);

DELETE FROM script_texts WHERE entry IN (-1230043, -1230044, -1230045, -1230046, -1230047, -1230048, -1230049);
INSERT INTO script_texts (entry,content_default,sound,type,language,emote,comment) VALUES
(-1230043,'You can\'t hide from us. Prepare to burn!',0,1,0,0,'anvilrage guardsman SAY_GUARD_AGGRO'),
(-1230044,'That one\'s empty!!',0,0,0,60,'rocknot SAY_BARREL_1'),
(-1230045,'Ah, empty again!',0,0,0,35,'rocknot SAY_BARREL_2'),
(-1230046,'ALE!',0,0,0,60,'rocknot SAY_BARREL_3'),
(-1230047,'I\m out of here!',0,0,0,60,'rocknot SAY_ROCKNOT_DESPAWN'),
(-1230048,'HALT! There were...reports...of a...disturbance.',0,1,0,0,'Fireguard Destroyer YELL_PATROL_1'),
(-1230049,'We...are...investigating.',0,1,0,0,'Fireguard Destroyer YELL_PATROL_2');


DELETE FROM script_binding WHERE ScriptName = 'boss_plugger_spazzring' AND bind = 9499;
INSERT INTO script_binding VALUES (0, 'boss_plugger_spazzring', 9499, 0);

DELETE FROM script_binding WHERE ScriptName = 'go_bar_ale_mug' AND bind = 165738;
INSERT INTO script_binding VALUES (0, 'go_bar_ale_mug', 165738, 0);
DELETE FROM script_binding WHERE ScriptName = 'go_bar_ale_mug' AND bind = 165739;
INSERT INTO script_binding VALUES (0, 'go_bar_ale_mug', 165739, 0);

DELETE FROM script_texts WHERE entry IN (-1230050, -1230051, -1230052, -1230053, -1230054,
-1230055, -1230056, -1230057, -1230058, -1230059);
INSERT INTO script_texts (entry,content_default,sound,type,language,emote,comment) VALUES
(-1230050,'Try the boar! It\'s my new recipe!',0,0,0,0,'Plugger Spazzring SAY_OOC_1'),
(-1230051,'Enjoy! You won\'t find better ale anywhere!',0,0,0,0,'Plugger Spazzring SAY_OOC_2'),
(-1230052,'Drink up! There\'s more where that came from!',0,0,0,0,'Plugger Spazzring SAY_OOC_3'),
(-1230053,'Have you tried the Dark Iron Ale? It\'s the best!',0,0,0,0,'Plugger Spazzring SAY_OOC_4'),
(-1230054,'What are you doing over there?',0,1,0,0,'Plugger Spazzring YELL_STOLEN_1'),
(-1230055,'Hey! Get away from that!',0,1,0,0,'Plugger Spazzring YELL_STOLEN_2'),
(-1230056,'No stealing the goods!',0,1,0,0,'Plugger Spazzring YELL_STOLEN_3'),
(-1230057,'That\'s it! You\'re going down!',0,1,0,0,'Plugger Spazzring YELL_AGRRO_1'),
(-1230058,'That\'s it! No more beer until this mess is sorted out!',0,1,0,0,'Plugger Spazzring YELL_AGRRO_2'),
(-1230059,'Hey, my pockets were picked!',0,1,0,0,'Plugger Spazzring YELL_PICKPOCKETED');

-- Improve Iron Hall encounter
DELETE FROM script_binding WHERE ScriptName = 'npc_ironhand_guardian' AND bind = 8982;
INSERT INTO script_binding VALUES (0, 'npc_ironhand_guardian', 8982, 0);

-- Improve Emperor Thaurissan encounter
DELETE FROM script_texts WHERE entry IN (-1230060, -1230061, -1230062, -1230063, -1230064, -1230065);
INSERT INTO script_texts (entry,content_default,sound,type,language,emote,comment) VALUES
(-1230060,'Ha! You can\'t even begin to imagine the futility of your efforts.',0,1,0,0,'Emperor Thaurissan YELL_SENATOR_1'),
(-1230061,'Is that the best you can do? Do you really expect that you could defeat someone as awe inspiring as me?',0,1,0,0,'Emperor Thaurissan YELL_SENATOR_2'),
(-1230062,'They were just getting in the way anyways.',0,1,0,0,'Emperor Thaurissan YELL_SENATOR_3'),
(-1230063,'Your efforts are utterly pointless, fools! You will never be able to defeat me!',0,1,0,0,'Emperor Thaurissan YELL_SENATOR_4'),
(-1230064,'I will crush you into little tiny pieces!',0,1,0,0,'Emperor Thaurissan YELL_AGGRO_2'),
(-1230065,'Prepare to meet your doom at the hands of Ragnaros\' most powerful servant!',0,1,0,0,'Emperor Thaurissan YELL_AGGRO_3');
  
  
-- Grim Guzzler rework part 5 (final)
DELETE FROM script_binding WHERE ScriptName = 'npc_mistress_nagmara' AND bind = 9500;
INSERT INTO script_binding VALUES (0, 'npc_mistress_nagmara', 9500, 0);

DELETE FROM script_texts WHERE entry IN (-1230065, -1230066, -1230067, -1230068, -1230069);
INSERT INTO script_texts (entry,content_default,sound,type,language,emote,comment) VALUES
(-1230065,'Prepare to meet your doom at the hands of Ragnaros\' most powerful servant!',0,1,0,0,'Emperor Thaurissan YELL_AGGRO_3'),
(-1230066,'Hey, Rocknot!',0,0,0,0,'Nagmara SAY_NAGMARA_1'),
(-1230067,'Let\'s go, honey.',0,0,0,0,'Nagmara SAY_NAGMARA_2'),
(-1230068,'%s kisses her lover.',0,2,0,0,'Nagmara TEXTEMOTE_NAGMARA'),
(-1230069,'%s kisses Mistress Nagmara',0,2,0,17,'Rocknot TEXTEMOTE_ROCKNOT');

DELETE FROM gossip_texts WHERE entry IN (-3230002, -3230003);
INSERT INTO gossip_texts (entry,content_default,comment) VALUES
(-3230002,'Your bondage is at an end, Doom\'rel. I challenge you!','doomrel GOSSIP_ITEM_CHALLENGE'),
(-3230003,'Why don\'t you and Rocknot go find somewhere private...','nagmara GOSSIP_ITEM_NAGMARA');

DELETE FROM script_waypoint WHERE entry=9503;
INSERT INTO script_waypoint VALUES
(9503, 0, 885.1852, -194.0071, -43.45835, 0,''),
(9503, 1, 885.1852, -194.0071, -43.45835, 0,''),
(9503, 2, 872.763550, -185.605621, -43.703655, 5000,'b1'),
(9503, 3, 867.923401, -188.006393, -43.703655, 5000,'b2'),
(9503, 4, 863.295898, -190.795212, -43.703655, 5000,'b3'),
(9503, 5, 856.139587, -194.652756, -43.703655, 5000,'b4'),
(9503, 6, 851.878906, -196.928131, -43.703655, 15000,'b5'),
(9503, 7, 877.035217, -187.048080, -43.703655, 0,''),
(9503, 8, 891.198000, -197.924000, -43.620400, 0,'home'),
(9503, 9, 876.9352, -189.0071, -43.45835, 0,'Nagmara escort'),
(9503, 10, 885.1852, -194.0071, -43.45835, 0,''),
(9503, 11, 869.1238, -202.8515, -43.70884, 0,''),
(9503, 12, 869.4652, -202.8777, -43.45879, 0,''),
(9503, 13, 864.2437, -210.8257, -43.45896, 0,''),
(9503, 14, 866.8236, -220.959, -43.44718, 0,''),
(9503, 15, 867.0736, -221.959, -43.44718, 0,''),
(9503, 16, 870.4187, -225.6747, -43.55664, 0,'open door'),
(9503, 17, 872.1687, -227.4247, -43.55664, 0,''),
(9503, 18, 872.9187, -228.1747, -43.55664, 0,''),
(9503, 19, 875.9187, -230.9247, -43.55664, 0,''),
(9503, 20, 876.9187, -230.1747, -43.55664, 0,''),
(9503, 21, 877.9187, -229.4247, -43.55664, 0,''),
(9503, 22, 882.3948, -225.949, -46.74049, 0,''),
(9503, 23, 885.8948, -223.699, -49.24049, 0,''),
(9503, 24, 887.6448, -222.449, -49.24049, 0,''),
(9503, 25, 885.937, -223.3513, -49.29544, 0,''),
(9503, 26, 887.437, -222.3513, -49.29544, 0,''),
(9503, 27, 888.937, -221.6013, -49.54544, 0,''),
(9503, 28, 887.687, -220.1013, -49.54544, 0,''),
(9503, 29, 886.687, -218.8513, -49.54544, 0,''),
(9503, 30, 887.5667, -220.0395, -49.70586, 0,''),
(9503, 31, 886.5667, -218.7895, -49.70586, 0,''),
(9503, 32, 886.0667, -218.2895, -49.70586, 0,''),
(9503, 33, 880.8252, -221.3895, -49.95622, 0,'stop');

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
                SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurResult AS `===== Found Version =====`;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;      