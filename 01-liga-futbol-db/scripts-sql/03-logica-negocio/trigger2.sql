CREATE OR REPLACE TRIGGER trg_BD_eliminar_temp 
BEFORE DELETE ON Temporada
FOR EACH ROW
DECLARE 
	partidosTemp NUMBER;
BEGIN
	SELECT COUNT(*) INTO partidosTemp FROM Partido
	WHERE Partido.Inicio_temporada_p = :OLD.Inicio_temporada;

	IF partidosTemp > 0 THEN
		raise_application_error (-20000, 'No se puede borrar una temporada si tiene partidos asociados.');
	END IF;
END;
/
