--só funciona se formos mudar as reservas já satisfeitas para outra tabela
CREATE TRIGGER AvailToReservedEqui
ON Equipamento
AFTER UPDATE
AS
BEGIN 
	IF EXISTS (
		SELECT 1
		FROM INSERTED
		JOIN DELETED ON INSERTED.ide = DELETED.ide
		WHERE INSERTED.estado = 'Available'
		AND DELETED.estado = 'InUse'
	)
	--this begin block only runs if the faltas column is updated
	BEGIN
		UPDATE Equipamento
		SET	Equipamento.estado = 'Reserved'
		WHERE ide IN (
			SELECT r.ide
			FROM ReservaPossuiEquipamento r
			GROUP BY r.ide
			HAVING COUNT(idr) > 1
		)
	END
END