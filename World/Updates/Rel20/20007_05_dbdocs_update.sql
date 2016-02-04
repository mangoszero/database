-- Adding subtables
delete from `dbdocssubtables` where `subtableId`= 36 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (36,0,'DB script commands','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Command name</b></th>
<th><b>Value</b></th>
<th align=\'left\'><b>Source and target</b></th>
<th align=\'left\'><b>Other fields</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_TALK</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Source = WorldObject, Target = Unit/none</td><td align=\'left\' valign=\'middle\'>dataint = text entry from db_script_string table. dataint2-4 optional for random selected texts</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_EMOTE</td><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Source = Unit, Target = Unit/none</td><td align=\'left\' valign=\'middle\'>datalong1 = emote_id, dataint1-4 optional for random selected emotes</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_FIELD_SET</td><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>source = any</td><td align=\'left\' valign=\'middle\'>datalong = field_id, datalong2 = value</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_MOVE_TO</td><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong2 = travel_speed*100, x/y/z; data_flags & SCRIPT_FLAG_COMMAND_ADDITIONAL: teleport unit to position</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_FLAG_SET</td><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>source = any</td><td align=\'left\' valign=\'middle\'>datalong = field_id, datalong2 = bitmask</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_FLAG_REMOVE</td><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>source = any</td><td align=\'left\' valign=\'middle\'>datalong = field_id, datalong2 = bitmask</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_TELEPORT_TO</td><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>source or target is Player</td><td align=\'left\' valign=\'middle\'>datalong2 = map_id, x/y/z</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_QUEST_EXPLORED</td><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>one from source or target must be Player, another GO/Creature</td><td align=\'left\' valign=\'middle\'>datalong=quest_id, datalong2=distance or 0</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_KILL_CREDIT</td><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>source or target is Player</td><td align=\'left\' valign=\'middle\'>datalong = creature entry (or 0 for target-entry), datalong2 = bool (0=personal credit, 1=group credit)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_RESPAWN_GAMEOBJECT</td><td align=\'center\' valign=\'middle\'>9</td><td align=\'left\' valign=\'middle\'>source = any</td><td align=\'left\' valign=\'middle\'>datalong=db_guid, datalong2=despawn_delay</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_TEMP_SUMMON_CREATURE</td><td align=\'center\' valign=\'middle\'>10</td><td align=\'left\' valign=\'middle\'>source = any</td><td align=\'left\' valign=\'middle\'>datalong=creature entry, datalong2=despawn_delay
; data_flags & SCRIPT_FLAG_COMMAND_ADDITIONAL = summon active</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_OPEN_DOOR</td><td align=\'center\' valign=\'middle\'>11</td><td></td><td align=\'left\' valign=\'middle\'>datalong=db_guid (or not provided), datalong2=reset_delay</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_CLOSE_DOOR</td><td align=\'center\' valign=\'middle\'>12</td><td></td><td align=\'left\' valign=\'middle\'>datalong=db_guid (or not provided), datalong2=reset_delay</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_ACTIVATE_OBJECT</td><td align=\'center\' valign=\'middle\'>13</td><td align=\'left\' valign=\'middle\'>source = unit, target=GO</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_REMOVE_AURA</td><td align=\'center\' valign=\'middle\'>14</td><td align=\'left\' valign=\'middle\'>Source = Unit</td><td align=\'left\' valign=\'middle\'>datalong = spell_id</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_CAST_SPELL</td><td align=\'center\' valign=\'middle\'>15</td><td align=\'left\' valign=\'middle\'>Source = Unit, cast spell on Target = Unit</td><td align=\'left\' valign=\'middle\'>datalong=spellid; data_flags &  SCRIPT_FLAG_COMMAND_ADDITIONAL = cast triggered</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_PLAY_SOUND</td><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>Source = WorldObject, target=any/player</td><td align=\'left\' valign=\'middle\'>datalong (sound_id), datalong2 (bitmask: 0/1=target-player, 0/2=with distance dependent, 0/4=map wide, 0/8=zone wide; so 1|2 = 3 is target with distance dependent)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_CREATE_ITEM</td><td align=\'center\' valign=\'middle\'>17</td><td align=\'left\' valign=\'middle\'>source or target must be player</td><td align=\'left\' valign=\'middle\'>datalong = item entry, datalong2 = amount</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_DESPAWN_SELF</td><td align=\'center\' valign=\'middle\'>18</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong = despawn delay</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_PLAY_MOVIE</td><td align=\'center\' valign=\'middle\'>19</td><td align=\'left\' valign=\'middle\'>target can only be a player</td><td align=\'left\' valign=\'middle\'>datalog = movie id</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_MOVEMENT</td><td align=\'center\' valign=\'middle\'>20</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong = MovementType (0:idle, 1:random or 2:waypoint), datalong2 = wander-distance; data_flags &  SCRIPT_FLAG_COMMAND_ADDITIONAL = Random-movement around current position</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_SET_ACTIVEOBJECT</td><td align=\'center\' valign=\'middle\'>21</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong=bool 0=off, 1=on</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_SET_FACTION</td><td align=\'center\' valign=\'middle\'>22</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong=factionId, datalong2=faction_flags</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL</td><td align=\'center\' valign=\'middle\'>23</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong=creature entry/modelid; data_flags &  SCRIPT_FLAG_COMMAND_ADDITIONAL = use datalong value as modelid explicit</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL</td><td align=\'center\' valign=\'middle\'>24</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong=creature entry/modelid
; data_flags &  SCRIPT_FLAG_COMMAND_ADDITIONAL = use datalong value as modelid explicit</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_SET_RUN</td><td align=\'center\' valign=\'middle\'>25</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong= bool 0=off, 1=on</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_ATTACK_START</td><td align=\'center\' valign=\'middle\'>26</td><td align=\'left\' valign=\'middle\'>Source = Creature, Target = Unit</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_GO_LOCK_STATE</td><td align=\'center\' valign=\'middle\'>27</td><td align=\'left\' valign=\'middle\'>Source = GameObject</td><td align=\'left\' valign=\'middle\'>datalong= 1=lock, 2=unlock, 4=set not-interactable, 8=set interactable</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_STAND_STATE</td><td align=\'center\' valign=\'middle\'>28</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong = stand state (enum UnitStandStateType)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_MODIFY_NPC_FLAGS</td><td align=\'center\' valign=\'middle\'>29</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong=NPCFlags; datalong2:0x00=toggle, 0x01=add, 0x02=remove</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_SEND_TAXI_PATH</td><td align=\'center\' valign=\'middle\'>30</td><td align=\'left\' valign=\'middle\'>source or target must be player</td><td align=\'left\' valign=\'middle\'>datalong = taxi path id</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_TERMINATE_SCRIPT</td><td align=\'center\' valign=\'middle\'>31</td><td></td><td align=\'left\' valign=\'middle\'>datalong = search for npc entry if provided, datalong2= search distance; data_flags & SCRIPT_FLAG_COMMAND_ADDITIONAL: terminate steps of this script if npc found, ELSE: terminate steps of this script if npc not found; dataint=diff to change a waittime of current Waypoint Movement</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_PAUSE_WAYPOINTS</td><td align=\'center\' valign=\'middle\'>32</td><td align=\'left\' valign=\'middle\'>Source = Creature</td><td align=\'left\' valign=\'middle\'>datalong = 0: unpause waypoint 1: pause waypoint</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_JOIN_LFG</td><td align=\'center\' valign=\'middle\'>33</td><td></td><td align=\'left\' valign=\'middle\'>datalong = zoneId</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_TERMINATE_COND</td><td align=\'center\' valign=\'middle\'>34</td><td></td><td align=\'left\' valign=\'middle\'>datalong = condition_id, datalong2 = if != 0 then quest_id of quest that will be failed for player\'s group if the script is terminated; data_flags & SCRIPT_FLAG_COMMAND_ADDITIONAL terminate when condition is false ELSE terminate when condition is true</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_SEND_AI_EVENT_AROUND</td><td align=\'center\' valign=\'middle\'>35</td><td align=\'left\' valign=\'middle\'>Source = Creature, Target = Unit</td><td align=\'left\' valign=\'middle\'>datalong = AIEventType, datalong2 = radius</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_COMMAND_TURN_TO</td><td align=\'center\' valign=\'middle\'>36</td><td align=\'left\' valign=\'middle\'>Source = Unit, Target = Unit/none</td></tr>
</table>
','<Command name|Value|<Source and target|<Other fields
SCRIPT_COMMAND_TALK|0|Source = WorldObject, Target = Unit/none|dataint = text entry from db_script_string table. dataint2-4 optional for random selected texts
SCRIPT_COMMAND_EMOTE|1|Source = Unit, Target = Unit/none|datalong1 = emote_id, dataint1-4 optional for random selected emotes
SCRIPT_COMMAND_FIELD_SET|2|source = any|datalong = field_id, datalong2 = value
SCRIPT_COMMAND_MOVE_TO|3|Source = Creature|datalong2 = travel_speed*100, x/y/z; data_flags & SCRIPT_FLAG_COMMAND_ADDITIONAL: teleport unit to position
SCRIPT_COMMAND_FLAG_SET|4|source = any|datalong = field_id, datalong2 = bitmask
SCRIPT_COMMAND_FLAG_REMOVE|5|source = any|datalong = field_id, datalong2 = bitmask
SCRIPT_COMMAND_TELEPORT_TO|6|source or target is Player|datalong2 = map_id, x/y/z
SCRIPT_COMMAND_QUEST_EXPLORED|7|one from source or target must be Player, another GO/Creature|datalong=quest_id, datalong2=distance or 0
SCRIPT_COMMAND_KILL_CREDIT|8|source or target is Player|datalong = creature entry (or 0 for target-entry), datalong2 = bool (0=personal credit, 1=group credit)
SCRIPT_COMMAND_RESPAWN_GAMEOBJECT|9|source = any|datalong=db_guid, datalong2=despawn_delay
SCRIPT_COMMAND_TEMP_SUMMON_CREATURE|10|source = any|datalong=creature entry, datalong2=despawn_delay; data_flags & SCRIPT_FLAG_COMMAND_ADDITIONAL = summon active
SCRIPT_COMMAND_OPEN_DOOR|11||datalong=db_guid (or not provided), datalong2=reset_delay
SCRIPT_COMMAND_CLOSE_DOOR|12||datalong=db_guid (or not provided), datalong2=reset_delay
SCRIPT_COMMAND_ACTIVATE_OBJECT|13|source = unit, target=GO
SCRIPT_COMMAND_REMOVE_AURA|14|Source = Unit|datalong = spell_id
SCRIPT_COMMAND_CAST_SPELL|15|Source = Unit, cast spell on Target = Unit|datalong=spellid; data_flags &  SCRIPT_FLAG_COMMAND_ADDITIONAL = cast triggered
SCRIPT_COMMAND_PLAY_SOUND|16|Source = WorldObject, target=any/player|datalong (sound_id), datalong2 (bitmask: 0/1=target-player, 0/2=with distance dependent, 0/4=map wide, 0/8=zone wide; so 1\|2 = 3 is target with distance dependent)
SCRIPT_COMMAND_CREATE_ITEM|17|source or target must be player|datalong = item entry, datalong2 = amount
SCRIPT_COMMAND_DESPAWN_SELF|18|Source = Creature|datalong = despawn delay
SCRIPT_COMMAND_PLAY_MOVIE|19| target can only be a player|datalog = movie id
SCRIPT_COMMAND_MOVEMENT|20|Source = Creature|datalong = MovementType (0:idle, 1:random or 2:waypoint), datalong2 = wander-distance; data_flags &  SCRIPT_FLAG_COMMAND_ADDITIONAL = Random-movement around current position
SCRIPT_COMMAND_SET_ACTIVEOBJECT|21|Source = Creature|datalong=bool 0=off, 1=on
SCRIPT_COMMAND_SET_FACTION|22|Source = Creature|datalong=factionId, datalong2=faction_flags
SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL|23|Source = Creature|datalong=creature entry/modelid; data_flags &  SCRIPT_FLAG_COMMAND_ADDITIONAL = use datalong value as modelid explicit
SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL|24|Source = Creature|datalong=creature entry/modelid; data_flags &  SCRIPT_FLAG_COMMAND_ADDITIONAL = use datalong value as modelid explicit
SCRIPT_COMMAND_SET_RUN|25|Source = Creature|datalong= bool 0=off, 1=on
SCRIPT_COMMAND_ATTACK_START|26|Source = Creature, Target = Unit
SCRIPT_COMMAND_GO_LOCK_STATE|27|Source = GameObject|datalong= 1=lock, 2=unlock, 4=set not-interactable, 8=set interactable
SCRIPT_COMMAND_STAND_STATE|28|Source = Creature|datalong = stand state (enum UnitStandStateType)
SCRIPT_COMMAND_MODIFY_NPC_FLAGS|29|Source = Creature|datalong=NPCFlags; datalong2:0x00=toggle, 0x01=add, 0x02=remove
SCRIPT_COMMAND_SEND_TAXI_PATH|30|source or target must be player|datalong = taxi path id
SCRIPT_COMMAND_TERMINATE_SCRIPT|31||datalong = search for npc entry if provided, datalong2= search distance; data_flags & SCRIPT_FLAG_COMMAND_ADDITIONAL: terminate steps of this script if npc found, ELSE: terminate steps of this script if npc not found; dataint=diff to change a waittime of current Waypoint Movement
SCRIPT_COMMAND_PAUSE_WAYPOINTS|32|Source = Creature|datalong = 0: unpause waypoint 1: pause waypoint
SCRIPT_COMMAND_JOIN_LFG|33||datalong = zoneId
SCRIPT_COMMAND_TERMINATE_COND|34||datalong = condition_id, datalong2 = if != 0 then quest_id of quest that will be failed for player\'s group if the script is terminated; data_flags & SCRIPT_FLAG_COMMAND_ADDITIONAL terminate when condition is false ELSE terminate when condition is true
SCRIPT_COMMAND_SEND_AI_EVENT_AROUND|35|Source = Creature, Target = Unit|datalong = AIEventType, datalong2 = radius
SCRIPT_COMMAND_TURN_TO|36|Source = Unit, Target = Unit/none');
delete from `dbdocssubtables` where `subtableId`= 37 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (37,0,'Script Info Data Flags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Flag</b></th>
<th><b>Value (hex)</b></th>
<th align=\'left\'><b>Meaning</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_FLAG_BUDDY_AS_TARGET</td><td align=\'center\' valign=\'middle\'>0x01</td><td align=\'left\' valign=\'middle\'>source -> buddy</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_FLAG_REVERSE_DIRECTION</td><td align=\'center\' valign=\'middle\'>0x02</td><td align=\'left\' valign=\'middle\'>target* -> source* (* result after previous flag is evaluated)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_FLAG_SOURCE_TARGETS_SELF</td><td align=\'center\' valign=\'middle\'>0x04</td><td align=\'left\' valign=\'middle\'>source* -> source* (* result after previous flag is evaluated)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_FLAG_COMMAND_ADDITIONAL</td><td align=\'center\' valign=\'middle\'>0x08</td><td align=\'left\' valign=\'middle\'>command-specific</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SCRIPT_FLAG_BUDDY_BY_GUID</td><td align=\'center\' valign=\'middle\'>0x10</td><td align=\'left\' valign=\'middle\'>take the buddy by guid instead of entry</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SCRIPT_FLAG_BUDDY_IS_PET</td><td align=\'center\' valign=\'middle\'>0x20</td><td align=\'left\' valign=\'middle\'>buddy is a pet</td></tr>
</table>
','<Flag|Value (hex)|<Meaning
SCRIPT_FLAG_BUDDY_AS_TARGET|0x01|source -> buddy
SCRIPT_FLAG_REVERSE_DIRECTION|0x02|target* -> source* (* result after previous flag is evaluated)
SCRIPT_FLAG_SOURCE_TARGETS_SELF|0x04|source* -> source* (* result after previous flag is evaluated)
SCRIPT_FLAG_COMMAND_ADDITIONAL|0x08|command-specific
SCRIPT_FLAG_BUDDY_BY_GUID|0x10| take the buddy by guid instead of entry
SCRIPT_FLAG_BUDDY_IS_PET|0x20|buddy is a pet');

-- Adding comments about fields
update `dbdocstable` set `languageId`=0, `tableName`='dbscripts_on_creature_death', `tableNotes`='This table holds scripts activated when a creature dies. (Source: creature; at the script execution time, it is considered alive, so can cast instant spells.)' where tableId=38;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'ID of the creature (creature_template.entry), at which death will run this script.<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by "delay" parameter.' where `fieldId`= '353' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds. Note that for any delay>0, the creature is dead and cannot perform any action by itself (including cast).' where `fieldId`= '352' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Script command.', `fieldNotes` = 'Script command. Note for this script type, several commands have no sense. These are animation command (will be overridden by death animation), movement, mount, despawn.<br />¬subtable:36¬' where `fieldId`= '343' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '350' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '351' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '346' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '347' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '348' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '349' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position X.', `fieldNotes` = 'X of position - for commands requiring position.' where `fieldId`= '356' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Y.', `fieldNotes` = 'Y of position - for commands requiring position.' where `fieldId`= '357' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Z.', `fieldNotes` = 'Z of position - for commands requiring position.' where `fieldId`= '358' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Orientation angle (0 to 2*Pi).', `fieldNotes` = 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.' where `fieldId`= '354' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '344' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (creature_template.entry) for changing source/target.', `fieldNotes` = 'Creature ID (creature_template.entry) for changing source/target.' where `fieldId`= '342' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command flags.', `fieldNotes` = 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬' where `fieldId`= '345' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.' where `fieldId`= '355' and `languageId`= 0;

update `dbdocstable` set `languageId`=0, `tableName`='dbscripts_on_creature_movement', `tableNotes`='This table holds scripts activated when a creature moving by waypoints reaches a WP. (Source: creature)' where tableId=39;
update `dbdocsfields` set `FieldComment` = 'Script ID (See creature_movement*.script_id).', `fieldNotes` = 'Script ID (See creature_movement_template.script_id, creature_movement_template.script_id).<br />Usually starts at creature entry * 100.<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by "delay" parameter.' where `fieldId`= '370' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds.' where `fieldId`= '369' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Script command.', `fieldNotes` = 'Script command. Note for this script type, either waittime for the waipoint should be defined, or stop/start WP movement should be used.<br />¬subtable:36¬' where `fieldId`= '360' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '367' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '368' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '363' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '364' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '365' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '366' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position X.', `fieldNotes` = 'X of position - for commands requiring position.' where `fieldId`= '373' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Y.', `fieldNotes` = 'Y of position - for commands requiring position.' where `fieldId`= '374' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Z.', `fieldNotes` = 'Z of position - for commands requiring position.' where `fieldId`= '375' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Orientation angle (0 to 2*Pi).', `fieldNotes` = 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.' where `fieldId`= '371' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '361' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (creature_template.entry) for changing source/target.', `fieldNotes` = 'Creature ID (creature_template.entry) for changing source/target.' where `fieldId`= '359' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command flags.', `fieldNotes` = 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬' where `fieldId`= '362' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.' where `fieldId`= '372' and `languageId`= 0;

update `dbdocstable` set `languageId`=0, `tableName`='dbscripts_on_event', `tableNotes`='This table holds scripts activated when an event is sent either via spell (SPELL_EFFECT_SEND_EVENT=61) or by a gameobject.' where tableId=40;
update `dbdocsfields` set `FieldComment` = 'Event ID (See gameobject_template or Spell.dbc).', `fieldNotes` = 'Event ID (See gameobject_template or Spell.dbc).<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by "delay" parameter.' where `fieldId`= '387' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds.' where `fieldId`= '386' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Script command.', `fieldNotes` = 'Script command.<br />¬subtable:36¬' where `fieldId`= '377' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '384' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '385' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '380' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '381' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '382' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '383' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position X.', `fieldNotes` = 'X of position - for commands requiring position.' where `fieldId`= '390' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Y.', `fieldNotes` = 'Y of position - for commands requiring position.' where `fieldId`= '391' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Z.', `fieldNotes` = 'Z of position - for commands requiring position.' where `fieldId`= '392' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Orientation angle (0 to 2*Pi).', `fieldNotes` = 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.' where `fieldId`= '388' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '378' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (creature_template.entry) for changing source/target.', `fieldNotes` = 'Creature ID (creature_template.entry) for changing source/target.' where `fieldId`= '376' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command flags.', `fieldNotes` = 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬' where `fieldId`= '379' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.' where `fieldId`= '389' and `languageId`= 0;

update `dbdocstable` set `languageId`=0, `tableName`='creature_movement', `tableNotes`='This table holds all the information on each creature\'s waypoints. In essence, a set of waypoints just defines a path that the creature will follow by going from point to point. More specifically, once the creature arrives at a point, it can do different things like cast a spell, do an emote, etc. Usually this table is filled through the .wp command (and its various subcommands) in the world. <br /><br />Please note that for a creature to use waypoints, its MovementType must be 2.' where tableId=23;
update `dbdocsfields` set `FieldComment` = 'Creature GUID (See creature.guid).', `fieldNotes` = 'Creature GUID (See creature.guid).' where `fieldId`= '155' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Emote ID that the creature should perform.', `fieldNotes` = 'Emote ID that the creature should perform.<br /><br />List of often used emote IDs and what they do ie. 65 Makes the creature look dead by lying on the ground.<br />¬subtable:22¬' where `fieldId`= '154' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The spell identifier.', `fieldNotes` = 'The spell identifier. The value has to match with a spell identifier defined in Spell.dbc. This refers to a spell which should be cast by the creature on this waypoint.' where `fieldId`= '164' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='creature_movement_template', `tableNotes`='This table holds informations on paths for creature_template entries and allows the behaviour to be defined along the movement path (set of waypoints).<br /><br />Template movement is usually applied to creature templates spawned by scripts, or for templates which are unique and have only one spawn.<br /><br /><b>Note:</b> Movement attached to a creature template will be applied to all spawns of this template, unless there is a unique movement defined for the creature guids in the creature_movement table.' where tableId=24;
update `dbdocsfields` set `FieldComment` = 'Creature ID from creature_template (See creature_template.entry)', `fieldNotes` = 'Creature ID from creature_template (See creature_template.entry)' where `fieldId`= '173' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Emote ID that the creature should perform.', `fieldNotes` = 'Emote ID that the creature should perform.<br />List of often used emote IDs and what they do ie. 65 Makes the creature look dead by lying on the ground.<br />¬subtable:22¬' where `fieldId`= '172' and `languageId`= 0;

update `dbdocstable` set `languageId`=0, `tableName`='dbscripts_on_go_template_use', `tableNotes`='This table holds scripts activated when a character uses a gameobject (like door, chest, button so on).' where tableId=41;
update `dbdocsfields` set `FieldComment` = 'Gameobject ID (See gameobject_template.entry).', `fieldNotes` = 'Gameobject ID (See gameobject_template.entry).<br />Note that commands with source = Unit should not be used here. The correct source may be defined via &quot;buddy&quot; or flag mechanic, see below.<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by "delay" parameter.' where `fieldId`= '404' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds.' where `fieldId`= '403' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Script command.', `fieldNotes` = 'Script command.<br />¬subtable:36¬' where `fieldId`= '394' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '401' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '402' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '397' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '398' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '399' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '400' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position X.', `fieldNotes` = 'X of position - for commands requiring position.' where `fieldId`= '407' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Y.', `fieldNotes` = 'Y of position - for commands requiring position.' where `fieldId`= '408' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Z.', `fieldNotes` = 'Z of position - for commands requiring position.' where `fieldId`= '409' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Orientation angle (0 to 2*Pi).', `fieldNotes` = 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.' where `fieldId`= '405' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '395' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (creature_template.entry) for changing source/target.', `fieldNotes` = 'Creature ID (creature_template.entry) for changing source/target.' where `fieldId`= '393' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command flags.', `fieldNotes` = 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬' where `fieldId`= '396' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.' where `fieldId`= '406' and `languageId`= 0;

update `dbdocstable` set `languageId`=0, `tableName`='dbscripts_on_go_use', `tableNotes`='This table holds scripts activated when a character uses either door or button. This script, bound to the GameObject GUID, does not override the script bound to the GameObject entry, if any. If both scripts are defined, they are executed sequentially, the script from this table activates after the script from dbscripts_on_go_template_use.' where tableId=42;
update `dbdocsfields` set `FieldComment` = 'Gameobject GUID (See gameobject.guid).', `fieldNotes` = 'Gameobject GUID (See gameobject.guid).<br />Note that commands with source = Unit will be ineffective here because source = GameObject and target = Player. The correct source may be defined via &quot;buddy&quot; or flag mechanic, see below.<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by "delay" parameter.' where `fieldId`= '421' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds.' where `fieldId`= '420' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Script command.', `fieldNotes` = 'Script command.<br />¬subtable:36¬' where `fieldId`= '411' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '418' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '419' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '414' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '415' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '416' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '417' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position X.', `fieldNotes` = 'X of position - for commands requiring position.' where `fieldId`= '424' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Y.', `fieldNotes` = 'Y of position - for commands requiring position.' where `fieldId`= '425' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Z.', `fieldNotes` = 'Z of position - for commands requiring position.' where `fieldId`= '426' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Orientation angle (0 to 2*Pi).', `fieldNotes` = 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.' where `fieldId`= '422' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '412' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (creature_template.entry) for changing source/target.', `fieldNotes` = 'Creature ID (creature_template.entry) for changing source/target.' where `fieldId`= '410' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command flags.', `fieldNotes` = 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬' where `fieldId`= '413' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.' where `fieldId`= '423' and `languageId`= 0;

update `dbdocstable` set `languageId`=0, `tableName`='dbscripts_on_gossip', `tableNotes`='This table holds scripts mentioned in the gossip_menu and gossip_menu_item tables. In the latter case, the parameters depend on object type (GameObject or Unit) of the object having such gossip: for GO, source = Player and target = GameObject; for Unit, source = Unit and target = Player. In the former case, source = Player and target = Unit. This all is rather funny, isn\'t this?<br />The scripts &quot;on talking to gameobject&quot; are implemented instead with dbscripts_on_go_template_use.' where tableId=43;
update `dbdocsfields` set `FieldComment` = 'Gossip script ID.', `fieldNotes` = 'Gossip script ID (See gossip_menu.script_id, gossip_menu_option.action_script_id).<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by "delay" parameter.' where `fieldId`= '438' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds.' where `fieldId`= '437' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Script command.', `fieldNotes` = 'Script command.<br />¬subtable:36¬' where `fieldId`= '428' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '435' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '436' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '431' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '432' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '433' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '434' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position X.', `fieldNotes` = 'X of position - for commands requiring position.' where `fieldId`= '441' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Y.', `fieldNotes` = 'Y of position - for commands requiring position.' where `fieldId`= '442' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Z.', `fieldNotes` = 'Z of position - for commands requiring position.' where `fieldId`= '443' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Orientation angle (0 to 2*Pi).', `fieldNotes` = 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.' where `fieldId`= '439' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '429' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (creature_template.entry) for changing source/target.', `fieldNotes` = 'Creature ID (creature_template.entry) for changing source/target.' where `fieldId`= '427' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command flags.', `fieldNotes` = 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬' where `fieldId`= '430' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.' where `fieldId`= '440' and `languageId`= 0;

update `dbdocstable` set `languageId`=0, `tableName`='dbscripts_on_quest_end', `tableNotes`='This table holds scripts mentioned in the quest_template table. Here source = questrewarder, target = Player.' where tableId=44;
update `dbdocsfields` set `FieldComment` = 'Quest end script ID (See quest_template.CompleteScript).', `fieldNotes` = 'Quest end script ID (See quest_template.CompleteScript).<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by "delay" parameter.' where `fieldId`= '455' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds.' where `fieldId`= '454' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Script command.', `fieldNotes` = 'Script command.<br />¬subtable:36¬' where `fieldId`= '445' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '452' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '453' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '448' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '449' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '450' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '451' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position X.', `fieldNotes` = 'X of position - for commands requiring position.' where `fieldId`= '458' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Y.', `fieldNotes` = 'Y of position - for commands requiring position.' where `fieldId`= '459' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Z.', `fieldNotes` = 'Z of position - for commands requiring position.' where `fieldId`= '460' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Orientation angle (0 to 2*Pi).', `fieldNotes` = 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.' where `fieldId`= '456' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '446' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (creature_template.entry) for changing source/target.', `fieldNotes` = 'Creature ID (creature_template.entry) for changing source/target.' where `fieldId`= '444' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command flags.', `fieldNotes` = 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬' where `fieldId`= '447' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.' where `fieldId`= '457' and `languageId`= 0;

update `dbdocstable` set `languageId`=0, `tableName`='dbscripts_on_quest_start', `tableNotes`='This table holds scripts mentioned in the quest_template table. Here source = questgiver, target = Player.' where tableId=45;
update `dbdocsfields` set `FieldComment` = 'Quest start script ID (See quest_template.StartScript).', `fieldNotes` = 'Quest start script ID (See quest_template.StartScript).<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by "delay" parameter.' where `fieldId`= '472' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds.' where `fieldId`= '471' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Script command.', `fieldNotes` = 'Script command.<br />¬subtable:36¬' where `fieldId`= '462' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '469' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '470' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '465' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '466' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '467' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '468' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position X.', `fieldNotes` = 'X of position - for commands requiring position.' where `fieldId`= '475' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Y.', `fieldNotes` = 'Y of position - for commands requiring position.' where `fieldId`= '476' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Z.', `fieldNotes` = 'Z of position - for commands requiring position.' where `fieldId`= '477' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Orientation angle (0 to 2*Pi).', `fieldNotes` = 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.' where `fieldId`= '473' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '463' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (creature_template.entry) for changing source/target.', `fieldNotes` = 'Creature ID (creature_template.entry) for changing source/target.' where `fieldId`= '461' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command flags.', `fieldNotes` = 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬' where `fieldId`= '464' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.' where `fieldId`= '474' and `languageId`= 0;

update `dbdocstable` set `languageId`=0, `tableName`='dbscripts_on_spell', `tableNotes`='This table holds scripts triggered by spells with EFFECT_DUMMY (3) or EFFECT_SCRIPT_EFFECT (77). Here source = caster, target = unitTarget.<br />Note that if the spell contains more than 1 effect of such type, this script will be set up for the single effect only, namely for one with the least effect number.' where tableId=46;
update `dbdocsfields` set `FieldComment` = 'Spell ID (See Spell.dbc).', `fieldNotes` = 'Spell ID (See Spell.dbc).<br />The script may contain several commands with identical id. Execution of these commands is not synchronized but the sequence is uniquely defined by "delay" parameter.' where `fieldId`= '489' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Delay (sec).', `fieldNotes` = 'Delay in seconds.' where `fieldId`= '488' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Script command.', `fieldNotes` = 'Script command.<br />¬subtable:36¬' where `fieldId`= '479' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '486' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '487' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '482' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '483' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '484' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Command parameter, see command description.' where `fieldId`= '495' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position X.', `fieldNotes` = 'X of position - for commands requiring position.' where `fieldId`= '492' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Y.', `fieldNotes` = 'Y of position - for commands requiring position.' where `fieldId`= '493' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Position Z.', `fieldNotes` = 'Z of position - for commands requiring position.' where `fieldId`= '494' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Orientation angle (0 to 2*Pi).', `fieldNotes` = 'Orientation angle (0 to 2*Pi): 0 north, Pi south - for commands requiring position.' where `fieldId`= '490' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '480' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (creature_template.entry) for changing source/target.', `fieldNotes` = 'Creature ID (creature_template.entry) for changing source/target.' where `fieldId`= '478' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command flags.', `fieldNotes` = 'Command flags (see enum ScriptInfoDataFlags in ScriptMgr.h).<br />Default cast direction: source/buddy -> target, flags can change this.<br />¬subtable:37¬' where `fieldId`= '481' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Radius for the buddy search.', `fieldNotes` = 'Radius, in which the buddy will be searched. For changing source/target mechanic.' where `fieldId`= '491' and `languageId`= 0;
