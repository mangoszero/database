-- Add the Revision update into the revision column
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_25';

-- Quest 8869 (Sweet Serenity fixed)
UPDATE quest_template SET RequiredSkillValue = 250, OfferRewardText = 'May you bash in many a brain, $N!', RequestItemsText = 'His apron! Where is it?', CompleteEmote = 1 WHERE entry = 8869;
-- Blacksmith now only has the more recent of the quests (5305 and 8869 are the same quest)
DELETE FROM creature_involvedrelation WHERE id = 11191 and quest = 5305;
DELETE FROM creature_questrelation WHERE id = 11191 and quest = 5305;

