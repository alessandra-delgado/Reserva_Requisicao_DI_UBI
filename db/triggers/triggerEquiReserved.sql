CREATE TRIGGER AvailToReservedEqui
ON Equipamento
AFTER UPDATE
AS
BEGIN 
	IF EXISTS (
		SELECT 1
		FROM INSERTED
		JOIN DELETED ON INSERTED.ide = DELETED.ide
		WHERE INSERTED.estado = 'Available'
		AND DELETED.estado = 'InUse'
	)
	BEGIN
		UPDATE Equipamento
		SET	Equipamento.estado = 'Reserved'
		WHERE ide IN (
			SELECT e.ide
			FROM ReservaPossuiEquipamento e
			JOIN Reserva r on r.idr = e.idr
			WHERE estado IN ('Active', 'Waiting')
			GROUP BY e.ide
			HAVING COUNT(e.idr) > 1
		)
	END
END
