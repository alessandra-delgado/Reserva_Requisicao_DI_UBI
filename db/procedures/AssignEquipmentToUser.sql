DROP PROCEDURE IF EXISTS AssignEquipmentToUser;
GO
CREATE PROCEDURE AssignEquipmentToUser @ide VARCHAR(10)
AS
BEGIN
    DECLARE @countReserva INT;
    DECLARE @maxPrio INT;
    DECLARE @countEssencial INT;

    SELECT u.current_priority, r.status_res, re.essential, re.assigned_to
    INTO #temp_results
    FROM User_DI u,
         Reservation r,
         Res_Equip re
    WHERE u.id_user = r.id_user
      AND re.id_reserv = r.id_reserv
      AND r.status_res IN ('Waiting', 'Active')


END
