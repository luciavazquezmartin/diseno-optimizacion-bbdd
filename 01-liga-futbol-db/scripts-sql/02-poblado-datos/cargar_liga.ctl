load data
 infile './cargar_liga.csv'
 into table Liga
 fields terminated by ","
 trailing nullcols
 ( Division, Nombre_comercial, Denominacion_oficial )