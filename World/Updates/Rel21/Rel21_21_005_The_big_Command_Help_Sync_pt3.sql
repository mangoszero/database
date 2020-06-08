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
    SET @cOldContent = '004';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '21';
    SET @cNewContent = '005';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Big_Command_Help_Sync_pt3';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'The_Big_Command_Help_Sync_pt3';

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
		
update `command` set `id`=523 where `id`=307;
update `command` set `id`=804 where `id`=306;
update `command` set `id`=803 where `id`=305;
update `command` set `id`=801 where `id`=304;
update `command` set `id`=800 where `id`=303;
update `command` set `id`=780 where `id`=302;
update `command` set `id`=770 where `id`=301;
update `command` set `id`=760 where `id`=300;
update `command` set `id`=750 where `id`=299;
update `command` set `id`=740 where `id`=298;
update `command` set `id`=732 where `id`=297;
update `command` set `id`=731 where `id`=296;
update `command` set `id`=730 where `id`=295;
update `command` set `id`=720 where `id`=294;
update `command` set `id`=712 where `id`=293;
update `command` set `id`=711 where `id`=292;
update `command` set `id`=710 where `id`=291;
update `command` set `id`=689 where `id`=290;
update `command` set `id`=688 where `id`=289;
update `command` set `id`=687 where `id`=288;
update `command` set `id`=686 where `id`=287;
update `command` set `id`=685 where `id`=286;
update `command` set `id`=690 where `id`=285;
update `command` set `id`=684 where `id`=284;
update `command` set `id`=683 where `id`=283;
update `command` set `id`=682 where `id`=282;
update `command` set `id`=681 where `id`=281;
update `command` set `id`=674 where `id`=280;
update `command` set `id`=673 where `id`=279;
update `command` set `id`=672 where `id`=278;
update `command` set `id`=671 where `id`=277;
update `command` set `id`=670 where `id`=276;
update `command` set `id`=660 where `id`=275;
update `command` set `id`=650 where `id`=274;
update `command` set `id`=640 where `id`=273;
update `command` set `id`=630 where `id`=272;
update `command` set `id`=620 where `id`=271;
update `command` set `id`=610 where `id`=270;
update `command` set `id`=601 where `id`=269;
update `command` set `id`=600 where `id`=268;
update `command` set `id`=590 where `id`=267;
update `command` set `id`=581 where `id`=266;
update `command` set `id`=580 where `id`=265;
update `command` set `id`=570 where `id`=264;
update `command` set `id`=569 where `id`=263;
update `command` set `id`=568 where `id`=262;
update `command` set `id`=567 where `id`=261;
update `command` set `id`=566 where `id`=260;
update `command` set `id`=565 where `id`=259;
update `command` set `id`=564 where `id`=258;
update `command` set `id`=563 where `id`=257;
update `command` set `id`=562 where `id`=256;
update `command` set `id`=561 where `id`=255;
update `command` set `id`=560 where `id`=254;
update `command` set `id`=556 where `id`=253;
update `command` set `id`=555 where `id`=252;
update `command` set `id`=554 where `id`=251;
update `command` set `id`=553 where `id`=250;
update `command` set `id`=552 where `id`=249;
update `command` set `id`=551 where `id`=248;
update `command` set `id`=550 where `id`=247;
update `command` set `id`=541 where `id`=246;
update `command` set `id`=540 where `id`=245;
update `command` set `id`=531 where `id`=244;
update `command` set `id`=530 where `id`=243;
update `command` set `id`=528 where `id`=242;
update `command` set `id`=528 where `id`=242;
update `command` set `id`=527 where `id`=241;
update `command` set `id`=526 where `id`=240;
update `command` set `id`=524 where `id`=239;
update `command` set `id`=522 where `id`=238;
update `command` set `id`=521 where `id`=237;
update `command` set `id`=510 where `id`=236;
update `command` set `id`=501 where `id`=235;
update `command` set `id`=500 where `id`=234;
update `command` set `id`=499 where `id`=233;
update `command` set `id`=498 where `id`=232;
update `command` set `id`=497 where `id`=231;
update `command` set `id`=496 where `id`=230;
update `command` set `id`=495 where `id`=229;
update `command` set `id`=494 where `id`=228;
update `command` set `id`=493 where `id`=227;
update `command` set `id`=492 where `id`=226;
update `command` set `id`=490 where `id`=225;
update `command` set `id`=480 where `id`=224;
update `command` set `id`=470 where `id`=223;
update `command` set `id`=462 where `id`=222;
update `command` set `id`=460 where `id`=220;
update `command` set `id`=452 where `id`=219;
update `command` set `id`=451 where `id`=218;
update `command` set `id`=450 where `id`=217;
update `command` set `id`=440 where `id`=216;
update `command` set `id`=426 where `id`=215;
update `command` set `id`=425 where `id`=214;
update `command` set `id`=420 where `id`=213;
update `command` set `id`=419 where `id`=212;
update `command` set `id`=418 where `id`=211;
update `command` set `id`=417 where `id`=210;
update `command` set `id`=416 where `id`=209;
update `command` set `id`=415 where `id`=208;
update `command` set `id`=414 where `id`=207;
update `command` set `id`=413 where `id`=206;
update `command` set `id`=411 where `id`=205;
update `command` set `id`=410 where `id`=204;
update `command` set `id`=409 where `id`=203;
update `command` set `id`=408 where `id`=202;
update `command` set `id`=407 where `id`=201;
update `command` set `id`=406 where `id`=200;
update `command` set `id`=405 where `id`=199;
update `command` set `id`=404 where `id`=198;
update `command` set `id`=403 where `id`=197;
update `command` set `id`=402 where `id`=196;
update `command` set `id`=401 where `id`=195;
update `command` set `id`=400 where `id`=194;
update `command` set `id`=399 where `id`=193;
update `command` set `id`=397 where `id`=192;
update `command` set `id`=396 where `id`=191;
update `command` set `id`=395 where `id`=190;
update `command` set `id`=394 where `id`=189;
update `command` set `id`=392 where `id`=188;
update `command` set `id`=392 where `id`=188;
update `command` set `id`=390 where `id`=187;
update `command` set `id`=385 where `id`=186;
update `command` set `id`=380 where `id`=185;
update `command` set `id`=375 where `id`=184;
update `command` set `id`=370 where `id`=183;
update `command` set `id`=367 where `id`=182;
update `command` set `id`=366 where `id`=181;
update `command` set `id`=365 where `id`=180;
update `command` set `id`=364 where `id`=179;
update `command` set `id`=362 where `id`=178;
update `command` set `id`=361 where `id`=177;
update `command` set `id`=359 where `id`=176;
update `command` set `id`=358 where `id`=175;
update `command` set `id`=357 where `id`=174;
update `command` set `id`=356 where `id`=173;
update `command` set `id`=355 where `id`=172;
update `command` set `id`=354 where `id`=171;
update `command` set `id`=353 where `id`=170;
update `command` set `id`=351 where `id`=169;
update `command` set `id`=350 where `id`=168;
update `command` set `id`=349 where `id`=167;
update `command` set `id`=347 where `id`=166;
update `command` set `id`=346 where `id`=165;
update `command` set `id`=340 where `id`=164;
update `command` set `id`=330 where `id`=163;
update `command` set `id`=329 where `id`=162;
update `command` set `id`=328 where `id`=161;
update `command` set `id`=327 where `id`=160;
update `command` set `id`=326 where `id`=159;
update `command` set `id`=325 where `id`=158;
update `command` set `id`=324 where `id`=157;
update `command` set `id`=323 where `id`=156;
update `command` set `id`=322 where `id`=155;
update `command` set `id`=321 where `id`=154;
update `command` set `id`=320 where `id`=153;
update `command` set `id`=319 where `id`=152;
update `command` set `id`=318 where `id`=151;
update `command` set `id`=317 where `id`=150;
update `command` set `id`=315 where `id`=149;
update `command` set `id`=314 where `id`=148;
update `command` set `id`=312 where `id`=147;
update `command` set `id`=311 where `id`=146;
update `command` set `id`=310 where `id`=145;
update `command` set `id`=305 where `id`=144;
update `command` set `id`=303 where `id`=143;
update `command` set `id`=302 where `id`=142;
update `command` set `id`=301 where `id`=141;
update `command` set `id`=300 where `id`=140;
update `command` set `id`=295 where `id`=139;
update `command` set `id`=290 where `id`=138;
update `command` set `id`=285 where `id`=137;
update `command` set `id`=284 where `id`=136;
update `command` set `id`=283 where `id`=135;
update `command` set `id`=281 where `id`=134;
update `command` set `id`=280 where `id`=133;
update `command` set `id`=279 where `id`=132;
update `command` set `id`=278 where `id`=131;
update `command` set `id`=277 where `id`=130;
update `command` set `id`=276 where `id`=129;
update `command` set `id`=275 where `id`=128;
update `command` set `id`=270 where `id`=127;
update `command` set `id`=265 where `id`=126;
update `command` set `id`=263 where `id`=125;
update `command` set `id`=262 where `id`=124;
update `command` set `id`=261 where `id`=123;
update `command` set `id`=260 where `id`=122;
update `command` set `id`=253 where `id`=121;
update `command` set `id`=252 where `id`=120;
update `command` set `id`=251 where `id`=119;
update `command` set `id`=250 where `id`=118;
update `command` set `id`=245 where `id`=117;
update `command` set `id`=240 where `id`=116;
update `command` set `id`=239 where `id`=115;
update `command` set `id`=238 where `id`=114;
update `command` set `id`=237 where `id`=113;
update `command` set `id`=236 where `id`=112;
update `command` set `id`=235 where `id`=111;
update `command` set `id`=230 where `id`=110;
update `command` set `id`=225 where `id`=109;
update `command` set `id`=220 where `id`=108;
update `command` set `id`=219 where `id`=107;
update `command` set `id`=218 where `id`=106;
update `command` set `id`=215 where `id`=105;
update `command` set `id`=214 where `id`=104;
update `command` set `id`=212 where `id`=103;
update `command` set `id`=210 where `id`=102;
update `command` set `id`=209 where `id`=101;
update `command` set `id`=208 where `id`=100;
update `command` set `id`=207 where `id`=99;
update `command` set `id`=206 where `id`=98;
update `command` set `id`=205 where `id`=97;
update `command` set `id`=204 where `id`=96;
update `command` set `id`=203 where `id`=95;
update `command` set `id`=202 where `id`=94;
update `command` set `id`=201 where `id`=93;
update `command` set `id`=200 where `id`=92;
update `command` set `id`=196 where `id`=91;
update `command` set `id`=195 where `id`=90;
update `command` set `id`=194 where `id`=89;
update `command` set `id`=193 where `id`=88;
update `command` set `id`=192 where `id`=87;
update `command` set `id`=191 where `id`=86;
update `command` set `id`=190 where `id`=85;
update `command` set `id`=175 where `id`=84;
update `command` set `id`=173 where `id`=83;
update `command` set `id`=172 where `id`=82;
update `command` set `id`=171 where `id`=81;
update `command` set `id`=170 where `id`=80;
update `command` set `id`=165 where `id`=79;
update `command` set `id`=160 where `id`=78;
update `command` set `id`=155 where `id`=77;
update `command` set `id`=150 where `id`=76;
update `command` set `id`=144 where `id`=75;
update `command` set `id`=143 where `id`=74;
update `command` set `id`=142 where `id`=73;
update `command` set `id`=141 where `id`=72;
update `command` set `id`=140 where `id`=71;
update `command` set `id`=139 where `id`=70;
update `command` set `id`=137 where `id`=69;
update `command` set `id`=136 where `id`=68;
update `command` set `id`=135 where `id`=67;
update `command` set `id`=134 where `id`=66;
update `command` set `id`=133 where `id`=65;
update `command` set `id`=132 where `id`=64;
update `command` set `id`=130 where `id`=63;
update `command` set `id`=125 where `id`=62;
update `command` set `id`=120 where `id`=61;
update `command` set `id`=115 where `id`=60;
update `command` set `id`=110 where `id`=59;
update `command` set `id`=104 where `id`=58;
update `command` set `id`=103 where `id`=57;
update `command` set `id`=102 where `id`=56;
update `command` set `id`=101 where `id`=55;
update `command` set `id`=100 where `id`=54;
update `command` set `id`=99 where `id`=53;
update `command` set `id`=98 where `id`=52;
update `command` set `id`=97 where `id`=51;
update `command` set `id`=93 where `id`=50;
update `command` set `id`=92 where `id`=49;
update `command` set `id`=91 where `id`=48;
update `command` set `id`=90 where `id`=47;
update `command` set `id`=85 where `id`=46;
update `command` set `id`=82 where `id`=45;
update `command` set `id`=81 where `id`=44;
update `command` set `id`=80 where `id`=43;
update `command` set `id`=75 where `id`=42;
update `command` set `id`=70 where `id`=41;
update `command` set `id`=69 where `id`=40;
update `command` set `id`=68 where `id`=39;
update `command` set `id`=67 where `id`=38;
update `command` set `id`=66 where `id`=37;
update `command` set `id`=65 where `id`=36;
update `command` set `id`=60 where `id`=35;
update `command` set `id`=59 where `id`=34;
update `command` set `id`=58 where `id`=33;
update `command` set `id`=57 where `id`=32;
update `command` set `id`=56 where `id`=31;
update `command` set `id`=55 where `id`=30;
update `command` set `id`=50 where `id`=29;
update `command` set `id`=45 where `id`=28;
update `command` set `id`=44 where `id`=27;
update `command` set `id`=43 where `id`=26;
update `command` set `id`=42 where `id`=25;
update `command` set `id`=41 where `id`=24;
update `command` set `id`=40 where `id`=23;
update `command` set `id`=39 where `id`=22;
update `command` set `id`=38 where `id`=21;
update `command` set `id`=37 where `id`=20;
update `command` set `id`=36 where `id`=19;
update `command` set `id`=35 where `id`=18;
update `command` set `id`=34 where `id`=17;
update `command` set `id`=33 where `id`=16;
update `command` set `id`=32 where `id`=15;
update `command` set `id`=31 where `id`=14;
update `command` set `id`=30 where `id`=13;
update `command` set `id`=21 where `id`=12;
update `command` set `id`=20 where `id`=11;
update `command` set `id`=10 where `id`=10;
update `command` set `id`=9 where `id`=9;
update `command` set `id`=8 where `id`=8;
update `command` set `id`=7 where `id`=7;
update `command` set `id`=6 where `id`=6;
update `command` set `id`=5 where `id`=5;
update `command` set `id`=4 where `id`=4;
update `command` set `id`=3 where `id`=3;
update `command` set `id`=3 where `id`=3;
update `command` set `id`=2 where `id`=2;
update `command` set `id`=1 where `id`=1;

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


