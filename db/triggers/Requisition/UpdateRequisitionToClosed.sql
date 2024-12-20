DROP TRIGGER IF EXISTS UpdateRequisitionToClosed;
GO
CREATE TRIGGER UpdateRequisitionToClosed
    ON TblRequisition
    AFTER UPDATE
    AS
BEGIN
    SET NOCOUNT ON;

    -- Evita loops de gatilho
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    -- Verifica se houve mudanças relevantes na coluna returned e status ativo
    IF EXISTS (SELECT 1
               FROM INSERTED
                        JOIN DELETED ON INSERTED.id_req = DELETED.id_req
               WHERE INSERTED.returned <> DELETED.returned)
        BEGIN
            -- Atualiza para o estado Closed
            UPDATE R
            SET R.status_req = 'Closed'
            FROM TblRequisition R
                     JOIN INSERTED I ON R.id_req = I.id_req
            WHERE R.returned = R.collected
              AND R.status_req = 'Active';
        END
END
