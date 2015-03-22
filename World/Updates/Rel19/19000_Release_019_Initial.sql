-- Update db_version to set the latest release
ALTER TABLE db_version CHANGE COLUMN required_z2514_mangos_spell_affect required_19000_Release_019_Initial bit;