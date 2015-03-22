-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 08';

-- 11 records with text entries written in the 3rd person were being output in the 1st person
-- "type" defines how the text is output (say, yell, emote, etc.)
UPDATE db_script_string SET `type`='2' where content_default like "%\%s%" and type = 0;
