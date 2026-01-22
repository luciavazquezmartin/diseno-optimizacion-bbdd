-- Vista con la edad media de los aviones que operan en cada aeropuerto
WITH MEDIAEDADAERO AS (
	SELECT IATA, NAME, AVG(EDADAVION) AS MEDIAEDADAVIONES
	FROM (
	    -- Seleccionamos de cada aeropuerto, cada avión distinto que haya realizado un vuelo en dicho aeropuerto y su edad.
    	SELECT DISTINCT AEROPUERTO.IATA AS IATA, AEROPUERTO.NAME AS NAME, AVION.TAILNUM, (2025 - AVION.MANUFACTUREYEAR) AS EDADAVION
    	FROM AVION
    	JOIN REALIZA ON (AVION.TAILNUM = REALIZA.TAILNUM_R)
    	JOIN VUELO ON (REALIZA.FLIGHTNUM_R = VUELO.FLIGHTNUM
                    	AND REALIZA.FLIGHTDATE_R = VUELO.FLIGHTDATE
                    	AND REALIZA.CRSDEPTIME_R = VUELO.CRSDEPTIME)
    	JOIN AEROPUERTO ON (VUELO.ORIGINIATA = AEROPUERTO.IATA
                        	OR VUELO.DESTIATA = AEROPUERTO.IATA)
	)
	GROUP BY IATA, NAME
)
-- Seleccionamos el aeropuerto con menor edad media de los aviones que operan en él
SELECT * FROM MEDIAEDADAERO
WHERE MEDIAEDADAVIONES = (
    -- Seleccionamos la menor edad media de la vista
	SELECT MIN(MEDIAEDADAVIONES) AS MEDIAEDADAVIONES
	FROM MEDIAEDADAERO
);
