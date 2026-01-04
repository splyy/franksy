.PHONY: help build up down restart logs ps composer certs phpstan phpstan-baseline cs-fix cs-check tw-build tw-watch

help: ## Affiche cette aide
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

##
## Docker
##

build: ## Construit les images Docker
	docker compose build

up: ## Démarre les conteneurs
	docker compose up -d

down: ## Arrête et supprime les conteneurs
	docker compose down

restart: down up ## Redémarre les conteneurs

logs: ## Affiche les logs des conteneurs
	docker compose logs -f

ps: ## Affiche l'état des conteneurs
	docker compose ps

##
## Dépendances
##

composer: ## Installe les dépendances Composer
	docker compose exec app composer install

##
## Certificats HTTPS
##

certs: ## Génère les certificats mkcert pour HTTPS local
	@if ! command -v mkcert >/dev/null 2>&1; then \
		echo "❌ mkcert n'est pas installé. Installez-le avec: brew install mkcert"; \
		exit 1; \
	fi
	@mkcert -install
	@cd certs && mkcert localhost 127.0.0.1 ::1
	@echo "✅ Certificats générés dans certs/"
	@echo "⚠️  Redémarrez les conteneurs avec: make restart"

##
## Frontend
##

tw-build: ## Compile Tailwind CSS pour production
	./tailwindcss -i assets/styles/app.css -o public/build/app.css --minify

tw-watch: ## Compile Tailwind CSS en mode watch
	./tailwindcss -i assets/styles/app.css -o public/build/app.css --watch

##
## Qualité de code
##

phpstan: ## Analyse statique avec PHPStan
	docker compose exec app vendor/bin/phpstan analyse

phpstan-baseline: ## Génère la baseline PHPStan
	docker compose exec app vendor/bin/phpstan analyse --generate-baseline

cs-fix: ## Corrige le style de code avec PHP-CS-Fixer
	docker compose exec app vendor/bin/php-cs-fixer fix

cs-check: ## Vérifie le style de code avec PHP-CS-Fixer
	docker compose exec app vendor/bin/php-cs-fixer fix --dry-run --diff
