ALTER TABLE character_db_version CHANGE COLUMN required_19002_01_character_ticket required_19002_02_character_whispers BIT;

CREATE TABLE `character_whispers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id of the whisper, sort by this or time',
  `to_guid` int(10) NOT NULL COMMENT 'guid of receiver of the whisper',
  `from_guid` int(10) NOT NULL COMMENT 'guid of sender of the whisper',
  `message` varchar(256) NOT NULL COMMENT 'actual whisper that was sent',
  `regarding_ticket_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'link to character_ticket.ticket_id, if 0 just a log of a whisper sent',
  `sent_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'this is when the whisper was sent',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
