<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Guru extends Model
{
    protected $table = 'gurus';
    
    protected $fillable = [
        'user_id', 'nip', 'nuptk', 'mata_pelajaran', 'pendidikan_terakhir'
    ];

    // Relasi ke User
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    // Relasi ke Siswa (guru pembimbing)
    public function siswas()
    {
        return $this->hasMany(Siswa::class, 'guru_pembimbing_id');
    }
    
    // Alias untuk konsistensi dengan frontend
    public function students()
    {
        return $this->hasMany(Siswa::class, 'guru_pembimbing_id');
    }
}