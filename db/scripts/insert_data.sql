INSERT INTO User_Priority (id_type, desc_userType, default_priority) VALUES
('PD', 'Presidente', 5),
('PR', 'Professor', 4),
('RS', 'Investigador', 3),
('BS', 'Licenciatura', 3),
('MS', 'Mestrado', 3),
('DS', 'Doutoramento', 3),
('SF', 'Apoio', 3),
('XT', 'Externo', 3);

-- set to default on utilizador: prioridade corrente -> 3 e faltas -> 0
INSERT INTO User_DI(id_user, id_type, phone_no) VALUES
('PD_Frutuos', 'PD', '274638468'),
('PR_SPECIAL', 'PR', '123456789'),
('RS_FABIO', 'RS', '347826592'),
('DS_DARIO', 'DS', '48527573'),
('MS_DAVINA', 'MS', '384396001'),
('BS_Dragon', 'BS','999028458'),
('BS_YUNA', 'BS', '448566772'),
('BS_ANA', 'BS', '999586709'),
('BS_CAROL', 'BS',  '88857472'),
('SF_BETTEN', 'SF', '848393582'),
('XT_MONIZ', 'XT', '885748209');

INSERT INTO Contacts(id_user, email) VALUES
('PD_Frutuos', 'frutuoso@di.ubi.pt'),
('PR_SPECIAL', 'mrspecial@di.ubi.pt'),
('RS_FABIO', 'fabio@di.upi.pt'),
('DS_DARIO', 'dariosantos@ubi.pt'),
('MS_DAVINA', 'davinass@ubi.pt'),
('BS_Dragon', 'dragonshell@ubi.pt'),
('BS_YUNA', 'alessandra@ubi.pt'),
('BS_ANA', 'anasilva@ubi.pt'),
('BS_CAROL', 'gegaloto@ubi.pt'),
('SF_BETTEN', 'guilherme@gmail.com'),
('XT_MONIZ', 'moniz4@gmail.com');

INSERT INTO Equipments (name_equip) values
('Toshiba TDP-S8U DLP'),
('Toshiba TDP-S8U DLP'),
('Toshiba TDP-S8U DLP'),
('Toshiba TDP-S8U DLP'),
('Toshiba TDP-S8U DLP'),
('Toshiba TDP-S8U DLP'),
('Toshiba TDP-S8U DLP'),
('Asus LC3'),
('Asus LC3'),
('Asus LC3'),
('Asus LC3'),
('Asus LC3'),
('Asus LC3'),
('Asus LC3'),
('Sony DCR405'),
('Sony DCR405'),
('Sony DCR405'),
('Sony DCR405'),
('Sony DCR405'),
('Sony DCR405'),
('Sony DCR405'),
('Sony DCR405'),
('Asus Tuff'),
('GB 5KF');

INSERT INTO Reservations (id_user, time_start, time_end, status_res) values
('BS_YUNA', GETDATE(), GETDATE(), 'Cancelled'),
('BS_CAROL', GETDATE(), GETDATE(), 'Waiting'),
('BS_ANA', GETDATE(), GETDATE(), 'Forgotten'),
('PR_SPECIAL', GETDATE(), GETDATE(), 'Active');

/*
INSERT INTO PrioridadeTN(id_tipo, num_prioridade) values
('PD', 5),
('PR', 4),
('RS', 3),
('BS', 3),
('MS', 3),
('DS', 3),
('SF', 3),
('XT', 3);
-- to delete? (does the same as Tipo_utilizador)
*/

INSERT INTO Priority_Map (id_priority, desc_priority) values
(5, 'Máxima'),
(4, 'Acima'),
(3, 'Média'),
(2, 'Abaixo'),
(1, 'Mínima');

select * from Priority_Map 
select * from User_DI

--testing...................................................................................
INSERT INTO Res_Equip (id_reserv, id_equip, essential, assigned_to) values
('20240001', 34, 'F', 'T');


-- presidente do departamento deveria ser um tipo de utilizador?


--query area-----------------------------------------------------------------


SELECT * FROM User_DI
SELECT * FROM User_Priority
SELECT * FROM Equipments


--delete from Reserva
--exec ResetSequence
--SELECT * FROM ReservaSequenceId;
--delete from tipo_utilizador
--delete from utilizador
--delete from Reserva
--delete from ReservaSequenceId
--delete from equipamento

-- 29-11-24 requisition testing
update Reservations
set status_res = 'Satisfied'
where id_user like 'DS_DARIO';
select * from Reservations

update Reservations
set status_res = 'Active'
where id_user like 'DS_DARIO';

INSERT INTO Reservations (id_user, time_start, time_end, status_res) values
('DS_DARIO', GETDATE(), GETDATE(), 'Active');
select * from Reservations
INSERT INTO Res_Equip(id_reserv, id_equip, essential, assigned_to) values
('20240005', 34, 'F', 'T');

DECLARE @tmp DATETIME
SET @tmp = GETDATE()
exec Reserve2Requisition 'BS_YUNA', @tmp, @tmp
select * from Requisitions
select *from Req_Equip


--inserir Reservations
--inserir equipamentos nessa Reservations
--mudar status_res da Reservations para active
INSERT INTO Reservations (id_user, time_start, time_end, status_res) values
('BS_YUNA', GETDATE(), GETDATE(), 'Active');
select * from Reservations
INSERT INTO Res_Equip(id_reserv, id_equip, essential, assigned_to) values
('20240001', 13, 'F', 'T'),
('20240001', 14, 'F', 'T'),
('20240001', 15, 'F', 'T'),
('20240001', 16, 'F', 'T'),
('20240001', 17, 'F', 'T'),
('20240001', 21, 'F', 'T');


select * from Res_Equip

update Reservations
set status_res = 'Satisfied'
where id_user like 'BS_YUNA' and id_reserv like '20240001';

select * from Req_Equip
select * from Equipamento
