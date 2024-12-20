DROP TRIGGER IF EXISTS PrioChange_AssignEquip
GO
CREATE TRIGGER PrioChange_AssignEquip
    ON
        User_DI
    AFTER UPDATE
    AS
    IF EXISTS (SELECT 1
               FROM INSERTED I
               INNER JOIN DELETED D ON I.id_user = D.id_user
               WHERE I.current_priority != D.current_priority)
        BEGIN
            DECLARE @id_user INT = (SELECT I.id_user
                                    FROM INSERTED I
                                    INNER JOIN DELETED D ON I.id_user = D.id_user
                                    WHERE I.current_priority != D.current_priority)

            DECLARE @id_reserv VARCHAR(8)
            DECLARE @id_equip INT

            DECLARE id_go_reserv CURSOR FOR
                SELECT r.id_reserv
                FROM Reservation r
                WHERE @id_user = r.id_user
                  AND r.status_res IN ('Active', 'Waiting')

            OPEN id_go_reserv;

            FETCH NEXT FROM id_go_reserv INTO @id_reserv;

            WHILE @@FETCH_STATUS = 0
                BEGIN
                    DECLARE id_go_equip CURSOR FOR
                        SELECT id_equip
                        FROM Res_Equip
                        WHERE @id_reserv = id_reserv

                    OPEN id_go_equip;

                    FETCH NEXT FROM id_go_equip INTO @id_equip;

                    WHILE @@FETCH_STATUS = 0
                        BEGIN
                            EXEC AssignEquipmentToUser @id_equip;
                            FETCH NEXT FROM id_go_equip INTO @id_equip;
                        END

                    CLOSE id_go_equip;
                    DEALLOCATE id_go_equip;

                    FETCH NEXT FROM id_go_reserv INTO @id_reserv;
                END

            CLOSE id_go_reserv;
            DEALLOCATE id_go_reserv;
        END