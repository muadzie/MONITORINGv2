<?php

namespace App\Http\Controllers\Api\Perusahaan;

use App\Http\Controllers\Controller;
use App\Models\Logbook;
use App\Models\User;
use App\Models\Placement;
use Illuminate\Http\Request;

class AssessmentController extends Controller
{
    public function index()
    {
        $user = auth()->user();
        $companyId = $user->company_id;
        
        // Ambil semua siswa yang magang di perusahaan ini
        $studentIds = Placement::where('company_id', $companyId)
            ->where('status', 'active')
            ->pluck('student_id');
        
        // Ambil semua logbook dari siswa-siswa tersebut
        $logbooks = Logbook::whereIn('user_id', $studentIds)
            ->with('user')
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function($logbook) {
                return [
                    'id' => $logbook->id,
                    'student_id' => $logbook->user_id,
                    'student' => [
                        'id' => $logbook->user->id,
                        'name' => $logbook->user->name,
                        'nisn' => $logbook->user->nisn,
                    ],
                    'date' => $logbook->date,
                    'activity' => $logbook->activity,
                    'description' => $logbook->description,
                    'attachment' => $logbook->attachment,
                    'attachment_url' => $logbook->attachment ? asset('storage/' . $logbook->attachment) : null,
                    'grade' => $logbook->grade,
                    'feedback' => $logbook->feedback,
                    'created_at' => $logbook->created_at,
                ];
            });
        
        return response()->json([
            'success' => true,
            'data' => $logbooks
        ]);
    }
    
    public function pending()
    {
        $user = auth()->user();
        $companyId = $user->company_id;
        
        $studentIds = Placement::where('company_id', $companyId)
            ->where('status', 'active')
            ->pluck('student_id');
        
        $logbooks = Logbook::whereIn('user_id', $studentIds)
            ->whereNull('grade')
            ->with('user')
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function($logbook) {
                return [
                    'id' => $logbook->id,
                    'student_id' => $logbook->user_id,
                    'student' => [
                        'id' => $logbook->user->id,
                        'name' => $logbook->user->name,
                        'nisn' => $logbook->user->nisn,
                    ],
                    'date' => $logbook->date,
                    'activity' => $logbook->activity,
                    'description' => $logbook->description,
                    'attachment' => $logbook->attachment,
                    'attachment_url' => $logbook->attachment ? asset('storage/' . $logbook->attachment) : null,
                    'created_at' => $logbook->created_at,
                ];
            });
        
        return response()->json([
            'success' => true,
            'data' => $logbooks
        ]);
    }
    
    public function show($id)
    {
        $logbook = Logbook::with('user')->findOrFail($id);
        
        return response()->json([
            'success' => true,
            'data' => [
                'id' => $logbook->id,
                'student_id' => $logbook->user_id,
                'student' => [
                    'id' => $logbook->user->id,
                    'name' => $logbook->user->name,
                    'nisn' => $logbook->user->nisn,
                ],
                'date' => $logbook->date,
                'activity' => $logbook->activity,
                'description' => $logbook->description,
                'attachment' => $logbook->attachment,
                'attachment_url' => $logbook->attachment ? asset('storage/' . $logbook->attachment) : null,
                'grade' => $logbook->grade,
                'feedback' => $logbook->feedback,
            ]
        ]);
    }
    
    public function grade(Request $request, $id)
    {
        $request->validate([
            'grade' => 'required|integer|min:0|max:100',
            'feedback' => 'nullable|string'
        ]);
        
        $logbook = Logbook::findOrFail($id);
        $logbook->grade = $request->grade;
        $logbook->feedback = $request->feedback;
        $logbook->save();
        
        return response()->json([
            'success' => true,
            'message' => 'Penilaian berhasil disimpan'
        ]);
    }
    
    public function feedback(Request $request, $id)
    {
        $request->validate([
            'feedback' => 'required|string'
        ]);
        
        $logbook = Logbook::findOrFail($id);
        $logbook->feedback = $request->feedback;
        $logbook->save();
        
        return response()->json([
            'success' => true,
            'message' => 'Feedback berhasil disimpan'
        ]);
    }
}