<?php

namespace App\Http\Controllers\Api\Siswa;

use App\Http\Controllers\Controller;
use App\Models\Logbook;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class LogbookController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        
        $logbooks = Logbook::where('user_id', $user->id)
            ->orderBy('date', 'desc')
            ->orderBy('created_at', 'desc')
            ->get();
        
        return response()->json([
            'success' => true,
            'data' => $logbooks
        ]);
    }
    
    public function recent(Request $request)
    {
        $user = $request->user();
        
        $logbooks = Logbook::where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->take(5)
            ->get();
        
        return response()->json([
            'success' => true,
            'data' => $logbooks
        ]);
    }
    
    public function store(Request $request)
    {
        $request->validate([
            'date' => 'required|date',
            'activity' => 'required|string',
            'description' => 'nullable|string',
            'attachment' => 'nullable|file|mimes:jpg,jpeg,png,pdf,doc,docx|max:5120'
        ]);
        
        $user = $request->user();
        
        // Cek apakah sudah ada logbook untuk tanggal ini
        $existing = Logbook::where('user_id', $user->id)
            ->where('date', $request->date)
            ->first();
        
        if ($existing) {
            return response()->json([
                'success' => false,
                'message' => 'Logbook untuk tanggal ini sudah ada'
            ], 400);
        }
        
        $attachmentPath = null;
        if ($request->hasFile('attachment')) {
            $file = $request->file('attachment');
            $fileName = 'logbook_' . $user->id . '_' . time() . '.' . $file->getClientOriginalExtension();
            $attachmentPath = $file->storeAs('logbooks', $fileName, 'public');
        }
        
        $logbook = Logbook::create([
            'user_id' => $user->id,
            'date' => $request->date,
            'activity' => $request->activity,
            'description' => $request->description,
            'attachment' => $attachmentPath,
            'status' => 'pending'
        ]);
        
        return response()->json([
            'success' => true,
            'message' => 'Logbook berhasil ditambahkan',
            'data' => $logbook
        ], 201);
    }
    
    public function show($id)
    {
        $logbook = Logbook::findOrFail($id);
        
        // Cek kepemilikan
        if ($logbook->user_id != auth()->id()) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 403);
        }
        
        return response()->json([
            'success' => true,
            'data' => $logbook
        ]);
    }
    
    public function update(Request $request, $id)
    {
        $logbook = Logbook::findOrFail($id);
        
        // Cek kepemilikan
        if ($logbook->user_id != auth()->id()) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 403);
        }
        
        // Cek status apakah sudah direview
        if ($logbook->status !== 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'Logbook sudah direview, tidak dapat diubah'
            ], 400);
        }
        
        $request->validate([
            'date' => 'required|date',
            'activity' => 'required|string',
            'description' => 'nullable|string',
            'attachment' => 'nullable|file|mimes:jpg,jpeg,png,pdf,doc,docx|max:5120'
        ]);
        
        if ($request->hasFile('attachment')) {
            // Hapus file lama
            if ($logbook->attachment && Storage::disk('public')->exists($logbook->attachment)) {
                Storage::disk('public')->delete($logbook->attachment);
            }
            
            $file = $request->file('attachment');
            $fileName = 'logbook_' . auth()->id() . '_' . time() . '.' . $file->getClientOriginalExtension();
            $attachmentPath = $file->storeAs('logbooks', $fileName, 'public');
            $logbook->attachment = $attachmentPath;
        }
        
        $logbook->date = $request->date;
        $logbook->activity = $request->activity;
        $logbook->description = $request->description;
        $logbook->save();
        
        return response()->json([
            'success' => true,
            'message' => 'Logbook berhasil diupdate',
            'data' => $logbook
        ]);
    }
    
    public function destroy($id)
    {
        $logbook = Logbook::findOrFail($id);
        
        // Cek kepemilikan
        if ($logbook->user_id != auth()->id()) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 403);
        }
        
        // Cek status apakah sudah direview
        if ($logbook->status !== 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'Logbook sudah direview, tidak dapat dihapus'
            ], 400);
        }
        
        // Hapus file attachment
        if ($logbook->attachment && Storage::disk('public')->exists($logbook->attachment)) {
            Storage::disk('public')->delete($logbook->attachment);
        }
        
        $logbook->delete();
        
        return response()->json([
            'success' => true,
            'message' => 'Logbook berhasil dihapus'
        ]);
    }
}