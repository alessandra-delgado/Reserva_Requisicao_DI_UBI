DROP TRIGGER IF EXISTS HitIncreases
GO
CREATE TRIGGER HitIncreases
ON Requisition
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON

    -- Incrementar os acertos se o estado for 'Closed' e não houve alteração nas faltas
    UPDATE u
    SET u.hits = u.hits + 1
    FROM User_DI u
    INNER JOIN INSERTED i ON u.id_user = i.id_user
    INNER JOIN Requisition r ON r.id_user = u.id_user
    WHERE 
        i.Status = 'Closed' -- Novo estado é 'Closed'
END;