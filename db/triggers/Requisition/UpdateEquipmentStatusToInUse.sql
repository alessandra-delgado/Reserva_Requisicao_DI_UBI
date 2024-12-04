DROP TRIGGER IF EXISTS UpdateEquipmentStatusToInUse;
GO
CREATE TRIGGER UpdateEquipmentStatusToInUse
    ON Req_Equip
    AFTER INSERT
    AS
BEGIN
    DECLARE @id_equip INT;
    DECLARE @id_req INT;

    DECLARE equipment_fetch CURSOR FOR
        SELECT id_equip, id_req FROM inserted

    OPEN equipment_fetch;

    FETCH NEXT FROM equipment_fetch INTO @id_equip, @id_req
    WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE Equipments SET status_equip = 'inUse' WHERE id_equip = @id_equip
            FETCH NEXT FROM equipment_fetch INTO @id_equip, @id_req
        END
    CLOSE equipment_fetch;
    DEALLOCATE equipment_fetch;
END;
GO