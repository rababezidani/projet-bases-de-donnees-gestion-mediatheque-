--Trigger pour gérer les pénalités avec les corrections appliquées

-- Supprimer le trigger et la fonction si déjà existants
DROP TRIGGER IF EXISTS appliquer_penalite_trigger ON Emprunt;
DROP FUNCTION IF EXISTS appliquer_penalite();

-- Créer la fonction appliquer_penalite
CREATE OR REPLACE FUNCTION appliquer_penalite()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier si l'emprunt est en retard en comparant la date actuelle et la date prévue
    IF (NEW.statut_emprunt = 'retard') THEN
        DECLARE
            nb_jours_retard INTEGER;
            montant_amende NUMERIC;
            type_ressource_var VARCHAR(50); -- Pour stocker le type de ressource
        BEGIN
            -- Calculer le nombre de jours de retard
            nb_jours_retard := CURRENT_DATE - NEW.date_retour_prevue;

            -- Récupérer le type de ressource
            SELECT r.type_ressource INTO type_ressource_var 
            FROM Ressource r 
            WHERE r.id_ressource = NEW.id_ressource;

            -- Calculer le montant de l'amende en fonction du type de ressource
            montant_amende := CASE 
                WHEN type_ressource_var = 'Livre' THEN 0.5 * nb_jours_retard
                WHEN type_ressource_var = 'DVD' THEN 1 * nb_jours_retard
                WHEN type_ressource_var = 'Magazine' THEN 0.25 * nb_jours_retard
                ELSE 0 -- Aucun montant par défaut pour les types inconnus
            END;

            -- Insérer une pénalité dans la table Penalite
            INSERT INTO Penalite (id_emprunt, tarif_amende, message)
            VALUES (NEW.id_emprunt, montant_amende, 'Retard dans le retour de la ressource');
        END;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le trigger
CREATE TRIGGER appliquer_penalite_trigger
AFTER UPDATE ON Emprunt
FOR EACH ROW
WHEN (NEW.statut_emprunt = 'retard')
EXECUTE FUNCTION appliquer_penalite();

-- Test avec des données existantes
\echo Test du trigger pour gérer les pénalités en cas de retard

INSERT INTO Ressource (id_ressource, titre, auteur, date_publication, type_ressource, langue)
VALUES 
(9, 'Livre de Test', 'Auteur Test', '2022-01-01', 'Livre', 'Français'),
(10, 'DVD de Test', 'Auteur Test', '2023-01-01', 'DVD', 'Français'),
(11, 'Magazine de Test', 'Auteur Test', '2021-01-01', 'Magazine', 'Français');

INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue)
VALUES
(1, 9, 'retard', '2023-11-15', '2023-12-01'),
(2, 10, 'retard', '2023-11-15', '2023-12-01'),
(3, 11, 'retard', '2023-11-15', '2023-12-01');

-- Vérification des pénalités créées
\echo Vérification des pénalités ajoutées
SELECT * FROM Penalite;

-- Nettoyage des données insérées pour le test
DELETE FROM Emprunt WHERE id_ressource IN (9, 10, 11);
DELETE FROM Ressource WHERE id_ressource IN (9, 10, 11);
DELETE FROM Penalite WHERE id_emprunt IN (SELECT id_emprunt FROM Emprunt WHERE id_ressource IN (9, 10, 11));
