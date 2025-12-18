<?php

use App\Http\Controllers\Api\AboutController;
use App\Http\Controllers\Api\ContactController;
use App\Http\Controllers\Api\HomeController;
use App\Http\Controllers\Api\PetController;
use App\Http\Controllers\Api\PrivacyController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::redirect('/admin', '/admin/login');

Route::get('/media/{path}', function (string $path) {
    if (! Storage::disk('public')->exists($path)) {
        abort(404);
    }

    return Storage::disk('public')->response($path);
})->where('path', '.*')->name('media.asset');

// TEMPORARY: Fix admin password route - REMOVE AFTER USE
// Usage: POST /fix-admin-password with email and password in request body
Route::post('/fix-admin-password', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required|min:8',
    ]);

    $user = \App\Models\User::where('email', $request->email)->first();
    
    if (!$user) {
        return response()->json(['error' => 'User not found'], 404);
    }

    $adminRole = config('constants.ADMIN');
    $superAdminRole = config('constants.SUPERADMIN');
    
    if ($user->role_id != $adminRole && $user->role_id != $superAdminRole) {
        return response()->json(['error' => 'User is not an admin'], 403);
    }

    $user->password = \Illuminate\Support\Facades\Hash::make($request->password);
    $user->save();

    return response()->json(['success' => 'Password updated successfully. You can now login.']);
})->middleware('web');

// Handle OPTIONS preflight for CSRF token
Route::options('/csrf-token', function (Request $request) {
    $origin = $request->header('Origin');
    $allowedOrigins = [
        'http://localhost:5173',
        'http://127.0.0.1:5173',
        'https://www.purplegridmarketing.com',
        'https://purplegridmarketing.com',
    ];
    
    $response = response()->noContent();
    
    if ($origin && in_array($origin, $allowedOrigins)) {
        $response->header('Access-Control-Allow-Origin', $origin);
    } else {
        $response->header('Access-Control-Allow-Origin', '*');
    }
    
    $response->header('Access-Control-Allow-Credentials', 'true')
             ->header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
             ->header('Access-Control-Allow-Headers', 'Content-Type, X-Requested-With, X-CSRF-TOKEN, Accept')
             ->header('Access-Control-Max-Age', '86400');
    
    return $response;
})->middleware('web');

// Get CSRF token for frontend (CORS enabled)
Route::get('/csrf-token', function (Request $request) {
    // Ensure session is started
    if (!session()->isStarted()) {
        session()->start();
    }
    
    $origin = $request->header('Origin');
    $allowedOrigins = [
        'http://localhost:5173',
        'http://127.0.0.1:5173',
        'https://www.purplegridmarketing.com',
        'https://purplegridmarketing.com',
    ];
    
    $response = response()->json([
        'csrf_token' => csrf_token(),
    ]);
    
    if ($origin && in_array($origin, $allowedOrigins)) {
        $response->header('Access-Control-Allow-Origin', $origin);
    } else {
        $response->header('Access-Control-Allow-Origin', '*');
    }
    
    $response->header('Access-Control-Allow-Credentials', 'true')
             ->header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
             ->header('Access-Control-Allow-Headers', 'Content-Type, X-Requested-With, X-CSRF-TOKEN, Accept');
    
    return $response;
})->middleware('web');


Route::get('/', function (Request $request, PrivacyController $controller) {
    $response = $controller->show($request);

    dd($response->getData(true));
});

Route::middleware(['auth', 'role:'.config('constants.USER')])->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->middleware(['verified'])->name('dashboard');
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
