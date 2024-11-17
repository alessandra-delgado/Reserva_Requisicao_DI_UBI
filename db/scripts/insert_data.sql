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

INSERT INTO ReservaPossuiEquipamento(idr, ide, essencial, assigned_to) values
('2024000', 34, 'F', 'T');


-- presidente do departamento deveria ser um tipo de utilizador?


--query area-----------------------------------------------------------------


SELECT * FROM utilizador
SELECT * FROM tipo_utilizador
SELECT * FROM EQUIPAMENTO


--delete from reserva
--exec ResetSequence
--SELECT * FROM ReservaSequenceId;
--delete from tipo_utilizador
--delete from utilizador
--delete from reserva
--delete from ReservaSequenceId
--delete from equipamento

-- 17-11-24
update reserva
set estado = 'Satisfied'
where idu like 'DS_DARIO';
select * from reserva

update reserva
set estado = 'Active'
where idu like 'DS_DARIO';

INSERT INTO reserva (idu, periodo_uso_inicio, periodo_uso_fim, estado) values
('DS_DARIO', GETDATE(), GETDATE(), 'Active');
select * from reserva
INSERT INTO ReservaPossuiEquipamento(idr, ide, essencial, assigned_to) values
('20240005', 34, 'F', 'T');

DECLARE @tmp DATETIME
SET @tmp = GETDATE()
exec Reserve2Requisition 'BS_YUNA', @tmp, @tmp
select * from Requisicao
select *from RequisicaoPossuiEquipamento


--inserir reserva
--inserir equipamentos nessa reserva
--mudar estado da reserva para active
INSERT INTO reserva (idu, periodo_uso_inicio, periodo_uso_fim, estado) values
('BS_YUNA', GETDATE(), GETDATE(), 'Active');
select * from Reserva
INSERT INTO ReservaPossuiEquipamento(idr, ide, essencial, assigned_to) values
('20240006', 37, 'F', 'T');
select * from ReservaPossuiEquipamento

update reserva
set estado = 'Satisfied'
where idu like 'BS_YUNA';

select * from RequisicaoPossuiEquipamento
select * from Equipamento
