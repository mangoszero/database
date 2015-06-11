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
echo    ^|  \/  ^|__ _^| \^| ^|/ __^|/ _ \/ __^|   World Database                                      
echo    ^| ^|\/^| / _` ^| .` ^| (_ ^| (_) \__ \
echo    ^|_^|  ^|_\__,_^|_^|\_^|\___^|\___/^|___/   Dumper v0.01
echo.
echo _____________________________________________________________
echo.
echo             Website / Forum / Wiki: https://getmangos.eu         
echo _____________________________________________________________
echo.
SET SERVER=localhost
md _full_db
SET TABLENAME=areatrigger_involvedrelation
echo Dumping.... %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=areatrigger_tavern
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=areatrigger_teleport
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=battleground_events
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=battleground_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=battlemaster_entry
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=command
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=conditions
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_addon
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_ai_scripts
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_ai_summons
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_ai_texts
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_battleground
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_equip_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_equip_template_raw
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_involvedrelation
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_item_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_linking
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_linking_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_loot_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_model_info
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=creature_model_race
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_movement
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_movement_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_onkill_reputation
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_questrelation
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_template_addon
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_template_classlevelstats
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=creature_template_spells
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=custom_texts
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=db_script_string
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=db_version
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbdocsfields
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbdocsfields_localised
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbdocsprogressquests
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbdocslanguage
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbdocstable
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbdocstable_localised
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbdocssubtables
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbdocssubtables_localised
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbscripts_on_creature_death
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbscripts_on_creature_movement
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbscripts_on_event
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbscripts_on_go_use
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbscripts_on_go_template_use
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbscripts_on_gossip
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbscripts_on_quest_end
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbscripts_on_quest_start
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=dbscripts_on_spell
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=disenchant_loot_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=exploration_basexp
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=fishing_loot_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=game_event
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=game_event_creature
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=game_event_creature_data
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=game_event_gameobject
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=game_event_mail
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=game_event_quest
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=game_graveyard_zone
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=game_tele
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=game_weather
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=gameobject
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=gameobject_battleground
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=gameobject_involvedrelation
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=gameobject_loot_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=gameobject_questrelation
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=gameobject_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=gossip_menu
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=gossip_menu_option
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=gossip_texts
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=instance_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=item_enchantment_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=item_loot_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=item_required_target
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=item_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=locales_creature
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=locales_gameobject
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=locales_gossip_menu_option
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=locales_item
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=locales_npc_text
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=locales_page_text
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=locales_points_of_interest
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=locales_quest
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=mail_level_reward
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=mail_loot_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=mangos_string
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=npc_gossip
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=npc_text
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=npc_trainer
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=npc_trainer_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=npc_vendor
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=npc_vendor_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=page_text
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pet_levelstats
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pet_name_generation
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=petcreateinfo_spell
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pickpocketing_loot_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=player_classlevelstats
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=player_levelstats
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=player_xp_for_level
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=playercreateinfo
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=playercreateinfo_action
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=playercreateinfo_item
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=playercreateinfo_spell
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=points_of_interest
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pool_creature
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pool_creature_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pool_gameobject
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pool_gameobject_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pool_pool
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pool_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=prospecting_loot_template
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pvpstats_battlegrounds
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=pvpstats_players
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=quest_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=reference_loot_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=reputation_reward_rate
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=reputation_spillover_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=reserved_name
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=script_texts
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=script_waypoint
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=scripted_areatrigger
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=scripted_event
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=sd2_db_version
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=skill_discovery_template
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=skill_extra_item_template
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=skill_fishing_base_level
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=skinning_loot_template
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_affect
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_area
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_bonus_data
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_chain
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_elixir
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_facing
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_learn_spell
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_linked
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_pet_auras
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_proc_event
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_proc_item_enchant
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_script_target
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_target_position
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=skill_extra_item_template
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=spell_threat
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=spell_template
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

SET TABLENAME=transports
echo             %TABLENAME%
echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

REM SET TABLENAME=world_template
REM echo             %TABLENAME%
REM echo -- ---------------------------------------- >  _full_db\%TABLENAME%.sql
REM echo -- --        CLEAR DOWN THE TABLE        -- >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM echo TRUNCATE TABLE `%TABLENAME%`; >>  _full_db\%TABLENAME%.sql
REM echo -- ---------------------------------------- >>  _full_db\%TABLENAME%.sql
REM mysqldump -Q -c -e -q --add-drop-table=false --no-create-info -u%user% -p%pass% -h %svr% %wdb% %TABLENAME% >>  _full_db\%TABLENAME%.sql

echo _____________________________________________________________
echo.
echo                     Database Dump Complete         
echo _____________________________________________________________
echo.

pause