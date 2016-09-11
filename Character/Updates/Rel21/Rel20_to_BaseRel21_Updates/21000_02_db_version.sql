SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `character_db_version`;

-- --------------------------------
-- Table structure for `db_version`
-- --------------------------------
DROP TABLE IF EXISTS `db_version`;
CREATE TABLE `db_version` (
  `version` int(3) NOT NULL,
  `structure` int(3) NOT NULL,
  `content` int(3) NOT NULL,
  `description` varchar(30) NOT NULL DEFAULT '',
  `comment` varchar(150) DEFAULT '',
  PRIMARY KEY (`version`,`structure`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Used DB version notes';

-- ---------------------
-- Records of db_version
-- ---------------------
INSERT INTO `db_version` VALUES ('21', '1', '0', 'revision_refactor', '');
