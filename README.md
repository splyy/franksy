# 🚀 Symfony 8.0 + FrankenPHP Template

Template moderne et optimisé pour démarrer rapidement vos projets Symfony avec FrankenPHP, Docker et des outils de qualité de code.

![Symfony](https://img.shields.io/badge/Symfony-8.0-000000?style=flat-square&logo=symfony)
![PHP](https://img.shields.io/badge/PHP-8.5-777BB4?style=flat-square&logo=php)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791?style=flat-square&logo=postgresql)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker)

## ✨ Fonctionnalités

- ⚡ **FrankenPHP** en mode worker pour des performances maximales
- 🐘 **PHP 8.5** avec extensions optimisées (OPcache, APCu)
- 🎯 **Symfony 8.0** avec la stack complète
- 🐳 **Docker Compose** prêt pour le développement
- 🔒 **HTTPS local** avec certificats mkcert de confiance
- 📊 **Outils qualité** : PHPStan niveau 6, PHP-CS-Fixer
- 🗄️ **PostgreSQL 15** Alpine
- 📦 **Caddy 2** avec compression automatique

## 📋 Prérequis

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [mkcert](https://github.com/FiloSottile/mkcert) pour HTTPS local
  ```bash
  # macOS
  brew install mkcert

  # Linux
  apt install mkcert  # ou yum install mkcert
  ```

## 🚀 Installation

### 1. Cloner le projet

```bash
git clone <votre-repo>
cd frankphp
```

### 2. Configurer les variables d'environnement

```bash
cp .env .env.local
# Éditez .env.local et personnalisez vos valeurs (APP_SECRET, DATABASE_PASSWORD, etc.)
```

### 3. Générer les certificats HTTPS

```bash
make certs
```

### 4. Démarrer le projet

```bash
make build
make up
```

Le site est maintenant accessible sur :
- **HTTPS** : https://localhost (recommandé)
- **HTTP** : http://localhost (redirige vers HTTPS)

## 🛠️ Commandes Makefile

### Gestion Docker

```bash
make build      # Construit les images Docker
make up         # Démarre les conteneurs
make down       # Arrête et supprime les conteneurs
make restart    # Redémarre les conteneurs (down + up)
make logs       # Affiche les logs en temps réel
make ps         # Affiche l'état des conteneurs
```

### Dépendances

```bash
make composer   # Installe les dépendances PHP
```

### Certificats HTTPS

```bash
make certs      # Génère les certificats mkcert
```

### Qualité de code

```bash
make phpstan          # Analyse statique avec PHPStan
make phpstan-baseline # Génère la baseline PHPStan
make cs-fix           # Corrige le style de code
make cs-check         # Vérifie le style (sans modifier)
```

### Aide

```bash
make help       # Liste toutes les commandes disponibles
```

## 📦 Stack Technique

| Composant | Version | Description |
|-----------|---------|-------------|
| **Symfony** | 8.0 | Framework PHP moderne |
| **PHP** | 8.5 | Dernière version de PHP |
| **FrankenPHP** | 1.x | Serveur d'application PHP moderne |
| **PostgreSQL** | 15 Alpine | Base de données relationnelle |
| **Caddy** | 2.x | Serveur web avec HTTPS automatique |
| **PHPStan** | 2.0 | Analyse statique niveau 6 |
| **PHP-CS-Fixer** | 3.64 | Formatage de code |

## 🏗️ Structure du Projet

```
.
├── config/              # Configuration Symfony
├── public/              # Point d'entrée web
├── src/
│   ├── Controller/      # Contrôleurs
│   ├── Entity/          # Entités Doctrine
│   └── Repository/      # Repositories
├── templates/           # Templates Twig
├── certs/              # Certificats HTTPS (non versionné)
├── Caddyfile           # Configuration Caddy
├── Dockerfile          # Image FrankenPHP
├── compose.yaml        # Docker Compose
├── Makefile            # Commandes utiles
├── phpstan.neon        # Configuration PHPStan
└── .php-cs-fixer.dist.php  # Configuration PHP-CS-Fixer
```

## 🔧 Configuration

### Variables d'environnement

Les variables sensibles sont dans `.env.local` (non versionné). Les valeurs par défaut sont dans `.env`.

Principales variables :
- `APP_SECRET` : Secret Symfony (générez avec `openssl rand -hex 32`)
- `DATABASE_URL` : URL de connexion PostgreSQL
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` : Credentials PostgreSQL

### PHP-CS-Fixer

Le projet utilise les règles `@Symfony` et `@PSR12`. Personnalisez dans `.php-cs-fixer.dist.php`.

### PHPStan

Analyse de niveau 6 avec les extensions Symfony et Doctrine. Configuration dans `phpstan.neon`.

## 🚦 Workflow de Développement

1. **Démarrage**
   ```bash
   make up
   ```

2. **Développement**
   - Modifiez votre code (hot-reload automatique)
   - Consultez les logs : `make logs`

3. **Qualité de code**
   ```bash
   make phpstan    # Vérifier les erreurs
   make cs-fix     # Formater le code
   ```

4. **Arrêt**
   ```bash
   make down
   ```

## 📝 Notes

### HTTPS en développement

Les certificats mkcert sont générés localement et reconnus par votre navigateur. Pour régénérer :

```bash
make certs
make restart
```

### Mode Worker FrankenPHP

Le mode worker garde l'application Symfony en mémoire entre les requêtes pour des performances optimales. Les fichiers sont rechargés automatiquement en mode `dev`.

### Hot Reload

Le projet est configuré pour recharger automatiquement :
- Les fichiers PHP (via le mode dev de FrankenPHP)
- Le Caddyfile (monté comme volume)
- Les templates Twig

## 🐛 Dépannage

### Les conteneurs ne démarrent pas

```bash
make down
docker system prune -a  # Attention : supprime toutes les images inutilisées
make build
make up
```

### Erreur de certificat HTTPS

```bash
make certs
make restart
```

### Problème de permissions

```bash
sudo chown -R $USER:$USER .
```

## 📄 Licence

Ce projet est sous licence MIT.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une issue ou une pull request.

---

**Développé avec ❤️ pour la communauté Symfony**
