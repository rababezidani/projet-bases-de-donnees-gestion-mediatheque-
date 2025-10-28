-- Inclusion des fichiers pour la création et le remplissage de la base
\i Proj_createBase.sql
\i Proj_fillBase.sql

-- Requête pour afficher toutes les tables
SELECT * FROM Utilisateur;
SELECT * FROM Ressource;
SELECT * FROM Emprunt;
SELECT * FROM Exemplaire;
SELECT * FROM Penalite;
SELECT * FROM Notifications;
SELECT * FROM Personnel;
SELECT * FROM Historique_abonnement;
SELECT * FROM Avis;
SELECT * FROM Organisme;
SELECT * FROM Theme;
SELECT * FROM Professeur;
SELECT * FROM Etudiant;
SELECT * FROM Souscrit;
SELECT * FROM Etagere;
SELECT * FROM Appliquer;
SELECT * FROM Associer;
SELECT * FROM Correspond;
SELECT * FROM Se_trouve;
SELECT * FROM Projection;
SELECT * FROM Reservation;
SELECT * FROM Magazine;
SELECT * FROM Livre;
SELECT * FROM DVD;
SELECT * FROM Photographie_Carte;
SELECT * FROM Bandes_Dessinees;

-- ###############################
-- REQUÊTES SQL
-- ###############################

-- Requête 1 : Requête avec 4 JOINTURES
\echo Requête qui renvoie les utilisateurs ayant des emprunts en retard avec les titres des ressources

SELECT u.nom AS Nom_Utilisateur, r.titre AS Titre_Ressource, e.date_retour_prevue AS Date_Retard
FROM Utilisateur u
JOIN Emprunt e ON u.id_utilisateur = e.id_utilisateur
JOIN Correspond c ON e.id_emprunt = c.id_emprunt
JOIN Exemplaire ex ON c.reference_ex = ex.reference_ex
JOIN Ressource r ON ex.id_ressource = r.id_ressource
WHERE e.statut_emprunt = 'En cours' 
  AND e.date_retour_prevue < CURRENT_DATE;

-- Requête 2 : Requête avec 2 JOINTURES
\echo Requête qui renvoie les utilisateurs ayant des emprunts en retard avec les titres des ressources

SELECT u.nom AS Nom_Utilisateur, r.titre AS Titre_Ressource, e.date_retour_prevue AS Date_Retard
FROM Utilisateur u
JOIN Emprunt e ON u.id_utilisateur = e.id_utilisateur
JOIN Correspond c ON e.id_emprunt = c.id_emprunt
JOIN Ressource r ON c.id_ressource = r.id_ressource
WHERE e.statut_emprunt = 'En cours' 
  AND e.date_retour_prevue < CURRENT_DATE;

-- Requête 3 : Requête avec une JOINTURE
\echo Requête qui renvoie les ressources disponibles avec leur type et leur nombre d'exemplaires

SELECT r.titre AS Titre, r.type_ressource AS Type, COUNT(ex.reference_ex) AS Exemplaires_Disponibles
FROM Ressource r
LEFT JOIN Exemplaire ex ON r.id_ressource = ex.id_ressource
GROUP BY r.titre, r.type_ressource
HAVING COUNT(ex.reference_ex) > 0;

-- Requête 4 : Requête avec une sous-requête de niveau 1
\echo Requête qui renvoie les ressources empruntées par un utilisateur donné (ID = 1)

SELECT r.titre, r.type_ressource
FROM Ressource r
WHERE r.id_ressource IN (
    SELECT ex.id_ressource
    FROM Exemplaire ex
    JOIN Correspond c ON ex.reference_ex = c.reference_ex
    JOIN Emprunt e ON c.id_emprunt = e.id_emprunt
    WHERE e.id_utilisateur = 1
);

-- Requête 5 : Requête avec une sous-requête de niveau 2
\echo Requête qui renvoie les utilisateurs ayant emprunté une ressource de type "Livre"

SELECT u.nom, u.prenom
FROM Utilisateur u
WHERE u.id_utilisateur IN (
    SELECT e.id_utilisateur
    FROM Emprunt e
    WHERE e.id_emprunt IN (
        SELECT c.id_emprunt
        FROM Correspond c
        JOIN Exemplaire ex ON c.reference_ex = ex.reference_ex
        JOIN Ressource r ON ex.id_ressource = r.id_ressource
        WHERE r.type_ressource = 'Livre'
    )
);

-- Requête 6 : Requête avec une sous-requête de niveau 3
\echo Requête de niveau 3 : Utilisateurs ayant emprunté une ressource appartenant à une catégorie avec un prix supérieur à la moyenne

SELECT nom, prenom
FROM Utilisateur
WHERE id_utilisateur IN (
    SELECT e.id_utilisateur
    FROM Emprunt e
    WHERE e.id_emprunt IN (
        SELECT c.id_emprunt
        FROM Correspond c
        WHERE c.reference_ex IN (
            SELECT ex.reference_ex
            FROM Exemplaire ex
            WHERE ex.id_ressource IN (
                SELECT r.id_ressource
                FROM Ressource r
                WHERE r.type_ressource = 'Livre'
            )
        )
    )
);

-- Requête 7 : Requête utilisant un INTERSECT
\echo Requête qui renvoie les utilisateurs ayant emprunté et rendu des ressources

SELECT DISTINCT u.nom, u.prenom
FROM Utilisateur u
JOIN Emprunt e ON u.id_utilisateur = e.id_utilisateur
WHERE e.statut_emprunt = 'Retourné'

INTERSECT

SELECT DISTINCT u.nom, u.prenom
FROM Utilisateur u
JOIN Emprunt e ON u.id_utilisateur = e.id_utilisateur
WHERE e.statut_emprunt = 'En cours';

-- Requête 8 : Création d'une VUE
\echo Création d'une vue pour afficher les utilisateurs avec le total de leurs emprunts

CREATE VIEW Vue_Total_Emprunts_Utilisateurs AS
SELECT u.id_utilisateur, u.nom, u.prenom, COUNT(e.id_emprunt) AS Total_Emprunts
FROM Utilisateur u
JOIN Emprunt e ON u.id_utilisateur = e.id_utilisateur
GROUP BY u.id_utilisateur, u.nom, u.prenom;

-- Appel de la vue
\echo Utilisateurs ayant effectué plus de 3 emprunts
SELECT * FROM Vue_Total_Emprunts_Utilisateurs
WHERE Total_Emprunts > 3;

-- Suppression de la vue
DROP VIEW IF EXISTS Vue_Total_Emprunts_Utilisateurs;

-- ###############################
-- TRIGGERS ET FONCTIONS
-- ###############################

-- Trigger 1 : Ajouter un emprunt et réduire le nombre d'exemplaires disponibles
\echo Ajout d’un emprunt et mise à jour du stock de la ressource

CREATE OR REPLACE FUNCTION ajouter_emprunt()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier si des exemplaires sont disponibles
    IF (SELECT COUNT(*) FROM Exemplaire WHERE id_ressource = NEW.id_ressource) <= 0 THEN
        RAISE EXCEPTION 'Erreur : Pas d''exemplaires disponibles pour cette ressource.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_ajout_emprunt
BEFORE INSERT ON Emprunt
FOR EACH ROW
EXECUTE FUNCTION ajouter_emprunt();

-- Test des triggers
\echo Test d’ajout d’un emprunt
INSERT INTO Emprunt (id_utilisateur, statut_emprunt, date_retour_prevue)
VALUES (1, 'En cours', CURRENT_DATE + INTERVAL '14 days');
