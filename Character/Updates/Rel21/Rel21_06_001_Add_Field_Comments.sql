-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update (v1.4)
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
    SET @cOldStructure = '05'; 
    SET @cOldContent = '004';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '06'; -- If The Update contains any 'ALTER DATABASE' statements, increment this and set cNewContent to 001
    SET @cNewContent = '001';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Add_field_comments';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Add_field_comments_from_Dbdocs';

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

ALTER TABLE ahbot_category MODIFY COLUMN `category` VARCHAR(45) COMMENT 'An Item category Id';
ALTER TABLE ahbot_category MODIFY COLUMN `expire_time` BIGINT(20) NOT NULL COMMENT 'The UNIX time when the item will expire.';
ALTER TABLE ahbot_category MODIFY COLUMN `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier of the category';
ALTER TABLE ahbot_category MODIFY COLUMN `max_auction_count` BIGINT(20) NOT NULL COMMENT 'The max number of items of this category in the AH. ';
ALTER TABLE ahbot_category MODIFY COLUMN `multiplier` DECIMAL(20,2) NOT NULL COMMENT 'The cost multiplier';
ALTER TABLE ahbot_history MODIFY COLUMN `category` VARCHAR(45) COMMENT 'An Item category Id from the list below:';
ALTER TABLE ai_playerbot_names MODIFY COLUMN `gender` TINYINT(3) UNSIGNED NOT NULL COMMENT 'The Gender of the bot';
ALTER TABLE ai_playerbot_names MODIFY COLUMN `race` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'The Race of the bot';
ALTER TABLE auction MODIFY COLUMN `buyguid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the highest bidder. See (character.guid)';
ALTER TABLE auction MODIFY COLUMN `buyoutprice` INT(11) NOT NULL DEFAULT '0' COMMENT 'The buyout price of the item in copper.';
ALTER TABLE auction MODIFY COLUMN `deposit` INT(11) NOT NULL DEFAULT '0' COMMENT 'The amount of copper spent on the deposit.';
ALTER TABLE auction MODIFY COLUMN `houseid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The AuctionHouseId (See AuctionHouse.dbc)';
ALTER TABLE auction MODIFY COLUMN `id` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Unique identifier for every auction.';
ALTER TABLE auction MODIFY COLUMN `itemguid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the item that is up for auction. (See item_instance.guid)';
ALTER TABLE auction MODIFY COLUMN `itemowner` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the owner of the item up for auction. (See character.guid)';
ALTER TABLE auction MODIFY COLUMN `item_count` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The stack count of the item';
ALTER TABLE auction MODIFY COLUMN `item_randompropertyid` INT(11) NOT NULL DEFAULT '0' COMMENT 'A link to the Item''s RandomProperty Id (See item_template.Randompropertyid).';
ALTER TABLE auction MODIFY COLUMN `item_template` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The entry of the item up for auction. See (item_template.entry)';
ALTER TABLE auction MODIFY COLUMN `lastbid` INT(11) NOT NULL DEFAULT '0' COMMENT 'The amount of copper of the last bid made on the item.';
ALTER TABLE auction MODIFY COLUMN `startbid` INT(11) NOT NULL DEFAULT '0' COMMENT 'The amount of copper of the starting bid made on the item.';
ALTER TABLE auction MODIFY COLUMN `time` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The time when this auction will end, measured in Unix time.';
ALTER TABLE bugreport MODIFY COLUMN `content` LONGTEXT NOT NULL COMMENT 'The text content of the bug/suggestion.';
ALTER TABLE bugreport MODIFY COLUMN `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto generated value when records are inserted by the core.';
ALTER TABLE bugreport MODIFY COLUMN `type` LONGTEXT NOT NULL COMMENT 'The text description of the type of bug report / suggestion.';
ALTER TABLE characters MODIFY COLUMN `account` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The account ID in which this character resides (See account.id) in the realm db.';
ALTER TABLE characters MODIFY COLUMN `actionBars` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This represents which action bars are currently active.';
ALTER TABLE characters MODIFY COLUMN `ammoId` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This is the item_template Entry ID of the ammo currently equipped.';
ALTER TABLE characters MODIFY COLUMN `at_login` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The status of the character.';
ALTER TABLE characters MODIFY COLUMN `cinematic` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean 1 or 0 controlling whether the start cinematic has been shown or not.';
ALTER TABLE characters MODIFY COLUMN `class` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Class Id of the character (See chrclasses.dbc).';
ALTER TABLE characters MODIFY COLUMN `death_expire_time` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Time when a character can be resurrected.';
ALTER TABLE characters MODIFY COLUMN `deleteDate` BIGINT(20) UNSIGNED COMMENT 'This is the date the character was deleted,';
ALTER TABLE characters MODIFY COLUMN `deleteInfos_Account` INT(11) UNSIGNED COMMENT 'This is the account number from the characters table.';
ALTER TABLE characters MODIFY COLUMN `deleteInfos_Name` VARCHAR(12) COMMENT 'The is the name of the character being deleted.';
ALTER TABLE characters MODIFY COLUMN `drunk` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This represents the alcoholic strength of the drink.';
ALTER TABLE characters MODIFY COLUMN `equipmentCache` LONGTEXT COMMENT 'This is a record of all items that are currently equipped.';
ALTER TABLE characters MODIFY COLUMN `exploredZones` LONGTEXT COMMENT 'This is a record of all areas discovered by the character.';
ALTER TABLE characters MODIFY COLUMN `extra_flags` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These flags control certain player specific attributes, mostly GM features.';
ALTER TABLE characters MODIFY COLUMN `gender` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Sex/Gender of the character.';
ALTER TABLE characters MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The character global unique identifier.';
ALTER TABLE characters MODIFY COLUMN `health` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The character''s health when logging out.';
ALTER TABLE characters MODIFY COLUMN `honor_highest_rank` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This shows the highest honor rank ever earned.';
ALTER TABLE characters MODIFY COLUMN `is_logout_resting` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean 1 or 0 controlling if the character is currently in a resting zone.';
ALTER TABLE characters MODIFY COLUMN `level` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The current level of the designated player.';
ALTER TABLE characters MODIFY COLUMN `leveltime` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The total time the character has spent in the world at the current level.';
ALTER TABLE characters MODIFY COLUMN `logout_time` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The time when the character last logged out, measured in Unix time.';
ALTER TABLE characters MODIFY COLUMN `map` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The map ID the character is in (See maps.dbc)';
ALTER TABLE characters MODIFY COLUMN `money` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This is the amount of copper the character possesses.';
ALTER TABLE characters MODIFY COLUMN `name` VARCHAR(12) NOT NULL DEFAULT '' COMMENT 'The name of the character.';
ALTER TABLE characters MODIFY COLUMN `online` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Records whether the character is online (1) or offline (0).';
ALTER TABLE characters MODIFY COLUMN `orientation` FLOAT NOT NULL DEFAULT '0' COMMENT 'The orientation the character is facing. (North = 0.0, South = 3.14159)';
ALTER TABLE characters MODIFY COLUMN `playerBytes` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This defines the physical attributes of the character.';
ALTER TABLE characters MODIFY COLUMN `playerBytes2` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This defines the facial hair physical attribute of the character.';
ALTER TABLE characters MODIFY COLUMN `playerFlags` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These are the player flags, such as GM mode on or off.';
ALTER TABLE characters MODIFY COLUMN `position_x` FLOAT NOT NULL DEFAULT '0' COMMENT 'The x position of the character''s location.';
ALTER TABLE characters MODIFY COLUMN `position_y` FLOAT NOT NULL DEFAULT '0' COMMENT 'The y position of the character''s location.';
ALTER TABLE characters MODIFY COLUMN `position_z` FLOAT NOT NULL DEFAULT '0' COMMENT 'The z position of the character''s location.';
ALTER TABLE characters MODIFY COLUMN `power1` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'If a mana user, then this is a character''s mana level when logging out.';
ALTER TABLE characters MODIFY COLUMN `power2` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'If a warrior, then this is a character''s rage level when logging out.';
ALTER TABLE characters MODIFY COLUMN `power3` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This is a hunter pet''s focus level.';
ALTER TABLE characters MODIFY COLUMN `power4` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'If a rogue, then this is a character''s energy level when logging out.';
ALTER TABLE characters MODIFY COLUMN `power5` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This is the current active pet''s happiness level.';
ALTER TABLE characters MODIFY COLUMN `race` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The race of the character.';
ALTER TABLE characters MODIFY COLUMN `resettalents_cost` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The cost for the character to reset its talents, measured in copper.';
ALTER TABLE characters MODIFY COLUMN `rest_bonus` FLOAT NOT NULL DEFAULT '0' COMMENT 'This is the rest bonus for the character.';
ALTER TABLE characters MODIFY COLUMN `stable_slots` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The number of stable slots the player has available. Maximum is 2.';
ALTER TABLE characters MODIFY COLUMN `stored_dishonorable_kills` INT(11) NOT NULL DEFAULT '0' COMMENT 'The is the total dishonorable kills made by the character.';
ALTER TABLE characters MODIFY COLUMN `stored_honorable_kills` INT(11) NOT NULL DEFAULT '0' COMMENT 'The is the total honorable kills made by the character.';
ALTER TABLE characters MODIFY COLUMN `stored_honor_rating` FLOAT NOT NULL DEFAULT '0' COMMENT 'This is the current amount of honor points.';
ALTER TABLE characters MODIFY COLUMN `taxi_path` TEXT COMMENT 'Stores the players current taxi path (TaxiPath.dbc) if logged off while on one.';
ALTER TABLE characters MODIFY COLUMN `totaltime` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The total time that the character has been active in the world.';
ALTER TABLE characters MODIFY COLUMN `transguid` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This is the transprt the character is currently travelling on.';
ALTER TABLE characters MODIFY COLUMN `trans_o` FLOAT NOT NULL DEFAULT '0' COMMENT 'The orientation of the character on the transport it is travelling on.';
ALTER TABLE characters MODIFY COLUMN `trans_x` FLOAT NOT NULL DEFAULT '0' COMMENT 'The X coordinate of the character on the transport it is travelling on.';
ALTER TABLE characters MODIFY COLUMN `trans_y` FLOAT NOT NULL DEFAULT '0' COMMENT 'The Y coordinate of the character on the transport it is travelling on.';
ALTER TABLE characters MODIFY COLUMN `trans_z` FLOAT NOT NULL DEFAULT '0' COMMENT 'The Z coordinate of the character on the transport it is travelling on.';
ALTER TABLE characters MODIFY COLUMN `watchedFaction` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The faction whose rep is being followed on the experience bar.';
ALTER TABLE characters MODIFY COLUMN `xp` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The total amount of xp that the signified player has.';
ALTER TABLE characters MODIFY COLUMN `zone` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The zone ID the character is in.';
ALTER TABLE character_action MODIFY COLUMN `action` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Depending on the type value, this could be various values.';
ALTER TABLE character_action MODIFY COLUMN `button` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The ID of the button on the action bar where the action icon will be placed.';
ALTER TABLE character_action MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the character (See character.id).';
ALTER TABLE character_action MODIFY COLUMN `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The type of action.';
ALTER TABLE character_aura MODIFY COLUMN `basepoints0` INT(11) NOT NULL DEFAULT '0' COMMENT 'Primary effect.';
ALTER TABLE character_aura MODIFY COLUMN `basepoints1` INT(11) NOT NULL DEFAULT '0' COMMENT 'Secondary effect (healing)';
ALTER TABLE character_aura MODIFY COLUMN `basepoints2` INT(11) NOT NULL DEFAULT '0' COMMENT 'Secondary effect (damage)';
ALTER TABLE character_aura MODIFY COLUMN `caster_guid` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID (Global Unique Identifier) of the player who cast the aura.';
ALTER TABLE character_aura MODIFY COLUMN `effIndexMask` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The effect index of the spell from which the aura came from.';
ALTER TABLE character_aura MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID (Full Global Unique Identifier) of the target affected by the aura.';
ALTER TABLE character_aura MODIFY COLUMN `item_guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID (Global Unique Identifier) of the item which casted the aura.';
ALTER TABLE character_aura MODIFY COLUMN `maxduration` INT(11) NOT NULL DEFAULT '0' COMMENT 'The maximum duration of the aura.';
ALTER TABLE character_aura MODIFY COLUMN `periodictime0` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary effect over time counter.';
ALTER TABLE character_aura MODIFY COLUMN `periodictime1` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary effect (healing) over time counter.';
ALTER TABLE character_aura MODIFY COLUMN `periodictime2` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary effect (damage) over time counter.';
ALTER TABLE character_aura MODIFY COLUMN `remaincharges` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The number of charges remaining on the aura.';
ALTER TABLE character_aura MODIFY COLUMN `remaintime` INT(11) NOT NULL DEFAULT '0' COMMENT 'The time remaining in seconds on the aura. -1 means that the aura is indefinite.';
ALTER TABLE character_aura MODIFY COLUMN `spell` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The spell from which the aura was applied. (See Spell.dbc)';
ALTER TABLE character_aura MODIFY COLUMN `stackcount` INT(11) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Determines how many stacks of the spell the character has.';
ALTER TABLE character_battleground_data MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The character battleground datar global unique identifier.';
ALTER TABLE character_battleground_data MODIFY COLUMN `instance_id` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The unique ID of the battleground instance the character has entered.';
ALTER TABLE character_battleground_data MODIFY COLUMN `join_map` INT(11) NOT NULL DEFAULT '0' COMMENT 'Battleground map ID where the character will spawn.';
ALTER TABLE character_battleground_data MODIFY COLUMN `join_o` FLOAT NOT NULL DEFAULT '0' COMMENT 'The character''s orientation in the battleground.';
ALTER TABLE character_battleground_data MODIFY COLUMN `join_x` FLOAT NOT NULL DEFAULT '0' COMMENT 'The character''s X coordinate in the battleground.';
ALTER TABLE character_battleground_data MODIFY COLUMN `join_y` FLOAT NOT NULL DEFAULT '0' COMMENT 'The character''s Y coordinate in the battleground.';
ALTER TABLE character_battleground_data MODIFY COLUMN `join_z` FLOAT NOT NULL DEFAULT '0' COMMENT 'The character''s Z coordinate in the battleground.';
ALTER TABLE character_battleground_data MODIFY COLUMN `team` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Neutral, Horde, or Alliance';
ALTER TABLE character_gifts MODIFY COLUMN `entry` INT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The entry of the item. (See item_template.entry).';
ALTER TABLE character_gifts MODIFY COLUMN `guid` INT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).';
ALTER TABLE character_gifts MODIFY COLUMN `item_guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the item. (See item_instance.guid).';
ALTER TABLE character_homebind MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).';
ALTER TABLE character_homebind MODIFY COLUMN `map` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Map Identifier where the character gets teleported to. (See Maps.dbc).';
ALTER TABLE character_homebind MODIFY COLUMN `position_x` FLOAT NOT NULL DEFAULT '0' COMMENT 'The x position where the character gets teleported to.';
ALTER TABLE character_homebind MODIFY COLUMN `position_y` FLOAT NOT NULL DEFAULT '0' COMMENT 'The y position where the character gets teleported to.';
ALTER TABLE character_homebind MODIFY COLUMN `position_z` FLOAT NOT NULL DEFAULT '0' COMMENT 'The z position where the character gets teleported to.';
ALTER TABLE character_homebind MODIFY COLUMN `zone` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Zone Identifier where the character gets teleported to.';
ALTER TABLE character_honor_cp MODIFY COLUMN `date` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The date the honor kill occured.';
ALTER TABLE character_honor_cp MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The global unique identifier player character (victor)';
ALTER TABLE character_honor_cp MODIFY COLUMN `honor` FLOAT NOT NULL DEFAULT '0' COMMENT 'Amount of honor earned for the honor kill.';
ALTER TABLE character_honor_cp MODIFY COLUMN `type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The is appears to be 1 for player and 2 for NPC.';
ALTER TABLE character_honor_cp MODIFY COLUMN `victim` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The global unique identifier player character (victim)';
ALTER TABLE character_honor_cp MODIFY COLUMN `victim_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '4' COMMENT 'This appears to be 4 for a player and 3 for an NPC.';
ALTER TABLE character_instance MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID (Global Unique Identifier) of the character.';
ALTER TABLE character_instance MODIFY COLUMN `instance` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The instance ID. (See instance.id).';
ALTER TABLE character_instance MODIFY COLUMN `permanent` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean 0 or 1 controlling if the player has been bound to the instance.';
ALTER TABLE character_inventory MODIFY COLUMN `bag` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'If it isn''t 0, then it is the bag''s item GUID (Global Unique Identifier).';
ALTER TABLE character_inventory MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).';
ALTER TABLE character_inventory MODIFY COLUMN `item` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The item''s GUID. (See item_instance.guid).';
ALTER TABLE character_inventory MODIFY COLUMN `item_template` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The item''s template entry (Item Identifier). (See item_template.entry).';
ALTER TABLE character_inventory MODIFY COLUMN `slot` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The slot is the slot in the bag where the item is.';
ALTER TABLE character_pet MODIFY COLUMN `abdata` LONGTEXT COMMENT 'Data about pet action bar and action type ten pairs of action bar entry.';
ALTER TABLE character_pet MODIFY COLUMN `CreatedBySpell` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The ID of the spell that has created this pet.';
ALTER TABLE character_pet MODIFY COLUMN `curhappiness` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The current pet happiness.';
ALTER TABLE character_pet MODIFY COLUMN `curhealth` INT(11) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'The current pet health at the time it was saved to DB.';
ALTER TABLE character_pet MODIFY COLUMN `curmana` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The current pet mana at the time it was saved to DB.';
ALTER TABLE character_pet MODIFY COLUMN `entry` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The creature entry of this pet. (See creature_template.entry).';
ALTER TABLE character_pet MODIFY COLUMN `exp` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The current experience that this pet has.';
ALTER TABLE character_pet MODIFY COLUMN `id` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The special pet ID. This is a unique identifier among all pets.';
ALTER TABLE character_pet MODIFY COLUMN `level` INT(11) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'The current level of the pet.';
ALTER TABLE character_pet MODIFY COLUMN `loyalty` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The pet''s loyalty level.';
ALTER TABLE character_pet MODIFY COLUMN `loyaltypoints` INT(11) NOT NULL DEFAULT '0' COMMENT 'The current amount of loyalty points the pet has.';
ALTER TABLE character_pet MODIFY COLUMN `modelid` INT(11) UNSIGNED DEFAULT '0' COMMENT 'The model ID to use to display the pet.';
ALTER TABLE character_pet MODIFY COLUMN `name` VARCHAR(100) DEFAULT 'Pet' COMMENT 'The pet''s name.';
ALTER TABLE character_pet MODIFY COLUMN `owner` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the pet''s owner. (See character.guid).';
ALTER TABLE character_pet MODIFY COLUMN `PetType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The type of pet that this is. 0 = summoned pet, 1 = tamed pet';
ALTER TABLE character_pet MODIFY COLUMN `Reactstate` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The current reaction state of the pet (passive, aggressive, etc).';
ALTER TABLE character_pet MODIFY COLUMN `renamed` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean 1 or 0. 1 = Pet has been renamed.';
ALTER TABLE character_pet MODIFY COLUMN `resettalents_cost` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'This is the cost to untrain the pet talents.';
ALTER TABLE character_pet MODIFY COLUMN `resettalents_time` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'How many times the pets talents have been reset.';
ALTER TABLE character_pet MODIFY COLUMN `savetime` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The time when the pet was last saved, in Unix time.';
ALTER TABLE character_pet MODIFY COLUMN `slot` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The pet slot that the pet is in. The slot is a number between 0 and 3 inclusive.';
ALTER TABLE character_pet MODIFY COLUMN `teachspelldata` LONGTEXT COMMENT 'This field holds IDs of spells that have been taught to this pet.';
ALTER TABLE character_pet MODIFY COLUMN `trainpoint` INT(11) NOT NULL DEFAULT '0' COMMENT 'Total training points available to spend.';
ALTER TABLE character_queststatus MODIFY COLUMN `explored` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean 1 or 0 representing if the character has explored what was needed.';
ALTER TABLE character_queststatus MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the character. (See character.guid).';
ALTER TABLE character_queststatus MODIFY COLUMN `itemcount1` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current item count for the first item in a delivery quest, if any.';
ALTER TABLE character_queststatus MODIFY COLUMN `itemcount2` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current item count for the second item in a delivery quest, if any.';
ALTER TABLE character_queststatus MODIFY COLUMN `itemcount3` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current item count for the third item in a delivery quest, if any.';
ALTER TABLE character_queststatus MODIFY COLUMN `itemcount4` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current item count for the forth item in a delivery quest, if any.';
ALTER TABLE character_queststatus MODIFY COLUMN `mobcount1` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current count of the first number of kills or casts.';
ALTER TABLE character_queststatus MODIFY COLUMN `mobcount2` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current count of the second number of kills or casts.';
ALTER TABLE character_queststatus MODIFY COLUMN `mobcount3` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current count of the third number of kills or casts.';
ALTER TABLE character_queststatus MODIFY COLUMN `mobcount4` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current count of the forth number of kills or casts.';
ALTER TABLE character_queststatus MODIFY COLUMN `quest` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The quest ID. (See quest_template.entry).';
ALTER TABLE character_queststatus MODIFY COLUMN `rewarded` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean 1 or 0 representing whether the quest has been rewarded or not.';
ALTER TABLE character_queststatus MODIFY COLUMN `status` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The current quest status.';
ALTER TABLE character_queststatus MODIFY COLUMN `timer` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Remaining time left on the quest if the quest has a timer (See quest_template).';
ALTER TABLE character_reputation MODIFY COLUMN `faction` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The faction ID that the character has the given reputation in (See Faction.dbc).';
ALTER TABLE character_reputation MODIFY COLUMN `flags` INT(11) NOT NULL DEFAULT '0' COMMENT 'This field is a bitmask containing flags that apply to the faction.';
ALTER TABLE character_reputation MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the character. (See character.guid).';
ALTER TABLE character_reputation MODIFY COLUMN `standing` INT(11) NOT NULL DEFAULT '0' COMMENT 'The current reputation value that the character has.';
ALTER TABLE character_skills MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).';
ALTER TABLE character_skills MODIFY COLUMN `max` MEDIUMINT(9) UNSIGNED NOT NULL COMMENT 'The highest possible value for the given skill within a given rank.';
ALTER TABLE character_skills MODIFY COLUMN `skill` MEDIUMINT(9) UNSIGNED NOT NULL COMMENT 'The list of skills a character knows. A listing of those can be found in here.';
ALTER TABLE character_skills MODIFY COLUMN `value` MEDIUMINT(9) UNSIGNED NOT NULL COMMENT 'The current skill rank(value) of the character skills a character has.';
ALTER TABLE character_social MODIFY COLUMN `flags` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Whether the character is a friend or ignored.';
ALTER TABLE character_social MODIFY COLUMN `friend` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the friend/ignored. (See character.guid)';
ALTER TABLE character_social MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the character. (See character.guid)';
ALTER TABLE character_spell MODIFY COLUMN `active` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Boolean 1 or 0 signifying whether the spell is active (appears in the spell book';
ALTER TABLE character_spell MODIFY COLUMN `disabled` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean flag 0 or 1 when spell is disabled because of talents.';
ALTER TABLE character_spell MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID (Global Unique Identifier) of the character. (See character.guid).';
ALTER TABLE character_spell MODIFY COLUMN `spell` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The spell ID (Spell Identifier). (See Spell.dbc)';
ALTER TABLE character_spell_cooldown MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID (Global Unique Identifier, Low part) of the character.';
ALTER TABLE character_spell_cooldown MODIFY COLUMN `item` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'If the spell was casted from an item, the item ID (Item Identifier).';
ALTER TABLE character_spell_cooldown MODIFY COLUMN `spell` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The spell ID (Spell Identifier). (See Spell.dbc)';
ALTER TABLE character_spell_cooldown MODIFY COLUMN `time` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The time when the spell cooldown will finish, measured in Unix Time.';
ALTER TABLE character_stats MODIFY COLUMN `agility` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current agility value';
ALTER TABLE character_stats MODIFY COLUMN `armor` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current armor value.';
ALTER TABLE character_stats MODIFY COLUMN `attackPower` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current attackpower.';
ALTER TABLE character_stats MODIFY COLUMN `blockPct` FLOAT UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current block chance';
ALTER TABLE character_stats MODIFY COLUMN `critPct` FLOAT UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current crit chance.';
ALTER TABLE character_stats MODIFY COLUMN `dodgePct` FLOAT UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current dodge chance.';
ALTER TABLE character_stats MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The guid of the character. (See character.guid).';
ALTER TABLE character_stats MODIFY COLUMN `intellect` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current intellect value.';
ALTER TABLE character_stats MODIFY COLUMN `maxhealth` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Maximum amount of health that the character has.';
ALTER TABLE character_stats MODIFY COLUMN `maxpower1` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Max Mana';
ALTER TABLE character_stats MODIFY COLUMN `maxpower2` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Max Rage';
ALTER TABLE character_stats MODIFY COLUMN `maxpower3` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Max Focus';
ALTER TABLE character_stats MODIFY COLUMN `maxpower4` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Max Energy';
ALTER TABLE character_stats MODIFY COLUMN `maxpower5` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Max Happiness';
ALTER TABLE character_stats MODIFY COLUMN `maxpower6` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Max Rune';
ALTER TABLE character_stats MODIFY COLUMN `maxpower7` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Max Runic Power';
ALTER TABLE character_stats MODIFY COLUMN `parryPct` FLOAT UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current parry chance.';
ALTER TABLE character_stats MODIFY COLUMN `rangedAttackPower` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current ranged attackpower.';
ALTER TABLE character_stats MODIFY COLUMN `rangedCritPct` FLOAT UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current ranged crit chance.';
ALTER TABLE character_stats MODIFY COLUMN `resArcane` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current arcane resistance value.';
ALTER TABLE character_stats MODIFY COLUMN `resFire` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current fire resistance value.';
ALTER TABLE character_stats MODIFY COLUMN `resFrost` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current frost resistance value.';
ALTER TABLE character_stats MODIFY COLUMN `resHoly` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current holy resistance value.';
ALTER TABLE character_stats MODIFY COLUMN `resNature` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current nature resistance value.';
ALTER TABLE character_stats MODIFY COLUMN `resShadow` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current shadow resistance value.';
ALTER TABLE character_stats MODIFY COLUMN `spirit` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current spirit value.';
ALTER TABLE character_stats MODIFY COLUMN `stamina` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current stamina value.';
ALTER TABLE character_stats MODIFY COLUMN `strength` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character''s current strength value.';
ALTER TABLE character_ticket MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the character sending the ticket. (See character.guid).';
ALTER TABLE character_ticket MODIFY COLUMN `resolved` TINYINT(1) DEFAULT '0' COMMENT 'Resolved Flag = set to 1 if the GM has sucessfully resolved the ticket';
ALTER TABLE character_ticket MODIFY COLUMN `response_text` TEXT COMMENT 'The ticket solution text; the text written by the GM.';
ALTER TABLE character_ticket MODIFY COLUMN `ticket_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'A unique ticket ID.';
ALTER TABLE character_ticket MODIFY COLUMN `ticket_lastchange` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Stores the time when this ticket was last changed.';
ALTER TABLE character_ticket MODIFY COLUMN `ticket_text` TEXT COMMENT 'The ticket description text; the text written by the player.';
ALTER TABLE character_tutorial MODIFY COLUMN `account` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The account id of the user. (See account.id).';
ALTER TABLE character_tutorial MODIFY COLUMN `tut0` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These values are 32bits flags.';
ALTER TABLE character_tutorial MODIFY COLUMN `tut1` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These values are 32bits flags.';
ALTER TABLE character_tutorial MODIFY COLUMN `tut2` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These values are 32bits flags.';
ALTER TABLE character_tutorial MODIFY COLUMN `tut3` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These values are 32bits flags.';
ALTER TABLE character_tutorial MODIFY COLUMN `tut4` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These values are 32bits flags.';
ALTER TABLE character_tutorial MODIFY COLUMN `tut5` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These values are 32bits flags.';
ALTER TABLE character_tutorial MODIFY COLUMN `tut6` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These values are 32bits flags.';
ALTER TABLE character_tutorial MODIFY COLUMN `tut7` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'These values are 32bits flags.';
ALTER TABLE character_whispers MODIFY COLUMN `from_guid` INT(10) NOT NULL COMMENT 'The GUID of the character sending the whisper. (See character.guid).';
ALTER TABLE character_whispers MODIFY COLUMN `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The unique id of this whisper message';
ALTER TABLE character_whispers MODIFY COLUMN `message` VARCHAR(256) NOT NULL COMMENT 'The body text of the whisper message';
ALTER TABLE character_whispers MODIFY COLUMN `regarding_ticket_id` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The id of the ticket this whisper relates to. (See character_ticket.ticket_id).';
ALTER TABLE character_whispers MODIFY COLUMN `sent_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Stores the time when this whisper was sent.';
ALTER TABLE character_whispers MODIFY COLUMN `to_guid` INT(10) NOT NULL COMMENT 'The GUID of the character receiving the whisper. (See character.guid).';
ALTER TABLE corpse MODIFY COLUMN `corpse_type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Display Type of the corpse.';
ALTER TABLE corpse MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The character global unique identifier of the corpse.';
ALTER TABLE corpse MODIFY COLUMN `instance` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The instance ID that the corpse is in.';
ALTER TABLE corpse MODIFY COLUMN `instance` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The instance ID that the corpse is in.';
ALTER TABLE corpse MODIFY COLUMN `map` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The map ID the corpse is in. (See maps.dbc)';
ALTER TABLE corpse MODIFY COLUMN `orientation` FLOAT NOT NULL DEFAULT '0' COMMENT 'The orientation of the corpse. (North = 0.0, South = 3.14159)';
ALTER TABLE corpse MODIFY COLUMN `player` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The character global unique identifier. (See characters.guid).';
ALTER TABLE corpse MODIFY COLUMN `position_x` FLOAT NOT NULL DEFAULT '0' COMMENT 'The x position of the character''s corpse location.';
ALTER TABLE corpse MODIFY COLUMN `position_y` FLOAT NOT NULL DEFAULT '0' COMMENT 'The y position of the character''s corpse location.';
ALTER TABLE corpse MODIFY COLUMN `position_z` FLOAT NOT NULL DEFAULT '0' COMMENT 'The z position of the character''s corpse location.';
ALTER TABLE corpse MODIFY COLUMN `time` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Time of death.';
ALTER TABLE creature_respawn MODIFY COLUMN `instance` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Instance ID of the instance the creature is respawning into.';
ALTER TABLE creature_respawn MODIFY COLUMN `respawntime` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Time till the creature should respawn.';
ALTER TABLE db_version MODIFY COLUMN `comment` VARCHAR(150) DEFAULT '' COMMENT 'A comment about the latest database revision.';
ALTER TABLE db_version MODIFY COLUMN `content` INT(3) NOT NULL COMMENT 'The current core content level.';
ALTER TABLE db_version MODIFY COLUMN `description` VARCHAR(30) NOT NULL DEFAULT '' COMMENT 'A short description of the latest database revision.';
ALTER TABLE db_version MODIFY COLUMN `structure` INT(3) NOT NULL COMMENT 'The current core structure level.';
ALTER TABLE db_version MODIFY COLUMN `version` INT(3) NOT NULL COMMENT 'The Version of the Release';
ALTER TABLE gameobject_respawn MODIFY COLUMN `guid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global unique ID of the game object.';
ALTER TABLE gameobject_respawn MODIFY COLUMN `instance` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Instance ID that the game object will spawn in.';
ALTER TABLE gameobject_respawn MODIFY COLUMN `respawntime` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Time till the game object should respawn.';
ALTER TABLE game_event_status MODIFY COLUMN `event` SMALLINT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Event Id (see game_event.is) of currently active game events.';
ALTER TABLE groups MODIFY COLUMN `groupId` INT(11) UNSIGNED NOT NULL COMMENT 'Uniquie ID for the group.';
ALTER TABLE groups MODIFY COLUMN `icon1` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the target that has the star raid target on it.';
ALTER TABLE groups MODIFY COLUMN `icon2` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the target that has the circle raid target on it.';
ALTER TABLE groups MODIFY COLUMN `icon3` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of target that has the dimond raid target on it.';
ALTER TABLE groups MODIFY COLUMN `icon4` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the target that has the triangler raid target on it.';
ALTER TABLE groups MODIFY COLUMN `icon5` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the target that has the moon raid target on it.';
ALTER TABLE groups MODIFY COLUMN `icon6` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the target that has the square raid target on it.';
ALTER TABLE groups MODIFY COLUMN `icon7` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the target that has the cross raid target on it.';
ALTER TABLE groups MODIFY COLUMN `icon8` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the target that has the skull raid target on it.';
ALTER TABLE groups MODIFY COLUMN `isRaid` TINYINT(1) UNSIGNED NOT NULL COMMENT 'Flag set for if group is part of a raid or not.';
ALTER TABLE groups MODIFY COLUMN `leaderGuid` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the group''s leader';
ALTER TABLE groups MODIFY COLUMN `looterGuid` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the character who retrieves the loot.';
ALTER TABLE groups MODIFY COLUMN `lootMethod` TINYINT(4) UNSIGNED NOT NULL COMMENT 'This is the loot method used by the group.';
ALTER TABLE groups MODIFY COLUMN `lootThreshold` TINYINT(4) UNSIGNED NOT NULL COMMENT 'The quality of the items in the loot to be rolled for.';
ALTER TABLE groups MODIFY COLUMN `mainAssistant` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the character who is that main assist.';
ALTER TABLE groups MODIFY COLUMN `mainTank` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of the character who is that main tank.';
ALTER TABLE group_instance MODIFY COLUMN `instance` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ID of the Instance session the group has enterd.';
ALTER TABLE group_instance MODIFY COLUMN `leaderGuid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Guid of the group leader. (See characters.guid)';
ALTER TABLE group_instance MODIFY COLUMN `permanent` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean flag if the group is bound to the Instance or not';
ALTER TABLE group_member MODIFY COLUMN `assistant` TINYINT(1) UNSIGNED NOT NULL COMMENT 'Flag stating whether or not the character is the assist.';
ALTER TABLE group_member MODIFY COLUMN `groupId` INT(11) UNSIGNED NOT NULL COMMENT 'The group ID from the groups table.';
ALTER TABLE group_member MODIFY COLUMN `memberGuid` INT(11) UNSIGNED NOT NULL COMMENT 'The GUID of the character in the group.';
ALTER TABLE group_member MODIFY COLUMN `subgroup` SMALLINT(6) UNSIGNED NOT NULL COMMENT 'This is the group number within a raid (8 groups max)';
ALTER TABLE guild MODIFY COLUMN `BackgroundColor` INT(5) NOT NULL DEFAULT '0' COMMENT 'The background color of the guild tabard.';
ALTER TABLE guild MODIFY COLUMN `BorderColor` INT(5) NOT NULL DEFAULT '0' COMMENT 'The border color of the guild tabard.';
ALTER TABLE guild MODIFY COLUMN `BorderStyle` INT(5) NOT NULL DEFAULT '0' COMMENT 'The border style of the guild tabard.';
ALTER TABLE guild MODIFY COLUMN `createdate` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The date when the guild was created.';
ALTER TABLE guild MODIFY COLUMN `EmblemColor` INT(5) NOT NULL DEFAULT '0' COMMENT 'The emblem color of the guild tabard.';
ALTER TABLE guild MODIFY COLUMN `EmblemStyle` INT(5) NOT NULL DEFAULT '0' COMMENT 'The emblem style of the guild tabard.';
ALTER TABLE guild MODIFY COLUMN `guildid` INT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The ID of the guild.';
ALTER TABLE guild MODIFY COLUMN `info` VARCHAR(500) NOT NULL DEFAULT '' COMMENT 'The text message that appears in the Guild Information box.';
ALTER TABLE guild MODIFY COLUMN `leaderguid` INT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the character who created the guild. (See characters.guid)';
ALTER TABLE guild MODIFY COLUMN `motd` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'The text that appears in the Message Of The Day box.';
ALTER TABLE guild MODIFY COLUMN `name` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'The guild name.';
ALTER TABLE guild_eventlog MODIFY COLUMN `EventType` TINYINT(1) UNSIGNED NOT NULL COMMENT 'The Guild Event Type.';
ALTER TABLE guild_eventlog MODIFY COLUMN `guildid` INT(11) UNSIGNED NOT NULL COMMENT 'Id of related guild. (See guild.guildid).';
ALTER TABLE guild_eventlog MODIFY COLUMN `LogGuid` INT(11) UNSIGNED NOT NULL COMMENT 'A unique identifier given to each log entry to distinguish it.';
ALTER TABLE guild_eventlog MODIFY COLUMN `NewRank` TINYINT(2) UNSIGNED NOT NULL COMMENT 'Id of new rank of PlayerGuid2. (See guild_rank.rid)';
ALTER TABLE guild_eventlog MODIFY COLUMN `PlayerGuid1` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of character who made the change. (See character.guid)';
ALTER TABLE guild_eventlog MODIFY COLUMN `PlayerGuid2` INT(11) UNSIGNED NOT NULL COMMENT 'Guid of character who was changed. (See character.guid)';
ALTER TABLE guild_eventlog MODIFY COLUMN `TimeStamp` BIGINT(20) UNSIGNED NOT NULL COMMENT 'Unix timestamp of when the event happened.';
ALTER TABLE guild_member MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the player. (See character.guid)';
ALTER TABLE guild_member MODIFY COLUMN `guildid` INT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The ID of the guild that the member is a part of. (See guild.guildid)';
ALTER TABLE guild_member MODIFY COLUMN `offnote` VARCHAR(31) NOT NULL DEFAULT '' COMMENT 'The Officers Note set by officers in the guild.';
ALTER TABLE guild_member MODIFY COLUMN `pnote` VARCHAR(31) NOT NULL DEFAULT '' COMMENT 'The Player Note set by the player.';
ALTER TABLE guild_member MODIFY COLUMN `rank` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The rank that the player has in the guild. (See guild_rank.rid)';
ALTER TABLE guild_rank MODIFY COLUMN `guildid` INT(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The guild ID that the rank is part of. (See guild.guildid)';
ALTER TABLE guild_rank MODIFY COLUMN `rid` INT(11) UNSIGNED NOT NULL COMMENT 'The particular rank ID. This number must be unique to each rank in a guild.';
ALTER TABLE guild_rank MODIFY COLUMN `rights` INT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The rights a player with this rank has in the guild.';
ALTER TABLE guild_rank MODIFY COLUMN `rname` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'The name of the rank that is displayed in-game.';
ALTER TABLE instance MODIFY COLUMN `data` LONGTEXT COMMENT 'Specific data belonging to the individual instance.';
ALTER TABLE instance MODIFY COLUMN `id` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The instance ID. This number is unique to every instance.';
ALTER TABLE instance MODIFY COLUMN `map` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The map ID the instance is in. (See Map.dbc)';
ALTER TABLE instance MODIFY COLUMN `resettime` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The time when the instance will be reset, in Unix time.';
ALTER TABLE instance_reset MODIFY COLUMN `mapid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The map ID of the instance. (See Map.dbc)';
ALTER TABLE instance_reset MODIFY COLUMN `resettime` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Dungeon reset time in seconds.';
ALTER TABLE item_instance MODIFY COLUMN `data` LONGTEXT COMMENT 'Much like the playerbytes fields in the characters table.';
ALTER TABLE item_instance MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the item. This number is unique for each item instance.';
ALTER TABLE item_instance MODIFY COLUMN `owner_guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the character who has ownership of this item. (See character.guid)';
ALTER TABLE item_loot MODIFY COLUMN `amount` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Total number of the item.';
ALTER TABLE item_loot MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global unique ID of the item loot entry.';
ALTER TABLE item_loot MODIFY COLUMN `itemid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Item template entry ID of the item.';
ALTER TABLE item_loot MODIFY COLUMN `owner_guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the owner. (See character.guid)';
ALTER TABLE item_loot MODIFY COLUMN `property` INT(11) NOT NULL DEFAULT '0' COMMENT 'Item random property.';
ALTER TABLE item_text MODIFY COLUMN `id` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The text entry ID. This number is unique to every text entry in this table.';
ALTER TABLE item_text MODIFY COLUMN `text` LONGTEXT COMMENT 'The actual text that was sent as mail using the mail system.';
ALTER TABLE mail MODIFY COLUMN `checked` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'checked_flag.';
ALTER TABLE mail MODIFY COLUMN `cod` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Amount of money needed (COD).';
ALTER TABLE mail MODIFY COLUMN `deliver_time` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current Unix Time + Unix Time till delivery.';
ALTER TABLE mail MODIFY COLUMN `expire_time` BIGINT(40) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Current Unix Time + Unix Time till expiry.';
ALTER TABLE mail MODIFY COLUMN `has_items` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean value showing whether or not atems have been sent.';
ALTER TABLE mail MODIFY COLUMN `id` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Unique message id. Every new message gets a new auto incremented id.';
ALTER TABLE mail MODIFY COLUMN `itemTextId` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The item_text ID of the massage within the mail.';
ALTER TABLE mail MODIFY COLUMN `mailTemplateId` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Mail Template Id (See MailTemplate.dbc)';
ALTER TABLE mail MODIFY COLUMN `messageType` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'message_type.';
ALTER TABLE mail MODIFY COLUMN `money` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Amount of money sent.';
ALTER TABLE mail MODIFY COLUMN `receiver` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Guid of the character who receives the mail.';
ALTER TABLE mail MODIFY COLUMN `sender` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Guid of the character who sends the mail.';
ALTER TABLE mail MODIFY COLUMN `stationery` TINYINT(3) NOT NULL DEFAULT '41' COMMENT 'The StationeryID (See Stationery.dbc).';
ALTER TABLE mail MODIFY COLUMN `subject` LONGTEXT COMMENT 'The Subject of the mail.';
ALTER TABLE mail_items MODIFY COLUMN `item_guid` INT(11) NOT NULL DEFAULT '0' COMMENT 'The GUID of the item.';
ALTER TABLE mail_items MODIFY COLUMN `item_template` INT(11) NOT NULL DEFAULT '0' COMMENT 'The entry ID of the item in the item_template table.';
ALTER TABLE mail_items MODIFY COLUMN `mail_id` INT(11) NOT NULL DEFAULT '0' COMMENT 'The Mail Id (See mail.id).';
ALTER TABLE mail_items MODIFY COLUMN `receiver` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Guid of the character who receives the mail.';
ALTER TABLE petition MODIFY COLUMN `name` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'The name of the guild or arena team that the player is trying to petition.';
ALTER TABLE petition MODIFY COLUMN `ownerguid` INT(10) UNSIGNED NOT NULL COMMENT 'The petition owner''s GUID. (See characters.guid)';
ALTER TABLE petition MODIFY COLUMN `petitionguid` INT(10) UNSIGNED DEFAULT '0' COMMENT 'The GUID of the petition item. See (item_instance.guid)';
ALTER TABLE petition_sign MODIFY COLUMN `ownerguid` INT(10) UNSIGNED NOT NULL COMMENT 'The GUID of the owner that is trying to make the guild/arena team.';
ALTER TABLE petition_sign MODIFY COLUMN `petitionguid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the charter item. (See item_template.guid)';
ALTER TABLE petition_sign MODIFY COLUMN `playerguid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the player that has signed the charter. (See character.guid)';
ALTER TABLE petition_sign MODIFY COLUMN `player_account` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The account ID of the player that has signed the charter (See account.id).';
ALTER TABLE pet_aura MODIFY COLUMN `basepoints0` INT(11) NOT NULL DEFAULT '0' COMMENT 'Primary effect.';
ALTER TABLE pet_aura MODIFY COLUMN `basepoints1` INT(11) NOT NULL DEFAULT '0' COMMENT 'Secondary effect (appears to be only healing related)';
ALTER TABLE pet_aura MODIFY COLUMN `basepoints2` INT(11) NOT NULL DEFAULT '0' COMMENT 'Secondary effect (appears to be only damage related)';
ALTER TABLE pet_aura MODIFY COLUMN `caster_guid` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the player or creature who casted the aura. (See character.guid)';
ALTER TABLE pet_aura MODIFY COLUMN `effIndexMask` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The effect index of the spell from which the aura came from.';
ALTER TABLE pet_aura MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the target affected by the aura. (See character.guid)';
ALTER TABLE pet_aura MODIFY COLUMN `item_guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Guid of the item that is casting the aura on the pet.';
ALTER TABLE pet_aura MODIFY COLUMN `maxduration` INT(11) NOT NULL DEFAULT '0' COMMENT 'The maximum duration of the aura.';
ALTER TABLE pet_aura MODIFY COLUMN `periodictime0` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary effect over time.';
ALTER TABLE pet_aura MODIFY COLUMN `periodictime1` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Secondary effect (healing) over time';
ALTER TABLE pet_aura MODIFY COLUMN `periodictime2` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Secondary effect (damage) over time.';
ALTER TABLE pet_aura MODIFY COLUMN `remaincharges` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The number of charges remaining on the aura.';
ALTER TABLE pet_aura MODIFY COLUMN `remaintime` INT(11) NOT NULL DEFAULT '0' COMMENT 'The time remaining in seconds on the aura. -1 means that the aura is indefinite.';
ALTER TABLE pet_aura MODIFY COLUMN `spell` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The spell from which the aura was applied. (See Spell.dbc column 1)';
ALTER TABLE pet_aura MODIFY COLUMN `stackcount` INT(11) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'This is the total number of times the aura can be stacked on the pet.';
ALTER TABLE pet_spell MODIFY COLUMN `active` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean 0 or 1 controlling if the spell is active or not.';
ALTER TABLE pet_spell MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The pet GUID. (See character_pet.id).';
ALTER TABLE pet_spell MODIFY COLUMN `spell` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The spell ID. See (Spell.dbc)';
ALTER TABLE pet_spell_cooldown MODIFY COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The GUID of the pet. (See character_pet.id)';
ALTER TABLE pet_spell_cooldown MODIFY COLUMN `spell` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The spell ID to which the cooldown applies.';
ALTER TABLE pet_spell_cooldown MODIFY COLUMN `time` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The time when the cooldown expires, in Unix time.';
ALTER TABLE saved_variables MODIFY COLUMN `cleaning_flags` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The flags controlling character cleanup.';
ALTER TABLE saved_variables MODIFY COLUMN `NextMaintenanceDate` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The Date when the Honor Points / Rank etc. are updated.';
ALTER TABLE world MODIFY COLUMN `data` LONGTEXT COMMENT 'Specific data belonging to the world.';
ALTER TABLE world MODIFY COLUMN `map` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The map ID (See Map.dbc)';

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
		IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
		ELSE
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
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

