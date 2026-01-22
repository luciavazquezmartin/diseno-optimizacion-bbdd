-- Creamos una vista materializada que calcula la edad media de los aviones
-- que operan en cada aeropuerto (tanto como origen como destino)
CREATE MATERIALIZED VIEW AEROMEDIAEDADAVION AS (
	-- Calculamos el promedio de edad de los aviones por aeropuerto
	SELECT IATA, NAME, AVG(EDADAVION) AS MEDIAEDADAVIONES
	FROM (
		-- Subconsulta: obtenemos la edad de cada avión y el aeropuerto en el que opera
		SELECT DISTINCT AEROPUERTO.IATA AS IATA, AEROPUERTO.NAME AS NAME, AVION.TAILNUM, (2025 - AVION.MANUFACTUREYEAR) AS EDADAVION
		FROM AVION
		-- Relacionamos avión con vuelos realizados
		JOIN REALIZA ON (AVION.TAILNUM = REALIZA.TAILNUM_R)
		-- Obtenemos los datos del vuelo correspondiente
		JOIN VUELO ON (REALIZA.FLIGHTNUM_R = VUELO.FLIGHTNUM
						AND REALIZA.FLIGHTDATE_R = VUELO.FLIGHTDATE
						AND REALIZA.CRSDEPTIME_R = VUELO.CRSDEPTIME)
		-- Relacionamos el vuelo con el aeropuerto (como origen o destino)
		JOIN AEROPUERTO ON (VUELO.ORIGINIATA = AEROPUERTO.IATA
							OR VUELO.DESTIATA = AEROPUERTO.IATA)
	)
	-- Agrupamos por aeropuerto para calcular la media de edad de los aviones que pasan por él
	GROUP BY IATA, NAME
);
