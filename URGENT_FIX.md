# URGENT FIX - Amazon Form Route Issue

## The Problem
Error: "The POST method is not supported for route api/amazon-form. Supported methods: OPTIONS."
Empty logs = Controller not being called = Route not matching

## Root Cause
The route cache on production is stale and only has OPTIONS registered, not POST.

## IMMEDIATE FIX - Run These Commands on Production

```bash
cd /home/u727587393/domains/purplegridmarketing.com/admin

# STEP 1: Delete route cache files directly (CRITICAL!)
rm -f bootstrap/cache/routes-v7.php
rm -f bootstrap/cache/routes.php
rm -f bootstrap/cache/config.php

# STEP 2: Verify route file has POST route
echo "Checking route file..."
grep -n "Route::post('/amazon-form" routes/api.php
# MUST show line 28 with: Route::post('/amazon-form', [AmazonFormController::class, 'store'])->name('amazon-form.store');

# If it doesn't show, the route file on production is wrong!
# Upload the updated routes/api.php file from your local machine

# STEP 3: Clear all caches
php artisan optimize:clear
php artisan route:clear
php artisan config:clear
php artisan cache:clear

# STEP 4: Verify controller exists
ls -la app/Http/Controllers/Api/AmazonFormController.php
# Must show the file exists

# STEP 5: Check route registration (should show POST now)
php artisan route:list | grep amazon-form
# Should show: POST       api/amazon-form

# STEP 6: Regenerate cache
php artisan route:cache
php artisan config:cache

# STEP 7: Test
curl -X POST https://admin.purplegridmarketing.com/api/amazon-form \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"niche":"test"}'
```

## If Route Still Doesn't Show in Step 5

The route file on production is different from your local file. 

**Check what's actually in the production route file:**
```bash
sed -n '25,30p' routes/api.php
```

**Should show:**
```php
Route::post('/contact', [ContactController::class, 'store']);

// Amazon Form Submission
Route::post('/amazon-form', [AmazonFormController::class, 'store'])->name('amazon-form.store');
```

**If it doesn't match, upload your local routes/api.php file to production.**

## Files That Must Be on Production

1. ✅ `routes/api.php` - Line 28 must have POST route
2. ✅ `app/Http/Controllers/Api/AmazonFormController.php` - Controller must exist
3. ✅ `app/Models/AmazonFormSubmission.php` - Model must exist
4. ✅ Database table `amazon_form_submissions` - Must exist (run migration)

## After Fixing

1. Test the form from frontend
2. Check browser console for debug logs
3. Check Laravel logs: `tail -f storage/logs/laravel.log`
4. You should now see: "AmazonFormController@store called" in logs

