DROP PROCEDURE IF EXISTS AssignEquipmentToUser;
GO
CREATE PROCEDURE AssignEquipmentToUser @ide VARCHAR(10)
AS
BEGIN
    DECLARE @IDR INT;

    SELECT u.current_priority, r.status_res, re.essential, re.assigned_to, r.id_reserv
    INTO #temp_results
    FROM User_DI u,
         Reservation r,
         Res_Equip re
    WHERE u.id_user = r.id_user
      AND re.id_reserv = r.id_reserv
      AND r.status_res IN ('Waiting', 'Active')
    ORDER BY R.time_start DESC, U.current_priority DESC, RE.essential DESC, R.reg_date DESC


    SET @IDR = (SELECT TOP 1 id_reserv FROM #temp_results)
    UPDATE Res_Equip
        SET assigned_to = 1
    WHERE id_reserv = @IDR
      AND id_equip = @ide

END
