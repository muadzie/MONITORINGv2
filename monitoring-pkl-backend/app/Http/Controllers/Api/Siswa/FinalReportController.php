<?php

namespace App\Http\Controllers\Api\Siswa;

use App\Http\Controllers\Controller;
use App\Models\FinalReport;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class FinalReportController extends Controller
{
    public function index(Request $request)
    {
        $report = FinalReport::where('student_id', $request->user()->id)->latest()->first();

        return response()->json([
            'success' => true,
            'data' => $report
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'abstract' => 'nullable|string',
            'file' => 'required|file|mimes:pdf,doc,docx|max:10240',
        ]);

        $file = $request->file('file');
        $extension = $file->guessExtension();
        $path = $file->storeAs('final-reports', uniqid() . '.' . $extension, 'public');

        $report = FinalReport::updateOrCreate(
            ['student_id' => $request->user()->id],
            [
                'title' => $request->title,
                'abstract' => $request->abstract,
                'file_path' => $path,
                'file_name' => $file->getClientOriginalName(),
                'status' => 'submitted',
                'submitted_at' => now(),
            ]
        );

        return response()->json([
            'success' => true,
            'message' => 'Laporan akhir berhasil diupload',
            'data' => $report
        ]);
    }

    public function show($id)
    {
        $report = FinalReport::where('student_id', auth()->id())->findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => $report
        ]);
    }

    public function destroy($id)
    {
        $report = FinalReport::where('student_id', auth()->id())->findOrFail($id);

        if ($report->file_path) {
            Storage::disk('public')->delete($report->file_path);
        }

        $report->delete();

        return response()->json([
            'success' => true,
            'message' => 'Laporan berhasil dihapus'
        ]);
    }
}
