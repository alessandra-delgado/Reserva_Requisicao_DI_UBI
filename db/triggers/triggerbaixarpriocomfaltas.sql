DROP TRIGGER IF EXISTS ChangePriorityWithMisses;
GO
CREATE TRIGGER ChangePriorityWithMisses 
ON User_DI 
AFTER UPDATE 
AS 
BEGIN  
	IF EXISTS ( 
		SELECT 1 
		FROM INSERTED 
		JOIN DELETED ON INSERTED.id_user = DELETED.id_user 
		WHERE INSERTED.misses <> DELETED.misses 
	) 
	--this begin block only runs if the faltas column is updated 
	BEGIN
		--atualizar a prioridade e as faltas para alguém que a prioridade ainda é positiva
		UPDATE User_DI 
		SET	current_priority = current_priority - 1, 
		    misses = 0 
		WHERE misses = 5
		AND current_priority > 1

		--atualizar apenas as faltas nas pessoas em que a prioridade já é 0
		UPDATE User_DI 
		SET	misses = 0 
		WHERE misses = 5
		AND current_priority = 1
	END 
END