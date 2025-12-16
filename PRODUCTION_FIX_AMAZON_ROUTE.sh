#!/bin/bash

# ==========================================
# PRODUCTION FIX FOR AMAZON FORM ROUTE
# ==========================================
# This script MUST be run on your production server
# SSH into: u727587393@purplegridmarketing.com
# Then navigate to: /home/u727587393/domains/purplegridmarketing.com/admin

echo "=========================================="
echo "PRODUCTION FIX: Amazon Form Route"
echo "=========================================="
echo ""

# Step 1: Navigate to Laravel root
cd /home/u727587393/domains/purplegridmarketing.com/admin || {
    echo "❌ ERROR: Cannot navigate to Laravel directory"
    echo "Current directory: $(pwd)"
    exit 1
}

echo "✅ Current directory: $(pwd)"
echo ""

# Step 2: Verify routes/api.php has the POST route
echo "Step 1: Verifying routes/api.php..."
if [ ! -f "routes/api.php" ]; then
    echo "❌ ERROR: routes/api.php file not found!"
    exit 1
fi

if grep -q "Route::post('/amazon-form'" routes/api.php; then
    echo "✅ POST route found in routes/api.php (line 26)"
    grep -n "amazon-form" routes/api.php
else
    echo "❌ ERROR: POST route NOT found in routes/api.php"
    echo ""
    echo "Please check that line 26 contains:"
    echo "Route::post('/amazon-form', [AmazonFormController::class, 'store']);"
    echo ""
    echo "Current content around line 26:"
    sed -n '24,28p' routes/api.php
    exit 1
fi
echo ""

# Step 3: Delete ALL route cache files
echo "Step 2: Deleting route cache files..."
rm -f bootstrap/cache/routes-v7.php
rm -f bootstrap/cache/routes.php
rm -f bootstrap/cache/routes-*.php
echo "✅ Route cache files deleted"
echo ""

# Step 4: Clear ALL Laravel caches
echo "Step 3: Clearing all Laravel caches..."
php artisan optimize:clear 2>&1
php artisan config:clear 2>&1
php artisan route:clear 2>&1
php artisan cache:clear 2>&1
php artisan view:clear 2>&1
echo "✅ All caches cleared"
echo ""

# Step 5: Verify route is registered (BEFORE caching)
echo "Step 4: Verifying route registration (uncached)..."
ROUTE_CHECK=$(php artisan route:list --path=amazon-form 2>&1)
if echo "$ROUTE_CHECK" | grep -q "POST.*amazon-form"; then
    echo "✅ Route is registered correctly"
    echo "$ROUTE_CHECK"
else
    echo "❌ ERROR: Route not found in route list"
    echo "Output:"
    echo "$ROUTE_CHECK"
    echo ""
    echo "Trying full route list..."
    php artisan route:list | grep -i amazon
    exit 1
fi
echo ""

# Step 6: Regenerate route cache
echo "Step 5: Regenerating route cache..."
php artisan route:cache 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Route cache regenerated"
else
    echo "⚠️  WARNING: Route cache regeneration had issues"
    echo "This might be okay if you're not using route caching"
fi
echo ""

# Step 7: Final verification
echo "Step 6: Final verification..."
FINAL_CHECK=$(php artisan route:list --path=amazon-form 2>&1)
if echo "$FINAL_CHECK" | grep -q "POST.*amazon-form"; then
    echo "✅ SUCCESS: Route is properly registered and cached"
    echo "$FINAL_CHECK"
else
    echo "⚠️  WARNING: Route not found after caching"
    echo "Output:"
    echo "$FINAL_CHECK"
    echo ""
    echo "Try clearing cache again:"
    echo "  php artisan route:clear"
    echo "  php artisan route:cache"
fi
echo ""

# Step 8: Check if controller exists
echo "Step 7: Verifying controller exists..."
if [ -f "app/Http/Controllers/Api/AmazonFormController.php" ]; then
    echo "✅ Controller file exists"
else
    echo "❌ ERROR: Controller file not found!"
    echo "Expected: app/Http/Controllers/Api/AmazonFormController.php"
    exit 1
fi
echo ""

# Step 9: Check if model exists
echo "Step 8: Verifying model exists..."
if [ -f "app/Models/AmazonFormSubmission.php" ]; then
    echo "✅ Model file exists"
else
    echo "❌ ERROR: Model file not found!"
    echo "Expected: app/Models/AmazonFormSubmission.php"
    exit 1
fi
echo ""

echo "=========================================="
echo "FIX COMPLETE!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Test the form submission from your frontend"
echo "2. Check Laravel logs: tail -f storage/logs/laravel.log"
echo "3. If still having issues, check web server error logs"
echo ""

