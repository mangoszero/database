SET Username=root
SET Password=mangos
SET DB=mangos0
SET SERVER=localhost
md _full_db
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% areatrigger_involvedrelation >  _full_db\areatrigger_involvedrelation.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% areatrigger_tavern >  _full_db\areatrigger_tavern.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% areatrigger_teleport >  _full_db\areatrigger_teleport.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% battleground_events >  _full_db\battleground_events.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% battleground_template >  _full_db\battleground_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% battlemaster_entry >  _full_db\battlemaster_entry.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% command >  _full_db\command.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% conditions >  _full_db\conditions.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature >  _full_db\creature.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_addon >  _full_db\creature_addon.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_ai_scripts >  _full_db\creature_ai_scripts.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_ai_summons >  _full_db\creature_ai_summons.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_ai_texts >  _full_db\creature_ai_texts.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_battleground >  _full_db\creature_battleground.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_equip_template >  _full_db\creature_equip_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_equip_template_raw >  _full_db\creature_equip_template_raw.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_involvedrelation >  _full_db\creature_involvedrelation.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_item_template >  _full_db\creature_item_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_linking >  _full_db\creature_linking.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_linking_template >  _full_db\creature_linking_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_loot_template >  _full_db\creature_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_model_info >  _full_db\creature_model_info.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_model_race >  _full_db\creature_model_race.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_movement >  _full_db\creature_movement.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_movement_template >  _full_db\creature_movement_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_onkill_reputation >  _full_db\creature_onkill_reputation.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_questrelation >  _full_db\creature_questrelation.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_template >  _full_db\creature_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_template_addon >  _full_db\creature_template_addon.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_template_classlevelstats >  _full_db\creature_template_classlevelstats.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% creature_template_spells >  _full_db\creature_template_spells.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% custom_texts >  _full_db\custom_texts.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% db_script_string >  _full_db\db_script_string.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% db_version >  _full_db\db_version.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbdocsfields >  _full_db\dbdocsfields.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbdocsfields_localised >  _full_db\dbdocsfields_localised.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbdocsprogressquests >  _full_db\dbdocsprogressquests.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbdocstable >  _full_db\dbdocstable.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbdocstable_localised >  _full_db\dbdocstable_localised.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbdocssubtables >  _full_db\dbdocssubtables.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbdocssubtables_localised >  _full_db\dbdocssubtables_localised.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbscripts_on_creature_death >  _full_db\dbscripts_on_creature_death.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbscripts_on_creature_movement >  _full_db\dbscripts_on_creature_movement.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbscripts_on_event >  _full_db\dbscripts_on_event.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbscripts_on_go_use >  _full_db\dbscripts_on_go_use.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbscripts_on_go_template_use >  _full_db\dbscripts_on_go_template_use.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbscripts_on_gossip >  _full_db\dbscripts_on_gossip.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbscripts_on_quest_end >  _full_db\dbscripts_on_quest_end.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbscripts_on_quest_start >  _full_db\dbscripts_on_quest_start.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% dbscripts_on_spell >  _full_db\dbscripts_on_spell.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% disenchant_loot_template >  _full_db\disenchant_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% exploration_basexp >  _full_db\exploration_basexp.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% fishing_loot_template >  _full_db\fishing_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% game_event >  _full_db\game_event.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% game_event_creature >  _full_db\game_event_creature.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% game_event_creature_data >  _full_db\game_event_creature_data.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% game_event_gameobject >  _full_db\game_event_gameobject.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% game_event_mail >  _full_db\game_event_mail.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% game_event_quest >  _full_db\game_event_quest.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% game_graveyard_zone >  _full_db\game_graveyard_zone.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% game_tele >  _full_db\game_tele.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% game_weather >  _full_db\game_weather.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% gameobject >  _full_db\gameobject.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% gameobject_battleground >  _full_db\gameobject_battleground.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% gameobject_involvedrelation >  _full_db\gameobject_involvedrelation.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% gameobject_loot_template >  _full_db\gameobject_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% gameobject_questrelation >  _full_db\gameobject_questrelation.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% gameobject_template >  _full_db\gameobject_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% gossip_menu >  _full_db\gossip_menu.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% gossip_menu_option >  _full_db\gossip_menu_option.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% gossip_texts >  _full_db\gossip_texts.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% instance_template >  _full_db\instance_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% item_enchantment_template >  _full_db\item_enchantment_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% item_loot_template >  _full_db\item_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% item_required_target >  _full_db\item_required_target.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% item_template >  _full_db\item_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% locales_creature >  _full_db\locales_creature.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% locales_gameobject >  _full_db\locales_gameobject.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% locales_gossip_menu_option >  _full_db\locales_gossip_menu_option.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% locales_item >  _full_db\locales_item.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% locales_npc_text >  _full_db\locales_npc_text.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% locales_page_text >  _full_db\locales_page_text.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% locales_points_of_interest >  _full_db\locales_points_of_interest.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% locales_quest >  _full_db\locales_quest.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% mail_level_reward >  _full_db\mail_level_reward.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% mail_loot_template >  _full_db\mail_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% mangos_string >  _full_db\mangos_string.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% npc_gossip >  _full_db\npc_gossip.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% npc_text >  _full_db\npc_text.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% npc_trainer >  _full_db\npc_trainer.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% npc_trainer_template >  _full_db\npc_trainer_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% npc_vendor >  _full_db\npc_vendor.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% npc_vendor_template >  _full_db\npc_vendor_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% page_text >  _full_db\page_text.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pet_levelstats >  _full_db\pet_levelstats.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pet_name_generation >  _full_db\pet_name_generation.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% petcreateinfo_spell >  _full_db\petcreateinfo_spell.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pickpocketing_loot_template >  _full_db\pickpocketing_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% player_classlevelstats >  _full_db\player_classlevelstats.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% player_levelstats >  _full_db\player_levelstats.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% player_xp_for_level >  _full_db\player_xp_for_level.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% playercreateinfo >  _full_db\playercreateinfo.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% playercreateinfo_action >  _full_db\playercreateinfo_action.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% playercreateinfo_item >  _full_db\playercreateinfo_item.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% playercreateinfo_spell >  _full_db\playercreateinfo_spell.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% points_of_interest >  _full_db\points_of_interest.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pool_creature >  _full_db\pool_creature.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pool_creature_template >  _full_db\pool_creature_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pool_gameobject >  _full_db\pool_gameobject.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pool_gameobject_template >  _full_db\pool_gameobject_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pool_pool >  _full_db\pool_pool.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pool_template >  _full_db\pool_template.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% prospecting_loot_template >  _full_db\prospecting_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pvpstats_battlegrounds >  _full_db\pvpstats_battlegrounds.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% pvpstats_players >  _full_db\pvpstats_players.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% quest_template >  _full_db\quest_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% reference_loot_template >  _full_db\reference_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% reputation_reward_rate >  _full_db\reputation_reward_rate.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% reputation_spillover_template >  _full_db\reputation_spillover_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% reserved_name >  _full_db\reserved_name.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% script_binding >  _full_db\script_binding.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% script_texts >  _full_db\script_texts.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% script_waypoint >  _full_db\script_waypoint.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% scripted_areatrigger >  _full_db\scripted_areatrigger.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% scripted_event >  _full_db\scripted_event.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% sd2_db_version >  _full_db\sd2_db_version.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% skill_discovery_template >  _full_db\skill_discovery_template.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% skill_extra_item_template >  _full_db\skill_extra_item_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% skill_fishing_base_level >  _full_db\skill_fishing_base_level.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% skinning_loot_template >  _full_db\skinning_loot_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_affect >  _full_db\spell_affect.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_area >  _full_db\spell_area.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_bonus_data >  _full_db\spell_bonus_data.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_chain >  _full_db\spell_chain.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_elixir >  _full_db\spell_elixir.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_facing >  _full_db\spell_facing.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_learn_spell >  _full_db\spell_learn_spell.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_linked >  _full_db\spell_linked.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_pet_auras >  _full_db\spell_pet_auras.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_proc_event >  _full_db\spell_proc_event.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_proc_item_enchant >  _full_db\spell_proc_item_enchant.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_script_target >  _full_db\spell_script_target.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_target_position >  _full_db\spell_target_position.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% skill_extra_item_template >  _full_db\skill_extra_item_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_threat >  _full_db\spell_threat.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% spell_template >  _full_db\spell_template.sql
mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% transports >  _full_db\transports.sql
REM mysqldump -Q -c -e -q -u%Username% -p%Password% -h %SERVER% %DB% world_template >  _full_db\world_template.sql
pause