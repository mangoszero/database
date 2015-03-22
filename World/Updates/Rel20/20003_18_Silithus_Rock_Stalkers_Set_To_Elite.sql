/*
	This sets the Rock Stalkers in Silithus to Elite (Rank)
	They did not have their elite status removed until patch 2.3
*/

UPDATE creature_template SET `Rank`='1' WHERE `Entry`='11739';
