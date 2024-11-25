INSERT INTO Tipo_utilizador (id_tipo, descricao, prioridade_base) VALUES
('PD', 'Presidente', 5),
('PR', 'Professor', 4),
('RS', 'Investigador', 3),
('BS', 'Licenciatura', 3),
('MS', 'Mestrado', 3),
('DS', 'Doutoramento', 3),
('SF', 'Apoio', 3),
('XT', 'Externo', 3);

INSERT INTO utilizador(idu, id_tipo, prioridade_corrente, telemovel, faltas) VALUES
('PD_Frutuos', 'PD', 5, '274638468', 0),
('PR_SPECIAL', 'PR', 4, '123456789', 0),
('RS_FABIO', 'RS', 3, '347826592', 0),
('DS_DARIO', 'DS', 3, '48527573', 0),
('MS_DAVINA', 'MS', 3, '384396001', 0),
('BS_Dragon', 'BS', 3,'999028458', 0),
('BS_YUNA', 'BS', 3,'448566772', 0),
('BS_ANA', 'BS', 3, '999586709',0),
('BS_CAROL', 'BS', 3,  '88857472',0),
('SF_BETTEN', 'SF', 3, '848393582',0),
('XT_MONIZ', 'XT', 3, '885748209',0);

INSERT INTO contacto(idu, email) VALUES
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

INSERT INTO equipamento(nome) values
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

INSERT INTO reserva (idu, periodo_uso_inicio, periodo_uso_fim, estado) values
('BS_YUNA', GETDATE(), GETDATE(), 'Cancelled'),
('BS_CAROL', GETDATE(), GETDATE(), 'Waiting'),
('BS_ANA', GETDATE(), GETDATE(), 'Forgotten'),
('PR_SPECIAL', GETDATE(), GETDATE(), 'Active');

INSERT INTO PrioridadeTN(id_tipo, num_prioridade) values
('PD', 5),
('PR', 4),
('RS', 3),
('BS', 3),
('MS', 3),
('DS', 3),
('SF', 3),
('XT', 3);

INSERT INTO PrioridadeNC(num_prioridade, class_prioridade) values
(5, 'Máxima'),
(4, 'Acima'),
(3, 'Média'),
(2, 'Abaixo'),
(1, 'Mínima');

select * from prioridadeNC 
select * from PrioridadeTN 
select * from Utilizador


-- presidente do departamento deveria ser um tipo de utilizador?


--query area-----------------------------------------------------------------


SELECT * FROM utilizador
SELECT * FROM tipo_utilizador
SELECT * FROM EQUIPAMENTO


delete from reserva
exec ResetSequence
select * from reserva
SELECT * FROM ReservaSequenceId;
--delete from tipo_utilizador
--delete from utilizador
--delete from reserva
--delete from ReservaSequenceId
--delete from equipamento
