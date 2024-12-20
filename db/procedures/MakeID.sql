DROP PROCEDURE IF EXISTS MakeID;
GO
CREATE PROCEDURE
    MakeID @GeneratedID VARCHAR(8) OUTPUT
AS
BEGIN
    DECLARE @Ano INT = YEAR(GETDATE());
    DECLARE @Sequence INT;

    -- Inicia uma transaçãosws
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Verifica se o ano atual já existe na tabela
        IF EXISTS (SELECT 1 FROM TblRes_SeqId WHERE current_year = @Ano)
            BEGIN
                -- Incrementa a sequência para o ano atual
                UPDATE TblRes_SeqId
                SET current_seq = current_seq + 1
                WHERE current_year = @Ano;

                -- Obtém o valor atualizado
                SELECT @Sequence = current_seq FROM TblRes_SeqId WHERE current_year = @Ano;
            END
        ELSE
            BEGIN
                -- Insere o ano atual com a sequência inicial de 1
                INSERT INTO TblRes_SeqId (current_year, current_seq) VALUES (@Ano, 1);
                SET @Sequence = 1;
            END

        -- Concatena o ano e a sequência com 4 dígitos
        SET @GeneratedID = CAST(@Ano AS VARCHAR(4)) + RIGHT('0000' + CAST(@Sequence AS VARCHAR(4)), 4);

        -- Confirma a transação se tudo correr bem
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Em caso de erro, faz rollback da transação
        ROLLBACK TRANSACTION;

        -- Retorna informações sobre o erro
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;