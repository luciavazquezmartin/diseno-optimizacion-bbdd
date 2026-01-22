-- Seleccionamos todos los datos del aeropuerto (IATA, nombre y edad media de aviones)
SELECT * FROM AEROMEDIAEDADAVION
-- Filtramos para quedarnos solo con el aeropuerto que tiene la menor edad media de aviones
WHERE MEDIAEDADAVIONES = (
	-- Subconsulta que obtiene la menor edad media registrada
	SELECT MIN(MEDIAEDADAVIONES)
	FROM AEROMEDIAEDADAVION
);
