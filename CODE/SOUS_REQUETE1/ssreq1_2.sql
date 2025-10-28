-- Requête avec 1 niveau de sous-requête : Rayons contenant des photographies/cartes empruntées par des professeurs
\echo Requête qui trouve les rayons contenant des photographies/cartes empruntées par des professeurs
SELECT DISTINCT et.rayon, et.section, et.etage
FROM Etagere et
WHERE et.id_etagere IN (
    SELECT st.id_etagere
    FROM Se_trouve st
    WHERE st.reference_ex IN (
        SELECT ex.reference_ex
        FROM Exemplaire ex
        WHERE ex.id_ressource IN (
            SELECT pc.id_ressource
            FROM Photographie_Carte pc
        ) AND ex.id_personnel IN (
            SELECT p.id_personnel
            FROM Personnel p
            JOIN Utilisateur u ON p.id_utilisateur = u.id_utilisateur
            WHERE u.role = 'Professeur'
        )
    )
);
