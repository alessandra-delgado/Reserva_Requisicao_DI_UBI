CREATE TRIGGER AvailToReservedEqui
ON Equipments
AFTER UPDATE
AS
BEGIN 
	IF EXISTS (
		SELECT 1
		FROM INSERTED
		JOIN DELETED ON INSERTED.id_equip = DELETED.id_equip
		WHERE INSERTED.status_equip = 'Available'
		AND DELETED.status_equip = 'InUse'
	)
	BEGIN
		UPDATE Equipments
		SET	Equipments.status_equip = 'Reserved'
		WHERE id_equip IN (
			SELECT e.id_equip
			FROM Res_Equip e
			JOIN Reservations r on r.id_reserv = e.id_reserv
			WHERE status_equip IN ('Active', 'Waiting')
			GROUP BY e.id_equip
			HAVING COUNT(e.id_reserv) > 1
		)
	END
END
