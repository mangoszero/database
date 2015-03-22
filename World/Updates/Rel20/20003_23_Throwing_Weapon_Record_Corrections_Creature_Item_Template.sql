/*
    These scripts place the correct values in the fields for the Throwing Weapon items in the creature_item_template table.
	The invalid entries were in the following fields:
	class, which was set to Miscellaneous, when it should be Weapon
	subclass, which was set to Consumable, when it should be Thrown
	material, which was not set to Metal in a few cases
	inventory_type, which was set to not equipable, when it should be Thrown
 */

UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='2946';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='2947';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `material`='1', `inventory_type`='25' WHERE `entry`='3104';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `material`='1', `inventory_type`='25' WHERE `entry`='3105';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `material`='1', `inventory_type`='25' WHERE `entry`='3106';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='3107';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='3108';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='3111';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='3131';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='3135';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='3137';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='3463';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='5379';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='13173';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='15326';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='15327';
UPDATE `creature_item_template` SET `class`='2', `subclass`='16', `inventory_type`='25' WHERE `entry`='20086';
