-- Requête 3 : Requête avec trois INNER JOIN
\echo Requête qui affiche la somme des pénalités par utilisateur ayant des emprunts

SELECT Utilisateur.nom, Utilisateur.prenom, SUM(Penalite.id_penalite) AS total_pénalités
FROM Utilisateur
INNER JOIN Emprunt ON Utilisateur.id_utilisateur = Emprunt.id_utilisateur
INNER JOIN Penalite ON Emprunt.id_emprunt = Penalite.id_emprunt
INNER JOIN Correspond ON Emprunt.id_emprunt = Correspond.id_emprunt
GROUP BY Utilisateur.nom, Utilisateur.prenom
ORDER BY total_pénalités DESC;
