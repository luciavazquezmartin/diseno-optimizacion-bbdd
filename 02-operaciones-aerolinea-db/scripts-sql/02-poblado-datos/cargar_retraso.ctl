load data
 infile './cargar_retraso.csv'
 into table Retraso
 fields terminated by ";"
 trailing nullcols
 ( ID_incidence_r, cause, delay )
