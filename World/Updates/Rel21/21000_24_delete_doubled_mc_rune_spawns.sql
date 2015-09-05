-- delete doubled molten core rune spawns

DELETE FROM `gameobject` WHERE `guid` = 43162;
DELETE FROM `gameobject` WHERE `guid` = 43164;

INSERT INTO `db_version` VALUES ('21', '1', '2', 'remove_doubled_runes', '');
