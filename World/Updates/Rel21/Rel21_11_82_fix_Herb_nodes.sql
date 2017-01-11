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
    SET @cOldStructure = '11'; 
    SET @cOldContent = '81';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '82';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'fix_Herb_nodes';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'fixed Black Lotus and Golden Sansam ';

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

        
        -- pool_gameobject data
		DELETE
		FROM
			pool_gameobject
		WHERE
			pool_entry IN (944, 945, 946, 948, 966, 968);
			
		DELETE
		FROM
			pool_gameobject
		WHERE
			guid IN
				(
					SELECT
						guid
					FROM
						gameobject
					WHERE
						id IN (
								176589, -- Black Lotus
								176583, -- Golden Sansam
								176638, -- Golden Sansam
								180167  -- Golden Sansam
								)
				);
				
		INSERT INTO `pool_gameobject` VALUES ('20263', '942', '0', 'Burning Steppes - Black Lotus');
        INSERT INTO `pool_gameobject` VALUES ('20264', '944', '0', 'Black Lotus zone 139, node 274');
		INSERT INTO `pool_gameobject` VALUES ('20265', '946', '0', 'Black Lotus zone 618, node 204');
		INSERT INTO `pool_gameobject` VALUES ('20266', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20267', '945', '0', 'Black Lotus zone 1377, node 41');
		INSERT INTO `pool_gameobject` VALUES ('20268', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20269', '946', '0', 'Black Lotus zone 618, node 205');
		INSERT INTO `pool_gameobject` VALUES ('20270', '946', '0', 'Black Lotus zone 618, node 206');
		INSERT INTO `pool_gameobject` VALUES ('20271', '944', '0', 'Black Lotus zone 139, node 275');
		INSERT INTO `pool_gameobject` VALUES ('20272', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20273', '946', '0', 'Black Lotus zone 618, node 207');
		INSERT INTO `pool_gameobject` VALUES ('20274', '945', '0', 'Black Lotus zone 1377, node 42');
		INSERT INTO `pool_gameobject` VALUES ('20275', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20276', '946', '0', 'Black Lotus zone 618, node 208');
		INSERT INTO `pool_gameobject` VALUES ('20277', '944', '0', 'Black Lotus zone 139, node 276');
		INSERT INTO `pool_gameobject` VALUES ('20278', '946', '0', 'Black Lotus zone 618, node 209');
		INSERT INTO `pool_gameobject` VALUES ('20279', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20280', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20281', '946', '0', 'Black Lotus zone 618, node 210');
		INSERT INTO `pool_gameobject` VALUES ('20282', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20283', '944', '0', 'Black Lotus zone 139, node 277');
		INSERT INTO `pool_gameobject` VALUES ('20284', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20285', '944', '0', 'Black Lotus zone 139, node 278');
		INSERT INTO `pool_gameobject` VALUES ('20286', '946', '0', 'Black Lotus zone 618, node 211');
		INSERT INTO `pool_gameobject` VALUES ('20287', '946', '0', 'Black Lotus zone 618, node 212');
		INSERT INTO `pool_gameobject` VALUES ('20288', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20289', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20290', '946', '0', 'Black Lotus zone 618, node 213');
		INSERT INTO `pool_gameobject` VALUES ('20291', '945', '0', 'Black Lotus zone 1377, node 43');
		INSERT INTO `pool_gameobject` VALUES ('20292', '945', '0', 'Black Lotus zone 1377, node 44');
		INSERT INTO `pool_gameobject` VALUES ('20293', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20294', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20295', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20296', '944', '0', 'Black Lotus zone 139, node 279');
		INSERT INTO `pool_gameobject` VALUES ('20297', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20298', '946', '0', 'Black Lotus zone 618, node 214');
		INSERT INTO `pool_gameobject` VALUES ('20299', '944', '0', 'Black Lotus zone 139, node 280');
		INSERT INTO `pool_gameobject` VALUES ('20300', '946', '0', 'Black Lotus zone 618, node 215');
		INSERT INTO `pool_gameobject` VALUES ('20301', '946', '0', 'Black Lotus zone 618, node 216');
		INSERT INTO `pool_gameobject` VALUES ('20302', '946', '0', 'Black Lotus zone 618, node 217');
		INSERT INTO `pool_gameobject` VALUES ('20303', '944', '0', 'Black Lotus zone 139, node 281');
		INSERT INTO `pool_gameobject` VALUES ('20304', '944', '0', 'Black Lotus zone 139, node 282');
		INSERT INTO `pool_gameobject` VALUES ('20305', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('20306', '945', '0', 'Black Lotus zone 1377, node 45');
		INSERT INTO `pool_gameobject` VALUES ('20307', '942', '0', 'Burning Steppes - Black Lotus');	
		INSERT INTO `pool_gameobject` VALUES ('33420', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('45837', '944', '0', 'Black Lotus zone 139, node 325');
		INSERT INTO `pool_gameobject` VALUES ('49139', '946', '0', 'Black Lotus zone 618, node 254');
		INSERT INTO `pool_gameobject` VALUES ('49412', '945', '0', 'Black Lotus zone 1377, node 64');
		INSERT INTO `pool_gameobject` VALUES ('63727', '944', '0', 'Black Lotus zone 139, node 399');
		INSERT INTO `pool_gameobject` VALUES ('63728', '944', '0', 'Black Lotus zone 139, node 400');
		INSERT INTO `pool_gameobject` VALUES ('65289', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('65290', '942', '0', 'Burning Steppes - Black Lotus');
		INSERT INTO `pool_gameobject` VALUES ('86503', '944', '0', 'Black Lotus zone 139, node 445');
		INSERT INTO `pool_gameobject` VALUES ('86504', '946', '0', 'Black Lotus zone 618, node 290');
		INSERT INTO `pool_gameobject` VALUES ('87316', '944', '0', 'Black Lotus zone 139, node 452');
		
		INSERT INTO `pool_gameobject` VALUES ('19055', '8602', '0', 'Golden Sansam - Felwood - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19154', '8596', '0', 'Golden Sansam - Felwood - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19111', '8596', '0', 'Golden Sansam - Felwood - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19001', '8596', '0', 'Golden Sansam - Felwood - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('18998', '8596', '0', 'Golden Sansam - Felwood - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19239', '8590', '0', 'Golden Sansam - Felwood - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19036', '8590', '0', 'Golden Sansam - Felwood - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19028', '8590', '0', 'Golden Sansam - Felwood - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19002', '8590', '0', 'Golden Sansam - Felwood - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18975', '8590', '0', 'Golden Sansam - Felwood - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18965', '8590', '0', 'Golden Sansam - Felwood - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19253', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19236', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19187', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19177', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19167', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19132', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19131', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19130', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19118', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19106', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19076', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19070', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19043', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18986', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18967', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18966', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18948', '8583', '0', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19231', '8576', '0', 'Golden Sansam - Felwood - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19098', '8576', '0', 'Golden Sansam - Felwood - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('50161', '8573', '0', 'Golden Sansam - Feralas - subzone 12');
		INSERT INTO `pool_gameobject` VALUES ('19173', '8563', '0', 'Golden Sansam - Feralas - subzone 9');
		INSERT INTO `pool_gameobject` VALUES ('19074', '8563', '0', 'Golden Sansam - Feralas - subzone 9');
		INSERT INTO `pool_gameobject` VALUES ('86386', '8557', '0', 'Golden Sansam - Feralas - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19224', '8557', '0', 'Golden Sansam - Feralas - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19183', '8550', '0', 'Golden Sansam - Feralas - subzone 7');
		INSERT INTO `pool_gameobject` VALUES ('18992', '8550', '0', 'Golden Sansam - Feralas - subzone 7');
		INSERT INTO `pool_gameobject` VALUES ('50163', '8544', '0', 'Golden Sansam - Feralas - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19123', '8544', '0', 'Golden Sansam - Feralas - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19122', '8544', '0', 'Golden Sansam - Feralas - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('18989', '8544', '0', 'Golden Sansam - Feralas - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('86384', '8539', '0', 'Golden Sansam - Feralas - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18999', '8539', '0', 'Golden Sansam - Feralas - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18982', '8539', '0', 'Golden Sansam - Feralas - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('87297', '8534', '0', 'Golden Sansam - Feralas - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('50160', '8534', '0', 'Golden Sansam - Feralas - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19143', '8534', '0', 'Golden Sansam - Feralas - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19054', '8534', '0', 'Golden Sansam - Feralas - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('50159', '8529', '0', 'Golden Sansam - Feralas - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19220', '8529', '0', 'Golden Sansam - Feralas - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('49399', '8523', '0', 'Golden Sansam - Silithus - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19223', '8523', '0', 'Golden Sansam - Silithus - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19216', '8523', '0', 'Golden Sansam - Silithus - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19135', '8523', '0', 'Golden Sansam - Silithus - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19238', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19198', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19196', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19195', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19193', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19189', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19186', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19168', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19052', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
        INSERT INTO `pool_gameobject` VALUES ('19038', '8519', '0', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('49400', '8516', '0', 'Golden Sansam - Silithus - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19012', '8516', '0', 'Golden Sansam - Silithus - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19004', '8516', '0', 'Golden Sansam - Silithus - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18972', '8516', '0', 'Golden Sansam - Silithus - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('49397', '8513', '0', 'Golden Sansam - Silithus - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19227', '8513', '0', 'Golden Sansam - Silithus - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19175', '8513', '0', 'Golden Sansam - Silithus - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19059', '8513', '0', 'Golden Sansam - Silithus - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19050', '8513', '0', 'Golden Sansam - Silithus - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('49398', '8510', '0', 'Golden Sansam - Silithus - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19170', '8507', '0', 'Golden Sansam - Silithus - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19169', '8507', '0', 'Golden Sansam - Silithus - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19075', '8507', '0', 'Golden Sansam - Silithus - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('86392', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('86383', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('46323', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19210', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19158', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19144', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19133', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19124', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19026', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19003', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('18980', '8415', '0', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('87486', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('87485', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('86394', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('63560', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('46306', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('46284', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19257', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19218', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19125', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19104', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19103', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19093', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19077', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19071', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19045', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19037', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19022', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19021', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19008', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18990', '8408', '0', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19194', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19150', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19096', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19049', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19018', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18979', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18963', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18962', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18958', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('6873', '8397', '0', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19226', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19051', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19042', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19034', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19025', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19024', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('18961', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('18955', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('6857', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('6823', '8393', '0', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19217', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19180', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19114', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19109', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19039', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19020', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18970', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18954', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18944', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('4525', '8389', '0', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19105', '8203', '0', 'Golden Sansam - Azshara - subzone 9');
		INSERT INTO `pool_gameobject` VALUES ('19073', '8203', '0', 'Golden Sansam - Azshara - subzone 9');
		INSERT INTO `pool_gameobject` VALUES ('86395', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('86393', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('63571', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('48414', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('48410', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('39928', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19215', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19199', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19192', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19165', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19141', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19134', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19089', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19078', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('19011', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('18971', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('18945', '8199', '0', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_gameobject` VALUES ('48415', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('48413', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('48412', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('39929', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19256', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19255', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19237', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19222', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19188', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19182', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19171', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19113', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19084', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19067', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19060', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19048', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('19047', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('18985', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('18983', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('18981', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('18950', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('18949', '8190', '0', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_gameobject` VALUES ('63570', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('48408', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19221', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19212', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19209', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19208', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19197', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19185', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19176', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19140', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19112', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19110', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19087', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('19014', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('18995', '8184', '0', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_gameobject` VALUES ('48411', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('48409', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('48407', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19251', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19250', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19247', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19243', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19225', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19219', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19214', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19163', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19162', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19161', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19116', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19108', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19086', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19082', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19006', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19005', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18947', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18946', '8177', '0', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19201', '8170', '0', 'Golden Sansam - Azshara - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19200', '8170', '0', 'Golden Sansam - Azshara - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19184', '8170', '0', 'Golden Sansam - Azshara - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19179', '8170', '0', 'Golden Sansam - Azshara - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19119', '8170', '0', 'Golden Sansam - Azshara - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19046', '8170', '0', 'Golden Sansam - Azshara - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19044', '8170', '0', 'Golden Sansam - Azshara - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19029', '8170', '0', 'Golden Sansam - Azshara - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19230', '8164', '0', 'Golden Sansam - Azshara - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19117', '8164', '0', 'Golden Sansam - Azshara - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19091', '8164', '0', 'Golden Sansam - Azshara - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19080', '8164', '0', 'Golden Sansam - Azshara - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19079', '8164', '0', 'Golden Sansam - Azshara - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19041', '8164', '0', 'Golden Sansam - Azshara - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18984', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19009', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19010', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19030', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19031', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19068', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19069', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19102', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19107', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19121', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19145', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19146', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19147', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19248', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19249', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('33309', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('45855', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('45908', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('63536', '8645', '0', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18968', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('18969', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19058', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19137', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19148', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19149', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19157', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19174', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19228', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19229', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19234', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('33874', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('45825', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('63523', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('86388', '8651', '0', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('18964', '8657', '0', 'Golden Sansam - Eastern Plaguelands - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18973', '8657', '0', 'Golden Sansam - Eastern Plaguelands - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19083', '8657', '0', 'Golden Sansam - Eastern Plaguelands - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19088', '8657', '0', 'Golden Sansam - Eastern Plaguelands - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19172', '8657', '0', 'Golden Sansam - Eastern Plaguelands - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19178', '8657', '0', 'Golden Sansam - Eastern Plaguelands - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('45948', '8657', '0', 'Golden Sansam - Eastern Plaguelands - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('86389', '8657', '0', 'Golden Sansam - Eastern Plaguelands - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18993', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18994', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19016', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19017', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19151', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19152', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19153', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('63559', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('86390', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('87298', '8664', '0', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('17738', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('17739', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18951', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18953', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18959', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18976', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18987', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('18988', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19061', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19062', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19063', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19064', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19081', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19085', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19097', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19115', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19126', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19136', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19155', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19156', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19190', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19202', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19211', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19235', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19240', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19241', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('19246', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('87004', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('87489', '8821', '0', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_gameobject` VALUES ('17740', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('17744', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('18974', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19000', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19023', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19027', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19033', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19040', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19066', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19072', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19101', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19120', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19142', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19164', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19166', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19203', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19232', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('19245', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('86387', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('87005', '8826', '0', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_gameobject` VALUES ('17741', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('17742', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18960', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18996', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('18997', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19007', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19013', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19099', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19100', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19127', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19128', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19129', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19139', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19191', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19207', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19213', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19233', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19252', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19254', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('19258', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('86382', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('87487', '8830', '0', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_gameobject` VALUES ('17737', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('17743', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18952', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18956', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18957', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18977', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18978', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('18991', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19019', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19032', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19053', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19056', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19057', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19065', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19090', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19094', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19095', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19138', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19159', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19160', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19181', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19204', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19205', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19206', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19242', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('19244', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('86385', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_gameobject` VALUES ('87488', '8835', '0', 'Golden Sansam - UnGoro Crater - subzone 4');

		
		-- pool_template data
		DELETE
		FROM
			pool_template
		WHERE
			entry IN
				(
					SELECT
						pool_entry
					FROM
						pool_gameobject
					WHERE
						guid IN
								(
									SELECT
										guid
									FROM
										gameobject
									WHERE
										id IN  (
												176589, -- Black Lotus
												176583, -- Golden Sansam
												176638, -- Golden Sansam
												180167  -- Golden Sansam
											    )
		                        )
                 );
				 

		INSERT INTO `pool_template` VALUES ('942', '1', 'MASTER Herbs Black Lotus Burning Steppes zone 46');
		INSERT INTO `pool_template` VALUES ('944', '1', 'MASTER Herbs Black Lotus Winterspring zone 618');
		INSERT INTO `pool_template` VALUES ('945', '1', 'MASTER Herbs Black Lotus Silithus zone 1377');
		INSERT INTO `pool_template` VALUES ('946', '1', 'MASTER Herbs Black Lotus Eastern Plaguelands zone 139');		
				 
				 
		INSERT INTO `pool_template` VALUES ('8835', '4', 'Golden Sansam - UnGoro Crater - subzone 4');
		INSERT INTO `pool_template` VALUES ('8830', '3', 'Golden Sansam - UnGoro Crater - subzone 3');
		INSERT INTO `pool_template` VALUES ('8826', '3', 'Golden Sansam - UnGoro Crater - subzone 2');
		INSERT INTO `pool_template` VALUES ('8821', '4', 'Golden Sansam - UnGoro Crater - subzone 1');
		INSERT INTO `pool_template` VALUES ('8664', '1', 'Golden Sansam - Eastern Plaguelands - subzone 4');
		INSERT INTO `pool_template` VALUES ('8657', '1', 'Golden Sansam - Eastern Plaguelands - subzone 3');
		INSERT INTO `pool_template` VALUES ('8651', '2', 'Golden Sansam - Eastern Plaguelands - subzone 2');
		INSERT INTO `pool_template` VALUES ('8645', '3', 'Golden Sansam - Eastern Plaguelands - subzone 1');
		INSERT INTO `pool_template` VALUES ('8602', '1', 'Golden Sansam - Felwood - subzone 6');
		INSERT INTO `pool_template` VALUES ('8596', '1', 'Golden Sansam - Felwood - subzone 5');
		INSERT INTO `pool_template` VALUES ('8590', '1', 'Golden Sansam - Felwood - subzone 4');
		INSERT INTO `pool_template` VALUES ('8583', '2', 'Golden Sansam - Felwood - subzone 3');
		INSERT INTO `pool_template` VALUES ('8576', '1', 'Golden Sansam - Felwood - subzone 1');
		INSERT INTO `pool_template` VALUES ('8573', '1', 'Golden Sansam - Feralas - subzone 12');
		INSERT INTO `pool_template` VALUES ('8563', '1', 'Golden Sansam - Feralas - subzone 9');
		INSERT INTO `pool_template` VALUES ('8557', '1', 'Golden Sansam - Feralas - subzone 8');
		INSERT INTO `pool_template` VALUES ('8550', '1', 'Golden Sansam - Feralas - subzone 7');
		INSERT INTO `pool_template` VALUES ('8544', '1', 'Golden Sansam - Feralas - subzone 5');
		INSERT INTO `pool_template` VALUES ('8539', '1', 'Golden Sansam - Feralas - subzone 4');
		INSERT INTO `pool_template` VALUES ('8534', '1', 'Golden Sansam - Feralas - subzone 2');
		INSERT INTO `pool_template` VALUES ('8529', '1', 'Golden Sansam - Feralas - subzone 1');
		INSERT INTO `pool_template` VALUES ('8523', '1', 'Golden Sansam - Silithus - subzone 6');
		INSERT INTO `pool_template` VALUES ('8519', '1', 'Golden Sansam - Silithus - subzone 5');
		INSERT INTO `pool_template` VALUES ('8516', '1', 'Golden Sansam - Silithus - subzone 4');
		INSERT INTO `pool_template` VALUES ('8513', '1', 'Golden Sansam - Silithus - subzone 3');
		INSERT INTO `pool_template` VALUES ('8510', '1', 'Golden Sansam - Silithus - subzone 2');
		INSERT INTO `pool_template` VALUES ('8507', '1', 'Golden Sansam - Silithus - subzone 1');
		INSERT INTO `pool_template` VALUES ('8415', '2', 'Golden Sansam - The Hinterlands - subzone 2');
		INSERT INTO `pool_template` VALUES ('8408', '3', 'Golden Sansam - The Hinterlands - subzone 1');
		INSERT INTO `pool_template` VALUES ('8397', '1', 'Golden Sansam - Burning Steppes - subzone 3');
		INSERT INTO `pool_template` VALUES ('8393', '1', 'Golden Sansam - Burning Steppes - subzone 2');
		INSERT INTO `pool_template` VALUES ('8389', '1', 'Golden Sansam - Burning Steppes - subzone 1');
		INSERT INTO `pool_template` VALUES ('8203', '1', 'Golden Sansam - Azshara - subzone 9');
		INSERT INTO `pool_template` VALUES ('8199', '2', 'Golden Sansam - Azshara - subzone 8');
		INSERT INTO `pool_template` VALUES ('8190', '3', 'Golden Sansam - Azshara - subzone 6');
		INSERT INTO `pool_template` VALUES ('8184', '2', 'Golden Sansam - Azshara - subzone 5');
		INSERT INTO `pool_template` VALUES ('8177', '3', 'Golden Sansam - Azshara - subzone 4');
		INSERT INTO `pool_template` VALUES ('8170', '1', 'Golden Sansam - Azshara - subzone 3');
		INSERT INTO `pool_template` VALUES ('8164', '1', 'Golden Sansam - Azshara - subzone 1');

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
