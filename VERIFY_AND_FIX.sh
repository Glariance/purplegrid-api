#!/bin/bash
# Run this on production server to fix the amazon-form route issue

echo "=========================================="
echo "Fixing Amazon Form Route on Production"
echo "=========================================="
echo ""

echo "Step 1: Checking current route registration..."
php artisan route:list | grep amazon-form
echo ""

echo "Step 2: Clearing all caches..."
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear
echo "✓ Caches cleared"
echo ""

echo "Step 3: Verifying route file has correct routes..."
echo "Checking for POST route:"
grep -n "Route::post('/amazon-form" routes/api.php || echo "❌ POST route not found!"
echo ""
echo "Checking for OPTIONS route:"
grep -n "Route::options('/amazon-form" routes/api.php || echo "❌ OPTIONS route not found!"
echo ""

echo "Step 4: Verifying controller exists..."
if [ -f "app/Http/Controllers/Api/AmazonFormController.php" ]; then
    echo "✓ Controller exists"
else
    echo "❌ Controller file missing!"
fi
echo ""

echo "Step 5: Re-registering routes..."
php artisan route:list | grep amazon-form
echo ""

echo "Step 6: Regenerating route cache..."
php artisan route:cache
php artisan config:cache
echo "✓ Caches regenerated"
echo ""

echo "Step 7: Final verification..."
php artisan route:list | grep amazon-form
echo ""

echo "=========================================="
echo "Done! The route should now work."
echo "=========================================="
echo ""
echo "Expected output should show:"
echo "  POST       api/amazon-form"
echo "  OPTIONS    api/amazon-form"

