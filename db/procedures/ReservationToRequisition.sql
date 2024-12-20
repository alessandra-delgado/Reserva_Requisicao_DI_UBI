DROP PROCEDURE IF EXISTS ReservationToRequisition;
GO
CREATE PROCEDURE ReservationToRequisition @id_user VARCHAR(10), @id_reserv VARCHAR(8), @time_start DATETIME,
                                          @time_end DATETIME
AS
BEGIN
    DECLARE @id_req INT;
    DECLARE @collected INT;

    INSERT INTO TblRequisition (id_user, time_start, time_end, status_req)
    VALUES (@id_user, @time_start, @time_end, 'Active');

    SET @id_req = SCOPE_IDENTITY();

    INSERT INTO TblReq_Equip(id_equip, id_req)
    SELECT re.id_equip, @id_req
    FROM TblRes_Equip AS re
    WHERE re.id_reserv = @id_reserv
      AND re.assigned_to = 1;

    SET @collected = @@ROWCOUNT;
    UPDATE TblRequisition
    SET TblRequisition.collected = @collected
    WHERE TblRequisition.id_req = @id_req;

END;