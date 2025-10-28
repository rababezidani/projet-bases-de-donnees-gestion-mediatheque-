-- Requête corrigée : Utilisateurs ayant réservé une ressource empruntée actuellement en retard
\echo Requête qui liste les utilisateurs ayant réservé des ressources empruntées en retard
SELECT u.nom, u.prenom, r.titre
FROM Utilisateur u
JOIN Reservation res ON u.id_utilisateur = res.id_utilisateur
JOIN Ressource r ON res.id_ressource = r.id_ressource
WHERE res.id_ressource IN (
    SELECT e.id_ressource
    FROM Emprunt e
    WHERE e.date_retour_prevue < CURRENT_DATE AND e.statut_emprunt = 'En cours'
)
AND res.statut_de_reservation = 'En attente';
