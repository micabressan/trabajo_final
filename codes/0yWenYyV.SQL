/*usuwanie tabeli jesli niepusta*/
IF OBJECT_ID('tempdb..#T') IS NOT NULL DROP TABLE #T
/*usuwanie tabeli jesli niepusta*/
IF OBJECT_ID('tempdb..#temp1') IS NOT NULL DROP TABLE #temp1
/*usuwanie tabeli jesli niepusta*/
IF OBJECT_ID('tempdb..#temp2') IS NOT NULL DROP TABLE #temp2
 
/*wyposazenia jakie istnieją dla samochodów z 5 wyposażeniami- nasze wymagania*/
SELECT DISTINCT wyp.idw, wyp.opis
INTO #T
FROM (
    SELECT  COUNT(wa.idw) AS [ilosc wyposazenia], wa.id_auta
    FROM wyp_auta wa
    GROUP BY wa.id_auta
    ) A
    JOIN auta aa ON aa.id_auta = A.id_auta
    JOIN wyp_auta wa ON wa.id_auta = aa.id_auta
    JOIN wypas wyp ON wyp.idw = wa.idw
    WHERE A.[ilosc wyposazenia] = 5
 
/*wyliczenie ile z powyższych wyposażen ma każde z aut*/
SELECT COUNT(wa.id_auta) AS [ilosc zgodnych wyposazen], wa.id_auta as id_auta, a.marka, a.model into #temp1
FROM wyp_auta wa
JOIN auta a ON a.id_auta=wa.id_auta
WHERE EXISTS (
        SELECT*
        FROM #T
        WHERE wa.idw=#T.idw    
)
GROUP BY wa.id_auta, a.marka, a.model
ORDER BY [ilosc zgodnych wyposazen] DESC


SELECT 0 AS [ilosc zgodnych wyposazen], a.id_auta, a.marka, a.model  into #temp2
FROM Auta a
WHERE NOT EXISTS(
SELECT *
FROM #temp1 t
WHERE t.id_auta=a.id_auta
)

select #temp1.[ilosc zgodnych wyposazen],#temp1.id_auta,#temp1.marka,#temp1.model
from #temp1

union

select #temp2.[ilosc zgodnych wyposazen],#temp2.id_auta,#temp2.marka,#temp2.model
from #temp2

order by [ilosc zgodnych wyposazen] desc