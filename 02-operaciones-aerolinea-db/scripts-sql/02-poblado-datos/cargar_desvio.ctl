load data
 infile './cargar_desvio.csv'
 into table Desvio
 fields terminated by ";"
 trailing nullcols
 ( ID_incidence_d, IATA_desvio )
