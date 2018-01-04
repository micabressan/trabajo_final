<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redirect;
use Mockery\Exception;
use \Torann\GeoIP\Facades\GeoIP;
use App\HomelessReports;
use App\ReportLocations;
use App\Services;
use Carbon\Carbon;


class GeoLocationController extends Controller
{

    public function index()
    {
        $clientLocation = geoip(\request()->ip());

        return view('index', compact('clientLocation'));

    }

    public function map()
    {
        $clientLocation = geoip(request()->ip());

        return view('map-it-out', compact('clientLocation'));
    }

    public function homelessReport()
    {
        //ACID Compliance Transaction:if any part of the query fails, the database is rolled back to the previous state,
        //If the query is completed successfully, the database is updated.
        DB::transaction(function()
        {
            try{

                $report_id = HomelessReports::initialReport();

                ReportLocations::saveLocation($report_id);

                Services::saveServices($report_id);

            }catch(Exception $queryError){

                DB::rollback();

                return Redirect('error', compact($queryError));

            }
        });

        return redirect('/map-it-out');
    }

}