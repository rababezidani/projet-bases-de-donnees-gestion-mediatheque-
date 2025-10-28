-- Requête 4 : Requête avec quatre RIGHT JOIN
\echo "Requête qui affiche les emprunts en cours, les utilisateurs associés, les ressources empruntées, et les pénalités éventuelles"
SELECT
    u.nom AS utilisateur_nom,
    u.prenom AS utilisateur_prenom,
    r.titre AS titre_ressource,
    r.type_ressource,
    e.statut_emprunt,
    e.date_emprunt,
    e.date_retour_prevue,
    p.tarif_amende,
    p.message AS message_penalite
FROM
    Emprunt e
LEFT JOIN Utilisateur u ON e.id_utilisateur = u.id_utilisateur
LEFT JOIN Ressource r ON e.id_ressource = r.id_ressource
LEFT JOIN Penalite p ON e.id_emprunt = p.id_emprunt
LEFT JOIN Notifications n ON u.id_utilisateur = n.id_utilisateur
WHERE
    e.statut_emprunt = 'En cours';

