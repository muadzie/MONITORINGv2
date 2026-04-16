<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Company;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class StudentController extends Controller
{
    public function index()
    {
        $students = User::where('role_id', 2)->with('company')->get();
        return response()->json($students);
    }

    public function store(Request $request)
    {
        $student = User::create([
            'nisn' => $request->nisn,
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role_id' => 2,
            'company_id' => $request->company_id,
            'phone' => $request->phone,
        ]);
        return response()->json($student);
    }

    public function update(Request $request, $id)
    {
        $student = User::findOrFail($id);
        $student->update($request->only('nisn', 'name', 'email', 'company_id', 'phone'));
        if ($request->filled('password')) {
            $student->password = Hash::make($request->password);
            $student->save();
        }
        return response()->json($student);
    }

    public function destroy($id)
    {
        User::destroy($id);
        return response()->json(['message' => 'Student deleted']);
    }
}