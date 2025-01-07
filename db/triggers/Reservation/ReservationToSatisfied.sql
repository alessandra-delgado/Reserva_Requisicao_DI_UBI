DROP TRIGGER IF EXISTS ReservationToSatisfied;
GO
CREATE TRIGGER ReservationToSatisfied
    ON TblReservation
    AFTER UPDATE
    AS
    IF (UPDATE(status_res))
        BEGIN
            DECLARE @id_user VARCHAR(10);
            DECLARE @id_reserv VARCHAR(8);
            DECLARE @time_start DATETIME;
            DECLARE @time_end DATETIME;

            DECLARE for_satisfied CURSOR FOR
                SELECT id_user, id_reserv, time_start, time_end
                FROM inserted
                WHERE status_res LIKE 'Satisfied'

            OPEN for_satisfied;

            FETCH NEXT FROM for_satisfied INTO @id_user, @id_reserv, @time_start, @time_end
            WHILE @@FETCH_STATUS = 0
                BEGIN
                    EXEC ReservationToRequisition @id_user, @id_reserv, @time_start, @time_end
                    FETCH NEXT FROM for_satisfied INTO @id_user, @id_reserv, @time_start, @time_end
                END
            CLOSE for_satisfied;
            DEALLOCATE for_satisfied;
        END;
GO