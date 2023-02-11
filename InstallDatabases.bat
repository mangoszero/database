@ECHO OFF

set scriptVersion=2.3
set releaseVersionPrevious=21
set releaseVersionCurrent=22

rem -- Change the values below to match your server --
rem -- Or do so in InstallDatabasesPreset.bat instead. --
IF NOT DEFINED dbClientHome set dbClientHome=Tools
IF NOT DEFINED dbClientName set dbClientName=mysql.exe
IF NOT DEFINED dbClient         set dbClient="%dbClientHome%\%dbClientName%"

IF NOT DEFINED svr                   set svr=localhost
IF NOT DEFINED newuser           set newuser=mangos
IF NOT DEFINED user                 set user=root
IF NOT DEFINED pass                 set pass=mangos
IF NOT DEFINED newpass           set newpass=mangos
IF NOT DEFINED port                 set port=3306

CALL SetCoreUniqueVars.bat

IF NOT DEFINED wdb         set wdb=mangos%coreNum%
IF NOT DEFINED wdborig set wdborig=mangos%coreNum%
IF NOT DEFINED cdb         set cdb=character%coreNum%
IF NOT DEFINED cdborig set cdborig=character%coreNum%
IF NOT DEFINED rdb         set rdb=realmd
IF NOT DEFINED rdborig set rdborig=realmd

IF NOT DEFINED skipPrintOS       set skipPrintOS=NO
IF NOT DEFINED skipChoices       set skipChoices=NO
IF NOT DEFINED skipConnection set skipConnection=NO
IF NOT DEFINED DEBUG                   set DEBUG=NO

rem -- Don't change past this point --
IF NOT DEFINED LOCList     set LOCList=NO

rem setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if %skipPrintOS% == YES goto afterOSPrint
if "%version%" == "6.3" echo Windows 8.1
if "%version%" == "6.2" echo Windows 8.
if "%version%" == "6.1" echo Windows 7.
if "%version%" == "6.0" echo Windows Vista.
if "%version%" == "10.0" echo Windows 10.

:afterOSPrint

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
IF NOT DEFINED createcharDB         set createcharDB=YES
IF NOT DEFINED createworldDB       set createworldDB=YES
IF NOT DEFINED createrealmDB       set createrealmDB=YES
IF NOT DEFINED createMangosUser set createMangosUser=YES
IF NOT DEFINED updatesOnly           set updatesOnly=NO
IF NOT DEFINED loadcharDB             set loadcharDB=YES
IF NOT DEFINED loadworldDB           set loadworldDB=YES
IF NOT DEFINED loadrealmDB           set loadrealmDB=YES
IF NOT DEFINED defaultsused         set defaultsused=NO

IF NOT DEFINED CDBUpdate               set CDBUpdate=YES
IF NOT DEFINED WDBUpdate               set WDBUpdate=YES
IF NOT DEFINED RDBUpdate               set RDBUpdate=YES

IF NOT DEFINED addrealmentry       set addrealmentry=YES

IF NOT DEFINED DBType                     set DBType=POPULATED
IF NOT DEFINED activity                 set activity=N

IF NOT DEFINED locKO                       set locKO=NO
IF NOT DEFINED locFR                       set locFR=NO
IF NOT DEFINED locDE                       set locDE=NO
IF NOT DEFINED locCH                       set locCH=NO
IF NOT DEFINED locTW                       set locTW=NO
IF NOT DEFINED locES                       set locES=NO
IF NOT DEFINED locMX                       set locMX=NO
IF NOT DEFINED locRU                       set locRU=NO
IF NOT DEFINED locIT                       set locIT=NO
IF NOT DEFINED locPT                       set locPT=NO
IF NOT DEFINED locBR                       set locBR=NO

rem -- first check that the repo has been cloned correctly
if not exist Realm goto missingRecursive:

if %skipChoices%==YES goto WorldDB:

:main
CLS

echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader v%scriptVersion%%colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteLightBlue%^|                                                                             ^|
echo ^|   Website / Forum / Wiki / Support: https://getmangos.eu                    ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colWhiteBold%^|                                                                             ^|
if %createcharDB% == NO set PAD=" "
if %createcharDB% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|   %colWhiteBold%Character Database : V - %colReset%Toggle Actually Create Character DB (%colYellowBold%%createcharDB%%colReset%)        %PAD:"=%%colWhiteBold%^|
if %loadcharDB% == NO set PAD=" "
if %loadcharDB% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colWhiteBold%C - %colReset%Toggle Create Character DB Structure (%colYellowBold%%loadcharDB%%colReset%)       %PAD:"=%%colWhiteBold%^|
if %CDBUpdate% == NO set PAD=" "
if %CDBUpdate% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colWhiteBold%B - %colReset%Apply Character DB updates (%colYellowBold%%CDBUpdate%%colReset%)                 %PAD:"=%%colWhiteBold%^|
if %updatesOnly% == YES echo %colWhiteBold%^|   %colWhiteBold%Character Database : B - %colReset%Apply Character DB updates (%colYellowBold%%CDBUpdate%%colReset%)                 %PAD:"=%%colWhiteBold%^|

echo %colWhiteBold%^|                                                                             ^|
if %createworldDB% == NO set PAD=" "
if %createworldDB% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|       %colYellowBold%World Database : E - %colYellow%Toggle Actually Create World DB (%colWhiteBold%%createworldDB%%colYellow%)%colReset%            %PAD:"=%%colWhiteBold%^|
if %loadworldDB% == NO set PAD=" "
if %loadworldDB% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colYellowBold%W - %colYellow%Toggle Create World DB Structure (%colWhiteBold%%loadworldDB%%colYellow%)%colReset%           %PAD:"=%%colWhiteBold%^|
if %DBType% == EMPTY set PAD="    "
if %DBType% == POPULATED set P=

if %loadworldDB% == YES echo %colWhiteBold%^|                        %colYellowBold%D - %colYellow%Toggle World Type (%colWhiteBold%%DBType%%colYellow%)%colReset%                    %PAD:"=%%colWhiteBold%^|

if %WDBUpdate% == NO set PAD=" "
if %WDBUpdate% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colYellowBold%U - %colYellow%Apply World DB updates (%colWhiteBold%%WDBUpdate%%colYellow%)%colReset%                     %PAD:"=%%colWhiteBold%^|
if %updatesOnly% == YES echo %colWhiteBold%^|       %colYellowBold%World Database : U - %colYellow%Apply World DB updates (%colWhiteBold%%WDBUpdate%%colYellow%)%colReset%                     %PAD:"=%%colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
if %createrealmDB% == NO set PAD=" "
if %createrealmDB% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|       %colCyanBold%Realm Database : T - %colCyan%Toggle Actually Create Realm DB (%colWhiteBold%%createrealmDB%%colCyan%)%colReset%            %PAD:"=%%colWhiteBold%^|
if %loadrealmDB% == NO set PAD=" "
if %loadrealmDB% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colCyanBold%R - %colCyan%Toggle Create Realm Db Structure (%colWhiteBold%%loadrealmDB%%colCyan%)%colReset%           %PAD:"=%%colWhiteBold%^|
if %RDBUpdate% == NO set PAD=" "
if %RDBUpdate% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colCyanBold%Y - %colCyan%Apply Realm DB updates (%colWhiteBold%%RDBUpdate%%colCyan%)%colReset%                     %PAD:"=%%colWhiteBold%^|
if %updatesOnly% == YES echo %colWhiteBold%^|       %colCyanBold%Realm Database : Y - %colCyan%Apply Realm DB updates (%colWhiteBold%%RDBUpdate%%colCyan%)%colReset%                     %PAD:"=%%colWhiteBold%^|
if %addrealmentry% == NO set PAD=" "
if %addrealmentry% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colCyanBold%L - %colCyan%Toggle Add Default RealmList Entry for Core (%colWhiteBold%%addrealmentry%%colCyan%)%colReset%%PAD:"=%%colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
if %updatesOnly% == NO set PAD=" "
if %updatesOnly% == YES set PAD=""
echo %colWhiteBold%^|                        %colMagentaBold%O - %colMagenta%Toggle Only Install Updates to Database's (%colWhiteBold%%updatesOnly%%colMagenta%)%colReset%  %PAD:"=%%colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
if %createMangosUser% == NO set PAD=" "
if %createMangosUser% == YES set PAD=""
if %updatesOnly% == NO echo %colWhiteBold%^|                        %colRedBold%P - %colRed%Toggle Create Mangos User (%colWhiteBold%%createMangosUser%%colRed%)%colReset%                  %PAD:"=%%colWhiteBold%^|
if %updatesOnly% == NO echo %colWhiteBold%^|                                                                             ^|
if %LOCList% == NO set PAD=" "
if %LOCList% == YES set PAD=""
echo %colWhiteBold%^|                        %colYellowBold%A - %colYellow%Add Localised Content (%colWhiteBold%%LOCList%%colYellow%)%colReset%                      %PAD:"=%%colWhiteBold%^|%colReset%
echo %colWhiteBold%^|                                                                             ^|%colReset%
echo %colWhiteBold%^|                        %colRedBold%Z - %colRed%Toggle None                                      %colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
echo %colWhiteBold%^|                        %colGreenBold%N - %colGreen%Next Step%colReset%                                        %colWhiteBold%^|%colReset%
echo %colWhiteBold%^|                        %colWhiteBold%X - %colReset%Exit                                             %colWhiteBold%^|%colReset%
echo %colWhiteBold%^|_____________________________________________________________________________^|%colReset%
echo.
set /p activity=". Please select an activity ? : "
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

if %activity% == A goto StepLoc1:
if %activity% == a goto StepLoc1:

if %activity% == Z goto ToggleNone:
if %activity% == z goto ToggleNone:

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

:ToggleNone
set createcharDB=NO
set createworldDB=NO
set createrealmDB=NO
set createMangosUser=NO
set loadcharDB=NO
set loadworldDB=NO
set loadrealmDB=NO

set CDBUpdate=NO
set WDBUpdate=NO
set RDBUpdate=NO

set addrealmentry=NO

goto main:

:Step1
if not exist %dbClient% then goto patherror
if %skipConnection%==YES goto WorldDB:
CLS
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|%colReset%
echo %colWhiteDarkBlue%^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|%colReset%
echo %colWhiteDarkBlue%^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|%colReset%
echo %colWhiteDarkBlue%^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader     %colWhiteBold%    ^|%colReset%
echo %colWhiteDarkBlue%^|_____________________________________________________________________________^|%colReset%
echo %colWhiteDarkRed%^|                                                                             ^|%colReset%
echo %colWhiteDarkRed%^|%colBold% Only leave the defaults for username, password and mysql port on servers    ^|%colReset%
echo %colWhiteDarkRed%^|%colBold% with no external internet access.                                           ^|%colReset%
echo %colWhiteDarkRed%^|%colBold%                                                                             ^|%colReset%
echo %colWhiteDarkRed%^|%colBold% Using these settings will leave you server open to exploits,                ^|%colReset%
echo %colWhiteDarkRed%^|%colBold% security breaches... or much much worse.                                    ^|%colReset%
echo %colWhiteDarkRed%^|%colBold%_____________________________________________________________________________^|%colReset%
echo.
echo.
set /p svr="%colYellowBold% What is your MySQL host name?           %colReset%DEFAULT: [%colWhiteBold%%svr%%colReset%] : "
if %svr%. == . set svr=localhost
set /p user="%colYellowBold% What is your MySQL user name?                %colReset%DEFAULT: [%colWhiteBold%%user%%colReset%] : "
if %user%. == . set user=root
set /p pass="%colYellowBold% What is your MySQL password?               %colReset%DEFAULT: [%colWhiteBold%%pass%%colReset%] : "
if %pass%. == . set pass=mangos
set /p port="%colYellowBold% What is your MySQL port?                     %colReset%DEFAULT: [%colWhiteBold%%port%%colReset%] : "
if %port%. == . set port=3306

set showChar=0
if %createcharDB% == YES set showChar=1
if %loadcharDB% == YES set showChar=1
if %CDBUpdate% == YES set showChar=1

if %showChar% == 1 set /p cdb="%colYellowBold% What is your Character database name?  %colReset%DEFAULT: [%colWhiteBold%%cdb%%colReset%] : "
if %cdb%. == . set cdb=%cdborig%

set showWorld=0
if %createworldDB% == YES set showWorld=1
if %loadworldDB% == YES set showWorld=1
if %WDBUpdate% == YES set showWorld=1
if %showWorld% == 1 set /p wdb="%colYellowBold% What is your World database name?         %colReset%DEFAULT: [%colWhiteBold%%wdb%%colReset%] : "
if %wdb%. == . set wdb=%wdborig%

set showRealm=0
if %createrealmDB% == YES set showRealm=1
if %loadrealmDB% == YES set showRealm=1
if %addrealmentry% == YES set showRealm=1
if %CDBUpdate% == YES set showRealm=1

if %showRealm% == 1 set /p rdb="%colYellowBold% What is your Realm database name?          %colReset%DEFAULT: [%colWhiteBold%%rdb%%colReset%] : "
if %rdb%. == . set rdb=%rdborig%

REM If create user is set to yes, ask for the details here
if %createMangosUser% == NO goto WorldDB:

if %createMangosUser% == YES set /p newuser="%colYellowBold% New MySQL user name?                       %colReset%DEFAULT: [%colWhiteBold%%newuser%%colReset%] : "
if %newuser%. == . set newuser=mangos
if %createMangosUser% == YES set /p newpass="%colYellowBold% New MySQL user password?                   %colReset%DEFAULT: [%colWhiteBold%%newpass%%colReset%] : "
if %newpass%. == . set newpass=mangos

if %newpass% == mangos set defaultsused=YES
REM if %newuser% == mangos set defaultsused=YES
REM if %defaultsused% == YES goto done:

:WorldDB

if not defined dbClientConnectionOptions set dbClientConnectionOptions=-h %svr% --user=%user% --password=%pass% --port=%port%
if not defined dbClientOtherOptions      set dbClientOtherOptions=-q -s
if not defined dbClientConnectionString  set dbClientConnectionString=%dbClient%  %dbClientConnectionOptions% %dbClientOtherOptions%

if %DEBUG%==YES echo dbClientConnectionOptions: %dbClientConnectionOptions%
if %DEBUG%==YES echo dbClientOtherOptions: %dbClientOtherOptions%
if %DEBUG%==YES echo dbClientConnectionString: %dbClientConnectionString%
if %DEBUG%==YES echo Sample Execution: %dbClientConnectionString% -e "create database %wdb%";

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

:NeedToCreateMangosUser
if %createMangosUser% == YES goto MangosUser1:
goto done:

:WorldDB1
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Creating World Database                                                     ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo %colReset%
echo %colReset% Creating Database %wdb%
%dbClientConnectionString% -e "create database %wdb%";
goto WorldDB2:

:WorldDB3
if %DBType% == POPULATED goto WorldDB4:
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Preparing World Database Structure                                          ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo %colReset%
echo %colReset% Preparing Database %wdb%
%dbClientConnectionString% %wdb% < World\Setup\mangosdLoadDB.sql
goto CharDB:

:WorldDB4
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Populating World Database                                                   ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo %colReset%
%dbClientConnectionString% %wdb% < World\Setup\mangosdLoadDB.sql
for %%i in (World\Setup\FullDB\*.sql) do echo . Loading %%i & %dbClientConnectionString% %wdb% < %%i
goto CharDB:

:CharDB1
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Creating Character Database                                                 ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo %colReset%
echo %colReset% Creating Database %cdb%
%dbClientConnectionString% -e "create database %cdb%";
goto CharDB2:

:CharDB3
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Character Database                                                  ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo %colReset%
echo %colReset% Loading Database %Cdb%
%dbClientConnectionString% %cdb% < Character\Setup\characterLoadDB.sql

goto RealmDB:

:RealmDB1
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Creating Realm Database                                                     ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo %colReset%
echo %colReset% Creating Database %rdb%
%dbClientConnectionString% -e "create database %rdb%";
goto RealmDB2:

:RealmDB3
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Realm Database                                                      ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo %colReset%
echo %colReset% Loading Database %rdb%
%dbClientConnectionString% %rdb% < Realm\Setup\realmdLoadDB.sql

goto RealmDB4:

:RealmDB5
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Adding RealmList entry in Realm Database                                    ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo %colReset%
echo %colReset% Adding Realmlist entry to %rdb%
echo _______________________________________________________________________________%colReset%
if %addrealmentry% == YES %dbClientConnectionString% %rdb% < Tools\updateRealm.sql
goto NeedToCreateMangosUser:

:MangosUser1
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Creating new user and granting privileges                                   ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo %colReset%
echo %colReset% Creating '%newuser%' user and granting privileges

%dbClientConnectionString% -e "CREATE USER '%newuser%'@'%svr%' IDENTIFIED BY '%newpass%'";
%dbClientConnectionString% -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES ON `%wdb%`.* TO '%newuser%'@'%svr%'";
%dbClientConnectionString% -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES ON `%cdb%`.* TO '%newuser%'@'%svr%'";
%dbClientConnectionString% -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES ON `%rdb%`.* TO '%newuser%'@'%svr%'";
goto done:


:patherror
echo Cannot find required files.
pause
goto :error

:StepLoc1
cls
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|%colReset%
echo %colWhiteDarkBlue%^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|%colReset%
echo %colWhiteDarkBlue%^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|%colReset%
echo %colWhiteDarkBlue%^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader     %colWhiteBold%    ^|%colReset%
echo %colWhiteDarkBlue%^|_____________________________________________________________________________^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Database Localisation Support                                               ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo ^|                                                                             ^|%colReset%
set PAD=""
if %locCH% == NO set PAD=" "
echo %colWhiteBold%^|                Locales : %colYellowBold%C - %colYellow%Toggle Chinese (%colWhiteBold%%locCH%%colYellow%)%colReset%                           %PAD:"=%%colWhiteBold%^|

set PAD=""
if %locFR% == NO set PAD=" "
echo %colWhiteBold%^|                          %colYellowBold%F - %colYellow%Toggle French (%colWhiteBold%%locFR%%colYellow%)%colReset%                            %PAD:"=%%colWhiteBold%^|

set PAD=""
if %locDE% == NO set PAD=" "
echo %colWhiteBold%^|                          %colYellowBold%G - %colYellow%Toggle German (%colWhiteBold%%locDE%%colYellow%)%colReset%                            %PAD:"=%%colWhiteBold%^|

set PAD=""
if %locKO% == NO set PAD=" "
echo %colWhiteBold%^|                          %colYellowBold%K - %colYellow%Toggle Korean (%colWhiteBold%%locKO%%colYellow%)%colReset%                            %PAD:"=%%colWhiteBold%^|

set PAD=""
if %locMX% == NO set PAD=" "
echo %colWhiteBold%^|                          %colYellowBold%M - %colYellow%Toggle Spanish (Mexican) (%colWhiteBold%%locMX%%colYellow%)%colReset%                 %PAD:"=%%colWhiteBold%^|

set PAD=""
if %locRU% == NO set PAD=" "
echo %colWhiteBold%^|                          %colYellowBold%R - %colYellow%Toggle Russian (%colWhiteBold%%locRU%%colYellow%)%colReset%                           %PAD:"=%%colWhiteBold%^|

set PAD=""
if %locES% == NO set PAD=" "
echo %colWhiteBold%^|                          %colYellowBold%S - %colYellow%Toggle Spanish (%colWhiteBold%%locES%%colYellow%)%colReset%                           %PAD:"=%%colWhiteBold%^|

set PAD=""
if %locTW% == NO set PAD=" "
echo %colWhiteBold%^|                          %colYellowBold%T - %colYellow%Toggle Taiwanese (%colWhiteBold%%locTW%%colYellow%)%colReset%                         %PAD:"=%%colWhiteBold%^|

REM set PAD=""
REM if %locIT% == NO set PAD=" "
REM echo %colWhiteBold%^|                          %colYellowBold%I - %colYellow%Toggle Italian (%colWhiteBold%%locIT%%colYellow%)%colReset%                           %PAD:"=%%colWhiteBold%^|

REM set PAD=""
REM if %locPT% == NO set PAD=" "
REM echo %colWhiteBold%^|                          %colYellowBold%P - %colYellow%Toggle Portuguese (%colWhiteBold%%locPT%%colYellow%)%colReset%                        %PAD:"=%%colWhiteBold%^|

REM set PAD=""
REM if %locBR% == NO set PAD=" "
REM echo %colWhiteBold%^|                          %colYellowBold%B - %colYellow%Toggle Brazilian (%colWhiteBold%%locBR%%colYellow%)%colReset%                         %PAD:"=%%colWhiteBold%^|

echo %colWhiteBold%^|                                                                             ^|
echo %colWhiteBold%^|                          X - Back to main Menu                              ^|
echo %colWhiteBold%^|                                                                             ^|
echo ^|_____________________________________________________________________________^|
echo.
set /p activity=%colYellowBold% Please select an activity ? : %colReset%
if %activity% == F goto ToggleLocFR:
if %activity% == f goto ToggleLocFR:
if %activity% == G goto ToggleLocDE:
if %activity% == g goto ToggleLocDE:
if %activity% == R goto ToggleLocRU:
if %activity% == r goto ToggleLocRU:
if %activity% == T goto ToggleLocTW:
if %activity% == t goto ToggleLocTW:
if %activity% == C goto ToggleLocCH:
if %activity% == c goto ToggleLocCH:
if %activity% == M goto ToggleLocMX:
if %activity% == m goto ToggleLocMX:
if %activity% == S goto ToggleLocES:
if %activity% == s goto ToggleLocES:
if %activity% == K goto ToggleLocKO:
if %activity% == k goto ToggleLocKO:
rem if %activity% == I goto ToggleLocIT:
rem if %activity% == i goto ToggleLocIT:
REM if %activity% == B goto ToggleLocBR:
REM if %activity% == b goto ToggleLocBR:
REM if %activity% == P goto ToggleLocPT:
REM if %activity% == p goto ToggleLocPT:

if %activity% == X goto LocBackToMain:
if %activity% == x goto LocBackToMain:
if %activity% == .. goto StepLoc1:
goto StepLoc1

:LocBackToMain
set LOCList=NO
if %locKO% == YES set LOCList=YES
if %locFR% == YES set LOCList=YES
if %locDE% == YES set LOCList=YES
if %locCH% == YES set LOCList=YES
if %locTW% == YES set LOCList=YES
if %locES% == YES set LOCList=YES
if %locMX% == YES set LOCList=YES
if %locRU% == YES set LOCList=YES
REM if %locIT% == YES set LOCList=YES
REM if %locPT% == YES set LOCList=YES
REM if %locBR% == YES set LOCList=YES
goto main:

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

:ToggleLocCH
if %locCH% == NO goto ToggleLocCHNo:
if %locCH% == YES goto ToggleLocCHYes:
goto StepLoc1:

:ToggleLocCHNo
set locCH=YES
goto StepLoc1:

:ToggleLocCHYes
set locCH=NO
goto StepLoc1:

:ToggleLocTW
if %locTW% == NO goto ToggleLocTWNo:
if %locTW% == YES goto ToggleLocTWYes:
goto StepLoc1:

:ToggleLocTWNo
set locTW=YES
goto StepLoc1:

:ToggleLocTWYes
set locTW=NO
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

:ToggleLocMX
if %locMX% == NO goto ToggleLocMXNo:
if %locMX% == YES goto ToggleLocMXYes:
goto StepLoc1:

:ToggleLocMXNo
set locMX=YES
goto StepLoc1:

:ToggleLocMXYes
set locMX=NO
goto StepLoc1:

:ToggleLocRU
if %locRU% == NO goto ToggleLocRUNo:
if %locRU% == YES goto ToggleLocRUYes:
goto StepLoc1:

:ToggleLocRUNo
set locRU=YES
goto StepLoc1:

:ToggleLocRUYes
set locRU=NO
goto StepLoc1:

:ToggleLocKO
if %locKO% == NO goto ToggleLocKONo:
if %locKO% == YES goto ToggleLocKOYes:
goto StepLoc1:

:ToggleLocKONo
set locKO=YES
goto StepLoc1:

:ToggleLocKOYes
set locKO=NO
goto StepLoc1:

:ToggleLocIT
if %locIT% == NO goto ToggleLocITNo:
if %locIT% == YES goto ToggleLocITYes:
goto StepLoc1:

:ToggleLocITNo
set locIT=YES
goto StepLoc1:

:ToggleLocITYes
set locIT=NO
goto StepLoc1:

:ToggleLocPT
if %locPT% == NO goto ToggleLocPTNo:
if %locPT% == YES goto ToggleLocPTYes:
goto StepLoc1:

:ToggleLocPTNo
set locPT=YES
goto StepLoc1:

:ToggleLocPTYes
set locPT=NO
goto StepLoc1:

:ToggleLocBR
if %locBR% == NO goto ToggleLocBRNo:
if %locBR% == YES goto ToggleLocBRYes:
goto StepLoc1:

:ToggleLocBRNo
set locBR=YES
goto StepLoc1:

:ToggleLocBRYes
set locBR=NO
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
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Applying World DB updates                                                   ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
for %%i in (World\Updates\Rel%releaseVersionPrevious%\*.sql) do echo %%i & %dbClientConnectionString% %wdb% < %%i
for %%i in (World\Updates\Rel%releaseVersionCurrent%\*.sql) do echo %%i & %dbClientConnectionString% %wdb% < %%i
goto done2

:PatchRealm
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Applying Realmd DB updates                                                  ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
for %%i in (Realm\Updates\Rel%releaseVersionPrevious%\*.sql) do echo %%i & %dbClientConnectionString% %rdb% < %%i
for %%i in (Realm\Updates\Rel%releaseVersionCurrent%\*.sql) do echo %%i & %dbClientConnectionString% %rdb% < %%i
goto done3

:patchCharacter
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Applying Character DB updates                                               ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
for %%i in (Character\Updates\Rel%releaseVersionPrevious%\*.sql) do echo %%i & %dbClientConnectionString% %cdb% < %%i
for %%i in (Character\Updates\Rel%releaseVersionCurrent%\*.sql) do echo %%i & %dbClientConnectionString% %cdb% < %%i
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

if %LOCList% == YES goto PrepLoc:

:LocWorldDB
if %locFR% == YES goto LoadFR:

:LocWorldDB1
if %locDE% == YES goto LoadDE:

:LocWorldDB2
if %locKO% == YES goto LoadKO:

:LocWorldDB3
if %locCH% == YES goto LoadCH:

:LocWorldDB4
if %locTW% == YES goto LoadTW:

:LocWorldDB5
if %locES% == YES goto LoadES:

:LocWorldDB6
if %locMX% == YES goto LoadMX:

:LocWorldDB7
if %locRU% == YES goto LoadRU:

:LocWorldDB8
if %locIT% == YES goto LoadIT:

:LocWorldDB9
if %locPT% == YES goto LoadPT:

:LocWorldDB10
if %locBR% == YES goto LoadBR:

:done4

echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|%colReset%
echo %colWhiteDarkBlue%^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|%colReset%
echo %colWhiteDarkBlue%^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|%colReset%
echo %colWhiteDarkBlue%^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Setup and World Loader     %colWhiteBold%    ^|%colReset%
echo %colWhiteDarkBlue%^|_____________________________________________________________________________^|%colReset%
echo %colWhiteLightGreen%^|                                                                             ^|%colReset%
echo %colWhiteLightGreen%^|                                                                             ^|%colReset%
echo %colWhiteLightGreen%^| Database Creation and Load complete                                         ^|%colReset%
echo %colWhiteLightGreen%^|                                                                             ^|%colReset%
echo %colWhiteLightGreen%^|_____________________________________________________________________________^|%colReset%

REM Warn about not setting up the user
if %defaultsused% == YES goto defaultpasswordused:

:finish
echo.
echo %colReset% Script has completed !
echo %colReset% - Please review the messages above to ensure no errors occurred.
echo.
goto theend:

:PrepLoc
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Preparing Localisation files                                                ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo.

%dbClientConnectionString% %wdb% < Translations\1_LocaleTablePrepare.sql
goto LocWorldDB:


:LoadFR
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading French Locale into World Database                                   ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Creature_AI_Texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Gossip_texts.sql
echo  .... Gossip_Menu_option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\French\French_NpcText.sql
goto LocWorldDB1:

:LoadDE
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading German Locale into World Database                                   ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Creature_ai_texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Gossip_texts.sql
echo  .... Gossip_Menu_option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\German\German_NpcText.sql
goto LocWorldDB2:

:LoadKO
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Korean Locale into World Database                                   ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Creature_ai_texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Gossip_texts.sql
echo  .... Gossip Menu Option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Korean\Korean_NpcText.sql
goto LocWorldDB3:

:LoadCH
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Chinese Locale into World Database                                  ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Creature_ai_texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Gossip_texts.sql
echo  .... Gossip Menu Option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Chinese\Chinese_NpcText.sql
goto LocWorldDB4:

:LoadTW
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Taiwanese Locale into World Database                                ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Creature_ai_texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Gossip_texts.sql
echo  .... Gossip Menu Option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Taiwanese\Taiwanese_NpcText.sql
goto LocWorldDB5:

:LoadES
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Spanish Locale into World Database                                  ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Creature_ai_texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Gossip_texts.sql
echo  .... Gossip Menu Option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Gossip_Menu_Option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish\Spanish_NpcText.sql
goto LocWorldDB6:

:LoadMX
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Spanish (South American) Locale into World Database                 ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Creature_ai_texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Gossip_texts.sql
echo  .... Gossip Menu Option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Spanish_South_American\SpanishSA_NpcText.sql
goto LocWorldDB7:

:LoadRU
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Russian Locale into World Database                                  ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Creature_AI_Texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Gossip_texts.sql
echo  .... Gossip Menu Option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Russian\Russian_NpcText.sql
goto LocWorldDB8:

:LoadIT
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Italian Locale into World Database                                  ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Creature_AI_Texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Gossip_texts.sql
echo  .... Gossip Menu Option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Italian\Italian_NpcText.sql
goto LocWorldDB9:

:LoadPT
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Portuguese Locale into World Database                               ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Creature_AI_Texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Gossip_texts.sql
echo  .... Gossip Menu Option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Portuguese\Portuguese_NpcText.sql
goto LocWorldDB10:

:LoadBR
echo %colWhiteBold%_______________________________________________________________________________%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^| Loading Brazilian Locale into World Database                                ^|%colReset%
echo %colWhiteDarkYellow%^|                                                                             ^|%colReset%
echo %colWhiteDarkYellow%^|_____________________________________________________________________________^|%colReset%
echo  .... Command (1/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_CommandHelp.sql
echo  .... Creatures (2/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Creature.sql
echo  .... Creature AI Texts (3/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Creature_AI_Texts.sql
echo  .... DB Script Strings (4/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_db_script_string.sql
echo  .... GameObjects (5/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Gameobject.sql
echo  .... Gossip Texts (6/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Gossip_texts.sql
echo  .... Gossip Menu Option (7/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Gossip_Menu_option.sql
echo  .... Items (8/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Items.sql
echo  .... Mangos String (9/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Mangos_String.sql
echo  .... PageText (10/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_PageText.sql
echo  .... Points of Interest (11/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Points_of_interest.sql
echo  .... Quests (12/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Quest.sql
echo  .... Script Texts (13/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_Script_Texts.sql
echo  .... NpcText (14/14)
%dbClientConnectionString% %wdb% < Translations\Translations\Brazilian\Brazilian_NpcText.sql
goto done4:


:quitting
echo.
echo %colReset% Script has been aborted !
echo.
goto theend:

:theend
pause
