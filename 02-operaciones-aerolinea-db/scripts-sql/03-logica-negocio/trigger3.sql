CREATE OR REPLACE TRIGGER trg_BI_realiza_sin_conflictos
BEFORE INSERT OR UPDATE ON realiza
FOR EACH ROW
DECLARE
    conflictos NUMBER;          -- Variable para contar vuelos en conflicto
    hora_salida_nueva NUMBER;   -- Hora de salida del nuevo vuelo
    hora_llegada_nueva NUMBER;  -- Hora estimada de llegada del nuevo vuelo
BEGIN
    -- Obtenemos la hora de salida y llegada del vuelo que se quiere asignar
    SELECT crsDepTime, TRUNC(crsDepTime/100)*60 + MOD(crsDepTime, 100) + crsElapsedTime
    INTO hora_salida_nueva, hora_llegada_nueva
    FROM Vuelo
    WHERE flightDate = :NEW.flightDate_r
      AND flightNum = :NEW.flightNum_r
      AND crsDepTime = :NEW.crsDepTime_r;

    -- Revisamos si el avión ya tiene otro vuelo solapado ese día
    SELECT COUNT(*) INTO conflictos
    FROM realiza
    JOIN Vuelo ON realiza.flightDate_r = Vuelo.flightDate
               AND realiza.flightNum_r = Vuelo.flightNum
               AND realiza.crsDepTime_r = Vuelo.crsDepTime
    WHERE realiza.tailNum_r = :NEW.tailNum_r        -- Mismo avión
      AND realiza.flightDate_r = :NEW.flightDate_r  -- Mismo día
      -- Verificamos que los vuelos se solapan
      AND NOT (
          -- Vuelo anterior termina antes de que empiece el nuevo
          (Vuelo.crsDepTime + Vuelo.crsElapsedTime) < hora_salida_nueva OR
          -- Vuelo anterior empieza después de que termine el nuevo
          TRUNC(Vuelo.crsDepTime/100)*60 + MOD(Vuelo.crsDepTime, 100) + Vuelo.crsElapsedTime > hora_llegada_nueva

      );

    IF conflictos > 0 THEN
        raise_application_error(-20000,
        'El avion ya esta asignado a otro vuelo que aun no ha aterrizado.');
    END IF;
END;
/
