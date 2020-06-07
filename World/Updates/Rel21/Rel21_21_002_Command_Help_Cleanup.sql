-- ----------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update
-- Now compatible with newer MySql Databases (v1.5)
-- ----------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT `structure` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cCurContent := (SELECT `content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '21'; 
    SET @cOldContent = '001';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '21';
    SET @cNewContent = '002';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Command_Help_Cleanup';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Command_Help_Cleanup';

    -- Evaluate all settings
    SET @cCurResult := (SELECT `description` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
    SET @cOldResult := (SELECT `description` FROM `db_version` WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
		
delete from `command` where `id` in (1,3,4,5,6,7);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (1,'account',0,'Syntax: .account\r\n\r\nDisplay the access level of your account.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (3,'account create',4,'Syntax: .account create $account $password\r\n\r\nCreate account and set password to it.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (4,'account delete',4,'Syntax: .account delete $account\r\n\r\nDelete account with all characters.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (5,'account lock',0,'Syntax: .account lock [on|off]\r\n\r\nAllow login from account only from current used IP or remove this requirement.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (6,'account onlinelist',4,'Syntax: .account onlinelist\r\n\r\nShow list of online accounts.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (7,'account password',0,'Syntax: .account password $old_password $new_password $new_password\r\n\r\nChange your account password.');

delete from `command` where `id` in (11,12);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (11,'additem',3,'Syntax: .additem #itemid/[#itemname]/#shift-click-item-link #itemcount\r\n\r\nAdds the specified number of items of id #itemid (or exact (!) name $itemname in brackets, or link created by shift-click at item in inventory or recipe) to your or selected character inventory. If #itemcount is omitted, only one item will be added..');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (12,'additemset',3,'Syntax: .additemset #itemsetid\r\n\r\nAdd items from itemset of id #itemsetid to your or selected character inventory. Will add by one example each item from itemset.');

delete from `command` where `id` in (28,29);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (28,'announce',1,'Syntax: .announce $MessageToBroadcast\r\n\r\nSend a global message to all players online in chat log.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (29,'appear',1,'Syntax: .appear [$charactername]\r\n\r\nTeleport to the given character. Either specify the character name or click on the character\'s portrait, e.g. when you are in a group. Character can be offline.');

delete from `command` where `id` in (35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (35,'aura',3,'Syntax: .aura #spellid\r\n\r\nAdd the aura from spell #spellid to the selected Unit.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (36,'ban account',3,'Syntax: .ban account $Name $bantime $reason\r\n\r\nBan account kick player.$bantime: negative value leads to permban, otherwise use a timestring like 4d20h3s\"\".\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (37,'ban character',3,'Syntax: .ban character $Name $bantime $reason\r\n\r\nBan account and kick player.$bantime: negative value leads to permban, otherwise use a timestring like 4d20h3s\"\".\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (38,'ban ip',3,'Syntax: .ban ip $Ip $bantime $reason\r\n\r\nBan IP.$bantime: negative value leads to permban, otherwise use a timestring like 4d20h3s\"\".\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (39,'baninfo account',3,'Syntax: .baninfo account $accountid\r\n\r\nWatch full information about a specific ban.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (40,'baninfo character',3,'Syntax: .baninfo character $charactername\r\n\r\nWatch full information about a specific ban.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (41,'baninfo ip',3,'Syntax: .baninfo ip $ip\r\n\r\nWatch full information about a specific ban.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (42,'bank',3,'Syntax: .bank\r\n\r\nShow your bank inventory.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (43,'banlist account',3,'Syntax: .banlist account [$Name]\r\n\r\nSearches the banlist for a account name pattern or show full list account bans.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (44,'banlist character',3,'Syntax: .banlist character $Name\r\n\r\nSearches the banlist for a character name pattern. Pattern required.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (45,'banlist ip',3,'Syntax: .banlist ip [$Ip]\r\n\r\nSearches the banlist for a IP pattern or show full list of IP bans.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (46,'cast',3,'Syntax: .cast #spellid [triggered]\r\n\r\nCast #spellid to selected target. If no target selected cast to self. If \'trigered\' or part provided then spell casted with triggered flag.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (47,'cast back',3,'Syntax: .cast back #spellid [triggered]\r\n\r\nSelected target will cast #spellid to your character. If \'trigered\' or part provided then spell casted with triggered flag.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (48,'cast dist',3,'Syntax: .cast dist #spellid [#dist [triggered]\r\n\r\nYou will cast spell to pint at distance #dist. If \'trigered\' or part provided then spell casted with triggered flag. Not all spells can be casted as area spells.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (49,'cast self',3,'Syntax: .cast self #spellid [triggered]\r\n\r\nCast #spellid by target at target itself. If \'trigered\' or part provided then spell casted with triggered flag.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (50,'cast target',3,'Syntax: .cast target #spellid [triggered]\r\n\r\nSelected target will cast #spellid to his victim. If \'trigered\' or part provided then spell casted with triggered flag.');

delete from `command` where `id` in (56,57,58,59,60,61,62,63,64);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (56,'character level',3,'Syntax: .character level [$playername] [#level]\r\n\r\nSet the level of character with $playername (or the selected if not name provided) by #numberoflevels Or +1 if no #numberoflevels provided). If #numberoflevels is omitted, the level will be increase by 1. If #numberoflevels is 0, the same level will be restarted. If no character is selected and name not provided, increase your level. Command can be used for offline character. All stats and dependent values recalculated. At level decrease talents can be reset if need. Also at level decrease equipped items with greater level requirement can be lost.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (57,'character rename',2,'Syntax: .character rename [$name]\r\n\r\nMark selected in game or by $name in command character for rename at next login.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (58,'character reputation',2,'Syntax: .character reputation [$player_name]\r\n\r\nShow reputation information for selected player or player find by $player_name.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (59,'combatstop',2,'Syntax: .combatstop [$playername]\r\n\r\nStop combat for selected character. If selected non-player then command applied to self. If $playername provided then attempt applied to online player $playername.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (60,'commands',0,'Syntax: .commands\r\n\r\nDisplay a list of available commands for your account level.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (61,'cooldown',3,'Syntax: .cooldown [#spell_id]\r\n\r\nRemove all (if spell_id not provided) or #spel_id spell cooldown from selected character or you (if no selection).');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (62,'damage',3,'Syntax: .damage $damage_amount [$school [$spellid]]\r\n\r\nApply $damage to target. If not $school and $spellid provided then this flat clean melee damage without any modifiers. If $school provided then damage modified by armor reduction (if school physical),\n and target absorbing modifiers and result applied as melee damage to target. If spell provided then damage modified and applied as spell damage. $spellid can be shift-link.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (63,'debug anim',2,'Syntax: .debug anim #emoteid\r\n\r\nPlay emote #emoteid for your character.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (64,'debug bg',3,'Syntax: .debug bg\r\n\r\nToggle debug mode for battlegrounds. In debug mode GM can start battleground with single player.');

delete from `command` where `id` in (69,70,71);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (69,'debug play cinematic',1,'Syntax: .debug play cinematic #cinematicid\r\n\r\nPlay cinematic #cinematicid for you. You stay at place while your mind fly.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (70,'debug play sound',1,'Syntax: .debug play sound #soundid\r\n\r\nPlay sound with #soundid.Sound will be play only for you. Other players do not hear this.Warning: client may have more 5000 sounds...');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (71,'debug recv',3,'Syntax: .debug recv\r\n\r\nYou send the opcode described in the server-side ropcode.txt file.');

delete from `command` where `id` in (76,77,78,79,80,81,82,83,84,85,86,87,88,89);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (76,'demorph',2,'Syntax: .demorph\r\n\r\nDemorph the selected player.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (77,'die',3,'Syntax: .die\r\n\r\nKill the selected player. If no player is selected, it will kill you.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (78,'dismount',0,'Syntax: .dismount\r\n\r\nDismount you, if you are mounted.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (79,'distance',3,'Syntax: .distance [$name/$link]\r\n\r\nDisplay the distance from your character to the selected creature/player, or player with name $name, or player/creature/gameobject pointed to shift-link with guid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (80,'event',2,'Syntax: .event #event_id\r\n\r\nShow details about event with #event_id.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (81,'event list',2,'Syntax: .event list\r\n\r\nShow list of currently active events.Show list of all events');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (82,'event start',2,'Syntax: .event start #event_id\r\n\r\nStart event #event_id. Set start time for event to current moment (change not saved in DB).');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (83,'event stop',2,'Syntax: .event stop #event_id\r\n\r\nStop event #event_id. Set start time for event to time in past that make current moment is event stop time (change not saved in DB).');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (84,'explorecheat',3,'Syntax: .explorecheat #flag\r\n\r\nReveal or hide all maps for the selected player. If no player is selected, hide or reveal maps to you.Use a #flag of value 1 to reveal, use a #flag value of 0 to hide all maps.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (85,'gm',1,'Syntax: .gm [on/off]\r\n\r\nEnable or Disable in game GM MODE or show current state of on/off not provided.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (86,'gm chat',1,'Syntax: .gm chat [on/off]\r\n\r\nEnable or disable chat GM MODE (show gm badge in messages) or show current state of on/off not provided.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (87,'gm fly',3,'Syntax: .gm fly [on/off]\r\n\r\nEnable/disable gm fly mode.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (88,'gm ingame',0,'Syntax: .gm ingame\r\n\r\nDisplay a list of available in game Game Masters.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (89,'gm list',3,'Syntax: .gm list\r\n\r\nDisplay a list of all Game Masters accounts and security levels.');

delete from `command` where `id` in (91,92,93,94,95,96,97);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (91,'gm visible',1,'Syntax: .gm visible on/off\r\n\r\nOutput current visibility state or make GM visible(on) and invisible(off) for other players.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (92,'go',1,'Syntax: .go  [$playername|pointlink|#x #y #z [#mapid]]\r\n\r\nTeleport your character to point with coordinates of player $playername, or coordinates of one from shift-link types: player, tele, taxinode, creature/creature_entry, gameobject/gameobject_entry, or explicit #x #y #z #mapid coordinates.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (93,'go creature',1,'Syntax: .go creature (#creature_guid|$creature_name|id #creature_id)\r\n\r\nTeleport your character to creature with guid #creature_guid, or teleport your character to creature with name including as part $creature_name substring, or teleport your character to a creature that was spawned from the template with this entry #creature_id.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (94,'go graveyard',1,'Syntax: .go graveyard #graveyardId\r\n\r\nTeleport to graveyard with the graveyardId specified.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (95,'go grid',1,'Syntax: .go grid #gridX #gridY [#mapId]\r\n\r\nTeleport the gm to center of grid with provided indexes at map #mapId (or current map if it not provided).');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (96,'go object',1,'Syntax: .go object (#gameobject_guid|$gameobject_name|id #gameobject_id)\r\n\r\nTeleport your character to gameobject with guid #gameobject_guid, or teleport your character to gameobject with name including as part $gameobject_name substring, or teleport your character to a gameobject that was spawned from the template with this entry #gameobject_id.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (97,'go taxinode',1,'Syntax: .go taxinode #taxinode\r\n\r\nTeleport player to taxinode coordinates. You can look up zone using .lookup taxinode $namepart');

delete from `command` where `id` in (99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (99,'go xy',1,'Syntax: .go xy #x #y [#mapid]\r\n\r\nTeleport player to point with (#x,#y) coordinates at ground(water) level at map #mapid or same map if #mapid not provided.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (100,'go xyz',1,'Syntax: .go xyz #x #y #z [#mapid]\r\n\r\nTeleport player to point with (#x,#y,#z) coordinates at ground(water) level at map #mapid or same map if #mapid not provided.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (101,'go zonexy',1,'Syntax: .go zonexy #x #y [#zone]\r\n\r\nTeleport player to point with (#x,#y) client coordinates at ground(water) level in zone #zoneid or current zone if #zoneid not provided. You can look up zone using .lookup area $namepart');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (102,'gobject add',2,'Syntax: .gobject add #id <spawntimeSecs>\r\n\r\nAdd a game object from game object templates to the world at your current location using the #id.spawntimesecs sets the spawntime, it is optional.Note: this is a copy of .gameobject.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (103,'gobject delete',2,'Syntax: .gobject delete #go_guid\r\n\r\nDelete gameobject with guid #go_guid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (104,'gobject move',2,'Syntax: .gobject move #goguid [#x #y #z]\r\n\r\nMove gameobject #goguid to character coordinates (or to (#x,#y,#z) coordinates if its provide).');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (105,'gobject near',2,'Syntax: .gobject near  [#distance]\r\n\r\nOutput gameobjects at distance #distance from player. Output gameobject guids and coordinates sorted by distance from character. If #distance not provided use 10 as default value.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (106,'gobject target',2,'Syntax: .gobject target [#go_id|#go_name_part]\r\n\r\nLocate and show position nearest gameobject. If #go_id or #go_name_part provide then locate and show position of nearest gameobject with gameobject template id #go_id or name included #go_name_part as part.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (107,'gobject turn',2,'Syntax: .gobject turn #goguid\r\n\r\nSet for gameobject #goguid orientation same as current character orientation.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (108,'gps',1,'Syntax: .gps [$name|$shift-link]\r\n\r\nDisplay the position information for a selected character or creature (also if player name $name provided then for named player, or if creature/gameobject shift-link provided then pointed creature/gameobject if it loaded). Position information includes X, Y, Z, and orientation, map Id and zone Id');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (109,'groupgo',1,'Syntax: .groupgo [$charactername]\r\n\r\nTeleport the given character and his group to you. Teleported only online characters but original selected group member can be offline.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (110,'guid',2,'Syntax: .guid\r\n\r\nDisplay the GUID for the selected character.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (111,'guild create',2,'Syntax: .guild create [$GuildLeaderName] $GuildName\"\"\r\n\r\nCreate a guild named $GuildName with the player $GuildLeaderName (or selected) as leader.  Guild name must in quotes.\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (112,'guild delete',2,'Syntax: .guild delete $GuildName\"\"\r\n\r\nDelete guild $GuildName. Guild name must in quotes.\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (113,'guild invite',2,'Syntax: .guild invite [$CharacterName] $GuildName\"\"\r\n\r\nAdd player $CharacterName (or selected) into a guild $GuildName. Guild name must in quotes.\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (114,'guild rank',2,'Syntax: .guild rank $CharacterName #Rank\r\n\r\nSet for $CharacterName rank #Rank in a guild.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (115,'guild uninvite',2,'Syntax: .guild uninvite [$CharacterName]\r\n\r\nRemove player $CharacterName (or selected) from a guild.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (116,'help',0,'Syntax: .help [$command]\r\n\r\nDisplay usage instructions for the given $command. If no $command provided show list available commands.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (117,'hidearea',3,'Syntax: .hidearea #areaid\r\n\r\nHide the area of #areaid to the selected character. If no character is selected, hide this area to you.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (118,'honor add',2,'Syntax: .honor add $amount\r\n\r\nAdd a certain amount of honor (gained in lifetime) to the selected player.');

delete from `command` where `id` in (120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,144);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (120,'honor show',1,'Syntax: .honor show\r\n\r\nDisplay the honor stats of the selected player');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (121,'honor update',2,'Syntax: .honor update\r\n\r\nForce honor to be update');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (122,'instance listbinds',3,'Syntax: .instance listbinds\r\n\r\nLists the binds of the selected player.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (123,'instance savedata',3,'Syntax: .instance savedata\r\n\r\nSave the InstanceData for the current player\'s map to the DB.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (124,'instance stats',3,'Syntax: .instance stats\r\n\r\nShows statistics about instances.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (125,'instance unbind',3,'Syntax: .instance unbind all\r\n\r\nAll of the selected player\'s binds will be cleared..instance unbind #mapid Only the specified #mapid instance will be cleared.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (126,'itemmove',2,'Syntax: .itemmove #sourceslotid #destinationslotid\r\n\r\nMove an item from slots #sourceslotid to #destinationslotid in your inventoryNot yet implemented');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (127,'kick',2,'Syntax: .kick [$charactername]\r\n\r\nKick the given character name from the world. If no character name is provided then the selected player (except for yourself) will be kicked.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (128,'learn',3,'Syntax: .learn #spell [all]\r\n\r\nSelected character learn a spell of id #spell. If \'all\' provided then all ranks learned.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (129,'learn all',3,'Syntax: .learn all\r\n\r\nLearn all big set different spells, maybe useful for Administrators.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (130,'learn all_crafts',2,'Syntax: .learn crafts\r\n\r\nLearn all professions and recipes.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (131,'learn all_default',1,'Syntax: .learn all_default [$playername]\r\n\r\nLearn for selected/$playername player all default spells for his race/class and spells rewarded by completed quests.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (132,'learn all_gm',2,'Syntax: .learn all_gm\r\n\r\nLearn all default spells for Game Masters.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (133,'learn all_lang',1,'Syntax: .learn all_lang\r\n\r\nLearn all languages');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (134,'learn all_myclass',3,'Syntax: .learn all_myclass\r\n\r\nLearn all spells and talents available for his class.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (135,'learn all_myspells',3,'Syntax: .learn all_myspells\r\n\r\nLearn all spells (except talents and spells with first rank learned as talent) available for his class.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (136,'learn all_mytalents',3,'Syntax: .learn all_mytalents\r\n\r\nLearn all talents (and spells with first rank learned as talent) available for his class.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (137,'learn all_recipes',2,'Syntax: .learn all_recipes [$profession]\r\n\r\nLearns all recipes of specified profession and sets skill level to max.Example: .learn all_recipes enchanting');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (138,'levelup',3,'Syntax: .levelup [$playername] [#numberoflevels]\r\n\r\nIncrease/decrease the level of character with $playername (or the selected if not name provided) by #numberoflevels Or +1 if no #numberoflevels provided). If #numberoflevels is omitted, the level will be increase by 1. If #numberoflevels is 0, the same level will be restarted. If no character is selected and name not provided, increase your level. Command can be used for offline character. All stats and dependent VALUESrecalculated. At level decrease talents can be reset if need. Also at level decrease equipped items with greater level requirement can be lost.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (139,'linkgrave',3,'Syntax: .linkgrave #graveyard_id [alliance|horde]\r\n\r\nLink current zone to graveyard for any (or alliance/horde faction ghosts). This let character ghost from zone teleport to graveyard after die if graveyard is nearest from linked to zone and accept ghost of this faction. Add only single graveyard at another map and only if no graveyards linked (or planned linked at same map).');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (140,'list creature',3,'Syntax: .list creature #creature_id [#max_count]\r\n\r\nOutput creatures with creature id #creature_id found in world. Output creature guids and coordinates sorted by distance from character. Will be output maximum #max_count creatures. If #max_count not provided use 10 as default value.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (141,'list item',3,'Syntax: .list item #item_id [#max_count]\r\n\r\nOutput items with item id #item_id found in all character inventories, mails, auctions, and guild banks. Output item guids, item owner guid, owner account and owner name (guild name and guid in case guild bank). Will be output maximum #max_count items. If #max_count not provided use 10 as default value.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (142,'list object',3,'Syntax: .list object #gameobject_id [#max_count]\r\n\r\nOutput gameobjects with gameobject id #gameobject_id found in world. Output gameobject guids and coordinates sorted by distance from character. Will be output maximum #max_count gameobject. If #max_count not provided use 10 as default value.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (144,'loadscripts',3,'Syntax: .loadscripts $scriptlibraryname\r\n\r\nUnload current and load the script library $scriptlibraryname or reload current if $scriptlibraryname omitted, in case you changed it while the server was running.');

delete from `command` where `id` in (148,149,150,151,152,153,154);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (148,'lookup area',1,'Syntax: .lookup area $namepart\r\n\r\nLooks up an area by $namepart, and returns all matches with their area ID\'s.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (149,'lookup creature',3,'Syntax: .lookup creature $namepart\r\n\r\nLooks up a creature by $namepart, and returns all matches with their creature ID\'s.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (150,'lookup event',2,'Syntax: .lookup event $name\r\n\r\nAttempts to find the ID of the event with the provided $name.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (151,'lookup faction',3,'Syntax: .lookup faction $name\r\n\r\nAttempts to find the ID of the faction with the provided $name.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (152,'lookup item',3,'Syntax: .lookup item $itemname\r\n\r\nLooks up an item by $itemname, and returns all matches with their Item ID\'s.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (153,'lookup itemset',3,'Syntax: .lookup itemset $itemname\r\n\r\nLooks up an item set by $itemname, and returns all matches with their Item set ID\'s.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (154,'lookup object',3,'Syntax: .lookup object $objname\r\n\r\nLooks up an gameobject by $objname, and returns all matches with their Gameobject ID\'s.');

delete from `command` where `id` in (159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (159,'lookup quest',3,'Syntax: .lookup quest $namepart\r\n\r\nLooks up a quest by $namepart, and returns all matches with their quest ID\'s.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (160,'lookup skill',3,'Syntax: .lookup skill $$namepart\r\n\r\nLooks up a skill by $namepart, and returns all matches with their skill ID\'s.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (161,'lookup spell',3,'Syntax: .lookup spell $namepart\r\n\r\nLooks up a spell by $namepart, and returns all matches with their spell ID\'s.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (162,'lookup taxinode',3,'Syntax: .lookup taxinode $substring\r\n\r\nSearch and output all taxinodes with provide $substring in name.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (163,'lookup tele',1,'Syntax: .lookup tele $substring\r\n\r\nSearch and output all .tele command locations with provide $substring in name.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (164,'maxskill',3,'Syntax: .maxskill\r\n\r\nSets all skills of the targeted player to their maximum VALUESfor its current level.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (165,'modify aspeed',1,'Syntax: .modify aspeed #rate\r\n\r\nModify all speeds -run,swim,run back,swim back- of the selected player to \r ormalbase speed for this move type\"\"*rate. If no player is selected, modify your speed. #rate may range from 0.1 to GM.MaxSpeedFactor defined in mangosd.conf.\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (166,'modify bwalk',1,'Syntax: .modify bwalk #rate\r\n\r\nModify the speed of the selected player while running backwards to \r ormal walk back speed\"\"*rate. If no player is selected, modify your speed. #rate may range from 0.1 to GM.MaxSpeedFactor defined in mangosd.conf.\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (167,'modify drunk',1,'Syntax: .modify drunk #value\r\n\r\nSet drunk level to #value (0..100). Value 0 remove drunk state, 100 is max drunked state.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (168,'modify energy',1,'Syntax: .modify energy #energy\r\n\r\nModify the energy of the selected player. If no player is selected, modify your energy.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (169,'modify faction',1,'Syntax: .modify faction #factionid #flagid #npcflagid #dynamicflagid\r\n\r\nModify the faction and flags of the selected creature. Without arguments, display the faction and flags of the selected creature.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (170,'modify gender',2,'Syntax: .modify gender male/female\r\n\r\nChange gender of selected player.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (171,'modify honor',2,'Syntax: .modify honor $field $value\r\n\r\nAdd $value to an honor $field (it\'s just for debug , values won\'t be saved at player logout)Field list: points / rank / todaykills / yesterdaykills / yesterdayhonor /thisweekkills / thisweekhonor / lastweekkills / lastweekhonor /lastweekstanding / lifetimedishonorablekills / lifetimehonorablekills ');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (172,'modify hp',1,'Syntax: .modify hp #newhp\r\n\r\nModify the hp of the selected player. If no player is selected, modify your hp.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (173,'modify mana',1,'Syntax: .modify mana #newmana\r\n\r\nModify the mana of the selected player. If no player is selected, modify your mana.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (174,'modify money',1,'Syntax: .modify money #money.money #money\r\n\r\nAdd or remove money to the selected player. If no player is selected, modify your money. #gold can be negative to remove money.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (175,'modify morph',2,'Syntax: .modify morph #displayid\r\n\r\nChange your current model id to #displayid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (176,'modify mount',1,'Syntax: .modify mount #id #speed\r\n\r\nDisplay selected player as mounted at #id creature and set speed to #speed value.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (177,'modify rage',1,'Syntax: .modify rage #newrage\r\n\r\nModify the rage of the selected player. If no player is selected, modify your rage.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (178,'modify rep',2,'Syntax: .modify rep #repId (#repvalue | $rankname [#delta])\r\n\r\nSets the selected players reputation with faction #repId to #repvalue or to $reprank.If the reputation rank name is provided, the resulting reputation will be the lowest reputation for that rank plus the delta amount, if specified.You can use \'.pinfo rep\' to list all known reputation ids, or use \'.lookup faction $name\' to locate a specific faction id.');

delete from `command` where `id` in (180,181,182,183,184,185,186,187,189);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (180,'modify speed',1,'Syntax: .modify speed #rate.speed #rate\r\n\r\nModify the running speed of the selected player to \r ormal base run speed\"\"*rate. If no player is selected, modify your speed. #rate may range from 0.1 to GM.MaxSpeedFactor defined in mangosd.conf.\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (181,'modify standstate',2,'Syntax: .modify standstate #emoteid\r\n\r\nChange the emote of your character while standing to #emoteid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (182,'modify swim',1,'Syntax: .modify swim #rate\r\n\r\nModify the swim speed of the selected player to \r ormal swim speed\"\"*rate. If no player is selected, modify your speed. #rate may range from 0.1 to GM.MaxSpeedFactor defined in mangosd.conf.\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (183,'movegens',3,'Syntax: .movegens\r\n\r\nShow movement generators stack for selected creature or player.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (184,'mute',1,'Syntax: .mute [$playerName] $timeInMinutes\r\n\r\nDisible chat messaging for any character from account of character $playerName (or currently selected) at $timeInMinutes minutes. Player can be offline.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (185,'neargrave',3,'Syntax: .neargrave [alliance|horde]\r\n\r\nFind nearest graveyard linked to zone (or only nearest from accepts alliance or horde faction ghosts).');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (186,'notify',1,'Syntax: .notify $MessageToBroadcast\r\n\r\nSend a global message to all players online in screen.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (187,'npc add',2,'Syntax: .npc add #creatureid\r\n\r\nSpawn a creature by the given template id of #creatureid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (189,'npc addweapon',3,'Not yet implemented.');

delete from `command` where `id` in (191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (191,'npc allowmove',3,'Syntax: .npc allowmove\r\n\r\nEnable or disable movement creatures in world. Not implemented.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (192,'npc changelevel',2,'Syntax: .npc changelevel #level\r\n\r\nChange the level of the selected creature to #level.#level may range from 1 to 63.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (193,'npc delete',2,'Syntax: .npc delete [#guid]\r\n\r\nDelete creature with guid #guid (or the selected if no guid is provided)');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (194,'npc delitem',2,'Syntax: .npc delitem #itemId\r\n\r\nRemove item #itemid from item list of selected vendor.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (195,'npc factionid',2,'Syntax: .npc factionid #factionid\r\n\r\nSet the faction of the selected creature to #factionid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (196,'npc flag',2,'Syntax: .npc flag #npcflag\r\n\r\nSet the NPC flags of creature template of the selected creature and selected creature to #npcflag. NPC flags will applied to all creatures of selected creature template after server restart or grid unload/load.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (197,'npc follow',2,'Syntax: .npc follow\r\n\r\nSelected creature start follow you until death/fight/etc.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (198,'npc info',3,'Syntax: .npc info\r\n\r\nDisplay a list of details for the selected creature.The list includes:- GUID, Faction, NPC flags, Entry ID, Model ID,- Level,- Health (current/maximum),\n- Field flags, dynamic flags, faction template, - Position information,- and the creature type, e.g. if the creature is a vendor.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (199,'npc move',2,'Syntax: .npc move [#creature_guid]\r\n\r\nMove the targeted creature spawn point to your coordinates.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (200,'npc name',2,'Syntax: .npc name $name\r\n\r\nChange the name of the selected creature or character to $name.Command disabled.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (201,'npc playemote',3,'Syntax: .npc playemote #emoteid\r\n\r\nMake the selected creature emote with an emote of id #emoteid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (202,'npc say',1,'Syntax: .npc say #text\r\n\r\nMake the selected npc says #text.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (203,'npc setdeathstate',2,'Syntax: .npc setdeathstate on/off\r\n\r\nSet default death state (dead/alive) for npc at spawn.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (204,'npc setmodel',2,'Syntax: .npc setmodel #displayid\r\n\r\nChange the model id of the selected creature to #displayid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (205,'npc setmovetype',2,'Syntax: .npc setmovetype [#creature_guid] stay/random/way [NODEL]\r\n\r\nSet for creature pointed by #creature_guid (or selected if #creature_guid not provided) movement type and move it to respawn position (if creature alive). Any existing waypoints for creature will be removed from the database if you do not use NODEL. If the creature is dead then movement type will applied at creature respawn.Make sure you use NODEL, if you want to keep the waypoints.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (206,'npc spawndist',2,'Syntax: .npc spawndist #dist\r\n\r\nAdjust spawndistance of selected creature to dist.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (207,'npc spawntime',2,'Syntax: .npc spawntime #time\r\n\r\nAdjust spawntime of selected creature to time.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (208,'npc subname',2,'Syntax: .npc subname $Name\r\n\r\nChange the subname of the selected creature or player to $Name.Command disabled.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (209,'npc tame',2,'Syntax: .npc tame\r\n\r\nTame selected creature (tameable non pet creature). You don\'t must have pet.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (210,'npc textemote',1,'Syntax: .npc textemote #emoteid\r\n\r\nMake the selected creature to do textemote with an emote of id #emoteid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (211,'npc unfollow',2,'Syntax: .npc unfollow\r\n\r\nSelected creature (non pet) stop follow you.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (212,'npc whisper',1,'Syntax: .npc whisper #playerguid #text\r\n\r\nMake the selected npc whisper #text to  #playerguid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (213,'npc yell',1,'Syntax: .npc yell #text\r\n\r\nMake the selected npc yells #text.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (214,'pdump load',3,'Syntax: .pdump load $filename $account [$newname] [$newguid]\r\n\r\nLoad character dump from dump file into character list of $account with saved or $newname, with saved (or first free) or $newguid guid.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (215,'pdump write',3,'Syntax: .pdump write $filename $playerNameOrGUID\r\n\r\nWrite character dump with name/guid $playerNameOrGUID to file $filename.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (216,'pinfo',2,'Syntax: .pinfo [$player_name]\r\n\r\nOutput account information for selected player or player find by $player_name.');

delete from `command` where `id` in (220,221,222,224,225,226,229,230,232);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (220,'quest add',3,'Syntax: .quest add #quest_id\r\n\r\nAdd to character quest log quest #quest_id. Quest started from item can\'t be added by this command but correct .additem call provided in command output.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (221,'quest complete',3,'Syntax: .quest complete #questid\r\n\r\nMark all quest objectives as completed for target character active quest. After this target character can go and get quest reward.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (222,'quest remove',3,'Syntax: .quest remove #quest_id\r\n\r\nSet quest #quest_id state to not completed and not active (and remove from active quest list) for selected player.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (224,'recall',1,'Syntax: .recall [$playername]\r\n\r\nTeleport $playername or selected player to the place where he has been before last use of a teleportation command. If no $playername is entered and no player is selected, it will teleport you.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (225,'reload all',3,'Syntax: .reload all\r\n\r\nReload all tables with reload support added and that can be _safe_ reloaded.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (226,'reload all_area',3,'Syntax: .reload all_area\r\n\r\nReload all `areatrigger_*` tables if reload support added for this table and this table can be _safe_ reloaded.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (229,'reload all_locales',3,'Syntax: .reload all_locales\r\n\r\nReload all `locales_*` tables with reload support added and that can be _safe_ reloaded.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (230,'reload all_loot',3,'Syntax: .reload all_loot\r\n\r\nReload all `*_loot_template` tables. This can be slow operation with lags for server run.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (232,'reload all_quest',3,'Syntax: .reload all_quest\r\n\r\nReload all quest related tables if reload support added for this table and this table can be _safe_ reloaded.');

delete from `command` where `id` in (234,235,236,237,238,239,240,241,242,243,244,245,246,247,248);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (234,'reload all_spell',3,'Syntax: .reload all_spell\r\n\r\nReload all `spell_*` tables with reload support added and that can be _safe_ reloaded.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (235,'reload config',3,'Syntax: .reload config\r\n\r\nReload config settings (by default stored in mangosd.conf). Not all settings can be change at reload: some new setting values will be ignored until restart, some values will applied with delay or only to new objects/maps, some values will explicitly rejected to change at reload.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (236,'repairitems',2,'Syntax: .repairitems\r\n\r\nRepair all selected player\'s items.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (237,'reset all',3,'Syntax: .reset all\r\n\r\nRequest reset spells,talents etc. at next login each existing character.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (238,'reset honor',3,'Syntax: .reset honor [Playername]\r\n\r\nReset all honor data for targeted character.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (239,'reset level',3,'Syntax: .reset level [Playername]\r\n\r\nReset level to 1 including reset stats and talents.  Equipped items with greater level requirement can be lost.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (240,'reset spells',3,'Syntax: .reset spells [Playername]\r\n\r\nRemoves all non-original spells from spellbook.. Playername can be name of offline character.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (241,'reset stats',3,'Syntax: .reset stats [Playername]\r\n\r\nResets(recalculate) all stats of the targeted player to their original VALUESat current level.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (242,'reset talents',3,'Syntax: .reset talents [Playername]\r\n\r\nRemoves all talents of the targeted player. Playername can be name of offline character.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (243,'respawn',3,'Syntax: .respawn\r\n\r\nRespawn selected creature or respawn all nearest creatures (if none selected) and GO without waiting respawn time expiration.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (244,'revive',3,'Syntax: .reviveRevive the selected player. If no player is selected, it will revive you.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (245,'save',0,'Syntax: .save\r\n\r\nSaves your character.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (246,'saveall',1,'Syntax: .saveall\r\n\r\nSave all characters in game.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (247,'send items',3,'Syntax: .send items #playername #subject\"\" \"\"#text\"\" itemid1[:count1] itemid2[:count2] ... itemidN[:countN]\r\n\r\nSend a mail to a player. Subject and mail text must be in \"\"\"\". If for itemid not provided related count values then expected 1, if count > max items in stack then items will be send in required amount stacks. All stacks amount in mail limited to 12.\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (248,'send mail',1,'Syntax: .send mail #playername #subject\"\" \"\"#text\"\"\r\n\r\nSend a mail to a player. Subject and mail text must be in \"\"\"\".\"');

delete from `command` where `id` in (252,253,254,255,256,257,258,259,260,263,264,265,266,267);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (252,'send message',3,'Syntax: .send message $playername $message\r\n\r\nSend screen message to player from ADMINISTRATOR.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (253,'send money',3,'Syntax: .send money #playername #subject\"\" \"\"#text\"\" #money\r\n\r\nSend mail with money to a player. Subject and mail text must be in \"\"\"\".\"');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (254,'server corpses',2,'Syntax: .server corpses\r\n\r\nTriggering corpses expire check in world.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (255,'server exit',4,'Syntax: .server exit\r\n\r\nTerminate mangosd NOW. Exit code 0.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (256,'server idlerestart',3,'Syntax: .server idlerestart #delay\r\n\r\nRestart the server after #delay seconds if no active connections are present (no players). Use #exist_code or 2 as program exist code.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (257,'server idlerestart cancel',3,'Syntax: .server idlerestart cancel\r\n\r\nCancel the restart/shutdown timer if any.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (258,'server idleshutdown',3,'Syntax: .server idleshutdown #delay [#exist_code]\r\n\r\nShut the server down after #delay seconds if no active connections are present (no players). Use #exist_code or 0 as program exist code.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (259,'server idleshutdown cancel',3,'Syntax: .server idleshutdown cancel\r\n\r\nCancel the restart/shutdown timer if any.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (260,'server info',0,'Syntax: .server info\r\n\r\nDisplay server version and the number of connected players.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (263,'server motd',0,'Syntax: .server motd\r\n\r\nShow server Message of the day.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (264,'server plimit',3,'Syntax: .server plimit [#num|-1|-2|-3|reset|player|moderator|gamemaster|administrator]\r\n\r\nWithout arg show current player amount and security level limitations for login to server, with arg set player linit ($num > 0) or securiti limitation ($num < 0 or security leme name. With `reset` sets player limit to the one in the config file');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (265,'server restart',3,'Syntax: .server restart #delay\r\n\r\nRestart the server after #delay seconds. Use #exist_code or 2 as program exist code.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (266,'server restart cancel',3,'Syntax: .server restart cancel\r\n\r\nCancel the restart/shutdown timer if any.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (267,'server set motd',3,'Syntax: .server set motd $MOTD\r\n\r\nSet server Message of the day.');

delete from `command` where `id` in (269,270,271,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (269,'server shutdown cancel',3,'Syntax: .server shutdown cancel\r\n\r\nCancel the restart/shutdown timer if any.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (270,'setskill',3,'Syntax: .setskill #skill #level [#max]\r\n\r\nSet a skill of id #skill with a current skill value of #level and a maximum value of #max (or equal current maximum if not provide) for the selected character. If no character is selected, you learn the skill.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (271,'showarea',3,'Syntax: .showarea #areaid\r\n\r\nReveal the area of #areaid to the selected character. If no character is selected, reveal this area to you.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (273,'start',0,'Syntax: .start\r\n\r\nTeleport you to the starting area of your character.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (274,'summon',1,'Syntax: .summon [$charactername]\r\n\r\nTeleport the given character to you. Character can be offline.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (275,'taxicheat',1,'Syntax: .taxicheat on/off\r\n\r\nTemporary grant access or remove to all taxi routes for the selected character. If no character is selected, hide or reveal all routes to you.Visited taxi nodes sill accessible after removing access.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (276,'tele',1,'Syntax: .tele #location\r\n\r\nTeleport player to a given location.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (277,'tele add',3,'Syntax: .tele add $name\r\n\r\nAdd current your position to .tele command target locations list with name $name.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (278,'tele del',3,'Syntax: .tele del $name\r\n\r\nRemove location with name $name for .tele command locations list.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (279,'tele group',1,'Syntax: .tele group#location\r\n\r\nTeleport a selected player and his group members to a given location.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (280,'tele name',1,'Syntax: .tele name [#playername] #location\r\n\r\nTeleport the given character to a given location. Character can be offline.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (281,'ticket accept',3,'Syntax: .ticket accept (on|off)\r\n\r\nTurning on/off the whole ticket accepting system.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (282,'ticket close',2,'Syntax: .ticket close (#ID|$name)\r\n\r\nClosing the ticket.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (283,'ticket delete',3,'Syntax: .ticket delete (#ID|$name)\r\n\r\nDelete ticket from the list. It will reappear after server restart.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (284,'ticket info',1,'Syntax: .ticket info\r\n\r\nInformation on the tickets and your relation to them.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (285,'ticket list',2,'Syntax: .ticket list\r\n\r\nGet list of ticket IDs with player GUIDs and last change date.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (286,'ticket meaccept',2,'Syntax: .ticket meaccept [(on|off)]\r\n\r\nSet you informing about incoming tickets, or show its status.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (287,'ticket onlinelist',2,'Syntax: .ticket onlinelist\r\n\r\nGet list of the tickets for online players only.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (288,'ticket respond',2,'Syntax: .ticket respond (#ID|$name) $responce_text\r\n\r\nSend your responce to the ticket as whisper chat.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (289,'ticket show',2,'Syntax: .ticket show (#ID|$name)\r\n\r\nShow details about the ticket.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (290,'ticket surveyclose',2,'Syntax: .ticket surveyclose (#ID|$name)\r\n\r\nClosing the ticket with the user survey.');

delete from `command` where `id` in (294,295,296,297,298,299,300,301,302,303,304,305,306,307);
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (294,'unaura',3,'Syntax: .unaura #spellid\r\n\r\nRemove aura due to spell #spellid from the selected Unit.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (295,'unban account',3,'Syntax: .unban account $Name\r\n\r\nUnban accounts for account name pattern.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (296,'unban character',3,'Syntax: .unban character $Name\r\n\r\nUnban accounts for character name pattern.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (297,'unban ip',3,'Syntax: .unban ip $Ip\r\n\r\nUnban accounts for IP pattern.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (298,'unlearn',3,'Syntax: .unlearn #spell [all]\r\n\r\nUnlearn for selected player a spell #spell.  If \'all\' provided then all ranks unlearned.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (299,'unmute',1,'Syntax: .unmute $playerName\r\n\r\nRestore chat messaging for any character from account of character $playerName.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (300,'waterwalk',2,'Syntax: .waterwalk on/off\r\n\r\nSet on/off waterwalk state for selected player.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (301,'wchange',3,'Syntax: .wchange #weathertype #status\r\n\r\nSet current weather to #weathertype with an intensity of #status.#weathertype can be 1 for rain, 2 for snow, and 3 for sand. #status can be 0 for disabled, and 1 for enabled.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (302,'whispers',1,'Syntax: .whispers on|off\r\n\r\nEnable/disable accepting whispers by GM from players. By default use mangosd.conf setting.');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (303,'wp add',2,'Syntax: .wp add [Selected Creature or dbGuid] [pathId [wpOrigin] ]');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (304,'wp export',3,'Syntax: .wp export [#creature_guid or Select a Creature] $filename');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (305,'wp modify',2,'Syntax: .wp modify command [dbGuid, id] [value]\r\n\r\nwhere command must be one of: waittime  | scriptid | orientation | del | move\r\nIf no waypoint was selected, one can be chosen with dbGuid and id.\r\nThe commands have the following meaning:\r\n waittime (Set the time the npc will wait at a point (in ms))\r\n scriptid (Set the DB-Script that will be executed when the wp is reached)\r\n orientation (Set the orientation of this point) \r\n del (Remove the waypoint from the path)\r\n move (Move the wayoint to the current position of the player)');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (306,'wp show',2,'Syntax: .wp show command [dbGuid] [pathId [wpOrigin] ]\r\n\r\nwhere command can have one of the following values\r\non (to show all related wp)\r\nfirst (to see only first one)\r\nlast (to see only last one)\r\noff (to hide all related wp)\r\ninfo (to get more info about theses wp)\r\n\r\nFor using info you have to do first show on and than select a Visual-Waypoint and do the show info!\r\nwith pathId and wpOrigin you can specify which path to show (optional)');
insert  into `command`(`id`,`command_text`,`security`,`help_text`) values (307,'reset items',3,'Syntax: .reset items equiped|bags|bank|keyring|all|allbags.\r\n\r\nDelete all items in the selecter player inventory (equiped, bank, bags etc...) depending on the chosen option.');

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
            -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
            -- UPDATE THE DB VERSION
            -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
            INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
            SET @cNewResult := (SELECT `description` FROM `db_version` WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

            SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,@cNewResult AS `===== DB is now on Version =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cCurResult AS `===== DB is already on Version =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
                IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                ELSE
                    SET @cCurVersion := (SELECT `version` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurStructure := (SELECT `STRUCTURE` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurContent := (SELECT `Content` FROM `db_version` ORDER BY `version` DESC, `STRUCTURE` DESC, `CONTENT` DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                END IF;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;


