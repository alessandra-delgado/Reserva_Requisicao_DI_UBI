@echo off
setlocal

REM Set the directories to search for SQL files
set "triggers=.\triggers"
set "procedures=.\procedures"

REM Execute initial SQL scripts
sqlcmd -S localhost -d teste_di -U sa -P sa -i ".\scripts\DropConstraints.sql"
sqlcmd -S localhost -d teste_di -U sa -P sa -i ".\scripts\DropTables.sql"
sqlcmd -S localhost -d teste_di -U sa -P sa -i ".\scripts\CreateTables.sql"


REM Loop through each file in the procedures directory and execute them
for /R "%procedures%" %%f in (*.sql) do (
    sqlcmd -S localhost -d teste_di -U sa -P sa -i "%%f"
)

REM Loop through each file in the triggers directory and execute them
for /R "%triggers%" %%f in (*.sql) do (
    sqlcmd -S localhost -d teste_di -U sa -P sa -i "%%f"
)

rem sqlcmd -S localhost -d teste_di -U sa -P sa -i ".\scripts\InsertData.sql"

echo Done running all SQL scripts.
pause
