DROP TRIGGER IF EXISTS ReducePriorityOnMissLimit;
GO
CREATE TRIGGER ReducePriorityOnMissLimit
    ON TblUser_DI
    AFTER UPDATE
    AS
BEGIN
    IF EXISTS (SELECT 1
               FROM INSERTED
                        JOIN DELETED ON INSERTED.id_user = DELETED.id_user
               WHERE INSERTED.misses <> DELETED.misses)
        --this begin block only runs if the faltas column is updated
        BEGIN
		IF EXISTS (
			SELECT 1
            FROM INSERTED
            JOIN DELETED ON INSERTED.id_user = DELETED.id_useR
			WHERE INSERTED.id_user != 'PR%'
			)
			BEGIN
            --atualizar a prioridade e as faltas para algu�m que a prioridade ainda � positiva
            UPDATE TblUser_DI
            SET current_priority = current_priority - 1,
                misses           = 0
            WHERE misses = 5
              AND current_priority > 1

            --atualizar apenas as faltas nas pessoas em que a prioridade j� � 0
            UPDATE TblUser_DI
            SET misses = 0
            WHERE misses = 5
              AND current_priority = 1

			END
        END
END