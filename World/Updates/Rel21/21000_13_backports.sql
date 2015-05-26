-- -----------------------------------
-- Added to prevent timeout's while loading
-- -----------------------------------
SET GLOBAL net_read_timeout=30;
SET GLOBAL net_write_timeout=60;
SET GLOBAL net_buffer_length=1000000; 
SET GLOBAL max_allowed_packet=1000000000;
SET GLOBAL connect_timeout=10000000;

-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

  SET @cOldRev = 'required_21000_11_STV_Sleeping_Creatures'; 

  -- Set the new revision string
  SET @cNewRev = 'required_21000_13_Backports';

  -- Set thisRevision to the column name of db_version in the currently selected database
  SET @cThisRev := ((SELECT column_name FROM information_schema.`COLUMNS` WHERE table_name='db_version' AND table_schema=(SELECT DATABASE() AS thisDB FROM DUAL) AND column_name LIKE 'required%'));

  -- Set friendly Version Text
  SET @cThisVersion = 'MaNGOSZero Database Rev 21000_13';
 
  -- Only Proceed if the old values match
  IF @cThisRev = @cOldRev THEN
    -- Make this all a single transaction
    START TRANSACTION;

    -- Apply the Version Change from Old Version to New Version
    SET @query = CONCAT('ALTER TABLE db_version CHANGE COLUMN ',@cOldRev, ' ' ,@cNewRev,' bit;');
    PREPARE stmt1 FROM @query;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;
    -- The Above block is required for making table changes
    
    INSERT IGNORE INTO `db_version` SET `Version` = @cThisVersion;

    -- If this is purely an incremental update, include this line
    SET @cNewRev = @cThisVersion;

    -- -- -- -- Normal Update / Insert / Delete statements will go here  -- -- -- -- --

-- This is mainly a backport from classicdb, but keep in mind that there are a lot of fixes and corrections implemented by me, the first script for example

-- Also this fix all startup errors and corrects several problems in the db like duplicates or double spawns

-- ==================================================================
-- Fix Faction Mount Vendors Selling To Other Races Below Exalted Rep
-- ==================================================================
 
-- --------------
-- Lelanai (4730) - Night Elf
-- --------------
UPDATE creature_template SET NPCFlags=NPCFlags|128 WHERE entry=4730;
DELETE FROM gossip_menu_option WHERE menu_id IN (3185) AND id IN (2);

DELETE FROM `conditions` WHERE `condition_entry`=218 AND `type` = 5;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('218','5','69','7');

DELETE FROM `conditions` WHERE `condition_entry`=219 AND `type` = 14;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('219','14','69','0');

DELETE FROM `conditions` WHERE `condition_entry`=220 AND `type` = -1;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('220','-1','218','219');

DELETE FROM `conditions` WHERE `condition_entry`=221 AND `type` = 14;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('221','14','8','0');

DELETE FROM `conditions` WHERE `condition_entry`=222 AND `type` = -2;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('222','-2','220','221');
 
UPDATE gossip_menu SET condition_id=222 WHERE entry=3185 AND text_id=3942;
UPDATE gossip_menu_option SET condition_id=222 WHERE menu_id=3185 AND id=1;
 
UPDATE gossip_menu_option SET id=0, npc_option_npcflag=128 WHERE menu_id=3185 AND id=1;
 
-- ---------------------------
-- Milli Featherwhistle (7955) - Gnome
-- ---------------------------
UPDATE creature_template SET NPCFlags=NPCFlags|128 WHERE entry=7955;

DELETE FROM `gossip_menu_option` WHERE `menu_id`=3186 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `condition_id`) VALUES
('3186','0','1','I would like to buy from you.','3','128','0','0','0','0','0',NULL,'331');
 
DELETE FROM `conditions` WHERE `condition_entry`=327 AND `type` = 5;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('327','5','54','7');

DELETE FROM `conditions` WHERE `condition_entry`=328 AND `type` = 14;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('328','14','13','0');

DELETE FROM `conditions` WHERE `condition_entry`=329 AND `type` = -1;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('329','-1','327','328');

DELETE FROM `conditions` WHERE `condition_entry`=330 AND `type` = 14;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('330','14','64','0');

DELETE FROM `conditions` WHERE `condition_entry`=331 AND `type` = -2;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES('331','-2','329','330');
 
UPDATE gossip_menu SET condition_id=331 WHERE entry=3186 AND text_id=3945;
UPDATE gossip_menu_option SET condition_id=331 WHERE menu_id=3186 AND id=0;
 


UPDATE creature SET curhealth = 979 WHERE id = 1893;
UPDATE creature SET curhealth = 836 WHERE id = 3533;
DELETE FROM creature WHERE GUID = 160015;
DELETE FROM creature WHERE GUID = 160486;
INSERT INTO creature VALUES (160486,12900,0,0,0,-10666,-3923,18.438,1.223,900,0,0,38844,8343,0,2);

DELETE FROM `creature_ai_scripts` WHERE creature_id = 3275;
INSERT INTO `creature_ai_scripts`  VALUES('327501','3275','4','0','100','0','0','0','0','0','11','6268','6','1','0','0','0','0','0','0','0','0','Kolkar Marauder - Cast Charge on Aggro');
INSERT INTO `creature_ai_scripts`  VALUES('327502','3275','0','0','100','1','5000','11000','7000','12000','11','11976','1','0','0','0','0','0','0','0','0','0','Kolkar Marauder - Cast Strike');
INSERT INTO `creature_ai_scripts`  VALUES('327503','3275','0','0','100','1','7000','15000','9000','14000','11','8014','4','33','0','0','0','0','0','0','0','0','Kolkar Marauder - Cast Tetanus');
INSERT INTO `creature_ai_scripts`  VALUES('327504','3275','6','0','5','0','0','0','0','0','1','-769','0','0','49','3395','1','8','0','0','0','0','Kolkar Marauder - Chance Say and Summon Verog the Dervish on Death');
DELETE FROM `dbscripts_on_go_template_use` WHERE id = 178905;
INSERT INTO `dbscripts_on_go_template_use` VALUES('178905','0','10','13696','60000','0','0','0','0','0','0','0','0','0','0','0','summon Noxxious Scion');

DELETE FROM `dbscripts_on_quest_end` WHERE id = 7811;
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','0','21','1','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty - active');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','0','21','1','0','10805','272','16','0','0','0','0','0','0','0','0','Klemmy - active');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','0','21','1','0','10610','269','16','0','0','0','0','0','0','0','0','Angus - active');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','73','3','0','0','10803','266','16','0','0','0','0','0','0','0','4.00565','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','74','16','6248','2','10803','266','16','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','77','3','0','0','10803','266','16','0','0','0','0','0','0','0','2.44346','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','81','0','0','0','10804','268','23','2000005739','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','83','15','16775','0','10803','266','23','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','87','15','16778','0','10803','266','23','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','91','1','5','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','71','0','0','0','10804','268','23','2000005737','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','67','0','0','0','10804','268','23','2000005736','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','62','1','23','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','61','1','21','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','59','1','25','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','121','1','4','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','54','15','16767','0','10803','266','23','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','180','3','0','0','10805','272','16','0','0','0','0','-6065.9','-202.298','424.369','5','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','115','1','21','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','48','1','274','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','176','3','0','0','10805','272','16','0','0','0','0','0','0','0','6.04228','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','119','3','0','0','10611','267','16','0','0','0','0','0','0','0','2.84489','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','44','0','0','0','10804','268','23','2000005733','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','119','3','0','0','10804','268','16','0','0','0','0','0','0','0','5.13852','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','31','0','0','0','10804','268','23','2000005730','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','115','1','21','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','178','1','66','0','10805','272','16','0','0','0','0','0','0','0','0','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','34','15','16768','0','10804','268','23','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','24','3','0','0','1243','265','16','0','0','0','0','0','0','0','3.68522','Hegnar');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','172','10','11875','180000','0','0','0','0','0','0','0','-6076','-215','424','0','summon 2nd Mortar Team Target Dummy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','114','3','0','0','10803','266','16','0','0','0','0','0','0','0','4.00565','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','6','3','0','0','10803','266','16','0','0','0','0','-6031.93','-221.088','413.153','2.44346','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','20','3','0','0','10803','266','16','0','0','0','0','0','0','0','2.44346','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','19','3','0','0','10611','267','16','0','0','0','0','0','0','0','2.18492','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','7','3','0','0','10805','272','16','0','0','0','0','-6065.18','-201.938','424.419','5','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','163','1','1','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','109','16','6246','2','10804','268','23','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','4','3','0','0','10805','272','16','0','0','0','0','-6011.17','-197.021','406.765','1.97737','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','1','21','1','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler - active');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','106','16','6250','2','10804','268','23','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','106','0','0','0','10804','268','23','2000005745','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','3','16','6598','2','0','0','0','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','103','15','16776','0','10804','268','23','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','164','1','4','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','77','0','0','0','10804','268','23','2000005738','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','100','16','6250','2','10804','268','23','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','100','0','0','0','10804','268','23','2000005743','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','98','3','0','0','10803','266','16','0','0','0','0','0','0','0','2.44346','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','89','0','0','0','10803','266','23','2000005742','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','162','3','0','0','10611','267','16','0','0','0','0','0','0','0','4.54215','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','121','3','0','0','10805','272','16','0','0','0','0','-6077.43','-213.257','424.05','5.59936','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','93','1','25','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','91','3','0','0','10803','266','16','0','0','0','0','0','0','0','4.00565','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','159','1','17','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','64','3','0','0','10803','266','16','0','0','0','0','0','0','0','2.44346','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','49','3','0','0','10804','268','16','0','0','0','0','0','0','0','1.88496','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','131','10','11875','180000','0','0','0','0','0','0','0','-6076','-215','424','0','summon 1st Mortar Team Target Dummy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','134','3','0','0','10805','272','16','0','0','0','0','-6065.9','-202.298','424.369','5','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','139','1','3','0','10805','272','16','0','0','0','0','0','0','0','0','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','119','3','0','0','10803','266','16','0','0','0','0','0','0','0','4.77803','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','1','21','1','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp - active');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','113','3','0','0','10804','268','16','0','0','0','0','0','0','0','0.810652','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','142','1','16','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','150','3','0','0','10611','267','16','0','0','0','0','0','0','0','2.84489','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','143','1','69','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','103','0','0','0','10804','268','23','2000005744','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','151','3','0','0','10803','266','16','0','0','0','0','0','0','0','3.01942','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','91','3','0','0','10804','268','16','0','0','0','0','0','0','0','0.810652','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','152','15','18655','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','156','15','5','0','11875','100','7','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','233','1','11','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','232','1','11','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','174','3','0','0','10805','272','16','0','0','0','0','-6071.88','-212.831','422.929','5','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','4','3','0','0','10803','266','16','0','0','0','0','-6011.87','-199.241','406.834','4.31443','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','160','25','0','0','10805','272','16','0','0','0','0','0','0','0','0','RUN OFF');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','260','3','0','0','1243','265','16','0','0','0','0','0','0','0','0.0349066','Hegnar');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','2','25','1','0','10805','272','16','0','0','0','0','0','0','0','0','RUN ON');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','17','3','0','0','10805','272','16','0','0','0','0','0','0','0','5.59936','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','106','15','16779','0','10804','268','23','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','20','3','0','0','10804','268','16','0','0','0','0','0','0','0','1.88496','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','214','15','5','0','12385','100','7','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','193','25','0','0','10805','272','16','0','0','0','0','0','0','0','0','RUN OFF');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','3','3','0','0','10610','269','16','0','0','0','0','-6031.16','-230.264','414.361','2.18492','Angus');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','36','0','0','0','10804','268','23','2000005731','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','256','3','0','0','10805','272','16','0','0','0','0','0','0','0','3.28222','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','212','16','6258','2','0','0','0','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','192','15','16786','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','46','3','0','0','10804','268','16','0','0','0','0','0','0','0','0.810652','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','191','16','7316','2','0','0','0','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','189','16','6255','2','0','0','0','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','4','3','0','0','10611','267','16','0','0','0','0','-6031.59','-228.182','414.404','2','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','42','15','16772','0','10804','268','23','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','4','3','0','0','10804','268','16','0','0','0','0','-6034.14','-223.333','413.4','1','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','20','3','0','0','10610','269','16','0','0','0','0','0','0','0','2','angus');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','5','3','0','0','10805','272','16','0','0','0','0','-6015.51','-184.362','407.712','2.49704','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','47','1','11','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','48','1','274','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','270','21','0','0','10610','269','16','0','0','0','0','0','0','0','0','Angus - unactive');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','188','3','0','0','10611','267','16','0','0','0','0','0','0','0','2.84489','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','183','3','0','0','10805','272','16','0','0','0','0','0','0','0','4.0985','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','50','0','0','0','10803','266','23','2000005734','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','47','1','5','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','270','21','0','0','10805','272','16','0','0','0','0','0','0','0','0','Klemmy - unactive');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','56','0','0','0','10803','266','23','2000005735','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','58','3','0','0','10803','266','16','0','0','0','0','0','0','0','4.00565','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','211','1','5','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','62','1','21','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','215','3','0','0','10804','268','16','0','0','0','0','0','0','0','2.9147','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','69','15','16777','0','10804','268','23','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','207','1','25','0','10805','272','16','0','0','0','0','0','0','0','0','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','154','16','7316','2','0','0','0','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','151','1','25','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','132','25','1','0','10805','272','16','0','0','0','0','0','0','0','0','RUN ON');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','210','15','18655','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','208','3','0','0','10805','272','16','0','0','0','0','0','0','0','6.04228','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','197','1','4','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','142','3','0','0','10805','272','16','0','0','0','0','0','0','0','4.0985','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','137','3','0','0','10805','272','16','0','0','0','0','0','0','0','5.59936','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','148','1','0','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','121','16','6256','2','0','0','0','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','204','10','12385','180000','0','0','0','0','0','0','0','-6076','-215','424','0','summon Mortar Team Advanced Target Dummy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','180','28','8','0','10611','267','16','0','0','0','0','0','0','0','0','STATE_KNEEL');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','195','3','0','0','10804','268','16','0','0','0','0','0','0','0','5.13852','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','270','21','0','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler - unactive');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','214','15','16786','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','73','1','20','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','85','0','0','0','10803','266','23','2000005741','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','196','1','21','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','190','15','18655','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','79','15','16780','0','10804','268','23','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','59','16','6249','2','10803','266','16','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','83','0','0','0','10803','266','23','2000005740','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','74','1','6','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','194','1','25','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','95','1','11','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','100','15','16572','0','10804','268','23','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','182','16','6254','2','0','0','0','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','232','1','11','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','103','16','6250','2','10804','268','23','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','151','3','0','0','10804','268','16','0','0','0','0','0','0','0','2.9147','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','141','3','0','0','10611','267','16','0','0','0','0','0','0','0','4.54215','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','194','16','6251','2','0','0','0','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','109','1','71','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','196','3','0','0','10803','266','16','0','0','0','0','0','0','0','4.77803','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','230','1','11','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','115','1','2','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','231','1','14','0','10805','272','16','0','0','0','0','0','0','0','0','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','254','3','0','0','10803','266','16','0','0','0','0','0','0','0','4.37218','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','120','25','0','0','10805','272','16','0','0','0','0','0','0','0','0','RUN OFF');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','119','3','0','0','10610','269','16','0','0','0','0','0','0','0','2.84489','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','189','1','25','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','205','3','0','0','10805','272','16','0','0','0','0','-6071.88','-212.831','422.929','5','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','40','0','0','0','10804','268','23','2000005732','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','98','3','0','0','10804','268','16','0','0','0','0','0','0','0','1.88496','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','115','1','21','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','156','15','16786','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','192','15','5','0','11875','100','7','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','211','1','15','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','213','16','7316','2','0','0','0','0','0','0','0','0','0','0','0','sound');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','162','3','0','0','10805','272','16','0','0','0','0','-6077.43','-213.257','424.05','5.59936','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','167','3','0','0','10611','267','16','0','0','0','0','0','0','0','2.84489','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','259','3','0','0','10804','268','16','0','0','0','0','0','0','0','5.53269','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','177','25','1','0','10805','272','16','0','0','0','0','0','0','0','0','RUN ON');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','208','1','11','0','10805','272','16','0','0','0','0','0','0','0','0','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','210','3','0','0','10805','272','16','0','0','0','0','-6064.07','-209.851','421.98','6.10275','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','215','1','10','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','195','3','0','0','10805','272','16','0','0','0','0','-6077.43','-213.257','424.05','5.59936','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','193','3','0','0','10611','267','16','0','0','0','0','0','0','0','4.54215','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','215','3','0','0','10803','266','16','0','0','0','0','0','0','0','3.01942','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','178','3','0','0','10611','267','16','0','0','0','0','0','0','0','4.54215','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','215','3','0','0','10805','272','16','0','0','0','0','-6061.97','-218.956','421.085','5.92054','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','121','1','4','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','237','3','0','0','10610','269','16','0','0','0','0','-6009.25','-202.65','406.983','2','angus');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','187','28','0','0','10611','267','16','0','0','0','0','0','0','0','0','STATE_STAND');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','231','1','11','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','230','1','11','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','163','16','6252','2','0','0','0','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','229','1','14','0','10805','272','16','0','0','0','0','0','0','0','0','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','229','1','0','0','10610','269','16','0','0','0','0','0','0','0','0','');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','210','25','1','0','10805','272','16','0','0','0','0','0','0','0','0','RUN ON');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','219','3','0','0','10805','272','16','0','0','0','0','-6040.96','-221.929','414.921','5.92054','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','215','1','10','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','237','3','0','0','10804','268','16','0','0','0','0','-6010.67','-199.434','406.792','5.53269','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','237','3','0','0','10803','266','16','0','0','0','0','-6008.53','-199.145','406.687','4.37218','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','236','3','0','0','10805','272','16','0','0','0','0','-6007.3','-200.348','406.777','3.28222','Klemmy');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','233','1','11','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','197','3','0','0','10611','267','16','0','0','0','0','0','0','0','2.84489','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','229','1','0','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','231','1','11','0','10803','266','16','0','0','0','0','0','0','0','0','Wheeler');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','270','21','0','0','10611','267','16','0','0','0','0','0','0','0','0','Shorty - unactive');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','270','21','0','0','10804','268','16','0','0','0','0','0','0','0','0','Middlecamp - unactive');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','254','3','0','0','10610','269','16','0','0','0','0','0','0','0','1.58825','angus');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','236','3','0','0','10611','267','16','0','0','0','0','-6007.46','-202.158','407.448','2','Shorty');
INSERT INTO `dbscripts_on_quest_end` VALUES('7811','260','3','0','0','10611','267','16','0','0','0','0','0','0','0','2.47837','Shorty');



-- Fixed quest 2954 (The Stone Watcher): the quest giver will now display its gossip menu
UPDATE `creature_template` SET `NpcFlags` = `NpcFlags` | 1 WHERE `Entry` = 7918;

-- This will fix the wrong text on UC summoning script
DELETE FROM `creature_ai_texts` WHERE entry IN (-1311, -1321, -1322);
DELETE FROM `creature_ai_texts` WHERE entry IN (-1411, -1412, -1413, -1414, -1415, -1416, -1417, -1418, -1419, -1420, -1421, -1422);
INSERT INTO `creature_ai_texts` VALUES
(-1422,'There you have it. Our lesson on summoning has come to an end. A new class will begin shortly, so if you wish to brush up, feel free to stay around.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1421,'I doubt you have had much occasion to see such a creature. These demonic equines will make your travels much faster by acting as your mount as long as you control them. However, they are difficult to control, so be sure you are ready before attempting it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1420,'When facing a spellcaster of any kind, this feral beast will be your best friend. Now, let us take a look at something a bit different. This next creature will aid your travels and make your future journeys much easier. Let\'s take a look at a felsteed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1419,'What you see before you is a felhunter. This creature\'s natural talents include spell lock and other abilities which make it unequalled when facing a magically attuned opponent.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1418,'Study hard and you might one day be able to summon one on your own, but for now it\'s time to move on to the felhunter.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1417,'All right now. Aside from the obvious distractions a minion like this will provide against your more masculine foes, she is also capable of dealing out impressive amounts of damage. However, her fragile endurance makes her almost useless as a shield.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1416,'If you\'ve never seen one, it is a sight to behold. A very impressive creature both on and off the field of battle. Next, let us take a look at what I am sure all you male students have been waiting for. The succubus.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1415,'This demonic entity is known as the Voidwalker. Its strength and endurance are significant, making it ideal for defense. Send it to attack your enemy, then use it as a shield while you use your spells and abilities to drain away your opponent\'s life.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1414,'Now that you have had a chance to study imp, let us move on the next minion you will be able to summon, the voidwalker.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1413,'This foul little beast is the imp. It is small and weak, making it almost useless as a meatshield, and its damage output is mediocre at best. This creature is best used for support of a larger group.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1412,'The easiest creature for you to summon is the imp. You should already be able to bring forth this minion but for completeness\' sake I will start with him.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702'),
(-1411,'If you\'re here, then it means you are prepared to begin the study of summoning demonic cohorts to do your bidding. We will start with the lowliest creatures you will be able to call and continue from there. Let us begin.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,33,0,'5702');

DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 5702;
INSERT INTO `creature_ai_scripts` VALUES
(570201,5702,4,0,100,0,0,0,0,0,12,7980,1,300000,0,0,0,0,0,0,0,0,'Jezelle Pruitt - Summon Deathguard Elite on Aggro'),
(570202,5702,1,0,100,1,0,0,300000,300000,1,-1411,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Event start Say Line'),
(570203,5702,1,0,100,1,10000,10000,300000,300000,1,-1412,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Imp Say Line 1'),
(570204,5702,1,0,100,1,18000,18000,300000,300000,32,5730,0,22,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Summon Jezelle\'s Imp'),
(570205,5702,1,0,100,1,20000,20000,300000,300000,1,-1413,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Imp Say Line 2'),
(570206,5702,1,0,100,1,50000,50000,300000,300000,1,-1414,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Voidwalker Say Line 1'),
(570207,5702,1,0,100,1,58000,58000,300000,300000,32,5729,0,22,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Summon Jezelle\'s Voidwalker'),
(570208,5702,1,0,100,1,60000,60000,300000,300000,1,-1415,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Voidwalker Say Line 2'),
(570209,5702,1,0,100,1,90000,90000,300000,300000,1,-1416,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Succubus Say Line 1'),
(570210,5702,1,0,100,1,98000,98000,300000,300000,32,5728,0,22,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Summon Jezelle\'s Succubus'),
(570211,5702,1,0,100,1,100000,100000,300000,300000,1,-1417,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Succubus Say Line 2'),
(570212,5702,1,0,100,1,130000,130000,300000,300000,1,-1418,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Felhunter Say Line 1'),
(570213,5702,1,0,100,1,138000,138000,300000,300000,32,5726,0,22,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Summon Jezelle\'s Felhunter'),
(570214,5702,1,0,100,1,140000,140000,300000,300000,1,-1419,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Felhunter Say Line 2'),
(570215,5702,1,0,100,1,170000,170000,300000,300000,1,-1420,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Felsteed Say Line 1'),
(570216,5702,1,0,100,1,178000,178000,300000,300000,32,5727,0,22,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Summon Jezelle\'s Felsteed'),
(570217,5702,1,0,100,1,180000,180000,300000,300000,1,-1421,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Felsteed Say Line 2'),
(570218,5702,1,0,100,1,210000,210000,300000,300000,1,-1422,0,0,0,0,0,0,0,0,0,0,'Jezelle Pruitt - OOC - Event end Say Line');


SET @CROMWELL := '14402'; -- Seeker Cromwell

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@CROMWELL);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='1583.506', `position_y`='256.2311', `position_z`='-62.11309', `orientation`='0', `MovementType`='2' WHERE `id`=@CROMWELL;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@CROMWELL;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@CROMWELL, (@POINT := @POINT + 1), '1583.506', '256.2311', '-62.11309', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1581.180', '256.7343', '-61.90614', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1565.844', '270.0585', '-60.69878', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1554.069', '279.5327', '-60.77398', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1550.043', '280.6547', '-60.79443', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1545.798', '278.7816', '-62.18080', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1521.743', '246.2183', '-62.17794', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1463.974', '233.8326', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1462.324', '230.5938', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1461.742', '216.1824', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1464.133', '199.7708', '-62.17709', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1467.824', '183.4344', '-62.18254', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1472.803', '173.5824', '-57.15204', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1472.375', '170.3603', '-57.01591', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1460.744', '164.0948', '-51.05494', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1445.551', '153.7872', '-57.15263', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1444.820', '150.5520', '-57.15324', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1449.093', '141.9922', '-62.27794', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1447.065', '138.7384', '-62.30164', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1425.409', '134.6217', '-62.29261', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1423.454', '133.4190', '-62.29228', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1422.167', '131.2488', '-62.29167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1412.971', '94.48728', '-62.28593', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1412.178', '68.96647', '-62.27882', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1410.143', '66.97049', '-62.27882', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1405.900', '66.30279', '-62.27882', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1391.262', '67.51823', '-62.27888', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1387.450', '65.16596', '-62.27829', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1379.324', '50.87375', '-62.27672', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1379.427', '48.54769', '-62.27669', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1408.113', '26.90218', '-62.27708', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1409.994', '26.57997', '-62.27705', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1412.155', '26.69325', '-62.27715', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1434.355', '33.64345', '-62.27644', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1438.174', '36.53374', '-62.27723', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1439.616', '38.71452', '-62.27779', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1446.229', '64.73573', '-62.28231', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1445.816', '67.92562', '-62.28153', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1444.844', '70.15820', '-62.28072', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1418.580', '101.1985', '-62.28775', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1404.943', '119.9008', '-62.29526', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1403.924', '122.0021', '-62.29600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1403.861', '125.2423', '-62.27325', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1405.325', '127.1650', '-62.26875', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1426.191', '154.1230', '-62.28469', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1427.121', '155.6431', '-62.28401', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1431.452', '165.7858', '-62.27488', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1434.476', '167.2110', '-62.26622', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1442.106', '155.5110', '-57.15324', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1443.467', '154.7457', '-57.15303', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1458.042', '161.8466', '-50.94152', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1473.620', '171.0510', '-57.15204', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1473.786', '174.2765', '-57.15204', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1469.005', '183.0757', '-62.18350', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1469.258', '185.4509', '-62.18411', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1472.276', '187.6451', '-62.18668', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1477.591', '188.1393', '-62.19527', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1480.276', '187.1101', '-62.19846', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1481.359', '185.9169', '-62.19843', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1486.357', '184.4406', '-62.18407', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1489.255', '187.5985', '-62.17602', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1490.054', '195.6768', '-62.16550', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1490.643', '198.2233', '-62.16230', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1491.724', '199.4280', '-62.15359', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1506.335', '175.3599', '-62.15884', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1518.162', '159.0233', '-62.16648', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1541.176', '141.8635', '-62.16800', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1542.285', '139.7458', '-62.16848', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1541.043', '137.0827', '-62.16963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1535.092', '126.9977', '-61.52202', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1536.230', '123.4622', '-61.50837', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1544.681', '113.2477', '-62.14553', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1547.049', '111.8176', '-62.14442', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1581.209', '104.5857', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1583.091', '105.6061', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1593.626', '126.2137', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1594.315', '130.5811', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1594.488', '165.4759', '-62.17780', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1591.848', '169.0581', '-62.17778', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1559.896', '187.3829', '-62.18196', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1557.058', '191.5276', '-62.18295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1555.870', '199.8094', '-60.77612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1556.872', '201.8134', '-60.77697', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1565.772', '211.0227', '-60.69686', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1579.981', '224.1431', '-61.90995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1582.291', '224.2461', '-61.91358', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1584.610', '223.5555', '-62.09014', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1592.897', '220.5184', '-57.16179', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1594.658', '221.1280', '-57.16177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1595.533', '230.7600', '-52.15380', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1593.387', '232.0359', '-52.15043', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1588.193', '232.2730', '-52.14523', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1586.658', '233.8912', '-52.14595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1586.203', '245.9066', '-52.15466', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1589.372', '248.5877', '-52.15392', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1601.850', '248.9071', '-52.14719', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1604.069', '246.4827', '-52.15307', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1606.339', '242.3287', '-52.15508', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1607.957', '240.8379', '-52.15958', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1629.973', '239.2152', '-43.10269', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1632.032', '236.4269', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1629.101', '223.9509', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1612.131', '206.9309', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1609.539', '205.5861', '-43.10269', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1597.743', '203.6275', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1594.194', '203.8103', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1582.785', '205.5456', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1578.919', '207.3404', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1562.383', '223.9282', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1560.665', '227.6953', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1559.218', '236.0390', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1561.987', '239.8349', '-43.17978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1567.898', '240.1943', '-44.16556', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1583.315', '240.6951', '-52.15242', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1584.639', '242.7373', '-52.15159', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1585.509', '247.5295', '-52.15097', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1587.016', '248.8708', '-52.14977', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1594.048', '249.3781', '-52.15096', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1595.588', '250.3003', '-52.15757', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1596.237', '258.3997', '-57.16174', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CROMWELL, (@POINT := @POINT + 1), '1595.332', '259.6997', '-57.16173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @NAHR := '14403'; -- Seeker Nahr

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@NAHR);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='1609.246', `position_y`='223.4584', `position_z`='-61.90340', `orientation`='0', `MovementType`='2' WHERE `id`=@NAHR;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@NAHR;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@NAHR, (@POINT := @POINT + 1), '1609.246', '223.4584', '-61.90340', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1625.298', '210.0929', '-60.70000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1639.942', '197.8281', '-60.76619', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1647.450', '200.8475', '-62.18166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1667.022', '234.6901', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1675.597', '239.0004', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1723.016', '239.1160', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1727.486', '241.2093', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1729.365', '267.5403', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1723.585', '290.4409', '-62.18439', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1720.117', '305.2959', '-61.47770', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1718.494', '309.0411', '-61.47762', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1706.621', '324.0278', '-55.39243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1707.659', '325.9294', '-55.39243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1720.192', '335.4403', '-49.14030', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1734.865', '346.2286', '-55.39350', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1737.210', '345.4460', '-55.39387', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1744.150', '336.7069', '-60.48446', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1745.905', '336.5825', '-60.48446', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1773.952', '346.5651', '-62.29193', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1786.241', '357.1428', '-61.96062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1792.518', '369.8833', '-60.15905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1792.492', '374.1188', '-60.15905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1787.537', '394.8491', '-57.21455', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1789.015', '398.8071', '-57.21456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1788.912', '404.6029', '-57.21456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1783.725', '410.2480', '-57.19440', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1776.076', '418.3867', '-58.03100', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1761.857', '432.2151', '-57.21456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1758.747', '431.9061', '-57.21456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1754.990', '427.7975', '-57.20795', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1752.367', '415.7229', '-57.21456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1755.393', '404.2359', '-57.21456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1761.858', '397.9333', '-57.21456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1775.760', '395.2629', '-57.21456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1783.611', '394.9522', '-57.21456', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1785.320', '393.8276', '-57.21371', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1794.375', '372.6804', '-60.15905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1779.703', '349.0509', '-62.32327', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1757.668', '332.6843', '-62.24566', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1755.163', '332.6872', '-62.30822', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1744.679', '335.3011', '-60.48443', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1736.581', '344.3666', '-55.39356', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1734.488', '344.8608', '-55.39321', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1720.657', '334.8886', '-49.13746', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1708.503', '323.9943', '-55.39243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1714.446', '313.4740', '-60.48489', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1714.439', '311.7840', '-60.48473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1704.675', '296.5861', '-62.17630', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1703.603', '293.7160', '-62.16811', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1703.467', '283.3416', '-62.15668', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1702.132', '279.9407', '-62.15506', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1698.638', '280.8020', '-62.14895', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1697.217', '284.9091', '-62.14731', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1701.107', '293.6302', '-62.16217', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1700.357', '296.7271', '-62.16661', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1690.123', '309.3857', '-62.16819', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1668.720', '328.7574', '-62.16398', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1640.502', '340.7791', '-62.17167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1636.327', '344.5663', '-62.17696', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1637.511', '347.0346', '-62.17834', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1642.676', '346.8737', '-62.17167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1649.723', '344.3992', '-62.17167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1653.708', '346.0358', '-62.17167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1658.568', '355.8368', '-60.74331', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1656.858', '359.7296', '-60.74574', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1638.040', '370.0992', '-62.16920', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1611.813', '375.1517', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1572.169', '374.0063', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1551.991', '369.2471', '-62.18160', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1544.057', '358.6568', '-62.19004', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1538.388', '348.9066', '-62.17683', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1539.908', '346.4219', '-62.17252', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1552.080', '348.6122', '-62.15915', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1557.466', '348.2967', '-62.15563', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1557.966', '345.0330', '-62.14893', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1551.411', '341.4445', '-62.14052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1533.871', '335.0199', '-62.16702', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1510.630', '312.5807', '-62.14772', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1498.700', '297.3567', '-62.17569', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1493.616', '284.4332', '-62.17167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1490.810', '281.0601', '-62.17270', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1488.552', '281.7254', '-62.16355', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1490.047', '297.7319', '-62.18245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1486.550', '310.1917', '-61.49476', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1488.010', '319.7120', '-60.78606', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1500.952', '335.1210', '-60.09231', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1513.509', '345.5368', '-60.09122', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1534.205', '356.9025', '-61.49840', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1554.556', '368.3122', '-62.18196', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1571.416', '375.1871', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1585.837', '377.7647', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1592.033', '370.8737', '-62.19471', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1597.092', '347.0850', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1596.720', '319.1431', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1599.777', '311.6949', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1630.804', '295.7702', '-62.17669', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1636.080', '284.0114', '-60.76847', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1633.370', '278.8240', '-60.77655', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1611.436', '256.5937', '-61.91060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1608.648', '256.3188', '-62.09599', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1598.780', '259.9653', '-57.16174', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1596.853', '259.1426', '-57.16173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1595.788', '257.0236', '-56.97906', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1595.788', '257.0236', '-56.97906', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1595.769', '249.5131', '-52.15284', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1597.261', '248.5666', '-52.15006', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1603.438', '249.1752', '-52.14738', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1605.078', '247.3450', '-52.15388', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1606.015', '242.4335', '-52.15417', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1607.030', '240.7188', '-52.15702', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1630.534', '240.4442', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1632.885', '243.0049', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1632.595', '249.7670', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1631.348', '254.0865', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1612.677', '274.2907', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1606.971', '276.3227', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1586.306', '276.4096', '-43.10275', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1580.767', '274.9485', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1563.419', '257.5845', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1560.005', '251.9638', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1558.889', '241.3186', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1559.384', '231.3293', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1561.175', '225.6089', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1578.664', '206.9777', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1585.731', '204.5607', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1605.467', '204.0483', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1611.460', '206.0352', '-43.10267', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1629.382', '223.7811', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1633.148', '233.4342', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1630.568', '236.9336', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1607.126', '238.8718', '-52.15732', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1605.703', '237.4906', '-52.14565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1603.532', '232.5689', '-52.14555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1596.857', '231.5195', '-52.15187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1596.119', '220.6832', '-57.16177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1598.207', '220.2113', '-57.16177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@NAHR, (@POINT := @POINT + 1), '1606.565', '223.6164', '-62.11158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @THOMPSON := '14404'; -- Seeker Thompson

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@THOMPSON);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='1617.092', `position_y`='218.6870', `position_z`='-59.24665', `orientation`='0', `MovementType`='2' WHERE `id`=@THOMPSON;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@THOMPSON;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@THOMPSON, (@POINT := @POINT + 1), '1617.092', '218.6870', '-59.24665', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1631.553', '204.2361', '-60.77610', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1640.147', '200.0196', '-60.76785', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1655.092', '207.0599', '-62.18034', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1668.467', '234.7804', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1680.321', '239.2071', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1723.507', '240.4131', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1730.388', '230.8118', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1728.824', '211.1376', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1724.623', '196.0272', '-62.16262', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1718.686', '184.9052', '-60.75858', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1709.365', '179.0808', '-60.73051', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1701.335', '182.7318', '-62.17167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1702.611', '194.2011', '-62.17167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1698.507', '195.9570', '-62.17167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1692.651', '187.9991', '-62.17167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1679.004', '162.3927', '-62.16040', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1649.448', '142.4823', '-62.14766', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1637.988', '136.5618', '-62.14884', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1639.086', '132.6971', '-62.15970', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1650.699', '134.7776', '-62.16821', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1667.648', '127.9414', '-61.48686', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1682.416', '130.8727', '-60.42862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1690.934', '138.4989', '-55.21449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1693.519', '138.6567', '-55.21449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1704.904', '128.4098', '-49.00900', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1716.952', '114.9741', '-55.21538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1717.120', '112.6673', '-55.21583', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1709.333', '104.5370', '-60.18544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1696.452', '91.29698', '-62.25266', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1695.932', '86.82401', '-62.26040', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1702.338', '70.93913', '-62.29219', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1709.622', '68.14681', '-62.28824', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1738.570', '59.20063', '-59.57227', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1749.862', '49.09429', '-52.81699', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1753.905', '47.71148', '-52.81699', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1766.786', '58.51758', '-46.32100', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1778.527', '70.24653', '-46.31701', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1786.401', '78.94379', '-52.81701', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1786.197', '83.47396', '-52.81700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1772.827', '97.08453', '-60.60150', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1770.960', '104.3613', '-62.27382', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1756.442', '136.9941', '-62.24012', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1750.686', '140.2855', '-62.19185', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1742.041', '136.3015', '-62.15237', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1729.465', '125.0361', '-60.20997', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1720.631', '116.7737', '-55.21572', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1718.348', '117.2919', '-55.21521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1705.410', '129.5553', '-49.04820', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1694.899', '140.4262', '-55.21449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1695.190', '142.7930', '-55.21449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1702.094', '150.2608', '-60.46858', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1702.372', '152.2507', '-60.45893', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1700.790', '156.0513', '-60.44802', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1712.581', '176.1745', '-60.75194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1724.331', '198.7045', '-62.16481', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1730.761', '214.7860', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1732.083', '228.0609', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1720.836', '236.7267', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1675.712', '241.5041', '-62.17767', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1666.813', '247.8042', '-62.17799', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1665.397', '249.8512', '-62.17779', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1658.122', '270.6968', '-62.17942', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1655.739', '273.1317', '-62.17991', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1640.921', '281.1269', '-60.76676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1637.546', '279.3629', '-60.77007', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1620.187', '263.8601', '-58.94020', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1610.994', '255.7129', '-61.90981', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1607.457', '253.6334', '-62.09164', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1596.368', '252.8378', '-62.09750', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1584.992', '252.5535', '-62.11018', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1583.530', '251.0041', '-62.10363', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1584.345', '225.8762', '-62.08577', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1585.527', '222.9704', '-62.14028', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1593.445', '221.0577', '-57.16179', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1594.703', '230.4956', '-52.15519', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1589.602', '231.8067', '-52.14540', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1586.992', '233.7449', '-52.14578', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1586.876', '246.4900', '-52.15490', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1587.663', '247.9331', '-52.15309', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1590.811', '248.5337', '-52.15467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1602.723', '248.4079', '-52.14769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1605.242', '245.4582', '-52.15356', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1606.502', '241.8904', '-52.15553', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1607.699', '240.1945', '-52.15888', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1630.692', '241.3403', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1632.833', '242.5227', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1632.958', '245.9545', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1631.514', '254.8911', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1613.102', '273.4337', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1605.617', '276.5178', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1586.844', '276.6540', '-43.10275', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1578.671', '274.2467', '-43.10270', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1562.308', '257.0070', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1558.667', '246.7306', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1559.340', '229.6207', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1562.744', '222.9461', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1578.147', '207.4494', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1586.199', '204.7502', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1604.896', '204.7057', '-43.10272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1611.628', '206.9705', '-43.10268', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1628.336', '223.2480', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1631.788', '229.7821', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1632.781', '236.3841', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1630.619', '237.2160', '-43.10271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1607.801', '239.1756', '-52.15918', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1606.174', '237.9438', '-52.15471', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1604.563', '233.8241', '-52.14586', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1602.063', '231.8929', '-52.15122', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1596.986', '231.8843', '-52.15088', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1596.206', '221.5799', '-57.16178', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1606.623', '223.4710', '-62.11187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THOMPSON, (@POINT := @POINT + 1), '1609.261', '223.3245', '-61.90321', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

-- fix stranglethorn fever
UPDATE `quest_template` SET `RewMoneyMaxLevel`='0' WHERE `entry`='349';


SET @STONEHAMMER := '5637'; -- Roetten Stonehammer

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@STONEHAMMER);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4681.394', `position_y`='-1266.606', `position_z`='503.4648', `orientation`='1.963985', `MovementType`='2' WHERE `id`=@STONEHAMMER;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@STONEHAMMER;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@STONEHAMMER, (@POINT := @POINT + 1), '-4686.149', '-1255.140', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4675.921', '-1244.380', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4667.503', '-1245.781', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4661.595', '-1250.517', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4661.595', '-1250.517', '503.3816', '60000', '0', '0', '0', '0', '0', '0', '0', '0',  '2.356194', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4670.109', '-1243.077', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4681.147', '-1244.796', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4686.531', '-1252.014', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4685.416', '-1262.677', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4681.394', '-1266.606', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@STONEHAMMER, (@POINT := @POINT + 1), '-4681.394', '-1266.606', '503.3816', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '1.605703', '0', '0');


SET @THORIUS := '8256'; -- Curator Thorius

SET @TEXT := '2000005348';

DELETE FROM `db_script_string` WHERE `entry`='2000005000'; -- ClassicDB, old string

-- -------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@THORIUS);
SET @NAME := (SELECT `name` FROM `creature_template` WHERE `entry`=@THORIUS);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4652.276', `position_y`='-1278.877', `position_z`='503.4648', `orientation`='0.7819276', `MovementType`='2' WHERE `id`=@THORIUS;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@THORIUS;
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` BETWEEN (CONCAT(@GUID, '01')) AND (CONCAT(@GUID, '03'));
DELETE FROM `db_script_string` WHERE `entry` BETWEEN (@TEXT + 00) AND (@TEXT + 2);

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@THORIUS, (@POINT := @POINT + 1), '-4646.738', '-1273.377', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4643.056', '-1269.847', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4638.852', '-1265.486', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4633.741', '-1261.104', '503.3824', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4629.312', '-1256.385', '503.3824', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4623.375', '-1256.475', '503.3830', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4622.471', '-1258.746', '503.3833', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4622.471', '-1258.746', '503.3833', '4500', (CONCAT(@GUID, '01')), '0', '0', '0', '0', '0', '0', '0', '4.066617', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4615.686', '-1255.442', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0',  '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4608.177', '-1249.271', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0',  '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4603.862', '-1251.563', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0',  '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4603.862', '-1251.563', '503.3816', '4500', (CONCAT(@GUID, '02')), '0', '0', '0', '0', '0', '0', '0', '0.3316126', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4598.436', '-1240.892', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4592.448', '-1232.214', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4588.735', '-1222.179', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4588.735', '-1222.179', '503.3816', '4500', (CONCAT(@GUID, '03')), '0', '0', '0', '0', '0', '0', '0', '5.742133', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4593.644', '-1214.160', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4598.711', '-1219.354', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4604.790', '-1227.240', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4610.729', '-1236.657', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4613.158', '-1252.017', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4618.215', '-1264.094', '503.3841', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4633.393', '-1276.797', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4652.419', '-1285.877', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4667.360', '-1293.999', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4678.205', '-1296.404', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4689.225', '-1301.691', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4699.487', '-1307.610', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4709.615', '-1317.365', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4711.283', '-1322.386', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4711.283', '-1322.386', '503.3816', '3000', '0', '0', '0', '0', '0', '0', '0',  '0', '3.577925', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4702.810', '-1325.272', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4696.292', '-1325.815', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4689.635', '-1325.204', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4686.068', '-1319.191', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4683.053', '-1314.015', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4675.000', '-1312.604', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4664.885', '-1306.134', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4662.038', '-1298.117', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4659.426', '-1288.833', '503.3816', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THORIUS, (@POINT := @POINT + 1), '-4654.313', '-1281.536', '503.3816', '75000', '0', '0', '0', '0', '0', '0', '0',  '0', '0.959392', '0', '0');

INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
((CONCAT(@GUID, '01')), '2', '0', '0', '0', '0', '0', '0', (@TEXT + 00), '0', '0', '0', '0', '0', '0', '0', (CONCAT(@NAME, ' - Say 1'))),
((CONCAT(@GUID, '02')), '2', '1', '69', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', (CONCAT(@NAME, ' - Emote 1'))),
((CONCAT(@GUID, '02')), '2', '0', '0', '0', '0', '0', '0', (@TEXT + 01), '0', '0', '0', '0', '0', '0', '0', (CONCAT(@NAME, ' - Say 2'))),
((CONCAT(@GUID, '02')), '4.5', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', (CONCAT(@NAME, ' - Emote 1 (Stop)'))),
((CONCAT(@GUID, '03')), '2', '0', '0', '0', '0', '0', '0', (@TEXT + 02), '0', '0', '0', '0', '0', '0', '0', (CONCAT(@NAME, ' - Say 3')));

INSERT INTO `db_script_string` (`entry`, `content_default`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
((@TEXT + 00), '%s dusts the base of the artifact.', '0', '2', '0', '16', (CONCAT(@NAME, ' - Say 1'))),
((@TEXT + 01), '%s meticulously examines the large vase.', '0', '2', '0', '0', (CONCAT(@NAME, ' - Say 2'))),
((@TEXT + 02), 'Poor Dorius. If I ever get my hands on those Dark Irons, so help me...', '2929', '0', '0', '36', (CONCAT(@NAME, ' - Say 3')));


SET @ROHAN := '11406'; -- High Priest Rohan

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@ROHAN);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4612.268', `position_y`='-909.0977', `position_z`='501.1455', `orientation`='4.328416', `MovementType`='2' WHERE `id`=@ROHAN;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@ROHAN;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@ROHAN, (@POINT := @POINT + 1), '-4612.254', '-909.1521', '501.0622', '90000', '0', '0', '0', '0', '0', '0', '0', '0', '4.328416', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4603.221', '-905.3360', '502.7668', '0', '0', '0', '0', '0', '0', '0', '0', '0',  '0', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4602.796', '-903.2332', '502.7668', '0', '0', '0', '0', '0', '0', '0', '0', '0',  '0', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4607.162', '-897.2797', '502.7668', '0', '0', '0', '0', '0', '0', '0', '0', '0',  '0', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4607.162', '-897.2797', '502.7668', '90000', '0', '0', '0', '0', '0', '0', '0',  '0', '5.358161', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4601.626', '-904.6155', '502.7668', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4602.049', '-906.3550', '502.7668', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4608.619', '-913.5076', '501.0607', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4610.180', '-921.8517', '501.0684', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4607.634', '-926.9007', '501.0711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4607.634', '-926.9007', '501.0711', '180000', '0', '0', '0', '0', '0', '0', '0', '0', '2.338741', '0', '0'),
(@ROHAN, (@POINT := @POINT + 1), '-4612.254', '-909.1521', '501.0622', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');



SET @LONGBERRY := '7978'; -- Bimble Longberry

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@LONGBERRY);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4715.607', `position_y`='-925.8232', `position_z`='501.7426', `orientation`='1.179421', `MovementType`='2' WHERE `id`=@LONGBERRY;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@LONGBERRY;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@LONGBERRY, (@POINT := @POINT + 1), '-4707.845', '-907.0120', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4688.098', '-902.9882', '501.6476', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4671.588', '-914.5618', '501.6541', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4655.948', '-931.1495', '501.6580', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4636.642', '-954.9941', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4621.530', '-981.5043', '501.6564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4617.623', '-1000.404', '501.6645', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4626.838', '-1012.120', '501.6519', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4641.676', '-1014.932', '501.6477', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4657.655', '-997.7007', '501.6358', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4667.463', '-983.3502', '501.6441', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4681.746', '-969.3637', '501.6945', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4689.473', '-949.4840', '501.6629', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4699.370', '-937.9786', '501.6703', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@LONGBERRY, (@POINT := @POINT + 1), '-4711.072', '-923.4749', '501.6572', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @TURNER := '6175'; -- John Turner

SET @TEXT := '2000000349';

-- -------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@TURNER);
SET @NAME := (SELECT `name` FROM `creature_template` WHERE `entry`=@TURNER);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4895.609', `position_y`='-898.0984', `position_z`='501.7426', `orientation`='2.286381', `MovementType`='2' WHERE `id`=@TURNER;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@TURNER;
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` BETWEEN (CONCAT(@GUID, '01')) AND (CONCAT(@GUID, '03'));
DELETE FROM `db_script_string` WHERE `entry` BETWEEN (@TEXT + 00) AND (@TEXT + 03);

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@TURNER, (@POINT := @POINT + 1), '-4895.609', '-898.0984', '501.6593', '4000', (CONCAT(@GUID, '01')), '0', '0', '0', '0', '0', '0', '0', '2.286381', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4859.858', '-887.9218', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4842.476', '-885.5647', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4842.476', '-885.5647', '501.6594', '0000', (CONCAT(@GUID, '01')), '0', '0', '0', '0', '0', '0', '0', '1.884956', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4875.518', '-889.0638', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4895.693', '-897.8222', '501.6593', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4895.693', '-897.8222', '501.6593', '4000', (CONCAT(@GUID, '01')), '0', '0', '0', '0', '0', '0', '0', '2.251475', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4927.132', '-915.4280', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4951.839', '-934.9794', '501.6593', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4981.382', '-966.5792', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4983.741', '-969.7697', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4983.741', '-969.7697', '501.6595', '4000', (CONCAT(@GUID, '01')), '0', '0', '0', '0', '0', '0', '0', '2.443461', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-5002.574', '-1008.675', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-5007.885', '-1022.321', '501.6549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-5012.979', '-1052.933', '501.7099', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-5012.979', '-1052.933', '501.7099', '4000', (CONCAT(@GUID, '01')), '0', '0', '0', '0', '0', '0', '0', '2.967060', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-5006.932', '-1021.700', '501.6555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4992.735', '-985.8944', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4981.066', '-962.5291', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4944.819', '-930.4164', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4906.594', '-901.6618', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@TURNER, (@POINT := @POINT + 1), '-4895.609', '-898.0984', '501.6593', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

INSERT INTO `dbscripts_on_creature_movement` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
((CONCAT(@GUID, '01')), '0', '0', '0', '0', '0', '0', '0', (@TEXT + 00), (@TEXT + 01), (@TEXT + 02), (@TEXT + 03), '0', '0', '0', '0', (CONCAT(@NAME, ' - Say 1, 2, 3 or 4')));

INSERT INTO `db_script_string` (`entry`, `content_default`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
((@TEXT + 00), 'Give to the charities who seek to help the victims of these hard times! Please.', '0', '0', '0', '0', (CONCAT(@NAME, ' - Say 1'))),
((@TEXT + 01), 'Don\'t forget the orphans of Stormwind!', '0', '0', '0', '0', (CONCAT(@NAME, ' - Say 2'))),
((@TEXT + 02), 'Give of your hearts and your purses! Give to the children of Stormwind who have lost their parents.', '0', '0', '0', '0', (CONCAT(@NAME, ' - Say 3'))),
((@TEXT + 03), 'Help the children of Stormwind... victims of the war and plague!', '0', '0', '0', '0', (CONCAT(@NAME, ' - Say 4')));


SET @FROSTBEARD := '1692'; -- Golorn Frostbeard

-- -------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@FROSTBEARD);
SET @NAME := (SELECT `name` FROM `creature_template` WHERE `entry`=@FROSTBEARD);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-5633.440', `position_y`='-496.4770', `position_z`='396.8753', `orientation`='2.539195', `MovementType`='2' WHERE `id`=@FROSTBEARD;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@FROSTBEARD;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@FROSTBEARD, (@POINT := @POINT + 1), '-5636.061', '-495.8329', '396.7780', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FROSTBEARD, (@POINT := @POINT + 1), '-5641.399', '-498.8961', '396.7780', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FROSTBEARD, (@POINT := @POINT + 1), '-5640.832', '-501.3918', '396.7937', '20000', '0', '0', '0', '0', '0', '0', '0', '0', '4.936115', '0', '0'),
(@FROSTBEARD, (@POINT := @POINT + 1), '-5641.399', '-498.8961', '396.7780', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FROSTBEARD, (@POINT := @POINT + 1), '-5640.068', '-496.7379', '396.7780', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FROSTBEARD, (@POINT := @POINT + 1), '-5636.061', '-495.8329', '396.7780', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FROSTBEARD, (@POINT := @POINT + 1), '-5633.440', '-496.4770', '396.7780', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FROSTBEARD, (@POINT := @POINT + 1), '-5633.440', '-496.4770', '396.7780', '30000', '0', '0', '0', '0', '0', '0', '0', '0', '2.199115', '0', '0');


SET @GUID := '57'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4992.175', `position_y`='-1155.4130', `position_z`='501.7427', `orientation`='3.96066', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-5007.487', '-1171.793', '501.6597', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5008.707', '-1185.934', '501.6618', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4998.198', '-1206.620', '501.6775', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4984.833', '-1224.770', '501.6792', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4963.304', '-1244.974', '501.6728', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4941.089', '-1251.620', '501.6482', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4927.949', '-1242.192', '501.6396', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4928.527', '-1229.495', '501.6493', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4943.524', '-1216.123', '501.6482', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4952.011', '-1195.801', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4965.607', '-1189.141', '501.6592', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4981.276', '-1171.385', '501.6539', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4992.600', '-1155.349', '501.6561', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @CLIFFBEARD := '5124'; -- Sognar Cliffbeard

-- -------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@CLIFFBEARD);
SET @NAME := (SELECT `name` FROM `creature_template` WHERE `entry`=@CLIFFBEARD);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-5002.887', `position_y`='-1160.7340', `position_z`='501.7427', `orientation`='3.433445', `MovementType`='2' WHERE `id`=@CLIFFBEARD;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@CLIFFBEARD;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@CLIFFBEARD, (@POINT := @POINT + 1), '-5014.963', '-1164.3620', '501.6634', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-5017.406', '-1177.7400', '501.6543', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-5006.694', '-1195.8610', '501.6673', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4991.032', '-1215.0220', '501.6773', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4976.490', '-1233.4380', '501.6785', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4963.135', '-1249.5380', '501.6708', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4950.890', '-1261.2130', '501.6667', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4932.905', '-1258.3310', '501.6477', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4925.248', '-1245.3570', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4926.883', '-1234.4750', '501.6547', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4941.878', '-1220.3930', '501.6520', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4947.642', '-1205.3560', '501.6685', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4957.721', '-1193.1830', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4974.970', '-1183.9740', '501.6564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-4983.421', '-1169.0440', '501.6555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@CLIFFBEARD, (@POINT := @POINT + 1), '-5002.725', '-1160.7740', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @GUID := '97'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4883.044', `position_y`='-1115.5980', `position_z`='502.2956', `orientation`='3.167327', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4894.075', '-1115.8820', '501.7928', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4906.619', '-1118.9820', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4917.980', '-1125.1810', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4921.549', '-1132.5180', '501.6068', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4923.342', '-1144.4310', '501.4421', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4928.308', '-1159.0010', '501.4994', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4932.610', '-1173.3460', '501.6097', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4938.115', '-1183.5250', '501.7061', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4948.813', '-1191.5090', '501.6595', '30000', '0', '0', '0', '0', '0', '0', '0', '0', '3.78266300', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4938.763', '-1183.0540', '501.7118', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4932.521', '-1170.7710', '501.5935', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4928.323', '-1153.0580', '501.4631', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4925.346', '-1140.7550', '501.3722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4922.706', '-1131.4410', '501.6305', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4913.503', '-1121.0990', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4900.859', '-1117.3100', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4883.246', '-1115.6400', '502.1969', '30000', '0', '0', '0', '0', '0', '0', '0', '0', '0.09456634', '0', '0');


SET @GUID := '1889'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4721.123', `position_y`='-1265.5990', `position_z`='501.7427', `orientation`='0.7560951', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4708.459', '-1253.6560', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4698.779', '-1235.5510', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4685.847', '-1223.8760', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4669.440', '-1218.9460', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4655.979', '-1205.6970', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4667.163', '-1192.6480', '501.6588', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4679.893', '-1193.8490', '501.6585', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4695.925', '-1199.8700', '501.6584', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4712.359', '-1205.4420', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4720.557', '-1213.5260', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4733.086', '-1230.5010', '501.6559', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4738.724', '-1248.3250', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4732.381', '-1261.1520', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4721.185', '-1265.5250', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @GUID := '121'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4986.547', `position_y`='-963.8156', `position_z`='501.7427', `orientation`='5.707227', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4986.600', '-963.4806', '501.6595', '15000', '0', '0', '0', '0', '0', '0', '0', '0', '5.637167', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4997.777', '-956.2134', '501.6609', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5011.686', '-939.2016', '501.6596', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5011.280', '-923.0540', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4982.625', '-898.7230', '501.6041', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4979.974', '-889.4788', '501.6265', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4979.974', '-889.4788', '501.6265', '15000', '0', '0', '0', '0', '0', '0', '0', '0', '2.303835', '0', '0'), 
(@GUID, (@POINT := @POINT + 1), '-4981.966', '-898.9245', '501.6014', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5007.113', '-919.8450', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5013.242', '-937.7985', '501.6597', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5000.367', '-953.1014', '501.6611', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @GUID := '134'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4902.161', `position_y`='-895.6193', `position_z`='501.7426', `orientation`='5.235988', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4902.170', '-895.5770', '501.6594', '15000', '0', '0', '0', '0', '0', '0', '0', '0', '5.122505', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4908.303', '-879.5649', '501.6605', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4921.320', '-862.3778', '501.6606', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4932.795', '-858.5505', '501.6626', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4963.470', '-883.8062', '501.6003', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4973.356', '-884.4930', '501.6224', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4973.356', '-884.4930', '501.6224', '15000', '0', '0', '0', '0', '0', '0', '0', '0', '2.199115', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4964.546', '-881.7691', '501.6193', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4940.618', '-860.9469', '501.6613', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4923.315', '-864.1235', '501.6606', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4908.667', '-880.6354', '501.6605', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @GUID := '1748'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4958.850', `position_y`='-997.5289', `position_z`='501.5721', `orientation`='0.9778681', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4942.368', '-973.0673', '501.5523', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4922.720', '-954.7523', '501.5698', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4896.282', '-936.7808', '501.4918', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4872.001', '-926.0280', '501.5149', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4872.001', '-926.0280', '501.5149', '45000', '0', '0', '0', '0', '0', '0', '0', '0', '3.5953780', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4905.076', '-941.8298', '501.5605', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4929.299', '-961.5024', '501.5698', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4958.948', '-997.8889', '501.4812', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4958.948', '-997.8889', '501.4812', '45000', '0', '0', '0', '0', '0', '0', '0', '0', '0.9773844', '0', '0');


SET @DORANA := '869'; -- Protector Dorana

-- -------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@DORANA);
SET @NAME := (SELECT `name` FROM `creature_template` WHERE `entry`=@DORANA);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-10657.14', `position_y`='1010.878', `position_z`='32.55214', `orientation`='0.3832296', `MovementType`='2' WHERE `id`=@DORANA;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@DORANA;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@DORANA, (@POINT := @POINT + 1), '-10642.80', '1016.665', '31.565100', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10620.20', '1000.852', '32.994370', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10593.99', '987.9368', '36.877070', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10564.63', '975.7330', '40.634450', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10532.88', '961.9837', '40.885220', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10500.21', '952.6395', '39.459800', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10466.91', '953.8127', '35.898200', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10433.16', '981.9645', '34.757520', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10410.51', '994.7161', '32.164260', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10400.42', '992.5428', '31.579060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10386.81', '984.0738', '31.597850', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10367.39', '980.6182', '31.472850', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10333.47', '978.7831', '31.254930', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10300.25', '965.6370', '31.253040', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10285.64', '964.0901', '31.185620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10273.86', '970.6926', '31.185620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10267.59', '983.3521', '31.310620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10260.89', '989.9033', '31.377510', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10233.98', '996.2642', '31.491770', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10215.86', '994.5016', '32.503140', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10200.06', '989.3520', '32.933310', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10190.04', '984.9003', '33.780400', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10166.77', '986.7172', '34.054080', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10133.55', '990.6491', '36.048570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10116.65', '990.1268', '38.219650', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10100.18', '999.1907', '37.460870', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10116.65', '990.1268', '38.219650', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10133.55', '990.6491', '36.048570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10166.77', '986.7172', '34.054080', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10190.04', '984.9003', '33.780400', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10200.06', '989.3520', '32.933310', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10215.86', '994.5016', '32.503140', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10233.98', '996.2642', '31.491770', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10260.89', '989.9033', '31.377510', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10267.59', '983.3521', '31.310620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10273.86', '970.6926', '31.185620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10285.64', '964.0901', '31.185620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10300.25', '965.6370', '31.253040', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10333.47', '978.7831', '31.254930', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10367.39', '980.6182', '31.472850', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10386.81', '984.0738', '31.597850', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10400.42', '992.5428', '31.579060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10410.51', '994.7161', '32.164260', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10433.16', '981.9645', '34.757520', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10466.91', '953.8127', '35.898200', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10500.21', '952.6395', '39.459800', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10532.88', '961.9837', '40.885220', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10564.63', '975.7330', '40.634450', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10593.99', '987.9368', '36.877070', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10620.20', '1000.8520', '32.99437', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10642.80', '1016.6650', '31.56510', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@DORANA, (@POINT := @POINT + 1), '-10647.46', '1012.3680', '31.77653', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @KORELOR := '874'; -- Protector Korelor

-- -------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@KORELOR);
SET @NAME := (SELECT `name` FROM `creature_template` WHERE `entry`=@KORELOR);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-10632.98', `position_y`='1087.872', `position_z`='33.87227', `orientation`='4.635367', `MovementType`='2' WHERE `id`=@KORELOR;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@KORELOR;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@KORELOR, (@POINT := @POINT + 1), '-10634.18', '1072.219', '33.90115', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10640.83', '1056.614', '33.69242', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10655.06', '1038.739', '33.58622', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10663.54', '1029.080', '32.69010', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10699.92', '1033.696', '34.47182', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10719.79', '1032.385', '34.58892', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10732.51', '1027.076', '34.58892', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10746.82', '1018.542', '34.10905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10768.83', '1017.259', '32.24479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10793.78', '1018.650', '32.28947', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10833.29', '1009.724', '32.82467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10864.48', '1006.455', '31.67381', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10898.81', '999.4549', '35.70985', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10919.73', '993.3299', '35.46926', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10942.45', '967.6190', '32.45774', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10949.25', '940.7150', '31.55006', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10946.80', '934.3032', '31.55006', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10914.47', '901.5839', '32.28352', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10916.35', '868.8564', '32.45573', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10926.30', '852.3051', '32.84294', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10929.21', '832.7261', '32.29058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10919.83', '800.1399', '30.84746', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10900.73', '777.5663', '30.75943', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10880.35', '749.3021', '31.09746', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10877.12', '732.9159', '31.10690', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10871.73', '699.8195', '30.98836', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10866.87', '665.3965', '31.03180', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10871.73', '699.8195', '30.98836', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10877.12', '732.9159', '31.10690', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10880.35', '749.3021', '31.09746', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10900.73', '777.5663', '30.75943', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10919.83', '800.1399', '30.84746', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10929.21', '832.7261', '32.29058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10926.30', '852.3051', '32.84294', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10916.35', '868.8564', '32.45573', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10914.47', '901.5839', '32.28352', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10946.80', '934.3032', '31.55006', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10949.25', '940.7150', '31.55006', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10942.45', '967.6190', '32.45774', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10919.73', '993.3299', '35.46926', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10898.81', '999.4549', '35.70985', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10864.48', '1006.455', '31.67381', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10833.29', '1009.724', '32.82467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10794.01', '1018.667', '32.32072', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10768.83', '1017.259', '32.24479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10746.87', '1018.548', '34.16447', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10732.51', '1027.076', '34.58892', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10719.79', '1032.385', '34.58892', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10699.92', '1033.696', '34.47182', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10663.54', '1029.080', '32.69010', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10655.06', '1038.739', '33.58622', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10640.83', '1056.614', '33.69242', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10634.18', '1072.219', '33.90115', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@KORELOR, (@POINT := @POINT + 1), '-10634.00', '1085.885', '33.74294', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @GUID := '1759'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4771.914', `position_y`='-1021.364', `position_z`='502.2956', `orientation`='1.193777', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4767.071', '-1009.134', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4759.091', '-994.4371', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4746.498', '-986.7278', '501.5323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4727.245', '-986.3358', '501.4722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4709.644', '-986.9350', '501.6451', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4696.713', '-982.7900', '501.6962', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4686.291', '-974.5480', '501.6554', '30000', '0', '0', '0', '0', '0', '0', '0', '0', '0.6690948', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4701.526', '-986.7450', '501.6711', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4718.943', '-986.9548', '501.5041', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4743.440', '-985.0746', '501.4334', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4759.754', '-995.0007', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4765.604', '-1007.700', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4771.829', '-1021.206', '502.2123', '30000', '0', '0', '0', '0', '0', '0', '0', '0', '4.2805010', '0', '0');


SET @GUID := '1760'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4635.689', `position_y`='-997.4887', `position_z`='501.7427', `orientation`='0.9016399', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4621.842', '-979.9805', '501.6565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4632.920', '-958.1653', '501.6589', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4645.341', '-941.0410', '501.6577', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4660.012', '-925.5549', '501.6573', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4687.626', '-903.8880', '501.6717', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4703.024', '-913.8218', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4707.872', '-930.5532', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4697.937', '-943.9158', '501.6703', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4687.489', '-966.4830', '501.6829', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4672.090', '-983.1004', '501.6840', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4654.317', '-995.6335', '501.6393', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4635.397', '-998.0302', '501.6534', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @GUID := '105'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-5003.920', `position_y`='-1117.3320', `position_z`='501.7582', `orientation`='0.7226949', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4997.035', '-1111.260', '501.6703', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4994.561', '-1083.678', '498.8325', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4991.824', '-1055.735', '497.9429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4986.590', '-1034.179', '501.6517', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4972.985', '-994.6423', '501.6516', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4954.183', '-966.5741', '501.6577', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4931.063', '-943.3762', '501.6425', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4896.667', '-918.9849', '501.6267', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4859.071', '-906.0353', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4827.863', '-903.4857', '501.6598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4805.999', '-905.0009', '497.9457', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4778.714', '-906.3766', '500.0083', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4766.738', '-906.0627', '501.6277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4753.256', '-910.0827', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4747.038', '-905.0212', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4748.268', '-895.6587', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4773.682', '-886.5223', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4799.893', '-879.7461', '501.6700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4830.926', '-880.5823', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4859.374', '-884.3204', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4900.400', '-897.6807', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4928.519', '-913.5782', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4964.312', '-943.6036', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4982.343', '-966.8148', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4995.402', '-992.4957', '501.6619', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5006.113', '-1016.344', '501.6579', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5010.339', '-1035.028', '501.6559', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5016.313', '-1067.132', '501.7428', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5017.297', '-1096.132', '501.6779', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5014.159', '-1111.454', '501.6730', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5004.407', '-1115.416', '501.6730', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

-- Removed old unused DBScripts for creature 8256 (Curator Thorius)
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` IN (825601, 825602);



-- Fixed stats of creature 4196 (Silithid Swarm). This NPCs is summoned by various
-- silithid NPCs and its stats change depending on how it is summoned
-- Sources:
-- http://www.wowhead.com/npc=5451#comments
-- http://www.wowhead.com/npc=5457#comments
-- http://www.wowhead.com/npc=3252#comments
-- Fixed stats of creature 7769 (Hazzali Parasite). This NPCs is summoned by various
-- silithid NPCs at death and previously had too much HP
-- Source: http://www.wowwiki.com/Hazzali_Parasite
UPDATE `creature_template` SET `MinLevel` = 1, `MaxLevel` = 1, `MinLevelHealth` = 1, `MaxLevelHealth` = 1, `MinLevelMana` = 0, `MaxLevelMana` = 0, `HealthMultiplier` = 0.02, `ArmorMultiplier` = 1, `Scale` = 0.2 WHERE `Entry` = 4196;
UPDATE `creature_template` SET `MinLevelHealth` = 2, `MaxLevelHealth` = 2, `HealthMultiplier` = 0.001, `ArmorMultiplier` = 1 WHERE `Entry` = 7769;

-- Fixed quest Waking Legends(q.8447) by adding end script. Heavily based on commit https://github.com/unified-db/Database/commit/8d6e23b090ea95e4230e9f431229b6c02efe1da3
-- by @Grz3s for UDB but adjusted for Classic DB.
-- This closes #32 
-- Source: http://www.youtube.com/watch?v=7S6_U8qNU2U

SET @MALFURION := 15362;

DELETE FROM dbscripts_on_quest_start WHERE id = 8447;
INSERT INTO dbscripts_on_quest_start (id,  delay,  command,  datalong,  datalong2,  buddy_entry,  search_radius,  data_flags,  dataint,  dataint2,  dataint3,  dataint4,  X,  Y,  z,  o,  comments) VALUES
(8447, 1, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Remulos active'), 
(8447, 1, 29, 3, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '22832 - npc_flag removed'), 
(8447, 3, 0, 0, 0, 0, 0, 0, 2000000375, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 6, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7841.78, -2226.41, 468.062, 4.27031, ''), 
(8447, 7, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7828.99, -2246.58, 463.559, 4.44419, ''), 
(8447, 11, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7824.59, -2280.33, 459.171, 4.52666, ''), 
(8447, 16, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7817.51, -2302.91, 456.077, 3.83315, ''), 
(8447, 19, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7808.83, -2304.32, 455.411, 3.81116, ''), 
(8447, 21, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7788.35, -2321.57, 454.651, 3.49596, ''), 
(8447, 24, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7775.52, -2324.3, 454.189, 3.10954, ''), 
(8447, 26, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7755.16, -2315.33, 455.235, 2.95796, ''), 
(8447, 31, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'wp pause'), 
(8447, 35, 0, 0, 0, 0, 0, 0, 2000000376, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 40, 15, 25004, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 50, 10, @MALFURION, 180000, 0, 0, 0, 0, 0, 0, 0, 7738.52, -2314.8, 454.679, 0.046443, 'summon'), 
(8447, 51, 15, 17321, 0, @MALFURION, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'cast spirit spawn-in'), 
(8447, 54, 0, 0, 0, 0, 0, 0, 2000000377, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 57, 0, 0, 0, @MALFURION, 20, 7, 2000000378, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 61, 1, 0, 0, @MALFURION, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 62, 0, 0, 0, 0, 0, 0, 2000000379, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 70, 0, 0, 0, @MALFURION, 20, 7, 2000000380, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 80, 1, 0, 0, @MALFURION, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 81, 0, 0, 0, 0, 0, 0, 2000000381, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 84, 0, 0, 0, @MALFURION, 20, 7, 2000000382, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 89, 0, 0, 0, 0, 0, 0, 2000000383, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 99, 0, 0, 0, @MALFURION, 20, 7, 2000000384, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 116, 1, 0, 0, @MALFURION, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 117, 0, 0, 0, @MALFURION, 20, 7, 2000000385, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 121, 1, 0, 0, @MALFURION, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 122, 0, 0, 0, 0, 0, 0, 2000000386, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 125, 18, 0, 0, @MALFURION, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'malfurion desp'), 
(8447, 125, 7, 8447, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 126, 0, 0, 0, 0, 0, 0, 2000000387, 0, 0, 0, 0, 0, 0, 0, ''), 
(8447, 128, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7848.3, -2216.35, 470.888, 0.572632, ''), 
(8447, 148, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.90954, ''), 
(8447, 149, 29, 3, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '22832 - npc_flag added'), 
(8447, 149, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Remulos unactive');

UPDATE quest_template SET StartScript = 8447 WHERE entry = 8447;
DELETE FROM db_script_string WHERE entry BETWEEN 2000000375 AND 2000000387;
INSERT INTO db_script_string (entry,  content_default,  content_loc1,  content_loc2,  content_loc3,  content_loc4,  content_loc5,  content_loc6,  content_loc7,  content_loc8,  sound,  TYPE,  LANGUAGE,  emote,  COMMENT) VALUES
(2000000375, 'Come,  $N. The lake is around the bend.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL), 
(2000000376, 'Stand near me,  $N. I will protect you should anything go wrong.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL), 
(2000000377, 'Malfurion!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL), 
(2000000378, 'Remulos,  old friend. It is good to see you once more. I knew the message would find its way to you - one way or another.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL), 
(2000000379, 'It was shrouded in nightmares,  Malfurion. What is happening in the Dream? What could cause such atrocities?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL), 
(2000000380, 'I fear for the worst,  old friend. Within the Dream we fight a new foe,  born of an ancient evil. Ysera\'s noble brood has fallen victim to the old whisperings. It seems as if the Nightmare has broken through the realm to find a new host on Azeroth.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL), 
(2000000381, 'I sensed as much,  Malfurion. Dark days loom ahead.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL), 
(2000000382, 'Aye Remulos,  prepare the mortal races.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL), 
(2000000383, 'You have been gone too long,  Malfurion. Peace between the Children of Azeroth has become tenuous at best. What of my father? Of your brother? Have you any news?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL), 
(2000000384, 'Cenarius fights at my side. Illidan sits atop his throne in Outland - brooding. I\'m afraid that the loss to Arthas proved to be his breaking point. Madness has embraced him,  Remulos. He replays the events in his mind a thousand times per day,  but in his mind,  he is the victor and Arthas is utterly defeated. He is too far gone,  old friend. I fear that the time may soon come that our bond is tested and it will not be as it was at the Well in Zin-Azshari. ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL), 
(2000000385, 'Remulos,  I am being drawn back... Tyrande... send her my love... Tell her I am safe... Tell her... Tell her I will return... Farewell...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL), 
(2000000386, 'Farewell,  old friend... Farewell...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL), 
(2000000387, 'Let us return to the grove,  mortal.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL);

DELETE FROM spell_target_position WHERE id = 25004;
INSERT INTO spell_target_position (id,  target_map,  target_position_x,  target_position_y,  target_position_z,  target_orientation) VALUES
(25004, 1, 7738.52, -2314.8, 452.679, 0);

-- Malfurion Stormrage -- update
UPDATE creature_template SET InhabitType = 5 WHERE entry = @MALFURION;
INSERT INTO creature_template_addon VALUES (@MALFURION, 0, 0, 1, 0, 0, 0, 24999);
DELETE FROM creature_template_addon WHERE entry = @MALFURION;

-- Trek to Ashenvale (q.990)
-- 'Sentinel Selarin' should appear after compl. q.994 or q.995
-- Closes #583 
DELETE FROM dbscripts_on_quest_end WHERE id IN (994,995);
INSERT INTO dbscripts_on_quest_end (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(994,0,31,3694,15,0,0,0x08,0,0,0,0,0,0,0,0,''), -- check if creature is alive (prevent double spawn)
(994,1,10,3694,650000,0,0,0,0,0,0,0,6339.14,341.764,24.3387,0.498114,'spawn Sentinel Selarin'),
(995,0,31,3694,15,0,0,0x08,0,0,0,0,0,0,0,0,''), -- check if creature is alive (prevent double spawn)
(995,1,10,3694,650000,0,0,0,0,0,0,0,6339.14,341.764,24.3387,0.498114,'spawn Sentinel Selarin');
UPDATE quest_template SET CompleteScript = 994 WHERE entry = 994;
UPDATE quest_template SET CompleteScript = 995 WHERE entry = 995;
-- Sentinel Selarin
UPDATE creature_template SET FactionAlliance = 80, FactionHorde = 80, SpeedWalk = 1, MovementType = 2 WHERE entry = 3694;
DELETE FROM creature_template_addon WHERE entry = 3694;
INSERT INTO creature_template_addon VALUES (3694,0,0,1,1,0,0,NULL);
DELETE FROM creature_movement_template WHERE entry = 3694;
INSERT INTO creature_movement_template VALUES
(3694,1,6339.14,341.764,24.3387,1000,369401,0,0,0,0,0,0,0,0.498114,0,0),
(3694,2,6353.39,354.557,22.3779,0,0,0,0,0,0,0,0,0,0.768994,0,0),
(3694,3,6368.99,357.894,21.5712,0,0,0,0,0,0,0,0,0,0.171388,0,0),
(3694,4,6387.81,359.455,18.9899,0,0,0,0,0,0,0,0,0,0.328468,0,0),
(3694,5,6398.12,363.588,17.366,0,0,0,0,0,0,0,0,0,0.505183,0,0),
(3694,6,6403.68,370.92,15.6815,0,0,0,0,0,0,0,0,0,0.983488,0,0),
(3694,7,6416.57,392.998,12.0215,0,0,0,0,0,0,0,0,0,0.944219,0,0),
(3694,8,6424.95,399.193,10.9586,0,0,0,0,0,0,0,0,0,0.0292295,0,0),
(3694,9,6428.93,396.971,11.1736,0,0,0,0,0,0,0,0,0,5.0974,0,0),
(3694,10,6432,388.708,13.7662,0,0,0,0,0,0,0,0,0,5.02044,0,0),
(3694,11,6436.71,375.264,13.9403,0,0,0,0,0,0,0,0,0,4.74006,0,0),
(3694,12,6434.92,367.203,13.9403,600000,369402,0,0,0,0,0,0,0,4.6089,0,0),
(3694,13,6436.9,374.833,13.9403,0,0,0,0,0,0,0,0,0,1.85765,0,0),
(3694,14,6431.63,389.723,13.5875,0,0,0,0,0,0,0,0,0,1.96918,0,0),
(3694,15,6428.84,397.45,11.0941,0,0,0,0,0,0,0,0,0,2.58414,0,0),
(3694,16,6424,400.084,10.9784,0,0,0,0,0,0,0,0,0,3.33734,0,0),
(3694,17,6413.76,392.804,12.2825,0,0,0,0,0,0,0,0,0,4.12981,0,0),
(3694,18,6401.4,368.195,16.4249,0,0,0,0,0,0,0,0,0,3.85806,0,0),
(3694,19,6393.69,360.887,18.1549,0,0,0,0,0,0,0,0,0,3.44736,0,0),
(3694,20,6377.21,357.731,20.6589,0,0,0,0,0,0,0,0,0,3.04995,0,0),
(3694,21,6358.35,357.353,22.2106,0,0,0,0,0,0,0,0,0,3.50941,0,0),
(3694,22,6348.45,352.662,22.6056,0,0,0,0,0,0,0,0,0,4.03249,0,0),
(3694,23,6322.42,326.649,25.3338,2000,369403,0,0,0,0,0,0,0,3.91389,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id BETWEEN 369401 AND 369403;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(369401,1,21,1,0,0,0,0,0,0,0,0,0,0,0,0,'Sentinel Selarin active'),
(369401,1,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON'),
(369402,3,0,0,0,0,0,0,2000000260,0,0,0,0,0,0,0,''),
(369402,7,31,3693,30,0,0,0,0,0,0,0,0,0,0,0,''),
(369402,8,0,0,0,3693,30,7,2000000395,0,0,0,0,0,0,0,''),
(369402,13,0,0,0,0,0,0,2000000396,0,0,0,0,0,0,0,''),
(369402,18,0,0,0,0,0,0,2000000397,0,0,0,0,0,0,0,''),
(369403,1,21,1,0,0,0,0,0,0,0,0,0,0,0,0,'Sentinel Selarin unactive'),
(369403,2,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'desp');
DELETE FROM db_script_string WHERE entry IN (2000000260,2000000395,2000000396,2000000397);
INSERT INTO db_script_string (entry, content_default, content_loc1, content_loc2, content_loc3, content_loc4, content_loc5, content_loc6, content_loc7, content_loc8, sound, TYPE, LANGUAGE, emote, COMMENT) VALUES
(2000000260,'Terenthis, Raene sent me to find you. The Sentinels are in need of help in Ashenvale.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,1,NULL),
(2000000395,'Hello, Selarin. I\'m afraid I cannot help you at the moment, but perhaps some of the adventurers here in Auberdine can...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,1,NULL),
(2000000396,'Thank you, Terenthis. I shall remain here for as long as I can.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,1,NULL),
(2000000397,'Hopefully I can send a worthy few to help Ashenvale and the Sentinels.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,1,NULL);
-- quest must be available for both options
UPDATE quest_template SET PrevQuestid = 0 WHERE entry = 990;
UPDATE quest_template SET NextQuestid = 990 WHERE entry IN (994,995);

-- Raene Wolfrunner - gossip
-- This closes #625 
UPDATE creature_template SET GossipMenuId = 5502 WHERE entry = 3691;
DELETE FROM gossip_menu WHERE entry = 5502;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(5502,6553,0,0),
(5502,6555,0,1009);

-- q.5541 'Ammo for Rumbleshot'
-- Closes #138 
DELETE FROM dbscripts_on_quest_end WHERE id = 5541;
INSERT INTO dbscripts_on_quest_end (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(5541,0,20,0,0,10610,269,7 | 0x10,0,0,0,0,0,0,0,0,'movement chenged to 0:idle'),
(5541,1,20,2,0,10610,269,7 | 0x10,0,0,0,0,0,0,0,0,'movement chenged to 2:waypoint'); -- this will force him to start 'Mortar Combat' Event
UPDATE quest_template SET CompleteScript = 5541 WHERE entry = 5541;
-- Event: Mortar Combat - update
-- Angus (q.5541req.)
UPDATE creature_movement_template SET waittime = 1000 WHERE entry = 10610 AND POINT = 1;
UPDATE creature_movement_template SET waittime = 420000 WHERE entry = 10610 AND POINT = 7;
DELETE FROM dbscripts_on_creature_movement WHERE id = 1061001 AND delay IN (0,1);
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(1061001,0,21,1,0,0,0,0,0,0,0,0,0,0,0,0,'Angus - active'),
(1061001,0,21,1,0,10805,272,0x10,0,0,0,0,0,0,0,0,'Klemmy - active'),
(1061001,0,21,1,0,10611,267,0x10,0,0,0,0,0,0,0,0,'Shorty - active'),
(1061001,1,29,3,2,1243,265,7 | 0x10,0,0,0,0,0,0,0,0,'1243 - NPCFlags removed'),
(1061001,1,21,1,0,10803,266,0x10,0,0,0,0,0,0,0,0,'Wheeler - active'),
(1061001,1,21,1,0,10804,268,0x10,0,0,0,0,0,0,0,0,'Middlecamp - active');
DELETE FROM dbscripts_on_creature_movement WHERE id = 1061003 AND delay = 229;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(1061003,229,29,3,1,1243,265,7 | 0x10,0,0,0,0,0,0,0,0,'1243 - NPCFlags added');


-- Fixed faction of traps in Suppression Room of Blackwing Lair
UPDATE `gameobject_template` SET `faction` = 14 WHERE `entry` = 179784;

-- missing cat figurine (YTDB)
DELETE FROM gameobject_template WHERE entry=12653;
INSERT INTO gameobject_template (entry,TYPE,displayId,NAME,faction,flags,size,data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14,data15,data16,data17,data18,data19,data20,data21,data22,data23,mingold,maxgold) VALUES
('12653','6','1287','Cat Figurine Trap','14','0','1','0','0','0','5968','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');

-- Fixed quests 7481 & 7482 (Elven Legends - Alliance / Horde) by adding missing
-- gossip_menu_options and missing DBscripts on gossip. Thanks TheTrueAnimal
-- for pointing. This closes #637
-- Also fixed quest requirements
-- Source: YTDB and http://www.wowhead.com/quest=7482
SET @STRING := 2000000196;
SET @CONDITION := 48;

DELETE FROM `conditions` WHERE `condition_entry` IN (@CONDITION, @CONDITION + 1);
INSERT INTO `conditions` VALUES
(@CONDITION, 9, 7482, 0),
(@CONDITION + 1, 9, 7481, 0);


DELETE FROM `gossip_menu_option` WHERE `menu_id` = 5743;
INSERT INTO `gossip_menu_option` VALUES
(5743, 0, 0, 'Mourn the great loss.', 1, 1, -1, 0, 574301, 0, 0, NULL, @CONDITION),
(5743, 1, 0, 'Mourn the great loss.', 1, 1, -1, 0, 574302, 0, 0, NULL, @CONDITION + 1);

DELETE FROM `dbscripts_on_gossip` WHERE `id` IN (574301, 574302);
INSERT INTO `dbscripts_on_gossip` VALUES
(574301, 0, 7, 7482, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(574301, 2, 3, 0, 0, 14368, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0.7, ''),
(574301, 4, 0, 0, 0, 14368, 20, 0, @STRING, 0, 0, 0, 0, 0, 0, 0, ''),
(574301, 7, 0, 0, 0, 14368, 20, 0, @STRING + 1, 0, 0, 0, 0, 0, 0, 0, ''),
(574301, 13, 0, 0, 0, 14368, 20, 0, @STRING + 2, 0, 0, 0, 0, 0, 0, 0, ''),
(574301, 20, 3, 0, 0, 14368, 20, 0, 0, 0, 0, 0, 0, 0, 0, 3.07178, ''),
(574302, 0, 7, 7481, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(574302, 2, 3, 0, 0, 14368, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0.7, ''),
(574302, 4, 0, 0, 0, 14368, 20, 0, @STRING, 0, 0, 0, 0, 0, 0, 0, ''),
(574302, 7, 0, 0, 0, 14368, 20, 0, @STRING + 1, 0, 0, 0, 0, 0, 0, 0, ''),
(574302, 13, 0, 0, 0, 14368, 20, 0, @STRING + 2, 0, 0, 0, 0, 0, 0, 0, ''),
(574302, 20, 3, 0, 0, 14368, 20, 0, 0, 0, 0, 0, 0, 0, 0, 3.07178, '');

DELETE FROM `db_script_string` WHERE `entry` IN (@STRING, @STRING + 1, @STRING + 2);
INSERT INTO `db_script_string` VALUES
(@STRING, 'I very much doubt that he will have anything to say, stranger...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL),
(@STRING + 1, 'I personally didn\'t mind him. It was the Prince who took exception to a high elf in his domain. Alas, I am not one to question the Prince. In his defense, he did not incinerate Master Winthalus immediately.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL),
(@STRING + 2, 'We most definitely do not need any more attention drawn to us, stranger. Return to those that sent you in search of the lost master and tell them that nothing could be found. When this is done - and I will know when it is so - return and I shall reveal the secrets of the deceased.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, NULL);

UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 0, `ReqCreatureOrGOCount1` = 0 WHERE `entry` IN (7481, 7482);

-- Fixed quest flags for quests 7481, 7482 (Elven Legends)
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `entry` IN (7481, 7482);


-- Added missing script for quest 1126 (Hive in the Tower)
-- Now, two NPCs 13301 (Hive'Ashi Ambusher) will spawn when looting the Hive'Ashi Pod
-- They were previously missing, breaking the quest because they are the one dropping the requested quest item
-- Also fixed stats for creature 13301 (Hive'Ashi Ambusher) and 13136 (Hive'Ashi Drone). Both are involved in this
-- quest but NPCs 13136 will be handled by SD2
-- Thanks Scotty0100 for pointing.  
-- This closes #264 
DELETE FROM `dbscripts_on_go_template_use` WHERE `id` = 178553;
INSERT INTO `dbscripts_on_go_template_use` VALUES
(178553, 3, 10, 13301, 300000, 0, 0, 0, 0, 0, 0, 0, -7185.854, 439.658, 64.308, 5.43250, 'Quest 1126 - spawn Hive\'Ashi Ambusher'),
(178553, 3, 10, 13301, 300000, 0, 0, 0, 0, 0, 0, 0, -7180.654, 443.308, 64.123, 5.2000, 'Quest 1126 - spawn Hive\'Ashi Ambusher');

-- Improved quest 308 (Distracting Jarven)
-- Thanks Patman for pointing. This closes #137
UPDATE `gameobject` SET `position_x` = -5607.24, `position_y` = -547.934, `position_z` = 392.985, `orientation` = 0.471239, `rotation2` = 0.69985, `rotation3` = -0.71429 WHERE `id` = 270;

-- Fixed spawn time of NPC 11489 (Tendris Warpwood) in Dire Maul
-- Thanks TheTrueAnimal for pointing. This closes #654 
UPDATE `creature` SET `spawntimesecs` = 3 * 3600 WHERE `id` = 11489;

-- Removed duplicate mailboxes in world (same entry, same coordinates)
-- Thanks shiendra for pointing
-- also removes brackenwall mailbox it was introduced 2.3 also removes kharanos mailbox

DELETE FROM `gameobject` WHERE `guid` IN
(2978, 7574, 7597, 11874, 11238, 9659, 7555, 1074, 8382, 9279, 32657, 32822,
22934, 20030, 26380, 1620, 13449, 30545, 20420, 20426, 26771,
15036, 15586, 14750, 17210, 10175, 15753, 10764, 10807, 26463,
42913, 26387, 16565, 15724, 12954, 2114, 10011, 1379, 866,
52, 10968, 10107, 23207, 17101, 34036, 17985, 19713, 10714,
23569, 30003);

-- Fixed a few issues in Zul'Farrak. Thanks Nekoi for reporting.
-- This closes #175 and #174

-- Added missing loot entry for creature 8876 (Sandfury Acolyte)
DELETE FROM `creature_loot_template` WHERE `entry` = 8876;
INSERT INTO `creature_loot_template` VALUES (8876, 24041, 1, 1, -24041, 1, 0);
UPDATE `creature_template` SET `LootId` = 8876 WHERE `Entry` = 8876;

-- Fixed quest Divino-matic rod
SET @CONDITION := 408;
UPDATE `gossip_menu_option` SET `action_script_id` = 94101, `condition_id` = @CONDITION + 1 WHERE `menu_id` = 941 AND `id` = 0;
DELETE FROM `conditions` WHERE `condition_entry` IN (@CONDITION, @CONDITION + 1);
INSERT INTO `conditions` VALUES
(@CONDITION, 9, 2768, 0),
(@CONDITION + 1, -1, @CONDITION, 384);

-- Added waypoint movement to creature 7795 (Hydromancer Velratha) in Zul'Farrak.
-- She will now move around the sacred pool.
-- Source: YTDB
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 7795;
UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` = 7795;
DELETE FROM `creature_movement_template` WHERE `entry` = 7795;
INSERT INTO `creature_movement_template` VALUES
(7795, 1, 1704.96, 1202.13, 9.24427, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7795, 2, 1684.78, 1225.34, 8.87707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7795, 3, 1706.28, 1200.92, 9.22012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7795, 4, 1681.82, 1180.19, 8.89546, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Fixed walk speed for creature 7273 (Gahz'rilla) in Zul'Farrak because it was moving way to quickly
UPDATE `creature_template` SET `SpeedWalk` = 1.14286 WHERE `Entry` = 7273;

-- Fixed addon for creature 5648 (Sandfury Shadowcaster) because they were using an aura addon and an EventAI
-- script to add the same spell 20798 (Demon Skin) resulting in the spell being self canceled
DELETE FROM `creature_addon` WHERE `auras` = '20798' AND `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 5648);

-- Fixed loot table of bosses in Zul'Farrak. Thanks Patman for reporting.
-- This closes #173
UPDATE creature_loot_template SET ChanceOrQuestChance = 40 WHERE entry = 7271 AND item = 18083;
UPDATE creature_loot_template SET ChanceOrQuestChance = 20 WHERE entry = 7271 AND item = 18082;
DELETE FROM `creature_loot_template` WHERE `entry` = 7271 AND `item` IN (24036, 24041, 24043, 24045);
INSERT INTO `creature_loot_template` VALUES
(7271, 24036, 10, 0, -24036, 1, 0), -- grey items
(7271, 24041, 10, 1, -24041, 1, 0), -- green items
(7271, 24043, 10, 1, -24043, 1, 0), -- green items
(7271, 24045, 10, 1, -24045, 1, 0); -- green items

DELETE FROM `creature_loot_template` WHERE `entry` = 7275 AND `item` IN (24036, 24041, 24043, 24045);
INSERT INTO `creature_loot_template` VALUES
(7275, 24036, 10, 0, -24036, 1, 0), -- grey items
(7275, 24041, 10, 1, -24041, 1, 0), -- green items
(7275, 24045, 10, 1, -24045, 1, 0); -- green items

UPDATE `creature_loot_template` SET `maxcount` = 4 WHERE `item` IN (4338, 4306) AND `entry` IN (8127, 7272, 7271, 7796, 7795, 7273, 7275, 7797, 7267);
UPDATE `creature_loot_template` SET `mincountOrRef` = 2, `maxcount` = 5 WHERE `item` = 9523 AND `entry` IN (8127, 7272, 7271, 7796, 7795, 7273, 7275, 7797, 7267);

-- Fixes the NPC flag of Guard Roberts(12423) so that he is not killed by wolves. This closes #575
UPDATE creature_template SET FactionAlliance = '12', FactionHorde = '12' WHERE entry = '12423';


SET @VENG := '12243'; -- Spirit of Veng

-- -------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@VENG);
SET @NAME := (SELECT `name` FROM `creature_template` WHERE `entry`=@VENG);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='1055.392', `position_y`='-424.1431', `position_z`='-31.71157', `orientation`='1.750369', `MovementType`='2' WHERE `id`=@VENG;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@VENG;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@VENG, (@POINT := @POINT + 1), '1049.818', '-393.4347', '-36.40392', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1045.682', '-370.0918', '-36.26097', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1037.269', '-344.1738', '-38.49696', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1010.231', '-354.8006', '-40.64174', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1001.227', '-344.3694', '-41.84286', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '999.8060', '-321.7702', '-44.88178', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '975.9816', '-300.2042', '-45.56088', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '973.3655', '-281.7761', '-45.60944', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '990.8004', '-256.7235', '-45.71144', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '989.8036', '-243.7692', '-46.39622', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '976.5450', '-231.1565', '-48.83212', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '961.1855', '-219.4528', '-46.59094', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '948.0901', '-222.7645', '-46.55467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '918.1025', '-245.1806', '-46.55928', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '890.2081', '-266.6740', '-45.42295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '893.1019', '-286.1003', '-45.94720', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '897.5882', '-303.8908', '-46.28094', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '901.6393', '-319.0111', '-49.26011', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '924.2225', '-338.5798', '-49.55234', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '945.5290', '-352.3690', '-50.18389', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '949.2391', '-372.7560', '-50.12433', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '988.6956', '-380.2867', '-50.14082', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '988.1112', '-348.7142', '-55.44043', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '996.1870', '-322.5443', '-66.97682', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1033.109', '-300.2142', '-71.97886', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1053.559', '-317.8576', '-72.60872', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1072.046', '-311.1849', '-72.56207', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1070.727', '-284.2663', '-72.68817', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1063.746', '-252.9242', '-72.76898', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1043.079', '-229.5041', '-72.24142', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1020.745', '-209.5346', '-68.81355', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '995.1354', '-196.4536', '-67.63020', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '976.9100', '-181.5676', '-67.80058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '948.1158', '-177.7663', '-63.59454', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '937.1934', '-168.8369', '-61.91036', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '938.5875', '-151.5429', '-60.67347', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '948.4577', '-143.1483', '-60.54069', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '958.8175', '-117.1759', '-63.10133', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '963.1480', '-94.42476', '-63.19287', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '959.0657', '-69.91625', '-61.98630', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '938.5645', '-63.86766', '-61.55652', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '919.0784', '-60.11865', '-59.44709', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '897.0678', '-67.87030', '-59.41375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '903.8420', '-88.71603', '-59.77781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '917.5721', '-110.9749', '-61.77675', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '903.7606', '-142.9984', '-60.55473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '905.8484', '-166.0484', '-60.56079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '915.4623', '-183.6756', '-57.63430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '902.2466', '-202.7771', '-52.54680', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '893.0361', '-219.8669', '-52.47010', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '877.2800', '-241.5437', '-51.13675', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '864.7952', '-249.2394', '-52.05878', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '827.9483', '-258.0505', '-59.70293', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '864.7952', '-249.2394', '-52.05878', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '877.2734', '-241.5478', '-51.36961', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '893.0361', '-219.8669', '-52.47010', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '902.2466', '-202.7771', '-52.54680', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '915.4623', '-183.6756', '-57.63430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '905.8484', '-166.0484', '-60.56079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '903.7606', '-142.9984', '-60.55473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '917.4988', '-111.1451', '-61.78257', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '903.8420', '-88.71603', '-59.77781', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '897.0678', '-67.87030', '-59.41375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '919.0784', '-60.11865', '-59.44709', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '938.5645', '-63.86766', '-61.55652', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '959.0657', '-69.91625', '-61.98630', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '963.1480', '-94.42476', '-63.19287', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '958.8175', '-117.1759', '-63.10133', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '948.4577', '-143.1483', '-60.54069', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '938.5875', '-151.5429', '-60.67347', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '937.1934', '-168.8369', '-61.91036', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '948.1158', '-177.7663', '-63.59454', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '976.9100', '-181.5676', '-67.80058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '995.1354', '-196.4536', '-67.63020', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1020.745', '-209.5346', '-68.81355', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1043.079', '-229.5041', '-72.24142', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1063.746', '-252.9242', '-72.76898', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1070.727', '-284.2663', '-72.68817', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1072.046', '-311.1849', '-72.56207', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1053.559', '-317.8576', '-72.60872', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1033.109', '-300.2142', '-71.97886', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '996.1870', '-322.5443', '-66.97682', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '988.1112', '-348.7142', '-55.44043', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '988.6956', '-380.2867', '-50.14082', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '949.2391', '-372.7560', '-50.12433', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '945.5290', '-352.3690', '-50.18389', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '924.2225', '-338.5798', '-49.55234', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '901.6393', '-319.0111', '-49.26011', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '897.5882', '-303.8908', '-46.28094', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '893.1019', '-286.1003', '-45.94720', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '890.0764', '-266.7756', '-45.43538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '918.1025', '-245.1806', '-46.55928', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '948.0901', '-222.7645', '-46.55467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '961.1744', '-219.4443', '-46.55466', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '976.5450', '-231.1565', '-48.83212', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '989.7991', '-243.7112', '-46.40620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '990.8004', '-256.7235', '-45.71144', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '973.3655', '-281.7761', '-45.60944', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '975.9816', '-300.2042', '-45.56088', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '999.8060', '-321.7702', '-44.88178', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1001.227', '-344.3694', '-41.84286', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1010.110', '-354.6602', '-40.65324', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1037.269', '-344.1738', '-38.49696', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1045.682', '-370.0918', '-36.26097', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1049.818', '-393.4347', '-36.40392', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@VENG, (@POINT := @POINT + 1), '1056.210', '-424.1578', '-31.78930', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


-- fix for atiesh
DELETE FROM `gameobject_template` WHERE `entry`='181146';
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `faction`, `flags`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `mingold`, `maxgold`) VALUES
('181146', '22', '4398', 'Portal to Karazhan', '0', '0', '1', '28147', '0', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

DELETE FROM `spell_target_position` WHERE `id`='28147';
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
('28147', '0', '-11123.3', '-2014.44', '47.09271', '0.675977');


SET @GUID := '3514';

-- -------------------------------------

SET @SHARK := '5435'; -- Sand Shark

UPDATE `creature_template` SET `SpeedWalk`='1' WHERE `Entry`=@SHARK;

DELETE FROM `creature` WHERE `guid` BETWEEN (@GUID + 00) AND (@GUID + 11);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID + 00, @SHARK, '0', '12193', '0', '3221.8960', '1710.4690', '-49.23661', '0.715585', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 01, @SHARK, '0', '12193', '0', '3234.7780', '1040.1620', '-49.03365', '2.083385', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 02, @SHARK, '0', '12193', '0', '3221.2930', '530.99500', '-49.03215', '6.165682', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 03, @SHARK, '1', '12193', '0', '1550.5950', '-5378.973', '-32.53504', '3.280727', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 04, @SHARK, '1', '12193', '0', '1283.9980', '-5408.571', '-50.30394', '3.492435', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 05, @SHARK, '1', '12193', '0', '912.37060', '-5415.917', '-55.11948', '0.000000', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 06, @SHARK, '1', '12193', '0', '493.32640', '-5371.269', '-49.88814', '0.000000', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 07, @SHARK, '1', '12193', '0', '-326.5838', '-5558.277', '-32.57368', '3.883571', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 08, @SHARK, '1', '12193', '0', '-576.1233', '-5817.376', '-32.54733', '3.157282', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 09, @SHARK, '1', '12193', '0', '-1385.017', '-5779.737', '-18.00786', '3.348139', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 10, @SHARK, '1', '12193', '0', '-1753.698', '-5591.549', '-33.64932', '3.028575', '300', '0', '0', '903', '0', '0', '2'),
(@GUID + 11, @SHARK, '1', '12193', '0', '-1115.526', '-4306.334', '-7.687678', '3.674317', '300', '0', '0', '903', '0', '0', '2');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 00);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 00, (@POINT := @POINT + 1), '3195.662', '1723.264', '-48.04173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3172.181', '1728.667', '-46.73510', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3159.840', '1742.105', '-47.11641', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3150.543', '1759.820', '-48.98943', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3145.209', '1779.996', '-48.55008', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3150.675', '1795.498', '-43.96499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3159.018', '1808.918', '-46.86113', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3147.042', '1829.820', '-48.91264', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3124.375', '1836.323', '-49.30346', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3110.177', '1853.608', '-49.30346', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3098.962', '1879.044', '-49.19866', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3099.791', '1899.643', '-45.14495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3093.299', '1918.567', '-48.78092', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3074.238', '1939.806', '-49.20982', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3047.839', '1955.769', '-49.31664', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3028.469', '1970.392', '-49.24512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3019.160', '1982.827', '-48.99512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2988.323', '1998.347', '-49.14025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2980.851', '2004.864', '-48.03909', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2954.493', '2018.016', '-47.80416', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2925.328', '2045.097', '-49.28268', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2893.023', '2053.511', '-49.19867', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2865.849', '2054.294', '-48.97533', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2843.767', '2055.249', '-49.08995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2822.482', '2054.119', '-48.85473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2788.695', '2062.917', '-48.87340', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2765.504', '2066.172', '-48.06932', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2788.695', '2062.917', '-48.87340', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2822.482', '2054.119', '-48.85473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2843.767', '2055.249', '-49.08995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2865.849', '2054.294', '-48.97533', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2893.023', '2053.511', '-49.19867', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2925.328', '2045.097', '-49.28268', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2954.493', '2018.016', '-47.80416', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2980.851', '2004.864', '-48.03909', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '2988.323', '1998.347', '-49.14025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3019.160', '1982.827', '-48.99512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3028.469', '1970.392', '-49.24512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3047.839', '1955.769', '-49.31664', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3074.238', '1939.806', '-49.20982', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3093.299', '1918.567', '-48.78092', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3099.791', '1899.643', '-45.14495', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3098.962', '1879.044', '-49.19866', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3110.177', '1853.608', '-49.30346', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3124.375', '1836.323', '-49.30346', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3147.042', '1829.820', '-48.91264', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3159.018', '1808.918', '-46.86113', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3150.675', '1795.498', '-43.96499', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3145.209', '1779.996', '-48.55008', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3150.505', '1759.881', '-48.99666', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3159.840', '1742.105', '-47.11641', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3172.181', '1728.667', '-46.73510', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3195.662', '1723.264', '-48.04173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '3222.932', '1722.388', '-49.26390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 01);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 01, (@POINT := @POINT + 1), '3219.865', '1066.655', '-48.89483', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3207.929', '1090.381', '-47.27658', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3194.551', '1111.675', '-46.84540', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3181.076', '1131.854', '-44.69330', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3178.316', '1156.420', '-45.47855', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3176.881', '1185.595', '-45.43680', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3180.236', '1206.306', '-43.94244', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3190.403', '1227.345', '-48.06219', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3193.387', '1253.546', '-49.51052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3191.814', '1284.168', '-48.92054', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3213.592', '1302.704', '-49.30187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3226.420', '1327.890', '-49.30187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3227.663', '1352.519', '-49.28304', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3220.748', '1378.083', '-49.21460', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3223.328', '1416.279', '-49.18565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3237.026', '1444.512', '-49.23547', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3225.315', '1473.262', '-49.20024', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3215.697', '1516.206', '-49.28796', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3199.542', '1542.934', '-49.26866', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3186.097', '1575.288', '-49.23889', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3189.738', '1608.755', '-49.30112', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3207.190', '1630.425', '-49.30617', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3223.051', '1654.719', '-49.30940', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3245.558', '1679.743', '-49.38989', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3242.984', '1723.863', '-49.34183', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3245.558', '1679.743', '-49.38989', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3223.051', '1654.719', '-49.30940', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3207.190', '1630.425', '-49.30617', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3189.738', '1608.755', '-49.30112', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3186.097', '1575.288', '-49.23889', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3199.542', '1542.934', '-49.26866', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3215.697', '1516.206', '-49.28796', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3225.315', '1473.262', '-49.20024', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3237.026', '1444.512', '-49.23547', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3223.328', '1416.279', '-49.18565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3220.748', '1378.083', '-49.21460', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3227.663', '1352.519', '-49.28304', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3226.420', '1327.890', '-49.30187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3213.592', '1302.704', '-49.30187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3191.814', '1284.168', '-48.92054', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3193.387', '1253.546', '-49.51052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3190.403', '1227.345', '-48.06219', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3180.236', '1206.306', '-43.94244', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3176.881', '1185.595', '-45.43680', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3178.316', '1156.420', '-45.47855', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3181.076', '1131.854', '-44.69330', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3194.551', '1111.675', '-46.84540', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3207.856', '1090.509', '-47.15768', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3219.865', '1066.655', '-48.89483', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '3229.621', '1042.286', '-48.93804', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 02);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 02, (@POINT := @POINT + 1), '3237.635', '529.06600', '-49.16099', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3245.977', '509.61450', '-49.20725', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3244.237', '480.18940', '-48.52467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3236.807', '451.48190', '-47.32991', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3229.509', '421.77820', '-46.67115', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3232.343', '398.54900', '-48.87648', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3232.087', '378.38370', '-47.22718', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3236.055', '354.16190', '-47.16812', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3225.398', '330.03550', '-46.41989', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3209.576', '308.72660', '-45.18295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3194.012', '282.98680', '-44.12692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3184.899', '250.45230', '-42.89439', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3180.684', '215.66450', '-43.48129', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3190.049', '191.40670', '-47.26377', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3202.457', '172.92600', '-49.13857', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3198.712', '154.54250', '-47.61382', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3191.650', '129.38040', '-46.38750', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3199.235', '111.01500', '-47.97380', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3215.442', '80.826820', '-49.30187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3225.974', '70.905170', '-49.30187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3215.456', '39.465930', '-49.28304', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3218.057', '14.812720', '-47.47643', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3232.953', '2.2024740', '-47.67784', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3241.448', '-16.72179', '-48.20384', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3240.345', '-45.92708', '-45.04333', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3236.313', '-72.91493', '-46.02376', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3225.415', '-94.10894', '-46.09856', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3215.184', '-125.0271', '-47.42868', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3198.149', '-144.3789', '-48.90287', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3195.199', '-160.0213', '-48.66862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3190.234', '-188.3837', '-46.62103', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3194.873', '-215.7166', '-49.69736', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3213.641', '-245.5773', '-49.15242', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3233.052', '-275.7148', '-49.20945', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3234.987', '-304.3427', '-49.21683', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3220.768', '-329.8578', '-49.39344', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3197.923', '-345.2815', '-48.11151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3181.139', '-362.3763', '-44.06171', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3170.618', '-379.9243', '-32.26678', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3167.317', '-395.3262', '-21.20147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3162.110', '-435.2891', '-17.72998', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3167.317', '-395.3262', '-21.20147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3170.618', '-379.9243', '-32.26678', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3181.139', '-362.3763', '-44.06171', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3197.923', '-345.2815', '-48.11151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3220.768', '-329.8578', '-49.39344', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3234.987', '-304.3427', '-49.21683', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3233.052', '-275.7148', '-49.20945', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3213.641', '-245.5773', '-49.15242', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3194.873', '-215.7166', '-49.69736', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3190.234', '-188.3837', '-46.62103', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3195.199', '-160.0213', '-48.66862', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3198.149', '-144.3789', '-48.90287', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3215.184', '-125.0271', '-47.42868', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3225.415', '-94.10894', '-46.09856', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3236.313', '-72.91493', '-46.02376', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3240.345', '-45.92708', '-45.04333', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3241.448', '-16.72179', '-48.20384', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3232.953', '2.2024740', '-47.67784', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3218.057', '14.812720', '-47.47643', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3215.456', '39.465930', '-49.28304', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3225.974', '70.905170', '-49.30187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3215.442', '80.826820', '-49.30187', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3199.235', '111.01500', '-47.97380', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3191.650', '129.38040', '-46.38750', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3198.712', '154.54250', '-47.61382', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3202.457', '172.92600', '-49.13857', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3190.049', '191.40670', '-47.26377', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3180.684', '215.66450', '-43.48129', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3184.899', '250.45230', '-42.89439', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3194.012', '282.98680', '-44.12692', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3209.576', '308.72660', '-45.18295', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3225.398', '330.03550', '-46.41989', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3236.055', '354.16190', '-47.16812', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3232.087', '378.38370', '-47.22718', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3232.343', '398.54900', '-48.87648', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3229.509', '421.77820', '-46.67115', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3236.807', '451.48190', '-47.32991', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3244.237', '480.18940', '-48.52467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3245.977', '509.61450', '-49.20725', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3237.635', '529.06600', '-49.16099', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 02, (@POINT := @POINT + 1), '3222.140', '543.13870', '-49.32173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 03);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 03, (@POINT := @POINT + 1), '1516.821', '-5383.695', '-28.89055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1474.842', '-5385.459', '-29.28639', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1447.965', '-5383.485', '-25.54378', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1412.757', '-5384.636', '-29.42945', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1382.154', '-5391.196', '-28.43884', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1354.784', '-5391.483', '-28.67631', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1334.220', '-5378.395', '-28.84184', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1335.495', '-5355.212', '-28.79936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1344.525', '-5325.676', '-28.07126', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1328.266', '-5309.035', '-31.77486', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1304.008', '-5312.752', '-31.23555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1284.624', '-5347.431', '-37.39617', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1286.436', '-5381.057', '-48.04226', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1284.715', '-5401.730', '-48.88867', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1287.051', '-5438.851', '-54.86390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1305.017', '-5456.569', '-56.55155', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1317.339', '-5496.389', '-55.88370', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1305.017', '-5456.569', '-56.55155', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1287.051', '-5438.851', '-54.86390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1284.738', '-5401.922', '-48.86840', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1286.436', '-5381.057', '-48.04226', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1284.624', '-5347.431', '-37.39617', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1304.008', '-5312.752', '-31.23555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1328.266', '-5309.035', '-31.77486', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1344.525', '-5325.676', '-28.07126', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1335.495', '-5355.212', '-28.79936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1334.220', '-5378.395', '-28.84184', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1354.784', '-5391.483', '-28.67631', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1382.154', '-5391.196', '-28.43884', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1412.757', '-5384.636', '-29.42945', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1447.965', '-5383.485', '-25.54378', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1474.842', '-5385.459', '-29.28639', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1516.821', '-5383.695', '-28.89055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 03, (@POINT := @POINT + 1), '1546.040', '-5379.322', '-32.59856', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 04);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 04, (@POINT := @POINT + 1), '1254.183', '-5419.487', '-52.47182', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1229.275', '-5435.859', '-56.99025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1208.765', '-5447.439', '-59.66518', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1187.963', '-5453.081', '-61.99784', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1153.766', '-5448.208', '-64.51538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1124.296', '-5439.626', '-63.20396', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1100.615', '-5425.709', '-61.84917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1080.524', '-5423.092', '-60.78251', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1055.613', '-5418.479', '-58.51124', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1026.962', '-5411.602', '-55.96208', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1002.202', '-5421.312', '-52.50908', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '978.4183', '-5425.099', '-52.55588', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '959.8919', '-5425.464', '-49.94030', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '939.5423', '-5439.234', '-53.97221', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '924.9915', '-5446.012', '-55.85010', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '902.2852', '-5443.909', '-58.57483', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '880.6873', '-5439.053', '-59.71062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '850.2018', '-5453.352', '-60.19572', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '880.6873', '-5439.053', '-59.71062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '902.2852', '-5443.909', '-58.57483', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '924.9915', '-5446.012', '-55.85010', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '939.5423', '-5439.234', '-53.97221', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '959.8919', '-5425.464', '-49.94030', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '978.4183', '-5425.099', '-52.55588', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1002.202', '-5421.312', '-52.50908', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1026.962', '-5411.602', '-55.96208', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1055.613', '-5418.479', '-58.51124', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1080.524', '-5423.092', '-60.78251', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1100.615', '-5425.709', '-61.84917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1124.296', '-5439.626', '-63.20396', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1153.766', '-5448.208', '-64.51538', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1187.963', '-5453.081', '-61.99784', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1208.765', '-5447.439', '-59.66518', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1229.275', '-5435.859', '-56.99025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1254.183', '-5419.487', '-52.47182', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 04, (@POINT := @POINT + 1), '1284.577', '-5416.164', '-50.28735', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 05);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 05, (@POINT := @POINT + 1), '884.7640', '-5424.270', '-58.09518', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '860.0378', '-5429.363', '-58.32449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '840.0536', '-5447.569', '-59.14537', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '808.6261', '-5450.202', '-55.68275', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '785.2258', '-5449.354', '-55.08957', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '752.3654', '-5448.882', '-57.33829', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '710.3349', '-5452.754', '-57.69526', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '683.3268', '-5449.814', '-59.34686', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '655.4700', '-5444.357', '-59.52345', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '651.5726', '-5424.516', '-58.07015', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '618.4048', '-5414.902', '-62.80570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '588.8499', '-5403.264', '-64.40174', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '542.9274', '-5406.277', '-62.64283', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '511.8536', '-5405.745', '-58.56149', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '482.2355', '-5413.691', '-57.85778', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '445.7431', '-5419.081', '-58.46385', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '482.2355', '-5413.691', '-57.85778', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '511.8536', '-5405.745', '-58.56149', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '542.9274', '-5406.277', '-62.64283', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '588.8499', '-5403.264', '-64.40174', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '618.4048', '-5414.902', '-62.80570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '651.5726', '-5424.516', '-58.07015', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '655.4700', '-5444.357', '-59.52345', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '683.3268', '-5449.814', '-59.34686', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '710.3349', '-5452.754', '-57.69526', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '752.3654', '-5448.882', '-57.33829', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '785.2258', '-5449.354', '-55.08957', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '808.6261', '-5450.202', '-55.68275', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '840.0536', '-5447.569', '-59.14537', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '860.0378', '-5429.363', '-58.32449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '884.7640', '-5424.270', '-58.09518', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 05, (@POINT := @POINT + 1), '910.8514', '-5418.024', '-54.31270', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 06);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 06, (@POINT := @POINT + 1), '478.1627', '-5354.213', '-43.77430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '449.2878', '-5339.316', '-39.46656', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '417.3964', '-5331.676', '-27.15956', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '401.8826', '-5346.240', '-24.60424', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '384.3302', '-5356.516', '-22.07583', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '365.9248', '-5363.742', '-21.16536', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '359.1452', '-5389.113', '-23.30958', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '351.7778', '-5414.204', '-22.67201', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '336.7711', '-5442.292', '-26.53557', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '336.7526', '-5463.582', '-28.15532', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '326.5220', '-5489.887', '-32.60765', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '297.9786', '-5504.623', '-32.26982', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '266.1298', '-5515.100', '-32.10590', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '239.6120', '-5514.212', '-31.99897', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '209.3774', '-5516.511', '-31.55025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '181.9160', '-5520.001', '-31.04438', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '152.5164', '-5519.960', '-29.29182', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '112.3420', '-5522.801', '-32.62555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '71.75141', '-5513.651', '-32.56606', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '42.74143', '-5516.012', '-32.60234', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '71.75141', '-5513.651', '-32.56606', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '112.3420', '-5522.801', '-32.62555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '152.5164', '-5519.960', '-29.29182', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '181.9160', '-5520.001', '-31.04438', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '209.3774', '-5516.511', '-31.55025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '239.6120', '-5514.212', '-31.99897', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '266.1298', '-5515.100', '-32.10590', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '297.9786', '-5504.623', '-32.26982', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '326.5220', '-5489.887', '-32.60765', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '336.7526', '-5463.582', '-28.15532', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '336.7711', '-5442.292', '-26.53557', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '351.7778', '-5414.204', '-22.67201', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '359.1452', '-5389.113', '-23.30958', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '365.9248', '-5363.742', '-21.16536', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '384.3302', '-5356.516', '-22.07583', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '401.8826', '-5346.240', '-24.60424', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '417.1816', '-5331.885', '-27.10952', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '449.2878', '-5339.316', '-39.46656', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '478.1627', '-5354.213', '-43.77430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 06, (@POINT := @POINT + 1), '483.2733', '-5373.548', '-49.24841', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 07);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 07, (@POINT := @POINT + 1), '-348.0666', '-5577.971', '-32.64998', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-357.5493', '-5604.614', '-32.54316', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-380.1994', '-5623.577', '-31.47375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-412.2324', '-5631.504', '-31.97309', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-438.9145', '-5638.841', '-33.19761', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-459.0912', '-5648.773', '-34.10117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-471.5914', '-5669.522', '-33.25838', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-490.0464', '-5686.989', '-32.26326', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-512.8648', '-5686.814', '-36.96063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-530.8138', '-5673.190', '-35.95770', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-545.8073', '-5669.218', '-31.60473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-554.3489', '-5676.345', '-26.09570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-548.3919', '-5686.530', '-26.03271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-545.6289', '-5697.585', '-25.74463', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-558.8811', '-5718.676', '-23.57467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-555.4393', '-5742.337', '-26.51720', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-543.6359', '-5759.576', '-33.29772', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-545.6593', '-5779.448', '-32.52080', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-565.7188', '-5811.162', '-34.10390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-584.5605', '-5824.542', '-32.46045', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-614.8983', '-5821.754', '-32.86377', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-584.5605', '-5824.542', '-32.46045', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-565.7188', '-5811.162', '-34.10390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-545.6593', '-5779.448', '-32.52080', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-543.6359', '-5759.576', '-33.29772', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-555.4393', '-5742.337', '-26.51720', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-558.8811', '-5718.676', '-23.57467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-545.6289', '-5697.585', '-25.74463', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-548.3919', '-5686.530', '-26.03271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-554.3489', '-5676.345', '-26.09570', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-545.8073', '-5669.218', '-31.60473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-530.8138', '-5673.190', '-35.95770', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-512.8648', '-5686.814', '-36.96063', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-490.0464', '-5686.989', '-32.26326', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-471.5914', '-5669.522', '-33.25838', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-459.0912', '-5648.773', '-34.10117', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-438.9145', '-5638.841', '-33.19761', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-412.4659', '-5631.576', '-32.09028', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-380.1994', '-5623.577', '-31.47375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-357.5493', '-5604.614', '-32.54316', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-348.0666', '-5577.971', '-32.64998', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 07, (@POINT := @POINT + 1), '-318.7133', '-5564.043', '-32.55148', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 08);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 08, (@POINT := @POINT + 1), '-608.1886', '-5817.862', '-33.70899', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-636.5050', '-5820.905', '-28.45358', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-659.1743', '-5823.260', '-19.37738', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-691.7118', '-5820.370', '-20.50407', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-713.3483', '-5823.955', '-20.36920', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-751.2515', '-5827.444', '-21.73389', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-783.6209', '-5825.679', '-22.79669', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-808.2864', '-5822.929', '-29.95310', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-845.2535', '-5820.434', '-16.36810', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-875.6730', '-5822.888', '-12.82245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-909.9373', '-5825.713', '-12.14808', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-942.4223', '-5823.407', '-20.27853', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-980.9655', '-5821.277', '-22.57777', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1015.380', '-5815.631', '-30.79053', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1034.805', '-5795.985', '-28.10279', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1056.589', '-5790.917', '-26.02222', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1070.566', '-5793.046', '-25.00549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1094.363', '-5787.655', '-27.30798', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1114.446', '-5780.142', '-27.81094', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1128.797', '-5771.169', '-18.63370', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1147.591', '-5766.960', '-13.69177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1179.733', '-5766.318', '-14.88489', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1207.664', '-5765.576', '-13.84899', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1232.476', '-5768.130', '-17.94231', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1249.485', '-5772.077', '-21.22132', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1232.476', '-5768.130', '-17.94231', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1207.664', '-5765.576', '-13.84899', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1179.733', '-5766.318', '-14.88489', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1147.591', '-5766.960', '-13.69177', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1128.797', '-5771.169', '-18.63370', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1114.446', '-5780.142', '-27.81094', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1094.363', '-5787.655', '-27.30798', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1070.566', '-5793.046', '-25.00549', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1056.589', '-5790.917', '-26.02222', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1034.805', '-5795.985', '-28.10279', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-1015.380', '-5815.631', '-30.79053', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-980.9655', '-5821.277', '-22.57777', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-942.4223', '-5823.407', '-20.27853', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-909.9373', '-5825.713', '-12.14808', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-875.6730', '-5822.888', '-12.82245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-845.2535', '-5820.434', '-16.36810', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-808.2864', '-5822.929', '-29.95310', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-783.6209', '-5825.679', '-22.79669', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-751.2515', '-5827.444', '-21.73389', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-713.3483', '-5823.955', '-20.36920', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-691.7118', '-5820.370', '-20.50407', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-659.1743', '-5823.260', '-19.37738', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-636.5050', '-5820.905', '-28.45358', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-608.1886', '-5817.862', '-33.70899', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 08, (@POINT := @POINT + 1), '-581.4075', '-5813.840', '-31.54468', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 09);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 09, (@POINT := @POINT + 1), '-1414.717', '-5785.945', '-18.28851', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1429.123', '-5803.252', '-21.42676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1440.071', '-5818.405', '-23.65052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1473.324', '-5817.655', '-28.52335', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1493.109', '-5817.798', '-30.55362', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1515.078', '-5820.915', '-30.82909', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1546.918', '-5824.502', '-30.41975', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1576.580', '-5830.682', '-26.95949', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1609.989', '-5827.751', '-22.25511', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1649.508', '-5819.800', '-18.23368', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1656.176', '-5794.950', '-11.23240', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1638.662', '-5767.847', '-23.09690', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1641.793', '-5751.137', '-26.11779', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1618.052', '-5731.528', '-29.60553', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1600.349', '-5710.068', '-28.90900', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1617.423', '-5693.512', '-23.34335', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1640.375', '-5682.300', '-22.65612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1660.634', '-5671.528', '-26.17687', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1686.911', '-5662.636', '-27.36601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1698.239', '-5629.519', '-27.07917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1712.572', '-5613.549', '-27.77460', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1728.000', '-5592.728', '-26.94653', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1744.330', '-5587.043', '-30.40704', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1728.000', '-5592.728', '-26.94653', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1712.572', '-5613.549', '-27.77460', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1698.239', '-5629.519', '-27.07917', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1686.911', '-5662.636', '-27.36601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1660.634', '-5671.528', '-26.17687', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1640.375', '-5682.300', '-22.65612', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1617.423', '-5693.512', '-23.34335', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1600.349', '-5710.068', '-28.90900', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1618.052', '-5731.528', '-29.60553', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1641.793', '-5751.137', '-26.11779', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1638.662', '-5767.847', '-23.09690', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1656.176', '-5794.950', '-11.23240', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1649.508', '-5819.800', '-18.23368', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1609.989', '-5827.751', '-22.25511', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1576.580', '-5830.682', '-26.95949', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1546.918', '-5824.502', '-30.41975', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1515.078', '-5820.915', '-30.82909', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1493.109', '-5817.798', '-30.55362', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1473.324', '-5817.655', '-28.52335', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1440.071', '-5818.405', '-23.65052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1429.123', '-5803.252', '-21.42676', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1414.717', '-5785.945', '-18.28851', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 09, (@POINT := @POINT + 1), '-1368.822', '-5777.984', '-19.77502', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 10);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 10, (@POINT := @POINT + 1), '-1776.081', '-5589.009', '-34.18173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1803.558', '-5594.414', '-34.12356', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1823.099', '-5600.482', '-33.48129', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1856.045', '-5605.799', '-33.92609', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1873.247', '-5594.561', '-36.22752', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1884.442', '-5579.096', '-39.40404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1896.791', '-5559.878', '-39.60547', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1889.671', '-5539.566', '-37.13672', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1871.801', '-5526.505', '-38.08211', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1846.049', '-5521.628', '-40.42604', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1827.922', '-5477.870', '-35.56777', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1820.318', '-5455.870', '-30.86184', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1804.972', '-5430.848', '-35.17406', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1779.959', '-5415.255', '-34.33684', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1766.378', '-5396.977', '-33.19410', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1779.959', '-5415.255', '-34.33684', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1804.972', '-5430.848', '-35.17406', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1820.318', '-5455.870', '-30.86184', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1827.922', '-5477.870', '-35.56777', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1846.049', '-5521.628', '-40.42604', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1871.801', '-5526.505', '-38.08211', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1889.671', '-5539.566', '-37.13672', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1896.791', '-5559.878', '-39.60547', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1884.442', '-5579.096', '-39.40404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1873.247', '-5594.561', '-36.22752', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1856.045', '-5605.799', '-33.92609', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1823.099', '-5600.482', '-33.48129', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1803.558', '-5594.414', '-34.12356', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1776.081', '-5589.009', '-34.18173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 10, (@POINT := @POINT + 1), '-1755.496', '-5592.202', '-32.99152', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 11);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 11, (@POINT := @POINT + 1), '-1142.711', '-4322.336', '-7.514394', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1145.222', '-4345.001', '-9.041511', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1160.349', '-4357.775', '-12.11841', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1176.233', '-4369.198', '-13.35694', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1169.887', '-4381.364', '-14.98853', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1166.834', '-4391.783', '-13.77357', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1184.732', '-4412.307', '-13.05519', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1183.193', '-4430.994', '-10.80470', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1202.447', '-4460.210', '-6.748327', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1215.991', '-4472.520', '-8.580442', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1208.834', '-4488.687', '-6.471312', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1188.059', '-4498.218', '-4.539361', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1169.258', '-4479.332', '-4.284722', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1162.066', '-4452.037', '-4.664849', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1155.305', '-4427.696', '-7.986797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1165.516', '-4412.070', '-11.33738', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1159.323', '-4392.171', '-11.84208', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1144.141', '-4381.103', '-9.759070', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1133.105', '-4355.526', '-8.964375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1120.305', '-4335.307', '-8.061429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 11, (@POINT := @POINT + 1), '-1119.314', '-4321.887', '-7.848064', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

-- Removed duplicate Midsummer bonefires in Ironforge. Also fixed the model used
-- Thanks 249CAAFE40 for pointing. This closes #659
DELETE FROM `creature` WHERE `guid` = 1882;
UPDATE `creature` SET `modelid` = 0 WHERE `guid` = 94910;

-- Added missing equipment to NPC 5124 (Sognar Cliffbeard) in Ironforge
-- Thanks Tobschinski for reporting. This closes #660
UPDATE `creature_template` SET `EquipmentTemplateId` = 515 WHERE `Entry` = 5124;
DELETE FROM `creature_addon` WHERE `guid` = (SELECT `guid` FROM `creature` WHERE `id` = 5124);


-- Fixed wrong equipment item model in [0646]. Thanks Tobschinski for pointing.
DELETE FROM `creature_equip_template_raw` WHERE entry = 2413;
DELETE FROM `creature_equip_template` WHERE entry = 2413;
INSERT INTO `creature_equip_template` VALUES (2413, 3433, 0 ,5870);

-- Fixed sheathed equipment for NPC 844 (Antonio Perrelli). Thanks Tobschinski for pointing.
DELETE FROM `creature_addon` WHERE `guid` = (SELECT `guid` FROM `creature` WHERE `id` = 844);

-- Fixed quest / gameobjects relation in Darkshore for the washed ashore quest line (Alliance only)
-- Thanks Galatean for reporting. Thanks trulynullified for fixing.
-- This closes #647 
UPDATE `gameobject_questrelation` SET `quest` = '4728' WHERE `id` = '175226';
UPDATE `gameobject_questrelation` SET `quest` = '4730' WHERE `id` = '175227';
UPDATE `gameobject_questrelation` SET `quest` = '4722' WHERE `id` = '176190';
UPDATE `gameobject_questrelation` SET `quest` = '4732' WHERE `id` = '176191';
UPDATE `gameobject_questrelation` SET `quest` = '4727' WHERE `id` = '176196';
UPDATE `gameobject_questrelation` SET `quest` = '4725' WHERE `id` = '176197';
UPDATE `gameobject_questrelation` SET `quest` = '4731' WHERE `id` = '176198';
UPDATE `gameobject_questrelation` SET `quest` = '4733' WHERE `id` = '175230';
UPDATE `gameobject_questrelation` SET `quest` = '4723' WHERE `id` = '175233';

-- Fixed quest text for quest 4727 (Beached Sea Turtle) which was using text from a similar quest instead
UPDATE `quest_template` SET `OfferRewardText` = 'You\'ve found even more beached creatures, $N?  Sea turtles were commonly found frolicking along the base of Nordrassil before it was destroyed.  With the birth of Teldrassil, however, these creatures have been seen in ever decreasing numbers.  Some, as we have discovered, end their lives here for some unknown reason.$B$BYour aid will perhaps unlock the mystery before us.  Please accept this in exchange for the remains you have provided for our study.' WHERE `entry` = 4727;

-- Added missing GO 175966 (Enchanted Scarlet Thread) in Stratholme
-- Also put them into a pool
-- Source: YTDB
SET @GUID := 511875;
SET @POOL := 15005;
DELETE FROM `gameobject` WHERE `guid` IN (@GUID, @GUID + 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID, 175966, 329, 3457.5, -3111.17, 137.482, 2.023, 0, 0, 0.847629, 0.53059, 43200, 100, 1),
(@GUID + 1, 175966, 329, 3585.85, -3061.59, 136.515, 5.31, 0, 0, 0.467617, -0.883931, 43200, 100, 1);

DELETE FROM `pool_gameobject_template` WHERE `id` = 175966;
INSERT INTO `pool_gameobject_template` VALUES
(175966, @POOL, 0, 'Enchanted Scarlet Thread (175966)');

DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` VALUES
(@POOL, 2, 'Enchanted Scarlet Thread (175966) - Stratholme');
-- Fixed graveyard for Alliance in Ratchet. Thanks Metalica for pointing. This closes #624
DELETE FROM `game_graveyard_zone` WHERE `id` = 249 AND `ghost_zone` = 215;
UPDATE `game_graveyard_zone` SET `faction` = 0 WHERE `id` = 249 AND `ghost_zone` = 17;

-- Alliance players dying in Mulgore and Thunder Bluff are now ported to Bloodhoof Village graveyard
-- as they should instead of Ratchet
-- Source: http://www.wowwiki.com/Mulgore#Patch_changes
UPDATE `game_graveyard_zone` SET `faction` = 0 WHERE `id` = 89 AND `ghost_zone` = 215;
UPDATE `game_graveyard_zone` SET `id` = 89 WHERE `faction` = 469 AND `ghost_zone` = 1638;

-- Fixed respawntime of GO 177287 (Unfinished Painting)
-- Thanks TheTrueAnimal for reporting. This closes #676 
-- Source: https://www.youtube.com/watch?v=2Dm3YwxxJUo
UPDATE `gameobject` SET `spawntimesecs` = '0' WHERE `id` = '177287';

-- Fixed drop chance of item 5339 (Serpent Bloom) in Wailing Caverns
-- Though a quest objective, it is lootable by everyone and should have a 100% drop chance
-- Also removed wrong loot content in GO 13891 (Serpent Bloom)
-- Thanks TheTrueAnimal for reporting, Sinoxan for researching. This closes #674 
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` = 5339;
DELETE FROM `gameobject_loot_template` WHERE `entry` = 2772 AND `item` <> 5339;

-- Improved start script for quest 1064 (Forsaken Aid)
-- Added missing spell visual
DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 1064 AND `delay` = 3;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(1064, 3, 15, 6657, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');


SET @SHADOWDELVE := '14363'; -- Thief Catcher Shadowdelve

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@SHADOWDELVE);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4896.550', `position_y`='-996.0091', `position_z`='504.0237', `orientation`='0.6960631', `MovementType`='2' WHERE `id`=@SHADOWDELVE;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@SHADOWDELVE;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4885.096', '-986.4387', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4888.364', '-983.6744', '503.9405', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4895.207', '-985.1433', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4904.652', '-975.4191', '501.4508', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4908.016', '-960.3723', '501.5012', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4880.324', '-920.6398', '501.5753', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4833.688', '-904.1839', '501.6598', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4797.364', '-906.4210', '497.9217', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4780.092', '-905.9431', '499.2118', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4763.683', '-907.0504', '501.6255', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4721.881', '-922.5632', '501.6541', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4691.694', '-946.5085', '501.6670', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4679.948', '-969.9567', '501.6992', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4650.121', '-982.7744', '501.6564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4635.554', '-960.3665', '501.6609', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4651.672', '-935.2123', '501.6579', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4687.276', '-922.1450', '501.6603', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4721.487', '-905.8834', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4757.437', '-890.9809', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4785.496', '-884.3284', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4815.042', '-883.2499', '501.6677', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4846.717', '-886.1057', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4886.973', '-891.7634', '501.6593', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4906.807', '-884.8439', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4929.052', '-856.4695', '501.6614', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4952.721', '-869.0760', '501.6613', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4988.777', '-898.9862', '501.6362', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-5017.839', '-932.5099', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4985.217', '-957.6404', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4958.795', '-941.6141', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4947.842', '-930.1240', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4950.354', '-921.7192', '504.2645', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4961.114', '-913.8481', '503.8348', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4956.323', '-904.1819', '503.8368', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4950.286', '-908.2200', '503.8357', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4950.209', '-918.2828', '504.2613', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4942.204', '-927.9940', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4935.647', '-936.2831', '503.0424', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4931.629', '-949.3468', '501.6228', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4915.165', '-957.8141', '501.5400', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4906.877', '-973.0106', '501.4532', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4898.353', '-983.7513', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SHADOWDELVE, (@POINT := @POINT + 1), '-4891.350', '-992.1207', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @FARMOUNTAIN := '14365'; -- Thief Catcher Farmountain

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@FARMOUNTAIN);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4956.434', `position_y`='-906.7910', `position_z`='503.9225', `orientation`='3.836208', `MovementType`='2' WHERE `id`=@FARMOUNTAIN;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@FARMOUNTAIN;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4963.365', '-912.5651', '503.8351', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4955.276', '-916.4485', '504.2614', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4944.974', '-929.2750', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4973.284', '-956.8936', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4992.383', '-979.8217', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4994.909', '-996.2097', '501.6608', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-5007.273', '-1025.464', '501.6562', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-5014.620', '-1054.751', '501.7294', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-5016.097', '-1099.324', '501.6745', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-5011.856', '-1112.884', '501.6742', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-5007.002', '-1116.343', '501.6876', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-5003.024', '-1142.076', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4998.460', '-1179.694', '501.6604', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4982.609', '-1226.394', '501.6788', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4944.211', '-1255.974', '501.6630', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4925.567', '-1250.108', '501.6418', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4923.098', '-1236.333', '501.6560', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4945.754', '-1214.150', '501.6548', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4969.667', '-1187.341', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4991.060', '-1151.823', '501.6537', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4997.530', '-1115.960', '501.6314', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4994.735', '-1091.497', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4992.421', '-1058.819', '497.9618', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4992.421', '-1058.819', '497.9618', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4989.006', '-1039.414', '501.6601', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4983.643', '-1019.235', '501.6526', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4962.486', '-981.2289', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4929.968', '-957.3575', '501.5874', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4915.203', '-960.3139', '501.4894', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4904.061', '-976.8671', '501.4414', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4896.077', '-987.4464', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4896.048', '-992.9202', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4889.553', '-993.4305', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4884.642', '-985.4946', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4888.783', '-984.3502', '503.9405', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4894.861', '-986.5887', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4899.702', '-980.8641', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4904.338', '-974.5950', '501.4507', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4914.213', '-959.8905', '501.5282', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4935.674', '-935.8187', '503.0679', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4949.081', '-919.8021', '504.2644', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FARMOUNTAIN, (@POINT := @POINT + 1), '-4959.338', '-908.1340', '503.8360', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @THUNDERBREW := '14367'; -- Thief Catcher Thunderbrew

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@THUNDERBREW);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4824.520', `position_y`='-1168.4150', `position_z`='502.2844', `orientation`='0.05302288', `MovementType`='2' WHERE `id`=@THUNDERBREW;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@THUNDERBREW;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@THUNDERBREW, (@POINT := @POINT + 1), '-4789.093', '-1166.5350', '502.2258', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4758.693', '-1159.6350', '502.2123', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4730.106', '-1194.2480', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4719.517', '-1218.3540', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4740.718', '-1244.5340', '501.6592', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4724.864', '-1277.6100', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4694.163', '-1265.8870', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4682.361', '-1259.1080', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4664.030', '-1243.1180', '501.9927', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4643.821', '-1214.2370', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4647.422', '-1189.8260', '501.6544', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4683.809', '-1195.8010', '501.6590', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4708.729', '-1200.7670', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4732.161', '-1176.4560', '501.6978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4747.495', '-1152.9930', '502.2064', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4734.040', '-1106.0400', '502.2181', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4738.371', '-1074.0730', '502.2418', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4762.797', '-1042.3680', '502.2115', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4788.038', '-1030.8930', '502.2079', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4816.683', '-1027.2800', '502.1957', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4826.917', '-1014.3390', '502.2123', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4838.749', '-977.66580', '501.8416', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4850.542', '-941.90900', '501.5055', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4866.628', '-946.19140', '501.4519', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4883.959', '-942.70810', '501.4178', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4908.408', '-967.71200', '501.4664', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4901.270', '-979.61580', '503.0475', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4894.480', '-986.55600', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4886.826', '-988.18080', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4894.627', '-994.62760', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4895.386', '-986.91030', '503.9404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4905.212', '-975.29350', '501.4462', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4915.479', '-959.21370', '501.5359', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4936.558', '-935.24610', '503.1360', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4951.304', '-916.99350', '504.2646', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4951.812', '-906.41910', '503.8361', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4960.936', '-907.57750', '503.8362', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4962.912', '-915.03820', '503.8346', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4952.596', '-917.66530', '504.2635', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4938.362', '-936.40620', '503.1531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4927.755', '-951.20630', '501.6015', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4937.900', '-980.27130', '501.4769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4943.053', '-998.15500', '501.4404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4943.612', '-1014.5180', '501.4404', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4948.514', '-1023.7060', '501.4620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4924.298', '-1036.7850', '501.7220', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4885.191', '-1057.8440', '502.1472', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4873.420', '-1069.6380', '502.2016', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4872.613', '-1106.7500', '502.1995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4858.562', '-1134.9510', '502.1884', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4842.917', '-1155.2710', '502.1171', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@THUNDERBREW, (@POINT := @POINT + 1), '-4820.896', '-1169.2980', '502.2008', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @SRAAZ := '9099'; -- Sraaz

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@SRAAZ);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4756.994', `position_y`='-1154.7340', `position_z`='502.2956', `orientation`='3.701010', `MovementType`='2' WHERE `id`=@SRAAZ;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@SRAAZ;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@SRAAZ, (@POINT := @POINT + 1), '-4774.401', '-1165.6340', '502.2124', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4790.139', '-1168.6600', '502.2254', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4815.048', '-1167.4000', '502.2048', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4836.729', '-1156.8980', '502.1668', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4854.076', '-1143.5300', '502.2069', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4867.312', '-1122.6440', '502.1823', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4873.944', '-1090.7310', '502.2140', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4868.064', '-1085.2770', '502.2046', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4829.619', '-1085.2750', '502.2084', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4812.885', '-1065.8780', '502.1967', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4810.180', '-1032.0500', '502.1985', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4797.529', '-1025.6460', '502.2035', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4764.070', '-1041.1130', '502.2115', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4737.233', '-1073.9190', '502.2396', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4732.991', '-1106.3140', '502.2190', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4741.397', '-1139.0810', '502.2007', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SRAAZ, (@POINT := @POINT + 1), '-4756.994', '-1154.7340', '502.2123', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @GUID := '144'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-5050.712', `position_y`='-810.2087', `position_z`='495.2109', `orientation`='1.361725', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-5045.773', '-786.9305', '495.2132', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5061.846', '-752.7072', '481.8096', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5097.768', '-740.2383', '468.6567', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5133.368', '-741.2177', '459.3947', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5166.305', '-739.1543', '450.9035', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5187.297', '-733.2242', '447.4483', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5203.363', '-699.6258', '438.4007', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5218.088', '-666.4339', '430.1400', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5228.595', '-633.1194', '421.7410', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5237.807', '-599.4499', '413.6968', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5241.627', '-566.6175', '403.4313', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5243.015', '-532.7789', '391.0985', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5256.577', '-498.8654', '386.2344', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '1.951077', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5243.385', '-533.1536', '391.2333', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5242.362', '-566.6934', '403.3719', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5238.352', '-599.8167', '413.7559', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5229.088', '-633.2765', '421.6609', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5218.850', '-666.7302', '430.0223', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5204.014', '-699.4961', '438.3316', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5188.978', '-733.1346', '447.0623', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5166.568', '-740.9424', '450.8019', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5133.428', '-742.4106', '459.3805', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5100.030', '-742.1588', '467.9603', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5066.893', '-749.7949', '479.0317', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5054.690', '-766.5782', '488.9085', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5050.706', '-799.8795', '495.2132', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5050.173', '-811.2641', '495.2521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5045.451', '-815.5643', '495.2521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5050.712', '-810.2087', '495.2521', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-5050.712', '-810.2087', '495.2521', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '4.729842', '0', '0');


SET @GUID := '1894'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4800.571', `position_y`='-1027.3610', `position_z`='502.2889', `orientation`='6.120802', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4783.109', '-1030.2210', '502.2087', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4764.898', '-1039.7820', '502.2114', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4746.893', '-1056.7650', '502.2387', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4734.417', '-1080.3780', '502.2124', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4732.405', '-1105.0680', '502.2192', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4738.651', '-1131.4270', '502.2089', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4747.607', '-1146.2290', '502.2102', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4760.845', '-1144.4210', '502.2124', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4770.223', '-1134.0510', '499.9824', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4785.496', '-1120.5330', '498.8060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4792.576', '-1112.7070', '498.8072', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4792.646', '-1105.1830', '498.8072', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4803.730', '-1091.7740', '499.4382', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4813.405', '-1078.9990', '502.2188', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4812.579', '-1064.7830', '502.1976', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4810.207', '-1046.0230', '502.1970', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4809.493', '-1036.1500', '502.2053', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4800.306', '-1026.9120', '502.2059', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @GUID := '1895'; -- Ironforge Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4874.089', `position_y`='-1090.3040', `position_z`='502.2973', `orientation`='4.767289', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-4873.168', '-1107.0780', '502.1995', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4866.706', '-1125.3990', '502.1795', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4855.071', '-1143.8020', '502.1944', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4836.417', '-1159.5780', '502.1925', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4814.893', '-1167.7510', '502.2046', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4790.182', '-1167.7950', '502.2260', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4765.064', '-1160.0570', '502.1873', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4763.539', '-1152.7280', '502.2124', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4778.483', '-1131.8860', '498.8080', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4795.002', '-1115.8850', '498.8072', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4804.095', '-1112.7490', '498.8071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4807.448', '-1107.6990', '498.8071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4808.890', '-1101.9740', '498.8071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4822.939', '-1086.6750', '502.2159', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4833.822', '-1085.0890', '502.2042', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4856.700', '-1084.2080', '502.1920', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4866.897', '-1084.1640', '502.2027', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-4874.189', '-1090.3630', '502.2141', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @GUID := '33988'; -- Theramore Sentry

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-2884.233', `position_y`='-3421.983', `position_z`='75.22582', `orientation`='2.973199', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-2890.391', '-3420.9360', '75.14247', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2890.355', '-3425.1440', '74.31193', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2887.165', '-3431.1870', '70.04095', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2883.404', '-3432.4980', '69.11050', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2881.354', '-3427.8630', '67.63020', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2883.900', '-3421.6560', '64.32716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2888.060', '-3420.1400', '64.05618', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2894.279', '-3421.7830', '62.46924', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2895.347', '-3432.7220', '59.30888', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2889.064', '-3436.1730', '55.76531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2879.695', '-3430.7790', '53.63267', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2879.491', '-3424.3420', '50.32526', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2888.417', '-3417.0010', '47.58076', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2895.876', '-3422.2820', '44.82439', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2898.244', '-3429.3220', '42.80464', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2894.986', '-3433.5540', '40.09473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2890.378', '-3434.4910', '40.05248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2885.449', '-3429.5500', '40.05105', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2874.388', '-3424.7000', '40.04735', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2885.449', '-3429.5500', '40.05105', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2890.378', '-3434.4910', '40.05248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2894.986', '-3433.5540', '40.09473', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2898.244', '-3429.3220', '42.80464', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2895.876', '-3422.2820', '44.82439', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2888.417', '-3417.0010', '47.58076', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2879.491', '-3424.3420', '50.44801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2879.695', '-3430.7790', '53.63267', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2889.063', '-3436.1730', '56.14276', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2895.347', '-3432.7220', '59.30888', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2894.279', '-3421.7830', '62.46924', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2888.060', '-3420.1400', '64.05618', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2883.900', '-3421.6560', '64.32716', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2881.354', '-3427.8630', '67.63020', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2883.404', '-3432.4980', '69.11050', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2886.807', '-3431.8650', '69.55936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2890.355', '-3425.1440', '74.33042', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2890.391', '-3420.9360', '75.14247', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2883.524', '-3422.5080', '75.14247', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @GUID := '33893'; -- Theramore Sentry

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-2905.880', `position_y`='-3424.5640', `position_z`='40.13115', `orientation`='4.763484', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-2905.330', '-3435.3180', '39.96030', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2899.780', '-3442.4150', '40.08151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2893.385', '-3445.4210', '39.98938', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2885.393', '-3445.8940', '40.05820', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2876.094', '-3441.7920', '39.98660', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2870.970', '-3435.4440', '40.03884', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2869.718', '-3429.2910', '40.04797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2871.232', '-3419.8690', '40.04797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2877.857', '-3412.2110', '40.04207', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2888.735', '-3410.0370', '40.04112', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2897.262', '-3412.5130', '40.06449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2903.723', '-3418.1760', '40.01704', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2906.327', '-3425.3110', '40.01620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @GUID := '33991'; -- Theramore Sentry

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-2868.661', `position_y`='-3423.4900', `position_z`='40.13130', `orientation`='4.780951', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-2867.939', '-3434.0100', '40.06625', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2873.997', '-3444.1060', '39.92670', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2885.609', '-3450.1910', '40.07593', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2895.702', '-3447.9080', '39.93052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2905.374', '-3441.5860', '40.14555', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2908.768', '-3434.2870', '39.91129', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2909.646', '-3426.4960', '39.97071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2906.835', '-3414.6380', '40.02058', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2900.900', '-3409.2640', '40.07021', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2894.011', '-3406.2900', '40.12309', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2885.169', '-3406.1270', '40.03277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2876.822', '-3409.8230', '39.99891', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2870.925', '-3415.9580', '40.04797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2866.849', '-3424.3550', '40.04797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @GUID := '31344'; -- Theramore Sentry

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-2889.708', `position_y`='-3318.7480', `position_z`='31.27396', `orientation`='2.398329', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-2905.646', '-3304.0990', '31.77243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2915.960', '-3292.1950', '31.91731', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2930.354', '-3268.0230', '31.54231', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2941.833', '-3258.1780', '31.27243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2948.270', '-3251.2840', '31.43088', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2976.800', '-3242.8420', '32.78296', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2997.709', '-3237.1340', '33.83252', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2998.629', '-3244.9980', '34.12817', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3000.839', '-3235.7740', '33.92015', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3016.902', '-3227.3430', '34.02878', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3045.638', '-3214.4090', '33.98430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3059.448', '-3209.5890', '33.35930', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3078.848', '-3208.8070', '33.15851', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3094.927', '-3210.4960', '33.43317', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3078.848', '-3208.8070', '33.15851', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3059.448', '-3209.5890', '33.35930', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3045.638', '-3214.4090', '33.98430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3016.902', '-3227.3430', '34.02878', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3000.839', '-3235.7740', '33.92015', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2998.629', '-3244.9980', '34.12817', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2997.709', '-3237.1340', '33.83252', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2976.800', '-3242.8420', '32.78296', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2948.270', '-3251.2840', '31.43088', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2941.833', '-3258.1780', '31.27243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2930.354', '-3268.0230', '31.54231', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2915.960', '-3292.1950', '31.91731', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2905.646', '-3304.0990', '31.77243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-2886.695', '-3315.8650', '31.41194', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


-- -------------------------------------

UPDATE `creature` SET `position_x`='-2890.217', `position_y`='-3427.3110', `position_z`='40.13894', `orientation`='3.33208500', `spawndist`='1', `MovementType`='1' WHERE `guid`='33895';
UPDATE `creature` SET `position_x`='-2885.137', `position_y`='-3434.4910', `position_z`='40.13694', `orientation`='2.89824200', `spawndist`='1', `MovementType`='1' WHERE `guid`='33917';
UPDATE `creature` SET `position_x`='-2885.085', `position_y`='-3419.2660', `position_z`='48.02174', `orientation`='1.74031200', `spawndist`='1', `MovementType`='1' WHERE `guid`='31322';
UPDATE `creature` SET `position_x`='-2882.128', `position_y`='-3433.5160', `position_z`='53.84687', `orientation`='6.01700900', `spawndist`='1', `MovementType`='1' WHERE `guid`='31323';
UPDATE `creature` SET `position_x`='-2895.764', `position_y`='-3429.3700', `position_z`='59.45377', `orientation`='4.12601600', `spawndist`='1', `MovementType`='1' WHERE `guid`='31324';
UPDATE `creature` SET `position_x`='-2891.701', `position_y`='-3420.8070', `position_z`='75.22581', `orientation`='2.79531600', `spawndist`='1', `MovementType`='1' WHERE `guid`='31326';
UPDATE `creature` SET `position_x`='-2892.788', `position_y`='-3433.1530', `position_z`='75.22582', `orientation`='3.13859600', `spawndist`='1', `MovementType`='1' WHERE `guid`='31327';
UPDATE `creature` SET `position_x`='-2896.232', `position_y`='-3349.9230', `position_z`='31.42304', `orientation`='1.63860700', `spawndist`='1', `MovementType`='1' WHERE `guid`='31274';
UPDATE `creature` SET `position_x`='-2891.220', `position_y`='-3344.7020', `position_z`='32.34992', `orientation`='2.97209500', `spawndist`='1', `MovementType`='1' WHERE `guid`='31271';
UPDATE `creature` SET `position_x`='-2889.718', `position_y`='-3337.9230', `position_z`='32.47049', `orientation`='5.58505300', `spawndist`='1', `MovementType`='1' WHERE `guid`='31268';
UPDATE `creature` SET `position_x`='-3093.748', `position_y`='-3214.6560', `position_z`='33.97084', `orientation`='1.74532900', `spawndist`='1', `MovementType`='1' WHERE `guid`='31273';
UPDATE `creature` SET `position_x`='-3101.218', `position_y`='-3211.5910', `position_z`='33.96617', `orientation`='0.06981317', `spawndist`='1', `MovementType`='1' WHERE `guid`='31262';
UPDATE `creature` SET `position_x`='-3006.095', `position_y`='-3244.0720', `position_z`='34.71600', `orientation`='0.45505880', `spawndist`='1', `MovementType`='1' WHERE `guid`='31434';
UPDATE `creature` SET `position_x`='-2997.980', `position_y`='-3249.8850', `position_z`='34.80450', `orientation`='1.69891700', `spawndist`='1', `MovementType`='1' WHERE `guid`='31437';



SET @GUID := '30814'; -- Sentry Point Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-3463.651', `position_y`='-4129.8440', `position_z`='17.05344', `orientation`='5.086615', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-3458.164', '-4143.8150', '11.80710', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3450.980', '-4148.4200', '10.86265', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3443.454', '-4156.0670', '9.985451', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3431.455', '-4163.4940', '10.08993', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3429.472', '-4166.1450', '10.20297', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3421.273', '-4160.1170', '10.65048', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3436.642', '-4150.4520', '10.49375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3442.773', '-4137.0180', '11.23545', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3457.494', '-4124.1710', '16.96460', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3442.709', '-4136.4590', '11.23545', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3436.642', '-4150.4520', '10.49375', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3421.273', '-4160.1170', '10.65048', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3429.472', '-4166.1450', '10.20297', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3431.455', '-4163.4940', '10.08993', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3443.454', '-4156.0670', '9.985451', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3450.980', '-4148.4200', '10.86265', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3458.164', '-4143.8150', '11.80710', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3463.676', '-4130.4720', '16.96460', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @GUID := '30810'; -- Sentry Point Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-3459.885', `position_y`='-4116.3370', `position_z`='17.05344', `orientation`='1.173562', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-3456.429', '-4108.098', '16.94242', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3458.704', '-4098.343', '16.96465', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3465.677', '-4090.356', '16.97877', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3478.250', '-4088.281', '16.97186', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3490.270', '-4094.468', '16.85423', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3495.154', '-4109.317', '16.87564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3489.858', '-4121.281', '17.02257', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3477.155', '-4127.292', '16.93963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3462.605', '-4124.125', '16.96460', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3455.443', '-4131.077', '15.03870', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3462.605', '-4124.125', '16.96460', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3477.155', '-4127.292', '16.93963', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3489.858', '-4121.281', '17.02257', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3495.154', '-4109.317', '16.87564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3490.270', '-4094.468', '16.85423', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3478.250', '-4088.281', '16.97186', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3465.677', '-4090.356', '16.97877', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3458.704', '-4098.343', '16.96465', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3456.429', '-4108.098', '16.94242', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3459.407', '-4117.533', '16.96460', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @GUID := '30816'; -- Sentry Point Guard

-- -------------------------------------

SET @POINT := '0';

UPDATE `creature` SET `position_x`='-3472.252', `position_y`='-4116.7920', `position_z`='17.05920', `orientation`='2.712768', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_movement` WHERE `id`=@GUID;

INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, (@POINT := @POINT + 1), '-3480.223', '-4113.1470', '16.96792', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3484.659', '-4105.1750', '16.97011', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3479.773', '-4099.1900', '20.09231', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3472.436', '-4098.7010', '21.74103', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3466.221', '-4103.6350', '24.50929', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3465.935', '-4110.2000', '25.09506', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3470.240', '-4114.9580', '28.28775', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3477.901', '-4115.3430', '30.68018', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3482.958', '-4109.7890', '33.41206', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3482.230', '-4104.0480', '36.22615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3476.560', '-4099.8650', '37.12769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3471.047', '-4100.6940', '40.52042', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3468.138', '-4109.3990', '41.48971', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3473.422', '-4114.3300', '45.02025', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3479.796', '-4112.7050', '46.47600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3471.020', '-4102.6250', '52.05910', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3479.796', '-4112.7050', '46.47600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3473.430', '-4114.3370', '45.05516', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3468.162', '-4109.4210', '41.49479', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3471.047', '-4100.6940', '40.52042', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3476.560', '-4099.8650', '37.12769', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3482.230', '-4104.0480', '36.22615', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3482.958', '-4109.7890', '33.41206', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3477.901', '-4115.3430', '30.68018', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3470.240', '-4114.9580', '28.28519', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3466.510', '-4110.8350', '25.31569', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3466.221', '-4103.6350', '24.50929', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3472.436', '-4098.7010', '21.74103', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3479.773', '-4099.1900', '20.09231', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3484.659', '-4105.1750', '16.97011', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3480.223', '-4113.1470', '16.96792', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID, (@POINT := @POINT + 1), '-3472.327', '-4115.8670', '16.96620', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');




-- -------------------------------------

UPDATE `creature` SET `position_x`='-3440.111', `position_y`='-4138.4560', `position_z`='11.16662', `orientation`='0.88256250', `spawndist`='1', `MovementType`='1' WHERE `guid`='30812';
UPDATE `creature` SET `position_x`='-3464.859', `position_y`='-4126.0560', `position_z`='17.05344', `orientation`='1.96763800', `spawndist`='1', `MovementType`='1' WHERE `guid`='31137';
UPDATE `creature` SET `position_x`='-3475.719', `position_y`='-4115.6700', `position_z`='17.05912', `orientation`='3.08986400', `spawndist`='1', `MovementType`='1' WHERE `guid`='23512';
UPDATE `creature` SET `position_x`='-3471.299', `position_y`='-4107.6460', `position_z`='17.05888', `orientation`='4.03171100', `spawndist`='1', `MovementType`='1' WHERE `guid`='08457';
UPDATE `creature` SET `position_x`='-3468.549', `position_y`='-4112.4550', `position_z`='17.05681', `orientation`='1.08874800', `spawndist`='1', `MovementType`='1' WHERE `guid`='08458';



SET @RAEDON := '14725'; -- Raedon Duskstriker

SET @WOOL := '7792'; -- A Donation of Wool
SET @SILK := '7798'; -- A Donation of Silk

-- -------------------------

DELETE FROM `quest_template` WHERE `entry`IN (@WOOL, @SILK);
INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewOrReqMoney`, `RewMoneyMaxLevel`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`) VALUES
(@WOOL, '0', '1657', '12', '60', '0', '0', '77', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'A Donation of Wool', '', '', 'Wonderful! We thank you for your generous donation, $n!', 'If you have the sixty pieces of wool cloth on you and are ready to donate them, I\'m able to take them from you now.', '', '', '', '', '', '2592', '0', '0', '0', '60', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '69', '0', '0', '0', '0', '150', '0', '0', '0', '0', '0', '390', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SILK, '0', '1657', '26', '60', '0', '0', '77', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'A Donation of Silk', '', '', 'Wonderful! We thank you for your generous donation, $n!', 'A benevolent gift such as silk, might I add, would certainly increase your local standing in the community! If you have the sixty pieces of silk cloth on you and are ready to donate them, I\'m able to take them from you now.', '', '', '', '', '', '4306', '0', '0', '0', '60', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '69', '0', '0', '0', '0', '150', '0', '0', '0', '0', '0', '990', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0');

DELETE FROM `creature_questrelation` WHERE `id`=@RAEDON AND `quest` IN (@WOOL, @SILK);
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES
(@RAEDON, @WOOL),
(@RAEDON, @SILK);

DELETE FROM `creature_involvedrelation` WHERE `id`=@RAEDON AND `quest` IN (@WOOL, @SILK);
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES
(@RAEDON, @WOOL),
(@RAEDON, @SILK);




-- --------------------

-- Stormwind
UPDATE `quest_template` SET `ExclusiveGroup`='-7791' WHERE `entry`='7791';
UPDATE `quest_template` SET `ExclusiveGroup`='-7791' WHERE `entry`='7793';
UPDATE `quest_template` SET `ExclusiveGroup`='-7791' WHERE `entry`='7794';
UPDATE `quest_template` SET `PrevQuestId`='7791' WHERE `entry`='7795';

-- Darnassus
UPDATE `quest_template` SET `ExclusiveGroup`='-7792' WHERE `entry`='7792';
UPDATE `quest_template` SET `ExclusiveGroup`='-7792' WHERE `entry`='7798';
UPDATE `quest_template` SET `ExclusiveGroup`='-7792' WHERE `entry`='7799';
UPDATE `quest_template` SET `PrevQuestId`='7792' WHERE `entry`='7800';

-- Ironforge
UPDATE `quest_template` SET `ExclusiveGroup`='-7802' WHERE `entry`='7802';
UPDATE `quest_template` SET `ExclusiveGroup`='-7802' WHERE `entry`='7803';
UPDATE `quest_template` SET `ExclusiveGroup`='-7802' WHERE `entry`='7804';
UPDATE `quest_template` SET `PrevQuestId`='7802' WHERE `entry`='7805';

-- Gnomeregan
UPDATE `quest_template` SET `ExclusiveGroup`='-7807' WHERE `entry`='7807';
UPDATE `quest_template` SET `ExclusiveGroup`='-7807' WHERE `entry`='7808';
UPDATE `quest_template` SET `ExclusiveGroup`='-7807' WHERE `entry`='7809';
UPDATE `quest_template` SET `PrevQuestId`='7807' WHERE `entry`='7811';

-- Undercity
UPDATE `quest_template` SET `ExclusiveGroup`='-7813' WHERE `entry`='7813';
UPDATE `quest_template` SET `ExclusiveGroup`='-7813' WHERE `entry`='7814';
UPDATE `quest_template` SET `ExclusiveGroup`='-7813' WHERE `entry`='7817';
UPDATE `quest_template` SET `PrevQuestId`='7813' WHERE `entry`='7818';

-- Thunder Bluff
UPDATE `quest_template` SET `ExclusiveGroup`='-7820' WHERE `entry`='7820';
UPDATE `quest_template` SET `ExclusiveGroup`='-7820' WHERE `entry`='7821';
UPDATE `quest_template` SET `ExclusiveGroup`='-7820' WHERE `entry`='7822';
UPDATE `quest_template` SET `PrevQuestId`='7820' WHERE `entry`='7823';

-- Orgrimmar
UPDATE `quest_template` SET `ExclusiveGroup`='-7826' WHERE `entry`='7826';
UPDATE `quest_template` SET `ExclusiveGroup`='-7826' WHERE `entry`='7827';
UPDATE `quest_template` SET `ExclusiveGroup`='-7826' WHERE `entry`='7831';
UPDATE `quest_template` SET `PrevQuestId`='7826' WHERE `entry`='7824';

-- Darkspear Trolls
UPDATE `quest_template` SET `ExclusiveGroup`='-7833' WHERE `entry`='7833';
UPDATE `quest_template` SET `ExclusiveGroup`='-7833' WHERE `entry`='7834';
UPDATE `quest_template` SET `ExclusiveGroup`='-7833' WHERE `entry`='7835';
UPDATE `quest_template` SET `PrevQuestId`='7833' WHERE `entry`='7836';


SET @HEARTHSINGER := '10558';
SET @GUID := '2349';
SET @POOL := '25468';

-- ---------------------------------------------

DELETE FROM `creature` WHERE `id`=@HEARTHSINGER;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID + 00, @HEARTHSINGER, '329', '10482', '0', '3595.755', '-3509.928', '137.5008', '5.742133', '604800', '0', '0', '6960', '0', '0', '0'),
(@GUID + 01, @HEARTHSINGER, '329', '10482', '0', '3680.273', '-3512.372', '136.1522', '2.042035', '604800', '0', '0', '6960', '0', '0', '0'),
(@GUID + 02, @HEARTHSINGER, '329', '10482', '0', '3692.933', '-3363.162', '130.7527', '3.246312', '604800', '0', '0', '6960', '0', '0', '0'),
(@GUID + 03, @HEARTHSINGER, '329', '10482', '0', '3683.747', '-3334.066', '125.3195', '3.141593', '604800', '0', '0', '6960', '0', '0', '0');

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL, '1', 'Stratholme - Hearthsinger Forresten');

DELETE FROM `pool_creature` WHERE `pool_entry`=@POOL;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID + 00, @POOL, '25', 'Stratholme - Hearthsinger Forresten'),
(@GUID + 01, @POOL, '25', 'Stratholme - Hearthsinger Forresten'),
(@GUID + 02, @POOL, '25', 'Stratholme - Hearthsinger Forresten'),
(@GUID + 03, @POOL, '25', 'Stratholme - Hearthsinger Forresten');


SET @MYRA := '5109'; -- Myra Tyrngaarde

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@MYRA);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4925.116', `position_y`='-947.6945', `position_z`='501.6491', `orientation`='4.042188', `MovementType`='2' WHERE `id`=@MYRA;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@MYRA;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@MYRA, (@POINT := @POINT + 1), '-4940.067', '-966.5563', '501.5916', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4956.591', '-978.8500', '501.6491', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4966.608', '-974.9324', '502.7796', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4977.690', '-967.0145', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4978.871', '-957.0950', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4966.549', '-946.7832', '501.6595', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4946.386', '-929.8782', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4924.840', '-913.5948', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4904.366', '-898.4344', '501.6594', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4898.426', '-902.3857', '501.6593', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4891.908', '-916.8919', '501.6311', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4902.026', '-933.6296', '501.5292', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@MYRA, (@POINT := @POINT + 1), '-4925.541', '-947.7893', '501.6206', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


-- ---------------------------------

DELETE FROM `creature_loot_template` WHERE `item`='5796' AND `entry` IN ('4457', '4458', '4459', '4460', '4461');


SET @SLIPKIK := '14323'; -- Guard Slip'Kik

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@SLIPKIK);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='550.3804', `position_y`='533.7247', `position_z`='-25.31852', `orientation`='3.926991', `MovementType`='2' WHERE `id`=@SLIPKIK;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@SLIPKIK;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@SLIPKIK, (@POINT := @POINT + 1), '558.6339', '549.9158', '-25.39908', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '573.5057', '563.2197', '-25.40176', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '573.2263', '586.4570', '-25.40273', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '524.0547', '587.0665', '-25.40254', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '510.3508', '606.5667', '-25.40364', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '486.8481', '606.4826', '-25.40477', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '478.1636', '594.9525', '-25.40531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '477.4341', '579.6123', '-25.40210', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '504.7797', '574.7651', '-25.40086', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '477.4341', '579.6123', '-25.40210', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '478.1636', '594.9525', '-25.40531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '486.8481', '606.4826', '-25.40477', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '510.3508', '606.5667', '-25.40364', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '524.0547', '587.0665', '-25.40254', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '573.2263', '586.4570', '-25.40273', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '573.5057', '563.2197', '-25.40176', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '558.6339', '549.9158', '-25.39908', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@SLIPKIK, (@POINT := @POINT + 1), '550.9423', '528.1198', '-25.40169', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');




-- --------------

SET @CHORUSH := '14324'; -- Cho'Rush the Observer

UPDATE `creature` SET `position_x`='833.9951', `position_y`='489.5435', `position_z`='37.40153', `orientation`='3.211406', `MovementType`='0' WHERE `id`=@CHORUSH;


SET @FENGUS := '14321'; -- Guard Fengus

-- ----------------------------------------

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@FENGUS);
SET @POINT := '0';

UPDATE `creature` SET `position_x`='356.795', `position_y`='258.3065', `position_z`='11.65384', `orientation`='3.142583', `MovementType`='2' WHERE `id`=@FENGUS;

DELETE FROM `creature_movement` WHERE `id`=@GUID;
DELETE FROM `creature_movement_template` WHERE `entry`=@FENGUS;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@FENGUS, (@POINT := @POINT + 1), '316.5439', '258.2672', '11.22405', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '287.7441', '260.7287', '2.869437', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '290.6053', '280.1005', '2.848812', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '289.7671', '310.0473', '2.853041', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '300.0063', '328.7043', '2.852961', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '294.1508', '290.1005', '2.849759', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '288.6681', '260.1472', '2.870163', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '318.0658', '258.1307', '11.22347', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '352.2249', '259.8816', '11.20577', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '379.2898', '259.8564', '11.43955', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '383.1255', '280.3708', '12.23591', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '384.3981', '315.2444', '11.21198', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '385.5048', '342.4915', '2.862235', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '350.4333', '341.1977', '2.853369', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '313.9085', '338.8922', '2.852938', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '356.0100', '342.2071', '2.853216', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '388.9794', '340.4667', '2.864845', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '423.3712', '340.0448', '2.853797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '454.4482', '336.7815', '2.855228', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '417.1513', '339.7217', '2.853512', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '390.7901', '340.0213', '2.865798', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '386.5863', '316.9394', '10.87668', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '385.8260', '281.0563', '12.23588', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '385.6659', '260.2018', '11.43955', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '407.4470', '256.0239', '12.23423', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '444.0919', '255.3879', '11.20982', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '407.4797', '258.5080', '12.23421', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '384.6136', '256.4120', '11.43955', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@FENGUS, (@POINT := @POINT + 1), '358.8656', '258.3085', '12.23409', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


-- ----------------

UPDATE `gameobject` SET `position_x`='808.3697', `position_y`='482.1281', `position_z`='37.31820', `orientation`='0', `rotation2`='-0.9996567', `rotation3`='0.02620165' WHERE `guid`='35834';
UPDATE `gameobject` SET `position_x`='380.6145', `position_y`='260.0570', `position_z`='11.43955', `orientation`='0', `rotation2`='-0.4848089', `rotation3`='0.87462010' WHERE `guid`='35832';



-- ----------------------------------

UPDATE `gameobject_template` SET `size`='3' WHERE `entry`='179485';



-- -------------------------

UPDATE `gameobject` SET `position_x`='491.2043', `position_y`='515.1331', `position_z`='29.467530', `orientation`='0', `rotation2`='0.70710660', `rotation3`='0.7071069', `spawntimesecs`='0', `animprogress`='100' WHERE `id`='177217';
UPDATE `gameobject` SET `position_x`='385.3268', `position_y`='374.2315', `position_z`='-1.343140', `orientation`='0', `rotation2`='0.70710660', `rotation3`='0.7071069', `spawntimesecs`='0', `animprogress`='100' WHERE `id`='177219';
UPDATE `gameobject` SET `position_x`='351.5679', `position_y`='88.67347', `position_z`='-36.39297', `orientation`='0', `rotation2`='0.70710660', `rotation3`='0.7071069', `spawntimesecs`='0', `animprogress`='100' WHERE `id`='179549';
UPDATE `gameobject` SET `position_x`='83.25511', `position_y`='630.5456', `position_z`='-24.63151', `orientation`='0', `rotation2`='-0.3131638', `rotation3`='0.9496992', `spawntimesecs`='0', `animprogress`='100' WHERE `id`='179550';
UPDATE `gameobject` SET `position_x`='50.58631', `position_y`='501.9406', `position_z`='-23.14985', `orientation`='0', `rotation2`='-0.7071066', `rotation3`='0.7071069', `spawntimesecs`='0', `animprogress`='100' WHERE `id`='177221';




-- -------------------------

UPDATE `gameobject_template` SET `flags`='34', `size`='1.482917' WHERE `entry`='177217';
UPDATE `gameobject_template` SET `flags`='34' WHERE `entry`='177219';
UPDATE `gameobject_template` SET `faction`='114' WHERE `entry`='179549';
UPDATE `gameobject_template` SET `size`='1.02' WHERE `entry`='179550';
UPDATE `gameobject_template` SET `size`='0.465763' WHERE `entry`='177221';



-- -------------------------

UPDATE `item_template` SET `area`='2557', `Map`='429' WHERE `entry`='18268';
UPDATE `item_template` SET `area`='2557', `Map`='429' WHERE `entry`='18266';

UPDATE `gameobject` SET `position_x`='129.4811', `position_y`='544.9671', `position_z`='-48.46632', `orientation`='0', `rotation2`='0.7253742', `rotation3`='0.6883547', `spawntimesecs`='0', `animprogress`='100' WHERE `id`='179517';
UPDATE `gameobject_template` SET `flags`='4' WHERE `entry`='179517';


SET @GUID := '134912';

-- ---------------------------------------------

SET @EYEOFKILROGG := '14386';
SET @MAP := '429';
SET @RESPAWN := '0.25' * '60' * '60';

DELETE FROM `creature` WHERE `id`=@EYEOFKILROGG;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID + 00, @EYEOFKILROGG, @MAP, '0', '0', '560.9175', '545.4094', '-25.31721', '1.005476', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@EYEOFKILROGG), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@EYEOFKILROGG), '0', '2'),
(@GUID + 01, @EYEOFKILROGG, @MAP, '0', '0', '446.8329', '542.6426', '-21.81278', '3.261362', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@EYEOFKILROGG), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@EYEOFKILROGG), '0', '2');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 00);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 00, (@POINT := @POINT + 1), '577.1039', '570.9245', '-25.40290', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '572.0755', '582.9881', '-25.40273', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '544.6523', '593.1812', '-25.40273', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '500.8310', '579.0237', '-25.40101', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '484.0373', '575.8411', '-25.40182', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '476.5366', '584.7387', '-25.40356', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '494.3848', '591.6921', '-20.39891', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '534.3132', '590.4163', '-4.754774', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '550.6912', '591.4011', '-4.754772', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '568.8508', '584.2122', '-4.754771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '581.8668', '574.6851', '-4.755718', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '587.1575', '556.0428', '-1.718680', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '587.0223', '535.8848', '6.7701660', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '568.9283', '535.3513', '13.090810', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '545.4929', '534.3782', '25.665700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '568.9283', '535.3513', '13.090810', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '587.0223', '535.8848', '6.7701660', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '587.1575', '556.0428', '-1.718680', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '581.8668', '574.6851', '-4.755718', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '568.8508', '584.2122', '-4.754771', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '550.6912', '591.4011', '-4.754772', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '534.3132', '590.4163', '-4.754774', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '494.3848', '591.6921', '-20.39891', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '481.7606', '590.6141', '-25.40754', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '484.0373', '575.8411', '-25.40182', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '500.8310', '579.0237', '-25.40101', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '544.6523', '593.1812', '-25.40273', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '572.0755', '582.9881', '-25.40273', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '577.1039', '570.9245', '-25.40290', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 00, (@POINT := @POINT + 1), '563.5419', '547.6833', '-25.39905', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

SET @POINT := '0';
DELETE FROM `creature_movement` WHERE `id`=(@GUID + 01);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID + 01, (@POINT := @POINT + 1), '428.5866', '550.3541', '-18.33062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '413.2478', '549.2036', '-18.33061', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '410.8050', '537.9805', '-18.00485', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '399.8401', '525.5711', '-12.77508', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '389.6866', '500.6979', '-12.01533', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '385.3872', '475.1862', '-7.219529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '395.8070', '468.8721', '-7.219531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '396.1824', '455.4167', '-7.219535', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '388.5278', '448.8068', '-7.219536', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '384.2072', '434.8414', '-5.553133', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '384.5225', '423.3623', '-3.128052', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '385.2957', '413.9088', '-1.672135', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '384.2072', '434.8414', '-5.553133', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '388.5278', '448.8068', '-7.219536', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '396.1824', '455.4167', '-7.219535', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '395.8070', '468.8721', '-7.219531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '385.3872', '475.1862', '-7.219529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '389.6866', '500.6979', '-12.01533', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '399.6569', '525.3637', '-12.77500', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '410.8050', '537.9805', '-18.00485', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '413.2478', '549.2036', '-18.33061', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '428.5866', '550.3541', '-18.33062', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '445.9710', '542.5389', '-21.56523', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '494.6815', '542.8771', '-25.38725', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@GUID + 01, (@POINT := @POINT + 1), '445.9710', '542.5389', '-21.56523', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


SET @MIZZLE := '14353';

-- -----------------------

UPDATE `creature_template` SET `ModelId1`='14406' WHERE `Entry`=@MIZZLE;

-- Added missing spawns of gameobject 175928 (Incendia Agave)
-- Uniformised respawn time for all GO (10 min)
-- Put them all into a pool as the comments highly suggest they are
-- (max limit is guesswork based on comments)
-- Thanks TheTrueAnimal for pointing. This closes #646
-- Source: YTDB
-- http://www.wowhead.com/object=175928
-- http://www.wowhead.com/item=12732

SET @GUID := 573672;
SET @POOL := 15006;

DELETE FROM `gameobject` WHERE `guid` BETWEEN @GUID AND @GUID + 10;
INSERT INTO `gameobject` VALUES
(@GUID, 175928, 1, -4961, -1995, -49, 3.142, 0, 0, 1, -0.000203653, 600, 100, 1),
(@GUID + 1, 175928, 1, -4963, -1912, -49, 3.142, 0, 0, 1, -0.000203653, 600, 100, 1),
(@GUID + 2, 175928, 1, -4962, -1901, -47, 4.762, 0, 0, 0.689351, -0.724428, 600, 100, 1),
(@GUID + 3, 175928, 1, -4966, -1954, -48, 3.142, 0, 0, 1, -0.000203653, 600, 100, 1),
(@GUID + 4, 175928, 1, -4948, -1899, -49, 3.142, 0, 0, 1, -0.000203653, 600, 100, 1),
(@GUID + 5, 175928, 1, -5038, -2019, -48, 3.142, 0, 0, 1, -0.000203653, 600, 100, 1),
(@GUID + 6, 175928, 1, -5006, -2038, -49, 0.666, 0, 0, 0.32688, 0.945066, 600, 100, 1),
(@GUID + 7, 175928, 1, -4977, -2026, -49, 3.142, 0, 0, 1, -0.000203653, 600, 100, 1),
(@GUID + 8, 175928, 1, -5100, -2066, -47, 3.142, 0, 0, 1, -0.000203653, 600, 100, 1),
(@GUID + 9, 175928, 1, -5029.36, -2045.23, -51.6448, 1.91986, 0, 0, 0.819151, 0.573577, 300, 100, 1),
(@GUID + 10, 175928, 1, -5028.41, -2000.75, -53.1136, -0.90757, 0, 0, -0.438371, 0.898794, 300, 100, 1);

UPDATE `gameobject` SET `spawntimesecs` = 600 WHERE `id` = 175928;

DELETE FROM `pool_gameobject_template` WHERE `id` = 175928;
INSERT INTO `pool_gameobject_template` VALUES
(175928, @POOL, 0, 'Incendia Agave (175928)');

DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` VALUES
(@POOL, 6, 'Incendia Agave (175928)');

-- Removed duplicate addon for creature 5109 (Myra Tyrngaarde) in Ironforge
-- preventing her from holding its bread, showing players how tasteful it is
-- Thanks Tobschinski for pointing. This closes #679
DELETE FROM `creature_addon` WHERE `guid` = (SELECT `guid` FROM `creature` WHERE `id` = 5109);

-- Improved completion script of quest 6661 (Deeprun round rat)
-- Thanks scotty0100 for pointing. This closes #105
SET @ENTRY := 2000000074;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 6661;
INSERT INTO `dbscripts_on_quest_end` VALUES
(6661, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'RUN ON'),
(6661, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, -20.57, 35.13, -4.30, 4.5837, ''),
(6661, 2, 0, 0, 0, 0, 0, 0, @ENTRY, 0, 0, 0, 0, 0, 0, 0, ''),
(6661, 4, 15, 21052, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Monty Bashes Rats (DND)'),
(6661, 3, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(6661, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, -19.6312, 40.0752, -4.21403, 4.79965, ''),
(6661, 6, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.79965, ''),
(6661, 7, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'RUN OFF');

DELETE FROM `db_script_string` WHERE `entry` = @ENTRY;
INSERT INTO `db_script_string` VALUES (@ENTRY, 'Into the box me pretties! Thas it. One by one, ye go.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL);

-- Fixed faction of creature 13017 (Enthralled Deeprun Rat)
UPDATE `creature_template` SET `FactionAlliance` = 7, `FactionHorde` = 7 WHERE `entry` = 13017;

-- Removed aura from addon for NPC 1200 (Morbent Fel) in Duskwood
-- because its aura is now handled in ACID script
-- Moved addon to template_addon
-- Thanks X-Savior
DELETE FROM `creature_addon` WHERE `guid` = (SELECT `guid` FROM `creature` WHERE `id` = 1200);
DELETE FROM `creature_template_addon` WHERE `entry` = 1200;
INSERT INTO `creature_template_addon` VALUES
(1200, 0, 0, 1, 16, 0, 0, NULL);

-- Improved Stitches script used at end of quest 252 (Translation to Ello) to make it closer
-- to what it was on retail:
-- Stitches is now neutral at spawn and will no longer kill Abercombrie
-- Stitches turns hostile when reaching the road
-- Stitches now attacks the Night Watch guards on its way to Darkshire
-- Town Crier (creature 468) now has several yells to inform players of Stitches progress toward Darkshire
-- Prevented Stitches to spawn twice
-- Source: http://www.wowwiki.com/Quest:Translation_to_Ello
-- http://www.wowwiki.com/Stitches
-- http://www.youtube.com/watch?v=rS0rjcQ6YMc

SET @NIGHTWATCH := 888;
SET @NIGHTWATCH2 := 499;
SET @TOWNCRIER := 468;
SET @CRIER_GUID := (SELECT `guid` FROM `creature` WHERE `id` = @TOWNCRIER);
SET @STRING := 2000000185;
SET @CONDITION := 204;
SET @SEARCH_RANGE := 100000;

UPDATE `creature_template` SET `FactionAlliance` = 7, `FactionHorde` = 7 WHERE `Entry` = 412;
UPDATE `creature_template` SET `ExtraFlags` = `ExtraFlags` | 0x1000 WHERE `Entry` = 468; -- Makes Town Crier an active object

UPDATE `dbscripts_on_quest_end` SET `delay` = 1 WHERE `id` = 252;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 252 AND `delay` = 0;
INSERT INTO `dbscripts_on_quest_end` VALUES
(252, 0, 34, @CONDITION, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'stop if stitches already spawned');

DELETE FROM `conditions` WHERE `condition_entry` = @CONDITION;
INSERT INTO `conditions` VALUES
(@CONDITION, 37, 412, @SEARCH_RANGE);

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 41204 AND `command` = 22;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(41204, 0, 22, 93, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'stitches faction hostile');
UPDATE `creature_movement_template` SET `script_id` = 41204 WHERE `entry` = 412 AND `point` = 35;

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 41205;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(41205, 0, 0, 6, 0, @TOWNCRIER, @CRIER_GUID, 0x10, @STRING + 1, 0, 0, 0, 0, 0, 0, 0, 'stitches - town crier 1st yell');
UPDATE `creature_movement_template` SET `script_id` = 41205 WHERE `entry` = 412 AND `point` = 47;

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 41206;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(41206, 0, 26, 0, 0, @NIGHTWATCH, 50, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'stitches attacks night watch'),
(41206, 1, 26, 0, 0, @NIGHTWATCH2, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2nd night watch attacks stitches');
UPDATE `creature_movement_template` SET `script_id` = 41206, `waittime` = 0 WHERE `entry` = 412 AND `point` = 49;

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 41202 AND `delay` = 4;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(41202, 4, 0, 6, 0, @TOWNCRIER, @CRIER_GUID, 0x10, @STRING + 2, 0, 0, 0, 0, 0, 0, 0, 'stitches - town crier 2nd yell');
UPDATE `creature_movement_template` SET `script_id` = 0 WHERE `entry` = 412 AND `point` = 69;
UPDATE `creature_movement_template` SET `script_id` = 41202 WHERE `entry` = 412 AND `point` = 50;

DELETE FROM `dbscripts_on_creature_death` WHERE `id` = 412;
INSERT INTO `dbscripts_on_creature_death` VALUES
(412, 5, 0, 6, 0, @TOWNCRIER, @CRIER_GUID, 0x10, @STRING + 3, 0, 0, 0, 0, 0, 0, 0, 'stitches - town crier 3rd yell');

DELETE FROM `db_script_string` WHERE `entry` IN (@STRING + 1, @STRING + 2, @STRING + 3);
INSERT INTO `db_script_string` VALUES
(@STRING + 1, 'An abomination of the undead is approaching!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 7, 0, NULL),
(@STRING + 2, 'The abomination has overrun the Night Watch camp! Quickly, we must intercept it before it reaches town!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 7, 0, NULL),
(@STRING + 3, 'The beast is slain! All is well in Darkshire.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6, 7, 0, NULL);

UPDATE `db_script_string` SET `type` = 6 WHERE `entry` IN (2000000161, 2000000162);


-- Fixed NPCFlags for NPC 9087 Bashana Runetotem
UPDATE `creature_template` SET `NpcFlags` = `NpcFlags` | 128 WHERE `Entry` = 9087;


-- Added wrongly removed waypoints of creature 2619 (Hammerfall Grunt)
DELETE FROM `creature_movement` WHERE `id` = 11453;
INSERT INTO `creature_movement` VALUES 
(11453, 1, -1531.04, -3108.09, 14.0027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 2, -1544.48, -3108.2, 13.7442, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 3, -1554.01, -3107.76, 13.4482, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 4, -1552.91, -3092.68, 13.6331, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 5, -1552.26, -3079.25, 13.7944, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 6, -1550.01, -3064.34, 13.1415, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 7, -1549.29, -3042.01, 12.993, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 8, -1549.16, -3052.09, 13.1918, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 9, -1548.74, -3067.14, 13.219, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 10, -1549.68, -3085.5, 13.7781, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 11, -1549.89, -3106.75, 13.5441, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 12, -1531.51, -3108.25, 13.9753, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 13, -1517.54, -3108.93, 13.3021, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 14, -1501.29, -3109.05, 13.3937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11453, 15, -1518.63, -3108.63, 13.3043, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);



-- Fixed addon for creature 10558 (Hearthsinger Forresten) and moved it to template
DELETE FROM `creature_addon` WHERE `guid` = 52150;
DELETE FROM `creature_template_addon` WHERE `entry` = 10558;
INSERT INTO `creature_template_addon` VALUES
(10558, 0, 0, 1, 16, 0, 0, NULL);

-- Fixed movementtype of creature 6090 (Bartleby) since its WP were removed
UPDATE `creature` SET `MovementType` = 0 WHERE `id` = 6090;

-- Removed wrong equipment for creature 5154 (Poranna Snowbraid) in Ironforge as she should wear none
UPDATE `creature_template` SET `EquipmentTemplateId` = 0 WHERE `Entry` = 5154;


-- Jenal <Ditch Digger> - gossip update
UPDATE gossip_menu_option SET action_menu_id = 1661 WHERE menu_id = 1662;
DELETE FROM gossip_menu WHERE entry = 1661;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(1661, 2314, 0, 0);

-- Fixed rank of creature 8217 (Mith'rethis the Enchanter) in the Hinterlands
-- because this NPC is rare and elite
-- Added waypoint movement to NPC 8217 (source: TBC-DB)
UPDATE `creature_template` SET `rank` = 2, `MovementType` = 2 WHERE `Entry` = 8217;
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 8217;

DELETE FROM `creature_movement_template` WHERE `entry` = 8217;
INSERT INTO `creature_movement_template` VALUES 
(8217, 1, -517.333, -4054.25, 216.023, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.81696, 0, 0),
(8217, 2, -528.477, -4075.78, 215.853, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.22791, 0, 0),
(8217, 3, -530.916, -4084.3, 215.575, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.96263, 0, 0),
(8217, 4, -547.423, -4085.67, 216.281, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.18254, 0, 0),
(8217, 5, -558.864, -4085.86, 225.49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.14249, 0, 0),
(8217, 6, -570.652, -4085.87, 234.629, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.14249, 0, 0),
(8217, 7, -578.233, -4085.87, 240.068, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.14249, 0, 0),
(8217, 8, -593.878, -4085.89, 238.362, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.14249, 0, 0),
(8217, 9, -616.638, -4064.5, 238.217, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.39557, 0, 0),
(8217, 10, -616.833, -4047.42, 238.046, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.21179, 0, 0),
(8217, 11, -652.808, -4040.06, 238.274, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.93436, 0, 0),
(8217, 12, -672.615, -4022.63, 238.229, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.41992, 0, 0),
(8217, 13, -676.225, -4016.49, 238.145, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.10262, 0, 0),
(8217, 14, -672.621, -4011.21, 238.248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.0062, 0, 0),
(8217, 15, -664.151, -4010.24, 238.159, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.113991, 0, 0),
(8217, 16, -655.342, -4029.7, 238.255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.1374, 0, 0),
(8217, 17, -637.653, -4043.85, 238.07, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.60864, 0, 0),
(8217, 18, -624.501, -4043.49, 238.073, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.085717, 0, 0),
(8217, 19, -617.972, -4032.87, 237.873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.986569, 0, 0),
(8217, 20, -617.911, -3980.06, 238.482, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.59918, 0, 0),
(8217, 21, -611.216, -3963.89, 238.351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.17821, 0, 0),
(8217, 22, -570.672, -3938.64, 238.326, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.471347, 0, 0),
(8217, 23, -568.836, -3931.76, 237.925, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.31015, 0, 0),
(8217, 24, -556.458, -3939.03, 237.937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.21138, 0, 0),
(8217, 25, -537.875, -3940.39, 238.764, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.32627, 0, 0),
(8217, 26, -566.704, -3951.51, 238.427, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.52419, 0, 0),
(8217, 27, -613.806, -3933.84, 238.346, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.78906, 0, 0),
(8217, 28, -620.501, -3938.32, 238.463, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.73153, 0, 0),
(8217, 29, -616.96, -3970.3, 238.351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.85936, 0, 0),
(8217, 30, -618.1, -4023.04, 237.988, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.68658, 0, 0),
(8217, 31, -617.327, -4059.77, 238.279, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.72663, 0, 0),
(8217, 32, -624.179, -4061.62, 238.351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.37967, 0, 0),
(8217, 33, -638.711, -4062.04, 247.263, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.19903, 0, 0),
(8217, 34, -618.277, -4063.46, 238.307, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.25345, 0, 0),
(8217, 35, -602.99, -4082.45, 238.351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.37302, 0, 0),
(8217, 36, -600.118, -4115.69, 238.504, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.83973, 0, 0),
(8217, 37, -610.419, -4140.24, 238.351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.31508, 0, 0),
(8217, 38, -599.085, -4160.05, 238.431, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.23871, 0, 0),
(8217, 39, -593.493, -4164.29, 238.355, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.70995, 0, 0),
(8217, 40, -587.6, -4160.74, 238.352, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.554599, 0, 0),
(8217, 41, -593.862, -4137.4, 238.387, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.83637, 0, 0),
(8217, 42, -629.492, -4119.94, 238.351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.68617, 0, 0),
(8217, 43, -642.951, -4106.99, 238.504, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.37515, 0, 0),
(8217, 44, -591.144, -4085.34, 238.368, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.381026, 0, 0),
(8217, 45, -577.325, -4085.64, 239.868, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.24559, 0, 0),
(8217, 46, -564.315, -4085.87, 229.775, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.16548, 0, 0),
(8217, 47, -544.956, -4085.42, 215.861, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.026026, 0, 0),
(8217, 48, -532.116, -4085.08, 215.547, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.026026, 0, 0),
(8217, 49, -529.232, -4073.31, 215.856, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.42561, 0, 0),
(8217, 50, -539.105, -4053.94, 216.756, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.95496, 0, 0),
(8217, 51, -531.195, -4035.23, 215.861, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.19391, 0, 0),
(8217, 52, -505.494, -4008.01, 215.944, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.802785, 0, 0),
(8217, 53, -524.022, -4030.32, 215.86, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.05669, 0, 0),
(8217, 54, -524.191, -4036.51, 215.86, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.68501, 0, 0);

-- Added missing spawn of NPC 15197 (Darkcaller Yanka) and 15199 (Sergeant Hartman)
-- Made them spawn only during Hallow's End event
-- Thanks TheTrueAnimal for reporting. This closes #639
-- Source: YTDB
SET @GUID := 160014;

DELETE FROM `creature` WHERE `guid` IN (@GUID, @GUID + 1);
INSERT INTO `creature` VALUES
(@GUID, 15197, 0, 0, 0, 1734.6, 508.803, 41.2847, 1.6173, 300, 0, 0, 9763, 0, 0, 0),
(@GUID + 1, 15199, 0, 0, 0, -813.614, -547.184, 15.6377, 1.69193, 300, 0, 0, 9763, 0, 0, 0);

DELETE FROM `game_event_creature` WHERE `guid` IN (@GUID, @GUID + 1);
INSERT INTO `game_event_creature` VALUES
(@GUID, 12),
(@GUID + 1, 12);

-- Fixed equipment of many creatures in Dire Maul North
-- Thanks Tobschinski for poiting and providing data. This closes #685  

SET @ENTRY := 2416;

UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY WHERE `Entry` = 11441; -- Gordok Brute
UPDATE `creature_template` SET `EquipmentTemplateId` = 1310 WHERE `Entry` = 14322; -- Stomper Kreeg <The Drunk> (or 1309)
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 1 WHERE `Entry` = 14326; -- Guard Mol'dar
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 2 WHERE `Entry` = 14321; -- Guard Fengus
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 3 WHERE `Entry` = 14323; -- Guard Slip'kik
UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY + 4 WHERE `Entry` = 14325; -- Captain Kromcrush
UPDATE `creature_template` SET `EquipmentTemplateId` = 94 WHERE `Entry` =14324; -- Cho'Rush the Observer (or 95)

DELETE FROM `creature_equip_template` WHERE `entry` BETWEEN @ENTRY AND @ENTRY + 4;
INSERT INTO `creature_equip_template` VALUES
(@ENTRY, 1207, 0, 0),
(@ENTRY + 1, 6738, 2051, 0),
(@ENTRY + 2, 2183, 2051, 0),
(@ENTRY + 3, 5286, 1985, 0),
(@ENTRY + 4, 27849, 0, 0);


-- Despawns GO 148937 (Atal'ai Light BIG (DND)) and GO 148883 (Atal'ai Light SMALL (DND))
-- in Sunken Temple : they are spawned by script
-- Thanks TheTrueAnimal for reporting. This closes #635
-- Value from UDB
UPDATE `gameobject` SET `spawntimesecs` = -43200 WHERE `id` IN (148883, 148937);

-- Added random movement to creature 1493 (Mok'Rash) near Booty Bay
-- Also fixed its respawn time to 2h instead of 30 min
-- Source: https://www.youtube.com/watch?v=Ne3WQssvEMM
-- http://www.wowwiki.com/Mok%27rash
UPDATE `creature` SET `MovementType` = 1, `spawndist` = 10, `spawntimesecs` = 2 * 60 * 60 WHERE `id` = 1493;

-- Improved script for quest 656 (Summoning the Princess) in Arathi Highlands
-- Now Myzrael has a speech and will engage players on spawn
-- Source: https://www.youtube.com/watch?v=aI6vUWaR2kg
-- https://www.youtube.com/watch?v=WjezLpIxxLg

UPDATE `creature_template` SET `MinLevel` = 44, `MaxLevel` = 44, `MinLevelHealth` = 11408, `MaxLevelHealth`=11408, `HealthMultiplier` = 8, `PowerMultiplier` = 3, `ArmorMultiplier` = 1 WHERE `Entry` = 2755;

SET @STRING := 2000000234;

DELETE FROM `db_script_string` WHERE `entry` BETWEEN @STRING AND @STRING + 2;
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(@STRING, 'What? $N, you served me well, but...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@STRING + 1, 'Why have you summoned me so soon? I haven\'t yet reached my full power!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@STRING + 2, 'No matter. You were a fool to help me, and now you will pay!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL);

DELETE FROM `dbscripts_on_event` WHERE `id` = 420;
INSERT INTO `dbscripts_on_event` VALUES
(420, 0, 10, 2755, 3000000, 0, 0, 0, 0, 0, 0, 0, -931.73, -3111.81, 48.517, 3.27404, 'quest 656'),
(420, 3, 0, 0, 0, 2755, 50, 3, @STRING, 0, 0, 0, 0, 0, 0, 0, ''),
(420, 6, 0, 0, 0, 2755, 50, 3, @STRING + 1, 0, 0, 0, 0, 0, 0, 0, ''),
(420, 11, 0, 0, 0, 2755, 50, 3, @STRING + 2, 0, 0, 0, 0, 0, 0, 0, ''),
(420, 12, 26, 0, 0, 2755, 50, 3, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- Fixed missing gossip_menu_option in Gnomeragan for engineers
-- Now Schematic: Discombobulator Ray will be available for
-- Players with the right engineering level and the right access card
-- Thanks at Neotmiren for pointing and researching. This closes #140
-- Source: http://www.wowwiki.com/Schematic:_Discombobulator_Ray

SET @CONDITION := 1142;

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 1050 AND `id` = 1;
INSERT INTO `gossip_menu_option` VALUES
(1050, 1, 0, 'Use engineering to access hidden schematics!', 1, 1, -1, 0, 105002, 0, 0, NULL, @CONDITION + 2);

DELETE FROM `dbscripts_on_gossip` WHERE `id` = 105002;
INSERT INTO `dbscripts_on_gossip` VALUES
(105002, 0, 15, 11595, 0, 0, 0, 0x04, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast spell Learn - Schematic: Discombobulator Ray');

DELETE FROM `conditions` WHERE `condition_entry` IN (@CONDITION, @CONDITION + 1, @CONDITION + 2);
INSERT INTO `conditions` VALUES
(@CONDITION, 17, 3959, 1), -- does not already knows Discombobulator Ray
-- (1104, 2, 9327, 1),	   -- must have Security DELTA Data Access Card
-- (1105, 7, 202, 160),	   -- Engineering 160
(@CONDITION + 1, -1, @CONDITION, 1104),
(@CONDITION + 2, -1, @CONDITION + 1, 1105);

-- Fixed gossip menu of creature 13278 (Duke Hydraxis) in Azshara
-- Now players will be able to get the required items to summon Majordomo
-- Executus in Molten Core
-- Thanks Scotty0100 for reporting and doing serious research about it
-- Thanks Tobschinski for researching also
-- This closes #614 
-- Source: http://thulf.blogspot.co.uk/2006_05_01_archive.html
-- http://img.photobucket.com/albums/v672/Xandier/Forums/WoWScrnShot_052106_111856.jpg
-- http://rsmg.pbsrc.com/albums/v672/Xandier/Forums/WoWScrnShot_052106_111828.jpg~c100

SET @CONDITION := 67;

DELETE FROM `gossip_menu` WHERE `entry` = 5065 AND `text_id` IN (6109, 6158, 8541, 8542);
INSERT INTO `gossip_menu` VALUES
(5065, 6109, 0, @CONDITION),
(5065, 6158, 0, @CONDITION + 1),
(5065, 8541, 0, @CONDITION + 9),
(5065, 8542, 0, @CONDITION + 7);

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 5065;
INSERT INTO `gossip_menu_option` VALUES
(5065, 0, 0, '[PH] I desire an aqual quintessence, Duke Hydraxis.', 1, 1, -1, 0, 506501, 0, 0, '', @CONDITION + 6),
(5065, 1, 0, 'I desire this eternal quintessence, Duke Hydraxis.', 1, 1, -1, 0, 506502, 0, 0, '', @CONDITION + 9);

DELETE FROM `conditions` WHERE `condition_entry` BETWEEN @CONDITION AND @CONDITION + 9;
INSERT INTO `conditions` VALUES
(@CONDITION, 8, 6805, 0), -- Quest "Stormers and Rumblers" rewarded
(@CONDITION + 1, 8, 6824, 0), -- Quest "Hands of the Enemy" rewarded
(@CONDITION + 2, 30, 749, 5), -- Reputation Hydraxian Waterlords is at max Honored
(@CONDITION + 3, -1, @CONDITION + 1, @CONDITION + 2),
(@CONDITION + 4, 5, 749, 6), -- Reputation Hydraxian Waterlords is at least Revered
(@CONDITION + 5, 24, 17333, 1), -- Does not have item Aqual Quintessence
(@CONDITION + 6, -1, @CONDITION + 3, @CONDITION + 5),
(@CONDITION + 7, -1, @CONDITION + 1, @CONDITION + 4),
(@CONDITION + 8, 24, 22754, 1), -- Does not have item Eternal Quintessence
(@CONDITION + 9, -1, @CONDITION + 7, @CONDITION + 8);

DELETE FROM `dbscripts_on_gossip` WHERE `id` IN (506501, 506502);
INSERT INTO `dbscripts_on_gossip` VALUES
(506501, 0, 15, 21357, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'create aqual quintessence'),
(506502, 0, 15, 28439, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'create eternal quintessence');

UPDATE `gameobject_template` SET `faction`='1375' WHERE `entry` IN ('97700', '104600');

UPDATE `areatrigger_teleport` SET `required_level`='10' WHERE `id`='78';

-- Fixed faction of NPC 8440 (Shade of Hakkar) in Sunken Temple
-- Thanks TheTrueAnimal for pointinng and fixing. Values from UDB. This closes #666
UPDATE `creature_template` SET `FactionAlliance` = 35, `FactionHorde` = 35 WHERE `entry` = 8440;

-- Fixed equipment of creatures 11450 (Gordok Reaver) and 14351 (Gordok Bushwacker) in Dire Maul North
-- Thanks Tobschinski for poiting and providing data. This closes #685 (again)
UPDATE `creature_template` SET `EquipmentTemplateId` = 1902 WHERE `Entry` = 14351; -- Gordok Bushwacker
UPDATE `creature_template` SET `EquipmentTemplateId` = 2164 WHERE `Entry` = 11450; -- Gordok Reaver

DELETE FROM `creature_equip_template_raw` WHERE `entry` = 2164;
DELETE FROM `creature_equip_template` WHERE `entry` = 2164;
INSERT INTO `creature_equip_template` VALUES
(2164, 15273, 0, 0);


DELETE FROM `creature_involvedrelation` WHERE `quest`='1318';
DELETE FROM `creature_questrelation` WHERE `quest`='1318';

-- Linked NPCs 15542 (Twilight Marauder) and NPC 15541 (Twilight Marauder Morna): they will now engage with their master and respawn with her
-- Set Run speed for creatures 15542 and 15541
-- Adjust spawn time (4 minutes for master, followers are linked)
-- Fixed model of NPC 15542 which had wrong alternate model similar to NPC 15541
-- Thanks @Metalica for pointing. This closes #671 
-- Sources: http://www.wowhead.com/npc=15541#comments
-- http://www.wowhead.com/npc=15542#comments
DELETE FROM `creature_linking_template` WHERE `entry` = 15542;
INSERT INTO `creature_linking_template` VALUES
(15542, 1, 15541, 1 + 2 + 128 + 8192, 0);

UPDATE `creature` SET `spawntimesecs` = 4 * 60 WHERE `id` = 15541;
UPDATE `creature` SET `spawntimesecs` = 4 * 60 WHERE `id` = 15542;

UPDATE `creature_model_info` SET `modelid_other_gender` = 0 WHERE `modelid` = 15552;

DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 1554101;
INSERT INTO `dbscripts_on_creature_movement` VALUES
(1554101, 2, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'RUN ON - Twilight Marauder Morna'),
(1554101, 1, 25, 1, 0, 15542, 43202, 0x10, 0, 0, 0, 0, 0, 0, 0, 0, 'RUN ON - Twilight Marauder 1'),
(1554101, 0, 25, 1, 0, 15542, 43203, 0x10, 0, 0, 0, 0, 0, 0, 0, 0, 'RUN ON - Twilight Marauder 2');

DELETE FROM `creature_movement` WHERE `id` = (SELECT `guid` FROM `creature` WHERE `id` = 15541);
DELETE FROM `creature_movement_template` WHERE `entry` = 15541;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(15541, 1, -6381.83, 522.263, 6.33608, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.08546, 0, 0),
(15541, 2, -6388.62, 511.913, 6.40844, 0, 1554101, 0, 0, 0, 0, 0, 0, 0, 4.11295, 0, 0),
(15541, 3, -6396.02, 501.126, 5.96868, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.97158, 0, 0),
(15541, 4, -6403.3, 493.654, 4.30304, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.94409, 0, 0),
(15541, 5, -6408.62, 486.992, 2.68521, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.04619, 0, 0),
(15541, 6, -6414.09, 479.644, 0.827286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.28181, 0, 0),
(15541, 7, -6415.84, 474.03, -1.00684, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.43889, 0, 0),
(15541, 8, -6418.49, 464.595, 0.523592, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.43889, 0, 0),
(15541, 9, -6418.49, 464.595, 0.523592, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.44674, 0, 0),
(15541, 10, -6425.01, 441.027, 2.01444, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.39962, 0, 0),
(15541, 11, -6430.5, 429.614, 2.89218, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.00299, 0, 0),
(15541, 12, -6434.42, 425.346, 3.12233, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.89696, 0, 0),
(15541, 13, -6452.57, 408.975, 3.49116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.93231, 0, 0),
(15541, 14, -6469.84, 391.597, 2.38939, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.92053, 0, 0),
(15541, 15, -6471.76, 389.704, 2.10586, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.73596, 0, 0),
(15541, 16, -6471.76, 389.704, 2.10586, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.73596, 0, 0),
(15541, 17, -6499.13, 374.662, 2.13876, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.4807, 0, 0),
(15541, 18, -6501.03, 373.994, 2.01011, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.44005, 0, 0),
(15541, 19, -6527.96, 388.841, 4.81061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.46107, 0, 0),
(15541, 20, -6530.47, 388.01, 4.49237, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.31322, 0, 0),
(15541, 21, -6541.67, 369.928, 1.47049, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.79879, 0, 0),
(15541, 22, -6544.27, 367.978, 1.26933, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.7281, 0, 0),
(15541, 23, -6544.27, 367.978, 1.26933, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.7281, 0, 0),
(15541, 24, -6568.99, 350.006, 3.62838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.07368, 0, 0),
(15541, 25, -6581.04, 334.773, 0.99317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.93623, 0, 0),
(15541, 26, -6581.04, 334.773, 0.99317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.95979, 0, 0),
(15541, 27, -6581.04, 334.773, 0.99317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.95979, 0, 0),
(15541, 28, -6604.63, 310.711, 3.49995, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.68883, 0, 0),
(15541, 29, -6608.37, 309.531, 3.46286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.35896, 0, 0),
(15541, 30, -6623.45, 305.414, 3.13978, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.7281, 0, 0),
(15541, 31, -6634.63, 297.475, 3.05937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.91267, 0, 0),
(15541, 32, -6640.44, 291.236, 2.59651, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.97943, 0, 0),
(15541, 33, -6649.03, 282.408, 2.2899, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.84984, 0, 0),
(15541, 34, -6660.82, 271.363, 4.43145, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.96372, 0, 0),
(15541, 35, -6660.82, 271.363, 4.43145, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.96372, 0, 0),
(15541, 36, -6677.3, 253.233, 3.84925, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.99121, 0, 0),
(15541, 37, -6695.4, 233.018, 2.69341, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.80664, 0, 0),
(15541, 38, -6708.32, 223.081, 2.06455, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.01085, 0, 0),
(15541, 39, -6720.52, 207.81, 2.13145, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.13651, 0, 0),
(15541, 40, -6728.84, 193.182, 3.85769, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.59204, 0, 0),
(15541, 41, -6729.12, 189.274, 3.89565, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.55669, 0, 0),
(15541, 42, -6733.38, 165.157, 2.50309, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.59204, 0, 0),
(15541, 43, -6733.73, 161.548, 2.26791, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.72555, 0, 0),
(15541, 44, -6733.41, 137.063, 4.09396, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.72555, 0, 0),
(15541, 45, -6740.68, 126.034, 4.11355, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.91267, 0, 0),
(15541, 46, -6752.78, 121.21, 2.5664, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.49641, 0, 0),
(15541, 47, -6763.03, 119.278, 1.11022, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.44536, 0, 0),
(15541, 48, -6770.36, 116.385, 0.736461, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.69668, 0, 0),
(15541, 49, -6786.8, 109.532, 4.10522, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.1901, 0, 0),
(15541, 50, -6786.8, 109.532, 4.10522, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.01986, 0, 0),
(15541, 51, -6798.34, 133.72, 3.8605, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.01593, 0, 0),
(15541, 52, -6803.13, 143.68, 3.29543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.83136, 0, 0),
(15541, 53, -6806.7, 156.926, 1.91714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.93739, 0, 0),
(15541, 54, -6809.22, 162.987, 1.34973, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.29082, 0, 0),
(15541, 55, -6822.97, 177.835, 0.423451, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.41648, 0, 0),
(15541, 56, -6830.98, 184.459, 1.24963, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.41256, 0, 0),
(15541, 57, -6847.84, 202.184, 3.13678, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.31831, 0, 0),
(15541, 58, -6853.92, 213.165, 2.3177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.03164, 0, 0),
(15541, 59, -6853.92, 213.165, 2.3177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.03164, 0, 0),
(15541, 60, -6862.69, 230.697, 0.189849, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.13374, 0, 0),
(15541, 61, -6875.76, 248.494, 0.714978, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.35365, 0, 0),
(15541, 62, -6886.87, 260.405, 3.01083, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.10625, 0, 0),
(15541, 63, -6890.23, 268.041, 3.75853, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.66643, 0, 0),
(15541, 64, -6891.84, 282.321, 3.93235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.851, 0, 0),
(15541, 65, -6898.99, 305.754, 3.84856, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.86671, 0, 0),
(15541, 66, -6908.82, 323.496, 3.55015, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.41256, 0, 0),
(15541, 67, -6908.82, 323.496, 3.55015, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.53429, 0, 0),
(15541, 68, -6928.57, 337.92, 3.2281, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.47932, 0, 0),
(15541, 69, -6937.24, 345.285, 4.01963, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.33794, 0, 0),
(15541, 70, -6951.84, 361.005, 5.90094, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.23584, 0, 0),
(15541, 71, -6964.7, 382.142, 5.41806, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.00022, 0, 0),
(15541, 72, -6968.47, 401.663, 3.03619, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.55255, 0, 0),
(15541, 73, -6968.47, 401.663, 3.03619, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.62716, 0, 0),
(15541, 74, -6970.83, 418.38, 5.32879, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.012, 0, 0),
(15541, 75, -6981.98, 440.13, 8.42832, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.97666, 0, 0),
(15541, 76, -6983.44, 444.071, 8.45617, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.87063, 0, 0),
(15541, 77, -6994.07, 473.436, 8.02054, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.41648, 0, 0),
(15541, 78, -7006.97, 484.434, 5.74935, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.77638, 0, 0),
(15541, 79, -7008.14, 488.174, 6.09104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.87456, 0, 0),
(15541, 80, -7010.18, 493.008, 8.48791, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.96881, 0, 0),
(15541, 81, -7014.82, 499.297, 9.05018, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.45968, 0, 0),
(15541, 82, -7024.9, 503.993, 8.78707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.12472, 0, 0),
(15541, 83, -7024.9, 503.993, 8.78707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.19934, 0, 0),
(15541, 84, -7035.93, 484.679, 9.25159, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.06975, 0, 0),
(15541, 85, -7054.55, 463.783, 9.08453, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.25686, 0, 0),
(15541, 86, -7059.05, 460.609, 8.44962, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.39569, 0, 0),
(15541, 87, -7059.05, 460.609, 8.44962, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.39569, 0, 0),
(15541, 88, -7066.06, 434.783, 8.65003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.21112, 0, 0),
(15541, 89, -7076.38, 423.931, 8.2561, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.85376, 0, 0),
(15541, 90, -7083.91, 418.745, 7.81772, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.08407, 0, 0),
(15541, 91, -7090.38, 419.532, 6.20053, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.91521, 0, 0),
(15541, 92, -7094.1, 423.171, 6.0317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.17694, 0, 0),
(15541, 93, -7103.52, 439.507, 5.07884, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.92168, 0, 0),
(15541, 94, -7106.42, 449.528, 5.01998, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.83922, 0, 0),
(15541, 95, -7112.86, 467.14, 6.73329, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.08662, 0, 0),
(15541, 96, -7112.86, 467.14, 6.73329, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.08662, 0, 0),
(15541, 97, -7125.08, 487.981, 3.37296, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.14552, 0, 0),
(15541, 98, -7125.08, 487.981, 3.37296, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.14552, 0, 0),
(15541, 99, -7138.8, 508.267, 3.89067, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.19657, 0, 0),
(15541, 100, -7138.8, 508.267, 3.89067, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.19657, 0, 0),
(15541, 101, -7138.8, 508.267, 3.89067, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.19657, 0, 0),
(15541, 102, -7152.07, 526.486, 7.64068, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.3026, 0, 0),
(15541, 103, -7152.07, 526.486, 7.64068, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.3026, 0, 0),
(15541, 104, -7169.3, 543.895, 4.61447, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.38114, 0, 0),
(15541, 105, -7169.3, 543.895, 4.61447, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.38114, 0, 0),
(15541, 106, -7195.62, 568.831, 4.7267, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.49895, 0, 0),
(15541, 107, -7204.96, 574.829, 3.99974, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.78169, 0, 0),
(15541, 108, -7215.56, 577.951, 2.85007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.04087, 0, 0),
(15541, 109, -7215.56, 577.951, 2.85007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.04087, 0, 0),
(15541, 110, -7215.56, 577.951, 2.85007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.04087, 0, 0),
(15541, 111, -7250.56, 582.17, 4.64078, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.87201, 0, 0),
(15541, 112, -7263.12, 585.77, 3.49723, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.96234, 0, 0),
(15541, 113, -7263.12, 585.77, 3.49723, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.96234, 0, 0),
(15541, 114, -7291.6, 592.721, 0.04386, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.68745, 0, 0),
(15541, 115, -7296.71, 595.531, 0.542263, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.58142, 0, 0),
(15541, 116, -7296.71, 595.531, 0.542263, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.58142, 0, 0),
(15541, 117, -7321.67, 613.23, 1.97044, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.67174, 0, 0),
(15541, 118, -7323.46, 614.139, 1.88293, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.96488, 0, 0),
(15541, 119, -7323.46, 614.139, 1.88293, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.96488, 0, 0),
(15541, 120, -7335.5, 645.596, -0.95606, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.5604, 0, 0),
(15541, 121, -7335.5, 645.596, -0.95606, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.5604, 0, 0),
(15541, 122, -7335.02, 670.041, 2.23719, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.62323, 0, 0),
(15541, 123, -7335.76, 680.791, 2.78817, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.76068, 0, 0),
(15541, 124, -7339.75, 697.307, 2.04653, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.8667, 0, 0),
(15541, 125, -7340.77, 700.481, 1.524, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.98844, 0, 0),
(15541, 126, -7340.77, 700.481, 1.524, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.98844, 0, 0),
(15541, 127, -7349.28, 720.233, 1.48185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.87849, 0, 0),
(15541, 128, -7355.21, 742.987, 4.43733, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.72533, 0, 0),
(15541, 129, -7355.21, 742.987, 4.43733, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.72533, 0, 0),
(15541, 130, -7358.45, 767.271, 3.88032, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.69784, 0, 0),
(15541, 131, -7359.12, 772.767, 3.10525, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.62323, 0, 0),
(15541, 132, -7359.12, 772.767, 3.10525, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.62323, 0, 0),
(15541, 133, -7360.41, 797.233, 2.03258, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.62716, 0, 0),
(15541, 134, -7360.41, 797.233, 2.03258, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.62716, 0, 0),
(15541, 135, -7364.25, 832.479, 6.24249, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.32871, 0, 0),
(15541, 136, -7364.25, 832.479, 6.24249, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.32871, 0, 0),
(15541, 137, -7359.69, 852.841, 5.61188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.48579, 0, 0),
(15541, 138, -7359.75, 868.507, 4.5219, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.78424, 0, 0),
(15541, 139, -7364.21, 879.221, 3.08032, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.38114, 0, 0),
(15541, 140, -7369.78, 884.806, 2.19951, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.25155, 0, 0),
(15541, 141, -7379.47, 897.887, 1.88811, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.13767, 0, 0),
(15541, 142, -7385.87, 909.284, 1.4183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.01986, 0, 0),
(15541, 143, -7385.87, 909.284, 1.4183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.92561, 0, 0),
(15541, 144, -7385.87, 909.284, 1.4183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.92561, 0, 0),
(15541, 145, -7394.29, 932.24, 3.78666, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.92168, 0, 0),
(15541, 146, -7401.88, 952.018, 4.22339, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.03949, 0, 0),
(15541, 147, -7408.17, 962.726, 3.8838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.26333, 0, 0),
(15541, 148, -7419.52, 973.376, 3.74543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.58927, 0, 0),
(15541, 149, -7419.52, 973.376, 3.74543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.58927, 0, 0),
(15541, 150, -7440.39, 985.459, 3.41013, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.70708, 0, 0),
(15541, 151, -7463.75, 996.742, 3.0073, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.55393, 0, 0),
(15541, 152, -7463.75, 996.742, 3.0073, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.55393, 0, 0),
(15541, 153, -7482.49, 1008.83, 1.90533, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.82096, 0, 0),
(15541, 154, -7500.16, 1012.46, 2.21159, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.20188, 0, 0),
(15541, 155, -7507.99, 1011.99, 2.44511, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.58673, 0, 0),
(15541, 156, -7529.33, 1002.12, 1.56887, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.41001, 0, 0),
(15541, 157, -7542.13, 999.824, 2.58838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.20188, 0, 0),
(15541, 158, -7562.8, 1001.46, 2.63714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.91521, 0, 0),
(15541, 159, -7562.8, 1001.46, 2.63714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.61676, 0, 0),
(15541, 160, -7562.8, 1001.46, 2.63714, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.61676, 0, 0),
(15541, 161, -7591.28, 1015.61, 3.19717, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.99375, 0, 0),
(15541, 162, -7591.28, 1015.61, 3.19717, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.32224, 0, 0),
(15541, 163, -7607.47, 1031.64, 5.29972, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.57749, 0, 0),
(15541, 164, -7614.83, 1035.81, 4.79784, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.8406, 0, 0),
(15541, 165, -7624.34, 1038.39, 4.65626, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.8838, 0, 0),
(15541, 166, -7643.9, 1043.74, 4.92598, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.77777, 0, 0),
(15541, 167, -7661.32, 1052.34, 4.82357, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.53037, 0, 0),
(15541, 168, -7661.32, 1052.34, 4.82357, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.33402, 0, 0),
(15541, 169, -7678.65, 1069.65, 3.93121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.40863, 0, 0),
(15541, 170, -7691.84, 1080.81, 3.53004, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.51859, 0, 0),
(15541, 171, -7696.62, 1084.24, 3.41852, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.48717, 0, 0),
(15541, 172, -7708.09, 1093.96, 2.98749, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.36151, 0, 0),
(15541, 173, -7718.06, 1105.22, 2.59431, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.2594, 0, 0),
(15541, 174, -7733.52, 1124.22, 1.73916, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.23977, 0, 0),
(15541, 175, -7741.22, 1134.37, 1.33201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.05127, 0, 0),
(15541, 176, -7751.82, 1156.45, 0.576632, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.00808, 0, 0),
(15541, 177, -7762.49, 1178.51, -0.154873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.02771, 0, 0),
(15541, 178, -7762.49, 1178.51, -0.154873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.02771, 0, 0),
(15541, 179, -7773.03, 1200.62, -1.26206, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.00808, 0, 0),
(15541, 180, -7783.37, 1222.83, -3.7369, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.00022, 0, 0),
(15541, 181, -7793.09, 1245.32, -6.71451, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.98451, 0, 0),
(15541, 182, -7800.12, 1259.61, -9.0872, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.09447, 0, 0),
(15541, 183, -7806.61, 1270.22, -10.4451, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.48971, 0, 0),
(15541, 184, -7802.96, 1289.36, -8.34551, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.26195, 0, 0),
(15541, 185, -7802.96, 1289.36, -8.34551, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.26195, 0, 0),
(15541, 186, -7795.69, 1314.38, -5.09394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.36151, 0, 0),
(15541, 187, -7810.15, 1326.26, -7.40606, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.9859, 0, 0),
(15541, 188, -7822.73, 1319.24, -10.681, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.29751, 0, 0),
(15541, 189, -7826.93, 1308.33, -10.038, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.40354, 0, 0),
(15541, 190, -7828.93, 1298.77, -9.55642, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.74519, 0, 0),
(15541, 191, -7826.23, 1286.24, -11.5585, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.23606, 0, 0),
(15541, 192, -7826.23, 1286.24, -11.5585, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.42063, 0, 0),
(15541, 193, -7826.23, 1286.24, -11.5585, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.42063, 0, 0),
(15541, 194, -7803.98, 1261.54, -9.61223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.33816, 0, 0),
(15541, 195, -7798.21, 1252.14, -7.91404, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.23606, 0, 0),
(15541, 196, -7786.57, 1230.64, -4.86232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.15752, 0, 0),
(15541, 197, -7776.76, 1208.36, -1.91932, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.10254, 0, 0),
(15541, 198, -7776.76, 1208.36, -1.91932, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.10254, 0, 0),
(15541, 199, -7767.4, 1185.77, -0.426412, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.1261, 0, 0),
(15541, 200, -7751.14, 1153.63, 0.568985, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.29889, 0, 0),
(15541, 201, -7742.45, 1142.21, 0.981252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.40492, 0, 0),
(15541, 202, -7726.66, 1123.48, 1.76707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.42848, 0, 0),
(15541, 203, -7726.66, 1123.48, 1.76707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.42848, 0, 0),
(15541, 204, -7710.6, 1105.02, 2.66458, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.43241, 0, 0),
(15541, 205, -7694.26, 1086.76, 3.33483, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.45204, 0, 0),
(15541, 206, -7677.74, 1068.78, 3.94982, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.48346, 0, 0),
(15541, 207, -7659.43, 1052.14, 4.91582, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.75049, 0, 0),
(15541, 208, -7649.08, 1046.71, 4.95878, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.04109, 0, 0),
(15541, 209, -7649.08, 1046.71, 4.95878, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.04109, 0, 0),
(15541, 210, -7625.01, 1042.15, 4.46894, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.10392, 0, 0),
(15541, 211, -7603.3, 1040.11, 4.48228, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.005301, 0, 0),
(15541, 212, -7579.12, 1039.98, 3.99961, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.17853, 0, 0),
(15541, 213, -7579.12, 1039.98, 3.99961, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.17853, 0, 0),
(15541, 214, -7554.95, 1036.01, 3.35316, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.09999, 0, 0),
(15541, 215, -7530.86, 1031.55, 2.74821, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.09999, 0, 0),
(15541, 216, -7518.82, 1029.07, 2.71235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.98218, 0, 0),
(15541, 217, -7518.82, 1029.07, 2.71235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.98218, 0, 0),
(15541, 218, -7489.37, 1018.31, 1.95638, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.01753, 0, 0),
(15541, 219, -7462.4, 1006.38, 2.20385, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.53843, 0, 0),
(15541, 220, -7455.77, 998.396, 2.89252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.03578, 0, 0),
(15541, 221, -7455.77, 998.396, 2.89252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.03578, 0, 0),
(15541, 222, -7448.96, 974.863, 4.33075, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.98473, 0, 0),
(15541, 223, -7441.17, 948.264, 1.65803, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.20857, 0, 0),
(15541, 224, -7441.17, 948.264, 1.65803, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.20857, 0, 0),
(15541, 225, -7428.39, 927.429, 3.78599, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.29496, 0, 0),
(15541, 226, -7423.08, 919.427, 3.25806, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.55414, 0, 0),
(15541, 227, -7415.13, 912.745, 2.17476, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.75834, 0, 0),
(15541, 228, -7415.13, 912.745, 2.17476, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.75834, 0, 0),
(15541, 229, -7393.35, 901.621, 1.19573, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.76227, 0, 0),
(15541, 230, -7377.8, 892.678, 1.60292, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.65232, 0, 0),
(15541, 231, -7368.15, 885.076, 2.38997, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.50309, 0, 0),
(15541, 232, -7356.76, 872.538, 4.52426, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.3735, 0, 0),
(15541, 233, -7349.03, 859.142, 5.9086, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.78053, 0, 0),
(15541, 234, -7349.03, 859.142, 5.9086, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.78053, 0, 0),
(15541, 235, -7347.9, 834.669, 5.75347, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.75696, 0, 0),
(15541, 236, -7347.27, 820.669, 4.12543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.59596, 0, 0),
(15541, 237, -7345.37, 799.572, 0.922967, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.23213, 0, 0),
(15541, 238, -7341.02, 793.882, 2.23596, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.61305, 0, 0),
(15541, 239, -7328.22, 783.823, 3.96613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.47953, 0, 0),
(15541, 240, -7318.78, 766.824, 5.08772, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.09861, 0, 0),
(15541, 241, -7312.81, 748.878, 5.60424, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.99651, 0, 0),
(15541, 242, -7308.44, 735.218, 4.81518, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.18108, 0, 0),
(15541, 243, -7308.44, 735.218, 4.81518, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.18893, 0, 0),
(15541, 244, -7297.61, 713.247, 1.50116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.16537, 0, 0),
(15541, 245, -7292.83, 704.299, 2.73024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.44812, 0, 0),
(15541, 246, -7292.83, 704.299, 2.73024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.57771, 0, 0),
(15541, 247, -7292.83, 704.299, 2.73024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.57771, 0, 0),
(15541, 248, -7273.99, 688.644, 6.33373, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.60912, 0, 0),
(15541, 249, -7262.51, 679.462, 8.53285, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.55807, 0, 0),
(15541, 250, -7262.51, 679.462, 8.53285, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.55807, 0, 0),
(15541, 251, -7240.23, 661.377, 9.91954, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.56985, 0, 0),
(15541, 252, -7232.97, 654.869, 8.79697, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.44812, 0, 0),
(15541, 253, -7220.35, 638.217, 5.59505, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.27926, 0, 0),
(15541, 254, -7218.06, 632.807, 4.35276, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.05935, 0, 0),
(15541, 255, -7218.06, 632.807, 4.35276, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.05935, 0, 0),
(15541, 256, -7209.08, 610.059, 3.65591, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.10254, 0, 0),
(15541, 257, -7209.08, 610.059, 3.65591, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.10254, 0, 0),
(15541, 258, -7199.58, 587.481, 4.66785, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.14574, 0, 0),
(15541, 259, -7187.62, 565.051, 5.23083, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.40492, 0, 0),
(15541, 260, -7187.62, 565.051, 5.23083, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.46775, 0, 0),
(15541, 261, -7168.85, 548.013, 4.94201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.73479, 0, 0),
(15541, 262, -7164.35, 545.33, 4.51328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.75049, 0, 0),
(15541, 263, -7164.35, 545.33, 4.51328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.84081, 0, 0),
(15541, 264, -7149.8, 539.532, 5.34474, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.08821, 0, 0),
(15541, 265, -7141.45, 538.382, 6.5345, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.19031, 0, 0),
(15541, 266, -7124.94, 539.611, 8.79837, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.594349, 0, 0),
(15541, 267, -7124.94, 539.611, 8.79837, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.594349, 0, 0),
(15541, 268, -7096.07, 559.827, 9.06105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.519737, 0, 0),
(15541, 269, -7074.14, 570.737, 9.21615, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.452978, 0, 0),
(15541, 270, -7055.48, 579.401, 8.91715, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.339095, 0, 0),
(15541, 271, -7033.3, 581.961, 7.69663, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.8251, 0, 0),
(15541, 272, -7027.81, 578.488, 7.82374, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.61305, 0, 0),
(15541, 273, -7003.35, 560.111, 10.0738, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.77012, 0, 0),
(15541, 274, -6994.12, 555.279, 10.789, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.89971, 0, 0),
(15541, 275, -6971.16, 545.977, 12.5531, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.71907, 0, 0),
(15541, 276, -6963.99, 539.302, 11.223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.44811, 0, 0),
(15541, 277, -6963.99, 539.302, 11.223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.44811, 0, 0),
(15541, 278, -6951.38, 523.417, 7.45497, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.064206, 0, 0),
(15541, 279, -6932.52, 525.206, 6.87967, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.405854, 0, 0),
(15541, 280, -6910.77, 536.454, 5.98403, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.441197, 0, 0),
(15541, 281, -6890.04, 545.287, 4.17121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.339095, 0, 0),
(15541, 282, -6866.77, 552.948, 1.73102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.315533, 0, 0),
(15541, 283, -6849.96, 556.929, -0.124853, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.107403, 0, 0),
(15541, 284, -6828.53, 556.161, -1.31591, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.96647, 0, 0),
(15541, 285, -6811.72, 549.231, -0.449676, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.52665, 0, 0),
(15541, 286, -6805.68, 540.093, -0.889439, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.07112, 0, 0),
(15541, 287, -6797.24, 517.093, -0.001643, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.06327, 0, 0),
(15541, 288, -6789.19, 494.001, 3.80897, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.00044, 0, 0),
(15541, 289, -6789.19, 494.001, 3.80897, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.00044, 0, 0),
(15541, 290, -6782.8, 470.402, 6.88729, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.9651, 0, 0),
(15541, 291, -6777.81, 448.479, 8.23635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.863, 0, 0),
(15541, 292, -6777.81, 448.479, 8.23635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.863, 0, 0),
(15541, 293, -6775.02, 424.207, 10.8402, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.8198, 0, 0),
(15541, 294, -6772.4, 399.848, 12.9945, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.8198, 0, 0),
(15541, 295, -6771.25, 375.415, 13.9048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.75697, 0, 0),
(15541, 296, -6770.56, 353.532, 12.4543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.65094, 0, 0),
(15541, 297, -6772.69, 329.132, 8.25087, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.5724, 0, 0),
(15541, 298, -6772.69, 329.132, 8.25087, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.5724, 0, 0),
(15541, 299, -6776.96, 305.008, 5.71315, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.52528, 0, 0),
(15541, 300, -6780.88, 278.513, 4.82217, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.27533, 0, 0),
(15541, 301, -6774.67, 270.074, 3.44356, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.36172, 0, 0),
(15541, 302, -6774.67, 270.074, 3.44356, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.36172, 0, 0),
(15541, 303, -6761.04, 254.448, 2.76589, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.46775, 0, 0),
(15541, 304, -6746.12, 240.139, 3.58501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.82511, 0, 0),
(15541, 305, -6743.11, 238.827, 3.47093, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.94684, 0, 0),
(15541, 306, -6723.7, 233.256, 0.354174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.19817, 0, 0),
(15541, 307, -6707.6, 234.206, 2.14407, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.401932, 0, 0),
(15541, 308, -6690.34, 243.172, 3.02167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.759288, 0, 0),
(15541, 309, -6690.34, 243.172, 3.02167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.759288, 0, 0),
(15541, 310, -6673.31, 260.704, 3.89955, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.841755, 0, 0),
(15541, 311, -6657.19, 279.159, 3.90556, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.86139, 0, 0),
(15541, 312, -6657.19, 279.159, 3.90556, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.86139, 0, 0),
(15541, 313, -6637.75, 301.124, 3.42846, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.61399, 0, 0),
(15541, 314, -6616.3, 313.404, 3.37217, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.276268, 0, 0),
(15541, 315, -6610.57, 314.709, 3.38045, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.17024, 0, 0),
(15541, 316, -6588.86, 319.15, 2.14188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.908514, 0, 0),
(15541, 317, -6583.84, 326.755, -0.328794, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.987054, 0, 0),
(15541, 318, -6583.84, 326.755, -0.328794, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.987054, 0, 0),
(15541, 319, -6583.84, 326.755, -0.328794, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.987054, 0, 0),
(15541, 320, -6564.96, 355.03, 3.12191, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.806412, 0, 0),
(15541, 321, -6564.96, 355.03, 3.12191, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.806412, 0, 0),
(15541, 322, -6564.96, 355.03, 3.12191, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.806412, 0, 0),
(15541, 323, -6546.82, 371.491, 0.773827, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.739654, 0, 0),
(15541, 324, -6538.95, 379.691, 2.40596, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.849609, 0, 0),
(15541, 325, -6538.95, 379.691, 2.40596, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.849609, 0, 0),
(15541, 326, -6522.84, 398.149, 5.48816, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.853536, 0, 0),
(15541, 327, -6511.4, 411.906, 5.84552, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.9792, 0, 0),
(15541, 328, -6494.62, 442.794, 5.71744, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.24624, 0, 0),
(15541, 329, -6494.62, 442.794, 5.71744, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.723946, 0, 0),
(15541, 330, -6480.24, 455.155, 4.56112, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.621844, 0, 0),
(15541, 331, -6467.78, 463.666, 3.73075, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.578647, 0, 0),
(15541, 332, -6463.69, 466.871, 2.66855, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.665041, 0, 0),
(15541, 333, -6459.07, 469.336, 0.357515, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.488326, 0, 0),
(15541, 334, -6452.34, 473.297, 1.23904, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.578647, 0, 0),
(15541, 335, -6447.84, 477.083, 2.19392, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.723946, 0, 0),
(15541, 336, -6441.07, 484.1, 3.19477, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.806412, 0, 0),
(15541, 337, -6441.07, 484.1, 3.19477, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.743581, 0, 0),
(15541, 338, -6422.88, 500.376, 4.78336, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.727873, 0, 0),
(15541, 339, -6411.08, 510.095, 5.67832, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.621844, 0, 0),
(15541, 340, -6390.46, 523.301, 6.31597, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.559012, 0, 0),
(15541, 341, -6390.46, 523.301, 6.31597, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.559012, 0, 0),
(15541, 342, -6370.45, 536.218, 6.39885, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.05243, 0, 0);

-- Fixed NPC 9198 (Spirestone Mystics) who were skinnable though being humanoids
-- @TheTrueAnimal for pointing and @Metalica for fixing. This closes #689 
UPDATE `creature_template` SET `SkinningLootId` = 0 WHERE `Entry` = 9198;
DELETE FROM `skinning_loot_template` WHERE `entry` = 9198;


SET @GUID := '44726';

 -- -------------------

SET @SHARD := '179559';
SET @MAP := '429';
SET @RESPAWN := '-1' * ('7' * '24' * '60' * '60');

DELETE FROM `gameobject` WHERE `id`=@SHARD AND `guid` BETWEEN (@GUID + '00') AND (@GUID + '04');
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID + '00', @SHARD, @MAP, '275.8198', '-424.0976', '-119.9618', '0', '0', '0', '-0.8241262', '0.56640610', @RESPAWN, '0', '1'),
(@GUID + '01', @SHARD, @MAP, '274.3399', '-424.0255', '-119.9618', '0', '0', '0', '0.30901620', '0.95105680', @RESPAWN, '0', '1'),
(@GUID + '02', @SHARD, @MAP, '275.1532', '-424.8906', '-119.9618', '0', '0', '0', '-0.6494474', '0.76040640', @RESPAWN, '0', '1'),
(@GUID + '03', @SHARD, @MAP, '275.2957', '-423.4662', '-119.9618', '0', '0', '0', '-0.9816265', '0.19081240', @RESPAWN, '0', '1'),
(@GUID + '04', @SHARD, @MAP, '275.3406', '-422.5365', '-119.9618', '0', '0', '0', '0.98325440', '0.18223800', @RESPAWN, '0', '1');


DELETE FROM db_script_string WHERE entry = 2000005313;

-- Fixed faction of NPC 10080 (Sandarr Dunereaver) and 10081 (Dustwraith) in Zul'Farrak
-- They were previously friendly.
UPDATE `creature_template` SET `FactionAlliance` = 37, `FactionHorde` = 37 WHERE `Entry` IN (10080, 10081);
UPDATE `creature_template` SET `EquipmentTemplateId` = 958 WHERE `Entry` = 10082;
UPDATE `creature_template` SET `EquipmentTemplateId` = 923 WHERE `Entry` = 10081;

DELETE FROM `creature_equip_template_raw` WHERE `entry` = 923;
DELETE FROM `creature_equip_template` WHERE `entry` = 923;
INSERT INTO `creature_equip_template` VALUES
(923, 10612, 5262, 0);

-- Fixed quest text of quest 348 (Stranglethorn Fever) because it was obviously manually added and wrong
UPDATE `quest_template` SET `Objectives` = 'Sick...so...very s-s-sick....$b$b...have contracted Stranglethorn Fever...deadly v-v-virus...$b$b...only cure...is...is...to eat the heart of M-m-m-m-mokk the Savage...elusive white beast...$b$b...Witch doctor Unbagwa...only one who can s-s-summon....$b$b...seek Unbagwa in hidden cave on southern cape...$b$b...hurry...dying...dying....' WHERE `entry` = 348;


SET @GUID := '43097';

-- ---------------------

SET @KEG := '164911';
SET @MAP := '230';
SET @RESPAWN := '7' * '24' * '60' * '60';

DELETE FROM `gameobject` WHERE `id`=@KEG AND `guid` BETWEEN (@GUID + '00') AND (@GUID + '02');
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID + '00', @KEG, @MAP, '914.3752', '-146.9912', '-49.75655', '0', '0', '0', '-0.9636297', '0.2672410', @RESPAWN, '100', '1'),
(@GUID + '01', @KEG, @MAP, '915.7144', '-149.2887', '-49.75705', '0', '0', '0', '-0.9681473', '0.2503814', @RESPAWN, '100', '1'),
(@GUID + '02', @KEG, @MAP, '917.0272', '-151.5825', '-49.75756', '0', '0', '0', '-0.9681473', '0.2503814', @RESPAWN, '100', '1');

UPDATE `gameobject_template` SET `faction`='0' WHERE `entry`='179549';

UPDATE `quest_template` SET `PrevQuestId`='3906' WHERE `entry`='3907';



-- -----------------------

UPDATE `creature_template` SET `FactionAlliance`='190', `FactionHorde`='190' WHERE `Entry`='2914'; -- Snake
UPDATE `creature_template` SET `FactionAlliance`='31', `FactionHorde`='31' WHERE `Entry`='4075'; -- Rat
UPDATE `creature_template` SET `FactionAlliance`='188', `FactionHorde`='188' WHERE `Entry`='4076'; -- Roach

UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='11441'; -- Gordok Brute
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='11444'; -- Gordok Mage-Lord
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='13036'; -- Gordok Mastiff
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='11448'; -- Gordok Warlock
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='11450'; -- Gordok Reaver
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='11445'; -- Gordok Captain
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='11446'; -- Gordok Spirit
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='14351'; -- Gordok Bushwacker
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='14385'; -- Doomguard Minion
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='14386'; -- Wandering Eye of Kilrogg
UPDATE `creature_template` SET `FactionAlliance`='14', `FactionHorde`='14' WHERE `Entry`='13160'; -- Carrion Swarmer

UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='14322'; -- Stomper Kreeg <The Drunk>
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='14326'; -- Guard Mol'dar
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='14321'; -- Guard Fengus
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='14323'; -- Guard Slip'kik
UPDATE `creature_template` SET `FactionAlliance`='1374', `FactionHorde`='1374' WHERE `Entry`='14325'; -- Captain Kromcrush
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='14324'; -- Cho'Rush the Observer
UPDATE `creature_template` SET `FactionAlliance`='45', `FactionHorde`='45' WHERE `Entry`='11501'; -- King Gordok

UPDATE `creature_template` SET `FactionAlliance`='35', `FactionHorde`='35' WHERE `Entry`='14338'; -- Knot Thimblejack
UPDATE `creature_template` SET `FactionAlliance`='35', `FactionHorde`='35' WHERE `Entry`='14353'; -- Mizzle the Crafty

UPDATE `gameobject_template` SET `size`='3' WHERE `entry`='179512';


SET @GUID := '138677';

-- ---------------------------------------------

SET @REAVER := '11450';
SET @MAP := '429';
SET @RESPAWN := '2' * '60' * '60';
SET @COUNT := '15';

DELETE FROM `creature` WHERE `guid`='134876'; -- Gordok Captain being replaced by Reaver. Should be pooled properly, but addition to the system are needed.

DELETE FROM `creature` WHERE `id`=@REAVER AND `guid` BETWEEN (@GUID + '00') AND (@GUID + @COUNT - '1');
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID + '00', @REAVER, @MAP, '0', '0', '387.4085', '462.7724', '-7.148942', '2.6878070', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '01', @REAVER, @MAP, '0', '0', '419.0150', '538.2688', '-18.26003', '0.4886922', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '02', @REAVER, @MAP, '0', '0', '530.1689', '580.4394', '-25.31940', '1.4137170', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '03', @REAVER, @MAP, '0', '0', '530.2059', '600.8753', '-25.31940', '4.8694690', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '04', @REAVER, @MAP, '0', '0', '593.2279', '565.1199', '-4.671438', '3.1066860', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '05', @REAVER, @MAP, '0', '0', '484.1014', '523.8082', '27.997650', '1.4486230', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '06', @REAVER, @MAP, '0', '0', '497.7333', '523.8073', '27.998240', '1.6406100', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '07', @REAVER, @MAP, '0', '0', '480.2641', '558.1676', '27.995270', '1.8500490', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '08', @REAVER, @MAP, '0', '0', '485.1412', '564.9458', '27.995090', '3.2114060', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '09', @REAVER, @MAP, '0', '0', '565.9363', '486.7255', '29.547450', '4.2586040', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '10', @REAVER, @MAP, '0', '0', '559.2202', '477.3137', '29.547450', '0.8552113', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '11', @REAVER, @MAP, '0', '0', '688.4595', '505.9162', '29.552950', '2.3038350', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '12', @REAVER, @MAP, '0', '0', '541.6950', '582.7410', '-4.671440', '5.6723200', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '13', @REAVER, @MAP, '0', '0', '522.9580', '554.5040', '28.000600', '2.1991100', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0'),
(@GUID + '14', @REAVER, @MAP, '0', '0', '748.4830', '433.1610', '28.266480', '3.5604720', @RESPAWN, '0', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@REAVER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@REAVER), '0', '0');


SET @GUID := '138692';

-- ---------------------------------------------

SET @CARRIONSWARMER := '13160';
SET @COUNT := '50';
SET @MAP := '429';
SET @RESPAWN := '2' * '60' * '60';

UPDATE `creature_template` SET `ModelId2`='13097' WHERE `Entry`='13160';

DELETE FROM `creature` WHERE `id`=@CARRIONSWARMER;
DELETE FROM `creature` WHERE `guid` BETWEEN (@GUID + 00) AND (@GUID + @COUNT - 1);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
((@GUID := @GUID + 0), @CARRIONSWARMER, @MAP, '0', '0', '532.7290', '535.45750', '-25.31940', '4.485496', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '478.7725', '542.63710', '-25.28667', '4.625123', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '506.4361', '541.64470', '-25.30522', '4.555309', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '494.0698', '531.72560', '-25.30895', '4.590216', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '512.3397', '556.75360', '-25.31533', '4.537856', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '479.4313', '534.18290', '-25.30033', '4.625123', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '520.4340', '531.47490', '-25.31460', '4.520403', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '480.3777', '551.96770', '-25.29888', '4.625123', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '522.0546', '543.64770', '-25.31568', '4.520403', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '533.7919', '552.40670', '-25.31940', '4.502949', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '462.8175', '251.53500', '8.8173770', '4.555309', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '449.7683', '243.47860', '11.297720', '4.660029', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '462.6022', '260.84490', '8.9096290', '4.572762', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '477.1857', '250.99920', '2.9512510', '4.433136', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '471.8947', '252.93710', '4.9657260', '4.485496', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '452.4716', '260.48950', '11.303170', '4.642576', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '448.1017', '251.62600', '11.296410', '4.677482', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '452.7207', '247.39500', '11.300130', '4.642576', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '455.3728', '253.91550', '11.303900', '4.625123', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '448.4704', '258.71660', '11.298890', '4.677482', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '474.5892', '316.70310', '2.9362390', '4.537856', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '467.4713', '316.58610', '2.9362500', '4.590216', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '483.9162', '328.99870', '2.9362550', '4.502949', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '494.2127', '319.36020', '2.9362270', '4.450590', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '490.8800', '329.76070', '2.9362490', '4.468043', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '471.9471', '324.63260', '2.9362590', '4.572762', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '485.1870', '320.71150', '2.9362340', '4.485496', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '478.2815', '324.03800', '2.9362510', '4.537856', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '486.4880', '313.60010', '2.9362180', '4.485496', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '493.1786', '309.85220', '2.9362050', '4.433136', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '396.8296', '-98.32212', '-3.803594', '1.378810', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '400.0482', '-105.0312', '-3.803111', '1.396263', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '403.6488', '-110.2321', '-3.802753', '1.413717', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '414.9770', '-98.74563', '-3.803658', '1.448623', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '414.4864', '-108.6242', '-3.802916', '1.448623', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '427.6517', '-100.8249', '-3.803568', '1.500983', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '424.8745', '-110.3578', '-3.802841', '1.500983', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '437.5299', '-108.4350', '-3.803006', '1.553343', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '445.7453', '-113.9387', '-3.802556', '1.570796', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '444.6700', '-99.75545', '-3.803718', '1.570796', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '460.2359', '-68.97313', '-3.803645', '1.500983', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '456.6826', '-57.28893', '-4.253410', '1.500983', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '464.6496', '-53.98102', '-3.803182', '1.553343', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '470.4993', '-60.37534', '-3.802882', '1.570796', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '470.6470', '-70.00087', '-3.802982', '1.570796', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '471.2401', '-46.80048', '-3.802765', '1.710423', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '461.8682', '-40.83654', '-3.803358', '1.658063', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '472.6571', '-33.71276', '-3.802353', '1.727876', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '460.3629', '-24.53695', '-3.803384', '1.658063', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1'),
((@GUID := @GUID + 1), @CARRIONSWARMER, @MAP, '0', '0', '473.4761', '-22.86045', '-3.801760', '1.745329', @RESPAWN, '2', '0', (SELECT `MaxLevelHealth` FROM `creature_template` WHERE `entry`=@CARRIONSWARMER), (SELECT `MaxLevelMana` FROM `creature_template` WHERE `Entry`=@CARRIONSWARMER), '0', '1');

-- Fixed drop chance of item 4892 (Durotar Tiger Fur) which was too low
-- Thanks to TheTrueAnimal for reporting. This closes #694
-- Source: https://web.archive.org/web/20070527004201/http://wow.allakhazam.com/db/mob.html?wmob=3121
-- https://web.archive.org/web/20090212060422/http://thottbot.com/c3121
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -35 WHERE `item` = 4892;


-- Added missing recipes/plans loots in item 20469 (Decoded True Believer Clippings)
-- Thanks to TheTrueAnimal for pointing. This closes #693
-- Source: http://www.wowhead.com/item=20469#contains
DELETE FROM `item_loot_template` WHERE `entry` = 20469 AND `item` IN (20546, 20547, 20548, 20553, 20554, 20555);
INSERT INTO `item_loot_template` VALUES
(20469, 20546, 5, 0, 1, 1, 0),
(20469, 20547, 5, 0, 1, 1, 0),
(20469, 20548, 5, 0, 1, 1, 0),
(20469, 20553, 5, 0, 1, 1, 0),
(20469, 20554, 5, 0, 1, 1, 0),
(20469, 20555, 5, 0, 1, 1, 0);

-- Fixed Z position of GO 30856 (Atal'ai Artifact) in Swamp of Sorrows
-- Thanks TheTrueAnimal for pointing. This closes #697
UPDATE `gameobject` SET `position_z` = 18.79 WHERE `guid` = 30561;

-- Fixed drop chance of item 20378 (Twilight Tablet Fragment) in Silithus
-- The item should not drop 100% of the time for players on the quest as
-- the main source intented are the GO on the ground
-- Thanks TheTrueAnimal for pointing. This closes #665 
-- Source: http://web.archive.org/web/20070315154609/http://www.thottbot.com/i20378
-- https://web.archive.org/web/20060720204038/http://wow.allakhazam.com/db/mob.html?wmob=11746
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -5 WHERE `item` = 20378; 

SET @PHALANX := '9502';

-- ---------------------

UPDATE `creature` SET `modelid`='0', `position_x`='847.848', `position_y`='-230.0667', `position_z`='-43.61398', `orientation`='1.64061', `spawntimesecs`='604800' WHERE `id`=@PHALANX;
SET @PHALANX := '9502';

-- -----------------------

UPDATE `creature_template` SET `FactionAlliance`='35', `FactionHorde`='35', `MeleeBaseAttackTime`='2000', `MovementType`='0' WHERE `Entry`=@PHALANX;

 UPDATE `gameobject_template` SET `size`='0.2' WHERE `entry`='161513';
 
 


-- ---------------

SET @ENTRY := '9500';
SET @POINT := '0';

UPDATE `creature` SET `position_x`='874.3762', `position_y`='-187.6327', `position_z`='-43.62038', `orientation`='2.164208', `modelid`='0', `spawndist`='0' WHERE `id`=@ENTRY;

DELETE FROM `creature_movement` WHERE `id`=(SELECT `guid` FROM `creature` WHERE `id`=@ENTRY);
DELETE FROM `creature_movement_template` WHERE `entry`=@ENTRY;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@ENTRY, @POINT := @POINT + '1', '876.3792', '-197.3044', '-43.70371', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '865.9424', '-201.7926', '-43.70371', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '856.1331', '-216.7420', '-43.70494', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '847.7590', '-219.7263', '-43.70203', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '847.7590', '-219.7263', '-43.70203', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '842.4940', '-211.2741', '-43.69165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '834.2650', '-195.0288', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '834.2650', '-195.0288', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '827.3196', '-180.0794', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '830.1271', '-170.9186', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '830.1271', '-170.9186', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '837.7622', '-167.4380', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '834.8788', '-158.4584', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '834.8788', '-158.4584', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '850.8875', '-158.5179', '-49.75803', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '860.3868', '-144.9282', '-49.75497', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '860.3868', '-144.9282', '-49.75497', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '873.7460', '-150.5549', '-49.75750', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '873.7460', '-150.5549', '-49.75750', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '871.8535', '-157.4179', '-49.75930', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '860.0489', '-158.3442', '-49.75855', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '843.7286', '-164.5333', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '843.7286', '-164.5333', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '831.4695', '-174.8025', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '831.4695', '-174.8025', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '832.6170', '-186.6620', '-49.75323', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '839.8559', '-204.9304', '-46.02564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '839.8559', '-204.9304', '-46.02564', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '849.8252', '-218.7138', '-43.70274', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '855.3878', '-214.2639', '-43.70450', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '855.3878', '-214.2639', '-43.70450', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '867.6884', '-203.8905', '-43.70837', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
-- (@ENTRY, @POINT := @POINT + '1', '890.0127', '-185.4018', '-43.70371', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '890.0127', '-185.4018', '-43.70371', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');


UPDATE `creature` SET `spawndist`='30', `MovementType`='1' WHERE `id`='5937';

UPDATE `quest_template` SET `PrevQuestId`='0' WHERE `entry`='3761';


UPDATE `quest_template` SET `ReqItemId2`='0', `ReqItemCount2`='0' WHERE `entry`='6621';


-- --------------------

UPDATE `quest_template` SET `PrevQuestId`='0' WHERE `entry`='509';
UPDATE `quest_template` SET `PrevQuestId`='0' WHERE `entry`='501';




-- ----------------------

DELETE FROM `npc_trainer` WHERE `spell`='17938';
INSERT INTO `npc_trainer` (`entry`, `spell`, `spellcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES
('0461', '17938', '22000', '17862', '0', '56'),
('0906', '17938', '22000', '17862', '0', '56'),
('0988', '17938', '22000', '17862', '0', '56'),
('2127', '17938', '22000', '17862', '0', '56'),
('3172', '17938', '22000', '17862', '0', '56'),
('3324', '17938', '22000', '17862', '0', '56'),
('3325', '17938', '22000', '17862', '0', '56'),
('3326', '17938', '22000', '17862', '0', '56'),
('4563', '17938', '22000', '17862', '0', '56'),
('4564', '17938', '22000', '17862', '0', '56'),
('5171', '17938', '22000', '17862', '0', '56'),
('5172', '17938', '22000', '17862', '0', '56'),
('5173', '17938', '22000', '17862', '0', '56'),
('5495', '17938', '22000', '17862', '0', '56'),
('5496', '17938', '22000', '17862', '0', '56'),
('5612', '17938', '22000', '17862', '0', '56');



-- --------------

SET @ENTRY := '9025';
SET @POINT := '0';

UPDATE `creature` SET `position_x`='654.6364', `position_y`='-172.4347', `position_z`='-73.61314', `orientation`='5.094945', `modelid`='0', `spawndist`='0' WHERE `id`=@ENTRY;

DELETE FROM `creature_movement` WHERE `id`=(SELECT `guid` FROM `creature` WHERE `id`=@ENTRY);
DELETE FROM `creature_movement_template` WHERE `entry`=@ENTRY;

INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@ENTRY, @POINT := @POINT + '1', '657.9712', '-180.7225', '-74.74625', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '658.9824', '-196.5155', '-76.57832', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '657.6954', '-216.0597', '-80.31235', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '640.0506', '-245.6001', '-83.58563', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '615.5219', '-267.3967', '-83.59071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '601.0486', '-274.4931', '-83.14562', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '578.9769', '-274.0088', '-80.12082', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '556.1347', '-263.5568', '-73.27393', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '578.9769', '-274.0088', '-80.12082', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '601.0486', '-274.4931', '-83.14562', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '615.5219', '-267.3967', '-83.59071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '640.0062', '-245.6395', '-83.58392', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '657.6954', '-216.0597', '-80.31235', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '658.9824', '-196.5155', '-76.57832', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '657.9712', '-180.7225', '-74.74625', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'),
(@ENTRY, @POINT := @POINT + '1', '651.8094', '-164.6052', '-72.57027', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

-- Huntress Skymane was tired of listening to Archaelogist Greywhiskers
-- 'stories' all day everyday and has joined her colleagues patrolling
-- around Darnassus
DELETE FROM `creature_movement_template` WHERE `entry` = 14378;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES 
(14378, 1, 9656.18, 2598.45, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.42763, 0, 0),
(14378, 2, 9660.32, 2598.62, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.67758, 0, 0),
(14378, 3, 9664.55, 2596.83, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.59118, 0, 0),
(14378, 4, 9668.79, 2593.05, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.54799, 0, 0),
(14378, 5, 9681.01, 2581.18, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.4773, 0, 0),
(14378, 6, 9700.06, 2560.13, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.46553, 0, 0),
(14378, 7, 9704.62, 2554.05, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.25347, 0, 0),
(14378, 8, 9706.54, 2550.39, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.09247, 0, 0),
(14378, 9, 9710.17, 2537.88, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.80187, 0, 0),
(14378, 10, 9710.75, 2520.64, 1335.69, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.75475, 0, 0),
(14378, 11, 9710.52, 2513.64, 1335.69, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.68406, 0, 0),
(14378, 12, 9709.42, 2508.07, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.47201, 0, 0),
(14378, 13, 9707.4, 2500.94, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.40525, 0, 0),
(14378, 14, 9705.06, 2494.84, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.23247, 0, 0),
(14378, 15, 9701.5, 2489.61, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.00078, 0, 0),
(14378, 16, 9696.14, 2483, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.99292, 0, 0),
(14378, 17, 9689.93, 2476.24, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.96936, 0, 0),
(14378, 18, 9671.14, 2457.36, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.87904, 0, 0),
(14378, 19, 9665.81, 2451.59, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.03612, 0, 0),
(14378, 20, 9662.34, 2445.56, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.28744, 0, 0),
(14378, 21, 9658.51, 2433.99, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.58196, 0, 0),
(14378, 22, 9656.64, 2416.64, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.6605, 0, 0),
(14378, 23, 9656.21, 2411.23, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.33201, 0, 0),
(14378, 24, 9657.62, 2407.5, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.087112, 0, 0),
(14378, 25, 9660.41, 2404.48, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.0885, 0, 0),
(14378, 26, 9663.79, 2405, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.52832, 0, 0),
(14378, 27, 9666.78, 2408.15, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.1631, 0, 0),
(14378, 28, 9667.68, 2414.61, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.60685, 0, 0),
(14378, 29, 9666.67, 2431.41, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.52438, 0, 0),
(14378, 30, 9666.84, 2434.89, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.4105, 0, 0),
(14378, 31, 9668.17, 2437.16, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.923555, 0, 0),
(14378, 32, 9671.37, 2439.07, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.534783, 0, 0),
(14378, 33, 9682.48, 2445.66, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.534783, 0, 0),
(14378, 34, 9686.26, 2448.24, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.6683, 0, 0),
(14378, 35, 9689.86, 2451.4, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.735059, 0, 0),
(14378, 36, 9699.59, 2460.19, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.617249, 0, 0),
(14378, 37, 9704.56, 2466.22, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.970683, 0, 0),
(14378, 38, 9711.66, 2477.24, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.998172, 0, 0),
(14378, 39, 9716.87, 2487.32, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.15918, 0, 0),
(14378, 40, 9723.13, 2504.55, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.24557, 0, 0),
(14378, 41, 9723.82, 2507.46, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.954975, 0, 0),
(14378, 42, 9725.99, 2508.91, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.562276, 0, 0),
(14378, 43, 9728.13, 2509.97, 1335.11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.358073, 0, 0),
(14378, 47, 9765.19, 2520.92, 1322.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.275602, 0, 0),
(14378, 48, 9769, 2521.82, 1320.64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.161719, 0, 0),
(14378, 49, 9777.07, 2522.24, 1318.95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.043909, 0, 0),
(14378, 50, 9887.82, 2524.85, 1318.66, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.024274, 0, 0),
(14378, 51, 9893.16, 2527.88, 1317.06, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.177427, 0, 0),
(14378, 52, 9900.56, 2529.79, 1315.35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.338434, 0, 0),
(14378, 53, 9905.75, 2532.06, 1316.06, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.515148, 0, 0),
(14378, 54, 9909.68, 2535.14, 1316.31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.809673, 0, 0),
(14378, 55, 9913.72, 2539.99, 1316.71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.872505, 0, 0),
(14378, 56, 9916.63, 2543.21, 1316.93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.73506, 0, 0),
(14378, 57, 9921.87, 2547.48, 1317.18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.487659, 0, 0),
(14378, 58, 9928.26, 2550.77, 1317.37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.436608, 0, 0),
(14378, 59, 9942.23, 2554.12, 1316.52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.126376, 0, 0),
(14378, 60, 9948.7, 2553.54, 1316.38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.06791, 0, 0),
(14378, 61, 9954.08, 2551.81, 1316.45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.85979, 0, 0),
(14378, 62, 9969.74, 2542.73, 1316.55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.67915, 0, 0),
(14378, 63, 9975.08, 2537.6, 1316.39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.4828, 0, 0),
(14378, 64, 9981.07, 2529.62, 1316.28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.1176, 0, 0),
(14378, 65, 9982.52, 2524.88, 1316.41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.75631, 0, 0),
(14378, 66, 9981.29, 2520.33, 1316.73, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.19083, 0, 0),
(14378, 67, 9974.37, 2515.55, 1317.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.66461, 0, 0),
(14378, 68, 9970.36, 2511.68, 1317.56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.22617, 0, 0),
(14378, 69, 9967.51, 2504.84, 1317.04, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.37147, 0, 0),
(14378, 70, 9964.53, 2499.52, 1316.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.10051, 0, 0),
(14378, 71, 9955.46, 2488.89, 1316.39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.00233, 0, 0),
(14378, 72, 9952.66, 2484.78, 1316.27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.24581, 0, 0),
(14378, 73, 9951.14, 2479.14, 1316.13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.6817, 0, 0),
(14378, 74, 9951.26, 2476.07, 1316.13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.7838, 0, 0),
(14378, 75, 9954.01, 2390.72, 1329.11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.7406, 0, 0),
(14378, 76, 9954.07, 2376.3, 1329.95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.69348, 0, 0),
(14378, 77, 9953.15, 2341.6, 1330.78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.68562, 0, 0),
(14378, 78, 9952.9, 2336.6, 1331.57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.69348, 0, 0),
(14378, 79, 9952.84, 2329.64, 1333.63, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.71704, 0, 0),
(14378, 80, 9952.91, 2323.1, 1335.56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.72882, 0, 0),
(14378, 81, 9954.13, 2282.49, 1341.39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.7406, 0, 0),
(14378, 82, 9954.13, 2273.11, 1341.39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.71311, 0, 0),
(14378, 83, 9954.69, 2263.74, 1338.3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.85448, 0, 0),
(14378, 84, 9955.94, 2257.77, 1336.06, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.98799, 0, 0),
(14378, 85, 9956.46, 2254.1, 1335.34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.77594, 0, 0),
(14378, 86, 9955.66, 2143.38, 1327.65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.70526, 0, 0),
(14378, 87, 9955.42, 2140.11, 1327.64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.45393, 0, 0),
(14378, 88, 9953.75, 2133.55, 1327.65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.47357, 0, 0),
(14378, 89, 9953.16, 2129.89, 1327.65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.64242, 0, 0),
(14378, 90, 9952.9, 2125.32, 1327.65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.68169, 0, 0),
(14378, 91, 9953.07, 2118.56, 1327.64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.81521, 0, 0),
(14378, 92, 9953.7, 2114.02, 1327.64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.02726, 0, 0),
(14378, 93, 9954.83, 2110.26, 1327.7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.96836, 0, 0),
(14378, 94, 9955.46, 2106.18, 1327.72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.7406, 0, 0),
(14378, 95, 9955.73, 2095.28, 1327.72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.73274, 0, 0),
(14378, 96, 9955.64, 2091.79, 1327.72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.52069, 0, 0),
(14378, 97, 9954.58, 2088.01, 1327.7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.40288, 0, 0),
(14378, 98, 9952.2, 2079.61, 1327.69, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.50891, 0, 0),
(14378, 99, 9951.83, 2074.18, 1327.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.77987, 0, 0),
(14378, 100, 9952.93, 2071.12, 1327.79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.19613, 0, 0),
(14378, 101, 9958.11, 2062.54, 1327.98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.28252, 0, 0),
(14378, 102, 9960.81, 2058.57, 1328.06, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.17649, 0, 0),
(14378, 103, 9962.73, 2054.9, 1328.13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.32964, 0, 0),
(14378, 104, 9965.36, 2051.71, 1328.16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.50635, 0, 0),
(14378, 105, 9966.79, 2050.07, 1328.16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.26288, 0, 0),
(14378, 106, 9967.93, 2046.62, 1328.15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.73274, 0, 0),
(14378, 107, 9966.99, 2045.42, 1328.17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.02588, 0, 0),
(14378, 108, 9964.74, 2044.57, 1328.21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.26012, 0, 0),
(14378, 109, 9962.34, 2046.65, 1328.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.37262, 0, 0),
(14378, 110, 9960.36, 2049.51, 1328.27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.20376, 0, 0),
(14378, 111, 9959.07, 2052.04, 1328.26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.00741, 0, 0),
(14378, 112, 9950.28, 2069.64, 1327.87, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.0349, 0, 0),
(14378, 113, 9948.29, 2074.48, 1327.77, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.90531, 0, 0),
(14378, 114, 9948.3, 2084.36, 1327.76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.43799, 0, 0),
(14378, 115, 9949.6, 2089.89, 1327.76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.36731, 0, 0),
(14378, 116, 9951.77, 2094.43, 1327.73, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.5558, 0, 0),
(14378, 117, 9951.88, 2102.69, 1327.76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.73252, 0, 0),
(14378, 118, 9951.08, 2106.76, 1327.74, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.81891, 0, 0),
(14378, 119, 9949.91, 2112.98, 1327.66, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.67754, 0, 0),
(14378, 120, 9949.73, 2123.24, 1327.65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.56366, 0, 0),
(14378, 121, 9950.77, 2216.92, 1330.02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.55973, 0, 0),
(14378, 122, 9950.73, 2222.15, 1330.64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.59115, 0, 0),
(14378, 123, 9950.12, 2272.14, 1341.39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.57544, 0, 0),
(14378, 124, 9949.18, 2292.22, 1341.39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.60293, 0, 0),
(14378, 125, 9948.65, 2319.06, 1336.55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.60293, 0, 0),
(14378, 126, 9945.79, 2405.51, 1328.19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.599, 0, 0),
(14378, 127, 9944.77, 2436.95, 1324.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.60293, 0, 0),
(14378, 128, 9943.98, 2461.62, 1319.47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.30448, 0, 0),
(14378, 129, 9946.07, 2472.11, 1316.96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.38302, 0, 0),
(14378, 130, 9946.62, 2477.31, 1316.07, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.58329, 0, 0),
(14378, 131, 9945.8, 2482.44, 1316.18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.7443, 0, 0),
(14378, 132, 9944.39, 2485.33, 1316.42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.39225, 0, 0),
(14378, 133, 9939.86, 2488.75, 1317.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.56112, 0, 0),
(14378, 134, 9937.21, 2490.67, 1317.35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.36476, 0, 0),
(14378, 135, 9935.45, 2493.64, 1317.81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.91709, 0, 0),
(14378, 136, 9935.56, 2497.12, 1317.81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.44978, 0, 0),
(14378, 137, 9936.5, 2501.6, 1317.84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.1042, 0, 0),
(14378, 138, 9938.76, 2506.57, 1317.83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.23379, 0, 0),
(14378, 139, 9937.61, 2510.13, 1317.81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.74568, 0, 0),
(14378, 140, 9933.53, 2505.2, 1317.86, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.1594, 0, 0),
(14378, 141, 9932.98, 2502.82, 1317.82, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.87273, 0, 0),
(14378, 142, 9930.73, 2501.57, 1317.82, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.22478, 0, 0),
(14378, 143, 9926.17, 2501.67, 1318.13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.97345, 0, 0),
(14378, 144, 9921.99, 2503.47, 1317.86, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.46687, 0, 0),
(14378, 145, 9918.42, 2506.99, 1317.34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.2823, 0, 0),
(14378, 146, 9916.02, 2511.1, 1317.06, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.99955, 0, 0),
(14378, 147, 9915.6, 2522.91, 1317.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.21161, 0, 0),
(14378, 148, 9911.31, 2527.55, 1316.39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.41189, 0, 0),
(14378, 149, 9901.36, 2531.99, 1315.34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.75746, 0, 0),
(14378, 150, 9890.5, 2534.01, 1317.81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.94988, 0, 0),
(14378, 151, 9884.43, 2535.28, 1318.87, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.15801, 0, 0),
(14378, 152, 9777.34, 2532, 1318.99, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.16587, 0, 0),
(14378, 153, 9735.71, 2535.47, 1332.35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.29153, 0, 0),
(14378, 154, 9730.37, 2536.56, 1334.2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.95774, 0, 0),
(14378, 155, 9727.23, 2537.47, 1335.28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.62001, 0, 0),
(14378, 156, 9723.26, 2538.83, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.43937, 0, 0),
(14378, 157, 9719.95, 2541.6, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.08202, 0, 0),
(14378, 158, 9717.02, 2545.67, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.96421, 0, 0),
(14378, 159, 9712.54, 2553.65, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.91708, 0, 0),
(14378, 160, 9708.45, 2562.34, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.04275, 0, 0),
(14378, 161, 9704.53, 2567.86, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.21946, 0, 0),
(14378, 162, 9694.25, 2580.62, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.29407, 0, 0),
(14378, 163, 9689.33, 2585.89, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.34512, 0, 0),
(14378, 164, 9683.97, 2591, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.41581, 0, 0),
(14378, 165, 9678.26, 2595.75, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.47079, 0, 0),
(14378, 166, 9672.37, 2599.93, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.56896, 0, 0),
(14378, 167, 9665.34, 2604.32, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.47471, 0, 0),
(14378, 168, 9662.25, 2608.53, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.99308, 0, 0),
(14378, 169, 9660.53, 2612.76, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.48395, 0, 0),
(14378, 170, 9660.33, 2624.77, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.03373, 0, 0),
(14378, 171, 9659.92, 2629.83, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.29429, 0, 0),
(14378, 172, 9656.99, 2633.21, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.63898, 0, 0),
(14378, 173, 9652.51, 2633.65, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.23588, 0, 0),
(14378, 174, 9650.51, 2632.43, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.95845, 0, 0),
(14378, 175, 9649.64, 2628.57, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.30794, 0, 0),
(14378, 176, 9649.42, 2625.32, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.78703, 0, 0),
(14378, 177, 9650.64, 2608.98, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.78703, 0, 0),
(14378, 178, 9653.03, 2601.61, 1335.68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.16009, 0, 0);

UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 14378;
UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` = 14378;

DELETE FROM `creature` WHERE `guid` = 54310;


-- Fixed model of NPC 12423 (Guard Roberts) and 1642 (Northshire Guard) who
-- were using wrong alternate model
-- Thanks Metalica for pointing and Tobschinski for researching. This closes #696
UPDATE `creature_model_info` SET `modelid_other_gender` = 0 WHERE `modelid` IN (3257, 3258);
UPDATE `creature_template` SET `modelid2` = 0 WHERE `Entry` = 1642; -- Northshire Guard
UPDATE `creature_model_info` SET `modelid_other_gender` = 3167 WHERE `modelid` = 5446;

-- Fixed model of NPC 1281 (Mountaineer Zaren) who were using an male alternate model
-- though she is female. Dwarves are really strange...
UPDATE `creature_model_info` SET `modelid_other_gender` = 0 WHERE `modelid` IN (1812, 4887);

-- Added missing entry for creature template 12529 (Illusion: Black Dragonkin) required for quest 6570 (Emberstrife)
-- for the Horde Onyxia quest line
-- Thanks Metalica for pointing. This closes #699
DELETE FROM `creature_template` WHERE `Entry` = 12536;
INSERT INTO `creature_template` (`Entry`, `Name`, `SubName`, `MinLevel`, `MaxLevel`, `ModelId1`, `ModelId2`, `FactionAlliance`, `FactionHorde`, `Scale`, `Family`, `CreatureType`, `InhabitType`, `RegenerateStats`, `RacialLeader`, `NpcFlags`, `UnitFlags`, `DynamicFlags`, `ExtraFlags`, `CreatureTypeFlags`, `SpeedWalk`, `SpeedRun`, `UnitClass`, `Rank`, `HealthMultiplier`, `PowerMultiplier`, `DamageMultiplier`, `DamageVariance`, `ArmorMultiplier`, `ExperienceMultiplier`, `MinLevelHealth`, `MaxLevelHealth`, `MinLevelMana`, `MaxLevelMana`, `MinMeleeDmg`, `MaxMeleeDmg`, `MinRangedDmg`, `MaxRangedDmg`, `Armor`, `MeleeAttackPower`, `RangedAttackPower`, `MeleeBaseAttackTime`, `RangedBaseAttackTime`, `DamageSchool`, `MinLootGold`, `MaxLootGold`, `LootId`, `PickpocketLootId`, `SkinningLootId`, `KillCredit1`, `KillCredit2`, `MechanicImmuneMask`, `ResistanceHoly`, `ResistanceFire`, `ResistanceNature`, `ResistanceFrost`, `ResistanceShadow`, `ResistanceArcane`, `PetSpellDataId`, `MovementType`, `TrainerType`, `TrainerSpell`, `TrainerClass`, `TrainerRace`, `TrainerTemplateId`, `VendorTemplateId`, `GossipMenuId`, `EquipmentTemplateId`, `AIName`) VALUES
(12536, 'Illusion: Black Dragonkin', '', 1, 1, 12529, 0, 35, 35, 1, 0, 2, 3, 3, 0, 0, 0, 0, 0, 0, 1.2, 1.14286, 1, 0, 1.35, 1, 1, 1, 1, 1, 5000, 5000, 0, 0, 2, 2, 1, 1, 7, 24, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');




-- ---------------------------------------

DELETE FROM `dbscripts_on_go_template_use` WHERE `buddy_entry`='160836';
INSERT INTO `dbscripts_on_go_template_use` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
('174554', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174555', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174556', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174557', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174558', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174559', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174560', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174561', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174562', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174563', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174564', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer'),
('174566', '0', '27', '8', '0', '160836', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Relic Coffer Door - Access: Relic Coffer');

-- Prevent NPCs 12238 (Zaetar's Spirit) and 13716 (Celebras the Redeemed) to roam
-- around their spawn point. Now, players will be able to speak with them
-- and get the quest they offer without having the window abruptly closed
-- every few seconds
UPDATE `creature_template` SET `MovementType` = 0 WHERE `Entry` IN (12238, 13716);

-- Linked NPC 12236 (Lord Vyletongue) in Maraudon to its two adds
DELETE FROM `creature_linking` WHERE `guid` IN (54676, 54675);
INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`) VALUES
(54675, 54579, 3),
(54676, 54579, 3);

-- Fixed equipment of NPC 13601 (Tinkerer Gizlock) in Maraudon
-- because it was using Naxxramas model
SET @ENTRY := 2421;

DELETE FROM `creature_equip_template` WHERE `entry` = @ENTRY;
INSERT INTO `creature_equip_template` VALUES
(@ENTRY, 10825, 11586, 12523);

UPDATE `creature_template` SET `EquipmentTemplateId` = @ENTRY WHERE `Entry` = 13601; 

-- Linked NPC 12225 (Celebras the Cursed) with its 3 adds 13743 (Corrupt Force of Nature) in Maraudon
-- The adds will engage along with their master, respawn when it evades, despawn when it dies
DELETE FROM `creature_linking_template` WHERE `entry` = 13743;
INSERT `creature_linking_template` VALUES
(13743, 349, 12225, 1 + 2 + 4 + 16, 0);

-- Adjusted creatures spawned HP to change in template value
UPDATE `creature` SET `curhealth` = 1716 WHERE `id` = 1088;

-- Readded NPCs removed in previous commit by wrong variable set
DELETE FROM `creature` WHERE `guid` BETWEEN 1 AND 5;
INSERT INTO `creature` VALUES
(1, 2843, 0, 4481, 0, -14467.8, 468.374, 15.1064, 0.139626, 300, 0, 0, 2766, 0, 0, 0),
(2, 7853, 0, 7036, 0, -14464.9, 459.585, 15.2488, 3.735, 300, 0, 0, 1605, 0, 0, 0),
(3, 2499, 0, 7429, 0, -14355.9, 433.399, 7.55289, 1.79769, 300, 0, 0, 2284, 0, 0, 0),
(4, 2838, 0, 7181, 0, -14430.2, 410.963, 15.3606, 3.03687, 300, 0, 0, 3077, 0, 0, 0),
(5, 2839, 0, 4478, 0, -14340.6, 414.604, 6.71338, 2.19912, 300, 0, 0, 2568, 0, 0, 0);

DELETE FROM `pool_creature` WHERE  `guid` BETWEEN 1 AND 5;

-- Reapplied rev 08223 with correct values for GUID
SET @GUID := 155621;
SET @POOL := 1208;
-- ----------------------------
-- Sandarr Dunereaver (10080)
-- ----------------------------
DELETE FROM `creature` WHERE `guid` IN (@GUID, @GUID + 1);
INSERT INTO `creature` VALUES (@GUID, 10080, 209, 0, 0, 1546.25, 1017.14, 8.87683, 0.0109968, 7200, 0, 0, 5544, 0, 0, 0); -- Sandarr Dunereaver
INSERT INTO `creature` VALUES (@GUID + 1, 7269, 209, 0, 0, 1546.25, 1017.14, 8.87683, 0.0109968, 60, 5, 0, 1782, 0, 0, 1); -- Sandarr Dunereaver placeholder
DELETE FROM `pool_creature` WHERE `guid` IN (@GUID, @GUID + 1);
INSERT INTO `pool_creature` VALUES
(@GUID, @POOL, 10, 'Sandarr Dunereaver (Zul\'Farrak)'),
(@GUID + 1, @POOL, 0, 'Sandarr Dunereaver placeholder (Zul\'Farrak)');
DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` VALUES
(@POOL, 1, 'Sandarr Dunereaver (Zul\'Farrak)');
-- ----------------------------
-- Dustwraith (10081)
-- ----------------------------
DELETE FROM `creature` WHERE `guid` IN (@GUID + 2, @GUID + 3);
INSERT INTO `creature` VALUES (@GUID + 2, 10081, 209, 0, 0, 1627.47, 1186.85, 8.87693, 0.647954, 7200, 15, 0, 5757, 0, 0, 1); -- Dustwraith
INSERT INTO `creature` VALUES (@GUID + 3, 7269, 209, 0, 0, 1627.47, 1186.85, 8.87693, 0.647954, 60, 5, 0, 1782, 0, 0, 1); -- Dustwraith placeholder
DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 2, @GUID + 3);
INSERT INTO `pool_creature` VALUES
(@GUID + 2, @POOL + 1, 10, 'Dustwraith (Zul\'Farrak)'),
(@GUID + 3, @POOL + 1, 0, 'Dustwraith placeholder (Zul\'Farrak)');
DELETE FROM `pool_template` WHERE `entry` = @POOL + 1;
INSERT INTO `pool_template` VALUES
(@POOL + 1, 1, 'Dustwraith (Zul\'Farrak)');
-- ----------------------------
-- Zerillis (10082)
-- ----------------------------
DELETE FROM `creature` WHERE `guid` IN (@GUID + 4);
INSERT INTO `creature` VALUES (@GUID + 4, 10082, 209, 0, 0, 1628.94, 952.042, 8.87684, 5.43152, 7200, 0, 0, 5544, 0, 0, 2); -- Zerillis
UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` = 10082;
DELETE FROM `creature_movement_template` WHERE `entry` = 10082;
INSERT INTO `creature_movement_template` VALUES
(10082, 1, 1648.93, 929.182, 9.0735, 400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10082, 2, 1676.93, 909.081, 8.8778, 400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10082, 3, 1679.64, 896.14, 8.8778, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10082, 4, 1662.26, 892.587, 8.87689, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10082, 5, 1653.05, 908.666, 8.87689, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10082, 6, 1649.56, 928.862, 8.97394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10082, 7, 1628.18, 951.86, 8.87694, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `pool_creature` WHERE `guid` IN (@GUID + 4, 44170);
INSERT INTO `pool_creature` VALUES
(@GUID + 4, @POOL + 2, 30, 'Zerillis (Zul\'Farrak)'),
(44170, @POOL + 2, 0, 'Zerillis placeholder (Zul\'Farrak)');
DELETE FROM `pool_template` WHERE `entry` = @POOL + 2;
INSERT INTO `pool_template` VALUES
(@POOL + 2, 1, 'Zerillis (Zul\'Farrak)');

SET @GUID := 160600;

DELETE FROM `creature` WHERE `guid` IN (54571, 54645);

-- Spawned missing NPCs in Maraudon : 12224 (Cavern Shambler)
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID + 7;
INSERT INTO `creature` VALUES
(@GUID, 12237, 349, 0, 0, 632.101, -92.409, -57.4999, 3.49563, 7200, 0, 0, 5757, 0, 0, 2),
(@GUID + 1, 12224, 349, 0, 0, 748.725, -81.8362, -57.4696, 0.620471, 7200, 0, 0, 4434, 2301, 0, 2),
(@GUID + 2, 12224, 349, 0, 0, 632.101, -92.409, -57.4999, 3.49563, 7200, 0, 0, 4434, 2301, 0, 2),
(@GUID + 3, 12224, 349, 0, 0, 818.573, -215.097, -77.1489, 4.14281, 7200, 0, 0, 4434, 2301, 0, 2),
(@GUID + 4, 12224, 349, 0, 0, 813.453, -370.449, -59.2094, 6.02488, 7200, 5, 0, 4434, 2301, 0, 1),
(@GUID + 5, 12224, 349, 0, 0, 719.899, -83.8715, -57.2155, 3.48941, 7200, 5, 0, 4434, 2301, 0, 1);

-- Added movement to some of the spawns
DELETE FROM `creature_movement` WHERE `id` IN (@GUID + 1, @GUID + 2, @GUID + 3);
INSERT INTO `creature_movement` VALUES
-- NPC 1
(@GUID + 1, 1, 747.806, -79.9688, -57.4744, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.30872, 0, 0),
(@GUID + 1, 2, 750.866, -86.8807, -57.4595, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.95922, 0, 0),
(@GUID + 1, 3, 741.016, -94.8653, -57.4978, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.6319, 0, 0),
(@GUID + 1, 4, 745.803, -84.0748, -57.4833, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.16459, 0, 0),
(@GUID + 1, 5, 738.607, -70.5452, -57.4977, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.23156, 0, 0),
(@GUID + 1, 6, 751.253, -70.6902, -57.3912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.39257, 0, 0),
(@GUID + 1, 7, 744.367, -78.7708, -57.4887, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.06801, 0, 0),
(@GUID + 1, 8, 756.588, -80.4979, -57.3727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.98809, 0, 0),
(@GUID + 1, 9, 736.461, -89.3428, -57.4996, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.35192, 0, 0),
(@GUID + 1, 10, 734.7, -80.3283, -57.4996, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.198547, 0, 0),
(@GUID + 1, 11, 744.209, -79.5844, -57.4915, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.045395, 0, 0),
(@GUID + 1, 12, 734.044, -71.701, -57.4977, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.40828, 0, 0),
-- NPC 2
(@GUID + 2, 1, 632.101, -92.409, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.240159, 0, 0),
(@GUID + 2, 2, 642.895, -89.225, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.306918, 0, 0),
(@GUID + 2, 3, 654.193, -88.5337, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.19348, 0, 0),
(@GUID + 2, 4, 666.728, -91.7718, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.01284, 0, 0),
(@GUID + 2, 5, 675.549, -93.9197, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.13457, 0, 0),
(@GUID + 2, 6, 690.764, -89.7546, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.61715, 0, 0),
(@GUID + 2, 7, 702.83, -84.753, -57.4631, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.173401, 0, 0),
(@GUID + 2, 8, 715.159, -83.791, -57.1193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.114496, 0, 0),
(@GUID + 2, 9, 708.503, -83.9885, -57.2554, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.35426, 0, 0),
(@GUID + 2, 10, 699.353, -86.647, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.55454, 0, 0),
(@GUID + 2, 11, 681.834, -93.4817, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.35034, 0, 0),
(@GUID + 2, 12, 674.938, -93.0037, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.78878, 0, 0),
(@GUID + 2, 13, 665.508, -90.6338, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.91051, 0, 0),
(@GUID + 2, 14, 652.935, -87.6942, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.10686, 0, 0),
(@GUID + 2, 15, 634.167, -92.0013, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.60559, 0, 0),
-- NPC 3
(@GUID + 3, 1, 818.873, -216.343, -77.1489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.28534, 0, 0),
(@GUID + 3, 2, 813.487, -210.328, -77.1489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.30105, 0, 0),
(@GUID + 3, 3, 806.875, -204.634, -77.1489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.43064, 0, 0),
(@GUID + 3, 4, 804.811, -193.5, -77.1489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.55099, 0, 0),
(@GUID + 3, 5, 806.356, -184.124, -77.1489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.35857, 0, 0),
(@GUID + 3, 6, 813.319, -173.6, -77.2995, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.541757, 0, 0),
(@GUID + 3, 7, 808.847, -175.006, -77.3074, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.0146, 0, 0),
(@GUID + 3, 8, 805.501, -182.277, -77.1489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.41377, 0, 0),
(@GUID + 3, 9, 804.538, -193.051, -77.1489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.92428, 0, 0),
(@GUID + 3, 10, 807.906, -203.501, -77.1489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.34446, 0, 0);

-- Fixed rank (is rare elite) and movement of  NPC 12237 (Meshlok the Harvester)
UPDATE `creature_template` SET `MovementType` = 2 WHERE `Entry` = 12237;


DELETE FROM `creature_movement_template` WHERE `entry` = 12237;
INSERT INTO `creature_movement_template` VALUES
(12237, 1, 632.101, -92.409, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.240159, 0, 0),
(12237, 2, 642.895, -89.225, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.306918, 0, 0),
(12237, 3, 654.193, -88.5337, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.19348, 0, 0),
(12237, 4, 666.728, -91.7718, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.01284, 0, 0),
(12237, 5, 675.549, -93.9197, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.13457, 0, 0),
(12237, 6, 690.764, -89.7546, -57.4999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.61715, 0, 0),
(12237, 7, 702.83, -84.753, -57.4631, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.173401, 0, 0),
(12237, 8, 715.159, -83.791, -57.1193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.114496, 0, 0),
(12237, 9, 708.503, -83.9885, -57.2554, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.35426, 0, 0),
(12237, 10, 699.353, -86.647, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.55454, 0, 0),
(12237, 11, 681.834, -93.4817, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.35034, 0, 0),
(12237, 12, 674.938, -93.0037, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.78878, 0, 0),
(12237, 13, 665.508, -90.6338, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.91051, 0, 0),
(12237, 14, 652.935, -87.6942, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.10686, 0, 0),
(12237, 15, 634.167, -92.0013, -57.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.60559, 0, 0);

SET @ENTRY := 1211;

-- Placed NPC 12237 (Meshlok the Harvester) into a pool with its placeholder
DELETE FROM `pool_creature` WHERE `guid` IN (@GUID, @GUID +3, 54652);
INSERT INTO `pool_creature` VALUES
(@GUID, @ENTRY, 30, 'Meshlok the Harvester (Maraudon)'),
(@GUID + 3, @ENTRY, 0, 'Meshlok the Harvester placeholder (Maraudon)'),
(54652, @ENTRY, 0, 'Meshlok the Harvester placeholder (Maraudon)');

DELETE FROM `pool_template` WHERE `entry` = @ENTRY;
INSERT INTO `pool_template` VALUES
(@ENTRY, 1, 'Meshlok the Harvester (Maraudon)');

-- Added quest script for quest 7046 (Scepter of Celebras) in Maraudon
-- Now NPC 13716 will start an event along with the player leading
-- to the completion of the quest, giving access to the Scepter of Celebras
-- which is required to grant easy access to the last wing of the instance

SET @GUID := 532823;

UPDATE quest_template SET `StartScript` = 7046 WHERE `entry` = 7046;

DELETE FROM `creature_movement_template` WHERE `entry` = 13716;
INSERT INTO `creature_movement_template` VALUES
(13716, 1, 654.905, 87.382, -86.8597, 5000, 1371601, 0, 0, 0, 0, 0, 0, 0, 5.06689, 0, 0),
(13716, 2, 657.207, 80.8004, -86.8318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.14543, 0, 0),
(13716, 3, 656.58, 73.1467, -86.8285, 6000, 1371602, 0, 0, 0, 0, 0, 0, 0, 2.94396, 0, 0),
(13716, 4, 652.437, 73.9764, -85.3354, 2000, 1371603, 0, 0, 0, 0, 0, 0, 0, 6.03528, 0, 0),
(13716, 5, 656.595, 73.5683, -86.8284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.10283, 0, 0),
(13716, 6, 655.724, 67.3549, -86.828, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.45585, 0, 0),
(13716, 7, 650.08, 65.0115, -86.7745, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 1.21372, 0, 0),
(13716, 8, 655.445, 67.6601, -86.8283, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.17524, 0, 0),
(13716, 9, 657.399, 78.0873, -86.8283, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.10044, 0, 0),
(13716, 10, 652.611, 86.3702, -86.8453, 0, 1371604, 0, 0, 0, 0, 0, 0, 0, 5.75411, 0, 0);

DELETE FROM `gameobject` WHERE `guid` IN (@GUID + 1, @GUID + 2);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID + 1, 178964, 349, 650.99, 74.458, -86.8651, 1.45735, 0, 0, 0.665882, 0.746057, -3600, 100, 1),
(@GUID + 2, 178965, 349, 652.263, 74.0125, -85.3354, 6.10288, 0, 0, 0.0900299, -0.995939, 3600, 100, 1);

UPDATE `gameobject_template` SET `flags` = 64 WHERE `entry` = 178965;
UPDATE `creature_template` SET `SpeedRun` = 1.8 WHERE `Entry` = 13716;

SET @ENTRY := 2000005646;

DELETE FROM `dbscripts_on_quest_start` WHERE `id` = 7046;
INSERT INTO `dbscripts_on_quest_start` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES
(7046, 0, 0, 0, 0, 0, 0, 0, @ENTRY, 0, 0, 0, 0, 0, 0, 0, 'Celebras Scepter Event'),
(7046, 1, 29, 3, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Remove flags'),
(7046, 2, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'set run'),
(7046, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 654.905, 87.382, -86.8597, 5.06689, 'move'),
(7046, 8, 20, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'movement changed to 2:waypoint'),
(7046, 10, 0, 0, 0, 0, 0, 0, @ENTRY + 1, 0, 0, 0, 0, 0, 0, 0, 'Celebras Scepter Event'),
(7046, 13, 0, 0, 0, 0, 0, 0, @ENTRY + 2, 0, 0, 0, 0, 0, 0, 0, 'Celebras Scepter Event');


DELETE FROM `dbscripts_on_creature_movement` WHERE `id` IN (1371601);
INSERT INTO `dbscripts_on_creature_movement` VALUES
(1371601, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'set walk'),
(1371601, 1, 20, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'movement changed to 2:waypoint'),

(1371602, 3, 0, 0, 0, 0, 0, 0, @ENTRY + 3, 0, 0, 0, 0, 0, 0, 0, 'Celebras Scepter Event'),
-- (1371602, 4, 9, @GUID + 2, 3600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'summon book'),
(1371602, 5, 15, 21916, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast Celebras Waiting'),
(1371602, 6, 0, 2, 0, 0, 0, 0, @ENTRY + 4, 0, 0, 0, 0, 0, 0, 0, 'Celebras Scepter Event'),
(1371602, 7, 0, 0, 0, 0, 0, 0, @ENTRY + 5, 0, 0, 0, 0, 0, 0, 0, 'Celebras Scepter Event'),

(1371603, 0, 0, 0, 0, 0, 0, 0, @ENTRY + 6, 0, 0, 0, 0, 0, 0, 0, 'Celebras Scepter Event'),
(1371603, 4, 0, 0, 0, 0, 0, 0, @ENTRY + 7, 0, 0, 0, 0, 0, 0, 0, 'Celebras Scepter Event'),
(1371603, 5, 15, 21950, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'cast Recite Words of Celebras'),

(1371604, 0, 29, 3, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Add flags'),
(1371604, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stop WP movement');

DELETE FROM `dbscripts_on_go_template_use` WHERE `id` = 178965;
INSERT INTO `dbscripts_on_go_template_use` VALUES
(178965, 0, 9, @GUID + 1, 3600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'summon Celebras Blue Aura'),
(178965, 1, 15, 21914, 0, 13716, 20, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'cast Celebras Quit Escort'),
(178965, 15, 7, 7046, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Give quest completion');

DELETE FROM `spell_script_target` WHERE `entry` = 21950;
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`, `inverseEffectMask`) VALUES
(21950, 0, 178560, 0);

DELETE FROM `db_script_string` WHERE `entry` BETWEEN @ENTRY AND @ENTRY + 7;
INSERT INTO `db_script_string` VALUES
(@ENTRY, 'You wish to learn of the stone? Follow me.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@ENTRY + 1, 'For so long I have drifted in my cursed form. You have freed me... Your hard work shall be repaid.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@ENTRY + 2, 'Please do as I instruct you, $N.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@ENTRY + 3, 'Read this tome I have placed before you, and speak the words aloud.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@ENTRY + 4, '%s begins to channel his energy, focusing on the stone.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 0, 0, NULL),
(@ENTRY + 5, 'Together, the two parts shall become one, once again.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@ENTRY + 6, 'Shal myrinan ishnu daldorah...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(@ENTRY + 7, 'My scepter will once again become whole!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL);

-- Fixed speed of NPC 12222 (Creeping Sludge) in Maraudon
-- because this NPC should be very slow in order to allow kitting
-- Source: http://www.wowwiki.com/Maraudon#Orange_side
-- http://www.wowhead.com/npc=12222
UPDATE `creature_template` SET `SpeedWalk` = 0.3, `SpeedRun` = 0.4 WHERE `Entry` = 12222;

-- Added patrol of NPC 13599 (Stolid Snapjaw) in Maraudon
DELETE FROM `creature_linking` WHERE `guid` IN (55115, 55116, 55117);
INSERT INTO `creature_linking` VALUES
(55115, 55118, 512),
(55116, 55118, 512),
(55117, 55118, 512);

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 55118;

DELETE FROM `creature_movement` WHERE `id` = 55118;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`)
VALUES
(55118, 1, 560.44, 74.1416, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.94883, 0, 0),
(55118, 2, 556.001, 97.5598, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.35115, 0, 0),
(55118, 3, 562.821, 116.938, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.716542, 0, 0),
(55118, 4, 558.737, 80.2023, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.70244, 0, 0),
(55118, 5, 567.894, 47.7771, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.88465, 0, 0),
(55118, 6, 573.623, 24.1758, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.21452, 0, 0),
(55118, 7, 583.107, 6.90322, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.56323, 0, 0),
(55118, 8, 597.509, 5.07898, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.18385, 0, 0),
(55118, 9, 600.013, 21.6183, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.22686, 0, 0),
(55118, 10, 575.202, 46.2133, -96.3128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.10748, 0, 0);

-- Quest 7046 (The Scepter of Celebras) needs quest 7044 (Legends of Maraudon) as prerequist
-- Reference: http://www.wowhead.com/quest=7046/the-scepter-of-celebras#comments
UPDATE `quest_template` SET `PrevQuestId`= 7044 WHERE `entry` = 7046;

-- Linked NPC 11784 (Theradrim Guardian) with its small adds 11783 (Theradrim Shardling) in Maraudon
-- The adds will engage along with their master and follow it
DELETE FROM `creature_linking_template` WHERE `entry` = 11783;
INSERT `creature_linking_template` VALUES
(11783, 349, 11784, 1 + 2 + 512, 15);

-- Removed all spawns of NPC 11783 (Theradrim Shardling) in Maraudon
-- because they are summoned
DELETE FROM `creature` WHERE `id` = 11783;

-- Removed duplicate NPC 11784 (Theradrim Guardian)
DELETE FROM `creature` WHERE `guid` = 55466;

-- Theradrim Guardians now patrol in the last part of Maraudon
UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 11784;

DELETE FROM `creature_movement` WHERE `id` = 55465;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`)
VALUES
(55465, 1, 248.538, -93.024, -129.62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.48821, 0, 0),
(55465, 2, 219.021, -92.1171, -129.607, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.77761, 0, 0),
(55465, 3, 258.14, -97.1733, -129.619, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.76526, 0, 0),
(55465, 4, 246.967, -145.304, -130.844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.31759, 0, 0),
(55465, 5, 213.934, -199.873, -131.159, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.56106, 0, 0),
(55465, 6, 248.627, -140.739, -131.005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.24747, 0, 0),
(55465, 7, 259.8, -98.2245, -129.619, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.83554, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 55471;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`)
VALUES
(55471, 1, 200.354, -133.505, -101.058, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.888545, 0, 0),
(55471, 9, 199.686, -134.684, -101.541, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.06627, 0, 0),
(55471, 8, 226.955, -112.811, -89.7437, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.15442, 0, 0),
(55471, 7, 276.408, -121.048, -83.6496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.72323, 0, 0),
(55471, 6, 299.577, -148.794, -69.9433, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.75562, 0, 0),
(55471, 5, 298.76, -178.312, -59.8991, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.52729, 0, 0),
(55471, 4, 300.187, -149.075, -69.7502, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.81004, 0, 0),
(55471, 3, 278.173, -121.002, -83.4807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.93787, 0, 0),
(55471, 2, 230.841, -109.688, -88.8687, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.20996, 0, 0),
(55471, 10, 183.329, -185.544, -111.375, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.68595, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 88989;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`)
VALUES
(88989, 1, 109.037, -268.553, -108.677, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.01719, 0, 0),
(88989, 2, 151.884, -275.712, -108.677, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.864195, 0, 0),
(88989, 3, 143.666, -231.173, -108.852, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.20251, 0, 0),
(88989, 4, 156.17, -275.286, -108.676, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.58089, 0, 0),
(88989, 5, 138.876, -278.577, -108.676, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.8379, 0, 0),
(88989, 6, 79.5604, -259.988, -108.678, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.8379, 0, 0),
(88989, 7, 62.416, -207.188, -109.659, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.94569, 0, 0),
(88989, 8, 8.187, -127.348, -123.845, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.395, 0, 0),
(88989, 9, 28.705, -38.025, -128.761, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.282, 0, 0),
(88989, 10, 8.187, -127.348, -123.845, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.134, 0, 0),
(88989, 11, 62.416, -207.188, -109.659, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.94569, 0, 0),
(88989, 12, 79.0383, -255.555, -108.677, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.96536, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 56485;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`)
VALUES
(56485, 1, 150.49, -193.898, -171.747, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.68202, 0, 0),
(56485, 2, 152.233, -231.891, -170.382, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.4087, 0, 0),
(56485, 3, 125.841, -257.66, -168.113, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.52554, 0, 0),
(56485, 4, 155.987, -284.034, -168.989, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.89625, 0, 0),
(56485, 5, 148.455, -238.759, -169.543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.08961, 0, 0),
(56485, 6, 155.062, -199.53, -171.957, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.02876, 0, 0),
(56485, 7, 104.937, -185.658, -167.457, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.76329, 0, 0),
(56485, 8, 100.198, -176.082, -167.457, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.16972, 0, 0),
(56485, 9, 111.893, -160.596, -167.328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.89781, 0, 0),
(56485, 10, 121.304, -176.939, -167.457, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.01502, 0, 0),
(56485, 11, 128.284, -191.12, -168.26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.77529, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 56501;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`)
VALUES
(56501, 1, 177.079, -304.031, -172.328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.46308, 0, 0),
(56501, 2, 146.519, -316.403, -174.591, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.85009, 0, 0),
(56501, 3, 153.733, -376.576, -175.003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.94886, 0, 0),
(56501, 4, 211.381, -381.672, -160.691, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.21354, 0, 0),
(56501, 5, 156.615, -376.11, -175.002, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.73206, 0, 0),
(56501, 6, 148.461, -317.13, -174.589, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.314416, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 56515;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`)
VALUES
(56515, 1, 312.737, -343.241, -117.348, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.19013, 0, 0),
(56515, 11, 251.778, -396.72, -139.555, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.22297, 0, 0),
(56515, 10, 256.965, -328.427, -140.451, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.59383, 0, 0),
(56515, 9, 250.345, -396.668, -139.555, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.10022, 0, 0),
(56515, 8, 325.14, -394.223, -124.867, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.68437, 0, 0),
(56515, 7, 317.848, -331.827, -116.777, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.80689, 0, 0),
(56515, 6, 331.665, -290.395, -118.061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.19978, 0, 0),
(56515, 5, 345.634, -276.933, -117.941, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.20528, 0, 0),
(56515, 4, 337.697, -262.309, -118.049, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.10123, 0, 0),
(56515, 3, 320.637, -268.75, -117.912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.612865, 0, 0),
(56515, 2, 328.91, -288.013, -118.069, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.41947, 0, 0),
(56515, 12, 319.125, -403.751, -124.866, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.55692, 0, 0);


UPDATE `quest_template` SET `RequiredRaces`='255', `RewMoneyMaxLevel`='4160' WHERE `entry`='3321';


UPDATE `dbscripts_on_quest_end` SET `command`='5' WHERE `id`='943' AND `delay`='0';
UPDATE `dbscripts_on_quest_end` SET `command`='4' WHERE `id`='943' AND `delay`='66';


UPDATE `creature_template` SET `DamageSchool`='4' WHERE `Entry`='5461';

UPDATE `creature_template` SET `DamageSchool`='4' WHERE `Entry`='5462';
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (SELECT `entry` FROM `quest_template` WHERE `title` IN ('Ribbons of Sacrifice', 'Talismans of Merit'));

DELETE FROM `creature_questrelation` WHERE `quest` IN (SELECT `entry` FROM `quest_template` WHERE `title` IN ('Ribbons of Sacrifice', 'Talismans of Merit'));

UPDATE `quest_template` SET `PrevQuestId`='3451' WHERE `entry`='3483';

UPDATE `quest_template` SET `RewMoneyMaxLevel`='390' WHERE `entry`='8262';
UPDATE `quest_template` SET `RewMoneyMaxLevel`='390' WHERE `entry`='8265';
UPDATE `quest_template` SET `RewMoneyMaxLevel`='162' WHERE `entry`='8260';
UPDATE `quest_template` SET `RewMoneyMaxLevel`='162' WHERE `entry`='8263';
UPDATE `quest_template` SET `RewMoneyMaxLevel`='228' WHERE `entry`='8261';
UPDATE `quest_template` SET `RewMoneyMaxLevel`='228' WHERE `entry`='8264';

-- Kirtonos the Herald - fixed. thx @Tauriella for report and test
-- Kirtonos the Herald
UPDATE creature_template SET MovementType = 2 WHERE entry = 10506;
DELETE FROM creature_movement_template WHERE entry = 10506;
INSERT INTO creature_movement_template (entry, POINT, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(10506,1,309.156,93.3245,101.662,0,0,3.17265,0,0),
(10506,2,299.559,93.255,105.634,10000,1050601,3.17972,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 1050601;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(1050601,1,20,0,0,0,0,0,0,0,0,0,0,0,0,0,'movement chenged to 0:idle'),
(1050601,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0.1,''),
(1050601,3,22,233,0x01 | 0x10 | 0x20,0,0,0,0,0,0,0,0,0,0,0,'temp faction');

-- Fix movement for spawned creatures
UPDATE creature_template SET MovementType=0 WHERE entry IN (7349,7351,7355);

-- Linking for Ambassador Flamelash
DELETE FROM creature_linking_template WHERE entry=9178;
INSERT INTO creature_linking_template VALUES
(9178,230,9156,4112,0);


-- Remove duplicate wrong spawn in Maraudon of NPC 12224 (Cavern Shambler)
DELETE FROM `creature` WHERE `guid` = 160510;

UPDATE `creature_template` SET `Armor`='3216', `MeleeBaseAttackTime`='2000', `ResistanceHoly`='0', `ResistanceFire`='0', `ResistanceNature`='0', `ResistanceFrost`='0', `ResistanceShadow`='0', `ResistanceArcane`='0', `AIName`='EventAI' WHERE `Entry`='8911';


DELETE FROM `creature_movement` WHERE `id`='30639' AND`point`='9';
DELETE FROM `creature_movement` WHERE `id`='30639' AND`point`='8';

UPDATE `creature_movement` SET `point`='8' WHERE `id`='30639' AND`point`='10';
UPDATE `creature_movement` SET `point`='9' WHERE `id`='30639' AND`point`='11';
UPDATE `creature_movement` SET `point`='10' WHERE `id`='30639' AND`point`='12';
UPDATE `creature_movement` SET `point`='11' WHERE `id`='30639' AND`point`='13';
UPDATE `creature_movement` SET `point`='12' WHERE `id`='30639' AND`point`='14';
UPDATE `creature_movement` SET `point`='13' WHERE `id`='30639' AND`point`='15';
UPDATE `creature_movement` SET `point`='14' WHERE `id`='30639' AND`point`='16';
UPDATE `creature_movement` SET `point`='15' WHERE `id`='30639' AND`point`='17';


UPDATE `creature_template` SET `FactionAlliance`='7', `FactionHorde`='7', `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='9178';

-- Torch will now open door in Solomance.
DELETE FROM dbscripts_on_go_template_use WHERE id = 176767;
INSERT INTO dbscripts_on_go_template_use (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(176767,1,11,45427,15,0,0,0,0,0,0,0,0,0,0,0,'');

-- Removed spawns of NPC 11258 from Scholomance : this NPC is summoned
DELETE FROM `creature` WHERE `id` = 11258 AND `map` = 289;

DELETE FROM `creature_ai_scripts` WHERE `creature_id`='8911';
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
('891101', '8911', '11', '0', '100', '0', '0', '0', '0', '0', '11', '3417', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', 'Fireguard Destroyer - Thrash'),
('891102', '8911', '0', '0', '100', '1', '8000', '12000', '8000', '12000', '11', '15243', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fireguard Destroyer - Fireball Volley');

DELETE FROM creature_addon WHERE guid IN (91405, 91406, 91407, 91421, 91422, 91427);
UPDATE creature SET curhealth = 4741 WHERE id = 12224;
UPDATE creature SET curhealth = 6181 WHERE id = 12237;
UPDATE creature SET curhealth = 1821 WHERE id = 7269;
UPDATE creature SET curhealth = 5932 WHERE id =  10082;


-- Fixed rewards of quest 8867 (Lunar Fireworks)
-- Author: @trulynullified
-- Thanks thetrueanimal for pointing. This closes #720 
DELETE FROM `item_loot_template` WHERE `entry` IN (21740, 21743);
INSERT INTO `item_loot_template` VALUES 
('21740', '21724', '0', '1', '1', '1', '0'),
('21740', '21725', '0', '1', '1', '1', '0'),
('21740', '21726', '0', '1', '1', '1', '0'),
('21743', '21733', '0', '1', '1', '1', '0'),
('21743', '21734', '0', '1', '1', '1', '0'),
('21743', '21735', '0', '1', '1', '1', '0');

-- Fixed NPC vendors items for vendors 10856 (Argent Quartermaster Hasana ), 10857 (Argent Quartermaster Lightspark ) & 11536 (Quartermaster Miranda Breechlock )
-- items are now available only once the related quests are completed
-- Also removed repeat flag for quest 5517, 5521, 5524 (Chromatic Mantle of the Dawn)
-- Prevented players to complete all Mantle of the Dawn quests as they should be able to do only one by tier (two tiers)
-- Author: @trulynullified
-- thanks the thetrueanimal for pointing. This closes #742

SET @ENTRY := 151;

DELETE FROM `conditions` WHERE `condition_entry` BETWEEN @ENTRY + 1 AND @ENTRY + 10;
INSERT INTO `conditions` VALUES 
(@ENTRY + 1, '8', '5513', '0'),
(@ENTRY + 2, '8', '5507', '0'),
(@ENTRY + 3, '8', '5504', '0'),
(@ENTRY + 4, '-2', @ENTRY + 1, @ENTRY + 2),
(@ENTRY + 5, '-2', @ENTRY + 3, @ENTRY + 4),
(@ENTRY + 6, '8', '5524', '0'),
(@ENTRY + 7, '8', '5521', '0'),
(@ENTRY + 8, '8', '5517', '0'),
(@ENTRY + 9, '-2', @ENTRY + 6, @ENTRY + 7),
(@ENTRY + 10, '-2', @ENTRY + 8, @ENTRY + 9);
UPDATE `npc_vendor` SET `condition_id` = @ENTRY + 5 WHERE `item` IN (18169,18170,18171,18172,18173);
UPDATE `npc_vendor` SET `condition_id` = @ENTRY + 10 WHERE `item` = '18182';
UPDATE `quest_template` SET `ExclusiveGroup` = '5504' WHERE `entry` IN (5504,5507,5513);
UPDATE `quest_template` SET `ExclusiveGroup` = '5517', `SpecialFlags` = '0' WHERE `entry` IN (5517,5521,5524);

-- Fixed quest 5581 (Portal of the Legion) in Desolace
-- Author: @trulynullified
-- Thanks thetrueanimal for pointing. This closes #712 
DELETE FROM `dbscripts_on_go_template_use` WHERE `id` IN (177243,177365,177366,177367,177368,177369,177397,177398,177399,177400);
INSERT INTO `dbscripts_on_go_template_use` VALUES 
('177243', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian'),
('177365', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian'),
('177366', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian'),
('177367', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian'),
('177368', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian'),
('177369', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian'),
('177397', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian'),
('177398', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian'),
('177399', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian'),
('177400', '0', '10', '11937', '60000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Demon Portal - Summon Demon Portal Guardian');

UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='-10' WHERE `entry`='9677' AND`item`='10715';
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='-10' WHERE `entry`='9677' AND`item`='10717';
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='-10' WHERE `entry`='9677' AND`item`='10718';
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`='-10' WHERE `entry`='9677' AND`item`='10722';

-- This only handles Eff0 of the spell. Currently the spell focus GO isn't despawned due to core limitations.
-- quest 6041
-- script targets (eff0 for creature, eff2 for go)
DELETE FROM spell_script_target WHERE entry=19250;
INSERT INTO spell_script_target VALUES
(19250,0,177668,1),
(19250,1,12247,4);
-- quest kill credit script (only starts for eff0)
DELETE FROM dbscripts_on_spell WHERE id IN (19250);
INSERT INTO dbscripts_on_spell (id,delay,command,datalong,data_flags,comments) VALUES
(19250,0,8,0,0,'kill credit'),
(19250,0,18,0,0,'despawn target');

-- Scripted q.3382 (A Crew Under Fire) in Azshara
-- Thx to @xfurry for tests

-- q.3382 'A Crew Under Fire'
DELETE FROM dbscripts_on_quest_start WHERE id = 3382;
INSERT INTO dbscripts_on_quest_start (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(3382,0,21,1,0,0,0,0,0,0,0,0,0,0,0,0,'Calia active'),
(3382,1,0,0,0,0,0,0,2000000466,0,0,0,0,0,0,0,''),
(3382,1,22,495,0x01,0,0,0,0,0,0,0,0,0,0,0,'temp faction'),
(3382,2,15,6245,0,8386,35900,7 | 0x10,0,0,0,0,0,0,0,0,''),
(3382,2,15,6245,0,8386,35905,7 | 0x10,0,0,0,0,0,0,0,0,''),
(3382,2,15,6245,0,8386,35906,7 | 0x10,0,0,0,0,0,0,0,0,''),
(3382,2,15,6245,0,8386,35904,7 | 0x10,0,0,0,0,0,0,0,0,''),
(3382,2,15,6245,0,8386,35903,7 | 0x10,0,0,0,0,0,0,0,0,''),
(3382,3,22,495,0x01,8386,35900,7 | 0x10,0,0,0,0,0,0,0,0,'temp faction'),
(3382,3,22,495,0x01,8386,35905,7 | 0x10,0,0,0,0,0,0,0,0,'temp faction'),
(3382,3,22,495,0x01,8386,35906,7 | 0x10,0,0,0,0,0,0,0,0,'temp faction'),
(3382,3,22,495,0x01,8386,35904,7 | 0x10,0,0,0,0,0,0,0,0,'temp faction'),
(3382,3,22,495,0x01,8386,35903,7 | 0x10,0,0,0,0,0,0,0,0,'temp faction'),
(3382,4,22,495,0x01,8381,35890,7 | 0x10,0,0,0,0,0,0,0,0,'temp faction'),
(3382,4,22,495,0x01,8378,35884,7 | 0x10,0,0,0,0,0,0,0,0,'temp faction'),
(3382,4,22,495,0x01,8382,35891,7 | 0x10,0,0,0,0,0,0,0,0,'temp faction'),
(3382,5,22,495,0x01,8386,35899,7 | 0x10,0,0,0,0,0,0,0,0,'temp faction'),
(3382,5,10,12205,300000,0,0,0,0,0,0,0,2370.83,-5893.06,10.6607,5.45564,'1st wave'),
(3382,6,10,12204,300000,0,0,0,0,0,0,0,2367.58,-5889.81,11.3931,5.36209,'1st wave'),
(3382,6,10,12204,300000,0,0,0,0,0,0,0,2369.53,-5888.84,11.2888,5.23643,'1st wave'),
(3382,6,10,12204,300000,0,0,0,0,0,0,0,2366.15,-5891.65,11.72,5.46812,'1st wave'),
(3382,59,34,317,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if player is dead or out of range'),
(3382,59,34,318,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if npc is dead'),
(3382,60,10,12204,300000,0,0,0,0,0,0,0,2370.83,-5893.06,10.6607,5.45564,'2nd wave'),
(3382,61,10,12204,300000,0,0,0,0,0,0,0,2367.58,-5889.81,11.3931,5.36209,'2nd wave'),
(3382,61,10,12205,300000,0,0,0,0,0,0,0,2369.53,-5888.84,11.2888,5.23643,'2nd wave'),
(3382,62,10,12204,300000,0,0,0,0,0,0,0,2366.15,-5891.65,11.72,5.46812,'2nd wave'),
(3382,114,34,317,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if player is dead or out of range'),
(3382,114,34,318,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if npc is dead'),
(3382,115,10,12204,300000,0,0,0,0,0,0,0,2370.83,-5893.06,10.6607,5.45564,'3rd wave'),
(3382,115,10,12205,300000,0,0,0,0,0,0,0,2367.58,-5889.81,11.3931,5.36209,'3rd wave'),
(3382,116,10,12204,300000,0,0,0,0,0,0,0,2369.53,-5888.84,11.2888,5.23643,'3rd wave'),
(3382,116,10,12204,300000,0,0,0,0,0,0,0,2366.15,-5891.65,11.72,5.46812,'3rd wave'),
(3382,169,34,317,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if player is dead or out of range'),
(3382,169,34,318,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if npc is dead'),
(3382,170,10,12204,300000,0,0,0,0,0,0,0,2370.83,-5893.06,10.6607,5.45564,'4th wave'),
(3382,170,10,12204,300000,0,0,0,0,0,0,0,2367.58,-5889.81,11.3931,5.36209,'4th wave'),
(3382,170,10,12204,300000,0,0,0,0,0,0,0,2369.53,-5888.84,11.2888,5.23643,'4th wave'),
(3382,170,10,12205,300000,0,0,0,0,0,0,0,2366.15,-5891.65,11.72,5.46812,'4th wave'),
(3382,224,34,317,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if player is dead or out of range'),
(3382,224,34,318,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if npc is dead'),
(3382,225,10,12205,300000,0,0,0,0,0,0,0,2370.83,-5893.06,10.6607,5.45564,'5th wave'),
(3382,226,10,12204,300000,0,0,0,0,0,0,0,2367.58,-5889.81,11.3931,5.36209,'5th wave'),
(3382,226,10,12204,300000,0,0,0,0,0,0,0,2369.53,-5888.84,11.2888,5.23643,'5th wave'),
(3382,227,10,12205,300000,0,0,0,0,0,0,0,2366.15,-5891.65,11.72,5.46812,'5th wave'),
(3382,279,34,317,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if player is dead or out of range'),
(3382,279,34,318,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if npc is dead'),
(3382,280,10,12205,300000,0,0,0,0,0,0,0,2370.83,-5893.06,10.6607,5.45564,'final wave'),
(3382,281,10,12204,300000,0,0,0,0,0,0,0,2367.58,-5889.81,11.3931,5.36209,'final wave'),
(3382,281,10,12204,300000,0,0,0,0,0,0,0,2369.53,-5888.84,11.2888,5.23643,'final wave'),
(3382,282,10,12205,300000,0,0,0,0,0,0,0,2366.15,-5891.65,11.72,5.46812,'final wave'),
(3382,334,34,317,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if player is dead or out of range'),
(3382,334,34,318,3382,0,0,0,0,0,0,0,0,0,0,0,'Stop script if npc is dead'),
(3382,335,7,3382,0,0,0,0,0,0,0,0,0,0,0,0,'quest credit'),
(3382,337,21,0,0,0,0,0,0,0,0,0,0,0,0,0,'Calia unactive');
UPDATE quest_template SET SpecialFlags = 3, StartScript = 3382 WHERE entry = 3382;
DELETE FROM db_script_string WHERE entry = 2000000466;
INSERT INTO db_script_string (entry,content_default,sound,TYPE,LANGUAGE,emote,COMMENT) VALUES
(2000000466,'Stand Prepared! The naga won\'t wait long to press their advantage once they know we\'re alive.',0,0,0,5,'');
-- Spitelash Witch
UPDATE creature_template SET MovementType = 2 WHERE entry = 12205;
DELETE FROM creature_movement_template WHERE entry = 12205;
INSERT INTO creature_movement_template (entry,POINT,position_x,position_y,position_z,waittime,script_id,orientation,model1,model2) VALUES
(12205,1,2370.83,-5893.06,10.6607,1000,1220501,5.45564,0,0),
(12205,2,2377.23,-5904.07,11.067,0,0,4.84696,0,0),
(12205,3,2378.04,-5915.15,10.7378,0,0,4.5383,0,0),
(12205,4,2374.96,-5932,9.66682,0,0,4.76293,0,0),
(12205,5,2374.06,-5963.62,9.89577,300000,0,4.63726,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 1220501;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(1220501,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON');
-- Spitelash Raider
UPDATE creature_template SET MovementType = 2 WHERE entry = 12204;
DELETE FROM creature_movement_template WHERE entry = 12204;
INSERT INTO creature_movement_template (entry,POINT,position_x,position_y,position_z,waittime,script_id,orientation,model1,model2) VALUES
(12204,1,2370.83,-5893.06,10.6607,1000,1220401,5.45564,0,0),
(12204,2,2379.97,-5904.9,10.7712,0,0,4.45113,0,0),
(12204,3,2376.15,-5924.8,9.84824,0,0,4.53485,0,0),
(12204,4,2373.41,-5962.79,9.70075,300000,0,4.66837,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 1220401;
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, X, Y, z, o, comments) VALUES
(1220401,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON');
-- Captain Vanessa Beltis
DELETE FROM gossip_menu WHERE entry = 1641;
INSERT INTO gossip_menu (entry, text_id, script_id, condition_id) VALUES
(1641, 2293, 0, 0),
(1641, 3073, 0, 966);
DELETE FROM conditions WHERE condition_entry = 966;
INSERT INTO conditions (condition_entry, TYPE, value1, value2) VALUES
(966, 9, 3382, 0);
-- Horizon Scout Crewman
UPDATE creature SET orientation = 2.43043 WHERE guid = 35899;




-- ######################
-- DM: Tribute run script
-- ######################

-- texts
SET @DB_STRING_ENTRY:=2000000166;
DELETE FROM db_script_string WHERE entry BETWEEN @DB_STRING_ENTRY AND @DB_STRING_ENTRY+1;
INSERT INTO db_script_string (entry,content_default,sound,TYPE,LANGUAGE,emote,COMMENT) VALUES
(@DB_STRING_ENTRY+0,'OH NOES! Da king is dead! Uh... hail to da new king! Yeah!',0,1,0,0,'mizzle the crafty - new king 1'),
(@DB_STRING_ENTRY+1,'Yar, he\'s dead all right. That makes you da new king... well, all of you! Gordok is yours now, boss! You should talk to me so you can learn everything there is about being da king! I was... is his assistant! Yeah, that\'s why I\'m called da crafty one!',0,0,0,0,'mizzle the crafty - new king 2');

-- movement
DELETE FROM creature_movement_template WHERE entry=14353;
INSERT INTO creature_movement_template (entry,POINT,position_x,position_y,position_z,waittime,script_id,orientation) VALUES
(14353, 1, 683.2966, 484.3845, 29.54451, 0, 1435301, 0.017),
(14353, 2, 728.9432, 483.2973, 28.18182, 0, 0, 0),
(14353, 3, 757.3987, 482.5078, 28.17787, 0, 0, 0),
(14353, 4, 768.0496, 482.5014, 29.54162, 0, 0, 0),
(14353, 5, 778.0708, 482.7376, 34.93199, 0, 0, 0),
(14353, 6, 784.5805, 481.7013, 37.19804, 0, 0, 0),
(14353, 7, 816.5302, 482.3017, 37.31819, 1000, 1435307, 3.159),
(14353, 8, 816.5302, 482.3017, 37.31819, 10800000, 1435308, 3.159);

-- movement script
DELETE FROM dbscripts_on_creature_movement WHERE id IN (1435301,1435307,1435308);
INSERT INTO dbscripts_on_creature_movement (id,delay,command,datalong,datalong2,buddy_entry,search_radius,data_flags,dataint,comments) VALUES
(1435301,1,0,0,0,0,0,0,@DB_STRING_ENTRY+0,'Mizzle - say new king 1'),
(1435307,0,32,1,0,0,0,0,0,'Mizzle - pause WP Movement'),
(1435307,0,0,0,0,0,0,0,@DB_STRING_ENTRY+1,'Mizzle - say new king 2'),
(1435308,0,32,1,0,0,0,0,0,'Mizzle - pause WP Movement'),
(1435308,0,9,35834,3600,0,0,0,0,'Mizzle - spawn tribute chest'),
(1435308,10,29,1,0x02,0,0,0,0,'Mizzle - npc_flag removed');

-- gossip conditions
SET @DB_CONDITION:=976;
DELETE FROM conditions WHERE condition_entry BETWEEN @DB_CONDITION+0 AND @DB_CONDITION+3;
INSERT INTO conditions VALUES
(@DB_CONDITION+0,1,22799,0), -- has King of Gortok aura
(@DB_CONDITION+1,-3,@DB_CONDITION+0,0), -- has not King of Gortok aura
(@DB_CONDITION+2,33,7,0), -- has WP == 7
(@DB_CONDITION+3,-1,@DB_CONDITION+0,@DB_CONDITION+2); -- has WP == 7 and has King of Gortok aura

-- gossip
UPDATE gossip_menu SET condition_id=@DB_CONDITION+1 WHERE entry=5708 AND text_id=6876;
UPDATE gossip_menu SET condition_id=@DB_CONDITION+3 WHERE entry=5708 AND text_id=6895;
UPDATE gossip_menu_option SET condition_id=@DB_CONDITION+1, action_script_id=570801 WHERE menu_id=5708 AND id=0;
UPDATE gossip_menu_option SET condition_id=@DB_CONDITION+3 WHERE menu_id=5708 AND id=1;
UPDATE gossip_menu_option SET action_script_id=574001 WHERE menu_id=5740;

-- gossip scripts
DELETE FROM dbscripts_on_gossip WHERE id IN (570801,574001);
INSERT INTO dbscripts_on_gossip (id,delay,command,datalong,datalong2,buddy_entry,search_radius,data_flags,dataint,comments) VALUES
(570801,0,15,22799,0,0,0,0,0,'Mizzle - cast King of the Gordok'),
(574001,0,32,0,0,0,0,0,0,'Mizzle - resume WP Movement');

-- Misc updates

-- link last 2 bosses
DELETE FROM creature_linking_template WHERE entry=14324;
INSERT INTO creature_linking_template VALUES
(14324,429,11501,3,0);

-- Delete Mizzle duplicate (summoned)
DELETE FROM creature WHERE guid=125640;

-- Broken Trap quest (partially complete - requires more research and investigation)

-- spell script target
DELETE FROM spell_script_target WHERE entry=5249;
INSERT INTO spell_script_target VALUES
(5249,1,14323,0);

-- ToDo: script spell 5249 to freeze npc 14323 and despawn the traps
-- Fixed trap GO spawn
SET @GUID := 573683;
DELETE FROM gameobject WHERE guid=@GUID;
INSERT INTO gameobject (guid,id,map,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(@GUID, 179512, 429, 558.652, 550.057, -25.4008, 0, 0, 0, -0.771625, 0.636078, -7200, 255, 1);

-- ToDo: fix GO data (faction and radius)
-- Broken trap script
UPDATE quest_template SET CompleteScript=1193 WHERE entry=1193;
DELETE FROM dbscripts_on_quest_end WHERE id IN (1193);
INSERT INTO dbscripts_on_quest_end (id,delay,command,datalong,datalong2,buddy_entry,search_radius,data_flags,dataint,comments) VALUES
(1193,0,9,@GUID,3600,0,0,0,0,'spawn Fixed trap');
-- ToDo: this part might require updates (such as despawn the Quest provider GO)

-- Fixed drop chance from bosses and dusty tomes in Dire Maul for class quest books
-- and Foror's Compendium of Dragon Slaying (epic quest starting item)
-- http://www.wowwiki.com/A_Dusty_Tome
-- http://www.wowwiki.com/Royal_Seal_of_Eldre%27Thalas

SET @DROPCHANCE := 2;

DELETE FROM `creature_loot_template` WHERE `item` BETWEEN 18356 AND 18364 OR `item` = 18401;
SET @ENTRY := 14354; -- Pusillin
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 13280; -- Hydrospawn
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 14327; -- Lethtendris
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 11490; -- Zevrim Thornhoof
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 11492; -- Alzzin the Wildshaper
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 11489; -- Tendris Warpwood
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 11488; -- Illyanna Ravenoak
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 11467; -- Tsu'zee
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 11487; -- Magister Kalendris
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 11496; -- Immol'thar
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 11486; -- Prince Tortheldrin
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 14326; -- Guard Mol'dar
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 14322; -- Stomper Kreeg
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 14321; -- Guard Fengus
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 14323; -- Guard Slip'kik
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 14325; -- Captain Kromcrush
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 14324; -- Cho'Rush the Observer
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);
SET @ENTRY := 11501; -- King Gordok
INSERT INTO `creature_loot_template` VALUES
(@ENTRY, 18356, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18357, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18358, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18359, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18360, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18361, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18362, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18363, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18364, @DROPCHANCE, 0, 1, 1, 0),
(@ENTRY, 18401, 0.5, 0, 1, 1, 0);

-- http://www.wowwiki.com/A_Dusty_Tome
DELETE FROM `gameobject_loot_template` WHERE `item` BETWEEN 18356 AND 18365 OR `item` = 18401 OR `entry` IN (16563, 16564);
INSERT INTO `gameobject_loot_template` VALUES
(16563, 18356, 0, 1, 1, 1, 0),
(16563, 18357, 0, 1, 1, 1, 0),
(16563, 18358, 0, 1, 1, 1, 0),
(16563, 18359, 0, 1, 1, 1, 0),
(16563, 18360, 0, 1, 1, 1, 0),
(16563, 18361, 0, 1, 1, 1, 0),
(16563, 18362, 0, 1, 1, 1, 0),
(16563, 18363, 0, 1, 1, 1, 0),
(16563, 18364, 0, 1, 1, 1, 0),
(16563, 18365, 79, 1, 1, 1, 0),
(16563, 18401, 0.5, 1, 1, 1, 0),
(16563, 5263, 100, 0, 1, 1, 0),
(16564, 18356, 0, 1, 1, 1, 0),
(16564, 18357, 0, 1, 1, 1, 0),
(16564, 18358, 0, 1, 1, 1, 0),
(16564, 18359, 0, 1, 1, 1, 0),
(16564, 18360, 0, 1, 1, 1, 0),
(16564, 18361, 0, 1, 1, 1, 0),
(16564, 18362, 0, 1, 1, 1, 0),
(16564, 18363, 0, 1, 1, 1, 0),
(16564, 18364, 0, 1, 1, 1, 0),
(16564, 18365, 79, 1, 1, 1, 0),
(16564, 18401, 0.5, 1, 1, 1, 0),
(16564, 5263, 100, 0, 1, 1, 0);

-- Fix for old bugs....
-- movement chenged to 0:idle (was wrongly set to random)
-- Jarven Thunderbrew
UPDATE dbscripts_on_creature_movement SET datalong = 0 WHERE id = 137302 AND delay = 2;
-- Grimand Elmore
UPDATE dbscripts_on_creature_movement SET datalong = 0 WHERE id = 141603 AND delay = 2;

UPDATE `npc_vendor` SET `incrtime`='1800' WHERE `entry`='2480' AND`item`='14634';
UPDATE `npc_vendor` SET `maxcount`='1' WHERE `entry`='2480' AND`item`='14634';

 UPDATE `npc_text` SET `text0_0` = 'Greetings, $glad:lass;. I\'m Grelin Whitebeard. I''m here to examine the threat posed by the growing numbers of trolls in Coldridge Valley. What have I found? It\'s a bit troubling...' WHERE `ID` = 15132;
 
 -- Major revamp of Winterveil Holiday.
-- Also added Winterveil gifts under the tree.

SET @EVENT := 21;
SET @POOL := 1700;

-- Inserting missing winter hats into creature_loot_table
DELETE FROM `creature_loot_template` WHERE item = 21524;
DELETE FROM `creature_loot_template` WHERE item = 21525;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (9237, 21524, 100, 0, 1, 1, 32);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (10997, 21524, 100, 0, 1, 1, 32);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (9019, 21524, 100, 0, 1, 1, 32);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (1853, 21525, 100, 0, 1, 1, 32);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (10899, 21525, 100, 0, 1, 1, 32);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (11486, 21525, 100, 0, 1, 1, 32);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=100 WHERE `entry`=1853 AND `item` = 21525;

-- Inserting model changes into christmas outfits
DELETE FROM `game_event_creature_data` WHERE `guid`=45840 AND `entry_id`=0;
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (45840, 0, 15737, 0, 0, 0, 2);

DELETE FROM `game_event_creature_data` WHERE `guid`=54433 AND `entry_id`=0;
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (54433, 0, 15733, 0, 0, 0, 2);

DELETE FROM `game_event_creature_data` WHERE `guid`=47613 AND `entry_id`=0;
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (47613, 0, 15735, 0, 0, 0, 2);

DELETE FROM `game_event_creature_data` WHERE `guid`=40458 AND `entry_id`=0;
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (40458, 0, 15760, 0, 0, 0, 2);

DELETE FROM `game_event_creature_data` WHERE `guid`=137881 AND `entry_id`=0;
INSERT INTO `game_event_creature_data` (`guid`, `entry_id`, `modelid`, `equipment_id`, `spell_start`, `spell_end`, `event`) VALUES (137881, 0, 15734, 0, 0, 0, 2);

-- Updating position of Goli Krumm
UPDATE `creature` SET `position_x`=-4882.709, `position_y`=952.68, `position_z`=501.464, `orientation`=3.17408 WHERE `guid`=86181;

-- Adding Fencing for Metzen in Searing Gorge
DELETE FROM `gameobject` WHERE `guid`=151751 AND `id`=180742;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151751, 180742, 0, -6606.33, -1860.82, 244.459, 6.27864, 0, 0, 0.00227228, -0.999997, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`=151752 AND `id`=180742;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151752, 180742, 0, -6606.36, -1857.85, 244.382, 6.2433, 0, 0, 0.0199423, -0.999801, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`=151753 AND `id`=180742;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151753, 180742, 0, -6609.29, -1854.76, 244.234, 1.58196, 0, 0, 0.711042, 0.703149, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`=151754 AND `id`=180742;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151754, 180742, 0, -6606.33, -1854.91, 244.308, 1.55211, 0, 0, 0.700471, 0.713681, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`=151755 AND `id`=180742;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151755, 180742, 0, -6612.22, -1854.84, 244.179, 3.15825, 0, 0, 0.999965, -0.00832624, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`=151756 AND `id`=180742;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151756, 180742, 0, -6612.16, -1857.78, 244.212, 3.15432, 0, 0, 0.99998, -0.00636482, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`=151757 AND `id`=180742;
INSERT INTO `gameobject` (`guid`, `id`, `map`,`position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151757, 180742, 0, -6612.09, -1860.72, 244.247, 4.69763, 0, 0, 0.712307, -0.701868, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`=151758 AND `id`=180742;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151758, 180742, 0, -6609.11, -1860.79, 244.347, 4.73297, 0, 0, 0.699791, -0.714347, 300, 0, 1);

DELETE FROM `game_event_gameobject` WHERE `event`=2 AND `guid` IN (151751,151752,151753,151754,151755,151756,151757,151758);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (151751, 2);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (151752, 2);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (151753, 2);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (151754, 2);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (151755, 2);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (151756, 2);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (151757, 2);
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (151758, 2);

-- Adding Metzen's stable in Tanaris
DELETE FROM `gameobject` WHERE `guid`= 151750 AND `id`=180719;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151750, 180719, 1, -8089.22, -5275.14, 1.23688, 1.75167, 0, 0, 0.768079, 0.640355, 300, 0, 1);

DELETE FROM `game_event_gameobject` WHERE `guid`= 151750 AND `event`=2;
INSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES (151750, 2);

-- Changing position of Holly Preserver in IF
UPDATE `gameobject` SET `position_x`=-4928.87, `position_y`=-990.331, `position_z`=501.448, `orientation`=2.51327 
WHERE `guid`=41673;

-- Correcting OfferRewardText in quests 7061 and 7063 (public though -> public thought)
UPDATE `quest_template` SET `OfferRewardText`='The legends and lore surrounding the Winter Veil are ones that have faded from the forefront of public thought over the years.  Yes, I know that the goblins are helping to revive the season for their own ends, the fact that our people reflect upon it at least in some form does good to keep such lore alive.$B$BYour desire to go beyond the material and learn about our past is an admirable trait, young $c.  I salute your wisdom.'
WHERE `entry`=7061;

UPDATE `quest_template` SET `OfferRewardText`='The legends and lore surrounding the Winter Veil are ones that have faded from the forefront of public thought over the years. While I recognize that the goblins are helping to revive the season for their own ends, the fact that the citizenry thinks about it at least in some form does good to keep such lore alive.$B$BYour desire to go beyond the material and learn about our past is an admirable trait, young $C. I salute your erudite nature.'
WHERE `entry`=7063;

-- Correcting Hero of the Day (alliance and horde)
UPDATE `quest_template` SET `RequiredRaces`= 77, `RequiredSkill`= 185, `RequiredSkillValue`= 300, `QuestFlags`= 0, `SpecialFlags`= 0, `PrevQuestId`= 8762, `OfferRewardText` = 'The machine lets off a little rumble and a small amount of steam as it starts working. It is not too long thereafter until it stops, heralded by another small jet of steam erupting from it. A door hatch opens, revealing a batch of preserved holly!', `RequestItemsText` = 'The "Holly Preserver" machine looks like some sort of still at first, but a careful examination of it reveals some goblin-esque changes to it. Still, your skill at cooking seems to allow you to understand how the machine works. $B$BThere is already fresh holly in the machine - you simply need to provide some deeprock salt and five gold coins to get the machine working.', `RewOrReqMoney` = -50000 WHERE `entry`= 8763;

UPDATE `quest_template` SET `RequiredRaces`= 178, `RequiredSkill`= 185, `RequiredSkillValue`= 300, `QuestFlags`= 0, `SpecialFlags`= 0, `PrevQuestId`= 8746, `OfferRewardText` = 'The machine lets off a little rumble and a small amount of steam as it starts working. It is not too long thereafter until it stops, heralded by another small jet of steam erupting from it. A door hatch opens, revealing a batch of preserved holly!', `RequestItemsText` = 'The "Holly Preserver" machine looks like some sort of still at first, but a careful examination of it reveals some goblin-esque changes to it. Still, your skill at cooking seems to allow you to understand how the machine works. $B$BThere is already fresh holly in the machine - you simply need to provide some deeprock salt and five gold coins to get the machine working.' WHERE `entry`= 8799;

UPDATE `quest_template` SET `RequiredRaces`= 77 WHERE `entry`= 8762;
UPDATE `quest_template` SET `RequiredRaces`= 178 WHERE `entry`= 8746;

-- Removing repeatability for quest 6962
UPDATE `quest_template` SET `SpecialFlags`= 0 WHERE `entry`= 6962;

-- Correcting typo (Greatfather ->Great-father)
UPDATE `npc_text` SET `text3_0`= 'Yeah, sure, go ahead and tell ol\' Great-father Winter what you\'d like for this Winter Veil.$B$BHo ho hurry up.' WHERE `ID`= 6250;

-- Adding thank you mail after Metzen quest completed
UPDATE `quest_template` SET `RewMailTemplateId`= 122, `RewMailDelaySecs`= 172800 WHERE `entry`= 8746;
UPDATE `quest_template` SET `RewMailTemplateId`= 161, `RewMailDelaySecs`= 172800 WHERE `entry`= 8762;

-- Adding thank you mail after Treats quest completed
UPDATE `quest_template` SET `RewMailTemplateId`= 118, `RewMailDelaySecs`= 86400 WHERE `entry`= 6962;
UPDATE `quest_template` SET `RewMailTemplateId`= 102, `RewMailDelaySecs`= 86400 WHERE `entry`= 7025;

-- Typo fix for quest 6962 (Greatfather ->Great-father)
UPDATE `quest_template` SET `Details`= 'Hey, can you do Great-father Winter a favor, um, little $g boy : girl;?$B$BNot to needlessly talk about myself in the third person, but Great-father Winter has been at this all day and he could use a treat himself.  Some gingerbread cookies and ice cold milk to wash them down with would really hit the spot.  Think you could be a friend to the Great-father and fetch some for me?', `Objectives`= 'Bring 5 Gingerbread Cookies and an Ice Cold Milk to Great-father Winter in Orgrimmar.', `OfferRewardText`= 'You\'re quite the helper to ol\' Great-father Winter there, $N.  Have a great Feast of Winter Veil.$B$BHere\'s a little something... you know, for the effort.' WHERE `entry`= 6962;

-- Fixing quest 6983 attributes to reflect 7043
UPDATE `quest_template` SET `QuestLevel`= 35, `RequiredRaces`= 178, `SpecialFlags`= 0 WHERE `entry`=6983;

-- Adding thank you mail after You're a Mean One quest completed
UPDATE `quest_template` SET `RewMailTemplateId`= 117, `RewMailDelaySecs`= 86400 WHERE `entry`= 6983;
UPDATE `quest_template` SET `RewMailTemplateId`= 108, `RewMailDelaySecs`= 86400 WHERE `entry`= 7043;

-- Adding Winter Gifts event
DELETE FROM `game_event` WHERE `entry`= @EVENT;
INSERT INTO `game_event` (`entry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `description`) VALUES (@EVENT, '2006-12-25 16:00:00', '2020-12-31 16:00:00', 525600, 11700, 0, 'Winter Veil: Gifts');

-- Moving quests Winter Presents and New Year Celebrations to 
-- their respective holidays
UPDATE `game_event_quest` SET `event`= @EVENT WHERE `quest`= 8827;
UPDATE `game_event_quest` SET `event`= @EVENT WHERE `quest`= 8828;

DELETE FROM `game_event_quest` WHERE `quest`=8860 AND `event`=6;
INSERT INTO `game_event_quest` (`quest`, `event`) VALUES (8860,6);

DELETE FROM `game_event_quest` WHERE `quest`=8861 AND `event`=6;
INSERT INTO `game_event_quest` (`quest`, `event`) VALUES (8861,6);

-- Adding presents under tree in IF and Org
-- Gaily Wrapped Present
DELETE FROM `gameobject` WHERE `guid`= 151761 AND `id`=180747;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151761, 180747, 0, - 4919.58, -980.674, 501.46, 2.15958, 0, 0, 0, 0, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`= 151762 AND `id`=180747;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151762, 180747, 1,  1626.71, -4414.16, 15.8292, 2.2784, 0, 0, 0, 0, 300, 0, 1);

-- Ticking Present
DELETE FROM `gameobject` WHERE `guid`= 151763 AND `id`=180748;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151763, 180748, 1,  1625.77, -4413.86, 16.0883, 4.80049, 0, 0, 0, 0, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`= 151764 AND `id`=180748;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151764, 180748, 0, - 4921.04, -981.624, 501.464, 1.81635, 0, 0, 0, 0, 300, 0, 1);

-- Festive Gift
DELETE FROM `gameobject` WHERE `guid`= 151765 AND `id`=180793;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151765, 180793, 0, - 4916.73, -982.109, 501.884, 1.72839, 0, 0, 0, 0, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`= 151766 AND `id`=180793;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151766, 180793, 1,  1625.46, -4415.83, 15.4469, 2.11818, 0, 0, 0, 0, 300, 0, 1);

-- Carefully Wrapped Present
DELETE FROM `gameobject` WHERE `guid`= 151767 AND `id`=180743;
INSERT INTO `gameobject` (`guid`, `id`, map, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151767, 180743, 0, - 4915.83, -981.304, 501.759, 1.99149, 0, 0, 0, 0, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`= 151768 AND `id`=180743;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151768, 180743, 1,  1623.6, -4415.36, 15.1169, 0.75159, 0, 0, 0, 0, 300, 0, 1);

-- Gently Shaken Gift
DELETE FROM `gameobject` WHERE `guid`= 151769 AND `id`=180746;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151769, 180746, 0, -4915.18, -978.104, 501.451, 5.56505, 0, 0, 0, 0, 300, 0, 1);

DELETE FROM `gameobject` WHERE `guid`= 151770 AND `id`=180746;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (151770, 180746, 1, 1624.53, -4414.58, 15.9044, 1.30844, 0, 0, 0, 0, 300, 0, 1);


-- Adding to event @EVENT gameobjects
DELETE FROM `game_event_gameobject` WHERE `guid` IN (151761,151762,151763,151764,151764,151765,151766,151767,151768,151769,151770) AND `event`=@EVENT;
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151761,@EVENT);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151762,@EVENT);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151763,@EVENT);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151764,@EVENT);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151765,@EVENT);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151766,@EVENT);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151767,@EVENT);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151768,@EVENT);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151769,@EVENT);
INSERT INTO `game_event_gameobject` (`guid`,`event`) VALUES (151770,@EVENT);

-- Adding Completion text to present quests
UPDATE `quest_template` SET `OfferRewardText`= 'The tag on this present reads:$b$bTo $N,$b$bMay your feast of Great-Winter be merry and bright!' WHERE `entry`= 8744;
UPDATE `quest_template` SET `OfferRewardText`= 'Have a joyous Feast of Great-Winter from your friends at Smokeywood Pastures.' WHERE `entry`= 8769;
UPDATE `quest_template` SET `OfferRewardText`= 'This festively-wrapped present has your name on it.$b$bWait, did it just move?' WHERE `entry`= 8768;
UPDATE `quest_template` SET `MinLevel`= 1, `RequiredClasses`= 13, `OfferRewardText`= 'This present looks like it has been shaken a few times. The tag on it reads:$b$bTo a very special $r $c.' WHERE `entry`= 8767;

-- This quest should only be available to mana users
UPDATE `quest_template` SET `RequiredClasses`= 1490 WHERE `entry`= 8788;

-- Adding 5x Winter Veil Eggnog to Gently Shaken Gift (21271)
DELETE FROM `item_loot_template` WHERE `entry`=21271 AND `item`=21241;
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (21271, 21241, 100, 0, 5, 5, 0);

UPDATE `quest_template` SET `OfferRewardText`= 'The note on this present reads:$b$bTo $n,$b$bIn hoping this will help you spread warm tidings and holiday cheer to all of Azeroth.$b$bFrom Greatfather Winter' WHERE `entry`= 8803;

-- Modifying 1 and adding 3 more spawn points for Abominable    -- Greench
UPDATE `creature` SET `position_x`= 171.682, `position_y`= -260.075, `position_z`= 150.132, `orientation`= 1.142, `spawntimesecs`= 600, `spawndist`= 40, `MovementType`= 1 WHERE `guid`= 89424;

DELETE FROM `creature` WHERE `guid` IN (91750,91751,91752) AND `id`=13602;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (91750, 13602, 0, 13644, 0, 361.078, -54.289, 145.192, 2.182, 600, 40, 0, 3831, 0, 0, 1);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (91751, 13602, 0, 13644, 0, 313.328, -376.999, 169.598, 0.914, 600, 40, 0, 3831, 0, 0, 1);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (91752, 13602, 0, 13644, 0, 550.981, -101.974, 145.180, 2.755, 600, 40, 0, 3831, 0, 0, 1);

DELETE FROM `game_event_creature` WHERE `guid` IN (91750,91751,91752) AND `event`=2;
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES (91750,2);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES (91751,2);
INSERT INTO `game_event_creature` (`guid`, `event`) VALUES (91752,2);

-- Adding pool entry to limit spawns to one at a time
DELETE FROM `pool_creature_template` WHERE `id`=13602 AND `pool_entry`=@POOL;
INSERT INTO `pool_creature_template` (`id`, `pool_entry`, `chance`, `description`) VALUES (13602, @POOL, 0, 'Abominable Greench \(13602\)');

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@POOL, 1, 'Abominable Greench \(13602\)');

-- Altering Mechanical Greench companaion scale
UPDATE `creature_template` SET `Scale`= 0 WHERE `entry`= 15721;

-- Fixed quest 5525 (Free Knot!) and its repeatable follow up 7429 (Free Knot!) in Dire Maul North
-- This closes #746 and closes #113

DELETE FROM `gameobject` WHERE `guid` = 35831;

SET @STRING := 2000005776;
SET @GUID := 10154;
SET @CONDITION := 114;

UPDATE `quest_template` SET `OfferRewardText` = 'Oh, thank you for freeing me! You - ranked number one. Everyone else - ranked number two or lower.$B$BI knew my life was destined for more than just being an appetizer to some ogre!', `CompleteScript` = 5525 WHERE `entry` = 5525;
UPDATE `quest_template` SET `RewRepFaction1` = 169, `RewRepValue1` = 350, `CompleteScript` = 5525 WHERE `entry` = 7429;

DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 5525;
INSERT INTO `dbscripts_on_quest_end` VALUES
(5525, 0, 0, 0, 0, 0, 0, 0, @STRING, 0, 0, 0, 0, 0, 0, 0, ''),
(5525, 0, 29, 3, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'remove flag'),
(5525, 1, 9, @GUID, 43200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'spawn cache'),
(5525, 2, 13, 0, 0, 179511, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'remove ball and chains'),
(5525, 3, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'run on'),
(5525, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 500.42, 540.966, -25.3846, 2.72271, 'WP movement'),
(5525, 15, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'despawn');

DELETE FROM `gameobject` WHERE `guid` = @GUID;
INSERT INTO `gameobject` VALUES
(@GUID, 179501, 429, 583.60, 523.44, -25.40, 3.1848, 0, 0, 0.861341, -0.508028, -43200, 100, 1);
UPDATE `gameobject` SET `spawntimesecs` = 43200 WHERE `id` = 179511;

DELETE FROM `db_script_string` WHERE `entry` = @STRING;
INSERT INTO `db_script_string` VALUES (@STRING, "$N, I'll make sure all my friends in the Cartel know that you've saved my life today. Here - I'm going to need to be able to travel light, so please help yourself to my cache of tailoring and leatherworking supplies! Thanks again - see ya!", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 4, NULL);

DELETE FROM `gossip_menu` WHERE `entry` = 5668;
INSERT INTO `gossip_menu` VALUES
(5668, 6875, 0, 0);

DELETE FROM `gossip_menu_option` WHERE (`menu_id` = 5668) OR (`menu_id` = 5667 AND `id` = 0);
INSERT INTO `gossip_menu_option` VALUES
(5667, 0, 0, 'So, I found this shackle key...', 1, 1, 5668, 0, 0, 0, 0, '', @CONDITION),
(5668, 0, 0, 'I guess so!', 1, 1, -1, 0, 0, 0, 0, '', 0);

UPDATE `gossip_menu_option` SET `action_menu_id` = 5716 WHERE `menu_id` = 5667 AND `id` = 1;

DELETE FROM `conditions` WHERE `condition_entry` = @CONDITION;
INSERT INTO `conditions` VALUES
(@CONDITION, 2, 18250, 1); -- Has gordok shackles key

-- Added missing object 181073 (Fragrant Cauldron) for Love in the Air event
-- Linked quest 9029 (A bubbling cauldron) to it
-- Thanks thetrueanimal for pointing. This closes #739
-- Sources: http://www.wowhead.com/quest=8984/the-source-revealed
-- http://www.wowhead.com/quest=9029/a-bubbling-cauldron
-- http://www.wowhead.com/quest=8984/the-source-revealed#screenshots:id=16849

DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 9029;
INSERT INTO `gameobject_involvedrelation` VALUES
(181073, 9029);

DELETE FROM `gameobject_questrelation` WHERE `quest` = 9029;
INSERT INTO `gameobject_questrelation` VALUES
(181073, 9029);

DELETE FROM `gameobject_template` WHERE `entry` = 181073;
INSERT INTO `gameobject_template` VALUES (181073, 2, 216, 'Fragrant Cauldron', 35, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `gameobject` WHERE `guid` = 121618;
INSERT INTO `gameobject` VALUES
(121618, 181073, 0, 87.6351, -1724.96, 220.192, 1.88655, 0, 0, 0.809484, 0.587141, 25, 100, 1);

DELETE FROM `game_event_gameobject` WHERE `guid` = 121618;
INSERT INTO `game_event_gameobject` VALUES
(121618, 8);

UPDATE `quest_template` SET `MinLevel` = 1 WHERE `entry` = 9029;

-- Fixed drop condition of item 12842 (Cruedly-written Log). The item was currently requiring
-- the player to have complete a quest further down the quest line started by the item
-- making it impossible to drop
-- Thanks the TrueAnimal for pointing. This closes #707
UPDATE `conditions` SET `type` = 9, `value1` = 5121 WHERE `condition_entry` = 211;
UPDATE `quest_template` SET `PrevQuestId` = 8464 WHERE `entry` = 8469; -- Winterfall Activity : prereq of Beads for Salfa

-- Fixed NPCs involved in quest 7003 (Zapped Giants)
-- They will now attack cast and revert to their original form after 5 min
-- Thanks 249CAAFE40 for reporting. This closes #655
DELETE FROM `dbscripts_on_spell` WHERE `id` = 23359;
INSERT INTO `dbscripts_on_spell` VALUES
(23359, 0, 26, 0, 0, 0, 0, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 'Giant/Strider attacks player on Transmogrify Spell Hit');

-- Fixed quest 7838 (Arean Grand Master) in Stranglethorn Vale
-- Thanks scotty0100 for pointing. This closes #172 
UPDATE `quest_template` SET `Method` = 2 WHERE `entry` = 7838;

-- Fixed several graveyards for Horde and Alliance accross the world
-- Thanks @Metalica for reporting with lots of details and @Rushor for contributing.
-- This closes #706
-- Darkshore : Horde should not respawn in Ashenvale
DELETE FROM `game_graveyard_zone` WHERE `id`=512 AND `ghost_zone`=148 AND `faction`=67;
UPDATE `game_graveyard_zone` SET `faction`=0 WHERE `id`=469 AND `ghost_zone`=148;
-- Dun Morogh : Horde should not be able to respawn in Ironforge
DELETE FROM `game_graveyard_zone` WHERE `id` = 102 OR `ghost_zone` = 1537;
INSERT INTO `game_graveyard_zone` VALUES
(102, 1537, 469),
(101, 1537, 67);
-- Undercity : graveyard missing
DELETE FROM `game_graveyard_zone` WHERE `ghost_zone` = 1497;
INSERT INTO `game_graveyard_zone` VALUES
(96, 1497, 67),
(853, 1497, 469);
-- Hinterlands : Alliance should be able to respawn at Overlook Cliffs
UPDATE `game_graveyard_zone` SET `faction` = 0 WHERE `id` = 789;
UPDATE `game_graveyard_zone` SET `faction` = 0 WHERE `id` = 349;

-- Fixed gossip menu of NPC 3430 (Mangletooth) in the Barrens
-- Thanks thegreatsepiroth for reporting. This closes #525
SET @CONDITION := 324;

DELETE FROM `conditions` WHERE `condition_entry` = @CONDITION;
INSERT INTO `conditions` VALUES
(@CONDITION, 8, 5052, 0);

DELETE FROM `gossip_menu` WHERE `entry` = 2944 AND `text_id` = 3656;
INSERT INTO `gossip_menu` VALUES
(2944, 3656, 0, 0);

UPDATE `gossip_menu` SET `condition_id` = @CONDITION WHERE `entry` = 2944 AND `text_id` = 3670;

-- Added missing spawn, movement and aura to NPC 2624 (Gazban) in Stranglethorn Vale
-- This closes #260  
SET @GUID := 105971;

DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` VALUES (@GUID, 0, 0, 1, 16, 0, 0, '6523');

UPDATE `creature_template` SET `FactionAlliance` = 35, `FactionHorde` = 35 WHERE `Entry` = 2624;

DELETE FROM `dbscripts_on_event` WHERE `id` = 364;
INSERT INTO `dbscripts_on_event` VALUES
(364, 0, 10, 2624, 90000, 0, 0, 0, 0, 0, 0, 0, -12179.4, 644.22, -67.1, 5.18, 'spawn Gazban'),
(364, 1, 22, 14, 0, 2624, 400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'change faction to hostile'),
(364, 2, 26, 0, 0, 2624, 400, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'attacks player');

DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID, 2624, 0, 0, 0, -12194, 769.859, -15.9318, 1.96466, 300, 0, 0, 3036, 3191, 0, 2);

DELETE FROM `creature_movement` WHERE `id` = @GUID; 
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `orientation`, `model1`, `model2`) VALUES
(@GUID, 1, -12194.7, 769.551, -15.9318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 2, -12195.2, 780.622, -6.52437, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 3, -12197.7, 797.174, -1.33736, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 4, -12204.2, 818.71, 0.812559, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 5, -12217.6, 838.669, 1.63277, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 6, -12224.5, 856.531, 2.1303, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 7, -12211.9, 879.66, 1.64149, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 8, -12184.3, 908.512, 0.859513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 9, -12159.2, 932.952, 2.17466, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 10, -12147.2, 948.471, 3.21953, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 11, -12131.2, 964.07, 5.20597, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5.02, 0, 0),
(@GUID, 12, -12131.2, 964.07, 5.20597, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 5.02, 0, 0),
(@GUID, 13, -12149.5, 947.191, 2.98636, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 14, -12161.9, 931.291, 2.17916, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 15, -12184.2, 907.044, 0.896548, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 16, -12212.5, 878.705, 1.68139, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 17, -12223.4, 855.218, 2.51366, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 18, -12216, 835.882, 1.65673, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 19, -12202.3, 814.66, 0.211267, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 20, -12196.8, 793.944, -1.38067, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 21, -12196.2, 780.529, -6.76857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0),
(@GUID, 22, -12193.7, 769.494, -16.3151, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);

-- -----------------------

UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='2914'; -- Snake
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4075'; -- Rat
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='4076'; -- Roach

UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11441'; -- Gordok Brute
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11444'; -- Gordok Mage-Lord
UPDATE `creature_template` SET `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='13036'; -- Gordok Mastiff
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11448'; -- Gordok Warlock
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11450'; -- Gordok Reaver
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11445'; -- Gordok Captain
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11446'; -- Gordok Spirit
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14351'; -- Gordok Bushwacker
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14385'; -- Doomguard Minion
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14386'; -- Wandering Eye of Kilrogg
UPDATE `creature_template` SET `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='13160'; -- Carrion Swarmer

UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14322'; -- Stomper Kreeg <The Drunk>
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14326'; -- Guard Mol'dar
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14321'; -- Guard Fengus
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14323'; -- Guard Slip'kik
UPDATE `creature_template` SET `MeleeBaseAttackTime`='1500', `RangedBaseAttackTime`='1500' WHERE `Entry`='14325'; -- Captain Kromcrush
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14324'; -- Cho'Rush the Observer
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='11501'; -- King Gordok

UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14338'; -- Knot Thimblejack
UPDATE `creature_template` SET `MeleeBaseAttackTime`='2000', `RangedBaseAttackTime`='2000' WHERE `Entry`='14353'; -- Mizzle the Crafty
 
-- Fixed model for NPC 659 (El Pollo Grande) in Felwood
-- Thanks theTrueAnimal for pointing. This closes #749
UPDATE `creature_template` SET `ModelId1` = 589 WHERE `entry` = 659;

UPDATE creature SET curhealth = 3936 WHERE id = 13602;
DELETE FROM dbscripts_on_gossip  WHERE id = 5740;

DELETE FROM conditions WHERE condition_entry = 317;
DELETE FROM conditions WHERE condition_entry = 318; 
INSERT INTO conditions VALUES ('317','36','0','60');
INSERT INTO conditions VALUES ('318','36','3','00');

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    
    -- If we get here ok, commit the changes
    IF bRollback = TRUE THEN
      ROLLBACK;
      SELECT '* UPDATE FAILED *' AS 'Status',@cThisRev AS 'DB is on Version';
    ELSE
      COMMIT;
      SELECT '* UPDATE COMPLETE *' AS 'Status',@cNewRev AS 'DB is now on Version';
    END IF;
  ELSE
    SELECT '* UPDATE SKIPPED *' AS 'Status',@cOldRev AS 'Required Version',@cThisRev AS 'Found Version';
  END IF;

END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;
