-- ----------------------------------------------------------------------------------------------------------------
-- WARNING: Running this script will replace the English text in the base World Database with the localised version
-- ----------------------------------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------------------------------
-- ATTENTION: Exécuter ce script remplacera le texte en anglais de la base de données World par la version locale.
-- ----------------------------------------------------------------------------------------------------------------

-- 1/14
UPDATE `creature_template`
INNER JOIN `locales_creature` ON `creature_template`.`entry` = `locales_creature`.`Entry`
SET creature_template.`Name`=`locales_creature`.`name_loc2`,creature_template.`subName`=`locales_creature`.`subname_loc2`;

-- 2/14
UPDATE `creature_ai_texts`
SET `content_default` = COALESCE(`content_loc2`,`content_default`);

-- 3/14
UPDATE `db_script_string`
SET `content_default` = COALESCE(`content_loc2`,`content_default`) ;

-- 4/14
UPDATE `gameobject_template`
INNER JOIN `locales_gameobject` ON `gameobject_template`.`entry` = `locales_gameobject`.`Entry`
SET gameobject_template.`Name` = `locales_gameobject`.`name_loc2`;

-- 5/14
UPDATE `gossip_texts`
SET `content_default` = COALESCE(`content_loc2`,`content_default`) ;

-- 6/14
UPDATE `gossip_menu_option`
INNER JOIN `locales_gossip_menu_option` ON gossip_menu_option.`menu_id`=`locales_gossip_menu_option`.`menu_id` AND gossip_menu_option.`id`=`locales_gossip_menu_option`.`id`
SET gossip_menu_option.`option_text`=`locales_gossip_menu_option`.`option_text_loc2`, gossip_menu_option.`box_text`=`locales_gossip_menu_option`.`box_text_loc2`;

-- 7/14
UPDATE `item_template`
INNER JOIN `locales_item` ON item_template.`Entry`=`locales_item`.`entry`
SET item_template.`Name`=`locales_item`.`name_loc2`,item_template.`description`=COALESCE(`locales_item`.`description_loc2`,'');
 
-- 8/14 
UPDATE `mangos_string`
SET `content_default` = COALESCE(`content_loc2`,`content_default`) ; 

-- 9/14
UPDATE `page_text`
INNER JOIN `locales_page_text` ON page_text.`entry`=`locales_page_text`.`entry`
SET page_text.`Text`=COALESCE(`locales_page_text`.`Text_loc2`,'');

-- 10/14
UPDATE `points_of_interest`
INNER JOIN `locales_points_of_interest` ON points_of_interest.`entry`=`locales_points_of_interest`.`entry`
SET points_of_interest.`icon_name`=COALESCE(`locales_points_of_interest`.`icon_name_loc2`,`locales_points_of_interest`.`icon_name_loc0`);

-- 11/14
UPDATE `quest_template`
INNER JOIN `locales_quest` ON quest_template.`entry`=`locales_quest`.`entry` 
SET quest_template.`Title`=`locales_quest`.`Title_loc2`,
    quest_template.`Details`=`locales_quest`.`Details_loc2`,
    quest_template.`Objectives`=`locales_quest`.`Objectives_loc2`,
    quest_template.`OfferRewardText`=`locales_quest`.`OfferRewardText_loc2`,
    quest_template.`RequestItemsText`=`locales_quest`.`RequestItemsText_loc2`,
    quest_template.`EndText`=`locales_quest`.`EndText_loc2`,
    quest_template.`ObjectiveText1`=`locales_quest`.`ObjectiveText1_loc2`,
    quest_template.`ObjectiveText2`=`locales_quest`.`ObjectiveText2_loc2`,
    quest_template.`ObjectiveText3`=`locales_quest`.`ObjectiveText3_loc2`,
    quest_template.`ObjectiveText4`=`locales_quest`.`ObjectiveText4_loc2`;

-- 12/14
UPDATE `script_texts`
SET `content_default` = COALESCE(`content_loc2`,`content_default`);

-- 13/14
UPDATE `npc_text`
INNER JOIN `locales_npc_text` ON npc_text.`id`=`locales_npc_text`.`entry` 
SET npc_text.`Text0_0`=`locales_npc_text`.`Text0_0_loc2`,
    npc_text.`Text0_1`=`locales_npc_text`.`Text0_1_loc2`,
    npc_text.`Text1_0`=`locales_npc_text`.`Text1_0_loc2`,
    npc_text.`Text1_1`=`locales_npc_text`.`Text1_1_loc2`,
    npc_text.`Text2_0`=`locales_npc_text`.`Text2_0_loc2`,
    npc_text.`Text2_1`=`locales_npc_text`.`Text2_1_loc2`,
    npc_text.`Text3_0`=`locales_npc_text`.`Text3_0_loc2`,
    npc_text.`Text3_1`=`locales_npc_text`.`Text3_1_loc2`,
    npc_text.`Text4_0`=`locales_npc_text`.`Text4_0_loc2`,
    npc_text.`Text4_1`=`locales_npc_text`.`Text4_1_loc2`,
    npc_text.`Text5_0`=`locales_npc_text`.`Text5_0_loc2`,
    npc_text.`Text5_1`=`locales_npc_text`.`Text5_1_loc2`,
    npc_text.`Text6_0`=`locales_npc_text`.`Text6_0_loc2`,
    npc_text.`Text6_1`=`locales_npc_text`.`Text6_1_loc2`,
    npc_text.`Text7_0`=`locales_npc_text`.`Text7_0_loc2`,
    npc_text.`Text7_1`=`locales_npc_text`.`Text7_1_loc2`;

-- 14/14
UPDATE `command`
INNER JOIN `locales_command` ON `command`.`id`=`locales_command`.`id`
SET `command`.`help_text`=COALESCE(`locales_command`.`help_text_loc2`,`command`.`help_text`);
