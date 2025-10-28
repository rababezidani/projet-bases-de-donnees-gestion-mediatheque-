

INSERT INTO Ressource (titre, auteur, date_publication, type_ressource, langue)
VALUES 
('Les Misérables', 'Victor Hugo', '1862-01-01', 'Livre', 'Français'),
('La Joconde', 'Leonardo da Vinci', '1503-01-01', 'Photographie', 'Français'),
('Introduction to Algorithms', 'Thomas H. Cormen', '2009-09-01', 'Livre', 'Anglais'),
('La Marche de l’Empereur', 'Luc Jacquet', '2005-01-01', 'DVD', 'Français'),
('Le Petit Prince', 'Antoine de Saint-Exupéry', '1943-04-06', 'Livre', 'Français'),
('Star Wars: A New Hope', 'George Lucas', '1977-05-25', 'DVD', 'Anglais'),
('Atlas Mondial', 'National Geographic', '2022-01-01', 'Carte', 'Français'),
('Cosmos', 'Carl Sagan', '1980-01-01', 'Livre', 'Anglais');

INSERT INTO Utilisateur (nom, prenom, email, role, adresse, est_abonne)
VALUES 
('Dupont', 'Jean', 'jean.dupont@example.com', 'Etudiant', '1 Rue des Lilas, Paris', TRUE),
('Martin', 'Claire', 'claire.martin@example.com', 'Professeur', '5 Avenue des Champs, Lyon', TRUE),
('Durand', 'Paul', 'paul.durand@example.com', 'Personnel', '12 Boulevard Haussmann, Marseille', FALSE),
('Morel', 'Sophie', 'sophie.morel@example.com', 'Etudiant', '9 Rue de la Gare, Lille', TRUE),
('Garcia', 'Luis', 'luis.garcia@example.com', 'Professeur', '14 Rue des Arts, Bordeaux', TRUE),
('Bernard', 'Luc', 'luc.bernard@example.com', 'Utilisateur', '15 Boulevard Voltaire, Nice', FALSE),
('Petit', 'Julie', 'julie.petit@example.com', 'Etudiant', '20 Rue de la République, Paris', TRUE),
('Lemoine', 'Pierre', 'pierre.lemoine@example.com', 'Professeur', '30 Rue Carnot, Toulouse', TRUE);

INSERT INTO Livre (id_ressource, titre, ISBN, nombre_pages)
VALUES 
(1, 'Les Misérables', '9780451419439', 1232),
(3, 'Introduction to Algorithms', '9780262033848', 1312),
(5, 'Le Petit Prince', '9782070612758', 96),
(6, 'L’Étranger', '9782070360024', 123),
(7, '1984', '9780451524935', 328),
(8, 'Cosmos', '9780345331359', 432),
(2, 'War and Peace', '9780192833983', 1225),
(4, 'La Divine Comédie', '9780553213393', 798);

INSERT INTO Magazine (id_ressource, numero_edition, date_parution)
VALUES 
(2, 12, '2023-01-15'),
(3, 10, '2023-10-01'),
(4, 24, '2023-03-01'),
(5, 8, '2023-07-01'),
(6, 20, '2023-09-20'),
(7, 30, '2023-12-01'),
(8, 5, '2023-08-15'),
(1, 6, '2023-11-01');

INSERT INTO DVD (id_ressource, duree, format, age_minimum)
VALUES 
(3, '02:30:00', 'Blu-ray', 12),
(5, '01:45:00', 'DVD', 10),
(6, '02:15:00', 'Blu-ray', 15),
(8, '03:00:00', 'DVD', 16),
(2, '01:25:00', 'Blu-ray', 10),
(7, '02:00:00', 'DVD', 13),
(4, '02:49:00', 'Blu-ray', 13),
(1, '01:50:00', 'DVD', 8);

INSERT INTO Photographie_Carte (id_ressource, dimension, lieu)
VALUES 
(2, '60x90 cm', 'Musée du Louvre'),
(8, '100x120 cm', 'National Geographic'),
(4, '70x100 cm', 'Parc Naturel'),
(6, '50x70 cm', 'Tour Eiffel'),
(7, '90x120 cm', 'Disneyland Paris'),
(5, '60x80 cm', 'Montmartre'),
(3, '80x100 cm', 'Mont Blanc'),
(1, '40x60 cm', 'Château de Versailles');

INSERT INTO Bandes_Dessinees (id_ressource, auteur, genre, numero_volume)
VALUES 
(1, 'Jean Dufaux', 'Fantastique', 1),
(3, 'Franquin', 'Humour', 2),
(5, 'Uderzo', 'Aventure', 5),
(6, 'Tardi', 'Historique', 3),
(7, 'Gotlib', 'Satire', 3),
(4, 'Moebius', 'Science-fiction', 2),
(8, 'Peyo', 'Fantaisie', 1),
(2, 'Hergé', 'Aventure', 4);

INSERT INTO Personnel (id_utilisateur, fonction, departement)
VALUES
(5, 'Bibliothécaire', 'Gestion des ressources'),
(7, 'Archiviste', 'Documentation'),
(3, 'Technicien', 'Informatique'),
(6, 'Bibliothécaire', 'Prêts et retours'),
(1, 'Manager', 'Administration'),
(8, 'Responsable IT', 'Systèmes'),
(4, 'Assistant', 'Accueil'),
(2, 'Archiviste adjoint', 'Archives');

INSERT INTO Exemplaire (id_personnel, id_ressource)
VALUES
-- Littérature (1er étage, rayon A)
(1, 1), (1, 5), (1, 7),
-- Sciences (1er étage, rayon B)
(2, 3), (2, 8),
-- Art et Histoire (1er étage, rayons C et D)
(3, 2), (3, 4),
-- Audiovisuel (2e étage, rayon K)
(1, 6), (1, 8),
-- Bandes dessinées (2e étage, rayon L)
(2, 5), (2, 7),
-- Photographies/Cartes (2e étage, rayons N et O)
(3, 8), (3, 2);

INSERT INTO Notifications (id_utilisateur, email, date_notification)
VALUES 
(1, 'jean.dupont@example.com', '2023-11-27'),
(2, 'claire.martin@example.com', '2023-11-28'),
(3, 'paul.durand@example.com', '2023-11-20'),
(4, 'sophie.morel@example.com', '2023-11-19'),
(5, 'luis.garcia@example.com', '2023-11-18'),
(6, 'luc.bernard@example.com', '2023-11-15'),
(7, 'julie.petit@example.com', '2023-11-10'),
(8, 'pierre.lemoine@example.com', '2023-11-05');


INSERT INTO Emprunt (id_utilisateur, id_ressource, statut_emprunt, date_emprunt, date_retour_prevue)
VALUES
(1, 1, 'En cours', '2023-11-20', '2023-12-05'),
(2, 3, 'Terminé', '2023-10-01', '2023-10-15'),
(3, 5, 'Annulé', '2023-09-10', '2023-09-25'),
(4, 6, 'En cours', '2023-11-28', '2023-12-13'),
(5, 8, 'En cours', '2023-11-18', '2023-12-02'),
(6, 2, 'Terminé', '2023-10-20', '2023-11-01'),
(7, 4, 'Annulé', '2023-09-15', '2023-09-30'),
(8, 7, 'En cours', '2023-11-25', '2023-12-10');


INSERT INTO Historique_abonnement (type_abonnement, date_debut, date_fin)
VALUES
('Annuel', '2023-01-01', '2023-12-31'),
('Mensuel', '2023-11-01', '2023-11-30'),
('Annuel', '2022-01-01', '2022-12-31'),
('Mensuel', '2023-10-01', '2023-10-31'),
('Annuel', '2021-01-01', '2021-12-31'),
('Annuel', '2024-01-01', '2024-12-31'),
('Mensuel', '2023-12-01', '2023-12-31'),
('Mensuel', '2023-09-01', '2023-09-30');

INSERT INTO Avis (id_utilisateur, id_ressource, note, commentaire, date)
VALUES
(1, 1, 5, 'Un classique incontournable.', '2023-11-27'),
(2, 3, 4, 'Très bon livre technique.', '2023-11-28'),
(3, 5, 5, 'Émouvant et captivant.', '2023-11-20'),
(4, 6, 3, 'Intéressant mais un peu daté.', '2023-11-19'),
(5, 8, 4, 'Très utile pour les recherches.', '2023-11-18'),
(6, 2, 5, 'Une lecture fascinante.', '2023-11-15'),
(7, 4, 2, 'Pas très captivant.', '2023-11-10'),
(8, 7, 4, 'Bon film, bien réalisé.', '2023-11-05');

INSERT INTO Organisme (id_utilisateur)
VALUES
(1), (2), (3), (4), (5), (6), (7), (8);

INSERT INTO Penalite (id_emprunt, tarif_amende, message)
VALUES
(1, 10.00, 'Retard de retour'),
(2, 5.00, 'Document abîmé'),
(3, 15.00, 'Non restitution'),
(4, 0.00, 'Aucune pénalité'),
(5, 8.00, 'Retard de retour'),
(6, 20.00, 'Document perdu'),
(7, 12.00, 'Non restitution'),
(8, 7.00, 'Retard de retour');

INSERT INTO Theme (nom_theme, description)
VALUES
('Littérature', 'Œuvres littéraires classiques et modernes'),
('Science', 'Connaissances et découvertes scientifiques'),
('Aventure', 'Romans et récits d’aventures'),
('Histoire', 'Documents et ouvrages historiques'),
('Humour', 'Bandes dessinées et livres humoristiques'),
('Technologie', 'Avancées et innovations technologiques'),
('Fantastique', 'Livres et BD de fiction fantastique'),
('Photographie', 'Albums et guides photographiques');

INSERT INTO Reservation (id_utilisateur, id_ressource, code_notif, statut_de_reservation, date_de_reservation)
VALUES
(1, 1, 1, 'Confirmée', '2023-11-27'),
(2, 3, 2, 'En attente', '2023-11-28'),
(3, 5, 3, 'Confirmée', '2023-11-20'),
(4, 6, 4, 'Annulée', '2023-11-19'),
(5, 8, 5, 'Confirmée', '2023-11-18'),
(6, 2, 6, 'En attente', '2023-11-15'),
(7, 4, 7, 'Confirmée', '2023-11-10'),
(8, 7, 8, 'En attente', '2023-11-05');

INSERT INTO Theme (nom_theme, description)
VALUES
('Littérature', 'Œuvres littéraires classiques et modernes'),
('Science', 'Connaissances et découvertes scientifiques'),
('Aventure', 'Romans et récits d’aventures'),
('Histoire', 'Documents et ouvrages historiques'),
('Humour', 'Bandes dessinées et livres humoristiques'),
('Technologie', 'Avancées et innovations technologiques'),
('Fantastique', 'Livres et BD de fiction fantastique'),
('Photographie', 'Albums et guides photographiques');

INSERT INTO Professeur (id_utilisateur, specialite)
VALUES
(2, 'Littérature française'),
(5, 'Histoire contemporaine'),
(6, 'Technologie de l’information'),
(8, 'Physique quantique'),
(3, 'Mathématiques appliquées'),
(7, 'Biologie moléculaire'),
(4, 'Économie internationale'),
(1, 'Philosophie moderne');

INSERT INTO Etudiant (id_utilisateur, programme_etude)
VALUES
(1, 'Licence Lettres'),
(3, 'Master Informatique'),
(6, 'Licence Histoire'),
(7, 'Master Biologie'),
(5, 'Licence Sciences de l’éducation'),
(2, 'Licence Physique'),
(4, 'Master Mathématiques'),
(8, 'Licence Chimie');

INSERT INTO Souscrit (code_abonnement, id_utilisateur)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

INSERT INTO Etagere (etage, rayon, section)
VALUES
(0, 'A', 'Réception'),
(0, 'B', 'Consultation rapide'),
(0, 'C', 'Zone prêt/retour'),
(1, 'A', 'Littérature'),
(1, 'B', 'Science'),
(1, 'C', 'Art'),
(1, 'D', 'Histoire'),
(1, 'E', 'Technologie'),
(1, 'F', 'Humour'),
(1, 'G', 'Fantastique'),
(1, 'H', 'Photographie'),
(2, 'K', 'Audiovisuel'),
(2, 'L', 'Bandes dessinées'),
(2, 'M', 'Mangas'),
(2, 'N', 'Cartes'),
(2, 'O', 'Photographies supplémentaires'),
(2, 'P', 'Ressources numériques');

INSERT INTO Appliquer (id_penalite, id_utilisateur)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

INSERT INTO Associer (id_ressource, id_theme)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

INSERT INTO Correspond (id_emprunt, reference_ex)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

INSERT INTO Se_trouve (id_etagere, reference_ex)
VALUES
(1, 1), (1, 5), (1, 7), -- Littérature
(2, 3), (2, 8),        -- Science
(3, 2), (3, 4),        -- Art/Histoire
(10, 6), (10, 8),      -- Audiovisuel
(11, 5), (11, 7),      -- Bandes dessinées
(13, 8), (14, 2);      -- Photographies/Cartes

INSERT INTO Projection (id_utilisateur, id_DVD)
VALUES
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 1),
(8, 2);

INSERT INTO Reservation (id_utilisateur, id_ressource, code_notif, statut_de_reservation, date_de_reservation)
VALUES
(1, 1, 1, 'Confirmée', '2023-11-27'),
(2, 2, 2, 'En attente', '2023-11-28'),
(3, 3, 3, 'Annulée', '2023-11-20'),
(4, 4, 4, 'Confirmée', '2023-11-19'),
(5, 5, 5, 'En attente', '2023-11-18'),
(6, 6, 6, 'Confirmée', '2023-11-15'),
(7, 7, 7, 'Annulée', '2023-11-10'),
(8, 8, 8, 'Confirmée', '2023-11-05');
