ALTER TABLE  `db_version` CHANGE `required_r2439_01_mangos_command` `required_r2441_01_mangos_db_version` BIT(1) NULL DEFAULT NULL;

ALTER TABLE `db_version` ADD PRIMARY KEY(`version`);
