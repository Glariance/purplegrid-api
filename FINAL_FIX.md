# FINAL FIX for Amazon Form Route Issue

## The Problem
Error: "The POST method is not supported for route api/amazon-form. Supported methods: OPTIONS."

This means Laravel's route cache on production is stale and only has OPTIONS registered for this route.

## The Solution

### Step 1: Upload Updated Files to Production
Make sure these files are on production:
- ✅ `routes/api.php` (line 28 must have: `Route::post('/amazon-form', ...)`)
- ✅ `app/Http/Controllers/Api/AmazonFormController.php`

### Step 2: SSH into Production and Run These Commands

```bash
cd /home/u727587393/domains/purplegridmarketing.com/admin

# CRITICAL: Clear route cache FIRST
php artisan route:clear

# Clear all other caches
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan optimize:clear

# Verify the route file has the POST route
grep -n "amazon-form" routes/api.php
# Should show line 28 with: Route::post('/amazon-form', ...

# Check if route is now registered
php artisan route:list | grep amazon-form
# Should show: POST       api/amazon-form

# If route shows correctly, regenerate cache
php artisan route:cache
php artisan config:cache
```

### Step 3: Verify Route File Content
On production, check `routes/api.php` line 28:
```bash
sed -n '28p' routes/api.php
```

**Must show:**
```php
Route::post('/amazon-form', [AmazonFormController::class, 'store'])->name('amazon-form.store');
```

### Step 4: Test
```bash
curl -X POST https://admin.purplegridmarketing.com/api/amazon-form \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"niche":"test"}'
```

## Why This Happens
Laravel caches routes for performance. When you add a new route, the cache needs to be cleared. The error "Supported methods: OPTIONS" means the cached route only has OPTIONS, not POST.

## If Still Not Working
1. Check Laravel logs: `tail -f storage/logs/laravel.log`
2. Verify controller exists: `ls -la app/Http/Controllers/Api/AmazonFormController.php`
3. Check route registration: `php artisan route:list --path=amazon-form`
4. Restart PHP-FPM or web server if needed

