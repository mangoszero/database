/*
	This fixes the issue where the Gnarlpine Totemic is casting heal on the player instead of itself
	The target field (parameter 2 of action 1) was 0 (target is the creature it is attacking), when it should have been 1 (target is itself)
	
*/

UPDATE `creature_ai_scripts` SET `action1_param2`='1' WHERE `id`='201401';
