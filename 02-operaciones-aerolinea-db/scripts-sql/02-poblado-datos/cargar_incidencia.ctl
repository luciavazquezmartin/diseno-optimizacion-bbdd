load data
 infile './cargar_incidencia.csv'
 into table Incidencia
 fields terminated by ";"
 trailing nullcols
 (ID_incidence, flightDate_i, flightNum_i, crsDepTime_i)
