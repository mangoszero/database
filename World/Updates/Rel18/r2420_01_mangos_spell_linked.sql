ALTER TABLE db_version CHANGE COLUMN required_z2408_s2034_12522_01_mangos_db_script_string required_r2420_01_mangos_spell_linked bit;

DROP TABLE IF EXISTS `spell_linked`;
CREATE TABLE IF NOT EXISTS `spell_linked` (
  `entry` int(10) unsigned NOT NULL COMMENT 'Spell entry',
  `linked_entry` int(10) unsigned NOT NULL COMMENT 'Linked spell entry',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Type of link',
  `effect_mask`int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'mask of effect (NY)',
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`,`linked_entry`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Linked spells storage';