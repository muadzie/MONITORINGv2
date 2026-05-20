<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CompanyHoliday extends Model
{
    protected $fillable = [
        'company_id',
        'date',
        'description',
    ];

    protected $casts = [
        'date' => 'date',
    ];

    public function company()
    {
        return $this->belongsTo(Company::class);
    }
}
