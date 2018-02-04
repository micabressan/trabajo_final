/*usuwanie tabeli jesli niepusta*/
IF OBJECT_ID('tempdb..#T') IS NOT NULL DROP TABLE #T 

/*wyposazenia jakie istnieją dla samochodów z 5 wyposażeniami- nasze wymagania*/
SELECT DISTINCT wyp.idw, wyp.opis
INTO #T
FROM (
	SELECT  COUNT(wa.idw) AS [ilosc wyposazenia], wa.id_auta
	FROM wyp_auta wa
	GROUP BY wa.id_auta
	) A
	join auta aa on aa.id_auta = A.id_auta
	join wyp_auta wa on wa.id_auta = aa.id_auta
	join wypas wyp on wyp.idw = wa.idw
	WHERE A.[ilosc wyposazenia] = 5

/*wyliczenie ile z powyższych wyposażen ma każde z aut*/
SELECT COUNT(wa.id_auta) AS [ilosc zgodnych wyposazen], wa.id_auta, a.marka, a.model
FROM wyp_auta wa
join auta a on a.id_auta=wa.id_auta
WHERE EXISTS ( 
		SELECT* 
		FROM #T
		WHERE wa.idw=#T.idw		
)
GROUP BY wa.id_auta, a.marka, a.model
ORDER BY [ilosc zgodnych wyposazen] DESC