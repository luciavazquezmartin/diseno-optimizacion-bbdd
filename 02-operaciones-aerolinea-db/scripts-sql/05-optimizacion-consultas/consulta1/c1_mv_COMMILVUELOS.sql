-- Creamos una vista materializada para identificar aerol�neas con 1000 vuelos diarios
CREATE MATERIALIZED VIEW COMMILVUELOS AS (
    -- Seleccionamos c�digo y nombre de aerol�nea
    SELECT CARRIERCODE, CARRIERNAME
    FROM AEROLINEA
    WHERE CARRIERCODE NOT IN (
        -- Seleccionamos las aerolineas que, al menos un dia, hayan hecho menos de 1000 vuelos
        SELECT DISTINCT CARRIERCODE_A
        FROM VUELO
        -- Agrupamos por d�a y aerol�nea (cada d�a cuenta por separado)
        GROUP BY FLIGHTDATE, CARRIERCODE_A
        HAVING COUNT(*) < 1000
    )
);
