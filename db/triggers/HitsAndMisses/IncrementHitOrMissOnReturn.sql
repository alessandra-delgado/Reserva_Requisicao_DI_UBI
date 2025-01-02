DROP TRIGGER IF EXISTS IncrementHitOrMissOnReturn
GO
CREATE TRIGGER IncrementHitOrMissOnReturn
    ON TblDevolution
    AFTER INSERT
    AS
BEGIN
    SET NOCOUNT ON;


    -- Atualizar as faltas dos utilizadores com base no atraso na entrega dos recursos
    -- Após 15 minutos, cada hora é uma falta. ex: 1h 2mins após 15 minutos de tolerância = 2 faltas
    UPDATE TblUser_DI
    SET misses = CASE
                     WHEN (misses +
                           CASE
                               WHEN DATEDIFF(MINUTE, req.time_end, d.return_date) > 15
                                   THEN 1 + DATEDIFF(HOUR, req.time_end, d.return_date)
                               ELSE 0
                               END) > 5 THEN 5
                     ELSE (misses +
                           CASE
                               WHEN DATEDIFF(MINUTE, req.time_end, d.return_date) > 15
                                   THEN 1 + DATEDIFF(HOUR, req.time_end, d.return_date)
                               ELSE 0
                               END)
        END,
        hits   =
            CASE
                WHEN DATEDIFF(MINUTE, d.return_date, req.time_end) > 15 AND
                     req.status_req LIKE 'Closed' THEN hits + 1
                ELSE hits
                END
    FROM TblUser_DI u
             INNER JOIN TblRequisition req ON u.id_user = req.id_user
             INNER JOIN TblDevolution d ON d.id_req = req.id_req
             INNER JOIN inserted i ON i.id_req = d.id_req
    WHERE req.returned >= 1; -- Apenas para recursos efetivamente entregues
END;
GO

