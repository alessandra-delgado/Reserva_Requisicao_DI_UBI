DROP TRIGGER IF EXISTS SetEquipmentStatusReserved;
GO
CREATE TRIGGER SetEquipmentStatusReserved
    ON TblEquipment
    AFTER UPDATE
    AS
BEGIN
    DECLARE @id_equip INT;
    IF EXISTS (SELECT 1
               FROM INSERTED
               JOIN DELETED ON INSERTED.id_equip = DELETED.id_equip
               WHERE INSERTED.status_equip = 'Available'
                 AND DELETED.status_equip IN ('InUse', 'Reserved'))
        BEGIN
            SET @id_equip = (SELECT i.id_equip
                             FROM INSERTED i
                                      JOIN DELETED ON i.id_equip = DELETED.id_equip
                             WHERE i.status_equip = 'Available'
                               AND DELETED.status_equip IN ('InUse', 'Reserved'))
			IF EXISTS (
				SELECT 1 
				FROM TblRes_Equip re, TblReservation r
				WHERE re.id_reserv = r.id_reserv
				AND r.status_res IN ('Active', 'Waiting')
				AND re.id_equip = @id_equip
			)
			BEGIN
				EXEC AssignEquipmentToUser @id_equip
			END
        END
END
