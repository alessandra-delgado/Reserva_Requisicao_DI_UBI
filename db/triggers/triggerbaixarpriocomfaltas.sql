DROP TRIGGER IF EXISTS MudarPrioridadeComFaltas;
GO
CREATE TRIGGER MudarPrioridadeComFaltas 
ON Utilizador 
AFTER UPDATE 
AS 
BEGIN  
	IF EXISTS ( 
		SELECT 1 
		FROM INSERTED 
		JOIN DELETED ON INSERTED.idu = DELETED.idu 
		WHERE INSERTED.faltas <> DELETED.faltas 
	) 
	--this begin block only runs if the faltas column is updated 
	BEGIN
		--atualizar a prioridade e as faltas para alguém que a prioridade ainda é positiva
		UPDATE Utilizador 
		SET	prioridade_corrente = prioridade_corrente - 1, 
		    faltas = 0 
		WHERE faltas = 5
		AND prioridade_corrente > 1

		--atualizar apenas as faltas nas pessoas em que a prioridade já é 0
		UPDATE Utilizador 
		SET	faltas = 0 
		WHERE faltas = 5
		AND prioridade_corrente = 1
	END 
END