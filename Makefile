up:
	docker compose up -d

copy-env:
	cp .env.example .env

app-grant-write-permission:
	docker compose run --rm laravel chmod -R 777 ./

app-composer-install:
	docker compose run --rm laravel composer install
	docker compose run --rm laravel composer run-script post-root-package-install
	docker compose run --rm laravel composer run-script post-create-project-cmd

app-migrations:
	docker compose run --rm laravel php artisan migrate --force

app-storage-link:
	docker compose run --rm laravel php artisan storage:link

stop:
	docker compose stop

bash:
	docker compose run --rm --user root laravel bash

init: up app-grant-write-permission app-composer-install app-migrations app-storage-link
