-- Supprimer les emprunts existants pour éviter les conflits
DELETE FROM Emprunt WHERE id_utilisateur IN (1, 2, 3);

-- Vérifier les rôles des utilisateurs
SELECT id_utilisateur, role FROM Utilisateur WHERE id_utilisateur IN (1, 2, 3);

-- Si le rôle de l'utilisateur 3 est NULL ou incorrect, corrigez-le
UPDATE Utilisateur SET role = 'Organisme' WHERE id_utilisateur = 3;


CREATE OR REPLACE FUNCTION verifier_limite_emprunt_simple()
RETURNS TRIGGER AS $$
DECLARE
    nb_emprunts INT;
    limite_max INT;
BEGIN
    -- Déterminer la limite maximale d'emprunts selon le rôle de l'utilisateur
    SELECT CASE 
        WHEN role = 'Etudiant' THEN 3
        WHEN role = 'Professeur' THEN 5
        WHEN role = 'Organisme' THEN 20
        ELSE 0
    END INTO limite_max
    FROM Utilisateur
    WHERE id_utilisateur = NEW.id_utilisateur;

    -- Compter les emprunts "En cours" de l'utilisateur
    SELECT COUNT(*) INTO nb_emprunts
    FROM Emprunt
    WHERE id_utilisateur = NEW.id_utilisateur AND statut_emprunt = 'En cours';

    -- Vérifier si la limite est dépassée
    IF nb_emprunts >= limite_max THEN
        RAISE EXCEPTION 'Limite d''emprunts dépassée pour l''utilisateur % : maximum % autorisé', NEW.id_utilisateur, limite_max;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_limite_emprunt
BEFORE INSERT ON Emprunt
FOR EACH ROW
EXECUTE FUNCTION verifier_limite_emprunt_simple();

-- Tester pour l'étudiant (id_utilisateur = 1)
INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue)
VALUES (1, 2, 'En cours', '2023-12-01', '2023-12-15'),
       (1, 3, 'En cours', '2023-12-02', '2023-12-16'),
       (1, 4, 'En cours', '2023-12-03', '2023-12-17');

-- Ce 4ème emprunt devrait échouer
INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue)
VALUES (1, 5, 'En cours', '2023-12-04', '2023-12-18');

-- Tester pour le professeur (id_utilisateur = 2)
INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue)
VALUES (2, 1, 'En cours', '2023-12-01', '2023-12-15'),
       (2, 2, 'En cours', '2023-12-02', '2023-12-16'),
       (2, 3, 'En cours', '2023-12-03', '2023-12-17'),
       (2, 4, 'En cours', '2023-12-04', '2023-12-18'),
       (2, 5, 'En cours', '2023-12-05', '2023-12-19');

-- Ce 6ème emprunt devrait échouer
INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue)
VALUES (2, 6, 'En cours', '2023-12-06', '2023-12-20');

-- Tester pour l'organisme (id_utilisateur = 3)
DO $$
BEGIN
    FOR i IN 1..20 LOOP
        INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue)
        VALUES (3, (i % 8) + 1, 'En cours', '2023-12-01', '2023-12-15');
    END LOOP;
END $$;

-- Ce 21ème emprunt devrait échouer
INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue)
VALUES (3, 8, 'En cours', '2023-12-21', '2024-01-05');

-- Supprimer les emprunts de test
DELETE FROM Emprunt WHERE date_emprunt >= '2023-12-01';

-- Supprimer le trigger et la fonction
DROP TRIGGER IF EXISTS trigger_limite_emprunt ON Emprunt;
DROP FUNCTION IF EXISTS verifier_limite_emprunt_simple();
