DROP PROCEDURE IF EXISTS MakeID;
CREATE PROCEDURE MakeID @GeneratedID VARCHAR(8) OUTPUT
AS
BEGIN
    DECLARE @Ano INT = YEAR(GETDATE());
    DECLARE @Sequence INT;

    -- Inicia uma transação
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Verifica se o ano atual já existe na tabela
        IF EXISTS (SELECT 1 FROM ReservaSequenceId WHERE Ano = @Ano)
        BEGIN
            -- Incrementa a sequência para o ano atual
            UPDATE ReservaSequenceId
            SET CurrentSequence = CurrentSequence + 1
            WHERE Ano = @Ano;

            -- Obtém o valor atualizado
            SELECT @Sequence = CurrentSequence FROM ReservaSequenceId WHERE Ano = @Ano;
        END
        ELSE
        BEGIN
            -- Insere o ano atual com a sequência inicial de 1
            INSERT INTO ReservaSequenceId (Ano, CurrentSequence) VALUES (@Ano, 1);
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

drop procedure if exists ResetSequence
CREATE PROCEDURE ResetSequence
AS
BEGIN
    -- Atualiza a sequência de todos os anos para 1
    UPDATE ReservaSequenceId
    SET CurrentSequence = 1;
END;


--------------------------------------------------------------------------
drop procedure if exists Reserve2Requisition;
create procedure Reserve2Requisition @idu varchar(10), @idr varchar(8), @periodo_uso_inicio DATETIME, @periodo_uso_fim DATETIME
as
begin
	insert into Requisicao (idu, periodo_uso_inicio, periodo_uso_fim, estado)
	values (@idu, @periodo_uso_inicio, @periodo_uso_fim, 'Active');
	INSERT INTO RequisicaoPossuiEquipamento(re.ide, idq)
	SELECT re.ide, SCOPE_IDENTITY() as idq from ReservaPossuiEquipamento as re where re.idr = @idr and re.assigned_to like 'T' 

end;