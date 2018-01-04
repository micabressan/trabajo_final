CREATE TABLE Klienci (
    Id INT IDENTITY PRIMARY KEY ,
    Imie VARCHAR(20) NOT NULL,
    Nazwisko VARCHAR(30) NOT NULL,
    Adres VARCHAR(254) NOT NULL,
    Email VARCHAR(254) NOT NULL,
    NrTelefonu CHAR(9) NOT NULL
);
 
CREATE TABLE Przesylki (
    Id INT IDENTITY PRIMARY KEY,
    Wartosc money,
    Waga NUMERIC(7,3),
    StatusOplacenia bit NOT NULL,
    DataPrzyjecia datetime,
    DataZrealizowania datetime,
    Nadawca INT REFERENCES Klienci NOT NULL,
    Odbiorca INT REFERENCES Klienci NOT NULL
);
 

CREATE TABLE Sortownie (
    Adres VARCHAR(254) PRIMARY KEY
);
 
CREATE TABLE Pracownicy (
    Id INT IDENTITY PRIMARY KEY ,
    Imie VARCHAR(20) NOT NULL,
    Nazwisko VARCHAR(30) NOT NULL,
    NrTelefonu CHAR(9) NOT NULL
);

CREATE TABLE ZadaniaPosortowania (
    Data datetime PRIMARY KEY,
	Pracownik INT REFERENCES Pracownicy NOT NULL,
	SortowniaPrzeznaczenia VARCHAR(254) REFERENCES Sortownie
);
 

 
CREATE TABLE Pojazdy (
    NumerRejestracyjny CHAR(7) PRIMARY KEY,
    Przebieg NUMERIC NOT NULL,
    Typ VARCHAR(15) NOT NULL
);
 
CREATE TABLE Mandaty (
    Numer INT PRIMARY KEY,
    KrajWykroczenia VARCHAR(10),
    Opis VARCHAR(300),
    Kwota MONEY NOT NULL,
    DataWystawienia DATE NOT NULL,
    StatusOplacenia BIT NOT NULL,
	Pojazd CHAR(7) REFERENCES Pojazdy NOT NULL
);

CREATE TABLE Transporty (
    Id INT PRIMARY KEY,
    DataZaladunku datetime,
    DataRozladunku datetime,
    Typ TINYINT NOT NULL CHECK(Typ <=2),
	Pojazd CHAR(7) REFERENCES Pojazdy NOT NULL,
	SortowniaPrzeznaczenia VARCHAR(254) REFERENCES Sortownie,
	Kierowca INT REFERENCES Pracownicy NOT NULL
);
 
 
CREATE TABLE Pojazdy_Transporty (
    Przesylka INT REFERENCES Przesylki,
    Tranport INT REFERENCES Transporty
);




ALTER TABLE Pojazdy
ADD CONSTRAINT NumberRejestracyjny_CHK 
	CHECK(NumerRejestracyjny LIKE '%[^a-zA-Z0-9]%');