<?php
// app/Console/Commands/FixPlacementTeacherId.php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Placement;
use App\Models\User;

class FixPlacementTeacherId extends Command
{
    protected $signature = 'placement:fix-teacher';
    protected $description = 'Fix missing teacher_id in placements and users table';

    public function handle()
    {
        // 1. Fix placements tanpa teacher_id
        $placements = Placement::whereNull('teacher_id')->get();
        $updatedPlacements = 0;
        
        foreach ($placements as $placement) {
            $student = User::find($placement->student_id);
            
            // Cari guru dari data siswa atau placement
            $teacherId = null;
            
            if ($student && $student->teacher_id) {
                $teacherId = $student->teacher_id;
            } else {
                // Jika tidak ada, cari guru default (ambil guru pertama)
                $defaultTeacher = User::where('role_id', 3)->first();
                if ($defaultTeacher) {
                    $teacherId = $defaultTeacher->id;
                    $this->warn("Using default teacher for placement {$placement->id}");
                }
            }
            
            if ($teacherId) {
                $placement->update(['teacher_id' => $teacherId]);
                $updatedPlacements++;
                $this->info("Updated placement {$placement->id} with teacher_id: {$teacherId}");
            }
        }
        
        // 2. Fix users tanpa teacher_id
        $students = User::where('role_id', 2)->whereNull('teacher_id')->get();
        $updatedStudents = 0;
        
        foreach ($students as $student) {
            // Cari placement aktif siswa
            $placement = Placement::where('student_id', $student->id)
                ->where('status', 'active')
                ->first();
                
            if ($placement && $placement->teacher_id) {
                $student->update(['teacher_id' => $placement->teacher_id]);
                $updatedStudents++;
                $this->info("Updated student {$student->name} with teacher_id: {$placement->teacher_id}");
            } else {
                // Jika tidak ada placement aktif, cari guru default
                $defaultTeacher = User::where('role_id', 3)->first();
                if ($defaultTeacher) {
                    $student->update(['teacher_id' => $defaultTeacher->id]);
                    $updatedStudents++;
                    $this->warn("Updated student {$student->name} with default teacher");
                }
            }
        }
        
        $this->newLine();
        $this->info("✅ Updated {$updatedPlacements} placements");
        $this->info("✅ Updated {$updatedStudents} students");
    }
}