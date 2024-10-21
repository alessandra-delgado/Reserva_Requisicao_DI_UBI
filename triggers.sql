--drop trigger set_prioridade_inicial

CREATE TRIGGER set_prioridade_inicial
ON utilizador
INSTEAD OF INSERT
AS
BEGIN
    -- Insere os novos registros com a prioridade corrente definida
    INSERT INTO utilizador (idu, id_tipo, prioridade_corrente)
    SELECT 
        i.idu,
        i.id_tipo,
        tu.prioridade_base -- COALESCE(tu.prioridade_base, 'Média')
    FROM inserted i
    LEFT JOIN tipo_utilizador tu ON i.id_tipo = tu.id_tipo;
END;
GO