<?php

namespace App\Services;

use App\Models\Setting;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class WhatsAppService
{
    protected string $apiKey;
    protected string $baseUrl = 'https://api.fonnte.com';

    public function __construct()
    {
        $this->apiKey = config('services.fonnte.api_key', '');
        if (empty($this->apiKey)) {
            $this->apiKey = Setting::getValue('fonnte_api_key', '');
        }
    }

    public function isConfigured(): bool
    {
        return !empty($this->apiKey);
    }

    public function send(string $target, string $message): array
    {
        if (!$this->isConfigured()) {
            Log::warning('WhatsApp not configured: missing FONNTE_API_KEY');
            return ['status' => false, 'message' => 'API key not configured'];
        }

        try {
            $caPath = 'C:\Program Files\php\cacert.pem';
            $options = [];
            if (file_exists($caPath)) {
                $options['verify'] = $caPath;
            }

            $response = Http::withOptions($options)->withHeaders([
                'Authorization' => $this->apiKey,
            ])->post($this->baseUrl . '/send', [
                'target' => $target,
                'message' => $message,
                'countryCode' => '62',
            ]);

            $body = $response->json();

            if ($response->successful() && ($body['status'] ?? false)) {
                Log::info("WhatsApp sent to {$target}: {$message}");
                return ['status' => true, 'data' => $body];
            }

            Log::warning("WhatsApp failed to {$target}: " . json_encode($body));
            return ['status' => false, 'message' => $body['reason'] ?? 'Unknown error'];
        } catch (\Exception $e) {
            Log::error("WhatsApp exception to {$target}: " . $e->getMessage());
            return ['status' => false, 'message' => $e->getMessage()];
        }
    }
}
