-- 1/14
UPDATE `locales_creature`
INNER JOIN `creature_template` ON `locales_creature`.`entry` = `creature_template`.`Entry`
SET `locales_creature`.`name_loc0` = `creature_template`.`Name`,`locales_creature`.`subname_loc0` = COALESCE(`creature_template`.`subName`,'');

-- 2/14
UPDATE `creature_ai_texts`
SET `content_loc0` = `content_default`;

-- 3/14
UPDATE `db_script_string`
SET `content_loc0` = `content_default`;

-- 4/14
UPDATE `locales_gameobject`
INNER JOIN `gameobject_template` ON `locales_gameobject`.`entry` = `gameobject_template`.`Entry`
SET `locales_gameobject`.`name_loc0` = `gameobject_template`.`Name`;

-- 5/14
UPDATE `gossip_texts`
SET `content_loc0` = `content_default`;

-- 6/14
UPDATE `locales_gossip_menu_option`
INNER JOIN `gossip_menu_option` ON `locales_gossip_menu_option`.`menu_id` = `gossip_menu_option`.`menu_id` AND `locales_gossip_menu_option`.`id` = `gossip_menu_option`.`id`
SET `locales_gossip_menu_option`.`option_text_loc0` = `gossip_menu_option`.`option_text`,`locales_gossip_menu_option`.`box_text_loc0` = `gossip_menu_option`.`box_text`;

-- 7/14
UPDATE `locales_item`
INNER JOIN `item_template` ON `locales_item`.`entry` = `item_template`.`Entry`
SET `locales_item`.`name_loc0` = `item_template`.`Name`,`locales_item`.`description_loc0` = COALESCE(`item_template`.`description`,'');
 
-- 8/14
UPDATE `mangos_string`
SET `content_loc0` = `content_default`;

-- 9/14
UPDATE `locales_page_text`
INNER JOIN `page_text` ON `locales_page_text`.`entry` = `page_text`.`entry`
SET `locales_page_text`.`Text_loc0` = `page_text`.`Text`;

-- 10/14
UPDATE `locales_points_of_interest`
INNER JOIN `points_of_interest` ON `locales_points_of_interest`.`entry` = `points_of_interest`.`entry`
SET `locales_points_of_interest`.`icon_name_loc0` = `points_of_interest`.`icon_name`;

-- 11/14
UPDATE `locales_quest`
INNER JOIN `quest_template` ON `locales_quest`.`entry` = `quest_template`.`entry`
SET `locales_quest`.`Title_loc0` = `quest_template`.`Title`,
    `locales_quest`.`Details_loc0` = `quest_template`.`Details`,
    `locales_quest`.`Objectives_loc0` = `quest_template`.`Objectives`,
    `locales_quest`.`OfferRewardText_loc0` = `quest_template`.`OfferRewardText`,
    `locales_quest`.`RequestItemsText_loc0` = `quest_template`.`RequestItemsText`,
    `locales_quest`.`EndText_loc0` = `quest_template`.`EndText`,
    `locales_quest`.`ObjectiveText1_loc0` = `quest_template`.`ObjectiveText1`,
    `locales_quest`.`ObjectiveText2_loc0` = `quest_template`.`ObjectiveText2`,
    `locales_quest`.`ObjectiveText3_loc0` = `quest_template`.`ObjectiveText3`,
    `locales_quest`.`ObjectiveText4_loc0` = `quest_template`.`ObjectiveText4`;

-- 12/14
UPDATE `script_texts`
SET `content_loc0` = `content_default`;

-- 13/14 
UPDATE `locales_npc_text`
INNER JOIN `npc_text` ON `locales_npc_text`.`entry` = `npc_text`.`id`
SET `locales_npc_text`.`Text0_0_loc0` = `npc_text`.`Text0_0`,
    `locales_npc_text`.`Text0_1_loc0` = `npc_text`.`Text0_1`,
    `locales_npc_text`.`Text1_0_loc0` = `npc_text`.`Text1_0`,
    `locales_npc_text`.`Text1_1_loc0` = `npc_text`.`Text1_1`,
    `locales_npc_text`.`Text2_0_loc0` = `npc_text`.`Text2_0`,
    `locales_npc_text`.`Text2_1_loc0` = `npc_text`.`Text2_1`,
    `locales_npc_text`.`Text3_0_loc0` = `npc_text`.`Text3_0`,
    `locales_npc_text`.`Text3_1_loc0` = `npc_text`.`Text3_1`,
    `locales_npc_text`.`Text4_0_loc0` = `npc_text`.`Text4_0`,
    `locales_npc_text`.`Text4_1_loc0` = `npc_text`.`Text4_1`,
    `locales_npc_text`.`Text5_0_loc0` = `npc_text`.`Text5_0`,
    `locales_npc_text`.`Text5_1_loc0` = `npc_text`.`Text5_1`,
    `locales_npc_text`.`Text6_0_loc0` = `npc_text`.`Text6_0`,
    `locales_npc_text`.`Text6_1_loc0` = `npc_text`.`Text6_1`,
    `locales_npc_text`.`Text7_0_loc0` = `npc_text`.`Text7_0`,
    `locales_npc_text`.`Text7_1_loc0` = `npc_text`.`Text7_1`;

-- 14/14
UPDATE `locales_command`
INNER JOIN `command` ON `locales_command`.`id` = `command`.`id`
SET `locales_command`.`help_text_loc0` = `command`.`help_text`;

