<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name', 'email', 'password', 'nisn', 'nip', 'phone', 
        'role_id', 'company_id', 'teacher_id', 'is_active'
    ];

    protected $hidden = ['password', 'remember_token'];

    // Relasi
    public function role()
    {
        return $this->belongsTo(Role::class);
    }

    public function company()
    {
        return $this->belongsTo(Company::class);
    }

    public function teacher()
    {
        return $this->belongsTo(User::class, 'teacher_id');
    }

    public function students()
    {
        return $this->hasMany(User::class, 'teacher_id');
    }

    public function placements()
    {
        return $this->hasMany(Placement::class, 'student_id');
    }

    public function attendances()
    {
        return $this->hasMany(Attendance::class);
    }

    public function logbooks()
    {
        return $this->hasMany(Logbook::class);
    }

    public function permissions()
    {
        return $this->hasMany(Permission::class);
    }

    // Scopes
    public function scopeStudents($query)
    {
        return $query->where('role_id', 2);
    }

    public function scopeTeachers($query)
    {
        return $query->where('role_id', 3);
    }

    public function scopeCompanies($query)
    {
        return $query->where('role_id', 4);
    }
}