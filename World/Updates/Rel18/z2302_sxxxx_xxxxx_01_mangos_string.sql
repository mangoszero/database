ALTER TABLE db_version CHANGE COLUMN required_z2268_s1900_12370_02_mangos_npc_vendor_template required_z2302_sxxxx_xxxxx_01_mangos_string bit;

DELETE FROM mangos_string WHERE entry =548;

INSERT INTO mangos_string VALUES
(548,'Player%s %s (guid: %u) Account: %s (id: %u) GMLevel: %u E-mail: %s Last IP: %s Last login: %s Latency: %ums',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
