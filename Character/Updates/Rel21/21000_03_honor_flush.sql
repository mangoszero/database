-- mark the already counted rows in the hk table
ALTER TABLE `character_honor_cp` ADD COLUMN `used` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '=1 if already counted in rank points';
-- change version
INSERT INTO `db_version` (`version`,`structure`,`content`,`description`) VALUES (21,2,0,'honor_counting');
