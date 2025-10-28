-- Requête 6 : Requête avec quatre OUTER JOIN
\echo "Requête : Affiche les utilisateurs abonnés, leurs abonnements, leur rôle spécifique (professeur ou étudiant) et les pénalités appliquées."

SELECT 
    u.id_utilisateur,
    u.nom AS utilisateur_nom,
    u.prenom AS utilisateur_prenom,
    ha.type_abonnement,
    ha.date_debut AS debut_abonnement,
    ha.date_fin AS fin_abonnement,
    p.specialite AS specialite_professeur,
    e.programme_etude AS programme_etude_etudiant,
    pe.tarif_amende AS montant_penalite,
    pe.message AS message_penalite
FROM 
    Utilisateur u
FULL OUTER JOIN Souscrit s ON u.id_utilisateur = s.id_utilisateur
FULL OUTER JOIN Historique_abonnement ha ON s.code_abonnement = ha.code_abonnement
FULL OUTER JOIN Professeur p ON u.id_utilisateur = p.id_utilisateur
FULL OUTER JOIN Etudiant e ON u.id_utilisateur = e.id_utilisateur
FULL OUTER JOIN Appliquer ap ON u.id_utilisateur = ap.id_utilisateur
FULL OUTER JOIN Penalite pe ON ap.id_penalite = pe.id_penalite
WHERE 
    u.est_abonne = TRUE
ORDER BY 
    u.nom, u.prenom;
