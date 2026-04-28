<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Siswa extends Model
{
    protected $table = 'siswas';
    
    protected $fillable = [
        'user_id', 'nisn', 'kelas_id', 'perusahaan_id', 
        'guru_pembimbing_id', 'tanggal_mulai_pkl', 'tanggal_selesai_pkl'
    ];

    // Relasi ke User
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    // Relasi ke Kelas
    public function kelas()
    {
        return $this->belongsTo(Kelas::class, 'kelas_id');
    }

    // Relasi ke Perusahaan
    public function perusahaan()
    {
        return $this->belongsTo(Perusahaan::class, 'perusahaan_id');
    }

    // Relasi ke Guru Pembimbing
    public function guruPembimbing()
    {
        return $this->belongsTo(Guru::class, 'guru_pembimbing_id');
    }
}