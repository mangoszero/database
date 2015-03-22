ALTER TABLE character_db_version CHANGE COLUMN required_19000_Release_019_Initial required_19002_01_character_ticket BIT;

ALTER TABLE character_ticket ADD COLUMN resolved TINYINT(1) DEFAULT 0;
