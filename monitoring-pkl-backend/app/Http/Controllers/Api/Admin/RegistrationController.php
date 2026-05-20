<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Notification;
use Illuminate\Http\Request;

class RegistrationController extends Controller
{
    // Daftar pendaftaran pending
    public function index()
    {
        $registrations = User::with('role')
            ->where('registration_status', 'pending')
            ->where('is_active', false)
            ->get();
        
        return response()->json($registrations);
    }

    // Daftar pendaftaran yang sudah diproses
    public function history()
    {
        $registrations = User::with('role')
            ->whereIn('registration_status', ['approved', 'rejected'])
            ->orderBy('updated_at', 'desc')
            ->get();
        
        return response()->json($registrations);
    }

    // Approve pendaftaran
    public function approve($id)
    {
        $user = User::findOrFail($id);
        $user->update([
            'registration_status' => 'approved',
            'is_active' => true,
            'approved_by' => auth()->id(),
            'approved_at' => now()
        ]);

        // Kirim notifikasi ke user
        sendNotification(
            $user->id,
            'Pendaftaran Disetujui',
            'Pendaftaran Anda telah disetujui. Silakan login ke sistem.',
            'success',
            '/login'
        );

        return response()->json(['message' => 'Pendaftaran disetujui']);
    }

    // Reject pendaftaran
    public function reject(Request $request, $id)
    {
        $request->validate([
            'reason' => 'required|string'
        ]);

        $user = User::findOrFail($id);
        $user->update([
            'registration_status' => 'rejected',
            'is_active' => false,
            'rejection_reason' => $request->reason,
            'approved_by' => auth()->id(),
            'approved_at' => now()
        ]);

        // Kirim notifikasi ke user
        sendNotification(
            $user->id,
            'Pendaftaran Ditolak',
            "Pendaftaran Anda ditolak. Alasan: {$request->reason}",
            'error',
            '/register'
        );

        return response()->json(['message' => 'Pendaftaran ditolak']);
    }

    // Hapus semua riwayat (hanya user yang ditolak)
    public function clearHistory()
    {
        $deleted = User::where('registration_status', 'rejected')->delete();

        return response()->json([
            'message' => "{$deleted} riwayat pendaftaran berhasil dihapus"
        ]);
    }
}