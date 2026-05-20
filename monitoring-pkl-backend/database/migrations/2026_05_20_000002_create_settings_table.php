<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('settings', function (Blueprint $table) {
            $table->id();
            $table->string('key')->unique();
            $table->text('value')->nullable();
            $table->string('group')->default('general');
            $table->timestamps();
        });

        // Seed default settings
        DB::table('settings')->insert([
            ['key' => 'app_name', 'value' => 'Monitoring PKL SMKN 1 Subang', 'group' => 'general'],
            ['key' => 'pkl_start_date', 'value' => '2026-01-01', 'group' => 'general'],
            ['key' => 'pkl_end_date', 'value' => '2026-03-31', 'group' => 'general'],
            ['key' => 'checkin_deadline', 'value' => '08:00', 'group' => 'general'],
            ['key' => 'logbook_target', 'value' => '30', 'group' => 'rules'],
            ['key' => 'min_attendance', 'value' => '75', 'group' => 'rules'],
            ['key' => 'late_penalty', 'value' => 'Peringatan tertulis untuk keterlambatan pertama, pemanggilan orang tua untuk keterlambatan berulang', 'group' => 'rules'],
            ['key' => 'email', 'value' => '1', 'group' => 'notifications'],
            ['key' => 'whatsapp', 'value' => '0', 'group' => 'notifications'],
            ['key' => 'attendance', 'value' => '1', 'group' => 'notifications'],
            ['key' => 'logbook', 'value' => '1', 'group' => 'notifications'],
        ]);
    }

    public function down(): void
    {
        Schema::dropIfExists('settings');
    }
};
