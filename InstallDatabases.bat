@ECHO OFF

set createcharDB=YES
set createworldDB=YES
set createrealmDB=YES

set loadcharDB=YES
set loadworldDB=YES
set loadrealmDB=YES

set CDBUpdate=YES
set WDBUpdate=YES
set RDBUpdate=YES

set addrealmentry=YES

set DBType=POPULATED
set activity=N

set locFR=NO
set locES=NO
set locDE=NO


rem -- Change the values below to match your server --
set mysql=Tools\
set svr=localhost
set user=root
set pass=mangos
set port=3306
set wdb=mangos0
set wdborig=mangos0
set cdb=character0
set cdborig=character0
set rdb=realmd
set rdborig=realmd

rem -- Don't change past this point --

:main
color 0e
CLS
echo.
echo     __  __      _  _  ___  ___  ___      
echo    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|   Database Setup and                                      
echo    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \
echo    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/  World Loader v0.07
echo.
echo _____________________________________________________________
echo.
echo          Website / Forum / Wiki: https://getmangos.eu         
echo _____________________________________________________________
echo.
ECHO.
echo    Character Database :   V   - Toggle Actually Create Character DB (%createcharDB%)
echo                           C   - Toggle Create Character DB Structure (%loadcharDB%)
echo                           B   - Apply Character DB updates (%CDBUpdate%)
echo.
echo        World Database :   E   - Toggle Actually Create World DB (%createworldDB%)    
echo                           W   - Toggle Create World DB Structure (%loadworldDB%)     
if %loadworldDB% == YES echo                           D   - Toggle World Type (%DBType%)
echo                           U   - Apply World DB updates (%WDBUpdate%)
echo.
echo        Realm Database :   T   - Toggle Actually Create Realm DB (%createrealmDB%)     
echo                           R   - Toggle Create Realm Db Structure (%loadrealmDB%)
echo                           Y   - Apply Realm DB updates (%RDBUpdate%)
echo                           L   - Toggle Add RealmList Entry (%addrealmentry%)
echo.
set LOCList=NO
if %locFR% == YES set LOCList=YES
if %locDE% == YES set LOCList=YES 
if %locES% == YES set LOCList=YES

REM echo                           A   - Add Localised Content (%LOCList%)
echo                           N   - Next Step
echo                           X   - Exit
echo.
set /p activity=. Please select an activity ? : 
if %activity% == V goto ToggleCharDB:
if %activity% == v goto ToggleCharDB:
if %activity% == B goto ToggleCharDBUpdate:
if %activity% == b goto ToggleCharDBUpdate:
if %activity% == E goto ToggleWorldDB:
if %activity% == e goto ToggleWorldDB:
if %activity% == U goto ToggleWorldDBUpdate:
if %activity% == u goto ToggleWorldDBUpdate:
if %activity% == D goto ToggleWorldDBType:
if %activity% == d goto ToggleWorldDBType:
if %activity% == T goto ToggleRealmDB:
if %activity% == t goto ToggleRealmDB:
if %activity% == Y goto ToggleRealmDBUpdate:
if %activity% == y goto ToggleRealmDBUpdate:
if %activity% == C goto LoadCharDB:
if %activity% == c goto LoadCharDB:
if %activity% == W goto LoadWorldDB:
if %activity% == w goto LoadWorldDB:
if %activity% == R goto LoadRealmDB:
if %activity% == r goto LoadRealmDB:
if %activity% == L goto AddRealmDB:
if %activity% == l goto AddRealmDB:

if %activity% == N goto Step1:
if %activity% == n goto Step1:

REM if %activity% == A goto StepLoc1:
REM if %activity% == a goto StepLoc1:

if %activity% == X goto done3:
if %activity% == x goto done3:
if %activity%. == . goto main:
goto main

:ToggleWorldDBType
if %DBType% == EMPTY goto ToggleWorldDBTypePopulated:
if %DBType% == POPULATED goto ToggleWorldDBTypeEmpty:
goto main:

:ToggleWorldDBTypePopulated
set DBType=POPULATED
goto main:

:ToggleWorldDBTypeEmpty
set DBType=EMPTY
goto main:

:ToggleCharDB
if %createcharDB% == NO goto ToggleCharDBNo:
if %createcharDB% == YES goto ToggleCharDBYes:
goto main:

:ToggleCharDBNo
set createcharDB=YES
goto main:

:ToggleCharDBYes
set createcharDB=NO
goto main:

:ToggleCharDBUpdate
if %CDBUpdate% == NO goto ToggleCharDBUpdateNo:
if %CDBUpdate% == YES goto ToggleCharDBUpdateYes:
goto main:

:ToggleCharDBUpdateNo
set CDBUpdate=YES
goto main:

:ToggleCharDBUpdateYes
set CDBUpdate=NO
goto main:

:ToggleWorldDB
if %createworldDB% == NO goto ToggleWorldDBNo:
if %createworldDB% == YES goto ToggleWorldDBYes:
goto main:

:ToggleWorldDBNo
set createworldDB=YES
goto main:

:ToggleWorldDBYes
set createworldDB=NO
goto main:

:ToggleWorldDBUpdate
if %WDBUpdate% == NO goto ToggleWorldDBUpdateNo:
if %WDBUpdate% == YES goto ToggleWorldDBUpdateYes:
goto main:

:ToggleWorldDBUpdateNo
set WDBUpdate=YES
goto main:

:ToggleWorldDBUpdateYes
set WDBUpdate=NO
goto main:

:ToggleRealmDB
if %createrealmDB% == NO goto ToggleRealmDBNo:
if %createrealmDB% == YES goto ToggleRealmDBYes:
goto main:

:ToggleRealmDBNo
set createrealmDB=YES
goto main:

:ToggleRealmDBYes
set createrealmDB=NO
goto main:

:ToggleRealmDBUpdate
if %RDBUpdate% == NO goto ToggleRealmDBUpdateNo:
if %RDBUpdate% == YES goto ToggleRealmDBUpdateYes:
goto main:

:ToggleRealmDBUpdateNo
set RDBUpdate=YES
goto main:

:ToggleRealmDBUpdateYes
set RDBUpdate=NO
goto main:

:LoadCharDB
if %loadcharDB% == NO goto LoadCharDBNo:
if %loadcharDB% == YES goto LoadCharDBYes:
goto main:

:LoadCharDBNo
set loadcharDB=YES
goto main:

:LoadCharDBYes
set loadcharDB=NO
goto main:


:LoadWorldDB
if %loadworldDB% == NO goto LoadWorldDBNo:
if %loadworldDB% == YES goto LoadWorldDBYes:
goto main:

:LoadWorldDBNo
set loadworldDB=YES
goto main:

:LoadWorldDBYes
set loadworldDB=NO
goto main:

:LoadRealmDB
if %loadrealmDB% == NO goto LoadRealmDBNo:
if %loadrealmDB% == YES goto LoadRealmDBYes:
goto main:

:LoadRealmDBNo
set loadrealmDB=YES
goto main:

:LoadRealmDBYes
set loadrealmDB=NO
goto main:

:AddRealmDB
if %addrealmentry% == NO goto AddRealmDBNo:
if %addrealmentry% == YES goto AddRealmDBYes:
goto main:

:AddRealmDBNo
set addrealmentry=YES
goto main:

:AddRealmDBYes
set addrealmentry=NO
goto main:

:Step1
if not exist %mysql%\mysql.exe then goto patherror
color 08
CLS
echo.
echo     __  __      _  _  ___  ___  ___      
echo    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|    Database Setup                                      
echo    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \
echo    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/  and World Loader
echo.
echo _____________________________________________________________
echo.
echo.
set /p svr=What is your MySQL host name?           [%svr%] : 
if %svr%. == . set svr=localhost
set /p user=What is your MySQL user name?                [%user%] : 
if %user%. == . set user=root
set /p pass=What is your MySQL password?               [%pass%] : 
if %pass%. == . set pass=mangos
set /p port=What is your MySQL port?                     [%port%] : 
if %port%. == . set port=3306

set showChar=0
if %createcharDB% == YES set showChar=1
if %loadcharDB% == YES set showChar=1

if %showChar% == 1 set /p cdb=What is your Character database name?  [%cdb%] : 
if %cdb%. == . set cdb=%cdborig%

set showWorld=0
if %createworldDB% == YES set showWorld=1
if %loadworldDB% == YES set showWorld=1
if %showWorld% == 1 set /p wdb=What is your World database name?         [%wdb%] : 
if %wdb%. == . set wdb=%wdborig%

set showRealm=0
if %createrealmDB% == YES set showRealm=1
if %loadrealmDB% == YES set showRealm=1
if %addrealmentry% == YES set showRealm=1

if %showRealm% == 1 set /p rdb=What is your Realm database name?          [%rdb%] : 
if %rdb%. == . set rdb=%rdborig%

color 02

:WorldDB
REM ##### IF createworlddb = YES then create the DB
if %createworldDB% == YES goto WorldDB1:

:WorldDB2
REM ##### IF loadworlddb = YES then load the DB
if %loadworldDB% == YES goto WorldDB3:

:CharDB
REM ##### IF createchardb = YES then create the DB
if %createcharDB% == YES goto CharDB1:

:CharDB2
REM ##### IF loadchardb = YES then load the DB
if %loadcharDB% == YES goto CharDB3:

:RealmDB
REM ##### IF createrealmdb = YES then create the DB
if %createrealmDB% == YES goto RealmDB1:

:RealmDB2
REM ##### IF loadrealmdb = YES then load the DB
if %loadrealmDB% == YES goto RealmDB3:

:RealmDB4
if %addrealmentry% == YES goto RealmDB5:

goto done:

:WorldDB1
echo Creating World Database %wdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "create database %wdb%";
goto WorldDB2:

:WorldDB3
if %DBType% == POPULATED goto WorldDB4:
echo  Preparing world Database Structure %wdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < World\Setup\mangosdLoadDB.sql
goto CharDB:

:WorldDB4
echo  Preparing world Database Structure %wdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < World\Setup\mangosdLoadDB.sql
echo  Importing World database information %wdb%
for %%i in (World\Setup\FullDB\*.sql) do echo %%i & %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < %%i
goto CharDB:

:CharDB1
echo Creating Character Database %cdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "create database %cdb%";
goto CharDB2:

:CharDB3
echo  Loading Character Database %cdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %cdb% < Character\Setup\characterLoadDB.sql
goto RealmDB:

:RealmDB1
echo Creating Realm Database %rdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "create database %rdb%";
goto RealmDB2:

:RealmDB3
echo  Loading Realm Database %rdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %rdb% < Realm\Setup\realmdLoadDB.sql
goto RealmDB4:

:RealmDB5
echo.
echo  Adding RealmList entry in Realm Database %rdb%
echo --------------------------------------------------
if %addrealmentry% == YES %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %rdb% < Tools\updateRealm.sql
echo --------------------------------------------------
goto done:


:patherror
echo Cannot find required files.
pause
goto :error

:StepLoc1
color 0e
cls
echo.
echo     __  __      _  _  ___  ___  ___      
echo    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|    Database Setup                                      
echo    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \
echo    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/  and World Loader
echo.
echo _____________________________________________________________
echo.
echo  Database Localisation Support
echo _____________________________________________________________
echo.
echo    French (Francaís)  : F   - Toggle Loading Localisations (%locFR%)
echo.
echo       German (Deusch)  : G/D - Toggle Loading Localisations (%locDE%)    
echo.
echo     Spanish (Espána)  : S/E - Toggle Loading Localisations (%locES%)     
echo.
echo                          N   - Next Step
echo.
set /p activity=. Please select an activity ? : 
if %activity% == F goto ToggleLocFR:
if %activity% == f goto TogglelocFR:
if %activity% == G goto TogglelocDE:
if %activity% == g goto TogglelocDE:
if %activity% == D goto TogglelocDE:
if %activity% == d goto TogglelocDE:
if %activity% == S goto TogglelocES:
if %activity% == s goto TogglelocES:
if %activity% == E goto TogglelocES:
if %activity% == e goto TogglelocES:
if %activity% == N goto main:
if %activity% == n goto main:
goto StepLoc1

:ToggleLocFR
if %locFR% == NO goto ToggleLocFRNo:
if %locFR% == YES goto ToggleLocFRYes:
goto StepLoc1:

:ToggleLocFRNo
set locFR=YES
goto StepLoc1:

:ToggleLocFRYes
set locFR=NO
goto StepLoc1:

:ToggleLocDE
if %locDE% == NO goto ToggleLocDENo:
if %locDE% == YES goto ToggleLocDEYes:
goto StepLoc1:

:ToggleLocDENo
set locDE=YES
goto StepLoc1:

:ToggleLocDEYes
set locDE=NO
goto StepLoc1:

:ToggleLocES
if %locES% == NO goto ToggleLocESNo:
if %locES% == YES goto ToggleLocESYes:
goto StepLoc1:

:ToggleLocESNo
set locES=YES
goto StepLoc1:

:ToggleLocESYes
set locES=NO
goto StepLoc1:

:error
echo _____________________________________________________________
echo.
echo  Install Database Process Failed
echo _____________________________________________________________
echo.
goto finish:

:PatchWorld
echo.
echo _____________________________________________________________
echo.
echo  Applying world DB updates
echo _____________________________________________________________
echo.
for %%i in (World\Updates\Rel21\*.sql) do echo %%i & %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < %%i
goto done2

:PatchRealm
echo.
echo _____________________________________________________________
echo.
echo  Applying Realm DB updates
echo _____________________________________________________________
echo.
for %%i in (Realm\Updates\Rel21\*.sql) do echo %%i & %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %rdb% < %%i
goto done3

:patchCharacter
echo.
echo _____________________________________________________________
echo.
echo  Applying Character DB updates
echo _____________________________________________________________
echo.
for %%i in (Character\Updates\Rel21\*.sql) do echo %%i & %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %cdb% < %%i
goto done1

:done
if %CDBUpdate% == YES goto patchCharacter:
:done1
if %WDBUpdate% == YES goto patchWorld:
:done2
if %RDBUpdate% == YES goto PatchRealm:
:done3
color 08
echo.
echo     __  __      _  _  ___  ___  ___      
echo    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|    Database Setup                                      
echo    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \
echo    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/  and World Loader
echo.
echo _____________________________________________________________
echo.
echo  Database Creation and Load complete
echo _____________________________________________________________
echo.
echo Done :)
echo.
:finish
pause
