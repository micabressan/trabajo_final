DROP TABLE ZABCZYN;
DROP TABLE WIZZAB;
DROP TABLE MATERIALY;
DROP TABLE CZYNNOSCI;
DROP TABLE ZABIEGI;
DROP TABLE WIZYTY;
DROP TABLE PRACOWNICE;
DROP TABLE KLIENTKI;
DROP TABLE ADRESY;

CREATE TABLE Adresy(
  IdAdresu NUMBER(8),
  Adres VARCHAR2(50),
  NrDomu VARCHAR2(10),
  NrMieszkania VARCHAR2(5),
  Miejscowosc VARCHAR2(20),
  KodPocztowy VARCHAR2(6),
  Kraj VARCHAR2(20),
  Telefon VARCHAR2(7),
  CONSTRAINT PK_Adresy PRIMARY KEY (IdAdresu)
);

CREATE TABLE Klientki(
  IdKlientki NUMBER(8),
  Imie VARCHAR2(15) NOT NULL,
  Nazwisko VARCHAR2(25) NOT NULL,
  DataRejestracji DATE NOT NULL,
  IdAdresu NUMBER(8),
  TelefonKontaktowy VARCHAR2(9),
  Uwagi VARCHAR2(3000),
  CONSTRAINT PK_Klientki PRIMARY KEY (IdKlientki),
  CONSTRAINT FK_AdresKlientki FOREIGN KEY (IdAdresu) REFERENCES ADRESY(IdAdresu)
);

CREATE TABLE Pracownice(
  IdPracownicy NUMBER(8),
  Imie VARCHAR2(15),
  Nazwisko VARCHAR2(25),
  DataZatrudnienia DATE,
  Zarobki NUMBER(7,2),
  IdAdresu NUMBER(8),
  Uwagi VARCHAR2(3000),
  CONSTRAINT PK_Pracownice PRIMARY KEY (IdPracownicy),
  CONSTRAINT FK_AdresPracownicy FOREIGN KEY (IdAdresu) REFERENCES 
ADRESY(IdAdresu)
);

CREATE TABLE Materialy(
  IdMaterialu NUMBER(8),
  Nazwa VARCHAR2(50) NOT NULL,
  Uwagi VARCHAR2(3000),
  CONSTRAINT PK_Materialy PRIMARY KEY (IdMaterialu)
);

CREATE TABLE Czynnosci(
  IdCzynnosci NUMBER(8),
  Nazwa VARCHAR2(50),
  CzasTrwania CHAR(4),
  Cena NUMBER(5,2),
  CONSTRAINT PK_Czynnosci PRIMARY KEY (IdCzynnosci)
);

CREATE TABLE Zabiegi(
  IdZabiegu NUMBER(8),
  Nazwa VARCHAR2(50),
  CONSTRAINT PK_Zabiegi PRIMARY KEY (IdZabiegu)
);

CREATE TABLE Wizyty(
  IdWizyty NUMBER(8),
  DataWizyty DATE NOT NULL,
  IdKlientki NUMBER(8),
  Uwagi VARCHAR2(3000),
  CONSTRAINT PK_Wizyty PRIMARY KEY (IdWizyty),
  CONSTRAINT FK_WizytaKlientki FOREIGN KEY (IdKlientki) REFERENCES 
Klientki(IdKlientki)
);

CREATE TABLE WizZab(
  IdWizyty NUMBER(8),
  IdZabiegu NUMBER(8),
  IdPracownicy NUMBER(8),
  NumerKolejny NUMBER(3) NOT NULL,
  CONSTRAINT PK_Wizyty_zbiegi PRIMARY KEY (IdWizyty, IdZabiegu, IdPracownicy, 
NumerKolejny),
  CONSTRAINT FK_Wizyty_WizZab FOREIGN KEY (IdWizyty) REFERENCES 
Wizyty(IdWizyty),
  CONSTRAINT FK_WizytaZabieg FOREIGN KEY (IdZabiegu) REFERENCES 
Zabiegi(IdZabiegu),
  CONSTRAINT FK_ObslugujacaPracownica FOREIGN KEY (IdPracownicy) REFERENCES 
Pracownice(IdPracownicy)
);

CREATE TABLE ZabCzyn(
  IdZabiegu NUMBER(8), 
  IdCzynnosci NUMBER(8),
  IdMaterialu NUMBER(8),
  NumerKolejny NUMBER(3) NOT NULL,
  CONSTRAINT PK_ZabCzyn PRIMARY KEY (IdZabiegu, IdCzynnosci, IdMaterialu, 
NumerKolejny),
  CONSTRAINT FK_WJakimZabiegu FOREIGN KEY (IdZabiegu) REFERENCES 
Zabiegi(IdZabiegu),
  CONSTRAINT FK_JakaCzynnosc FOREIGN KEY (IdCzynnosci) REFERENCES 
Czynnosci(IdCzynnosci),
  CONSTRAINT FK_ZuzytyMaterial FOREIGN KEY (IdMaterialu) REFERENCES 
Materialy(IdMaterialu)
);