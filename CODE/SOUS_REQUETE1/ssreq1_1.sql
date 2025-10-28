-- Requête avec 1 niveau de sous-requête : Utilisateurs ayant emprunté des photographies/cartes en retard
\echo Requête qui liste les utilisateurs ayant emprunté des photographies ou cartes en retard
SELECT u.id_utilisateur, u.nom, u.prenom, u.role
FROM Utilisateur u
WHERE u.id_utilisateur IN (
    SELECT e.id_utilisateur
    FROM Emprunt e
    WHERE e.id_ressource IN (
        SELECT pc.id_ressource
        FROM Photographie_Carte pc
    ) AND e.date_retour_prevue < CURRENT_DATE AND e.statut_emprunt = 'En cours'
);
