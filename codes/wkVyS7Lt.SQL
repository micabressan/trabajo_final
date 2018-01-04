DROP TABLE Studenci CASCADE CONSTRAINTS;
DROP TABLE Wykladowcy CASCADE CONSTRAINTS;
DROP TABLE Przedmioty CASCADE CONSTRAINTS;
DROP TABLE Stypendia CASCADE CONSTRAINTS;
DROP TABLE Kola_naukowe CASCADE CONSTRAINTS;
DROP TABLE Uslugi CASCADE CONSTRAINTS;
DROP TABLE Grupy CASCADE CONSTRAINT;
DROP TABLE Studenci_grupy CASCADE CONSTRAINT;
DROP TABLE Przedmioty_grupy CASCADE CONSTRAINT;
DROP TABLE Studenci_kola_naukowe CASCADE CONSTRAINT;
DROP TABLE Studenci_stypendia CASCADE CONSTRAINT;
DROP TABLE Platnosci CASCADE CONSTRAINT;

Create table Studenci (
    nr_albumu VARCHAR (6) PRIMARY KEY,
    imie VARCHAR (20) NOT NULL,
    nazwisko VARCHAR (40) NOT NULL,
    PESEL VARCHAR (11) UNIQUE NOT NULL,
    miasto VARCHAR (40),
    ulica VARCHAR (40),
    nr_budynku VARCHAR (6),
    nr_telefonu VARCHAR (15)
);

Create table Wykladowcy (
    id_wykladowcy VARCHAR (6) PRIMARY KEY,
    imie VARCHAR (20) NOT NULL,
    nazwisko VARCHAR (40) NOT NULL,
    tytul_naukowy VARCHAR (15)
);

Create table Przedmioty (
    id_przedmiotu VARCHAR (6) PRIMARY KEY,
    nazwa VARCHAR (30) NOT NULL,
    ilosc_godzin number (2), CONSTRAINT ch_ilosc_godzin CHECK ((ilosc_godzin>=0) AND (ilosc_godzin<=60)),
    ECTS number (1), CONSTRAINT ch_ecst CHECK ((ECTS>=0) AND (ECTS<=10)),
    rodzaj_zajec VARCHAR (15)
);

Create table Stypendia (
    id_stypendium number PRIMARY KEY,
    nazwa VARCHAR (50) NOT NULL,
    kwota number (5)
);

Create table Kola_naukowe (
    id_kola_naukowego number PRIMARY KEY,
    nazwa VARCHAR (30) NOT NULL,
    opis VARCHAR (100),
    id_opiekuna VARCHAR (6),
    id_przewodniczacego VARCHAR (6),
    FOREIGN KEY (id_opiekuna) REFERENCES Wykladowcy(id_wykladowcy),
    FOREIGN KEY (id_przewodniczacego) REFERENCES Studenci(nr_albumu)
);

Create table Uslugi (
    id_uslugi number PRIMARY KEY,
    nazwa_uslugi VARCHAR (30),
    opis VARCHAR (50),
    cena number (5,2)
);

Create table Grupy (
    nr_grupy VARCHAR (10) PRIMARY KEY,
    id_starosty VARCHAR (6),
    id_opiekuna VARCHAR (6),
    FOREIGN KEY (id_starosty) REFERENCES Studenci(nr_albumu),
    FOREIGN KEY (id_opiekuna) REFERENCES Wykladowcy(id_wykladowcy)
);

Create table Studenci_grupy (
    nr_grupy VARCHAR (10) NOT NULL,
    nr_albumu VARCHAR (6) NOT NULL,
    FOREIGN KEY (nr_grupy) REFERENCES Grupy(nr_grupy),
    FOREIGN KEY (nr_albumu) REFERENCES Studenci(nr_albumu)
);

Create table Przedmioty_grupy (
    nr_grupy VARCHAR (10) NOT NULL,
    id_przedmiotu VARCHAR (6) NOT NULL,
    id_wykladowcy VARCHAR (6),
    FOREIGN KEY (nr_grupy) REFERENCES Grupy(nr_grupy),
    FOREIGN KEY (id_wykladowcy) REFERENCES Wykladowcy(id_wykladowcy),
    FOREIGN KEY (id_przedmiotu) REFERENCES Przedmioty(id_przedmiotu)
);

Create table Studenci_kola_naukowe (
    id_kola_naukowego number NOT NULL,
    nr_albumu VARCHAR (6) NOT NULL,
    FOREIGN KEY (id_kola_naukowego) REFERENCES Kola_naukowe(id_kola_naukowego),
    FOREIGN KEY (nr_albumu) REFERENCES Studenci(nr_albumu)
);

Create table Studenci_stypendia (
    nr_albumu VARCHAR (6) NOT NULL,
    id_stypendium number NOT NULL,
    FOREIGN KEY (nr_albumu) REFERENCES Studenci(nr_albumu),
    FOREIGN KEY (id_stypendium) REFERENCES Stypendia(id_stypendium)
);

Create table Platnosci (
    id_platnosci number PRIMARY KEY,
    id_uslugi number NOT NULL,
    nr_albumu VARCHAR (6) NOT NULL,
    stan_realizacji VARCHAR (30),
    FOREIGN KEY (id_uslugi) REFERENCES Uslugi(id_uslugi),
    FOREIGN KEY (nr_albumu) REFERENCES Studenci(nr_albumu)
);