ALTER TABLE db_version CHANGE COLUMN required_20003_03_mangos_spell_bonus_data required_20003_04_mangos_spell_bonus_data bit;

-- Seal of Command fix
-- 20% SpellDamageBonusDone
-- 29% SpellDamageBonusTaken
UPDATE `spell_bonus_data` SET `direct_bonus`='0', `direct_bonus_done`='0.2', `direct_bonus_taken`='0.29' WHERE `entry`='20424';

