-- strings for new gobj commands: state, lootstate

DELETE FROM `mangos_string` WHERE `entry` IN (573,574);
INSERT INTO `mangos_string` (`entry`,`content_default`) VALUES
 (573,'The lootstate of GO lowGuid %u is %u.'),
 (574,'The GO state of GO lowGuid %u is %u.');
