#!/bin/bash
# PRODUCTION FIX - Run this on your production server
# This will definitively fix the amazon-form route issue

cd /home/u727587393/domains/purplegridmarketing.com/admin || exit 1

echo "=========================================="
echo "FIXING AMAZON FORM ROUTE"
echo "=========================================="
echo ""

# Step 1: Delete route cache file directly
echo "Step 1: Deleting route cache files..."
rm -f bootstrap/cache/routes-v7.php
rm -f bootstrap/cache/routes.php
echo "✓ Route cache files deleted"

# Step 2: Clear all artisan caches
echo ""
echo "Step 2: Clearing all Laravel caches..."
php artisan route:clear 2>/dev/null || true
php artisan config:clear 2>/dev/null || true
php artisan cache:clear 2>/dev/null || true
php artisan view:clear 2>/dev/null || true
php artisan optimize:clear 2>/dev/null || true
echo "✓ All caches cleared"

# Step 3: Verify route file content
echo ""
echo "Step 3: Verifying route file..."
if grep -q "Route::post('/amazon-form" routes/api.php; then
    echo "✓ POST route found in routes/api.php"
    echo "   Line content:"
    grep -n "Route::post('/amazon-form" routes/api.php
else
    echo "❌ ERROR: POST route NOT found in routes/api.php"
    echo "   Please upload the updated routes/api.php file"
    exit 1
fi

# Step 4: Verify controller exists
echo ""
echo "Step 4: Verifying controller..."
if [ -f "app/Http/Controllers/Api/AmazonFormController.php" ]; then
    echo "✓ Controller file exists"
else
    echo "❌ ERROR: Controller file missing"
    echo "   Please upload app/Http/Controllers/Api/AmazonFormController.php"
    exit 1
fi

# Step 5: Check current route registration
echo ""
echo "Step 5: Checking route registration..."
php artisan route:list 2>/dev/null | grep amazon-form || echo "   No routes found (cache cleared, this is normal)"

# Step 6: Regenerate route cache
echo ""
echo "Step 6: Regenerating route cache..."
php artisan route:cache
php artisan config:cache
echo "✓ Caches regenerated"

# Step 7: Final verification
echo ""
echo "Step 7: Final route verification..."
ROUTE_OUTPUT=$(php artisan route:list 2>/dev/null | grep amazon-form)
if [ -z "$ROUTE_OUTPUT" ]; then
    echo "❌ ERROR: Route still not registered after cache regeneration"
    echo "   This means the route file on production is different"
    echo "   Please verify routes/api.php line 28 has:"
    echo "   Route::post('/amazon-form', [AmazonFormController::class, 'store']);"
    exit 1
else
    echo "✓ Route is now registered:"
    echo "$ROUTE_OUTPUT"
fi

echo ""
echo "=========================================="
echo "FIX COMPLETE!"
echo "=========================================="
echo ""
echo "The route should now work. Test it:"
echo "curl -X POST https://admin.purplegridmarketing.com/api/amazon-form \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"niche\":\"test\"}'"
echo ""

