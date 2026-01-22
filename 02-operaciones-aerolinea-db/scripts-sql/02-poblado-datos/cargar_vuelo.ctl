load data
 infile './cargar_vuelo.csv'
 into table Vuelo
 fields terminated by ";"
 trailing nullcols
 ( flightDate, flightNum, crsDepTime, crsElapsedTime, crsArrTime, originiata, destiata, carrierCode_a )
