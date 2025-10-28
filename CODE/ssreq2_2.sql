-- Requête avec 2 niveaux de sous-requête 
\echo Requête qui liste les ressources avec des avis supérieurs à 4 et le nombre d emprunts

SELECT r.titre, r.auteur, COUNT(e.id_emprunt) AS nombre_emprunts
FROM Ressource r
JOIN Emprunt e ON r.id_ressource = e.id_ressource
WHERE e.id_utilisateur IN (
    SELECT a.id_utilisateur
    FROM Avis a
    WHERE a.note > 4 AND a.id_ressource = r.id_ressource
)
GROUP BY r.titre, r.auteur
ORDER BY nombre_emprunts DESC;

