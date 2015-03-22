/*
    These scripts fix the looting issues with the corrupted plants in Felwood, where no loot is available.
	This also relates to the quest: 4117 "Corrupted Whipper Root"
 */


-- this allows the looting of Whipper Root Tuber from Corrupted Whipper Root
DELETE FROM `gameobject_loot_template` WHERE `entry`='164888' and`item`='11951';
DELETE FROM `gameobject_loot_template` WHERE `entry`='173284' and`item`='11951';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174605' and`item`='11951';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174606' and`item`='11951';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174607' and`item`='11951';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174686' and`item`='11951';
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('164888', '11951', '100', '0', '1', '3', '0'),('173284', '11951', '100', '0', '1', '3', '0'),('174605', '11951', '100', '0', '1', '3', '0'),('174606', '11951', '100', '0', '1', '3', '0'),('174607', '11951', '100', '0', '1', '3', '0'),('174686', '11951', '100', '0', '1', '3', '0');

-- this allows the looting of Night Dragon Breath from Corrupted Night Dragon
DELETE FROM `gameobject_loot_template` WHERE `entry`='164885' and`item`='11952';
DELETE FROM `gameobject_loot_template` WHERE `entry`='173324' and`item`='11952';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174608' and`item`='11952';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174684' and`item`='11952';
DELETE FROM `gameobject_loot_template` WHERE `entry`='182114' and`item`='11952';
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('164885', '11952', '100', '0', '1', '3', '0'),('173324', '11952', '100', '0', '1', '3', '0'),('174608', '11952', '100', '0', '1', '3', '0'),('174684', '11952', '100', '0', '1', '3', '0'),('182114', '11952', '100', '0', '1', '3', '0');

-- this allows the looting of Windblossom Berries from Corrupted Windblossom
DELETE FROM `gameobject_loot_template` WHERE `entry`='164887' and`item`='11950';
DELETE FROM `gameobject_loot_template` WHERE `entry`='173327' and`item`='11950';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174599' and`item`='11950';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174600' and`item`='11950';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174601' and`item`='11950';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174602' and`item`='11950';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174603' and`item`='11950';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174604' and`item`='11950';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174708' and`item`='11950';
DELETE FROM `gameobject_loot_template` WHERE `entry`='174709' and`item`='11950';
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('164887', '11950', '100', '0', '1', '3', '0'),('173327', '11950', '100', '0', '1', '3', '0'),('174599', '11950', '100', '0', '1', '3', '0'),('174600', '11950', '100', '0', '1', '3', '0'),('174601', '11950', '100', '0', '1', '3', '0'),('174602', '11950', '100', '0', '1', '3', '0'),('174603', '11950', '100', '0', '1', '3', '0'),('174604', '11950', '100', '0', '1', '3', '0'),('174708', '11950', '100', '0', '1', '3', '0'),('174709', '11950', '100', '0', '1', '3', '0');