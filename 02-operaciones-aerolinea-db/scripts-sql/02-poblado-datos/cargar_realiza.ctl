load data
 infile './cargar_realiza.csv'
 into table realiza
 fields terminated by ";"
 trailing nullcols
 ( tailNum_r, flightDate_r, flightNum_r, crsDepTime_r )