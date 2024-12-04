select *
from Priority_Map
select *
from User_DI

--testing...................................................................................
INSERT INTO Res_Equip (id_reserv, id_equip, essential, assigned_to)
values ('20240001', 34, 1, 1);


--query area-----------------------------------------------------------------


SELECT *
FROM User_DI
SELECT *
FROM User_Priority
SELECT *
FROM Equipments


--delete from Reserva
--exec ResetSequence
--SELECT * FROM ReservaSequenceId;
--delete from tipo_utilizador
--delete from utilizador
--delete from Reserva
--delete from ReservaSequenceId
--delete from equipamento

-- 29-11-24 requisition testing
update Reservation
set status_res = 'Satisfied'
where id_user like 'DS_DARIO';
select *
from Reservation

update Reservation
set status_res = 'Active'
where id_user like 'DS_DARIO';

INSERT INTO Reservation (id_user, reg_date,time_start, time_end, status_res)
values ('DS_DARIO', GETDATE(), GETDATE(), 'Active');
select *
from Reservation
INSERT INTO Res_Equip(id_reserv, id_equip, essential, assigned_to)
values ('20240005', 34, 'F', 'T');

DECLARE @tmp DATETIME
SET @tmp = GETDATE()
exec ReservationToRequisition 'BS_YUNA', @tmp, @tmp
select *
from Requisition
select *
from Req_Equip


--inserir Reservations
--inserir equipamentos nessa Reservations
--mudar status_res da Reservations para active
INSERT INTO Reservation (id_user, time_start, time_end, status_res)
values ('BS_YUNA', GETDATE(), GETDATE(), 'Active');
select *
from Reservation
INSERT INTO Res_Equip(id_reserv, id_equip, essential, assigned_to)
values ('20240001', 13, 'F', 'T'),
       ('20240001', 14, 'F', 'T'),
       ('20240001', 15, 'F', 'T'),
       ('20240001', 16, 'F', 'T'),
       ('20240001', 17, 'F', 'T'),
       ('20240001', 21, 'F', 'T');


select *
from Res_Equip

update Reservation
set status_res = 'Satisfied'
where id_user like 'BS_YUNA'
  and id_reserv like '20240001';

select *
from Req_Equip
select *
from Equipment
