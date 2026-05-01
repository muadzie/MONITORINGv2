<?php
// app/Http/Controllers/Api/Admin/TeacherController.php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class TeacherController extends Controller
{
    public function index()
    {
        $teachers = User::where('role_id', 3)
            ->select('id', 'name', 'email', 'nip', 'phone', 'mata_pelajaran', 'created_at')
            ->withCount('students') // students() dari supervisedStudents
            ->orderBy('name')
            ->get();
        
        // Format response yang konsisten
        return response()->json([
            'success' => true,
            'data' => $teachers,
            'message' => 'Teachers retrieved successfully'
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|min:6',
            'nip' => 'nullable|string|unique:users,nip',
            'phone' => 'nullable|string',
            'mata_pelajaran' => 'nullable|string',
        ]);

        $teacher = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'nip' => $request->nip,
            'phone' => $request->phone,
            'mata_pelajaran' => $request->mata_pelajaran,
            'role_id' => 3, // role guru
        ]);

        return response()->json([
            'success' => true,
            'data' => $teacher,
            'message' => 'Teacher created successfully'
        ], 201);
    }

    public function show($id)
    {
        $teacher = User::where('role_id', 3)->with('students')->findOrFail($id);
        
        return response()->json([
            'success' => true,
            'data' => $teacher
        ]);
    }

    public function update(Request $request, $id)
    {
        $teacher = User::where('role_id', 3)->findOrFail($id);
        
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email,' . $id,
            'nip' => 'nullable|string|unique:users,nip,' . $id,
            'phone' => 'nullable|string',
            'mata_pelajaran' => 'nullable|string',
        ]);

        $updateData = [
            'name' => $request->name,
            'email' => $request->email,
            'nip' => $request->nip,
            'phone' => $request->phone,
            'mata_pelajaran' => $request->mata_pelajaran,
        ];

        if ($request->filled('password')) {
            $request->validate(['password' => 'min:6']);
            $updateData['password'] = Hash::make($request->password);
        }

        $teacher->update($updateData);

        return response()->json([
            'success' => true,
            'data' => $teacher,
            'message' => 'Teacher updated successfully'
        ]);
    }

    public function destroy($id)
    {
        $teacher = User::where('role_id', 3)->findOrFail($id);
        
        // Cek apakah guru memiliki siswa bimbingan
        $studentCount = User::where('teacher_id', $id)->count();
        
        if ($studentCount > 0) {
            return response()->json([
                'success' => false,
                'message' => 'Guru tidak dapat dihapus karena masih memiliki ' . $studentCount . ' siswa bimbingan'
            ], 400);
        }
        
        $teacher->delete();
        
        return response()->json([
            'success' => true,
            'message' => 'Teacher deleted successfully'
        ]);
    }
    
    // Opsional: get teacher options untuk dropdown
    public function options()
    {
        $teachers = User::where('role_id', 3)
            ->where('is_active', true)
            ->select('id', 'name', 'nip', 'mata_pelajaran')
            ->orderBy('name')
            ->get();
        
        return response()->json([
            'success' => true,
            'data' => $teachers
        ]);
    }
}