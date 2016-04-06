SELECT DISTINCT bdId,bdTitre
	FROM Bd
	JOIN Participation ON bdId = bd
	JOIN Auteur durand ON auteur = durand.autId
	JOIN Auteur dupont ON auteur = dupont.autId and durant.autId != dupont.autId -- pas le meme type
	WHERE LOWER(durand.autNom) = 'durand' OR LOWER(dupont.autNom) = 'dupont';