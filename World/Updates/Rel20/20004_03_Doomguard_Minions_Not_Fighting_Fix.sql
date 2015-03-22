/*
	This fixes the issue where the Doomguard Minions in Dire Maul are just standing around doing nothing, when 
	they should be fighting.
	This adds the combat abilities for the Doomguard Minions to the creature_ai_scripts as well as activating the
	use of AI for the creature.
	see: http://www.wowwiki.com/Doomguard_(warlock_minion)
 */

-- Add the Revision update into the revision column
INSERT INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 03';

-- enable the use of AI scripts for the Doomguard Minion creatures
UPDATE creature_template SET `AIName`='EventAI' WHERE `Entry`='14385';

-- CRIPPLE ABILITY:
-- add Cripple ability to Doomguard Minion's AI scripts
DELETE FROM creature_ai_scripts WHERE id=1438501;
INSERT INTO creature_ai_scripts (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1438501', '14385', '9', '0', '100', '31', '0', '30', '30100', '34900', '11', '89', '1', '32', '0', '0', '0', '0', '0', '0', '0', '0', 'Doomguard Minion - Cast Cripple');

-- RAIN OF FIRE ABILITY:
-- add Rain of Fire ability to Doomguard Minion's AI scripts
DELETE FROM creature_ai_scripts WHERE id=1438502;
INSERT INTO creature_ai_scripts (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1438502', '14385', '0', '0', '100', '1', '5000', '8000', '18000', '24000', '11', '16005', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Doomguard Minion - Cast Rain of Fire');

-- DISPEL ABILITY:
-- add Dispel ability to Doomguard Minion's AI scripts
DELETE FROM creature_ai_scripts WHERE id=1438503;
INSERT INTO creature_ai_scripts (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1438503', '14385', '0', '0', '100', '1', '7000', '14000', '17000', '22000', '11', '15090', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Doomguard Minion - Cast Dispel Magic');

-- WAR STOMP ABILITY:
-- add War Stomp ability to Doomguard Minion's AI scripts
DELETE FROM creature_ai_scripts WHERE id=1438504;
INSERT INTO creature_ai_scripts (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES ('1438504', '14385', '0', '0', '100', '1', '12000', '15000', '20000', '25000', '11', '16727', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Doomguard Minion - Cast War Stomp');

