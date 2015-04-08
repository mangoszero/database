-- Update db_version to set the latest release
ALTER TABLE character_db_version CHANGE COLUMN `required_21000_00_Release_021_Initial` `required_21000_01_warden_action` bit;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `warden_action`
-- ----------------------------
DROP TABLE IF EXISTS `warden_action`;
CREATE TABLE `warden_action` (
  `wardenId` smallint(5) unsigned NOT NULL,
  `action` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`wardenId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of warden_action
-- ----------------------------
