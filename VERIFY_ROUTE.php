<?php
/**
 * Route Verification Script
 * Run this on production: php VERIFY_ROUTE.php
 */

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

echo "========================================\n";
echo "ROUTE VERIFICATION FOR AMAZON-FORM\n";
echo "========================================\n\n";

// Check route file
echo "1. Checking routes/api.php file:\n";
$routeFile = __DIR__.'/routes/api.php';
if (file_exists($routeFile)) {
    $content = file_get_contents($routeFile);
    if (strpos($content, "Route::post('/amazon-form") !== false) {
        echo "   ✓ POST route found in routes/api.php\n";
        preg_match("/Route::post\('\/amazon-form.*?\);/s", $content, $matches);
        if (!empty($matches)) {
            echo "   Route definition: " . trim($matches[0]) . "\n";
        }
    } else {
        echo "   ❌ POST route NOT found in routes/api.php\n";
    }
} else {
    echo "   ❌ routes/api.php file not found!\n";
}

// Check controller
echo "\n2. Checking controller file:\n";
$controllerFile = __DIR__.'/app/Http/Controllers/Api/AmazonFormController.php';
if (file_exists($controllerFile)) {
    echo "   ✓ Controller file exists\n";
} else {
    echo "   ❌ Controller file missing!\n";
}

// Check registered routes
echo "\n3. Checking registered routes:\n";
try {
    $routes = \Illuminate\Support\Facades\Route::getRoutes();
    $amazonRoutes = [];
    foreach ($routes as $route) {
        if (strpos($route->uri(), 'amazon-form') !== false) {
            $amazonRoutes[] = [
                'methods' => $route->methods(),
                'uri' => $route->uri(),
                'name' => $route->getName(),
                'action' => $route->getActionName(),
            ];
        }
    }
    
    if (empty($amazonRoutes)) {
        echo "   ❌ No amazon-form routes found in route collection!\n";
    } else {
        foreach ($amazonRoutes as $route) {
            echo "   Route found:\n";
            echo "     Methods: " . implode(', ', $route['methods']) . "\n";
            echo "     URI: " . $route['uri'] . "\n";
            echo "     Name: " . ($route['name'] ?? 'none') . "\n";
            echo "     Action: " . $route['action'] . "\n";
            echo "\n";
        }
    }
} catch (\Exception $e) {
    echo "   ❌ Error checking routes: " . $e->getMessage() . "\n";
}

// Check route cache
echo "\n4. Checking route cache:\n";
$cacheFile = __DIR__.'/bootstrap/cache/routes-v7.php';
if (file_exists($cacheFile)) {
    echo "   ⚠ Route cache file exists (this might be stale)\n";
    echo "   Run: php artisan route:clear\n";
} else {
    echo "   ✓ No route cache file (good)\n";
}

echo "\n========================================\n";
echo "VERIFICATION COMPLETE\n";
echo "========================================\n";

