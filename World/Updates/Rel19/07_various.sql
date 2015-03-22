-- Fix Condition Startup Errors

DELETE FROM conditions WHERE TYPE =15 AND value1=51 AND value2=1;
INSERT INTO conditions VALUES (1010, 15, 51, 1);
UPDATE gossip_menu SET condition_id=1010 WHERE condition_id=1200;


DELETE FROM conditions WHERE TYPE =15 AND value1=20 AND value2=1;
INSERT INTO conditions VALUES (1011, 15, 20, 1);
UPDATE gossip_menu SET condition_id=1011 WHERE condition_id=1201;

-- UnitClass Adjustments
SET @ClassWarrior = 1; -- 1: Warrior Has increased health and no mana
SET @ClassPaladin = 2; -- 2: Paladin Has increased health and low mana 
SET @ClassMage = 8;    -- 8: Mage 

-- No UnitClass and No Mana, make the entries warriors
UPDATE creature_template SET unitclass=@ClassWarrior WHERE unitclass = 0 AND minlevelmana=0;

-- No UnitClass and Mana plus Armour, make the entries paladins
UPDATE creature_template SET unitclass=@ClassPaladin WHERE unitclass = 0 AND armor>0;

-- No UnitClass and Mana plus No Armour, make the entries mages
UPDATE creature_template SET unitclass=@ClassMage WHERE unitclass = 0 AND armor=0;

-- Remove the entries that are invalid
DELETE FROM creature_template_classlevelstats WHERE class=0;

-- Fix out of range creature levels
UPDATE creature_template SET minlevel=63 WHERE minlevel>63;
UPDATE creature_template SET maxlevel=63 WHERE maxlevel>63;

-- Fix missing script
INSERT  INTO `dbscripts_on_quest_end`(`id`,`delay`,`command`,`datalong`,`datalong2`,`buddy_entry`,`search_radius`,`data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`,`x`,`y`,`z`,`o`,`comments`) VALUES (808,1,0,0,0,0,0,0,2000000016,0,0,0,0,0,0,0,'Gadrin Say');

DELETE FROM `creature_movement_template` WHERE entry=16061 AND POINT=1;
INSERT  INTO `creature_movement_template`(`entry`,`point`,`position_x`,`position_y`,`position_z`,`waittime`,`script_id`,`textid1`,`textid2`,`textid3`,`textid4`,`textid5`,`emote`,`spell`,`wpguid`,`orientation`,`model1`,`model2`) VALUES (16061,1,2765.25,-3088.47,267.685,0,1606102,0,0,0,0,0,0,0,0,0.38872,0,0);

-- Fix Loot Error 
DELETE FROM creature_loot_template WHERE entry=1;

-- Fix Lunar Invite Item Error
UPDATE item_template SET subclass=0 WHERE entry=21711
