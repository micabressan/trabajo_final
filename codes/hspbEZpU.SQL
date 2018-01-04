SELECT b.CodPer as B, a.CodPer as A 
FROM InPercorso a 
LEFT JOIN InPercorso b 
	ON a.Nodo = b.Nodo 
WHERE a.CodPer IS NOT b.CodPer
GROUP BY A