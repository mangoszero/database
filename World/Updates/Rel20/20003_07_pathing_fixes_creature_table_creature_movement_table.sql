/*
    This fixes one of the lumberjacks (Northshire peasant) in the Northshire abbey area.
	Before this fix, the lumberjack walked through the tree (FAULT 1) to get to his chopping place, carrying a load of logs (FAULT 2), then
	stood there and just stared at the tree (FAULT 3).
	There was no path set out in the creature_movement table, just 1 entry, so I assumed he was not meant to move about.
	With fix applied, the lumberjack is spawned in place, chopping away.
	creature_movement table entry still needed, or otherwise he would not animate the chopping. 
*/
UPDATE creature_movement SET model1 = 308 WHERE id = 80119; 
UPDATE creature SET position_x = -8840.38, position_y = -271.402, position_z = 80.9516, orientation = 1.12229, modelid = 308 WHERE guid = 80119;

/*
    This fixes one of the Horde Guards, who is facing a wall (canvas/leather material) at Camp Taurajo, instead of looking out to the road (northbound) and 
    surrounding land (facing the wrong way!).
*/
UPDATE creature SET orientation = 4.936845 WHERE guid = 19379;

/*
    This fixes one of the Horde Guards in Camp Taurajo, who has been spawned in nowhere land (outside of the game world).
	It is supposed to be one of the guards by the Inn (right hand side, as you look at it). This fix places the guard there.
*/
UPDATE creature SET position_x = -2376.782227, position_y = -1962.498413, position_z = 96.087646, orientation = 0.773024 WHERE guid = 19382;