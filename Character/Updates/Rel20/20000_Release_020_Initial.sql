-- Update db_version to set the latest release
ALTER TABLE character_db_version CHANGE COLUMN `required_19002_02_character_whispers` `required_20000_Release_020_Initial` bit;