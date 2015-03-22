-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_03';

UPDATE `dbdocsfields` SET `FieldComment` = 'Controls if a creature template should regenerate it\'s Health/Mana.', `fieldNotes` = 'This flag is a bitmask field which controls if a creature template should regenerate it\'s Health and/or Power. i.e. To Regenerate both Health and Mana, you would set the template to 3 (1+2).<br />¬subtable:38¬' WHERE `fieldId`= '254' AND `languageId`= 0;
