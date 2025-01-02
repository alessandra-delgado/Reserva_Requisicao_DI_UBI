USE teste_di
GO

DROP VIEW IF EXISTS UserInfo
GO
CREATE VIEW UserInfo
AS SELECT u.id_user AS Identification, up.desc_userType AS 'Position', u.name AS Name, u.phone_no AS 'Phone number'
   FROM TblUser_DI u, TblUser_Priority up
   WHERE u.id_type = up.id_type
GO

DROP VIEW IF EXISTS UserPriority
GO
CREATE VIEW UserPriority
AS SELECT u.id_user AS Identification, u.name AS Name, p.desc_priority AS Priority
   FROM TblUser_DI u, TblUser_Priority up, TblPriority_Map p
   WHERE u.id_type = up.id_type
   AND up.id_priority = p.id_priority
GO

DROP VIEW IF EXISTS ActiveReservations
GO
CREATE VIEW ActiveReservations
AS SELECT r.id_user AS 'User', r.id_reserv AS 'Reservation id', r.time_start AS 'Due date',
   CASE 
        WHEN DATEDIFF(DAY, GETDATE(), r.time_start) = 0 
        THEN CAST(DATEDIFF(HOUR, GETDATE(), r.time_start) AS NVARCHAR) + ' hours'
        ELSE CAST(DATEDIFF(DAY, GETDATE(), r.time_start) AS NVARCHAR) + ' days'
    END AS [Time left to start]
   ,r.status_res AS 'Status'
   FROM TblReservation r
   WHERE r.status_res IN ('Active', 'Waiting')
GO

SELECT * FROM TblUser_DI