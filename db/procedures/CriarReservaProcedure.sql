--procedura para criar reservas que recebe os parametros da aplicação python

CREATE PROCEDURE CriarReserva
--parametros de entrada da funcao
	@IDutilizador VARCHAR(10),
	@inicio DATETIME,
	@fim DATETIME,
	@ide INT,
	@essencial VARCHAR(3),
	@inUse VARCHAR(25) OUTPUT
AS
BEGIN
	DECLARE @idr VARCHAR(8);
	DECLARE @estado_e VARCHAR(10) = (SELECT estado FROM equipamento WHERE ide = @ide);
	DECLARE @temp_idr TABLE (idr VARCHAR(8));
	DECLARE @prio_outro INT;
	DECLARE @prio_nossa INT = (SELECT prioridade_corrente FROM Utilizador WHERE idu = @IDutilizador);
	DECLARE @fim_outro DATETIME = (SELECT r.periodo_uso_fim FROM Utilizador u, ReservaPossuiEquipamento e, Reserva r WHERE e.ide = @ide AND r.idu = u.idu AND r.idr = e.idr AND assigned_to = 'Sim')
	--ide pode corresponder a varios por isso por tambem assigned_to = sim
	--QUANDO ESTIVER AVAILABLE CRIAR A RESERVA
	IF (@estado_e = 'Available')
	BEGIN
		--inserir os dados recebidos a tabela reserva criando uma nova reserva
		INSERT INTO Reserva(idu, data_registo, periodo_uso_inicio, periodo_uso_fim, estado)
		--guarda o valor gerado pelo trigger MakeID numa tabela temporária
		OUTPUT INSERTED.idr INTO @temp_idr
		VALUES (@IDutilizador, GETDATE(), @inicio, @fim, 'Active')

		--guardamos o valor do idr guardado na temp_idr para uma variavel idr
		SELECT @idr = idr FROM @temp_idr

		--inserir os dados da reserva recem criada na tabela que conecta a reserva ao equipamento
		INSERT INTO ReservaPossuiEquipamento(idr, ide, essencial, assigned_to) 
		VALUES (@idr, @ide, @essencial, 'Sim')

		--atualizar a tabela do equipamento para que mostre que o mesmo se encontra reservado
		UPDATE Equipamento
		SET estado = 'Reserved'
		WHERE ide = @ide
	END
	ELSE
	BEGIN
		--SE ESTIVER RESERVED VER SE A PRIORIDADE INTERFERE
		IF (@estado_e = 'Reserved')
		BEGIN 
			--antes de inserir os dados verificar se a prioridade nos atribui o equipamento ou nao
			SET @prio_outro = (SELECT u.prioridade_corrente FROM Utilizador u, ReservaPossuiEquipamento e, Reserva r WHERE e.ide = @ide AND r.idu = u.idu AND r.idr = e.idr AND assigned_to = 'Sim')
			DECLARE @idu_outro VARCHAR(10) = (SELECT u.idu FROM Utilizador u, ReservaPossuiEquipamento e, Reserva r WHERE e.ide = @ide AND r.idu = u.idu AND r.idr = e.idr AND assigned_to = 'Sim')
			DECLARE @idr_outro VARCHAR(8) = (SELECT idr FROM Reserva r WHERE idu = @idu_outro)

			IF (@prio_outro < @prio_nossa)
			BEGIN
			--NOSSA RESERVA
				--inserir os dados recebidos a tabela reserva criando uma nova reserva
				INSERT INTO Reserva(idu, data_registo, periodo_uso_inicio, periodo_uso_fim, estado)
				--guarda o valor gerado pelo trigger MakeID numa tabela temporária
				OUTPUT INSERTED.idr INTO @temp_idr
				VALUES (@IDutilizador, GETDATE(), @inicio, @fim, 'Active')

				--guardamos o valor do idr guardado na temp_idr para uma variavel idr
				SELECT @idr = idr FROM @temp_idr

				--inserir os dados da reserva recem criada na tabela que conecta a reserva ao equipamento
				INSERT INTO ReservaPossuiEquipamento(idr, ide, essencial, assigned_to) 
				VALUES (@idr, @ide, @essencial, 'Sim')
			
			--OUTRA RESERVA
				--atualizar a tabela da reserva do uti que tinha originalmente o equipamento para waiting
				UPDATE Reserva
				SET estado = 'Waiting'
				WHERE idr = @idr_outro

				--alterar o assigned_to de sim para nao pois agora o uti atual é que tem o equi
				UPDATE ReservaPossuiEquipamento
				SET assigned_to = 'Nao'
				WHERE idr = @idr_outro
			END
			ELSE
			BEGIN
			--quando a nossa prioridade é mais baixa
			--NOSSA RESERVA
				--inserir os dados recebidos a tabela reserva criando uma nova reserva
				INSERT INTO Reserva(idu, data_registo, periodo_uso_inicio, periodo_uso_fim, estado)
				--guarda o valor gerado pelo trigger MakeID numa tabela temporária
				OUTPUT INSERTED.idr INTO @temp_idr
				VALUES (@IDutilizador, GETDATE(), @inicio, @fim, 'Waiting')

				--guardamos o valor do idr guardado na temp_idr para uma variavel idr
				SELECT @idr = idr FROM @temp_idr

				--inserir os dados da reserva recem criada na tabela que conecta a reserva ao equipamento
				INSERT INTO ReservaPossuiEquipamento(idr, ide, essencial, assigned_to) 
				VALUES (@idr, @ide, @essencial, 'Nao')
			END
		END
		ELSE
		BEGIN
		--VER SE O PERIODO DE USO INTERFERE
			--estado inUse
			--se o periodo de uso da nossa reserva nunca for possivel
			IF ( @fim_outro < @fim) --entao a reserva não acontece
			BEGIN
				SET @inUse = 'A reserva atual não é possível.';
			END
		END
	END
END