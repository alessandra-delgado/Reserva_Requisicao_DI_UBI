DROP TRIGGER IF EXISTS HitReset
GO
CREATE TRIGGER HitReset
ON User_DI
AFTER UPDATE 
AS
BEGIN
    SET NOCOUNT ON
    
    -- Se as faltas do utilizador mudaram, redefinir os acertos para 0
    UPDATE u
    SET u.hits = 0
    FROM User_DI u
    INNER JOIN INSERTED i ON u.id_user = i.id_user
    INNER JOIN DELETED d ON i.id_user= d.id_user
    WHERE i.Misses <> d.Misses; -- Verifica alteração no número de faltas
END;