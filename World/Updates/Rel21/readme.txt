If your database is a version prior to:

Rel21_14_067_kodo_roundup_tidyup

You need to run the appriopriate updates in folder:

Rel20_to_BaseRel21_Updates

To Find out the current version of your database run this query against your mangos world database:

SELECT * FROM db_version ORDER BY VERSION DESC, structure DESC, content DESC LIMIT 0,1

