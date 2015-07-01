-- ---------------------------------------- 
-- --        CLEAR DOWN THE TABLE        -- 
-- ---------------------------------------- 
TRUNCATE TABLE `dbdocstable`; 
-- ---------------------------------------- 
-- MySQL dump 10.13  Distrib 5.5.37, for Win32 (x86)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	5.6.23-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@SESSION.TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `dbdocstable`
--

LOCK TABLES `dbdocstable` WRITE;
/*!40000 ALTER TABLE `dbdocstable` DISABLE KEYS */;
INSERT INTO `dbdocstable` (`tableId`, `languageId`, `tableName`, `tableNotes`) VALUES (1,0,'areatrigger_involvedrelation','The areatrigger_involvedrelation table holds connections between triggers and quests.\r\n\r\nIf there is a record in the table for a quest, the quest will not be completed until the player activates the areatriger. The quest is not necessarily finished after that, but that one condition of the quest is satisfied. If the only condition of the quest is to explore an area, then the quest will be complete.'),
(2,0,'areatrigger_tavern','Enable a trigger when player enters a city or tavern. This causes the player to enter a resting state.'),
(3,0,'areatrigger_teleport','Contains all the teleport triggers definition. This table is used to complete .dbc file information.'),
(4,0,'battleground_events','This table contains the description of battleground events.'),
(5,0,'battleground_template','Contains information about the different battlegrounds, like how many players are needed to start, how many can be inside the same one, and the locations where each side starts.'),
(6,0,'battlemaster_entry','Holds information on which NPC can start what battleground or arena.'),
(7,0,'command','Holds help and security information for commands.'),
(8,0,'conditions','With this table and the new conditions it is possible to create tree like and very complicated combined conditions (like HasAura && (HasItem || HasQuest))\r\n\r\nUsed in:\r\n\r\nDBScript\r\ngossip_menu\r\ngossip_menu_option\r\nnpc_spellclick_spells\r\nspell_area'),
(9,0,'creature','Contains individual creature spawn data. Spawn of a creature is an instance of the creature object in the world.'),
(10,0,'creature_addon','The creature_addon and creature_template_addon tables define different things that are applied on creatures when they are loaded. These \"different things\" can be for example to have the creature be mounted, to have it emote something, to have it display an aura effect, etc. Through the use of the fields in this table, many things can be changed about the outward visual appearance of the creature. The creature_template_addon table affects all creatures with that creature template ID while the creature_addon table affects individually spawned creatures (so that two creatures using the same template can look different).\r\n\r\nNOTES: \r\nA creature_addon record will override a creature_template_addon record should they overlap on the same creature.<br />\r\n<br />\r\nThe data for this table is largely incomplete and is mostly just a regurgitation of what the client receives from the server. This article is a WIP as to what all the possible values are.'),
(11,0,'creature_ai_scripts','This table specifies the actions that a creature script will do. \r\nA basic eventAI script works with and requires only two pieces of information: What to do and When to do it.'),
(12,0,'creature_ai_summons','This table is used to provide NPC support for an event using action 32 = ACTION_T_SUMMON as one of its Actions'),
(13,0,'creature_ai_texts','This table holds all the texts used within the eventai (ACID) scripts. This table handles the actual text, display type (say/yell/emote) and corresponding sounds or emote (if any).'),
(14,0,'creature_battleground','This table contains the description of creatures spawned on battlegrounds.'),
(15,0,'creature_equip_template','This table contains all equipment mobs can wear.'),
(16,0,'creature_equip_template_raw','The creature_equip_template_raw table holds information on items that creatures should wear.<br/ >\r\n<br/ >\r\n<b>Note:</b> This table is deprecated. Do not use it, as it will be removed in a future update and is just here to ease transition to the new creature_equip_template table.'),
(17,0,'creature_involvedrelation','Holds NPC quest ender relations on which NPCs finishes which quests.'),
(18,0,'creature_item_template','xxxx'),
(19,0,'creature_linking','This table holds details of how creatures linked to a master creature should act in combat and non-combat situations.'),
(20,0,'creature_linking_template','This table holds details on how creature templates linked to a master creature template should act in combat and non-combat situations.'),
(21,0,'creature_loot_template','This table format is used to generate different loot items. Loot templates define only items in the loot.\r\nSee comments about money drop in corpse, pickpocketing and luggage loot in creature_template and item_template.'),
(22,0,'creature_model_info','This table contains all models of mobs, their gender and other information that are model related. This means that when a creature uses another model, this information will change as well.'),
(23,0,'creature_movement','This table holds all the information on each creature\'s waypoints. In essence, a set of waypoints just defines a path that the creature will follow by going from point to point. More specifically, once the creature arrives at a point, it can do different things like cast a spell, do an emote, etc. Usually this table is filled through the .wp command (and its various subcommands) in the world. <br /><br />Please note that for a creature to use waypoints, its MovementType must be 2.'),
(24,0,'creature_movement_template','This table holds informations on paths for creature_template entries and allows the behaviour to be defined along the movement path (set of waypoints).<br /><br />Template movement is usually applied to creature templates spawned by scripts, or for templates which are unique and have only one spawn.<br /><br /><b>Note:</b> Movement attached to a creature template will be applied to all spawns of this template, unless there is a unique movement defined for the creature guids in the creature_movement table.'),
(25,0,'creature_onkill_reputation','This table controls the reputation given by creatures when killed by other players.'),
(26,0,'creature_questrelation','This table holds NPC quest giver relations on which NPCs start which quests.'),
(27,0,'creature_template','This table contains the description of creatures. Each spawned creature is an instance of a template present in this table, this means every creature MUST be defined in this table.'),
(28,0,'creature_template_addon','The creature_addon and creature_template_addon tables define different things that are applied on creatures when they are loaded. These \"different things\" can be for example to have the creature be mounted, to have it emote something, to have it display an aura effect, etc. Through the use of the fields in this table, many things can be changed about the outward visual appearance of the creature. The creature_template_addon table affects all creatures with that creature template ID while the creature_addon table affects individually spawned creatures (so that two creatures using the same template can look different).\r\n\r\nNOTES: \r\nA creature_addon record will override a creature_template_addon record should they overlap on the same creature.<br />\r\n<br />\r\nThe data for this table is largely incomplete and is mostly just a regurgitation of what the client receives from the server. This article is a WIP as to what all the possible values are.'),
(29,0,'creature_template_classlevelstats','This table contains the base values for creatures\' health, mana and armor.'),
(30,0,'creature_template_spells','This table holds information on the spells to which a Creature (See creature_template) has access.'),
(31,0,'custom_texts','xxxx'),
(32,0,'db_script_string','This table holds texts for the DB-based scripts.'),
(33,0,'db_version','This table holds the current version of the MaNGOS world database'),
(34,0,'dbdocsfields','This table is part of the implementation of the \'Mangos Database Documentation\' (MDD) Project.\r\n\r\nAn entry in this table provides a link to the table and field to allow additional notes to describe the field in the Wiki.'),
(35,0,'dbdocsprogressquests','This table is part of the dbdocs project and is not used by the mangos server. \r\nIt holds details on the completion status of each quest in MaNGOS, as well as any notes about the quest.<br />\r\n<br />\r\n<b>Note:</b> By default the progress value is set to 0% by dbdocs.'),
(36,0,'dbdocssubtables','This table is part of the implementation of the \'Mangos Database Documentation\' (MDD) Project.\r\n\r\nAn entry in this table provides a table which dirctly replaces the link in the fieldnotes.'),
(37,0,'dbdocstable','This table is part of the implementation of the \'Mangos Database Documentation\' (MDD) Project.\r\n\r\nAn entry in this table provides a additional notes field to describe the database in the Wiki.'),
(38,0,'dbscripts_on_creature_death','This table holds scripts activated when a creature dies. (Source: creature; at the script execution time, it is considered alive, so can cast instant spells.)'),
(39,0,'dbscripts_on_creature_movement','This table holds scripts activated when a creature moving by waypoints reaches a WP. (Source: creature)'),
(40,0,'dbscripts_on_event','This table holds scripts activated when an event is sent either via spell (SPELL_EFFECT_SEND_EVENT=61) or by a gameobject.'),
(41,0,'dbscripts_on_go_template_use','This table holds scripts activated when a character uses a gameobject (like door, chest, button so on).'),
(42,0,'dbscripts_on_go_use','This table holds scripts activated when a character uses either door or button. This script, bound to the GameObject GUID, does not override the script bound to the GameObject entry, if any. If both scripts are defined, they are executed sequentially, the script from this table activates after the script from dbscripts_on_go_template_use.'),
(43,0,'dbscripts_on_gossip','This table holds scripts mentioned in the gossip_menu and gossip_menu_item tables. In the latter case, the parameters depend on object type (GameObject or Unit) of the object having such gossip: for GO, source = Player and target = GameObject; for Unit, source = Unit and target = Player. In the former case, source = Player and target = Unit. This all is rather funny, isn\'t this?<br />The scripts &quot;on talking to gameobject&quot; are implemented instead with dbscripts_on_go_template_use.'),
(44,0,'dbscripts_on_quest_end','This table holds scripts mentioned in the quest_template table. Here source = questrewarder, target = Player.'),
(45,0,'dbscripts_on_quest_start','This table holds scripts mentioned in the quest_template table. Here source = questgiver, target = Player.'),
(46,0,'dbscripts_on_spell','This table holds scripts triggered by spells with EFFECT_DUMMY (3) or EFFECT_SCRIPT_EFFECT (77). Here source = caster, target = unitTarget.<br />Note that if the spell contains more than 1 effect of such type, this script will be set up for the single effect only, namely for one with the least effect number.'),
(47,0,'disenchant_loot_template','This table format is used to generate different loot items. Loot templates define only items in the loot.\r\nSee comments about money drop in corpse, pickpocketing and luggage loot in creature_template and item_template.'),
(48,0,'exploration_basexp','This table controls the XP gained by characters when they explore new zones.<br />Many areas have an \"area level\" defined in AreaTable.dbc. It is the suggested level of the character exploring the area. This table defines exploration XP reward and in conjunction with a core mechanic limits the reward for the characters of substantial different level. The basic formula for the XP reward is:<br />basexp[area_level] * Rate.XP.Explore<br />where the last parameter is defined in the config file. If the area level exceeds the player level by 5 or more, the formula turns into:<br />basexp[player_level+5] * Rate.XP.Explore'),
(49,0,'fishing_loot_template','This table format is used to generate different loot items. Loot templates define only items in the loot.\r\nSee comments about money drop in corpse, pickpocketing and luggage loot in creature_template and item_template.'),
(50,0,'game_event','This table contains definitions for all game events that are activated or deactivated automatically by the Game Event System in the core.<br />NOTE: an object (creature, GO etc.) cannot be related to a more than 1 game event. For example, if you wish something to happen only at March nights, you cannot combine events \"March\" and \"Nights\", but have to define a new event like \"Nights\" starting March 1 and ending April 1 of the same year.'),
(51,0,'game_event_creature','Contains all creature instances that have to be spawned/unspawned during defined game events.'),
(52,0,'game_event_creature_data','Contains all creature instances that need to change display id and/or equipment during defined game events.'),
(53,0,'game_event_gameobject','Contains all gameobjects instances that participate to any game event.'),
(54,0,'game_event_mail','This table holds definitions for mails sent out during game events and conditions for when to send the mail.'),
(55,0,'game_event_quest','This table controls availability of the quests during the events. When out of the event a questgiver may not be despawned, you can disable quests which he proposes. Quests listed here will be available only during respective events.'),
(56,0,'game_graveyard_zone','This table contains information about which zones are connected to the world’s graveyards.<br /><br />This table set if character die in zone ghost_zone and graveyard with id accept his team (HORDE or ALIANCE or both) and this is nearest graveyard then character’s ghost will be teleported to graveyard id.<br /><br />For a list of all existing graveyards and their respective IDs, check out WorldSafeLocs.dbc.'),
(57,0,'game_tele','This table contains a list of teleport locations that can be used with the .tele command in-game. Entries in this table can be added/deleted manually or with the .addtele/.deltele commands.'),
(58,0,'game_weather','This table holds the percentages for weather changes in various zones. Not all zones can have their weather changed. For any given zone the percentage of all weather types for each season should total, and not exceed 100%.'),
(59,0,'gameobject','This table holds the individual object data on each spawned game object in the world. This data along with the object’s template data is read and used to instantiate the objects in the world.'),
(60,0,'gameobject_battleground','This table contains the events of gameobjects which are spawned on battlegrounds.'),
(61,0,'gameobject_involvedrelation','This table holds game object quest taker relations. The game objects in this table should all be of type QUESTGIVER (2).'),
(62,0,'gameobject_loot_template','This table format is used to generate different loot items. Loot templates define only items in the loot.\r\nSee comments about money drop in corpse, pickpocketing and luggage loot in creature_template and item_template.'),
(63,0,'gameobject_questrelation','This table holds game object quest giver relations. The game objects in this table should all be of type QUESTGIVER (2).'),
(64,0,'gameobject_template','This table contains templates of all the world’s objects'),
(65,0,'gossip_menu','This table is used for displaying gossip when a player talks to an NPC.'),
(66,0,'gossip_menu_option','This table holds infos about menu options a gossip NPC can have. \r\nExamples of options: \"Train me!\" or \"I want to unlearn my talents\".'),
(67,0,'gossip_texts','This table defines textes for gossip menu items, used by C++ native (SD2) scripts.'),
(68,0,'instance_template','This table has all the templates for every instance. When a group enters an instance, a new copy of that instance is made from the values in these fields.'),
(69,0,'item_enchantment_template','This table holds enchantment chance information for items that should have either a random property or a random suffix attached to them.'),
(70,0,'item_loot_template','This table format is used to generate different loot items. Loot templates define only items in the loot.\r\nSee comments about money drop in corpse, pickpocketing and luggage loot in creature_template and item_template.'),
(71,0,'item_required_target','These spell effects require a specific target in either alive or dead state (for creatures).'),
(72,0,'item_template','Holds information on every item that exists in the game. All items are created from their template stored in this table.'),
(73,0,'locales_creature','This table is used to provide to localized clients with localized names and subnames of creatures.'),
(74,0,'locales_gameobject','This table is used to provide to localized clients with localized gameobject names.'),
(75,0,'locales_gossip_menu_option','This table is used to provide localized clients with localized string for gossip_menu_option.'),
(76,0,'locales_item','This table is used to provide to localized clients with localized names and descriptions of items.'),
(77,0,'locales_npc_text','This table is used to provide localized clients with localized string for npc_texts.'),
(78,0,'locales_page_text','This table is used to provide localized clients with localized string for page_texts.'),
(79,0,'locales_points_of_interest','This table is used to provide to localized clients with localized string for points_of_interest.'),
(80,0,'locales_quest','This table is used to provide to localized clients with localized string for quest templates.'),
(81,0,'mail_loot_template','This table format is used to generate different loot items. Loot templates define only items in the loot.\r\nSee comments about money drop in corpse, pickpocketing and luggage loot in creature_template and item_template.'),
(82,0,'mangos_string','This table holds all of the strings used internally by the server. This table is provided with the main purpose of translation in mind.\r\n\r\nNOTE: The % arguments need to stay in the exact same order as they are provided by default in the English translation.'),
(83,0,'npc_gossip','THIS TABLE IS OUTDATED. DO NOT USE\r\n<br/> \r\nIt should have been removed around 2009, but for some bad reasons it wasn’t..\r\n\r\nUse table gossip_menu instead.'),
(84,0,'npc_text','This table contains the texts that are used for gossip. \r\n<br />\r\nMore research needs to be done on this table !\r\n<br />\r\nText is shown in the start of the talk window.'),
(85,0,'npc_trainer','This table holds all the information on training NPCs. All spells listed in the table are learning spells. This means that the main effect of the spells listed here is to teach spells to the target (which is the player in this case). Any other spell that is not a learning spell will be ignored and an error message will be shown in the console window. Learning spells usually have the same name as their actual spell counterparts and are listed as Uncategorized in Wowhead.'),
(86,0,'npc_trainer_template','DEPRECATED. Use npc_trainer table instead.'),
(87,0,'npc_vendor','This table holds the vendor data for all NPCs that sell items. The gold price for each item is in its item template as BuyPrice.'),
(88,0,'npc_vendor_template','DEPRECATED. Use npc_vendor table instead.'),
(89,0,'page_text','This table holds the text for letter items or any items that when moused-over turn the cursor into a magnifying glass and on right-click will open up a window where you can read the contents of the letter.'),
(90,0,'pet_levelstats','This table holds information on individual pet base stats based on level.'),
(91,0,'pet_name_generation','This table holds pieces of names (first and last half) that are use for pet name generation.'),
(92,0,'petcreateinfo_spell','This table holds spells which are assigned to tameable creatures.'),
(93,0,'pickpocketing_loot_template','This table format is used to generate different loot items. Loot templates define only items in the loot.\r\nSee comments about money drop in corpse, pickpocketing and luggage loot in creature_template and item_template.'),
(94,0,'player_classlevelstats','This table holds information on the base health and mana of characters when they level up. Each class has different level stats. All of the values in this table signify only the base health and mana of the class at a specific level.'),
(95,0,'player_levelstats','This table holds information on what stats are gained by characters when they level up. Each race-class combination has different level stats. All of the values in this table signify only the base stats of the race-class combination at a specific level.'),
(96,0,'player_xp_for_level','Includes information on how much experience needed for next level.'),
(97,0,'playercreateinfo','This table holds the start positions of each class-race combinations for all newly created characters.'),
(98,0,'playercreateinfo_action','This table holds information on what default actions a brand new character should start out with. Each race-class combination can have a different default starting setup.'),
(99,0,'playercreateinfo_item','This table holds information on what items each race-class combination of a new character starts out with.'),
(100,0,'playercreateinfo_spell','This table holds information on what spells newly created characters should start out with. A character in this table is defined by his/her race and class combination.'),
(101,0,'points_of_interest','This table holds definitions for points of interests in various locations.'),
(102,0,'pool_creature','Contains all pool instances that participate, in particular, to any game event.'),
(103,0,'pool_creature_template','Contains all pool instances that participate, in partuclar, to any game event.'),
(104,0,'pool_gameobject','Contains all pool instances that participate, in particualr, to any game event.'),
(105,0,'pool_gameobject_template','Contains all pool instances that participate, in particular, to any game event.'),
(106,0,'pool_pool','This is the pool of pools table. Like creatures and gameobjects, pools are the objects that may be gathered into other pools. You can create a pool with a chance of a range of pools in that pool being activated.'),
(107,0,'pool_template','Defines all pool instances that participate, in particular, to any game event.'),
(108,0,'quest_template','Contains all basic definitions of quests available.'),
(109,0,'reference_loot_template','This table format is used to generate different loot items. Loot templates define only items in the loot.\r\nSee comments about money drop in corpse, pickpocketing and luggage loot in creature_template and item_template.'),
(110,0,'reputation_reward_rate','Holds reputation multipliers for specific factions.<br />Setting a rate to 0 disables reputation gain to the faction by the defined way completely.<br />NOTE: For the low level kills/quests, the rate values are combined with the config file settings Rate.Reputation.LowLevel.Kill/Quest by multiplying.'),
(111,0,'reputation_spillover_template','This table holds information for additional factions which will be awarded reputation simultaneously with the original one. Note that the rates may be fractional and/or negative.'),
(112,0,'reserved_name','This table serves as a simple list of names that players (gmlevel == 0) cannot use when naming their characters.'),
(113,0,'script_texts','This table contains the texts (and localized ones) for C++ SD2 script engine, used in the function DoScriptText().'),
(114,0,'script_waypoint','The table contains creature waypoints used in the C++ SD2 script library. The data is used by npc_escortAI::FillPointMovementListForCreature().'),
(115,0,'scripted_areatrigger','This table links areatriggers to C++ scripts.'),
(116,0,'scripted_event','This table links events to C++ scripts.'),
(117,0,'sd2_db_version','This table holds the current version of the Scripts database'),
(118,0,'skill_fishing_base_level','This table controls the minimum skill level required in fishing to fish in a certain area.'),
(119,0,'skinning_loot_template','This table format is used to generate different loot items. Loot templates define only items in the loot.\r\nSee comments about money drop in corpse, pickpocketing and luggage loot in creature_template and item_template.'),
(120,0,'spell_affect','This table holds information on what spells are affected by what spell mods. All spells in this table need to apply an aura that either adds a flat modifier to other spells or adds a percent modifier to other spells. Also, a single row in this table only holds information on a single spell effect that applies the aura. Therefore since a spell may have up to three effects, a maximum of 3 rows per spell is allowed. However, only the spell effects that apply the flat or percent auras will be used.'),
(121,0,'spell_area','This table holds information on what spells are applied to npcs/players in some areas.'),
(122,0,'spell_bonus_data','Table used for storing custom damage/healing bonus coefficients.'),
(123,0,'spell_chain','This table defines spell chains. A spell chain is a series of spells which all share the same name and all do the same thing; however, each has a different rank and as the rank increases, so does the spell damage/heal/etc values. This table also controls what spells are replaced by their more powerful later ranks; however, that is also decided by other factors as well (if mana costs for both spells are the same, etc). All fields in this table except rank are spell IDs from Spell.dbc.'),
(124,0,'spell_elixir','This table holds elixir information to be used to properly stack the elixirs.'),
(125,0,'spell_facing','This table holds information indicating whether a caster needs to face the target when casting a spell.'),
(126,0,'spell_learn_spell','This table holds information on spells that should be learned at the same time a player learns another spell. For example the few spells that are automatically learned when a player first learns a new profession. All fields in this table use spell IDs from Spell.dbc\r\n\r\nNOTE: Spells with spell effects SPELL_EFFECT_LEARN_SPELL should NOT be included in this table.'),
(127,0,'spell_linked','This table provides data for spell linking system, telling it what spells trigger what, and under what conditions.'),
(128,0,'spell_pet_auras','This table holds information for additional auras due to the pet. This mechanic implements character talents modifying the pet properties. If the character has aura/knows spell, then the pet get additional aura.'),
(129,0,'spell_proc_event','This table holds information on what events (or procs) certain spells are activated. All spells in this table must have apply a SPELL_AURA_PROC_TRIGGER_SPELL (42) aura. Any nonzero entries in this table will overwrite the existing proc settings in the spell’s DBC entry.'),
(130,0,'spell_proc_item_enchant','This table holds information for proc chances of spells which enchant weapons.<br/>\r\n<br/>\r\nThis also includes shaman weapon enchants.'),
(131,0,'spell_script_target','Used to control SpellEffect with ImpliciteTargetA-B == 7|8|38|40|46|52.\r\n\r\nThese spell effects require a specific target in either alive or dead state (for creatures).'),
(132,0,'spell_target_position','This table holds coordinate information on where the player should be teleported to when a spell with effect SPELL_EFFECT_TELEPORT_UNITS.'),
(133,0,'spell_threat','This table holds threat values on all spells that should either give or take away threat.'),
(134,0,'transports','This table contains all type 15 transports (Boats and Zeppelins). \r\n<br />\r\nAll other transport types have their frame time read from TransportAnimation.dbc.'),
(135,0,'world_template','This table holds informations for connection world continents to scripts from the script library.');
/*!40000 ALTER TABLE `dbdocstable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-31 23:46:33
