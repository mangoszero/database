-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_20';

-- [485]: change Fleshripper (1109) into Rotten Ghoul (846) at nights (event 27 starting at 21:00)

-- the closest free creature guid
SET @FCGUID=160506;

-- actually add Ghouls to spawns
DELETE FROM `creature` WHERE `map`=0 AND `id`=846 AND POW(`position_x`+10960.8,2)+POW(`position_y`-1607.3,2)<2500;

INSERT INTO `creature` VALUES
 (@FCGUID+0,846,0,0,0,-10988.2,1600.1,45.6427,5.37523,300,5,0,332,0,0,1),
 (@FCGUID+1,846,0,0,0,-10958.9,1603.63,47.8132,1.78282,300,5,0,332,0,0,1),
 (@FCGUID+2,846,0,0,0,-10976.4,1610.5,46.0335,1.98,300,5,0,332,0,0,1),
 (@FCGUID+3,846,0,0,0,-10990.2,1623.08,45.1017,4.4604,300,5,0,332,0,0,1),
 (@FCGUID+4,846,0,0,0,-10962.3,1625.83,46.4382,3.24442,300,5,0,332,0,0,1);

-- add nightly despawn to the Fleshrippers
DELETE FROM `game_event_creature` WHERE `event`=-27 AND `guid` IN (SELECT `guid` FROM `creature` WHERE `map`=0 AND `id`=1109 AND POW(`position_x`+10960.8,2)+POW(`position_y`-1607.3,2)<2500);
INSERT INTO `game_event_creature` (`guid`,`event`) SELECT `guid`,-27 FROM `creature` WHERE `map`=0 AND `id`=1109 AND POW(`position_x`+10960.8,2)+POW(`position_y`-1607.3,2)<2500;

-- add nightly spawn to the Ghouls
DELETE FROM `game_event_creature` WHERE `event`=27 AND `guid` IN (SELECT `guid` FROM `creature` WHERE `map`=0 AND `id`=846 AND POW(`position_x`+10960.8,2)+POW(`position_y`-1607.3,2)<2500);
INSERT INTO `game_event_creature` (`guid`,`event`) SELECT `guid`,27 FROM `creature` WHERE `map`=0 AND `id`=846 AND POW(`position_x`+10960.8,2)+POW(`position_y`-1607.3,2)<2500;
