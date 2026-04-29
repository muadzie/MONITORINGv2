<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Permission extends Model
{
    protected $fillable = ['user_id', 'date', 'type', 'reason', 'attachment', 'status', 'rejection_reason'];

    protected $casts = [
        'date' => 'date'
    ];
    
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    
    public function getAttachmentUrlAttribute()
    {
        if ($this->attachment && Storage::disk('public')->exists($this->attachment)) {
            return Storage::url($this->attachment);
        }
        return null;
    }
}