INSERT INTO Priority_Map (id_priority, desc_priority)
VALUES (5, N'Máxima'),
       (4, 'Acima'),
       (3, N'Média'),
       (2, 'Abaixo'),
       (1, N'Mínima');

INSERT INTO User_Priority (id_type, desc_userType, default_priority)
VALUES ('PD', 'Presidente', 5),
       ('PR', 'Professor', 4),
       ('RS', 'Investigador', 3),
       ('BS', 'Licenciatura', 3),
       ('MS', 'Mestrado', 3),
       ('DS', 'Doutoramento', 3),
       ('SF', 'Apoio', 3),
       ('XT', 'Externo', 3);

-- set to default on utilizador: prioridade corrente -> 3 e faltas -> 0
INSERT INTO User_DI(id_user, id_type, phone_no)
VALUES ('PD_Frutuos', 'PD', '274638468'),
       ('PR_SPECIAL', 'PR', '123456789'),
       ('RS_FABIO', 'RS', '347826592'),
       ('DS_DARIO', 'DS', '48527573'),
       ('MS_DAVINA', 'MS', '384396001'),
       ('BS_Dragon', 'BS', '999028458'),
       ('BS_YUNA', 'BS', '448566772'),
       ('BS_ANA', 'BS', '999586709'),
       ('BS_CAROL', 'BS', '88857472'),
       ('SF_BETTEN', 'SF', '848393582'),
       ('XT_MONIZ', 'XT', '885748209');

INSERT INTO Contacts(id_user, email)
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

INSERT INTO Equipments (name_equip)
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

INSERT INTO Reservation (id_user, reg_date, time_start, time_end, status_res)
VALUES ('BS_YUNA', GETDATE(), GETDATE(), GETDATE(), 'Cancelled'),
       ('BS_CAROL', GETDATE(), GETDATE(), GETDATE(), 'Waiting'),
       ('BS_ANA', GETDATE(), GETDATE(), GETDATE(), 'Forgotten'),
       ('PR_SPECIAL', GETDATE(), GETDATE(), GETDATE(), 'Active');
