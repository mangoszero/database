ALTER TABLE db_version CHANGE COLUMN required_z2268_s1900_12370_01_mangos_npc_vendor required_z2268_s1900_12370_02_mangos_npc_vendor_template bit;

ALTER TABLE npc_vendor_template ADD COLUMN `condition_id` mediumint(8) unsigned NOT NULL default '0' AFTER incrtime;
