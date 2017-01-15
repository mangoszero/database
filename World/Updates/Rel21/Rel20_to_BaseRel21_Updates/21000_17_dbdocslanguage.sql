-- The New stored procdure system doesn't like performing this update

    -- Apply the Version Change from Old Version to New Version
    ALTER TABLE db_version CHANGE COLUMN `required_21000_16_Terl_Arakor_Wetlands_gossip_text` `required_21000_17_dbdocslanguage` BIT;
    INSERT IGNORE INTO db_version VALUES ('MaNGOSZero Database Rev 21000_17',NULL,NULL);

--
-- Table structure for table `dbdocslanguage`
--

CREATE TABLE `dbdocslanguage` (
  `LanguageId` INT(11) NOT NULL COMMENT 'LanguageId for this Language',
  `LanguageName` VARCHAR(30) NOT NULL COMMENT 'The Language Name',
  PRIMARY KEY (`LanguageId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping Data for table `dbdocslanguage`
--

INSERT  INTO `dbdocslanguage`(`LanguageId`,`LanguageName`) VALUES (0,'English');
INSERT  INTO `dbdocslanguage`(`LanguageId`,`LanguageName`) VALUES (1,'Korean');
INSERT  INTO `dbdocslanguage`(`LanguageId`,`LanguageName`) VALUES (2,'French');
INSERT  INTO `dbdocslanguage`(`LanguageId`,`LanguageName`) VALUES (3,'German');
INSERT  INTO `dbdocslanguage`(`LanguageId`,`LanguageName`) VALUES (4,'Chinese');
INSERT  INTO `dbdocslanguage`(`LanguageId`,`LanguageName`) VALUES (5,'Taiwanese');
INSERT  INTO `dbdocslanguage`(`LanguageId`,`LanguageName`) VALUES (6,'Spanish (Spain)');
INSERT  INTO `dbdocslanguage`(`LanguageId`,`LanguageName`) VALUES (7,'Spanish (Latin America)');
INSERT  INTO `dbdocslanguage`(`LanguageId`,`LanguageName`) VALUES (8,'Russian');


