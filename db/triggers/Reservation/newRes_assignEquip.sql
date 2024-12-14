DROP TRIGGER IF EXISTS newRes_assignEquip;
GO
CREATE TRIGGER newRes_assignEquip
ON Res_Equip
AFTER INSERT
AS
BEGIN
	DECLARE @id_equip INT = (SELECT id_equip FROM INSERTED);
	EXEC AssignEquipmentToUser ide
END
