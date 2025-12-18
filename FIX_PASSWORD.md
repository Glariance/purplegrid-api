# Fix Admin Password - Bcrypt Issue

## Problem
The password in the database is not hashed with Bcrypt, causing the error: "This password does not use the Bcrypt algorithm."

## Solution

### Option 1: Use the Fix Route (Easiest)

1. Open your browser's developer console (F12)
2. Go to the Network tab
3. Navigate to: `http://localhost:8000/admin/login`
4. In the console, run this JavaScript:

```javascript
fetch('/fix-admin-password', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
  },
  credentials: 'include',
  body: JSON.stringify({
    email: 'YOUR_ADMIN_EMAIL@example.com',
    password: 'YOUR_NEW_PASSWORD'
  })
})
.then(r => r.json())
.then(console.log)
.catch(console.error);
```

Replace:
- `YOUR_ADMIN_EMAIL@example.com` with your actual admin email
- `YOUR_NEW_PASSWORD` with your desired password

### Option 2: Use Artisan Command

Run this command in your terminal:

```bash
php artisan admin:fix-password YOUR_ADMIN_EMAIL@example.com YOUR_NEW_PASSWORD
```

### Option 3: Direct Database Update (Not Recommended)

If you must update directly in the database, use this SQL:

```sql
UPDATE users 
SET password = '$2y$12$YOUR_BCRYPT_HASH_HERE' 
WHERE email = 'YOUR_ADMIN_EMAIL@example.com';
```

To generate a Bcrypt hash, use:
```bash
php artisan tinker
>>> Hash::make('your-password-here')
```

## Important Notes:

- After fixing the password, you should be able to login
- The password will be properly hashed with Bcrypt
- Make sure to use a strong password (at least 8 characters)

