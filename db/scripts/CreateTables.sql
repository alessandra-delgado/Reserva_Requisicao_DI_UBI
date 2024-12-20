CREATE TABLE Res_SeqId
(
    current_year INT PRIMARY KEY,
    current_seq  INT
);
--Perguntar ao stor se no esquema fica s� l� � parte

CREATE TABLE Priority_Map --horrible creation not anymore (what did it even do D:)
(
    id_priority   INT        NOT NULL,
    desc_priority VARCHAR(6) NOT NULL,
    PRIMARY KEY (id_priority)
);

CREATE TABLE User_Priority
(
    id_type          VARCHAR(2)  NOT NULL,
    id_priority      INT,
    desc_userType    VARCHAR(12) NOT NULL,
    PRIMARY KEY (id_type),
    FOREIGN KEY (id_priority) REFERENCES Priority_Map (id_priority)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE User_DI
(
    id_user          VARCHAR(10) NOT NULL UNIQUE,
    id_type          VARCHAR(2)  NOT NULL,
    current_priority INT         NOT NULL DEFAULT 3,
    phone_no         INT         NOT NULL UNIQUE,
    misses           INT                  DEFAULT 0,
    hits             INT                  DEFAULT 0,

    CONSTRAINT CHK_TIPO CHECK (id_type IN ('PD', 'PR', 'RS', 'BS', 'MS', 'DS', 'SF', 'XT')),
    CONSTRAINT CHK_prio CHECK (current_priority BETWEEN 1 AND 5),
    CONSTRAINT CHK_faltas CHECK (misses BETWEEN 0 AND 5),
    CONSTRAINT CHK_ACERTOS CHECK (hits BETWEEN 0 AND 2),

    PRIMARY KEY (id_user),
    FOREIGN KEY (id_type) REFERENCES User_Priority (id_type)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Contact
(
    id_user VARCHAR(10) NOT NULL UNIQUE,
    email   VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_user),
    FOREIGN KEY (id_user) REFERENCES User_DI (id_user)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Equipment
(
    id_equip     INT IDENTITY (1,1),
    status_equip VARCHAR(10) NOT NULL DEFAULT 'Available',
    name_equip   VARCHAR(50) NOT NULL,
    category     VARCHAR(13),
    CONSTRAINT CHK_STATUS_EQUIPMENT CHECK (status_equip IN ('Available', 'Reserved', 'InUse')),
    PRIMARY KEY (id_equip)
);

CREATE TABLE Reservation
(
    id_reserv  VARCHAR(8)  NOT NULL UNIQUE DEFAULT 'N/A',
    id_user    VARCHAR(10) NOT NULL,
    reg_date   DATETIME    NOT NULL,
    time_start DATETIME    NOT NULL,
    time_end   DATETIME    NOT NULL,
    status_res VARCHAR(12) NOT NULL,

    CONSTRAINT CHECK_STATUS_RESERVATION CHECK (status_res IN ('Active', 'Satisfied', 'Cancelled', 'Forgotten', 'Waiting', 'NotSatisfied')),
    PRIMARY KEY (id_reserv),
    FOREIGN KEY (id_user) REFERENCES User_DI (id_user)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Requisition
(
    id_req     INT         NOT NULL IDENTITY (1,1),
    id_user    VARCHAR(10) NOT NULL,
    status_req VARCHAR(10) NOT NULL DEFAULT 'Active',
    time_start DATETIME    NOT NULL,
    time_end   DATETIME    NOT NULL,
    returned   INT                  DEFAULT 0,
    collected  INT                  DEFAULT -1,

    CONSTRAINT CHK_COLLECTED CHECK (collected >= -1),
    CONSTRAINT CHK_RETURN CHECK (returned >= 0),
    CONSTRAINT CHK_STATUS_REQUISITION CHECK (status_req IN ('Active', 'Closed')),
    PRIMARY KEY (id_req),
    FOREIGN KEY (id_user) REFERENCES User_DI (id_user)
);

CREATE TABLE Res_Equip
(
    id_reserv   VARCHAR(8),
    id_equip    INT NOT NULL,
    essential   BIT NOT NULL,
    assigned_to BIT NOT NULL DEFAULT 0,
    --estado VARCHAR(10), (DA RESERVA?)
    FOREIGN KEY (id_reserv) REFERENCES Reservation (id_reserv)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (id_equip) REFERENCES Equipment (id_equip)
        ON DELETE NO ACTION ON UPDATE CASCADE,
);

CREATE TABLE Req_Equip
(
    id_req   INT NOT NULL,
    id_equip INT NOT NULL,
    FOREIGN KEY (id_req) REFERENCES Requisition (id_req)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (id_equip) REFERENCES Equipment (id_equip)
        ON DELETE NO ACTION ON UPDATE CASCADE,
);

CREATE TABLE Devolution
(
    id_req      INT      NOT NULL,
    id_equip    INT      NOT NULL,
    return_date DATETIME NOT NULL,
    PRIMARY KEY (id_req, id_equip),
    FOREIGN KEY (id_req) REFERENCES Requisition (id_req),
    FOREIGN KEY (id_equip) REFERENCES Equipment (id_equip)
);
