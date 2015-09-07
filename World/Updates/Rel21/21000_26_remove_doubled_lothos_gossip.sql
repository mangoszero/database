-- delete doubled gossip_menu_option for the teleport to molten core

DELETE FROM `gossip_menu_option` WHERE `option_text` LIKE 'Teleport me to the Molten Core, Lothos.';
UPDATE `gossip_menu_option` SET `id` = 0 WHERE `option_text` LIKE 'Transport me to the Molten Core, Lothos.';

INSERT INTO `db_version` VALUES ('21', '1', '4', 'remove_doubled_lothos_gossip', '');
