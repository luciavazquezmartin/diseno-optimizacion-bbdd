CREATE OR REPLACE TRIGGER trg_AD_eliminar_estadio 
AFTER DELETE ON Estadio
FOR EACH ROW
BEGIN
	UPDATE Equipo
	SET Equipo.Nombre_e = NULL;
	WHERE Equipo.Nombre_e = :OLD.Nombre;
END;
/
