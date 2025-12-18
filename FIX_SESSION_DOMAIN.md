# Fix Session Domain for Local Development

## Problem
The session domain is set to `.purplegridmarketing.com` but you're testing on `localhost:8000`. This causes the session cookie to not be sent with AJAX requests, resulting in CSRF token mismatch errors.

## Solution

### For Local Development:
In your `.env` file, set:
```env
SESSION_DOMAIN=
```
Or comment it out/remove the line entirely.

### For Production:
Keep it as:
```env
SESSION_DOMAIN=.purplegridmarketing.com
```

## Steps to Fix:

1. Open `purple-api/.env` file
2. Find the line: `SESSION_DOMAIN=.purplegridmarketing.com`
3. Change it to: `SESSION_DOMAIN=` (empty)
4. Or remove the line entirely
5. Clear config cache: `php artisan config:clear`
6. Restart your server
7. Clear browser cookies for localhost:8000
8. Try logging in again

## Why This Happens:
- Session cookies are domain-specific
- A cookie set for `.purplegridmarketing.com` won't be sent to `localhost:8000`
- Without the session cookie, Laravel creates a new session for each request
- New session = new CSRF token = mismatch error

