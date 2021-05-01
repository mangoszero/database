@ECHO OFF
rem -- set the main parameters
set createcharDB=YES
set createworldDB=YES
set createrealmDB=YES

set loadcharDB=YES
set loadworldDB=YES
set loadrealmDB=YES
set DBType=POPULATED
set activity=@

set locFR=NO
set locES=NO
set locDE=NO
set viacommandline=NO

rem -- Change the values below to match your server --
set mysql=
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


SET servername=%1
if %servername%. NEQ . goto parameters:
goto main

:parameters
if %servername% == HELP goto parametersbanners:
goto processparams

:parametersbanners
CLS
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Backup v1.1                %colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteLightBlue%^|                                                                             ^|
echo ^|   Website / Forum / Wiki / Support: https://getmangos.eu                    ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colWhiteBold%^|                                                                             ^|
echo %colWhiteBold%^|  
echo.
ECHO.
echo  Parameters:
echo.
echo  backupDB {servername} {username} {password} {port} {worlddbname}
echo           {wdbStruct} {chardbname} {cdbStruct} {realmdbname} {rdbStruct}
echo.
echo  Where    {servername}  - The name or ip address of the server
echo           {username}    - Username to use
echo           {password}    - Password to use
echo           {port}        - Port to access the server
echo           {worlddbname} - Name of the World Database
echo           {wdbStruct}   - Backup the Structure as part of the backup (YES/NO)
echo           {chardbname}  - Name of the Character Database
echo           {cdbStruct}   - Backup the Structure as part of the backup (YES/NO)
echo           {realmdbname} - Name of the Realm Database
echo           {rdbStruct}   - Backup the Structure as part of the backup (YES/NO)

echo  e.g.
echo.
echo  backupDB mangosserver root mangos 3306 mangos0 YES character0 YES realmd YES
echo.
goto finish

:processparams
set svr=%1
set user=%2
set pass=%3
set port=%4
set wdb=%5
set cdb=%7
set rdb=%9
set loadworldDB=%6
set loadcharDB=%8
shift /1
set loadrealmDB=%9
set viacommandline=YES

echo.
echo  backupDB %svr% %user% %pass% %port% %wdb% %loadworldDB% %cdb% %loadcharDB% %rdb% %loadrealmDB%
echo.
rem pause
rem goto finish


rem -- Don't change past this point --
rem setlocal
:main
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
rem If running from the commandline, skip the asking for params
if %viacommandline% == YES goto Step1:
CLS

echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Backup v1.0                %colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteLightBlue%^|                                                                             ^|
echo ^|   Website / Forum / Wiki / Support: https://getmangos.eu                    ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo %colWhiteBold%^|                                                                             ^|
echo %colWhiteBold%^|                                                                             ^|

if %createcharDB% == NO set PAD= 
if %createcharDB% == YES set PAD=
echo %colWhiteBold%^|    Character Database : V -%colWhite% Backup DB (%colYellowBold%%createcharDB%%colWhite%)%PAD%                                 %colWhiteBold%^|

if %loadcharDB% == NO set PAD= 
if %loadcharDB% == YES set PAD=
echo %colWhiteBold%^|                         C -%colWhite% Include DB Structure (%colYellowBold%%loadcharDB%%colWhite%)%PAD%                      %colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|

if %createworldDB% == NO set PAD= 
if %createworldDB% == YES set PAD=
echo %colWhiteBold%^|        %colYellowBold%World Database : E -%colYellow% Backup DB (%colWhiteBold%%createworldDB%%colYellow%)%PAD%                                 %colWhiteBold%^|

if %loadworldDB% == NO set PAD= 
if %loadworldDB% == YES set PAD=
echo %colWhiteBold%^|                         %colYellowBold%W -%colYellow% Include DB Structure (%colWhiteBold%%loadworldDB%%colYellow%)%PAD%                      %colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|

if %createrealmDB% == NO set PAD= 
if %createrealmDB% == YES set PAD=
echo %colWhiteBold%^|        %colCyanBold%Realm Database : T -%colCyan% Back DB (%colWhiteBold%%createrealmDB%%colCyan%)%PAD%                                   %colWhiteBold%^|

if %loadrealmDB% == NO set PAD= 
if %loadrealmDB% == YES set PAD=
echo %colWhiteBold%^|                         %colCyanBold%R -%colCyan% Include DB Structure (%colWhiteBold%%loadrealmDB%%colCyan%)%PAD%                      %colWhiteBold%^|
echo %colWhiteBold%^|                                                                             ^|
echo %colWhiteBold%^|                         %colGreenBold%N -%colGreen% Next Step%colWhiteBold%                                       ^|
echo %colWhiteBold%^|                         X - %colWhite%Exit%colWhiteBold%                                            ^|
echo %colWhiteBold%^|                                                                             ^|
echo %colWhiteBold%^|    %colRedBold%Type backupDB HELP to display commandline options%colWhiteBold%                        ^|
echo %colWhiteBold%^|                                                                             ^|
echo %colWhiteBold%^|_____________________________________________________________________________^|%colReset%
echo.


set /p activity=. Please select an activity ? : 
if %activity% == V goto ToggleCharDB:
if %activity% == v goto ToggleCharDB:
if %activity% == E goto ToggleWorldDB:
if %activity% == e goto ToggleWorldDB:
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

if %activity% == X goto done:
if %activity% == x goto done:
if %activity%. == . goto main:
if %activity% == . goto main:
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
if not exist %mysql%mysql.exe goto patherror:
rem If running from the commandline, skip the asking for params
if %viacommandline% == YES goto WorldDB:

CLS
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Backup                     %colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteLightBlue%^|                                                                             ^|
echo ^|   Website / Forum / Wiki / Support: https://getmangos.eu                    ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo.
echo.
set /p svr=. What is your MySQL host name?           [%svr%] : 
if %svr%. == . set svr=localhost
set /p user=. What is your MySQL user name?                [%user%] : 
if %user%. == . set user=root
set /p pass=. What is your MySQL password?               [%pass%] : 
if %pass%. == . set pass=mangos
set /p port=. What is your MySQL port?                     [%port%] : 
if %port%. == . set port=3306

set showChar=0
if %createcharDB% == YES set showChar=1
REM if %loadcharDB% == YES set showChar=1

if %showChar% == 1 set /p cdb=. What is your Character database name?  [%cdb%] : 
if %cdb%. == . set cdb=%cdborig%

set showWorld=0
if %createworldDB% == YES set showWorld=1
REM if %loadworldDB% == YES set showWorld=1
if %showWorld% == 1 set /p wdb=. What is your World database name?         [%wdb%] : 
if %wdb%. == . set wdb=%wdborig%

set showRealm=0
if %createrealmDB% == YES set showRealm=1
REM if %loadrealmDB% == YES set showRealm=1

if %showRealm% == 1 set /p rdb=. What is your Realm database name?          [%rdb%] : 
if %rdb%. == . set rdb=%rdborig%

color 02

:WorldDB
REM ##### IF createworlddb = YES then create the DB
if %loadworldDB% == NO set extraparams=--add-drop-table=false --no-create-info 
if %createworldDB% == YES goto WorldDB1:
if %loadworldDB% == YES goto WorldDB1:

:CharDB
REM ##### IF createchardb = YES then create the DB
set extraparams=
if %loadcharDB% == NO set extraparams=--add-drop-table=false --no-create-info 
if %loadcharDB% == YES goto CharDB1:
if %createcharDB% == YES goto CharDB1:

:RealmDB
REM ##### IF createrealmdb = YES then create the DB
set extraparams=
if %loadrealmDB% == NO set extraparams=--add-drop-table=false --no-create-info 
if %createrealmDB% == YES goto RealmDB1:
if %loadrealmDB% == YES goto RealmDB1:

goto done:

:WorldDB1
if exist _full_worlddb goto WorldDBSkip1:
md _full_worlddb
:WorldDBSkip1
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^| Dumping World Database                                                      ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo.

SET TABLENAME=areatrigger_tavern
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=areatrigger_teleport
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=autobroadcast
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=battleground_events
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=battleground_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=battlemaster_entry
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=command
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=conditions
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_addon
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_ai_scripts
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_ai_summons
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_ai_texts
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_battleground
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_equip_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_equip_template_raw
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_item_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_linking
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_linking_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_loot_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_model_info
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

REM SET TABLENAME=creature_model_race
REM echo             %TABLENAME%
REM if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_movement
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_movement_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_onkill_reputation
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_spells
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_template_addon
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_template_classlevelstats
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=creature_template_spells
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=custom_texts
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=db_script_string
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=db_version
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=db_scripts
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=disables
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=disenchant_loot_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=exploration_basexp
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=fishing_loot_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=game_event
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=game_event_creature
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=game_event_creature_data
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=game_event_gameobject
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=game_event_mail
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=game_event_quest
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=game_graveyard_zone
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=game_tele
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=game_weather
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=gameobject
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=gameobject_battleground
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=gameobject_loot_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=gameobject_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=gossip_menu
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=gossip_menu_option
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=gossip_texts
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=instance_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=item_enchantment_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=item_loot_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=item_required_target
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=item_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=locales_command
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=locales_creature
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=locales_gameobject
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=locales_gossip_menu_option
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=locales_item
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=locales_npc_text
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=locales_page_text
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=locales_points_of_interest
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=locales_quest
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

REM SET TABLENAME=mail_level_reward
REM echo             %TABLENAME%
REM if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=mail_loot_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=mangos_string
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=npc_text
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=npc_trainer
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=npc_trainer_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=npc_vendor
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=npc_vendor_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=page_text
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=pet_levelstats
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=pet_name_generation
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=petcreateinfo_spell
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=pickpocketing_loot_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=player_classlevelstats
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=player_levelstats
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=player_xp_for_level
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=playercreateinfo
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=playercreateinfo_action
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=playercreateinfo_item
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=playercreateinfo_spell
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=points_of_interest
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=pool_creature
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=pool_creature_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=pool_gameobject
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=pool_gameobject_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=pool_pool
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=pool_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

REM SET TABLENAME=prospecting_loot_template
REM echo             %TABLENAME%
REM if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=quest_relations
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=quest_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=reference_loot_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=reputation_reward_rate
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=reputation_spillover_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=reserved_name
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=script_binding
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=script_texts
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=script_waypoint
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

REM SET TABLENAME=skill_discovery_template
REM echo             %TABLENAME%
REM if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

REM SET TABLENAME=skill_extra_item_template
REM echo             %TABLENAME%
REM if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=skill_fishing_base_level
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=skinning_loot_template
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_affect
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_area
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_bonus_data
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_chain
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_elixir
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_facing
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_learn_spell
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_linked
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_pet_auras
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_proc_event
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_proc_item_enchant
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_script_target
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_target_position
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

REM SET TABLENAME=skill_extra_item_template
REM echo             %TABLENAME%
REM if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=spell_threat
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

REM SET TABLENAME=spell_template
REM echo             %TABLENAME%
REM if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
REM if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=transports
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

SET TABLENAME=warden
echo             %TABLENAME%
if %loadworldDB% == NO echo -- ---------------------------------------- >  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_worlddb\%TABLENAME%.sql
if %loadworldDB% == NO echo -- ---------------------------------------- >>  _full_worlddb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %wdb% %TABLENAME% >>  _full_worlddb\%TABLENAME%.sql

goto CharDB:

:CharDB1
REM ############ CHAR DB DUMP STUFF HERE ###########
if exist _full_chardb goto CharDBSkip1:
md _full_chardb
:CharDBSkip1
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^| Dumping Character Database                                                  ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo.

SET TABLENAME=ahbot_category
echo Dumping.... %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=ahbot_history
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=ahbot_price
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=ai_playerbot_names
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=ai_playerbot_random_bots
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=arena_team
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=arena_team_member
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=arena_team_stats
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=auction
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=bugreport
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_action
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_aura
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_battleground_data
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=character_declinedname
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_gifts
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_homebind
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_honor_cp
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_instance
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_inventory
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_pet
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=Character_pet_declinedname
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_queststatus
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=character_queststatus_daily
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_reputation
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_skills
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_social
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_spell
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_spell_cooldown
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_stats
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_tutorial
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_ticket
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=character_whispers
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=characters
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=corpse
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=creature_respawn
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=db_version
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=game_event_status
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=gameobject_respawn
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=group_instance
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=group_member
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=groups
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=guild
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=guild_bank_eventlog
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=guild_bank_item
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=guild_bank_right
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

REM SET TABLENAME=guild_bank_tab
REM echo             %TABLENAME%
REM if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
REM if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
REM mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=guild_eventlog
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=guild_member
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=guild_rank
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=instance
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=instance_reset
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=item_instance
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=item_loot
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=item_text
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=mail
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=mail_items
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=pet_aura
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=pet_spell
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=pet_spell_cooldown
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=petition
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=petition_sign
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=pvpstats_battlegrounds
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=pvpstats_players
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=saved_variables
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=warden_action
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql

SET TABLENAME=world
echo             %TABLENAME%
if %loadcharDB% == NO echo -- ---------------------------------------- >  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_chardb\%TABLENAME%.sql
if %loadcharDB% == NO echo -- ---------------------------------------- >>  _full_chardb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %cdb% %TABLENAME% >>  _full_chardb\%TABLENAME%.sql
goto RealmDB:

:RealmDB1
REM ############ REALM DB DUMP STUFF HERE ###########
if exist _full_realmdb goto RealmDBSkip1:
md _full_realmdb
:RealmDBSkip1
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkYellow%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^| Dumping Realm Database                                                      ^|
echo ^|                                                                             ^|
echo ^|_____________________________________________________________________________^|%colReset%
echo.

SET TABLENAME=account
echo Dumping.... %TABLENAME%
if %loadrealmDB% == NO echo -- ---------------------------------------- >  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %rdb% %TABLENAME% >>  _full_realmdb\%TABLENAME%.sql

SET TABLENAME=account_banned
echo             %TABLENAME%
if %loadrealmDB% == NO echo -- ---------------------------------------- >  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %rdb% %TABLENAME% >>  _full_realmdb\%TABLENAME%.sql

SET TABLENAME=db_version
echo             %TABLENAME%
if %loadrealmDB% == NO echo -- ---------------------------------------- >  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %rdb% %TABLENAME% >>  _full_realmdb\%TABLENAME%.sql

SET TABLENAME=ip_banned
echo             %TABLENAME%
if %loadrealmDB% == NO echo -- ---------------------------------------- >  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %rdb% %TABLENAME% >>  _full_realmdb\%TABLENAME%.sql

SET TABLENAME=realmcharacters
echo             %TABLENAME%
if %loadrealmDB% == NO echo -- ---------------------------------------- >  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %rdb% %TABLENAME% >>  _full_realmdb\%TABLENAME%.sql

SET TABLENAME=realmlist
echo             %TABLENAME%
if %loadrealmDB% == NO echo -- ---------------------------------------- >  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %rdb% %TABLENAME% >>  _full_realmdb\%TABLENAME%.sql

SET TABLENAME=uptime
echo             %TABLENAME%
if %loadrealmDB% == NO echo -- ---------------------------------------- >  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %rdb% %TABLENAME% >>  _full_realmdb\%TABLENAME%.sql

SET TABLENAME=warden_log
echo             %TABLENAME%
if %loadrealmDB% == NO echo -- ---------------------------------------- >  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_realmdb\%TABLENAME%.sql
if %loadrealmDB% == NO echo -- ---------------------------------------- >>  _full_realmdb\%TABLENAME%.sql
mysqldump -Q -c -e -q %extraparams% -u%user% -p%pass% --port=%port% -h %svr% %rdb% %TABLENAME% >>  _full_realmdb\%TABLENAME%.sql

goto done:



:patherror
echo.
echo _______________________________________________________________________________
echo %colWhiteDarkRed%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^|                           Cannot find required files.                       ^|
echo ^|                                                                             ^|
echo %colWhiteBold%^|_____________________________________________________________________________^|
echo.
goto finish:

:error
echo.
echo _______________________________________________________________________________
echo %colWhiteDarkRed%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^|                           Install Database Process Failed                   ^|
echo ^|                                                                             ^|
echo %colWhiteBold%^|_____________________________________________________________________________^|
echo.
goto finish:

:done
color 08
echo %colWhiteBold%_______________________________________________________________________________
echo %colWhiteDarkBlue%^|    __  __      _  _  ___  ___  ___                                          ^|
echo ^|   ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^|
echo ^|   ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^|
echo ^|   ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%Database Backup                     %colWhiteBold%    ^|
echo ^|_____________________________________________________________________________^|
echo %colWhiteLightGreen%^|                                                                             ^|
echo ^|                                                                             ^|
echo ^|                               Database Backup Complete                      ^|
echo ^|                                                                             ^|
echo %colWhiteBold%^|_____________________________________________________________________________^|
echo.
echo Done :)
echo.
:finish
pause