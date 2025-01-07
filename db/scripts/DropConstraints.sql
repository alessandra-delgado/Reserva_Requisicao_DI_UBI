DECLARE @sql NVARCHAR(MAX);

-- Initialize SQL string
SET @sql = '';

-- Generate DROP CONSTRAINT statements for CHECK constraints
SELECT @sql = @sql + 'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + '.'
    + QUOTENAME(OBJECT_NAME(parent_object_id))
    + ' DROP CONSTRAINT ' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.check_constraints;

-- Execute the dynamically generated SQL
EXEC sp_executesql @sql;
