-- Step 1: Drop all foreign key constraints dynamically
DECLARE @sql NVARCHAR(MAX);

-- Generate DROP CONSTRAINT statements for all foreign keys
SELECT @sql = STRING_AGG('ALTER TABLE ' + QUOTENAME(OBJECT_NAME(parent_object_id)) +
                         ' DROP CONSTRAINT ' + QUOTENAME(name), '; ') WITHIN GROUP (ORDER BY name)
FROM sys.foreign_keys;

-- Execute the generated SQL to drop foreign keys
EXEC sp_executesql @sql;

-- Step 2: Drop all tables dynamically
SET @sql = '';

-- Generate DROP TABLE statements for all tables
SELECT @sql = STRING_AGG('DROP TABLE ' + QUOTENAME(name), '; ') WITHIN GROUP (ORDER BY name)
FROM sys.objects
WHERE type = 'U';
-- Only user tables

-- Execute the generated SQL to drop all tables
EXEC sp_executesql @sql;
