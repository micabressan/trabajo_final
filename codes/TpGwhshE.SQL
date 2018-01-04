SELECT 
   f.namaalternatif,d.namakriteria,costbenefit,nilai,n_max,n_min, IF(d.costbenefit='benefit',c.nilai/d.n_max,d.n_min/c.nilai) AS cos_benefit
FROM
  (nilai_alternatif c
   INNER JOIN  
   ( SELECT a.id_kriteria,b.namakriteria,b.costbenefit,a.n_max,a.n_min FROM
	   ( SELECT 
		  id_kriteria, MAX(nilai) AS n_max, MIN(nilai) AS n_min 
		FROM 
		  nilai_alternatif 
		GROUP BY 
		  id_kriteria
	   ) a
	   INNER JOIN
		  kriteria b
	   ON a.id_kriteria = b.idkriteria 
   ) d
   ON c.id_kriteria=d.id_kriteria) INNER JOIN alternatif f ON c.id_alternatif=f.idalternatif;