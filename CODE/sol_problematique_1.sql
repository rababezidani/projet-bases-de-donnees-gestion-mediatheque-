--Réponse à la problématique
--Requête pour limiter le nombre d’emprunts pour les étudiants
--Cette requête liste les étudiants ayant dépassé la nouvelle limite d’une ressource empruntable.

SELECT 
    Utilisateur.id_utilisateur,
    Utilisateur.nom,
    Utilisateur.prenom,
    COUNT(Emprunt.id_emprunt) AS total_emprunts
FROM 
    Emprunt
JOIN 
    Utilisateur ON Emprunt.id_utilisateur = Utilisateur.id_utilisateur
WHERE 
    Utilisateur.role = 'Etudiant'
GROUP BY 
    Utilisateur.id_utilisateur, Utilisateur.nom, Utilisateur.prenom
HAVING 
    COUNT(Emprunt.id_emprunt) > 1;
