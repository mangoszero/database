DELETE FROM `conditions` WHERE `condition_entry` IN (1718,1719,1720,1721,1722,1723,1724,1725,1726,1727,1728,1729,1730,1731,1732);

INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES
(1718, 8, 8700, 0),
(1719, 24, 21408, 1),
(1720, -1, 1718, 1719),
(1721, 8, 8699, 0),
(1722, 24, 21414, 1),
(1723, -1, 1721, 1722),
(1724, 8, 8701, 0),
(1725, 24, 21405, 1),
(1726, -1, 1724, 1725),
(1727, 8, 8703, 0),
(1728, 24, 21396, 1),
(1729, -1, 1727, 1728),
(1730, 8, 8697, 0),
(1731, 24, 21411, 1),
(1732, -1, 1730, 1731);

UPDATE gossip_menu_option SET condition_id=1720 WHERE menu_id = 6928 AND id = 0;
UPDATE gossip_menu_option SET condition_id=1723 WHERE menu_id = 6928 AND id = 1;
UPDATE gossip_menu_option SET condition_id=1726 WHERE menu_id = 6928 AND id = 2;
UPDATE gossip_menu_option SET condition_id=1729 WHERE menu_id = 6928 AND id = 3;
UPDATE gossip_menu_option SET condition_id=1732 WHERE menu_id = 6928 AND id = 4;
