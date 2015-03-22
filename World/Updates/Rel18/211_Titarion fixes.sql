/*
Full Changelog, please credit Titarion. This file contains the following:


Quests

- Fixed an issue wherein 'Panther Mastery' would display an incorrect in-progress message.
- Fixed an issue wherein 'Report to General Kirika' would be available at level 53.
- Fixed an issue wherein the Horde version of 'Theramore Guard Badge' would be available to Alliance players.
- Fixed an issue wherein 'Cryptstalker Armor Doesn't Make Itself...' would be available for players that would not meet the minimum requirements.
- Fixed an issue wherein 'Bonescythe Digs' would be available for players that would not meet the minimum requirements.
- Fixed an issue wherein 'The Elemental Equation' would be available for players that would not meet the minimum requirements.
- Fixed an issue wherein 'Binding the Dreadnaught' would be available for players that would not meet the minimum requirements.
- Fixed an issue wherein 'Savage Fronds' would be available for players that would not meet the minimum requirements.
- Fixed an issue wherein 'The Fate of Ramaladni' would be available for players that have not completed 'Echoes of War'.
- Fixed several issues with 'Children's Week'.
- Fixed an issue wherein 'Wandering Shay' would not be available at level 44 or be accepted by Alliance players.
- Fixed an issue wherein 'A Matter of Time' could not be completed.
- Fixed a minor typo in the Quest 'Blood Tinged Skies '.


Creatures/NPCs

- Argent Sentries, Argent Riders and Cenarion Hold Infantry have been updated and will now properly react in certain situations.
- Fenros now has its correct loot table.
- Gadgetzan Bruisers will now display their correct gossip.
- Mupsi Shacklefridd will now display her correct gossip.
- Battleground Masters will now display their correct gossip.
- Removed invalid gossip from Booty Bay Bruisers.
- Vol'jin has been scripted.
- Jaina's basic script has been implemented.
- Thrall's basic script has been implemented.
- High Overlord Saurfang is now scripted.
- Duggan Wildhammer is now longer part of the Ravenholdt Faction and will now be functional in combat.
- Scholomance Students will now display their proper gossip and will no longer drop loot.
- Lord Alexei Barov will now always be level 60.

GameObjects/Containers/Items

- Decoded True Believer Clippings will now contain the proper Darkrune Recipes amongst other Recipes.
- Fixed an issue wherein the container 'Curmudgeon's Payoff' would not give the player 5g upon opening it.
- Fixed an issue wherein Invisibility Potions would trigger a 10min. CD on pots of that same category.
*/
-- ===================================
-- Fixed an issue wherein 'Panther Mastery' would display an incorrect in-progress message. 
-- ===================================

-- Sir S. J. Erlgadin.
UPDATE `quest_template` SET `RequestItemsText`='Those big boys are tougher.  They\'re not as easy as the young ones you were killing earlier.' WHERE `entry`=191;

-- ===================================
-- Fixed an issue wherein 'Report to General Kirika' would be available at level 53.
-- ===================================

UPDATE `quest_template` SET `MinLevel`=54 WHERE `entry`=9416;


-- correct MinLevel.
UPDATE `quest_template` SET `MinLevel`=30 WHERE `entry`=1252;


-- ===================================
-- Fixed an issue wherein T3 pre-reqs. would be available for players that would not meet the minimum requirements.
-- ===================================

-- Friendly
UPDATE `quest_template` SET `RequiredMinRepFaction`=529, `RequiredMinRepValue`=3000 WHERE `entry` IN (9124,9126,9128,9131,9136);
-- Honored
UPDATE `quest_template` SET `RequiredMinRepFaction`=529, `RequiredMinRepValue`=3000 WHERE `entry` IN (9125,9127,9129,9132,9137);

-- ===================================
-- Fixed an issue wherein 'The Fate of Ramaladni' would be available for players that have not completed 'Echoes of War'.
-- ===================================

-- Make sure the player completes the proper requirements before being prompted to the next quest
UPDATE `quest_template` SET `PrevQuestId`=9033 WHERE `entry`=9229;

-- ===================================
-- Fixed several issues with 'Children's Week'
-- ===================================

-- Set correct MinLevel
UPDATE `quest_template` SET `MinLevel`=10 WHERE `entry` IN (1468,1479,1558,1687,558,4822,171,172,910,911,1800,915,925,5502);

-- Set correct NPC
UPDATE `creature_questrelation` SET `id`=14305 WHERE `quest`=171;

-- TrinityCore @author w1sht0l1v3)
-- Human Orphan quest order
UPDATE `quest_template` SET `prevquestid`=1468,`exclusivegroup`=-1479 WHERE `entry` IN (1479,1558,1687);
UPDATE `quest_template` SET `prevquestid`=1479,`exclusivegroup`=-558 WHERE `entry` IN (558,4822);
UPDATE `quest_template` SET `prevquestid`=558,`exclusivegroup`=0 WHERE `entry`=171;

-- Orcish Orphan quest order
UPDATE `quest_template` SET `prevquestid`=172,`exclusivegroup`=-910 WHERE `entry` IN (910,911,1800);
UPDATE `quest_template` SET `prevquestid`=910,`exclusivegroup`=-915 WHERE `entry` IN (915,925);
UPDATE `quest_template` SET `prevquestid`=915,`exclusivegroup`=0 WHERE `entry`=5502;

-- ===================================
-- Fixed an issue wherein 'Wandering Shay' would not be available at level 44 or be accepted by Alliance players.
-- ===================================

-- This quest is available at level 44, not 45.
UPDATE `quest_template` SET `MinLevel`=44 WHERE `entry`=2845;
-- Set to Alliance Only.
UPDATE `quest_template` SET `RequiredRaces`=77 WHERE `entry`=2845;

-- ===================================
-- Fixed an issue wherein 'A Matter of Time' could not be completed.
-- ===================================

-- Update the entire quest.

REPLACE INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewOrReqMoney`, `RewMoneyMaxLevel`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`) VALUES (4971, 2, 28, 53, 56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12627, 1, 0, 'A Matter of Time', 'Tampering of the timeline by a sinister force - most likely the Scourge - has occurred in Andorhal! I can try to keep the passage of time here intact and mend what has been damaged, but I\'ll need your help to do so uninterrupted.$B$BTemporal parasites - carrion that feed on the strands of time\'s altered flow - now infest the silos of Andorhal. A blue pulse of distortion is their only visual marker. They slow my auguries; please $N, help me by using this temporal displacer to root out these parasites.', 'Use the Temporal Displacer near one of Andorhal\'s silos and uncover Temporal Parasites.$B$BSlay 10 Temporal Parasites, and then return the Temporal Displacer to Chromie in the Andorhal Inn, Western Plaguelands.', 'Time feels easier to mend now, thank you $N. While you might not understand fully the consequences of a fractured timeline, I appreciate that you understand the urgency of countering what I suspect more and more to be a Scourge-driven malfeasance.$B$BI see no harm in rewarding you for your assistance, mortal. Your greatest feats are to come, and the awarding of a bauble will certainly not alter your future destiny. Your continued aid, however, is something that I and the dragonflight could use...', 'Temporal parasites are a common malady present wherever the flow of time has been tampered with. I sense that many are present, and this is disturbing.$B$BRooting out whatever ones you can find will help me be able to take a better hold on the deteriorating temporal situation here. I will be able to sense when this has been achieved.', '', '', '', '', '', 12627, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10717, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 15812, 15813, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5100, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Correct the max level of Temporal Parasite.
UPDATE `creature_template` SET `maxlevel`=56 WHERE `entry`=10717;
-- Give them Mana Points so they can use their spell.
UPDATE `creature_template` SET `minmana`=2117, `maxmana`= 2163 WHERE `entry`=10717;


-- ===================================
-- Fixed an issue wherein 'Gnome/Goblin Engineering' would be offered to the wrong faction.
-- ===================================

-- All of the Gnome and Goblin quests are available at level 30. Be aware that in order to pickup these quests your Engineering skill must be level 225 or higher.
UPDATE `quest_template` SET `MinLevel`=30 WHERE `entry` IN (3630,3632,3634,3635,3637,3526,3629,3633,4181);

-- Gnome Engineer series.
-- Alliance quests are for Alliance only.
UPDATE `quest_template` SET `RequiredRaces`=77 WHERE `entry` IN (3630,3632,3634);
-- Horde quests are for Horde only.
UPDATE `quest_template` SET `RequiredRaces`=178 WHERE `entry` IN (3635,3637);

-- Goblin Engineer series.
-- Alliance quests are for Alliance only.
UPDATE `quest_template` SET `RequiredRaces`=77 WHERE `entry` IN (3629,4181);
-- Horde quest is for Horde only.
UPDATE `quest_template` SET `RequiredRaces`=178 WHERE `entry`=3526; 

-- ===================================
-- Argent Sentries, Argent Riders and Cenarion Hold Infantry have been updated and will now properly react in certain situations.
-- ===================================

-- Miscellaneous updates to the NPCs.
DELETE FROM `creature_addon` WHERE `guid` IN (53857,68543,42766);
DELETE FROM `creature_template_addon` WHERE `entry` IN (16378,11102,15184);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`b2_0_sheath`,`emote`,`moveflags`,`auras`) VALUES 
(16378,0,0,1,0,0,18950),(11102,2402,0,1,0,0,18950),(15184,0,0,1,0,0,18950);

UPDATE `creature` SET `curhealth`=9763 WHERE `id` IN (16378,11102,15184);
UPDATE `creature_template` SET `minhealth`=9763, `maxhealth`=9763 WHERE `entry` IN (16378,11102,15184);
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60 WHERE `entry` IN (16378,11102,15184);
UPDATE `creature_template` SET `armor`= 5892 WHERE `entry` IN (16378,11102,15184);
UPDATE `creature_template` SET `rank`=1 WHERE `entry` IN (16378,11102,15184);
UPDATE `creature_template` SET `mindmg`=605, `maxdmg`=665 WHERE `entry` IN (16378,11102,15184);
UPDATE `creature_template` SET `attackpower`=293 WHERE `entry`IN (16378,11102,15184);
UPDATE `creature_template` SET `baseattacktime`=1175 WHERE `entry`IN (16378,11102,15184);
UPDATE `creature_template` SET `minrangedmg`=301.34, `maxrangedmg`=422.17 WHERE `entry`IN (16378,11102,15184);
UPDATE `creature_template` SET `speed_run`=2.28571 WHERE `entry` IN (16378,11102,15184);
UPDATE `creature_template` SET `unit_flags`=36864 WHERE `entry` IN (16378,15184);
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry` IN (16378,11102,15184);
UPDATE `creature_template` SET `mechanic_immune_mask`=650854239 WHERE `entry` IN (16378,11102,15184);
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry` IN (16378,11102,15184);
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN (16378,15184);
-- Argent Riders should only react to spells.
UPDATE `creature_template` SET `AIName`='ReactorAI' WHERE `entry`=11102;
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=11102;


-- Spells and Abilities

-- We have to clear all of our entires first.
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=16378;
DELETE FROM `creature_ai_scripts` WHERE `id` IN (1637801,1637802,1637803,1637804,1637805,1720902);
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=15184;
DELETE FROM `creature_ai_scripts` WHERE `id` IN (1720904,1720905,1720906,1720902);
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=11102;
DELETE FROM `creature_ai_scripts` WHERE `id`=1720903;

-- Argent Sentry
INSERT INTO `creature_ai_scripts` VALUES 
(1637801,16378,4,0,100,0,0,0,0,0,11,25821,1,0,0,0,0,0,0,0,0,0,'Argent Sentry - Cast Charge on Aggro'),
(1637802,16378,0,0,100,1,4000,6000,7000,9000,11,19643,1,1,40,1,0,0,0,0,0,0,'Argent Sentry - Cast Mortal Strike and Set Melee Weapon Model'),
(1637803,16378,0,0,100,1,1000,3000,9000,12000,11,18328,0,0,0,0,0,0,0,0,0,0,'Argent Sentry - Cast Incapacitating Shout'),
(1637804,16378,9,0,100,1,0,5,8000,14000,11,15618,1,1,0,0,0,0,0,0,0,0,'Argent Sentry - Cast Snap Kick'),
(1637805,16378,9,0,100,1,20,45,2300,3900,11,23337,1,0,40,2,0,0,0,0,0,0,'Argent Sentry - Cast Shoot and Set Ranged Weapon Model'),
(1720902,16378,4,0,100,0,0,0,0,0,1,-1156,-1157,-1158,0,0,0,0,0,0,0,0,'Argent Sentry - Random Say on Aggro');

-- Cenarion Hold Infantry
INSERT INTO `creature_ai_scripts` VALUES
(1720904,15184,4,0,100,0,0,0,0,0,1,-1156,-1157,-1158,0,0,0,0,0,0,0,0,'Cenarion Hold Infantry - Random Say on Aggro'),
(1720905,15184,9,0,100,1,0,5,8000,14000,11,15618,1,1,0,0,0,0,0,0,0,0,'Cenarion Hold Infantry - Cast Snap Kick'),
(1720906,15184,0,0,100,1,1000,3000,9000,12000,11,18328,0,0,0,0,0,0,0,0,0,0,'Cenarion Hold Infantry - Cast Incapacitating Shout'),
(1720907,15184,0,0,100,1,4000,6000,7000,9000,11,19643,1,1,40,1,0,0,0,0,0,0,'Cenarion Hold Infantry - Cast Mortal Strike and Set Melee Weapon Model');

-- Argent Rider
INSERT INTO `creature_ai_scripts` VALUES
(1720903,11102,4,0,100,0,0,0,0,0,1,-1156,-1157,-1158,0,0,0,0,0,0,0,0,'Argent Rider - Random Say on Aggro');

-- Texts, etc..
-- Argent Sentries/Argent Riders and Cenarion Hold Infantry will now say their correct text upon aggro. Removed data from script_text and move it to creature_ai_texts.
-- Remove data from script_texts and create new data in creature_ai_texts.
-- DELETE FROM `script_texts` WHERE `entry` IN (-1000198,-1000199,-10001200);

DELETE FROM `creature_ai_texts` WHERE `entry` IN (-1156,-1157,-1158);
INSERT INTO `creature_ai_texts` VALUES 
(-1156,'Taste blade, mongrel!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Argent Sentry, Argent Rider, Cenarion Hold Infantry - Random Say on Aggro'),
(-1157,'Please tell me that you didn\'t just do what I think you just did. Please tell me that I\'m not going to have to hurt you...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Argent Sentry, Argent Rider, Cenarion Hold Infantry - Random Say on Aggro'),
(-1158,'As if we don\'t have enough problems, you go and create more!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Argent Sentry, Argent Rider, Cenarion Hold Infantry - Random Say on Aggro');



-- ===================================
-- Fenros now has its correct loot table.
-- ===================================

-- Remove obsolete TBC Data.
DELETE FROM `creature_loot_template` WHERE `entry`=507 AND `item` IN (24047,24048,24050,24052,24058);

-- Tribal Worg Helm (33% chance to drop)
REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 6204, 33, 0, 1, 1, 0);

 -- Ravenwood Bow (66% chance to drop)
REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 4474, 66, 0, 1, 1, 0);

-- Double Mail coif (1.7 chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 8748, 1.7, 0, 1, 1, 0); 

-- Durable Boots (1.1 chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 9820, 1.1, 0, 1, 1, 0); 

-- An Old History Book (0.5% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 2794, 0.5, 0, 1, 1, 0);

-- Interlaced Cowl (0.3% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 8746, 0.3, 0, 1, 1, 0); 

 -- Taut Compound Bow (0.3% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3778, 0.3, 0, 1, 1, 0);

-- Hardened Leather Boots (0.2% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3801, 0.2, 0, 1, 1, 0); 

-- Keen Axe (0.2% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3785, 0.2, 0, 1, 1, 0); 

-- Archer's Longbow (0.17% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 15285, 0.17, 0, 1, 1, 0); 

-- Emblazoned Leggings (0.17% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 4050, 0.17, 0, 1, 1, 0); 

-- Scroll of Protection II (0.17% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 1478, 0.17, 0, 1, 1, 0); 

-- Hardened Leather Helm (0.17% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 8747, 0.17, 0, 1, 1, 0); 

-- Hefty War Axe (0.17% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3779, 0.17, 0, 1, 1, 0); 

-- Large war Club (0.17% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3782, 0.17, 0, 1, 1, 0);

 -- Light Scimitar (0.17% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3783, 0.17, 0, 1, 1, 0);

-- Reinforced Buckler (0.17% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3817, 0.17, 0, 1, 1, 0); 

-- Shiny Dirk (0.17% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3786, 0.17, 0, 1, 1, 0);

-- Leaden Mace (0.13% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 865, 0.13, 0, 1, 1, 0); 

-- Broad claymore (0.13% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3781, 0.13, 0, 1, 1, 0); 

-- Hardened Leather Tunic (0.13% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3807, 0.13, 0, 1, 1, 0); 

-- Interlaced Cloak (0.13% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3795, 0.13, 0, 1, 1, 0);

-- Long-barreled Musket (0.13% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3780, 0.13, 0, 1, 1, 0); 

-- Stone Club (0.13% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3787, 0.13, 0, 1, 1, 0); 

 -- Glimmering Flamberge (0.09% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 15250, 0.09, 0, 1, 1, 0);

-- Greenstone Talisman (0.09% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 12029, 0.09, 0, 1, 1, 0); 

-- Double-stitched Cloak (0.09% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3811, 0.09, 0, 1, 1, 0);

 -- Hardened Leather Pants (0.09% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3805, 0.09, 0, 1, 1, 0);

-- Interlaced Gloves (0.09% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3796, 0.09, 0, 1, 1, 0); 

-- Interlaced Vest (0.09% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3799, 0.09, 0, 1, 1, 0); 

-- Metal Stave (0.09% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3784, 0.09, 0, 1, 1, 0); 

-- Ardent Custodian (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 868, 0.04, 0, 1, 1, 0); 

-- Ebon Vise (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 7690, 0.04, 0, 1, 1, 0); 

-- Frostreaver Crown (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 13127, 0.04, 0, 1, 1, 0); 

-- Green Iron Hauberk (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3844, 0.04, 0, 1, 1, 0); 

-- Band of Thorns (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 5007, 0.04, 0, 1, 1, 0); 

 -- Cerulean Talisman (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 12019, 0.04, 0, 1, 1, 0);

-- Elder's Mantle (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 7367, 0.04, 0, 1, 1, 0); 

-- Infiltrator Cloak (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 7411, 0.04, 0, 1, 1, 0); 

-- Infiltrator Cord (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 7406, 0.04, 0, 1, 1, 0); 

-- Insignia Belt (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 6409, 0.04, 0, 1, 1, 0); 

-- Insignia Mantle (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 4721, 0.04, 0, 1, 1, 0); 

-- Knight's Mantle (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 7460, 0.04, 0, 1, 1, 0); 

-- Mail Combat Gauntlets (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 4075, 0.04, 0, 1, 1, 0); 

-- Mail Combat Spaulders (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 6404, 0.04, 0, 1, 1, 0); 

-- Scouting Bracers (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 6583, 0.04, 0, 1, 1, 0); 

-- Sequoia Hammer (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 15225, 0.04, 0, 1, 1, 0); 

-- Splitting Hatchet (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 15231, 0.04, 0, 1, 1, 0); 

-- Large Knapsack (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 1725, 0.04, 0, 1, 1, 0); 

 -- Scroll of Stamina II (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 1711, 0.04, 0, 1, 1, 0);

-- Double Mail Belt (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3808, 0.04, 0, 1, 1, 0); 

 -- Double Mail Bracers (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3810, 0.04, 0, 1, 1, 0);

-- Double Mail Gloves (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3812, 0.04, 0, 1, 1, 0); 

-- Harneded Leather Belt (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3800, 0.04, 0, 1, 1, 0); 

-- Hardened Leather Gloves (0.04% chance to drop)
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (507, 3804, 0.04, 0, 1, 1, 0); 

-- ===================================
-- Removed invalid gossip from Booty Bay Bruisers.
-- ===================================

-- Remove gossip from Booty Bay Bruisers
DELETE FROM `npc_gossip` WHERE `npc_guid` IN (76,77,160,161,162,163,164,165,178,182,589,590,591,592,593,594,596,597,598,599,649,650,651,652,653,654,655,656,657,679,680,681,682,683,686,687,688,689,692,693,694,695,696,697,698,699,700,715,716,717,718,719,2164,2167);


-- ===================================
-- Vol'jin has been scripted. Fine tuning required
-- ===================================

-- Miscellaneous updates and convert his script to EventAI.
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry`=10540;
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=10540;
UPDATE `creature_template` SET `flags_extra`=0 WHERE `entry`=10540;
UPDATE `creature_template` SET `unit_flags`=4672 WHERE `entry`=10540;
UPDATE `creature_template` SET `rank`=3 WHERE `entry`=10540;
UPDATE `creature_template` SET `RacialLeader`=1 WHERE `entry`=10540;
UPDATE `creature_template` SET `mechanic_immune_mask`=650854239 WHERE `entry`=10540;
UPDATE `creature_template` SET `minlevel`=63,`maxlevel`=63 WHERE `entry`=10540;
UPDATE `creature_template` SET `mingold`=592440,`maxgold`=592440 WHERE `entry`=10540;
UPDATE `creature_template` SET `minhealth`=329800, `maxhealth`=329800 WHERE `entry`=10540;
UPDATE `creature_template` SET `minmana`=68128, `maxmana`=68128 WHERE `entry`=10540;
UPDATE `creature` SET `curhealth`=329800, `curmana`=68128 WHERE `id`=10540;

-- Remove old entries if exists.
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-1153,-1154,-1155);
-- Create new entries.
INSERT INTO `creature_ai_texts` VALUES
(-1155,'For the Darkspear tribe!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5881,1,0,0,'Vol\'jin- Random Yell and Sound on Aggro'),
(-1154,'Here come the voodoo!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5881,1,0,0,'Vol\'jin - Random Yell and Sound on Aggro'),
(-1153,'You make big mistake, mon.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5881,1,0,0,'Vol\'jin - Random Yell and Sound on Aggro');

-- Create a new entry and make sure we have the correct data.
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=10540;
INSERT INTO `creature_ai_scripts` VALUES
( 1054001, 10540, 0, 0, 100, 1, 5500, 5500, 18500, 22500, 11, 16097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Cast Hex'),
( 1054002, 10540, 0, 0, 100, 1, 5500, 5500, 8500, 12500, 11, 17289, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Cast Shadow Shock'),
( 1054003, 10540, 0, 0, 100, 1, 5500, 5500, 15000, 15000, 11, 17146, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Cast Shadow Word: Pain'),
( 1054004, 10540, 0, 0, 100, 1, 1500, 5500, 22000, 22500, 11, 17820, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Cast Veil of Shadow'),
( 1054005, 10540, 0, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Stop Movement on Aggro'),
( 1054006, 10540, 4, 0, 100, 0, 0, 0, 0, 0, 11, 20463, 1, 0, 22, 1, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Cast Shoot and Set Phase 1 on Aggro'),
( 1054007, 10540, 0, 13, 100, 1, 2200, 4700, 2200, 4700, 11, 20463, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Cast Shoot (Phase 1)'),
( 1054008, 10540, 9, 13, 100, 1, 20, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Start Movement at 20 Yards (Phase 1)'),
( 1054009, 10540, 9, 13, 100, 1, 6, 10, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Stop Movement at 10 Yards (Phase 1)'),
( 1054010, 10540, 9, 13, 100, 1, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Start Movement at 5 Yards (Phase 1)'),
( 1054011, 10540, 2, 0, 100, 0, 15, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Set Phase 2 at 15% HP'),
( 1054012, 10540, 2, 11, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 25, 0, 0, 0, 1, -47, 0, 0, 'Vol\'jin - Start Movement and Flee at 15% HP (Phase 2)'),
( 1054013, 10540, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - On Evade set Phase to 0'),
( 1054014, 10540, 4, 0, 100, 0, 0, 0, 0, 0, 1, -1153, -1155, -1154, 0, 0, 0, 0, 0, 0, 0, 0, 'Vol\'jin - Random Yell and Sound on Aggro');


-- ===================================
-- Jaina's basic script has been implemented.
-- ===================================

-- Miscellaneous updates and convert script to EventAI
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry`=4968;
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=4968;
UPDATE `creature_template` SET `flags_extra`=0 WHERE `entry`=4968;
UPDATE `creature_template` SET `unit_flags`=4672 WHERE `entry`=4968;
UPDATE `creature_template` SET `minhealth`=462000, `maxhealth`=462000 WHERE `entry`=4968;
UPDATE `creature` SET `curhealth`= 462000 WHERE `id`=4968;

-- Set official gossips. Sound may differ from displayed text.
-- Create a new missing textid
DELETE FROM `npc_text` WHERE (`ID`=11458);
INSERT INTO `npc_text` VALUES (11458, 'Welcome to Theramore. Have you come to help the Alliance?', '', 0, 25, 0, 0, 0, 0, 0, 0, 'All I ever wanted to do was study.', '', 0, 25, 0, 0, 0, 0, 0, 0, 'Shh, I\'m trying to think here!', '', 0, 25, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `npc_gossip` WHERE (`npc_guid`=7895);
INSERT INTO `npc_gossip` (`npc_guid`, `textid`) VALUES (7895, 11458);

-- Texts and Sounds
-- Jaina will Yell a random text and Sound when first engaging in Combat. Sound may differ from yelled text.
DELETE FROM `creature_ai_texts` WHERE (`entry`=-1149); -- Created
DELETE FROM `creature_ai_texts` WHERE (`entry`=-1148); -- Created
INSERT INTO `creature_ai_texts` VALUES
(-1148,'You asked for it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5882,1,0,0,'Lady Jaina Proudmoore - Random Yell and Sound on Aggro'),
(-1149,'I hate resorting to violence!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5882,1,0,0,'Lady Jaina Proudmoore - Random Yell and Sound on Aggro');

-- Create a new entry.
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=4968);
INSERT INTO `creature_ai_scripts` VALUES
(496703,4968,4,0,100,0,0,0,0,0,1,-1148,-1149,0,0,0,0,0,0,0,0,0,'Lady Jaina Proudmoore - Random Yell and Sound on Aggro');


-- ===================================
-- Thrall's basic script has been implemented.
-- ===================================

-- Texts and Sounds
-- Thrall will Yell a random text and sound when first engaging in Combat. Sound may differ from yelled text.
-- Remove old entries if exists.
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-1150,-1151,-1152);
-- Create new entries.
INSERT INTO `creature_ai_texts` VALUES
(-1152,'For Doomhammer!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5880,1,0,0,'Thrall - Random Yell and Sound on Aggro'),
(-1151,'Lok\'Narosh!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5880,1,0,0,'Thrall - Random Yell and Sound on Aggro'),
(-1150,'Your time has come!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5880,1,0,0,'Thrall - Random Yell and Sound on Aggro');

-- Create a new entry.
INSERT INTO `creature_ai_scripts` VALUES
(494903, 4949, 4, 0, 100, 0, 0, 0, 0, 0, 1, -1150, -1151, -1152, 11, 0, 1, 0, 0, 0, 0, 0, 'Thrall - Random Yell and Sound on Aggro'); 


-- ===================================
-- High Overlord Saurfang is now scripted.
-- ===================================

/* High Overlord Saurfang (Version 1). This NPC will shred through anyone who dares attack him. I can confirm that he is absolutely insane. Not even Tier 3 will save you from this beast.
Note: His Timers may not be correct. If I ever get any feedback from an actual populated encounter, I will adjust them accordingly. */

/* Make sure we have him using EventAI. */
UPDATE creature_template SET AIName='EventAI' WHERE entry=14720;

/* Miscellaneous updates to his template. */
UPDATE `creature` SET `curhealth`=600000 WHERE `id`=14720;
UPDATE `creature_template` SET `minhealth`=600000, `maxhealth`=600000, `mindmg`=1118, `maxdmg`=1440, `armor`=5892, `unit_flags`=37376, `mechanic_immune_mask`=650854239, speed_run=3.28571,`flags_extra`=256 WHERE `entry`=14720;

/* Saurfang's Abilities */

/* Shield Charge. Initial Charge if within dist. */
DELETE FROM `creature_ai_scripts` WHERE `id`=1720909 AND `creature_id`=14720;
INSERT INTO `creature_ai_scripts` VALUES (1720909, 14720, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15749, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Overlord Saurfang - Cast Shield Charge on Aggro');

/* Shield Charge & other abilities will continuously cycle throughout the fight. */
DELETE FROM `creature_ai_scripts` WHERE `id`=1720910 AND `creature_id`=14720;
INSERT INTO `creature_ai_scripts` VALUES (1720910, 14720, 9, 0, 100, 1, 8, 25, 2300, 3900, 11, 15749, 1, 0, 40, 1, 0, 0, 0, 0, 0, 0, 'High Overlord Saurfang - Cast Shield Charge and set Melee Weapon Model');

/* Mortal Strike */
DELETE FROM `creature_ai_scripts` WHERE id=1720911 AND `creature_id`=14720;
INSERT INTO `creature_ai_scripts` VALUES (1720911, 14720, 0, 0, 100, 1, 4000, 6000, 7000, 9000, 11, 24573, 1, 1, 40, 1, 0, 0, 0, 0, 0, 0, 'High Overlord Saurfang - Cast Mortal Strike and set Melee Weapon Model');

/* Cleave */
DELETE FROM `creature_ai_scripts` WHERE `id`=1720912 AND `creature_id`=14720;
INSERT INTO `creature_ai_scripts` VALUES (1720912, 14720, 0, 0, 100, 1, 2000, 3000, 3500, 4500, 11, 16044, 1, 1, 40, 1, 0, 0, 0, 0, 0, 0, 'High Overlord Saurfang - Cast Cleave and set Melee Weapon Model');

/* Terrifying Road */
DELETE FROM `creature_ai_scripts` WHERE `id`=1720913 AND `creature_id`=14720;
INSERT INTO `creature_ai_scripts` VALUES (1720913, 14720, 0, 0, 100, 1, 4000, 6000, 7000, 9000, 11, 14100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Overlord Saurfang - Cast Terrifying Roar');

/* Whirlwind */
DELETE FROM `creature_ai_scripts` WHERE `id`=1720914 AND `creature_id`=14720;
INSERT INTO `creature_ai_scripts` VALUES (1720914, 14720, 0, 0, 100, 1, 10000, 12000, 15000, 18000, 11, 28334, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Overlord Saurfang - Cast Whirlwind');

/* Setup his Text */
/* Saurfang will say this upon killing a player.  */
DELETE FROM `creature_ai_texts` WHERE `entry`=-1159;
INSERT INTO `creature_ai_texts` VALUES
(-1159,'Is that the best you can do?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'High Overlord Saurfang - Say On Kill');

/* Script Text */
DELETE FROM `creature_ai_scripts` WHERE `id`=1720908 AND `creature_id`=14720;
INSERT INTO `creature_ai_scripts` VALUES (1720908, 14720, 5, 0, 100, 1, 1000, 1000, 0, 0, 1, -1159, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Overlord Saurfang - Say On Kill');


-- ===================================
-- Redridge Poachers will now properly engage in combat.
-- ===================================

DELETE FROM `creature_ai_scripts` WHERE `creature_id`=424;
INSERT INTO `creature_ai_scripts` VALUES
(42401, 424, 4, 0, 10, 0, 0, 0, 0, 0, 1, -5, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Redridge Poacher - Random Say on Aggro'),
(42402, 424, 9, 5, 100, 1, 5, 30, 3400, 3700, 11, 6660, 1, 0, 40, 2, 0, 0, 0, 0, 0, 0, 'Redridge Poacher - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
(42403, 424, 2, 0, 100, 0, 15, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Redridge Poacher - Set Phase 2 at 15% HP'),
(42404, 424, 2, 3, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 25, 0, 0, 0, 1, -47, 0, 0, 'Redridge Poacher - Start Combat Movement and Flee at 15% HP (Phase 2)'),
(42405, 424, 7, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 'Redridge Poacher - Set Phase 1 and Set Melee Weapon Model on Evade');

-- ===================================
-- Duggan Wildhammer is now longer part of the Ravenholdt Faction and will now be functional in combat.
-- ===================================

/* Misc. updates to his template. His walkspeed was higher than his runspeed, causing him to fastwalk. */
UPDATE creature_template SET AIName='EventAI', speed_walk=1 WHERE entry=10817;
DELETE FROM creature_template_spells WHERE entry=10817;

/* Remove TBC loot */
DELETE FROM creature_loot_template WHERE entry=10817 AND item IN (24024,24029,24031,24033);

/* Texts */
DELETE FROM creature_ai_texts WHERE entry=-1160;
INSERT INTO creature_ai_texts VALUES (-1160,'Ah ken see very well through this haze, but I\'d know tha\' smell anywhere! Die ye foul ogre!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Duggan wildhammer - Say on Aggro');

/* Insert data into script file. Scrap his previous AI and rework his abilities. Blizzard decided that he wasn't cool enough so they decided not to give him any Ranged Weapon Model. */
/* Remove phase_mask as we're not using any Phases right now. */
DELETE FROM creature_ai_scripts WHERE id BETWEEN 1081701 AND 1081710;
INSERT INTO creature_ai_scripts VALUES
(1081701,10817,4,0,100,0,0,0,0,0,1,-1160,0,0,0,0,0,0,0,0,0,0,'Duggan Wildhammer - Say on Aggro'),
(1081702,10817,9,0,100,1,0,5,6000,9000,11,15284,1,1,40,1,0,0,0,0,0,0,'Duggan Wildhammer - Cast Cleave and Set Melee Weapon Model'),
(1081703,10817,9,0,100,1,5,30,2300,3900,11,15547,1,0,40,2,0,0,0,0,0,0,'Duggan Wildhammer - Cast Shoot and Set Ranged Weapon Model'),
(1081704,10817,2,0,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Duggan Wildhammer - Start Combat Movement and Flee at 15% HP'),
(1081705,10817,7,0,100,0,0,0,0,0,22,1,0,0,40,1,0,0,0,0,0,0,'Duggan Wildhammer - Set Melee Weapon Model on Evade');


-- ===================================
-- Scholomance Students will now longer drop loot.
-- ===================================

/* Remove Loot */
UPDATE creature_template SET lootid=0 WHERE entry=10475;
DELETE FROM creature_loot_template WHERE entry=10475;

/* Add missing Pickpocketing Loot. Data taken from old.wowhead */
DELETE FROM `pickpocketing_loot_template` WHERE `entry`=10475;
INSERT INTO `pickpocketing_loot_template` VALUES
(10475, 3928, 3.8462, 0, 1, 1, 0), -- Superior Healing Potion
(10475, 5432, 19.2308, 0, 1, 1, 0), -- Hickory Pipe
(10475, 16885, 74, 0, 1, 1, 0), -- Heavy Junkbox
(10475, 8953, 22, 0, 1, 1, 0), -- Deep Fried Plantains
(10475, 8932, 16, 0, 1, 1, 0), -- Alterac Swiss
(10475, 8950, 16, 0, 1, 1, 0), -- Homemade Cherry Pie
(10475, 7910, 2, 0, 1, 1, 0); -- Star Ruby

-- ===================================
-- Lord Alexei Barov will now always be level 60. 
-- ===================================

UPDATE creature_template SET minlevel=60, maxlevel=60 WHERE entry=10504;

-- ===================================
-- Gordok Spirits will no longer attack players and to prevent any exploiting, they have been made unattackable.
-- ===================================

-- Set their unit flag to passive and make them unattackable
UPDATE `creature_template` SET `unit_flags`=514, `MovementType`=0 WHERE `entry`=11446;

-- ===================================
-- Decoded True Believer Clippings will now contain the proper Darkrune Recipes amongst other Recipes.
-- ===================================

-- Pattern: Runed Stygian Belt (6% chance to be inside container)
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (20469, 20548, 6, 0, 1, 1, 0);

-- Plans: Darkrune Breastplate (6% chance to be inside container)
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (20469, 20554, 6, 0, 1, 1, 0);

-- Pattern: Runed Stygian Leggings (5% chance to be inside container)
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (20469, 20546, 5, 0, 1, 1, 0);

-- Plans: Darkrune Helm (4% chance to be inside container)
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (20469, 20555, 4, 0, 1, 1, 0);

-- Plans: Darkrune Gauntlets (1.4% chance to be inside container)
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (20469, 20553, 1.4, 0, 1, 1, 0);

-- Pattern: Runed Stygian Boots (1.1% chance to be inside container)
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (20469, 20547, 1.1, 0, 1, 1, 0);

-- ===================================
-- Fixed an issue wherein the container 'Curmudgeon's Payoff' would not give the player 5g upon opening it.
-- ===================================

UPDATE `item_template` SET `minMoneyLoot`=50000, `maxMoneyLoot`=50000 WHERE `entry`=23022;

-- ===================================
-- Fixed an issue where in Invisibility Potions would trigger a 10min. CD on pots of that same category.
-- ===================================

UPDATE `item_template` SET `spellcooldown_1`=600000 WHERE `entry` IN (3823,9172);
UPDATE `item_template` SET `spellcategorycooldown_1`=120000 WHERE `entry` IN (3823,9172);

DELETE FROM `conditions` WHERE `condition_entry` = 1200;
DELETE FROM `conditions` WHERE `condition_entry` = 1201;
-- Condition for Alterac Valley
REPLACE INTO `conditions` VALUES (1200, 15, 51, 1);

-- Condition for Arathi Basin
REPLACE INTO `conditions` VALUES (1201, 15, 20, 1); 

-- Alliance
-- Alterac Valley

DELETE FROM `gossip_menu` WHERE `entry` = 5118;
INSERT INTO `gossip_menu` VALUES (5118, 7616, 0, 0); -- Player below level 51
INSERT INTO `gossip_menu` VALUES (5118, 7662, 0, 1200); -- Player are Level 51 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=49937);
UPDATE `creature_template` SET `gossip_menu_id` = 5118 WHERE `entry` = 5118;

DELETE FROM `gossip_menu` WHERE `entry` = 6465;
INSERT INTO `gossip_menu` VALUES (6465, 7616, 0, 0); -- Player below level 51
INSERT INTO `gossip_menu` VALUES (6465, 7658, 0, 1200); -- Player are Level 51 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=2017);
UPDATE `creature_template` SET `gossip_menu_id` = 6465 WHERE `entry` = 12197;

DELETE FROM `gossip_menu` WHERE `entry` = 7410;
INSERT INTO `gossip_menu` VALUES (7410, 7616, 0, 0); -- Player below level 51
INSERT INTO `gossip_menu` VALUES (7410, 7662, 0, 1200); -- Player are Level 51 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=42893);
UPDATE `creature_template` SET `gossip_menu_id` = 7410 WHERE `entry` = 7410;

-- Horde

DELETE FROM `gossip_menu` WHERE `entry` = 347;
INSERT INTO `gossip_menu` VALUES (347, 7683, 0, 0); -- Player below level 51
INSERT INTO `gossip_menu` VALUES (347, 7659, 0, 1200); -- Player are Level 51 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=32067);
UPDATE `creature_template` SET `gossip_menu_id` = 347 WHERE `entry` = 347;

DELETE FROM `gossip_menu` WHERE `entry` = 7427;
INSERT INTO `gossip_menu` VALUES (7427, 7683, 0, 0); -- Player below level 51
INSERT INTO `gossip_menu` VALUES (7427, 7661, 0, 1200); -- Player are Level 51 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=24670);
UPDATE `creature_template` SET `gossip_menu_id` = 7427 WHERE `entry` = 7427;

DELETE FROM `gossip_menu` WHERE `entry` = 14942;
INSERT INTO `gossip_menu` VALUES (14942, 7683, 0, 0); -- Player below level 51
INSERT INTO `gossip_menu` VALUES (14942, 7659, 0, 1200); -- Player are Level 51 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=4764);
UPDATE `creature_template` SET `gossip_menu_id` = 14942 WHERE `entry` = 14942;

-- Arathi
-- Alliance

DELETE FROM `gossip_menu` WHERE `entry` = 6471;
INSERT INTO `gossip_menu` VALUES (6471, 7642, 0, 0); -- Player below level 20
INSERT INTO `gossip_menu` VALUES (6471, 7665, 0, 1201); -- Player are Level 20 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=78);
UPDATE `creature_template` SET `gossip_menu_id` = 6471 WHERE `entry` = 857;

DELETE FROM `gossip_menu` WHERE `entry` = 907;
INSERT INTO `gossip_menu` VALUES (907, 7642, 0, 0); -- Player below level 20
INSERT INTO `gossip_menu` VALUES (907, 7665, 0, 1201); -- Player are Level 20 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=46570);
UPDATE `creature_template` SET `gossip_menu_id` = 907 WHERE `entry` = 907;

DELETE FROM `gossip_menu` WHERE `entry` = 6472;
INSERT INTO `gossip_menu` VALUES (6472, 7642, 0, 0); -- Player below level 20
INSERT INTO `gossip_menu` VALUES (6472, 7666, 0, 1201); -- Player are Level 20 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=54625);
UPDATE `creature_template` SET `gossip_menu_id` = 6472 WHERE `entry` = 15008;

-- Horde

DELETE FROM `gossip_menu` WHERE `entry` = 12198;
INSERT INTO `gossip_menu` VALUES (12198, 7678, 0, 0); -- Player below level 20
INSERT INTO `gossip_menu` VALUES (12198, 7667, 0, 1201); -- Player are Level 20 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=26564);
UPDATE `creature_template` SET `gossip_menu_id` = 12198 WHERE `entry` = 12198;

DELETE FROM `gossip_menu` WHERE `entry` = 6473;
INSERT INTO `gossip_menu` VALUES (6473, 7678, 0, 0); -- Player below level 20
INSERT INTO `gossip_menu` VALUES (6473, 7667, 0, 1201); -- Player are Level 20 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=4761);
UPDATE `creature_template` SET `gossip_menu_id` = 6473 WHERE `entry` = 15006;

DELETE FROM `gossip_menu` WHERE `entry` = 6474;
INSERT INTO `gossip_menu` VALUES (6474, 7678, 0, 0); -- Player below level 20
INSERT INTO `gossip_menu` VALUES (6474, 7668, 0, 1201); -- Player are Level 20 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=32068);
UPDATE `creature_template` SET `gossip_menu_id` = 6474 WHERE `entry` = 15007;

-- Warsong
-- Alliance

DELETE FROM `gossip_menu` WHERE `entry` = 6463;
INSERT INTO `gossip_menu` VALUES (6463, 7704, 0, 0); -- Player below level 10
INSERT INTO `gossip_menu` VALUES (6463, 7656, 0, 107); -- Player are Level 10 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=79);
UPDATE `creature_template` SET `gossip_menu_id` = 6463 WHERE `entry` = 14982;

DELETE FROM `gossip_menu` WHERE `entry` = 14981;
INSERT INTO `gossip_menu` VALUES (14981, 7704, 0, 0); -- Player below level 10
INSERT INTO `gossip_menu` VALUES (14981, 7653, 0, 107); -- Player are Level 10 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=54614);
UPDATE `creature_template` SET `gossip_menu_id` = 14981 WHERE `entry` = 14981;

DELETE FROM `gossip_menu` WHERE `entry` = 2302;
INSERT INTO `gossip_menu` VALUES (2302, 7704, 0, 0); -- Player below level 10
INSERT INTO `gossip_menu` VALUES (2302, 7481, 0, 107); -- Player are Level 10 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=49936);
UPDATE `creature_template` SET `gossip_menu_id` = 2302 WHERE `entry` = 2302;

-- Horde

DELETE FROM `gossip_menu` WHERE `entry` = 3890;
INSERT INTO `gossip_menu` VALUES (3890, 7688, 0, 0); -- Player below level 10
INSERT INTO `gossip_menu` VALUES (3890, 7652, 0, 107); -- Player are Level 10 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=4765);
UPDATE `creature_template` SET `gossip_menu_id` = 3890 WHERE `entry` = 3890;

DELETE FROM `gossip_menu` WHERE `entry` = 4766;
INSERT INTO `gossip_menu` VALUES (4766, 7688, 0, 0); -- Player below level 10
INSERT INTO `gossip_menu` VALUES (4766, 7654, 0, 107); -- Player are Level 10 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=24794);
UPDATE `creature_template` SET `gossip_menu_id` = 4766 WHERE `entry` = 10360;

DELETE FROM `gossip_menu` WHERE `entry` = 2804;
INSERT INTO `gossip_menu` VALUES (2804, 7688, 0, 0); -- Player below level 10
INSERT INTO `gossip_menu` VALUES (2804, 7654, 0, 107); -- Player are Level 10 or higher
DELETE FROM `npc_gossip` WHERE (`npc_guid`=32071);
UPDATE `creature_template` SET `gossip_menu_id` = 2804 WHERE `entry` = 2804;

