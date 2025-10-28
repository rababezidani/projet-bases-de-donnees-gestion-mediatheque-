--Trigger pour gérer les notifications automatiques

-- Supprimer le trigger et la fonction si déjà existants
DROP TRIGGER IF EXISTS envoyer_notification_trigger ON Emprunt;
DROP FUNCTION IF EXISTS envoyer_notification();

-- Créer la fonction envoyer_notification
CREATE OR REPLACE FUNCTION envoyer_notification()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier si l'emprunt approche de sa date de retour prévue (2 jours avant la date prévue)
    IF (NEW.date_retour_prevue - CURRENT_DATE <= 2 AND NEW.statut_emprunt = 'en cours') THEN
        INSERT INTO Notifications (id_utilisateur, email, date_notification)
        SELECT 
            NEW.id_utilisateur, 
            U.email, 
            CURRENT_DATE
        FROM 
            Utilisateur U
        WHERE 
            U.id_utilisateur = NEW.id_utilisateur;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le trigger
CREATE TRIGGER envoyer_notification_trigger
AFTER UPDATE ON Emprunt
FOR EACH ROW
WHEN (NEW.statut_emprunt = 'en cours' AND NEW.date_retour_prevue - CURRENT_DATE <= 2)
EXECUTE FUNCTION envoyer_notification();

-- Test avec des données existantes
\echo Test du trigger pour les notifications automatiques

-- Ajouter des données de test
INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue)
VALUES
(1, 9, 'en cours', '2023-12-01', '2023-12-03'),
(2, 10, 'en cours', '2023-12-01', '2023-12-04');

-- Vérification des notifications créées
\echo Vérification des notifications envoyées
SELECT * FROM Notifications;

-- Nettoyage des données insérées pour le test
DELETE FROM Emprunt WHERE id_utilisateur IN (1, 2);
DELETE FROM Notifications WHERE id_utilisateur IN (1, 2);
