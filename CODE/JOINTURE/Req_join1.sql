-- Requête 1 : Requête avec une JOINTURE
\echo Requête qui renvoie les ressources disponibles avec leur type et leur nombre d exemplaires

SELECT r.titre AS Titre, r.type_ressource AS Type, COUNT(ex.reference_ex) AS Exemplaires_Disponibles
FROM Ressource r
LEFT JOIN Exemplaire ex ON r.id_ressource = ex.id_ressource
GROUP BY r.titre, r.type_ressource
HAVING COUNT(ex.reference_ex) > 0;