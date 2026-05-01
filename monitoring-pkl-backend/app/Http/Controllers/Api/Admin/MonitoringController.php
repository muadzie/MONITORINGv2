<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Attendance;
use App\Models\Logbook;
use Carbon\Carbon;
use Illuminate\Http\Request;

class MonitoringController extends Controller
{
    public function index()
    {
        try {
            // Ambil semua siswa dengan relasi
            $students = User::where('role_id', 2)
                ->with(['company', 'class'])
                ->get();
            
            $result = [];
            foreach ($students as $student) {
                // Status kehadiran hari ini
                $today = Carbon::today();
                $attendance = Attendance::where('user_id', $student->id)
                    ->whereDate('date', $today)
                    ->first();
                
                // Hitung total logbook
                $logbookCount = Logbook::where('user_id', $student->id)->count();
                
                // Hitung rata-rata nilai
                $avgGrade = Logbook::where('user_id', $student->id)->avg('grade');
                
                $result[] = [
                    'id' => $student->id,
                    'nisn' => $student->nisn,
                    'name' => $student->name,
                    'class_id' => $student->class_id,
                    'class' => $student->class,
                    'company_id' => $student->company_id,
                    'company' => $student->company,
                    'today_status' => $attendance ? $attendance->status : 'absent',
                    'logbook_count' => $logbookCount,
                    'avg_grade' => $avgGrade ? round($avgGrade, 2) : 0,
                ];
            }
            
            return response()->json($result);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error: ' . $e->getMessage()
            ], 500);
        }
    }

    public function progress(Request $request)
    {
        try {
            $query = User::where('role_id', 2)
                ->with(['company', 'class']);
            
            if ($request->class_id) {
                $query->where('class_id', $request->class_id);
            }
            
            if ($request->company_id) {
                $query->where('company_id', $request->company_id);
            }
            
            $students = $query->get();
            
            $result = [];
            foreach ($students as $student) {
                $logbookCount = Logbook::where('user_id', $student->id)->count();
                $progress = min(100, round(($logbookCount / 30) * 100));
                $avgGrade = Logbook::where('user_id', $student->id)->avg('grade');
                
                $result[] = [
                    'id' => $student->id,
                    'nisn' => $student->nisn,
                    'name' => $student->name,
                    'class' => $student->class,
                    'company' => $student->company,
                    'logbook_count' => $logbookCount,
                    'progress' => $progress,
                    'avg_grade' => $avgGrade ? round($avgGrade, 2) : 0,
                ];
            }
            
            return response()->json($result);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
    
    public function attendance(Request $request)
    {
        try {
            $query = Attendance::with(['user', 'user.company', 'user.class'])  // ← TAMBAHKAN RELASI
                ->whereBetween('date', [$request->start_date ?? '2026-01-01', $request->end_date ?? Carbon::now()]);
            
            if ($request->status) {
                $query->where('status', $request->status);
            }
            
            $attendances = $query->orderBy('date', 'desc')->get();
            
            // Format response dengan data lengkap
            $formattedData = $attendances->map(function($attendance) {
                return [
                    'id' => $attendance->id,
                    'date' => $attendance->date,
                    'check_in' => $attendance->check_in,
                    'check_out' => $attendance->check_out,
                    'status' => $attendance->status,
                    'notes' => $attendance->notes,
                    'user' => $attendance->user ? [
                        'id' => $attendance->user->id,
                        'name' => $attendance->user->name,
                        'nisn' => $attendance->user->nisn,
                        'kelas' => $attendance->user->kelas,
                        'email' => $attendance->user->email,
                    ] : null,
                    'company' => $attendance->user && $attendance->user->company ? [
                        'id' => $attendance->user->company->id,
                        'name' => $attendance->user->company->name,
                        'address' => $attendance->user->company->address,
                    ] : null,
                    'class' => $attendance->user && $attendance->user->class ? [
                        'id' => $attendance->user->class->id,
                        'name' => $attendance->user->class->name,
                        'jurusan' => $attendance->user->class->jurusan,
                    ] : null,
                ];
            });
            
            return response()->json([
                'success' => true,
                'data' => $formattedData
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
    
   public function logbook(Request $request)
{
    try {
        // Load relasi user beserta company dan class
        $query = Logbook::with(['user', 'user.company', 'user.class'])
            ->whereBetween('date', [$request->start_date ?? '2026-01-01', $request->end_date ?? Carbon::now()]);
        
        if ($request->status) {
            $query->where('status', $request->status);
        }
        
        $logbooks = $query->orderBy('date', 'desc')->get();
        
        // Format response dengan data lengkap termasuk kelas
        $formattedData = $logbooks->map(function($logbook) {
            return [
                'id' => $logbook->id,
                'date' => $logbook->date,
                'activity' => $logbook->activity,
                'description' => $logbook->description,
                'status' => $logbook->status,
                'grade' => $logbook->grade,
                'feedback' => $logbook->feedback,
                'attachment' => $logbook->attachment,
                'created_at' => $logbook->created_at,
                'user' => $logbook->user ? [
                    'id' => $logbook->user->id,
                    'name' => $logbook->user->name,
                    'nisn' => $logbook->user->nisn,
                    // Ambil kelas dari relasi class atau langsung dari field kelas
                    'kelas' => $logbook->user->class ? $logbook->user->class->name : ($logbook->user->kelas ?? '-'),
                    'email' => $logbook->user->email,
                    'phone' => $logbook->user->phone,
                ] : null,
                'company' => $logbook->user && $logbook->user->company ? [
                    'id' => $logbook->user->company->id,
                    'name' => $logbook->user->company->name,
                    'address' => $logbook->user->company->address,
                ] : null,
                'class' => $logbook->user && $logbook->user->class ? [
                    'id' => $logbook->user->class->id,
                    'name' => $logbook->user->class->name,
                    'jurusan' => $logbook->user->class->jurusan,
                ] : null,
            ];
        });
        
        return response()->json([
            'success' => true,
            'data' => $formattedData
        ]);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
}

    public function show($id)
    {
        try {
            $student = User::where('role_id', 2)
                ->with(['company', 'class'])
                ->findOrFail($id);
            
            // Recent logbooks
            $recentLogbooks = Logbook::where('user_id', $student->id)
                ->orderBy('date', 'desc')
                ->limit(5)
                ->get();
            
            // Logbook count
            $logbookCount = Logbook::where('user_id', $student->id)->count();
            
            // Rata-rata nilai
            $avgGrade = Logbook::where('user_id', $student->id)->avg('grade');
            
            return response()->json([
                'id' => $student->id,
                'nisn' => $student->nisn,
                'name' => $student->name,
                'class' => $student->class,
                'company' => $student->company,
                'logbook_count' => $logbookCount,
                'avg_grade' => $avgGrade ? round($avgGrade, 2) : 0,
                'recent_logbooks' => $recentLogbooks,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error: ' . $e->getMessage()
            ], 500);
        }
    }
}