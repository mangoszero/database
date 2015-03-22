INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_14';

-- Blacksmith Specialisations - Swordmith, Axesmith, Hammersmith

-- We need to change Lilith's quest to the old one:
-- change from 8869 to 5305 (they are the same, but 5305 is required as we need to make use of the ExclusiveGroup field)
UPDATE creature_involvedrelation SET quest=5305 WHERE id=11191 and quest=8869;
UPDATE creature_questrelation SET quest=5305 WHERE id=11191 and quest=8869;
-- Exculsive group field: only must of the quests must be completed, no more

-- Remove script from NPCs
-- the script is not required in Vanilla (the entire profession is unlearnt
-- STILL TO TEST: *** quests may need to be removed when profession is unlearnt, so that they can be acquired again ***
-- remove scripts form Blacksmithing NPCs
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_prof_blacksmith' AND Entry IN (11191, 11192, 11193, 5164, 11145, 11146, 11176, 11177, 11178);
-- remove scripts form Leatherworking NPCs
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_prof_leather' AND Entry IN (7870, 7871, 7868, 7869, 7867, 7866);

-- OnQuestComplete cast learn Hammermith specialisation
UPDATE quest_template SET ExclusiveGroup=5305, RewSpellCast=17044 WHERE entry=5305;

-- OnQuestComplete cast learn Axesmith specialisation
UPDATE quest_template SET ExclusiveGroup=5305, RewSpellCast=17043 WHERE entry=5306;

-- OnQuestComplete cast learn Swordsmith specialisation
UPDATE quest_template SET ExclusiveGroup=5305, RewSpellCast=17042 WHERE entry=5307;

