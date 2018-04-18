@ECHO OFF

rem -- Change the values below to match your server --
set mysql=Tools\
set svr=localhost
set newuser=mangos
set user=root
set pass=mangos
set newpass=mangos
set port=3306
set wdb=mangos0
set wdborig=mangos0
set cdb=character0
set cdborig=character0
set rdb=realmd
set rdborig=realmd

rem -- Don't change past this point --

rem setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "6.3" echo Windows 8.1
if "%version%" == "6.2" echo Windows 8.
if "%version%" == "6.1" echo Windows 7.
if "%version%" == "6.0" echo Windows Vista.
if "%version%" == "10.0" echo Windows 10.

if "%version%" == "10.0" goto setColours:
goto setOptions:

:setColours
set colReset=[0m
set colYellow=[33m
set colYellowBold=[93m
set colWhiteBold=[97m
set colWhiteDarkBlue=[97;44m
set colWhiteLightBlue=[97;104m
set colWhiteLightGreen=[97;42m
set colCyanBold=[96m
set colCyan=[36m
set colWhite=[37m
set colMagentaBold=[95m
set colMagenta=[35m
set colRedBold=[91m
set colRed=[31m
set colGreenBold=[92m
set colGreen=[32m
set colWhiteDarkRed=[97;101m
set colBold=[101m
set colWhiteDarkYellow=[97;43m

:setOptions
set createcharDB=YES
set createworldDB=YES
set createrealmDB=YES
set createMangosUser=YES
set updatesOnly=NO
set loadcharDB=YES
set loadworldDB=YES
set loadrealmDB=YES
set defaultsused=NO 

set CDBUpdate=YES
set WDBUpdate=YES
set RDBUpdate=YES

set addrealmentry=YES

set DBType=POPULATED
set activity=N

set locFR=NO
set locES=NO
set locDE=NO

rem -- first check that the repo has been cloned correctly
if not exist Realm goto missingRecursive:

:main
CLS

echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader v1.0%colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteLightBlue%^|                                                                             ^|
echo ^|   Website / Forum / Wiki / Support: https://getmangos.eu                    ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colWhiteBold%^|                                                                             ^|
if %createcharDB% == NO set PAD= 
if %createcharDB% == YES set PAD=
echo %colWhiteBold%^|   %colWhiteBold%Character Database : V - %colReset%Toggle Actually Create Character DB (%colYellowBold%%createcharDB%%colReset%)        %PAD%%colWhiteBold%^|
if %loadcharDB% == NO set PAD= 
if %loadcharDB% == YES set PAD=
echo %colWhiteBold%^|                        %colWhiteBold%C - %colReset%Toggle Create Character DB Structure (%colYellowBold%%loadcharDB%%colReset%)       %PAD%%colWhiteBold%^|
if %CDBUpdate% == NO set PAD= 
if %CDBUpdate% == YES set PAD=
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colWhiteBold%B - %colReset%Apply Character DB updates (%colYellowBold%%CDBUpdate%%colReset%)                 %PAD%%colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
if %createworldDB% == NO set PAD= 
if %createworldDB% == YES set PAD=
echo %colWhiteBold%^|       %colYellowBold%World Database : E  - %colYellow%Toggle Actually Create World DB (%colWhiteBold%%createworldDB%%colYellow%)%colReset%           %PAD%%colWhiteBold%^|
if %loadworldDB% == NO set PAD= 
if %loadworldDB% == YES set PAD=
echo %colWhiteBold%^|                        %colYellowBold%W  - %colYellow%Toggle Create World DB Structure (%colWhiteBold%%loadworldDB%%colYellow%)%colReset%          %PAD%%colWhiteBold%^|
if %DBType% == EMPTY set PAD=    
if %DBType% == POPULATED set P=

if %loadworldDB% == YES echo %colWhiteBold%^|                        %colYellowBold%D - %colYellow%Toggle World Type (%colWhiteBold%%DBType%%colYellow%)%colReset%                    %PAD%%colWhiteBold%^|

if %WDBUpdate% == NO set PAD= 
if %WDBUpdate% == YES set PAD=
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colYellowBold%U - %colYellow%Apply World DB updates (%colWhiteBold%%WDBUpdate%%colYellow%)%colReset%                     %PAD%%colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
if %createrealmDB% == NO set PAD= 
if %createrealmDB% == YES set PAD=
echo %colWhiteBold%^|       %colCyanBold%Realm Database : T - %colCyan%Toggle Actually Create Realm DB (%colWhiteBold%%createrealmDB%%colCyan%)%colReset%            %PAD%%colWhiteBold%^|
if %loadrealmDB% == NO set PAD= 
if %loadrealmDB% == YES set PAD=
echo %colWhiteBold%^|                        %colCyanBold%R - %colCyan%Toggle Create Realm Db Structure (%colWhiteBold%%loadrealmDB%%colCyan%)%colReset%           %PAD%%colWhiteBold%^|
if %RDBUpdate% == NO set PAD= 
if %RDBUpdate% == YES set PAD=
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colCyanBold%Y - %colCyan%Apply Realm DB updates (%colWhiteBold%%RDBUpdate%%colCyan%)%colReset%                     %PAD%%colWhiteBold%^|
if %addrealmentry% == NO set PAD= 
if %addrealmentry% == YES set PAD=
echo %colWhiteBold%^|                        %colCyanBold%L - %colCyan%Toggle Add Default RealmList Entry for Core (%colWhiteBold%%addrealmentry%%colCyan%)%colReset%%PAD%%colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
if %updatesOnly% == NO set PAD= 
if %updatesOnly% == YES set PAD=
echo %colWhiteBold%^|                        %colMagentaBold%O - %colMagenta%Toggle Only Install Updates to Database's (%colWhiteBold%%updatesOnly%%colMagenta%)%colReset%  %PAD%%colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
if %createMangosUser% == NO set PAD= 
if %createMangosUser% == YES set PAD=
echo %colWhiteBold%^|                        %colRedBold%P - %colRed%Toggle Create Mangos User (%colWhiteBold%%createMangosUser%%colRed%)%colReset%                  %PAD%%colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
set LOCList=NO
if %locFR% == YES set LOCList=YES
if %locDE% == YES set LOCList=YES 
if %locES% == YES set LOCList=YES

REM echo                           A   - Add Localised Content (%LOCList%)
echo %colWhiteBold%^|                        %colGreenBold%N - %colGreen%Next Step%colReset%                                        %colWhiteBold%^|
echo %colWhiteBold%^|                        %colWhiteBold%X - %colReset%Exit                                             %colWhiteBold%^|
echo %colWhiteBold%^|_____________________________________________________________________________^|%colReset%
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
if %activity% == P goto ToggleCreateMangosUser:
if %activity% == p goto ToggleCreateMangosUser:
if %activity% == O goto ToggleUpdatesOnly:
if %activity% == o goto ToggleUpdatesOnly:

if %activity% == N goto Step1:
if %activity% == n goto Step1:

REM if %activity% == A goto StepLoc1:
REM if %activity% == a goto StepLoc1:

if %activity% == X goto quitting:
if %activity% == x goto quitting:
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

:ToggleCreateMangosUser
if %createMangosUser% == NO goto ToggleCreateMangosUserNo:
if %createMangosUser% == YES goto ToggleCreateMangosUserYes:
goto main:

:ToggleCreateMangosUserNo
set createMangosUser=YES
goto main:

:ToggleCreateMangosUserYes
set createMangosUser=NO
goto main:

:ToggleUpdatesOnly
if %updatesOnly% == YES goto ToggleUpdatesOnlyNo
if %updatesOnly% == NO goto ToggleUpdatesOnlyYes
goto main

:ToggleUpdatesOnlyNo
set updatesOnly=NO
set createcharDB=YES
set createworldDB=YES
set createrealmDB=YES
set createMangosUser=YES
set loadcharDB=YES
set loadworldDB=YES
set loadrealmDB=YES

set CDBUpdate=YES
set WDBUpdate=YES
set RDBUpdate=YES

set addrealmentry=YES
goto main:

:ToggleUpdatesOnlyYes
set updatesOnly=YES
set createcharDB=NO
set createworldDB=NO
set createrealmDB=NO
set createMangosUser=NO
set loadcharDB=NO
set loadworldDB=NO
set loadrealmDB=NO

set CDBUpdate=YES
set WDBUpdate=YES
set RDBUpdate=YES

set addrealmentry=NO
goto main:

:Step1
if not exist %mysql%\mysql.exe then goto patherror
CLS
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader     %colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteDarkRed%^|                                                                             ^|
echo ^|%colBold% Only leave the defaults for username, password and mysql port on servers    ^|
echo ^| with no external internet access.                                           ^|
echo ^|                                                                             ^|
echo ^| Using these settings will leave you server open to exploits,                ^|
echo ^| security breaches... or much much worse.                                    ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo.
echo.
set /p svr=%colYellowBold% What is your MySQL host name?           %colReset%DEFAULT: [%colWhiteBold%%svr%%colReset%] : 
if %svr%. == . set svr=localhost
set /p user=%colYellowBold% What is your MySQL user name?                %colReset%DEFAULT: [%colWhiteBold%%user%%colReset%] : 
if %user%. == . set user=root
set /p pass=%colYellowBold% What is your MySQL password?               %colReset%DEFAULT: [%colWhiteBold%%pass%%colReset%] : 
if %pass%. == . set pass=mangos
set /p port=%colYellowBold% What is your MySQL port?                     %colReset%DEFAULT: [%colWhiteBold%%port%%colReset%] : 
if %port%. == . set port=3306

set showChar=0
if %createcharDB% == YES set showChar=1
if %loadcharDB% == YES set showChar=1
if %CDBUpdate% == YES set showChar=1

if %showChar% == 1 set /p cdb=%colYellowBold% What is your Character database name?  %colReset%DEFAULT: [%colWhiteBold%%cdb%%colReset%] : 
if %cdb%. == . set cdb=%cdborig%

set showWorld=0
if %createworldDB% == YES set showWorld=1
if %loadworldDB% == YES set showWorld=1
if %WDBUpdate% == YES set showWorld=1
if %showWorld% == 1 set /p wdb=%colYellowBold% What is your World database name?         %colReset%DEFAULT: [%colWhiteBold%%wdb%%colReset%] : 
if %wdb%. == . set wdb=%wdborig%

set showRealm=0
if %createrealmDB% == YES set showRealm=1
if %loadrealmDB% == YES set showRealm=1
if %addrealmentry% == YES set showRealm=1
if %CDBUpdate% == YES set showRealm=1

if %showRealm% == 1 set /p rdb=%colYellowBold% What is your Realm database name?          %colReset%DEFAULT: [%colWhiteBold%%rdb%%colReset%] : 
if %rdb%. == . set rdb=%rdborig%

REM If create user is set to yes, ask for the details here
if %createMangosUser% == NO goto WorldDB:

if %createMangosUser% == YES set /p newuser=%colYellowBold% New MySQL user name?                       %colReset%DEFAULT: [%colWhiteBold%%newuser%%colReset%] : 
if %newuser%. == . set newuser=mangos
if %createMangosUser% == YES set /p newpass=%colYellowBold% New MySQL user password?                   %colReset%DEFAULT: [%colWhiteBold%%newpass%%colReset%] : 
if %newpass%. == . set newpass=mangos

if %newpass% == mangos set defaultsused=YES
if %newuser% == mangos set defaultsused=YES
if %defaultsused% == YES goto done:

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

goto MangosUser:

:WorldDB1
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^| Creating World Database                                                     ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colReset% 
echo %colReset% Creating Database %wdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "create database %wdb%";
goto WorldDB2:

:WorldDB3
if %DBType% == POPULATED goto WorldDB4:
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^| Preparing World Database Structure                                          ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colReset% 
echo %colReset% Preparing Database %wdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < World\Setup\mangosdLoadDB.sql
goto CharDB:

:WorldDB4
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^| Populating World Database                                                   ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colReset% 
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < World\Setup\mangosdLoadDB.sql
for %%i in (World\Setup\FullDB\*.sql) do echo . Loading %%i & %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < %%i
goto CharDB:

:CharDB1
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^| Creating Character Database                                                 ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colReset% 
echo %colReset% Creating Database %cdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "create database %cdb%";
goto CharDB2:

:CharDB3
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^| Loading Character Database                                                  ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colReset% 
echo %colReset% Loading Database %Cdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %cdb% < Character\Setup\characterLoadDB.sql

goto RealmDB:

:RealmDB1
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^| Creating Realm Database                                                     ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colReset% 
echo %colReset% Creating Database %rdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "create database %rdb%";
goto RealmDB2:

:RealmDB3
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^| Loading Realm Database                                                      ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colReset% 
echo %colReset% Loading Database %rdb%
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %rdb% < Realm\Setup\realmdLoadDB.sql

goto RealmDB4:

:RealmDB5
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^| Adding RealmList entry in Realm Database                                    ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colReset% 
echo %colReset% Adding Realmlist entry to %rdb%
echo _______________________________________________________________________________
if %addrealmentry% == YES %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %rdb% < Tools\updateRealm.sql

if %createMangosUser% == YES goto MangosUser1:
goto done:

:MangosUser1
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^| Creating new user and granting privileges                                   ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colReset% 
echo %colReset% Creating '%newuser%' user and granting privileges

%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "CREATE USER '%newuser%'@'%svr%' IDENTIFIED BY '%newpass%'";
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES ON `%wdb%`.* TO '%newuser%'@'%svr%'";
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES ON `%cdb%`.* TO '%newuser%'@'%svr%'";
%mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES ON `%rdb%`.* TO '%newuser%'@'%svr%'";
goto done:


:patherror
echo Cannot find required files.
pause
goto :error

:StepLoc1
cls
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader     %colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo.
echo  Database Localisation Support
echo _______________________________________________________________________________
echo.
echo    French (Francaís)  : F   - Toggle Loading Localisations (%locFR%)
echo.
echo       German (Deusch)  : G/D - Toggle Loading Localisations (%locDE%)    
echo.
echo     Spanish (Espána)  : S/E - Toggle Loading Localisations (%locES%)     
echo.
echo                          N   - Next Step
echo.
set /p activity=%colYellowBold% Please select an activity ? : %colReset%
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
echo %colWhiteDarkRed%^|                                                                             ^|
echo ^| ** ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR ** ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo ^|                                                                             ^|
echo ^|                                                                             ^|
echo ^|   %colRedBold%Install Database Process Failed                    %colReset%                       ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colWhiteDarkRed%^|                                                                             ^|
echo ^| ** ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR ** ^|
echo ^|_____________________________________________________________________________^|%colReset%
goto finish:

:PatchWorld
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^| Applying World DB updates                                                   ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%
for %%i in (World\Updates\Rel21\*.sql) do echo %%i & %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < %%i
goto done2

:PatchRealm
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^| Applying Realmd DB updates                                                  ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%
for %%i in (Realm\Updates\Rel21\*.sql) do echo %%i & %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %rdb% < %%i
goto done3

:patchCharacter
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^| Applying Character DB updates                                               ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%
for %%i in (Character\Updates\Rel21\*.sql) do echo %%i & %mysql%mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %cdb% < %%i
goto done1

:missingRecursive
CLS
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader     %colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteDarkRed%^|                                                                             ^|
echo ^| ** ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR ** ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo ^|                                                                             ^|
echo ^|                                                                             ^|
echo ^|   %colRedBold%The repository was cloned without the %colWhiteBold%--recursive %colRedBold%flag%colReset%                    ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colWhiteDarkRed%^|                                                                             ^|
echo ^| ** ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR ** ^|
echo ^|_____________________________________________________________________________^|%colReset%
goto finish:

:defaultpasswordused
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader     %colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteDarkRed%^|                                                                             ^|
echo ^| ** ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR ** ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo ^|                                                                             ^|
echo ^|                                                                             ^|
echo ^|   %colRedBold%We will not create a user with the default password%colReset%                       ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colWhiteDarkRed%^|                                                                             ^|
echo ^| ** ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR ** ^|
echo ^|_____________________________________________________________________________^|%colReset%
goto finish:



:done
if %CDBUpdate% == YES goto patchCharacter:
:done1
if %WDBUpdate% == YES goto patchWorld:
:done2
if %RDBUpdate% == YES goto PatchRealm:
:done3
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader     %colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteLightGreen%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^| Database Creation and Load complete                                         ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%

REM Warn about not setting up the user
if %defaultsused% == YES goto defaultpasswordused:

:finish
echo.
echo %colReset% Script has completed !
echo %colReset% - Please review the messages above to ensure no errors occurred.
echo.
goto theend:

:quitting
echo.
echo %colReset% Script has been aborted !
echo.
goto theend:

:theend
pause