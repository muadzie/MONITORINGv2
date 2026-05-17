<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/** @deprecated Use User model with role_id = 4 or Company model instead */
class Perusahaan extends Model
{
    protected $table = 'perusahaans';
    
    protected $fillable = [
        'user_id', 'nama_perusahaan', 'alamat', 'latitude', 'longitude', 
        'radius', 'telepon', 'bidang_usaha', 'deskripsi', 'kontak_person', 
        'jabatan_kontak', 'logo', 'is_active'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function placements()
    {
        return $this->hasMany(Placement::class);
    }
}