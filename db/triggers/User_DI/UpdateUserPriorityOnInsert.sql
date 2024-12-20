DROP TRIGGER IF EXISTS UpdateUserPriorityOnInsert;
GO
CREATE TRIGGER UpdateUserPriorityOnInsert
    ON TblUser_DI
    AFTER INSERT
    AS
BEGIN
    SET NOCOUNT ON;

    -- Update the priority for the inserted rows directly using a JOIN
    UPDATE TblUser_DI
    SET current_priority = up.id_priority
    FROM TblUser_DI td
             INNER JOIN inserted i ON td.id_user = i.id_user
             INNER JOIN TblUser_Priority up ON up.id_type = i.id_type;
END;
GO
