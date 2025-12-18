<?php

namespace App\Console\Commands;

use App\Models\User;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Hash;

class FixAdminPassword extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'admin:fix-password {email} {password} {--force : Skip role check and update password anyway}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Fix admin password by updating it to use Bcrypt hashing';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $email = $this->argument('email');
        $password = $this->argument('password');

        $user = User::where('email', $email)->first();

        if (!$user) {
            $this->error("User with email {$email} not found.");
            return 1;
        }

        // Show user info
        $this->info("User found: {$user->name} (role_id: {$user->role_id})");
        
        // Check if user is admin or superadmin (optional check)
        if (!$this->option('force')) {
            $adminRole = config('constants.ADMIN');
            $superAdminRole = config('constants.SUPERADMIN');
            
            if ($adminRole !== null || $superAdminRole !== null) {
                $isAdmin = ($adminRole !== null && $user->role_id == $adminRole);
                $isSuperAdmin = ($superAdminRole !== null && $user->role_id == $superAdminRole);
                
                if (!$isAdmin && !$isSuperAdmin) {
                    $this->warn("Warning: User role_id ({$user->role_id}) doesn't match ADMIN ({$adminRole}) or SUPERADMIN ({$superAdminRole}).");
                    $this->info("Use --force flag to skip this check: php artisan admin:fix-password {$email} {$password} --force");
                    return 1;
                }
            }
        } else {
            $this->warn("Skipping role check (--force flag used)");
        }

        // Update password with Bcrypt
        $user->password = Hash::make($password);
        $user->save();

        $this->info("Password for {$email} has been updated successfully!");
        $this->info("You can now login with the new password.");

        return 0;
    }
}

