<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AiInfluencerFormSubmission extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'full_name',
        'email',
        'phone',
        'company_name',
        'service',
        'budget',
        'project_details',
        'is_read'
    ];

    protected $dates = ['deleted_at'];
}
