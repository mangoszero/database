/*
    This fixes the issue where an NPC says "Missing US Text" when a player character interacts with it.
	All npc_text records that contained "Missing US Text" were traced back to the NPC that they are linked to and the correct text
	was located and used to replace the "Missing US Text" text.
	The text was only replaced if it were necessary to do so. 
	
	In all the following cases, only the correct text for Sprok could not be located; standard greeting was used in that case.
	
	Updates made to the creature_template to ensure the gossip_menu ID is correct. This is done just-in-case anyone set it to 0
	as a result of a supposed fix, which was not correct.
	
	NOTE: In order for these to take affect, the WDB folder of the game client (WoW) must be wiped (delete all files within).
	
 */

-- Sprok - Gnomeregan (Entry 8320)
UPDATE creature_template SET `GossipMenuId`='12741 ' WHERE `Entry`='8320'; 
UPDATE npc_text SET `text0_0`='Greetings $N' WHERE `ID`='17880'; 

-- Lorekeeper Raintotem - Mulgore (Entry 3233)
UPDATE creature_template SET `GossipMenuId`='12707 ' WHERE `Entry`='3233'; 
UPDATE npc_text SET `text0_0`='Only the most valiant and honorable amongst the tribe can earn the honor of being laid to rest at Red Rocks.' WHERE `ID`='17838'; 

-- Kibler - Burning Steppes (Entry 10260) 
UPDATE creature_template SET `GossipMenuId`='12663' WHERE `Entry`='10260';
UPDATE npc_text SET `text0_0`='What!' WHERE `ID`='17805 '; 

-- Terl Arakor - Wetlands (Entry 2153) 
UPDATE creature_template SET `GossipMenuId`='11788' WHERE `Entry`='2153';
UPDATE npc_text SET `text0_0`='This is MY WAGON!$B$BMINE!' WHERE `ID`='16528'; 

-- Griniblix the Spectator - Dire Maul - Feralas (Entry 14395) 
UPDATE creature_template SET `GossipMenuId`='11738' WHERE `Entry`='14395';
UPDATE npc_text SET `text0_0`='Woohoo! They are into it now!' WHERE `ID`='16432'; 

-- Commander Aggro gosh - Grom Gol - STV (Entry 2464) 
UPDATE creature_template SET `GossipMenuId`='11673' WHERE `Entry`='2464';
UPDATE npc_text SET `text0_0`='Welcome to Grom\'gol, $C. Before we get off on the wrong foot, I\'ll have you know that I won\'t have slackers in my Base Camp.. I expect a healthy $R like you to pull your own weight around here.' WHERE `ID`='16334'; 

-- Far Seer Mok thardin - Grom Gol  STV (Entry 2465) 
UPDATE creature_template SET `GossipMenuId`='11674' WHERE `Entry`='2465';
UPDATE npc_text SET `text0_0`='Even in this remote corner of the world, know that Hellscream\'s eyes are upon you.' WHERE `ID`='16335'; 

-- Jangdor Swiftstrider - Camp Mojache - Feralas (Entry 7854) 
UPDATE creature_template SET `GossipMenuId`='1964' WHERE `Entry`='7854';
UPDATE npc_text SET `text0_0`='Welcome to Camp Mojache, brave $C. How may I assist you this day?' WHERE `ID`='2368'; 

-- Baron Revilgaz - Booty Bay (Entry 2496) 
UPDATE creature_template SET `GossipMenuId`='6685' WHERE `Entry`='2496';
UPDATE npc_text SET `text0_0`='Welcome to Booty Bay, partner. I hope your stay in my town is enjoyable and uneventful - emphasis on the latter. We\'ve got plenty of drink if you\'re thirsty, and plenty of bouncers if you\'re antsy.$B$BNow then... what can this humble servant of the Steamwheedle Cartel do for you? Better still - what can you do for me, eh?' WHERE `ID`='7965'; 
DELETE FROM gossip_menu WHERE `entry`='6685' and`text_id`='13062'; 
 