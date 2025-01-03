USE teste_di
GO

DROP VIEW IF EXISTS UserInfo
GO
CREATE VIEW UserInfo
AS SELECT u.id_user AS Identification, up.desc_userType AS 'Position', 
    u.name AS Name, u.phone_no AS 'Phone number', COALESCE(c.email, '') AS 'Email'
	FROM TblUser_DI u
	JOIN TblUser_Priority up ON u.id_type = up.id_type
	LEFT JOIN TblContact c ON u.id_user = c.id_user;
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
AS SELECT r.id_user AS 'User', r.id_reserv AS 'Reservation id', r.time_start AS 'Start time',
   CASE 
        WHEN DATEDIFF(DAY, GETDATE(), r.time_start) = 0 
        THEN CAST(DATEDIFF(HOUR, GETDATE(), r.time_start) AS NVARCHAR) + ' hours'
        ELSE CAST(DATEDIFF(DAY, GETDATE(), r.time_start) AS NVARCHAR) + ' days'
    END AS [Time left to start]
   ,r.status_res AS 'Status'
   FROM TblReservation r
   WHERE r.status_res IN ('Active', 'Waiting')
GO

DROP VIEW IF EXISTS PendingRequisitions
GO
CREATE VIEW PendingRequisitions
AS SELECT r.id_user AS 'User', r.id_req AS 'Requisition id', r.time_end AS 'End time',
   CASE 
        WHEN DATEDIFF(DAY, GETDATE(), r.time_end) = 0 
        THEN CAST(DATEDIFF(HOUR, GETDATE(), r.time_end) AS NVARCHAR) + ' hours'
        ELSE CAST(DATEDIFF(DAY, GETDATE(), r.time_end) AS NVARCHAR) + ' days'
    END AS [Time left to end]
   ,r.status_req AS 'Status'
   FROM TblRequisition r
   WHERE r.status_req LIKE 'Active'
GO

DROP VIEW IF EXISTS ResourceState
GO
CREATE VIEW ResourceState
AS SELECT e.id_equip AS 'Equipment ID', e.name_equip AS 'Name', e.status_equip AS 'Status', 
     CASE 
        WHEN r.id_reserv IS NOT NULL THEN r.id_reserv
        WHEN req.id_req IS NOT NULL THEN CAST(req.id_req AS VARCHAR)
        ELSE ''
    END AS 'Assignment ID',
	CASE 
        WHEN r.id_reserv IS NOT NULL THEN r.id_user
        WHEN req.id_req IS NOT NULL THEN req.id_user
        ELSE ''
    END AS 'User ID'
   FROM TblEquipment e
   LEFT JOIN TblRes_Equip re ON e.id_equip = re.id_equip
   LEFT JOIN TblReservation r ON re.id_reserv = r.id_reserv
   LEFT JOIN TblReq_Equip reqe ON e.id_equip = reqe.id_equip
   LEFT JOIN TblRequisition req ON reqe.id_req = req.id_req;
GO

DROP VIEW IF EXISTS RankedRequisition
GO
CREATE VIEW RankedRequisition AS
 SELECT 
        e.id_equip AS 'Equipment ID',
        e.name_equip AS 'Name',
        e.status_equip AS 'Status',
        e.category AS 'Category',
        r.id_req AS 'Requisition ID',
        r.time_end AS 'Requisition End Time',
        u.name AS 'Last User Name',
        u.current_priority AS 'Priority',
		r.status_req,
    ROW_NUMBER() OVER (PARTITION BY e.id_equip ORDER BY r.time_end DESC) AS rn 
    FROM TblEquipment e
    LEFT JOIN TblReq_Equip re ON e.id_equip = re.id_equip
    LEFT JOIN TblRequisition r ON re.id_req = r.id_req
    LEFT JOIN TblUser_DI u ON r.id_user = u.id_user
    LEFT JOIN TblUser_Priority up ON u.id_type = up.id_type
    LEFT JOIN TblPriority_Map pm ON up.id_priority = pm.id_priority
	WHERE r.status_req LIKE 'Closed'
go

DROP VIEW IF EXISTS ViewEquipmentLastPriority
GO
CREATE VIEW ViewEquipmentLastPriority AS
SELECT
    'Equipment ID' = [Equipment ID],
    'Name' = [Name],
    'Status' = [Status],
    'Category' = [Category],
    'Last User Name' = [Last User Name],
    'Priority' = [Priority]
FROM RankedRequisition
WHERE rn = 1; 
go
