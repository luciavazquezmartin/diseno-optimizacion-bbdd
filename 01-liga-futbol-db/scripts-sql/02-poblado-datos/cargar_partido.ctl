load data
 infile './cargar_partido.csv'
 into table Partido
 fields terminated by ","
 trailing nullcols
 ( Jornada, Equipo_local, Equipo_visitante, Division_p, Inicio_temporada_p, Puntos_local, Puntos_visitante )
