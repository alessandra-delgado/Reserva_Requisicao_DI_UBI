INSERT INTO TblPriority_Map (id_priority, desc_priority)
VALUES (5, 'Maxima'),
       (4, 'Acima'),
       (3, 'Media'),
       (2, 'Abaixo'),
       (1, 'Minima');

INSERT INTO TblUser_Priority (id_type, desc_userType, id_priority)
VALUES ('PD', 'Presidente', 5),
       ('PR', 'Professor', 4),
       ('RS', 'Investigador', 3),
       ('BS', 'Licenciatura', 3),
       ('MS', 'Mestrado', 3),
       ('DS', 'Doutoramento', 3),
       ('SF', 'Apoio', 3),
       ('XT', 'Externo', 3);

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('PD_Frutuos', 'PD', 'frutuoso', '274638468');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('PR_SPECIAL', 'PR', 'mr special', '123456789');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('RS_FABIO', 'RS', 'Fabio Craveiro', '347826592');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('DS_DARIO', 'DS', 'Dario Santos', '48527573');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('MS_DAVINA', 'MS', 'Davinas', '384396001');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('BS_Dragon', 'BS', 'Doragon', '999028458');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('BS_YUNA', 'BS', 'alessandra', '448566772');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('BS_ANA', 'BS', 'Ana Silva', '999586709');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('BS_CAROL', 'BS', 'Carolina Gegaloto', '88857472');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('SF_BETTEN', 'SF', 'Guilherme Paulo', '848393582');

INSERT INTO TblUser_DI(id_user, id_type, name, phone_no)
VALUES ('XT_MONIZ', 'XT', 'Moniz', '885748209');


INSERT INTO TblContact(id_user, email)
VALUES ('PD_Frutuos', 'frutuoso@di.ubi.pt'),
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

INSERT INTO TblEquipment (name_equip)
VALUES ('Toshiba TDP-S8U DLP'),
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

INSERT INTO TblReservation (id_user, reg_date, time_start, time_end, status_res)
VALUES ('BS_YUNA', GETDATE(), GETDATE(), GETDATE(), 'Cancelled');

INSERT INTO TblReservation (id_user, reg_date, time_start, time_end, status_res)
VALUES ('BS_ANA', GETDATE(), GETDATE(), GETDATE(), 'Forgotten');

INSERT INTO TblReservation (id_user, reg_date, time_start, time_end, status_res)
VALUES ('PR_SPECIAL', GETDATE(), GETDATE(), GETDATE(), 'Active');

INSERT INTO TblRes_Equip (id_reserv, id_equip, essential, assigned_to)
VALUES ('20240001', 1, 1, 1);


INSERT INTO TblRequisition (id_user, status_req, time_start, time_end)
VALUES ('BS_YUNA', 'Active', '2024-12-30 00:00:00', '2025-1-3 00:00:00');

INSERT INTO TblReq_Equip(id_req, id_equip)
VALUES (1, 1)
INSERT INTO TblReq_Equip(id_req, id_equip)
VALUES (1, 3)
INSERT INTO TblReq_Equip(id_req, id_equip)
VALUES (1, 5)
INSERT INTO TblReq_Equip(id_req, id_equip)
VALUES (1, 12)


INSERT INTO TblReservation (id_user, reg_date, time_start, time_end, status_res)
VALUES ('BS_CAROL', GETDATE(), GETDATE(), GETDATE(), 'Waiting');
INSERT INTO TblRequisition(id_user, time_start, time_end)
VALUES ('BS_CAROL', GETDATE(), GETDATE())
INSERT INTO TblReq_Equip(id_req, id_equip)
VALUES (2, 2)

-- devolver equipamentos da requisição 1
----------------------------------


-- reserva nova

-- Executar o MakeID e guardar numa var
declare @id_res VARCHAR(8)
EXEC MakeID @id_res OUTPUT

-- Inserir nas tabelas com o id recebido
INSERT INTO TblReservation (id_reserv ,id_user, reg_date, time_start, time_end, status_res)
VALUES (@id_res, 'PR_SPECIAL', GETDATE(), GETDATE(), GETDATE(), 'Waiting');
INSERT INTO TblRes_Equip(ID_RESERV, ID_EQUIP, ESSENTIAL) VALUES (@id_res, 5, 0)

