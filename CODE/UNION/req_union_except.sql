-- Requête avec UNION et EXCEPT : Ressources rangées mais ni empruntées ni réservées
\echo Requête qui trouve les ressources rangées mais ni empruntées ni réservées
SELECT DISTINCT r.id_ressource, r.titre, r.type_ressource, 'Rangée uniquement' AS statut
FROM Ressource r
WHERE r.id_ressource IN (
    SELECT st.reference_ex
    FROM Se_trouve st
    JOIN Exemplaire ex ON st.reference_ex = ex.reference_ex
)
EXCEPT
SELECT DISTINCT r.id_ressource, r.titre, r.type_ressource, 'Réservée ou empruntée' AS statut
FROM Ressource r
WHERE r.id_ressource IN (
    SELECT e.id_ressource
    FROM Emprunt e
    WHERE e.statut_emprunt = 'En cours'
    UNION
    SELECT res.id_ressource
    FROM Reservation res
    WHERE res.statut_de_reservation IN ('Confirmée', 'En attente')
)
ORDER BY titre;
