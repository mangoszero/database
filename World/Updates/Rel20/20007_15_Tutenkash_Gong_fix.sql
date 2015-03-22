INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_15';

-- Tuten'kash Gong - Rezorfen Downs

-- make gong usable by everyone (it was only usable by GMs)
UPDATE gameobject_template SET flags=0, data3=19660800 WHERE entry=148917;

