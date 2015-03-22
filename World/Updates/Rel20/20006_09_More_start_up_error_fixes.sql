-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_09';

--                         ******************        FIXES BY ARKADUS        ***************

-- Start up error fixes

UPDATE `creature_template` 
SET `ExtraFlags` = 2
WHERE `Entry` = 69 OR `Entry` = 5912 OR `Entry` = 8297 OR `Entry` = 1508 OR `Entry` = 1509;

UPDATE `item_template` 
SET `subclass` = 0
WHERE `class` = 15;

DELETE FROM `creature_equip_template` 
WHERE `equipentry1` = 27524;

UPDATE `creature_template` 
SET `FactionAlliance` = 115, `FactionHorde` = 115, `UnitClass` = 1
WHERE `Entry` = 14755 OR `Entry` = 14756;

DELETE FROM `gameobject` 
WHERE `GUID` = 5315 OR `GUID` = 5431;

DELETE FROM `conditions` 
WHERE `condition_entry` = 717 OR `condition_entry` = 718;

DELETE FROM `creature_loot_template`
WHERE `entry` = 68 OR `entry` = 325 OR `entry` = 466 OR `entry` = 467 OR `entry` = 468 OR `entry` = 469 OR `entry` = 487 OR `entry` = 488 OR `entry` = 489 OR `entry` = 490
OR `entry` = 494 OR `entry` = 495 OR `entry` = 499 OR `entry` = 754 OR `entry` = 826 OR `entry` = 827 OR `entry` = 828 OR `entry` = 853 OR `entry` = 861 OR `entry` = 862 OR `entry` = 863 OR `entry` = 864 OR `entry` = 865 OR `entry` = 866 OR `entry` = 867 OR `entry` = 868 OR `entry` = 869
OR `entry` = 870 OR `entry` = 874 OR `entry` = 876 OR `entry` = 885 OR `entry` = 886 OR `entry` = 887 OR `entry` = 932 OR `entry` = 933 OR `entry` = 934 OR `entry` = 935 OR `entry` = 936 OR `entry` = 999 OR `entry` = 1064 OR `entry` = 1245 OR `entry` = 1278
OR `entry` = 1280 OR `entry` = 1337 OR `entry` = 1338 OR `entry` = 1414 OR `entry` = 1421 OR `entry` = 1434 OR `entry` = 1437 OR `entry` = 1476 OR `entry` = 1477 OR `entry` = 1481
OR `entry` = 1483 OR `entry` = 1642 OR `entry` = 1733 OR `entry` = 1741 OR `entry` = 1754 OR `entry` = 1756 OR `entry` = 1777 OR `entry` = 1949 OR `entry` = 1975 OR `entry` = 2058 OR `entry` = 2099 OR `entry` = 2105 OR `entry` = 2112
OR `entry` = 2153 OR `entry` = 2238 OR `entry` = 2239 OR `entry` = 2361 OR `entry` = 2362 OR `entry` = 2363 OR `entry` = 2378 OR `entry` = 2379 OR `entry` = 2386 OR `entry` = 2392 OR `entry` = 2395 OR `entry` = 2396 OR `entry` = 2398 OR `entry` = 2400 OR `entry` = 2402 OR `entry` = 2466
OR `entry` = 2468 OR `entry` = 2469 OR `entry` = 2470 OR `entry` = 2506 OR `entry` = 2507 OR `entry` = 2508 OR `entry` = 2509 OR `entry` = 2510 OR `entry` = 2511 OR `entry` = 2527 OR `entry` = 2608
OR `entry` = 2714 OR `entry` = 2721 OR `entry` = 2787 OR `entry` = 3083 OR `entry` = 3338 OR `entry` = 3501 OR `entry` = 3691 OR `entry` = 3695 OR `entry` = 3732 OR `entry` = 3733 OR `entry` = 3734 OR `entry` = 3804 OR `entry` = 3806 OR `entry` = 3807 OR `entry` = 3808 OR `entry` = 3893 OR `entry` = 4966 OR `entry` = 4979 OR `entry` = 4995 OR `entry` = 5546
OR `entry` = 7489 OR `entry` = 7730 OR `entry` = 7843 OR `entry` = 7865 OR `entry` = 7939 OR `entry` = 7975 OR `entry` = 7980 OR `entry` = 8015 OR `entry` = 8016 OR `entry` = 8096 OR `entry` = 8147 OR `entry` = 8154 OR `entry` = 8155
OR `entry` = 8310 OR `entry` = 9118 OR `entry` = 9119 OR `entry` = 9525 OR `entry` = 10036 OR `entry` = 10037 OR `entry` = 10684 OR `entry` = 10696 OR `entry` = 11040 OR `entry` = 11053 OR `entry` = 11180 OR `entry` = 11276
OR `entry` = 11328 OR `entry` = 11609 OR `entry` = 11615 OR `entry` = 11979 OR `entry` = 11994 OR `entry` = 12047 OR `entry` = 12160 OR `entry` = 12657 OR `entry` = 12658 OR `entry` = 12736 OR `entry` = 12858
OR `entry` = 12862 OR `entry` = 12863 OR `entry` = 12903 OR `entry` = 13817 OR `entry` = 14983 OR `entry` = 15443 OR `entry` = 17070 OR `entry` = 17079 OR `entry` = 17080
OR `entry` = 2512 OR `entry` = 2513 OR `entry` = 2514 OR `entry` = 2515 OR `entry` = 2516 OR `entry` = 2517 OR `entry` = 2518 OR `entry` = 2525 OR `entry` = 2526;

DELETE FROM `gameobject_loot_template`
WHERE
`entry` = 164885 OR `entry` = 164887 OR `entry` = 173324 OR `entry` = 173327 OR `entry` = 174599 OR `entry` = 174600 OR `entry` = 174601 OR `entry` = 174602 OR `entry` = 174603 OR `entry` = 174604 OR `entry` = 174608 OR `entry` = 174684 OR `entry` = 174708 OR `entry` = 174709 OR `entry` = 182114;

DELETE FROM `gossip_menu_option`
WHERE
`condition_id` = 718 OR `condition_id` = 717 OR `menu_id` = 10360;

DELETE FROM `gossip_menu`
WHERE
`condition_id` = 718;

DELETE FROM `dbscripts_on_gossip`
WHERE
`id` = 2908 OR `id` = 66442 OR `id` = 66441;

DELETE FROM `dbscripts_on_quest_start`
WHERE
`datalong` = 317 OR `datalong` = 318;

DELETE FROM `db_script_string`
WHERE
`entry` = 2000000016 OR `entry` = 2000005019 OR `entry` = 2000005020;

UPDATE `creature_movement` 
SET `script_id` = 0
WHERE `script_id` = 1018206;

UPDATE `npc_vendor`
SET `incrtime` = 0
WHERE `entry` = 491 AND `item` = 4496;

UPDATE `creature_template`
SET `npcflags` = 2
WHERE `entry` = 3209;

UPDATE `creature_template`
SET `npcflags` = 135
WHERE `entry` = 9087;

UPDATE `creature_item_template`
SET `class` = 2, `subclass` = 16, `inventory_type` = 25, `sheath_type` = 0, `material` = 1
WHERE `entry` = 2945 OR `entry` = 3109 OR `entry` = 3128 OR `entry` = 4959 OR `entry` = 5559 OR `entry` = 20814 OR `entry` = 21135 OR `entry` = 25497 OR `entry` = 25641 OR `entry` = 25665;

UPDATE `creature_item_template`
SET `sheath_type` = 0, `inventory_type` = 27, `class` = 11, `subclass` = 2, `material` = 8
WHERE `entry` = 2101 OR `entry` = 2662 OR `entry` = 3573 OR `entry` = 3605 OR `entry` = 5439 OR `entry` = 7278 OR `entry` = 7371 OR `entry` = 8217 OR `entry` = 11362 OR `entry` = 18714 OR `entry` = 19319 OR `entry` = 34100;

UPDATE `creature_item_template`
SET `class` = 2, `subclass` = 5, `inventory_type` = 17,`sheath_type` = 1, `material` = 1
WHERE `entry` = 9464;

UPDATE `creature_item_template`
SET `class` = 2, `subclass` = 7, `inventory_type` = 13,`sheath_type` = 3, `material` = 1
WHERE `entry` = 9719 OR `entry` = 32674;

UPDATE `creature_item_template`
SET `class` = 12, `subclass` = 0, `inventory_type` = 23,`sheath_type` = 2, `material` = 2
WHERE `entry` = 11885;

UPDATE `creature_item_template`
SET `class` = 4, `subclass` = 0, `inventory_type` = 23,`sheath_type` = 2, `material` = 4
WHERE `entry` = 11905 OR `entry` = 12065 OR `entry` = 13544;

UPDATE `creature_item_template`
SET `class` = 15, `subclass` = 0, `inventory_type` = 23,`sheath_type` = 0, `material` = 0
WHERE `entry` = 13876 OR `entry` = 13877 OR `entry` = 13878 OR `entry` = 13879 OR `entry` = 13880 OR `entry` = 21169 OR `entry` = 21170 OR `entry` = 21171 OR `entry` = 21172 OR `entry` = 21173 OR `entry` = 21174 OR `entry` = 32911 OR `entry` = 32921 OR `entry` = 21713;

UPDATE `creature_item_template`
SET `class` = 0, `subclass` = 0, `inventory_type` = 26,`sheath_type` = 0, `material` = 0
WHERE `entry` = 20908;

UPDATE `creature_item_template`
SET `material` = 0
WHERE `material` = 255;