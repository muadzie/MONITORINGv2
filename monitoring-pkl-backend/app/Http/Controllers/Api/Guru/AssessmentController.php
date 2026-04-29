<?php

namespace App\Http\Controllers\Api\Guru;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Assessment;
use App\Models\Attendance;
use App\Models\Logbook;
use Illuminate\Http\Request;

class AssessmentController extends Controller
{
    public function index()
    {
        $user = auth()->user();
        
        // Ambil semua siswa yang memiliki teacher_id = id guru
        $students = User::where('role_id', 2)
            ->where('teacher_id', $user->id)
            ->with(['class', 'company'])
            ->get();
        
        $result = $students->map(function($student) {
            // Hitung statistik
            $totalAttendance = Attendance::where('user_id', $student->id)->count();
            $presentCount = Attendance::where('user_id', $student->id)->where('status', 'present')->count();
            $attendancePercentage = $totalAttendance > 0 ? round(($presentCount / $totalAttendance) * 100) : 0;
            
            $logbookCount = Logbook::where('user_id', $student->id)->count();
            
            // Cek penilaian terakhir
            $assessment = Assessment::where('student_id', $student->id)
                ->where('assessor_id', auth()->id())
                ->latest()
                ->first();
            
            return [
                'id' => $student->id,
                'nisn' => $student->nisn,
                'name' => $student->name,
                'email' => $student->email,
                'phone' => $student->phone,
                'class' => $student->class,
                'company' => $student->company,
                'logbook_count' => $logbookCount,
                'attendance_percentage' => $attendancePercentage,
                'assessment' => $assessment,
            ];
        });
        
        return response()->json([
            'success' => true,
            'data' => $result
        ]);
    }
    
    public function store(Request $request)
    {
        $request->validate([
            'student_id' => 'required|exists:users,id',
            'attendance_score' => 'nullable|integer|min:0|max:100',
            'logbook_score' => 'nullable|integer|min:0|max:100',
            'report_score' => 'nullable|integer|min:0|max:100',
            'attitude_score' => 'nullable|integer|min:0|max:100',
            'performance_score' => 'nullable|integer|min:0|max:100',
            'final_score' => 'nullable|integer|min:0|max:100',
            'notes' => 'nullable|string',
        ]);
        
        $assessment = Assessment::updateOrCreate(
            [
                'student_id' => $request->student_id,
                'assessor_id' => auth()->id(),
                'assessor_type' => 'guru',
            ],
            [
                'attendance_score' => $request->attendance_score,
                'logbook_score' => $request->logbook_score,
                'report_score' => $request->report_score,
                'attitude_score' => $request->attitude_score,
                'performance_score' => $request->performance_score,
                'final_score' => $request->final_score,
                'notes' => $request->notes,
            ]
        );
        
        return response()->json([
            'success' => true,
            'message' => 'Penilaian berhasil disimpan',
            'data' => $assessment
        ]);
    }
}