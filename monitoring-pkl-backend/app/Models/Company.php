<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    protected $fillable = [
        'name',
        'address',
        'phone',
        'email',
        'description',
        'latitude',
        'longitude',
        'radius',
    ];

    // Accessor untuk format radius
    public function getRadiusInKmAttribute()
    {
        return round($this->radius / 1000, 2);
    }

    // Method untuk validasi jarak
    public function isWithinRadius($userLat, $userLng)
    {
        $distance = $this->calculateDistance($userLat, $userLng, $this->latitude, $this->longitude);
        return $distance <= $this->radius;
    }

    public function calculateDistance($lat1, $lon1, $lat2, $lon2)
    {
        return haversineDistance($lat1, $lon1, $lat2, $lon2);
    }

    public function placements()
{
    return $this->hasMany(Placement::class);
}

    public function users()
    {
        return $this->hasMany(User::class);
    }

    public function attendances()
    {
        return $this->hasMany(Attendance::class);
    }
}