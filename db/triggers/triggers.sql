DROP TRIGGER IF EXISTS set_prioridade_inicial;
GO
CREATE TRIGGER set_prioridade_inicial
ON utilizador
INSTEAD OF INSERT
AS
BEGIN
    -- Insere os novos registros com a prioridade corrente definida
    INSERT INTO utilizador (idu, id_tipo, prioridade_corrente, telemovel, faltas)
    SELECT 
        i.idu,
        i.id_tipo,
        tu.prioridade_base, -- COALESCE(tu.prioridade_base, 'Média'),
		i.telemovel,
		faltas = 0
    FROM inserted i
    LEFT JOIN tipo_utilizador tu ON i.id_tipo = tu.id_tipo;
END;
GO

DROP TRIGGER IF EXISTS set_initial_equipment_state;
GO
CREATE TRIGGER set_initial_equipment_state
ON equipamento
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO equipamento(nome, estado)
	SELECT
		i.nome,
		estado = 'Available'
	FROM inserted i
END;
GO

DROP TRIGGER IF EXISTS set_id_reserva;
GO
CREATE TRIGGER set_id_reserva
ON reserva
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @GeneratedID VARCHAR(8);
    DECLARE @idu VARCHAR(10);
    DECLARE @periodo_uso_inicio DATETIME;
    DECLARE @periodo_uso_fim DATETIME;
    DECLARE @estado VARCHAR(50); -- Ajuste o tipo conforme necessário

    -- Cursor para iterar sobre cada linha inserida
    DECLARE reserva_cursor CURSOR FOR 
    SELECT idu, periodo_uso_inicio, periodo_uso_fim, estado
    FROM inserted;

    OPEN reserva_cursor;
    
    FETCH NEXT FROM reserva_cursor INTO @idu, @periodo_uso_inicio, @periodo_uso_fim, @estado; 
	--METER O QUE ESTÁ NO CURSOR EM CADA VARIÁVEL DECLARADA----------------
    WHILE @@FETCH_STATUS = 0 --ENQUANTO HOUVER LINHAS PARA ITERAR
		BEGIN
			-- Chama a procedure MakeID para gerar um novo ID para cada linha
			EXEC MakeID @GeneratedID OUTPUT;

			-- Insere a linha na tabela 'reserva' com o ID gerado
			INSERT INTO reserva (idr, idu, data_registo, periodo_uso_inicio, periodo_uso_fim, estado)
			VALUES (@GeneratedID, @idu, GETDATE(), @periodo_uso_inicio, @periodo_uso_fim, @estado);

			FETCH NEXT FROM reserva_cursor INTO @idu, @periodo_uso_inicio, @periodo_uso_fim, @estado; --BUSCAR PROXIMOS VALORES
		END

    CLOSE reserva_cursor;
    DEALLOCATE reserva_cursor; --FREE DO CURSOR (POTERO)
END;
GO
