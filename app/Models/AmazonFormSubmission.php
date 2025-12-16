<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AmazonFormSubmission extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'niche',
        'location',
        'revenue',
        'ad_budget',
        'business_type',
        'grid_team',
        'email',
        'name',
        'phone',
        'is_read'
    ];

    protected $casts = [
        'grid_team' => 'array',
    ];

    protected $dates = ['deleted_at'];
}

