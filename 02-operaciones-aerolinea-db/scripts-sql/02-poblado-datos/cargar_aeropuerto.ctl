load data
 infile './cargar_aeropuerto.csv'
 into table Aeropuerto
 fields terminated by ";"
 trailing nullcols
 ( IATA, name, city, state )