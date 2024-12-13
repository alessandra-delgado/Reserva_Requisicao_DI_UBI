DROP TRIGGER IF EXISTS PenaltyOnUncollectedEquipment;
GO

CREATE TRIGGER PenaltyOnUncollectedEquipment
    ON Devolution
    AFTER INSERT
    AS
BEGIN
    SET NOCOUNT ON;

    -- Atualizar as faltas dos utilizadores com base no atraso na entrega dos recursos
    UPDATE User_DI
    SET misses = misses +
                 CASE
                     WHEN DATEDIFF(MINUTE, res.time_end, d.return_date) > 15 THEN
                         CEILING(DATEDIFF(MINUTE, res.time_end, d.return_date) / 60.0)
                     ELSE 0
                     END
    FROM User_DI u
             INNER JOIN Requisition req ON u.id_user = req.id_user
             INNER JOIN Reservation res ON res.id_user = u.id_user
             INNER JOIN Devolution d ON d.id_req = req.id_req
    WHERE req.returned >= 1; -- Apenas para recursos efetivamente entregues
END;