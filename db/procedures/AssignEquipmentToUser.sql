DROP PROCEDURE IF EXISTS AssignEquipmentToUser;
GO
CREATE PROCEDURE AssignEquipmentToUser @ide VARCHAR(10)
AS
BEGIN
    DECLARE @countReserva INT;
    DECLARE @maxPrio INT;
    DECLARE @countEssencial INT;

    select u.current_priority, r.status_res, re.essential
    from User_DI u,
         Reservation r,
         Res_Equip re
    where u.id_user = r.id_user -- todo:select cases

    SET @countReserva = (SELECT COUNT(id_reserv)
                         FROM Res_Equip
                         WHERE @ide = id_equip)

    IF (@countReserva = 1)
        BEGIN
            UPDATE Res_Equip
            SET assigned_to = 'Sim'
            WHERE id_equip = @ide
        END

    IF (@countReserva > 1)
        BEGIN
            SET @countEssencial = (SELECT COUNT(essential)
                                   FROM Res_Equip
                                   WHERE @ide = id_equip)

            --IF ( @countEssencial = 0 )


            WITH maxPrio AS (SELECT MAX(current_priority)
                             FROM User_DI u
                                      INNER JOIN Reservation r ON u.id_user = r.id_user
                                      INNER JOIN Res_Equip e ON e.id_reserv = r.id_reserv
                             WHERE e.id_equip = 5
                               AND essential = 0)


        END
END