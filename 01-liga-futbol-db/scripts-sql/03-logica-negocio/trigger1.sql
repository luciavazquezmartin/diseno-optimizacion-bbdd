CREATE OR REPLACE TRIGGER trg_BI_equipos_distintos
BEFORE INSERT ON Partido
FOR EACH ROW
WHEN (NEW.Equipo_local = NEW.Equipo_visitante)
BEGIN
	raise_application_error (-20000, 'El equipo local y el equipo visitante no pueden ser el mismo.');
END;
/
