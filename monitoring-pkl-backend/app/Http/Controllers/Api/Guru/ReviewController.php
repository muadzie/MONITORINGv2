<?php

namespace App\Http\Controllers\Api\Guru;

use App\Http\Controllers\Controller;
use App\Models\Logbook;
use App\Models\User;
use App\Models\Placement;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ReviewController extends Controller
{
    public function index()
    {
        $user = auth()->user();
        
        // Ambil semua siswa yang dibimbing oleh guru ini
        $studentIds = User::where('teacher_id', $user->id)->pluck('id');
        
        // Ambil semua logbook dari siswa-siswa tersebut
        $logbooks = Logbook::whereIn('user_id', $studentIds)
            ->with(['user', 'user.company']) // Tambahkan relasi company
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function($logbook) {
                return [
                    'id' => $logbook->id,
                    'student' => [
                        'id' => $logbook->user->id,
                        'name' => $logbook->user->name,
                        'nisn' => $logbook->user->nisn,
                        'company' => $logbook->user->company ? [
                            'id' => $logbook->user->company->id,
                            'name' => $logbook->user->company->name,
                        ] : null,
                    ],
                    'date' => $logbook->date,
                    'activity' => $logbook->activity,
                    'description' => $logbook->description,
                    'attachment' => $logbook->attachment,
                    'attachment_url' => $logbook->attachment ? Storage::url($logbook->attachment) : null,
                    'status' => $logbook->status,
                    'grade' => $logbook->grade,
                    'feedback' => $logbook->feedback,
                    'company' => $logbook->user->company ? [
                        'id' => $logbook->user->company->id,
                        'name' => $logbook->user->company->name,
                    ] : null,
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
        
        $studentIds = User::where('teacher_id', $user->id)->pluck('id');
        
        $logbooks = Logbook::whereIn('user_id', $studentIds)
            ->where('status', 'pending')
            ->with(['user', 'user.company']) // Tambahkan relasi company
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function($logbook) {
                return [
                    'id' => $logbook->id,
                    'student' => [
                        'id' => $logbook->user->id,
                        'name' => $logbook->user->name,
                        'nisn' => $logbook->user->nisn,
                        'company' => $logbook->user->company ? [
                            'id' => $logbook->user->company->id,
                            'name' => $logbook->user->company->name,
                        ] : null,
                    ],
                    'date' => $logbook->date,
                    'activity' => $logbook->activity,
                    'description' => $logbook->description,
                    'attachment' => $logbook->attachment,
                    'attachment_url' => $logbook->attachment ? Storage::url($logbook->attachment) : null,
                    'status' => $logbook->status,
                    'company' => $logbook->user->company ? [
                        'id' => $logbook->user->company->id,
                        'name' => $logbook->user->company->name,
                    ] : null,
                    'created_at' => $logbook->created_at,
                ];
            });
        
        return response()->json([
            'success' => true,
            'data' => $logbooks
        ]);
    }
    
    public function approve(Request $request, $id)
    {
        try {
            $logbook = Logbook::findOrFail($id);
            $logbook->status = 'approved';
            
            if ($request->has('notes')) {
                $logbook->feedback = $request->notes;
            }
            
            $logbook->save();
            
            return response()->json([
                'success' => true,
                'message' => 'Logbook berhasil disetujui'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal menyetujui: ' . $e->getMessage()
            ], 500);
        }
    }
    
    public function reject(Request $request, $id)
    {
        try {
            $request->validate([
                'notes' => 'required|string'
            ]);
            
            $logbook = Logbook::findOrFail($id);
            $logbook->status = 'rejected';
            $logbook->feedback = $request->notes;
            $logbook->save();
            
            return response()->json([
                'success' => true,
                'message' => 'Logbook ditolak'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal menolak: ' . $e->getMessage()
            ], 500);
        }
    }
}