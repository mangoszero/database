-- core adds another parameter to be printed out: aura stack number
-- NOTE probably the best way was to change db `structure` because old string with new core leads to a crash
-- however the list aura command is used so rarely that even when missing this update, crash chance is minimal

UPDATE `mangos_string` SET `content_default`='id: %d eff: %d type: %d duration: %d maxduration: %d name: %s%s%s caster: %s (stacks: %d)' WHERE `entry`=468;

INSERT INTO `db_version` VALUES ('21', '1', '3', 'list_aura_command', '');
