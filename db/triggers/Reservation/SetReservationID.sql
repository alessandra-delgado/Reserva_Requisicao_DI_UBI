DROP TRIGGER IF EXISTS SetReservationID;
GO
CREATE TRIGGER SetReservationID
    ON Reservation
    INSTEAD OF INSERT
    AS
BEGIN
    DECLARE @GeneratedID VARCHAR(8);
    DECLARE @id_user VARCHAR(10);
    DECLARE @time_start DATETIME;
    DECLARE @time_end DATETIME;
    DECLARE @status_res VARCHAR(50);

    -- Cursor para iterar sobre cada linha inserida
    DECLARE set_id_at CURSOR FOR
        SELECT id_user, time_start, time_end, status_res
        FROM inserted;

    OPEN set_id_at;

    FETCH NEXT FROM set_id_at INTO @id_user, @time_start, @time_end, @status_res;
    --METER O QUE ESTÁ NO CURSOR EM CADA VARIÁVEL DECLARADA----------------
    WHILE @@FETCH_STATUS = 0 --ENQUANTO HOUVER LINHAS PARA ITERAR
        BEGIN
            -- Chama a procedure MakeID para gerar um novo ID para cada linha
            EXEC MakeID @GeneratedID OUTPUT;

            -- Insere a linha na tabela 'reserva' com o ID gerado
            INSERT INTO Reservation (id_reserv, id_user, reg_date, time_start, time_end, status_res)
            VALUES (@GeneratedID, @id_user, GETDATE(), @time_start, @time_end, @status_res);

            FETCH NEXT FROM set_id_at INTO @id_user, @time_start, @time_end, @status_res; --BUSCAR PROXIMOS VALORES
        END

    CLOSE set_id_at;
    DEALLOCATE set_id_at; --FREE DO CURSOR (POTERO)
END;
GO

-- fixme: triggers não devem ter transações...



