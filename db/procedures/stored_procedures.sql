--temporary
drop procedure if exists ResetSequence
CREATE PROCEDURE ResetSequence
AS
BEGIN
    -- Atualiza a sequência de todos os anos para 1
    UPDATE ReservaSequenceId
    SET CurrentSequence = 1;
END;