-- version
INSERT IGNORE INTO `db_version` SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20007_18';

-- Add creature linking to Mr. Smite's adds (GUID = 79345 and 79346)
-- This also starts the fight if you add or attack his adds at the bottom of the ramp (blizzlike)

DELETE FROM `creature_linking` where `guid` IN (79345,79346) and master_guid = 79337;

INSERT INTO `creature_linking` (`guid`, `master_guid`, `flag`)
VALUES
	(79345, 79337, 1167),
	(79346, 79337, 1167);

-- Changed Mr. Smite's faction ID to another Defias Brotherhood faction ID where he wouldn't add the nearby pirates on combat start
-- Reference: https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
UPDATE `creature_template` SET `FactionAlliance`='27', `FactionHorde`='27' WHERE `Entry`='646';

-- Changed Mr. Smite's orientation and position
UPDATE `creature` SET `position_x`='-24.733', `position_y`='-798.865', `position_z`='19.4144', `orientation`='0.750789' WHERE `guid`='79337';
