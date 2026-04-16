<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Company;
use Illuminate\Http\Request;

class CompanyController extends Controller
{
    public function index()
    {
        return response()->json(Company::all());
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'address' => 'required',
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
            'radius' => 'required|integer|min:10',
        ]);

        $company = Company::create($request->all());
        return response()->json($company);
    }

    public function update(Request $request, $id)
    {
        $company = Company::findOrFail($id);
        $company->update($request->all());
        return response()->json($company);
    }

    public function destroy($id)
    {
        Company::destroy($id);
        return response()->json(['message' => 'Company deleted']);
    }
}