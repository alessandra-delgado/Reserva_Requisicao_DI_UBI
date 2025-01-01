DROP PROCEDURE IF EXISTS AssignEquipmentToUser;
GO
CREATE PROCEDURE AssignEquipmentToUser @ide INT
AS
BEGIN
    DECLARE @idr VARCHAR(8);

    SET @idr = (
        (SELECT TOP 1 re.id_reserv
         FROM TblUser_DI u,
              TblReservation r,
              TblRes_Equip re
         WHERE u.id_user = r.id_user
           AND re.id_reserv = r.id_reserv
           AND r.status_res IN ('Waiting', 'Active')
           AND re.id_equip = @ide
         ORDER BY r.time_start ASC, u.current_priority DESC, re.essential DESC, r.reg_date ASC))

    UPDATE TblRes_Equip
    SET assigned_to = 0
    WHERE id_equip = @ide


    UPDATE TblRes_Equip
    SET assigned_to = 1
    WHERE id_reserv = @idr
      AND id_equip = @ide

    UPDATE TblEquipment
    SET status_equip = 'Reserved'
    WHERE id_equip = @ide
END
