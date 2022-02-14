If your database is a version prior to:

Rel22_02_001_add_character_createdDate_column.sql

You need to run the appriopriate updates in the zip file  in folder:

Rel21_to_BaseRel22_Updates


To Find out the current version of your database run this query against your mangos character database:

SELECT * FROM db_version ORDER BY VERSION DESC, structure DESC, content DESC LIMIT 0,1

