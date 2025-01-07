@echo off
setlocal

REM Set the directories to search for SQL files
set "triggers=.\triggers"
set "procedures=.\procedures"
set "address=localhost"
set "database=teste_di"
set "user=sa"
set "password=sa"

REM Execute initial SQL scripts
sqlcmd -S "%address%" -d "%database%" -U "%user%" -P "%password%" -i ".\scripts\DropConstraints.sql"
sqlcmd -S "%address%" -d "%database%" -U "%user%" -P "%password%" -i ".\scripts\DropTables.sql"
sqlcmd -S "%address%" -d "%database%" -U "%user%" -P "%password%" -i ".\scripts\CreateTables.sql"

REM Loop through each file in the procedures directory and execute them
for /R "%procedures%" %%f in (*.sql) do (
    sqlcmd -S "%address%" -d "%database%" -U "%user%" -P "%password%" -i "%%f"
)

REM Loop through each file in the triggers directory and execute them
for /R "%triggers%" %%f in (*.sql) do (
    sqlcmd -S "%address%" -d "%database%" -U "%user%" -P "%password%" -i "%%f"
)

sqlcmd -S "%address%" -d "%database%" -U "%user%" -P "%password%" -i ".\scripts\SetTriggerOrder.sql"
sqlcmd -S "%address%" -d "%database%" -U "%user%" -P "%password%" -i ".\scripts\InsertData.sql"
sqlcmd -S "%address%" -d "%database%" -U "%user%" -P "%password%" -i ".\scripts\CreateViews.sql"

echo Done running all SQL scripts.
pause
