CREATE DATABASE `characters0` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE USER 'mangos'@'localhost' IDENTIFIED BY 'mangos';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES ON `characters0`.* TO 'mangos'@'localhost';
