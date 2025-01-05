DROP TRIGGER IF EXISTS EquipToAvailFinalState
GO
CREATE TRIGGER EquipToAvailFinalState
ON TblReservation
AFTER UPDATE
AS
IF EXISTS (
	SELECT 1
	FROM INSERTED I
	LEFT JOIN DELETED D ON I.id_reserv = D.id_reserv
	WHERE I.status_res IN ('Cancelled','Forgotten')
)
BEGIN
    DECLARE @id_reserv VARCHAR(8) = (
		SELECT I.id_reserv
		FROM INSERTED I
		LEFT JOIN DELETED D ON I.id_reserv = D.id_reserv
		WHERE I.status_res IN ('Cancelled','Forgotten')
	)
	DECLARE @id_equip INT;

	DECLARE EquipToAvail  CURSOR FOR
	SELECT id_equip 
	FROM TblRes_Equip
	WHERE id_reserv = @id_reserv

	OPEN EquipToAvail

	FETCH NEXT FROM EquipToAvail
	INTO @id_equip

	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE TblEquipment
		SET status_equip = 'Available'
		WHERE id_equip = @id_equip

		FETCH NEXT FROM EquipToAvail
		INTO @id_equip
	END

	CLOSE EquipToAvail 
	DEALLOCATE EquipToAvail 

END

