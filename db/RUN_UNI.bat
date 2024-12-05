@echo off
setlocal

REM Set the directories to search for SQL files
set "triggers=.\triggers"
set "procedures=.\procedures"

REM Execute initial SQL scripts
sqlcmd -S 192.168.100.14 -d BD_PL2_01 -U User_BD_PL2_01 -P diubi:2024!BD!PL2_01 -i ".\scripts\DropTables.sql"
sqlcmd -S 192.168.100.14 -d BD_PL2_01 -U User_BD_PL2_01 -P diubi:2024!BD!PL2_01 -i ".\scripts\CreateTables.sql"


REM Loop through each file in the procedures directory and execute them
for /R "%procedures%" %%f in (*.sql) do (
    sqlcmd -S 192.168.100.14 -d BD_PL2_01 -U User_BD_PL2_01 -P diubi:2024!BD!PL2_01 -i "%%f"
)

REM Loop through each file in the triggers directory and execute them
for /R "%triggers%" %%f in (*.sql) do (
    sqlcmd -S 192.168.100.14 -d BD_PL2_01 -U User_BD_PL2_01 -P diubi:2024!BD!PL2_01 -i "%%f"
)
REM Insert data
sqlcmd -S 192.168.100.14 -d BD_PL2_01 -U User_BD_PL2_01 -P diubi:2024!BD!PL2_01 -i ".\scripts\InsertData.sql"

echo Done running all SQL scripts.
pause
