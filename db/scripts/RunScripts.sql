--:setvar BasePath "C:\Users\yana\Desktop\base_de_dados_git\Reserva_Requisicao_DI_UBI\db\scripts"
:setvar BasePath ".\scripts"

PRINT 'Dropping all tables...';
:r $(BasePath)\DropTables.sql

PRINT 'Creating tables...';
:r $(BasePath)\CreateTables.sql

PRINT 'Inserting data...';
:r $(BasePath)\InsertData.sql
