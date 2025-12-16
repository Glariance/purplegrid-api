#!/bin/bash

# Comprehensive fix for Amazon Form Route 405 Error
# Run this script on your production server

echo "=========================================="
echo "Fixing Amazon Form Route - Production Fix"
echo "=========================================="

# Navigate to Laravel root
cd /home/u727587393/domains/purplegridmarketing.com/admin || exit 1

echo ""
echo "Step 1: Verifying routes/api.php has POST route..."
if grep -q "Route::post('/amazon-form'" routes/api.php; then
    echo "✅ POST route found in routes/api.php"
else
    echo "❌ ERROR: POST route NOT found in routes/api.php"
    echo "Please upload the updated routes/api.php file!"
    exit 1
fi

echo ""
echo "Step 2: Verifying routes/api.php has OPTIONS route..."
if grep -q "Route::options('/amazon-form'" routes/api.php; then
    echo "✅ OPTIONS route found in routes/api.php"
else
    echo "❌ ERROR: OPTIONS route NOT found in routes/api.php"
    echo "Please upload the updated routes/api.php file!"
    exit 1
fi

echo ""
echo "Step 3: Deleting route cache files..."
rm -f bootstrap/cache/routes-v7.php
rm -f bootstrap/cache/routes.php
rm -f bootstrap/cache/config.php
rm -f bootstrap/cache/services.php
echo "✅ Route cache files deleted"

echo ""
echo "Step 4: Clearing all Laravel caches..."
php artisan optimize:clear
php artisan config:clear
php artisan route:clear
php artisan cache:clear
php artisan view:clear
echo "✅ All caches cleared"

echo ""
echo "Step 5: Verifying route registration..."
php artisan route:list | grep -i amazon-form
if [ $? -eq 0 ]; then
    echo "✅ Route is registered"
else
    echo "❌ ERROR: Route not found in route list"
    exit 1
fi

echo ""
echo "Step 6: Regenerating route cache..."
php artisan route:cache
php artisan config:cache
echo "✅ Route cache regenerated"

echo ""
echo "Step 7: Final verification..."
php artisan route:list | grep -i amazon-form
echo ""
echo "=========================================="
echo "Fix complete! Please test the form now."
echo "=========================================="

