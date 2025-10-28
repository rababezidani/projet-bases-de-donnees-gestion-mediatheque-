-- Requête 2 : Requête avec deux JOINTURE
\echo Requête qui liste des emprunts avec les détails de l utilisateur et des ressources empruntées

SELECT Emprunt.id_emprunt, Utilisateur.nom, Utilisateur.prenom, Ressource.titre
FROM Emprunt
JOIN Utilisateur ON Emprunt.id_utilisateur = Utilisateur.id_utilisateur
JOIN Correspond ON Emprunt.id_emprunt = Correspond.id_emprunt
JOIN Exemplaire ON Correspond.reference_ex = Exemplaire.reference_ex
JOIN Ressource ON Exemplaire.id_ressource = Ressource.id_ressource;
