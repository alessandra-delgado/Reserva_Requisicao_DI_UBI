--:setvar BasePath "C:\Users\yana\Desktop\base_de_dados_git\Reserva_Requisicao_DI_UBI\db\scripts"
:SETVAR BasePath ".\scripts"

PRINT 'Dropping all tables...';
:R $(BasePath)\DropTables.sql

PRINT 'Creating tables...';
:R $(BasePath)\CreateTables.sql

PRINT 'Inserting data...';
:R $(BasePath)\InsertData.sql
