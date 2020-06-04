-- Adjust as desired before import:
--   mysql < ./user.sql
CREATE USER 'mangos'@'%' IDENTIFIED BY 'mangos';

-- Permissions set in [table]/Setup/[table]CreateDB.sql