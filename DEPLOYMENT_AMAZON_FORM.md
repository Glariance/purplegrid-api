# Amazon Form Deployment Checklist

## Files to Upload to Production

1. **Routes**
   - `routes/api.php` (updated with amazon-form route)

2. **Controller**
   - `app/Http/Controllers/Api/AmazonFormController.php`

3. **Model**
   - `app/Models/AmazonFormSubmission.php`

4. **Mail Classes**
   - `app/Mail/AmazonFormAdminMail.php`
   - `app/Mail/AmazonFormUserMail.php`

5. **Email Templates**
   - `resources/views/emails/amazon-form-admin.blade.php`
   - `resources/views/emails/amazon-form-user.blade.php`

6. **Migration**
   - `database/migrations/2025_01_15_000001_create_amazon_form_submissions_table.php`

## Production Server Commands

After uploading all files, SSH into your production server and run:

```bash
cd /path/to/your/laravel/app

# Run the migration
php artisan migrate

# Clear ALL caches (CRITICAL!)
php artisan route:clear
php artisan config:clear
php artisan cache:clear
php artisan view:clear

# Regenerate caches (if using in production)
php artisan route:cache
php artisan config:cache

# Verify the route is registered
php artisan route:list | grep amazon-form

# Should show:
# POST       api/amazon-form ...................................... amazon-form.store › Api\AmazonFormController@store
```

## Verification

1. Check route exists:
   ```bash
   php artisan route:list --path=amazon-form
   ```

2. Check table exists:
   ```bash
   php artisan tinker
   # Then: Schema::hasTable('amazon_form_submissions');
   ```

3. Test the endpoint:
   ```bash
   curl -X POST https://admin.purplegridmarketing.com/api/amazon-form \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -d '{"niche":"test"}'
   ```

## Common Issues

- **405 Method Not Allowed**: Route cache not cleared on production
- **404 Not Found**: Route file not uploaded or route not registered
- **500 Error**: Migration not run or files missing

