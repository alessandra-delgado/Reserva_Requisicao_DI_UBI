DROP PROCEDURE IF EXISTS MakeID;
GO
CREATE PROCEDURE
    MakeID @GeneratedID VARCHAR(8) OUTPUT
AS
BEGIN
    DECLARE @Ano INT = YEAR(GETDATE());
    DECLARE @Sequence INT;

        -- If current year already exists on the table, take it
        IF EXISTS (SELECT 1 FROM TblRes_SeqId WHERE current_year = @Ano)
            BEGIN
                UPDATE TblRes_SeqId
                SET current_seq = current_seq + 1
                WHERE current_year = @Ano;

                SELECT @Sequence = current_seq FROM TblRes_SeqId WHERE current_year = @Ano;
            END
        ELSE
            BEGIN
                -- Current year does not exist on the table yet: add it onto the table with init sequence as 1
                INSERT INTO TblRes_SeqId (current_year, current_seq) VALUES (@Ano, 1);
                SET @Sequence = 1;
            END

        -- Id generation with right shift
        SET @GeneratedID = CAST(@Ano AS VARCHAR(4)) + RIGHT('0000' + CAST(@Sequence AS VARCHAR(4)), 4);

END;