<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Company;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class StudentController extends Controller
{
    public function index()
    {
        $students = User::where('role_id', 2) // role siswa
            ->with(['company', 'class', 'teacher']) // Tambahkan relasi teacher
            ->select('id', 'name', 'email', 'nisn', 'class_id', 'phone', 'company_id', 'teacher_id', 'created_at', 'is_active')
            ->orderBy('name')
            ->get();
        
        // Format response agar lebih rapi
        $formattedStudents = $students->map(function($student) {
            return [
                'id' => $student->id,
                'nisn' => $student->nisn,
                'name' => $student->name,
                'email' => $student->email,
                'phone' => $student->phone,
                'company_id' => $student->company_id,
                'company' => $student->company ? [
                    'id' => $student->company->id,
                    'name' => $student->company->name
                ] : null,
                'teacher_id' => $student->teacher_id,
                'teacher' => $student->teacher ? [
                    'id' => $student->teacher->id,
                    'name' => $student->teacher->name,
                    'email' => $student->teacher->email,
                    'nip' => $student->teacher->nip,
                    'mata_pelajaran' => $student->teacher->mata_pelajaran
                ] : null,
                'class_id' => $student->class_id,
                'class' => $student->class ? [
                    'id' => $student->class->id,
                    'name' => $student->class->name
                ] : null,
                'is_active' => $student->is_active ?? true,
                'created_at' => $student->created_at
            ];
        });
        
        return response()->json([
            'success' => true,
            'data' => $formattedStudents,
            'message' => 'Students retrieved successfully'
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'nisn' => 'required|string|unique:users,nisn',
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|min:6',
            'phone' => 'nullable|string',
            'company_id' => 'nullable|exists:companies,id',
            'teacher_id' => 'nullable|exists:users,id', // Validasi teacher_id
            'class_id' => 'nullable|exists:classes,id',
            'kelas' => 'nullable|string',
            'jurusan' => 'nullable|string',
        ]);

        $student = User::create([
            'nisn' => $request->nisn,
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'phone' => $request->phone,
            'company_id' => $request->company_id,
            'teacher_id' => $request->teacher_id, // Tambahkan teacher_id
            'class_id' => $request->class_id,
            'kelas' => $request->kelas,
            'jurusan' => $request->jurusan,
            'role_id' => 2, // role siswa
            'is_active' => true
        ]);

        // Load relasi untuk response
        $student->load(['company', 'teacher', 'class']);

        return response()->json([
            'success' => true,
            'data' => [
                'id' => $student->id,
                'nisn' => $student->nisn,
                'name' => $student->name,
                'email' => $student->email,
                'phone' => $student->phone,
                'company_id' => $student->company_id,
                'company' => $student->company ? ['id' => $student->company->id, 'name' => $student->company->name] : null,
                'teacher_id' => $student->teacher_id,
                'teacher' => $student->teacher ? ['id' => $student->teacher->id, 'name' => $student->teacher->name] : null,
                'class_id' => $student->class_id,
                'is_active' => $student->is_active,
            ],
            'message' => 'Student created successfully'
        ], 201);
    }

    public function show($id)
    {
        $student = User::where('role_id', 2)
            ->with(['company', 'teacher', 'class'])
            ->findOrFail($id);
        
        return response()->json([
            'success' => true,
            'data' => [
                'id' => $student->id,
                'nisn' => $student->nisn,
                'name' => $student->name,
                'email' => $student->email,
                'phone' => $student->phone,
                'kelas' => $student->kelas,
                'jurusan' => $student->jurusan,
                'company_id' => $student->company_id,
                'company' => $student->company ? ['id' => $student->company->id, 'name' => $student->company->name] : null,
                'teacher_id' => $student->teacher_id,
                'teacher' => $student->teacher ? [
                    'id' => $student->teacher->id,
                    'name' => $student->teacher->name,
                    'nip' => $student->teacher->nip,
                    'mata_pelajaran' => $student->teacher->mata_pelajaran
                ] : null,
                'class_id' => $student->class_id,
                'is_active' => $student->is_active,
            ]
        ]);
    }

    public function update(Request $request, $id)
    {
        $student = User::where('role_id', 2)->findOrFail($id);
        
        $request->validate([
            'nisn' => 'required|string|unique:users,nisn,' . $id,
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email,' . $id,
            'phone' => 'nullable|string',
            'company_id' => 'nullable|exists:companies,id',
            'teacher_id' => 'nullable|exists:users,id', // Validasi teacher_id
            'class_id' => 'nullable|exists:classes,id',
            'kelas' => 'nullable|string',
            'jurusan' => 'nullable|string',
        ]);

        $updateData = [
            'nisn' => $request->nisn,
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'company_id' => $request->company_id,
            'teacher_id' => $request->teacher_id, // Tambahkan teacher_id
            'class_id' => $request->class_id,
            'kelas' => $request->kelas,
            'jurusan' => $request->jurusan,
        ];

        if ($request->filled('password')) {
            $request->validate(['password' => 'min:6']);
            $updateData['password'] = Hash::make($request->password);
        }

        $student->update($updateData);

        // Load relasi untuk response
        $student->load(['company', 'teacher', 'class']);

        return response()->json([
            'success' => true,
            'data' => [
                'id' => $student->id,
                'nisn' => $student->nisn,
                'name' => $student->name,
                'email' => $student->email,
                'phone' => $student->phone,
                'company_id' => $student->company_id,
                'company' => $student->company ? ['id' => $student->company->id, 'name' => $student->company->name] : null,
                'teacher_id' => $student->teacher_id,
                'teacher' => $student->teacher ? ['id' => $student->teacher->id, 'name' => $student->teacher->name] : null,
                'class_id' => $student->class_id,
                'kelas' => $student->kelas,
                'jurusan' => $student->jurusan,
                'is_active' => $student->is_active,
            ],
            'message' => 'Student updated successfully'
        ]);
    }

    public function destroy($id)
    {
        $student = User::where('role_id', 2)->findOrFail($id);
        
        // Cek apakah siswa memiliki data terkait
        $hasAttendances = $student->attendances()->count() > 0;
        $hasLogbooks = $student->logbooks()->count() > 0;
        $hasPermissions = $student->permissions()->count() > 0;
        $hasReports = $student->finalReports()->count() > 0;
        
        if ($hasAttendances || $hasLogbooks || $hasPermissions || $hasReports) {
            return response()->json([
                'success' => false,
                'message' => 'Siswa tidak dapat dihapus karena sudah memiliki data aktivitas (absensi, logbook, izin, atau laporan)'
            ], 400);
        }
        
        // Hapus user
        $studentName = $student->name;
        $student->delete();
        
        return response()->json([
            'success' => true,
            'message' => "Siswa '{$studentName}' berhasil dihapus"
        ]);
    }

    /**
     * Get statistics for students
     */
    public function stats()
    {
        $totalStudents = User::where('role_id', 2)->count();
        $activeStudents = User::where('role_id', 2)->where('is_active', true)->count();
        $placedStudents = User::where('role_id', 2)->whereNotNull('company_id')->count();
        $unplacedStudents = User::where('role_id', 2)->whereNull('company_id')->count();
        
        return response()->json([
            'success' => true,
            'data' => [
                'total' => $totalStudents,
                'active' => $activeStudents,
                'placed' => $placedStudents,
                'unplaced' => $unplacedStudents,
                'inactive' => $totalStudents - $activeStudents
            ]
        ]);
    }
}