<?php

namespace App\Http\Controllers\Api\Siswa;

use App\Http\Controllers\Controller;
use App\Models\Permission;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PermissionController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        
        $permissions = Permission::where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->get();
        
        return response()->json([
            'success' => true,
            'data' => $permissions
        ]);
    }
    
    public function store(Request $request)
    {
        $request->validate([
            'date' => 'required|date',
            'type' => 'required|in:sick,permit',
            'reason' => 'required|string',
            'attachment' => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:5120'
        ]);
        
        $user = $request->user();
        
        // Cek apakah sudah ada izin untuk tanggal ini
        $existing = Permission::where('user_id', $user->id)
            ->where('date', $request->date)
            ->first();
        
        if ($existing) {
            return response()->json([
                'success' => false,
                'message' => 'Anda sudah mengajukan izin untuk tanggal ini'
            ], 400);
        }
        
        $attachmentPath = null;
        if ($request->hasFile('attachment')) {
            $file = $request->file('attachment');
            $fileName = 'permission_' . $user->id . '_' . time() . '.' . $file->getClientOriginalExtension();
            $attachmentPath = $file->storeAs('permissions', $fileName, 'public');
        }
        
        $permission = Permission::create([
            'user_id' => $user->id,
            'date' => $request->date,
            'type' => $request->type,
            'reason' => $request->reason,
            'attachment' => $attachmentPath,
            'status' => 'pending'
        ]);
        
        return response()->json([
            'success' => true,
            'message' => 'Pengajuan izin berhasil dikirim',
            'data' => $permission
        ], 201);
    }
    
    public function show($id)
    {
        $permission = Permission::findOrFail($id);
        
        if ($permission->user_id != auth()->id()) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 403);
        }
        
        return response()->json([
            'success' => true,
            'data' => $permission
        ]);
    }
    
    public function update(Request $request, $id)
    {
        $permission = Permission::findOrFail($id);
        
        if ($permission->user_id != auth()->id()) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 403);
        }
        
        if ($permission->status !== 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'Izin sudah diproses, tidak dapat diubah'
            ], 400);
        }
        
        $request->validate([
            'date' => 'required|date',
            'type' => 'required|in:sick,permit',
            'reason' => 'required|string',
            'attachment' => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:5120'
        ]);
        
        if ($request->hasFile('attachment')) {
            if ($permission->attachment && Storage::disk('public')->exists($permission->attachment)) {
                Storage::disk('public')->delete($permission->attachment);
            }
            
            $file = $request->file('attachment');
            $fileName = 'permission_' . auth()->id() . '_' . time() . '.' . $file->getClientOriginalExtension();
            $attachmentPath = $file->storeAs('permissions', $fileName, 'public');
            $permission->attachment = $attachmentPath;
        }
        
        $permission->date = $request->date;
        $permission->type = $request->type;
        $permission->reason = $request->reason;
        $permission->save();
        
        return response()->json([
            'success' => true,
            'message' => 'Izin berhasil diupdate',
            'data' => $permission
        ]);
    }
    
    public function destroy($id)
    {
        $permission = Permission::findOrFail($id);
        
        if ($permission->user_id != auth()->id()) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 403);
        }
        
        if ($permission->status !== 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'Izin sudah diproses, tidak dapat dihapus'
            ], 400);
        }
        
        if ($permission->attachment && Storage::disk('public')->exists($permission->attachment)) {
            Storage::disk('public')->delete($permission->attachment);
        }
        
        $permission->delete();
        
        return response()->json([
            'success' => true,
            'message' => 'Izin berhasil dihapus'
        ]);
    }
}