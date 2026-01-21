load data
 infile './cargar_estadio.csv'
 into table Estadio
 fields terminated by ","
 trailing nullcols
 ( nombre, Fecha_inag, Capacidad )
