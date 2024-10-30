INSERT INTO Tipo_utilizador (id_tipo, descricao, prioridade_base) VALUES
('PD', 'Presidente', 'Máxima'),
('PR', 'Professor', 'Acima'),
('RS', 'Investigador', 'Média'),
('BS', 'Licenciatura', 'Média'),
('MS', 'Mestrado', 'Média'),
('DS', 'Doutoramento', 'Média'),
('SF', 'Apoio', 'Média'),
('XT', 'Externo', 'Média');

INSERT INTO utilizador(idu, id_tipo, telemovel) VALUES
('PD_Frutuos', 'PD', '274638468'),
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