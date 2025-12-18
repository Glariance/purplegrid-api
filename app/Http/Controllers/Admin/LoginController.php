<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Mail\Admin\AdminResetPasswordMail;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Str;

class LoginController extends Controller
{
    public function login()
    {
        // Ensure session is started and CSRF token is available
        session()->regenerateToken();
        return view('admin.auth.login');
    }
    public function forgot()
    {
        return view('admin.auth.forgot');
    }
    public function forgotpost(Request $request)
    {
        $request->validate(['email' => 'required|email|exists:users,email']);
        try {
            $token = Str::random(60);
            $email = $request->email;
            DB::table('password_reset_tokens')->updateOrInsert(
                ['email' => $email],
                [
                    'token' => $token,
                    'created_at' => Carbon::now()
                ]
            );
            $resetUrl = url('/admin/reset-password?token=' . $token . '&email=' . urlencode($email));
            $this->sendMailHelper($email, AdminResetPasswordMail::class, $resetUrl);

            return response()->json(['success' => 'Password reset link sent to your email.']);
        } catch (\Exception $e) {
            return response()->json(['errors' => $e->getMessage()], 500);
        }
        //     return $this->forSuccessResponse('Password reset link sent to your email.');
        // } catch (\Exception $e) {
        //     return $this->forErrorResponse('Mail sending failed: ' . $e->getMessage(), 500);
        // }
    }
    public function resetPassword(Request $request)
    {
        return view('admin.auth.reset_password', ['token' => $request->token, 'email' => $request->email]);
    }
    public function resetPasswordPost(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:password_reset_tokens,email',
            'token' => 'required',
            'password' => 'required|confirmed',
        ]);

        $record = DB::table('password_reset_tokens')->where('email', $request->email)->first();
        if (!$record || $request->token != $record->token) {
            return response()->json(['errors' => 'Invalid or expired token!'], 400);
        }
        // Update Password
        $admin = User::where('email', $request->email)->first();
        $admin->password = Hash::make($request->password);
        $admin->save();

        // Delete Reset Token
        DB::table('password_reset_tokens')->where('email', $request->email)->delete();
        return response()->json(['success' => 'Password reset successfully!']);
    }
    public function adminLogin(Request $request)
    {
        // Check if this is an AJAX/JSON request
        $acceptHeader = $request->header('Accept', '');
        $isAjax = $request->ajax() || 
                  $request->wantsJson() || 
                  $request->header('X-Requested-With') === 'XMLHttpRequest' ||
                  (strpos($acceptHeader, 'application/json') !== false);
        
        // Force JSON response for AJAX requests
        if ($isAjax) {
            $request->headers->set('Accept', 'application/json');
        }
        
        // Debug: Log login attempt
        \Log::info('Admin login attempt', [
            'email' => $request->input('email'),
            'has_password' => $request->has('password'),
            'is_ajax' => $isAjax,
            'accept_header' => $request->header('Accept'),
        ]);
        
        // Validate request
        try {
            $validated = $request->validate([
                'email' => 'required|string|email',
                'password' => 'required',
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'errors' => $e->validator->errors()->first(),
                'message' => 'Validation failed',
            ], 422);
        }
        
        try {
            $credentials = $request->only('email', 'password');
            
            // Use web guard to ensure session-based authentication works
            if (Auth::guard('web')->attempt($credentials)) {
                $user = Auth::guard('web')->user();
                $adminRole = config('constants.ADMIN', 2);
                $superAdminRole = config('constants.SUPERADMIN', null);
                $userRole = config('constants.USER', 1);
                
                // Check if user is admin or superadmin
                $isAdmin = ($user->role_id == $adminRole) || 
                          ($superAdminRole !== null && $user->role_id == $superAdminRole);
                
                // Check if user is regular user
                $isUser = ($user->role_id == $userRole);
                
                // Regenerate session to prevent session fixation attacks
                try {
                    $request->session()->regenerate();
                } catch (\Exception $sessionError) {
                    \Log::warning('Session regeneration failed', ['error' => $sessionError->getMessage()]);
                    // Continue without session regeneration
                }
                
                // Verify authentication is maintained
                \Log::info('After login', [
                    'user_id' => Auth::guard('web')->id(),
                    'is_authenticated' => Auth::guard('web')->check(),
                    'session_id' => $request->session()->getId(),
                    'session_driver' => config('session.driver'),
                    'session_domain' => config('session.domain'),
                ]);
                
                // Save session to ensure it's persisted
                $request->session()->save();
                
                // Get session cookie name and ID
                $sessionName = config('session.cookie', 'laravel_session');
                $sessionId = $request->session()->getId();
                
                \Log::info('Session cookie details', [
                    'session_name' => $sessionName,
                    'session_id' => $sessionId,
                    'session_domain' => config('session.domain'),
                    'session_path' => config('session.path'),
                    'session_same_site' => config('session.same_site'),
                ]);
                
                // Always return JSON for AJAX requests
                if ($isAjax) {
                    // Get session cookie configuration
                    $sessionName = config('session.cookie', 'laravel_session');
                    $sessionId = $request->session()->getId();
                    $cookieDomain = config('session.domain');
                    $cookiePath = config('session.path', '/');
                    $cookieSecure = config('session.secure', false);
                    $cookieSameSite = config('session.same_site', 'lax');
                    $cookieLifetime = config('session.lifetime', 120);
                    
                    // For localhost, set domain to null
                    if (empty($cookieDomain) || $cookieDomain === '.purplegridmarketing.com') {
                        $cookieDomain = null;
                    }
                    
                    // Create response
                    if ($isAdmin) {
                        // Admin users go to admin dashboard
                        $redirectTo = $request->session()->get('url.intended', '/admin/dashboard');
                        
                        $response = response()->json([
                            'success' => 'Login successful!',
                            'redirect_to' => $redirectTo,
                            'user_type' => 'admin',
                        ], 200);
                    } elseif ($isUser) {
                        // Regular users go to user dashboard
                        $redirectTo = $request->session()->get('url.intended', '/dashboard');
                        
                        $response = response()->json([
                            'success' => 'Login successful!',
                            'redirect_to' => $redirectTo,
                            'user_type' => 'user',
                        ], 200);
                    } else {
                        // Unknown role - log for debugging
                        \Log::warning('User with unknown role attempted login', [
                            'user_id' => $user->id,
                            'role_id' => $user->role_id,
                        ]);
                        Auth::guard('web')->logout();
                        return response()->json(['errors' => 'Invalid user role.'], 403);
                    }
                    
                    // Explicitly set session cookie in response
                    // IMPORTANT: Must assign the result of withCookie() back to $response
                    $response = $response->withCookie(cookie(
                        $sessionName,
                        $sessionId,
                        $cookieLifetime,
                        $cookiePath,
                        $cookieDomain,
                        $cookieSecure,
                        true, // httpOnly
                        false, // raw
                        $cookieSameSite
                    ));
                    
                    \Log::info('Setting session cookie in response', [
                        'session_name' => $sessionName,
                        'session_id' => $sessionId,
                        'cookie_domain' => $cookieDomain,
                        'cookie_path' => $cookiePath,
                        'cookie_same_site' => $cookieSameSite,
                        'cookie_secure' => $cookieSecure,
                        'cookie_lifetime' => $cookieLifetime,
                    ]);
                    
                    return $response;
                } else {
                    // Non-AJAX request - use standard redirects
                    if ($isAdmin) {
                        return redirect()->intended('/admin/dashboard');
                    } elseif ($isUser) {
                        return redirect()->intended('/dashboard');
                    } else {
                        Auth::guard('web')->logout();
                        return back()->withErrors(['email' => 'Invalid user role.']);
                    }
                }
            }
            
            // Always return JSON for AJAX requests
            if ($isAjax) {
                return response()->json(['errors' => 'The provided credentials do not match our records.'], 401);
            }
            return back()->withErrors(['email' => 'The provided credentials do not match our records.'])->withInput();
        } catch (\Exception $e) {
            \Log::error('Admin login error', ['error' => $e->getMessage()]);
            return response()->json(['errors' => $e->getMessage()], 500);
        }
        // dd($request->all());
        // return back()->withErrors([
        //     'email' => 'The provided credentials do not match our records.',
        // ])->withInput();
    }
    public function logout()
    {
        Auth::logout();
        return redirect()->route('admin.login');
    }
}
