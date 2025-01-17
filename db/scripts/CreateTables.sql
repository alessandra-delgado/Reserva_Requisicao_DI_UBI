CREATE TABLE TblRes_SeqId
(
    current_year INT PRIMARY KEY,
    current_seq  INT
);

CREATE TABLE TblPriority_Map
(
    id_priority   INT        NOT NULL,
    desc_priority VARCHAR(6) NOT NULL,
    PRIMARY KEY (id_priority)
);

CREATE TABLE TblUser_Priority
(
    id_type       VARCHAR(2)  NOT NULL,
    id_priority   INT,
    desc_userType VARCHAR(12) NOT NULL,
    PRIMARY KEY (id_type),
    FOREIGN KEY (id_priority) REFERENCES TblPriority_Map (id_priority)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE TblUser_DI
(
    id_user          VARCHAR(10) NOT NULL UNIQUE,
    id_type          VARCHAR(2)  NOT NULL,
    name             VARCHAR(50) NOT NULL,
    current_priority INT         NOT NULL DEFAULT 3,
    phone_no         INT         NOT NULL UNIQUE,
    misses           INT                  DEFAULT 0,
    hits             INT                  DEFAULT 0,

    CONSTRAINT CHK_TYPE CHECK (id_type IN ('PD', 'PR', 'RS', 'BS', 'MS', 'DS', 'SF', 'XT')),
    CONSTRAINT CHK_PRIORITY CHECK (current_priority BETWEEN 1 AND 5),
    CONSTRAINT CHK_MISSES CHECK (misses BETWEEN 0 AND 5),
    CONSTRAINT CHK_HITS CHECK (hits BETWEEN 0 AND 2),

    PRIMARY KEY (id_user),
    FOREIGN KEY (id_type) REFERENCES TblUser_Priority (id_type)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE TblContact
(
    id_user VARCHAR(10) NOT NULL UNIQUE,
    email   VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_user),
    FOREIGN KEY (id_user) REFERENCES TblUser_DI (id_user)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE TblEquipment
(
    id_equip     INT IDENTITY (1,1),
    status_equip VARCHAR(10) NOT NULL DEFAULT 'Available',
    name_equip   VARCHAR(50) NOT NULL,
    category     VARCHAR(13),
    CONSTRAINT CHK_STATUS_EQUIPMENT CHECK (status_equip IN ('Available', 'Reserved', 'InUse')),
    PRIMARY KEY (id_equip)
);

CREATE TABLE TblReservation
(
    id_reserv  VARCHAR(8)  NOT NULL UNIQUE DEFAULT 'N/A',
    id_user    VARCHAR(10) NOT NULL,
    reg_date   DATETIME    NOT NULL,
    time_start DATETIME    NOT NULL,
    time_end   DATETIME    NOT NULL,
    status_res VARCHAR(12) NOT NULL,

    CONSTRAINT CHECK_STATUS_RESERVATION CHECK (status_res IN
                                               ('Active', 'Satisfied', 'Cancelled', 'Forgotten', 'Waiting',
                                                'NotSatisfied' , 'Suspended')),
    PRIMARY KEY (id_reserv),
    FOREIGN KEY (id_user) REFERENCES TblUser_DI (id_user)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE TblRequisition
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
    FOREIGN KEY (id_user) REFERENCES TblUser_DI (id_user)
);

CREATE TABLE TblRes_Equip
(
    id_reserv   VARCHAR(8),
    id_equip    INT NOT NULL,
    essential   BIT NOT NULL,
    assigned_to BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_reserv) REFERENCES TblReservation (id_reserv)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (id_equip) REFERENCES TblEquipment (id_equip)
        ON DELETE NO ACTION ON UPDATE CASCADE,
);

CREATE TABLE TblReq_Equip
(
    id_req   INT NOT NULL,
    id_equip INT NOT NULL,
    FOREIGN KEY (id_req) REFERENCES TblRequisition (id_req)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (id_equip) REFERENCES TblEquipment (id_equip)
        ON DELETE NO ACTION ON UPDATE CASCADE,
);

CREATE TABLE TblDevolution
(
    id_req      INT      NOT NULL,
    id_equip    INT      NOT NULL,
    return_date DATETIME NOT NULL,
    PRIMARY KEY (id_req, id_equip),
    FOREIGN KEY (id_req) REFERENCES TblRequisition (id_req),
    FOREIGN KEY (id_equip) REFERENCES TblEquipment (id_equip)
);
