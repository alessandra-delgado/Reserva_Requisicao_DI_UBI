DROP TRIGGER IF EXISTS ReturnEquipmentOLD
GO
CREATE TRIGGER ReturnEquipmentOLD
ON Requisition
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON

    UPDATE Equipments
    SET status_equip = 'Available'
    FROM Equipments
    INNER JOIN Req_Equip rq ON rq.id_equip = Equipments.id_equip
    INNER JOIN Requisition r ON r.id_req = rq.id_req
    WHERE
        r.status_req = 'Closed' AND e.status_equip = 'In Use'
END;