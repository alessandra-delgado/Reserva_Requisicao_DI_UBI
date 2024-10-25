CREATE TABLE Tipo_utilizador
(
  id_tipo VARCHAR(2) NOT NULL,
  descricao VARCHAR(12) NOT NULL,
  prioridade_base VARCHAR(6) NOT NULL,
  PRIMARY KEY (id_tipo)
);

CREATE TABLE Utilizador
(
  idu VARCHAR(10) NOT NULL UNIQUE,
  id_tipo VARCHAR(2) NOT NULL,
  prioridade_corrente VARCHAR(6),
  telemovel INT NOT NULL UNIQUE,
  faltas int,
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

CREATE TABLE Telemovel
(
  idt INT NOT NULL IDENTITY(1,1),
  idu VARCHAR(10) NOT NULL,
  telemovel INT NOT NULL,
  PRIMARY KEY (idt),
  FOREIGN KEY (idu) REFERENCES utilizador(idu)
);

CREATE TABLE Equipamento
(
  ide INT NOT NULL IDENTITY(1,1),
  estado VARCHAR(10) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  PRIMARY KEY (ide)
);


CREATE TABLE Reserva
(
  idr INT NOT NULL IDENTITY(20240001,1),
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
  estado VARCHAR(10) NOT NULL,
  PRIMARY KEY (idq),
  FOREIGN KEY (idu) REFERENCES Utilizador(idu)
);

CREATE TABLE ReservaPossuiEquipamento
(
  idr INT NOT NULL,
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