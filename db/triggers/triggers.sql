DROP TRIGGER IF EXISTS set_prioridade_inicial;
GO
CREATE TRIGGER set_prioridade_inicial
ON utilizador
INSTEAD OF INSERT
AS
BEGIN
    -- Insere os novos registros com a prioridade corrente definida
    INSERT INTO utilizador (id_user, id_tipo, prioridade_corrente, telemovel, faltas)
    SELECT 
        i.id_user,
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
ON Equipments
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO Equipments(nome, status_res)
	SELECT
		i.nome,
		status_res = 'Available'
	FROM inserted i
END;
GO
-- ^^^^^^^^^^^^^^^^^^^^^TO DELETE -> DEFAULT!!!!!!!

DROP TRIGGER IF EXISTS set_reserv_id;
GO
CREATE TRIGGER set_reserv_id
ON Reservations
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @GeneratedID VARCHAR(8);
    DECLARE @id_user VARCHAR(10);
    DECLARE @time_start DATETIME;
    DECLARE @time_end DATETIME;
    DECLARE @status_res VARCHAR(50); -- Ajuste o tipo conforme necessário

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
			INSERT INTO Reservations (id_reserv, id_user, data_registo, time_start, time_end, status_res)
			VALUES (@GeneratedID, @id_user, GETDATE(), @time_start, @time_end, @status_res);

			FETCH NEXT FROM set_id_at INTO @id_user, @time_start, @time_end, @status_res; --BUSCAR PROXIMOS VALORES
		END

    CLOSE set_id_at;
    DEALLOCATE set_id_at; --FREE DO CURSOR (POTERO)
END;
GO


drop trigger if exists Reservation2Satisfied;
go
create trigger Reservation2Satisfied
on Reservations
after update
as
if (update (status_res))
begin
		declare @id_user varchar(10);
		declare @id_reserv varchar(8);
		declare @time_start DATETIME;
		declare @time_end DATETIME;

		declare for_satisfied cursor for
		select id_user, id_reserv, time_start, time_end, count(id_reserv) as equips from inserted
		where status_res like 'Satisfied'

		open for_satisfied;

		fetch next from for_satisfied into @id_user, @id_reserv, @time_start, @time_end, @equips
		while @@FETCH_STATUS = 0
			begin
				exec Reserve2Requisition @id_user, @id_reserv, @time_start, @time_end, @equips
				fetch next from for_satisfied into @id_user, @id_reserv, @time_start, @time_end, @equips
			end
		close for_satisfied;
		deallocate for_satisfied;
end;
go


drop trigger if exists EquipmentInUse;
go
create trigger EquipmentInUse
on Req_Equip
after insert
as
begin
	declare @id_equip int;
	declare @id_req int;

	declare equipment_fetch cursor for
	select id_equip, id_req from inserted

	open equipment_fetch;

	fetch next from equipment_fetch into @id_equip, @id_req
	while @@FETCH_STATUS = 0
		begin
			update Equipments set status_equip = 'inUse' where id_equip = @id_equip
			fetch next from equipment_fetch into @id_equip, @id_req
		end
	close equipment_fetch;
	deallocate equipment_fetch;
end;
go