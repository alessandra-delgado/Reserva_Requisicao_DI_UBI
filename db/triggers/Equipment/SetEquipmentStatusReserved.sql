drop trigger if EXISTS SetEquipmentStatusReserved;
GO
CREATE TRIGGER SetEquipmentStatusReserved
ON Equipments
AFTER UPDATE
AS
BEGIN 
DECLARE @id_equip INT;
	IF EXISTS (
		SELECT 1
		FROM INSERTED
		JOIN DELETED ON INSERTED.id_equip = DELETED.id_equip
		WHERE INSERTED.status_equip = 'Available'
		AND DELETED.status_equip in ('InUse', 'Reserved')
	)
	BEGIN
		SET @id_equip = (
			SELECT i.id_equip
			FROM INSERTED i
			JOIN DELETED ON i.id_equip = DELETED.id_equip
			WHERE i.status_equip = 'Available'
			AND DELETED.status_equip in ('InUse', 'Reserved')
		)
		EXEC Assigned_To @id_equip
	END
END
