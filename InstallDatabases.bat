@ECHO OFF

set createcharDB=YES
set createworldDB=YES
set createrealmDB=YES

set loadcharDB=YES
set loadworldDB=YES
set loadrealmDB=YES
set DBType=POPULATED
set activity=N

set locFR=NO
set locES=NO
set locDE=NO


rem -- Change the values below to match your server --
set mysql=Tools\
set svr=localhost
set user=mangos
set pass=
set port=3306
set wdb=mangos0
set cdb=character0
set rdb=realmd

rem -- Don't change past this point --

:main
color 0e
CLS
echo.
echo     __  __      _  _  ___  ___  ___      
echo    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|   Database Setup and                                      
echo    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \
echo    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/   World Loader v0.03
echo.
echo _____________________________________________________________
echo.
echo             Website / Forum / Wiki: https://getmangos.eu         
echo _____________________________________________________________
echo.
ECHO.
echo    Character Database : V - Toggle Create DB (%createcharDB%)
echo                         C - Toggle Create Structure (%loadcharDB%)
echo.
echo        World Database : E - Toggle Create DB (%createworldDB%)    
echo                         W - Toggle Create Structure (%loadworldDB%)     
echo                         D - Toggle World Type (%DBType%)
echo.
echo        Realm Database : T - Toggle Create DB (%createrealmDB%)     
echo                         R - Toggle Create Structure (%loadrealmDB%)
echo.
set LOCList=NO
if %locFR% == YES set LOCList=YES
if %locDE% == YES set LOCList=YES 
if %locES% == YES set LOCList=YES

REM echo                         A - Add Localised Content (%LOCList%)
echo                         N - Next Step
echo                         X - Exit
echo.
set /p activity=. Please select an activity ? : 
if %activity% == V goto ToggleCharDB:
if %activity% == v goto ToggleCharDB:
if %activity% == E goto ToggleWorldDB:
if %activity% == e goto ToggleWorldDB:
if %activity% == D goto ToggleWorldDBType:
if %activity% == d goto ToggleWorldDBType:
if %activity% == T goto ToggleRealmDB:
if %activity% == t goto ToggleRealmDB:
if %activity% == C goto LoadCharDB:
if %activity% == c goto LoadCharDB:
if %activity% == W goto LoadWorldDB:
if %activity% == w goto LoadWorldDB:
if %activity% == R goto LoadRealmDB:
if %activity% == r goto LoadRealmDB:

if %activity% == N goto Step1:
if %activity% == n goto Step1:

REM if %activity% == A goto StepLoc1:
REM if %activity% == a goto StepLoc1:

if %activity% == X goto done:
if %activity% == x goto done:
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

:Step1
if not exist %mysql%\mysql.exe then goto patherror
color 08
CLS
echo.
echo     __  __      _  _  ___  ___  ___      
echo    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|   Database Setup and                                      
echo    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \
echo    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/   World Loader v0.03
echo.
echo _____________________________________________________________
echo.
echo.
set /p svr=. What is your MySQL host name?           [localhost] : 
if %svr%. == . set svr=localhost
set /p user=. What is your MySQL user name?             [mangos] : 
if %user%. == . set user=mangos
set /p pass=. What is your MySQL password?                   [ ] : 
if %pass%. == . set pass=
set /p port=. What is your MySQL port?                    [3306] : 
if %port%. == . set port=3306
set /p cdb=. What is your Character database name?  [character0] : 
if %cdb%. == . set cdb=character0
set /p wdb=. What is your World database name?         [mangos0] : 
if %wdb%. == . set wdb=mangos0
set /p rdb=. What is your Realm database name?          [realmd] : 
if %rdb%. == . set rdb=realmd

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

goto done:

:WorldDB1
echo Creating World Database %wdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "create database %wdb%";
goto WorldDB2:

:WorldDB3
if %DBType% == POPULATED goto WorldDB4:
echo  Loading world Database %wdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < World\Setup\mangosdLoadDB.sql
goto CharDB:

:WorldDB4
echo  Importing World database %wdb%
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
echo    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|   Database Setup and                                      
echo    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \
echo    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/   World Loader v0.03
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

:done
color 08
echo.
echo     __  __      _  _  ___  ___  ___      
echo    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|   Database Setup and                                      
echo    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \
echo    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/   World Loader v0.03
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