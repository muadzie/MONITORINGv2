<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class TeacherController extends Controller
{
    public function index()
    {
        $teachers = User::where('role_id', 3)->get();
        return response()->json($teachers);
    }

    public function store(Request $request)
    {
        $teacher = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role_id' => 3,
            'phone' => $request->phone,
            'nip' => $request->nip,
        ]);
        return response()->json($teacher);
    }

    public function update(Request $request, $id)
    {
        $teacher = User::findOrFail($id);
        $teacher->update($request->only('name', 'email', 'phone', 'nip'));
        if ($request->filled('password')) {
            $teacher->password = Hash::make($request->password);
            $teacher->save();
        }
        return response()->json($teacher);
    }

    public function destroy($id)
    {
        User::destroy($id);
        return response()->json(['message' => 'Teacher deleted']);
    }
}