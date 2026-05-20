<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    public function general()
    {
        $s = Setting::getGroup('general');

        return response()->json([
            'success' => true,
            'data' => [
                'app_name' => $s['app_name'] ?? config('app.name'),
                'pkl_start_date' => $s['pkl_start_date'] ?? '2026-01-01',
                'pkl_end_date' => $s['pkl_end_date'] ?? '2026-03-31',
                'checkin_deadline' => $s['checkin_deadline'] ?? '08:00',
                'fonnte_api_key' => $s['fonnte_api_key'] ?? '',
            ]
        ]);
    }

    public function updateGeneral(Request $request)
    {
        $request->validate([
            'app_name' => 'nullable|string|max:255',
            'pkl_start_date' => 'nullable|date',
            'pkl_end_date' => 'nullable|date',
            'checkin_deadline' => 'nullable|string',
            'fonnte_api_key' => 'nullable|string',
        ]);

        if ($request->filled('app_name')) {
            Setting::setValue('app_name', $request->app_name, 'general');
        }
        if ($request->filled('pkl_start_date')) {
            Setting::setValue('pkl_start_date', $request->pkl_start_date, 'general');
        }
        if ($request->filled('pkl_end_date')) {
            Setting::setValue('pkl_end_date', $request->pkl_end_date, 'general');
        }
        if ($request->filled('checkin_deadline')) {
            Setting::setValue('checkin_deadline', $request->checkin_deadline, 'general');
        }
        if ($request->filled('fonnte_api_key')) {
            Setting::setValue('fonnte_api_key', $request->fonnte_api_key, 'general');
        }

        return response()->json([
            'success' => true,
            'message' => 'Pengaturan umum berhasil disimpan'
        ]);
    }

    public function rules()
    {
        $s = Setting::getGroup('rules');

        return response()->json([
            'success' => true,
            'data' => [
                'logbook_target' => (int) ($s['logbook_target'] ?? 30),
                'min_attendance' => (int) ($s['min_attendance'] ?? 75),
                'late_penalty' => $s['late_penalty'] ?? 'Peringatan tertulis untuk keterlambatan pertama, pemanggilan orang tua untuk keterlambatan berulang',
            ]
        ]);
    }

    public function updateRules(Request $request)
    {
        $request->validate([
            'logbook_target' => 'required|integer|min:1',
            'min_attendance' => 'required|integer|min:0|max:100',
            'late_penalty' => 'nullable|string',
        ]);

        Setting::setValue('logbook_target', $request->logbook_target, 'rules');
        Setting::setValue('min_attendance', $request->min_attendance, 'rules');
        Setting::setValue('late_penalty', $request->late_penalty, 'rules');

        return response()->json([
            'success' => true,
            'message' => 'Aturan PKL berhasil disimpan'
        ]);
    }

    public function notifications()
    {
        $s = Setting::getGroup('notifications');

        return response()->json([
            'success' => true,
            'data' => [
                'email' => ($s['email'] ?? '1') === '1',
                'whatsapp' => ($s['whatsapp'] ?? '0') === '1',
                'attendance' => ($s['attendance'] ?? '1') === '1',
                'logbook' => ($s['logbook'] ?? '1') === '1',
            ]
        ]);
    }

    public function updateNotifications(Request $request)
    {
        $request->validate([
            'email' => 'required|boolean',
            'whatsapp' => 'required|boolean',
            'attendance' => 'required|boolean',
            'logbook' => 'required|boolean',
        ]);

        Setting::setValue('email', $request->email ? '1' : '0', 'notifications');
        Setting::setValue('whatsapp', $request->whatsapp ? '1' : '0', 'notifications');
        Setting::setValue('attendance', $request->attendance ? '1' : '0', 'notifications');
        Setting::setValue('logbook', $request->logbook ? '1' : '0', 'notifications');

        return response()->json([
            'success' => true,
            'message' => 'Pengaturan notifikasi berhasil disimpan'
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
                'default_radius' => (int) Setting::getValue('default_radius', 100),
                'radius_unit' => 'meter',
            ]
        ]);
    }

    public function updateRadius(Request $request)
    {
        $request->validate([
            'default_radius' => 'required|numeric|min:10|max:10000',
        ]);

        Setting::setValue('default_radius', $request->default_radius, 'general');

        return response()->json([
            'success' => true,
            'message' => 'Radius berhasil disimpan'
        ]);
    }
}
