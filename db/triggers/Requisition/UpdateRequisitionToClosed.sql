DROP TRIGGER IF EXISTS UpdateRequisitionToClosed;
GO
CREATE TRIGGER UpdateRequisitionToClosed
    ON Requisition
    AFTER UPDATE
    AS
BEGIN
    SET NOCOUNT ON;
            
        -- Atualiza para o estado Closed
        UPDATE R
        SET R.status_req = 'Closed'
        FROM Requisition R
        JOIN INSERTED I ON R.id_req = I.id_req
        WHERE R.returned = R.collected
            AND R.status_req = 'Active';     
END;
