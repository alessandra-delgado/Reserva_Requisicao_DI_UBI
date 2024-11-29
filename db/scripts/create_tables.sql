CREATE TABLE Tipo_utilizador
(
  id_tipo VARCHAR(2) NOT NULL,
  descricao VARCHAR(12) NOT NULL,
  prioridade_base int NOT NULL,
  PRIMARY KEY (id_tipo)
);

CREATE TABLE Utilizador
(
  idu VARCHAR(10) NOT NULL UNIQUE,
  id_tipo VARCHAR(2) NOT NULL,
  prioridade_corrente INT DEFAULT 3,
  telemovel INT NOT NULL UNIQUE,
  faltas int DEFAULT 0,
  acertos int default 0,

  CONSTRAINT CHK_TIPO CHECK (id_tipo in ('PD', 'PR', 'RS', 'BS', 'MS', 'DS', 'SF', 'XT')),
  CONSTRAINT CHK_prio CHECK (prioridade_corrente BETWEEN 1 AND 5), 
  CONSTRAINT CHK_faltas CHECK (faltas BETWEEN 0 AND 5),
  CONSTRAINT CHK_ACERTOS CHECK (acertos BETWEEN 0 AND 2),

  PRIMARY KEY (idu),
  FOREIGN KEY (id_tipo) REFERENCES Tipo_utilizador(id_tipo)
			ON Delete No ACTION On UpDate No Action,
);

CREATE TABLE Contacto
(
  idu VARCHAR(10) NOT NULL UNIQUE,
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (idu),
  FOREIGN KEY (idu) REFERENCES Utilizador(idu)
			ON Delete No ACTION On UpDate No Action,
);

CREATE TABLE Equipamento
(
  ide INT IDENTITY(1,1),
  estado VARCHAR(10) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  PRIMARY KEY (ide)
);

CREATE TABLE Reserva
(
  idr varchar(8) NOT NULL UNIQUE,
  idu VARCHAR(10) NOT NULL,
  data_registo DATE NOT NULL,
  periodo_uso_inicio DATETIME NOT NULL,
  periodo_uso_fim DATETIME NOT NULL,
  estado VARCHAR(10) NOT NULL,
  PRIMARY KEY (idr),
  FOREIGN KEY (idu) REFERENCES Utilizador(idu)
			ON Delete No ACTION On UpDate No ACTION,
);

CREATE TABLE Requisicao
(
  idq INT NOT NULL IDENTITY(1,1),
  idu VARCHAR(10) NOT NULL,
  estado VARCHAR(10) default 'Active',
  periodo_uso_inicio DATETIME NOT NULL,
  periodo_uso_fim DATETIME NOT NULL,
  PRIMARY KEY (idq),
  FOREIGN KEY (idu) REFERENCES Utilizador(idu)
);

CREATE TABLE ReservaPossuiEquipamento
(
  idr varchar(8),
  ide INT NOT NULL,
  essencial VARCHAR(1) NOT NULL,
  assigned_to VARCHAR(1) NOT NULL,
  FOREIGN KEY (idr) REFERENCES Reserva(idr)
			ON Delete No ACTION On UpDate Cascade,
  FOREIGN KEY (ide) REFERENCES Equipamento(ide)
			ON Delete No ACTION On UpDate Cascade,
);

CREATE TABLE RequisicaoPossuiEquipamento
(
  idq INT NOT NULL,
  ide INT NOT NULL,
  FOREIGN KEY (idq) REFERENCES Requisicao(idq)
			ON Delete No ACTION On UpDate Cascade,
  FOREIGN KEY (ide) REFERENCES Equipamento(ide)
			ON Delete No ACTION On UpDate Cascade,
);

CREATE TABLE ReservaSequenceId
(
	Ano INT PRIMARY KEY,
    CurrentSequence INT
);

CREATE TABLE PrioridadeNC
(
  num_prioridade INT NOT NULL,
  class_prioridade varchar (6) NOT NULL,
  PRIMARY KEY (num_prioridade)
);

CREATE TABLE PrioridadeTN
(
	id_tipo varchar (2) NOT NULL,
	num_prioridade INT NOT NULL,
	PRIMARY KEY (id_tipo),
  foreign key (num_prioridade) references PrioridadeNC (num_prioridade)
);
