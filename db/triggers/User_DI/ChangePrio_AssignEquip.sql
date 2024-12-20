DROP TRIGGER IF EXISTS PrioChange_AssignEquip
GO
CREATE TRIGGER PrioChange_AssignEquip
ON
User_DI
AFTER UPDATE
AS
IF EXISTS (
	SELECT 1 
	FROM INSERTED I
	INNER JOIN DELETED D ON I.id_user = D.id_user
	WHERE I.current_priority != D.current_priority
)
BEGIN
	DECLARE @id_user INT = (
		SELECT I.id_user 
		FROM INSERTED I
		INNER JOIN DELETED D ON I.id_user = D.id_user
		WHERE I.current_priority != D.current_priority
		)

	DECLARE id_go_reserv CURSOR FOR
		SELECT id_reserv FROM Res_ed
END