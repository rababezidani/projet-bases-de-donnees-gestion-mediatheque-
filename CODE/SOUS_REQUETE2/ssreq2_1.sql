-- Requête avec 2 niveaux de sous-requête : Ressources les plus empruntées par des utilisateurs ayant des pénalités
\echo Requête qui liste les ressources les plus empruntées par des utilisateurs ayant des pénalités, avec le statut d emprunts terminés
SELECT r.titre, r.type_ressource, COUNT(e.id_emprunt) AS nombre_emprunts
FROM Ressource r
JOIN Emprunt e ON r.id_ressource = e.id_ressource
WHERE e.id_utilisateur IN (
    SELECT DISTINCT e.id_utilisateur
    FROM Penalite p
    WHERE p.tarif_amende > 0 AND p.id_emprunt IN (
        SELECT e2.id_emprunt
        FROM Emprunt e2
        WHERE e2.statut_emprunt = 'Terminé'
    )
)
GROUP BY r.titre, r.type_ressource
ORDER BY nombre_emprunts DESC;