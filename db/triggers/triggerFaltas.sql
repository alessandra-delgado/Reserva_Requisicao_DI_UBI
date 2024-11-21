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
		UPDATE Utilizador
		SET	prioridade_corrente = prioridade_corrente - 1,
		    faltas = 0
		WHERE faltas = 5
	END
END