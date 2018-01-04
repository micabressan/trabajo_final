stanowisko
FROM pracownik
WHERE UPPER(stanowisko) LIKE 'A%';

SELECT id_pracownika, nazwisko
FROM pracownik
WHERE UPPER(nazwisko) LIKE 'N%' or UPPER(nazwisko) LIKE 'M%';

SELECT id_pracownika, nazwisko, pensja+nvl(premia,0) AS ZAROBKI, nr_przedzialu
FROM pracownik, poziom_zarobkow
WHERE pensja+nvl(premia,0) BETWEEN dolna_granica AND gorna_granica AND (nr_przedzialu =1 OR nr_przedzialu=2);

SELECT DISTINCT d.nazwa AS DEPARTAMENT, pr.nazwa AS PROJEKT
FROM departament d, pracownik p, zlecenie z, projekt pr
WHERE p.id_pracownika=z.id_pracownika AND z.nr_projektu = pr.nr_projektu AND p.nr_departamentu=d.nr_departamentu
ORDER BY d.nazwa;

SELECT DISTINCT p.stanowisko, d.nazwa
FROM pracownik p, departament d
WHERE p.nr_departamentu = d.nr_departamentu
ORDER BY d.nazwa;

SELECT pr.id_pracownika, nazwisko, p.nr_projektu, nazwa
FROM pracownik pr LEFT JOIN zlecenie z
ON pr.id_pracownika = z.id_pracownika
FULL JOIN projekt p
ON z.nr_projektu = p.nr_projektu
WHERE pr.id_pracownika is null OR p.nr_projektu is null;

SELECT stanowisko, AVG(pensja + nvl(premia,0)) AS SREDNIE_ZAROBKI, MIN(pensja + nvl(premia,0)) AS MINIMALNE_ZAROBKI, MAX(pensja + nvl(premia,0)) AS MAKSYMALNE_ZAROBKI
FROM pracownik
GROUP by stanowisko;

SELECT MIN(pensja) AS MIN_PENSJA, MAX(pensja) AS MAX_PENSJA
FROM pracownik;

SELECT stanowisko, Count(id_pracownika) AS Ilosc_stanowisko
FROM pracownik
WHERE UPPER(stanowisko)='ANALITYK'
GROUP BY stanowisko;

SELECT d.nazwa, COUNT(p.id_pracownika) AS LICZBA_ZATRUDNIONYCH
FROM departament d LEFT JOIN pracownik p
ON d.nr_departamentu = p.nr_departamentu
GROUP BY d.nazwa, d.nr_departamentu
ORDER BY d.nr_departamentu;

SELECT d.nr_departamentu, d.nazwa, ROUND(AVG(nvl(pensja,0)),2) AS SREDNIE_ZAROBKI
FROM pracownik p FULL JOIN departament d on p.nr_departamentu = d.nr_departamentu
GROUP BY d.nr_departamentu, d.nazwa
ORDER BY SREDNIE_ZAROBKI DESC;

SELECT d.nazwa
FROM departament d LEFT JOIN pracownik p ON d.nr_departamentu=p.nr_departamentu
GROUP BY d.nazwa, d.nr_departamentu
HAVING COUNT(*) > 3;

SELECT d.nazwa, AVG(p.pensja) AS SREDNIA_PENSJA
FROM departament d LEFT JOIN pracownik p ON d.nr_departamentu = p.nr_departamentu
WHERE p.pensja > 1500 AND (UPPER(d.lokalizacja)='BIALYSTOK' OR UPPER(d.lokalizacja)='WARSZAWA')
GROUP BY d.nazwa, d.nr_departamentu;

SELECT d.nr_departamentu, d.nazwa, p.stanowisko, COUNT(p.stanowisko) AS ILOSC_OSOB_PRACUJACYCH
FROM departament d LEFT JOIN pracownik p ON d.nr_departamentu = p.nr_departamentu
GROUP BY d.nr_departamentu,d.nazwa,p.stanowisko
ORDER BY d.nr_departamentu;

SELECT p.nazwisko AS Pracownik , k.nazwisko AS Przelozony
FROM pracownik p LEFT JOIN pracownik k ON 
p.id_kierownika = k.id_pracownika;

SELECT k.id_pracownika, k.nazwisko AS KIEROWNIK,p.stanowisko, AVG(nvl(p.pensja,0)) AS SREDNIA_PENSJA_PODWLADNYCH
FROM pracownik p LEFT JOIN pracownik k ON p.id_kierownika=k.id_pracownika
GROUP BY p.stanowisko, k.id_pracownika, k.nazwisko;

SELECT nr_przedzialu, COUNT(id_pracownika) AS LICZBA_OSOB
FROM poziom_zarobkow LEFT JOIN pracownik
ON pensja+nvl(premia,0) BETWEEN dolna_granica AND gorna_granica
GROUP BY nr_przedzialu
ORDER BY nr_przedzialu;

SELECT count(id_pracownika) AS liczba_osob, data_zatrudnienia, stanowisko
FROM pracownik
WHERE UPPER(stanowisko)='SPRZEDAWCA' AND id_kierownika IS NOT NULL
GROUP BY data_zatrudnienia, stanowisko
ORDER BY data_zatrudnienia DESC, count(id_pracownika);

SELECT pr.nazwa, COUNT(p.id_pracownika) AS LICZBA_PRACOWNIKOW, SUM(z.stawka_za_godzine*z.ilosc_godzin) AS KOSZT
FROM pracownik p LEFT JOIN zlecenie z ON p.id_pracownika=z.id_pracownika RIGHT JOIN projekt pr ON z.nr_projektu=pr.nr_projektu
GROUP BY pr.nazwa
ORDER BY pr.nazwa;

SELECT DISTINCT COUNT(p.stanowisko) AS ILOSC_STANOWISK ,d.nr_departamentu , d.nazwa
FROM departament d LEFT JOIN pracownik p ON d.nr_departamentu=p.nr_departamentu
GROUP BY d.nr_departamentu, d.nazwa
ORDER BY d.nr_departamentu;

SELECT p.nazwisko, d.nazwa, p.id_pracownika
FROM pracownik p, departament d
WHERE p.nr_departamentu = d.nr_departamentu AND p.nr_departamentu IN ( 
SELECT nr_departamentu FROM pracownik
WHERE UPPER(nazwisko) = 'NAZWISKO2');


SELECT id_pracownika, nazwisko
FROM pracownik
WHERE pensja > ALL (SELECT pensja FROM pracownik WHERE UPPER(nazwisko)='NAZWISKO3') AND
pensja < ALL (SELECT pensja FROM pracownik WHERE UPPER(nazwisko)='NAZWISKO7');

SELECT nazwisko, id_pracownika
FROM pracownik
GROUP BY data_zatrudnienia, nazwisko, id_pracownika
HAVING data_zatrudnienia = ALL(SELECT MIN(data_zatrudnienia) FROM pracownik);

SELECT nazwisko, pensja
FROM pracownik
WHERE pensja > ANY (SELECT avg(pensja) AS pensja FROM pracownik) ;

SELECT d.nazwa
FROM pracownik p LEFT JOIN departament d ON p.nr_departamentu=d.nr_departamentu
WHERE UPPER(p.stanowisko)='ANALITYK' AND (SELECT COUNT(id_pracownika) AS ILOSC FROM pracownik p, departament d WHERE 
p.nr_departamentu=d.nr_departamentu) >= 3
GROUP BY d.nr_departamentu, d.nazwa;

SELECT d.nr_departamentu, d.nazwa, p.stanowisko, COUNT(p.id_pracownika) AS ILOSC_ZATRUDNIONYCH
FROM pracownik p LEFT JOIN departament d ON p.nr_departamentu = d.nr_departamentu
GROUP BY d.nr_departamentu, d.nazwa, p.stanowisko
ORDER BY nr_departamentu;

SELECT pr.nazwa, p.id_pracownika, p.id_kierownika
FROM pracownik p, zlecenie z, projekt pr
WHERE p.id_pracownika = ALL(SELECT k.id_pracownika FROM pracownik p, pracownik k WHERE p.id_kierownika=p.id_pracownika) AND
z.nr_projektu=pr.nr_projektu AND z.id_pracownika=p.id_pracownika
ORDER BY pr.nazwa;

SELECT pr.nazwa, pr.budzet, SUM(z.ilosc_godzin*z.stawka_za_godzine) AS WYDANO
FROM projekt pr RIGHT JOIN  zlecenie z ON pr.nr_projektu=z.nr_projektu
GROUP BY pr.nazwa, z.nr_projektu, pr.budzet
HAVING SUM(z.ilosc_godzin*z.stawka_za_godzine) < (SELECT budzet FROM projekt WHERE z.nr_projektu=nr_projektu);

SELECT pr.nazwa, pr.budzet, SUM(z.ilosc_godzin*z.stawka_za_godzine) AS WYDANO
FROM zlecenie z LEFT JOIN projekt pr ON z.nr_projektu=pr.nr_projektu
GROUP BY pr.nr_projektu, pr.nazwa, pr.budzet;

SELECT p.id_pracownika, p.nazwisko, p.pensja+nvl(p.premia,0) AS ZAROBKI
FROM pracownik p
WHERE p.pensja + nvl(p.premia,0) > (SELECT k.pensja+nvl(k.premia,0) FROM pracownik k WHERE p.id_kierownika=k.id_pracownika);

SELECT id_pracownika, pensja
FROM pracownik
WHERE pensja > ANY(SELECT pensja FROM pracownik WHERE UPPER(stanowisko)='ANALITYK')
ORDER BY id_pracownika;

SELECT di.nr_departamentu, di.nazwa
FROM departament di LEFT JOIN pracownik pi
ON di.nr_departamentu=pi.nr_departamentu
GROUP BY di.nr_departamentu, di.nazwa
HAVING COUNT(pi.id_pracownika) >=  ALL(SELECT COUNT(p.id_pracownika) FROM departament d LEFT JOIN pracownik p ON p.nr_departamentu=d.nr_departamentu
GROUP BY p.nr_departamentu);

/*SELECT d.nr_departamentu, d.nazwa
FROM pracownik p RIGHT JOIN departament d ON p.nr_departamentu=d.nr_departamentu
WHERE p.pensja <> ALL(SELECT MAX(pensja) FROM pracownik) AND p.pensja <> ALL(SELECT MIN(pensja) FROM pracownik);
 zle */
SELECT nr_departamentu, nazwa
FROM departament
WHERE nr_departamentu NOT IN (SELECT nr_departamentu FROM pracownik WHERE pensja=(SELECT MIN(pensja)FROM pracownik) OR 
pensja=(SELECT MAX(pensja) FROM pracownik));


SELECT p.nazwisko AS PODWLADNY, k.nazwisko AS SZEF
FROM pracownik p, pracownik k
WHERE p.id_kierownika = k.id_pracownika AND p.id_pracownika IN(SELECT id_pracownika FROM zlecenie) AND k.id_pracownika IN(SELECT id_pracownika
FROM zlecenie) AND NOT EXISTS (SELECT 5 FROM zlecenie WHERE id_pracownika = p.id_pracownika AND nr_projektu IN(SELECT nr_projektu FROM zlecenie WHERE
id_pracownika=k.id_pracownika));

SELECT id_pracownika, nazwisko
FROM pracownik x
WHERE      2<=       (SELECT count(id_pracownika)
FROM pracownik WHERE id_pracownika IN (SELECT id_kierownika FROM pracownik) AND pensja+nvl(premia,0) < x.pensja+nvl(x.premia,0));


SELECT p.id_pracownika, p.nazwisko, p.pensja
FROM pracownik p
WHERE p.id_pracownika NOT IN(SELECT m.id_pracownika FROM pracownik m, pracownik k
WHERE  k.id_kierownika = m.id_pracownika);


SELECT p.nazwisko
FROM pracownik p
WHERE pensja+nvl(premia,0)=(SELECT min(pensja + nvl(premia,0))
                            FROM pracownik
                            WHERE nr_departamentu=p.nr_departamentu) AND 
p.nr_departamentu IN
                            (SELECT nr_departamentu
                             FROM pracownik
                             GROUP BY nr_departamentu
                             HAVING COUNT(id_pracownika)<= ALL(SELECT COUNT(id_pracownika)
                             FROM pracownik GROUP BY nr_departamentu));

SELECT p.id_pracownika, p.nazwisko
FROM pracownik p
WHERE       (SELECT COUNT(nr_projektu)
            FROM zlecenie 
            WHERE id_pracownika=p.id_pracownika) =
                            (SELECT COUNT(DISTINCT nr_projektu)
                            FROM zlecenie)
AND EXISTS (SELECT 'abc'
            FROM zlecenie z1
            WHERE id_pracownika=p.id_pracownika AND
            NOT EXISTS(SELECT 'abc' 
                       FROM zlecenie z2
                       WHERE nr_projektu=z1.nr_projektu AND
                       id_pracownika<>p.id_pracownika));


SELECT pr.id_pracownika, nazwisko, nvl(nazwa,' ') AS NAZWA_PROJEKTU
FROM pracownik pr LEFT JOIN zlecenie z ON pr.id_pracownika=z.id_pracownika
FULL JOIN projekt p ON p.nr_projektu=z.nr_projektu
WHERE z.data_zakonczenia = (SELECT MAX(data_zakonczenia)
                            FROM zlecenie
                            WHERE id_pracownika=pr.id_pracownika)
AND EXISTS (SELECT 15
            FROM zlecenie a
            WHERE nr_projektu IN(SELECT nr_projektu
                                FROM zlecenie
                                WHERE id_pracownika=pr.id_pracownika) AND
            nr_projektu IN(SELECT nr_projektu
                           FROM zlecenie
                           WHERE id_pracownika=pr.id_kierownika) AND 
            2=(SELECT COUNT(id_pracownika)
                FROM zlecenie
                WHERE nr_projektu=a.nr_projektu)) OR
pr.id_pracownika NOT IN(SELECT id_pracownika
                        FROM zlecenie)
ORDER BY id_pracownika;