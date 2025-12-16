#!/bin/bash
# PRODUCTION FIX SCRIPT - Run this on your production server
# This will fix the amazon-form route issue

echo "=========================================="
echo "FIXING AMAZON FORM ROUTE ON PRODUCTION"
echo "=========================================="
echo ""

# Step 1: Verify route file has POST route
echo "Step 1: Checking route file..."
if grep -q "Route::post('/amazon-form" routes/api.php; then
    echo "✓ POST route found in routes/api.php"
else
    echo "❌ ERROR: POST route NOT found in routes/api.php"
    echo "Please upload the updated routes/api.php file"
    exit 1
fi

# Step 2: Verify controller exists
echo ""
echo "Step 2: Checking controller file..."
if [ -f "app/Http/Controllers/Api/AmazonFormController.php" ]; then
    echo "✓ Controller file exists"
else
    echo "❌ ERROR: Controller file missing"
    echo "Please upload app/Http/Controllers/Api/AmazonFormController.php"
    exit 1
fi

# Step 3: Clear ALL caches
echo ""
echo "Step 3: Clearing all caches..."
php artisan optimize:clear
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear
echo "✓ All caches cleared"

# Step 4: Verify route registration
echo ""
echo "Step 4: Verifying route registration..."
ROUTE_CHECK=$(php artisan route:list | grep "amazon-form" | grep "POST")
if [ -z "$ROUTE_CHECK" ]; then
    echo "❌ ERROR: POST route not registered"
    echo "Current routes:"
    php artisan route:list | grep amazon-form
    exit 1
else
    echo "✓ POST route is registered:"
    echo "$ROUTE_CHECK"
fi

# Step 5: Regenerate caches
echo ""
echo "Step 5: Regenerating caches..."
php artisan route:cache
php artisan config:cache
echo "✓ Caches regenerated"

# Step 6: Final verification
echo ""
echo "Step 6: Final route verification..."
php artisan route:list | grep amazon-form
echo ""

echo "=========================================="
echo "FIX COMPLETE!"
echo "=========================================="
echo ""
echo "Test the endpoint:"
echo "curl -X POST https://admin.purplegridmarketing.com/api/amazon-form \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"niche\":\"test\"}'"
echo ""

