DROP TRIGGER IF EXISTS SetReservationID;
GO
CREATE TRIGGER SetReservationID
    ON TblUser_DI
    AFTER INSERT
    AS
BEGIN
    DECLARE @id VARCHAR(10)
    DECLARE @type VARCHAR(2)
    DECLARE @user VARCHAR(10)


    SET @user = (SELECT id_user FROM inserted)
    SET @type = (SELECT id_type FROM inserted)
    SET @id = CAST(@type AS VARCHAR(2)) + '_' + CAST(@user AS VARCHAR(7));

    IF NOT EXISTS(SELECT 1
                  FROM TblUser_DI
                  WHERE id_user LIKE @id)
        BEGIN
            UPDATE TblUser_DI
            SET id_user = @id
            WHERE id_user = @user
        END
END;
GO
-- change this trigger into python verification if possible



