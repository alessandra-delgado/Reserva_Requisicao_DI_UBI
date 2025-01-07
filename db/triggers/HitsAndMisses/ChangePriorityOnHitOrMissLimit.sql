DROP TRIGGER IF EXISTS ChangePriorityOnHitOrMissLimit;
GO
CREATE TRIGGER ChangePriorityOnHitOrMissLimit
    ON TblUser_DI
    AFTER UPDATE
    AS
BEGIN
    DECLARE @user_id VARCHAR(10);
    IF EXISTS (SELECT 1
               FROM INSERTED
                        JOIN DELETED ON INSERTED.id_user = DELETED.id_user
               WHERE INSERTED.misses <> DELETED.misses
                 AND INSERTED.id_type NOT LIKE 'PD')
        --this begin block only runs if the faltas column is updated
        BEGIN

            SELECT @user_id = INSERTED.id_user
            FROM INSERTED
                     JOIN DELETED ON INSERTED.id_user = DELETED.id_user
            WHERE INSERTED.misses <> DELETED.misses
              AND INSERTED.id_type NOT LIKE 'PD';

            --atualizar a prioridade e as faltas para algu�m que a prioridade ainda � positiva
            UPDATE TblUser_DI
            SET current_priority =
                    CASE
                        WHEN current_priority - 1 <= 0 THEN 1
                        ELSE current_priority - 1
                        END,
                misses           = 0,
                hits             = 0
            WHERE misses >= 5
              AND id_user = @user_id
              AND id_type NOT LIKE 'PD'


            PRINT @user_id
        END

    IF EXISTS (SELECT 1
               FROM INSERTED
                        JOIN DELETED ON INSERTED.id_user = DELETED.id_user
               WHERE INSERTED.hits <> DELETED.hits
                 AND INSERTED.id_type NOT LIKE 'PD')
        --this begin block only runs if the faltas column is updated
        BEGIN
            DECLARE @user_type VARCHAR(2);

            SELECT @user_id = INSERTED.id_user,
                   @user_type = INSERTED.id_type
            FROM INSERTED
                     JOIN DELETED ON INSERTED.id_user = DELETED.id_user
            WHERE INSERTED.hits <> DELETED.hits
              AND INSERTED.id_type NOT LIKE 'PD';

            DECLARE @max_user_priority INT = (SELECT id_priority
                                              FROM TblUser_Priority up
                                              WHERE @user_type = up.id_type);

            --atualizar a prioridade e as faltas para algu�m que a prioridade ainda � positiva
            UPDATE TblUser_DI
            SET current_priority =
                    CASE
                        WHEN current_priority + 1 > @max_user_priority THEN @max_user_priority
                        ELSE current_priority + 1
                        END,
                hits             = 0,
                misses           = 0
            WHERE hits >= 2
              AND id_user = @user_id
              AND id_type NOT LIKE 'PD'
        END
END