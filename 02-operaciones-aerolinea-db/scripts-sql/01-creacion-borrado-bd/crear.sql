-- Tabla que almacena información sobre las aerolíneas.
CREATE TABLE Aerolinea (
	carrierCode VARCHAR(7) PRIMARY KEY, -- Código único de la aerolínea.
	carrierName VARCHAR(100) NOT NULL -- Nombre de la aerolínea.
);

-- Tabla que almacena información sobre los aeropuertos.
CREATE TABLE Aeropuerto (
	IATA VARCHAR(3) PRIMARY KEY, -- Código único del aeropuerto (IATA).
	name VARCHAR(50) NOT NULL, -- Nombre del aeropuerto.
	city VARCHAR(40) NOT NULL, -- Ciudad donde se ubica el aeropuerto.
	state VARCHAR(2) NOT NULL -- Estado donde se ubica el aeropuerto.
);

-- Tabla que almacena información sobre los vuelos.
CREATE TABLE Vuelo (
	flightDate VARCHAR(10), -- Fecha del vuelo.
	flightNum NUMBER(4), -- Número de vuelo.
	crsDepTime NUMBER(4) CHECK(crsDepTime > 0), -- Hora programada de salida (formato 24h), debe ser positiva.
	crsElapsedTime NUMBER(3) NOT NULL CHECK(crsElapsedTime > 0), -- Duración estimada del vuelo en minutos.
	crsArrTime NUMBER(4) NOT NULL CHECK(crsArrTime > 0), -- Hora programada de llegada (formato 24h), debe ser positiva.
	originiata VARCHAR(3) NOT NULL, -- Aeropuerto de origen (código IATA).
	destiata VARCHAR(3) NOT NULL, -- Aeropuerto de destino (código IATA).
	carrierCode_a VARCHAR(7), -- Código de la aerolínea que realiza el vuelo.
	FOREIGN KEY(originiata) REFERENCES Aeropuerto(IATA), -- Relación con el aeropuerto de origen.
	FOREIGN KEY(destiata) REFERENCES Aeropuerto(IATA), -- Relación con el aeropuerto de destino.
	FOREIGN KEY(carrierCode_a) REFERENCES Aerolinea(carrierCode), -- Relación con la tabla de aerolíneas.
	PRIMARY KEY (flightDate, flightNum, crsDepTime), -- Clave primaria compuesta para identificar un vuelo único.
	CHECK (originiata <> destiata) -- Un vuelo no puede tener el mismo origen y destino.
);

-- Tabla que almacena incidencias en los vuelos.
CREATE TABLE Incidencia (
	ID_incidence NUMBER(5) PRIMARY KEY, -- Identificador único de la incidencia.
	flightDate_i VARCHAR(10), -- Fecha del vuelo asociado a la incidencia.
	flightNum_i NUMBER(4), -- Número de vuelo asociado.
	crsDepTime_i NUMBER(4), -- Hora programada de salida del vuelo asociado.
	FOREIGN KEY(flightDate_i, flightNum_i, crsDepTime_i) 
	REFERENCES Vuelo(flightDate, flightNum, crsDepTime) -- Relación con la tabla de vuelos.
);

-- Tabla que almacena información sobre cancelaciones de vuelos.
CREATE TABLE Cancelacion (
	ID_incidence_c NUMBER(5), -- Identificador de la incidencia asociada a la cancelación.
	FOREIGN KEY(ID_incidence_c) REFERENCES Incidencia(ID_incidence) -- Relación con la tabla de incidencias.
);

-- Tabla que almacena información sobre retrasos en los vuelos.
CREATE TABLE Retraso (
	ID_incidence_r NUMBER(5), -- Identificador de la incidencia asociada al retraso.
	cause VARCHAR(20) NOT NULL, 
	delay NUMBER(3) NOT NULL CHECK(delay > 0), -- Duración del retraso en minutos, debe ser positiva.
	FOREIGN KEY(ID_incidence_r) REFERENCES Incidencia(ID_incidence) -- Relación con la tabla de incidencias.
);

-- Tabla que almacena información sobre desvíos de vuelos.
CREATE TABLE Desvio (
	ID_incidence_d NUMBER(5), -- Identificador de la incidencia asociada al desvío.
	IATA_desvio VARCHAR(3), -- Aeropuerto alternativo al que se desvió el vuelo.
	FOREIGN KEY(ID_incidence_d) REFERENCES Incidencia(ID_incidence), -- Relación con la tabla de incidencias.
	FOREIGN KEY(IATA_desvio) REFERENCES Aeropuerto(IATA) -- Relación con la tabla de aeropuertos.
);

-- Tabla que almacena información sobre los aviones.
CREATE TABLE Avion (
	tailNum VARCHAR(6) PRIMARY KEY, -- Número de identificación único del avión.
	manufactureYear NUMBER(4), -- Año de fabricación del avión.
	planeManufacturer VARCHAR(20), -- Fabricante del avión.
	planeModel VARCHAR(20), -- Modelo del avión.
	planeEngineType VARCHAR(15) -- Tipo de motor del avión.
);

-- Tabla que almacena qué avión realizó qué vuelo.
CREATE TABLE realiza (
	tailNum_r VARCHAR(6), -- Identificador del avión que realizó el vuelo.
	flightDate_r VARCHAR(10), -- Fecha del vuelo realizado.
	flightNum_r NUMBER(4), -- Número de vuelo realizado.
	crsDepTime_r NUMBER(4), -- Hora programada de salida del vuelo.
	FOREIGN KEY(tailNum_r) REFERENCES Avion(tailNum), -- Relación con la tabla de aviones.
	FOREIGN KEY(flightDate_r, flightNum_r, crsDepTime_r) 
	REFERENCES Vuelo(flightDate, flightNum, crsDepTime) -- Relación con la tabla de vuelos.
);
