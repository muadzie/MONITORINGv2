<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        // Nonaktifkan foreign key check sementara
        DB::statement('SET FOREIGN_KEY_CHECKS=0');

        // Kosongkan tabel dengan delete (bukan truncate)
        DB::table('permissions')->delete();
        DB::table('logbooks')->delete();
        DB::table('attendances')->delete();
        DB::table('users')->delete();
        DB::table('companies')->delete();
        DB::table('roles')->delete();

        // 1. Roles
        DB::table('roles')->insert([
            ['id' => 1, 'name' => 'Admin', 'created_at' => now(), 'updated_at' => now()],
            ['id' => 2, 'name' => 'Siswa', 'created_at' => now(), 'updated_at' => now()],
            ['id' => 3, 'name' => 'Guru', 'created_at' => now(), 'updated_at' => now()],
            ['id' => 4, 'name' => 'Perusahaan', 'created_at' => now(), 'updated_at' => now()],
        ]);

        // 2. Companies
        DB::table('companies')->insert([
            [
                'id' => 1,
                'name' => 'PT. Teknologi Nusantara',
                'address' => 'Jl. Merdeka No. 123, Subang',
                'latitude' => -6.5696,
                'longitude' => 107.7583,
                'radius' => 100,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'id' => 2,
                'name' => 'CV. Karya Mandiri',
                'address' => 'Jl. Diponegoro No. 45, Subang',
                'latitude' => -6.5650,
                'longitude' => 107.7620,
                'radius' => 150,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'id' => 3,
                'name' => 'PT. Subang Jaya Abadi',
                'address' => 'Jl. Otto Iskandardinata No. 78, Subang',
                'latitude' => -6.5720,
                'longitude' => 107.7550,
                'radius' => 200,
                'created_at' => now(),
                'updated_at' => now()
            ],
        ]);

        // 3. Users
        DB::table('users')->insert([
            [
                'id' => 1,
                'name' => 'Administrator',
                'email' => 'admin@smkn1subang.sch.id',
                'password' => Hash::make('password'),
                'role_id' => 1,
                'nisn' => null,
                'phone' => '081234567890',
                'company_id' => null,
                'teacher_id' => null,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'id' => 2,
                'name' => 'Budi Santoso, S.Kom',
                'email' => 'guru@smkn1subang.sch.id',
                'password' => Hash::make('password'),
                'role_id' => 3,
                'nisn' => null,
                'phone' => '081234567891',
                'company_id' => null,
                'teacher_id' => null,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'id' => 3,
                'name' => 'Perusahaan PT. Teknologi Nusantara',
                'email' => 'perusahaan1@example.com',
                'password' => Hash::make('password'),
                'role_id' => 4,
                'nisn' => null,
                'phone' => '081234567892',
                'company_id' => 1,
                'teacher_id' => null,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'id' => 4,
                'name' => 'Ahmad Fauzi',
                'email' => 'ahmadfauzi@student.com',
                'password' => Hash::make('password'),
                'role_id' => 2,
                'nisn' => '0012345678',
                'phone' => '081234567893',
                'company_id' => 1,
                'teacher_id' => 2,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'id' => 5,
                'name' => 'Siti Nurhaliza',
                'email' => 'sitinurhaliza@student.com',
                'password' => Hash::make('password'),
                'role_id' => 2,
                'nisn' => '0012345679',
                'phone' => '081234567894',
                'company_id' => 1,
                'teacher_id' => 2,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'id' => 6,
                'name' => 'Rizki Ramadhan',
                'email' => 'rizkiramadhan@student.com',
                'password' => Hash::make('password'),
                'role_id' => 2,
                'nisn' => '0012345680',
                'phone' => '081234567895',
                'company_id' => 2,
                'teacher_id' => 2,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'id' => 7,
                'name' => 'Dewi Anggraeni',
                'email' => 'dewianggraeni@student.com',
                'password' => Hash::make('password'),
                'role_id' => 2,
                'nisn' => '0012345681',
                'phone' => '081234567896',
                'company_id' => 2,
                'teacher_id' => 2,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'id' => 8,
                'name' => 'Muhammad Irfan',
                'email' => 'muhammadirfan@student.com',
                'password' => Hash::make('password'),
                'role_id' => 2,
                'nisn' => '0012345682',
                'phone' => '081234567897',
                'company_id' => 3,
                'teacher_id' => 2,
                'created_at' => now(),
                'updated_at' => now()
            ],
        ]);

        // Aktifkan kembali foreign key check
        DB::statement('SET FOREIGN_KEY_CHECKS=1');
    }
}