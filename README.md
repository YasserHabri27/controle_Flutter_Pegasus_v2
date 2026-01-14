# 🦅 Pegasus App

> **Smart Workflow & Productivity Manager**

---

## 🎓 Contexte Académique

Ce projet a été réalisé dans le cadre du module **WebSphere (Flutter)** pour le contrôle continu.

| Information | Détail |
| :--- | :--- |
| **École** | **EMSI** (École Marocaine des Sciences de l'Ingénieur), Rabat |
| **Filière** | Ingénierie Informatique et Réseaux |
| **Option** | MIAGE (Méthodes Informatiques Appliquées à la Gestion des Entreprises) |
| **Niveau** | 5ème Année |
| **Année Universitaire** | 2025 - 2026 |
| **Date de présentation** | 03 Janvier 2026 |

### 👥 Équipe de Réalisation (Binôme)
*   **Yasser Habri**
*   **Doha Allali**

### 👨‍🏫 Encadrement
*   **Encadré et supervisé par :** Monsieur **Abdoul Hamidou Soumana**

---

## 📱 Description du Projet

**Pegasus** est une application mobile de gestion de productivité et de projets conçue pour optimiser l'organisation personnelle et professionnelle. Elle adopte une approche minimaliste et moderne ("Contemporary Productive Minimalism") pour offrir une expérience utilisateur fluide et efficace.

L'application permet aux utilisateurs de gérer leurs projets de bout en bout, de l'idéation à la complétion, en passant par la gestion détaillée des tâches associées et le suivi de l'avancement en temps réel.

## ✨ Fonctionnalités Clés

*   **Gestion de Projets (Projects)** : Création, modification, archivage et suppression de projets avec suivi de dates et de progression.
*   **Gestion de Tâches (Tasks)** : Ajout de tâches liées aux projets, marquage comme terminées, et organisation par priorité.
*   **Tableau de Bord (Dashboard)** : Vue d'ensemble des statistiques, des projets actifs et des tâches urgentes.
*   **Administration** : Un panneau d'administration local pour surveiller l'état du système (Hive, Synchro) et voir les métriques globales.
*   **Mode Hors-ligne (Offline-First)** : Toutes les données sont persistées localement grâce à **Hive**, assurant une disponibilité totale même sans internet.
*   **Authentification** : Système de connexion et d'inscription sécurisé via Firebase Auth.

## 🛠 Architecture & Choix Techniques

Le projet respecte scrupuleusement les standards de l'industrie et une architecture **"Feature-First"** (séparation par fonctionnalité) pour garantir la maintenabilité et la scalabilité.

### Structure du Code
```
lib/
├── core/            # Composants partagés (Widgets, Thèmes, Utils, Routes)
├── features/        # Modules fonctionnels
│   ├── auth/        # Authentification
│   ├── projects/    # Gestion des Projets (Anciennement Workflows)
│   ├── tasks/       # Gestion des Tâches
│   ├── dashboard/   # Tableau de bord utilisateur
│   ├── admin/       # Dashboard Admin
│   ├── profile/     # Gestion de profil
│   └── statistics/  # Statistiques globales
└── main.dart        # Point d'entrée
```

### Technologies Utilisées

*   **Framework** : [Flutter](https://flutter.dev/) (SDK >=3.2.0)
*   **State Management** : [Flutter Bloc](https://pub.dev/packages/flutter_bloc) (Pattern BLoC pour une séparation stricte UI/Logique)
*   **Base de Données Locale** : [Hive](https://pub.dev/packages/hive) (NoSQL performant pour le mode offline)
*   **Backend / Auth** : [Firebase Auth](https://firebase.google.com/)
*   **Injection de Dépendances** : [GetIt](https://pub.dev/packages/get_it) (Service Locator)
*   **Réseau** : [Dio](https://pub.dev/packages/dio) & [Retrofit](https://pub.dev/packages/retrofit) (Prêt pour l'intégration API REST)
*   **UI/UX** :
    *   `sizer` pour le responsive design.
    *   `google_fonts` pour la typographie (Outfit/Inter).
    *   `percent_indicator` et `fl_chart` pour la visualisation de données.

## 🚀 Installation et Lancement

1.  **Prérequis** : Assurez-vous d'avoir le SDK Flutter installé et configuré.
2.  **Cloner le projet** :
    ```bash
    git clone https://github.com/votre-repo/pegasus_app.git
    cd pegasus_app
    ```
3.  **Installer les dépendances** :
    ```bash
    flutter pub get
    ```
4.  **Génération de code** (nécessaire pour Hive, Retrofit, etc.) :
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
5.  **Lancer l'application** :
    ```bash
    flutter run
    ```

---
*Ce projet est une démonstration académique des capacités de Flutter à créer des applications complexes, architecturées et performantes.*
