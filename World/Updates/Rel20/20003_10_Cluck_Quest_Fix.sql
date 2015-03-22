/*
	The fixes the Cluck! quest, where the Continue button is disabled when it should be enabled
*/

UPDATE quest_template SET `SpecialFlags`='0' WHERE `entry`='3861';
