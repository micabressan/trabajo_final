SELECT DISTINCT bdId,bdTitre
	FROM Bd
	JOIN Participation ON bdId = bd
	JOIN Auteur durand ON auteur = durand.autId
	JOIN Auteur dupont ON auteur = dupont.autId
	WHERE LOWER(durand.autNom) = 'durand' AND LOWER(dupont.autNom) = 'dupont';