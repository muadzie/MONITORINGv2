<?php

namespace App\Http\Controllers\Api\Siswa;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Placement;
use Illuminate\Http\Request;

class CompanyController extends Controller
{
    public function index()
    {
        $user = auth()->user();
        
        // Ambil penempatan aktif siswa
        $placement = Placement::where('student_id', $user->id)
            ->with(['company', 'teacher'])
            ->where('status', 'active')
            ->first();
        
        if (!$placement) {
            return response()->json([
                'company' => null,
                'guru_pembimbing' => null,
                'message' => 'Belum ada penempatan aktif'
            ]);
        }
        
        return response()->json([
            'company' => [
                'id' => $placement->company->id,
                'name' => $placement->company->name,
                'address' => $placement->company->address,
                'latitude' => $placement->company->latitude,
                'longitude' => $placement->company->longitude,
                'radius' => $placement->company->radius,
                'phone' => $placement->company->phone,
            ],
            'guru_pembimbing' => $placement->teacher ? [
                'id' => $placement->teacher->id,
                'name' => $placement->teacher->name,
                'email' => $placement->teacher->email,
                'phone' => $placement->teacher->phone,
                'mata_pelajaran' => $placement->teacher->mata_pelajaran,
            ] : null,
        ]);
    }
}