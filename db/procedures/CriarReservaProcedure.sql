--procedura para criar reservas que recebe os parametros da aplicação python

CREATE PROCEDURE CriarReserva
	@IDutilizador VARCHAR(10),
	@inicio DATETIME,
	@fim DATETIME,
	@ide INT,
	@essencial VARCHAR(3)
AS
BEGIN
	DECLARE @idr VARCHAR(8);
	DECLARE @temp_idr TABLE (idr VARCHAR(8));
	
	INSERT INTO Reserva(idu, data_registo, periodo_uso_inicio, periodo_uso_fim)
	OUTPUT INSERTED.idr INTO @temp_idr
	VALUES (@IDutilizador, GETDATE(), @inicio, @fim)
	SELECT @idr = idr FROM @temp_idr

	INSERT INTO ReservaPossuiEquipamento(idr, ide, essencial) 
	VALUES (@idr, @ide, @essencial)

END