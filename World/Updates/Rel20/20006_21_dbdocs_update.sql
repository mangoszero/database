-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_21';

delete from `dbdocssubtables` where `subtableId`= 30 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (30,0,'Character RaceMask','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Race</b></th>
<th><b>Mask Value (hex)</b></th>
<th><b>Mask Value (dec)</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>Human</td><td align=\'center\' valign=\'middle\'>0x1</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>Orc</td><td align=\'center\' valign=\'middle\'>0x2</td><td align=\'center\' valign=\'middle\'>2</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>Dwarf</td><td align=\'center\' valign=\'middle\'>0x4</td><td align=\'center\' valign=\'middle\'>4</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>Night Elf</td><td align=\'center\' valign=\'middle\'>0x8</td><td align=\'center\' valign=\'middle\'>8</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>Undead</td><td align=\'center\' valign=\'middle\'>0x10</td><td align=\'center\' valign=\'middle\'>16</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>Tauren</td><td align=\'center\' valign=\'middle\'>0x20</td><td align=\'center\' valign=\'middle\'>32</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>Gnome</td><td align=\'center\' valign=\'middle\'>0x40</td><td align=\'center\' valign=\'middle\'>64</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>Troll</td><td align=\'center\' valign=\'middle\'>0x80</td><td align=\'center\' valign=\'middle\'>128</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>Goblin</td><td align=\'center\' valign=\'middle\'>0x100</td><td align=\'center\' valign=\'middle\'>256</td></tr>
</table>
','<Race|Mask Value (hex)|Mask Value (dec)
Human|0x1|1
Orc|0x2|2
Dwarf|0x4|4
Night Elf|0x8|8
Undead|0x10|16
Tauren|0x20|32
Gnome|0x40|64
Troll|0x80|128
Goblin|0x100|256');

DELETE FROM `dbdocsfields` WHERE `tableName` IN ('game_event','game_event_creature','game_event_creature_data','game_event_gameobject','game_event_mail','game_event_quest');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (511,0,'game_event','description','Description of the event.','Textual comment about the event.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (512,0,'game_event','end_time','Global ending date of the event.','Ending date of the event. After this date, the event will never happen.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (513,0,'game_event','entry','ID of the event.','ID of the event. May be any, should be as low as possible.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (514,0,'game_event','holiday','Holiday ID.','Holiday ID is a number, associated with the seasonal events and strictly defined since 3.x (WotLK) client version. Ignore this if you do not know one.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (515,0,'game_event','length','Event duration (minutes).','The interval (in minutes) between start and end of single event occurence.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (516,0,'game_event','occurence','Event periodicity (minutes).','The interval (minutes) between consequent starts of the event.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (517,0,'game_event','start_time','Global starting date for the event.','Starting date for the event. Defines the first event occurence only, see <i>occurence</i> and <i>length</i> for the next ones.<br />NOTE: due to occurence/length event definition, the seasonal events require an editing in leap-years. The simplest solution is to change start_time to the event start at such year.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (518,0,'game_event_creature','event','ID of game event (See game_event.entry).','ID of game event (See game_event.entry).<br />If positive, the creature will be spawned at event start and despawned at event end.<br />If negative, the creature will be despawned at event start and spawned again at event end.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (519,0,'game_event_creature','guid','Creature GUID (See creature.guid).','GUID of an existing creature.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (520,0,'game_event_creature_data','entry_id','New creature ID (See creature_template.entry).','New ID of the creature (See creature_template.entry) applied during the event.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (521,0,'game_event_creature_data','equipment_id','New equipment ID (See creature_equip_template.entry).','New equipment ID (See creature_equip_template.entry) applied during the event.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (522,0,'game_event_creature_data','event','Event ID (See game_event.entry).','Event ID (See game_event.entry).');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (523,0,'game_event_creature_data','guid','Creature GUID (See creature.guid).','GUID of the creature (See creature.guid) which should change their appearance during the event.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (524,0,'game_event_creature_data','modelid','New modelID (See creature_template.ModelId1,2)','New modelID of the creature (creature_template.ModelId1 or ModelId2) applied during the event.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (525,0,'game_event_creature_data','spell_end','Spell ID (See Spell.dbc) to be removed.','ID of the aura spell (See Spell.dbc) to be removed from the creature at event start. Usually this is an aura of unlimited duration, added to the creature via creature_template_addon/creature_addon table. The aura will be applied again at event end.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (526,0,'game_event_creature_data','spell_start','Spell ID (See Spell.dbc) to be selfcasted.','ID of the spell (See Spell.dbc) which the creature will cast on self at event start. Usually this is an aura of unlimited duration. The aura will be removed at event end.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (527,0,'game_event_gameobject','event','ID of the event (See game_event.entry).','ID of the event (See game_event.entry).<br />If positive, the gameobject is spawned at event start and despawned at event end.<br />If negative, the gameobject is despawned at event start and spawned again at event end.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (528,0,'game_event_gameobject','guid','GUID of gameobject (See gameobject.guid).','GUID of an existing gameobject.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (529,0,'game_event_mail','event','Event ID (See game_events.entry).','Event ID (See game_events.entry).');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (530,0,'game_event_mail','mailTemplateId','Mail template ID (See MailTemplate.dbc).','Mail template ID (See MailTemplate.dbc) of the mail which will be sent to the player when all conditions are satisfied.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (531,0,'game_event_mail','quest','Quest (See quest_template.entry) which should be rewarded.','The quest (See quest_template.entry) which the player should have REWARDED (handed off) for receiving the mail.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (532,0,'game_event_mail','raceMask','Races of affected players.','Races of affected players based on enum Races (See ChrRaces.dbc) in the bitmask form. Values from the table may be combined by simple adding.<br />¬subtable:30¬');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (533,0,'game_event_mail','senderEntry','NPC entry (See creature_template.entry).','Entry (See creature_template.entry) of the NPC which will sign the mail.');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (534,0,'game_event_quest','event','Event ID (see game_event.entry).','Event ID (see game_event.entry).');
insert  into `dbdocsfields`(`fieldId`,`languageId`,`tableName`,`fieldName`,`fieldComment`,`fieldNotes`) values (535,0,'game_event_quest','quest','Quest ID (See quest_template.entry).','ID of the quest (See quest_template.entry) which will be accessible only during the event.');

DELETE FROM `dbdocstable` WHERE `tableName` IN ('game_event','game_event_creature','game_event_creature_data','game_event_gameobject','game_event_mail','game_event_quest');
insert  into `dbdocstable`(`tableId`,`languageId`,`tableName`,`tableNotes`) values (50,0,'game_event','This table contains definitions for all game events that are activated or deactivated automatically by the Game Event System in the core.<br />NOTE: an object (creature, GO etc.) cannot be related to a more than 1 game event. For example, if you wish something to happen only at March nights, you cannot combine events \"March\" and \"Nights\", but have to define a new event like \"Nights\" starting March 1 and ending April 1 of the same year.');
insert  into `dbdocstable`(`tableId`,`languageId`,`tableName`,`tableNotes`) values (51,0,'game_event_creature','Contains all creature instances that have to be spawned/unspawned during defined game events.');
insert  into `dbdocstable`(`tableId`,`languageId`,`tableName`,`tableNotes`) values (52,0,'game_event_creature_data','Contains all creature instances that need to change display id and/or equipment during defined game events.');
insert  into `dbdocstable`(`tableId`,`languageId`,`tableName`,`tableNotes`) values (53,0,'game_event_gameobject','Contains all gameobjects instances that participate to any game event.');
insert  into `dbdocstable`(`tableId`,`languageId`,`tableName`,`tableNotes`) values (54,0,'game_event_mail','This table holds definitions for mails sent out during game events and conditions for when to send the mail.');
insert  into `dbdocstable`(`tableId`,`languageId`,`tableName`,`tableNotes`) values (55,0,'game_event_quest','This table controls availability of the quests during the events. When out of the event a questgiver may not be despawned, you can disable quests which he proposes. Quests listed here will be available only during respective events.');
