DROP TRIGGER IF EXISTS IncreatePriorityOnHitLimit;
GO
CREATE TRIGGER IncreasePriorityOnHitLimit
    ON User_DI
    AFTER UPDATE
    AS
BEGIN
    IF EXISTS (SELECT 1
               FROM INSERTED
                        JOIN DELETED ON INSERTED.id_user = DELETED.id_user
               WHERE INSERTED.hits <> DELETED.hits)
        --this begin block only runs if the faltas column is updated
        BEGIN
            IF (u.current_priority < ui.id_priority) BEGIN
            UPDATE User_DI 
            SET current_priority = current_priority + 1,
                hits           = 0
            FROM User_DI u, User_Priority ui
            WHERE hits = 2
            AND u.id_type = ui.id_type
        END

            ELSE BEGIN
            UPDATE User_DI 
            SET hits = 0
            FROM User_DI u, User_Priority ui
            WHERE hits = 2
            AND u.id_type = ui.id_type
        END    
    END
END