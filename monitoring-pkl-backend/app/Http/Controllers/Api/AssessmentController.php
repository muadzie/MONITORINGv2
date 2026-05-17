<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Assessment;
use Illuminate\Http\Request;

class AssessmentController extends Controller
{
    public function index()
    {
        $assessments = Assessment::with(['student', 'assessor'])->get();
        return response()->json(['success' => true, 'data' => $assessments]);
    }

    public function myAssessments(Request $request)
    {
        $user = $request->user();
        $assessments = Assessment::where('student_id', $user->id)
            ->with('assessor')
            ->get();
        return response()->json(['success' => true, 'data' => $assessments]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'student_id' => 'required|exists:users,id',
            'attendance_score' => 'nullable|integer|min:0|max:100',
            'logbook_score' => 'nullable|integer|min:0|max:100',
            'report_score' => 'nullable|integer|min:0|max:100',
            'attitude_score' => 'nullable|integer|min:0|max:100',
            'performance_score' => 'nullable|integer|min:0|max:100',
            'discipline_score' => 'nullable|integer|min:0|max:100',
            'final_score' => 'nullable|numeric|min:0|max:100',
            'notes' => 'nullable|string',
        ]);

        $validated['assessor_id'] = $request->user()->id;
        $validated['assessor_type'] = 'guru';

        $assessment = Assessment::create($validated);
        return response()->json(['success' => true, 'data' => $assessment], 201);
    }

    public function show($id)
    {
        $assessment = Assessment::with(['student', 'assessor'])->findOrFail($id);
        return response()->json(['success' => true, 'data' => $assessment]);
    }

    public function update(Request $request, $id)
    {
        $assessment = Assessment::findOrFail($id);

        $validated = $request->validate([
            'attendance_score' => 'nullable|integer|min:0|max:100',
            'logbook_score' => 'nullable|integer|min:0|max:100',
            'report_score' => 'nullable|integer|min:0|max:100',
            'attitude_score' => 'nullable|integer|min:0|max:100',
            'performance_score' => 'nullable|integer|min:0|max:100',
            'discipline_score' => 'nullable|integer|min:0|max:100',
            'final_score' => 'nullable|numeric|min:0|max:100',
            'notes' => 'nullable|string',
        ]);

        $assessment->update($validated);
        return response()->json(['success' => true, 'data' => $assessment]);
    }

    public function destroy($id)
    {
        $assessment = Assessment::findOrFail($id);
        $assessment->delete();
        return response()->json(['success' => true, 'message' => 'Assessment deleted']);
    }
}
