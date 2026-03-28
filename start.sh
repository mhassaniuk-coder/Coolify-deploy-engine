#!/bin/sh
set -e

# Generate app key if not set
if [ -z "$APP_KEY" ]; then
    php artisan key:generate --force
fi

# Cache config
php artisan config:cache || true
php artisan route:cache || true
php artisan view:cache || true

# Run migrations if DB is available
php artisan migrate --force --no-interaction || true

# Start the server
php artisan serve --host=0.0.0.0 --port=${PORT:-8080}
