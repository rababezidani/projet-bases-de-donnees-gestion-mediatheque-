-- Requête : Films projetés mais rarement empruntés ou mal notés
\echo Requête qui trouve les films projetés mais rarement empruntés ou mal notés
SELECT DISTINCT r.id_ressource, r.titre, r.type_ressource, 
       COALESCE(em.nombre_emprunts, 0) AS nombre_emprunts,
       COALESCE(av.note_moyenne, 0) AS note_moyenne,
       'Film projeté' AS statut
FROM Ressource r
JOIN Projection p ON r.id_ressource = p.id_DVD
LEFT JOIN (
    SELECT e.id_ressource, COUNT(e.id_emprunt) AS nombre_emprunts
    FROM Emprunt e
    GROUP BY e.id_ressource
) em ON r.id_ressource = em.id_ressource
LEFT JOIN (
    SELECT a.id_ressource, AVG(a.note) AS note_moyenne
    FROM Avis a
    GROUP BY a.id_ressource
) av ON r.id_ressource = av.id_ressource
WHERE r.type_ressource = 'DVD'
  AND (COALESCE(em.nombre_emprunts, 0) < 2 OR COALESCE(av.note_moyenne, 0) < 3)
ORDER BY nombre_emprunts, note_moyenne, titre;
