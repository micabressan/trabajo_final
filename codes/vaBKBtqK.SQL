CREATE TABLE adres
    (
     klient_login UNIQUE VARCHAR (64) NOT NULL ,
     ulica VARCHAR (64) NOT NULL ,
     nr_domu INTEGER NOT NULL ,
     nr_lokalu INTEGER ,
     kod_pocztowy VARCHAR (64) NOT NULL ,
     miasto VARCHAR (64) NOT NULL
    )
    ON "default"
GO

ALTER TABLE adres ADD CONSTRAINT adres_PK PRIMARY KEY CLUSTERED (klient_login)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE egzemplarz
    (
     nazwa VARCHAR (64) NOT NULL ,
     produkt_kod_produktu UNIQUE VARCHAR (64) NOT NULL ,
     data_zakupu DATETIME NOT NULL ,
     data_sprzedazy DATETIME NOT NULL ,
     czy_sprzedano INTEGER NOT NULL
    )
    ON "default"
GO

ALTER TABLE egzemplarz ADD CONSTRAINT egzemplarz_PK PRIMARY KEY CLUSTERED (nazwa)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE faktury
    (
     nr_faktury UNIQUE VARCHAR (64) NOT NULL ,
     zamowienie_nr_zamowienia INTEGER NOT NULL ,
     klient_login VARCHAR (64) NOT NULL ,
     data_sprzedazy DATETIME NOT NULL ,
     wartosc_netto MONEY NOT NULL ,
     wartosc_brutto MONEY NOT NULL ,
     forma_platnosci VARCHAR (64) NOT NULL
    )
    ON "default"
GO




CREATE UNIQUE NONCLUSTERED INDEX
    faktury__IDX ON faktury
    (
     zamowienie_nr_zamowienia
    )
    ON "default"
GO

ALTER TABLE faktury ADD CONSTRAINT faktury_PK PRIMARY KEY CLUSTERED (nr_faktury)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE klient
    (
     login UNIQUE VARCHAR (64) NOT NULL ,
     haslo VARCHAR (64) NOT NULL ,
     imie VARCHAR (64) NOT NULL ,
     nazwisko VARCHAR (64) NOT NULL ,
     nip VARCHAR (64) ,
     nazwa_firmy VARCHAR (64)
    )
    ON "default"
GO

ALTER TABLE klient ADD CONSTRAINT klient_PK PRIMARY KEY CLUSTERED (login)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE kontakt
    (
     klient_login VARCHAR (64) NOT NULL ,
     nr_tel INTEGER NOT NULL ,
     fax INTEGER NOT NULL ,
     email VARCHAR (64) NOT NULL
    )
    ON "default"
GO

ALTER TABLE kontakt ADD CONSTRAINT kontakt_PK PRIMARY KEY CLUSTERED (klient_login)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE produkt
    (
     kod_produktu UNIQUE VARCHAR (64) NOT NULL ,
     nazwa_produktu VARCHAR (64) NOT NULL ,
     producent VARCHAR (64) NOT NULL ,
     cena_netto MONEY NOT NULL ,
     cena_brutto MONEY NOT NULL ,
     kolor VARCHAR (64) NOT NULL ,
     kategoria VARCHAR (64) NOT NULL
    )
    ON "default"
GO

ALTER TABLE produkt ADD CONSTRAINT produkt_PK PRIMARY KEY CLUSTERED (kod_produktu)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE Relation_10
    (
     produkt_kod_produktu VARCHAR (64) NOT NULL ,
     faktury_nr_faktury VARCHAR (64) NOT NULL
    )
    ON "default"
GO

ALTER TABLE Relation_10 ADD CONSTRAINT Relation_10_PK PRIMARY KEY CLUSTERED (produkt_kod_produktu, faktury_nr_faktury)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE Relation_12
    (
     produkt_kod_produktu VARCHAR (64) NOT NULL ,
     zamowienie_nr_zamowienia INTEGER NOT NULL
    )
    ON "default"
GO

ALTER TABLE Relation_12 ADD CONSTRAINT Relation_12_PK PRIMARY KEY CLUSTERED (produkt_kod_produktu, zamowienie_nr_zamowienia)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE zamowienie
    (
     nr_zamowienia UNIQUE INTEGER NOT NULL ,
     klient_login VARCHAR (64) NOT NULL ,
     faktury_nr_faktury VARCHAR (64) NOT NULL ,
     data_zlozenia DATETIME NOT NULL ,
     data_realizacji DATETIME NOT NULL ,
     data_wysylki DATETIME NOT NULL ,
     forma_dostawy VARCHAR (64) NOT NULL
    )
    ON "default"
GO




CREATE UNIQUE NONCLUSTERED INDEX
    zamowienie__IDX ON zamowienie
    (
     faktury_nr_faktury
    )
    ON "default"
GO

ALTER TABLE zamowienie ADD CONSTRAINT zamowienie_PK PRIMARY KEY CLUSTERED (nr_zamowienia)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

ALTER TABLE adres
    ADD CONSTRAINT adres_klient_FK FOREIGN KEY
    (
     klient_login
    )
    REFERENCES klient
    (
     login
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE egzemplarz
    ADD CONSTRAINT egzemplarz_produkt_FK FOREIGN KEY
    (
     produkt_kod_produktu
    )
    REFERENCES produkt
    (
     kod_produktu
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE faktury
    ADD CONSTRAINT faktury_klient_FK FOREIGN KEY
    (
     klient_login
    )
    REFERENCES klient
    (
     login
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE faktury
    ADD CONSTRAINT faktury_zamowienie_FK FOREIGN KEY
    (
     zamowienie_nr_zamowienia
    )
    REFERENCES zamowienie
    (
     nr_zamowienia
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE kontakt
    ADD CONSTRAINT kontakt_klient_FK FOREIGN KEY
    (
     klient_login
    )
    REFERENCES klient
    (
     login
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Relation_10
    ADD CONSTRAINT Relation_10_faktury_FK FOREIGN KEY
    (
     faktury_nr_faktury
    )
    REFERENCES faktury
    (
     nr_faktury
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Relation_10
    ADD CONSTRAINT Relation_10_produkt_FK FOREIGN KEY
    (
     produkt_kod_produktu
    )
    REFERENCES produkt
    (
     kod_produktu
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Relation_12
    ADD CONSTRAINT Relation_12_produkt_FK FOREIGN KEY
    (
     produkt_kod_produktu
    )
    REFERENCES produkt
    (
     kod_produktu
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Relation_12
    ADD CONSTRAINT Relation_12_zamowienie_FK FOREIGN KEY
    (
     zamowienie_nr_zamowienia
    )
    REFERENCES zamowienie
    (
     nr_zamowienia
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE zamowienie
    ADD CONSTRAINT zamowienie_faktury_FK FOREIGN KEY
    (
     faktury_nr_faktury
    )
    REFERENCES faktury
    (
     nr_faktury
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE zamowienie
    ADD CONSTRAINT zamowienie_klient_FK FOREIGN KEY
    (
     klient_login
    )
    REFERENCES klient
    (
     login
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO