CREATE OR REPLACE TRIGGER trg_AD_avion_descatalogado
AFTER DELETE ON Realiza
FOR EACH ROW
BEGIN
  -- Eliminar cancelaciones del vuelo eliminado
  DELETE FROM Cancelacion WHERE ID_incidence_c IN (
    SELECT ID_incidence FROM Incidencia
    WHERE flightDate_i = :OLD.flightDate_r
      AND flightNum_i = :OLD.flightNum_r
      AND crsDepTime_i = :OLD.crsDepTime_r
  );

  -- Eliminar desvíos del vuelo eliminado
  DELETE FROM Desvio WHERE ID_incidence_d IN (
    SELECT ID_incidence FROM Incidencia
    WHERE flightDate_i = :OLD.flightDate_r
      AND flightNum_i = :OLD.flightNum_r
      AND crsDepTime_i = :OLD.crsDepTime_r
  );

  -- Eliminar retrasos del vuelo eliminado
  DELETE FROM Retraso WHERE ID_incidence_r IN (
    SELECT ID_incidence FROM Incidencia
    WHERE flightDate_i = :OLD.flightDate_r
      AND flightNum_i = :OLD.flightNum_r
      AND crsDepTime_i = :OLD.crsDepTime_r
  );

  -- Eliminar incidencia del vuelo eliminado
  DELETE FROM Incidencia
  WHERE flightDate_i = :OLD.flightDate_r
    AND flightNum_i = :OLD.flightNum_r
    AND crsDepTime_i = :OLD.crsDepTime_r;

  -- Eliminar el vuelo (si no está ya eliminado)
  DELETE FROM Vuelo
  WHERE flightDate = :OLD.flightDate_r
    AND flightNum = :OLD.flightNum_r
    AND crsDepTime = :OLD.crsDepTime_r;
END;
/
