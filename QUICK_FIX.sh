#!/bin/bash
# Quick fix - run this on production server

cd /home/u727587393/domains/purplegridmarketing.com/admin

# Delete route cache
rm -f bootstrap/cache/routes-v7.php bootstrap/cache/routes.php bootstrap/cache/routes-*.php

# Clear all caches
php artisan optimize:clear
php artisan route:clear

# Verify route
php artisan route:list | grep amazon-form

# Regenerate cache
php artisan route:cache

echo "Done! Test the form now."

