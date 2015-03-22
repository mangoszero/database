/*
	This fixes the "NULL target for ACTION_T_CAST creature entry 2583 casting spell id 2767" error, for the Stormgarde Troll Hunters.
	The target field (parameter 2 of action 1) was 1, when it should have been 0 
	
*/

UPDATE `creature_ai_scripts` SET `action1_param2`='0' WHERE `id`='258301';
