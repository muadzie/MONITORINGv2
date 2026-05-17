<?php

namespace App\Http\Controllers\Api\Guru;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Attendance;
use App\Models\Logbook;
use App\Models\Placement;
use Illuminate\Http\Request;

class MonitoringController extends Controller
{
    public function students()
    {
        $user = auth()->user();

        $students = User::supervisedBy($user->id)
            ->with(['class', 'company'])
            ->get();

        if ($students->isEmpty()) {
            $studentIds = Placement::where('teacher_id', $user->id)
                ->where('status', 'active')
                ->pluck('student_id');

            $students = User::whereIn('id', $studentIds)
                ->with(['class', 'company'])
                ->get();
        }

        $result = $students->map(function ($student) {
            return [
                'id' => $student->id,
                'nisn' => $student->nisn,
                'name' => $student->name,
                'email' => $student->email,
                'phone' => $student->phone,
                'class' => $student->class,
                'company' => $student->company,
                'logbook_count' => $student->logbooks_count ?? $student->logbooks()->count(),
                'attendance_percentage' => $this->getAttendancePercentage($student->id),
                'assessment' => null,
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $result,
        ]);
    }
    
    public function index()
    {
        $user = auth()->user();

        $students = User::supervisedBy($user->id)
            ->with(['class', 'company'])
            ->withCount(['logbooks'])
            ->get();

        $today = now()->format('Y-m-d');

        $todayAttendances = Attendance::whereIn('user_id', $students->pluck('id'))
            ->whereDate('date', $today)
            ->get()
            ->keyBy('user_id');

        $result = $students->map(function ($student) use ($todayAttendances) {
            $attendance = $todayAttendances->get($student->id);

            return [
                'id' => $student->id,
                'nisn' => $student->nisn,
                'name' => $student->name,
                'class' => $student->class,
                'company' => $student->company,
                'today_status' => $attendance ? $attendance->status : 'absent',
                'today_check_in' => $attendance ? $attendance->check_in : null,
                'today_check_out' => $attendance ? $attendance->check_out : null,
                'logbook_count' => (int) $student->logbooks_count,
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