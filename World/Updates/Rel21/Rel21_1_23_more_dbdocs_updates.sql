-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional update
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT structure FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurContent := (SELECT content FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '1'; 
    SET @cOldContent = '22'; 

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '1';
    SET @cNewContent = '23';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'dbdocs updates';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Updates made to dbdocs table, subtables, and fields';

    -- Evaluate all settings
    SET @cCurResult := (SELECT description FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cOldResult := (SELECT description FROM db_version WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;

        -- UPDATE THE DB VERSION
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
        SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

-- dbocstable
-- -- -- -- -
update `dbdocsfields` set `FieldComment` = 'Data field Two for the condition.', `fieldNotes` = 'Data field Two for the condition.<br /><br /><br /><br />Condition Types:<br /><br />¬subtable:12¬' where `fieldId`= '37' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Event Type ID, from one of the Events below:

<hr />
<pre>
* *0 = EVENT&#95;', `fieldNotes` = 'Event Type ID, from one of the Events below:<br /><br />¬subtable:100¬<br /><br />Now that all of the supported events have been listed and described, we shall now move on to the actions that can be performed. Each event can take up to three actions. The actions will all be performed when the event is triggered and they will be performed in the order that they have been defined. This means that, for a certain event, action 1 will be performed first, followed by action 2, then lastly by action 3. Just like event definitions, each action can use up to three different parameters but not all actions will use all three parameters. If a parameter isn\'t mentioned for an action, then that action does not need that parameter.<br />' where `fieldId`= '83' and `languageId`= 0;

update `dbdocsfields` set `FieldComment` = 'The first actiontype.', `fieldNotes` = 'The first actiontype<br /><br /><br />Before we start to list and explain the different actions that can be taken, we must first look at how the eventAI targeting system works. Due to technical reasons in how targetting is handled, the eventAI script cannot target anything or anyone that is not in its threat list or is not the scripted creature itself. It also can\'t currently target anyone specific in its threat list except by their position in the threat list. However, even then it can only target specifically the current victim, the second unit in its threat list, and the last unit in its threat list. It can also target units in its threat list at random and has two options for that: anyone in its threat list at random, or anyone in its threat list excluding the unit with the most threat. Aside from all of those external targets, the script can always target itself. More information on the target types can be found in the reference tables at the end of this guide.<br /><br />One last note before we start looking at individual actions is about the texts. The eventAI script has support for localized text entries. Therefore, you can define what the mob will say in more than one language all in another table and the script will show the corresponding localized text to the corresponding client (english text to enUS/enGB clients, german text to deDE clients, etc). All of the localized text entries will have a unique text ID assigned to them and it is that text ID that will be used by any actions that require textual input.<br /><br />¬subtable:2¬<br /><br />

Possible target types<br /><pre><br />* *TARGET_T_SELF<br />**0<br />**Self cast<br />
* *TARGET_T_HOSTILE<br />**1<br />**Our current target (ie: top aggro)<br />
* *TARGET_T_HOSTILE_SECOND_AGGRO<br />**2<br />**Second highest aggro, usually offtank (generaly used for cleaves and some special attacks)<br />
* *TARGET_T_HOSTILE_LAST_AGGRO<br />**3<br />**Bottom aggro target (these are healers usually)<br />
* *TARGET_T_HOSTILE_RANDOM<br />**4<br />**Just any random target on our threat list<br />
* *TARGET_T_HOSTILE_RANDOM_NOT_TOP<br />**5<br />**Any random target except top aggro<br />
* *TARGET_T_ACTION_INVOKER<br />**6<br />**Unit who caused this Event to occur (only works for EVENT_T_AGGRO, EVENT_T_KILL, EVENT_T_DEATH, EVENT_T_SPELLHIT, EVENT_T_OOC_LOS, EVENT_T_FRIENDLY_HP, EVENT_T_FRIENDLY_IS_CC, EVENT_T_FRIENDLY_MISSING_BUFF, EVENT_T_RECEIVE_EMOTE, EVENT_T_RECEIVE_AI_EVENT)<br />
* *TARGET_T_ACTION_INVOKER_OWNER<br />**7<br />**Unit owning the one responsible for Event to occur, for example, the hunter which pet triggered the event (only works for EVENT_T_AGGRO, EVENT_T_KILL, EVENT_T_DEATH, EVENT_T_SPELLHIT, EVENT_T_OOC_LOS, EVENT_T_FRIENDLY_HP, EVENT_T_FRIENDLY_IS_CC, EVENT_T_FRIENDLY_MISSING_BUFF, EVENT_T_RECEIVE_EMOTE, EVENT_T_RECEIVE_AI_EVENT)<br />
* *TARGET_T_HOSTILE_RANDOM_PLAYER<br />**8<br />**Just any random player on our threat list<br />
* *TARGET_T_HOSTILE_RANDOM_NOT_TOP_PLAYER<br />**9<br />**Any random player from threat list except top aggro (ie except main tank)<br />
* *TARGET_T_EVENT_SENDER<br />**10<br />**Unit who sent an AIEvent that was received with EVENT_T_RECEIVE_AI_EVENT<br /></pre>' where `fieldId`= '65' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Main Event.', `fieldNotes` = 'The identifier for the event node in the battleground. Event nodes usually are defined in the battleground’s script.<br /><br />Nodes are locations in a battleground where characters of each faction can perform actions, such as capturing a tower in Alterac Valley, or taking control over the stables in Arathi Basin.' where `fieldId`= '107' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Sub Event.', `fieldNotes` = 'The state of the event node. Node status is defined differently in every battleground script.<br /><br />Node events can occur for every node and usually describe changes due to character interaction. E.g. if stables in Arathi Basin are taken over by Alliance, the stables note state would become Alliance controlled. Similar node states exist for every battleground note.<br /><br /><hr><br /><b>Note</b><br /><br />If you update battleground scripts and make changes to node status values ensure that you provide database update scripts which update the battleground events accordingly.<br />' where `fieldId`= '108' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='creature_equip_template', `tableNotes`='This table contains all equipment creatures should wear.' where tableId=15;
update `dbdocsfields` set `FieldComment` = 'Unique Id of the equipment, no link with any official data.', `fieldNotes` = 'Unique Id of the equipment, no link with any official data.' where `fieldId`= '110' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A map identifier', `fieldNotes` = 'A map identifier. The value has to match with a map identifier (See Map.dbc). This is the map where creature templates are located.' where `fieldId`= '138' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'master entry to trigger events', `fieldNotes` = 'This is a  unique ID for which the entry is valid (See “creature_template” table).<br /><br />This is the master creature template which defines behaviour for the linked creature template.' where `fieldId`= '139' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This flag determines how a linked creature will act.', `fieldNotes` = 'This flag determines how a linked creature will act, when the master is changing it\'s combat state. Flags provide support for combat state, non combat state and life state.<br /><br />The following flags determine the behaviour if the master is in combat state.<br /><br />¬subtable:51¬<br /><br />' where `fieldId`= '137' and `languageId`= 0;

        
        
-- dbocssubtables
-- -- -- -- -- --
delete from `dbdocssubtables` where `subtableId`= 100 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (100,0,'Event Types','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Type</b></th>
<th><b>Parameters</b></th>
<th><b>Description</b></th>
<th><b>Notes</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>EVENT_T_TIMER_IN_COMBAT</td><td align=\'center\' valign=\'middle\'>InitialMin, InitialMax, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4)</td><td align=\'center\' valign=\'middle\'>EXPIRES ONLY IN COMBAT.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>EVENT_T_TIMER_OOC</td><td align=\'center\' valign=\'middle\'>InitialMin, InitialMax, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4)</td><td align=\'center\' valign=\'middle\'>EXPIRES ONLY OUT OF COMBAT BUT NOT DURING EVADE.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>EVENT_T_HP</td><td align=\'center\' valign=\'middle\'>HPMax%, HPMin%, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when the NPC’s HP% is between (Param1) and (Param2). Will repeat between every (Param3) and (Param4)</td><td align=\'center\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'center\' valign=\'middle\'>EVENT_T_MANA</td><td align=\'center\' valign=\'middle\'>ManaMax%,ManaMin% RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when the NPC’s Mana% is between (Param1) and (Param2). Will repeat between every (Param3) and (Param4)</td><td align=\'center\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>EVENT_T_AGGRO NONE</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>Expires ONLY upon the NPC’s INITIAL Aggro at the Start of Combat (Does NOT Repeat) and Only Resets on Spawn or Evade.</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>EVENT_T_KILL</td><td align=\'center\' valign=\'middle\'>RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires upon Killing a Player. Will Repeat Check between (Param1) and (Param2).</td><td align=\'center\' valign=\'middle\'>This Event Will Not Trigger Again Until Repeat Timer Expires</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'center\' valign=\'middle\'>EVENT_T_DEATH NONE</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>Expires on the NPC’s Death. (This Triggers At The Moment The NPC Dies)</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'center\' valign=\'middle\'>EVENT_T_EVADE NONE</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>Expires at the moment the Creature EnterEvadeMode() and Exits Combat.</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>EVENT_T_SPELLHIT</td><td align=\'center\' valign=\'middle\'>SpellID, School, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires upon Spell Hit of the NPC. When (param1) is set, it is the specific Spell ID used as the trigger. With (param2) specified, the expiration is limited to specific spell schools (-1 for all) and Spell ID value is ignored.</td><td align=\'center\' valign=\'middle\'>Will repeat Event Conditions Check between every (Param3) and (Param4). Only A Spell ID or Spell School may be Specified but NOT both.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>9</td><td align=\'center\' valign=\'middle\'>EVENT_T_RANGE</td><td align=\'center\' valign=\'middle\'>MinDist, MaxDist, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when the Highest Threat Target Distance is Greater than (Param1) and Less than (Param2).</td><td align=\'center\' valign=\'middle\'>Will repeat between every (Param3) and (Param4) if Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>10</td><td align=\'center\' valign=\'middle\'>EVENT_T_OOC_LOS</td><td align=\'center\' valign=\'middle\'>NoHostile, MaxRange, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when a unit moves within distance (MaxAllowedRange) of the NPC. If (Param1) is 0 it will expire only when unit is hostile, If (Param1) is 1 it will expire only when unit is friendly.</td><td align=\'center\' valign=\'middle\'>This depends generally on faction relations. Will repeat every (Param3) and (Param4). Does NOT expire when the NPC is in combat.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>11</td><td align=\'center\' valign=\'middle\'>EVENT_T_SPAWNED</td><td align=\'center\' valign=\'middle\'>Condition, CondValue1</td><td align=\'center\' valign=\'middle\'>Expires on initial spawn and respawn of the NPC (Useful for setting Ranged Movement/Summoning Pets/Applying Buffs).</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>12</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_HP</td><td align=\'center\' valign=\'middle\'>HPMax%, HPMin%, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when current target’s HP% is between (Param1) and (Param2). Will repeat every (Param3) and (Param4)</td><td align=\'center\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>13</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_CASTING</td><td align=\'center\' valign=\'middle\'>RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when the current target is casting a spell. Will repeat every (Param1) and (Param2)</td><td align=\'center\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>14</td><td align=\'center\' valign=\'middle\'>EVENT_T_FRIENDLY_HP</td><td align=\'center\' valign=\'middle\'>HPDeficit, Radius, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when a friendly unit in (Radius) has at least (Param1) HP points missing. Will repeat every (Param3) and (Param4)</td><td align=\'center\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>15</td><td align=\'center\' valign=\'middle\'>EVENT_T_FRIENDLY_IS_CC</td><td align=\'center\' valign=\'middle\'>DispelType, Radius, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when a friendly unit is crowd controlled within the given Radius (Param2). Will repeat every (Param3) and (Param4).</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'center\' valign=\'middle\'>EVENT_T_FRIENDLY_MISSING_BUFF</td><td align=\'center\' valign=\'middle\'>SpellId, Radius, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when a friendly unit is missing aura(s) given by a spell (Param1) within Radius (Param2). Will repeat every (Param3) and (Param4) If Event Conditions Are Still Met.</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>17</td><td align=\'center\' valign=\'middle\'>EVENT_T_SUMMONED_UNIT</td><td align=\'center\' valign=\'middle\'>CreatureId, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires after creature with entry = (Param1) is spawned (Param1 = 0 means all spawns).</td><td align=\'center\' valign=\'middle\'>Will repeat every (Param2) and (Param3).</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>18</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_MANA</td><td align=\'center\' valign=\'middle\'>ManaMax%, ManaMin%, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires when current target’s Mana% is between (Param1) and (Param2). Will repeat every (Param3) and (Param4)</td><td align=\'center\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>19</td><td align=\'center\' valign=\'middle\'>EVENT_T_QUEST_ACCEPT QuestID</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>20</td><td align=\'center\' valign=\'middle\'>EVENT_T_QUEST_COMPLETE</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>&nbsp;</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>21</td><td align=\'center\' valign=\'middle\'>EVENT_T_REACHED_HOME</td><td align=\'center\' valign=\'middle\'>NONE</td><td align=\'center\' valign=\'middle\'>Expires when a creature reaches it’s home (spawn) location after evade.</td><td align=\'center\' valign=\'middle\'>This is commonly used for NPC’s who Stealth once reaching their Spawn Location</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>22</td><td align=\'center\' valign=\'middle\'>EVENT_T_RECEIVE_EMOTE</td><td align=\'center\' valign=\'middle\'>EmoteId, Condition, CondValue1, CondValue2</td><td align=\'center\' valign=\'middle\'>Expires when a creature receives an emote with emote text id (“enum TextEmotes” from SharedDefines.h in Mangos Source) in (Param1).</td><td align=\'center\' valign=\'middle\'>Conditions can be defined (Param2) with optional values (Param3,Param4), see (enum ConditionType) in ObjectMgr.h (Mangos Source).</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>23</td><td align=\'center\' valign=\'middle\'>EVENT_T_AURA</td><td align=\'center\' valign=\'middle\'>Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max Expires when a creature has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).</td><td align=\'center\' valign=\'middle\'>Will repeat every (Param3) and (Param4)</td><td align=\'center\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>24</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_AURA</td><td align=\'center\' valign=\'middle\'>Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max Expires when a target unit has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).</td><td align=\'center\' valign=\'middle\'>Will repeat every (Param3) and (Param4)</td><td align=\'center\' valign=\'middle\'>If Event Conditions Are Still Met.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>25</td><td align=\'center\' valign=\'middle\'>EVENT_T_SUMMONED_JUST_DIED</td><td align=\'center\' valign=\'middle\'>CreatureId, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires after creature with entry = (Param1) is die (Param1 = 0 means all spawns).</td><td align=\'center\' valign=\'middle\'>Will repeat every (Param2) and (Param3).</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>26</td><td align=\'center\' valign=\'middle\'>EVENT_T_SUMMONED_JUST_DESPAWN</td><td align=\'center\' valign=\'middle\'>CreatureId, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires before creature with entry = (Param1) is despawn (Param1 = 0 means all spawns).</td><td align=\'center\' valign=\'middle\'>Will repeat every (Param2) and (Param3).</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>27</td><td align=\'center\' valign=\'middle\'>EVENT_T_MISSING_AURA</td><td align=\'center\' valign=\'middle\'>Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max</td><td align=\'center\' valign=\'middle\'>Expires when a creature not has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).</td><td align=\'center\' valign=\'middle\'>Will repeat every (Param3) and (Param4).</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>28</td><td align=\'center\' valign=\'middle\'>EVENT_T_TARGET_MISSING_AURA</td><td align=\'center\' valign=\'middle\'>Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max</td><td align=\'center\' valign=\'middle\'>Expires when a target unit not has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).</td><td align=\'center\' valign=\'middle\'>Will repeat every (Param3) and (Param4).</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>29</td><td align=\'center\' valign=\'middle\'>EVENT_T_TIMER_GENERIC</td><td align=\'center\' valign=\'middle\'>InitialMin, InitialMax, RepeatMin, RepeatMax</td><td align=\'center\' valign=\'middle\'>Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4).</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>30</td><td align=\'center\' valign=\'middle\'>EVENT_T_RECEIVE_AI_EVENT</td><td align=\'center\' valign=\'middle\'>AIEventType, Sender-Entry, unused, unused</td><td align=\'center\' valign=\'middle\'>Expires when the creature receives an AIEvent of type (Param1), sent by creature (Param2 != 0). If (Param2 = 0) then sent by any creature</td><td align=\'center\' valign=\'middle\'>&nbsp;</td></tr>
</table>
','Value|Type|Parameters|Description|Notes
0|EVENT_T_TIMER_IN_COMBAT|InitialMin, InitialMax, RepeatMin, RepeatMax|Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4)|EXPIRES ONLY IN COMBAT. 
1|EVENT_T_TIMER_OOC|InitialMin, InitialMax, RepeatMin, RepeatMax|Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4)|EXPIRES ONLY OUT OF COMBAT BUT NOT DURING EVADE. 
2|EVENT_T_HP|HPMax%, HPMin%, RepeatMin, RepeatMax|Expires when the NPC’s HP% is between (Param1) and (Param2). Will repeat between every (Param3) and (Param4)|If Event Conditions Are Still Met.| 
3|EVENT_T_MANA|ManaMax%,ManaMin% RepeatMin, RepeatMax|Expires when the NPC’s Mana% is between (Param1) and (Param2). Will repeat between every (Param3) and (Param4)|If Event Conditions Are Still Met. 
4|EVENT_T_AGGRO NONE|&nbsp;|Expires ONLY upon the NPC’s INITIAL Aggro at the Start of Combat (Does NOT Repeat) and Only Resets on Spawn or Evade.|&nbsp; 
5|EVENT_T_KILL|RepeatMin, RepeatMax|Expires upon Killing a Player. Will Repeat Check between (Param1) and (Param2).|This Event Will Not Trigger Again Until Repeat Timer Expires 
6|EVENT_T_DEATH NONE|&nbsp;|Expires on the NPC’s Death. (This Triggers At The Moment The NPC Dies) |&nbsp;
7|EVENT_T_EVADE NONE|&nbsp;|Expires at the moment the Creature EnterEvadeMode() and Exits Combat.|&nbsp;
8|EVENT_T_SPELLHIT|SpellID, School, RepeatMin, RepeatMax|Expires upon Spell Hit of the NPC. When (param1) is set, it is the specific Spell ID used as the trigger. With (param2) specified, the expiration is limited to specific spell schools (-1 for all) and Spell ID value is ignored.|Will repeat Event Conditions Check between every (Param3) and (Param4). Only A Spell ID or Spell School may be Specified but NOT both. 
9|EVENT_T_RANGE|MinDist, MaxDist, RepeatMin, RepeatMax|Expires when the Highest Threat Target Distance is Greater than (Param1) and Less than (Param2).|Will repeat between every (Param3) and (Param4) if Event Conditions Are Still Met. 
10|EVENT_T_OOC_LOS|NoHostile, MaxRange, RepeatMin, RepeatMax|Expires when a unit moves within distance (MaxAllowedRange) of the NPC. If (Param1) is 0 it will expire only when unit is hostile, If (Param1) is 1 it will expire only when unit is friendly.|This depends generally on faction relations. Will repeat every (Param3) and (Param4). Does NOT expire when the NPC is in combat. 
11|EVENT_T_SPAWNED|Condition, CondValue1|Expires on initial spawn and respawn of the NPC (Useful for setting Ranged Movement/Summoning Pets/Applying Buffs).|&nbsp;
12|EVENT_T_TARGET_HP|HPMax%, HPMin%, RepeatMin, RepeatMax|Expires when current target’s HP% is between (Param1) and (Param2). Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met. 
13|EVENT_T_TARGET_CASTING|RepeatMin, RepeatMax|Expires when the current target is casting a spell. Will repeat every (Param1) and (Param2)|If Event Conditions Are Still Met. 
14|EVENT_T_FRIENDLY_HP|HPDeficit, Radius, RepeatMin, RepeatMax|Expires when a friendly unit in (Radius) has at least (Param1) HP points missing. Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met. 
15|EVENT_T_FRIENDLY_IS_CC|DispelType, Radius, RepeatMin, RepeatMax|Expires when a friendly unit is crowd controlled within the given Radius (Param2). Will repeat every (Param3) and (Param4).|&nbsp;
16|EVENT_T_FRIENDLY_MISSING_BUFF|SpellId, Radius, RepeatMin, RepeatMax|Expires when a friendly unit is missing aura(s) given by a spell (Param1) within Radius (Param2). Will repeat every (Param3) and (Param4) If Event Conditions Are Still Met.|&nbsp;
17|EVENT_T_SUMMONED_UNIT|CreatureId, RepeatMin, RepeatMax|Expires after creature with entry = (Param1) is spawned (Param1 = 0 means all spawns).|Will repeat every (Param2) and (Param3). 
18|EVENT_T_TARGET_MANA|ManaMax%, ManaMin%, RepeatMin, RepeatMax|Expires when current target’s Mana% is between (Param1) and (Param2). Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met. 
19|EVENT_T_QUEST_ACCEPT QuestID|&nbsp;|&nbsp;|&nbsp;
20|EVENT_T_QUEST_COMPLETE|&nbsp;|&nbsp;|&nbsp;
21|EVENT_T_REACHED_HOME|NONE|Expires when a creature reaches it’s home (spawn) location after evade.|This is commonly used for NPC’s who Stealth once reaching their Spawn Location 
22|EVENT_T_RECEIVE_EMOTE|EmoteId, Condition, CondValue1, CondValue2|Expires when a creature receives an emote with emote text id (“enum TextEmotes” from SharedDefines.h in Mangos Source) in (Param1).|Conditions can be defined (Param2) with optional values (Param3,Param4), see (enum ConditionType) in ObjectMgr.h (Mangos Source). 
23|EVENT_T_AURA|Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max Expires when a creature has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).|Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met. 
24|EVENT_T_TARGET_AURA|Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max Expires when a target unit has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).|Will repeat every (Param3) and (Param4)|If Event Conditions Are Still Met. 
25|EVENT_T_SUMMONED_JUST_DIED|CreatureId, RepeatMin, RepeatMax|Expires after creature with entry = (Param1) is die (Param1 = 0 means all spawns).|Will repeat every (Param2) and (Param3).| 
26|EVENT_T_SUMMONED_JUST_DESPAWN|CreatureId, RepeatMin, RepeatMax|Expires before creature with entry = (Param1) is despawn (Param1 = 0 means all spawns).|Will repeat every (Param2) and (Param3).
27|EVENT_T_MISSING_AURA|Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max|Expires when a creature not has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).|Will repeat every (Param3) and (Param4). 
28|EVENT_T_TARGET_MISSING_AURA|Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max|Expires when a target unit not has spell (Param1) auras applied in a stack greater or equal to value provided in (Param2).|Will repeat every (Param3) and (Param4). 
29|EVENT_T_TIMER_GENERIC|InitialMin, InitialMax, RepeatMin, RepeatMax|Expires at first between (Param1) and (Param2) and then will repeat between every (Param3) and (Param4).|&nbsp;
30|EVENT_T_RECEIVE_AI_EVENT|AIEventType, Sender-Entry, unused, unused|Expires when the creature receives an AIEvent of type (Param1), sent by creature (Param2 != 0). If (Param2 = 0) then sent by any creature|&nbsp;');

delete from `dbdocssubtables` where `subtableId`= 111 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (111,0,'Action Types','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th><b>Type</b></th>
<th align=\'left\'><b>Parameters</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'center\' valign=\'middle\'>ACTION_T_NONE</td><td align=\'left\' valign=\'middle\'>No action</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'center\' valign=\'middle\'>ACTION_T_TEXT</td><td align=\'left\' valign=\'middle\'>TextId1, optionally -TextId2, optionally -TextId3(if -TextId2 exist). If more than just -TextId1 is defined, randomize. Neg$</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'center\' valign=\'middle\'>ACTION_T_SET_FACTION</td><td align=\'left\' valign=\'middle\'>FactionId (or 0 for default)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'center\' valign=\'middle\'>ACTION_T_MORPH_TO_ENTRY_OR_MODEL</td><td align=\'left\' valign=\'middle\'>Creature_template entry(param1) OR ModelId (param2) (or 0 for both to demorph)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'center\' valign=\'middle\'>ACTION_T_SOUND</td><td align=\'left\' valign=\'middle\'>SoundId</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'center\' valign=\'middle\'>ACTION_T_EMOTE</td><td align=\'left\' valign=\'middle\'>EmoteId</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'center\' valign=\'middle\'>ACTION_T_RANDOM_SAY</td><td align=\'left\' valign=\'middle\'>UNUSED</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>7</td><td align=\'center\' valign=\'middle\'>ACTION_T_RANDOM_YELL</td><td align=\'left\' valign=\'middle\'>UNUSED</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>8</td><td align=\'center\' valign=\'middle\'>ACTION_T_RANDOM_TEXTEMOTE</td><td align=\'left\' valign=\'middle\'>UNUSED</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>9</td><td align=\'center\' valign=\'middle\'>ACTION_T_RANDOM_SOUND</td><td align=\'left\' valign=\'middle\'>SoundId1, SoundId2, SoundId3 (-1 in any field means no output if randomed that field)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>10</td><td align=\'center\' valign=\'middle\'>ACTION_T_RANDOM_EMOTE</td><td align=\'left\' valign=\'middle\'>EmoteId1, EmoteId2, EmoteId3 (-1 in any field means no output if randomed that field)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>11</td><td align=\'center\' valign=\'middle\'>ACTION_T_CAST</td><td align=\'left\' valign=\'middle\'>SpellId, Target, CastFlags</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>12</td><td align=\'center\' valign=\'middle\'>ACTION_T_SUMMON</td><td align=\'left\' valign=\'middle\'>CreatureID, Target, Duration in ms</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>13</td><td align=\'center\' valign=\'middle\'>ACTION_T_THREAT_SINGLE_PCT</td><td align=\'left\' valign=\'middle\'>Threat%, Target</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>14</td><td align=\'center\' valign=\'middle\'>ACTION_T_THREAT_ALL_PCT</td><td align=\'left\' valign=\'middle\'>Threat%</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>15</td><td align=\'center\' valign=\'middle\'>ACTION_T_QUEST_EVENT</td><td align=\'left\' valign=\'middle\'>QuestID, Target</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>16</td><td align=\'center\' valign=\'middle\'>ACTION_T_CAST_EVENT</td><td align=\'left\' valign=\'middle\'>QuestID, SpellId, Target - must be removed as hack?</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>17</td><td align=\'center\' valign=\'middle\'>ACTION_T_SET_UNIT_FIELD</td><td align=\'left\' valign=\'middle\'>Field_Number, Value, Target</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>18</td><td align=\'center\' valign=\'middle\'>ACTION_T_SET_UNIT_FLAG</td><td align=\'left\' valign=\'middle\'>Flags (may be more than one field OR’d together), Target</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>19</td><td align=\'center\' valign=\'middle\'>ACTION_T_REMOVE_UNIT_FLAG</td><td align=\'left\' valign=\'middle\'>Flags (may be more than one field OR’d together), Target</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>20</td><td align=\'center\' valign=\'middle\'>ACTION_T_AUTO_ATTACK</td><td align=\'left\' valign=\'middle\'>AllowAttackState (0 = stop attack, anything else means continue attacking)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>21</td><td align=\'center\' valign=\'middle\'>ACTION_T_COMBAT_MOVEMENT</td><td align=\'left\' valign=\'middle\'>AllowCombatMovement (0 = stop combat based movement, anything else continue attacking)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>22</td><td align=\'center\' valign=\'middle\'>ACTION_T_SET_PHASE</td><td align=\'left\' valign=\'middle\'>Phase</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>23</td><td align=\'center\' valign=\'middle\'>ACTION_T_INC_PHASE</td><td align=\'left\' valign=\'middle\'>Value (may be negative to decrement phase, should not be 0)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>24</td><td align=\'center\' valign=\'middle\'>ACTION_T_EVADE</td><td align=\'left\' valign=\'middle\'>No Params</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>25</td><td align=\'center\' valign=\'middle\'>ACTION_T_FLEE_FOR_ASSIST</td><td align=\'left\' valign=\'middle\'>No Params</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>26</td><td align=\'center\' valign=\'middle\'>ACTION_T_QUEST_EVENT_ALL</td><td align=\'left\' valign=\'middle\'>QuestID</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>27</td><td align=\'center\' valign=\'middle\'>ACTION_T_CAST_EVENT_ALL</td><td align=\'left\' valign=\'middle\'>CreatureId, SpellId</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>28</td><td align=\'center\' valign=\'middle\'>ACTION_T_REMOVEAURASFROMSPELL</td><td align=\'left\' valign=\'middle\'>Target, Spellid</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>29</td><td align=\'center\' valign=\'middle\'>ACTION_T_RANGED_MOVEMENT</td><td align=\'left\' valign=\'middle\'>Distance, Angle</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>30</td><td align=\'center\' valign=\'middle\'>ACTION_T_RANDOM_PHASE</td><td align=\'left\' valign=\'middle\'>PhaseId1, PhaseId2, PhaseId3</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>31</td><td align=\'center\' valign=\'middle\'>ACTION_T_RANDOM_PHASE_RANGE</td><td align=\'left\' valign=\'middle\'>PhaseMin, PhaseMax</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>32</td><td align=\'center\' valign=\'middle\'>ACTION_T_SUMMON_ID</td><td align=\'left\' valign=\'middle\'>CreatureId, Target, SpawnId</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>33</td><td align=\'center\' valign=\'middle\'>ACTION_T_KILLED_MONSTER</td><td align=\'left\' valign=\'middle\'>CreatureId, Target</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>34</td><td align=\'center\' valign=\'middle\'>ACTION_T_SET_INST_DATA</td><td align=\'left\' valign=\'middle\'>Field, Data</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>35</td><td align=\'center\' valign=\'middle\'>ACTION_T_SET_INST_DATA64</td><td align=\'left\' valign=\'middle\'>Field, Target</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>36</td><td align=\'center\' valign=\'middle\'>ACTION_T_UPDATE_TEMPLATE</td><td align=\'left\' valign=\'middle\'>Entry, Team</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>37</td><td align=\'center\' valign=\'middle\'>ACTION_T_DIE</td><td align=\'left\' valign=\'middle\'>No Params</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>38</td><td align=\'center\' valign=\'middle\'>ACTION_T_ZONE_COMBAT_PULSE</td><td align=\'left\' valign=\'middle\'>No Params</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>39</td><td align=\'center\' valign=\'middle\'>ACTION_T_CALL_FOR_HELP</td><td align=\'left\' valign=\'middle\'>Radius</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>40</td><td align=\'center\' valign=\'middle\'>ACTION_T_SET_SHEATH</td><td align=\'left\' valign=\'middle\'>Sheath (0-passive,1-melee,2-ranged)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>41</td><td align=\'center\' valign=\'middle\'>ACTION_T_FORCE_DESPAWN</td><td align=\'left\' valign=\'middle\'>Delay (0-instant despawn)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>42</td><td align=\'center\' valign=\'middle\'>ACTION_T_SET_INVINCIBILITY_HP_LEVEL</td><td align=\'left\' valign=\'middle\'>MinHpValue, format(0-flat,1-percent from max health)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>43</td><td align=\'center\' valign=\'middle\'>ACTION_T_MOUNT_TO_ENTRY_OR_MODEL</td><td align=\'left\' valign=\'middle\'>Creature_template entry(param1) OR ModelId (param2) (or 0 for both to unmount)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>44</td><td align=\'center\' valign=\'middle\'>ACTION_T_CHANCED_TEXT</td><td align=\'left\' valign=\'middle\'>Chance to display the text, TextId1, optionally TextId2. If more than just -TextId1 is defined, randomize. Negative values.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>45</td><td align=\'center\' valign=\'middle\'>ACTION_T_THROW_AI_EVENT</td><td align=\'left\' valign=\'middle\'>EventType, Radius, unused</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>46</td><td align=\'center\' valign=\'middle\'>ACTION_T_SET_THROW_MASK</td><td align=\'left\' valign=\'middle\'>EventTypeMask, unused, unused</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>47</td><td align=\'center\' valign=\'middle\'>ACTION_T_SUMMON_UNIQUE</td><td align=\'left\' valign=\'middle\'>CreatureID, Target, SummonID</td></tr>
</table>','Value|Type|<Parameters
0|ACTION_T_NONE|No action 
1|ACTION_T_TEXT|TextId1, optionally -TextId2, optionally -TextId3(if -TextId2 exist). If more than just -TextId1 is defined, randomize. Neg$ 
2|ACTION_T_SET_FACTION|FactionId (or 0 for default) 
3|ACTION_T_MORPH_TO_ENTRY_OR_MODEL|Creature_template entry(param1) OR ModelId (param2) (or 0 for both to demorph) 
4|ACTION_T_SOUND|SoundId 
5|ACTION_T_EMOTE|EmoteId 
6|ACTION_T_RANDOM_SAY|UNUSED 
7|ACTION_T_RANDOM_YELL|UNUSED 
8|ACTION_T_RANDOM_TEXTEMOTE|UNUSED 
9|ACTION_T_RANDOM_SOUND|SoundId1, SoundId2, SoundId3 (-1 in any field means no output if randomed that field) 
10|ACTION_T_RANDOM_EMOTE|EmoteId1, EmoteId2, EmoteId3 (-1 in any field means no output if randomed that field) 
11|ACTION_T_CAST|SpellId, Target, CastFlags 
12|ACTION_T_SUMMON|CreatureID, Target, Duration in ms 
13|ACTION_T_THREAT_SINGLE_PCT|Threat%, Target 
14|ACTION_T_THREAT_ALL_PCT|Threat% 
15|ACTION_T_QUEST_EVENT|QuestID, Target 
16|ACTION_T_CAST_EVENT|QuestID, SpellId, Target - must be removed as hack? 
17|ACTION_T_SET_UNIT_FIELD|Field_Number, Value, Target 
18|ACTION_T_SET_UNIT_FLAG|Flags (may be more than one field OR’d together), Target 
19|ACTION_T_REMOVE_UNIT_FLAG|Flags (may be more than one field OR’d together), Target 
20|ACTION_T_AUTO_ATTACK|AllowAttackState (0 = stop attack, anything else means continue attacking) 
21|ACTION_T_COMBAT_MOVEMENT|AllowCombatMovement (0 = stop combat based movement, anything else continue attacking) 
22|ACTION_T_SET_PHASE|Phase 
23|ACTION_T_INC_PHASE|Value (may be negative to decrement phase, should not be 0) 
24|ACTION_T_EVADE|No Params 
25|ACTION_T_FLEE_FOR_ASSIST|No Params 
26|ACTION_T_QUEST_EVENT_ALL|QuestID 
27|ACTION_T_CAST_EVENT_ALL|CreatureId, SpellId 
28|ACTION_T_REMOVEAURASFROMSPELL|Target, Spellid 
29|ACTION_T_RANGED_MOVEMENT|Distance, Angle 
30|ACTION_T_RANDOM_PHASE|PhaseId1, PhaseId2, PhaseId3 
31|ACTION_T_RANDOM_PHASE_RANGE|PhaseMin, PhaseMax 
32|ACTION_T_SUMMON_ID|CreatureId, Target, SpawnId 
33|ACTION_T_KILLED_MONSTER|CreatureId, Target 
34|ACTION_T_SET_INST_DATA|Field, Data 
35|ACTION_T_SET_INST_DATA64|Field, Target 
36|ACTION_T_UPDATE_TEMPLATE|Entry, Team 
37|ACTION_T_DIE|No Params 
38|ACTION_T_ZONE_COMBAT_PULSE|No Params 
39|ACTION_T_CALL_FOR_HELP|Radius 
40|ACTION_T_SET_SHEATH|Sheath (0-passive,1-melee,2-ranged) 
41|ACTION_T_FORCE_DESPAWN|Delay (0-instant despawn) 
42|ACTION_T_SET_INVINCIBILITY_HP_LEVEL|MinHpValue, format(0-flat,1-percent from max health) 
43|ACTION_T_MOUNT_TO_ENTRY_OR_MODEL|Creature_template entry(param1) OR ModelId (param2) (or 0 for both to unmount) 
44|ACTION_T_CHANCED_TEXT|Chance to display the text, TextId1, optionally TextId2. If more than just -TextId1 is defined, randomize. Negative values. 
45|ACTION_T_THROW_AI_EVENT|EventType, Radius, unused 
46|ACTION_T_SET_THROW_MASK|EventTypeMask, unused, unused 
47|ACTION_T_SUMMON_UNIQUE|CreatureID, Target, SummonID');
delete from `dbdocssubtables` where `subtableId`= 111 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (111,0,'Item Required Target type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>Value</b></th>
<th align=\'left\'><b>Description</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Game object</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Creature template</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Dead creature template</td></tr>
</table>
','Value|<Description
0|Game object
1|Creature template
2|Dead creature template');


-- dbocsfields
-- -- -- -- --
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '485' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '484' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '483' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Command parameter, see command description.', `fieldNotes` = 'Currently these fields are only used as text identifiers for the SCRIPT_COMMAND_TALK and SCRIPT_COMMAND_TERMINATE_SCRIPT commands.' where `fieldId`= '482' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The total number of copies of an item or may reference another loot template', `fieldNotes` = 'Depending on the value of the field it may either define the minimum number of copies for the item to be dropped, or it may reference another loot template.' where `fieldId`= '501' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The total number of copies of an item or may reference another loot template', `fieldNotes` = 'Depending on the value of the field it may either define the minimum number of copies for the item to be dropped, or it may reference another loot template.' where `fieldId`= '510' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The orientation of the game object.', `fieldNotes` = 'The object\'s orientation in the game world, where north is 0 and south is 3.14159.' where `fieldId`= '563' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The amount of rotation of an object along one of the axis.', `fieldNotes` = 'The amount of rotation of an object along one of the axis in the game world.' where `fieldId`= '567' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The amount of rotation of an object along one of the axis.', `fieldNotes` = 'The amount of rotation of an object along one of the axis in the game world.' where `fieldId`= '568' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The amount of rotation of an object along one of the axis.', `fieldNotes` = 'The amount of rotation of an object along one of the axis in the game world.' where `fieldId`= '569' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The amount of rotation of an object along one of the axis.', `fieldNotes` = 'The amount of rotation of an object along one of the axis in the game world.' where `fieldId`= '570' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references the “gameobject” table\'s  unique ID.', `fieldNotes` = 'This references the “gameobject” table\'s unique ID for which the entry is valid.' where `fieldId`= '575' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The identifier for the event node in the battleground. ', `fieldNotes` = 'The identifier for the event node in the battleground. Event nodes usually are defined in the battleground’s script.<br /><br />Nodes are locations in a battleground where characters of each faction can perform actions, such as capturing a tower in Alterac Valley, or taking control over the stables in Arathi Basin.' where `fieldId`= '573' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The state of the event node. ', `fieldNotes` = 'The state of the event node. Node status is defined differently in every battleground script.<br /><br />Node events can occur for every node and usually describe changes due to character interaction. E.g. if stables in Arathi Basin are taken over by Alliance, the stables note state would become Alliance controlled. Similar node states exist for every battleground note.' where `fieldId`= '574' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The total number of copies of an item or may reference another loot template', `fieldNotes` = 'Depending on the value of the field it may either define the minimum number of copies for the item to be dropped, or it may reference another loot template.' where `fieldId`= '584' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'DEPRECATED: Defines money looted from the game object.', `fieldNotes` = 'DEPRECATED: Defines money looted from the game object.' where `fieldId`= '616' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'DEPRECATED: Defines money looted from the game object.', `fieldNotes` = 'DEPRECATED: Defines money looted from the game object.' where `fieldId`= '615' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'A zone identifier', `fieldNotes` = 'A zone identifier. The value has to match with a zone identifier defined in AreaTable.dbc.' where `fieldId`= '558' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for snow in the Spring.', `fieldNotes` = 'Percentage chance for snow in the Spring.' where `fieldId`= '550' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for rain in the Spring.', `fieldNotes` = 'Percentage chance for rain in the Spring.' where `fieldId`= '549' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for a sand storm in the Spring.', `fieldNotes` = 'Percentage chance for a sand storm in the Spring.' where `fieldId`= '551' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for rain in the Summer.', `fieldNotes` = 'Percentage chance for rain in the Summer.' where `fieldId`= '552' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for snow in the Summer.', `fieldNotes` = 'Percentage chance for snow in the Summer.' where `fieldId`= '553' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for a sand storm in the Summer.', `fieldNotes` = 'Percentage chance for a sand storm in the Summer.' where `fieldId`= '554' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for rain in the Fall.', `fieldNotes` = 'Percentage chance for rain in the Fall.' where `fieldId`= '546' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for snow in the Fall.', `fieldNotes` = 'Percentage chance for snow in the Fall.' where `fieldId`= '547' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for storm in the Fall.', `fieldNotes` = 'Percentage chance for storm in the Fall.' where `fieldId`= '548' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for rain in the Winter.', `fieldNotes` = 'Percentage chance for rain in the Winter.' where `fieldId`= '555' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for snow in the Winter.', `fieldNotes` = 'Percentage chance for snow in the Winter.' where `fieldId`= '556' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Percentage chance for storm in the Winter.', `fieldNotes` = 'Percentage chance for storm in the Winter.' where `fieldId`= '557' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The total number of copies of an item or may reference another loot template', `fieldNotes` = 'Depending on the value of the field it may either define the minimum number of copies for the item to be dropped, or it may reference another loot template.' where `fieldId`= '668' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This references the “item_template” table tables unique ID.', `fieldNotes` = 'This references the “item_template” table tables unique ID.' where `fieldId`= '669' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'zzzz', `fieldNotes` = 'Describes which type of target the spell requires. The following table shows all valid target types.<br />¬subtable:111¬' where `fieldId`= '671' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Describes which type of target the spell requires.', `fieldNotes` = 'Describes which type of target the spell requires. The following table shows all valid target types.<br />¬subtable:111¬' where `fieldId`= '671' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The maximum amount of copies of the item that a character may have.', `fieldNotes` = 'The maximum amount of copies of the item that a character may have. Setting this to 0 will allow an infinite amount.' where `fieldId`= '719' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = '', `fieldNotes` = '' where `fieldId`= '729' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'This references the “creature_template” table tables unique ID for which the entry is valid.' where `fieldId`= '800' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of name in the “creature_template” table table.', `fieldNotes` = 'Korean localization of name in the “creature_template” table table.' where `fieldId`= '801' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of name in the “creature_template” table table.', `fieldNotes` = 'French localization of name in the “creature_template” table table.' where `fieldId`= '802' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of name in the “creature_template” table table.', `fieldNotes` = 'German localization of name in the “creature_template” table table.' where `fieldId`= '803' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of name in the “creature_template” table table.', `fieldNotes` = 'Chinese localization of name in the “creature_template” table table.' where `fieldId`= '804' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of name in the “creature_template” table table.', `fieldNotes` = 'Taiwanese localization of name in the “creature_template” table table.' where `fieldId`= '805' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of name in the “creature_template” table table.', `fieldNotes` = 'Spanish Spain localization of name in the “creature_template” table table.' where `fieldId`= '806' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of name.', `fieldNotes` = 'Spanish Latin America localization of name in the “creature_template” table table.' where `fieldId`= '807' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of name in the “creature_template” table table.', `fieldNotes` = 'Russian localization of name in the “creature_template” table table.' where `fieldId`= '808' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of subname in the “creature_template” table table.', `fieldNotes` = 'Korean localization of subname in the “creature_template” table table.' where `fieldId`= '809' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of subname in the “creature_template” table table.', `fieldNotes` = 'French localization of subname in the “creature_template” table table.' where `fieldId`= '810' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of subname in the “creature_template” table table.', `fieldNotes` = 'German localization of subname in the “creature_template” table table.' where `fieldId`= '811' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of subname in the “creature_template” table table.', `fieldNotes` = 'Chinese localization of subname in the “creature_template” table table.' where `fieldId`= '812' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of subname in the “creature_template” table table.', `fieldNotes` = 'Taiwanese localization of subname in the “creature_template” table table.' where `fieldId`= '813' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of subname in the “creature_template” table table.', `fieldNotes` = 'Spanish Spain localization of subname in the “creature_template” table table.' where `fieldId`= '814' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of subname.', `fieldNotes` = 'Spanish Latin America localization of subname in the “creature_template” table table.' where `fieldId`= '815' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of subname in the “creature_template” table table.', `fieldNotes` = 'Russian localization of subname in the “creature_template” table table.' where `fieldId`= '816' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Gameobject ID (See gameobject_template.entry).', `fieldNotes` = 'This references the “gameobject_template” table tables unique ID for which the entry is valid.' where `fieldId`= '817' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of name in the “gameobject_template” table table.', `fieldNotes` = 'Korean localization of name in the “gameobject_template” table table.' where `fieldId`= '818' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of name in the “gameobject_template” table table.', `fieldNotes` = 'French localization of name in the “gameobject_template” table table.' where `fieldId`= '819' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of name in the “gameobject_template” table table.', `fieldNotes` = 'German localization of name in the “gameobject_template” table table.' where `fieldId`= '820' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of name in the “gameobject_template” table table.', `fieldNotes` = 'Chinese localization of name in the “gameobject_template” table table.' where `fieldId`= '821' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of name in the “gameobject_template” table table.', `fieldNotes` = 'Taiwanese localization of name in the “gameobject_template” table table.' where `fieldId`= '822' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of name in the “gameobject_template” table table.', `fieldNotes` = 'Spanish Spain localization of name in the “gameobject_template” table table.' where `fieldId`= '823' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of name.', `fieldNotes` = 'Spanish Latin America localization of name in the “gameobject_template” table table.' where `fieldId`= '824' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of name in the “gameobject_template” table table.', `fieldNotes` = 'Russian localization of name in the “gameobject_template” table table.' where `fieldId`= '825' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to gossip_menu_option.menu_id.', `fieldNotes` = 'This references the “gossip_menu_option” table tables menu_id for which the entry is valid.' where `fieldId`= '835' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of option_text in the “gossip_menu_option” table table.', `fieldNotes` = 'Korean localization of option_text in the “gossip_menu_option” table table.' where `fieldId`= '836' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of option_text in the “gossip_menu_option” table table.', `fieldNotes` = 'French localization of option_text in the “gossip_menu_option” table table.' where `fieldId`= '837' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of option_text in the “gossip_menu_option” table table.', `fieldNotes` = 'German localization of option_text in the “gossip_menu_option” table table.' where `fieldId`= '838' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of option_text in the “gossip_menu_option” table table.', `fieldNotes` = 'Chinese localization of option_text in the “gossip_menu_option” table table.' where `fieldId`= '839' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of option_text in the “gossip_menu_option” table table.', `fieldNotes` = 'Taiwanese localization of option_text in the “gossip_menu_option” table table.' where `fieldId`= '840' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of option_text.', `fieldNotes` = 'Spanish Spain localization of option_text in the “gossip_menu_option” table table.' where `fieldId`= '841' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of option_text.', `fieldNotes` = 'Spanish Latin America localization of option_text in the “gossip_menu_option” table table.' where `fieldId`= '842' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of option_text in the “gossip_menu_option” table table.', `fieldNotes` = 'Russian localization of option_text in the “gossip_menu_option” table table.' where `fieldId`= '843' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of box_text in the “gossip_menu_option” table table.', `fieldNotes` = 'Korean localization of box_text in the “gossip_menu_option” table table.' where `fieldId`= '826' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of box_text in the “gossip_menu_option” table table.', `fieldNotes` = 'French localization of box_text in the “gossip_menu_option” table table.' where `fieldId`= '827' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of box_text in the “gossip_menu_option” table table.', `fieldNotes` = 'German localization of box_text in the “gossip_menu_option” table table.' where `fieldId`= '828' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of box_text in the “gossip_menu_option” table table.', `fieldNotes` = 'Chinese localization of box_text in the “gossip_menu_option” table table.' where `fieldId`= '829' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of box_text in the “gossip_menu_option” table table.', `fieldNotes` = 'Taiwanese localization of box_text in the “gossip_menu_option” table table.' where `fieldId`= '830' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of box_text in the “gossip_menu_option” table table.', `fieldNotes` = 'Spanish Spain localization of box_text in the “gossip_menu_option” table table.' where `fieldId`= '831' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of box_text.', `fieldNotes` = 'Spanish Latin America localization of box_text in the “gossip_menu_option” table table.' where `fieldId`= '832' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of box_text in the “gossip_menu_option” table table.', `fieldNotes` = 'Russian localization of box_text in the “gossip_menu_option” table table.' where `fieldId`= '833' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item ID (See item_template.entry).', `fieldNotes` = 'This references the “item_template” table tables unique ID for which the entry is valid.' where `fieldId`= '852' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of name in the “item_template” table table.', `fieldNotes` = 'Korean localization of name in the “item_template” table table.' where `fieldId`= '853' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of name in the “item_template” table table.', `fieldNotes` = 'French localization of name in the “item_template” table table.' where `fieldId`= '854' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of name in the “item_template” table table.', `fieldNotes` = 'German localization of name in the “item_template” table table.' where `fieldId`= '855' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of name in the “item_template” table table.', `fieldNotes` = 'Chinese localization of name in the “item_template” table table.' where `fieldId`= '856' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of name in the “item_template” table table.', `fieldNotes` = 'Taiwanese localization of name in the “item_template” table table.' where `fieldId`= '857' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of name in the “item_template” table table.', `fieldNotes` = 'Spanish Spain localization of name in the “item_template” table table.' where `fieldId`= '858' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of name in the “item_template” table table.', `fieldNotes` = 'Spanish Latin America localization of name in the “item_template” table table.' where `fieldId`= '859' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of name in the “item_template” table table.', `fieldNotes` = 'Russian localization of name in the “item_template” table table.' where `fieldId`= '860' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Korean localization of description in the “item_template” table table.', `fieldNotes` = 'Korean localization of description in the “item_template” table table.' where `fieldId`= '844' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'French localization of description in the “item_template” table table.', `fieldNotes` = 'French localization of description in the “item_template” table table.' where `fieldId`= '845' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'German localization of description in the “item_template” table table.', `fieldNotes` = 'German localization of description in the “item_template” table table.' where `fieldId`= '846' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chinese localization of description in the “item_template” table table.', `fieldNotes` = 'Chinese localization of description in the “item_template” table table.' where `fieldId`= '847' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Taiwanese localization of description in the “item_template” table table.', `fieldNotes` = 'Taiwanese localization of description in the “item_template” table table.' where `fieldId`= '848' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Spain localization of description in the “item_template” table table.', `fieldNotes` = 'Spanish Spain localization of description in the “item_template” table table.' where `fieldId`= '849' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spanish Latin America localization of description.', `fieldNotes` = 'Spanish Latin America localization of description in the “item_template” table table.' where `fieldId`= '850' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Russian localization of description in the “item_template” table table.', `fieldNotes` = 'Russian localization of description in the “item_template” table table.' where `fieldId`= '851' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to npc_text.ID.', `fieldNotes` = 'The unique identifier of the text entry. Please note that the identifier is acquired from the game client by parsing the local WDB cache files.<br /><br />It is unknown if text identifiers required a specific identifier to work.' where `fieldId`= '861' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '862' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '863' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '864' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '865' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '869' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '868' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '867' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '866' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '870' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '871' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '877' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '876' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '875' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '874' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '873' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '872' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '879' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '880' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '885' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '884' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '883' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '882' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '881' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '886' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '887' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '888' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '893' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '892' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '891' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '890' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '889' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '894' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '895' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '896' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '897' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '900' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '899' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '898' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '901' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '902' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '903' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '904' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '909' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '908' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '907' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '906' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '905' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '910' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '911' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '912' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '913' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '914' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '915' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '916' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '917' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '926' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '927' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '928' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '929' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '930' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '931' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '932' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '933' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '942' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '944' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '945' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '946' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '947' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '948' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '949' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '958' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '959' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '960' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '961' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '962' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'zzzz' where `fieldId`= '963' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '963' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '964' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '965' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '974' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '975' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '976' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '977' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '978' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '979' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '980' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is male.', `fieldNotes` = 'This is the locale text that is displayed if the creature is male.' where `fieldId`= '981' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '918' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '919' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '920' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '921' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '922' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '923' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '924' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '925' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '934' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '935' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '936' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '937' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '938' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '939' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '940' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '941' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '950' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '951' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '952' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '953' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '954' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '955' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '956' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '957' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '966' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '967' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '968' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '969' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '970' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'zzzz' where `fieldId`= '971' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '971' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'zzzz' where `fieldId`= '972' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '972' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '973' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '982' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '983' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.z' where `fieldId`= '984' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '984' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '985' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '986' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '987' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '988' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This is the locale text that is displayed if the creature is female.', `fieldNotes` = 'This is the locale text that is displayed if the creature is female.' where `fieldId`= '989' and `languageId`= 0;



        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL ABOVE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

        -- If we get here ok, commit the changes
        IF bRollback = TRUE THEN
            ROLLBACK;
            SHOW ERRORS;
            SELECT '* UPDATE FAILED *' AS `===== Status =====`,@cCurResult AS `===== DB is on Version: =====`;



        ELSE
            COMMIT;
            SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,@cNewResult AS `===== DB is now on Version =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cCurResult AS `===== DB is already on Version =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
                SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurResult AS `===== Found Version =====`;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;