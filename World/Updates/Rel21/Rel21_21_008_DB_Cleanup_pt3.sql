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
    SET @cOldContent = '007';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '21';
    SET @cNewContent = '008';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'DB_Cleanup_pt3';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'DB_Cleanup_pt3';

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
		
UPDATE `quest_template` SET `details`='Thanks to you and Omarion (May he rest in peace),$B$BI am now able to create Icebane bracers. All you need to do is bring me the materials and pay a small crafting fee.' WHERE `entry`='9235';
UPDATE `quest_template` SET `details`='Thanks to you and Omarion (May he rest in peace),$B$BI am now able to create an Icebane breastplate. All you need to do is bring me the materials and pay a small crafting fee.' WHERE `entry`='9236';
UPDATE `quest_template` SET `details`='Thanks to you and Omarion (May he rest in peace),$B$BI am now able to create Polar bracers. All you need to do is bring me the materials and pay a small crafting fee.' WHERE `entry`='9241';
UPDATE `quest_template` SET `details`='Thanks to you and Omarion (May he rest in peace),$B$BI am now able to create Polar gloves. All you need to do is bring me the materials and pay a small crafting fee.' WHERE `entry`='9242';
UPDATE `quest_template` SET `details`='Thanks to you and Omarion (May he rest in peace),$B$BI am now able to create Icy Scale gauntlets. All you need to do is bring me the materials and pay a small crafting fee.' WHERE `entry`='9245';
UPDATE `quest_template` SET `details`='Thanks to you and Omarion (May he rest in peace),$B$BI am now able to create an Icy Scale breastplate. All you need to do is bring me the materials and pay a small crafting fee.' WHERE `entry`='9246';
UPDATE `quest_template` SET `objectives`='Narain Soothfancy wants you to find his ex-best friend forever (BFF),$B$BStewvul, and take back the scrying goggles that Stewvul stole from him.' WHERE `entry`='8577';
UPDATE `quest_template` SET `objectives`='Gather 5 Lightforge Ingots, then return to Glorin Steelbrow in the Wetlands.' WHERE `entry`='526';
UPDATE `quest_template` SET `offerrewardtext`='Hmmm, Narm sent you to me, did he?$B$BWell then, Narm could always be trusted, so that must mean you\'re ready to take part of the next sapta--the sapta of fire.$B$BI see it in your eyes already, the burning, the desire. You\'ve tasted power, and now you\'re ready for more of it. Patience, $N. Remember what earth taught you. Power and destruction will come easily, but you must still know when to stay your hand.' WHERE `entry`='2984';
UPDATE `quest_template` SET `offerrewardtext`='Greetings young $C, I\'m glad to see you ready and eager to learn about the curing of poisons.$B$BWhile most druids in the past were put through pre-planned trials, your work will involve no such thing. There has been a rash of animal poisonings at the Crossroads in the Barrens, and they\'re unable to bring it under control. Someone there has requested Moonglade for aid, so we are sending you there to aid them. This is no exercise - the work you\'ll do is quite real. Bear this in mind.' WHERE `entry`='6126';

UPDATE `quest_template` SET `offerrewardtext`='Outstanding - your tribute to the Dawn is duly noted, $N. With this accomplished, I am delighted to make our mantles available to you for purchase. So long as you maintain your current status with us, these mantles will be purchasable from any authorized quartermaster of the Argent Dawn.$B$BFor the Dawn, my $Gbrother:sister;!' WHERE `entry`='5504';
UPDATE `quest_template` SET `offerrewardtext`='Outstanding - your tribute to the Dawn is duly noted, $N. With this accomplished, I am delighted to make our mantles available to you for purchase. So long as you maintain your current status with us, these mantles will be purchasable from any authorized quartermaster of the Argent Dawn.$B$BFor the Dawn, my $Gbrother:sister;!' WHERE `entry`='5507';
UPDATE `quest_template` SET `offerrewardtext`='Outstanding - your tribute to the Dawn is duly noted, $N. With this accomplished, I am delighted to make our mantles available to you for purchase. So long as you maintain your current status with us, these mantles will be purchasable from any authorized quartermaster of the Argent Dawn.$B$BFor the Dawn, my $Gbrother:sister;!' WHERE `entry`='5513';

UPDATE `quest_template` SET `offerrewardtext`='Hiccup! Ho Ho!' WHERE `entry`='49';
UPDATE `quest_template` SET `offerrewardtext`='Hiccup! Ho Ho!' WHERE `entry`='50';
UPDATE `quest_template` SET `offerrewardtext`='Hiccup! Ho Ho!' WHERE `entry`='51';
UPDATE `quest_template` SET `offerrewardtext`='Excellent, excellent!  These are going to work out incredibly well - I can already tell that they\'re going to be much harder when properly cured.$B$BThanks again for your help $N. Here - please take one of my latest creations.' WHERE `entry`='7734';

UPDATE `quest_template` SET `offerrewardtext`='You have done well, $N.$B$BAlthough the Vile Familiars were merely pets of the darker powers within the Burning Blade, your success against them foretells greater deeds ahead.' WHERE `entry`='1499';
UPDATE `quest_template` SET `offerrewardtext`='A pleasure doin\' business with ya.$B$BAnd $N, wipe that look of disgust off yer face.' WHERE `entry`='7653';

UPDATE `quest_template` SET `offerrewardtext`='Ah, well done! These should last me for a little while at least. Here is your pay as promised.$B$BIf you\'re interested, I have some more reagents I could use. These, however, are only found in the depths of the Uldaman excavation. They will not be easy to get, but I will make it worth your while if you are interested in helping me again.$B$BPerhaps something more than some shiny coins, yes?' WHERE `entry`='2258';
UPDATE `quest_template` SET `offerrewardtext`='Ah, well done! These should last me for a little while at least. Here is your pay as promised.$B$BIf you\'re interested, I have some more reagents I could use. These, however, are only found in the depths of the Uldaman excavation. They will not be easy to get, but I will make it worth your while if you are interested in helping me again.$B$BPerhaps something more than some shiny coins, yes?' WHERE `entry`='2500';

UPDATE `quest_template` SET `details`='A glint of light on the ground catches your eye from underneath the rubble. Brushing away debris and ash caked onto the object reveals the insignia of a gold anchor on white enameled on the surface: the sign of Theramore.$B$BUnderneath the anchor is embossed the name "Lieutenant Paval Reethe".' WHERE `entry`='1269';

UPDATE `quest_template` SET `details`='If you bring me your white stallion, I\'ll trade you for one from the new herd. The new horse will be just as fast as your old one, but have a different look to it. You can look at the swift steeds here to see what it will look like.$B$BMUST PAY 500 Gold too....' WHERE `entry`='7677';

UPDATE `quest_template` SET `details`='Zanza can create the ancient troll enchantments with the right components. The first is a primal Hakkari idol that must be taken from the most powerful of the Hakkari lieutenants: Jin\'do and the Bloodlord.$B$BThe second is a punctured voodoo doll. These can be found in the piles of refuse that litter this foul place. Look inside the jinxed hoodoo.$B$BBring me these things and I will create a powerful enchantment for you!' WHERE `entry`='8184';

UPDATE `quest_template` SET `objectives`='Journey to Orgrimmar and speak with Shenthul at the Cleft of Shadow.' WHERE `entry`='2378';
UPDATE `quest_template` SET `objectives`='Speak with Gornek. You recall Kaltunk marking your map with his location and mentioning that Gornek resided in the Den, a building to the west.' WHERE `entry`='4641';

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


