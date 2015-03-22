ALTER TABLE db_version CHANGE COLUMN required_19001_02_mangos_string required_19003_01_mangos_string BIT;

INSERT INTO `mangos_string` VALUES
(1513,'You cant close a ticket for offline players',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
