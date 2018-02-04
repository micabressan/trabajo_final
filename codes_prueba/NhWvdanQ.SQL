/* CREACION DE LAS TABLAS SEGUN EL MODELO RELACIONAL */

CREATE TABLE EQUIPO (
 nombreOficial CHAR(40) NOT NULL,
 nombreCorto CHAR(32) PRIMARY KEY NOT NULL,
 nombreHistórico CHAR(40),
 ciudad CHAR(32) NOT NULL,
 fundacionOf NUMBER(4) NOT NULL,
 fundación NUMBER(4)	
);

CREATE TABLE ESTADIO (
 nombre CHAR(32) PRIMARY KEY NOT NULL,
 capacidad NUMBER(6) NOT NULL,
 inauguración NUMBER(4) NOT NULL,
 ciudad CHAR(32) NOT NULL
);

CREATE TABLE TENER (
 nombreEquipo CHAR(32) NOT NULL,
 nombreEstadio CHAR(32) NOT NULL,
 FOREIGN KEY (nombreEquipo) REFERENCES EQUIPO(nombreCorto),
 FOREIGN KEY (nombreEstadio) REFERENCES ESTADIO(nombre),
 PRIMARY KEY (nombreEquipo,nombreEstadio)
);

CREATE TABLE TEMPORADA (
 fecha CHAR(32),
 division CHAR(2),
 PRIMARY KEY (fecha,division)
);

CREATE TABLE JORNADA (
 jornada NUMBER(2),
 idTemporada CHAR(32),
 idDivision CHAR (2),
 FOREIGN KEY (idTemporada,idDivision) REFERENCES TEMPORADA(fecha,division) ON DELETE CASCADE,
 PRIMARY KEY (jornada,idTemporada,idDivision)
);

CREATE TABLE PARTIDOS (
 temporada CHAR(32),
 division CHAR(2),
 jornada NUMBER(2),
 nombreLocal CHAR(32),
 nombreVisitante CHAR(32),
 golesLocal NUMBER(2) NOT  NULL,
 golesVisitante NUMBER(2) NOT NULL,
 FOREIGN KEY (jornada,temporada,division) REFERENCES JORNADA(jornada,idTemporada,idDivision) ON DELETE CASCADE,
 FOREIGN KEY (nombreLocal) REFERENCES EQUIPO(nombreCorto) ON DELETE CASCADE,
 FOREIGN KEY (nombreVisitante) REFERENCES EQUIPO(nombreCorto) ON DELETE CASCADE,
 PRIMARY KEY (nombreLocal,jornada,temporada,division)
);