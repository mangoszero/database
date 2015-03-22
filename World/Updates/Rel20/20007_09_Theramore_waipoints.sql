-- [887] credits to: Arkadus
-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_09';

-- correcting waypoints for the Theramore guard (I wonder why it all works with ignored orientation field)
DELETE FROM `creature_movement` WHERE `id`=30639 AND `point` BETWEEN 8 AND 18;
insert into `creature_movement`  values('30639','8','-3726.97','-4418.81','28.5435','0','0','0','0','0','0','0','0','0','0','3.961','0','0');
insert into `creature_movement`  values('30639','9','-3729.53','-4421.38','30.4502','2000','0','0','0','0','0','0','0','0','0','0.7954','0','0');
insert into `creature_movement`  values('30639','10','-3723.93','-4415.39','26.5923','0','0','0','0','0','0','0','0','0','0','0','0','0');
insert into `creature_movement`  values('30639','11','-3715.69','-4407.81','23.1773','0','0','0','0','0','0','0','0','0','0','0','0','0');
insert into `creature_movement`  values('30639','12','-3709.76','-4394.12','18.0685','0','0','0','0','0','0','0','0','0','0','0','0','0');
insert into `creature_movement`  values('30639','13','-3705.45','-4391.2','16.5513','0','0','0','0','0','0','0','0','0','0','0','0','0');
insert into `creature_movement`  values('30639','14','-3689.03','-4392.06','11.2187','0','0','0','0','0','0','0','0','0','0','0','0','0');
insert into `creature_movement`  values('30639','15','-3680.93','-4386.06','10.5868','0','0','0','0','0','0','0','0','0','0','0','0','0');
insert into `creature_movement`  values('30639','16','-3672.82','-4393.77','10.609','0','0','0','0','0','0','0','0','0','0','0','0','0');
insert into `creature_movement`  values('30639','17','-3674.05','-4393.86','10.6142','0','0','0','0','0','0','0','0','0','0','0','0','0');
insert into `creature_movement`  values('30639','18','-3674.43','-4384.91','10.1379','0','0','0','0','0','0','0','0','0','0','0','0','0');
