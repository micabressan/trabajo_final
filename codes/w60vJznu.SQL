SELECT DISTINCT wyp.idw, wyp.opis
FROM (
	SELECT  COUNT(wa.idw) AS [ilosc wyposazenia], wa.id_auta
	FROM wyp_auta wa
	GROUP BY wa.id_auta
	) A
	join auta aa on aa.id_auta = A.id_auta
	join wyp_auta wa on wa.id_auta = aa.id_auta
	join wypas wyp on wyp.idw = wa.idw
	WHERE A.[ilosc wyposazenia] = 5