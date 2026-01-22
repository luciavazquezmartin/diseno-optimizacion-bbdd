load data
 infile './cargar_aerolinea.csv'
 into table Aerolinea
 fields terminated by ";"
 trailing nullcols
 ( carrierCode, carrierName )