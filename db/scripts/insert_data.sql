INSERT INTO Tipo_utilizador (id_tipo, descricao, prioridade_base) VALUES
('PD', 'Presidente', 5),
('PR', 'Professor', 4),
('RS', 'Investigador', 3),
('BS', 'Licenciatura', 3),
('MS', 'Mestrado', 3),
('DS', 'Doutoramento', 3),
('SF', 'Apoio', 3),
('XT', 'Externo', 3);

-- set to default on utilizador: prioridade corrente -> 3 e faltas -> 0
INSERT INTO utilizador(idu, id_tipo, prioridade_corrente, telemovel, faltas) VALUES
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

INSERT INTO PrioridadeNC(num_prioridade, class_prioridade) values
(5, 'Máxima'),
(4, 'Acima'),
(3, 'Média'),
(2, 'Abaixo'),
(1, 'Mínima');

select * from prioridadeNC 
select * from PrioridadeTN 
select * from Utilizador

--testing...................................................................................
INSERT INTO ReservaPossuiEquipamento(idr, ide, essencial, assigned_to) values
('20240001', 34, 'F', 'T');


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

-- 29-11-24 requisition testing
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
('20240001', 13, 'F', 'T'),
('20240001', 14, 'F', 'T'),
('20240001', 15, 'F', 'T'),
('20240001', 16, 'F', 'T'),
('20240001', 17, 'F', 'T'),
('20240001', 21, 'F', 'T');


select * from ReservaPossuiEquipamento

update reserva
set estado = 'Satisfied'
where idu like 'BS_YUNA' and idr like '20240001';

select * from RequisicaoPossuiEquipamento
select * from Equipamento
