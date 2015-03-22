ALTER TABLE db_version CHANGE COLUMN required_20002_creature_template_power required_20003_01_mangos_spell_bonus_data bit;

-- Update table structure for one-hand/two-hand custom spell coeff.
-- Add also support of custom coeff for done/taken damage.
ALTER TABLE `spell_bonus_data`
ADD COLUMN `one_hand_direct_bonus` FLOAT NOT NULL DEFAULT 0 AFTER `direct_bonus`,
ADD COLUMN `two_hand_direct_bonus` FLOAT NOT NULL DEFAULT 0 AFTER `one_hand_direct_bonus`,
ADD COLUMN `direct_bonus_done` FLOAT NOT NULL DEFAULT 0 AFTER `two_hand_direct_bonus`,
ADD COLUMN `one_hand_direct_bonus_done` FLOAT NOT NULL DEFAULT 0 AFTER `direct_bonus_done`,
ADD COLUMN `two_hand_direct_bonus_done` FLOAT NOT NULL DEFAULT 0 AFTER `one_hand_direct_bonus_done`,
ADD COLUMN `direct_bonus_taken` FLOAT NOT NULL DEFAULT 0 AFTER `two_hand_direct_bonus_done`,
ADD COLUMN `one_hand_direct_bonus_taken` FLOAT NOT NULL DEFAULT 0 AFTER `direct_bonus_taken`,
ADD COLUMN `two_hand_direct_bonus_taken` FLOAT NOT NULL DEFAULT 0 AFTER `one_hand_direct_bonus_taken`;