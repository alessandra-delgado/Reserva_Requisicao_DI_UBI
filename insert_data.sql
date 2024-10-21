INSERT INTO Tipo_utilizador (id_tipo, descricao, prioridade_base) VALUES
('PD', 'Presidente', 'Máxima'),
('PR', 'Professor', 'Acima'),
('RS', 'Investigador', 'Média'),
('BS', 'Licenciatura', 'Média'),
('MS', 'Mestrado', 'Média'),
('DS', 'Doutoramento', 'Média'),
('SF', 'Apoio', 'Média'),
('XT', 'Externo', 'Média');

INSERT INTO utilizador (idu, id_tipo) VALUES
('PD_Frutuos', 'PD'),
('PR_SPECIAL', 'PR'),
('RS_FABIO', 'RS'),
('DS_DARIO', 'DS'),
('MS_DAVINA', 'MS'),
('BS_Dragon', 'BS'),
('BS_YUNA', 'BS'),
('BS_ANA', 'BS'),
('SF_BETTEN', 'SF'),
('XT_MONIZ', 'XT');
-- presidente do departamento deveria ser um tipo de utilizador?
SELECT * FROM utilizador
SELECT * FROM tipo_utilizador

/*
alter table utilizador
add constraint foo unique(idu); ?
*/

--delete from utilizador