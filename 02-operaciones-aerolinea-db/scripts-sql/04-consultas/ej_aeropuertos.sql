-- Vista que calcula la compañia con mas aviones
WITH COMPMASAVIONES AS (
    -- De cada aerolinea agrupamos por aerolinea y contamos el nº de tailnums distintos
	SELECT DISTINCT CARRIERCODE, COUNT(DISTINCT REALIZA.TAILNUM_R) AS NUMAVIONES
	FROM REALIZA 
	JOIN VUELO ON (REALIZA.FLIGHTDATE_R = VUELO.FLIGHTDATE
					AND REALIZA.FLIGHTNUM_R = VUELO.FLIGHTNUM
					AND REALIZA.CRSDEPTIME_R = VUELO.CRSDEPTIME)
	JOIN AEROLINEA ON (VUELO.CARRIERCODE_A = AEROLINEA.CARRIERCODE)
	GROUP BY CARRIERCODE
	-- Seleccionamos la aerolinea, cuyo nº de aviones sea igual al máximo
	HAVING COUNT(DISTINCT REALIZA.TAILNUM_R) = (	
	    -- Nos quedamos con el nº mayor
		SELECT MAX(NUMAVIONES)
		FROM (
		    -- De cada aerolinea agrupamos por aerolinea y contamos el nº de tailnums distintos
			SELECT DISTINCT CARRIERCODE, COUNT(DISTINCT REALIZA.TAILNUM_R) AS NUMAVIONES
			FROM REALIZA 
			JOIN VUELO ON (REALIZA.FLIGHTDATE_R = VUELO.FLIGHTDATE
							AND REALIZA.FLIGHTNUM_R = VUELO.FLIGHTNUM
							AND REALIZA.CRSDEPTIME_R = VUELO.CRSDEPTIME)
			JOIN AEROLINEA ON (VUELO.CARRIERCODE_A = AEROLINEA.CARRIERCODE)
			GROUP BY CARRIERCODE
		)
	)
)
SELECT DISTINCT * FROM AEROPUERTO
-- Seleccionamos los aeropuertos que esten en el estado de 'Alaska' ó 'California'
WHERE (STATE = 'AK' OR STATE = 'CA')
AND (
-- Seleccionamos aquellos cuyo IATA no haya realizado ningún vuelo con la compañia de mas aviones
    IATA NOT IN (
        SELECT ORIGINIATA FROM VUELO
        WHERE CARRIERCODE_A = (
            SELECT CARRIERCODE FROM COMPMASAVIONES
        )
    )
    OR
    IATA NOT IN (
        SELECT DESTIATA FROM VUELO
        WHERE CARRIERCODE_A = (
            SELECT CARRIERCODE FROM COMPMASAVIONES
        )
    )
)
ORDER BY NAME ASC;
