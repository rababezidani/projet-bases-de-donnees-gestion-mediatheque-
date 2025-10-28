-- Supprimer le trigger et la fonction si déjà existants
DROP TRIGGER IF EXISTS set_return_date_trigger ON Emprunt;
DROP FUNCTION IF EXISTS set_return_date();

-- Créer la fonction set_return_date
CREATE OR REPLACE FUNCTION set_return_date()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.id_ressource IS NOT NULL) THEN
        DECLARE
            type_ressource_var VARCHAR(50); -- Nom différent pour éviter l'ambiguïté
        BEGIN
            SELECT r.type_ressource INTO type_ressource_var 
            FROM Ressource r 
            WHERE r.id_ressource = NEW.id_ressource;

            IF type_ressource_var = 'Livre' OR type_ressource_var = 'Magazine' THEN
                NEW.date_retour_prevue := NEW.date_emprunt + INTERVAL '14 days';
            ELSIF type_ressource_var = 'DVD' THEN
                NEW.date_retour_prevue := NEW.date_emprunt + INTERVAL '7 days';
            ELSIF type_ressource_var = 'Photographie' OR type_ressource_var = 'Carte' THEN
                NEW.date_retour_prevue := NEW.date_emprunt + INTERVAL '10 days';
            ELSIF type_ressource_var = 'Bandes Dessinées' THEN
                NEW.date_retour_prevue := NEW.date_emprunt + INTERVAL '14 days';
            ELSE
                RAISE EXCEPTION 'Type de ressource inconnu : %', type_ressource_var;
            END IF;
        END;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le trigger
CREATE TRIGGER set_return_date_trigger
BEFORE INSERT OR UPDATE ON Emprunt
FOR EACH ROW
EXECUTE FUNCTION set_return_date();

-- Test avec des données existantes
\echo Test du trigger avec des données corrigées

INSERT INTO Ressource (id_ressource, titre, auteur, date_publication, type_ressource, langue)
VALUES 
(9, 'Livre de Test', 'Auteur Test', '2022-01-01', 'Livre', 'Français'),
(10, 'DVD de Test', 'Auteur Test', '2023-01-01', 'DVD', 'Français'),
(11, 'Photographie de Test', 'Auteur Test', '2021-01-01', 'Photographie', 'Français'),
(12, 'Carte de Test', 'Auteur Test', '2021-01-01', 'Carte', 'Français'),
(13, 'Bandes Dessinées de Test', 'Auteur Test', '2020-01-01', 'Bandes Dessinées', 'Français');

INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt)
VALUES
(1, 9, 'En cours', '2023-12-01'),
(2, 10, 'En cours', '2023-12-01'),
(3, 11, 'En cours', '2023-12-01'),
(4, 12, 'En cours', '2023-12-01'),
(5, 13, 'En cours', '2023-12-01');

-- Vérification des résultats
\echo Vérification des emprunts et des dates de retour prévues
SELECT id_emprunt, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue
FROM Emprunt
ORDER BY id_emprunt;

-- Nettoyage des données insérées pour le test
DELETE FROM Emprunt WHERE id_ressource IN (9, 10, 11, 12, 13);
DELETE FROM Ressource WHERE id_ressource IN (9, 10, 11, 12, 13);
