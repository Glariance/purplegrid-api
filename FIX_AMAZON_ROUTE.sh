#!/bin/bash
# Fix Amazon Form Route on Production
# Run this script on your production server

echo "Clearing all Laravel caches..."
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear

echo ""
echo "Checking if route is registered..."
php artisan route:list | grep amazon-form

echo ""
echo "If route shows POST method, regenerate cache:"
echo "php artisan route:cache"
echo "php artisan config:cache"

echo ""
echo "Verifying route file has POST route:"
grep -n "amazon-form" routes/api.php

echo ""
echo "Done! Test the endpoint now."

