-- Seleccionamos todos los aeropuertos
SELECT * FROM AEROPUERTO
-- Filtramos solo los que están en Alaska (AK) o California (CA)
WHERE (STATE = 'AK' OR STATE = 'CA')
  -- Y además, se cumple al menos una de las siguientes condiciones:
  AND (
    -- 1) El aeropuerto NO ha sido origen de vuelos de la aerolínea con más aviones
    IATA NOT IN (
      SELECT ORIGINIATA
      FROM VUELO
      WHERE CARRIERCODE_A = (SELECT CARRIERCODE FROM COMPMASAVIONES)
    )
    -- 2) El aeropuerto NO ha sido destino de vuelos de esa misma aerolínea
    OR IATA NOT IN (
      SELECT DESTIATA
      FROM VUELO
      WHERE CARRIERCODE_A = (SELECT CARRIERCODE FROM COMPMASAVIONES)
    )
  )
ORDER BY NAME;
  