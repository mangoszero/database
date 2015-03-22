ALTER TABLE db_version CHANGE COLUMN required_z2498_mangos_creature_template_classlevelstats required_z2514_mangos_spell_affect bit;

UPDATE spell_affect SET SpellFamilyMask=SpellFamilyMask|512|33554432 WHERE entry IN (20101,20102,20103,20104,20105);
