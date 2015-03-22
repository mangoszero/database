ALTER TABLE db_version CHANGE COLUMN required_19001_01_mangos_command required_19001_02_mangos_string BIT;

INSERT INTO `mangos_string` VALUES
(1510,'Closed ticket for player %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1511,'Ticket system is globally on, accepting all tickets',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1512,'Ticket system is globally off, not accepting tickets at all',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
