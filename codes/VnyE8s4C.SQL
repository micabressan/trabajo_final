
1.=========================================================
SELECT nazwa, nazwisko, imie, dataur, wynagrodzenie FROM
(SELECT *
  FROM firma f
  JOIN firmapracownik fp ON f.fid = fp.fid
  JOIN pracownik p ON p.pid = fp.pid
) AS costam
WHERE dataodejscia IS NULL AND wynagrodzenie <= 2313.45 AND 
      dataur BETWEEN '1970-01-01' AND '1979-12-31'
ORDER BY nazwa, wynagrodzenie;

2.=========================================================
SELECT s.nazwa, count(*)
FROM pracownik p 
RIGHT JOIN stan s ON p.sid = s.sid
GROUP BY s.nazwa
HAVING COUNT(*) > 1;

3.=========================================================


4.========================================================
SELECT p.nazwisko, p.imie, f.nazwa, fp.wynagrodzenie
FROM firmapracownik fp
JOIN pracownik p USING(pid)
JOIN firma f USING(fid)
WHERE fp.dataodejscia IS NULL AND fp.wynagrodzenie >= 1.4 * (SELECT MIN(wynagrodzenie) FROM firmapracownik fp2 WHERE fp2.fid = fp.fid);

5.========================================================
SELECT DISTINCT nazwa, (
      SELECT AVG(wynagrodzenie) FROM firmapracownik
      WHERE dataodejscia IS NULL AND firmapracownik.fid = fp.fid) as srednia

FROM firmapracownik fp JOIN firma USING(fid);