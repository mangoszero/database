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
    SET @cOldStructure = '19'; 
    SET @cOldContent = '001';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '19';
    SET @cNewContent = '002';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'carriage returns quest';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'carriage returns quest- Remove and replace';

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

DELETE FROM `quest_template` WHERE `entry` IN (1859,2881,4641,6567,7654,7655,7656,7658,8742);

INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewOrReqMoney`, `RewMoneyMaxLevel`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`) VALUES
('1859','2','-162','10','10','0','8','2','0','0','0','0','0','0','0','0','0','0','8','0','0','0','1859','1963','0','0','0','Therzok','Lower your voice, $n. Yeah, I know your name. Was told to keep an eye out for an orc by your description.$B$BFrom what we\'ve heard about you, you can handle yourself in combat, and aren\'t opposed to a little sneakery from time to time.$B$BAm I right?$B$BAnyways, you should go see Therzok in Orgrimmar. He\'s got an offer for you to hear.','Speak with Therzok in the Cleft of Shadow in Orgrimmar.','Very good, I\'m glad Kaplak was able to get a hold of you.$B$BWe have some things to speak of, not the least of which is your future with the Hand.',NULL,'','','','','','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','120','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0'),
('2881','0','47','40','45','0','0','0','0','0','0','0','0','0','0','0','0','0','264','1','2880','0','0','0','0','0','0','Troll Necklace Bounty','','','Another set of necklaces means that there are fewer trolls in the Hinterlands we have to worry about!$BYou\'ve done it again, $N.$B$BKeep up the good work!','You\'ve done it already, but we will continue to accept any troll tribal necklaces you find and are willing to turn in.  By turning them in to me, you\'ll continue to improve your standing amongst the Wildhammers; if you\'re willing to fight for us, then we\'ll be willing to fight for you!$B$BI need five troll tribal necklaces for them to count, $N.','','','','','','9259','0','0','0','5','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','471','0','0','0','0','25','0','0','0','0','0','234','0','0','0','0','0','0','0','0','25','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0'),
('4641','2','363','1','1','0','0','130','0','0','0','0','0','0','0','0','0','0','8','0','0','0','0','788','0','0','0','Your Place In The World','Finally, you are of age, $N... of age to battle in the name of the Horde. To conquer for the glory of the Warchief.$B$BYes...$B$B<Kaltunk looks you over.>$B$BYou will do nicely.$B$BNo doubt you wish to find a great dragon or demon and strangle it with your bare hands, but perhaps it would be wise to start on something less... dangerous.$B$B<Kaltunk laughs.>$B$BReport to Gornek, he should be able to assign a task better suited to a young $c. You will find Gornek in the Den, to the west.$B$B','Speak with Gornek. You recall Kaltunk marking your map with his location and mentioning that Gornek resided in the Den, a building to the west. $B$B$B$B','Another one of Kaltunk\'s recruits, hm?$B$BA sorry state of affairs we find ourselves in if this is the best the Horde can produce. No matter. By the time we think you\'re ready to leave the Valley, you\'ll be a proud $C of the Horde.','','','','','','','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','530','76','0','0','0','50','50','0','0','0','0','30','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','6','0','0','0','0','0','0','0','0','0','0'),
('6567','2','1637','55','60','0','0','178','0','0','0','0','0','0','0','0','0','0','8','0','6566','0','0','6568','0','0','0','The Champion of the Horde','I have received word from one of my champions that a way into the lair of the dragon may exist. You are to seek him out.$B$BRexxar wanders the desert wasteland of Desolace, traveling between Stonetalon and Feralas. He awaits your arrival.','Seek out Rexxar. The Warchief has instructed you as to his whereabouts. Search the paths of Desolace, between the Stonetalon Mountains and Feralas.','There is but one way into the dragon\'s lair, $R.$B$BYou see, only the strongest of the Black Dragonflight are allowed entry into the lair of the brood mother. Many trials must be passed and the key to enter ceremoniously enchanted by General Drakkisath himself!$B$BSince you are not of black dragonkin, you may have some difficulty in obtaining passage.$B$B<Rexxar grins.>','','','','','','','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','2880','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0'),
('7654','0','-121','50','60','0','0','0','164','265','0','0','0','0','0','0','0','0','0','0','7652','0','0','0','0','0','0','Imperial Plate Boots','','','A pleasure doin\' business with ya.$B$BAnd $N, wipe that look of disgust off yer face.','For the boot plans, I\'ll be needin\' 40 thorium bars. Yep, 40. Are you gonna cry? Would you like a hanky?$B$B<Derotain laughs.>','','','','','','12359','0','0','0','40','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','12700','0','0','0','1','0','0','0','59','0','0','0','0','200','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','11','0','0','0','0','0','0','0','0','0','0'),
('7655','0','-121','50','60','0','0','0','164','265','0','0','0','0','0','0','0','0','0','0','7652','0','0','0','0','0','0','Imperial Plate Bracer','','','A pleasure doin\' business with ya.$B$BAnd $N, wipe that look of disgust off yer face.','For the bracer plans, I\'ll be needin\' 20 thorium bars.$B$BAre you alright, sonny? Yer getting\' all red.','','','','','','12359','0','0','0','20','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','12690','0','0','0','1','0','0','0','59','0','0','0','0','150','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0'),
('7656','0','-121','50','60','0','0','0','164','265','0','0','0','0','0','0','0','0','0','0','7652','0','0','0','0','0','0','Imperial Plate Chest','','','A pleasure doin\' business with ya.$B$BAnd $N, wipe that look of disgust off yer face.','For the chest piece plans, I\'ll be needin\' 60 thorium bars.$B$B$BOh boy, there you go again. Are you gonna be runnin\' to yer blue Gods, askin\' why they have forsaken you?!? Toughen up, Nancy! Nobody ever said life\'s fair.','','','','','','12359','0','0','0','60','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','12705','0','0','0','1','0','0','0','59','0','0','0','0','200','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0'),
('7658','0','-121','50','60','0','0','0','164','265','0','0','0','0','0','0','0','0','0','0','7652','0','0','0','0','0','0','Imperial Plate Leggings','','','A pleasure doin\' business with ya.$B$BAnd $N, wipe that look of disgust off yer face.','Just hand over 60 thorium bars and the leg plans are yers.$B$BI know, I\'m driving you into bankruptcy! I\'ve heard it all before so you can save your sob story, weakling.','','','','','','12359','0','0','0','60','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','12715','0','0','0','1','0','0','0','59','0','0','0','0','200','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0'),
('8742','0','440','60','60','0','0','0','0','0','0','0','910','0','0','0','0','0','64','0','0','0','0','0','0','0','0','The Might of Kalimdor','A thousand years has passed and just as it was fated, one stands before me. One who shall lead their people to a new age.$B$BThe Old God trembles, $N. Oh yes, it fears your faith. Shatter the prophecy of C\'Thun.$B$BIt knows you come, champion - and with you comes the might of Kalimdor. You have only to let me know when you are prepared and I shall grant you The Scepter of the Shifting Sands.','','The Scepter of the Shifting Sands is whole once more, $N.$B$BIt must be you who uses the scepter. It must be you who heralds the next age of your people. You must wait for the armies of the Horde and the Alliance to arrive in Silithus before you may ring the Scarab Gong.',NULL,NULL,'','','','','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','910','0','0','0','0','500','0','0','0','0','0','8580','25861','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');    

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


