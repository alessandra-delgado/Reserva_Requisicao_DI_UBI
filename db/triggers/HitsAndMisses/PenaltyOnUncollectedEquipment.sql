DROP TRIGGER IF EXISTS ApplyPenaltyForUncollectedEquipment;
GO
CREATE TRIGGER ApplyPenaltyForUncollectedEquipment
    ON TblReservation
    AFTER UPDATE
    AS
BEGIN

    -- Penaliza o utilizador se a reserva nao foi levantada ate o final do periodo
    UPDATE TblUser_DI
    SET misses = 5
    FROM TblUser_DI U
             JOIN TblReservation R ON U.id_user = R.id_user
             JOIN inserted I ON R.id_reserv = I.id_reserv
    WHERE I.status_res = 'Forgotten' -- Verifica estados
      AND GETDATE() > R.time_end -- passou o periodo de uso
END;