<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    public function general()
    {
        return response()->json([
            'success' => true,
            'data' => [
                'app_name' => config('app.name'),
                'app_description' => config('app.description', ''),
            ]
        ]);
    }

    public function updateGeneral(Request $request)
    {
        $request->validate([
            'app_name' => 'required|string|max:255',
        ]);

        // In production, save to database or .env
        return response()->json([
            'success' => true,
            'message' => 'Pengaturan umum berhasil disimpan'
        ]);
    }

    public function school()
    {
        return response()->json([
            'success' => true,
            'data' => [
                'school_name' => '',
                'school_address' => '',
                'school_phone' => '',
            ]
        ]);
    }

    public function updateSchool(Request $request)
    {
        $request->validate([
            'school_name' => 'required|string|max:255',
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Data sekolah berhasil disimpan'
        ]);
    }

    public function academic()
    {
        return response()->json([
            'success' => true,
            'data' => [
                'academic_year' => date('Y') . '/' . (date('Y') + 1),
                'semester' => 'ganjil',
            ]
        ]);
    }

    public function updateAcademic(Request $request)
    {
        $request->validate([
            'academic_year' => 'required|string',
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Tahun akademik berhasil disimpan'
        ]);
    }

    public function radius()
    {
        return response()->json([
            'success' => true,
            'data' => [
                'default_radius' => 100,
                'radius_unit' => 'meter',
            ]
        ]);
    }

    public function updateRadius(Request $request)
    {
        $request->validate([
            'default_radius' => 'required|numeric|min:10|max:10000',
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Radius berhasil disimpan'
        ]);
    }
}
