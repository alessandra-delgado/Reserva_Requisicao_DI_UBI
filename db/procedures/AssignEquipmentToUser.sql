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

    SET @countReserva = (SELECT COUNT(re.id_reserv)
                         FROM Res_Equip AS re,
                              Reservation AS r
                         WHERE @ide = id_equip
                           AND r.status_res IN ('Active', 'Waiting'))

    IF (@countReserva = 1)
        BEGIN
            UPDATE Res_Equip
            SET assigned_to = 1
            WHERE id_equip = @ide
            RETURN;
        END


    BEGIN
        SELECT r.time_start, r.id_reserv FROM Reservation r ORDER BY time_start ASC


        --IF ( @countEssencial = 0 )

/*
        WITH maxPrio AS (SELECT MAX(current_priority)
                         FROM User_DI u
                                  INNER JOIN Reservation r ON u.id_user = r.id_user
                                  INNER JOIN Res_Equip e ON e.id_reserv = r.id_reserv
                         WHERE e.id_equip = 5
                           AND essential = 0)*/


    END
END
