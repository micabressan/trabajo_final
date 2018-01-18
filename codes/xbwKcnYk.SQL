ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienie_Ladunek
 FOREIGN KEY (ID_Ladunku)
 REFERENCES Ladunek (ID_Ladunku) ON DELETE CASCADE;