-- Correct a mismatched version number in the DB

ALTER TABLE db_version CHANGE COLUMN required_20003_02_mangos_spell_bonus_data required_20003_03_mangos_spell_bonus_data bit;
