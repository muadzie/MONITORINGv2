<?php

namespace App\Http\Controllers\Api\Perusahaan;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Logbook;
use App\Models\Assessment;
use App\Models\Placement;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function stats()
    {
        $user = auth()->user();
        $companyId = $user->company_id;
        
        // Ambil semua siswa yang magang di perusahaan ini
        $studentIds = Placement::where('company_id', $companyId)
            ->where('status', 'active')
            ->pluck('student_id');
        
        // Hitung statistik
        $totalStudents = $studentIds->count();
        $totalLogbooks = Logbook::whereIn('user_id', $studentIds)->count();
        $pendingAssessment = Logbook::whereIn('user_id', $studentIds)
            ->whereNull('grade')
            ->count();
        
        // Hitung rata-rata nilai
        $assessments = Assessment::whereIn('student_id', $studentIds)
            ->where('assessor_type', 'perusahaan')
            ->get();
        $averageGrade = $assessments->avg('final_score');
        
        return response()->json([
            'students' => $totalStudents,
            'logbooks' => $totalLogbooks,
            'pending_assessment' => $pendingAssessment,
            'average_grade' => round($averageGrade),
        ]);
    }
    
    public function topStudents()
    {
        $user = auth()->user();
        $companyId = $user->company_id;
        
        $studentIds = Placement::where('company_id', $companyId)
            ->where('status', 'active')
            ->pluck('student_id');
        
        $students = User::whereIn('id', $studentIds)
            ->with('company')
            ->get()
            ->map(function($student) {
                $logbookCount = Logbook::where('user_id', $student->id)->count();
                return [
                    'id' => $student->id,
                    'name' => $student->name,
                    'nisn' => $student->nisn,
                    'logbook_count' => $logbookCount,
                ];
            })
            ->sortByDesc('logbook_count')
            ->take(5)
            ->values();
        
        return response()->json($students);
    }
}