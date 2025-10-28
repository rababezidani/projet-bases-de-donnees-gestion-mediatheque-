--Réduction des Durées d’Emprunt
--Requête pour identifier les emprunts avec des durées prolongées à ajuster
--Cette requête vérifie les emprunts dont les durées actuelles dépassent les nouvelles limites.


SELECT 
    Emprunt.id_emprunt,
    Ressource.titre,
    Emprunt.date_emprunt,
    Emprunt.date_retour_prevue,
    CASE 
        WHEN Ressource.type_ressource = 'Livre' OR Ressource.type_ressource = 'Magazine' THEN 7
        WHEN Ressource.type_ressource = 'DVD' THEN 3
        WHEN Ressource.type_ressource = 'Photographie' OR Ressource.type_ressource = 'Carte' THEN 5
        WHEN Ressource.type_ressource = 'Bande Dessinée' THEN 7
    END AS nouvelle_duree
FROM 
    Emprunt
JOIN 
    Ressource ON Emprunt.id_utilisateur = Ressource.id_ressource
WHERE 
    Emprunt.date_retour_prevue > (Emprunt.date_emprunt + INTERVAL '14 days');
