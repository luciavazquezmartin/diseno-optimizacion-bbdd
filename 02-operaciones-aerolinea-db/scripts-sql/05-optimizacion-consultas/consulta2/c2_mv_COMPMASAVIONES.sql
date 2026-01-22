-- Creamos una vista materializada para obtener la aerolínea con más aviones diferentes operando
CREATE MATERIALIZED VIEW COMPMASAVIONES AS (
    -- Seleccionamos el código de aerolínea y el número de aviones distintos que ha utilizado
    SELECT CARRIERCODE, COUNT(DISTINCT REALIZA.TAILNUM_R) AS NUMAVIONES
    FROM REALIZA
    -- Unimos la tabla REALIZA con VUELO para identificar correctamente cada vuelo
    JOIN VUELO ON (REALIZA.FLIGHTDATE_R = VUELO.FLIGHTDATE AND
                   REALIZA.FLIGHTNUM_R = VUELO.FLIGHTNUM AND
                   REALIZA.CRSDEPTIME_R = VUELO.CRSDEPTIME)
    -- Unimos con AEROLINEA para obtener el código real de la aerolínea
    JOIN AEROLINEA ON (VUELO.CARRIERCODE_A = AEROLINEA.CARRIERCODE)
    -- Agrupamos por aerolínea para contar cuántos aviones distintos ha operado cada una
    GROUP BY CARRIERCODE
    -- Solo dejamos aquellas aerolíneas cuyo número de aviones coincide con el máximo global
    HAVING COUNT(DISTINCT REALIZA.TAILNUM_R) = (
        -- Subconsulta que calcula ese máximo global de aviones distintos por aerolínea
        SELECT MAX(NUMAVIONES)
        FROM (
            SELECT CARRIERCODE, COUNT(DISTINCT REALIZA.TAILNUM_R) AS NUMAVIONES
            FROM REALIZA
            JOIN VUELO ON (REALIZA.FLIGHTDATE_R = VUELO.FLIGHTDATE AND
                           REALIZA.FLIGHTNUM_R = VUELO.FLIGHTNUM AND
                           REALIZA.CRSDEPTIME_R = VUELO.CRSDEPTIME)
            JOIN AEROLINEA ON (VUELO.CARRIERCODE_A = AEROLINEA.CARRIERCODE)
            GROUP BY CARRIERCODE
        )
    )
);
