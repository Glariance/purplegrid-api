# Step-by-Step Debugging Guide for Amazon Form Route Issue

## Issue
Error: "The POST method is not supported for route api/amazon-form. Supported methods: OPTIONS."

## Step 1: Check Frontend Request
1. Open browser DevTools (F12)
2. Go to Network tab
3. Submit the Amazon form
4. Check the request:
   - **URL**: Should be `https://admin.purplegridmarketing.com/api/amazon-form`
   - **Method**: Should be `POST`
   - **Request Headers**: Check Content-Type is `application/json`
   - **Response**: Check status code and error message

## Step 2: Check Browser Console
Look for the debug logs we added:
```
🔍 Amazon Form Submission Debug:
URL: https://admin.purplegridmarketing.com/api/amazon-form
Method: POST
Payload: {...}
API Base URL: https://admin.purplegridmarketing.com/api
Response Status: 405
```

## Step 3: Check Production Server Logs
SSH into production and check Laravel logs:
```bash
cd /home/u727587393/domains/purplegridmarketing.com/admin
tail -f storage/logs/laravel.log
```

Then submit the form and look for:
- `AmazonFormController@store called` - means route matched
- `OPTIONS request to /amazon-form` - means OPTIONS route matched
- `OPTIONS catch-all matched` - means catch-all matched (BAD)

## Step 4: Verify Route Registration on Production
```bash
php artisan route:list | grep amazon-form
```

**Expected output:**
```
POST       api/amazon-form ...................................... amazon-form.store › Api\AmazonFormController@store
OPTIONS    api/amazon-form
```

If you only see OPTIONS, the route file wasn't uploaded correctly.

## Step 5: Clear All Caches on Production
```bash
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan optimize:clear  # Clears all caches
```

## Step 6: Verify Route File on Production
```bash
grep -A2 "amazon-form" routes/api.php
```

**Should show:**
```php
Route::post('/amazon-form', [AmazonFormController::class, 'store'])->name('amazon-form.store');
Route::options('/amazon-form', function () {
```

## Step 7: Test Route Directly
```bash
curl -X POST https://admin.purplegridmarketing.com/api/amazon-form \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{"niche":"test"}'
```

## Step 8: Check if Controller Exists
```bash
ls -la app/Http/Controllers/Api/AmazonFormController.php
```

## Common Issues and Fixes

### Issue 1: Route cache is stale
**Fix**: Run `php artisan route:clear` and `php artisan route:cache`

### Issue 2: Route file not uploaded
**Fix**: Upload the updated `routes/api.php` file

### Issue 3: Controller file missing
**Fix**: Upload `app/Http/Controllers/Api/AmazonFormController.php`

### Issue 4: OPTIONS catch-all matching first
**Fix**: Ensure POST route comes before OPTIONS routes in routes/api.php

### Issue 5: Route registered in wrong order
**Fix**: Make sure POST route is defined before the OPTIONS catch-all at the bottom

## Files That Must Be on Production

1. ✅ `routes/api.php` - Must have POST route for amazon-form
2. ✅ `app/Http/Controllers/Api/AmazonFormController.php` - Controller must exist
3. ✅ `app/Models/AmazonFormSubmission.php` - Model must exist
4. ✅ `app/Mail/AmazonFormAdminMail.php` - Mail class
5. ✅ `app/Mail/AmazonFormUserMail.php` - Mail class
6. ✅ `resources/views/emails/amazon-form-admin.blade.php` - Email template
7. ✅ `resources/views/emails/amazon-form-user.blade.php` - Email template
8. ✅ Database table `amazon_form_submissions` must exist (run migration)

