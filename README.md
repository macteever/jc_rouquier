# Projet PrestaShop 9 Dockerisé (B2B)

## 1) Présentation du projet
Ce dépôt fournit un environnement **local** complet pour un projet **PrestaShop 9 B2B** avec Docker.  
Le cœur PrestaShop est exécuté dans des conteneurs (non versionné dans Git), et le développement métier se fait via des modules custom, notamment **`b2block`**.

## 2) Stack technique
- **PrestaShop 9**
- **MySQL 8**
- **Docker / Docker Compose**
- **Mailpit** (SMTP local + interface web)
- **Module custom** : `b2block`

## 3) Installation (pas à pas)

### Prérequis
- Docker
- Docker Compose

### Étapes
1. **Cloner le repository**
   ```bash
   git clone <url-du-repo>
   cd <nom-du-repo>
   ```

2. **Créer le fichier d’environnement**
   ```bash
   cp .env.example .env
   ```
   Puis renseigner les variables sensibles dans `.env` :
   - MySQL (`MYSQL_*`)
   - PrestaShop (`DB_*`, `PS_*`)
   - Admin (`ADMIN_MAIL`, `ADMIN_PASSWD`)
   - Mailpit (`MAILPIT_SMTP_PORT`, `MAILPIT_UI_PORT`)

3. **Démarrer les services**
   ```bash
   docker compose up -d
   ```

4. **Accès application**
   - Front-office : `http://localhost:8080`
   - Back-office : URL admin générée par PrestaShop (après installation auto)
   - Mailpit : `http://localhost:8025`

## 4) Configuration email (Mailpit)
Mailpit permet de capturer tous les emails sortants en local (inscription, reset mot de passe, notifications, etc.).

- SMTP local :
  - Hôte : `mailpit`
  - Port : `1025` (ou `${MAILPIT_SMTP_PORT}` côté hôte)
- Interface de lecture des mails :
  - `http://localhost:8025` (ou `${MAILPIT_UI_PORT}`)

## 5) Module `b2block` (aperçu)
Le module `b2block` couvre le workflow B2B, notamment :
- restriction d’accès visiteurs non connectés,
- page d’accès professionnelle,
- parcours d’inscription pro,
- gestion de comptes en attente de validation,
- notifications email associées au workflow B2B.

Le module est monté en bind mount :
- local : `./modules/b2block`
- conteneur : `/var/www/html/modules/b2block`

## 6) Commandes Docker utiles
```bash
# Démarrer
docker compose up -d

# Arrêter
docker compose down

# Voir les logs
docker compose logs -f
docker compose logs -f prestashop
docker compose logs -f db
docker compose logs -f mailpit

# Ouvrir un shell dans PrestaShop
docker compose exec prestashop bash

# Redémarrer un service
docker compose restart prestashop
```

## 7) Structure du projet
```text
.
├── compose.yml
├── .env.example
├── .gitignore
├── modules/
│   └── b2block/
│       ├── b2block.php
│       ├── controllers/
│       ├── views/
│       ├── mails/
│       └── ...
└── README.md
```

## 8) Bonnes pratiques
- **Ne jamais commit `.env`** (secrets locaux).
- Utiliser **`.env.example`** comme modèle partagé.
- La base de données et les fichiers runtime PrestaShop sont en volumes Docker :
  - non versionnés dans Git.
- Versionner uniquement le code projet :
  - `compose.yml`
  - modules custom (`modules/b2block`, etc.)
  - documentation et scripts utilitaires.

## 9) Développement
- Modifier le module custom directement dans `./modules/b2block` (hot-reload via bind mount).
- Vérifier les emails fonctionnels dans Mailpit.
- En cas de changement de variables d’environnement :
  ```bash
  docker compose down
  docker compose up -d
  ```
- Avant commit :
  - vérifier que `.env` n’est pas suivi,
  - relire les logs applicatifs (`docker compose logs -f prestashop`),
  - tester les parcours B2B clés (accès, inscription, activation, emails).
