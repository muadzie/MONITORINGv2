<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Company;
use App\Models\Logbook;
use App\Models\Attendance;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function stats()
    {
        return response()->json([
            'total_students' => User::where('role_id', 2)->count(),
            'total_teachers' => User::where('role_id', 3)->count(),
            'total_companies' => Company::count(),
            'total_logbooks' => Logbook::count(),
            'present_today' => Attendance::whereDate('date', Carbon::today())->where('status', 'present')->count(),
            'late_today' => Attendance::whereDate('date', Carbon::today())->where('status', 'late')->count(),
            'absent_today' => Attendance::whereDate('date', Carbon::today())->where('status', 'absent')->count(),
        ]);
    }
}