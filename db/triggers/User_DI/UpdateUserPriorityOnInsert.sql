DROP TRIGGER IF EXISTS UpdateUserPriorityOnInsert;
GO
CREATE TRIGGER UpdateUserPriorityOnInsert
    ON TblUser_DI
    AFTER INSERT
    AS
BEGIN
    SET NOCOUNT ON
    DECLARE @USER_ID VARCHAR(10)
    DECLARE @TYPE_ID VARCHAR(2)

    DECLARE SET_PRIORITY CURSOR FOR
        SELECT i.id_user, i.id_type
        FROM inserted i;

    OPEN SET_PRIORITY;

    FETCH NEXT FROM SET_PRIORITY INTO @USER_ID, @TYPE_ID

    WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE TblUser_DI
            SET current_priority = up.id_priority
            FROM TblUser_Priority up
            WHERE id_user = @USER_ID
            AND up.id_type = @TYPE_ID
            FETCH NEXT FROM SET_PRIORITY INTO @USER_ID, @TYPE_ID
        END
END