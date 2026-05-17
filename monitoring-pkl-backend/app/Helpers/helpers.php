<?php

use App\Helpers\HaversineHelper;

if (!function_exists('haversineDistance')) {
    function haversineDistance($lat1, $lon1, $lat2, $lon2): float
    {
        return HaversineHelper::calculateDistance($lat1, $lon1, $lat2, $lon2);
    }
}
