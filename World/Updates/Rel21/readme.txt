If your database is a version prior to:

Rel21_22_024_NPC_1434_position_fix.sql

You need to run the appriopriate updates in the zip file  in folder:

Rel20_to_BaseRel21_Updates


To Find out the current version of your database run this query against your mangos world database:

SELECT * FROM db_version ORDER BY VERSION DESC, structure DESC, content DESC LIMIT 0,1

