load data
 infile './cargar_equipo.csv'
 into table Equipo
 fields terminated by ","
 trailing nullcols
 ( Nombre_Corto, Nombre_Oficial, Ciudad, Fecha_fundacion, Nombre_Historico, Nombre_e )
