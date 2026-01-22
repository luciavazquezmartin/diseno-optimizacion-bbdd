load data
 infile './cargar_cancelacion.csv'
 into table Cancelacion
 fields terminated by ";"
 trailing nullcols
 ( ID_incidence_c )