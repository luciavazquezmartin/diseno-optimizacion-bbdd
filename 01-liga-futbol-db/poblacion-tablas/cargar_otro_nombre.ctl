load data
 infile './cargar_otro_nombre.csv'
 into table Otro_nombre
 fields terminated by ","
 trailing nullcols
 ( Nombre_Corto_o, Otros_Nombres )
