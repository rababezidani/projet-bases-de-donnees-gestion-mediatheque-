-- Requête 5 : Requête avec quatre LEFT JOIN
\echo "Requête 5 : Requête qui affiche les ressources avec leurs avis, thèmes associés et emplacement dans la médiathèque."

SELECT 
    Ressource.id_ressource,
    Ressource.titre AS titre_ressource,
    Ressource.auteur,
    Theme.nom_theme AS theme_associe,
    Avis.note AS note_avis,
    Avis.commentaire AS commentaire_avis,
    Etagere.section AS section_ressource,
    Etagere.rayon AS rayon_ressource
FROM 
    Ressource
LEFT JOIN 
    Associer ON Ressource.id_ressource = Associer.id_ressource
LEFT JOIN 
    Theme ON Associer.id_theme = Theme.id_theme
LEFT JOIN 
    Avis ON Ressource.id_ressource = Avis.id_ressource
LEFT JOIN 
    Exemplaire ON Ressource.id_ressource = Exemplaire.id_ressource
LEFT JOIN 
    Se_trouve ON Exemplaire.reference_ex = Se_trouve.reference_ex
LEFT JOIN 
    Etagere ON Se_trouve.id_etagere = Etagere.id_etagere
ORDER BY 
    Ressource.titre ASC;
