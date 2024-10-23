CREATE TABLE Tipo_utilizador
(
  id_tipo VARCHAR(2) NOT NULL,
  descricao VARCHAR(12) NOT NULL,
  prioridade_base VARCHAR(6) NOT NULL,
  PRIMARY KEY (id_tipo)
);

CREATE TABLE Equipamento
(
  estado VARCHAR(10) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  ide INT NOT NULL,
  PRIMARY KEY (ide)
);

CREATE TABLE Utilizador
(
  prioridade_corrente VARCHAR(6),
  idu VARCHAR(10) NOT NULL UNIQUE,
  id_tipo VARCHAR(2) NOT NULL,
  PRIMARY KEY (idu),
  FOREIGN KEY (id_tipo) REFERENCES Tipo_utilizador(id_tipo)
);

CREATE TABLE Reserva
(
  idr INT NOT NULL,
  periodo_uso DATE NOT NULL,
  data DATE NOT NULL,
  estado VARCHAR(10) NOT NULL,
  idu VARCHAR(10) NOT NULL,
  PRIMARY KEY (idr),
  FOREIGN KEY (idu) REFERENCES Utilizador(idu)
);

CREATE TABLE Email
(
  email VARCHAR(50) NOT NULL,
  idm INT NOT NULL,
  idu VARCHAR(10) NOT NULL,
  PRIMARY KEY (idm),
  FOREIGN KEY (idu) REFERENCES Utilizador(idu)
);

CREATE TABLE Telemovel
(
  telemovel INT NOT NULL,
  idt INT NOT NULL,
  idu VARCHAR(10) NOT NULL,
  PRIMARY KEY (idt),
  FOREIGN KEY (idu) REFERENCES Utilizador(idu)
);

CREATE TABLE Requisicao
(
  estado VARCHAR(10) NOT NULL,
  idq INT NOT NULL,
  idu VARCHAR(10) NOT NULL,
  PRIMARY KEY (idq),
  FOREIGN KEY (idu) REFERENCES Utilizador(idu)
);

CREATE TABLE Reservado
(
  essencial VARCHAR(3) NOT NULL,
  idr INT NOT NULL,
  ide INT NOT NULL,
  FOREIGN KEY (idr) REFERENCES Reserva(idr),
  FOREIGN KEY (ide) REFERENCES Equipamento(ide)
);

CREATE TABLE Levantamento
(
  idq INT NOT NULL,
  ide INT NOT NULL,
  FOREIGN KEY (idq) REFERENCES Requisicao(idq),
  FOREIGN KEY (ide) REFERENCES Equipamento(ide)
);