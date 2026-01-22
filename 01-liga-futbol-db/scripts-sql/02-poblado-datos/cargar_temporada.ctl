load data
 infile './cargar_temporada.csv'
 into table Temporada
 fields terminated by ","
 trailing nullcols
 ( Inicio_temporada )
