<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

class Logbook extends Model
{
    protected $table = 'logbooks';
    
    protected $fillable = [
        'user_id',
        'siswa_id',
        'date',
        'activity',
        'description',
        'attachment',
        'status',
        'grade',
        'feedback'
    ];
    
    protected $casts = [
        'date' => 'date',
        'grade' => 'integer'
    ];
    
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    
    public function siswa()
    {
        return $this->belongsTo(User::class, 'siswa_id');
    }
    
    public function getAttachmentUrlAttribute()
    {
        if ($this->attachment && Storage::disk('public')->exists($this->attachment)) {
            return Storage::url($this->attachment);
        }
        return null;
    }
}