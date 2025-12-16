# Production Fix Instructions for Amazon Form Route

## The Problem
The production server has a stale route cache that only recognizes OPTIONS method, not POST. This causes the 405 error.

## The Solution
You need to clear the route cache on production and ensure the route file is correct.

## Step-by-Step Instructions

### Option 1: Using SSH (Recommended)

1. **SSH into your production server:**
   ```bash
   ssh u727587393@purplegridmarketing.com
   ```

2. **Navigate to Laravel directory:**
   ```bash
   cd /home/u727587393/domains/purplegridmarketing.com/admin
   ```

3. **Upload the fix script:**
   - Upload `PRODUCTION_FIX_AMAZON_ROUTE.sh` to the admin directory
   - Or copy the commands manually

4. **Make script executable and run:**
   ```bash
   chmod +x PRODUCTION_FIX_AMAZON_ROUTE.sh
   ./PRODUCTION_FIX_AMAZON_ROUTE.sh
   ```

### Option 2: Manual Commands

If you prefer to run commands manually:

```bash
# 1. Navigate to Laravel root
cd /home/u727587393/domains/purplegridmarketing.com/admin

# 2. Verify route file has POST route (should show line 26)
grep -n "amazon-form" routes/api.php

# 3. Delete route cache files
rm -f bootstrap/cache/routes-v7.php
rm -f bootstrap/cache/routes.php
rm -f bootstrap/cache/routes-*.php

# 4. Clear all caches
php artisan optimize:clear
php artisan config:clear
php artisan route:clear
php artisan cache:clear
php artisan view:clear

# 5. Verify route is registered
php artisan route:list | grep amazon-form
# Should show: POST  api/amazon-form

# 6. Regenerate route cache
php artisan route:cache

# 7. Final verification
php artisan route:list | grep amazon-form
```

### Option 3: Via cPanel File Manager

1. **Navigate to:** `/home/u727587393/domains/purplegridmarketing.com/admin`

2. **Delete these cache files:**
   - `bootstrap/cache/routes-v7.php`
   - `bootstrap/cache/routes.php`
   - Any other `routes-*.php` files in `bootstrap/cache/`

3. **Use cPanel Terminal or SSH** to run:
   ```bash
   php artisan route:clear
   php artisan route:cache
   ```

## Critical: Verify Route File

**Before clearing cache, verify your `routes/api.php` file on production has this line (around line 26):**

```php
Route::post('/amazon-form', [AmazonFormController::class, 'store']);
```

**It should be EXACTLY like the contact route:**
```php
Route::post('/contact', [ContactController::class, 'store']);
Route::post('/amazon-form', [AmazonFormController::class, 'store']);
```

## If Route File is Wrong on Production

If the route file on production doesn't have the POST route:

1. **Upload your local `routes/api.php` file** to production
2. **Then run the cache clearing commands**

## Testing After Fix

1. **Test the form** from your frontend
2. **Check Laravel logs:**
   ```bash
   tail -f storage/logs/laravel.log
   ```
3. **Check database** to see if submissions are being saved

## Why This Happens

Laravel caches routes for performance. When you update `routes/api.php`, you must:
- Clear the route cache (`php artisan route:clear`)
- Or delete the cache files manually
- Then regenerate if needed (`php artisan route:cache`)

The production server still has the old cached routes that only had OPTIONS, not POST.

