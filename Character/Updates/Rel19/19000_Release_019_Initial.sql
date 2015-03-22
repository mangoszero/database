-- Update db_version to set the latest release
ALTER TABLE character_db_version CHANGE COLUMN `required_z1794_s1350_11716_09_characters_auction` `required_19000_Release_019_Initial` bit;