/*

	This fixes the issue where trash mobs and boss adds could be affected by crowd control.
	It makes bosses and their Adds Immune to crowd control. It also make trash mobs immune to crowd control
	except for elementals which could still be banished.

*/

ALTER TABLE db_version CHANGE COLUMN `required_20003_04_mangos_spell_bonus_data` required_20003_16_Molten_Core_Creature_Cleanup bit;

UPDATE `creature_template` SET `MechanicImmuneMask` = '1073594367' WHERE `creature_template`.`Entry` =11668;
UPDATE `creature_template` SET `MechanicImmuneMask` = '1073594367' WHERE `creature_template`.`Entry` =11665;
UPDATE `creature_template` SET `MechanicImmuneMask` = '1073594367' WHERE `creature_template`.`Entry` =12101;
UPDATE `creature_template` SET `MechanicImmuneMask` = '1073594367' WHERE `creature_template`.`Entry` =11666;
UPDATE `creature_template` SET `MechanicImmuneMask` = '1073594367' WHERE `creature_template`.`Entry` =12076;
UPDATE `creature_template` SET `MechanicImmuneMask` = '1073594367' WHERE `creature_template`.`Entry` =12100;
UPDATE `creature_template` SET `MechanicImmuneMask` = '1073594367' WHERE `creature_template`.`Entry` =11667;
UPDATE `creature_template` SET `MechanicImmuneMask` = '1073594367' WHERE `creature_template`.`Entry` =12009;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =12118;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11658;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11673;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11669;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11671;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11659;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =12119;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11982;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =12259;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11661;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =12057;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =12056;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =12264;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =12098;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11662;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11988;
UPDATE `creature_template` SET `MechanicImmuneMask` = '617299803' WHERE `creature_template`.`Entry` =11672; 
