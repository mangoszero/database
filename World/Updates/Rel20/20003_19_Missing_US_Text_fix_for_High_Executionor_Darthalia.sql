/*
	This fixes the issue where High Executor Darthalia's (Tarren Mill, Hillsbrad Foothills) greeting is "Missing US Text"

	The text used is the same as used on the TrueWow private server. No other sources could be found, other than private servers.
*/

UPDATE npc_text SET `text0_0`='Greetings $N' WHERE `ID`='16667';
