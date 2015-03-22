/*
    This fixes the issue where the braves in the Tauren Starting area greet people when being interacted with, when 
    they should not say anything.
    The issue is caused by the wrong value in the NpcFlags, which should be set to 0, not 1. 1 means the NPC has 
    gossip dialogue, 0 no dialogue.
    Details on the NpcFlags field: https://github.com/cmangos/issues/wiki/creature_template
 */

-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 05';

-- Brave Darksky
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3220';
-- Brave Dawneagle
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3217';
-- Brave Greathoof
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3214';
-- Brave Ironhorn
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3212';
-- Brave Leaping Deer
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3219';
-- Brave Lightninghorn
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3211';
-- Brave Proudsnout
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3210';
-- Brave Rainchaser
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3223';
-- Brave Rockhorn
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3221';
-- Brave Running Wolf
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3213';
-- Brave Strongbash
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3215';
-- Brave Swiftwind
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3218';
-- Brave Wildrunner
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3222';
-- Brave Windfeather
UPDATE creature_template SET `NpcFlags`='0' WHERE `Entry`='3209';
