DROP PROCEDURE IF EXISTS AssignedTo
CREATE PROCEDURE AssignedTo
	@ide VARCHAR(10)
AS
BEGIN
	DECLARE @countReserva INT;
	DECLARE @maxPrio INT;
	DECLARE @countEssencial INT;
	
	select u.current_priority, r.status_res, re.essential from User_DI u, Reservations r, Res_Equip re
	where u.id_user = r.id_user and r.re

	SET @countReserva = (
		SELECT COUNT(idr)
		FROM ReservaPossuiEquipamento
		WHERE @ide = ide 
	)

	IF ( @countReserva = 1 )
	BEGIN
		UPDATE ReservaPossuiEquipamento
		SET assigned_to = 'Sim'
		WHERE ide = @ide
	END
	
	IF ( @countReserva > 1 )
	BEGIN
		SET @countEssencial = (
			SELECT COUNT(essencial)
			FROM ReservaPossuiEquipamento
			WHERE @ide = ide 
		)

		--IF ( @countEssencial = 0 )
	

		WITH maxPrio AS (
			SELECT MAX(prioridade_corrente)
			FROM Utilizador u 
			INNER JOIN Reserva r ON u.idu = r.idu
			INNER JOIN ReservaPossuiEquipamento e ON e.idr = r.idr
			WHERE e.ide = 5
			AND essencial = 'N'
		)


	END
END