<?php

namespace App\Http\Controllers\Api\Perusahaan;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Logbook;
use App\Models\Placement;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function logbook(Request $request)
    {
        $user = auth()->user();
        $companyId = $user->company_id;
        
        $startDate = $request->get('start_date');
        $endDate = $request->get('end_date');
        
        // Ambil semua siswa yang magang di perusahaan ini
        $studentIds = Placement::where('company_id', $companyId)
            ->where('status', 'active')
            ->pluck('student_id');
        
        // Query logbook
        $query = Logbook::whereIn('user_id', $studentIds)
            ->with('user');
        
        if ($startDate) {
            $query->where('date', '>=', $startDate);
        }
        if ($endDate) {
            $query->where('date', '<=', $endDate);
        }
        
        $logbooks = $query->orderBy('date', 'desc')->get();
        
        // Hitung summary
        $totalStudents = $studentIds->count();
        $totalLogbooks = $logbooks->count();
        $gradedLogbooks = $logbooks->whereNotNull('grade')->count();
        $averageGrade = $gradedLogbooks > 0 ? round($logbooks->whereNotNull('grade')->avg('grade')) : 0;
        
        return response()->json([
            'success' => true,
            'data' => $logbooks,
            'summary' => [
                'total_students' => $totalStudents,
                'total_logbooks' => $totalLogbooks,
                'graded_logbooks' => $gradedLogbooks,
                'pending_logbooks' => $totalLogbooks - $gradedLogbooks,
                'overall_average' => $averageGrade,
            ]
        ]);
    }
    
    public function progress(Request $request)
    {
        $user = auth()->user();
        $companyId = $user->company_id;
        
        $studentIds = Placement::where('company_id', $companyId)
            ->where('status', 'active')
            ->pluck('student_id');
        
        $students = User::whereIn('id', $studentIds)
            ->get()
            ->map(function($student) {
                $logbooks = Logbook::where('user_id', $student->id)->get();
                $gradedCount = $logbooks->whereNotNull('grade')->count();
                $totalCount = $logbooks->count();
                
                return [
                    'nisn' => $student->nisn,
                    'name' => $student->name,
                    'logbook_count' => $totalCount,
                    'graded_count' => $gradedCount,
                    'pending_count' => $totalCount - $gradedCount,
                    'average_grade' => $gradedCount > 0 ? round($logbooks->whereNotNull('grade')->avg('grade')) : 0,
                ];
            });
        
        $totalStudents = $students->count();
        $totalLogbooks = $students->sum('logbook_count');
        $totalGraded = $students->sum('graded_count');
        $overallAverage = $totalGraded > 0 ? round($students->sum(function($s) { return $s['average_grade'] * $s['graded_count']; }) / $totalGraded) : 0;
        
        return response()->json([
            'success' => true,
            'data' => $students,
            'summary' => [
                'total_students' => $totalStudents,
                'total_logbooks' => $totalLogbooks,
                'total_graded' => $totalGraded,
                'total_pending' => $totalLogbooks - $totalGraded,
                'overall_average' => $overallAverage,
            ]
        ]);
    }
}