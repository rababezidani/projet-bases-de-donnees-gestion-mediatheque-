--Trigger pour associer automatiquement des thèmes aux ressources

-- Supprimer le trigger et la fonction si déjà existants
DROP TRIGGER IF EXISTS ajouter_theme_trigger ON Ressource;
DROP FUNCTION IF EXISTS ajouter_theme();

-- Créer la fonction ajouter_theme
CREATE OR REPLACE FUNCTION ajouter_theme()
RETURNS TRIGGER AS $$
BEGIN
    -- Ajouter automatiquement un thème en fonction du type de ressource
    IF (NEW.type_ressource = 'Livre') THEN
        INSERT INTO Theme (id_theme, nom_theme) VALUES (DEFAULT, 'Littérature')
        ON CONFLICT (nom_theme) DO NOTHING;

        INSERT INTO Associer (id_ressource, id_theme)
        SELECT NEW.id_ressource, id_theme 
        FROM Theme 
        WHERE nom_theme = 'Littérature';

    ELSIF (NEW.type_ressource = 'DVD') THEN
        INSERT INTO Theme (id_theme, nom_theme) VALUES (DEFAULT, 'Audiovisuel')
        ON CONFLICT (nom_theme) DO NOTHING;

        INSERT INTO Associer (id_ressource, id_theme)
        SELECT NEW.id_ressource, id_theme 
        FROM Theme 
        WHERE nom_theme = 'Audiovisuel';

    ELSIF (NEW.type_ressource = 'Magazine') THEN
        INSERT INTO Theme (id_theme, nom_theme) VALUES (DEFAULT, 'Périodiques')
        ON CONFLICT (nom_theme) DO NOTHING;

        INSERT INTO Associer (id_ressource, id_theme)
        SELECT NEW.id_ressource, id_theme 
        FROM Theme 
        WHERE nom_theme = 'Périodiques';

    ELSE
        RAISE NOTICE 'Aucun thème spécifique pour ce type de ressource : %', NEW.type_ressource;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le trigger
CREATE TRIGGER ajouter_theme_trigger
AFTER INSERT ON Ressource
FOR EACH ROW
EXECUTE FUNCTION ajouter_theme();

-- Test avec des données existantes
\echo Test du trigger pour associer des thèmes automatiquement

INSERT INTO Ressource (id_ressource, titre, auteur, date_publication, type_ressource, langue)
VALUES 
(14, 'Roman Test', 'Auteur Littéraire', '2020-01-01', 'Livre', 'Français'),
(15, 'Film Test', 'Réalisateur Test', '2021-01-01', 'DVD', 'Français'),
(16, 'Magazine Test', 'Éditeur Test', '2022-01-01', 'Magazine', 'Français');

-- Vérification des associations créées
\echo Vérification des associations thème-ressource
SELECT r.titre, t.nom_theme
FROM Ressource r
JOIN Associer a ON r.id_ressource = a.id_ressource
JOIN Theme t ON a.id_theme = t.id_theme;

-- Nettoyage des données insérées pour le test
DELETE FROM Ressource WHERE id_ressource IN (14, 15, 16);
DELETE FROM Associer WHERE id_ressource IN (14, 15, 16);
DELETE FROM Theme WHERE nom_theme IN ('Littérature', 'Audiovisuel', 'Périodiques');
