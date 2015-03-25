-- version
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_19';

-- Start up errors fix

-- these are not used anywhere
DELETE FROM creature_equip_template_raw where entry IN (32,33,34,35);

-- action_menu_id (269) did not exist and was incorrect, anyway
-- Quartermaster Miranda Breechlock Entry 11536
UPDATE gossip_menu_option SET action_menu_id=100 WHERE menu_id=3461 and id=2;
