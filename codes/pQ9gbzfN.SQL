SELECT idPersonne id, nomPers nom, prenomPers prenom
		FROM Utilisateur
		WHERE idPersonne IN (SELECT idEtudiant
							 FROM Etudiant
							 WHERE idEtudiant IN ( SELECT idEtudiant
							 						FROM Appartient
							 						WHERE idGroupe = (SELECT idGroupe
													 				   FROM Seance
													 				   WHERE idProfesseur = :prof
													 				   AND dateDebut = :deb
													 				   AND dateFin = :fin )))
		ORDER BY 2,3