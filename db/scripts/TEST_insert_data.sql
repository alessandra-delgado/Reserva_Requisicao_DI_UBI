SELECT *
FROM Priority_Map
SELECT *
FROM User_DI

--testing...................................................................................
INSERT INTO Res_Equip (id_reserv, id_equip, essential, assigned_to)
VALUES ('20240001', 34, 1, 1);


--query area-----------------------------------------------------------------


SELECT *
FROM User_DI
SELECT *
FROM User_Priority
SELECT *
FROM Equipment


--delete from Reserva
--exec ResetSequence
--SELECT * FROM ReservaSequenceId;
--delete from tipo_utilizador
--delete from utilizador
--delete from Reserva
--delete from ReservaSequenceId
--delete from equipamento

-- 29-11-24 requisition testing
UPDATE Reservation
SET status_res = 'Satisfied'
WHERE id_user LIKE 'DS_DARIO';
SELECT *
FROM Reservation

UPDATE Reservation
SET status_res = 'Active'
WHERE id_user LIKE 'DS_DARIO';

INSERT INTO Reservation (id_user, reg_date, time_start, time_end, status_res)
VALUES ('DS_DARIO', GETDATE(), GETDATE(), GETDATE(), 'Available');
SELECT *
FROM Reservation
INSERT INTO Res_Equip(id_reserv, id_equip, essential, assigned_to)
VALUES ('20240005', 34, 'F', 'T');

DECLARE @tmp DATETIME
SET @tmp = GETDATE()
EXEC ReservationToRequisition 'BS_YUNA', @tmp, @tmp
SELECT *
FROM Requisition
SELECT *
FROM Req_Equip


--inserir Reservations
--inserir equipamentos nessa Reservations
--mudar status_res da Reservations para active
INSERT INTO Reservation (id_user, reg_date, time_start, time_end, status_res)
VALUES ('BS_YUNA',GETDATE(),GETDATE(), GETDATE(), 'Active');
SELECT *
FROM Reservation
INSERT INTO Res_Equip(id_reserv, id_equip, essential, assigned_to)
VALUES ('20240001', 13, 'F', 'T'),
       ('20240001', 14, 'F', 'T'),
       ('20240001', 15, 'F', 'T'),
       ('20240001', 16, 'F', 'T'),
       ('20240001', 17, 'F', 'T'),
       ('20240001', 21, 'F', 'T');


SELECT *
FROM Res_Equip

UPDATE Reservation
SET status_res = 'Satisfied'
WHERE id_user LIKE 'BS_YUNA'
  AND id_reserv LIKE '20240001';

SELECT *
FROM Req_Equip
SELECT *
FROM Equipment
