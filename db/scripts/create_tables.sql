CREATE TABLE Res_SeqId
(
	current_year INT PRIMARY KEY,
    current_seq INT
);
--Perguntar ao stor se no esquema fica s� l� � parte

CREATE TABLE Priority_Map --horrible criation not anymore (what did it even do D:)
(
  id_priority INT NOT NULL,
  desc_priority VARCHAR(6) NOT NULL,
  PRIMARY KEY (id_priority)
);

CREATE TABLE User_Priority
(
  id_type VARCHAR(2) NOT NULL,
  id_priority INT,
  desc_userType VARCHAR(12) NOT NULL,
  default_priority int NOT NULL,
  PRIMARY KEY (id_type),
  FOREIGN KEY (id_priority) REFERENCES Priority_Map(id_priority)
			ON Delete No ACTION On UpDate No Action,
);

CREATE TABLE User_DI
(
  id_user VARCHAR(10) NOT NULL UNIQUE,
  id_type VARCHAR(2) NOT NULL,
  current_priority INT NOT NULL DEFAULT 3,
  phone_no INT NOT NULL UNIQUE,
  misses int DEFAULT 0,
  hits int default 0,

  CONSTRAINT CHK_TIPO CHECK (id_type in ('PD', 'PR', 'RS', 'BS', 'MS', 'DS', 'SF', 'XT')),
  CONSTRAINT CHK_prio CHECK (current_priority BETWEEN 1 AND 5), 
  CONSTRAINT CHK_faltas CHECK (misses BETWEEN 0 AND 5),
  CONSTRAINT CHK_ACERTOS CHECK (hits BETWEEN 0 AND 2),

  PRIMARY KEY (id_user),
  FOREIGN KEY (id_type) REFERENCES User_Priority(id_type)
			ON Delete No ACTION On UpDate No Action,
);

CREATE TABLE Contacts
(
  id_user VARCHAR(10) NOT NULL UNIQUE,
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_user),
  FOREIGN KEY (id_user) REFERENCES User_DI(id_user)
			ON Delete No ACTION On UpDate No Action,
);

CREATE TABLE Equipments
(
  id_equip INT IDENTITY(1,1),
  status_equip VARCHAR(10) NOT NULL DEFAULT 'Available',
  name_equip VARCHAR(50) NOT NULL,
  category VARCHAR(13),
  PRIMARY KEY (id_equip)
);

CREATE TABLE Reservations
(
  id_reserv VARCHAR(8) NOT NULL UNIQUE,
  id_user VARCHAR(10) NOT NULL,
  reg_data DATE NOT NULL,
  time_start DATETIME NOT NULL,
  time_end DATETIME NOT NULL,
  status_res VARCHAR(10) NOT NULL,

  CONSTRAINT CHECK_STATUS CHECK (status_res in ('Active', 'Satisfied', 'Cancelled', 'Forgotten', 'Waiting')), 
  PRIMARY KEY (id_reserv),
  FOREIGN KEY (id_user) REFERENCES User_DI(id_user)
			ON Delete No ACTION On UpDate No ACTION,
);

CREATE TABLE Requisitions
(
  id_req INT NOT NULL IDENTITY(1,1),
  id_user VARCHAR(10) NOT NULL,
  status_req VARCHAR(10) NOT NULL DEFAULT 'Active',
  time_start DATETIME NOT NULL,
  time_end DATETIME NOT NULL,
  returned INT DEFAULT 0,
  collected INT DEFAULT -1,

  CONSTRAINT CHK_COLLECTED check (collected >= -1),
  CONSTRAINT CHK_RETURN CHECK (returned >= 0),
  CONSTRAINT CHK_STATUS CHECK (status_req in ('Active', 'Closed')),
  PRIMARY KEY (id_req),
  FOREIGN KEY (id_user) REFERENCES User_DI(id_user)
);

CREATE TABLE Res_Equip
(
  id_reserv VARCHAR(8),
  id_equip INT NOT NULL,
  essential BIT NOT NULL,
  assigned_to BIT NOT NULL DEFAULT 0,
  --estado VARCHAR(10), (DA RESERVA?)
  FOREIGN KEY (id_reserv) REFERENCES Reservations(id_reserv)
			ON Delete No ACTION On UpDate Cascade,
  FOREIGN KEY (id_equip) REFERENCES Equipments(id_equip)
			ON Delete No ACTION On UpDate Cascade,
);

CREATE TABLE Req_Equip
(
  id_req INT NOT NULL,
  id_equip INT NOT NULL,
  FOREIGN KEY (id_req) REFERENCES Requisitions(id_req)
			ON Delete No ACTION On UpDate Cascade,
  FOREIGN KEY (id_equip) REFERENCES Equipments(id_equip)
			ON Delete No ACTION On UpDate Cascade,
);

CREATE TABLE Devolution
(
  id_req INT NOT NULL,
  id_equip INT NOT NULL,
  return_date DATETIME NOT NULL,
  PRIMARY KEY (id_req, id_equip),
  FOREIGN KEY (id_req) REFERENCES Requisitions (id_req),
  FOREIGN KEY (id_equip) REFERENCES Equipments (id_equip)
);
