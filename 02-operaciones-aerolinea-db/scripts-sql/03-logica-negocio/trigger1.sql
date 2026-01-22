CREATE OR REPLACE TRIGGER trg_BI_cancelacion_exclusiva
BEFORE INSERT ON Cancelacion
FOR EACH ROW
DECLARE
	existe_retraso NUMBER;
	existe_desvio NUMBER;
BEGIN
	-- Comprobamos si la incidencia se encuentra ya en Retraso
	SELECT COUNT(*) INTO existe_retraso FROM Retraso
	WHERE ID_incidence_r = :NEW.ID_incidence_c;

	-- Comprobamos si la incidencia se encuentra ya en Desvio
	SELECT COUNT(*) INTO existe_desvio FROM Desvio
	WHERE ID_incidence_d = :NEW.ID_incidence_c;

	-- Si está presente en cualquiera, no se puede insertar en Cancelacion
	IF existe_retraso > 0 OR existe_desvio > 0 THEN
    		raise_application_error(-20000, 'La incidencia ya ha sido registrada
como retraso o desvio. No puede ser tambien una cancelacion.');
	END IF;
END;
/
