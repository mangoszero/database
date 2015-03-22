-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 11';

-- Update GameObject Template with new script
UPDATE gameobject_template SET ScriptName='go_table_theka' WHERE entry=142715;