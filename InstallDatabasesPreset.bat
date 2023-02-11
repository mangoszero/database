@echo off

REM -- To use this file, uncomment, change, or add any lines that you want. --
REM -- and run this file once those changes are completed.

REM set quickExecute=YES
IF NOT DEFINED quickExecute set quickExecute=NO

REM set skipPrintOS=YES
REM set skipChoices=YES
REM set skipConnection=YES
REM set DEBUG=YES

REM set dbClientHome=C:\Program Files\MySQL\MySQL Server 8.0\bin
REM set dbClientHome=C:\Program Files\MariaDB\bin
REM set dbClientName=mysql.exe
REM set dbClientName=mariadb.exe
REM set newuser=mangos
REM set user=root
REM set pass=mangos
REM set newpass=mangos
REM set port=3306
REM set wdb=mangos0
REM set wdborig=mangos0
REM set cdb=character0
REM set cdborig=character0
REM set rdb=realmd
REM set rdborig=realmd
REM set dbClientConnectionOptions=--login-path=local
REM set dbClientOtherOptions=-q -v
REM set dbClientConnectionString=

REM -- Specific settings to use after considering the defaults --
REM set createrealmDB=NO
REM set loadrealmDB=NO
REM set RDBUpdate=NO
REM set createMangosUser=NO

REM -- This line helps use default settings. --
GOTO Ready:

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

          set DBType=POPULATED
        set activity=N

           set locKO=NO
           set locFR=NO
           set locDE=NO
           set locCH=NO
           set locTW=NO
           set locES=NO
           set locMX=NO
           set locRU=NO
           set locIT=NO
           set locPT=NO
           set locBR=NO

:Ready
IF %quickExecute% == YES GOTO Execute:

set /p ready="Ready? (Y/<*>): "
IF NOT DEFINED ready set ready=N
if %ready% == Y GOTO EXECUTE:
if %ready% == y GOTO EXECUTE:

GOTO :EOF

:Execute
InstallDatabases.bat
pause
