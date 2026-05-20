<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Company;
use App\Models\CompanyHoliday;
use Illuminate\Http\Request;

class CompanyController extends Controller
{
    public function index()
    {
        $companies = Company::withCount('holidays')->get();
        return response()->json($companies);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'address' => 'required|string',
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
            'radius' => 'required|integer|min:10',
            'phone' => 'nullable|string',
            'email' => 'nullable|email',
            'description' => 'nullable|string',
        ]);

        $request->merge(['phone' => normalizePhone($request->phone)]);
        $company = Company::create($request->all());
        return response()->json($company, 201);
    }

    public function show($id)
    {
        $company = Company::with('holidays')->findOrFail($id);
        return response()->json($company);
    }

    public function update(Request $request, $id)
    {
        $company = Company::findOrFail($id);
        
        $request->validate([
            'name' => 'required|string|max:255',
            'address' => 'required|string',
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
            'radius' => 'required|integer|min:10',
            'phone' => 'nullable|string',
            'email' => 'nullable|email',
            'description' => 'nullable|string',
        ]);
        
        $request->merge(['phone' => normalizePhone($request->phone)]);
        $company->update($request->all());
        return response()->json($company);
    }

    public function destroy($id)
    {
        $company = Company::findOrFail($id);
        $company->delete();
        return response()->json(['message' => 'Company deleted']);
    }

    public function holidays($companyId)
    {
        $company = Company::findOrFail($companyId);
        $holidays = $company->holidays()->orderBy('date', 'desc')->get();
        return response()->json($holidays);
    }

    public function addHoliday(Request $request, $companyId)
    {
        $company = Company::findOrFail($companyId);

        $request->validate([
            'date' => 'required|date',
            'description' => 'nullable|string|max:255',
        ]);

        $exists = CompanyHoliday::where('company_id', $company->id)
            ->where('date', $request->date)
            ->exists();

        if ($exists) {
            return response()->json([
                'success' => false,
                'message' => 'Tanggal ini sudah terdaftar sebagai hari libur'
            ], 400);
        }

        $holiday = CompanyHoliday::create([
            'company_id' => $company->id,
            'date' => $request->date,
            'description' => $request->description,
        ]);

        return response()->json($holiday, 201);
    }

    public function removeHoliday($companyId, $holidayId)
    {
        $company = Company::findOrFail($companyId);
        $holiday = CompanyHoliday::where('company_id', $company->id)
            ->findOrFail($holidayId);
        $holiday->delete();

        return response()->json(['message' => 'Hari libur berhasil dihapus']);
    }
}