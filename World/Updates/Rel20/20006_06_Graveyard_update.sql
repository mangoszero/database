-- Add the Revision update into the revision column
INSERT IGNORE INTO db_version SET `Version` = 'MaNGOSZero Database 2.0.11 Rev 20006_06';

--                         ******************        FIXES BY ARKADUS        ***************

-- Graveyard Updates for Alliance/Horde Cities

REPLACE INTO `game_graveyard_zone`
(`id`, `ghost_zone`, `faction`)
VALUES
(852, 1537, 469),
(853, 1497, 67);

UPDATE `game_graveyard_zone`
SET `id` = 429
WHERE `faction` = 469 AND `ghost_zone` = 85;

UPDATE `game_graveyard_zone`
SET `id` = 229
WHERE `faction` = 469 AND `ghost_zone` = 1638;

INSERT INTO `game_graveyard_zone` (`id`,`ghost_zone`,`faction`)
VALUES (101,1537,67),(429,1497,469);
