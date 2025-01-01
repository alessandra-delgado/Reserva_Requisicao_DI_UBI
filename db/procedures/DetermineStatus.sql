DROP PROCEDURE IF EXISTS DetermineStatus
GO
CREATE PROCEDURE DetermineStatus @idr INT
AS

DECLARE @qnteq INT = (SELECT COUNT(id_equip) FROM TblRes_Equip );
DECLARE @qntes INT = (SELECT COUNT(id_equip) FROM TblRes_Equip WHERE  essential=1);
DECLARE @qntas INT = (SELECT COUNT(id_equip) FROM TblRes_Equip WHERE assigned_to=1);
DECLARE @qntesas INT = (SELECT COUNT(id_equip) FROM TblRes_Equip WHERE essential=1 AND assigned_to=1);
DECLARE @qntcol INT = (SELECT collected FROM TblRes_Equip);

SELECT R.time_start, R.status_res, RE.essential, R.id_reserv, RE.id_reserv 
FROM Tb1Reservation R, TblRes_Equip RE


IF R.status_res NOT LIKE 'Cancelled'

BEGIN
    IF (DATEDIFF(HOUR, R.time_start, GETDATE()) > 6)
    BEGIN
        IF R.status_res IN ('Waiting' , 'Active')
        BEGIN
            UPDATE TblReservation
            SET R.status_res = 
             CASE 
                 WHEN @qntes = 0 AND @qnteq = @qntas THEN 'Active'
                 WHEN @qntes = 0 AND @qnteq != @qntas THEN 'Waiting'
                 WHEN @qntes >= 1 AND @qntesas = @qntes THEN 'Active'
                 WHEN @qntes >= 1 AND @qntesas != @qntes THEN 'Waiting'
                 ELSE R.status_res
            END
            WHERE R.id_reserv = RE.id_reserv;
END
ELSE
    BEGIN
        IF @qntcol = -1
        BEGIN

        UPDATE TblReservation
        SET R.status_res =
            CASE
                WHEN @qntas = 0 THEN 'NotSatisfied'
                WHEN DATEDIFF(HOUR, GETDATE, R.time_end) = 0 THEN 'Forgotten'
        END
        WHERE R.id_reserv = RE.id_reserv

        END
    END
END
END