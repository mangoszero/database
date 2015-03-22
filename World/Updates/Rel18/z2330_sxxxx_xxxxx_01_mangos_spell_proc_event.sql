ALTER TABLE db_version CHANGE COLUMN required_z2302_sxxxx_xxxxx_01_mangos_string required_z2330_sxxxx_xxxxx_01_mangos_spell_proc_event bit;

DELETE FROM `spell_proc_event` WHERE `entry` = 23401;
INSERT INTO spell_proc_event VALUES
(23401, 0x00,  6, 0x0000000000041e00, 0x0000000000000000, 0x0000000000000000, 0x00004000, 0x00000000, 0.000000, 0.000000,  0);
