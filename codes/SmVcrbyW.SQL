/* Znajdz wszystkie transporty za ktore odpowiedzialny byl Dany pracownik sortujac je datami od najmlodszego do najstarszego 
*/

SELECT * FROM Pracownicy 
INNER JOIN Transporty ON Transporty.Kierowca = Pracownicy.ID
WHERE Typ = 0 AND DataRozladunku IS NOT NULL
ORDER BY DataRozladunku

/* Znajdz ile paczek zostalo przetworzonych danego dnia w danej sortowni */




/* Znajdz ile mandatow ma dany pojazd */