-- Drops
DROP TABLE IF EXISTS Magazine CASCADE;
DROP TABLE IF EXISTS Livre CASCADE;
DROP TABLE IF EXISTS Ressource CASCADE;
DROP TABLE IF EXISTS DVD CASCADE;
DROP TABLE IF EXISTS Photographie_Carte CASCADE;
DROP TABLE IF EXISTS Bandes_Dessinees CASCADE;
DROP TABLE IF EXISTS Utilisateur CASCADE;
DROP TABLE IF EXISTS Exemplaire CASCADE;
DROP TABLE IF EXISTS Notifications CASCADE;
DROP TABLE IF EXISTS Personnel CASCADE;
DROP TABLE IF EXISTS Emprunt CASCADE;
DROP TABLE IF EXISTS Historique_abonnement CASCADE;
DROP TABLE IF EXISTS Avis CASCADE;
DROP TABLE IF EXISTS Organisme CASCADE;
DROP TABLE IF EXISTS Penalite CASCADE;
DROP TABLE IF EXISTS Theme CASCADE;
DROP TABLE IF EXISTS Professeur CASCADE;
DROP TABLE IF EXISTS Etudiant CASCADE;
DROP TABLE IF EXISTS Souscrit CASCADE;
DROP TABLE IF EXISTS Etagere CASCADE;
DROP TABLE IF EXISTS Appliquer CASCADE;
DROP TABLE IF EXISTS Associer CASCADE;
DROP TABLE IF EXISTS Correspond CASCADE;
DROP TABLE IF EXISTS Se_trouve CASCADE;
DROP TABLE IF EXISTS Projection CASCADE;
DROP TABLE IF EXISTS Reservation CASCADE;


-- Création des tables

-- Table Ressource
CREATE TABLE Ressource (
    id_ressource SERIAL PRIMARY KEY,
    titre VARCHAR(255),
    auteur VARCHAR(255),
    date_publication DATE,
    type_ressource VARCHAR(50),
    langue VARCHAR(50)
);

-- Table Utilisateur
CREATE TABLE Utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    role VARCHAR(50),
    adresse VARCHAR(255),
    est_abonne BOOLEAN
);

-- Table Personnel
CREATE TABLE Personnel (
    id_personnel SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    fonction VARCHAR(50),
    departement VARCHAR(50)
);

-- Table Magazine
CREATE TABLE Magazine (
    id_magazine SERIAL PRIMARY KEY,
    id_ressource INT REFERENCES Ressource(id_ressource),
    numero_edition INT,
    date_parution DATE
);

-- Table Livre
CREATE TABLE Livre (
    id_livre SERIAL PRIMARY KEY,
    id_ressource INT REFERENCES Ressource(id_ressource),
    titre VARCHAR(255),
    ISBN VARCHAR(13),
    nombre_pages INT
);

-- Table DVD
CREATE TABLE DVD (
    id_DVD SERIAL PRIMARY KEY,
    id_ressource INT REFERENCES Ressource(id_ressource),
    duree TIME,
    format VARCHAR(50),
    age_minimum INT
);

-- Table Photographie / Carte
CREATE TABLE Photographie_Carte (
    id_PhotoCarte SERIAL PRIMARY KEY,
    id_ressource INT REFERENCES Ressource(id_ressource),
    dimension VARCHAR(100),
    lieu VARCHAR(255)
);

-- Table Bandes Dessinées
CREATE TABLE Bandes_Dessinees (
    id_BD SERIAL PRIMARY KEY,
    id_ressource INT REFERENCES Ressource(id_ressource),
    auteur VARCHAR(255),
    genre VARCHAR(50),
    numero_volume INT
);

-- Table Exemplaire
CREATE TABLE Exemplaire (
    reference_ex SERIAL PRIMARY KEY,
    id_personnel INT NOT NULL REFERENCES Personnel(id_personnel),
    id_ressource INT NOT NULL REFERENCES Ressource(id_ressource)
);

-- Table Notifications
CREATE TABLE Notifications (
    code_notif SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    email VARCHAR(255),
    date_notification DATE
);

-- Table Emprunt
CREATE TABLE Emprunt (
    id_emprunt SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    id_ressource INT REFERENCES Ressource(id_ressource),
    statut_emprunt VARCHAR(50) CHECK (statut_emprunt IN ('En cours', 'Terminé', 'Annulé')),
    date_emprunt DATE NOT NULL DEFAULT CURRENT_DATE,
    date_retour_prevue DATE NOT NULL
);

-- Table Historique Abonnement
CREATE TABLE Historique_abonnement (
    code_abonnement SERIAL PRIMARY KEY,
    type_abonnement VARCHAR(50),
    date_debut DATE,
    date_fin DATE
);

-- Table Avis
CREATE TABLE Avis (
    id_avis SERIAL PRIMARY KEY,
    id_utilisateur INT NOT NULL REFERENCES Utilisateur(id_utilisateur),
    id_ressource INT NOT NULL REFERENCES Ressource(id_ressource),
    note INT CHECK (note >= 1 AND note <= 5),
    commentaire TEXT,
    date DATE DEFAULT CURRENT_DATE
);

-- Table Organisme
CREATE TABLE Organisme (
    id_organisme SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur)
);

-- Table Pénalité
CREATE TABLE Penalite (
    id_penalite SERIAL PRIMARY KEY,
    id_emprunt INT REFERENCES Emprunt(id_emprunt),
    tarif_amende NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    message TEXT
);

-- Table Thème
CREATE TABLE Theme (
    id_theme SERIAL PRIMARY KEY,
    nom_theme VARCHAR(50),
    description TEXT
);

-- Table Professeur
CREATE TABLE Professeur (
    id_professeur SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    specialite VARCHAR(100)
);

-- Table Étudiant
CREATE TABLE Etudiant (
    id_etudiant SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    programme_etude VARCHAR(100)
);

-- Table Souscrit
CREATE TABLE Souscrit (
    code_abonnement INT REFERENCES Historique_abonnement(code_abonnement),
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    PRIMARY KEY (code_abonnement, id_utilisateur)
);

-- Table Etagère
CREATE TABLE Etagere (
    id_etagere SERIAL PRIMARY KEY,
    etage INT,
    rayon VARCHAR(1),
    section VARCHAR(50)
);

-- Table Appliquer
CREATE TABLE Appliquer (
    id_penalite INT REFERENCES Penalite(id_penalite),
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    PRIMARY KEY (id_penalite, id_utilisateur)
);

-- Table Associer
CREATE TABLE Associer (
    id_ressource INT REFERENCES Ressource(id_ressource),
    id_theme INT REFERENCES Theme(id_theme),
    PRIMARY KEY (id_ressource, id_theme)
);

-- Table Correspond
CREATE TABLE Correspond (
    id_emprunt INT REFERENCES Emprunt(id_emprunt),
    reference_ex INT REFERENCES Exemplaire(reference_ex),
    PRIMARY KEY (id_emprunt, reference_ex)
);

-- Table Se trouve
CREATE TABLE Se_trouve (
    id_etagere INT REFERENCES Etagere(id_etagere),
    reference_ex INT REFERENCES Exemplaire(reference_ex),
    PRIMARY KEY (id_etagere, reference_ex)
);

-- Table Projection
CREATE TABLE Projection (
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    id_DVD INT REFERENCES DVD(id_DVD),
    PRIMARY KEY (id_utilisateur, id_DVD)
);

-- Table Réservation
CREATE TABLE Reservation (
    id_reservation SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    id_ressource INT REFERENCES Ressource(id_ressource),
    code_notif INT REFERENCES Notifications(code_notif),
    statut_de_reservation VARCHAR(50),
    date_de_reservation DATE
);