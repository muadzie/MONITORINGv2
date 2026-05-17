<?php

namespace App\Http\Controllers\Api\Siswa;

use App\Http\Controllers\Controller;
use App\Models\Report;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        
        $report = Report::where('user_id', $user->id)->latest()->first();
        
        if ($report) {
            $report->file_url = asset('storage/' . $report->file_path);
            return response()->json($report);
        }
        
        return response()->json(null, 200);
    }

    public function upload(Request $request)
    {
        try {
            // Validasi dengan pesan custom
            $validator = \Illuminate\Support\Facades\Validator::make($request->all(), [
                'report' => 'required|file|mimes:pdf,doc,docx|max:10240'
            ], [
                'report.required' => 'File laporan wajib diupload',
                'report.file' => 'File tidak valid',
                'report.mimes' => 'Format file harus PDF, DOC, atau DOCX',
                'report.max' => 'Ukuran file maksimal 10MB'
            ]);
            
            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validasi gagal',
                    'errors' => $validator->errors()
                ], 422);
            }

            $user = $request->user();
            $file = $request->file('report');
            
            // Hapus laporan lama
            $oldReport = Report::where('user_id', $user->id)->first();
            if ($oldReport) {
                if (Storage::disk('public')->exists($oldReport->file_path)) {
                    Storage::disk('public')->delete($oldReport->file_path);
                }
                $oldReport->delete();
            }

            $fileName = 'report_' . $user->id . '_' . time() . '.' . $file->guessExtension();
            $filePath = $file->storeAs('reports', $fileName, 'public');
            
            $report = Report::create([
                'user_id' => $user->id,
                'file_path' => $filePath,
                'file_name' => $file->getClientOriginalName(),
                'file_size' => $file->getSize(),
                'status' => 'pending'
            ]);

            $report->file_url = asset('storage/' . $filePath);
            
            return response()->json([
                'success' => true,
                'message' => 'Laporan berhasil diupload',
                'data' => $report
            ], 201);
            
        } catch (\Exception $e) {
            \Log::error('Upload error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat mengupload laporan'
            ], 500);
        }
    }

    public function delete(Request $request)
    {
        $user = $request->user();
        $report = Report::where('user_id', $user->id)->first();
        
        if ($report) {
            if (Storage::disk('public')->exists($report->file_path)) {
                Storage::disk('public')->delete($report->file_path);
            }
            $report->delete();
        }
        
        return response()->json([
            'success' => true,
            'message' => 'Laporan berhasil dihapus'
        ]);
    }
}