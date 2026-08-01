@ECHO OFF
REM =============================================================================
REM  MaNGOS - Database Setup and World Loader
REM =============================================================================
REM  MAINTENANCE NOTES
REM  -----------------
REM  Everything that used to be copy/pasted is now table driven:
REM
REM    Menu keys .......... KEY_<letter> / LKEY_<letter> lookup tables
REM    Option toggles ..... one :Toggle subroutine (no per-option labels)
REM    Locales ............ LOC_LIST + LOC_<code>_* tables, one :LoadLocale
REM    Locale SQL files ... LOC_TABLES (add or remove a file in ONE place)
REM    Update releases .... REL_LIST
REM    SQL execution ...... :RunSql / :RunSqlDir / :CountError (errors counted)
REM    Boxes and banners .. :Banner / :Section / :Box (self padding)
REM
REM  To add a locale:  add its code to LOC_LIST, define the four LOC_<code>_*
REM                    variables, and add the code to LOC_MENU to show it.
REM  To add a toggle:  give the variable a default in :SetDefaults, add a
REM                    KEY_<letter> entry in :SetTables, and echo a row in
REM                    :DrawMainMenu.  Nothing else needs to change.
REM
REM  All settings can still be pre-seeded from InstallDatabasesPreset.bat.
REM  Extra settings understood by this version:
REM    useColour=AUTO^|YES^|NO     force ANSI colour on or off
REM    pauseAtEnd=YES^|NO         skip the final pause for unattended runs
REM    testConnection=YES^|NO     check the server answers before doing work
REM    newuserHost=<host>        host part of the MySQL account that is created
REM
REM  The script exits with the number of statements that failed plus the number
REM  of SQL files that were missing, so it can be driven from another script.
REM =============================================================================

SETLOCAL

set "scriptVersion=3.0"
set "releaseVersionPrevious=21"
set "releaseVersionCurrent=22"
set "REL_LIST=%releaseVersionPrevious% %releaseVersionCurrent%"

call :SetDefaults
call :SetColours
call :SetTables

if /i not "%skipPrintOS%"=="YES" call :PrintOS

REM -- Sanity checks before anything is touched ---------------------------------
if exist "Realm" goto :HaveRepo
call :Abort "The repository was cloned without the --recursive flag"
goto :TheEnd

:HaveRepo
if defined dbClientConnectionString goto :HaveClient
if exist %dbClient% goto :HaveClient
call :Abort "Cannot find the database client: %dbClientDisplay%"
goto :TheEnd

:HaveClient
if /i "%skipChoices%"=="YES" goto :Execute

REM =============================================================================
REM  MAIN MENU
REM =============================================================================
:Main
call :DrawMainMenu
set "activity="
set /p activity=". Please select an activity ? : "
rem -- Enter (or a closed stdin) takes the default action, as it always did.
rem -- Nothing but empty answers means nobody is there: stop instead of spinning.
if defined activity set "emptyReads=0"
if not defined activity set /a emptyReads+=1
if not defined activity set "activity=%activityDefault%"
if %emptyReads% GTR 20 goto :Quitting
call :ReadKey "%activity%" "%MAIN_KEYS%"
if not defined key goto :Main

REM -- keys that do more than flip one variable are handled first --------------
if "%key%"=="N" goto :Execute
if "%key%"=="X" goto :Quitting
if "%key%"=="A" goto :LocaleMenu
if "%key%"=="D" call :ToggleWorldDBType
if "%key%"=="O" call :ToggleUpdatesOnly
if "%key%"=="Z" call :ToggleAllOptions

REM -- everything else is a plain on/off option in the KEY_ lookup table -------
if defined KEY_%key% call :ToggleByKey KEY %key%
goto :Main

REM =============================================================================
REM  LOCALISATION MENU
REM =============================================================================
:LocaleMenu
call :DrawLocaleMenu
set "activity="
set /p activity=%colYellowBold% Please select an activity ? : %colReset%
if not defined activity set "activity=X"
call :ReadKey "%activity%" "%LOC_KEYS% X"
if not defined key goto :LocaleMenu

if "%key%"=="X" (
    call :RefreshLOCList
    goto :Main
)
if defined LKEY_%key% call :ToggleByKey LKEY %key%
goto :LocaleMenu

REM =============================================================================
REM  EXECUTION
REM =============================================================================
:Execute
if /i not "%skipConnection%"=="YES" call :AskConnectionDetails

rem -- a preset can enable locales without ever opening the localisation menu
call :RefreshLOCList

rem -- each value is quoted so a password containing & ^| < > or a space cannot
rem -- break out of the command line; the client strips the quotes itself.
if not defined dbClientConnectionOptions set "dbClientConnectionOptions=-h "%svr%" --user="%user%" --password="%pass%" --port="%port%""
if not defined dbClientOtherOptions      set dbClientOtherOptions=-q -s
if not defined dbClientConnectionString  set dbClientConnectionString=%dbClient% %dbClientConnectionOptions% %dbClientOtherOptions%

if /i "%DEBUG%"=="YES" call :ShowDebug

if /i "%createMangosUser%"=="YES" if /i "%newpass%"=="mangos" set "defaultsused=YES"

REM -- fail fast instead of reporting the same error for every SQL file ---------
if /i not "%testConnection%"=="YES" goto :Work
call :Section "Checking the connection to %svr%"
%dbClientConnectionString% -e "SELECT 1;" >nul 2>&1
if not errorlevel 1 goto :ConnectionOK
call :ConnectionFailed
if "%retry%"=="YES" goto :Execute
goto :TheEnd

:ConnectionOK
echo  . Connection OK
echo.

:Work
REM -- Create and load, in the original order -----------------------------------
if /i "%createworldDB%"=="YES"    call :CreateDatabase "%wdb%" "World"
if /i "%loadworldDB%"=="YES"      call :LoadWorld
if /i "%createcharDB%"=="YES"     call :CreateDatabase "%cdb%" "Character"
if /i "%loadcharDB%"=="YES"       call :LoadStructure  "%cdb%" "Character" "Character\Setup\characterLoadDB.sql"
if /i "%createrealmDB%"=="YES"    call :CreateDatabase "%rdb%" "Realm"
if /i "%loadrealmDB%"=="YES"      call :LoadStructure  "%rdb%" "Realm" "Realm\Setup\realmdLoadDB.sql"
if /i "%addrealmentry%"=="YES"    call :AddRealmEntry
if /i "%createMangosUser%"=="YES" call :CreateMangosUser

REM -- Updates -------------------------------------------------------------------
if /i "%CDBUpdate%"=="YES" call :ApplyUpdates "Character" "Character" "%cdb%"
if /i "%WDBUpdate%"=="YES" call :ApplyUpdates "World"     "World"     "%wdb%"
if /i "%RDBUpdate%"=="YES" call :ApplyUpdates "Realmd"    "Realm"     "%rdb%"

REM -- Localisation ---------------------------------------------------------------
if /i "%LOCList%"=="YES" call :LoadLocales

call :Banner
call :Box "%colWhiteLightGreen%" . . "Database Creation and Load complete" .
if /i "%createMangosUser%"=="YES" if /i "%defaultsused%"=="YES" call :DefaultPasswordWarning
goto :Finish

REM =============================================================================
REM  WORK SUBROUTINES
REM =============================================================================

REM  :CreateDatabase <dbName> <friendlyName>
REM  The statements are run here rather than handed to a helper: CALL re-parses
REM  its command line, so a '%' in a value read straight from a variable (the
REM  new user's password above all) would be expanded twice and corrupted.
:CreateDatabase
call :Section "Creating %~2 Database"
echo  . Creating database %~1
%dbClientConnectionString% -e "create database %~1;"
if errorlevel 1 call :CountError "create database %~1"
exit /b 0

REM  :LoadStructure <dbName> <friendlyName> <sqlFile>
:LoadStructure
call :Section "Loading %~2 Database"
call :RunSql "%~1" "%~3" "%~nx3"
exit /b 0

:LoadWorld
if /i "%DBType%"=="POPULATED" goto :LoadWorldPopulated
call :Section "Preparing World Database Structure"
call :RunSql "%wdb%" "World\Setup\mangosdLoadDB.sql" "mangosdLoadDB.sql"
exit /b 0

:LoadWorldPopulated
call :Section "Populating World Database"
call :RunSql    "%wdb%" "World\Setup\mangosdLoadDB.sql" "mangosdLoadDB.sql"
call :RunSqlDir "%wdb%" "World\Setup\FullDB"
exit /b 0

:AddRealmEntry
call :Section "Adding RealmList entry in Realm Database"
call :RunSql "%rdb%" "Tools\updateRealm.sql" "updateRealm.sql"
exit /b 0

REM  :ApplyUpdates <friendlyName> <folder> <dbName>
:ApplyUpdates
call :Section "Applying %~1 DB updates"
for %%R in (%REL_LIST%) do call :RunSqlDir "%~3" "%~2\Updates\Rel%%R"
exit /b 0

:CreateMangosUser
rem -- settled here, so it follows the host name even after a retry --
if not defined newuserHost set "newuserHost=%svr%"
call :Section "Creating new user and granting privileges"
echo  . Creating '%newuser%'@'%newuserHost%' and granting privileges
%dbClientConnectionString% -e "CREATE USER '%newuser%'@'%newuserHost%' IDENTIFIED BY '%newpass%';"
if errorlevel 1 call :CountError "CREATE USER '%newuser%'"
for %%D in ("%wdb%" "%cdb%" "%rdb%") do call :Grant %%D
exit /b 0

REM  :Grant <dbName>
:Grant
%dbClientConnectionString% -e "GRANT %GRANT_PRIVS% ON `%~1`.* TO '%newuser%'@'%newuserHost%';"
if errorlevel 1 call :CountError "GRANT on %~1"
exit /b 0

:LoadLocales
call :Section "Preparing Localisation files"
call :RunSql "%wdb%" "Translations\1_LocaleTablePrepare.sql" "1_LocaleTablePrepare.sql"
for %%L in (%LOC_LIST%) do call :LoadLocaleIfEnabled %%L
exit /b 0

REM  :LoadLocaleIfEnabled <code>   loads the locale only when loc<code> is YES
:LoadLocaleIfEnabled
set "enabled="
call set "enabled=%%loc%~1%%"
if /i not "%enabled%"=="YES" exit /b 0
call set "locName=%%LOC_%~1_NAME%%"
call set "locDir=%%LOC_%~1_DIR%%"
call set "locPfx=%%LOC_%~1_PREFIX%%"
call :Section "Loading %locName% Locale into World Database"
set "locStep=0"
for %%T in (%LOC_TABLES%) do call :LoadLocaleTable %%T
exit /b 0

REM  :LoadLocaleTable <tableSuffix>
:LoadLocaleTable
set /a locStep+=1
set "lbl=%~1"
set "lbl=%lbl:_= %"
call :RunSql "%wdb%" "%LOC_ROOT%\%locDir%\%locPfx%_%~1.sql" "%lbl% (%locStep%/%LOC_TABLE_COUNT%)"
exit /b 0

REM =============================================================================
REM  SQL HELPERS - every database call goes through one of these
REM =============================================================================

REM  :RunSql <dbName> <sqlFile> [label]
:RunSql
if not "%~3"=="" echo  .... %~3
if not exist "%~2" goto :RunSqlMissing
%dbClientConnectionString% %~1 < "%~2"
if errorlevel 1 goto :RunSqlFailed
exit /b 0
:RunSqlMissing
set /a sqlMissing+=1
echo %colRedBold%      Missing SQL file: %~2%colReset%
exit /b 1
:RunSqlFailed
set /a sqlErrors+=1
echo %colRedBold%      Error while running %~2%colReset%
exit /b 1

REM  :RunSqlDir <dbName> <folder>   sorted, so numbered updates apply in order
:RunSqlDir
if not exist "%~2" exit /b 0
for /f "delims=" %%F in ('dir /b /a-d /on "%~2\*.sql" 2^>nul') do call :RunSql "%~1" "%~2\%%F" "%%F"
exit /b 0

REM  :CountError <what failed>
:CountError
set /a sqlErrors+=1
echo %colRedBold%      Error while running: %~1%colReset%
exit /b 1

REM  :ShowDebug
:ShowDebug
echo dbClientConnectionOptions: %dbClientConnectionOptions%
echo dbClientOtherOptions: %dbClientOtherOptions%
echo dbClientConnectionString: %dbClientConnectionString%
echo Sample Execution: %dbClientConnectionString% -e "create database %wdb%;"
exit /b 0

REM =============================================================================
REM  PROMPTS
REM =============================================================================
:AskConnectionDetails
CLS
call :Banner
call :Box "%colWhiteDarkRed%" . "Only leave the defaults for username, password and mysql port on servers" "with no external internet access." . "Using these settings will leave your server open to exploits," "security breaches... or much much worse." .
echo.
set /p svr="%colYellowBold% What is your MySQL host name?           %colReset%DEFAULT: [%colWhiteBold%%svr%%colReset%] : "
call :DefaultIfBlank svr localhost
set /p user="%colYellowBold% What is your MySQL user name?                %colReset%DEFAULT: [%colWhiteBold%%user%%colReset%] : "
call :DefaultIfBlank user root
set /p pass="%colYellowBold% What is your MySQL password?               %colReset%DEFAULT: [%colWhiteBold%%pass%%colReset%] : "
call :DefaultIfBlank pass mangos
set /p port="%colYellowBold% What is your MySQL port?                     %colReset%DEFAULT: [%colWhiteBold%%port%%colReset%] : "
call :DefaultIfBlank port 3306

call :AnyEnabled createcharDB loadcharDB CDBUpdate
if "%needed%"=="1" set /p cdb="%colYellowBold% What is your Character database name?  %colReset%DEFAULT: [%colWhiteBold%%cdb%%colReset%] : "
call :DefaultIfBlank cdb "%cdborig%"

call :AnyEnabled createworldDB loadworldDB WDBUpdate
if "%needed%"=="1" set /p wdb="%colYellowBold% What is your World database name?         %colReset%DEFAULT: [%colWhiteBold%%wdb%%colReset%] : "
call :DefaultIfBlank wdb "%wdborig%"

call :AnyEnabled createrealmDB loadrealmDB RDBUpdate addrealmentry
if "%needed%"=="1" set /p rdb="%colYellowBold% What is your Realm database name?          %colReset%DEFAULT: [%colWhiteBold%%rdb%%colReset%] : "
call :DefaultIfBlank rdb "%rdborig%"

if /i not "%createMangosUser%"=="YES" exit /b 0

:AskNewUser
set /a newUserAsk+=1
set /p newuser="%colYellowBold% New MySQL user name?                       %colReset%DEFAULT: [%colWhiteBold%%newuser%%colReset%] : "
call :DefaultIfBlank newuser mangos
set /p newpass="%colYellowBold% New MySQL user password?                   %colReset%DEFAULT: [%colWhiteBold%%newpass%%colReset%] : "
call :DefaultIfBlank newpass mangos
if /i not "%newpass%"=="mangos" exit /b 0

echo.
call :Box "%colWhiteDarkRed%" . "That is the well known default password for this account." "Anyone who can reach this server will be able to use it." .
echo.
set "confirm="
set /p confirm=" Create '%newuser%' with the default password anyway? (Y/<*>) : "
if /i "%confirm%"=="Y" exit /b 0
rem -- never loop forever: an unattended run has no one to answer the prompt --
if %newUserAsk% GEQ 3 exit /b 0
echo.
echo  Please choose a different password.
echo.
goto :AskNewUser

REM  :ConnectionFailed   report it, and offer to type the details again rather
REM  than dropping the operator back at a closed window with no explanation.
:ConnectionFailed
set "retry=NO"
call :ErrorBox "Could not connect to %svr% on port %port% as user '%user%'." "Check the host name, user name, password and port."
set /a connectAsk+=1
if /i "%skipConnection%"=="YES" goto :ConnectionGiveUp
if %connectAsk% GEQ 3 goto :ConnectionGiveUp
echo.
set "answer="
set /p answer=" Enter different connection details and try again? (Y/<*>) : "
if /i not "%answer%"=="Y" goto :ConnectionGiveUp
set "retry=YES"
set "dbClientConnectionOptions="
set "dbClientConnectionString="
exit /b 0
:ConnectionGiveUp
set /a sqlErrors+=1
exit /b 0

REM  :DefaultIfBlank <variableName> <default>
REM  SET /P leaves a variable alone when the user presses Enter, but it happily
REM  stores a value that is nothing but spaces - put the default back for both.
:DefaultIfBlank
set "raw="
call set "raw=%%%~1%%"
set "probe=%raw: =%"
if defined probe exit /b 0
set "%~1=%~2"
exit /b 0

REM  :AnyEnabled <flag> [flag...]   sets needed=1 when any of the flags is YES
:AnyEnabled
set "needed=0"
:AnyEnabledLoop
if "%~1"=="" exit /b 0
set "flagValue="
call set "flagValue=%%%~1%%"
if /i "%flagValue%"=="YES" set "needed=1"
shift
goto :AnyEnabledLoop

REM =============================================================================
REM  OPTION HANDLING
REM =============================================================================

REM  :ToggleByKey <tableName> <menuKey>   flips the variable that key stands for
:ToggleByKey
set "target="
call set "target=%%%~1_%~2%%"
if defined target call :Toggle %target%
exit /b 0

REM  :Toggle <variableName>   flips YES <-> NO
:Toggle
set "current="
call set "current=%%%~1%%"
if /i "%current%"=="YES" (set "%~1=NO") else (set "%~1=YES")
exit /b 0

:ToggleWorldDBType
if /i "%DBType%"=="EMPTY" (set "DBType=POPULATED") else (set "DBType=EMPTY")
exit /b 0

:ToggleUpdatesOnly
if /i "%updatesOnly%"=="YES" goto :UpdatesOnlyOff
set "updatesOnly=YES"
for %%V in (%CREATE_VARS% %LOAD_VARS% addrealmentry) do set "%%V=NO"
for %%V in (%UPDATE_VARS%) do set "%%V=YES"
exit /b 0
:UpdatesOnlyOff
set "updatesOnly=NO"
for %%V in (%CREATE_VARS% %LOAD_VARS% %UPDATE_VARS% addrealmentry) do set "%%V=YES"
exit /b 0

REM  :ToggleAllOptions   what Z does: all off, or all back on.
REM  While anything is still YES the next press clears the lot; once every
REM  option is NO the next press turns them all back on, so Z is a way back
REM  as well as a way out.  The menu row shows which of the two is next.
:ToggleAllOptions
call :SetToggleVars
call :AnyEnabled %TOGGLE_VARS%
if "%needed%"=="1" (set "toggleAllTo=NO") else (set "toggleAllTo=YES")
for %%V in (%TOGGLE_VARS%) do set "%%V=%toggleAllTo%"
exit /b 0

REM  :SetToggleVars   the options Z acts on.  Only the rows the menu is actually
REM  showing, so turning everything on cannot quietly undo "Only Install
REM  Updates" by switching the create and load steps back on behind the scenes.
:SetToggleVars
set "TOGGLE_VARS=%CREATE_VARS% %LOAD_VARS% %UPDATE_VARS% addrealmentry"
if /i "%updatesOnly%"=="YES" set "TOGGLE_VARS=%UPDATE_VARS%"
exit /b 0

:RefreshLOCList
set "LOCList=NO"
for %%L in (%LOC_LIST%) do call :CheckLocEnabled %%L
exit /b 0

:CheckLocEnabled
set "enabled="
call set "enabled=%%loc%~1%%"
if /i "%enabled%"=="YES" set "LOCList=YES"
exit /b 0

REM  :ReadKey <input> <allowed keys>   key is set only for an allowed choice
:ReadKey
set "key="
set "input=%~1"
if not defined input exit /b 0
set "input=%input:~0,1%"
for %%K in (%~2) do if /i "%input%"=="%%K" set "key=%%K"
exit /b 0

REM =============================================================================
REM  MENUS
REM =============================================================================
:DrawMainMenu
CLS
for %%V in (%YESNO_VARS%) do call :PadYN %%V
if /i "%DBType%"=="EMPTY" (set "pDBType=    ") else (set "pDBType=")
rem -- the Z row says what the next press will do; both labels are 11 wide --
call :SetToggleVars
call :AnyEnabled %TOGGLE_VARS%
set "zLabel=Toggle All Settings"
REM if "%needed%"=="1" (set "zLabel=Toggle None") else (set "zLabel=Toggle All ")
call :Banner
echo %colWhiteLightBlue%^                                                                              ^ 
echo ^    Website / Forum / Wiki / Support: https://getmangos.eu                    ^ 
echo ^                                                                              ^ %colReset%
echo %colWhiteBold%^                                                                              ^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^    %colWhiteBold%Character Database : V - %colReset%Toggle Actually Create Character DB (%colYellowBold%%createcharDB%%colReset%)        %pcreatecharDB%%colWhiteBold%^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^                         %colWhiteBold%C - %colReset%Toggle Create Character DB Structure (%colYellowBold%%loadcharDB%%colReset%)       %ploadcharDB%%colWhiteBold%^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^                         %colWhiteBold%B - %colReset%Apply Character DB updates (%colYellowBold%%CDBUpdate%%colReset%)                 %pCDBUpdate%%colWhiteBold%^ 
if /i "%updatesOnly%"=="YES" echo %colWhiteBold%^    %colWhiteBold%Character Database : B - %colReset%Apply Character DB updates (%colYellowBold%%CDBUpdate%%colReset%)                 %pCDBUpdate%%colWhiteBold%^ 
echo %colWhiteBold%^                                                                              ^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^        %colYellowBold%World Database : E - %colYellow%Toggle Actually Create World DB (%colWhiteBold%%createworldDB%%colYellow%)%colReset%            %pcreateworldDB%%colWhiteBold%^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^                         %colYellowBold%W - %colYellow%Toggle Create World DB Structure (%colWhiteBold%%loadworldDB%%colYellow%)%colReset%           %ploadworldDB%%colWhiteBold%^ 
if /i "%loadworldDB%"=="YES" echo %colWhiteBold%^                         %colYellowBold%D - %colYellow%Toggle World Type (%colWhiteBold%%DBType%%colYellow%)%colReset%                    %pDBType%%colWhiteBold%^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^                         %colYellowBold%U - %colYellow%Apply World DB updates (%colWhiteBold%%WDBUpdate%%colYellow%)%colReset%                     %pWDBUpdate%%colWhiteBold%^ 
if /i "%updatesOnly%"=="YES" echo %colWhiteBold%^        %colYellowBold%World Database : U - %colYellow%Apply World DB updates (%colWhiteBold%%WDBUpdate%%colYellow%)%colReset%                     %pWDBUpdate%%colWhiteBold%^ 
echo %colWhiteBold%^                                                                              ^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^        %colCyanBold%Realm Database : T - %colCyan%Toggle Actually Create Realm DB (%colWhiteBold%%createrealmDB%%colCyan%)%colReset%            %pcreaterealmDB%%colWhiteBold%^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^                         %colCyanBold%R - %colCyan%Toggle Create Realm Db Structure (%colWhiteBold%%loadrealmDB%%colCyan%)%colReset%           %ploadrealmDB%%colWhiteBold%^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^                         %colCyanBold%Y - %colCyan%Apply Realm DB updates (%colWhiteBold%%RDBUpdate%%colCyan%)%colReset%                     %pRDBUpdate%%colWhiteBold%^ 
if /i "%updatesOnly%"=="YES" echo %colWhiteBold%^        %colCyanBold%Realm Database : Y - %colCyan%Apply Realm DB updates (%colWhiteBold%%RDBUpdate%%colCyan%)%colReset%                     %pRDBUpdate%%colWhiteBold%^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^                         %colCyanBold%L - %colCyan%Toggle Add Default RealmList Entry for Core (%colWhiteBold%%addrealmentry%%colCyan%)%colReset%%paddrealmentry%%colWhiteBold%^ 
echo %colWhiteBold%^                                                                              ^ 
echo %colWhiteBold%^                         %colMagentaBold%O - %colMagenta%Toggle Only Install Updates to Database's (%colWhiteBold%%updatesOnly%%colMagenta%)%colReset%  %pupdatesOnly%%colWhiteBold%^ 
echo %colWhiteBold%^                         %colMagentaBold%Z - %colMagenta%%zLabel%                                      %colWhiteBold%^ 
echo %colWhiteBold%^                                                                              ^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^                         %colRedBold%P - %colRed%Toggle Create Mangos User (%colWhiteBold%%createMangosUser%%colRed%)%colReset%                  %pcreateMangosUser%%colWhiteBold%^ 
if /i "%updatesOnly%"=="NO"  echo %colWhiteBold%^                                                                              ^ 
echo %colWhiteBold%^                         %colYellowBold%A - %colYellow%Add Localised Content (%colWhiteBold%%LOCList%%colYellow%)%colReset%                      %pLOCList%%colWhiteBold%^ %colReset%
echo %colWhiteBold%^                                                                              ^ 
echo %colWhiteBold%^                         %colGreenBold%N - %colGreen%Next Step%colReset%                                        %colWhiteBold%^ %colReset%
echo %colWhiteBold%^                         %colWhiteBold%X - %colReset%Exit                                             %colWhiteBold%^ %colReset%
echo %colWhiteBold%^                                                                              ^ %colReset%
REM xxxx echo.
exit /b 0

:DrawLocaleMenu
CLS
for %%V in (%LOC_VARS%) do call :PadYN %%V
call :Banner
call :TitleBox "%colWhiteDarkYellow%" "Database Localisation Support"
echo %colWhiteBold%^                                                                              ^ 
set "rowPrefix=%LOCIND1%"
for %%L in (%LOC_MENU%) do call :DrawLocaleRow %%L
echo %colWhiteBold%^                                                                              ^ 
echo %colWhiteBold%^                           %colRedBold%X - %colRed%Back to main Menu%colReset%                              %colWhiteBold%^|
echo %colWhiteBold%^                                                                              ^ 
echo %colWhiteBold%^                                                                              ^ %colReset%
echo.
exit /b 0

REM  :DrawLocaleRow <code>   the name is padded so every row lines up
:DrawLocaleRow
call set "locName=%%LOC_%~1_NAME%%"
call set "locKey=%%LOC_%~1_KEY%%"
call set "locState=%%loc%~1%%"
call set "locPad=%%ploc%~1%%"
set "nm=%locName%                            "
set "nm=%nm:~0,19%"
echo %colWhiteBold%^ %rowPrefix%%colYellowBold%%locKey% - %colYellow%Toggle %nm%(%colWhiteBold%%locState%%colYellow%)%colReset%                %locPad%%colWhiteBold%^ 
set "rowPrefix=%LOCIND%"
exit /b 0

REM  :PadYN <variableName>   sets p<variableName> to the alignment filler
:PadYN
set "value="
call set "value=%%%~1%%"
if /i "%value%"=="YES" (set "p%~1=") else (set "p%~1= ")
exit /b 0

REM =============================================================================
REM  OUTPUT HELPERS
REM =============================================================================
:Banner
echo %colWhiteDarkBlue%^     __  __      _  _  ___  ___  ___                                          ^ %colReset%
echo %colWhiteDarkBlue%^    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|                                         ^ %colReset%
echo %colWhiteDarkBlue%^    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \                                         ^ %colReset%
echo %colWhiteDarkBlue%^    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/ %colYellowBold%%bannerTitle%%colWhiteBold%^ %colReset%
echo %colWhiteDarkBlue%^                                                                              ^ %colReset%
exit /b 0

REM  :Section <title>   rule, title box and a blank line - used before each step
:Section
echo %colWhiteBold%1______________________________________________________________________________%colReset%
call :TitleBox "%colWhiteDarkYellow%" "%~1"
echo.
exit /b 0

REM  :TitleBox <colour> <title>
:TitleBox
call :BoxLine "%~1" ""
call :BoxLine "%~1" "%~2"
echo %~1^                                                                              ^ %colReset%
exit /b 0

REM  :Box <colour> <line> [line...]   any number of lines, padded automatically
REM  A single dot means a blank line: an empty "" argument survives IF as four
REM  quote characters, which not every parser copes with.
:Box
set "boxColour=%~1"
shift
:BoxLoop
if "%~1"=="" goto :BoxEnd
set "boxText=%~1"
if "%boxText%"=="." set "boxText="
call :BoxLine "%boxColour%" "%boxText%"
shift
goto :BoxLoop
:BoxEnd
exit /b 0

REM  :BoxLine <colour> <text>
REM  Boxes can carry values the user typed, so neutralise the characters that
REM  would otherwise break out of the ECHO once they have been expanded.
:BoxLine
set "line=%~2                                                                             "
set "line=%line:&=+%"
set "line=%line:|=+%"
set "line=%line:<=+%"
set "line=%line:>=+%"
set "line=%line:^=+%"
set "line=%line:~0,76%"
echo %~1^  %line%^ %colReset%
exit /b 0

REM  :ErrorBox <line one> [line two]
:ErrorBox
call :Box "%colWhiteDarkRed%" . "** ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR **" .
call :Box "" . "  %~1" "  %~2" .
call :Box "%colWhiteDarkRed%" . "** ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR * ERROR **" .
exit /b 0

REM  :Abort <line one> [line two]   error box, and the run is flagged as failed
:Abort
call :Banner
call :ErrorBox "%~1" "%~2"
set /a sqlErrors+=1
exit /b 0

:DefaultPasswordWarning
call :Box "%colWhiteDarkRed%" . "** WARNING ** The MySQL account '%newuser%' uses the default password." . "  Change it before this server is reachable from the internet." .
exit /b 0

:PrintOS
if "%version%"=="6.0"  echo Windows Vista.
if "%version%"=="6.1"  echo Windows 7.
if "%version%"=="6.2"  echo Windows 8.
if "%version%"=="6.3"  echo Windows 8.1
if "%version%"=="10.0" echo Windows 10 or later.
exit /b 0

REM =============================================================================
REM  SETUP
REM =============================================================================
:SetDefaults
rem -- Change the values below to match your server --
rem -- Or do so in InstallDatabasesPreset.bat instead. --
if not defined dbClientHome set "dbClientHome=Tools"
if not defined dbClientName set "dbClientName=mysql.exe"
if not defined dbClient     set dbClient="%dbClientHome%\%dbClientName%"
set dbClientDisplay=%dbClient:"=%

if not defined svr     set "svr=localhost"
if not defined newuser set "newuser=mangos"
if not defined user    set "user=root"
if not defined pass    set "pass=mangos"
if not defined newpass set "newpass=mangos"
if not defined port    set "port=3306"

if exist "SetCoreUniqueVars.bat" call SetCoreUniqueVars.bat

if not defined wdb set "wdb=mangos%coreNum%"
if not defined cdb set "cdb=character%coreNum%"
if not defined rdb set "rdb=realmd"

rem -- the *orig names are kept only so an existing preset file still loads.
rem -- SET /P leaves a variable untouched when the user just presses Enter,
rem -- so the defaults above are all that is needed to restore them.
if not defined wdborig set "wdborig=%wdb%"
if not defined cdborig set "cdborig=%cdb%"
if not defined rdborig set "rdborig=%rdb%"

if not defined skipPrintOS    set "skipPrintOS=NO"
if not defined skipChoices    set "skipChoices=NO"
if not defined skipConnection set "skipConnection=NO"
rem -- skipping the menu has always meant skipping the prompts behind it too --
if /i "%skipChoices%"=="YES" set "skipConnection=YES"
if not defined testConnection set "testConnection=YES"
if not defined pauseAtEnd     set "pauseAtEnd=YES"
if not defined useColour      set "useColour=AUTO"
if not defined DEBUG          set "DEBUG=NO"

rem -- Don't change past this point --
set "CREATE_VARS=createcharDB createworldDB createrealmDB createMangosUser"
set "LOAD_VARS=loadcharDB loadworldDB loadrealmDB"
set "UPDATE_VARS=CDBUpdate WDBUpdate RDBUpdate"

for %%V in (%CREATE_VARS% %LOAD_VARS% %UPDATE_VARS% addrealmentry) do if not defined %%V set "%%V=YES"
if not defined updatesOnly  set "updatesOnly=NO"
if not defined defaultsused set "defaultsused=NO"
if not defined DBType       set "DBType=POPULATED"
if not defined LOCList      set "LOCList=NO"

rem -- what pressing Enter at the main menu does; the preset can override it --
if not defined activity set "activity=N"
set "activityDefault=%activity%"

set "sqlErrors=0"
set "sqlMissing=0"
set "newUserAsk=0"
set "connectAsk=0"
set "emptyReads=0"
set "GRANT_PRIVS=SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, LOCK TABLES, CREATE ROUTINE, ALTER ROUTINE"

rem -- the banner title is padded so any length of version number still fits --
set "bannerTitle=Database Setup and World Loader v%scriptVersion%                              "
set "bannerTitle=%bannerTitle:~0,40%"

rem -- indents for the localisation menu rows --
set "LOCIND1=                Locales : "
set "LOCIND=                          "
exit /b 0

:SetColours
for /f "tokens=4-5 delims=. " %%i in ('ver') do set "VERSION=%%i.%%j"
set "useAnsi=NO"
if /i "%useColour%"=="YES" set "useAnsi=YES"
if /i "%useColour%"=="AUTO" if "%version%"=="10.0" set "useAnsi=YES"

rem -- the colour names stay defined but empty when ANSI is not available --
for %%C in (Reset Yellow YellowBold WhiteBold WhiteDarkBlue WhiteLightBlue WhiteLightGreen CyanBold Cyan White MagentaBold Magenta RedBold Red GreenBold Green WhiteDarkRed Bold WhiteDarkYellow) do set "col%%C="
if not "%useAnsi%"=="YES" exit /b 0

rem -- build the escape character at run time, so no editor can strip it --
for /f %%E in ('echo prompt $E^| cmd') do set "ESC=%%E"
set "colReset=%ESC%[0m"
set "colYellow=%ESC%[33m"
set "colYellowBold=%ESC%[93m"
set "colWhiteBold=%ESC%[97m"
set "colWhiteDarkBlue=%ESC%[97;44m"
set "colWhiteLightBlue=%ESC%[97;104m"
set "colWhiteLightGreen=%ESC%[97;42m"
set "colCyanBold=%ESC%[96m"
set "colCyan=%ESC%[36m"
set "colWhite=%ESC%[37m"
set "colMagentaBold=%ESC%[95m"
set "colMagenta=%ESC%[35m"
set "colRedBold=%ESC%[91m"
set "colRed=%ESC%[31m"
set "colGreenBold=%ESC%[92m"
set "colGreen=%ESC%[32m"
set "colWhiteDarkRed=%ESC%[97;101m"
set "colBold=%ESC%[101m"
set "colWhiteDarkYellow=%ESC%[97;43m"
exit /b 0

:SetTables
rem -- main menu: key -> variable to flip --
set "KEY_V=createcharDB"
set "KEY_C=loadcharDB"
set "KEY_B=CDBUpdate"
set "KEY_E=createworldDB"
set "KEY_W=loadworldDB"
set "KEY_U=WDBUpdate"
set "KEY_T=createrealmDB"
set "KEY_R=loadrealmDB"
set "KEY_Y=RDBUpdate"
set "KEY_L=addrealmentry"
set "KEY_P=createMangosUser"
set "MAIN_KEYS=V C B E W U T R Y L P D O Z N A X"

rem -- locales: code -> name / folder / file prefix / menu key --
set "LOC_ROOT=Translations\Translations"
rem -- LOC_LIST is the load order, kept the same as it has always been.
set "LOC_LIST=FR DE KO CH TW ES MX RU IT PT BR"
rem -- LOC_MENU decides which locales are offered on screen, and in what order.
rem -- A code in LOC_LIST but not in LOC_MENU can still be set from the preset.
set "LOC_MENU=CH FR DE KO MX RU ES TW"

set "LOC_CH_NAME=Chinese"           & set "LOC_CH_DIR=Chinese"                & set "LOC_CH_PREFIX=Chinese"    & set "LOC_CH_KEY=C"
set "LOC_FR_NAME=French"            & set "LOC_FR_DIR=French"                 & set "LOC_FR_PREFIX=French"     & set "LOC_FR_KEY=F"
set "LOC_DE_NAME=German"            & set "LOC_DE_DIR=German"                 & set "LOC_DE_PREFIX=German"     & set "LOC_DE_KEY=G"
set "LOC_KO_NAME=Korean"            & set "LOC_KO_DIR=Korean"                 & set "LOC_KO_PREFIX=Korean"     & set "LOC_KO_KEY=K"
set "LOC_MX_NAME=Spanish (Mexican)" & set "LOC_MX_DIR=Spanish_South_American" & set "LOC_MX_PREFIX=SpanishSA"  & set "LOC_MX_KEY=M"
set "LOC_RU_NAME=Russian"           & set "LOC_RU_DIR=Russian"                & set "LOC_RU_PREFIX=Russian"    & set "LOC_RU_KEY=R"
set "LOC_ES_NAME=Spanish"           & set "LOC_ES_DIR=Spanish"                & set "LOC_ES_PREFIX=Spanish"    & set "LOC_ES_KEY=S"
set "LOC_TW_NAME=Taiwanese"         & set "LOC_TW_DIR=Taiwanese"              & set "LOC_TW_PREFIX=Taiwanese"  & set "LOC_TW_KEY=T"
set "LOC_IT_NAME=Italian"           & set "LOC_IT_DIR=Italian"                & set "LOC_IT_PREFIX=Italian"    & set "LOC_IT_KEY=I"
set "LOC_PT_NAME=Portuguese"        & set "LOC_PT_DIR=Portuguese"             & set "LOC_PT_PREFIX=Portuguese" & set "LOC_PT_KEY=P"
set "LOC_BR_NAME=Brazilian"         & set "LOC_BR_DIR=Brazilian"              & set "LOC_BR_PREFIX=Brazilian"  & set "LOC_BR_KEY=B"

set "LOC_VARS="
set "LOC_KEYS="
for %%L in (%LOC_LIST%) do call :RegisterLocale %%L
for %%L in (%LOC_MENU%) do call :RegisterMenuKey %%L

rem -- the SQL files that make up one locale, in load order --
set "LOC_TABLES=CommandHelp Creature Creature_AI_Texts db_script_string Gameobject Gossip_texts Gossip_Menu_option Items Mangos_String PageText Points_of_interest Quest Script_Texts NpcText"
set "LOC_TABLE_COUNT=0"
for %%T in (%LOC_TABLES%) do set /a LOC_TABLE_COUNT+=1

set "YESNO_VARS=%CREATE_VARS% %LOAD_VARS% %UPDATE_VARS% addrealmentry updatesOnly LOCList"
exit /b 0

REM  :RegisterLocale <code>   default the flag and map its key to the flag
:RegisterLocale
if not defined loc%~1 set "loc%~1=NO"
set "LOC_VARS=%LOC_VARS% loc%~1"
call set "LKEY_%%LOC_%~1_KEY%%=loc%~1"
exit /b 0

REM  :RegisterMenuKey <code>   only keys of locales shown on screen are accepted
:RegisterMenuKey
call set "LOC_KEYS=%LOC_KEYS% %%LOC_%~1_KEY%%"
exit /b 0

REM =============================================================================
REM  EXIT PATHS
REM =============================================================================
:Quitting
echo.
CLS
echo %colWhiteDarkBlue%^                                                                              ^ %colReset%
echo %colWhiteDarkBlue%^                        Script was aborted by user !                          ^ %colReset%
echo %colWhiteDarkBlue%^                                                                              ^ %colReset%
echo.
goto :TheEnd

:Finish
echo.
echo %colReset% Script has completed !
if not "%sqlErrors%"=="0"  echo %colRedBold% - %sqlErrors% statements reported an error.%colReset%
if not "%sqlMissing%"=="0" echo %colRedBold% - %sqlMissing% SQL files could not be found.%colReset%
echo %colReset% - Please review the messages above to ensure no errors occurred.
echo.

:TheEnd
set /a exitCode=sqlErrors+sqlMissing
if /i "%pauseAtEnd%"=="YES" pause
ENDLOCAL & exit /b %exitCode%
