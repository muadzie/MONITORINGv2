<?php

use App\Helpers\HaversineHelper;
use App\Models\Notification;
use App\Models\Setting;
use App\Services\WhatsAppService;

if (!function_exists('normalizePhone')) {
    function normalizePhone(?string $phone): ?string
    {
        if (!$phone) return null;

        $phone = preg_replace('/[^0-9]/', '', $phone);
        if (!$phone) return null;

        if (str_starts_with($phone, '62')) return $phone;
        if (str_starts_with($phone, '0')) return '62' . substr($phone, 1);

        return '62' . $phone;
    }
}

if (!function_exists('haversineDistance')) {
    function haversineDistance($lat1, $lon1, $lat2, $lon2): float
    {
        return HaversineHelper::calculateDistance($lat1, $lon1, $lat2, $lon2);
    }
}

if (!function_exists('sendNotification')) {
    function sendNotification(int $userId, string $title, string $message, string $type = 'info', ?string $url = null): void
    {
        Notification::create([
            'user_id' => $userId,
            'title' => $title,
            'message' => $message,
            'type' => $type,
            'url' => $url,
            'is_read' => false,
        ]);

        try {
            $waEnabled = Setting::getValue('whatsapp', '0') === '1';
        } catch (\Exception $e) {
            $waEnabled = false;
        }

        if (!$waEnabled) return;

        try {
            $user = \App\Models\User::find($userId);
            if (!$user || !$user->phone) return;

            $waService = new WhatsAppService();
            if (!$waService->isConfigured()) return;

            $phone = preg_replace('/[^0-9]/', '', $user->phone);
            if (!str_starts_with($phone, '62')) {
                $phone = '62' . ltrim($phone, '0');
            }

            $waMessage = "*{$title}*\n\n{$message}";
            $waService->send($phone, $waMessage);
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error("Send WA failed for user {$userId}: " . $e->getMessage());
        }
    }
}
