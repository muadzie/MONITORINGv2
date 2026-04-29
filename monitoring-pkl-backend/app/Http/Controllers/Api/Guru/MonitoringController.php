<?php

namespace App\Http\Controllers\Api\Guru;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Attendance;
use App\Models\Logbook;
use App\Models\Placement;
use App\Models\Assessment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MonitoringController extends Controller
{
    // Ambil semua siswa yang dibimbing oleh guru ini
  public function students()
    {
        $user = auth()->user();
        
        // Debug - cek user yang login
        \Log::info('=== GURU STUDENTS API ===');
        \Log::info('User ID: ' . $user->id);
        \Log::info('User Name: ' . $user->name);
        \Log::info('User Role: ' . $user->role_id);
        
        // Method 1: Langsung query ke database
        $students = DB::table('users')
            ->where('role_id', 2)
            ->where('teacher_id', $user->id)
            ->get();
        
        \Log::info('Query 1 result (raw DB): ' . $students->count());
        
        // Method 2: Menggunakan Eloquent
        $studentsEloquent = User::where('role_id', 2)
            ->where('teacher_id', $user->id)
            ->with(['class', 'company'])
            ->get();
        
        \Log::info('Query 2 result (Eloquent): ' . $studentsEloquent->count());
        
        // Jika masih kosong, cek melalui tabel placements
        if ($studentsEloquent->isEmpty()) {
            \Log::info('Trying via placements table...');
            $studentIds = Placement::where('teacher_id', $user->id)
                ->where('status', 'active')
                ->pluck('student_id');
            
            \Log::info('Student IDs from placements: ' . json_encode($studentIds));
            
            $studentsEloquent = User::whereIn('id', $studentIds)
                ->with(['class', 'company'])
                ->get();
            
            \Log::info('Students from placements: ' . $studentsEloquent->count());
        }
        
        // Format response
        $result = $studentsEloquent->map(function($student) {
            $logbookCount = Logbook::where('user_id', $student->id)->count();
            
            $totalAttendance = Attendance::where('user_id', $student->id)->count();
            $presentCount = Attendance::where('user_id', $student->id)->where('status', 'present')->count();
            $attendancePercentage = $totalAttendance > 0 ? round(($presentCount / $totalAttendance) * 100) : 0;
            
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
                'assessment' => null,
            ];
        });
        
        return response()->json([
            'success' => true,
            'data' => $result,
            'debug' => [
                'user_id' => $user->id,
                'teacher_id_used' => $user->id,
                'count' => $result->count()
            ]
        ]);
    }
    
    // Monitoring siswa (untuk halaman monitoring)
    public function index()
    {
        $user = auth()->user();
        
        $students = User::where('role_id', 2)
            ->where('teacher_id', $user->id)
            ->with(['class', 'company'])
            ->get();
        
        $today = now()->format('Y-m-d');
        
        $result = $students->map(function($student) use ($today) {
            $attendance = Attendance::where('user_id', $student->id)
                ->whereDate('date', $today)
                ->first();
            
            $logbookCount = Logbook::where('user_id', $student->id)->count();
            
            return [
                'id' => $student->id,
                'nisn' => $student->nisn,
                'name' => $student->name,
                'class' => $student->class,
                'company' => $student->company,
                'today_status' => $attendance ? $attendance->status : 'absent',
                'today_check_in' => $attendance ? $attendance->check_in : null,
                'today_check_out' => $attendance ? $attendance->check_out : null,
                'logbook_count' => $logbookCount,
            ];
        });
        
        return response()->json([
            'success' => true,
            'data' => $result
        ]);
    }
    
    public function show($id)
    {
        $user = auth()->user();
        
        $student = User::where('role_id', 2)
            ->where('id', $id)
            ->where('teacher_id', $user->id)
            ->with(['class', 'company'])
            ->firstOrFail();
        
        $attendances = Attendance::where('user_id', $student->id)
            ->orderBy('date', 'desc')
            ->take(30)
            ->get();
        
        $logbooks = Logbook::where('user_id', $student->id)
            ->orderBy('created_at', 'desc')
            ->take(20)
            ->get();
        
        return response()->json([
            'success' => true,
            'data' => [
                'student' => $student,
                'attendances' => $attendances,
                'logbooks' => $logbooks,
            ]
        ]);
    }
    private function getAttendancePercentage($userId)
{
    $total = \App\Models\Attendance::where('user_id', $userId)->count();
    $present = \App\Models\Attendance::where('user_id', $userId)->where('status', 'present')->count();
    return $total > 0 ? round(($present / $total) * 100) : 0;
}
}