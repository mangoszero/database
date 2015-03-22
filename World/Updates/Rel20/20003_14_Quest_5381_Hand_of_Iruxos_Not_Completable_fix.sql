/*
	This fixes the issue where the Quest 5381 Hand of Iruxos is not completable, due to the demon box not appearing as loot after killing the
	NPC (after breaking the crystal with the pickaxe)
	
	The spawn chance for the demon box in the creature_loot_table was set to -100 (minus 100 percent)
	
*/

UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='100' WHERE `entry`='11876' and`item`='13542';
