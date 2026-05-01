<?php

namespace App\Http\Controllers\Api\Perusahaan;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Logbook;
use App\Models\Placement;
use Illuminate\Http\Request;

class ProgressController extends Controller
{
    public function index()
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
                $logbookCount = $logbooks->count();
                $averageGrade = $logbooks->whereNotNull('grade')->avg('grade');
                $lastLogbook = $logbooks->sortByDesc('created_at')->first();
                
                return [
                    'id' => $student->id,
                    'name' => $student->name,
                    'nisn' => $student->nisn,
                    'logbook_count' => $logbookCount,
                    'average_grade' => round($averageGrade),
                    'last_logbook' => $lastLogbook ? [
                        'activity' => $lastLogbook->activity,
                        'date' => $lastLogbook->date,
                    ] : null,
                ];
            });
        
        return response()->json([
            'success' => true,
            'data' => $students
        ]);
    }
    
    public function show($id)
    {
        $student = User::findOrFail($id);
        
        $logbooks = Logbook::where('user_id', $student->id)
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function($logbook) {
                return [
                    'id' => $logbook->id,
                    'date' => $logbook->date,
                    'activity' => $logbook->activity,
                    'description' => $logbook->description,
                    'grade' => $logbook->grade,
                    'feedback' => $logbook->feedback,
                ];
            });
        
        $stats = [
            'total_logbooks' => $logbooks->count(),
            'graded_logbooks' => $logbooks->whereNotNull('grade')->count(),
            'average_grade' => round($logbooks->whereNotNull('grade')->avg('grade')),
            'total_activities' => $logbooks->sum('grade'),
        ];
        
        return response()->json([
            'success' => true,
            'data' => [
                'student' => [
                    'id' => $student->id,
                    'name' => $student->name,
                    'nisn' => $student->nisn,
                    'email' => $student->email,
                ],
                'stats' => $stats,
                'logbooks' => $logbooks,
            ]
        ]);
    }
    
    public function report()
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
                
                return [
                    'nisn' => $student->nisn,
                    'name' => $student->name,
                    'total_logbooks' => $logbooks->count(),
                    'average_grade' => round($logbooks->whereNotNull('grade')->avg('grade')),
                    'completed_percentage' => $logbooks->count() > 0 ? round(($logbooks->whereNotNull('grade')->count() / $logbooks->count()) * 100) : 0,
                ];
            });
        
        return response()->json([
            'success' => true,
            'data' => $students,
            'summary' => [
                'total_students' => $students->count(),
                'total_logbooks' => $students->sum('total_logbooks'),
                'overall_average' => round($students->avg('average_grade')),
            ]
        ]);
    }
}