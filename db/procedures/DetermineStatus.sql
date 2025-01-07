DROP PROCEDURE IF EXISTS DetermineStatus
GO
CREATE PROCEDURE DetermineStatus @idr INT
AS
BEGIN
    DECLARE
        @num_equips_essenciais INT = (SELECT COUNT(id_equip)
                                      FROM TblRes_Equip
                                      WHERE id_reserv = @idr
                                        AND essential = 1);

    DECLARE
        @num_equips_essenciais_attr INT = (SELECT COUNT(id_equip)
                                           FROM TblRes_Equip
                                           WHERE id_reserv = @idr
                                             AND essential = 1
                                             AND assigned_to = 1);

    DECLARE
        @equip_attribuidos INT = (SELECT COUNT(id_equip)
                                  FROM TblRes_Equip
                                  WHERE assigned_to = 1
                                    AND id_reserv = @idr);

    DECLARE
        @time_end DATETIME = (SELECT TOP 1 time_end
                              FROM TblReservation
                              WHERE id_reserv = @idr);

    DECLARE
        @status_res VARCHAR(12) = (SELECT TOP 1 status_res
                                   FROM TblReservation
                                   WHERE id_reserv = @idr);


    IF @status_res IN ('Active', 'Waiting')
        BEGIN
            IF (DATEDIFF(MINUTE, @time_end, GETDATE()) > 0)
                BEGIN
                    UPDATE TblReservation
                    SET status_res =
                            CASE
                                WHEN @equip_attribuidos = 0 THEN 'NotSatisfied'
                                ELSE 'Forgotten'
                                END
                    WHERE id_reserv = @idr;
                END
            ELSE
                BEGIN
                    UPDATE TblReservation
                    SET status_res =
                            CASE
                                -- todos os equipamentos essenciais estiverem atríbuídos
                                WHEN @num_equips_essenciais_attr = @num_equips_essenciais THEN 'Active'
                                ELSE 'Waiting'
                                END
                    WHERE id_reserv = @idr;
                END
        END
END