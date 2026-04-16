<?php

namespace App\Http\Controllers\Api\Siswa;

use App\Http\Controllers\Controller;
use App\Models\Attendance;
use Carbon\Carbon;
use Illuminate\Http\Request;

class AttendanceController extends Controller
{
    public function checkIn(Request $request)
    {
        $user = $request->user();
        $company = $user->company;

        if (!$company) {
            return response()->json(['message' => 'Perusahaan tidak ditemukan'], 400);
        }

        // Hitung jarak
        $distance = $this->calculateDistance(
            $company->latitude, $company->longitude,
            $request->latitude, $request->longitude
        );

        if ($distance > $company->radius) {
            return response()->json([
                'message' => "Anda berada di luar radius absensi. Jarak Anda {$distance}m, radius perusahaan {$company->radius}m"
            ], 400);
        }

        $today = Carbon::today();
        $attendance = Attendance::firstOrNew(['user_id' => $user->id, 'date' => $today]);

        if ($attendance->check_in) {
            return response()->json(['message' => 'Anda sudah check in hari ini'], 400);
        }

        $checkInTime = Carbon::now();
        $status = $checkInTime->format('H:i') > '08:00' ? 'late' : 'present';

        $attendance->fill([
            'company_id' => $company->id,
            'check_in' => $checkInTime,
            'check_in_lat' => $request->latitude,
            'check_in_lng' => $request->longitude,
            'status' => $status
        ]);
        $attendance->save();

        return response()->json(['message' => 'Check in berhasil', 'status' => $status]);
    }

    public function checkOut(Request $request)
    {
        $user = $request->user();
        $today = Carbon::today();
        $attendance = Attendance::where('user_id', $user->id)->where('date', $today)->first();

        if (!$attendance || !$attendance->check_in) {
            return response()->json(['message' => 'Belum check in'], 400);
        }

        if ($attendance->check_out) {
            return response()->json(['message' => 'Sudah check out'], 400);
        }

        $attendance->update([
            'check_out' => Carbon::now(),
            'check_out_lat' => $request->latitude,
            'check_out_lng' => $request->longitude,
        ]);

        return response()->json(['message' => 'Check out berhasil']);
    }

    public function today(Request $request)
    {
        $today = Carbon::today();
        $attendance = Attendance::where('user_id', $request->user()->id)->where('date', $today)->first();

        return response()->json([
            'has_checked_in' => $attendance && $attendance->check_in,
            'has_checked_out' => $attendance && $attendance->check_out,
            'attendance' => $attendance,
            'status' => $attendance ? $attendance->status : 'absent'
        ]);
    }

    public function history(Request $request)
    {
        $history = Attendance::where('user_id', $request->user()->id)
            ->orderBy('date', 'desc')
            ->get();
        return response()->json($history);
    }

    private function calculateDistance($lat1, $lon1, $lat2, $lon2)
    {
        $earthRadius = 6371000;
        $latDelta = deg2rad($lat2 - $lat1);
        $lonDelta = deg2rad($lon2 - $lon1);
        $a = sin($latDelta/2) * sin($latDelta/2) +
             cos(deg2rad($lat1)) * cos(deg2rad($lat2)) *
             sin($lonDelta/2) * sin($lonDelta/2);
        $c = 2 * atan2(sqrt($a), sqrt(1-$a));
        return $earthRadius * $c;
    }
}