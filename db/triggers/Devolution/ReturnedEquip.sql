CREATE TRIGGER ReturnedEquip
    ON TblDevolution
    AFTER INSERT
    AS
BEGIN
    DECLARE @id_req INT;
    DECLARE @id_equip INT;
    DECLARE @collected INT;
    DECLARE @returned INT;

    SET @id_req = (SELECT id_req
                   FROM INSERTED)

    SET @id_equip = (SELECT id_equip
                     FROM INSERTED)

    --aumentar o numero de equipamentos devolvidos na requisicao
    UPDATE TblRequisition
    SET returned = returned + 1
    WHERE id_req = @id_req

    --voltar a por o estado do equipamento para available
    UPDATE TblEquipment
    SET status_equip = 'Available'
    WHERE id_equip = @id_equip

    SET @collected = (SELECT collected
                      FROM TblRequisition
                      WHERE id_req = @id_req)

    SET @returned = (SELECT returned
                     FROM TblRequisition
                     WHERE id_req = @id_req)

    IF (@collected = @returned)
        BEGIN
            UPDATE TblRequisition
            SET status_req = 'Closed'
            WHERE id_req = @id_req
        END

END
