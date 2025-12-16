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
        Schema::create('amazon_form_submissions', function (Blueprint $table) {
            $table->id();
            $table->string('niche')->nullable();
            $table->string('location')->nullable();
            $table->string('revenue')->nullable();
            $table->string('ad_budget')->nullable();
            $table->string('business_type')->nullable();
            $table->json('grid_team')->nullable(); // Store array of selected roles
            $table->string('email')->nullable(); // Optional email field
            $table->string('name')->nullable(); // Optional name field
            $table->string('phone')->nullable(); // Optional phone field
            $table->boolean('is_read')->default(false);
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('amazon_form_submissions');
    }
};

