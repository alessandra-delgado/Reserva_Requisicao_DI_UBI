DROP TRIGGER IF EXISTS notcollectedtrigger;
GO
CREATE TRIGGER notcollectedtrigger
ON Reservations
AFTER UPDATE
AS
BEGIN

    -- Penaliza o utilizador se a reserva nao foi levantada ate o final do periodo
    UPDATE User_DI
    SET misses = 5
    FROM User_DI U
    JOIN Reservations R ON U.idu = R.idu
    JOIN inserted I ON R.idr = I.idr
    WHERE I.status_res = 'forgotten' -- Verifica estados 
      AND GETDATE() > R.time_end  -- passou o periodo de uso
END;