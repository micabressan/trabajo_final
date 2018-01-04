
drop table "Ventas";
drop table "Clientes"
drop table "VideoJuegos";
drop table "Generos";

CREATE TABLE "Generos"
(
	"Id" int NOT NULL  IDENTITY
	,"Nombre" varchar(255) NOT NULL
	,"Descuento" decimal (3,2) DEFAULT 0
	,PRIMARY KEY ("Id")
);


CREATE TABLE "VideoJuegos"
(
	"Id" int NOT NULL IDENTITY
	,"Nombre" char(255) NOT NULL
	,"Id_genero" int NOT NULL
	,"Precio" decimal(18,2) NOT NULL
	,"Edad_Recomendada" int default 3
	,"Descuento" decimal (3,2) DEFAULT 0
	,PRIMARY KEY("Id")
	,FOREIGN KEY ("Id_genero") REFERENCES "Generos"("Id")
);

CREATE TABLE "Clientes"
(
	"DNI" varchar(9)
	,"Nombre" varchar(255) NOT NULL
	,"Apellidos" varchar(255) NOT NULL
	,"Edad" int NOT NULL
	,"Fecha_Alta" date DEFAULT CURRENT_DATE
	,"Descuento" decimal (3,2) DEFAULT 0
	,PRIMARY KEY("DNI")
	--,CHECK ( REGEXP_MATCHES("DNI",'^[0-9]{8}([A-Z]|[a-z])$') )
);

CREATE TABLE "Ventas"
(
	"Id_Cliente" varchar(9)
	,"Id_Videojuego" int NOT NULL
	,PRIMARY KEY("Id_Cliente","Id_Videojuego")
	,FOREIGN KEY ("Id_Cliente") REFERENCES "Clientes"("DNI")
	,FOREIGN KEY ("Id_Videojuego") REFERENCES "VideoJuegos"("Id")
);


INSERT INTO "Generos"("Nombre","Descuento") VALUES ('Accion',0.1);
INSERT INTO "Generos"("Nombre","Descuento") VALUES ('Terror',0);
INSERT INTO "Generos"("Nombre","Descuento") VALUES ('Sigilo',0.3);

INSERT INTO "VideoJuegos" ("Nombre", "Id_genero", "Precio", "Descuento", "Edad_Recomendada") VALUES ('The Last of Us', 0, 45.5, 0,18);
INSERT INTO "VideoJuegos" ("Nombre", "Id_genero", "Precio", "Descuento") VALUES ('Splinter Cell Double Agent', 2, 45.5, 0);
INSERT INTO "VideoJuegos" ("Nombre", "Id_genero", "Precio", "Descuento", "Edad_Recomendada") VALUES ('Tom Clancy Rainbow Six',0, 0.50, 0.3, 18);

INSERT INTO "Clientes" ("DNI", "Nombre", "Apellidos", "Edad") VALUES ('54109078Z','Javier','Duque Melguizo',24)
INSERT INTO "Clientes" ("DNI", "Nombre", "Apellidos", "Edad") VALUES ('12345678Z','Prueba','Probandi Probadore',100);

INSERT INTO "Ventas" ("Id_Cliente" , "Id_Videojuego") VALUES ('54109078Z',0)
INSERT INTO "Ventas" ("Id_Cliente" , "Id_Videojuego") VALUES ('54109078Z',1)
INSERT INTO "Ventas" ("Id_Cliente" , "Id_Videojuego") VALUES ('54109078Z',2)
INSERT INTO "Ventas" ("Id_Cliente" , "Id_Videojuego") VALUES ('12345678Z',0)
INSERT INTO "Ventas" ("Id_Cliente" , "Id_Videojuego") VALUES ('12345678Z',2);


select COUNT(Ventas.Id_Videojuego) Ventas, VideoJuegos.Nombre from VideoJuegos 
	inner join Ventas on VideoJuegos.Id = Ventas.Id_Videojuego
	group by VideoJuegos.Nombre order by Ventas desc
	
select VideoJuegos.Nombre, Generos.Nombre Genero, Precio, Edad_Recomendada, Descuento from VideoJuegos
	inner join Generos on VideoJuegos.Id_genero = Generos.Id
	where Edad_Recomendada < 18;

select VideoJuegos.Nombre, Generos.Nombre Genero, Precio, Edad_Recomendada, Descuento from VideoJuegos
	inner join Generos on VideoJuegos.Id_genero = Generos.Id
	where Edad_Recomendada < 18 and Precio <= 30;