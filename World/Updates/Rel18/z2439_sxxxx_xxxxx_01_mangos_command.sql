ALTER TABLE  `db_version` CHANGE `required_r2434_01_mangos_scripted_event` `required_r2439_01_mangos_command` BIT(1) NULL DEFAULT NULL;

UPDATE
    `command`
SET
    `name` = 'appear',
    `security` = 1,
    `help` = 'Syntax: .appear [$charactername]Teleport to the given character. Either specify the character name or click on the character''s portrait, e.g. when you are in a group. Character can be offline.'
WHERE
    `name` = 'goname';

UPDATE
    `command`
SET
    `name` = 'summon',
    `security` = 1,
    `help` = 'Syntax: .summon [$charactername]Teleport the given character to you. Character can be offline.'
WHERE
    `name` = 'namego';
