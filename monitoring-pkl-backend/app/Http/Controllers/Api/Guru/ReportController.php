<?php

namespace App\Http\Controllers\Api\Guru;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Attendance;
use App\Models\Logbook;
use App\Models\Assessment;
use Carbon\Carbon;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function attendance(Request $request)
    {
        $user = auth()->user();
        $students = User::supervisedBy($user->id)->with('company')->get();

        $data = $students->map(function ($student) {
            $total = Attendance::where('user_id', $student->id)->count();
            $present = Attendance::where('user_id', $student->id)->where('status', 'present')->count();
            $late = Attendance::where('user_id', $student->id)->where('status', 'late')->count();

            return [
                'id' => $student->id,
                'name' => $student->name,
                'nisn' => $student->nisn,
                'company' => $student->company?->name,
                'total' => $total,
                'present' => $present,
                'late' => $late,
                'percentage' => $total > 0 ? round(($present / $total) * 100, 1) : 0,
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $data,
        ]);
    }

    public function logbook(Request $request)
    {
        $user = auth()->user();
        $students = User::supervisedBy($user->id)->with('company')->get();

        $data = $students->map(function ($student) {
            $logbooks = Logbook::where('user_id', $student->id);

            return [
                'id' => $student->id,
                'name' => $student->name,
                'nisn' => $student->nisn,
                'company' => $student->company?->name,
                'total' => (clone $logbooks)->count(),
                'pending' => (clone $logbooks)->where('status', 'pending')->count(),
                'approved' => (clone $logbooks)->where('status', 'approved')->count(),
                'rejected' => (clone $logbooks)->where('status', 'rejected')->count(),
                'avg_grade' => round((clone $logbooks)->avg('grade') ?? 0, 2),
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $data,
        ]);
    }

    public function assessment(Request $request)
    {
        $user = auth()->user();
        $students = User::supervisedBy($user->id)->with('company')->get();

        $data = $students->map(function ($student) {
            $assessment = Assessment::where('student_id', $student->id)
                ->where('assessor_type', 'guru')
                ->first();

            return [
                'id' => $student->id,
                'name' => $student->name,
                'nisn' => $student->nisn,
                'company' => $student->company?->name,
                'assessed' => $assessment ? true : false,
                'final_score' => $assessment?->final_score,
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $data,
        ]);
    }
}
