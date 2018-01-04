CREATE TABLE Klijent
(
	KlijentID int,
	Ime nvarchar(30),
	Prezime nvarchar(50),
	Adresa nvarchar(50),
	GradID int,
	Telefon nvarchar(30),
	Email nvarchar(30),
	AktivanKlijent bit,
);

CREATE TABLE Region
(
   RegionID int,
   Naziv nvarchar(20),
   Opis nvarchar(20),
 
   constraint Region_PK primary key(RegionID)
);
 
CREATE TABLE Grad
(
   GradID int,
   Grad nvarchar(15),
   PozivniBroj int,
   PostanskiBroj int,
   BrojStanovnika int,
   RegionID int,
 
   constraint Grad_PK primary key(GradID),
   constraint Region_FK foreign key(RegionID) references Region(RegionID),
   constraint GradID_FK foreign key(GradID) references Grad(GradID)
);

SELECT * FROM Grad;