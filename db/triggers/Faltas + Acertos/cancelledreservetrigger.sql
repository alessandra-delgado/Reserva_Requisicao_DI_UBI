DROP TRIGGER IF EXISTS cancelledreservetrigger
GO
CREATE TRIGGER cancelledreservetrigger
ON Reservations
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Penaliza cancelamentos com base no tempo relativo ao prazo de uso
    UPDATE User_DI
    SET misses = CASE 
                    WHEN misses + Penalty > 5 THEN 5
                    ELSE misses + Penalty
                 END
    FROM Users U
    JOIN Reservations R ON U.id_user = R.id_user
    JOIN inserted I ON R.id_reserv = I.id_reserv
    CROSS APPLY (
        SELECT 
            CASE 
                -- Penalização até 2 horas antes do início do uso
                WHEN R.status_res = 'cancelled'
                AND GETDATE() NOT BETWEEN R.time_start AND R.time_end
                     AND DATEDIFF(MINUTE, GETDATE(), R.time_start) <= 120 THEN 1

                -- Cancelamento no período de uso com penalização proporcional (máx 3)
                WHEN R.Status = 'cancelled' 
                     AND GETDATE() BETWEEN R.time_start AND R.time_end 
                     AND DATEDIFF(HOUR, R.time_start, GETDATE()) >= 3 THEN 3 
                      

                -- Cancelamento após o prazo de uso (até 2 horas após o término)
                WHEN R.Status = 'cancelled'
                    AND GETDATE() BETWEEN R.time_start AND R.time_end
                     AND DATEDIFF(HOUR, R.time_start, GETDATE()) = 1 then 1

                WHEN R.Status = 'cancelled'
                    AND GETDATE() BETWEEN R.time_start AND R.time_end
                     AND DATEDIFF(HOUR, R.EndTime, GETDATE()) = 2 THEN 2

                -- Sem penalização (outros casos)
                ELSE 0
            END AS Penalty
    ) P
    WHERE P.Penalty > 0; -- Só aplica penalização se houver necessidade
END;
