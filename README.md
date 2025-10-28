
# 📚 Projet Base de Données — Gestion d’une Médiathèque

Ce projet a été réalisé dans le cadre du module **Bases de Données (2A-SIE)** à l’École d’Ingénieurs Denis Diderot – **Université Paris Cité**.
Il vise à concevoir et implémenter une **base de données relationnelle complète** pour la gestion d’une **médiathèque moderne**, en appliquant la méthode **MERISE** et en utilisant **PostgreSQL** pour l’implémentation.

---

## 🎯 Objectifs du projet

L’objectif principal est de développer un système permettant de :

* Gérer les **ressources** : livres, magazines, DVD, cartes, bandes dessinées, etc.
* Suivre les **emprunts, retours et réservations**.
* Calculer automatiquement les **pénalités de retard**.
* Automatiser les **notifications** pour les utilisateurs.
* Optimiser la **disponibilité des ressources** en période de forte demande.

---

## 🧠 Problématique

Comment optimiser la gestion des ressources en médiathèque lors des périodes de forte demande, afin de minimiser les temps d’attente et maximiser la disponibilité des ressources les plus populaires ?

### 💡 Solution proposée

1. Détection automatique des périodes de forte demande grâce aux historiques d’emprunt.
2. Réduction temporaire des durées et limites d’emprunt pour les étudiants.
3. Augmentation progressive des pénalités en cas de retard.
4. Automatisation des notifications et rappels pour fluidifier la circulation des ressources.

---

## 🧱 Structure du dépôt

* **CODE/** → Contient les scripts SQL (création, insertion, requêtes, vues).
* **MCD_MLD.zip** → Contient les modèles MERISE (MCD + MLD).
* **Présentation Gestion d’une médiathèque.pdf** → Diaporama du projet.
* **Rapport_Projet_BDD_ELABJANI_ZIDANI_HIBAOUI.pdf** → Rapport complet du projet.
* **README.md** → Ce fichier de documentation.

---

## 🧩 Modélisation — Méthode MERISE

### MCD (Modèle Conceptuel de Données)

Entités principales :

* Utilisateur (étudiant, professeur, organisme)
* Ressource (livre, DVD, magazine, carte, bande dessinée)
* Exemplaire
* Emprunt / Retour
* Réservation
* Thème
* Avis
* Pénalité
* Étagère

Relations :

* Un utilisateur peut effectuer plusieurs emprunts et réservations.
* Une ressource peut avoir plusieurs exemplaires.
* Les notifications et pénalités sont générées automatiquement selon les actions.

### MLD (Modèle Logique de Données)

Le modèle relationnel a été implémenté sous **PostgreSQL** avec :

* Des clés primaires et étrangères.
* Des contraintes d’intégrité référentielle.
* Des vues SQL pour la gestion et le suivi.
* Des triggers pour automatiser les notifications et pénalités.

---

## ⚙️ Fonctionnalités principales

* Gestion des utilisateurs avec rôles et droits spécifiques.
* Gestion complète des ressources et exemplaires.
* Suivi des emprunts, retours et réservations.
* Calcul automatique des pénalités selon le type de ressource.
* Notifications automatiques pour rappels et disponibilités.
* Optimisation de la rotation des ressources en période de forte demande.
* Historique des avis et évaluations pour chaque ressource.

---

## 🧪 Exemples de requêtes SQL

**1. Lister les ressources les plus empruntées :**
Permet d’identifier les ouvrages populaires dans la médiathèque.

**2. Identifier les emprunts en retard :**
Affiche la liste des utilisateurs concernés, les dates de retour et les montants des pénalités.

**3. Suivre les réservations en attente :**
Permet de gérer la file d’attente et d’envoyer les notifications dès qu’un exemplaire est disponible.

---

## 📊 Réponse technique à la problématique

| Étape | Action                           | Objectif                                                |
| ----- | -------------------------------- | ------------------------------------------------------- |
| 1️⃣   | Détection des périodes critiques | Identifier les pics d’activité et anticiper la demande. |
| 2️⃣   | Réduction des limites d’emprunt  | Répartir équitablement les ressources.                  |
| 3️⃣   | Réduction des durées d’emprunt   | Augmenter la rotation des exemplaires.                  |
| 4️⃣   | Augmentation des pénalités       | Encourager les retours rapides.                         |

---

## 💡 Perspectives d’amélioration

* Intégration d’un module d’**analyse prédictive** pour anticiper la demande.
* Automatisation complète via des **triggers SQL**.
* Développement d’une **interface web** (Flask, Django ou PHP) pour la gestion visuelle.
* Intégration d’un **tableau de bord BI** pour visualiser les statistiques d’utilisation.

---

## 👩‍💻 Équipe du projet

* **Nissrine ELABJANI** — Modélisation, requêtes SQL et validation des contraintes.
* **Rababe ZIDANI** — Rapport, documentation et présentation du projet.
* **Imane HIBAOUI** — Vérification, tests et cohérence du modèle.

---

## 🏁 Conclusion

Ce projet met en œuvre une solution complète et réaliste de **gestion de médiathèque**, reposant sur une modélisation MERISE rigoureuse et une implémentation SQL performante.
Il répond aux besoins d’organisation, de fiabilité et d’automatisation d’une médiathèque moderne.

Les perspectives d’évolution incluent l’ajout d’outils prédictifs, la numérisation intégrale du système et une interface web interactive pour la gestion en temps réel.

---

## ⭐️ *Projet réalisé dans le cadre du module “Bases de Données” — 2A SIE, Université Paris Cité (EIDD).*

