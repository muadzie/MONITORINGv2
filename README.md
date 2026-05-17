<div align="center">

# MONITORINGv2

### Sistem Informasi Monitoring Praktik Kerja Lapangan
### SMKN 1 Subang

![Version](https://img.shields.io/badge/Version-2.0-6366F1?style=for-the-badge)
![Laravel](https://img.shields.io/badge/Laravel-11-FF2D20?style=for-the-badge&logo=laravel)
![Vue.js](https://img.shields.io/badge/Vue.js-3-4FC08D?style=for-the-badge&logo=vuedotjs)
![MySQL](https://img.shields.io/badge/MySQL-8-4479A1?style=for-the-badge&logo=mysql)
![Tailwind CSS](https://img.shields.io/badge/Tailwind-3-06B6D4?style=for-the-badge&logo=tailwindcss)

<br>

> Sistem digital terintegrasi untuk memonitoring kegiatan Praktik Kerja Lapangan (PKL)
> siswa SMKN 1 Subang secara real-time dengan fitur absensi GPS, jurnal harian,
> penilaian multidimensi, dan peta sebaran interaktif.

</div>

---

## Daftar Isi

- [Sekilas Tentang](#sekilas-tentang)
- [Fitur Unggulan](#fitur-unggulan)
- [Teknologi](#teknologi)
- [Tampilan Aplikasi](#tampilan-aplikasi)
- [Role Pengguna](#role-pengguna)
- [Struktur Database](#struktur-database)
- [Panduan Instalasi](#panduan-instalasi)
- [Endpoint API](#endpoint-api)
- [Lisensi](#lisensi)

---

## Sekilas Tentang

**MONITORINGv2** adalah sistem informasi berbasis web yang dirancang untuk mendigitalisasi seluruh proses monitoring Praktik Kerja Lapangan (PKL) di SMKN 1 Subang. Sistem ini menggantikan proses manual semi-digital dengan platform modern berbasis _Single Page Application_ (SPA) yang interaktif, responsif, dan real-time.

Aplikasi ini melayani empat peran pengguna: **Admin**, **Siswa**, **Guru**, dan **Perusahaan** (DUDI), masing-masing dengan portal dan hak akses yang berbeda.

---

## Fitur Unggulan

### Manajemen Pengguna
Registrasi multi-role dengan sistem _approval_, manajemen profil lengkap, dan autentikasi berbasis token (Laravel Sanctum).

### Absensi GPS (Geofencing)
Check-in/check-out menggunakan lokasi real-time dengan validasi radius geofencing menggunakan **rumus Haversine**. Dilengkapi foto dokumentasi dan riwayat absensi lengkap.

### Jurnal Harian (Logbook)
Catatan kegiatan harian siswa selama PKL dengan lampiran file (gambar, PDF). Dilengkapi review dan penilaian oleh Guru dan Perusahaan.

### Perizinan & Sakit
Pengajuan izin atau sakit dengan bukti lampiran, disertai sistem approval oleh Guru pembimbing.

### Penempatan Siswa
Penugasan siswa ke perusahaan dengan periode PKL tertentu dan penunjukan Guru pembimbing.

### Penilaian Multidimensi
Penilaian mencakup enam aspek: Absensi, Logbook, Laporan, Sikap, Kinerja, dan Kedisiplinan. Dilakukan oleh Guru dan Perusahaan.

### Peta Sebaran Interaktif
Visualisasi lokasi perusahaan dan sebaran siswa menggunakan **Leaflet.js** dengan tampilan marker interaktif.

### Laporan & Ekspor Excel
Ekspor laporan rekap absensi, logbook, ringkasan siswa, dan nilai akhir ke format Excel (.xlsx).

### Notifikasi In-App
Pemberitahuan real-time untuk approval registrasi, pengingat kegiatan, dan informasi penting lainnya.

### Laporan Akhir PKL
Upload dan review laporan akhir PKL dengan riwayat revisi.

---

## Teknologi

### Backend
| Teknologi | Kegunaan |
|-----------|----------|
| PHP 8.3 | Bahasa pemrograman |
| Laravel 11 | Framework PHP (MVC) |
| MySQL 8.x | Basis data relasional |
| Laravel Sanctum | Autentikasi API (token) |
| Maatwebsite/Laravel-Excel | Ekspor file Excel |

### Frontend
| Teknologi | Kegunaan |
|-----------|----------|
| Vue.js 3 (Composition API) | Framework frontend reaktif |
| Pinia | Manajemen state |
| Vue Router 4 | Routing SPA |
| Tailwind CSS 3 | Styling utility-first |
| Leaflet.js | Peta interaktif |
| ApexCharts / Chart.js / ECharts | Visualisasi grafik |
| Axios | HTTP Client |
| Vite | Build tool |

### Algoritma
**Haversine Formula** digunakan untuk menghitung jarak antara koordinat siswa dengan koordinat perusahaan guna validasi radius geofencing saat absensi.

---

## Tampilan Aplikasi

<div align="center">

### Beranda (Landing Page)
<img src="foto/beranda.png" alt="Beranda" width="800" style="border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">

### Peta Sebaran Interaktif
<img src="foto/peta_sebaran.png" alt="Peta Sebaran" width="800" style="border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">

### Absensi Radius (Geofencing)
<img src="foto/absensi_radius.png" alt="Absensi Radius" width="800" style="border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">

### Dashboard Admin
<img src="foto/dashboard_admin.png" alt="Dashboard Admin" width="800" style="border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">

</div>

---

## Role Pengguna

### Admin
- Dashboard statistik lengkap
- CRUD semua data (pengguna, perusahaan, kelas, penempatan)
- Monitoring absensi, logbook, dan progres siswa
- Peta sebaran interaktif
- Approval registrasi pengguna
- Konfigurasi sistem (pengaturan umum, profil sekolah, radius absensi)

### Siswa
- Dashboard personal dengan statistik
- Absensi GPS check-in/check-out
- Jurnal harian dengan lampiran file
- Pengajuan izin dan sakit
- Upload laporan PKL
- Informasi perusahaan dan guru pembimbing

### Guru
- Dashboard monitoring siswa bimbingan
- Review dan approval logbook
- Approval izin/sakit
- Penilaian multidimensi
- Review laporan akhir
- Ekspor laporan Excel

### Perusahaan (DUDI)
- Dashboard progres siswa
- Penilaian logbook
- Monitoring aktivitas siswa
- Ekspor laporan

---

## Struktur Database

Database `monitoring_pkl` terdiri dari tabel-tabel utama berikut:

| Tabel | Deskripsi |
|-------|-----------|
| `roles` | Role pengguna (Admin, Siswa, Guru, Perusahaan) |
| `users` | Seluruh pengguna dengan relasi polimorfik |
| `companies` | Data perusahaan mitra (DUDI) |
| `classes` | Data kelas, jurusan, dan wali kelas |
| `placements` | Penempatan siswa ke perusahaan |
| `attendances` | Data absensi (check-in/check-out) |
| `logbooks` | Jurnal harian siswa |
| `permissions` | Pengajuan izin dan sakit |
| `assessments` | Penilaian multidimensi |
| `reports` | Upload laporan PKL |
| `final_reports` | Laporan akhir PKL |
| `notifications` | Notifikasi in-app |

---

## Panduan Instalasi

### Prasyarat
- PHP >= 8.3
- Composer
- Node.js & npm
- MySQL 8.x

### Langkah Instalasi

**1. Clone repositori**
```bash
git clone <repository-url>
cd monitoring-pkl-backend
```

**2. Install dependensi backend**
```bash
composer install
```

**3. Konfigurasi environment**
```bash
cp .env.example .env
# Sesuaikan konfigurasi database di file .env
DB_DATABASE=monitoring_pkl
DB_USERNAME=root
DB_PASSWORD=
```

**4. Generate application key**
```bash
php artisan key:generate
```

**5. Buat database**
```bash
mysql -u root -e "CREATE DATABASE monitoring_pkl"
```

**6. Jalankan migrasi**
```bash
php artisan migrate
```

**7. (Opsional) Seed data awal**
```bash
php artisan db:seed
```

**8. Install dependensi frontend**
```bash
cd ../monitoring-pkl-frontend
npm install
```

**9. Jalankan aplikasi**

Terminal 1 (Backend):
```bash
cd monitoring-pkl-backend
php artisan serve
```

Terminal 2 (Frontend):
```bash
cd monitoring-pkl-frontend
npm run dev
```

**Akses:**
- Frontend: `http://localhost:5173`
- Backend API: `http://localhost:8000/api`

---

## Endpoint API

### Public
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| POST | `/api/login` | Login pengguna |
| POST | `/api/register/siswa` | Registrasi siswa |
| POST | `/api/register/guru` | Registrasi guru |
| POST | `/api/register/perusahaan` | Registrasi perusahaan |
| POST | `/api/logout` | Logout |
| GET | `/api/me` | Informasi pengguna saat ini |

### Admin (`/api/admin`)
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/dashboard/stats` | Statistik dashboard |
| CRUD | `/users` | Manajemen pengguna |
| CRUD | `/students` | Manajemen siswa |
| CRUD | `/teachers` | Manajemen guru |
| CRUD | `/companies` | Manajemen perusahaan |
| CRUD | `/classes` | Manajemen kelas |
| CRUD | `/placements` | Manajemen penempatan |
| GET | `/map` | Data peta sebaran |
| GET | `/registrations/pending` | Registrasi menunggu approval |
| POST | `/registrations/approve` | Approval registrasi |
| GET | `/reports/*` | Ekspor laporan (Excel/JSON) |

### Siswa (`/api/siswa`)
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/dashboard/stats` | Statistik personal |
| POST | `/attendance/check-in` | Check-in absensi |
| POST | `/attendance/check-out` | Check-out absensi |
| CRUD | `/logbooks` | Jurnal harian |
| CRUD | `/permissions` | Pengajuan izin/sakit |
| CRUD | `/final-reports` | Laporan akhir |
| GET | `/company` | Informasi perusahaan |

### Guru (`/api/guru`)
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/dashboard/stats` | Statistik dashboard |
| GET | `/logbooks/pending` | Logbook pending review |
| POST | `/logbooks/approve` | Approve logbook |
| GET | `/permissions/pending` | Izin pending approval |
| POST | `/permissions/approve` | Approve izin |
| CRUD | `/assessments` | Penilaian siswa |

### Perusahaan (`/api/perusahaan`)
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/dashboard/stats` | Statistik dashboard |
| GET | `/logbooks/pending` | Logbook pending penilaian |
| POST | `/assessments` | Penilaian logbook |
| GET | `/progress` | Progres siswa |

---

## Lisensi

Hak cipta © 2026 **SMKN 1 Subang**. Seluruh hak cipta dilindungi undang-undang.

Dikembangkan untuk keperluan monitoring Praktik Kerja Lapangan (PKL)
di lingkungan SMKN 1 Subang.

---

<div align="center">
  <b>SMKN 1 Subang</b> — Jl. Arief Rahman Hakim No. 35, Subang, Jawa Barat
</div>
