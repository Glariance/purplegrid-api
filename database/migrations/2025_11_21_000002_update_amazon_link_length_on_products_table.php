<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Only run if products table exists
        if (Schema::hasTable('products')) {
            Schema::table('products', function (Blueprint $table) {
                // Check if amazon_link column exists before modifying
                if (Schema::hasColumn('products', 'amazon_link')) {
                    // Allow longer Amazon URLs
                    $table->string('amazon_link', 2048)->nullable()->change();
                }
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Only run if products table exists
        if (Schema::hasTable('products')) {
            Schema::table('products', function (Blueprint $table) {
                // Check if amazon_link column exists before modifying
                if (Schema::hasColumn('products', 'amazon_link')) {
                    // Revert to default string length
                    $table->string('amazon_link', 255)->nullable()->change();
                }
            });
        }
    }
};
