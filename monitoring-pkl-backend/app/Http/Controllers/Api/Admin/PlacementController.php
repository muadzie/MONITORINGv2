<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Company;
use App\Models\Placement;
use Illuminate\Http\Request;

class PlacementController extends Controller
{
    public function index()
    {
        $placements = Placement::with(['student', 'company'])->get();
        return response()->json($placements);
    }

    public function store(Request $request)
    {
        $placement = Placement::create($request->all());
        
        // Update user company_id
        User::where('id', $request->student_id)->update(['company_id' => $request->company_id]);
        
        return response()->json($placement);
    }

    public function update(Request $request, $id)
    {
        $placement = Placement::findOrFail($id);
        $placement->update($request->all());
        
        User::where('id', $placement->student_id)->update(['company_id' => $placement->company_id]);
        
        return response()->json($placement);
    }

    public function destroy($id)
    {
        Placement::destroy($id);
        return response()->json(['message' => 'Placement deleted']);
    }

    public function availableStudents()
    {
        $placedStudentIds = Placement::where('status', 'active')->pluck('student_id');
        $students = User::students()->whereNotIn('id', $placedStudentIds)->get();
        return response()->json($students);
    }
}