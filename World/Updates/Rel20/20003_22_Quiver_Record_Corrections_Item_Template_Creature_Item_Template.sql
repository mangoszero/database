/*
    These scripts place the correct values in the fields for the Quiver item in the creature_item_template and item_template tables.
	The invalid entries were in the following fields:
	material, which was not set to Leather in some cases
	inventory_type, which was set to Bag, when it should be Quiver
	sheath_type, which was set to 0, when it should be 2
 */


-- this corrects the field entries for the Quiver records in the creature_item_template table
UPDATE `creature_item_template` SET `material`='8', `inventory_type`='27', `sheath_type`='2' WHERE `class`='11' AND `subclass`='2';

-- this corrects the field entries for the Quiver records in the item_template table
UPDATE `item_template` SET `InventoryType`='27' WHERE `class`='11' AND `subclass`='2';