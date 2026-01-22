load data
 infile './cargar_avion.csv'
 into table Avion
 fields terminated by ";"
 trailing nullcols
 ( tailNum, manufactureYear, planeManufacturer, planeModel, planeEngineType )
