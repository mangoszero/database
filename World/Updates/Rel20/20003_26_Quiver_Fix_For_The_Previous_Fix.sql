/*
    These scripts correct the supposed fix of a previous quiver fix. 
	inventory_type, this is the type of slot the item (quiver) goes into; in this case a bag slot, NOT a quiver!
 */

-- quivers go into bag slots not into quivers 
UPDATE `creature_item_template` SET `inventory_type`='18' WHERE `class`='11' AND `subclass`='2';

-- this fixes the previous fix, which was not a fix (Quivers go into bag slots not into quivers)
UPDATE `item_template` SET `InventoryType`='18' WHERE `class`='11' AND `subclass`='2';