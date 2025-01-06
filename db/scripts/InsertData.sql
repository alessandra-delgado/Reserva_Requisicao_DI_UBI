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

INSERT INTO TblEquipment (name_equip, category)
VALUES ('Toshiba TDP-S8U DLP', 'projector'),
       ('Toshiba TDP-S8U DLP', 'projector'),
       ('Toshiba TDP-S8U DLP', 'projector'),
       ('Toshiba TDP-S8U DLP', 'projector'),
       ('Toshiba TDP-S8U DLP', 'projector'),
       ('Toshiba TDP-S8U DLP', 'projector'),
       ('Toshiba TDP-S8U DLP', 'projector'),
       ('HP 230', 'peripherals'),
       ('HP 230', 'peripherals'),
       ('HP 230', 'peripherals'),
       ('Logitech MX Keys S', 'peripherals'),
       ('Logitech MX Keys S', 'peripherals'),
       ('Logitech MX Keys S', 'peripherals'),
       ('Logitech MX Keys S', 'peripherals'),
       ('Sony DCR405', 'other'),
       ('Sony DCR405', 'other'),
       ('Sony DCR405', 'other'),
       ('Sony DCR405', 'other'),
       ('Sony DCR405', 'other'),
       ('Sony DCR405', 'other'),
       ('Sony DCR405', 'other'),
       ('Sony DCR405', 'other'),
       ('Asus TUF', 'computer'),
       ('Gigabyte GB 5KF', 'computer');



