:setvar BasePath "C:\Users\yana\Desktop\base_de_dados_git\Reserva_Requisicao_DI_UBI\db\scripts"

PRINT 'Dropping all tables...';
:r $(BasePath)\drop_all.sql

PRINT 'Creating tables...';
:r $(BasePath)\create_tables.sql

PRINT 'Inserting data...';
:r $(BasePath)\insert_data.sql
