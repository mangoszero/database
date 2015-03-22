ALTER TABLE db_version CHANGE COLUMN required_z2330_sxxxx_xxxxx_01_mangos_spell_proc_event required_z2363_s1957_12440_01_mangos_spell_area bit;

ALTER TABLE spell_area ADD COLUMN `condition_id` mediumint(8) unsigned NOT NULL default '0' AFTER quest_end;
